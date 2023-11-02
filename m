Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBB87DECD9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 07:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjKBG3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 02:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKBG3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 02:29:14 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6C5111
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 23:29:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9d8d3b65a67so76556166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 23:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698906547; x=1699511347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8s8BEGi6JAh5hgt7PGWzCQ28+yKcSbRdmy2GqyGeI14=;
        b=ZWoUIB/TjEhOC9rjB4i8sNxrVmy//LknPJV0lkVbq+L622LBCynpnESUdFmSBMDTbA
         5FoxpTDUNbK0fANkqAVbB0HxjDArGoGAx0w4fHI/W7t/HAteUZAO1C2Xxek42j59P8Oo
         nOwsc0gTVwZhE/OZQhLOiM9qDYpMyIb0kPhD8QV6o0tY+yucrFWNwvekLcaZpRcaNbNm
         1bjFyb+4z11YUM1vwwZA7viafiJqG2/Mwmd4FiiqsMmS6X4lN7A8QU0NYM1t2CKUzygb
         7PRmWhEtMXc8vypCuaeHM0ynhOPOqm9eMv6L/Jy6smTu5NP1eq84InnhafB7GYeYaIzH
         s3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698906547; x=1699511347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8s8BEGi6JAh5hgt7PGWzCQ28+yKcSbRdmy2GqyGeI14=;
        b=RHNr4eimJizGfNSFvgtRPk3q7lNfF5SbA903byCylw8w38Ws8aV/iOyVCoPv5d0EJe
         /Q5n86iSBRVKSlE9MzrIP5vFOPYqmAnBv65zg3YoeyK3/MksxMYbYlM479OEJg3f/TZ/
         3FmgaCHx/wKT+htDAFTSwIU8Dhh3a8J1Ew+wGlgrr4TVvwHXP/NnJKyD/DVa1NRj3dGs
         VNjfXRayde1E1tITbelj8NH21VAgqq2b9H9kyuaqKLPLQ/ZlBn3MQn4sjZm0/w12TXsf
         aH6DuIbRRaNElIG57SwkwwojtbmF8ipx3w7Qynat+OpkXoQ6hzMdHFHvib0skQNI/nO+
         f4gQ==
X-Gm-Message-State: AOJu0Yz1IzINfaUVfmvxNyj/mk6X4o538faGM5ZD/QG3EN4zJwNEBvHX
        HJ84VIQqGndR/Emy9RSib6U=
X-Google-Smtp-Source: AGHT+IFa5SrLVRvUzLdXqe8EHW/90mWfTg3hvSjll7Qc1cTgTtB8bHRCFGquuPYi9FLp9URWHBFxNQ==
X-Received: by 2002:a17:906:d54c:b0:9b2:d78c:afe9 with SMTP id cr12-20020a170906d54c00b009b2d78cafe9mr3858309ejc.49.1698906546603;
        Wed, 01 Nov 2023 23:29:06 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id ov2-20020a170906fc0200b00992b2c55c67sm733787ejb.156.2023.11.01.23.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 23:29:05 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH V3] nvmem: brcm_nvram: store a copy of NVRAM content
Date:   Thu,  2 Nov 2023 07:28:48 +0100
Message-Id: <20231102062848.23965-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
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

This driver uses MMIO access for reading NVRAM from a flash device.
Underneath there is a flash controller that reads data and provides
mapping window.

Using MMIO interface affects controller configuration and may break real
controller driver. It was reported by multiple users of devices with
NVRAM stored on NAND.

Modify driver to read & cache NVRAM content during init and use that
copy to provide NVMEM data when requested. On NAND flashes due to their
alignment NVRAM partitions can be quite big (1 MiB and more) while
actual NVRAM content stays quite small (usually 16 to 32 KiB). To avoid
allocating so much memory check for actual data length.

Link: https://lore.kernel.org/linux-mtd/CACna6rwf3_9QVjYcM+847biTX=K0EoWXuXcSMkJO1Vy_5vmVqA@mail.gmail.com/
Fixes: 3fef9ed0627a ("nvmem: brcm_nvram: new driver exposing Broadcom's NVRAM")
Cc: Arınç ÜNAL <arinc.unal@arinc9.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
V2: Minialize amount of allocated memory (check for actual data length)
V3: Document missed fields in struct brcm_nvram

 drivers/nvmem/brcm_nvram.c | 134 ++++++++++++++++++++++++++-----------
 1 file changed, 94 insertions(+), 40 deletions(-)

diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 9737104f3b76..5cdf339cfbec 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -17,9 +17,23 @@
 
 #define NVRAM_MAGIC			"FLSH"
 
+/**
+ * struct brcm_nvram - driver state internal struct
+ *
+ * @dev:		NVMEM device pointer
+ * @nvmem_size:		Size of the whole space available for NVRAM
+ * @data:		NVRAM data copy stored to avoid poking underlaying flash controller
+ * @data_len:		NVRAM data size
+ * @padding_byte:	Padding value used to fill remaining space
+ * @cells:		Array of discovered NVMEM cells
+ * @ncells:		Number of elements in cells
+ */
 struct brcm_nvram {
 	struct device *dev;
-	void __iomem *base;
+	size_t nvmem_size;
+	uint8_t *data;
+	size_t data_len;
+	uint8_t padding_byte;
 	struct nvmem_cell_info *cells;
 	int ncells;
 };
@@ -36,10 +50,47 @@ static int brcm_nvram_read(void *context, unsigned int offset, void *val,
 			   size_t bytes)
 {
 	struct brcm_nvram *priv = context;
-	u8 *dst = val;
+	size_t to_copy;
+
+	if (offset + bytes > priv->data_len)
+		to_copy = max_t(ssize_t, (ssize_t)priv->data_len - offset, 0);
+	else
+		to_copy = bytes;
+
+	memcpy(val, priv->data + offset, to_copy);
+
+	memset((uint8_t *)val + to_copy, priv->padding_byte, bytes - to_copy);
+
+	return 0;
+}
+
+static int brcm_nvram_copy_data(struct brcm_nvram *priv, struct platform_device *pdev)
+{
+	struct resource *res;
+	void __iomem *base;
+
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->nvmem_size = resource_size(res);
+
+	priv->padding_byte = readb(base + priv->nvmem_size - 1);
+	for (priv->data_len = priv->nvmem_size;
+	     priv->data_len;
+	     priv->data_len--) {
+		if (readb(base + priv->data_len - 1) != priv->padding_byte)
+			break;
+	}
+	WARN(priv->data_len > SZ_128K, "Unexpected (big) NVRAM size: %zu B\n", priv->data_len);
+
+	priv->data = devm_kzalloc(priv->dev, priv->data_len, GFP_KERNEL);
+	if (!priv->data)
+		return -ENOMEM;
+
+	memcpy_fromio(priv->data, base, priv->data_len);
 
-	while (bytes--)
-		*dst++ = readb(priv->base + offset++);
+	bcm47xx_nvram_init_from_iomem(base, priv->data_len);
 
 	return 0;
 }
@@ -67,8 +118,13 @@ static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
 				size_t len)
 {
 	struct device *dev = priv->dev;
-	char *var, *value, *eq;
+	char *var, *value;
+	uint8_t tmp;
 	int idx;
+	int err = 0;
+
+	tmp = priv->data[len - 1];
+	priv->data[len - 1] = '\0';
 
 	priv->ncells = 0;
 	for (var = data + sizeof(struct brcm_nvram_header);
@@ -78,67 +134,68 @@ static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
 	}
 
 	priv->cells = devm_kcalloc(dev, priv->ncells, sizeof(*priv->cells), GFP_KERNEL);
-	if (!priv->cells)
-		return -ENOMEM;
+	if (!priv->cells) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	for (var = data + sizeof(struct brcm_nvram_header), idx = 0;
 	     var < (char *)data + len && *var;
 	     var = value + strlen(value) + 1, idx++) {
+		char *eq, *name;
+
 		eq = strchr(var, '=');
 		if (!eq)
 			break;
 		*eq = '\0';
+		name = devm_kstrdup(dev, var, GFP_KERNEL);
+		*eq = '=';
+		if (!name) {
+			err = -ENOMEM;
+			goto out;
+		}
 		value = eq + 1;
 
-		priv->cells[idx].name = devm_kstrdup(dev, var, GFP_KERNEL);
-		if (!priv->cells[idx].name)
-			return -ENOMEM;
+		priv->cells[idx].name = name;
 		priv->cells[idx].offset = value - (char *)data;
 		priv->cells[idx].bytes = strlen(value);
 		priv->cells[idx].np = of_get_child_by_name(dev->of_node, priv->cells[idx].name);
-		if (!strcmp(var, "et0macaddr") ||
-		    !strcmp(var, "et1macaddr") ||
-		    !strcmp(var, "et2macaddr")) {
+		if (!strcmp(name, "et0macaddr") ||
+		    !strcmp(name, "et1macaddr") ||
+		    !strcmp(name, "et2macaddr")) {
 			priv->cells[idx].raw_len = strlen(value);
 			priv->cells[idx].bytes = ETH_ALEN;
 			priv->cells[idx].read_post_process = brcm_nvram_read_post_process_macaddr;
 		}
 	}
 
-	return 0;
+out:
+	priv->data[len - 1] = tmp;
+	return err;
 }
 
 static int brcm_nvram_parse(struct brcm_nvram *priv)
 {
+	struct brcm_nvram_header *header = (struct brcm_nvram_header *)priv->data;
 	struct device *dev = priv->dev;
-	struct brcm_nvram_header header;
-	uint8_t *data;
 	size_t len;
 	int err;
 
-	memcpy_fromio(&header, priv->base, sizeof(header));
-
-	if (memcmp(header.magic, NVRAM_MAGIC, 4)) {
+	if (memcmp(header->magic, NVRAM_MAGIC, 4)) {
 		dev_err(dev, "Invalid NVRAM magic\n");
 		return -EINVAL;
 	}
 
-	len = le32_to_cpu(header.len);
-
-	data = kzalloc(len, GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	memcpy_fromio(data, priv->base, len);
-	data[len - 1] = '\0';
-
-	err = brcm_nvram_add_cells(priv, data, len);
-	if (err) {
-		dev_err(dev, "Failed to add cells: %d\n", err);
-		return err;
+	len = le32_to_cpu(header->len);
+	if (len > priv->nvmem_size) {
+		dev_err(dev, "NVRAM length (%zd) exceeds mapped size (%zd)\n", len,
+			priv->nvmem_size);
+		return -EINVAL;
 	}
 
-	kfree(data);
+	err = brcm_nvram_add_cells(priv, priv->data, len);
+	if (err)
+		dev_err(dev, "Failed to add cells: %d\n", err);
 
 	return 0;
 }
@@ -150,7 +207,6 @@ static int brcm_nvram_probe(struct platform_device *pdev)
 		.reg_read = brcm_nvram_read,
 	};
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct brcm_nvram *priv;
 	int err;
 
@@ -159,21 +215,19 @@ static int brcm_nvram_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	priv->dev = dev;
 
-	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	err = brcm_nvram_copy_data(priv, pdev);
+	if (err)
+		return err;
 
 	err = brcm_nvram_parse(priv);
 	if (err)
 		return err;
 
-	bcm47xx_nvram_init_from_iomem(priv->base, resource_size(res));
-
 	config.dev = dev;
 	config.cells = priv->cells;
 	config.ncells = priv->ncells;
 	config.priv = priv;
-	config.size = resource_size(res);
+	config.size = priv->nvmem_size;
 
 	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
 }
-- 
2.35.3

