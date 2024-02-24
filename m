Return-Path: <linux-kernel+bounces-79842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895F486277E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8EB28241E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495EB5102F;
	Sat, 24 Feb 2024 20:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qk5FAEkj"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1469D4EB5E
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708806064; cv=none; b=E5QIGfJ07KwPDn0YAfqiVoF1gk2jaoiO9QR5ZfPIHguCE1GW/J9MUeTpPk6+Nh97m88IPMFrAOOyjCGycA3fA/38+jmO97cW5dJe0PF+0ZscbOHkjiyrUybz+kp9iNvaFYb/jgUzrKuMHJ68+S6ULudfm4Gr51oS4P35I5xorv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708806064; c=relaxed/simple;
	bh=1ImW2IACKGUhYJ7/rOYdyKajWLj0N3ZFaS5Yy40Yw9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o1ttbse0fLmiTiJ56KrxQCyyznrzB7EGhKsfLRAMALUsVj8OOb+f4AmLeXuNeloZljg2OUgGESS029i88nIbd/LFjRDzwN43ZzlZ4TXD6VB4rmSor4vIjhbiaZ02/o5JlSNiAmKlyMC8uBahJRTek4XuKRVyKPEiYx4ExQ+dm2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qk5FAEkj; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c15b7b36bbso701630b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 12:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708806061; x=1709410861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7KoDUleWCo5UKlQBGeeXR+YMlhweLkGTgyZVq03PTg=;
        b=Qk5FAEkjrBHH8HlHdVAu9FwzTs1OZcvOlRjeq5hHbGEDMWbAVC0Rp+UsrP/uA1dkIO
         hNDPTPu3Nzi1ochSmYgkPuibYyOwknfrwgAWLo+GcMkIJ3ww52EaRN7zW10zBvJOXnLw
         6sn4JAKxYdgsYWqLbV66W8cAfNaxHcdHl9KhMK3UluqNeTAGSZjPQsy+u5WToBiCn1Kl
         A+4sAwb0uJeKLVQrpskgly/cLXxMFvASYGOc1UsownmtMX0iFQQ1CWyDwvN/Ih7psvJb
         Iab/NmG4IVxl/FYoOz4Jsc2xKwkSzGO+2VXMxnMb+6pyage8G8KKFKJG+s4RP9LcVEtr
         bZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708806061; x=1709410861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7KoDUleWCo5UKlQBGeeXR+YMlhweLkGTgyZVq03PTg=;
        b=gU+ljraBFH8KRDPbvBp2esETHEVO3wQ26ysdAacjhLVaWqklfuSWVUzHszQGnEFwd+
         P0ZlXtlfD52e8r3Kutwi2p2ByR6HmL9u8NcLKFDSRjl+Vemjg/vbkaM9zUH/UYkoUQXf
         bqNHs4LKXDF4E0UskN2l2h715jwMKjPpjXb0Pyz50aEuYQDTSe0jJssuWJgOnWw2x8Vm
         qbOdTS7oy7x/G+qIDsFWpLk5DgAB/II0f1QZPjB+8ZO/cg7cHNIMXXiPinf+n6fvD5X6
         QWsK265bjj0OyOR2jSgu6wNP7kMvs6G91sgOfl9map3hDEH85sGwJO60DfEFAG0tbtih
         v5vg==
X-Forwarded-Encrypted: i=1; AJvYcCWn95CvaCiHpQNl+2XaP0b2ghBdAZKshLsmfAvNMPb4wijEIjJX+9MUhZTCL/0x/G270RYN/GwopDgQZE06USz4NTyZx5ORHN7GoONU
X-Gm-Message-State: AOJu0Yzk4nqjOo/7pjn0zk20vpXmQbvZR4C9ptXSKwbIoTFBvCgyid+j
	7Rt/pO+MmLxbvE0UPjaKiuxg7SwUbBQIE/6iRkryuvy9xkecoaAR6awhviq9Wg0=
X-Google-Smtp-Source: AGHT+IENaAaBEvjJseobNlvF+eiZDk+l+seaHD0oo3sk7o+f/hO5ZUaGaS5Q1MrGsUHlW0icJeudIw==
X-Received: by 2002:a05:6808:f88:b0:3c1:9c5b:74a7 with SMTP id o8-20020a0568080f8800b003c19c5b74a7mr119158oiw.17.1708806061101;
        Sat, 24 Feb 2024 12:21:01 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id 22-20020aca0916000000b003c150705429sm382420oij.12.2024.02.24.12.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 12:21:00 -0800 (PST)
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
Subject: [PATCH v3 09/15] clk: samsung: Keep CPU clock chip specific data in a dedicated struct
Date: Sat, 24 Feb 2024 14:20:47 -0600
Message-Id: <20240224202053.25313-10-semen.protsenko@linaro.org>
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

Keep chip specific data in the data structure, don't mix it with code.
It makes it easier to add more chip specific data further. Having all
chip specific data in the table eliminates possible code bloat when
adding more rate handlers for new chips, and also makes it possible to
keep some other chip related data in that array.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - none

Changes in v2:
  - Improved the commit message: explained why it's beneficial for new
    chips to keep chip-specific data in one table

 drivers/clk/samsung/clk-cpu.c | 40 +++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index 635ab8cc54a2..eb2b67d08f89 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -43,6 +43,16 @@ struct exynos_cpuclk;
 typedef int (*exynos_rate_change_fn_t)(struct clk_notifier_data *ndata,
 				       struct exynos_cpuclk *cpuclk);
 
+/**
+ * struct exynos_cpuclk_chip - Chip specific data for CPU clock
+ * @pre_rate_cb: callback to run before CPU clock rate change
+ * @post_rate_cb: callback to run after CPU clock rate change
+ */
+struct exynos_cpuclk_chip {
+	exynos_rate_change_fn_t	pre_rate_cb;
+	exynos_rate_change_fn_t	post_rate_cb;
+};
+
 /**
  * struct exynos_cpuclk - information about clock supplied to a CPU core
  * @hw:		handle between CCF and CPU clock
@@ -55,8 +65,7 @@ typedef int (*exynos_rate_change_fn_t)(struct clk_notifier_data *ndata,
  * @clk_nb:	clock notifier registered for changes in clock speed of the
  *		primary parent clock
  * @flags:	configuration flags for the CPU clock
- * @pre_rate_cb: callback to run before CPU clock rate change
- * @post_rate_cb: callback to run after CPU clock rate change
+ * @chip:	chip-specific data for the CPU clock
  *
  * This structure holds information required for programming the CPU clock for
  * various clock speeds.
@@ -70,9 +79,7 @@ struct exynos_cpuclk {
 	const unsigned long			num_cfgs;
 	struct notifier_block			clk_nb;
 	unsigned long				flags;
-
-	exynos_rate_change_fn_t			pre_rate_cb;
-	exynos_rate_change_fn_t			post_rate_cb;
+	const struct exynos_cpuclk_chip		*chip;
 };
 
 /* ---- Common code --------------------------------------------------------- */
@@ -420,13 +427,24 @@ static int exynos_cpuclk_notifier_cb(struct notifier_block *nb,
 	cpuclk = container_of(nb, struct exynos_cpuclk, clk_nb);
 
 	if (event == PRE_RATE_CHANGE)
-		err = cpuclk->pre_rate_cb(ndata, cpuclk);
+		err = cpuclk->chip->pre_rate_cb(ndata, cpuclk);
 	else if (event == POST_RATE_CHANGE)
-		err = cpuclk->post_rate_cb(ndata, cpuclk);
+		err = cpuclk->chip->post_rate_cb(ndata, cpuclk);
 
 	return notifier_from_errno(err);
 }
 
+static const struct exynos_cpuclk_chip exynos_clkcpu_chips[] = {
+	[CPUCLK_LAYOUT_E4210] = {
+		.pre_rate_cb	= exynos_cpuclk_pre_rate_change,
+		.post_rate_cb	= exynos_cpuclk_post_rate_change,
+	},
+	[CPUCLK_LAYOUT_E5433] = {
+		.pre_rate_cb	= exynos5433_cpuclk_pre_rate_change,
+		.post_rate_cb	= exynos5433_cpuclk_post_rate_change,
+	},
+};
+
 /* helper function to register a CPU clock */
 static int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
 				const struct samsung_cpu_clock *clk_data)
@@ -465,13 +483,7 @@ static int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
 	cpuclk->lock = &ctx->lock;
 	cpuclk->flags = clk_data->flags;
 	cpuclk->clk_nb.notifier_call = exynos_cpuclk_notifier_cb;
-	if (clk_data->reg_layout == CPUCLK_LAYOUT_E5433) {
-		cpuclk->pre_rate_cb = exynos5433_cpuclk_pre_rate_change;
-		cpuclk->post_rate_cb = exynos5433_cpuclk_post_rate_change;
-	} else {
-		cpuclk->pre_rate_cb = exynos_cpuclk_pre_rate_change;
-		cpuclk->post_rate_cb = exynos_cpuclk_post_rate_change;
-	}
+	cpuclk->chip = &exynos_clkcpu_chips[clk_data->reg_layout];
 
 	ret = clk_notifier_register(parent->clk, &cpuclk->clk_nb);
 	if (ret) {
-- 
2.39.2


