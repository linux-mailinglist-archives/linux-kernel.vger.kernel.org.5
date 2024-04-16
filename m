Return-Path: <linux-kernel+bounces-146594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 563478A67B4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD500B22F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22E41272B7;
	Tue, 16 Apr 2024 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqf/wXgY"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D21A1272AF;
	Tue, 16 Apr 2024 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261925; cv=none; b=Ve+PcRxgWlHSjOsWB5TunX6et0WR7yYUYQXEDQZ2joAe5heLLEKNBmO5hT8fI31WKkuT8ovqbZp9lQ+7v6C2E1JdVFbpCdVEJdTMCEZnUEuItMCTTfHIgv7cGgrMsB3Z/TyShg98+u20M9TVaMG49AvEuyk/sNE6QkxxkfNjzgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261925; c=relaxed/simple;
	bh=pk6yWl/RNdZzOeycoEC/b30bS65iojlOAy7XjiYgCzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwKzp/Pq+BL0/JFnnsY7F13Wfz1ThxxukIhks8+THKtnmhkuXdvHxhO6Z+bA8/f9Ng+A28SpZ/hUCZJHcsgN0dk+04nCPBzbHNHivUR458hNsdRTvT2X9JJmQD8eC5CiD7BpXODAVqrWkYtvDg93V9IdW2DEdpHS1O0kxTL+jVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqf/wXgY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ece8991654so3768882b3a.3;
        Tue, 16 Apr 2024 03:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713261922; x=1713866722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JN8cCX+UgxQKSAyjiVn+CX8QDt1QPDveAfP0mG3Jhlw=;
        b=mqf/wXgYTZxSrWztC3gu141lraZjGKFzFKqlsuEDD6rS2BjUlOR8x2y8PVDWNR4rY8
         X6Ya4s1NNmCoItmgqbo5yF5nIS3h589z3QXYhkoYls5J/+hVpwUPt8CH5pWIDP8A0PJg
         /a943aKJ3N2oB0n15mT2TT4e6Fk5T3JGX/xNfPi/iI669uJ/ARlN8EJI0IJ22pdb0Yq5
         LOOGi8sgOHDVhPc3RGFcHupTSqeIvX7kZhQS3kkk07FCriBJvw1HtQHZ75DIwonqL0Xf
         MBihchtecxZ7iPkJe2xhwjSWC4Pv7aPqdx+1LLMzGAAeznPfaMC3oi0HS+xOSfcqOuXK
         N6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261922; x=1713866722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JN8cCX+UgxQKSAyjiVn+CX8QDt1QPDveAfP0mG3Jhlw=;
        b=KcRYKl84GdUgokylqUk1WvI/o5Ae1KGi0URyVMTw5DKUBcvlveD8wDpDmpYf/W+3g7
         KSWtbosVj18dkgpQShgPlqKxg7IgEeH72HsORnn9gJ4CbUYl384PcSSWN/boHj5TXGCu
         hp23io0jb5ilG8RP4RwjDvudWZnaDAb6j1lSIKRW3sLth11SPuXM1lQfwcs90egrQqIh
         mgu4UeI7NsWKWaGP2Y0ctZjrE0gPFeaDXXSPHovm43pLym32hqXcTJwfiD6z45RPJYFc
         RXEGdrg98MaWTgUdyXDKh406io/QK/2RTKecfrNi/p+ugIWhoLHEVLuGq5IGw9/IQ2NY
         EdnA==
X-Forwarded-Encrypted: i=1; AJvYcCWH81krcwNLfR7KMHd1/piutVhynEUc7ScHSsMIX93CAmuLiVvt5wGLHPsQ9UI72EFTDRseNCV7/zbdeXVTa6cws7hvoCkQbUPHLVMD
X-Gm-Message-State: AOJu0YzCkxswyJx1uIxuKgQ+Zj4HG7roWLjEHYavRWlbxLwHXIIk3tzC
	53l6gBfAaUbbh9olYnZPw7FvUBNd19gvV1sGPtLANUa/bBe1TaVA9fofL2Xl
X-Google-Smtp-Source: AGHT+IEt8jl3IX8kYWpEM5gQKmxGm6x6m0d7VWuJrmqmgUPSxa4deme6SPWzMd64UPZN3tcj2NZZMA==
X-Received: by 2002:a05:6a21:2b13:b0:1a9:11e4:72b6 with SMTP id ss19-20020a056a212b1300b001a911e472b6mr14733863pzb.57.1713261922528;
        Tue, 16 Apr 2024 03:05:22 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090322c400b001e0b287c1d2sm9353651plg.215.2024.04.16.03.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:05:22 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH v10 08/13] clk: hisilicon: hi3670: Convert into module
Date: Tue, 16 Apr 2024 18:03:42 +0800
Message-ID: <20240416100347.395295-9-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416100347.395295-1-mmyangfl@gmail.com>
References: <20240416100347.395295-1-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/clk-hi3670.c | 250 +++++++++--------------------
 1 file changed, 76 insertions(+), 174 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3670.c b/drivers/clk/hisilicon/clk-hi3670.c
index fa20ad144c8e..b6005be71290 100644
--- a/drivers/clk/hisilicon/clk-hi3670.c
+++ b/drivers/clk/hisilicon/clk-hi3670.c
@@ -9,8 +9,11 @@
 
 #include <dt-bindings/clock/hi3670-clock.h>
 #include <linux/clk-provider.h>
-#include <linux/of.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+
 #include "clk.h"
 
 static const struct hisi_fixed_rate_clock hi3670_fixed_rate_clks[] = {
@@ -822,195 +825,94 @@ static const struct hisi_gate_clock hi3670_media2_gate_sep_clks[] = {
 	  CLK_SET_RATE_PARENT, 0x00, 2, 0, },
 };
 
-static void hi3670_clk_crgctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-
-	int nr = ARRAY_SIZE(hi3670_fixed_rate_clks) +
-		 ARRAY_SIZE(hi3670_crgctrl_gate_sep_clks) +
-		 ARRAY_SIZE(hi3670_crgctrl_gate_clks) +
-		 ARRAY_SIZE(hi3670_crgctrl_mux_clks) +
-		 ARRAY_SIZE(hi3670_crg_fixed_factor_clks) +
-		 ARRAY_SIZE(hi3670_crgctrl_divider_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_fixed_rate(hi3670_fixed_rate_clks,
-				     ARRAY_SIZE(hi3670_fixed_rate_clks),
-				     clk_data);
-	hisi_clk_register_gate_sep(hi3670_crgctrl_gate_sep_clks,
-				   ARRAY_SIZE(hi3670_crgctrl_gate_sep_clks),
-				   clk_data);
-	hisi_clk_register_gate(hi3670_crgctrl_gate_clks,
-			       ARRAY_SIZE(hi3670_crgctrl_gate_clks),
-			       clk_data);
-	hisi_clk_register_mux(hi3670_crgctrl_mux_clks,
-			      ARRAY_SIZE(hi3670_crgctrl_mux_clks),
-			      clk_data);
-	hisi_clk_register_fixed_factor(hi3670_crg_fixed_factor_clks,
-				       ARRAY_SIZE(hi3670_crg_fixed_factor_clks),
-				       clk_data);
-	hisi_clk_register_divider(hi3670_crgctrl_divider_clks,
-				  ARRAY_SIZE(hi3670_crgctrl_divider_clks),
-				  clk_data);
-}
-
-static void hi3670_clk_pctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3670_pctrl_gate_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-	hisi_clk_register_gate(hi3670_pctrl_gate_clks,
-			       ARRAY_SIZE(hi3670_pctrl_gate_clks), clk_data);
-}
-
-static void hi3670_clk_pmuctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3670_pmu_gate_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate(hi3670_pmu_gate_clks,
-			       ARRAY_SIZE(hi3670_pmu_gate_clks), clk_data);
-}
-
-static void hi3670_clk_sctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3670_sctrl_gate_sep_clks) +
-		 ARRAY_SIZE(hi3670_sctrl_gate_clks) +
-		 ARRAY_SIZE(hi3670_sctrl_mux_clks) +
-		 ARRAY_SIZE(hi3670_sctrl_divider_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate_sep(hi3670_sctrl_gate_sep_clks,
-				   ARRAY_SIZE(hi3670_sctrl_gate_sep_clks),
-				   clk_data);
-	hisi_clk_register_gate(hi3670_sctrl_gate_clks,
-			       ARRAY_SIZE(hi3670_sctrl_gate_clks),
-			       clk_data);
-	hisi_clk_register_mux(hi3670_sctrl_mux_clks,
-			      ARRAY_SIZE(hi3670_sctrl_mux_clks),
-			      clk_data);
-	hisi_clk_register_divider(hi3670_sctrl_divider_clks,
-				  ARRAY_SIZE(hi3670_sctrl_divider_clks),
-				  clk_data);
-}
-
-static void hi3670_clk_iomcu_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3670_iomcu_gate_sep_clks) +
-			ARRAY_SIZE(hi3670_iomcu_fixed_factor_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate(hi3670_iomcu_gate_sep_clks,
-			       ARRAY_SIZE(hi3670_iomcu_gate_sep_clks), clk_data);
-
-	hisi_clk_register_fixed_factor(hi3670_iomcu_fixed_factor_clks,
-				       ARRAY_SIZE(hi3670_iomcu_fixed_factor_clks),
-				       clk_data);
-}
-
-static void hi3670_clk_media1_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-
-	int nr = ARRAY_SIZE(hi3670_media1_gate_sep_clks) +
-		 ARRAY_SIZE(hi3670_media1_gate_clks) +
-		 ARRAY_SIZE(hi3670_media1_mux_clks) +
-		 ARRAY_SIZE(hi3670_media1_divider_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate_sep(hi3670_media1_gate_sep_clks,
-				   ARRAY_SIZE(hi3670_media1_gate_sep_clks),
-				   clk_data);
-	hisi_clk_register_gate(hi3670_media1_gate_clks,
-			       ARRAY_SIZE(hi3670_media1_gate_clks),
-			       clk_data);
-	hisi_clk_register_mux(hi3670_media1_mux_clks,
-			      ARRAY_SIZE(hi3670_media1_mux_clks),
-			      clk_data);
-	hisi_clk_register_divider(hi3670_media1_divider_clks,
-				  ARRAY_SIZE(hi3670_media1_divider_clks),
-				  clk_data);
-}
-
-static void hi3670_clk_media2_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-
-	int nr = ARRAY_SIZE(hi3670_media2_gate_sep_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate_sep(hi3670_media2_gate_sep_clks,
-				   ARRAY_SIZE(hi3670_media2_gate_sep_clks),
-				   clk_data);
-}
+static const struct hisi_clocks hi3670_clk_crgctrl_clks = {
+	.fixed_rate_clks = hi3670_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3670_fixed_rate_clks),
+	.fixed_factor_clks = hi3670_crg_fixed_factor_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hi3670_crg_fixed_factor_clks),
+	.mux_clks = hi3670_crgctrl_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3670_crgctrl_mux_clks),
+	.divider_clks = hi3670_crgctrl_divider_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3670_crgctrl_divider_clks),
+	.gate_clks = hi3670_crgctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3670_crgctrl_gate_clks),
+	.gate_sep_clks = hi3670_crgctrl_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3670_crgctrl_gate_sep_clks),
+};
+
+static const struct hisi_clocks hi3670_clk_pctrl_clks = {
+	.gate_clks = hi3670_pctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3670_pctrl_gate_clks),
+};
+
+static const struct hisi_clocks hi3670_clk_pmuctrl_clks = {
+	.gate_clks = hi3670_pmu_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3670_pmu_gate_clks),
+};
+
+static const struct hisi_clocks hi3670_clk_sctrl_clks = {
+	.mux_clks = hi3670_sctrl_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3670_sctrl_mux_clks),
+	.divider_clks = hi3670_sctrl_divider_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3670_sctrl_divider_clks),
+	.gate_clks = hi3670_sctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3670_sctrl_gate_clks),
+	.gate_sep_clks = hi3670_sctrl_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3670_sctrl_gate_sep_clks),
+};
+
+static const struct hisi_clocks hi3670_clk_iomcu_clks = {
+	.fixed_factor_clks = hi3670_iomcu_fixed_factor_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hi3670_iomcu_fixed_factor_clks),
+	.gate_clks = hi3670_iomcu_gate_sep_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3670_iomcu_gate_sep_clks),
+};
+
+static const struct hisi_clocks hi3670_clk_media1_clks = {
+	.mux_clks = hi3670_media1_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3670_media1_mux_clks),
+	.divider_clks = hi3670_media1_divider_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3670_media1_divider_clks),
+	.gate_clks = hi3670_media1_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3670_media1_gate_clks),
+	.gate_sep_clks = hi3670_media1_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3670_media1_gate_sep_clks),
+};
+
+static const struct hisi_clocks hi3670_clk_media2_clks = {
+	.gate_sep_clks = hi3670_media2_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3670_media2_gate_sep_clks),
+};
 
 static const struct of_device_id hi3670_clk_match_table[] = {
 	{ .compatible = "hisilicon,hi3670-crgctrl",
-	  .data = hi3670_clk_crgctrl_init },
+	  .data = &hi3670_clk_crgctrl_clks },
 	{ .compatible = "hisilicon,hi3670-pctrl",
-	  .data = hi3670_clk_pctrl_init },
+	  .data = &hi3670_clk_pctrl_clks },
 	{ .compatible = "hisilicon,hi3670-pmuctrl",
-	  .data = hi3670_clk_pmuctrl_init },
+	  .data = &hi3670_clk_pmuctrl_clks },
 	{ .compatible = "hisilicon,hi3670-sctrl",
-	  .data = hi3670_clk_sctrl_init },
+	  .data = &hi3670_clk_sctrl_clks },
 	{ .compatible = "hisilicon,hi3670-iomcu",
-	  .data = hi3670_clk_iomcu_init },
+	  .data = &hi3670_clk_iomcu_clks },
 	{ .compatible = "hisilicon,hi3670-media1-crg",
-	  .data = hi3670_clk_media1_init },
+	  .data = &hi3670_clk_media1_clks },
 	{ .compatible = "hisilicon,hi3670-media2-crg",
-	  .data = hi3670_clk_media2_init },
+	  .data = &hi3670_clk_media2_clks },
 	{ }
 };
-
-static int hi3670_clk_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *np = pdev->dev.of_node;
-	void (*init_func)(struct device_node *np);
-
-	init_func = of_device_get_match_data(dev);
-	if (!init_func)
-		return -ENODEV;
-
-	init_func(np);
-
-	return 0;
-}
+MODULE_DEVICE_TABLE(of, hi3670_clk_match_table);
 
 static struct platform_driver hi3670_clk_driver = {
-	.probe          = hi3670_clk_probe,
+	.probe = hisi_clk_probe,
+	.remove_new = hisi_clk_remove,
 	.driver         = {
 		.name   = "hi3670-clk",
 		.of_match_table = hi3670_clk_match_table,
 	},
 };
 
-static int __init hi3670_clk_init(void)
-{
-	return platform_driver_register(&hi3670_clk_driver);
-}
-core_initcall(hi3670_clk_init);
+module_platform_driver(hi3670_clk_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("HiSilicon Hi3670 Clock Driver");
-- 
2.43.0


