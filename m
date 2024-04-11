Return-Path: <linux-kernel+bounces-139922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79E68A092B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8791C217F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A439613F44B;
	Thu, 11 Apr 2024 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYCkbJdg"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5E013F003;
	Thu, 11 Apr 2024 07:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819200; cv=none; b=Q/gKLsKClVBaIsW1eBrq/GKrcdijZLrTLalxhjZQhbj5f+0Bi8nWDgiIJacuCzkW9tPa1zob3oWcl15iCCHi5JzHBogLOo+VU23w3F0MsYCvXT6TZ9BYxAroJn3v8mxqLAM8ZBlNUJG/s+AZPTKCw4pI81635utHhXE14HskwSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819200; c=relaxed/simple;
	bh=HfJ1S5KdKHSPKA4RYbJNyHIQ3bzwY7tI4B4y7x9pmgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHfc1LAVysccMro+J+BXYHV3MP2WRsnxHzciljiU0QTmfy/a4JfrAY6OxEZyT8N/nkiuScgIwCnvxSqusjnNJwauiqPdsPS4T79FI3v+6oGFMTrEmuGrVnGZIq4/ilFuB5SJsVnTfwFaE3TbgubnI+d8KzdWb5igI4DLO9jui6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYCkbJdg; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed2dc03df6so3565888b3a.1;
        Thu, 11 Apr 2024 00:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712819198; x=1713423998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtSXYkkVUyqDmHmEVpBee9BzMAYrcrXa3fsn+yc0wAY=;
        b=CYCkbJdghCn6Yue4MOgh7JbQihxVlpGC8mJWWftrxLxFHmaOmhfN792l+J4gmFPMxR
         zXKJqEcOObjnpQB9Jegd2bvAvuS7i2LA4QyN6iprtRrcBfXr7I5rNNViC4NSds5UWaaV
         nSfGCgZDK7p7RcMgsQFT0YAeTHOHWhivsec2g981RYn25776PBg+Uh81YfaGrHVgeOL8
         eHYFW+mgvOvF55dyMqj7a3aArU75obj83mPmUHZk22ixBJUXWWfmk+D1so22mLUi4yIa
         RZoVErtUTtCV7xr/WUHc6MSwsnGIyFxHB5NNetzQYIx8GglDIqugDFmMjIIuJWj3YCyi
         bMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712819198; x=1713423998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtSXYkkVUyqDmHmEVpBee9BzMAYrcrXa3fsn+yc0wAY=;
        b=jx798jxcAssVmW2y2KqTB0GaFc2JWYHH30in4+LxDbrqhic9vBTkAp/wwos0fpsMdO
         pwR8rlFf4q8pPG18wx5w7cg3Q4qz3MNIfRSVP3FAk2c/UT6pO1win65Y0RNmXk0OUBrU
         xTT7whHIHf5AeA6x6p5GSXiY7L0jVu7cG72xrGdY5GqmVri3rl34Hh/kDbjHItuAVv4i
         hztCZDWw2W4bFzjJOTnyT/SJtyMpTOaQjjCMiByW0+LC2G4cjwVsZ3wh/k16CcBE+osZ
         7YrW0Ib1COjvwArVsg7UNDZAK0Br7ZJmei+a6uHCSX8rGXb+i2/MDeCq9TGZNxDXB75z
         PqGA==
X-Forwarded-Encrypted: i=1; AJvYcCXaxjdIJgKkmz7Q4Ic2l8OdYTAMqa5Me7oGLFrHYnM5YJxCdo6Opd4CmWdwVywitBvmZa1es23KfLvhsV/RKCrT1VSuGXQ+i2oq3BM8
X-Gm-Message-State: AOJu0Yzz5F77yZwMvxQT0fP93TUBdql3StUVgZL/oP/7vzO30ToBTFkx
	Yf9O+1w9pQEQ52q9ALsGv4VsxoEhBEW9SSIE44QN+HEjmSQeNdD7DizmwwyS
X-Google-Smtp-Source: AGHT+IEJsPN2WLvuUE3HBhMwONpa+bYyKE0ExIxMoaNtYzuwxxFvuFm8NKQ/WNtYNlXrPVAGPz2pog==
X-Received: by 2002:a05:6a00:1acb:b0:6ed:9158:774e with SMTP id f11-20020a056a001acb00b006ed9158774emr6009467pfv.20.1712819198038;
        Thu, 11 Apr 2024 00:06:38 -0700 (PDT)
Received: from d.wok.cipunited.com ([104.28.213.200])
        by smtp.gmail.com with ESMTPSA id g5-20020a056a0023c500b006e6be006637sm647402pfc.135.2024.04.11.00.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 00:06:37 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH v8 06/13] clk: hisilicon: hi3559a: Use helper functions
Date: Thu, 11 Apr 2024 15:04:51 +0800
Message-ID: <20240411070503.38093-8-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411070503.38093-2-mmyangfl@gmail.com>
References: <20240411070503.38093-2-mmyangfl@gmail.com>
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


