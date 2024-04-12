Return-Path: <linux-kernel+bounces-141955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A688A257A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2161A1C2253D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6D91B27D;
	Fri, 12 Apr 2024 05:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CB2mVFq8"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C6B1DFF5;
	Fri, 12 Apr 2024 05:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712898705; cv=none; b=i0tPk50iWcVOy9z1QbScdDePzgLmyRFPw1Y+O5P2WK5rTIld6hyJ9gsZvwRgzvO3xZQjdg4H0Q2e55D3NR9s7r8KBwd++Hz/vpgXP4SBuFLoPzDU0fYlJ394K6D1jvf2P6eXnE/ogb3CYCTzitVq2snhZo2e/9JJ1Mfj+Usr0pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712898705; c=relaxed/simple;
	bh=jqDNrGAyxsYzMLYgVvkvn3DsQMoDqzG2Abl6HqZwq3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UP6L54Q9QNz8Ky3SUKWkcx8rvCr1pmivaHSTuECWMUVb35mgO1nAjYE4kfCkEG2UUBE2mmSs+lyh3WlDFryxNecBoLqtp+TkLh6bUMDPHzqamBMrDjpTz7hM2IIOFKwHJm9ui32/1h/hqTkA/cSqZIi/QBWriJD5Rrw+M2Q/34s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CB2mVFq8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so606124b3a.0;
        Thu, 11 Apr 2024 22:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712898702; x=1713503502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tC6rG1fD3ItI1XoGthXm2AMsyO+JK9+EA6lFFhllInI=;
        b=CB2mVFq8KOS2Y2A5FJE5A+KCYEn54t63/kntes8GApz3TcKzGZj97aQI42CWgWv32S
         DVlyj6+TRtITC5u/0bcxzTxBXWlyBsT7lYjgwhNz3LsYDkjoijUfZhAjAKsXusxD0Zl9
         XSZcjcPaMryMOhO55pLmMYiTBlLzTE2z9t6VSRlDBtmMc/bzNHGpRXUN1vCiI+p+pusO
         sYNc8k3Lj43xgbEQMKH7iQ56w52Ibr/WIRLQAQkgUsVLnqmNicjPR36WUBJMvDAXUqtK
         golJwV0gmz++Cq8TtTC62vO6J7cmA0TUc2Sw/Vjl54CcrJI3uIopK2U6/jhWYQg5W33G
         jUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712898702; x=1713503502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tC6rG1fD3ItI1XoGthXm2AMsyO+JK9+EA6lFFhllInI=;
        b=Wg8FfZE2K5dIItwPB+Ui3RA+DHgEhlcjKel42zm2rMt01jTfOMRCFTDBvUnEVCqhTT
         mLjSOM3aW3JhkoWD5dQ4A/NwrgmcLXlKRrYOZUekSzgfA20s8LEEOSbYuDk6OA1z5bSl
         9eld6HbxOVQNdSuRBmqK1tSEUHNACtePmC+xARS1s8yhBLSq+CkLw3KSMnIrycme0HIA
         EdJpWIkH+FsK2+/ZOBCGMyDYPJAm+9yHQZ00MjtHl4CkFksfdli0IbyUwA8YlrcPOYBq
         0vuauBCY9l6LTcksnWBsKqPnrElmgkhoXQJTlQnkyndoxWXUkDhaMpuOcFD7uJKUM5pE
         JpuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbMpjxYJNKRrMEKEsBfJX0SD1nPDaQF6Pa6OPIIgojh4q1hCAcTQWP+7JmyOK+WLe5wAgjBSLV23NKWXxS8adDU+WC1ps9R45lsafh
X-Gm-Message-State: AOJu0YxUrjYFKHVLvgbgLItm2TxjlDFcWkqZu1WuJ6goMn9lFUTlEt/g
	FVNWytbOxCKTjrk9+TATACMOxbLJ4yAjFX+JWO6FVZn0fLnqNmhN+02bZmmb
X-Google-Smtp-Source: AGHT+IFvEzqiuVhGHocDVtmsh+c8BjcBpxbHbhUWcq0prVOG9lCOh8+ctqqPR3ecrPuvIQCXPqDjag==
X-Received: by 2002:a05:6a20:6597:b0:1a7:4aa2:9bbf with SMTP id p23-20020a056a20659700b001a74aa29bbfmr1571122pzh.60.1712898702499;
        Thu, 11 Apr 2024 22:11:42 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.200])
        by smtp.gmail.com with ESMTPSA id fh16-20020a17090b035000b002a53b9cf356sm3734902pjb.0.2024.04.11.22.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 22:11:42 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH v9 03/13] clk: hisilicon: hi3798cv200: Use helper functions
Date: Fri, 12 Apr 2024 13:10:32 +0800
Message-ID: <20240412051041.90376-5-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/crg-hi3798cv200.c | 200 +++---------------------
 1 file changed, 22 insertions(+), 178 deletions(-)

diff --git a/drivers/clk/hisilicon/crg-hi3798cv200.c b/drivers/clk/hisilicon/crg-hi3798cv200.c
index f651b197e45a..9ce590cc4142 100644
--- a/drivers/clk/hisilicon/crg-hi3798cv200.c
+++ b/drivers/clk/hisilicon/crg-hi3798cv200.c
@@ -12,7 +12,6 @@
 #include <linux/platform_device.h>
 #include "clk.h"
 #include "crg.h"
-#include "reset.h"
 
 /* hi3798CV200 core CRG */
 #define HI3798CV200_INNER_CLK_OFFSET		64
@@ -41,6 +40,7 @@
 
 #define HI3798CV200_CRG_NR_CLKS			128
 
+#define HI3798CV200_SYSCTRL_NR_CLKS		16
 static const struct hisi_fixed_rate_clock hi3798cv200_fixed_rate_clks[] = {
 	{ HISTB_OSC_CLK, "clk_osc", NULL, 0, 24000000, },
 	{ HISTB_APB_CLK, "clk_apb", NULL, 0, 100000000, },
@@ -193,90 +193,18 @@ static const struct hisi_gate_clock hi3798cv200_gate_clks[] = {
 		CLK_SET_RATE_PARENT, 0xb0, 18, 0 },
 };
 
-static struct hisi_clock_data *hi3798cv200_clk_register(
-				struct platform_device *pdev)
-{
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_alloc(pdev, HI3798CV200_CRG_NR_CLKS);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
-
-	/* hisi_phase_clock is resource managed */
-	ret = hisi_clk_register_phase(&pdev->dev,
-				hi3798cv200_phase_clks,
-				ARRAY_SIZE(hi3798cv200_phase_clks),
-				clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = hisi_clk_register_fixed_rate(hi3798cv200_fixed_rate_clks,
-				     ARRAY_SIZE(hi3798cv200_fixed_rate_clks),
-				     clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = hisi_clk_register_mux(hi3798cv200_mux_clks,
-				ARRAY_SIZE(hi3798cv200_mux_clks),
-				clk_data);
-	if (ret)
-		goto unregister_fixed_rate;
-
-	ret = hisi_clk_register_gate(hi3798cv200_gate_clks,
-				ARRAY_SIZE(hi3798cv200_gate_clks),
-				clk_data);
-	if (ret)
-		goto unregister_mux;
-
-	ret = of_clk_add_provider(pdev->dev.of_node,
-			of_clk_src_onecell_get, &clk_data->clk_data);
-	if (ret)
-		goto unregister_gate;
-
-	return clk_data;
-
-unregister_gate:
-	hisi_clk_unregister_gate(hi3798cv200_gate_clks,
-				ARRAY_SIZE(hi3798cv200_gate_clks),
-				clk_data);
-unregister_mux:
-	hisi_clk_unregister_mux(hi3798cv200_mux_clks,
-				ARRAY_SIZE(hi3798cv200_mux_clks),
-				clk_data);
-unregister_fixed_rate:
-	hisi_clk_unregister_fixed_rate(hi3798cv200_fixed_rate_clks,
-				ARRAY_SIZE(hi3798cv200_fixed_rate_clks),
-				clk_data);
-	return ERR_PTR(ret);
-}
-
-static void hi3798cv200_clk_unregister(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-
-	hisi_clk_unregister_gate(hi3798cv200_gate_clks,
-				ARRAY_SIZE(hi3798cv200_gate_clks),
-				crg->clk_data);
-	hisi_clk_unregister_mux(hi3798cv200_mux_clks,
-				ARRAY_SIZE(hi3798cv200_mux_clks),
-				crg->clk_data);
-	hisi_clk_unregister_fixed_rate(hi3798cv200_fixed_rate_clks,
-				ARRAY_SIZE(hi3798cv200_fixed_rate_clks),
-				crg->clk_data);
-}
-
-static const struct hisi_crg_funcs hi3798cv200_crg_funcs = {
-	.register_clks = hi3798cv200_clk_register,
-	.unregister_clks = hi3798cv200_clk_unregister,
+static const struct hisi_clocks hi3798cv200_crg_clks = {
+	.nr = HI3798CV200_CRG_NR_CLKS,
+	.fixed_rate_clks = hi3798cv200_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3798cv200_fixed_rate_clks),
+	.mux_clks = hi3798cv200_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3798cv200_mux_clks),
+	.phase_clks = hi3798cv200_phase_clks,
+	.phase_clks_num = ARRAY_SIZE(hi3798cv200_phase_clks),
+	.gate_clks = hi3798cv200_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3798cv200_gate_clks),
 };
 
-/* hi3798CV200 sysctrl CRG */
-
-#define HI3798CV200_SYSCTRL_NR_CLKS 16
-
 static const struct hisi_gate_clock hi3798cv200_sysctrl_gate_clks[] = {
 	{ HISTB_IR_CLK, "clk_ir", "24m",
 		CLK_SET_RATE_PARENT, 0x48, 4, 0, },
@@ -286,115 +214,31 @@ static const struct hisi_gate_clock hi3798cv200_sysctrl_gate_clks[] = {
 		CLK_SET_RATE_PARENT, 0x48, 10, 0, },
 };
 
-static struct hisi_clock_data *hi3798cv200_sysctrl_clk_register(
-					struct platform_device *pdev)
-{
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_alloc(pdev, HI3798CV200_SYSCTRL_NR_CLKS);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
-
-	ret = hisi_clk_register_gate(hi3798cv200_sysctrl_gate_clks,
-				ARRAY_SIZE(hi3798cv200_sysctrl_gate_clks),
-				clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = of_clk_add_provider(pdev->dev.of_node,
-			of_clk_src_onecell_get, &clk_data->clk_data);
-	if (ret)
-		goto unregister_gate;
-
-	return clk_data;
-
-unregister_gate:
-	hisi_clk_unregister_gate(hi3798cv200_sysctrl_gate_clks,
-				ARRAY_SIZE(hi3798cv200_sysctrl_gate_clks),
-				clk_data);
-	return ERR_PTR(ret);
-}
-
-static void hi3798cv200_sysctrl_clk_unregister(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-
-	hisi_clk_unregister_gate(hi3798cv200_sysctrl_gate_clks,
-				ARRAY_SIZE(hi3798cv200_sysctrl_gate_clks),
-				crg->clk_data);
-}
-
-static const struct hisi_crg_funcs hi3798cv200_sysctrl_funcs = {
-	.register_clks = hi3798cv200_sysctrl_clk_register,
-	.unregister_clks = hi3798cv200_sysctrl_clk_unregister,
+static const struct hisi_clocks hi3798cv200_sysctrl_clks = {
+	.nr = HI3798CV200_SYSCTRL_NR_CLKS,
+	.gate_clks = hi3798cv200_sysctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3798cv200_sysctrl_gate_clks),
 };
 
 static const struct of_device_id hi3798cv200_crg_match_table[] = {
 	{ .compatible = "hisilicon,hi3798cv200-crg",
-		.data = &hi3798cv200_crg_funcs },
+		.data = &hi3798cv200_crg_clks },
 	{ .compatible = "hisilicon,hi3798cv200-sysctrl",
-		.data = &hi3798cv200_sysctrl_funcs },
+		.data = &hi3798cv200_sysctrl_clks },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, hi3798cv200_crg_match_table);
 
-static int hi3798cv200_crg_probe(struct platform_device *pdev)
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
-static void hi3798cv200_crg_remove(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	hisi_reset_exit(crg->rstc);
-	crg->funcs->unregister_clks(pdev);
-}
-
 static struct platform_driver hi3798cv200_crg_driver = {
-	.probe          = hi3798cv200_crg_probe,
-	.remove_new	= hi3798cv200_crg_remove,
-	.driver         = {
-		.name   = "hi3798cv200-crg",
+	.probe = hisi_crg_probe,
+	.remove_new = hisi_crg_remove,
+	.driver = {
+		.name = "hi3798cv200-crg",
 		.of_match_table = hi3798cv200_crg_match_table,
 	},
 };
 
-static int __init hi3798cv200_crg_init(void)
-{
-	return platform_driver_register(&hi3798cv200_crg_driver);
-}
-core_initcall(hi3798cv200_crg_init);
-
-static void __exit hi3798cv200_crg_exit(void)
-{
-	platform_driver_unregister(&hi3798cv200_crg_driver);
-}
-module_exit(hi3798cv200_crg_exit);
+module_platform_driver(hi3798cv200_crg_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("HiSilicon Hi3798CV200 CRG Driver");
-- 
2.43.0


