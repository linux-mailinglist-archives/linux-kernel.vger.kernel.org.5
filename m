Return-Path: <linux-kernel+bounces-139924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BC28A092F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B39283A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C54013DDC6;
	Thu, 11 Apr 2024 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvloTbba"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AF113FD72;
	Thu, 11 Apr 2024 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819209; cv=none; b=WiKOkltBQS7PfIYNc413EkLBLnijkiXkapjfFxF0/w4OoojpdPKU31YPgSgQqpxG4cmuMF7Y6e6Gk60jjAr3aGS69AhwWLsbt95op+K2h+XiFYcNfd2g1Zysea933/7Neuh3IGVSHoUagJpSrgYAz6ASUU1ErB6krDccXtWqNv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819209; c=relaxed/simple;
	bh=pk6yWl/RNdZzOeycoEC/b30bS65iojlOAy7XjiYgCzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imJIpY5J4kr7oPkxbNDtQL0JKeYQMuUO+7JlvuxoeXMYGDEN6SUoAJNYofjjgffNE+7psfENCfK9wiUAgOlkcG9kylJQxRs2023fVG+SR1G/pv0NWutXzJVocBUf3IkHwYnjI3sSl1EOg3Th2ta8aEcEFrpVYcMjnAb8B5g0rao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvloTbba; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d8b519e438so5821282a12.1;
        Thu, 11 Apr 2024 00:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712819206; x=1713424006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JN8cCX+UgxQKSAyjiVn+CX8QDt1QPDveAfP0mG3Jhlw=;
        b=SvloTbbaJT9c0fJMOgEIsrKxvD8R+oVUlizHW6dfZL2D2R040wlEbInxF/YSyjd/uj
         srZVWhP+G5kZz0jRx5zdtadvWi5fY839vqJyBr3V2VRp0QfldPNDYAhqGFVvnE/owzyK
         d6wnNYDDSWVexgVk+KJje/zErCjRrf3UbvR1G+IJKl+Xc64xCJZMNUg0wuQSD91t26ep
         5hYCeZXN/Jy4nOSICahweTwlxda1RCTw8/HvYpxdtctnFiZVPNWe+xNVm4CAOlesqpOZ
         0ZUKZJ4LshMsnoykYsNr60xJECqkrN1T0DlERRHAtqeVAVfzfxLlIrilvoQKoqqFuFsf
         lqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712819206; x=1713424006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JN8cCX+UgxQKSAyjiVn+CX8QDt1QPDveAfP0mG3Jhlw=;
        b=LGhwAvWBIIZZ5mgt51WlgubWPEV6BOI3IdJhApiwGq2pil0EEsjfytrq+2tUuqcqDe
         ezykHfbjB750rGSBjfD/H7FNyZy+d8v0eE8/945MTNc99kVfgENu9nZBLpjytZOp+QBZ
         lC4h7W5mo/qkLFE/ygMKpxkCAffOqaZoqO9+JM/qGZTiHAPThF9tlWTvmLK8v/GyyMgJ
         JoG9p8Ep1k1mxCfm3+kVHTsA0oy7UiyafombfE+r6loPLx6OmjGjcIf3NQCWWSsjy1jd
         4ShRvbkDF/AvhvQRdgrIL1UiO8iOnV38/XbRtDsjTBvyB0TXVRCDpua8pn9hJUtTExom
         b/FA==
X-Forwarded-Encrypted: i=1; AJvYcCVnmRIsj6G9XD/dvG+H2jqfBSIfPKNImzxXRZcLS2IVl4SWPmbcDtlbRk3rFcASvneHstgXtPs6TJgvqXBVm94fAEVjgx0bXR2YASaE
X-Gm-Message-State: AOJu0YzvJAglrYqLcbVhkVTJShHeV1iLYRnL563kWMY/kgR/kwzfwqzp
	B0EXRUl02mdKMbBWBGpb7pkHaTDE1ieFymdDimC0DQZRMdWOmMzS9rAfODve
X-Google-Smtp-Source: AGHT+IE8wGLGIU1MJG2+4xUoXaBzJOj/pLkyxU4COwoxwQKAwi+BivasDNwvYUZPkIrl7h832Qexeg==
X-Received: by 2002:a05:6a21:8805:b0:1a9:11e6:a0ad with SMTP id ta5-20020a056a21880500b001a911e6a0admr6004398pzc.38.1712819206466;
        Thu, 11 Apr 2024 00:06:46 -0700 (PDT)
Received: from d.wok.cipunited.com ([104.28.213.200])
        by smtp.gmail.com with ESMTPSA id g5-20020a056a0023c500b006e6be006637sm647402pfc.135.2024.04.11.00.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 00:06:46 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH v8 08/13] clk: hisilicon: hi3670: Convert into module
Date: Thu, 11 Apr 2024 15:04:53 +0800
Message-ID: <20240411070503.38093-10-mmyangfl@gmail.com>
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


