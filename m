Return-Path: <linux-kernel+bounces-5565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CD2818C58
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D731C241C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4903931A7F;
	Tue, 19 Dec 2023 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="tUvnul4Y";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="dNJnBW58"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B5A210EC;
	Tue, 19 Dec 2023 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1703003468; bh=uUf3zxmOYbpHbQdPmRJIHAbIUbLSVg5+6TD2Zc3o9Ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tUvnul4YU3uRyaHPOY+Hd5w5TnG2MszE5+Vvm7WCc/Oy4eTRnvFGzObEhPDinpcSv
	 IaCOvBvmj5jJpq3b6EQYfU5ARUU6rT93bMVpz+syxIPqYIFNZ/PacQq9RlCCOpfRnx
	 IO5upqGyQYVrvG63iutpU9sZiHv0fMiw9JWEEPJGuXQGfEpkXgvdfarIscc+pokUD6
	 CB07HGp3EqgTYj2MiIXGH7xaKKc4btoOrnIRteb/LBklA/ob4XiwLxIK9lcuIPKby2
	 4FarnA7+TeeRhJqtEU+/eLmAVrwF+sZpZr7FwmzmzQ9qkKqIPTO5hpz7TjYca7wWbM
	 Xu5BCJzw9DZIA==
Received: by gofer.mess.org (Postfix, from userid 501)
	id 7A96F100A03; Tue, 19 Dec 2023 16:31:08 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1703003449; bh=uUf3zxmOYbpHbQdPmRJIHAbIUbLSVg5+6TD2Zc3o9Ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dNJnBW582nDvd33QqAoyQHVEL3FUPnDHJ2VkfvM33QXCUHAC2w1qKFXrntsGF/CCV
	 SMBbb2eBbKPIpj5EE+2HeHZkrV3p8GNVnNNbWE8oyCkJCqf+c9MQ3T78wbHn+3XiQ/
	 bryAdBHzinfQNaMk6/BLA6M3IHBCYzJMrklc/yA4vgCRkfqi9jM/XyimvqqasDRuxC
	 pH16vlRs8S03L5J4xW5/uasoeLtPpCPzixLWBCCE1QWNKKkglzpVmKmCkMnUcjrJfB
	 6hoSgVVfImSqlO8kOF6EO4PeWCeuhR/eaIGovsM1zVsi0fMWJ4D9PIu2CtmqDF8n7k
	 XhPy15NsK/pXw==
Received: from localhost.localdomain (bigcore.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id 7E1191009FD;
	Tue, 19 Dec 2023 16:30:49 +0000 (GMT)
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
Subject: [PATCH v10 5/6] pwm: bcm2835: Allow PWM driver to be used in atomic context
Date: Tue, 19 Dec 2023 16:30:28 +0000
Message-ID: <6c5852c902e6603571e4fde5955d1aeb537059ba.1703003288.git.sean@mess.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703003288.git.sean@mess.org>
References: <cover.1703003288.git.sean@mess.org>
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
 drivers/pwm/pwm-bcm2835.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index ab30667f4f95..d9ac50a5b04e 100644
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
@@ -131,6 +126,13 @@ static const struct pwm_ops bcm2835_pwm_ops = {
 	.apply = bcm2835_pwm_apply,
 };
 
+static void devm_clk_rate_exclusive_put(void *data)
+{
+	struct clk *clk = data;
+
+	clk_rate_exclusive_put(clk);
+}
+
 static int bcm2835_pwm_probe(struct platform_device *pdev)
 {
 	struct bcm2835_pwm *pc;
@@ -151,8 +153,22 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
 				     "clock not found\n");
 
+	ret = clk_rate_exclusive_get(pc->clk);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "fail to get exclusive rate\n");
+
+	devm_add_action_or_reset(&pdev->dev, devm_clk_rate_exclusive_put,
+				 pc->clk);
+
+	pc->rate = clk_get_rate(pc->clk);
+	if (!pc->rate)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "failed to get clock rate\n");
+
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &bcm2835_pwm_ops;
+	pc->chip.atomic = true;
 	pc->chip.npwm = 2;
 
 	platform_set_drvdata(pdev, pc);
-- 
2.43.0


