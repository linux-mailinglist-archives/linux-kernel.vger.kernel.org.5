Return-Path: <linux-kernel+bounces-141959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CD58A2583
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7CA1C2265F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4FD1BC56;
	Fri, 12 Apr 2024 05:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ75Gxfj"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E858405C7;
	Fri, 12 Apr 2024 05:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712898718; cv=none; b=gJgWAP5aan1cyOi6HKLzd44phvj0JNQ3jHqd2vd5+akEkJEFuuW9o85pUGHcpeDAi8rLHvQNTFKIhDTrUSADv83fZqjX+Nd/toOcRUw3RoCW4RyACTK1FQTXPtERxoYR/ioVL95SzoTHnUTHt9oB5Hi3GrVHAbms01xYxDic7wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712898718; c=relaxed/simple;
	bh=HfJ1S5KdKHSPKA4RYbJNyHIQ3bzwY7tI4B4y7x9pmgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bhl6goGdZsi78f8A2i5/GJugo7Q9oxgsSf/qpXs4cztAtxhfleQXNcg10s+P9TK/ISH9BMX+ma/yT/w8XCRxmKIQrtEEtEGZZVoJqaTULBd0bbD6/mJNJdvH+5pKrHnzuMojtWbNhEPmIZQWzGu7dbxCz0xCeEssuae0o+vJKMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZ75Gxfj; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a2d82537efso303015a91.2;
        Thu, 11 Apr 2024 22:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712898715; x=1713503515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtSXYkkVUyqDmHmEVpBee9BzMAYrcrXa3fsn+yc0wAY=;
        b=bZ75GxfjpW5EwZPvWbWUXglqvD9UY3NYZprT1z7ehZ+BBNl3Vz/rok8k/dbW+T0xQC
         tUXluAcxQhGMZ/R8g/CmP3VBHuS3WT5X/4jGpIkA4cVpRw7QPkY7T7vLOa6lHV9T9v/S
         GANst7Da0QFymA/Dl2sYEufX6xOweZ9dFkWHSJrKprAMqUINh/Q0uhi/5GCHcWem07qx
         fu6pe8bOXZj39UvYJtvCM1cJH0apHZRFKKr2f82tFkaTJ36nxyjYRKHAAN5S9QprUYCZ
         Jj5K6Khv+F4EV8SaOzhqHZ1FfUNFQU4VKmcTbk7UcFy2ms1YMYb9rrciN86KGWkK7N/4
         /xVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712898715; x=1713503515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtSXYkkVUyqDmHmEVpBee9BzMAYrcrXa3fsn+yc0wAY=;
        b=nVVNP3ECHWFNU0PvRxk0DglWRzGsa1SZR4HcJYcvS3civY6KcF85aXHUgTWOjBNtRP
         CTG5CmXYe1CmDiA4tdYJN/qpRkHzuQovT6pRSqjARojWG2r9y/2vckUskj9/S/LXz7bP
         2vGEFm7v59MZ61Eyj08hl7CWO7G+BSsox55iy5/iyuNNvf5tH5BBQKQj2voCrN4qznPz
         /y/uCTxbNHDGIPRpTLmT4AbukP8xF/GdcmZklkmXU69x8eOyex0k412c4zr4BN/WiE0h
         wvgwpv2GBJlVlcBP7fhu/ClJIknHFBVnvJHzl2JLnh90sHBn+CPHYWhq+Bd425zWVZUG
         G66A==
X-Forwarded-Encrypted: i=1; AJvYcCWxXqJq1LDhUSiWppbJ4DGB9GZQX3BXByjFgEyelXSkLcv+aZo6KhsjB//BBZY1loSEdKGweAQs/ViMwuqIG6vsnqBUIdNLdGUtv4Ot
X-Gm-Message-State: AOJu0YyDIBw+xBvNVIQqDKAUMDhMKbAtXFiry/UXTOcpnHtHwySkmnQR
	zvWr8O3etz0bOnx3on2srjutB0rMpKYt7EUGXvGNC98S30yoGQZZytCP4Ss8
X-Google-Smtp-Source: AGHT+IE+Eiym0/V6QXMZ8BBFlkVkwFHjpiivMTsYgUAHHDtZU9j9GDcbac6/29E1Lue+s8XzqE3zJQ==
X-Received: by 2002:a17:90a:e50e:b0:2a5:6e51:eebd with SMTP id t14-20020a17090ae50e00b002a56e51eebdmr1731499pjy.23.1712898715281;
        Thu, 11 Apr 2024 22:11:55 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.200])
        by smtp.gmail.com with ESMTPSA id fh16-20020a17090b035000b002a53b9cf356sm3734902pjb.0.2024.04.11.22.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 22:11:54 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH v9 06/13] clk: hisilicon: hi3559a: Use helper functions
Date: Fri, 12 Apr 2024 13:10:35 +0800
Message-ID: <20240412051041.90376-8-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240412051041.90376-2-mmyangfl@gmail.com>
References: <20240412051041.90376-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use common helper functions and register clks with a single of_device_id
data.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/clk-hi3559a.c | 230 +++++-----------------------
 1 file changed, 37 insertions(+), 193 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
index c79a94f6d9d2..1902d943fe34 100644
--- a/drivers/clk/hisilicon/clk-hi3559a.c
+++ b/drivers/clk/hisilicon/clk-hi3559a.c
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/slab.h>
 
 #include <dt-bindings/clock/hi3559av100-clock.h>
 
@@ -452,9 +451,11 @@ static const struct clk_ops hisi_clk_pll_ops = {
 	.recalc_rate = clk_pll_recalc_rate,
 };
 
-static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
-			   int nums, struct hisi_clock_data *data, struct device *dev)
+static int
+hisi_clk_register_pll(struct device *dev, const void *clocks,
+		      size_t num, struct hisi_clock_data *data)
 {
+	const struct hi3559av100_pll_clock *clks = clocks;
 	void __iomem *base = data->base;
 	struct hi3559av100_clk_pll *p_clk = NULL;
 	struct clk *clk = NULL;
@@ -462,10 +463,11 @@ static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
 	int i;
 
 	p_clk = devm_kcalloc(dev, nums, sizeof(*p_clk), GFP_KERNEL);
+
 	if (!p_clk)
-		return;
+		return -ENOMEM;
 
-	for (i = 0; i < nums; i++) {
+	for (i = 0; i < num; i++) {
 		init.name = clks[i].name;
 		init.flags = 0;
 		init.parent_names =
@@ -492,78 +494,27 @@ static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
 		if (IS_ERR(clk)) {
 			dev_err(dev, "%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
-			continue;
+			return PTR_ERR(clk);
 		}
 
 		data->clk_data.clks[clks[i].id] = clk;
 		p_clk++;
 	}
-}
-
-static struct hisi_clock_data *hi3559av100_clk_register(
-	struct platform_device *pdev)
-{
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_alloc(pdev, HI3559AV100_CRG_NR_CLKS);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
-
-	ret = hisi_clk_register_fixed_rate(hi3559av100_fixed_rate_clks_crg,
-					   ARRAY_SIZE(hi3559av100_fixed_rate_clks_crg), clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	hisi_clk_register_pll(hi3559av100_pll_clks,
-			      ARRAY_SIZE(hi3559av100_pll_clks), clk_data, &pdev->dev);
-
-	ret = hisi_clk_register_mux(hi3559av100_mux_clks_crg,
-				    ARRAY_SIZE(hi3559av100_mux_clks_crg), clk_data);
-	if (ret)
-		goto unregister_fixed_rate;
-
-	ret = hisi_clk_register_gate(hi3559av100_gate_clks,
-				     ARRAY_SIZE(hi3559av100_gate_clks), clk_data);
-	if (ret)
-		goto unregister_mux;
-
-	ret = of_clk_add_provider(pdev->dev.of_node,
-				  of_clk_src_onecell_get, &clk_data->clk_data);
-	if (ret)
-		goto unregister_gate;
-
-	return clk_data;
-
-unregister_gate:
-	hisi_clk_unregister_gate(hi3559av100_gate_clks,
-				 ARRAY_SIZE(hi3559av100_gate_clks), clk_data);
-unregister_mux:
-	hisi_clk_unregister_mux(hi3559av100_mux_clks_crg,
-				ARRAY_SIZE(hi3559av100_mux_clks_crg), clk_data);
-unregister_fixed_rate:
-	hisi_clk_unregister_fixed_rate(hi3559av100_fixed_rate_clks_crg,
-				       ARRAY_SIZE(hi3559av100_fixed_rate_clks_crg), clk_data);
-	return ERR_PTR(ret);
-}
-
-static void hi3559av100_clk_unregister(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
 
-	of_clk_del_provider(pdev->dev.of_node);
-
-	hisi_clk_unregister_gate(hi3559av100_gate_clks,
-				 ARRAY_SIZE(hi3559av100_gate_clks), crg->clk_data);
-	hisi_clk_unregister_mux(hi3559av100_mux_clks_crg,
-				ARRAY_SIZE(hi3559av100_mux_clks_crg), crg->clk_data);
-	hisi_clk_unregister_fixed_rate(hi3559av100_fixed_rate_clks_crg,
-				       ARRAY_SIZE(hi3559av100_fixed_rate_clks_crg), crg->clk_data);
+	return 0;
 }
 
-static const struct hisi_crg_funcs hi3559av100_crg_funcs = {
-	.register_clks = hi3559av100_clk_register,
-	.unregister_clks = hi3559av100_clk_unregister,
+static const struct hisi_clocks hi3559av100_clks = {
+	.nr = HI3559AV100_CRG_NR_CLKS,
+	.fixed_rate_clks = hi3559av100_fixed_rate_clks_crg,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3559av100_fixed_rate_clks_crg),
+	.mux_clks = hi3559av100_mux_clks_crg,
+	.mux_clks_num = ARRAY_SIZE(hi3559av100_mux_clks_crg),
+	.gate_clks = hi3559av100_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3559av100_gate_clks),
+	.customized_clks = hi3559av100_pll_clks,
+	.customized_clks_num = ARRAY_SIZE(hi3559av100_pll_clks),
+	.clk_register_customized = hisi_clk_register_pll,
 };
 
 static struct hisi_fixed_rate_clock hi3559av100_shub_fixed_rate_clks[] = {
@@ -671,7 +622,7 @@ static struct hisi_gate_clock hi3559av100_shub_gate_clks[] = {
 	},
 };
 
-static int hi3559av100_shub_default_clk_set(void)
+static int hi3559av100_shub_default_clk_set(struct device *dev, struct hisi_clock_data *data)
 {
 	void __iomem *crg_base;
 	unsigned int val;
@@ -694,148 +645,41 @@ static int hi3559av100_shub_default_clk_set(void)
 	return 0;
 }
 
-static struct hisi_clock_data *hi3559av100_shub_clk_register(
-	struct platform_device *pdev)
-{
-	struct hisi_clock_data *clk_data = NULL;
-	int ret;
-
-	hi3559av100_shub_default_clk_set();
-
-	clk_data = hisi_clk_alloc(pdev, HI3559AV100_SHUB_NR_CLKS);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
-
-	ret = hisi_clk_register_fixed_rate(hi3559av100_shub_fixed_rate_clks,
-					   ARRAY_SIZE(hi3559av100_shub_fixed_rate_clks), clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = hisi_clk_register_mux(hi3559av100_shub_mux_clks,
-				    ARRAY_SIZE(hi3559av100_shub_mux_clks), clk_data);
-	if (ret)
-		goto unregister_fixed_rate;
-
-	ret = hisi_clk_register_divider(hi3559av100_shub_div_clks,
-					ARRAY_SIZE(hi3559av100_shub_div_clks), clk_data);
-	if (ret)
-		goto unregister_mux;
-
-	ret = hisi_clk_register_gate(hi3559av100_shub_gate_clks,
-				     ARRAY_SIZE(hi3559av100_shub_gate_clks), clk_data);
-	if (ret)
-		goto unregister_factor;
-
-	ret = of_clk_add_provider(pdev->dev.of_node,
-				  of_clk_src_onecell_get, &clk_data->clk_data);
-	if (ret)
-		goto unregister_gate;
-
-	return clk_data;
-
-unregister_gate:
-	hisi_clk_unregister_gate(hi3559av100_shub_gate_clks,
-				 ARRAY_SIZE(hi3559av100_shub_gate_clks), clk_data);
-unregister_factor:
-	hisi_clk_unregister_divider(hi3559av100_shub_div_clks,
-				    ARRAY_SIZE(hi3559av100_shub_div_clks), clk_data);
-unregister_mux:
-	hisi_clk_unregister_mux(hi3559av100_shub_mux_clks,
-				ARRAY_SIZE(hi3559av100_shub_mux_clks), clk_data);
-unregister_fixed_rate:
-	hisi_clk_unregister_fixed_rate(hi3559av100_shub_fixed_rate_clks,
-				       ARRAY_SIZE(hi3559av100_shub_fixed_rate_clks), clk_data);
-	return ERR_PTR(ret);
-}
-
-static void hi3559av100_shub_clk_unregister(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-
-	hisi_clk_unregister_gate(hi3559av100_shub_gate_clks,
-				 ARRAY_SIZE(hi3559av100_shub_gate_clks), crg->clk_data);
-	hisi_clk_unregister_divider(hi3559av100_shub_div_clks,
-				    ARRAY_SIZE(hi3559av100_shub_div_clks), crg->clk_data);
-	hisi_clk_unregister_mux(hi3559av100_shub_mux_clks,
-				ARRAY_SIZE(hi3559av100_shub_mux_clks), crg->clk_data);
-	hisi_clk_unregister_fixed_rate(hi3559av100_shub_fixed_rate_clks,
-				       ARRAY_SIZE(hi3559av100_shub_fixed_rate_clks), crg->clk_data);
-}
-
-static const struct hisi_crg_funcs hi3559av100_shub_crg_funcs = {
-	.register_clks = hi3559av100_shub_clk_register,
-	.unregister_clks = hi3559av100_shub_clk_unregister,
+static const struct hisi_clocks hi3559av100_shub_clks = {
+	.nr = HI3559AV100_SHUB_NR_CLKS,
+	.prologue = hi3559av100_shub_default_clk_set,
+	.fixed_rate_clks = hi3559av100_shub_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3559av100_shub_fixed_rate_clks),
+	.mux_clks = hi3559av100_shub_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3559av100_shub_mux_clks),
+	.divider_clks = hi3559av100_shub_div_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3559av100_shub_div_clks),
+	.gate_clks = hi3559av100_shub_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3559av100_shub_gate_clks),
 };
 
 static const struct of_device_id hi3559av100_crg_match_table[] = {
 	{
 		.compatible = "hisilicon,hi3559av100-clock",
-		.data = &hi3559av100_crg_funcs
+		.data = &hi3559av100_clks
 	},
 	{
 		.compatible = "hisilicon,hi3559av100-shub-clock",
-		.data = &hi3559av100_shub_crg_funcs
+		.data = &hi3559av100_shub_clks
 	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, hi3559av100_crg_match_table);
 
-static int hi3559av100_crg_probe(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg;
-
-	crg = devm_kmalloc(&pdev->dev, sizeof(*crg), GFP_KERNEL);
-	if (!crg)
-		return -ENOMEM;
-
-	crg->funcs = of_device_get_match_data(&pdev->dev);
-	if (!crg->funcs)
-		return -ENOENT;
-
-	crg->rstc = hisi_reset_init(pdev);
-	if (!crg->rstc)
-		return -ENOMEM;
-
-	crg->clk_data = crg->funcs->register_clks(pdev);
-	if (IS_ERR(crg->clk_data)) {
-		hisi_reset_exit(crg->rstc);
-		return PTR_ERR(crg->clk_data);
-	}
-
-	platform_set_drvdata(pdev, crg);
-	return 0;
-}
-
-static void hi3559av100_crg_remove(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	hisi_reset_exit(crg->rstc);
-	crg->funcs->unregister_clks(pdev);
-}
-
 static struct platform_driver hi3559av100_crg_driver = {
-	.probe		= hi3559av100_crg_probe,
-	.remove_new	= hi3559av100_crg_remove,
+	.probe = hisi_crg_probe,
+	.remove_new = hisi_crg_remove,
 	.driver		= {
 		.name	= "hi3559av100-clock",
 		.of_match_table = hi3559av100_crg_match_table,
 	},
 };
 
-static int __init hi3559av100_crg_init(void)
-{
-	return platform_driver_register(&hi3559av100_crg_driver);
-}
-core_initcall(hi3559av100_crg_init);
-
-static void __exit hi3559av100_crg_exit(void)
-{
-	platform_driver_unregister(&hi3559av100_crg_driver);
-}
-module_exit(hi3559av100_crg_exit);
-
+module_platform_driver(hi3559av100_crg_driver);
 
 MODULE_DESCRIPTION("HiSilicon Hi3559AV100 CRG Driver");
-- 
2.43.0


