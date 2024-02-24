Return-Path: <linux-kernel+bounces-79844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02061862782
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DB37B21E3F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DDD5338F;
	Sat, 24 Feb 2024 20:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qMqoYQjc"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D2B50A70
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708806066; cv=none; b=gYFNNZGOTReXu/UyQyPA7VZvZeS7CuM+nqo6IM9MSxO6jUIMHIOWv6OTtiJPchI9C0fximcyEEO/E0xGe9a/I2llGzIBVCJLzLuIlfHvuStpyn+KMP6hZfAGNIyy6zUGZyr0kPAelv2tQex8jpSwdDXW3EaZK9u5KGq4p5NG34Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708806066; c=relaxed/simple;
	bh=9SoRSzxWcGaydbHrFDSNHoHFdfw9AKcnZIpgUrABSWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J9gTp/7jHy4gB4fU+Y5nIPFkOvEUnj+zH+JrO0C6W4sy4OTwzaOvLLLMKCz4Vn9nHnhtqJVMJnJZFqaRTzJobTerb6ESIlSJHvTvKkFTBW9r3TMXy7oJp0sQU8F1L65RAUD8xLZQdgPEme2FVOJIBIxs9Cg64lGMJOj8EzYyq+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qMqoYQjc; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e47a0fad63so576202a34.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 12:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708806063; x=1709410863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxynHCX6n2NFtKK18h8LwX8Im2S2Zjm5Bqoy0lY/gAg=;
        b=qMqoYQjcM0+EZhrIXFTcImYo10vWsVnxqKJrNkIBbPjD9s/6860xni1sLr4DfW7pBO
         YJcziO5e7ODz6E93D13CgHeYuc/4qNlfsEchulxLKMd++m8iMQVlGUEkGwmfcmQUbocz
         hPpRfsUa7YQr9W0Lo7FfYgKCtGVOWN/6yI3WL/WcKJarpBtD5sRnCHm14E26brW0XnQ9
         d0a2gg1IKTWw+xe1lDdlFqksPOWAbN24bZdo0loEqtdQg4D4LrmehDug4RZr4aFg7UVD
         fnBaTios5IT+K7K5jV6P7QlhMXrD+CObSf9BeRWlLQ3c6TEu+O3DrVVmE08sdp6P1lxh
         QESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708806063; x=1709410863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxynHCX6n2NFtKK18h8LwX8Im2S2Zjm5Bqoy0lY/gAg=;
        b=XjCxPEt31CT36AqwMcoupW4WAUIY44SjVRk6rufLnPhujOFDGs2gPLmQP6oS0bBhwZ
         UOcYyFRC+eyKEYSbmjWMXrDhJReeHUb2Qs52hhHOFhzWh3OkJg4F4gCP3U7IGUFLISC9
         4j4Xj4cqZ22dCaT6N9PhwtBA2Bnp01tk6nS+O8BbQwLn9ZS7ZO+qEEaQwEIrZb7nC84c
         z3YWwLiNomSUIhkobVswHBlXT7ybCTTnrM2rAF7xq5Bf7JHBvvup2usnpuXhSfWzGIkG
         DQrjwH/5MZ6uzb06Oy18dleA/zWvj50Ilyll4XBfgk1SovvXXj9S0S5FkhNFMQLCV7Nr
         ixEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbiMkPnMcXkajkRb5TbY48BpRyDf2in2r/ACm82qiwYxZ8Gqxr3jnpuEM4HttxOHeZhetDMsoO4HM58YyvvhRSu+UzOtvNAJz8DwO2
X-Gm-Message-State: AOJu0Yy25FodHAL5J3MPY6q1DSqCeGN13ndPo7cjOQIMUY+fXqHK3fIM
	LjzgCMKfcpQQKs0stgCc+LHhcwPXmLfmcx+Wq0nSF1kjOy00AjPOrziaOQFmTA4=
X-Google-Smtp-Source: AGHT+IFnDJ/rs9ipgn5drE3Y9e4JSbMKRailfOBMuRxXVrrb84Xu0Nn8Lvf8nI4GGCITh/z9FbQ+3w==
X-Received: by 2002:a9d:4e93:0:b0:6e4:8456:c362 with SMTP id v19-20020a9d4e93000000b006e48456c362mr1406094otk.14.1708806062983;
        Sat, 24 Feb 2024 12:21:02 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id n17-20020a4a3451000000b005a02b453ff8sm448112oof.45.2024.02.24.12.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 12:21:02 -0800 (PST)
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
Subject: [PATCH v3 11/15] clk: samsung: Pass mask to wait_until_mux_stable()
Date: Sat, 24 Feb 2024 14:20:49 -0600
Message-Id: <20240224202053.25313-12-semen.protsenko@linaro.org>
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

Make it possible to use wait_until_mux_stable() for MUX registers where
the mask is different from MUX_MASK (e.g. in upcoming CPU clock
implementation for Exynos850).

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - none

Changes in v2:
  - none

 drivers/clk/samsung/clk-cpu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index e29d08a1c8b3..0cf288138167 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -135,16 +135,16 @@ static void wait_until_divider_stable(void __iomem *div_reg, unsigned long mask)
  * value was changed.
  */
 static void wait_until_mux_stable(void __iomem *mux_reg, u32 mux_pos,
-				  unsigned long mux_value)
+				  unsigned long mask, unsigned long mux_value)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(MAX_STAB_TIME);
 
 	do {
-		if (((readl(mux_reg) >> mux_pos) & MUX_MASK) == mux_value)
+		if (((readl(mux_reg) >> mux_pos) & mask) == mux_value)
 			return;
 	} while (time_before(jiffies, timeout));
 
-	if (((readl(mux_reg) >> mux_pos) & MUX_MASK) == mux_value)
+	if (((readl(mux_reg) >> mux_pos) & mask) == mux_value)
 		return;
 
 	pr_err("%s: re-parenting mux timed-out\n", __func__);
@@ -249,7 +249,7 @@ static int exynos_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 	/* select sclk_mpll as the alternate parent */
 	mux_reg = readl(base + regs->mux_sel);
 	writel(mux_reg | (1 << 16), base + regs->mux_sel);
-	wait_until_mux_stable(base + regs->mux_stat, 16, 2);
+	wait_until_mux_stable(base + regs->mux_stat, 16, MUX_MASK, 2);
 
 	/* alternate parent is active now. set the dividers */
 	writel(div0, base + regs->div_cpu0);
@@ -290,7 +290,7 @@ static int exynos_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
 	/* select mout_apll as the alternate parent */
 	mux_reg = readl(base + regs->mux_sel);
 	writel(mux_reg & ~(1 << 16), base + regs->mux_sel);
-	wait_until_mux_stable(base + regs->mux_stat, 16, 1);
+	wait_until_mux_stable(base + regs->mux_stat, 16, MUX_MASK, 1);
 
 	if (cpuclk->flags & CLK_CPU_NEEDS_DEBUG_ALT_DIV) {
 		div |= (cfg_data->div0 & E4210_DIV0_ATB_MASK);
@@ -362,7 +362,7 @@ static int exynos5433_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 	/* select the alternate parent */
 	mux_reg = readl(base + regs->mux_sel);
 	writel(mux_reg | 1, base + regs->mux_sel);
-	wait_until_mux_stable(base + regs->mux_stat, 0, 2);
+	wait_until_mux_stable(base + regs->mux_stat, 0, MUX_MASK, 2);
 
 	/* alternate parent is active now. set the dividers */
 	writel(div0, base + regs->div_cpu0);
@@ -390,7 +390,7 @@ static int exynos5433_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
 	/* select apll as the alternate parent */
 	mux_reg = readl(base + regs->mux_sel);
 	writel(mux_reg & ~1, base + regs->mux_sel);
-	wait_until_mux_stable(base + regs->mux_stat, 0, 1);
+	wait_until_mux_stable(base + regs->mux_stat, 0, MUX_MASK, 1);
 
 	exynos_set_safe_div(cpuclk, div, div_mask);
 	spin_unlock_irqrestore(cpuclk->lock, flags);
-- 
2.39.2


