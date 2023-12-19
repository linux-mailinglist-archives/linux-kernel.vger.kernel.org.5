Return-Path: <linux-kernel+bounces-5707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F705818E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 725FCB22002
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E75381A1;
	Tue, 19 Dec 2023 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVeTALbw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40A0374E7;
	Tue, 19 Dec 2023 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e384cd6ebso3095066e87.3;
        Tue, 19 Dec 2023 09:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703007642; x=1703612442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ycf7wNvbkEl/9uPO9wSLuwfT5/8x2RoUUgzU3Md07E=;
        b=QVeTALbwg0y+ZzLZCJuPv5qtmfDGKJdRHQ3Y/lJ9+/kxYZoDPiXROjP3cceapSlOA/
         B4T5joQuQ10cC9rKmPRPj0x7WmGa7JXuLGhdVT7S3YRRTZuPSBH7uHuQkbJJRfIZjRMv
         J5Tt2wqkeeXRzRCc1WtY4a03EPZlYHPbG1nD6xFJLcwmI5iGwgttRVqGD9ytNPcerYLn
         c1a20awoPCajb2Z6NItiXjKHCfNeNStcGVvvi2BZLpv9RmZkngElko+SCNRBJurBlAaQ
         XwyTR5YfVzzFAKgd+jdyE92y+XW8ctLB3Jn5QU9sCHZB3sp1dDa2v0uLwlsVJh298h2g
         JiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007642; x=1703612442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ycf7wNvbkEl/9uPO9wSLuwfT5/8x2RoUUgzU3Md07E=;
        b=AedGyicT3ymK6t6xWTQ+HNn7eiVTZK3GZcmR0Q1oJAKAOAOW0mr3/5R03cQH7baB5n
         55ZUG/UPyxBJyJaRAdXNN4sb2EGIld8cOriydM42Mp87x3NYavjvUhOzfx8kkrSFZvmx
         jiZWEuGa77BOWWzm+zukDtWKpwZ1qOT9qAa4GLpsWvJyNHEV/i71sgXJYEjssfpxhdEY
         AynPlo3FK4RyyK+2auUsGsWdBF53YHN2nnfV/cxy12hDWqBJZOQ6AfD2sRLSuCpk+r8z
         /oBBoW5h0Es8gUEGcbJUguWKjbH9949TVNLz3LEmL7I20Y+zOHF0jeUVEtVAy1fLbg+g
         H2lQ==
X-Gm-Message-State: AOJu0YyNAUrbhiPQfSh+t/4U980NE51gIPPO9InbxcMFXK6ATTXFa989
	1Ci/Sxe8c/LJT0xfi5e7BgI=
X-Google-Smtp-Source: AGHT+IFXWlg0Ca+Iule8+3trpaH6T9SLCyaiFa3AwNwMzBt2EkWWzlZdV/VpHBJalreP4HGa4oqWtA==
X-Received: by 2002:ac2:4e11:0:b0:50b:eadf:f175 with SMTP id e17-20020ac24e11000000b0050beadff175mr6460266lfr.91.1703007642136;
        Tue, 19 Dec 2023 09:40:42 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id tx27-20020a1709078e9b00b00a1c85124b08sm15834840ejc.94.2023.12.19.09.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:40:41 -0800 (PST)
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
Subject: [PATCH V2 3/5] nvmem: u-boot-env: use more nvmem subsystem helpers
Date: Tue, 19 Dec 2023 18:40:23 +0100
Message-Id: <20231219174025.15228-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231219174025.15228-1-zajec5@gmail.com>
References: <20231219174025.15228-1-zajec5@gmail.com>
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
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
V2: Don't introduce memleak when handling nvmem_device_read() failures

 drivers/nvmem/u-boot-env.c | 78 ++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 42 deletions(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index c4ae94af4af7..111905189341 100644
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
@@ -94,70 +91,70 @@ static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, i
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
-
-	priv->cells = devm_kcalloc(dev, priv->ncells, sizeof(*priv->cells), GFP_KERNEL);
-	if (!priv->cells)
-		return -ENOMEM;
 
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
+	bytes = nvmem_device_read(nvmem, 0, dev_size, buf);
+	if (bytes < 0) {
+		err = bytes;
+		goto err_kfree;
+	} else if (bytes != dev_size) {
+		err = -EIO;
 		goto err_kfree;
 	}
 
@@ -179,8 +176,8 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		break;
 	}
 	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
-	crc32_data_len = priv->mtd->size - crc32_data_offset;
-	data_len = priv->mtd->size - data_offset;
+	crc32_data_len = dev_size - crc32_data_offset;
+	data_len = dev_size - data_offset;
 
 	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
 	if (calc != crc32) {
@@ -189,7 +186,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		goto err_kfree;
 	}
 
-	buf[priv->mtd->size - 1] = '\0';
+	buf[dev_size - 1] = '\0';
 	err = u_boot_env_add_cells(priv, buf, data_offset, data_len);
 	if (err)
 		dev_err(dev, "Failed to add cells: %d\n", err);
@@ -209,7 +206,6 @@ static int u_boot_env_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct u_boot_env *priv;
-	int err;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -224,17 +220,15 @@ static int u_boot_env_probe(struct platform_device *pdev)
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


