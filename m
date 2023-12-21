Return-Path: <linux-kernel+bounces-8857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA50A81BD54
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF15B1C23675
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A50263511;
	Thu, 21 Dec 2023 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQGWUKs1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CFA634EA;
	Thu, 21 Dec 2023 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a236d77dceeso132142966b.2;
        Thu, 21 Dec 2023 09:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703180076; x=1703784876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqokOpCdOnYJH+v0vSqloYMckBtHhTjUM2t6QO3puqo=;
        b=RQGWUKs1PmWexBqA7biqdNoRe0mVG45Fs2gpqKE0Ot6imjGHCNTJ+RE9HJM8IAvkKx
         z9Q+sjJ1wGGC5yBGFaXzLPfhQw711NDNAlfsYXUmgfEzbygJdP1hnjwjLPgVAYwx1arI
         qDOTMoiaSuDiH86Vzq25qd0QWOM4wpJcBKvmD9RVS6ia2tFPhXVu5ogkuEagd+EGAel2
         dl9RqItJsmTeaJQIWXVylZIYpka8purV01MmYdYWCR3feHpGxGuduffsVVQ8SZf4Gl0L
         1BkRRoft4jL9+C54wsCetBcAdAenmMus4ASWmaha4II7jWHt0yobbwc6HDf5gJ0i++HT
         JrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703180076; x=1703784876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqokOpCdOnYJH+v0vSqloYMckBtHhTjUM2t6QO3puqo=;
        b=G3l+Jv+Ad8DqbMM58fCy0C4PjuVyBe4yPcATTpK24+7cH/qla8/m6DqAKdjlHV/IM5
         yGavr2EsrsWT8pInStArfK1TVtnKpkPRzU9npAEfwq5M2xzZT2hxcWGNgYqssCor17hX
         JlmFB1nSE0AS/ifCB5AxsbKe/8q11Njh4+eCQ0X7OC489LDWvJJ6rh1rPTUDMfmFGC40
         kEyvxMUYMGbwihSixUkhcZZcU3LyStIVYKi7LL5WPG9e2WJrJFPaVuSOMWwWD6hseDMT
         QYe9hPpPeAU4V18xVbnzCim8Gxhn2mFMxKHwP9dGQOWI3+wXPkT4GlXMql6qcpkhxnvC
         RePg==
X-Gm-Message-State: AOJu0YwS54ZZZGUwZ4NuUvsBr8/e48kh/2FKumN5udMRqqiRGjpvyBxh
	Ph6zblRgTLkloE+hOBR3Xek=
X-Google-Smtp-Source: AGHT+IGaQKjDvlJgaXz5OpWMMH3CY7VA2HKjsXJ3j9h1/O/qdloXPM6loUd6C+exNofs994/dz4K/A==
X-Received: by 2002:a17:906:1059:b0:a23:56a3:f51e with SMTP id j25-20020a170906105900b00a2356a3f51emr22883ejj.198.1703180075704;
        Thu, 21 Dec 2023 09:34:35 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id z25-20020a1709060ad900b00a23499f1d7dsm1176118ejf.209.2023.12.21.09.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:34:35 -0800 (PST)
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
Subject: [PATCH V3 3/6] nvmem: u-boot-env: use nvmem_add_one_cell() nvmem subsystem helper
Date: Thu, 21 Dec 2023 18:34:18 +0100
Message-Id: <20231221173421.13737-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231221173421.13737-1-zajec5@gmail.com>
References: <20231221173421.13737-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Simplify adding NVMEM cells.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
V3: Split PATCH 3/3 into two

 drivers/nvmem/u-boot-env.c | 55 +++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 34 deletions(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index c4ae94af4af7..dd9d0ad22712 100644
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
@@ -94,43 +91,36 @@ static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, i
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
@@ -209,7 +199,6 @@ static int u_boot_env_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct u_boot_env *priv;
-	int err;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -224,17 +213,15 @@ static int u_boot_env_probe(struct platform_device *pdev)
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


