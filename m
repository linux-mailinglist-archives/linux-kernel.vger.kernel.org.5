Return-Path: <linux-kernel+bounces-80005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 368D286298B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 07:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6D03B219DB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 06:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30853F9EA;
	Sun, 25 Feb 2024 06:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ke3bplO7"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D98514A81;
	Sun, 25 Feb 2024 06:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708844035; cv=none; b=LWsnLDg93K2L5S4N+zvvEZI4LHkNr/0mV8oIfmkX+A+YwXOxTVAEypPajzKSrEJOPcjjOU0UhkXoEOhj9vJ7ZlGc+GVRr3UFLVlZ6EaFQwzQhA875Y44jrbJkNsb4+zJpkVg+s0PZsfaQNK3ZT+A11rVEzxG5gM1vVBPqOKTWgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708844035; c=relaxed/simple;
	bh=JSqvGeRsBb75ZTjqhVvWEcNKN1Q/ASsQY9j3OSmgGIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A96Db2gvZx85hEdmcJqqfooDN3v1F4ujIvBDH4yfdN+amsJRHnrjtceBHquIdYn5VdAwi0XULEtiw31HxpylFerAZAGMLw3HRRkHXGZYSYoJ5vHXTNvHe6tnf/c4T64xzwu//diZq9em6JJapwpgLVhy0cDgj9yVoavHq9nQmPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ke3bplO7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so1886135b3a.0;
        Sat, 24 Feb 2024 22:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708844032; x=1709448832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBwFTB23QYK27eowOhLn23rF4sWQalYXU3BNGKcydTk=;
        b=ke3bplO7T/wUclZOAqMkLzgdWKiyGak+LzXwd7YbEWZ2xJSo/fnxRTuUUfTE+UWP+T
         26I0J0ftF9ahJPvf1oegnqzCmb7B00RmN9xhOiWkAoSJqIU4fO6KiwQc7xfgKJkjRBbC
         faAFGms0F9D7m+C7mR19x+9NrX1IwKLvI297LXRMDyHVaXt2bKFSiOWH46f9oF/Ng2Un
         rw3ZIvm77v+r3CXvN9NBjy+9rB5iIXGANm+823nyTMlU0UC6hjPvOgdGkZTaP6H+N2FP
         +EU9rfkWlc4NztNUGfaecFppHOWmV8pCJxHN1slKKOR7Fcg/XwOPPzMo6TduhbNLcY/E
         uEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708844032; x=1709448832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBwFTB23QYK27eowOhLn23rF4sWQalYXU3BNGKcydTk=;
        b=dtRpj4IBqENRjffhaWk6Vf/dWKVGGXtJmAzfr5p5+PLs7s6DhOPt66s0GU9hn9K/Uu
         UwOXzY+vzaTERBCZs/Q6HXK+398LmUFuOD4ofrvO6RhHwOSSNqbsa1xfVJ+1Tazlc0ig
         BlW0fGDN2SNdLdTBRCTMqcLDlcRDk33kaDoLBTos42O/vQp1r4+j+MJl8/s91XwgIFt5
         ricurBdwIcT+nQOKh1UGDUcvKayjJWAbgxR2jJWU+DoPUmlG5pd3/fukhAB4faG04NeN
         dEgzwrV9e/g5/gxTJHpnZ5at39Tviv1ctjAU5uU00sqHFP8BodJs3QyjAc+APTFaalY5
         LsRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU00io7a9G11UKMPsrT8bxvXxfsURu70AggN9zNYyEnMCz/iHFWD9ELC+tWPxPZn1CdlQpxaSHg+WzchT2EGy+xy73PGXQU3u9Mj27Z
X-Gm-Message-State: AOJu0Yy1VUAvEjRiFIhMA+xCZJCAoYErUHge/t0nIRRcG8M2EjN+w8RM
	CESJ42u4E0LvL2JQwt2WjrupZWfYZUk7qhHAwGVoDxd+arMRHl2qwx4QCqkl3e5daA==
X-Google-Smtp-Source: AGHT+IHqlheyd9a9E6ldvmZxCf007QFILvFKohbDwxewIuUxCaB0hTnLFYvpXUWtfeE1HeiT6AZIcg==
X-Received: by 2002:a05:6a00:1da3:b0:6e4:fc2b:5f6c with SMTP id z35-20020a056a001da300b006e4fc2b5f6cmr3271668pfw.9.1708844032011;
        Sat, 24 Feb 2024 22:53:52 -0800 (PST)
Received: from localhost.localdomain ([171.218.176.26])
        by smtp.gmail.com with ESMTPSA id p18-20020a056a0026d200b006e45b910a98sm1930313pfw.6.2024.02.24.22.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 22:53:51 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Yang Xiwen <forbidden405@outlook.com>,
	David Yang <mmyangfl@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 09/13] clk: hisilicon: hi3620: Convert into platform driver module
Date: Sun, 25 Feb 2024 14:52:24 +0800
Message-ID: <20240225065234.413687-10-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/clk-hi3620.c | 191 +++++++++++++++--------------
 1 file changed, 96 insertions(+), 95 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index 5d0226530fdb..8832cdd6bd57 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
@@ -21,48 +22,48 @@
 #include "clk.h"
 
 /* clock parent list */
-static const char *const timer0_mux_p[] __initconst = { "osc32k", "timerclk01", };
-static const char *const timer1_mux_p[] __initconst = { "osc32k", "timerclk01", };
-static const char *const timer2_mux_p[] __initconst = { "osc32k", "timerclk23", };
-static const char *const timer3_mux_p[] __initconst = { "osc32k", "timerclk23", };
-static const char *const timer4_mux_p[] __initconst = { "osc32k", "timerclk45", };
-static const char *const timer5_mux_p[] __initconst = { "osc32k", "timerclk45", };
-static const char *const timer6_mux_p[] __initconst = { "osc32k", "timerclk67", };
-static const char *const timer7_mux_p[] __initconst = { "osc32k", "timerclk67", };
-static const char *const timer8_mux_p[] __initconst = { "osc32k", "timerclk89", };
-static const char *const timer9_mux_p[] __initconst = { "osc32k", "timerclk89", };
-static const char *const uart0_mux_p[] __initconst = { "osc26m", "pclk", };
-static const char *const uart1_mux_p[] __initconst = { "osc26m", "pclk", };
-static const char *const uart2_mux_p[] __initconst = { "osc26m", "pclk", };
-static const char *const uart3_mux_p[] __initconst = { "osc26m", "pclk", };
-static const char *const uart4_mux_p[] __initconst = { "osc26m", "pclk", };
-static const char *const spi0_mux_p[] __initconst = { "osc26m", "rclk_cfgaxi", };
-static const char *const spi1_mux_p[] __initconst = { "osc26m", "rclk_cfgaxi", };
-static const char *const spi2_mux_p[] __initconst = { "osc26m", "rclk_cfgaxi", };
+static const char *const timer0_mux_p[] = { "osc32k", "timerclk01", };
+static const char *const timer1_mux_p[] = { "osc32k", "timerclk01", };
+static const char *const timer2_mux_p[] = { "osc32k", "timerclk23", };
+static const char *const timer3_mux_p[] = { "osc32k", "timerclk23", };
+static const char *const timer4_mux_p[] = { "osc32k", "timerclk45", };
+static const char *const timer5_mux_p[] = { "osc32k", "timerclk45", };
+static const char *const timer6_mux_p[] = { "osc32k", "timerclk67", };
+static const char *const timer7_mux_p[] = { "osc32k", "timerclk67", };
+static const char *const timer8_mux_p[] = { "osc32k", "timerclk89", };
+static const char *const timer9_mux_p[] = { "osc32k", "timerclk89", };
+static const char *const uart0_mux_p[] = { "osc26m", "pclk", };
+static const char *const uart1_mux_p[] = { "osc26m", "pclk", };
+static const char *const uart2_mux_p[] = { "osc26m", "pclk", };
+static const char *const uart3_mux_p[] = { "osc26m", "pclk", };
+static const char *const uart4_mux_p[] = { "osc26m", "pclk", };
+static const char *const spi0_mux_p[] = { "osc26m", "rclk_cfgaxi", };
+static const char *const spi1_mux_p[] = { "osc26m", "rclk_cfgaxi", };
+static const char *const spi2_mux_p[] = { "osc26m", "rclk_cfgaxi", };
 /* share axi parent */
-static const char *const saxi_mux_p[] __initconst = { "armpll3", "armpll2", };
-static const char *const pwm0_mux_p[] __initconst = { "osc32k", "osc26m", };
-static const char *const pwm1_mux_p[] __initconst = { "osc32k", "osc26m", };
-static const char *const sd_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const mmc1_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const mmc1_mux2_p[] __initconst = { "osc26m", "mmc1_div", };
-static const char *const g2d_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const venc_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const vdec_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const vpp_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const edc0_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const ldi0_mux_p[] __initconst = { "armpll2", "armpll4",
+static const char *const saxi_mux_p[] = { "armpll3", "armpll2", };
+static const char *const pwm0_mux_p[] = { "osc32k", "osc26m", };
+static const char *const pwm1_mux_p[] = { "osc32k", "osc26m", };
+static const char *const sd_mux_p[] = { "armpll2", "armpll3", };
+static const char *const mmc1_mux_p[] = { "armpll2", "armpll3", };
+static const char *const mmc1_mux2_p[] = { "osc26m", "mmc1_div", };
+static const char *const g2d_mux_p[] = { "armpll2", "armpll3", };
+static const char *const venc_mux_p[] = { "armpll2", "armpll3", };
+static const char *const vdec_mux_p[] = { "armpll2", "armpll3", };
+static const char *const vpp_mux_p[] = { "armpll2", "armpll3", };
+static const char *const edc0_mux_p[] = { "armpll2", "armpll3", };
+static const char *const ldi0_mux_p[] = { "armpll2", "armpll4",
 					     "armpll3", "armpll5", };
-static const char *const edc1_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const ldi1_mux_p[] __initconst = { "armpll2", "armpll4",
+static const char *const edc1_mux_p[] = { "armpll2", "armpll3", };
+static const char *const ldi1_mux_p[] = { "armpll2", "armpll4",
 					     "armpll3", "armpll5", };
-static const char *const rclk_hsic_p[] __initconst = { "armpll3", "armpll2", };
-static const char *const mmc2_mux_p[] __initconst = { "armpll2", "armpll3", };
-static const char *const mmc3_mux_p[] __initconst = { "armpll2", "armpll3", };
+static const char *const rclk_hsic_p[] = { "armpll3", "armpll2", };
+static const char *const mmc2_mux_p[] = { "armpll2", "armpll3", };
+static const char *const mmc3_mux_p[] = { "armpll2", "armpll3", };
 
 
 /* fixed rate clocks */
-static struct hisi_fixed_rate_clock hi3620_fixed_rate_clks[] __initdata = {
+static struct hisi_fixed_rate_clock hi3620_fixed_rate_clks[] = {
 	{ HI3620_OSC32K,   "osc32k",   NULL, 0, 32768, },
 	{ HI3620_OSC26M,   "osc26m",   NULL, 0, 26000000, },
 	{ HI3620_PCLK,     "pclk",     NULL, 0, 26000000, },
@@ -75,13 +76,13 @@ static struct hisi_fixed_rate_clock hi3620_fixed_rate_clks[] __initdata = {
 };
 
 /* fixed factor clocks */
-static struct hisi_fixed_factor_clock hi3620_fixed_factor_clks[] __initdata = {
+static struct hisi_fixed_factor_clock hi3620_fixed_factor_clks[] = {
 	{ HI3620_RCLK_TCXO,   "rclk_tcxo",   "osc26m",   1, 4,  0, },
 	{ HI3620_RCLK_CFGAXI, "rclk_cfgaxi", "armpll2",  1, 30, 0, },
 	{ HI3620_RCLK_PICO,   "rclk_pico",   "hsic_div", 1, 40, 0, },
 };
 
-static struct hisi_mux_clock hi3620_mux_clks[] __initdata = {
+static struct hisi_mux_clock hi3620_mux_clks[] = {
 	{ HI3620_TIMER0_MUX, "timer0_mux", timer0_mux_p, ARRAY_SIZE(timer0_mux_p), CLK_SET_RATE_PARENT, 0,     15, 2, 0,                   },
 	{ HI3620_TIMER1_MUX, "timer1_mux", timer1_mux_p, ARRAY_SIZE(timer1_mux_p), CLK_SET_RATE_PARENT, 0,     17, 2, 0,                   },
 	{ HI3620_TIMER2_MUX, "timer2_mux", timer2_mux_p, ARRAY_SIZE(timer2_mux_p), CLK_SET_RATE_PARENT, 0,     19, 2, 0,                   },
@@ -119,7 +120,7 @@ static struct hisi_mux_clock hi3620_mux_clks[] __initdata = {
 	{ HI3620_MMC3_MUX,   "mmc3_mux",   mmc3_mux_p,   ARRAY_SIZE(mmc3_mux_p),   CLK_SET_RATE_PARENT, 0x140, 9,  1, CLK_MUX_HIWORD_MASK, },
 };
 
-static struct hisi_divider_clock hi3620_div_clks[] __initdata = {
+static struct hisi_divider_clock hi3620_div_clks[] = {
 	{ HI3620_SHAREAXI_DIV, "saxi_div",   "saxi_mux",  0, 0x100, 0, 5, CLK_DIVIDER_HIWORD_MASK, NULL, },
 	{ HI3620_CFGAXI_DIV,   "cfgaxi_div", "saxi_div",  0, 0x100, 5, 2, CLK_DIVIDER_HIWORD_MASK, NULL, },
 	{ HI3620_SD_DIV,       "sd_div",     "sd_mux",	  0, 0x108, 0, 4, CLK_DIVIDER_HIWORD_MASK, NULL, },
@@ -129,7 +130,7 @@ static struct hisi_divider_clock hi3620_div_clks[] __initdata = {
 	{ HI3620_MMC3_DIV,     "mmc3_div",   "mmc3_mux",  0, 0x140, 5, 4, CLK_DIVIDER_HIWORD_MASK, NULL, },
 };
 
-static struct hisi_gate_clock hi3620_separated_gate_clks[] __initdata = {
+static struct hisi_gate_clock hi3620_separated_gate_clks[] = {
 	{ HI3620_TIMERCLK01,   "timerclk01",   "timer_rclk01", CLK_SET_RATE_PARENT, 0x20, 0, 0, },
 	{ HI3620_TIMER_RCLK01, "timer_rclk01", "rclk_tcxo",    CLK_SET_RATE_PARENT, 0x20, 1, 0, },
 	{ HI3620_TIMERCLK23,   "timerclk23",   "timer_rclk23", CLK_SET_RATE_PARENT, 0x20, 2, 0, },
@@ -191,29 +192,19 @@ static struct hisi_gate_clock hi3620_separated_gate_clks[] __initdata = {
 	{ HI3620_MCU_CLK,      "mcu_clk",      "acp_clk",      CLK_SET_RATE_PARENT, 0x50, 24, 0, },
 };
 
-static void __init hi3620_clk_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-
-	clk_data = hisi_clk_init(np, HI3620_NR_CLKS);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_fixed_rate(hi3620_fixed_rate_clks,
-				     ARRAY_SIZE(hi3620_fixed_rate_clks),
-				     clk_data);
-	hisi_clk_register_fixed_factor(hi3620_fixed_factor_clks,
-				       ARRAY_SIZE(hi3620_fixed_factor_clks),
-				       clk_data);
-	hisi_clk_register_mux(hi3620_mux_clks, ARRAY_SIZE(hi3620_mux_clks),
-			      clk_data);
-	hisi_clk_register_divider(hi3620_div_clks, ARRAY_SIZE(hi3620_div_clks),
-				  clk_data);
-	hisi_clk_register_gate_sep(hi3620_separated_gate_clks,
-				   ARRAY_SIZE(hi3620_separated_gate_clks),
-				   clk_data);
-}
-CLK_OF_DECLARE(hi3620_clk, "hisilicon,hi3620-clock", hi3620_clk_init);
+static const struct hisi_clocks hi3620_clks = {
+	.nr = HI3620_NR_CLKS,
+	.fixed_rate_clks = hi3620_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3620_fixed_rate_clks),
+	.fixed_factor_clks = hi3620_fixed_factor_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hi3620_fixed_factor_clks),
+	.mux_clks = hi3620_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3620_mux_clks),
+	.divider_clks = hi3620_div_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3620_div_clks),
+	.gate_sep_clks = hi3620_separated_gate_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3620_separated_gate_clks),
+};
 
 struct hisi_mmc_clock {
 	unsigned int		id;
@@ -251,7 +242,7 @@ struct clk_mmc {
 
 #define to_mmc(_hw) container_of(_hw, struct clk_mmc, hw)
 
-static struct hisi_mmc_clock hi3620_mmc_clks[] __initdata = {
+static struct hisi_mmc_clock hi3620_mmc_clks[] = {
 	{ HI3620_SD_CIUCLK,	"sd_bclk1", "sd_clk", CLK_SET_RATE_PARENT, 0x1f8, 0, 0x1f8, 1, 3, 0x1f8, 4, 4, 0x1f8, 8, 4},
 	{ HI3620_MMC_CIUCLK1,   "mmc_bclk1", "mmc_clk1", CLK_SET_RATE_PARENT, 0x1f8, 12, 0x1f8, 13, 3, 0x1f8, 16, 4, 0x1f8, 20, 4},
 	{ HI3620_MMC_CIUCLK2,   "mmc_bclk2", "mmc_clk2", CLK_SET_RATE_PARENT, 0x1f8, 24, 0x1f8, 25, 3, 0x1f8, 28, 4, 0x1fc, 0, 4},
@@ -407,8 +398,9 @@ static const struct clk_ops clk_mmc_ops = {
 	.recalc_rate = mmc_clk_recalc_rate,
 };
 
-static struct clk *hisi_register_clk_mmc(struct hisi_mmc_clock *mmc_clk,
-			void __iomem *base, struct device_node *np)
+static struct clk *
+clk_register_hisi_mmc(struct device *dev, const struct hisi_mmc_clock *mmc_clk,
+		      void __iomem *base)
 {
 	struct clk_mmc *mclk;
 	struct clk *clk;
@@ -444,41 +436,50 @@ static struct clk *hisi_register_clk_mmc(struct hisi_mmc_clock *mmc_clk,
 	return clk;
 }
 
-static void __init hi3620_mmc_clk_init(struct device_node *node)
+static int hisi_register_clk_mmc(struct device *dev, const void *clocks,
+				 size_t num, struct hisi_clock_data *data)
 {
-	void __iomem *base;
-	int i, num = ARRAY_SIZE(hi3620_mmc_clks);
-	struct clk_onecell_data *clk_data;
+	const struct hisi_mmc_clock *clks = clocks;
 
-	if (!node) {
-		pr_err("failed to find pctrl node in DTS\n");
-		return;
-	}
+	for (int i = 0; i < num; i++) {
+		struct clk *clk = clk_register_hisi_mmc(dev, &clks[i], data->base);
 
-	base = of_iomap(node, 0);
-	if (!base) {
-		pr_err("failed to map pctrl\n");
-		return;
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			return PTR_ERR(clk);
+		}
+		data->clk_data.clks[clks[i].id] = clk;
 	}
 
-	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
-	if (WARN_ON(!clk_data))
-		return;
+	return 0;
+}
 
-	clk_data->clks = kcalloc(num, sizeof(*clk_data->clks), GFP_KERNEL);
-	if (!clk_data->clks) {
-		kfree(clk_data);
-		return;
-	}
+static const struct hisi_clocks hi3620_clks_mmc = {
+	.customized_clks = hi3620_mmc_clks,
+	.customized_clks_num = ARRAY_SIZE(hi3620_mmc_clks),
+	.clk_register_customized = hisi_register_clk_mmc,
+};
 
-	for (i = 0; i < num; i++) {
-		struct hisi_mmc_clock *mmc_clk = &hi3620_mmc_clks[i];
-		clk_data->clks[mmc_clk->id] =
-			hisi_register_clk_mmc(mmc_clk, base, node);
-	}
+static const struct of_device_id hi3620_clk_match_table[] = {
+	{ .compatible = "hisilicon,hi3620-clock",
+	  .data = &hi3620_clks },
+	{ .compatible = "hisilicon,hi3620-mmc-clock",
+	  .data = &hi3620_clks_mmc },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hi3620_clk_match_table);
+
+static struct platform_driver hi3620_clk_driver = {
+	.probe = hisi_clk_probe,
+	.remove_new = hisi_clk_remove,
+	.driver = {
+		.name = "hi3620-clock",
+		.of_match_table = hi3620_clk_match_table,
+	},
+};
 
-	clk_data->clk_num = num;
-	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-}
+module_platform_driver(hi3620_clk_driver);
 
-CLK_OF_DECLARE(hi3620_mmc_clk, "hisilicon,hi3620-mmc-clock", hi3620_mmc_clk_init);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("HiSilicon Hi3620 Clock Driver");
-- 
2.43.0


