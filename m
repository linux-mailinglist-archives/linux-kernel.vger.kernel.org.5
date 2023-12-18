Return-Path: <linux-kernel+bounces-3217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB3881695A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BEB1C225EB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F56513FE3;
	Mon, 18 Dec 2023 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="Ef95AFuj";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="JJhq0UHZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596DF12B8F;
	Mon, 18 Dec 2023 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702890439; bh=LjaOwH9UGD1qjsd41DylO0EFQhH3+r2HBaFpyCOGEtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ef95AFujTW+p0IPeSunN4wL1NmrFEdPxGTqU1UDz3ohrYnK1ZXY49IlCVT0U627Ld
	 +LOZicKSUxhRGhg8cnmwsqQfTzdEwiL/8khv9l5+0G1pf874Iko8IHSJSAlxShjqSO
	 jX+/Epp/0F0Fzc1vaiU09iQcHQUkjAju8rDsHmI2HpDosxRKscHnJjsHuIBPsXGXDt
	 zKbI0k308EY0PoVZeamuhwbFOtN6e/4p/QTRzle4QKcLm5WCxGFUG7+vyFZ7ysDVB7
	 0KCLvIiSb8slvxkn/eXyGAbjq4pQgUh5t8Yt0iHfsKYuHNVWRw8eojsPX07TXnLhcu
	 6CZUgSU41cdyQ==
Received: by gofer.mess.org (Postfix, from userid 501)
	id CF0FF100A06; Mon, 18 Dec 2023 09:07:19 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702890421; bh=LjaOwH9UGD1qjsd41DylO0EFQhH3+r2HBaFpyCOGEtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JJhq0UHZr/w0Fs0e2iqfz0fDUdsaK8ijm7rmAq6jlcaWL+tfnln7/R8UjjYXsh0ho
	 1dWUZXIVosvb+ntlRapjUN8BHaCRcNKsOrlxha0bC33sKh5Bprh6zO/Mt6Si2AB85l
	 q93/sAUXg+lwW2mIzIH6bYxV4JsCfuDOhHU2hur8EieyBKpB6g8zS7uLc4KQI5YXP6
	 hhBrEKM1ZSjzubRWOR6hKY4JlW0i350kGAYnylA5OUyFsrYrZPKzDbw+TgVaE6k5pA
	 MEH8muqZBtdp+J5T10TQ51vNrwitFGUXGLa9n++K8ngJYKMT4KSIGg+iJQRHYz8w1Z
	 xuNrGjOUGjLLw==
Received: from localhost.localdomain (bigcore-79.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id 06D361009FD;
	Mon, 18 Dec 2023 09:07:01 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Sean Young <sean@mess.org>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 5/6] pwm: bcm2835: Allow PWM driver to be used in atomic context
Date: Mon, 18 Dec 2023 09:06:46 +0000
Message-ID: <5249bb5d6c067692e4cd09573ced2df58966693b.1702890244.git.sean@mess.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702890244.git.sean@mess.org>
References: <cover.1702890244.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clk_get_rate() may do a mutex lock. Fetch the clock rate once, and prevent
rate changes using clk_rate_exclusive_get().

Signed-off-by: Sean Young <sean@mess.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/pwm/pwm-bcm2835.c | 40 +++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index ab30667f4f95..e556ae300c82 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -28,6 +28,7 @@ struct bcm2835_pwm {
 	struct device *dev;
 	void __iomem *base;
 	struct clk *clk;
+	unsigned long rate;
 };
 
 static inline struct bcm2835_pwm *to_bcm2835_pwm(struct pwm_chip *chip)
@@ -63,17 +64,11 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 
 	struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
-	unsigned long rate = clk_get_rate(pc->clk);
 	unsigned long long period_cycles;
 	u64 max_period;
 
 	u32 val;
 
-	if (!rate) {
-		dev_err(pc->dev, "failed to get clock rate\n");
-		return -EINVAL;
-	}
-
 	/*
 	 * period_cycles must be a 32 bit value, so period * rate / NSEC_PER_SEC
 	 * must be <= U32_MAX. As U32_MAX * NSEC_PER_SEC < U64_MAX the
@@ -88,13 +83,13 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * <=> period < ((U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC/2) / rate
 	 * <=> period <= ceil((U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC/2) / rate) - 1
 	 */
-	max_period = DIV_ROUND_UP_ULL((u64)U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC / 2, rate) - 1;
+	max_period = DIV_ROUND_UP_ULL((u64)U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC / 2, pc->rate) - 1;
 
 	if (state->period > max_period)
 		return -EINVAL;
 
 	/* set period */
-	period_cycles = DIV_ROUND_CLOSEST_ULL(state->period * rate, NSEC_PER_SEC);
+	period_cycles = DIV_ROUND_CLOSEST_ULL(state->period * pc->rate, NSEC_PER_SEC);
 
 	/* don't accept a period that is too small */
 	if (period_cycles < PERIOD_MIN)
@@ -103,7 +98,7 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	writel(period_cycles, pc->base + PERIOD(pwm->hwpwm));
 
 	/* set duty cycle */
-	val = DIV_ROUND_CLOSEST_ULL(state->duty_cycle * rate, NSEC_PER_SEC);
+	val = DIV_ROUND_CLOSEST_ULL(state->duty_cycle * pc->rate, NSEC_PER_SEC);
 	writel(val, pc->base + DUTY(pwm->hwpwm));
 
 	/* set polarity */
@@ -151,16 +146,40 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
 				     "clock not found\n");
 
+	ret = clk_rate_exclusive_get(pc->clk);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "fail to get exclusive rate\n");
+
+	pc->rate = clk_get_rate(pc->clk);
+	if (!pc->rate) {
+		clk_rate_exclusive_put(pc->clk);
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "failed to get clock rate\n");
+	}
+
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &bcm2835_pwm_ops;
+	pc->chip.atomic = true;
 	pc->chip.npwm = 2;
 
 	platform_set_drvdata(pdev, pc);
 
 	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
-	if (ret < 0)
+	if (ret < 0) {
+		clk_rate_exclusive_put(pc->clk);
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to add pwmchip\n");
+	}
+
+	return 0;
+}
+
+static int bcm2835_pwm_remove(struct platform_device *pdev)
+{
+	struct bcm2835_pwm *pc = platform_get_drvdata(pdev);
+
+	clk_rate_exclusive_put(pc->clk);
 
 	return 0;
 }
@@ -197,6 +216,7 @@ static struct platform_driver bcm2835_pwm_driver = {
 		.pm = pm_ptr(&bcm2835_pwm_pm_ops),
 	},
 	.probe = bcm2835_pwm_probe,
+	.remove = bcm2835_pwm_remove,
 };
 module_platform_driver(bcm2835_pwm_driver);
 
-- 
2.43.0


