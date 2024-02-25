Return-Path: <linux-kernel+bounces-79999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB5F86297F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 07:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60E0282237
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 06:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EF3DDA8;
	Sun, 25 Feb 2024 06:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTvYJ3uz"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2621F9EF;
	Sun, 25 Feb 2024 06:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708844008; cv=none; b=q61BzMeIUJM6M5knKs8ny9CKhZ/FkGXcM+BMOS5dEQJkJPVrNaQQjpQEEx9h8mV/whk5xmFspawxc7nXBd/vGrW42DgJd9eMHD4GtHvUzFVSFAr9dtfztZAe/biZF0FqQ+GjJEc7WJ/tLXBeKGK7rzPmuMEbiqq4i7ObWh1Njz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708844008; c=relaxed/simple;
	bh=jqDNrGAyxsYzMLYgVvkvn3DsQMoDqzG2Abl6HqZwq3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzX8qMLL7gc3mcukRUY7+omPM4V75VWrBSEE19eP2F2ooFcUdkHiobHj9Ia8u9plceX76QcDgeYDQdoss8q2Ky75IrpvTAn80EeO9CiQxw3jRNwPdrj95KYFzgEpKdH4RQ0+9e/ao8IJp44njTrnVqsQhwlTh+alXD4T0czExGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTvYJ3uz; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e4560664b5so1712843b3a.1;
        Sat, 24 Feb 2024 22:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708844006; x=1709448806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tC6rG1fD3ItI1XoGthXm2AMsyO+JK9+EA6lFFhllInI=;
        b=RTvYJ3uzOdeYw491jBGjwbT0fkuZuj1Ob5CcDqWa8oTMyCo7sautN9QrKioh7ESt/t
         0wGzfi5UuNPWkTNWTPRRL7bnwkReUPfJcFXNoRt6qxMaL30as25ASsY8kCOK2AoksvgC
         iqko1c5aq+fe6e/CWtwfaGMvxR9KdCLvfL5eSIi8x0wuNRcv++dczIYgpTk5AIPxJzAr
         OsyNe8Hkriaj8XAy+G/oaTkgsH15PLUd97cMQb1gSQixjOcDHP4sZksFgrqchOhcFubT
         29Nc9fGVBViaxTQIjnP2Uc5OZrHlljNOhEMpTgX/xYHtfkiEYy6VIAtMlItu4D6xEAAZ
         o27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708844006; x=1709448806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tC6rG1fD3ItI1XoGthXm2AMsyO+JK9+EA6lFFhllInI=;
        b=DwZ8ALXwJx7YRca0WVURetyrKDTwC78IseqQkx8XHfgzSbuf/rt3UDQRdyDsOGfzL7
         r9mRg4ZG8/IlDiK64DwHv7yjpSUSAUEeKctyBbdPcRdwEGvtI6gP4lBIiop1vujf8OjA
         6+OqpU9kp7ybOQ7AWyWGWp0AAk+ScF6anH2Ks5zfZmfiJ7riEvZl5SINK4fvoqbl9fY+
         qWFI34sAv0BiW/Htfu/aNEzNYEudOI9fAGRETpvcNKOtcQHtLKHJxAbsq7iVPEBraoar
         7bJJj5c6N27ZtbWeOWLBysUIRlUMcHcxpI34RAeRFoTh028LP+t3uyVl8AvPkBDzDB7e
         T2sw==
X-Forwarded-Encrypted: i=1; AJvYcCVzsMJlCTStFgot+Fvrvk+yFIvepUOApQ0Uo7F/d0BZPdx7R2l4oEyDq/+9KgwrN/fH3w+C26D9H3CfO8fIowjuPr579wr5hwlHpdsl
X-Gm-Message-State: AOJu0YzhNl+Hafruwyzezbmh1uX1+T6SiNEObZbsOXgHANwuKfPLNQD3
	rfWzaCjBnfCtP6ZaTJPC1rSl80UhefukFiPJQCEg490OlW/+mzVCfZ1vd8jn6014gQ==
X-Google-Smtp-Source: AGHT+IHDI+HjZ3MY5VXrPmzpbyhzAsHIEEhSCZ9SwMV1htfu1Nz+gTS4G1tgWezJSH4+A+nCIpwNuQ==
X-Received: by 2002:a62:cf04:0:b0:6e4:625a:f03 with SMTP id b4-20020a62cf04000000b006e4625a0f03mr4201315pfg.15.1708844005820;
        Sat, 24 Feb 2024 22:53:25 -0800 (PST)
Received: from localhost.localdomain ([171.218.176.26])
        by smtp.gmail.com with ESMTPSA id p18-20020a056a0026d200b006e45b910a98sm1930313pfw.6.2024.02.24.22.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 22:53:25 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Yang Xiwen <forbidden405@outlook.com>,
	David Yang <mmyangfl@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 03/13] clk: hisilicon: hi3798cv200: Use helper functions
Date: Sun, 25 Feb 2024 14:52:18 +0800
Message-ID: <20240225065234.413687-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240225065234.413687-1-mmyangfl@gmail.com>
References: <20240225065234.413687-1-mmyangfl@gmail.com>
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


