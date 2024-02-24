Return-Path: <linux-kernel+bounces-79840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2974862776
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99088282361
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B5C52F62;
	Sat, 24 Feb 2024 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bmA+eXTk"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90924E1CA
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708806063; cv=none; b=UQBVeh9wqRze9U6kzroqsas6Ydlzs/r9g1ClknXPJ9tmQ7sf+V0x7jRB616mltuSx9Pu46TIOGUEpw76F5v8o/JthKtZSm6sbOGbS33f1U//M1soZt8vJCcdiub6CrOmGSOwWi033I/KqjZ5Jwxs+JyY7BDntiw4A4aJlTEECNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708806063; c=relaxed/simple;
	bh=u5e/xru5KQ8TgtFLyzjDISb/KYM+XpEMO0hxy8y7HBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U6T8FFl468rDgNZtpS/QUW2Oj/aj1zro7221quZWMpseTQdtf2kOfqWOODcnt3r0/6CHwR+u0JJfd3wrvKsQMZvUZ6lrWngujMa/HsDz/qcMF/oprTgD9tg34FJT+fVD1M2ux+mpQf+H71ecsfzVDaX7n+cohvuL4WJqd8wAQnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bmA+eXTk; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbc649c275so1179549b6e.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 12:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708806059; x=1709410859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjHY+LeTW+KnH1y9XJoOarQqtNcWlU5y9fOQzKMZUcg=;
        b=bmA+eXTkH4xUXc5xzujYbs8b6oHE7hB5pphjOxtLiuLyWJOUxPgK2fnuebSzjvOy3T
         OZs0u2ta+n+AlW5DLV9/nwXWCAVDDlL1pqJjQ+Jpmovywt2gyzZTab/2Tpp0L/ZjZcLh
         /gxKlqnQW6x5x9vL/r1oNUMQ2vRR1lSoyEQKwk/tAkrMcTMeyJ/Kl4u/B5rJvDYJTP+n
         lQArl+n2dHoWSseV3hjSq8tmWuD0ErNwwZkFELyEJ2jwHikxawqmLMDvEtWJIG/zNFJg
         ruAGI1zsVPJ0aBdszOZ2wKe/tFms7JejleTZDMmrAedwEp06FlSnRwJjushW5YS4pNKp
         APvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708806059; x=1709410859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjHY+LeTW+KnH1y9XJoOarQqtNcWlU5y9fOQzKMZUcg=;
        b=twhqIYqKfxUlnfERN503g+V50Ff1+OB89PLC6HhDhS6SsTYbLkAFoCSdgONRletWro
         q+CFY2cnk2E8Sq8pPApyZvYu2m8XFqbxdt+uPMgn3gCNkZnby5dPDeEA0GxxR+4UqxAj
         2ro4/+xXc87nW8yxfG6uV3wRsR8kcbpy55e7Rhtehp8SiPQxBpwMMim5m6hQeal4hIWi
         yvUatpUBL+/kuFZKPjT2XlWVRS2vtxiSxYrD/sEN+05IVMvNFts47mnoc0lmAcqcex+4
         o3KMCr6ce7oFLdv7bQ55lFtI+D9npUd0rF+rlN1szziIE1PYs8hQJiXS2DPQFTdGE1kH
         AIow==
X-Forwarded-Encrypted: i=1; AJvYcCW9jJITwipcJkk1ny/5Z2VNudZQs6zq15IVfxvs+7oBAIoHJmMOSAbxWtRVx8j5xUXviH2x012ydf8DchfM3B/f4CDwpizJFviuFn4q
X-Gm-Message-State: AOJu0YwpeWQeADX9PhZVHEdFxOrzaySlQzr0Pra+9jbO28p8xdRSGmb/
	mRBNQ4LFuIoeS/ZT5g/eicZuaGZf1mxiBMJwLz4IhQgBiPVXlnB2/PYTQfXl8Pc=
X-Google-Smtp-Source: AGHT+IEwI6OK8WVCS1b7MMABsfhdOvcpe0B33DhpjfkxQpBjowZA8STFgPmu1CwTM1Jct8GlKPbwTA==
X-Received: by 2002:a05:6808:120a:b0:3c1:83c3:969b with SMTP id a10-20020a056808120a00b003c183c3969bmr2857773oil.53.1708806059623;
        Sat, 24 Feb 2024 12:20:59 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id e15-20020a056808148f00b003c18039f8bbsm377925oiw.54.2024.02.24.12.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 12:20:59 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/15] clk: samsung: Pass actual CPU clock registers base to CPU_CLK()
Date: Sat, 24 Feb 2024 14:20:45 -0600
Message-Id: <20240224202053.25313-8-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240224202053.25313-1-semen.protsenko@linaro.org>
References: <20240224202053.25313-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation for struct exynos_cpuclk says .ctrl_base field should
contain the controller base address. There are two different problems
with that:

1. All Exynos clock drivers are actually passing CPU_SRC register offset
   via CPU_CLK() macro, which in turn gets assigned to mentioned
   .ctrl_base field. Because CPU_SRC register usually already has 0x200
   offset from controller's base, all other register offsets in
   clk-cpu.c (like DIVs and MUXes) are specified as offsets from CPU_SRC
   offset, and not from controller's base. That makes things confusing
   and inconsistent with register offsets provided in Exynos clock
   drivers, also breaking the contract for .ctrl_base field as described
   in struct exynos_cpuclk doc.

2. Furthermore, some Exynos chips have an additional offset for the
   start of CPU clock registers block (inside of the CMU). There might
   be different reasons for that, e.g.:

   - The CMU contains clocks for two different CPUs (like in Exynos5420)
   - The CMU contains also non-CPU clocks as well (like in Exynos4)
   - The CPU CMU exists as a dedicated hardware block in the SoC layout,
     but is modelled as a part of bigger CMU in the driver (like in case
     of Exynos3250)

   That means the .ctrl_base field is actually not a controller's base,
   but instead it's a start address of the CPU clock registers inside of
   the CMU.

Rework all register offsets in clk-cpu.c to be actual offsets from the
CPU clock register block start, and fix offsets provided to CPU_CLK()
macro in all Exynos clock drivers. Also clarify the .ctrl_base field
documentation and rename it to just .base, because it doesn't really
contain the CMU base.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - none

Changes in v2:
  - Renamed .ctrl_base field to .base and fixed its documentation
  - Fixed typo in commit message: Exynis -> Exynos
  - Improved the commit message: mentioned that .ctrl_base is actually a
    start address of the CPU clock register block, not the CMU base

 drivers/clk/samsung/clk-cpu.c        | 38 ++++++++++++++--------------
 drivers/clk/samsung/clk-exynos3250.c |  2 +-
 drivers/clk/samsung/clk-exynos4.c    |  9 ++++---
 drivers/clk/samsung/clk-exynos5250.c |  4 +--
 drivers/clk/samsung/clk-exynos5420.c | 16 ++++++------
 drivers/clk/samsung/clk-exynos5433.c | 10 +++-----
 6 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index d550a4bb632f..82d54b0c9040 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -48,7 +48,7 @@ typedef int (*exynos_rate_change_fn_t)(struct clk_notifier_data *ndata,
  * @hw:		handle between CCF and CPU clock
  * @alt_parent:	alternate parent clock to use when switching the speed
  *		of the primary parent clock
- * @ctrl_base:	base address of the clock controller
+ * @base:	start address of the CPU clock registers block
  * @lock:	cpu clock domain register access lock
  * @cfg:	cpu clock rate configuration data
  * @num_cfgs:	number of array elements in @cfg array
@@ -64,7 +64,7 @@ typedef int (*exynos_rate_change_fn_t)(struct clk_notifier_data *ndata,
 struct exynos_cpuclk {
 	struct clk_hw				hw;
 	const struct clk_hw			*alt_parent;
-	void __iomem				*ctrl_base;
+	void __iomem				*base;
 	spinlock_t				*lock;
 	const struct exynos_cpuclk_cfg_data	*cfg;
 	const unsigned long			num_cfgs;
@@ -125,12 +125,12 @@ static void wait_until_mux_stable(void __iomem *mux_reg, u32 mux_pos,
 
 /* ---- Exynos 3/4/5 -------------------------------------------------------- */
 
-#define E4210_SRC_CPU		0x0
-#define E4210_STAT_CPU		0x200
-#define E4210_DIV_CPU0		0x300
-#define E4210_DIV_CPU1		0x304
-#define E4210_DIV_STAT_CPU0	0x400
-#define E4210_DIV_STAT_CPU1	0x404
+#define E4210_SRC_CPU		0x200
+#define E4210_STAT_CPU		0x400
+#define E4210_DIV_CPU0		0x500
+#define E4210_DIV_CPU1		0x504
+#define E4210_DIV_STAT_CPU0	0x600
+#define E4210_DIV_STAT_CPU1	0x604
 
 #define E4210_DIV0_RATIO0_MASK	GENMASK(2, 0)
 #define E4210_DIV1_HPM_MASK	GENMASK(6, 4)
@@ -160,7 +160,7 @@ static int exynos_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 					 struct exynos_cpuclk *cpuclk)
 {
 	const struct exynos_cpuclk_cfg_data *cfg_data = cpuclk->cfg;
-	void __iomem *base = cpuclk->ctrl_base;
+	void __iomem *base = cpuclk->base;
 	unsigned long alt_prate = clk_hw_get_rate(cpuclk->alt_parent);
 	unsigned long div0, div1 = 0, mux_reg;
 	unsigned long flags;
@@ -238,7 +238,7 @@ static int exynos_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
 					  struct exynos_cpuclk *cpuclk)
 {
 	const struct exynos_cpuclk_cfg_data *cfg_data = cpuclk->cfg;
-	void __iomem *base = cpuclk->ctrl_base;
+	void __iomem *base = cpuclk->base;
 	unsigned long div = 0, div_mask = DIV_MASK;
 	unsigned long mux_reg;
 	unsigned long flags;
@@ -271,12 +271,12 @@ static int exynos_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
 
 /* ---- Exynos5433 ---------------------------------------------------------- */
 
-#define E5433_MUX_SEL2		0x008
-#define E5433_MUX_STAT2		0x208
-#define E5433_DIV_CPU0		0x400
-#define E5433_DIV_CPU1		0x404
-#define E5433_DIV_STAT_CPU0	0x500
-#define E5433_DIV_STAT_CPU1	0x504
+#define E5433_MUX_SEL2		0x208
+#define E5433_MUX_STAT2		0x408
+#define E5433_DIV_CPU0		0x600
+#define E5433_DIV_CPU1		0x604
+#define E5433_DIV_STAT_CPU0	0x700
+#define E5433_DIV_STAT_CPU1	0x704
 
 /*
  * Helper function to set the 'safe' dividers for the CPU clock. The parameters
@@ -299,7 +299,7 @@ static int exynos5433_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 					     struct exynos_cpuclk *cpuclk)
 {
 	const struct exynos_cpuclk_cfg_data *cfg_data = cpuclk->cfg;
-	void __iomem *base = cpuclk->ctrl_base;
+	void __iomem *base = cpuclk->base;
 	unsigned long alt_prate = clk_hw_get_rate(cpuclk->alt_parent);
 	unsigned long div0, div1 = 0, mux_reg;
 	unsigned long flags;
@@ -359,7 +359,7 @@ static int exynos5433_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 static int exynos5433_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
 					      struct exynos_cpuclk *cpuclk)
 {
-	void __iomem *base = cpuclk->ctrl_base;
+	void __iomem *base = cpuclk->base;
 	unsigned long div = 0, div_mask = DIV_MASK;
 	unsigned long mux_reg;
 	unsigned long flags;
@@ -461,7 +461,7 @@ static int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
 
 	cpuclk->alt_parent = alt_parent;
 	cpuclk->hw.init = &init;
-	cpuclk->ctrl_base = ctx->reg_base + clk_data->offset;
+	cpuclk->base = ctx->reg_base + clk_data->offset;
 	cpuclk->lock = &ctx->lock;
 	cpuclk->flags = clk_data->flags;
 	cpuclk->clk_nb.notifier_call = exynos_cpuclk_notifier_cb;
diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
index a02461667664..bf149fae04c3 100644
--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -775,7 +775,7 @@ static const struct exynos_cpuclk_cfg_data e3250_armclk_d[] __initconst = {
 
 static const struct samsung_cpu_clock exynos3250_cpu_clks[] __initconst = {
 	CPU_CLK(CLK_ARM_CLK, "armclk", CLK_MOUT_APLL, CLK_MOUT_MPLL_USER_C,
-			CLK_CPU_HAS_DIV1, 0x14200, e3250_armclk_d),
+		CLK_CPU_HAS_DIV1, 0x14000, e3250_armclk_d),
 };
 
 static void __init exynos3_core_down_clock(void __iomem *reg_base)
diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 4ec41221e68f..d5b1e9f49d8b 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1252,17 +1252,20 @@ static const struct exynos_cpuclk_cfg_data e4412_armclk_d[] __initconst = {
 
 static const struct samsung_cpu_clock exynos4210_cpu_clks[] __initconst = {
 	CPU_CLK(CLK_ARM_CLK, "armclk", CLK_MOUT_APLL, CLK_SCLK_MPLL,
-			CLK_CPU_NEEDS_DEBUG_ALT_DIV | CLK_CPU_HAS_DIV1, 0x14200, e4210_armclk_d),
+		CLK_CPU_NEEDS_DEBUG_ALT_DIV | CLK_CPU_HAS_DIV1, 0x14000,
+		e4210_armclk_d),
 };
 
 static const struct samsung_cpu_clock exynos4212_cpu_clks[] __initconst = {
 	CPU_CLK(CLK_ARM_CLK, "armclk", CLK_MOUT_APLL, CLK_MOUT_MPLL_USER_C,
-		CLK_CPU_NEEDS_DEBUG_ALT_DIV | CLK_CPU_HAS_DIV1, 0x14200, e4212_armclk_d),
+		CLK_CPU_NEEDS_DEBUG_ALT_DIV | CLK_CPU_HAS_DIV1, 0x14000,
+		e4212_armclk_d),
 };
 
 static const struct samsung_cpu_clock exynos4412_cpu_clks[] __initconst = {
 	CPU_CLK(CLK_ARM_CLK, "armclk", CLK_MOUT_APLL, CLK_MOUT_MPLL_USER_C,
-			CLK_CPU_NEEDS_DEBUG_ALT_DIV | CLK_CPU_HAS_DIV1, 0x14200, e4412_armclk_d),
+		CLK_CPU_NEEDS_DEBUG_ALT_DIV | CLK_CPU_HAS_DIV1, 0x14000,
+		e4412_armclk_d),
 };
 
 /* register exynos4 clocks */
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 8ebe6155d8b7..58df80de52ef 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -776,8 +776,8 @@ static const struct exynos_cpuclk_cfg_data exynos5250_armclk_d[] __initconst = {
 };
 
 static const struct samsung_cpu_clock exynos5250_cpu_clks[] __initconst = {
-	CPU_CLK(CLK_ARM_CLK, "armclk", CLK_MOUT_APLL, CLK_MOUT_MPLL, CLK_CPU_HAS_DIV1, 0x200,
-			exynos5250_armclk_d),
+	CPU_CLK(CLK_ARM_CLK, "armclk", CLK_MOUT_APLL, CLK_MOUT_MPLL,
+		CLK_CPU_HAS_DIV1, 0x0, exynos5250_armclk_d),
 };
 
 static const struct of_device_id ext_clk_match[] __initconst = {
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 199843f12ae5..bd7b304d2c00 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1555,17 +1555,17 @@ static const struct exynos_cpuclk_cfg_data exynos5420_kfcclk_d[] __initconst = {
 };
 
 static const struct samsung_cpu_clock exynos5420_cpu_clks[] __initconst = {
-	CPU_CLK(CLK_ARM_CLK, "armclk", CLK_MOUT_APLL, CLK_MOUT_MSPLL_CPU, 0, 0x200,
-			exynos5420_eglclk_d),
-	CPU_CLK(CLK_KFC_CLK, "kfcclk", CLK_MOUT_KPLL, CLK_MOUT_MSPLL_KFC, 0, 0x28200,
-			exynos5420_kfcclk_d),
+	CPU_CLK(CLK_ARM_CLK, "armclk", CLK_MOUT_APLL, CLK_MOUT_MSPLL_CPU, 0,
+		0x0, exynos5420_eglclk_d),
+	CPU_CLK(CLK_KFC_CLK, "kfcclk", CLK_MOUT_KPLL, CLK_MOUT_MSPLL_KFC, 0,
+		0x28000, exynos5420_kfcclk_d),
 };
 
 static const struct samsung_cpu_clock exynos5800_cpu_clks[] __initconst = {
-	CPU_CLK(CLK_ARM_CLK, "armclk", CLK_MOUT_APLL, CLK_MOUT_MSPLL_CPU, 0, 0x200,
-			exynos5800_eglclk_d),
-	CPU_CLK(CLK_KFC_CLK, "kfcclk", CLK_MOUT_KPLL, CLK_MOUT_MSPLL_KFC, 0, 0x28200,
-			exynos5420_kfcclk_d),
+	CPU_CLK(CLK_ARM_CLK, "armclk", CLK_MOUT_APLL, CLK_MOUT_MSPLL_CPU, 0,
+		0x0, exynos5800_eglclk_d),
+	CPU_CLK(CLK_KFC_CLK, "kfcclk", CLK_MOUT_KPLL, CLK_MOUT_MSPLL_KFC, 0,
+		0x28000, exynos5420_kfcclk_d),
 };
 
 static const struct of_device_id ext_clk_match[] __initconst = {
diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index 6bfc5d0cd924..d3779eefb438 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -3700,9 +3700,8 @@ static const struct exynos_cpuclk_cfg_data exynos5433_apolloclk_d[] __initconst
 
 static const struct samsung_cpu_clock apollo_cpu_clks[] __initconst = {
 	CPU_CLK(CLK_SCLK_APOLLO, "apolloclk", CLK_MOUT_APOLLO_PLL,
-			CLK_MOUT_BUS_PLL_APOLLO_USER,
-			CLK_CPU_HAS_E5433_REGS_LAYOUT, 0x200,
-			exynos5433_apolloclk_d),
+		CLK_MOUT_BUS_PLL_APOLLO_USER, CLK_CPU_HAS_E5433_REGS_LAYOUT,
+		0x0, exynos5433_apolloclk_d),
 };
 
 static const struct samsung_cmu_info apollo_cmu_info __initconst = {
@@ -3945,9 +3944,8 @@ static const struct exynos_cpuclk_cfg_data exynos5433_atlasclk_d[] __initconst =
 
 static const struct samsung_cpu_clock atlas_cpu_clks[] __initconst = {
 	CPU_CLK(CLK_SCLK_ATLAS, "atlasclk", CLK_MOUT_ATLAS_PLL,
-			CLK_MOUT_BUS_PLL_ATLAS_USER,
-			CLK_CPU_HAS_E5433_REGS_LAYOUT, 0x200,
-			exynos5433_atlasclk_d),
+		CLK_MOUT_BUS_PLL_ATLAS_USER, CLK_CPU_HAS_E5433_REGS_LAYOUT,
+		0x0, exynos5433_atlasclk_d),
 };
 
 static const struct samsung_cmu_info atlas_cmu_info __initconst = {
-- 
2.39.2


