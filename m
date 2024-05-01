Return-Path: <linux-kernel+bounces-165039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F9F8B86F4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D3D1B2294F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB2553E2B;
	Wed,  1 May 2024 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvDxPEcr"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A8050282;
	Wed,  1 May 2024 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714552380; cv=none; b=uYosBecgbjBsHazCQLoUY60h6uZu99o9adSOQz1LqkEuI4kE/xMGV5YJJ6iddXE48HxqQPzJ4kOALfEJUlWueLAz4ziAo6el2WQVQI8nPg8V5ilXbJACLIOrOO492swTOsutDzX1E74ywPQuRXsM72rf4q9UbEabPu0OXYifG30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714552380; c=relaxed/simple;
	bh=TETtiPetAcuGzTqUCORh17g6lG8EFlt4pqG/qRzx7aU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=grtnFmLo1YnjSwhPaWWaN8E7Cohig7/OwIc7NYZVzRp5z3GAQInhvM2mw41DDVKgCYued+eCWaMXYHDXLN0m2SuVWAcgYKf9nz3uhvEa6l8oCaVA5kvlIzTUp4Tljrx6gdoc1xHbm1NGvcBwo0v670DBNBQzdx5fNgcBV7ZpOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvDxPEcr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e4f341330fso60689055ad.0;
        Wed, 01 May 2024 01:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714552378; x=1715157178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4yOag9d+2lNyIjlP/iP+9nWS0CniAbc89X9/hTFyLM=;
        b=PvDxPEcrn6Tzp68PtAUK0agCZHLcdwTaLzw5ZNs62cbfCeumR0uxtOe2oFLKRE4Id9
         YC4hDKG8ckTXc7LgeQKVddPke3+TC839T1xKtqdoF9NwCeJeOVVUsLdYw8r5IcnGuhkk
         0bOmPYg4ccFsf4MsTMX6KwTLZmgjbIJpqCd32ccOKNv1LyJ+xiPq7I898pT3iTG7IBa5
         qG+Xyw86zpatpWuWONXh7oLQaw3nxVKZln2SMvhuSNtdKCEqG3N1Go05shgUWCZAb9W6
         8ROEa+CxF5bNxdPKh8tWR0BpKaWGlLZHSsAmyWIkLmSq+i1ABMBdFcGiJXchfGo0npVZ
         bM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714552378; x=1715157178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4yOag9d+2lNyIjlP/iP+9nWS0CniAbc89X9/hTFyLM=;
        b=HowlMa5YCJmcOdy3AJpTC7Vg/ZEmodQ5mvj0c7MOKhPKMLQq8gGRW/abvke9fkC4EG
         40B6HyKgZm+pQ2DFGmZbIuBATOlvVhtARq1iyCYKUfBbCdQYDnQI45DTIcXamw6Uh7Cp
         aQ7AF+aAKadfxjF2yUL4ixpBAI9iFccMJx3X5yvC/tTW0AXTg1S4yjamzo0lyTqk/Qn2
         kqBzz5/56O2hJnJ/gfgIkaZxoSpPWJlg8no6NellTKxrZPoSZgpbPRE+HYwtjPOKXTDO
         uLASGXdFjXd0bK5A71s6/fiEXagRudt9OVDBsQI7cBc9OVEaq4M/dr4LafX+nambrgQ9
         uNdA==
X-Forwarded-Encrypted: i=1; AJvYcCXHMaGr7djQ/g/eKRU+x2Btn+UBCFRRo6Ck068WLr1W+r3lzcN7kwAcet0JAOOuHZXt5DZsSilaxEoswkTO+bJVDMCg3IggdApr4RgkiB6AwUb5pildT8YnWeIr5JsK4rJ9Trexn327DvOMxeRNnZItmCYx6AJW1MaVyFV4vO9/t3YAVg==
X-Gm-Message-State: AOJu0YzIwH9BWfZCt6JrrgHDD8P3z+RfiGremrMgNvGLv7a02SbnEZXI
	s85PR/yWl5iAYpTx1ydtRy6oFig3FNsSFo/Prw6SEkrDxsBK1G+w
X-Google-Smtp-Source: AGHT+IGwMaQWvwJdJ+/0gVC5reBQNoPxhcce8M4TzT7XOQLxs3Nd4Y2mkZ4sirMFaxk5o5cU46PT3Q==
X-Received: by 2002:a17:903:124f:b0:1e2:1915:2479 with SMTP id u15-20020a170903124f00b001e219152479mr2097599plh.12.1714552377217;
        Wed, 01 May 2024 01:32:57 -0700 (PDT)
Received: from localhost ([39.152.149.70])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902a50b00b001eb2fb28eabsm8570921plq.227.2024.05.01.01.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 01:32:57 -0700 (PDT)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	unicorn_wang@outlook.com
Cc: dlan@gentoo.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v7 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
Date: Wed,  1 May 2024 16:32:42 +0800
Message-Id: <20240501083242.773305-3-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240501083242.773305-1-qiujingbao.dlmu@gmail.com>
References: <20240501083242.773305-1-qiujingbao.dlmu@gmail.com>
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
 drivers/pwm/pwm-cv1800.c | 293 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 304 insertions(+)
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
index 000000000000..d487af637198
--- /dev/null
+++ b/drivers/pwm/pwm-cv1800.c
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Sophgo CV1800 PWM driver
+ * Author: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
+ *
+ * Limitations:
+ * - The hardware emits the inactive level when disabled.
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
+#define PWM_CV1800_UPDATE_MASK(n)   BIT(n)
+#define PWM_CV1800_OE_MASK(n)       BIT(n)
+#define PWM_CV1800_START_MASK(n)    BIT(n)
+#define PWM_CV1800_POLARITY_MASK(n) BIT(n)
+
+#define PWM_CV1800_MAXPERIOD        0x3fffffff
+#define PWM_CV1800_MINPERIOD        2
+#define PWM_CV1800_CHANNELS         4
+#define PWM_CV1800_PERIOD_RESET     BIT(1)
+#define PWM_CV1800_HLPERIOD_RESET   BIT(0)
+#define PWM_CV1800_REG_ENABLE(n)    BIT(n)
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
+				   PWM_CV1800_UPDATE_MASK(pwm->hwpwm), 0);
+	} else if (!pwm_enable && enable) {
+		regmap_update_bits(priv->map, PWM_CV1800_START,
+				   PWM_CV1800_START_MASK(pwm->hwpwm),
+				   PWM_CV1800_REG_ENABLE(pwm->hwpwm));
+	} else if (pwm_enable && !enable) {
+		regmap_update_bits(priv->map, PWM_CV1800_START,
+				   PWM_CV1800_START_MASK(pwm->hwpwm), 0);
+	}
+
+	/* check and set OE/Output-Enable mode */
+	regmap_read(priv->map, PWM_CV1800_OE, &state);
+
+	if ((state & BIT(pwm->hwpwm)) && enable)
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
+	if (IS_ERR(priv->map)) {
+		dev_err(dev, "Couldn't create PWM regmap\n");
+		return PTR_ERR(priv->map);
+	}
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


