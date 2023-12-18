Return-Path: <linux-kernel+bounces-3756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2593F81709C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC881C23FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08073786A;
	Mon, 18 Dec 2023 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOA88rAz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C17C1D159;
	Mon, 18 Dec 2023 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a1ca24776c3so774878366b.0;
        Mon, 18 Dec 2023 05:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702906666; x=1703511466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NnQuhRM2aKmxMX4UvGIlLC0dqge59QIibPSitP1r8c=;
        b=KOA88rAz5IExgADkVtZ3ZqaO0vf+zleUGHuaBu5A8kGfyS90w8rFjs3HQwdtKWnJp8
         3LhEgYDmCu1GNIfPH1imqiEVj2in1YMpIe7GP0TglbPLdhJqHYOsnR2U4cs6bBHzvOLe
         TuY6wFTgJZ0mUA+H34uVYjrpG3L2pJ5Dqs676LOVpJQA/zp4TsOUwc8+kkhJ8qGEfIIE
         6DEhpJp2wzP9KMvxhRim9+xuCbNRmqYiozIQ9lm6aKvYNxyT+DRRvS6LV4/ET8pQdGnY
         BhpPfbNH0Ug2S3oztc+eZSAh8Yl3RX9oZFry+vcBIxjv2opwhPG9QaaQKTjkuB7XIGXc
         XmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702906666; x=1703511466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NnQuhRM2aKmxMX4UvGIlLC0dqge59QIibPSitP1r8c=;
        b=N+35BEl8aeZkuEeCWyuQjRAZKQLC34AE1myfDTJrdTWBckzZBag8Z/0QBBvLBwtDFO
         vz//ijZFFzDFjXbkmb3217Z/IB3DyNdWD7pkq5BYu4/aVwvem0KFFoEBCGIBQuJXjmIl
         +IoDpclu5OBlm2Ag1veo3HVYcoyt/Q6sX0vXpMxJ9977ABXAIqKO60hnVQGhMkxW4dB/
         FNam55M+oT7GKO0Z7Ffn9LGZW68P+wSoQ5bS46Pu5qAudQPaH6t3Eja2sDDKx9M4vRn3
         HybqD6pz+bVI7DFF8WPIRPn/41Y/aY9ZcOi56XBT5nt5ogNdWyACzjoZ6ibtmnNUH9OO
         uaAQ==
X-Gm-Message-State: AOJu0YwYmGT3fEoqa60NLeptzX3ihnWFd1dLAfocBcVb24Q927Yg+PX1
	K4xHWnDfWRYe9zUtyNg5YfE=
X-Google-Smtp-Source: AGHT+IHfTv+BKJWGNsKj+Odg60M5z2SLEb0xSXLQVDZohpDTBi8IGg8TUepkJ6sZFipc+PIZqYgp3w==
X-Received: by 2002:a17:906:5345:b0:a1c:b707:cbd1 with SMTP id j5-20020a170906534500b00a1cb707cbd1mr13446680ejo.24.1702906666210;
        Mon, 18 Dec 2023 05:37:46 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id f20-20020a1709067f9400b00a234907311asm1891537ejr.55.2023.12.18.05.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 05:37:45 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Walle <michael@walle.cc>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	u-boot@lists.denx.de,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 4/4] nvmem: layouts: add U-Boot env layout
Date: Mon, 18 Dec 2023 14:37:22 +0100
Message-Id: <20231218133722.16150-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231218133722.16150-1-zajec5@gmail.com>
References: <20231218133722.16150-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

This patch moves all generic (NVMEM devices independent) code from NVMEM
device driver to NVMEM layout driver. Then it adds a simple NVMEM layout
code on top of it.

Thanks to proper layout it's possible to support U-Boot env data stored
on any kind of NVMEM device.

For backward compatibility with old DT bindings we need to keep old
NVMEM device driver functional. To avoid code duplication a parsing
function is exported and reused in it.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 MAINTAINERS                        |   1 +
 drivers/nvmem/Kconfig              |   3 +-
 drivers/nvmem/layouts/Kconfig      |  11 ++
 drivers/nvmem/layouts/Makefile     |   1 +
 drivers/nvmem/layouts/u-boot-env.c | 212 +++++++++++++++++++++++++++++
 drivers/nvmem/layouts/u-boot-env.h |  15 ++
 drivers/nvmem/u-boot-env.c         | 155 +--------------------
 7 files changed, 243 insertions(+), 155 deletions(-)
 create mode 100644 drivers/nvmem/layouts/u-boot-env.c
 create mode 100644 drivers/nvmem/layouts/u-boot-env.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b589218605b4..1f7e6d74cd51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22282,6 +22282,7 @@ U-BOOT ENVIRONMENT VARIABLES
 M:	Rafał Miłecki <rafal@milecki.pl>
 S:	Maintained
 F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+F:	drivers/nvmem/layouts/u-boot-env.c
 F:	drivers/nvmem/u-boot-env.c
 
 UACCE ACCELERATOR FRAMEWORK
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 283134498fbc..d2c384f58028 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -363,8 +363,7 @@ config NVMEM_SUNXI_SID
 config NVMEM_U_BOOT_ENV
 	tristate "U-Boot environment variables support"
 	depends on OF && MTD
-	select CRC32
-	select GENERIC_NET_UTILS
+	select NVMEM_LAYOUT_U_BOOT_ENV
 	help
 	  U-Boot stores its setup as environment variables. This driver adds
 	  support for verifying & exporting such data. It also exposes variables
diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
index 9c6e672fc350..5e586dfebe47 100644
--- a/drivers/nvmem/layouts/Kconfig
+++ b/drivers/nvmem/layouts/Kconfig
@@ -26,6 +26,17 @@ config NVMEM_LAYOUT_ONIE_TLV
 
 	  If unsure, say N.
 
+config NVMEM_LAYOUT_U_BOOT_ENV
+	tristate "U-Boot environment variables layout"
+	select CRC32
+	select GENERIC_NET_UTILS
+	help
+	  U-Boot stores its setup as environment variables. This driver adds
+	  support for verifying & exporting such data. It also exposes variables
+	  as NVMEM cells so they can be referenced by other drivers.
+
+	  If unsure, say N.
+
 endmenu
 
 endif
diff --git a/drivers/nvmem/layouts/Makefile b/drivers/nvmem/layouts/Makefile
index 2974bd7d33ed..4940c9db0665 100644
--- a/drivers/nvmem/layouts/Makefile
+++ b/drivers/nvmem/layouts/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_NVMEM_LAYOUT_SL28_VPD) += sl28vpd.o
 obj-$(CONFIG_NVMEM_LAYOUT_ONIE_TLV) += onie-tlv.o
+obj-$(CONFIG_NVMEM_LAYOUT_U_BOOT_ENV) += u-boot-env.o
diff --git a/drivers/nvmem/layouts/u-boot-env.c b/drivers/nvmem/layouts/u-boot-env.c
new file mode 100644
index 000000000000..1787cfaf45f8
--- /dev/null
+++ b/drivers/nvmem/layouts/u-boot-env.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 - 2023 Rafał Miłecki <rafal@milecki.pl>
+ */
+
+#include <linux/crc32.h>
+#include <linux/etherdevice.h>
+#include <linux/export.h>
+#include <linux/if_ether.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+
+#include "u-boot-env.h"
+
+struct u_boot_env_image_single {
+	__le32 crc32;
+	uint8_t data[];
+} __packed;
+
+struct u_boot_env_image_redundant {
+	__le32 crc32;
+	u8 mark;
+	uint8_t data[];
+} __packed;
+
+struct u_boot_env_image_broadcom {
+	__le32 magic;
+	__le32 len;
+	__le32 crc32;
+	DECLARE_FLEX_ARRAY(uint8_t, data);
+} __packed;
+
+static const struct of_device_id u_boot_env_of_match_table[] = {
+	{ .compatible = "u-boot,env", .data = (void *)U_BOOT_FORMAT_SINGLE, },
+	{ .compatible = "u-boot,env-redundant-bool", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
+	{ .compatible = "u-boot,env-redundant-count", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
+	{ .compatible = "brcm,env", .data = (void *)U_BOOT_FORMAT_BROADCOM, },
+	{},
+};
+
+static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, int index,
+						unsigned int offset, void *buf, size_t bytes)
+{
+	u8 mac[ETH_ALEN];
+
+	if (bytes != 3 * ETH_ALEN - 1)
+		return -EINVAL;
+
+	if (!mac_pton(buf, mac))
+		return -EINVAL;
+
+	if (index)
+		eth_addr_add(mac, index);
+
+	ether_addr_copy(buf, mac);
+
+	return 0;
+}
+
+static int u_boot_env_parse_cells(struct device *dev, struct nvmem_device *nvmem, uint8_t *buf,
+				  size_t data_offset, size_t data_len)
+{
+	char *data = buf + data_offset;
+	char *var, *value, *eq;
+
+	for (var = data;
+	     var < data + data_len && *var;
+	     var = value + strlen(value) + 1) {
+		struct nvmem_cell_info info = {};
+
+		eq = strchr(var, '=');
+		if (!eq)
+			break;
+		*eq = '\0';
+		value = eq + 1;
+
+		info.name = devm_kstrdup(dev, var, GFP_KERNEL);
+		if (!info.name)
+			return -ENOMEM;
+		info.offset = data_offset + value - data;
+		info.bytes = strlen(value);
+		info.np = of_get_child_by_name(dev->of_node, info.name);
+		if (!strcmp(var, "ethaddr")) {
+			info.raw_len = strlen(value);
+			info.bytes = ETH_ALEN;
+			info.read_post_process = u_boot_env_read_post_process_ethaddr;
+		}
+
+		nvmem_add_one_cell(nvmem, &info);
+	}
+
+	return 0;
+}
+
+int u_boot_env_parse(struct device *dev, struct nvmem_device *nvmem,
+		     enum u_boot_env_format format)
+{
+	size_t crc32_data_offset;
+	size_t crc32_data_len;
+	size_t crc32_offset;
+	size_t data_offset;
+	size_t data_len;
+	size_t dev_size;
+	uint32_t crc32;
+	uint32_t calc;
+	uint8_t *buf;
+	int bytes;
+	int err;
+
+	dev_size = nvmem_dev_size(nvmem);
+
+	buf = kcalloc(1, dev_size, GFP_KERNEL);
+	if (!buf) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	bytes = nvmem_device_read(nvmem, 0, dev_size, buf);
+	if (bytes < 0)
+		return bytes;
+	else if (bytes != dev_size)
+		return -EIO;
+
+	switch (format) {
+	case U_BOOT_FORMAT_SINGLE:
+		crc32_offset = offsetof(struct u_boot_env_image_single, crc32);
+		crc32_data_offset = offsetof(struct u_boot_env_image_single, data);
+		data_offset = offsetof(struct u_boot_env_image_single, data);
+		break;
+	case U_BOOT_FORMAT_REDUNDANT:
+		crc32_offset = offsetof(struct u_boot_env_image_redundant, crc32);
+		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, data);
+		data_offset = offsetof(struct u_boot_env_image_redundant, data);
+		break;
+	case U_BOOT_FORMAT_BROADCOM:
+		crc32_offset = offsetof(struct u_boot_env_image_broadcom, crc32);
+		crc32_data_offset = offsetof(struct u_boot_env_image_broadcom, data);
+		data_offset = offsetof(struct u_boot_env_image_broadcom, data);
+		break;
+	}
+	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
+	crc32_data_len = dev_size - crc32_data_offset;
+	data_len = dev_size - data_offset;
+
+	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
+	if (calc != crc32) {
+		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n", calc, crc32);
+		err = -EINVAL;
+		goto err_kfree;
+	}
+
+	buf[dev_size - 1] = '\0';
+	err = u_boot_env_parse_cells(dev, nvmem, buf, data_offset, data_len);
+	if (err)
+		dev_err(dev, "Failed to add cells: %d\n", err);
+
+err_kfree:
+	kfree(buf);
+err_out:
+	return err;
+}
+EXPORT_SYMBOL_GPL(u_boot_env_parse);
+
+static int u_boot_env_add_cells(struct device *dev, struct nvmem_device *nvmem)
+{
+	const struct of_device_id *match;
+	struct device_node *layout_np;
+	enum u_boot_env_format format;
+
+	layout_np = of_nvmem_layout_get_container(nvmem);
+	if (!layout_np)
+		return -ENOENT;
+
+	match = of_match_node(u_boot_env_of_match_table, layout_np);
+	if (!match)
+		return -ENOENT;
+
+	format = (uintptr_t)match->data;
+
+	of_node_put(layout_np);
+
+	return u_boot_env_parse(dev, nvmem, format);
+}
+
+static int u_boot_env_probe(struct nvmem_layout *layout)
+{
+	layout->add_cells = u_boot_env_add_cells;
+
+	return nvmem_layout_register(layout);
+}
+
+static void u_boot_env_remove(struct nvmem_layout *layout)
+{
+	nvmem_layout_unregister(layout);
+}
+
+static struct nvmem_layout_driver u_boot_env_layout = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "u-boot-env-layout",
+		.of_match_table = u_boot_env_of_match_table,
+	},
+	.probe = u_boot_env_probe,
+	.remove = u_boot_env_remove,
+};
+module_nvmem_layout_driver(u_boot_env_layout);
+
+MODULE_AUTHOR("Rafał Miłecki");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, u_boot_env_of_match_table);
diff --git a/drivers/nvmem/layouts/u-boot-env.h b/drivers/nvmem/layouts/u-boot-env.h
new file mode 100644
index 000000000000..dd5f280ac047
--- /dev/null
+++ b/drivers/nvmem/layouts/u-boot-env.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _LINUX_NVMEM_LAYOUTS_U_BOOT_ENV_H
+#define _LINUX_NVMEM_LAYOUTS_U_BOOT_ENV_H
+
+enum u_boot_env_format {
+	U_BOOT_FORMAT_SINGLE,
+	U_BOOT_FORMAT_REDUNDANT,
+	U_BOOT_FORMAT_BROADCOM,
+};
+
+int u_boot_env_parse(struct device *dev, struct nvmem_device *nvmem,
+		     enum u_boot_env_format format);
+
+#endif  /* ifndef _LINUX_NVMEM_LAYOUTS_U_BOOT_ENV_H */
diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index ab8c9bf63d99..386b2b255c30 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -3,23 +3,15 @@
  * Copyright (C) 2022 Rafał Miłecki <rafal@milecki.pl>
  */
 
-#include <linux/crc32.h>
-#include <linux/etherdevice.h>
-#include <linux/if_ether.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
-#include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-enum u_boot_env_format {
-	U_BOOT_FORMAT_SINGLE,
-	U_BOOT_FORMAT_REDUNDANT,
-	U_BOOT_FORMAT_BROADCOM,
-};
+#include "layouts/u-boot-env.h"
 
 struct u_boot_env {
 	struct device *dev;
@@ -29,24 +21,6 @@ struct u_boot_env {
 	struct mtd_info *mtd;
 };
 
-struct u_boot_env_image_single {
-	__le32 crc32;
-	uint8_t data[];
-} __packed;
-
-struct u_boot_env_image_redundant {
-	__le32 crc32;
-	u8 mark;
-	uint8_t data[];
-} __packed;
-
-struct u_boot_env_image_broadcom {
-	__le32 magic;
-	__le32 len;
-	__le32 crc32;
-	DECLARE_FLEX_ARRAY(uint8_t, data);
-} __packed;
-
 static int u_boot_env_read(void *context, unsigned int offset, void *val,
 			   size_t bytes)
 {
@@ -69,131 +43,6 @@ static int u_boot_env_read(void *context, unsigned int offset, void *val,
 	return 0;
 }
 
-static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, int index,
-						unsigned int offset, void *buf, size_t bytes)
-{
-	u8 mac[ETH_ALEN];
-
-	if (bytes != 3 * ETH_ALEN - 1)
-		return -EINVAL;
-
-	if (!mac_pton(buf, mac))
-		return -EINVAL;
-
-	if (index)
-		eth_addr_add(mac, index);
-
-	ether_addr_copy(buf, mac);
-
-	return 0;
-}
-
-static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
-				size_t data_offset, size_t data_len)
-{
-	struct nvmem_device *nvmem = priv->nvmem;
-	struct device *dev = priv->dev;
-	char *data = buf + data_offset;
-	char *var, *value, *eq;
-
-	for (var = data;
-	     var < data + data_len && *var;
-	     var = value + strlen(value) + 1) {
-		struct nvmem_cell_info info = {};
-
-		eq = strchr(var, '=');
-		if (!eq)
-			break;
-		*eq = '\0';
-		value = eq + 1;
-
-		info.name = devm_kstrdup(dev, var, GFP_KERNEL);
-		if (!info.name)
-			return -ENOMEM;
-		info.offset = data_offset + value - data;
-		info.bytes = strlen(value);
-		info.np = of_get_child_by_name(dev->of_node, info.name);
-		if (!strcmp(var, "ethaddr")) {
-			info.raw_len = strlen(value);
-			info.bytes = ETH_ALEN;
-			info.read_post_process = u_boot_env_read_post_process_ethaddr;
-		}
-
-		nvmem_add_one_cell(nvmem, &info);
-	}
-
-	return 0;
-}
-
-static int u_boot_env_parse(struct u_boot_env *priv)
-{
-	struct nvmem_device *nvmem = priv->nvmem;
-	struct device *dev = priv->dev;
-	size_t crc32_data_offset;
-	size_t crc32_data_len;
-	size_t crc32_offset;
-	size_t data_offset;
-	size_t data_len;
-	size_t dev_size;
-	uint32_t crc32;
-	uint32_t calc;
-	uint8_t *buf;
-	int bytes;
-	int err;
-
-	dev_size = nvmem_dev_size(nvmem);
-
-	buf = kcalloc(1, dev_size, GFP_KERNEL);
-	if (!buf) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-
-	bytes = nvmem_device_read(nvmem, 0, dev_size, buf);
-	if (bytes < 0)
-		return bytes;
-	else if (bytes != dev_size)
-		return -EIO;
-
-	switch (priv->format) {
-	case U_BOOT_FORMAT_SINGLE:
-		crc32_offset = offsetof(struct u_boot_env_image_single, crc32);
-		crc32_data_offset = offsetof(struct u_boot_env_image_single, data);
-		data_offset = offsetof(struct u_boot_env_image_single, data);
-		break;
-	case U_BOOT_FORMAT_REDUNDANT:
-		crc32_offset = offsetof(struct u_boot_env_image_redundant, crc32);
-		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, data);
-		data_offset = offsetof(struct u_boot_env_image_redundant, data);
-		break;
-	case U_BOOT_FORMAT_BROADCOM:
-		crc32_offset = offsetof(struct u_boot_env_image_broadcom, crc32);
-		crc32_data_offset = offsetof(struct u_boot_env_image_broadcom, data);
-		data_offset = offsetof(struct u_boot_env_image_broadcom, data);
-		break;
-	}
-	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
-	crc32_data_len = dev_size - crc32_data_offset;
-	data_len = dev_size - data_offset;
-
-	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
-	if (calc != crc32) {
-		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n", calc, crc32);
-		err = -EINVAL;
-		goto err_kfree;
-	}
-
-	buf[dev_size - 1] = '\0';
-	err = u_boot_env_add_cells(priv, buf, data_offset, data_len);
-	if (err)
-		dev_err(dev, "Failed to add cells: %d\n", err);
-
-err_kfree:
-	kfree(buf);
-err_out:
-	return err;
-}
-
 static int u_boot_env_probe(struct platform_device *pdev)
 {
 	struct nvmem_config config = {
@@ -225,7 +74,7 @@ static int u_boot_env_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->nvmem))
 		return PTR_ERR(priv->nvmem);
 
-	return u_boot_env_parse(priv);
+	return u_boot_env_parse(dev, priv->nvmem, priv->format);
 }
 
 static const struct of_device_id u_boot_env_of_match_table[] = {
-- 
2.35.3


