Return-Path: <linux-kernel+bounces-15216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC24682286E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD971C22F7F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6E4179A4;
	Wed,  3 Jan 2024 06:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkNHOTlU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91FD14F82;
	Wed,  3 Jan 2024 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3ef33e68dso1139365ad.1;
        Tue, 02 Jan 2024 22:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704263769; x=1704868569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+MBTamTfaPyaYjpkNQL2PokE1w8PaRTeTsUSGY4kEI=;
        b=CkNHOTlUhjD3rGEXTBOsmvg6qARh4YTOyWBxnBVQ42mUPPp2KJIutwAFS1A4Dws8XZ
         lZ6lF0uKrqkLUCKcm9iU5i9FkvBWTrlejVkqqItn2kkFcD70y49ajpL/QaQLWliEPT0y
         DoieMmT6vfx78ofIHKperataMa8FCI1xIXwzIZW1jyB1Zy79V09eHgEyee4lpLRdaRiz
         hjHWjIBW8QccLP9j+8j2rMpQh8IoAMjZvXF8XjZK7/6fr/YYYhaziWGB6+7Q73X2mOJo
         c/ZRcrBP3C8elJbR1GEv0sNET+0MyjHl/pQpcK3G5RmuyXHUGXnpSHUNKqA8hqbZybVz
         DUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704263769; x=1704868569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+MBTamTfaPyaYjpkNQL2PokE1w8PaRTeTsUSGY4kEI=;
        b=NS16enrOylZwSSFJAQtTtIwvgNOjuGHZLZKZMcWBucHkiMI9ZFVRXVUT+6hpxqLfRo
         oJdYYKzjKudZak4t3ucpZXpovufB7v0NswXXHhFVL4OGupUBNSbFZnYrTTWs9YyXWQef
         uFtKrq0ooUzTWPCqlUnYMJ8fcR9KNhfTo4XzuIukgSn2WXdqlr5bvAkQUiHZtWms1Gpd
         SAIfLU1EBjespbYgZFZ4xv42NFPj9TjC+WWtUOW10LQypodXmSjdp/FGVzaJL99mroN+
         eXj1yNgQmg7HaCZD0V4iykOvzUjHIaM9nT14DUj67VRLVqTg92dCU1hDScssRFRWQQId
         JYjQ==
X-Gm-Message-State: AOJu0Ywxe0giYwpbkoCz3kdtdgRn1RCg79wEckqBI3R+24AkAnSLbSzK
	4QhnVqdP3FVb7Rtg5Mkl/Ps=
X-Google-Smtp-Source: AGHT+IE16RtP6WmR3PaaMPQV00189k/7cj0kBIoj2tv9dqPIsrRgKQmTtUA9Hj9MeKkatHiU3/R2Yw==
X-Received: by 2002:a17:902:d4cb:b0:1d4:7381:dc31 with SMTP id o11-20020a170902d4cb00b001d47381dc31mr591283plg.6.1704263769097;
        Tue, 02 Jan 2024 22:36:09 -0800 (PST)
Received: from localhost.localdomain ([2409:4042:4d3f:759f:e49e:2d4c:d3c7:71c])
        by smtp.gmail.com with ESMTPSA id bh10-20020a170902a98a00b001d4160c4f97sm21168987plb.188.2024.01.02.22.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 22:36:08 -0800 (PST)
From: pratikmanvar09@gmail.com
To: lkp@intel.com
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
Subject: [PATCH v2] pwm: imx27: workaround of the pwm output bug
Date: Wed,  3 Jan 2024 12:04:54 +0530
Message-Id: <20240103063454.1795-1-pratikmanvar09@gmail.com>
X-Mailer: git-send-email 2.39.1.windows.1
In-Reply-To: <202312300907.RGtYsKxb-lkp@intel.com>
References: <202312300907.RGtYsKxb-lkp@intel.com>
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
---
 V1 -> V2: fix sparse warnings reported-by: kernel test robot <lkp@intel.com>
           Closes: https://lore.kernel.org/oe-kbuild-all/202312300907.RGtYsKxb-lkp@intel.com/

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


