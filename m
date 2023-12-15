Return-Path: <linux-kernel+bounces-807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B319814685
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF82B1F248A7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D216288D5;
	Fri, 15 Dec 2023 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N7o/bpSi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F02250F3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c256ffdbcso6249315e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702638851; x=1703243651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYK5SSyCcJcTJmQw3Ft0qVwmUNHqhmVPpaMnVQcB3iM=;
        b=N7o/bpSifPr49EPj5YCwKE9wi3ZtHXk6CDUt4igrVWGhlCYnLW/LmDlfU9Wu8idx2C
         K1al+6XAJcIHvrStcjATrHgdUgeDYwScL1yHu9w+sxnip14HisslM7X0+K7uhueNkpDr
         AkYyXbXp90aoJHUjwPJDsApQHJep1alQaaJS4ciiVDQZpd51ijnLJ0N9lx4R0lXpMygP
         f3G+o59yzTvuauvR26bKp0z9VaPmSAElyEVUyUsyrrn3jGOzOuvyh/v+YEOxxDigevNc
         jvf3fRlysY7bAsfvRgahII3BuRQUeiv1tGh72468Fe3Lfvg19bW67X+2doBZ9fSwTTCI
         wRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638851; x=1703243651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYK5SSyCcJcTJmQw3Ft0qVwmUNHqhmVPpaMnVQcB3iM=;
        b=dA09cyOAaQbauyEWykLwfgY7bMqHl5PiD0joU/7WxyX+HrNssYIIa85GbdoSCMEEZT
         L96h1pPsvp9GU8p7Kp0/ACVZryEr8tnIPfwAECCBQLqaYR2szZQi5JZjzHe8llI94NId
         +BIIKZOdJN3OG205oaTFvSStnxtkKQo20V1xXz1ByFnppOHhcdQpMwOa/fYQpRgmjt7G
         rTUfLEZrSAk1PF736VZ781bfdg5/I/tHZyO+8L8EzOg6jej0I7wAl2KAj9BilTjneC8e
         8UnsR+j93GBTFDXQ+vPjg8QwTsgzexVjrM8lOe5Ovk5GvMJ6iijG4u6A4VpQNWayoyRt
         m0JA==
X-Gm-Message-State: AOJu0YzxL+Ovu5y5jJ814TUmuoWBeIkFkkXShA1PReMGW/ckSHQF3KDa
	fso1Tqkqbr3smwwYvgvWcLn3qg==
X-Google-Smtp-Source: AGHT+IGIYXkMH1KSqrZSZCj482ymSyGEGZ2ZPuDvXqWT88CPrLclGwRdWDPjsZMJSrugSSSmi+AbyQ==
X-Received: by 2002:a05:600c:2a41:b0:40c:32f1:816b with SMTP id x1-20020a05600c2a4100b0040c32f1816bmr5427489wme.162.1702638851407;
        Fri, 15 Dec 2023 03:14:11 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id s15-20020a5d69cf000000b0033641783aeesm6310757wrw.7.2023.12.15.03.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:14:10 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Stable@vger.kernel.org,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] nvmem: brcm_nvram: store a copy of NVRAM content
Date: Fri, 15 Dec 2023 11:13:58 +0000
Message-Id: <20231215111358.316727-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215111358.316727-1-srinivas.kandagatla@linaro.org>
References: <20231215111358.316727-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7598; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=MeuXfzd8v2OTApwmzDfMTPMeZrCjYF/6svBGCLK4fic=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlfDTrS8jaG1N3nUU25PVNLOXyNfS5W2m3VidcY AlTpcoXYOaJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZXw06wAKCRB6of1ZxzRV N/wACACaphehGw3NDzwOzazVFWMPC3DrlYZsw05AA1+Aj51ZteSUSzHBx4Mw4ccKd3bUWixGDZo m9zS2NyHS93KsFfaZ3Bp2JsvfVtgt0dFEh1Vs99RUBKyr4VzwbonrCZ8xmdMTVlwk3H9HN+yJIe H5gDOFoXrCrEKVWN/1Tr7/9Si9P1KxG8cIq60CnszcaxHJIjl6EjCefG9HdTtDfObjmxGWvUWq3 dHdASJaj+OfPlaJB+sUndzd0eKwP3UNN4AUzfVHnPX2/bzNqRxRbLw/ChhFUR6KGxvOovmrp7AA ToS9kM9qPzPW2rCrNQURHaWk0aZ32qZEFtWTRIN5yaBWte7v
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

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
Cc: <Stable@vger.kernel.org>
Cc: Arınç ÜNAL <arinc.unal@arinc9.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
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
2.25.1


