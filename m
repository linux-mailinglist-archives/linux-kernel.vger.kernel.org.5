Return-Path: <linux-kernel+bounces-115807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9188894B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49F1296177
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51C73736ED;
	Mon, 25 Mar 2024 03:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jne2TL4X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD23E145FEC;
	Sun, 24 Mar 2024 23:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322049; cv=none; b=iilCS8ClggEyFEOsFLmExXctBYK/eTRa/Zfg/NGpBRcE/QwiYepnD+ShdMMlQ0RHRhpiNxxfvWPFR5M9rAYuECiMyTdN9mEa3QCkS4xbPDPzV+eOQyvJyRGcKbuxpaDy41w/9AiH1q/5VU5itTwg81QtEEQkVDe2MQicqBumZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322049; c=relaxed/simple;
	bh=akUmTWz/zsZ2kenJnJwgx9OQCKZ8/xx+LY8+fSU5Lyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3H1nZuHoxxC65y/Q2ToFGAkvbIn4OZulPbrLgyDY5qP9WHt9UtHms8+0R4CDBohNSL33bavMOB9FF+bWKj0SDouzynIaxZyBrKWWwSjiytszsB5zHtb9OjOq1yNZAE+L86zBX1Ia8LAAysuGytoGQfBpon1gD+Utm9lkjNuMZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jne2TL4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1054DC433C7;
	Sun, 24 Mar 2024 23:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322049;
	bh=akUmTWz/zsZ2kenJnJwgx9OQCKZ8/xx+LY8+fSU5Lyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jne2TL4XJLxrqySoEO8zkGLxDIDcP5EqMFK3GcuFvQdb9pvXChTdy2azb1oCren2C
	 eSfYD5tFMZJ2F4H+FijA0jl3K/snhmM359s9j1qksIc4YKhbE6j17b074BQtxnoepk
	 hFKXBoQU2g5eKitIjvUsBQbwauzEf9GPO2zi/KqEvSdicYndx/efw3kt2xzBLBFxpA
	 TgmsH7MV88XEPRD4IKvvHmnSyQHVXflAFv3MlAdkJfEg4wplCmkKEoMUlLeUI7SL2w
	 bWt5mvIEAuutBscb7w4r8cJPtEC2wPmX1MWpctaV2ghUmGJoOKrZ5uHW7kwd8wSe2f
	 /9Ek28WrCxt4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 122/451] pwm: atmel-hlcdc: Use consistent variable naming
Date: Sun, 24 Mar 2024 19:06:38 -0400
Message-ID: <20240324231207.1351418-123-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit aecab554b6ffa9a94ba796031eb39ea20eb60fb3 ]

In PWM drivers the variable name "chip" is usually only used for struct
pwm_chip pointers. This driver however used "chip" for its driver data
and pwm_chip pointers are named "chip", too, when there is no driver
data around and "c" otherwise. Instead use "atmel" for driver data and
always "chip" for pwm_chips.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
[thierry.reding@gmail.com: replace ddata by atmel]
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Stable-dep-of: e25ac87d3f83 ("pwm: atmel-hlcdc: Fix clock imbalance related to suspend support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 65 ++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 96a709a9d49a8..4d0b859d0ac13 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -38,11 +38,11 @@ static inline struct atmel_hlcdc_pwm *to_atmel_hlcdc_pwm(struct pwm_chip *chip)
 	return container_of(chip, struct atmel_hlcdc_pwm, chip);
 }
 
-static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
+static int atmel_hlcdc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 				 const struct pwm_state *state)
 {
-	struct atmel_hlcdc_pwm *chip = to_atmel_hlcdc_pwm(c);
-	struct atmel_hlcdc *hlcdc = chip->hlcdc;
+	struct atmel_hlcdc_pwm *atmel = to_atmel_hlcdc_pwm(chip);
+	struct atmel_hlcdc *hlcdc = atmel->hlcdc;
 	unsigned int status;
 	int ret;
 
@@ -54,7 +54,7 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 		u32 pwmcfg;
 		int pres;
 
-		if (!chip->errata || !chip->errata->slow_clk_erratum) {
+		if (!atmel->errata || !atmel->errata->slow_clk_erratum) {
 			clk_freq = clk_get_rate(new_clk);
 			if (!clk_freq)
 				return -EINVAL;
@@ -64,7 +64,7 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 		}
 
 		/* Errata: cannot use slow clk on some IP revisions */
-		if ((chip->errata && chip->errata->slow_clk_erratum) ||
+		if ((atmel->errata && atmel->errata->slow_clk_erratum) ||
 		    clk_period_ns > state->period) {
 			new_clk = hlcdc->sys_clk;
 			clk_freq = clk_get_rate(new_clk);
@@ -77,8 +77,8 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 
 		for (pres = 0; pres <= ATMEL_HLCDC_PWMPS_MAX; pres++) {
 		/* Errata: cannot divide by 1 on some IP revisions */
-			if (!pres && chip->errata &&
-			    chip->errata->div1_clk_erratum)
+			if (!pres && atmel->errata &&
+			    atmel->errata->div1_clk_erratum)
 				continue;
 
 			if ((clk_period_ns << pres) >= state->period)
@@ -90,7 +90,7 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 
 		pwmcfg = ATMEL_HLCDC_PWMPS(pres);
 
-		if (new_clk != chip->cur_clk) {
+		if (new_clk != atmel->cur_clk) {
 			u32 gencfg = 0;
 			int ret;
 
@@ -98,8 +98,8 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 			if (ret)
 				return ret;
 
-			clk_disable_unprepare(chip->cur_clk);
-			chip->cur_clk = new_clk;
+			clk_disable_unprepare(atmel->cur_clk);
+			atmel->cur_clk = new_clk;
 
 			if (new_clk == hlcdc->sys_clk)
 				gencfg = ATMEL_HLCDC_CLKPWMSEL;
@@ -160,8 +160,8 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 		if (ret)
 			return ret;
 
-		clk_disable_unprepare(chip->cur_clk);
-		chip->cur_clk = NULL;
+		clk_disable_unprepare(atmel->cur_clk);
+		atmel->cur_clk = NULL;
 	}
 
 	return 0;
@@ -183,31 +183,32 @@ static const struct atmel_hlcdc_pwm_errata atmel_hlcdc_pwm_sama5d3_errata = {
 #ifdef CONFIG_PM_SLEEP
 static int atmel_hlcdc_pwm_suspend(struct device *dev)
 {
-	struct atmel_hlcdc_pwm *chip = dev_get_drvdata(dev);
+	struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
 
 	/* Keep the periph clock enabled if the PWM is still running. */
-	if (pwm_is_enabled(&chip->chip.pwms[0]))
-		clk_disable_unprepare(chip->hlcdc->periph_clk);
+	if (pwm_is_enabled(&atmel->chip.pwms[0]))
+		clk_disable_unprepare(atmel->hlcdc->periph_clk);
 
 	return 0;
 }
 
 static int atmel_hlcdc_pwm_resume(struct device *dev)
 {
-	struct atmel_hlcdc_pwm *chip = dev_get_drvdata(dev);
+	struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
 	struct pwm_state state;
 	int ret;
 
-	pwm_get_state(&chip->chip.pwms[0], &state);
+	pwm_get_state(&atmel->chip.pwms[0], &state);
 
 	/* Re-enable the periph clock it was stopped during suspend. */
 	if (!state.enabled) {
-		ret = clk_prepare_enable(chip->hlcdc->periph_clk);
+		ret = clk_prepare_enable(atmel->hlcdc->periph_clk);
 		if (ret)
 			return ret;
 	}
 
-	return atmel_hlcdc_pwm_apply(&chip->chip, &chip->chip.pwms[0], &state);
+	return atmel_hlcdc_pwm_apply(&atmel->chip, &atmel->chip.pwms[0],
+				     &state);
 }
 #endif
 
@@ -244,14 +245,14 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
-	struct atmel_hlcdc_pwm *chip;
+	struct atmel_hlcdc_pwm *atmel;
 	struct atmel_hlcdc *hlcdc;
 	int ret;
 
 	hlcdc = dev_get_drvdata(dev->parent);
 
-	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
-	if (!chip)
+	atmel = devm_kzalloc(dev, sizeof(*atmel), GFP_KERNEL);
+	if (!atmel)
 		return -ENOMEM;
 
 	ret = clk_prepare_enable(hlcdc->periph_clk);
@@ -260,31 +261,31 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 
 	match = of_match_node(atmel_hlcdc_dt_ids, dev->parent->of_node);
 	if (match)
-		chip->errata = match->data;
+		atmel->errata = match->data;
 
-	chip->hlcdc = hlcdc;
-	chip->chip.ops = &atmel_hlcdc_pwm_ops;
-	chip->chip.dev = dev;
-	chip->chip.npwm = 1;
+	atmel->hlcdc = hlcdc;
+	atmel->chip.ops = &atmel_hlcdc_pwm_ops;
+	atmel->chip.dev = dev;
+	atmel->chip.npwm = 1;
 
-	ret = pwmchip_add(&chip->chip);
+	ret = pwmchip_add(&atmel->chip);
 	if (ret) {
 		clk_disable_unprepare(hlcdc->periph_clk);
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, chip);
+	platform_set_drvdata(pdev, atmel);
 
 	return 0;
 }
 
 static void atmel_hlcdc_pwm_remove(struct platform_device *pdev)
 {
-	struct atmel_hlcdc_pwm *chip = platform_get_drvdata(pdev);
+	struct atmel_hlcdc_pwm *atmel = platform_get_drvdata(pdev);
 
-	pwmchip_remove(&chip->chip);
+	pwmchip_remove(&atmel->chip);
 
-	clk_disable_unprepare(chip->hlcdc->periph_clk);
+	clk_disable_unprepare(atmel->hlcdc->periph_clk);
 }
 
 static const struct of_device_id atmel_hlcdc_pwm_dt_ids[] = {
-- 
2.43.0


