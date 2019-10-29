TAG?=latest
VERSION?=$(shell grep 'VERSION' cmd/kxds/version.go | awk '{ print $$4 }' | tr -d '"' | head -n1)
NAME:=kxds
DOCKER_REPOSITORY:=stefanprodan
DOCKER_IMAGE_NAME:=$(DOCKER_REPOSITORY)/$(NAME)

run:
	go run cmd/kxds/*.go serve --kubeconfig=$$HOME/.kube/config

envoy:
	envoy -c envoy.yaml -l info

build-container:
	docker build -t $(DOCKER_IMAGE_NAME):$(VERSION) .

push-container: build-container
	docker push $(DOCKER_IMAGE_NAME):$(VERSION)