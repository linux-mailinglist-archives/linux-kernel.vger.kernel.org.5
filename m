Return-Path: <linux-kernel+bounces-146595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BB28A67B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A811C21291
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB0E1272AF;
	Tue, 16 Apr 2024 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fy0pfCS/"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7C81292D6;
	Tue, 16 Apr 2024 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261929; cv=none; b=pQ6X2yRb6xaZeLqSoVFzcvpn4MQ6e4RZcZdh/JaNrv/3ZiQMWfZbj6/DSCLNeBPDer+vxuE+1w+FGbUDdnDZ4itUvcCjuBxPrVlP8uulr1hYjjQYoccHLy1qfKljFfmAQ9ZH9+fXv4/bC8EMCMJdQbPOMTnvjdn+GZ1HOp887G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261929; c=relaxed/simple;
	bh=THOlQNYQ3XLHFrKTZ3I/J83AKC7OEV1gCwIHkExt2KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDf/jcCQoeuygnV7Mwbkzyq/YS8r4VKNDwZXSWCxGF7sZ49qNvBxgFJPxoaRPG2TZx86S3C8Yp7ca8/yDMlFS6dPYb90B4XlM8r/zOUx64YZYfKVwgaHnvvqzD6jClt2Xgw3oZsAWSbLr38VxbcTeQmreHNr7DT17w0KC2rwpdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fy0pfCS/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3f6f03594so26845525ad.0;
        Tue, 16 Apr 2024 03:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713261926; x=1713866726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqQYS83u49eAatFebVywwsoQA2O7fC1IRiP+OSZwee8=;
        b=Fy0pfCS/kfZ+ddwn2+BDdcB9F7wNdmwja1TNuBQg6odHmNUf2ogumz5fKpgnMW8DZN
         MYRR6MLY+DSAcCUQvr0OFSOG11gsxHACIRIp1e52CCY+305dRdXw1mbPk1M0oHsW3ylQ
         A7IaMPMGJRGJLgjHXngbVn60GFPhSEKtDtuPAwiRC/zXgqpGI9nbgS8uliCoJzchnwiE
         taYXWPt8ONZND0oFlJc09IZv7ClHaOgeOmzSaF3HqIs3pousKb1NID+cJayk24GeQ40s
         COeHmGj4SMWsD8ppOMULTfPCJSYfKb7v95XIoqZUkJE8E+Em3UThljbofJ1x27InRc+3
         roGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261926; x=1713866726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqQYS83u49eAatFebVywwsoQA2O7fC1IRiP+OSZwee8=;
        b=hmTOk/8HKyhky0HjdiwBgdP55h3l8mcoymSmB0+tWO3Csjzs11Xjh8CMZL/Jgo0+BE
         cdUxf6B+4WtTWkwGEeUe5prM+5dqLoPwzLTZHN9kQbhiFfOyabrnmxEhukqAtdYOcABa
         t0eEQzjXqo40PkXrUn6oGl7ZZQ/Zk8rYrWvP/mFjchF3KD7BFsMMaNOtN+WdyrM8FYkH
         XLeWM6rhluFcjg2uEyLCTcBuzxJhXuFB9fLCLxeVmFpskUBRYnXazhP7h2v5JkBDar/I
         LiggRicnds2XToVQAkvEPFDN3bLG+S2wCq6ghXiaYmcTfBIhghQd8tXvxPb4nTCeWvu7
         KR/w==
X-Forwarded-Encrypted: i=1; AJvYcCVvjk1Gi0iDFcXMXzGajKi7wOOXVmP4EhHEaRQz75MdtEUucqQDPHBHuIx11e0YWUc+IGunNjJWE23nP7k7HcddJmnDJ3MfNFQOnMzv
X-Gm-Message-State: AOJu0Yy65/fRvYILDzOhR3cT9QrR7uD0t6paaPCXLjoVmA2LgRu1zVP1
	cxsofxeh1AuGCgAN2pY8R2uyLDwQ7rOnOHLavjipLo9G5gu+t3dCyhEAGfcf
X-Google-Smtp-Source: AGHT+IE3MbPYpqR8yOEiAcB+Mv6VBAMqrom/BO9icjL1/IXN2ZVhFCTQpt3csGQKR2SIXchQH0+G6w==
X-Received: by 2002:a17:902:dac8:b0:1e4:ad9b:f770 with SMTP id q8-20020a170902dac800b001e4ad9bf770mr15256928plx.23.1713261926454;
        Tue, 16 Apr 2024 03:05:26 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090322c400b001e0b287c1d2sm9353651plg.215.2024.04.16.03.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:05:25 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH v10 09/13] clk: hisilicon: hi3620: Convert into platform driver module
Date: Tue, 16 Apr 2024 18:03:43 +0800
Message-ID: <20240416100347.395295-10-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/clk-hi3620.c | 192 +++++++++++++++--------------
 1 file changed, 97 insertions(+), 95 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index 5d0226530fdb..97108eda6cb6 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -12,8 +12,10 @@
 #include <linux/kernel.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 #include <dt-bindings/clock/hi3620-clock.h>
@@ -21,48 +23,48 @@
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
@@ -75,13 +77,13 @@ static struct hisi_fixed_rate_clock hi3620_fixed_rate_clks[] __initdata = {
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
@@ -119,7 +121,7 @@ static struct hisi_mux_clock hi3620_mux_clks[] __initdata = {
 	{ HI3620_MMC3_MUX,   "mmc3_mux",   mmc3_mux_p,   ARRAY_SIZE(mmc3_mux_p),   CLK_SET_RATE_PARENT, 0x140, 9,  1, CLK_MUX_HIWORD_MASK, },
 };
 
-static struct hisi_divider_clock hi3620_div_clks[] __initdata = {
+static struct hisi_divider_clock hi3620_div_clks[] = {
 	{ HI3620_SHAREAXI_DIV, "saxi_div",   "saxi_mux",  0, 0x100, 0, 5, CLK_DIVIDER_HIWORD_MASK, NULL, },
 	{ HI3620_CFGAXI_DIV,   "cfgaxi_div", "saxi_div",  0, 0x100, 5, 2, CLK_DIVIDER_HIWORD_MASK, NULL, },
 	{ HI3620_SD_DIV,       "sd_div",     "sd_mux",	  0, 0x108, 0, 4, CLK_DIVIDER_HIWORD_MASK, NULL, },
@@ -129,7 +131,7 @@ static struct hisi_divider_clock hi3620_div_clks[] __initdata = {
 	{ HI3620_MMC3_DIV,     "mmc3_div",   "mmc3_mux",  0, 0x140, 5, 4, CLK_DIVIDER_HIWORD_MASK, NULL, },
 };
 
-static struct hisi_gate_clock hi3620_separated_gate_clks[] __initdata = {
+static struct hisi_gate_clock hi3620_separated_gate_clks[] = {
 	{ HI3620_TIMERCLK01,   "timerclk01",   "timer_rclk01", CLK_SET_RATE_PARENT, 0x20, 0, 0, },
 	{ HI3620_TIMER_RCLK01, "timer_rclk01", "rclk_tcxo",    CLK_SET_RATE_PARENT, 0x20, 1, 0, },
 	{ HI3620_TIMERCLK23,   "timerclk23",   "timer_rclk23", CLK_SET_RATE_PARENT, 0x20, 2, 0, },
@@ -191,29 +193,19 @@ static struct hisi_gate_clock hi3620_separated_gate_clks[] __initdata = {
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
@@ -251,7 +243,7 @@ struct clk_mmc {
 
 #define to_mmc(_hw) container_of(_hw, struct clk_mmc, hw)
 
-static struct hisi_mmc_clock hi3620_mmc_clks[] __initdata = {
+static struct hisi_mmc_clock hi3620_mmc_clks[] = {
 	{ HI3620_SD_CIUCLK,	"sd_bclk1", "sd_clk", CLK_SET_RATE_PARENT, 0x1f8, 0, 0x1f8, 1, 3, 0x1f8, 4, 4, 0x1f8, 8, 4},
 	{ HI3620_MMC_CIUCLK1,   "mmc_bclk1", "mmc_clk1", CLK_SET_RATE_PARENT, 0x1f8, 12, 0x1f8, 13, 3, 0x1f8, 16, 4, 0x1f8, 20, 4},
 	{ HI3620_MMC_CIUCLK2,   "mmc_bclk2", "mmc_clk2", CLK_SET_RATE_PARENT, 0x1f8, 24, 0x1f8, 25, 3, 0x1f8, 28, 4, 0x1fc, 0, 4},
@@ -407,8 +399,9 @@ static const struct clk_ops clk_mmc_ops = {
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
@@ -444,41 +437,50 @@ static struct clk *hisi_register_clk_mmc(struct hisi_mmc_clock *mmc_clk,
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


