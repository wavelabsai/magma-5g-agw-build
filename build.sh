#!/bin/bash

set -ex

# Install prerequisites
pip3 install ansible fabric3 jsonpickle requests PyYAML
vagrant plugin install vagrant-vbguest

# Cloning magma repo:
git clone https://github.com/magma/magma.git --depth 1

# start building magma
cd magma/lte/gateway
sed -i '' 's/1.1.20210928/1.1.20210618/' Vagrantfile
fab release package:vcs=git

# copy magma packages to github runner
vagrant ssh -c "cp -r magma-packages /vagrant"
