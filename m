Return-Path: <linux-kernel+bounces-814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A733814695
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0057C1F2429F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8862CCDA;
	Fri, 15 Dec 2023 11:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vf8ZE4q0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A583625561
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c1e3ea2f2so5157085e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702638951; x=1703243751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vf01rCZNs+PJUcph0LJ9xDFnWBedH3iX5y7d50fBsIk=;
        b=Vf8ZE4q0PS+WjT6xWQSiY0E7IOlIHy8FFW2O2TdM4gJm06bhGcgQmK0a2yVv/ZZ8zC
         8pQZ3Kvh00y6FY/DSzrgvNp6QltdeXZrxaX9JR8jvkskGQFW5x7AiJcLI0qIEtUt1HBy
         ja6QLH6mkH4N9zR98RyixXf8cZ9bDuTeVUo+cHdYBMchGSChTP25gUhSzPukFVkb7v11
         zaUqCa6IDz/ETnlJJGHm0umsrtBLD4SW8lSngDeKTBKT+4UGDUFk+qH1TDLl+X0P7hQj
         U3kTFo7Bm+XFRvZie9o6x1gWGMsRDWRmWPYiq2qUZBZlbWB9CkBFPvN1Kr7753d+cmBU
         IVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638951; x=1703243751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vf01rCZNs+PJUcph0LJ9xDFnWBedH3iX5y7d50fBsIk=;
        b=taej9xh1s8b3ZodxGZxcOQceQPzUYnQzMUH3gibkuLLB/vrLQMqYxpSez1LF/sW2ON
         gTSiLkBRDT6ThpC21oK6zF4C8VPcsS/P76vTwhC7L3Inj5sSEgRABPi2q6nYSLfsQnoR
         OQ98H5WDHkK9Xxjzhgl4g9VgDGD7Y/MVQzeZdKfKvOmmokeengqxJBOtKzFwtZzJlhtq
         TMCIN8Xl9Fna2fDW9/B5uzU58jYjFIkw4Gesv0YH2xxNwoj8HmaXSq6wgyZzMf0bhhT1
         7n9XI9r074LXSA82OYgyjrmERUpRaPKvgvHUUKa8iNiZMvaQzyu4NOmoDOz7VxaO/YLG
         4g9g==
X-Gm-Message-State: AOJu0YzP+miQJO8bb0zNnRktPB1mjczMQu0fMyBBBA+32IgAXl1o1Di8
	cURbv92e4/CfsyrlL+VJHTLv4lcGRipAgfejqqI=
X-Google-Smtp-Source: AGHT+IHc5BnjKeKbvk3KxtuAx1J6qEDt6m00OlC4Vt97548PUCJpJEODPb7x9n8NUVtWwxGsNIOPig==
X-Received: by 2002:a05:6000:184f:b0:336:492c:78ff with SMTP id c15-20020a056000184f00b00336492c78ffmr1648229wri.105.1702638950956;
        Fri, 15 Dec 2023 03:15:50 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g13-20020a056000118d00b003333d46a9e8sm18511497wrx.56.2023.12.15.03.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:15:50 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/10] nvmem: Move and rename ->fixup_cell_info()
Date: Fri, 15 Dec 2023 11:15:31 +0000
Message-Id: <20231215111536.316972-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215111536.316972-1-srinivas.kandagatla@linaro.org>
References: <20231215111536.316972-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6682; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=XG5KX8SfWmX9pvjWJZAJ+CNIBRWVO3JTz3rW0C54F/U=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlfDVXuIMnLmTFPbZQCNEgbcPPtySg7god6A1sC AcH33AuMbKJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZXw1VwAKCRB6of1ZxzRV NzRAB/0eYNEcKULKdiIDWHFT2wKV+RqSFs+yfjycokpsmF8MnEQTqFBQfWKe9HRMhId05H6BHKL Aa5/UzuOU8RHeF2CEPvWTYI/aqjZVX1IFBX3at6mWMOjVJH+MQi8cvQFnRMxSlvaIAozFqSdL84 2nZf0TJCCj9y3q3gC0fuIfOhkCWudgg0imfiuipkPZH4TDKpFYGkdvMpnQOwHr0FhWeKJ52q77/ QCeDwgdbSiK+RnM3kzuqk28/yrNS9tWxvDiShCh4jo9CBm+oqQ/0vL6w7aRCW1BadZJAThphWcr I9CaPEVU/zoG5XBb69Ca6Ji6iATlVK1tcn+9zMFc9Rf0q466
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Miquel Raynal <miquel.raynal@bootlin.com>

This hook is meant to be used by any provider and instantiating a layout
just for this is useless. Let's instead move this hook to the nvmem
device and add it to the config structure to be easily shared by the
providers.

While at moving this hook, rename it ->fixup_dt_cell_info() to clarify
its main intended purpose.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           |  6 +++---
 drivers/nvmem/imx-ocotp.c      | 11 +++--------
 drivers/nvmem/internals.h      |  2 ++
 drivers/nvmem/mtk-efuse.c      | 11 +++--------
 include/linux/nvmem-provider.h |  9 ++++-----
 5 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f63db5e01fca..a885713d6b4b 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -675,7 +675,6 @@ static int nvmem_validate_keepouts(struct nvmem_device *nvmem)
 
 static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_node *np)
 {
-	struct nvmem_layout *layout = nvmem->layout;
 	struct device *dev = &nvmem->dev;
 	struct device_node *child;
 	const __be32 *addr;
@@ -705,8 +704,8 @@ static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_nod
 
 		info.np = of_node_get(child);
 
-		if (layout && layout->fixup_cell_info)
-			layout->fixup_cell_info(nvmem, layout, &info);
+		if (nvmem->fixup_dt_cell_info)
+			nvmem->fixup_dt_cell_info(nvmem, &info);
 
 		ret = nvmem_add_one_cell(nvmem, &info);
 		kfree(info.name);
@@ -895,6 +894,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 	kref_init(&nvmem->refcnt);
 	INIT_LIST_HEAD(&nvmem->cells);
+	nvmem->fixup_dt_cell_info = config->fixup_dt_cell_info;
 
 	nvmem->owner = config->owner;
 	if (!nvmem->owner && config->dev->driver)
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index f1e202efaa49..79dd4fda0329 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -583,17 +583,12 @@ static const struct of_device_id imx_ocotp_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
 
-static void imx_ocotp_fixup_cell_info(struct nvmem_device *nvmem,
-				      struct nvmem_layout *layout,
-				      struct nvmem_cell_info *cell)
+static void imx_ocotp_fixup_dt_cell_info(struct nvmem_device *nvmem,
+					 struct nvmem_cell_info *cell)
 {
 	cell->read_post_process = imx_ocotp_cell_pp;
 }
 
-static struct nvmem_layout imx_ocotp_layout = {
-	.fixup_cell_info = imx_ocotp_fixup_cell_info,
-};
-
 static int imx_ocotp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -619,7 +614,7 @@ static int imx_ocotp_probe(struct platform_device *pdev)
 	imx_ocotp_nvmem_config.size = 4 * priv->params->nregs;
 	imx_ocotp_nvmem_config.dev = dev;
 	imx_ocotp_nvmem_config.priv = priv;
-	imx_ocotp_nvmem_config.layout = &imx_ocotp_layout;
+	imx_ocotp_nvmem_config.fixup_dt_cell_info = &imx_ocotp_fixup_dt_cell_info;
 
 	priv->config = &imx_ocotp_nvmem_config;
 
diff --git a/drivers/nvmem/internals.h b/drivers/nvmem/internals.h
index ce353831cd65..893553fbdf51 100644
--- a/drivers/nvmem/internals.h
+++ b/drivers/nvmem/internals.h
@@ -23,6 +23,8 @@ struct nvmem_device {
 	struct bin_attribute	eeprom;
 	struct device		*base_dev;
 	struct list_head	cells;
+	void (*fixup_dt_cell_info)(struct nvmem_device *nvmem,
+				   struct nvmem_cell_info *cell);
 	const struct nvmem_keepout *keepout;
 	unsigned int		nkeepout;
 	nvmem_reg_read_t	reg_read;
diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index 87c94686cfd2..84f05b40a411 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -45,9 +45,8 @@ static int mtk_efuse_gpu_speedbin_pp(void *context, const char *id, int index,
 	return 0;
 }
 
-static void mtk_efuse_fixup_cell_info(struct nvmem_device *nvmem,
-				      struct nvmem_layout *layout,
-				      struct nvmem_cell_info *cell)
+static void mtk_efuse_fixup_dt_cell_info(struct nvmem_device *nvmem,
+					 struct nvmem_cell_info *cell)
 {
 	size_t sz = strlen(cell->name);
 
@@ -61,10 +60,6 @@ static void mtk_efuse_fixup_cell_info(struct nvmem_device *nvmem,
 		cell->read_post_process = mtk_efuse_gpu_speedbin_pp;
 }
 
-static struct nvmem_layout mtk_efuse_layout = {
-	.fixup_cell_info = mtk_efuse_fixup_cell_info,
-};
-
 static int mtk_efuse_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -91,7 +86,7 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	econfig.priv = priv;
 	econfig.dev = dev;
 	if (pdata->uses_post_processing)
-		econfig.layout = &mtk_efuse_layout;
+		econfig.fixup_dt_cell_info = &mtk_efuse_fixup_dt_cell_info;
 	nvmem = devm_nvmem_register(dev, &econfig);
 
 	return PTR_ERR_OR_ZERO(nvmem);
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 3939991b3c5f..36415a602d9e 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -83,6 +83,8 @@ struct nvmem_cell_info {
  * @cells:	Optional array of pre-defined NVMEM cells.
  * @ncells:	Number of elements in cells.
  * @add_legacy_fixed_of_cells:	Read fixed NVMEM cells from old OF syntax.
+ * @fixup_dt_cell_info: Will be called before a cell is added. Can be
+ *		used to modify the nvmem_cell_info.
  * @keepout:	Optional array of keepout ranges (sorted ascending by start).
  * @nkeepout:	Number of elements in the keepout array.
  * @type:	Type of the nvmem storage
@@ -113,6 +115,8 @@ struct nvmem_config {
 	const struct nvmem_cell_info	*cells;
 	int			ncells;
 	bool			add_legacy_fixed_of_cells;
+	void (*fixup_dt_cell_info)(struct nvmem_device *nvmem,
+				   struct nvmem_cell_info *cell);
 	const struct nvmem_keepout *keepout;
 	unsigned int		nkeepout;
 	enum nvmem_type		type;
@@ -158,8 +162,6 @@ struct nvmem_cell_table {
  * @of_match_table:	Open firmware match table.
  * @add_cells:		Called to populate the layout using
  *			nvmem_add_one_cell().
- * @fixup_cell_info:	Will be called before a cell is added. Can be
- *			used to modify the nvmem_cell_info.
  * @owner:		Pointer to struct module.
  * @node:		List node.
  *
@@ -172,9 +174,6 @@ struct nvmem_layout {
 	const char *name;
 	const struct of_device_id *of_match_table;
 	int (*add_cells)(struct device *dev, struct nvmem_device *nvmem);
-	void (*fixup_cell_info)(struct nvmem_device *nvmem,
-				struct nvmem_layout *layout,
-				struct nvmem_cell_info *cell);
 
 	/* private */
 	struct module *owner;
-- 
2.25.1


