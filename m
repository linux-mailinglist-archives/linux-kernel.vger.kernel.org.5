Return-Path: <linux-kernel+bounces-90266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6EC86FCA1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BADF4B232B4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF451B7F1;
	Mon,  4 Mar 2024 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzn1g94B"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E54C1B598;
	Mon,  4 Mar 2024 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709542977; cv=none; b=tSLtX/koFRShM8Q9P7QH8mL2GXLA/FsVUVeCaLI8dKo5nSg80NqXd+cr/LB0HNAWbc9MDJCW/NiujgFHcHpkAoEFESvnJ1Nlxo1bvNGT4+K2wbhEGhAVeHBzzLvoeszAmWKZVHJVXoWm/Scwuy4is2F5iNO6r7flPT5wf8E8Jr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709542977; c=relaxed/simple;
	bh=I6ItcAdhYvN0K88755QaB7z9ob7xyH3wVWwR1CR8gOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gvXDfZc9OjbZfXzPxExNTIU1j0wwbeql12ahOvk4bjqP98FYctwqZSkRYORAutypyF8fiu4OW+VrLl1g5+NPSzEzjq81uIvWtfEHRUeXxm1n0XTbMG/mPoFNWnrG9DEfM1vEBPK/bqtrKgQp77bU7RHzB7Xx9WWdsnU6VSP6/tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzn1g94B; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dcafff3c50so35451955ad.0;
        Mon, 04 Mar 2024 01:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709542974; x=1710147774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOSSzXWtg7hPNVxlQJgzsSWMxiBRgskIg49mArSAU2Q=;
        b=mzn1g94Bp8xFa8B1KfUqbfowD3PTqcbJBgUiriQVI05ZtQ5UE7tTrarAhwGWdf6xns
         oqq3AT29a9nPR0j9jag3mq1waNDrGeyuMle95lw4kHiwoWrpk/TA+DQboa4j2DDzujAx
         jfP/x68aFdXZT0anwNc99WHRfL1npyfRiFBQUFkgSl6kHiFTMY4LQbUnzPw/bNNeaowz
         0wuQ0IwXkhCVMPvPvapI7z2uKF1z54Uvue5R1F/GyOrn/n+WKk/CtQdr8FHZReMKn44Z
         8lefwNAw3rucPgKedH2RTeocVec0wY87qCYrpVl6CTW6UuEBnu6uC1YKWD5Zwnwvr59y
         EQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709542974; x=1710147774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOSSzXWtg7hPNVxlQJgzsSWMxiBRgskIg49mArSAU2Q=;
        b=YJGsvkw2CiUCdvPZJdPMSFWwpXv7KQ7d0TYuJclrdVfIxPuuLB8KELGSfAfW7tQTmO
         3EACmjBqU7kqo72O2sp3M8PJUEyP83vmkHrW3+womwMD17dXCJimbbf55W/OXzCnfKD5
         +mJVkLqbjIJFplYCggZBvwaTbro4YTvM1h7SQE20mPimjWXmQvNdtevwinjlrjhfwPP0
         vv7sJLdfZd5QQHCS4z+jtRhJUCeakNKNbGfCNBqwxOx5+8pYuHORTsY0bSOIIC8wTumP
         kv78u8JdOBUNqlxU8KVXG5xypI/wzZadVGQoXg9bGtJeN6ywCCEdDI5HYB1yQCAUczVY
         6S7g==
X-Forwarded-Encrypted: i=1; AJvYcCXfrj+In9Gx0r2EJbgPlMYIHt8+l3lAG0pxcSPieWqEsCBcf95L25mxkBtxN74woyv/KdS6jPX9C9oYgt/3/WcRY6tB9v00hQJqpq7F64FDqvw/HSlvbLI4mywl5pf+nWWK9OOO4pJcnA==
X-Gm-Message-State: AOJu0YwnUO1Vp9fturyVyScx20+p6jGhJLLR3EJCzwI4XYQq6QZo/krf
	UxBDhaXisJU/nlhhIC7fDo9ZuP+UKQflYv3MOuRNtev0In8IuTn2
X-Google-Smtp-Source: AGHT+IEBWcpVB0ZIpXk7KFK3wsCpjgqPsqySMI7qTdKSbsKXYn5LQpOJ1cIRP6GjSNXX6+rvyCu+0w==
X-Received: by 2002:a17:902:ecc4:b0:1dd:2e6:b951 with SMTP id a4-20020a170902ecc400b001dd02e6b951mr7815406plh.12.1709542974417;
        Mon, 04 Mar 2024 01:02:54 -0800 (PST)
Received: from localhost ([46.3.240.107])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902650600b001dbb0348733sm8134714plk.67.2024.03.04.01.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:02:54 -0800 (PST)
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
Subject: [PATCH v4 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
Date: Mon,  4 Mar 2024 17:02:48 +0800
Message-Id: <20240304090248.1247215-1-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240304085933.1246964-1-qiujingbao.dlmu@gmail.com>
References: <20240304085933.1246964-1-qiujingbao.dlmu@gmail.com>
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
 drivers/pwm/pwm-cv1800.c | 314 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 325 insertions(+)
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
index 000000000000..d5b31a2b7787
--- /dev/null
+++ b/drivers/pwm/pwm-cv1800.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * pwm-cv1800.c: PWM driver for Sophgo cv1800
+ *
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
+#define PWM_CV1800_OE_INPUT          0x00U
+#define PWM_CV1800_OE_OUTPUT(n)      (BIT(0) << (n))
+#define PWM_CV1800_MAXPERIOD         (BIT(30) - 1)
+#define PWM_CV1800_MINPERIOD         BIT(1)
+#define PWM_CV1800_PERIOD_RESET      BIT(1)
+#define PWM_CV1800_HLPERIOD_RESET    BIT(0)
+#define PWM_CV1800_REG_DISABLE       0x00U
+#define PWM_CV1800_REG_ENABLE(n)     (BIT(0) << (n))
+#define PWM_CV1800_CHANNELS          4
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
+
+	if (pwm->state.enabled)
+		cv1800_pwm_enable(chip, pwm, !pwm->state.enabled);
+
+	if (polarity == PWM_POLARITY_INVERSED)
+		regmap_update_bits(priv->map, PWM_CV1800_POLARITY,
+				   PWM_CV1800_POLARITY_MASK(pwm->hwpwm),
+				   PWM_CV1800_REG_ENABLE(pwm->hwpwm));
+	else
+		regmap_update_bits(priv->map, PWM_CV1800_POLARITY,
+				   PWM_CV1800_POLARITY_MASK(pwm->hwpwm),
+				   PWM_CV1800_REG_DISABLE);
+}
+
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
+	cv1800_pwm_enable(chip, pwm, false);
+
+	if (mode == PWM_CV1800_OE_INPUT)
+		regmap_update_bits(priv->map, PWM_CV1800_OE,
+				   PWM_CV1800_OE_MASK(pwm->hwpwm),
+				   PWM_CV1800_REG_DISABLE);
+	else if (mode == PWM_CV1800_OE_OUTPUT(pwm->hwpwm))
+		regmap_update_bits(priv->map, PWM_CV1800_OE,
+				   PWM_CV1800_OE_MASK(pwm->hwpwm),
+				   PWM_CV1800_REG_ENABLE(pwm->hwpwm));
+}
+
+static int cv1800_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
+	u32 period_val, hlperiod_val;
+	u64 tem;
+
+	cv1800_pwm_set_oe(chip, pwm, PWM_CV1800_OE_OUTPUT(pwm->hwpwm));
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
+	tem = mul_u64_u64_div_u64(state->period, priv->clk_rate, NSEC_PER_SEC);
+	if (tem < PWM_CV1800_MINPERIOD)
+		return -EINVAL;
+
+	if (tem > PWM_CV1800_MAXPERIOD)
+		tem = PWM_CV1800_MAXPERIOD;
+
+	period_val = (u32)tem;
+
+	/*
+	 * The meaning of HLPERIOD is the number of beats in the low or high level
+	 * of the PERIOD. When the value of the POLARITY register is 0, HLPERIOD
+	 * represents a low level.
+	 * HLPERIOD = period_val - rate(MHz) / duty(MHz)
+	 * HLPERIOD = period_val - duty(ns) * rate(Hz) / NSEC_PER_SEC
+	 */
+	tem = mul_u64_u64_div_u64(state->duty_cycle, priv->clk_rate,
+				  NSEC_PER_SEC);
+	if (tem > period_val)
+		return -EINVAL;
+	hlperiod_val = period_val - (u32)tem;
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
+	u64 period_ns = 0;
+	u64 duty_ns = 0;
+	u32 enable = 0;
+	u32 polarity = 0;
+
+	regmap_read(priv->map, PWM_CV1800_PERIOD(pwm->hwpwm), &period_val);
+	regmap_read(priv->map, PWM_CV1800_HLPERIOD(pwm->hwpwm), &hlperiod_val);
+
+	if (period_val != PWM_CV1800_PERIOD_RESET ||
+	    hlperiod_val != PWM_CV1800_HLPERIOD_RESET) {
+		period_ns = DIV_ROUND_UP_ULL(period_val * NSEC_PER_SEC,
+					     priv->clk_rate);
+		duty_ns = DIV_ROUND_UP_ULL(hlperiod_val * period_ns, period_val);
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
+	state->polarity = polarity ? PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+
+	return 0;
+}
+
+static const struct pwm_ops cv1800_pwm_ops = {
+	.apply = cv1800_pwm_apply,
+	.get_state = cv1800_pwm_get_state,
+};
+
+static void devm_clk_rate_exclusive_put(void *data)
+{
+	struct clk *clk = data;
+
+	clk_rate_exclusive_put(clk);
+}
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
+	ret = clk_rate_exclusive_get(priv->clk);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to get exclusive rate\n");
+
+	ret = devm_add_action_or_reset(&pdev->dev, devm_clk_rate_exclusive_put,
+				       priv->clk);
+	if (ret) {
+		clk_rate_exclusive_put(priv->clk);
+		return ret;
+	}
+
+	priv->clk_rate = clk_get_rate(priv->clk);
+	if (!priv->clk_rate)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "Invalid clock rate: %lu\n",
+				     priv->clk_rate);
+
+	chip->ops = &cv1800_pwm_ops;
+
+	return devm_pwmchip_add(dev, chip);
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


