Return-Path: <linux-kernel+bounces-103087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1FC87BADE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614B21F22A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEC06E2AE;
	Thu, 14 Mar 2024 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPdIBF5y"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37766E5F3;
	Thu, 14 Mar 2024 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710410517; cv=none; b=WLf7Ebhhm54+ZvMfbS96fjwKht46T733IjRUpwGNp7+U02YZgFz0/WstAkmhD0PkWObEEao1uoqgKefUT+xs0fYfJJHW/3a+Dr4iJGhyJNZD+kBWrdMG0oIj7KzuvowLIdQ7Bi6wb3xwPtaSnO7jSxgGu+7/7pMeKWFriT5fRXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710410517; c=relaxed/simple;
	bh=NqommDIQVB4/iNSLMlSTpCiKSTxhqmtgrrnq1aEi+dg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=snLtc/WFykgoYUPZ/pU2g4nDk8MgcPeLoFjR+fyF5SuQJpZXOC753p11p0WQlw1U8amhigDTgzZ4/8XJmwpe2LK/0/WGDgIl70hEvALYeEIXqEvQFAMNiFZyu1Xa4v9P5Nvy1m+m/I0KcAnc9GE81WWXcTfpPsQ+g69ZnhKXEP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPdIBF5y; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6ca8c8be2so563816b3a.1;
        Thu, 14 Mar 2024 03:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710410515; x=1711015315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltw3Jo4Vxs0R1AxClzjd+3mQ5yMJlSiU+UcUdlHv65M=;
        b=YPdIBF5y9nsOekAIYu7A1xIi4E2+v3TlmbGik2IzA/rUinzuU0PmYlu0m2F1L/xDoT
         xLQ9Ds6fIFG8BbIIA/l++i0ExIhtspNqlg+YrWiBV36tW3cU7JyiF4OtmhIQ376lxflT
         xJsHv8Af1FRgOI0gjIp+J6kclGdIzFLxQiT0BSpcNUO78IdE+UILoYKG3pM6oZ6XiYv+
         PezyOscXa1p1rEX6bsKfi7ebdMpRqz82o1d24jjBWJ5BE+ywIA90waWhYR/CSDzUBbtg
         gM6XAaavfhiLfeqnEdhp52skE553dpiiBuujYpysGPHB1+7Kqhx7i/dOTBFGVd2DC9mP
         tzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710410515; x=1711015315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltw3Jo4Vxs0R1AxClzjd+3mQ5yMJlSiU+UcUdlHv65M=;
        b=Ce/pHH3ETeD9xOisLrysFYOVryMtOFEn/u8QDjVWq8tL73/yaUAveS1ojuQvxt4DWB
         FtjXrxEmUh32YNlMIRiZrLxMAQIyCzUAr1hjBKW4hivlsa7dXGNYXgx/VaeuwQL7IJf7
         Itz9F6c4vvxw9O2z/FiqdLcXUCpQJI4HlUQwM7I92TdUTHDOi9kcoCcSAUpChF4fluSa
         Q1c5u0JIHwfnS6mRAyW36+nGWI2cakTkcJfNlOgYCWsKZPqrHJr9gaD8WxsujxY6QJzI
         xHAXdhQwstPSFm9iytSaa/ZmUsFow4XKwvrzuyTScXmOHW5Q/SpiYp6Q4q3sM+8AT4VE
         PtBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+ouVY3rfEAeNSnbSrHsftKnRCI+vMDd80GyK5lYPTHBux+tZX0N9Y5seKdEt+IIP4sbknYMAB28nySAG8wg1IDtHd/iXwZStIO5GiTtjvepF9mblbAX/wS2fNqgfKzPebf2gbZfnqfw==
X-Gm-Message-State: AOJu0YwOT41CguXudVEUC5ra6Tc2RxWN1GlC+3GcWijyr3Xt10jGA3wV
	ed0AheH3GPKnbLiNLdQfM3pEBrGSCmuLgO4WyS0GD/gNne6FEfoa
X-Google-Smtp-Source: AGHT+IHxCF5ppdQopTH/LJ+SoRqt5gBiZnO2kEZKcAUuUYGN9WcvELbAxjKGqSNQQa+KqAlbAXExlw==
X-Received: by 2002:a05:6a20:12c2:b0:1a1:8c67:25e1 with SMTP id v2-20020a056a2012c200b001a18c6725e1mr1711988pzg.45.1710410514962;
        Thu, 14 Mar 2024 03:01:54 -0700 (PDT)
Received: from localhost ([2001:da8:a801:69b2:6cee:23f3:5da6:de15])
        by smtp.gmail.com with ESMTPSA id y71-20020a62ce4a000000b006e6b989514bsm1128692pfg.60.2024.03.14.03.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 03:01:54 -0700 (PDT)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: u.kleine-koenig@pengutronix.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	dlan@gentoo.org,
	inochiama@outlook.com,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v5 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
Date: Thu, 14 Mar 2024 18:01:31 +0800
Message-Id: <20240314100131.323540-3-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314100131.323540-1-qiujingbao.dlmu@gmail.com>
References: <20240314100131.323540-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the PWM driver for CV1800.

Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 drivers/pwm/Kconfig      |  10 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-cv1800.c | 315 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 326 insertions(+)
 create mode 100644 drivers/pwm/pwm-cv1800.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4b956d661755..455f07af94f7 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -186,6 +186,16 @@ config PWM_CROS_EC
 	  PWM driver for exposing a PWM attached to the ChromeOS Embedded
 	  Controller.
 
+config PWM_CV1800
+	tristate "Sophgo CV1800 PWM driver"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	help
+	  Generic PWM framework driver for the Sophgo CV1800 series
+	  SoCs.
+
+	  To compile this driver as a module, build the dependecies
+	  as modules, this will be called pwm-cv1800.
+
 config PWM_DWC_CORE
 	tristate
 	depends on HAS_IOMEM
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index c5ec9e168ee7..6c3c4a07a316 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CLK)		+= pwm-clk.o
 obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
 obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
+obj-$(CONFIG_PWM_CV1800)	+= pwm-cv1800.o
 obj-$(CONFIG_PWM_DWC_CORE)	+= pwm-dwc-core.o
 obj-$(CONFIG_PWM_DWC)		+= pwm-dwc.o
 obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
diff --git a/drivers/pwm/pwm-cv1800.c b/drivers/pwm/pwm-cv1800.c
new file mode 100644
index 000000000000..8eca07c60942
--- /dev/null
+++ b/drivers/pwm/pwm-cv1800.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Sophgo CV1800 PWM driver
+ * Author: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
+ *
+ * Limitations:
+ * - It output low when PWM channel disabled.
+ * - This pwm device supports dynamic loading of PWM parameters. When PWMSTART
+ *   is written from 0 to 1, the register value (HLPERIODn, PERIODn) will be
+ *   temporarily stored inside the PWM. If you want to dynamically change the
+ *   waveform during PWM output, after writing the new value to HLPERIODn and
+ *   PERIODn, write 1 and then 0 to PWMUPDATE[n] to make the new value effective.
+ * - Supports up to Rate/2 output, and the lowest is about Rate/(2^30-1).
+ * - By setting HLPERIODn to 0, can produce 100% duty cycle.
+ * - This hardware could support inverted polarity. By default, the value of the
+ *   POLARITY register is 0x0. This means that HLPERIOD represents the number
+ *   of low level beats.
+ * - This hardware supports input mode and output mode, implemented through the
+ *   Output-Enable/OE register. However, this driver has not yet implemented
+ *   capture callback.
+ */
+
+#include <linux/clk.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+
+#define PWM_CV1800_HLPERIOD_BASE     0x00
+#define PWM_CV1800_PERIOD_BASE       0x04
+#define PWM_CV1800_POLARITY          0x40
+#define PWM_CV1800_START             0x44
+#define PWM_CV1800_DONE              0x48
+#define PWM_CV1800_UPDATE            0x4c
+#define PWM_CV1800_OE                0xd0
+
+#define PWM_CV1800_HLPERIOD(n)       (PWM_CV1800_HLPERIOD_BASE + ((n) * 0x08))
+#define PWM_CV1800_PERIOD(n)         (PWM_CV1800_PERIOD_BASE + ((n) * 0x08))
+
+#define PWM_CV1800_UPDATE_MASK(n)    (BIT(0) << (n))
+#define PWM_CV1800_OE_MASK(n)        (BIT(0) << (n))
+#define PWM_CV1800_START_MASK(n)     (BIT(0) << (n))
+#define PWM_CV1800_POLARITY_MASK(n)  (BIT(0) << (n))
+
+#define PWM_CV1800_MAXPERIOD         0x3fffffff
+#define PWM_CV1800_MINPERIOD         2
+#define PWM_CV1800_CHANNELS          4
+#define PWM_CV1800_PERIOD_RESET      BIT(1)
+#define PWM_CV1800_HLPERIOD_RESET    BIT(0)
+#define PWM_CV1800_REG_DISABLE       0x00U
+#define PWM_CV1800_REG_ENABLE(n)     (BIT(0) << (n))
+
+struct cv1800_pwm {
+	struct regmap *map;
+	struct clk *clk;
+	unsigned long clk_rate;
+};
+
+static inline struct cv1800_pwm *to_cv1800_pwm_dev(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static const struct regmap_config cv1800_pwm_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+static int cv1800_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
+			     bool enable)
+{
+	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
+	u32 pwm_enable;
+
+	regmap_read(priv->map, PWM_CV1800_START, &pwm_enable);
+	pwm_enable &= PWM_CV1800_START_MASK(pwm->hwpwm);
+
+	/*
+	 * If the parameters are changed during runtime, Register needs
+	 * to be updated to take effect.
+	 */
+	if (pwm_enable && enable) {
+		regmap_update_bits(priv->map, PWM_CV1800_UPDATE,
+				   PWM_CV1800_UPDATE_MASK(pwm->hwpwm),
+				   PWM_CV1800_REG_ENABLE(pwm->hwpwm));
+		regmap_update_bits(priv->map, PWM_CV1800_UPDATE,
+				   PWM_CV1800_UPDATE_MASK(pwm->hwpwm),
+				   PWM_CV1800_REG_DISABLE);
+	} else if (!pwm_enable && enable) {
+		regmap_update_bits(priv->map, PWM_CV1800_START,
+				   PWM_CV1800_START_MASK(pwm->hwpwm),
+				   PWM_CV1800_REG_ENABLE(pwm->hwpwm));
+	} else if (pwm_enable && !enable) {
+		regmap_update_bits(priv->map, PWM_CV1800_START,
+				   PWM_CV1800_START_MASK(pwm->hwpwm),
+				   PWM_CV1800_REG_DISABLE);
+	}
+
+	return 0;
+}
+
+static void cv1800_pwm_set_polarity(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    enum pwm_polarity polarity)
+{
+	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
+	u32 config_polarity = 0;
+
+	if (pwm->state.enabled)
+		cv1800_pwm_enable(chip, pwm, !pwm->state.enabled);
+
+	if (polarity == PWM_POLARITY_INVERSED)
+		config_polarity =  PWM_CV1800_POLARITY_MASK(pwm->hwpwm);
+
+	regmap_update_bits(priv->map, PWM_CV1800_POLARITY,
+			   PWM_CV1800_POLARITY_MASK(pwm->hwpwm),
+			   config_polarity);
+}
+
+/**
+ * cv1800_pwm_set_oe() - check and config nth channal output-enable/OE mode
+ * @chip: PWM chip
+ * @pwm: PWM device
+ * @mode: The nth bit of the mode represents the output-enable/OE mode
+ *        of the nth channal. 1 represents output mode, 0 represents
+ *        input mode.
+ */
+static void cv1800_pwm_set_oe(struct pwm_chip *chip, struct pwm_device *pwm,
+			      u32 mode)
+{
+	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
+	u32 state;
+
+	regmap_read(priv->map, PWM_CV1800_OE, &state);
+	state &= PWM_CV1800_OE_MASK(pwm->hwpwm);
+
+	if (state == mode)
+		return;
+
+	/* disenable pwm output before changing output mode */
+	cv1800_pwm_enable(chip, pwm, false);
+
+	regmap_update_bits(priv->map, PWM_CV1800_OE,
+			   PWM_CV1800_OE_MASK(pwm->hwpwm), mode);
+}
+
+static int cv1800_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
+	u32 period_val, hlperiod_val;
+	u64 ticks;
+
+	cv1800_pwm_set_oe(chip, pwm, PWM_CV1800_OE_MASK(pwm->hwpwm));
+
+	if (state->polarity != pwm->state.polarity)
+		cv1800_pwm_set_polarity(chip, pwm, state->polarity);
+
+	/*
+	 * This hardware use PERIOD and HLPERIOD registers to represent PWM waves.
+	 *
+	 * The meaning of PERIOD is how many clock cycles (from the clock source)
+	 * are used to represent PWM waves.
+	 * PERIOD = rate(MHz) / target(MHz)
+	 * PERIOD = period(ns) * rate(Hz) / NSEC_PER_SEC
+	 */
+	ticks = mul_u64_u64_div_u64(state->period, priv->clk_rate,
+				    NSEC_PER_SEC);
+	if (ticks < PWM_CV1800_MINPERIOD)
+		return -EINVAL;
+
+	if (ticks > PWM_CV1800_MAXPERIOD)
+		ticks = PWM_CV1800_MAXPERIOD;
+	period_val = (u32)ticks;
+
+	/*
+	 * After mapping, hlperiod represents the same polarity as duty.
+	 * HLPERIOD = rate(MHz) / duty(MHz)
+	 * HLPERIOD = duty(ns) * rate(Hz) / NSEC_PER_SEC
+	 */
+	ticks = mul_u64_u64_div_u64(state->duty_cycle, priv->clk_rate,
+				    NSEC_PER_SEC);
+	if (ticks > period_val)
+		ticks = period_val;
+	hlperiod_val = (u32)ticks;
+
+	regmap_write(priv->map, PWM_CV1800_PERIOD(pwm->hwpwm), period_val);
+	regmap_write(priv->map, PWM_CV1800_HLPERIOD(pwm->hwpwm), hlperiod_val);
+
+	cv1800_pwm_enable(chip, pwm, state->enabled);
+
+	return 0;
+}
+
+static int cv1800_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
+	u32 period_val, hlperiod_val;
+	u64 period_ns = 0, duty_ns = 0;
+	u32 enable = 0, polarity = 0;
+
+	regmap_read(priv->map, PWM_CV1800_PERIOD(pwm->hwpwm), &period_val);
+	regmap_read(priv->map, PWM_CV1800_HLPERIOD(pwm->hwpwm), &hlperiod_val);
+
+	if (period_val != PWM_CV1800_PERIOD_RESET ||
+	    hlperiod_val != PWM_CV1800_HLPERIOD_RESET) {
+		period_ns = DIV_ROUND_UP_ULL(period_val * NSEC_PER_SEC,
+					     priv->clk_rate);
+		duty_ns = DIV_ROUND_UP_ULL(hlperiod_val * NSEC_PER_SEC,
+					   priv->clk_rate);
+
+		regmap_read(priv->map, PWM_CV1800_START, &enable);
+		enable &= PWM_CV1800_START_MASK(pwm->hwpwm);
+
+		regmap_read(priv->map, PWM_CV1800_POLARITY, &polarity);
+		polarity &= PWM_CV1800_POLARITY_MASK(pwm->hwpwm);
+	}
+
+	state->period = period_ns;
+	state->duty_cycle = duty_ns;
+	state->enabled = enable;
+
+	/*
+	 * To ensure that duty and hlperiod represent the same polarity
+	 * the following mapping needs to be completed.
+	 *
+	 * |----------|------------|------------|-----------|
+	 * |  Linux   |  register  |    duty    | register  |
+	 * | polarity |  polarity  |            | hlperiod  |
+	 * |----------|------------|------------|-----------|
+	 * |    1     |      0     | low level  | low level |
+	 * |----------|------------|------------|-----------|
+	 * |    0     |      1     | high level | high level|
+	 * |----------|------------|------------|-----------|
+	 */
+	state->polarity = polarity ? PWM_POLARITY_NORMAL :
+					   PWM_POLARITY_INVERSED;
+
+	return 0;
+}
+
+static const struct pwm_ops cv1800_pwm_ops = {
+	.apply = cv1800_pwm_apply,
+	.get_state = cv1800_pwm_get_state,
+};
+
+static int cv1800_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cv1800_pwm *priv;
+	struct pwm_chip *chip;
+	void __iomem *base;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, PWM_CV1800_CHANNELS, sizeof(*priv));
+	if (!chip)
+		return PTR_ERR(chip);
+	priv = to_cv1800_pwm_dev(chip);
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->map = devm_regmap_init_mmio(&pdev->dev, base,
+					  &cv1800_pwm_regmap_config);
+	if (IS_ERR(priv->map))
+		return PTR_ERR(priv->map);
+
+	priv->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk),
+				     "clk not found\n");
+
+	ret = devm_clk_rate_exclusive_get(dev, priv->clk);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to get exclusive rate\n");
+
+	priv->clk_rate = clk_get_rate(priv->clk);
+	if (!priv->clk_rate)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "Invalid clock rate: %lu\n",
+				     priv->clk_rate);
+
+	chip->ops = &cv1800_pwm_ops;
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
+
+	return 0;
+}
+
+static const struct of_device_id cv1800_pwm_dt_ids[] = {
+	{ .compatible = "sophgo,cv1800-pwm" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cv1800_pwm_dt_ids);
+
+static struct platform_driver cv1800_pwm_driver = {
+	.probe = cv1800_pwm_probe,
+	.driver	= {
+		.name = "cv1800-pwm",
+		.of_match_table = cv1800_pwm_dt_ids,
+	},
+};
+module_platform_driver(cv1800_pwm_driver);
+
+MODULE_AUTHOR("Jingbao Qiu");
+MODULE_DESCRIPTION("Sophgo cv1800 PWM Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


