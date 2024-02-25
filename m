Return-Path: <linux-kernel+bounces-80004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB554862989
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 07:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E179EB21048
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 06:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D5C1401F;
	Sun, 25 Feb 2024 06:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9/TPD83"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AF514006;
	Sun, 25 Feb 2024 06:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708844030; cv=none; b=T/EdYMUnTFEa/4bgz/bdW3RHGNIAvanf26vcggU1vzBPGth82bNUmbNWHE9fWONBO7F7fPCVC/krcZb/fGT95uVpGXsjo8niszNMRCoO5Uz7fLjKFk8ZgOHLfwrdeAqeOpsran8Y/sNaJVoZHazaSbTwZqM7SOKKxmRdgFTF/xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708844030; c=relaxed/simple;
	bh=pk6yWl/RNdZzOeycoEC/b30bS65iojlOAy7XjiYgCzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t90gHqcyWTepuLurH+ynJrqby6oQzJOtjE8qlooOM4DvuTzo7113INADkFOOr+WoUeEN6635xry2hoaLDvlzCa9pjVy3xBqV1sP0OKcIaMTa+ft94MZdPE7bmCFdEB8yGnj3k9zW/yrDMxJfptpDLNCWcp2zMcfgYX/o8Wczcqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9/TPD83; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so1886125b3a.0;
        Sat, 24 Feb 2024 22:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708844027; x=1709448827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JN8cCX+UgxQKSAyjiVn+CX8QDt1QPDveAfP0mG3Jhlw=;
        b=Y9/TPD83RG4Kr4WcC6OEhjJEA3nKuNluhOzbkNQRfON3I3GEtk/dG8jX70lgUR9KuD
         iByTjhhJ2mQ9CxYnHQEwBgQowYBGW/s491cKmqo+1lQBzFekZziMpgYdJYdf8Jr3EZvG
         XLVuiL8J9h124KHFjRGvRNx8KKLP2O8VWjbAXi35JPloiNHiCbubzkSle5zd9yHPG5me
         K/w2C4VbC36AbHxGm4KvHisTaSOtCtbwB3E+Te/EuAV8LCEFU1fsWGdKjt6BZjsKCL+6
         4euU9gqUCVf64LAPtuFA4haD30V9IywQuoBl0O8nn07HhY+GuPxifElD2JPeWMmyHSQs
         ZmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708844027; x=1709448827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JN8cCX+UgxQKSAyjiVn+CX8QDt1QPDveAfP0mG3Jhlw=;
        b=Hf6IlBuW9a4osXahsAkwijkRgrvuU0Erew703a4nCCxHtKQvfsBHIMAF+3XJyK9cjP
         CAvgHkd3KO2hfrCGoL7sADhgmniSVL5w94nGpFZtvxp9wZQNDIm4vDdbXkVJ8Fj92gXv
         K2eKori1WO/bI1e/+JF7ejbMLS1TSkYtrz01WUmj3R6POrZREowcJ7p386K3po2UuOmr
         /lT3/pMkx6e/gOrn+UG4zfHztNg8tpHZkqzC444lyipMIu5LpV52eVlxLVg9PicIC8Fr
         rjfi2LZVeBAzD3IpNhNLvN/KWdbg8fsi4n8XrAy0jG3FKFV0EadBX2mqCpjcRvvz2hg9
         S7iA==
X-Forwarded-Encrypted: i=1; AJvYcCXnyZFDBnnzz0MWuJTgdyY5+sMwSr4frfCMZHNgTFI+JHlwqa5U75t1iFd20tQR3T/fzvZ0QFIfYDzTOdtFB0DXQY5CTFX+9SE5glVH
X-Gm-Message-State: AOJu0YzHcwtnOszHnhssFgJAjFV6pobvoEbWPW0ytTwXnlchM+RgKiHa
	k9NW5Y6/jULjJiAIVELiW2cKehq/kKqqtAyo7se7UIFfo8CRnJ6qd3AS1RDkrCvhzg==
X-Google-Smtp-Source: AGHT+IEISK8M66rySYh1NK5SU5jfdHDBYmVb9tTjbuPrsYcVv8FUiVP9YiQktBOtFg4FMFNoogrnXw==
X-Received: by 2002:a05:6a00:1d1d:b0:6e5:90:acd9 with SMTP id a29-20020a056a001d1d00b006e50090acd9mr2903421pfx.7.1708844027640;
        Sat, 24 Feb 2024 22:53:47 -0800 (PST)
Received: from localhost.localdomain ([171.218.176.26])
        by smtp.gmail.com with ESMTPSA id p18-20020a056a0026d200b006e45b910a98sm1930313pfw.6.2024.02.24.22.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 22:53:47 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Yang Xiwen <forbidden405@outlook.com>,
	David Yang <mmyangfl@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 08/13] clk: hisilicon: hi3670: Convert into module
Date: Sun, 25 Feb 2024 14:52:23 +0800
Message-ID: <20240225065234.413687-9-mmyangfl@gmail.com>
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


