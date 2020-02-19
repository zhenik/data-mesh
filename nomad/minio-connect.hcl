job "minio-connect" {
  type = "service"
  datacenters = [
    "dc1"]

  group "s3" {
    count = 1

    service {
      name = "minio"
      port = 9000

      connect {
        sidecar_service {}
      }
    }

    network {
      mode = "bridge"
    }

    task "server" {
      driver = "docker"

      config {
        image = "minio/minio:latest"
        args = [
        "server", "/local/data"
        ]
      }

      template {
        data = "placeholder"
        destination = "local/data/default/placeholder"
      }
      template {
        data = "placeholder"
        destination = "local/data/hive/warehouse/placeholder"
      }
      resources {
        cpu = 200
        memory = 1024
      }
    }
  }
}