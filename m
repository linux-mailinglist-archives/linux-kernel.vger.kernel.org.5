Return-Path: <linux-kernel+bounces-3768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8CF8170BE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820DB28348D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E05F14F63;
	Mon, 18 Dec 2023 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZE0DgLcH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE2E129EE3;
	Mon, 18 Dec 2023 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3363aa2bbfbso2966920f8f.0;
        Mon, 18 Dec 2023 05:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702907116; x=1703511916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWStvqK6KrlPpDCxoD+LXp2BPwdp0DZEpw1OHP4LGGI=;
        b=ZE0DgLcHy+3q3DeFQSSiGOXe1ZE7U7esYEJDZ+C1klkO18WybgxPiTh3rHCDQ7bjdA
         kf0J5cg84eKx9jhnZUqjQfCLta6ZIPNKJ7snJQoRkIGfJGtJZI2aKc1FvQ24bkqOLh3T
         PBM8JF1evgeJF1c896P/QaycdhI7/XbDnYghwRZ0K9S6EuwYDT8nZhRL1K8j//RSJ6CQ
         B3IZR5pZVPcofKl/dSHZDPNM/Q8T8NTyq4MSuVWXjVMiT6zRZLjt3pEeXmGOBA9TMm9r
         XvO6zsiddTZt76VGx+H6wGd58h+iDlo0GnBGobkiGVOme6Xcb7kcVwgWcGeSF3qsFSml
         7sFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702907116; x=1703511916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWStvqK6KrlPpDCxoD+LXp2BPwdp0DZEpw1OHP4LGGI=;
        b=X+nvxf+vxmwXxcHczdP7PCv3QN4QtdKOVZ22JeGRwMW0aPTALM8v+//UiZ4QG0eCKI
         4xCswLk5KsTgrOKJiTTPct81xB7PIvQlGZXPjziMu28EyqkhGD3wlCGIyCo2ZB2UERdN
         K7oaxJj+TjVYIoYpR+dLp9M62tZjNOhleNT4lA0fJOHLk8TRMUSO6z+aqMcNU2gAymxS
         w5VmCSMusXzHdFlXE97yir8PagSerkVflYgmEUWktuA1rd0eCEX0Yt7zuLrhWV68cRUx
         U4dPx91sKW22c57/GP6x8yp3m36Ce/g0yNzKr4t9/5lI8gPDLXOepZimvYhD5Mapru/0
         eveg==
X-Gm-Message-State: AOJu0YyUHHWWPlCGSE1j/Gy5uzKbqFnhxCsdMjwnMqSAm0+SWS2OVn96
	GfqI6q0D2eY5Jy0/zWDSRvgu3ueigxE=
X-Google-Smtp-Source: AGHT+IHp95pnHBpGST+4vtRvNyTH5biaemOYZgB8XiiCBPCxXrTDcGLJjvu3bDnbMTy8rJsQqRJ+XQ==
X-Received: by 2002:a05:6512:39cb:b0:50b:f03c:1ea2 with SMTP id k11-20020a05651239cb00b0050bf03c1ea2mr10860168lfu.84.1702906664468;
        Mon, 18 Dec 2023 05:37:44 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id f20-20020a1709067f9400b00a234907311asm1891537ejr.55.2023.12.18.05.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 05:37:44 -0800 (PST)
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
Subject: [PATCH 3/4] nvmem: u-boot-env: use more nvmem subsystem helpers
Date: Mon, 18 Dec 2023 14:37:21 +0100
Message-Id: <20231218133722.16150-3-zajec5@gmail.com>
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

1. Use nvmem_dev_size() and nvmem_device_read() to make this driver less
   mtd dependent
2. Use nvmem_add_one_cell() to simplify adding NVMEM cells

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/u-boot-env.c | 79 +++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 44 deletions(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index c4ae94af4af7..ab8c9bf63d99 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -23,13 +23,10 @@ enum u_boot_env_format {
 
 struct u_boot_env {
 	struct device *dev;
+	struct nvmem_device *nvmem;
 	enum u_boot_env_format format;
 
 	struct mtd_info *mtd;
-
-	/* Cells */
-	struct nvmem_cell_info *cells;
-	int ncells;
 };
 
 struct u_boot_env_image_single {
@@ -94,72 +91,69 @@ static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, i
 static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
 				size_t data_offset, size_t data_len)
 {
+	struct nvmem_device *nvmem = priv->nvmem;
 	struct device *dev = priv->dev;
 	char *data = buf + data_offset;
 	char *var, *value, *eq;
-	int idx;
-
-	priv->ncells = 0;
-	for (var = data; var < data + data_len && *var; var += strlen(var) + 1)
-		priv->ncells++;
 
-	priv->cells = devm_kcalloc(dev, priv->ncells, sizeof(*priv->cells), GFP_KERNEL);
-	if (!priv->cells)
-		return -ENOMEM;
-
-	for (var = data, idx = 0;
+	for (var = data;
 	     var < data + data_len && *var;
-	     var = value + strlen(value) + 1, idx++) {
+	     var = value + strlen(value) + 1) {
+		struct nvmem_cell_info info = {};
+
 		eq = strchr(var, '=');
 		if (!eq)
 			break;
 		*eq = '\0';
 		value = eq + 1;
 
-		priv->cells[idx].name = devm_kstrdup(dev, var, GFP_KERNEL);
-		if (!priv->cells[idx].name)
+		info.name = devm_kstrdup(dev, var, GFP_KERNEL);
+		if (!info.name)
 			return -ENOMEM;
-		priv->cells[idx].offset = data_offset + value - data;
-		priv->cells[idx].bytes = strlen(value);
-		priv->cells[idx].np = of_get_child_by_name(dev->of_node, priv->cells[idx].name);
+		info.offset = data_offset + value - data;
+		info.bytes = strlen(value);
+		info.np = of_get_child_by_name(dev->of_node, info.name);
 		if (!strcmp(var, "ethaddr")) {
-			priv->cells[idx].raw_len = strlen(value);
-			priv->cells[idx].bytes = ETH_ALEN;
-			priv->cells[idx].read_post_process = u_boot_env_read_post_process_ethaddr;
+			info.raw_len = strlen(value);
+			info.bytes = ETH_ALEN;
+			info.read_post_process = u_boot_env_read_post_process_ethaddr;
 		}
-	}
 
-	if (WARN_ON(idx != priv->ncells))
-		priv->ncells = idx;
+		nvmem_add_one_cell(nvmem, &info);
+	}
 
 	return 0;
 }
 
 static int u_boot_env_parse(struct u_boot_env *priv)
 {
+	struct nvmem_device *nvmem = priv->nvmem;
 	struct device *dev = priv->dev;
 	size_t crc32_data_offset;
 	size_t crc32_data_len;
 	size_t crc32_offset;
 	size_t data_offset;
 	size_t data_len;
+	size_t dev_size;
 	uint32_t crc32;
 	uint32_t calc;
-	size_t bytes;
 	uint8_t *buf;
+	int bytes;
 	int err;
 
-	buf = kcalloc(1, priv->mtd->size, GFP_KERNEL);
+	dev_size = nvmem_dev_size(nvmem);
+
+	buf = kcalloc(1, dev_size, GFP_KERNEL);
 	if (!buf) {
 		err = -ENOMEM;
 		goto err_out;
 	}
 
-	err = mtd_read(priv->mtd, 0, priv->mtd->size, &bytes, buf);
-	if ((err && !mtd_is_bitflip(err)) || bytes != priv->mtd->size) {
-		dev_err(dev, "Failed to read from mtd: %d\n", err);
-		goto err_kfree;
-	}
+	bytes = nvmem_device_read(nvmem, 0, dev_size, buf);
+	if (bytes < 0)
+		return bytes;
+	else if (bytes != dev_size)
+		return -EIO;
 
 	switch (priv->format) {
 	case U_BOOT_FORMAT_SINGLE:
@@ -179,8 +173,8 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		break;
 	}
 	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
-	crc32_data_len = priv->mtd->size - crc32_data_offset;
-	data_len = priv->mtd->size - data_offset;
+	crc32_data_len = dev_size - crc32_data_offset;
+	data_len = dev_size - data_offset;
 
 	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
 	if (calc != crc32) {
@@ -189,7 +183,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		goto err_kfree;
 	}
 
-	buf[priv->mtd->size - 1] = '\0';
+	buf[dev_size - 1] = '\0';
 	err = u_boot_env_add_cells(priv, buf, data_offset, data_len);
 	if (err)
 		dev_err(dev, "Failed to add cells: %d\n", err);
@@ -209,7 +203,6 @@ static int u_boot_env_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct u_boot_env *priv;
-	int err;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -224,17 +217,15 @@ static int u_boot_env_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->mtd);
 	}
 
-	err = u_boot_env_parse(priv);
-	if (err)
-		return err;
-
 	config.dev = dev;
-	config.cells = priv->cells;
-	config.ncells = priv->ncells;
 	config.priv = priv;
 	config.size = priv->mtd->size;
 
-	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
+	priv->nvmem = devm_nvmem_register(dev, &config);
+	if (IS_ERR(priv->nvmem))
+		return PTR_ERR(priv->nvmem);
+
+	return u_boot_env_parse(priv);
 }
 
 static const struct of_device_id u_boot_env_of_match_table[] = {
-- 
2.35.3


