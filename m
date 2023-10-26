Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27687D7DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344406AbjJZHfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjJZHfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:35:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4ABD6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:35:09 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50816562320so707470e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698305707; x=1698910507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hJZ6wfm0bTuqieUHXEKtRuJrDeks5L6l8rWKf4hHJEo=;
        b=TngL/zmJZaURwMCP5/htZ/7voWYDEOowQiXsB8tTuyJ3UI/XnY9l+Scx0H+Ysob/eN
         fHV5RM48QhHLB19dO6dBztAiBb6+0k36Qt8bVN4fs0zoDwTLsER8PBfn4GxhJiOigBpN
         EHa4Gq42phQscmDcZwgtF/0Z+dUnsRhsXS9UjmLQLt2pBDfttbc7w6mtCmoZNYTqkecV
         xesBWS9DWXrlIkb0pWCZukOKDTSWd5vi4Ey5ORDmiNBnc8VJECG0K49h+65jZsAH/LXK
         mejDYL3Y+n7kO9dZhEUEvXtaneyMUyZr6PzW0oYZDpYp/4aQm3TgFekYItXpsiHdEe9T
         m4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698305707; x=1698910507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJZ6wfm0bTuqieUHXEKtRuJrDeks5L6l8rWKf4hHJEo=;
        b=rr0TCZRwkeazKBZLIWHQsbyduqCZo91GIhqYk5O/zq83GbBTYJCiZAOGemybfl0Dpv
         HtvElYt/gw/8Qgna/NswwKJHlCvboKD3SULPfn5E/uINzdsOXelrbYv4FWu6jYPxsR11
         OW9LD+enZ7g8tKrvu3/jI550zfPucW6QOcbGPqYT4/P0l5DZEWaNKvBAp29EO2Ws7XwO
         4pQttUJKslp5dDgD2pDr3ysg3WInggacVhRX7G1M0IC28m/j7GDdz9NH+ZO3fmsyp7Is
         NXaWCBGNjzI8jzoqWbQ/1oAkW3TCR7kMaHe/U6LN4KXfkHJG6T1JMGLk85kGmlUFva3V
         hotw==
X-Gm-Message-State: AOJu0Yy4uPYkfhonHTwUlydGSu0dHJA7N9l4wfJ6ev75VVi0rwT/OBmy
        ZTK/Gbe2wvmNF8TN29NenJA=
X-Google-Smtp-Source: AGHT+IF1kDUFN0AdnY4R0HavPdl604V/76H23E4wqzAPj8PJLLQTSSq1movSs/LWlTbRJ2bShRj4gg==
X-Received: by 2002:a05:6512:3d29:b0:507:ba28:1bc5 with SMTP id d41-20020a0565123d2900b00507ba281bc5mr15172418lfv.3.1698305707045;
        Thu, 26 Oct 2023 00:35:07 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id x12-20020a056512078c00b00507a4661f76sm2895189lfr.145.2023.10.26.00.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 00:35:06 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH V2] nvmem: brcm_nvram: store a copy of NVRAM content
Date:   Thu, 26 Oct 2023 09:34:40 +0200
Message-Id: <20231026073440.6724-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
---
V2: Minialize amount of allocated memory (check for actual data length)

 drivers/nvmem/brcm_nvram.c | 131 ++++++++++++++++++++++++++-----------
 1 file changed, 91 insertions(+), 40 deletions(-)

diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 9737104f3b76..fbd133732bba 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -17,9 +17,20 @@
 
 #define NVRAM_MAGIC			"FLSH"
 
+/**
+ * struct brcm_nvram - driver state internal struct
+ *
+ * @nvmem_size:		Size of the whole space available for NVRAM
+ * @data:		NVRAM data copy stored to avoid poking underlaying flash controller
+ * @data_len:		NVRAM data size
+ * @padding_byte:	Padding value used to fill remaining space
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
@@ -36,10 +47,47 @@ static int brcm_nvram_read(void *context, unsigned int offset, void *val,
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
@@ -67,8 +115,13 @@ static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
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
@@ -78,67 +131,68 @@ static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
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
@@ -150,7 +204,6 @@ static int brcm_nvram_probe(struct platform_device *pdev)
 		.reg_read = brcm_nvram_read,
 	};
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct brcm_nvram *priv;
 	int err;
 
@@ -159,21 +212,19 @@ static int brcm_nvram_probe(struct platform_device *pdev)
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

