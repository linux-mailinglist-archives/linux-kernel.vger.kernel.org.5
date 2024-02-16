Return-Path: <linux-kernel+bounces-69415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD0B8588BA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958C1283E52
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A4A14D43E;
	Fri, 16 Feb 2024 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BwTv8h6/"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6119C14A0A4
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 22:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122777; cv=none; b=S2h0pSX0SXqisBs8iY/NSItOo7X5mN86ChwXQ8LvmDgFc4ZrGCm0KobMp0zfBAHvHcXaQQ04IZVAmN4+PbqVePULDPabG90xWFy6iCe5XOoN+7dWz+DqSHp/LaU0FfA6z7qNJUaKyBolM/KWngtwtD33rWvGz/goU7jDENmWTiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122777; c=relaxed/simple;
	bh=ePFKOWRE3K7dYiOwtCkaYNJrSXoFcKNqXcZmDfVeAws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FezcurGHIz43WAB/AYv/Sc8mYcusHKEMfKJQLOPuX+POZRRijKuRcZsUd6zN4zuAfIZZUomVA2cAvP/atxGYXs6DuQVQZXJUcVjkN6gUeXdOqEKiKLkR+AZb4mwXN63xB+Mr8GemPwNTruxg3pGEEd76u155Eh0gbkt3w0P1Db8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BwTv8h6/; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-59f786b2b59so1192389eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708122773; x=1708727573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JueSEWjzcD2UuRwkarRrGZ51dhlmNKxIoCGdG4EKeus=;
        b=BwTv8h6/A8lOtFHVhgCYvqI+YfzBk/fnjRpNVnmJVOm0VE5/756+kiIpHR7HYbA4ns
         YpOwEDfNkHSQCBOmpmR4lSXIGHYnnblc1dTlY/FC6fpG/FCFkFSwn8SGn6DKGNS3fjeF
         8oYUCbDlKuaGde9IVtuvU8JIYpAm9tBSe5iQBSOLb/zOAZOB5KPlERgC/5cXIg4cX1Lq
         Vi+ca4hzDIqoaLML+5D8lK5VfaeYCrKBwBcmdA0zNv7JymIGsaR6gn3tSGaQ6Pzzv1He
         0RL7zIjnxRL5t4/ziW/WQLeg4QdVFpdVPpTFUaSISn6vadqgiMbycg/DbWDEBCieWNiR
         hnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708122773; x=1708727573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JueSEWjzcD2UuRwkarRrGZ51dhlmNKxIoCGdG4EKeus=;
        b=NeJq7RAmdFvQM52HTI6LsNH/4Va8IbyTBYcMewRHooE3DUZIAXKB/I4VkBjtjD1hA+
         uisEZiOqJAgsX3PvkWHbGDBvW4ST6+zFZW+jyjvVA0k+P56awBF1CvCytignNo7qf3Ai
         IQKvO0rJX3Pix74hAkQ4U70gKFQ6NhFGQxb1c5tJvUjxaVxw+SrIsJNDJTY4NuMsYSp5
         naCzKXHYHfgnjrO6M7frurDNY7PVCA6x1J2YmqSI6qZMWRALmZ3ZahWyzWSM5WQbYyjK
         oaYUqljHrRs4Wm3DRLdtAn9vhrmKtDvuHvIeEDXFxu3Tl/D2ZWTCKZ7STTTenUmwH2Ko
         1Q2g==
X-Forwarded-Encrypted: i=1; AJvYcCWFb/rEJN2VyvQclj3yPzUaO2WsChMdNCNipG9bUzgQ0xYu84gn9cbe90SZhYj2sDI6OAJAfc5Uq4aYFDirjy3eRSakq+24pGtsSayI
X-Gm-Message-State: AOJu0YzriN47qW9pjdo+FkVrGTPEi/MOyJ8sUbs018/8IR5kI6YxQY/6
	Sxr3WWdz4ouoV7YpBap3PIhCpwGEgTxs320FWZ/HDgDw7hFnQ9n37xwZazjP59fhQd//IvA0dyI
	7
X-Google-Smtp-Source: AGHT+IHqsY/7UiQiRe1NJD98l3tJa+4ypfbDSrWMJpk7nvMVXfKKcbU/94lhB0AA7pVATRVoiIAFOw==
X-Received: by 2002:a4a:345e:0:b0:59c:b57a:5746 with SMTP id n30-20020a4a345e000000b0059cb57a5746mr6347301oof.4.1708122773428;
        Fri, 16 Feb 2024 14:32:53 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id b6-20020a4ad886000000b0059fae73df22sm112897oov.3.2024.02.16.14.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 14:32:53 -0800 (PST)
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
Subject: [PATCH 09/16] clk: samsung: Pass register layout type explicitly to CLK_CPU()
Date: Fri, 16 Feb 2024 16:32:38 -0600
Message-Id: <20240216223245.12273-10-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216223245.12273-1-semen.protsenko@linaro.org>
References: <20240216223245.12273-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make it more obvious which register layout should be used for a CPU
clock. It prepares clk-cpu.c for adding new chips support.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/samsung/clk-cpu.c        |  2 +-
 drivers/clk/samsung/clk-cpu.h        | 12 ++++++++++--
 drivers/clk/samsung/clk-exynos3250.c |  2 +-
 drivers/clk/samsung/clk-exynos4.c    |  6 +++---
 drivers/clk/samsung/clk-exynos5250.c |  3 ++-
 drivers/clk/samsung/clk-exynos5420.c |  8 ++++----
 drivers/clk/samsung/clk-exynos5433.c |  8 ++++----
 drivers/clk/samsung/clk.h            |  4 +++-
 8 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index 4c46416281a3..21998c89b96d 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -464,7 +464,7 @@ static int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
 	cpuclk->lock = &ctx->lock;
 	cpuclk->flags = clk_data->flags;
 	cpuclk->clk_nb.notifier_call = exynos_cpuclk_notifier_cb;
-	if (clk_data->flags & CLK_CPU_HAS_E5433_REGS_LAYOUT) {
+	if (clk_data->reg_layout == CPUCLK_LAYOUT_E5433) {
 		cpuclk->pre_rate_cb = exynos5433_cpuclk_pre_rate_change;
 		cpuclk->post_rate_cb = exynos5433_cpuclk_post_rate_change;
 	} else {
diff --git a/drivers/clk/samsung/clk-cpu.h b/drivers/clk/samsung/clk-cpu.h
index ee57f3638fed..4382ab005ad3 100644
--- a/drivers/clk/samsung/clk-cpu.h
+++ b/drivers/clk/samsung/clk-cpu.h
@@ -12,8 +12,16 @@
 #define CLK_CPU_HAS_DIV1		BIT(0)
 /* When ALT parent is active, debug clocks need safe divider values */
 #define CLK_CPU_NEEDS_DEBUG_ALT_DIV	BIT(1)
-/* The CPU clock registers have Exynos5433-compatible layout */
-#define CLK_CPU_HAS_E5433_REGS_LAYOUT	BIT(2)
+
+/**
+ * enum exynos_cpuclk_layout - CPU clock registers layout compatibility
+ * @CPUCLK_LAYOUT_E4210: Exynos4210 compatible layout
+ * @CPUCLK_LAYOUT_E5433: Exynos5433 compatible layout
+ */
+enum exynos_cpuclk_layout {
+	CPUCLK_LAYOUT_E4210,
+	CPUCLK_LAYOUT_E5433,
+};
 
 /**
  * struct exynos_cpuclk_cfg_data - config data to setup cpu clocks
diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
index d1b72a75bc5a..bd017a68163d 100644
--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -773,7 +773,7 @@ static const struct exynos_cpuclk_cfg_data e3250_armclk_d[] __initconst = {
 
 static const struct samsung_cpu_clock exynos3250_cpu_clks[] __initconst = {
 	CPU_CLK(CLK_ARM_CLK, "armclk", CLK_MOUT_APLL, CLK_MOUT_MPLL_USER_C,
-		CLK_CPU_HAS_DIV1, 0x14000, e3250_armclk_d),
+		CLK_CPU_HAS_DIV1, 0x14000, CPUCLK_LAYOUT_E4210, e3250_armclk_d),
 };
 
 static void __init exynos3_core_down_clock(void __iomem *reg_base)
diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 3d57020a620f..e1b7a5e0dbb8 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1252,19 +1252,19 @@ static const struct exynos_cpuclk_cfg_data e4412_armclk_d[] __initconst = {
 static const struct samsung_cpu_clock exynos4210_cpu_clks[] __initconst = {
 	CPU_CLK(CLK_ARM_CLK, "armclk", CLK_MOUT_APLL, CLK_SCLK_MPLL,
 		CLK_CPU_NEEDS_DEBUG_ALT_DIV | CLK_CPU_HAS_DIV1, 0x14000,
-		e4210_armclk_d),
+		CPUCLK_LAYOUT_E4210, e4210_armclk_d),
 };
 
 static const struct samsung_cpu_clock exynos4212_cpu_clks[] __initconst = {
 	CPU_CLK(CLK_ARM_CLK, "armclk", CLK_MOUT_APLL, CLK_MOUT_MPLL_USER_C,
 		CLK_CPU_NEEDS_DEBUG_ALT_DIV | CLK_CPU_HAS_DIV1, 0x14000,
-		e4212_armclk_d),
+		CPUCLK_LAYOUT_E4210, e4212_armclk_d),
 };
 
 static const struct samsung_cpu_clock exynos4412_cpu_clks[] __initconst = {
 	CPU_CLK(CLK_ARM_CLK, "armclk", CLK_MOUT_APLL, CLK_MOUT_MPLL_USER_C,
 		CLK_CPU_NEEDS_DEBUG_ALT_DIV | CLK_CPU_HAS_DIV1, 0x14000,
-		e4412_armclk_d),
+		CPUCLK_LAYOUT_E4210, e4412_armclk_d),
 };
 
 /* register exynos4 clocks */
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 4953da754994..36d28d466da9 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -776,7 +776,8 @@ static const struct exynos_cpuclk_cfg_data exynos5250_armclk_d[] __initconst = {
 
 static const struct samsung_cpu_clock exynos5250_cpu_clks[] __initconst = {
 	CPU_CLK(CLK_ARM_CLK, "armclk", CLK_MOUT_APLL, CLK_MOUT_MPLL,
-		CLK_CPU_HAS_DIV1, 0x0, exynos5250_armclk_d),
+		CLK_CPU_HAS_DIV1, 0x0, CPUCLK_LAYOUT_E4210,
+		exynos5250_armclk_d),
 };
 
 static const struct of_device_id ext_clk_match[] __initconst = {
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 531ef1c3fa30..f8cd28465b58 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1555,16 +1555,16 @@ static const struct exynos_cpuclk_cfg_data exynos5420_kfcclk_d[] __initconst = {
 
 static const struct samsung_cpu_clock exynos5420_cpu_clks[] __initconst = {
 	CPU_CLK(CLK_ARM_CLK, "armclk", CLK_MOUT_APLL, CLK_MOUT_MSPLL_CPU, 0,
-		0x0, exynos5420_eglclk_d),
+		0x0, CPUCLK_LAYOUT_E4210, exynos5420_eglclk_d),
 	CPU_CLK(CLK_KFC_CLK, "kfcclk", CLK_MOUT_KPLL, CLK_MOUT_MSPLL_KFC, 0,
-		0x28000, exynos5420_kfcclk_d),
+		0x28000, CPUCLK_LAYOUT_E4210, exynos5420_kfcclk_d),
 };
 
 static const struct samsung_cpu_clock exynos5800_cpu_clks[] __initconst = {
 	CPU_CLK(CLK_ARM_CLK, "armclk", CLK_MOUT_APLL, CLK_MOUT_MSPLL_CPU, 0,
-		0x0, exynos5800_eglclk_d),
+		0x0, CPUCLK_LAYOUT_E4210, exynos5800_eglclk_d),
 	CPU_CLK(CLK_KFC_CLK, "kfcclk", CLK_MOUT_KPLL, CLK_MOUT_MSPLL_KFC, 0,
-		0x28000, exynos5420_kfcclk_d),
+		0x28000, CPUCLK_LAYOUT_E4210, exynos5420_kfcclk_d),
 };
 
 static const struct of_device_id ext_clk_match[] __initconst = {
diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index 379744f0a5b6..d35901af21d0 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -3698,8 +3698,8 @@ static const struct exynos_cpuclk_cfg_data exynos5433_apolloclk_d[] __initconst
 
 static const struct samsung_cpu_clock apollo_cpu_clks[] __initconst = {
 	CPU_CLK(CLK_SCLK_APOLLO, "apolloclk", CLK_MOUT_APOLLO_PLL,
-		CLK_MOUT_BUS_PLL_APOLLO_USER, CLK_CPU_HAS_E5433_REGS_LAYOUT,
-		0x0, exynos5433_apolloclk_d),
+		CLK_MOUT_BUS_PLL_APOLLO_USER, 0, 0x0,
+		CPUCLK_LAYOUT_E5433, exynos5433_apolloclk_d),
 };
 
 static const struct samsung_cmu_info apollo_cmu_info __initconst = {
@@ -3942,8 +3942,8 @@ static const struct exynos_cpuclk_cfg_data exynos5433_atlasclk_d[] __initconst =
 
 static const struct samsung_cpu_clock atlas_cpu_clks[] __initconst = {
 	CPU_CLK(CLK_SCLK_ATLAS, "atlasclk", CLK_MOUT_ATLAS_PLL,
-		CLK_MOUT_BUS_PLL_ATLAS_USER, CLK_CPU_HAS_E5433_REGS_LAYOUT,
-		0x0, exynos5433_atlasclk_d),
+		CLK_MOUT_BUS_PLL_ATLAS_USER, 0, 0x0,
+		CPUCLK_LAYOUT_E5433, exynos5433_atlasclk_d),
 };
 
 static const struct samsung_cmu_info atlas_cmu_info __initconst = {
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 8157479f45eb..87bbb8b31b03 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -283,10 +283,11 @@ struct samsung_cpu_clock {
 	unsigned int	alt_parent_id;
 	unsigned long	flags;
 	int		offset;
+	enum exynos_cpuclk_layout reg_layout;
 	const struct exynos_cpuclk_cfg_data *cfg;
 };
 
-#define CPU_CLK(_id, _name, _pid, _apid, _flags, _offset, _cfg) \
+#define CPU_CLK(_id, _name, _pid, _apid, _flags, _offset, _layout, _cfg) \
 	{							\
 		.id		  = _id,			\
 		.name		  = _name,			\
@@ -294,6 +295,7 @@ struct samsung_cpu_clock {
 		.alt_parent_id	  = _apid,			\
 		.flags		  = _flags,			\
 		.offset		  = _offset,			\
+		.reg_layout	  = _layout,			\
 		.cfg		  = _cfg,			\
 	}
 
-- 
2.39.2


