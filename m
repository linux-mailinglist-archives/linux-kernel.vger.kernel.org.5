Return-Path: <linux-kernel+bounces-15422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB551822BC3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8871F240A2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2387218E10;
	Wed,  3 Jan 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvUjVxy9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967C018E0D;
	Wed,  3 Jan 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d9344f30caso232857b3a.1;
        Wed, 03 Jan 2024 03:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704279747; x=1704884547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1gaN9BKDsQUkFUJbKrfBfCdHosQE6/nsF3X2hMHg0A=;
        b=AvUjVxy9aTFum53KISw0j8MpoeLS4b1rG7/bL/KZknO5BBAYRhR+ki1YDa5qr/NT1C
         MDbY/V+bHZ5b1Cc02tnWQTjbsz+hipz8ucZ23fwXpmC96OwAXnP4K3WozqO/9jYLAzV4
         9DL3mvh1Aw7/RhQaB4I5h9yHPdIfewQ+mb4CX9cxPFsqmtmjPzj7Tlj7qRhKe1/itphS
         9gd8VFfAsStp9s2rNz4zaJZuHyWoV4SN+1mqXqTGohL194RpsVVson+PDmhYHrvGbGE6
         hU+BDFaXRR9tXDjWb0p1Q8rDHKbm7rbRSBd7iwYQ3JP2cQOCpW39NUEuqaiMwOwX0ZCW
         U09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704279747; x=1704884547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1gaN9BKDsQUkFUJbKrfBfCdHosQE6/nsF3X2hMHg0A=;
        b=Oo+P+qAjOJM6S8dP/co3QfmDnNnuCnjQZ5xOyluRP3x1rI0KZ38pKwny3ncPcCZo8A
         s0GRoF04SRGx6hm4lT8Ip1VhrdJ75KFRKUAteeV2veXIjdDF2nFYtIwJIqUKPRlgwd1V
         m4AqCEzcv20U6p5rNoXK0XenOkPaxs2afDBgD7X75uR6BHqjBdcjcXmBpbkBRBz6+dC1
         7qpt61dC05icIkXgwN5EspKqyCIXLHbaON2NQrk3I2/08oOi7NCxT5wCEeryVuzHTZzV
         77AU4bzQavKb0gVdlgDkz31XRZfxPRWXP3jvz2fVYCr/cC/0KxgccXVL9Hdi3CJY4C6Z
         5mdA==
X-Gm-Message-State: AOJu0YxoaHEi5IpMt+phohBePhirEqdifipv79l4+L6Qi7huD8nA/yaL
	dhQd2kixaJSmuaG1qVxOetY=
X-Google-Smtp-Source: AGHT+IEgRmIQSnuTH5P7fHzNNRsHgCmWlhpKrPFbzC6+mjVYdH4kZMMcb7e7+f5ACaBuhP5WFQJmBg==
X-Received: by 2002:a05:6a20:3d8b:b0:196:2772:f810 with SMTP id s11-20020a056a203d8b00b001962772f810mr1275858pzi.2.1704279746771;
        Wed, 03 Jan 2024 03:02:26 -0800 (PST)
Received: from localhost.localdomain ([2409:4042:4d3f:759f:609c:feb6:c912:4906])
        by smtp.gmail.com with ESMTPSA id y9-20020aa793c9000000b006d49ed3eff2sm20232790pff.75.2024.01.03.03.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 03:02:26 -0800 (PST)
From: pratikmanvar09@gmail.com
To: francesco@dolcini.it
Cc: festevam@gmail.com,
	jun.li@nxp.com,
	kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	pratik.manvar@ifm.com,
	pratikmanvar09@gmail.com,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org,
	thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de,
	xiaoning.wang@nxp.com
Subject: [PATCH v3] pwm: imx27: workaround of the pwm output bug
Date: Wed,  3 Jan 2024 16:32:00 +0530
Message-Id: <20240103110200.1018-1-pratikmanvar09@gmail.com>
X-Mailer: git-send-email 2.39.1.windows.1
In-Reply-To: <20240103103421.GA3758@francesco-nb>
References: <20240103103421.GA3758@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Clark Wang <xiaoning.wang@nxp.com>

This fixes the pwm output bug when decrease the duty cycle.
This is a limited workaround for the PWM IP issue TKT0577206.

Root cause:
When the SAR FIFO is empty, the new write value will be directly applied
to SAR even the current period is not over.
If the new SAR value is less than the old one, and the counter is
greater than the new SAR value, the current period will not filp the
level. This will result in a pulse with a duty cycle of 100%.

Workaround:
Add an old value SAR write before updating the new duty cycle to SAR.
This will keep the new value is always in a not empty fifo, and can be
wait to update after a period finished.

Limitation:
This workaround can only solve this issue when the PWM period is longer
than 2us(or <500KHz).

Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Link: https://github.com/nxp-imx/linux-imx/commit/16181cc4eee61d87cbaba0e5a479990507816317
Tested-by: Pratik Manvar <pratik.manvar@ifm.com>
Signed-off-by: Pratik Manvar <pratik.manvar@ifm.com>
---
 V1 -> V2: fix sparse warnings reported-by: kernel test robot <lkp@intel.com>
           Closes: https://lore.kernel.org/oe-kbuild-all/202312300907.RGtYsKxb-lkp@intel.com/
 V2 -> V3: Add signed-off-by as suggested by `Francesco Dolcini`

 drivers/pwm/pwm-imx27.c | 67 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 7d9bc43f12b0..1e500a5bf564 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -21,11 +21,13 @@
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 
 #define MX3_PWMCR			0x00    /* PWM Control Register */
 #define MX3_PWMSR			0x04    /* PWM Status Register */
 #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
 #define MX3_PWMPR			0x10    /* PWM Period Register */
+#define MX3_PWMCNR			0x14    /* PWM Counter Register */
 
 #define MX3_PWMCR_FWM			GENMASK(27, 26)
 #define MX3_PWMCR_STOPEN		BIT(25)
@@ -91,6 +93,7 @@ struct pwm_imx27_chip {
 	 * value to return in that case.
 	 */
 	unsigned int duty_cycle;
+	spinlock_t lock;
 };
 
 #define to_pwm_imx27_chip(chip)	container_of(chip, struct pwm_imx27_chip, chip)
@@ -203,10 +206,10 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
 
 	sr = readl(imx->mmio_base + MX3_PWMSR);
 	fifoav = FIELD_GET(MX3_PWMSR_FIFOAV, sr);
-	if (fifoav == MX3_PWMSR_FIFOAV_4WORDS) {
+	if (fifoav >= MX3_PWMSR_FIFOAV_3WORDS) {
 		period_ms = DIV_ROUND_UP_ULL(pwm_get_period(pwm),
 					 NSEC_PER_MSEC);
-		msleep(period_ms);
+		msleep(period_ms * (fifoav - 2));
 
 		sr = readl(imx->mmio_base + MX3_PWMSR);
 		if (fifoav == FIELD_GET(MX3_PWMSR_FIFOAV, sr))
@@ -217,13 +220,15 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
 static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			   const struct pwm_state *state)
 {
-	unsigned long period_cycles, duty_cycles, prescale;
+	unsigned long period_cycles, duty_cycles, prescale, counter_check, flags;
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
+	void __iomem *reg_sar = imx->mmio_base + MX3_PWMSAR;
+	__force u32 sar_last, sar_current;
 	struct pwm_state cstate;
 	unsigned long long c;
 	unsigned long long clkrate;
 	int ret;
-	u32 cr;
+	u32 cr, timeout = 1000;
 
 	pwm_get_state(pwm, &cstate);
 
@@ -264,7 +269,57 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		pwm_imx27_sw_reset(chip);
 	}
 
-	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+	/*
+	 * This is a limited workaround. When the SAR FIFO is empty, the new
+	 * write value will be directly applied to SAR even the current period
+	 * is not over.
+	 * If the new SAR value is less than the old one, and the counter is
+	 * greater than the new SAR value, the current period will not filp
+	 * the level. This will result in a pulse with a duty cycle of 100%.
+	 * So, writing the current value of the SAR to SAR here before updating
+	 * the new SAR value can avoid this issue.
+	 *
+	 * Add a spin lock and turn off the interrupt to ensure that the
+	 * real-time performance can be guaranteed as much as possible when
+	 * operating the following operations.
+	 *
+	 * 1. Add a threshold of 1.5us. If the time T between the read current
+	 * count value CNR and the end of the cycle is less than 1.5us, wait
+	 * for T to be longer than 1.5us before updating the SAR register.
+	 * This is to avoid the situation that when the first SAR is written,
+	 * the current cycle just ends and the SAR FIFO that just be written
+	 * is emptied again.
+	 *
+	 * 2. Use __raw_writel() to minimize the interval between two writes to
+	 * the SAR register to increase the fastest pwm frequency supported.
+	 *
+	 * When the PWM period is longer than 2us(or <500KHz), this workaround
+	 * can solve this problem.
+	 */
+	if (duty_cycles < imx->duty_cycle) {
+		c = clkrate * 1500;
+		do_div(c, NSEC_PER_SEC);
+		counter_check = c;
+		sar_last = (__force u32) cpu_to_le32(imx->duty_cycle);
+		sar_current = (__force u32) cpu_to_le32(duty_cycles);
+
+		spin_lock_irqsave(&imx->lock, flags);
+		if (state->period >= 2000) {
+			while ((period_cycles -
+				readl_relaxed(imx->mmio_base + MX3_PWMCNR))
+				< counter_check) {
+				if (!--timeout)
+					break;
+			};
+		}
+		if (!(MX3_PWMSR_FIFOAV &
+		      readl_relaxed(imx->mmio_base + MX3_PWMSR)))
+			__raw_writel(sar_last, reg_sar);
+		__raw_writel(sar_current, reg_sar);
+		spin_unlock_irqrestore(&imx->lock, flags);
+	} else
+		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+
 	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
 
 	/*
@@ -324,6 +379,8 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),
 				     "failed to get peripheral clock\n");
 
+	spin_lock_init(&imx->lock);
+	imx->duty_cycle = 0;
 	imx->chip.ops = &pwm_imx27_ops;
 	imx->chip.dev = &pdev->dev;
 	imx->chip.npwm = 1;
-- 
2.25.1


