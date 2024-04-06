Return-Path: <linux-kernel+bounces-133830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C3389A964
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 08:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F222128388A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 06:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF522B9A4;
	Sat,  6 Apr 2024 06:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSCnZGAw"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FC028DD0;
	Sat,  6 Apr 2024 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712385279; cv=none; b=DH6yWRkVzWUJiRgkKavAictOH6Coivq70P5EcR2tUZpV53QlopVMNLeciGJto12M112yovhBjw7p0OzFxEzDqcJCqjsdmUkiE9PDU0zQUh3fSoiexuRCH8QeGXOKb7mMknJSIXjAaPvuEKylMyNTaHFYeByyScMFkMXRXPegFcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712385279; c=relaxed/simple;
	bh=22B+74++I+pTCcTeu6WYfEEnYpK/y0Q7tTLPNAcwD9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YhrVfxYmORzDgs/ex/ErQVeO1cr45StPjC2pPapxmcyK814AmJrSFkhbK8f86m/Ggs34qjmeNO9APGpUMyli8S1FNZ4yEgMiYR18ZfO33rPDJu7vRDErpO0GlSNpr0W/N9F45Hd2FK3xKaXyCN2IWyeFroUpnObuTm9rkblqHI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSCnZGAw; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso1906093a12.0;
        Fri, 05 Apr 2024 23:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712385277; x=1712990077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HloA09HYWfj+exivGvOeK6EGfkfpT/O66Y43VVa7czg=;
        b=nSCnZGAwvFaOW2LN2GuzXi4is9jB7xLHOtn2eHoQkwMoqEXzz7qt2LaTPV8Qm6l6U8
         Hd4vR44KjJKYrIS13neBPI9M7pHiB6OBURkGINo1R+lgg56nlYb8P7Bf/+nEKSYa0K2j
         3CoEuPOp2IYhHMDbrX7ruOjes5MJq0Hny4T3Tzi5szjyS2njbjIGjw8O1XF1mfVmiJHC
         npOBkV+gVVdhCDyDqt9mQ6nCAl+ciO413u/WOkFgO9BjOR9trMvn1Ux+LUgEgGn8guqg
         Fjs60LHJE86aUw5Go/QneTjxhC0Uin4BG+elRVL86shcAbS7yf43LqT2d3a9Oben5pRv
         z75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712385277; x=1712990077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HloA09HYWfj+exivGvOeK6EGfkfpT/O66Y43VVa7czg=;
        b=EYzqIz4EW+qeEfdCtKNUgOUVHl7bimdF14J8SqBBHbxpKleP18QdYdjL3eMp3AFWhJ
         3gZPNvcQuH7HfNzNNIfy7aVLIiKP/T6xJipoNy71W9IuWGlJzTJZy2C77Myz7KKPd0Yw
         E2ipAR0OYzAtqIBffVwq5EiNnhpeqpANG9Wr1bqIRW1WLf0VapatH5+iHhzjObQOF/I5
         fGjphegbkPi+58vhhJCsvXl4ybxNpmSMi7azNlZHMRGdbX7HWsu1raugrtaJuh7mmRBl
         jckIZM9lZNb+2t7zVTlSZBDL9ooDIHF9D2VId/Tm2YFXGT3//7y6EcOiFqOiWcez4q8Z
         roVg==
X-Forwarded-Encrypted: i=1; AJvYcCXlWHcqHZuOd/99oVCFoEIZbJxKC1aPEsA5XNiZ5odwE+djTcAFtrCl75k0Nhc4b7FNje1FSGN7tNM3+69GGAoutO76lMIFQ182chlU+J6HNO6TD9Cjvtgta3z6ZrfwZz4P0LdSdoxpqJMcTVUbXTJDbVBQQ2rlS8GPBWG8aSCs2/hdkg==
X-Gm-Message-State: AOJu0Yzo5NfXLm85QbEieQMUh1bnL810uRFhCCOi4F3z43K3UCcUOzbt
	5oB474j0Ar4+Zn0C2eerjieIzjUPAL4w9uMUqAgdNfbkOUx+S5qK
X-Google-Smtp-Source: AGHT+IEeAQmcECIDStHRhWsm+h1mZWgZLHirKVVz5juMz+R53gQ/Xq1lSl5S+65EUkSKkwLhD+6G+A==
X-Received: by 2002:a17:902:e751:b0:1dd:7b1d:af7f with SMTP id p17-20020a170902e75100b001dd7b1daf7fmr4129246plf.58.1712385276653;
        Fri, 05 Apr 2024 23:34:36 -0700 (PDT)
Received: from localhost ([46.3.240.101])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902784d00b001e245c5afbfsm2732208pln.155.2024.04.05.23.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 23:34:36 -0700 (PDT)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: u.kleine-koenig@pengutronix.de,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	inochiama@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v6 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
Date: Sat,  6 Apr 2024 14:34:13 +0800
Message-Id: <20240406063413.3334639-3-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240406063413.3334639-1-qiujingbao.dlmu@gmail.com>
References: <20240406063413.3334639-1-qiujingbao.dlmu@gmail.com>
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
 drivers/pwm/pwm-cv1800.c | 296 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 307 insertions(+)
 create mode 100644 drivers/pwm/pwm-cv1800.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 1dd7921194f5..3869ca022aeb 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -182,6 +182,16 @@ config PWM_CROS_EC
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
index 90913519f11a..6295e2259efc 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_PWM_CLK)		+= pwm-clk.o
 obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
 obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
+obj-$(CONFIG_PWM_CV1800)	+= pwm-cv1800.o
 obj-$(CONFIG_PWM_DWC_CORE)	+= pwm-dwc-core.o
 obj-$(CONFIG_PWM_DWC)		+= pwm-dwc.o
 obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
diff --git a/drivers/pwm/pwm-cv1800.c b/drivers/pwm/pwm-cv1800.c
new file mode 100644
index 000000000000..37a6be3f63aa
--- /dev/null
+++ b/drivers/pwm/pwm-cv1800.c
@@ -0,0 +1,296 @@
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
+#define PWM_CV1800_HLPERIOD_BASE    0x00
+#define PWM_CV1800_PERIOD_BASE      0x04
+#define PWM_CV1800_POLARITY         0x40
+#define PWM_CV1800_START            0x44
+#define PWM_CV1800_DONE             0x48
+#define PWM_CV1800_UPDATE           0x4c
+#define PWM_CV1800_OE               0xd0
+
+#define PWM_CV1800_HLPERIOD(n)      (PWM_CV1800_HLPERIOD_BASE + ((n)*0x08))
+#define PWM_CV1800_PERIOD(n)        (PWM_CV1800_PERIOD_BASE + ((n)*0x08))
+
+#define PWM_CV1800_UPDATE_MASK(n)   (BIT(0) << (n))
+#define PWM_CV1800_OE_MASK(n)       (BIT(0) << (n))
+#define PWM_CV1800_START_MASK(n)    (BIT(0) << (n))
+#define PWM_CV1800_POLARITY_MASK(n) (BIT(0) << (n))
+
+#define PWM_CV1800_MAXPERIOD        0x3fffffff
+#define PWM_CV1800_MINPERIOD        2
+#define PWM_CV1800_CHANNELS         4
+#define PWM_CV1800_PERIOD_RESET     BIT(1)
+#define PWM_CV1800_HLPERIOD_RESET   BIT(0)
+#define PWM_CV1800_REG_DISABLE      0x00U
+#define PWM_CV1800_REG_ENABLE(n)    (BIT(0) << (n))
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
+	u32 pwm_enable, state;
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
+	/* check and set OE/Output-Enable mode */
+	regmap_read(priv->map, PWM_CV1800_OE, &state);
+	state &= PWM_CV1800_OE_MASK(pwm->hwpwm);
+
+	if (state == PWM_CV1800_REG_DISABLE && enable)
+		regmap_update_bits(priv->map, PWM_CV1800_OE,
+				   PWM_CV1800_OE_MASK(pwm->hwpwm),
+				   PWM_CV1800_REG_ENABLE(pwm->hwpwm));
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
+	if (polarity == PWM_POLARITY_NORMAL)
+		config_polarity = PWM_CV1800_POLARITY_MASK(pwm->hwpwm);
+
+	regmap_update_bits(priv->map, PWM_CV1800_POLARITY,
+			   PWM_CV1800_POLARITY_MASK(pwm->hwpwm),
+			   config_polarity);
+}
+
+static int cv1800_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
+	u32 period_val, hlperiod_val;
+	u64 ticks;
+	u32 state;
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


