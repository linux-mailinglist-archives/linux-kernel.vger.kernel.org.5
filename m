Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F04B79FC4F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbjINGtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjINGtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:49:41 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDB7CCD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:49:37 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso9089841fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694674176; x=1695278976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nLt56x/+byFP2a42jCI16rLI5Oh2/81pcuquOpoEQwU=;
        b=hfhGBqt9lDVZjZ7aiQRJJO7kkG8Xlip5rKZg1zMqq3cD1pICRoTlisBVsn7v4BYa0b
         lZgxxOrcmZmjggdryYpBh0ogHulzZ3NkkufkiXt1R5b5mxW10qYCDkiSNhbBeT/C+8Z9
         M30jjrem6oTiN/XOMnAlG24UBVYz6guWlrZOgrhTLupkT5KethtvR6RBdKmdZQKFcqp+
         Mb4PwuLN2xF5K34uQO4Aa4m1j0lzoSTObLhzghSZS2lebSxXwWbAf4JDA4oegfDxOa3f
         P0vGtU4FyBgsoTauFjNPos9lYpnB4xEdfye1aKnTG6KGw6Kap/YTXrg5/B8vA6iZnBvG
         4ATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694674176; x=1695278976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLt56x/+byFP2a42jCI16rLI5Oh2/81pcuquOpoEQwU=;
        b=DxKd/Ssgr6CoDaXYwhDbUFDtniZ+n5WfmvW4W+gFSfWcU+JvCwzpKEUYZbe1b5MwMc
         9qguzgfutc3tmOxkbn4ocSC4F3lNozzKo80RdkkLqiKcSylvEZrtHnB/nT0VSEQ1xGGr
         ErGmcq1KQceRmVEyluw+Zwz1c6U/x2p7RbHlJbi16jhOxJ04B33tuMwuWUyX+rxl+eHI
         vE5laAxqVpC2jY5B95Vp6bf5dq5daT3X6KqKIjwYLPG32NaHGSixkrcbUuKcVhAoEpON
         drpx+z41eh05MXQPkdXWU4anesdqtplsE7vY+Di5Yosp6FjFXvkkDxCmoVmVjudl/U/P
         SxCw==
X-Gm-Message-State: AOJu0YwU781JzcxMaEtTI7abkz7UIGzNyNWqW7PdEdzS0yyHhL9XfsLH
        xtq5ObMaJClQMEzDMudmi1s=
X-Google-Smtp-Source: AGHT+IGmZW4nrpil9KXEo+bbhmVfahNQoU3dZnFCrmBmZD4hG2m18HihW7kyboCIQAU1X8pIArdHsA==
X-Received: by 2002:a2e:8850:0:b0:2bb:c22a:f28c with SMTP id z16-20020a2e8850000000b002bbc22af28cmr4775114ljj.32.1694674175493;
        Wed, 13 Sep 2023 23:49:35 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id l4-20020a2e7004000000b002b9f0b25ff6sm159739ljc.4.2023.09.13.23.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 23:49:35 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] nvmem: brcm_nvram: store a copy of NVRAM content
Date:   Thu, 14 Sep 2023 08:49:22 +0200
Message-Id: <20230914064922.3986-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Modify driver to read & cache all NVRAM content during init and use that
copy to provide NVMEM data when requested.

Link: https://lore.kernel.org/linux-mtd/CACna6rwf3_9QVjYcM+847biTX=K0EoWXuXcSMkJO1Vy_5vmVqA@mail.gmail.com/
Cc: Arınç ÜNAL <arinc.unal@arinc9.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/brcm_nvram.c | 77 +++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 34 deletions(-)

diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 9737104f3b76..cfc1c485e20a 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -19,7 +19,8 @@
 
 struct brcm_nvram {
 	struct device *dev;
-	void __iomem *base;
+	uint8_t *data;
+	size_t size;
 	struct nvmem_cell_info *cells;
 	int ncells;
 };
@@ -36,10 +37,8 @@ static int brcm_nvram_read(void *context, unsigned int offset, void *val,
 			   size_t bytes)
 {
 	struct brcm_nvram *priv = context;
-	u8 *dst = val;
 
-	while (bytes--)
-		*dst++ = readb(priv->base + offset++);
+	memcpy(val, priv->data + offset, bytes);
 
 	return 0;
 }
@@ -68,7 +67,12 @@ static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
 {
 	struct device *dev = priv->dev;
 	char *var, *value, *eq;
+	uint8_t tmp;
 	int idx;
+	int err = 0;
+
+	tmp = priv->data[len - 1];
+	priv->data[len - 1] = '\0';
 
 	priv->ncells = 0;
 	for (var = data + sizeof(struct brcm_nvram_header);
@@ -78,8 +82,10 @@ static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
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
@@ -91,8 +97,10 @@ static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
 		value = eq + 1;
 
 		priv->cells[idx].name = devm_kstrdup(dev, var, GFP_KERNEL);
-		if (!priv->cells[idx].name)
-			return -ENOMEM;
+		if (!priv->cells[idx].name) {
+			err = -ENOMEM;
+			goto out;
+		}
 		priv->cells[idx].offset = value - (char *)data;
 		priv->cells[idx].bytes = strlen(value);
 		priv->cells[idx].np = of_get_child_by_name(dev->of_node, priv->cells[idx].name);
@@ -105,40 +113,32 @@ static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
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
+	if (len > priv->size) {
+		dev_err(dev, "NVRAM length (%zd) exceeds mapped size (%zd)\n", len, priv->size);
+		return -EINVAL;
 	}
 
-	kfree(data);
+	err = brcm_nvram_add_cells(priv, priv->data, len);
+	if (err)
+		dev_err(dev, "Failed to add cells: %d\n", err);
 
 	return 0;
 }
@@ -150,8 +150,9 @@ static int brcm_nvram_probe(struct platform_device *pdev)
 		.reg_read = brcm_nvram_read,
 	};
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct brcm_nvram *priv;
+	struct resource *res;
+	void __iomem *base;
 	int err;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -159,21 +160,29 @@ static int brcm_nvram_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	priv->dev = dev;
 
-	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->size = resource_size(res);
+
+	priv->data = devm_kzalloc(dev, priv->size, GFP_KERNEL);
+	if (!priv->data)
+		return -ENOMEM;
+
+	memcpy_fromio(priv->data, base, priv->size);
 
 	err = brcm_nvram_parse(priv);
 	if (err)
 		return err;
 
-	bcm47xx_nvram_init_from_iomem(priv->base, resource_size(res));
+	bcm47xx_nvram_init_from_iomem(base, priv->size);
 
 	config.dev = dev;
 	config.cells = priv->cells;
 	config.ncells = priv->ncells;
 	config.priv = priv;
-	config.size = resource_size(res);
+	config.size = priv->size;
 
 	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
 }
-- 
2.35.3

