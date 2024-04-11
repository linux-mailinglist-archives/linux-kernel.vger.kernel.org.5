Return-Path: <linux-kernel+bounces-139928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFF18A0937
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162F7283D92
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA1E13E3F8;
	Thu, 11 Apr 2024 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuXiFVdQ"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A4A1422DC;
	Thu, 11 Apr 2024 07:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819226; cv=none; b=VYznlGFSMKWkYSKUgd1jcHtuM4DgtAT5plL5Jl42WAyywaHWdWKKY1LTyCvY8QDVjvyi6xkHjq7prWrDJYeBkdInngCROQFcEe52MDsM1yl5eiDPZLcjN3OEFVL6RUUP5zE7T+ZNNfKQNR6kxiYjyooYCtksk0Bv+400fMk07MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819226; c=relaxed/simple;
	bh=4hA8+z3f2ldZmeSXUpUNrydWtdec93hvgrr/De9O8Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iybGDv8TyVi0AiwZckhBrmJDo4j4bVAsWhgD3etKqcrtljKgmfI1w1aHrzAlZSKPB88DWJyrgp3h6CoKTSfKtQTWk3/tLk+tF6T9bTe1TKFpw/m5sh88+RXJP4puzQofDD39fnvywgldWF9796f7Ic9FtcPwyfrUUr9F2LBgRhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuXiFVdQ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so5521170b3a.0;
        Thu, 11 Apr 2024 00:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712819223; x=1713424023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzYAusLgHA5dg3wxY39f8O7jqiLmZIOTBnC6DEHE96c=;
        b=SuXiFVdQcQnRpXc3nxm/uj/hdmWtZW2aAsFw3Acb+Lg/IsG8HT1XYRAmDIkmipPYtj
         UrFWZ0VsjN8fWiiYPb4No0eypSeKyFEwZiyi0Hb0/PE5d+OvQnvTakVTlDoi5WbfYkjK
         GbylTzARZGnbC6KzZvZJbkfTnpW1GagIeEZNUm7cE8HwxX9pdvS8SCJ6cgLAClSEu4T0
         vokwmqRAFrLCEdqj+K6JODOiRxliQ2a7TknzaBwa5QZ7tKSCDhzb7Po5dsgnpAUGu8le
         ieSG2Us1I9FSgwMUzSM6IZri1hCXJYuxgSibPgadq1NmzmjQxyS8KZt+QvBFoAY5pvkH
         n7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712819223; x=1713424023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzYAusLgHA5dg3wxY39f8O7jqiLmZIOTBnC6DEHE96c=;
        b=YpOiOgsJCXiChHrDHUErFkeaUVvu6mPsF4rJcxgWGM5hulFvq+GzDq41b45bUpt+Ij
         JvUnTOPMkTC9HG4vtyAG90hEDFQlauJxpbk29PfKae0eyGRIlhHGeWdrJRQ5jW1htUpn
         Npp37VkQnuaumbywk0PC37Z/d5Amv9hZeHLiBpHBvT7BO+Anlb9IwzOlvB7YVGiD2/Sp
         66iS0eumZ2UjbdPv+7jheN2kfOJeXekWsSO0bOQa9UTpTJx9BC7NRIPMDJ3tMv83MQEW
         ynQYSSNa7q93jQcSnG+PYbV7gbm+Peaq1aOXIOO4LvcLn7zhWb7rh/GObHcWoztYIoMs
         DQXg==
X-Forwarded-Encrypted: i=1; AJvYcCXvBAta8GhKYE2Ge1VgZeukX9jZIyDicl0cHziBKbVVjTIwfC6dJIJZo0XStLTteHHzdqzVFrqPp+cnLRGAvb8zUef5eewsSyP8+Lbj
X-Gm-Message-State: AOJu0YyGirqBBJdVpb5BikycVO7uu7WLQEJd2ajc6VjWYpgbTuwA6B3E
	n+6wL6ftgckDd9z3E5VbvttKlc168sWBZU3LcQi7njP+vlELx+dz9IXfwFV5
X-Google-Smtp-Source: AGHT+IFO1dGnx0tkxicMzAjdfAOkTtkeWfvjhICb+fwD5cVkvUIVPkHCUVzbv2DNY0+Nl4jks+RmWQ==
X-Received: by 2002:a05:6a21:1f09:b0:1a9:7f1b:e3f7 with SMTP id ry9-20020a056a211f0900b001a97f1be3f7mr1062749pzb.50.1712819223626;
        Thu, 11 Apr 2024 00:07:03 -0700 (PDT)
Received: from d.wok.cipunited.com ([104.28.213.200])
        by smtp.gmail.com with ESMTPSA id g5-20020a056a0023c500b006e6be006637sm647402pfc.135.2024.04.11.00.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 00:07:03 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH v8 12/13] clk: hisilicon: hix5hd2: Convert into platform driver module
Date: Thu, 11 Apr 2024 15:04:57 +0800
Message-ID: <20240411070503.38093-14-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/clk-hix5hd2.c | 85 ++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hix5hd2.c b/drivers/clk/hisilicon/clk-hix5hd2.c
index 64bdd3f05725..0a3f1320d0d5 100644
--- a/drivers/clk/hisilicon/clk-hix5hd2.c
+++ b/drivers/clk/hisilicon/clk-hix5hd2.c
@@ -4,13 +4,17 @@
  * Copyright (c) 2014 Hisilicon Limited.
  */
 
-#include <linux/of_address.h>
 #include <dt-bindings/clock/hix5hd2-clock.h>
+
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+
 #include "clk.h"
 
-static struct hisi_fixed_rate_clock hix5hd2_fixed_rate_clks[] __initdata = {
+static struct hisi_fixed_rate_clock hix5hd2_fixed_rate_clks[] = {
 	{ HIX5HD2_FIXED_1200M, "1200m", NULL, 0, 1200000000, },
 	{ HIX5HD2_FIXED_400M, "400m", NULL, 0, 400000000, },
 	{ HIX5HD2_FIXED_48M, "48m", NULL, 0, 48000000, },
@@ -43,19 +47,19 @@ static struct hisi_fixed_rate_clock hix5hd2_fixed_rate_clks[] __initdata = {
 	{ HIX5HD2_FIXED_83M, "83m", NULL, 0, 83333333, },
 };
 
-static const char *const sfc_mux_p[] __initconst = {
+static const char *const sfc_mux_p[] = {
 		"24m", "150m", "200m", "100m", "75m", };
 static u32 sfc_mux_table[] = {0, 4, 5, 6, 7};
 
-static const char *const sdio_mux_p[] __initconst = {
+static const char *const sdio_mux_p[] = {
 		"75m", "100m", "50m", "15m", };
 static u32 sdio_mux_table[] = {0, 1, 2, 3};
 
-static const char *const fephy_mux_p[] __initconst = { "25m", "125m"};
+static const char *const fephy_mux_p[] = { "25m", "125m"};
 static u32 fephy_mux_table[] = {0, 1};
 
 
-static struct hisi_mux_clock hix5hd2_mux_clks[] __initdata = {
+static struct hisi_mux_clock hix5hd2_mux_clks[] = {
 	{ HIX5HD2_SFC_MUX, "sfc_mux", sfc_mux_p, ARRAY_SIZE(sfc_mux_p),
 		CLK_SET_RATE_PARENT, 0x5c, 8, 3, 0, sfc_mux_table, },
 	{ HIX5HD2_MMC_MUX, "mmc_mux", sdio_mux_p, ARRAY_SIZE(sdio_mux_p),
@@ -67,7 +71,7 @@ static struct hisi_mux_clock hix5hd2_mux_clks[] __initdata = {
 		CLK_SET_RATE_PARENT, 0x120, 8, 2, 0, fephy_mux_table, },
 };
 
-static struct hisi_gate_clock hix5hd2_gate_clks[] __initdata = {
+static struct hisi_gate_clock hix5hd2_gate_clks[] = {
 	/* sfc */
 	{ HIX5HD2_SFC_CLK, "clk_sfc", "sfc_mux",
 		CLK_SET_RATE_PARENT, 0x5c, 0, 0, },
@@ -153,7 +157,7 @@ struct hix5hd2_clk_complex {
 	u32		phy_rst_mask;
 };
 
-static struct hix5hd2_complex_clock hix5hd2_complex_clks[] __initdata = {
+static struct hix5hd2_complex_clock hix5hd2_complex_clks[] = {
 	{"clk_mac0", "clk_fephy", HIX5HD2_MAC0_CLK,
 		0xcc, 0xa, 0x500, 0x120, 0, 0x10, TYPE_ETHER},
 	{"clk_mac1", "clk_fwd_sys", HIX5HD2_MAC1_CLK,
@@ -249,21 +253,22 @@ static const struct clk_ops clk_complex_ops = {
 	.disable = clk_complex_disable,
 };
 
-static void __init
-hix5hd2_clk_register_complex(struct hix5hd2_complex_clock *clks, int nums,
+static int
+hix5hd2_clk_register_complex(struct device *dev, const void *clocks, size_t num,
 			     struct hisi_clock_data *data)
 {
+	const struct hix5hd2_complex_clock *clks = clocks;
 	void __iomem *base = data->base;
 	int i;
 
-	for (i = 0; i < nums; i++) {
+	for (i = 0; i < num; i++) {
 		struct hix5hd2_clk_complex *p_clk;
 		struct clk *clk;
 		struct clk_init_data init;
 
 		p_clk = kzalloc(sizeof(*p_clk), GFP_KERNEL);
 		if (!p_clk)
-			return;
+			return -ENOMEM;
 
 		init.name = clks[i].name;
 		if (clks[i].type == TYPE_ETHER)
@@ -289,31 +294,45 @@ hix5hd2_clk_register_complex(struct hix5hd2_complex_clock *clks, int nums,
 			kfree(p_clk);
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
-			continue;
+			return PTR_ERR(p_clk);
 		}
 
 		data->clk_data.clks[clks[i].id] = clk;
 	}
-}
 
-static void __init hix5hd2_clk_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-
-	clk_data = hisi_clk_init(np, HIX5HD2_NR_CLKS);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_fixed_rate(hix5hd2_fixed_rate_clks,
-				     ARRAY_SIZE(hix5hd2_fixed_rate_clks),
-				     clk_data);
-	hisi_clk_register_mux(hix5hd2_mux_clks, ARRAY_SIZE(hix5hd2_mux_clks),
-					clk_data);
-	hisi_clk_register_gate(hix5hd2_gate_clks,
-			ARRAY_SIZE(hix5hd2_gate_clks), clk_data);
-	hix5hd2_clk_register_complex(hix5hd2_complex_clks,
-				     ARRAY_SIZE(hix5hd2_complex_clks),
-				     clk_data);
+	return 0;
 }
 
-CLK_OF_DECLARE(hix5hd2_clk, "hisilicon,hix5hd2-clock", hix5hd2_clk_init);
+static const struct hisi_clocks hix5hd2_clks = {
+	.nr = HIX5HD2_NR_CLKS,
+	.fixed_rate_clks = hix5hd2_fixed_rate_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hix5hd2_fixed_rate_clks),
+	.mux_clks = hix5hd2_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hix5hd2_mux_clks),
+	.gate_clks = hix5hd2_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hix5hd2_gate_clks),
+	.customized_clks = hix5hd2_complex_clks,
+	.customized_clks_num = ARRAY_SIZE(hix5hd2_complex_clks),
+	.clk_register_customized = hix5hd2_clk_register_complex,
+};
+
+static const struct of_device_id hix5hd2_clk_match_table[] = {
+	{ .compatible = "hisilicon,hix5hd2-clock",
+	  .data = &hix5hd2_clks },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hix5hd2_clk_match_table);
+
+static struct platform_driver hix5hd2_clk_driver = {
+	.probe = hisi_clk_probe,
+	.remove_new = hisi_clk_remove,
+	.driver		= {
+		.name	= "hix5hd2-clock",
+		.of_match_table = hix5hd2_clk_match_table,
+	},
+};
+
+module_platform_driver(hix5hd2_clk_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("HiSilicon Hix5hd2 Clock Driver");
-- 
2.43.0


