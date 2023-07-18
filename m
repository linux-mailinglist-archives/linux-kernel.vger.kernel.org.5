Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547407581B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjGRQHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjGRQHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:07:17 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F10A4;
        Tue, 18 Jul 2023 09:07:07 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fcd615d7d6so9007084e87.3;
        Tue, 18 Jul 2023 09:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689696425; x=1692288425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYO3tGH2MBohSxIGrRwDWvJzs2Un0ySfOiS4DZ0h6R8=;
        b=GT99Yn5XNGnVERhtU/ltZKp8nqyrPcRtnYkCGPugt5FhzQoaa/0GvD0HqIXaM6JOFF
         IgRU0uYYHMoYzyeaI89rmAciAXqlpRzEYVfQXhtqyDKvXFs1vhZUxT+7BHs1Paa1GSzJ
         zEOFtgxvUPTWPetEU8L11PxGwIlTniwuNrCHEdKGU2U4kfvWj5q8AIkqRaUu6mqVWrmS
         rwGZYRmyp7hdXKaoT6NrlyhZOWFOcUMaTYTpjYSW9BIx6izB6Bi/TSYAk92hdEB7kS8K
         DF4E8CKO23kQ3RBN9hVGRi8+/ZGM4D0kbgQCLGDOOuF8+fpoYG3bGn5NCjyG8oADPKAt
         rpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689696425; x=1692288425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYO3tGH2MBohSxIGrRwDWvJzs2Un0ySfOiS4DZ0h6R8=;
        b=N4d38F13ivB6w8Iv1f7x+RxI5CnkZkF41K4hUpM4qg7/oTDrYplL8QR/cFhl0bvCX6
         TxbN6y6faeIyKwmMY56uBRLp/tz00KdQ2qHtxxHbdji6sHM/6zWeiJU5PraH7iDeDuJ4
         6qYIwlFDQbRS8pnQC+0+6PmifQToLTJe7rhkjUGXHFFMCTbD1q3t0Z1XEusoy2Kf2iO+
         1H76h0NbXgUPaOIzrx45pK4IAIpuGjlymQdPO7VNs6iaW9sqBwYM7ivaC2piNT624kzO
         Efd44mwGtZY/kOeFuLpB37/WinIDCN4GShBGO02HCW5E2crJKBzX54fDwu8wXzMrkVbj
         jPsQ==
X-Gm-Message-State: ABy/qLb7XSpY5ZBZaz4Xc/E0w0pHIL3nltxqdFhZX9GPlPfLUQZ79i/9
        yVpjh1+qB0yAs5YvkAFEkHs=
X-Google-Smtp-Source: APBJJlGxOuFZuyQgOiPahWuMwqDffd4PQl0ksLJAlOHbs1Csjgy4iJRO8XlMcxTIbZgA5RYj3AfVdw==
X-Received: by 2002:a05:6512:473:b0:4fb:cb10:64d0 with SMTP id x19-20020a056512047300b004fbcb1064d0mr15639048lfd.29.1689696425315;
        Tue, 18 Jul 2023 09:07:05 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id t14-20020ac24c0e000000b004f86aef886asm502295lfq.54.2023.07.18.09.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 09:07:05 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH WIP 3/3] nvmem: u-boot-env: convert to NVMEM layout
Date:   Tue, 18 Jul 2023 18:06:52 +0200
Message-Id: <20230718160652.26756-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230718160652.26756-1-zajec5@gmail.com>
References: <20230718160652.26756-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This avoids code duplication (NVMEM device access) and allows reusing
this on top of other NVMEM devices.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/mtd/mtdcore.c                    |   7 ++
 drivers/nvmem/Kconfig                    |  15 ++-
 drivers/nvmem/Makefile                   |   2 -
 drivers/nvmem/layouts/Kconfig            |  10 ++
 drivers/nvmem/layouts/Makefile           |   1 +
 drivers/nvmem/{ => layouts}/u-boot-env.c | 112 +++++++++--------------
 6 files changed, 68 insertions(+), 79 deletions(-)
 rename drivers/nvmem/{ => layouts}/u-boot-env.c (67%)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 3d781ffb8c32..5f96affdfb0f 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -556,6 +556,13 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 	config.ignore_wp = true;
 	config.priv = mtd;
 
+	if (IS_ENABLED(NVMEM_U_BOOT_ENV) &&
+	    (of_device_is_compatible(node, "u-boot,env") ||
+	     of_device_is_compatible(node, "brcm,env"))) {
+		/* FIXME */
+		pr_warn("Missing support for deprecated U-Boot env binding\n");
+	}
+
 	mtd->nvmem = nvmem_register(&config);
 	if (IS_ERR(mtd->nvmem)) {
 		/* Just ignore if there is no NVMEM support in the kernel */
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index da9befa3d6c4..ff99c284a582 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -347,18 +347,15 @@ config NVMEM_SUNXI_SID
 	  will be called nvmem_sunxi_sid.
 
 config NVMEM_U_BOOT_ENV
-	tristate "U-Boot environment variables support"
+	bool "U-Boot environment variables support"
 	depends on OF && MTD
-	select CRC32
-	select GENERIC_NET_UTILS
+	select NVMEM_LAYOUT_U_BOOT_ENV
 	help
-	  U-Boot stores its setup as environment variables. This driver adds
-	  support for verifying & exporting such data. It also exposes variables
-	  as NVMEM cells so they can be referenced by other drivers.
-
-	  Currently this drivers works only with env variables on top of MTD.
+	  This option enables support for the old device tree binding describing
+	  U-Boot environment variables block on top of MTD partition.
 
-	  If compiled as module it will be called nvmem_u-boot-env.
+	  Those bindings have been deprecated in favor of using a proper NVMEM
+	  layout.
 
 config NVMEM_UNIPHIER_EFUSE
 	tristate "UniPhier SoCs eFuse support"
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index cc23ce4ffb1f..2558752fd9a3 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -69,8 +69,6 @@ obj-$(CONFIG_NVMEM_SUNPLUS_OCOTP)	+= nvmem_sunplus_ocotp.o
 nvmem_sunplus_ocotp-y			:= sunplus-ocotp.o
 obj-$(CONFIG_NVMEM_SUNXI_SID)		+= nvmem_sunxi_sid.o
 nvmem_sunxi_sid-y			:= sunxi_sid.o
-obj-$(CONFIG_NVMEM_U_BOOT_ENV)		+= nvmem_u-boot-env.o
-nvmem_u-boot-env-y			:= u-boot-env.o
 obj-$(CONFIG_NVMEM_UNIPHIER_EFUSE)	+= nvmem-uniphier-efuse.o
 nvmem-uniphier-efuse-y			:= uniphier-efuse.o
 obj-$(CONFIG_NVMEM_VF610_OCOTP)		+= nvmem-vf610-ocotp.o
diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
index 7ff1ee1c1f05..f33999be787e 100644
--- a/drivers/nvmem/layouts/Kconfig
+++ b/drivers/nvmem/layouts/Kconfig
@@ -20,4 +20,14 @@ config NVMEM_LAYOUT_ONIE_TLV
 
 	  If unsure, say N.
 
+config NVMEM_LAYOUT_U_BOOT_ENV
+	tristate "U-Boot environment variables layout support"
+	depends on OF
+	select CRC32
+	select GENERIC_NET_UTILS
+	help
+	  U-Boot stores its setup as environment variables. This driver adds
+	  support for verifying & exporting such data. It also exposes variables
+	  as NVMEM cells so they can be referenced by other drivers.
+
 endmenu
diff --git a/drivers/nvmem/layouts/Makefile b/drivers/nvmem/layouts/Makefile
index 2974bd7d33ed..4940c9db0665 100644
--- a/drivers/nvmem/layouts/Makefile
+++ b/drivers/nvmem/layouts/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_NVMEM_LAYOUT_SL28_VPD) += sl28vpd.o
 obj-$(CONFIG_NVMEM_LAYOUT_ONIE_TLV) += onie-tlv.o
+obj-$(CONFIG_NVMEM_LAYOUT_U_BOOT_ENV) += u-boot-env.o
diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/layouts/u-boot-env.c
similarity index 67%
rename from drivers/nvmem/u-boot-env.c
rename to drivers/nvmem/layouts/u-boot-env.c
index ee9fd9989b6e..32eae6df8d96 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/layouts/u-boot-env.c
@@ -8,11 +8,9 @@
 #include <linux/if_ether.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/mtd/mtd.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of_device.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 enum u_boot_env_format {
@@ -25,7 +23,7 @@ struct u_boot_env {
 	struct device *dev;
 	enum u_boot_env_format format;
 
-	struct mtd_info *mtd;
+	struct nvmem_device *nvmem;
 
 	/* Cells */
 	struct nvmem_cell_info *cells;
@@ -50,28 +48,6 @@ struct u_boot_env_image_broadcom {
 	uint8_t data[0];
 } __packed;
 
-static int u_boot_env_read(void *context, unsigned int offset, void *val,
-			   size_t bytes)
-{
-	struct u_boot_env *priv = context;
-	struct device *dev = priv->dev;
-	size_t bytes_read;
-	int err;
-
-	err = mtd_read(priv->mtd, offset, bytes, &bytes_read, val);
-	if (err && !mtd_is_bitflip(err)) {
-		dev_err(dev, "Failed to read from mtd: %d\n", err);
-		return err;
-	}
-
-	if (bytes_read != bytes) {
-		dev_err(dev, "Failed to read %zu bytes\n", bytes);
-		return -EIO;
-	}
-
-	return 0;
-}
-
 static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, int index,
 						unsigned int offset, void *buf, size_t bytes)
 {
@@ -95,17 +71,25 @@ static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
 				size_t data_offset, size_t data_len)
 {
 	struct device *dev = priv->dev;
+	struct device_node *layout_np;
 	char *data = buf + data_offset;
 	char *var, *value, *eq;
+	int err = 0;
 	int idx;
 
+	layout_np = of_nvmem_layout_get_container(priv->nvmem);
+	if (!layout_np)
+		return -ENOENT;
+
 	priv->ncells = 0;
 	for (var = data; var < data + data_len && *var; var += strlen(var) + 1)
 		priv->ncells++;
 
 	priv->cells = devm_kcalloc(dev, priv->ncells, sizeof(*priv->cells), GFP_KERNEL);
-	if (!priv->cells)
-		return -ENOMEM;
+	if (!priv->cells) {
+		err = -ENOMEM;
+		goto err_of_node_put;
+	}
 
 	for (var = data, idx = 0;
 	     var < data + data_len && *var;
@@ -117,11 +101,13 @@ static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
 		value = eq + 1;
 
 		priv->cells[idx].name = devm_kstrdup(dev, var, GFP_KERNEL);
-		if (!priv->cells[idx].name)
-			return -ENOMEM;
+		if (!priv->cells[idx].name) {
+			err = -ENOMEM;
+			goto err_of_node_put;
+		}
 		priv->cells[idx].offset = data_offset + value - data;
 		priv->cells[idx].bytes = strlen(value);
-		priv->cells[idx].np = of_get_child_by_name(dev->of_node, priv->cells[idx].name);
+		priv->cells[idx].np = of_get_child_by_name(layout_np, priv->cells[idx].name);
 		if (!strcmp(var, "ethaddr")) {
 			priv->cells[idx].raw_len = strlen(value);
 			priv->cells[idx].bytes = ETH_ALEN;
@@ -132,7 +118,10 @@ static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
 	if (WARN_ON(idx != priv->ncells))
 		priv->ncells = idx;
 
-	return 0;
+err_of_node_put:
+	of_node_put(layout_np);
+
+	return err;
 }
 
 static int u_boot_env_parse(struct u_boot_env *priv)
@@ -143,21 +132,25 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 	size_t crc32_offset;
 	size_t data_offset;
 	size_t data_len;
+	size_t env_size;
 	uint32_t crc32;
 	uint32_t calc;
-	size_t bytes;
+	ssize_t bytes;
 	uint8_t *buf;
 	int err;
 
-	buf = kcalloc(1, priv->mtd->size, GFP_KERNEL);
+	env_size = nvmem_device_size(priv->nvmem);
+
+	buf = kcalloc(1, env_size, GFP_KERNEL);
 	if (!buf) {
 		err = -ENOMEM;
 		goto err_out;
 	}
 
-	err = mtd_read(priv->mtd, 0, priv->mtd->size, &bytes, buf);
-	if ((err && !mtd_is_bitflip(err)) || bytes != priv->mtd->size) {
-		dev_err(dev, "Failed to read from mtd: %d\n", err);
+	bytes = nvmem_device_read(priv->nvmem, 0, env_size, buf);
+	if (bytes < 0 || bytes != env_size) {
+		dev_err(dev, "Failed to read from NVMEM device: %zd\n", bytes);
+		err = -EIO;
 		goto err_kfree;
 	}
 
@@ -179,8 +172,8 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		break;
 	}
 	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
-	crc32_data_len = priv->mtd->size - crc32_data_offset;
-	data_len = priv->mtd->size - data_offset;
+	crc32_data_len = env_size - crc32_data_offset;
+	data_len = env_size - data_offset;
 
 	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
 	if (calc != crc32) {
@@ -189,7 +182,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		goto err_kfree;
 	}
 
-	buf[priv->mtd->size - 1] = '\0';
+	buf[env_size - 1] = '\0';
 	err = u_boot_env_add_cells(priv, buf, data_offset, data_len);
 	if (err)
 		dev_err(dev, "Failed to add cells: %d\n", err);
@@ -200,14 +193,9 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 	return err;
 }
 
-static int u_boot_env_probe(struct platform_device *pdev)
+static int u_boot_env_layout_add_cells(struct device *dev, struct nvmem_device *nvmem,
+				       struct nvmem_layout *layout)
 {
-	struct nvmem_config config = {
-		.name = "u-boot-env",
-		.reg_read = u_boot_env_read,
-	};
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct u_boot_env *priv;
 	int err;
 
@@ -216,28 +204,18 @@ static int u_boot_env_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	priv->dev = dev;
 
-	priv->format = (uintptr_t)of_device_get_match_data(dev);
+	priv->format = (uintptr_t)nvmem_layout_get_match_data(nvmem, layout);
 
-	priv->mtd = of_get_mtd_device_by_node(np);
-	if (IS_ERR(priv->mtd)) {
-		dev_err_probe(dev, PTR_ERR(priv->mtd), "Failed to get %pOF MTD\n", np);
-		return PTR_ERR(priv->mtd);
-	}
+	priv->nvmem = nvmem;
 
 	err = u_boot_env_parse(priv);
 	if (err)
 		return err;
 
-	config.dev = dev;
-	config.cells = priv->cells;
-	config.ncells = priv->ncells;
-	config.priv = priv;
-	config.size = priv->mtd->size;
-
-	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
+	return 0;
 }
 
-static const struct of_device_id u_boot_env_of_match_table[] = {
+static const struct of_device_id u_boot_env_layout_of_match_table[] = {
 	{ .compatible = "u-boot,env", .data = (void *)U_BOOT_FORMAT_SINGLE, },
 	{ .compatible = "u-boot,env-redundant-bool", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
 	{ .compatible = "u-boot,env-redundant-count", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
@@ -245,15 +223,13 @@ static const struct of_device_id u_boot_env_of_match_table[] = {
 	{},
 };
 
-static struct platform_driver u_boot_env_driver = {
-	.probe = u_boot_env_probe,
-	.driver = {
-		.name = "u_boot_env",
-		.of_match_table = u_boot_env_of_match_table,
-	},
+static struct nvmem_layout u_boot_env_layout = {
+	.name = "u_boot_env",
+	.of_match_table = u_boot_env_layout_of_match_table,
+	.add_cells = u_boot_env_layout_add_cells,
 };
-module_platform_driver(u_boot_env_driver);
+module_nvmem_layout_driver(u_boot_env_layout);
 
 MODULE_AUTHOR("Rafał Miłecki");
 MODULE_LICENSE("GPL");
-MODULE_DEVICE_TABLE(of, u_boot_env_of_match_table);
+MODULE_DEVICE_TABLE(of, u_boot_env_layout_of_match_table);
-- 
2.35.3

