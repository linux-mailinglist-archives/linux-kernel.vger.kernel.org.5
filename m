Return-Path: <linux-kernel+bounces-85098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5F086B068
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A43288821
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900BE151CD4;
	Wed, 28 Feb 2024 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzXsiAvL"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7508214F9E5;
	Wed, 28 Feb 2024 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127178; cv=none; b=MhipYdnG63972ha/1a3va6kyXHG/V2yq4rPVXdom0Gy+RQMmPkBlO0xAbzm7zy+vr/kFYjNSPjOWp+U/79wWRDjTMGRbR55FycyoJacVLNrGoZLM5cft/D6edhuh+xuXLad3IXOQKIlxHBFVFUCfcr5vAops+CU5RYJAy8rDkCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127178; c=relaxed/simple;
	bh=BEB7qWDqpMw22mTCQUG5lw1gg9QbrSUF0oqtCMqWoC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MhK+9M9gLQceGBhDpwRL1LRMwCdLAD43LFbcxEtFW0fWIudV9DusL0Np/I8+ktl8UXFcoUH0M/Giq0PeV4kniw1+eE6ik4q6/kP4RuFuBUSUWW2qkm1jGlayfeGgPhGQHYxrgrf7Ty04zIbhCHfTgjN6KD1OYrn+pngp0FNGSyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzXsiAvL; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4417fa396fso44671266b.1;
        Wed, 28 Feb 2024 05:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709127175; x=1709731975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Rqdfw7u5pplnc2e2TFtlnNGF+ckTKLmulF+IZmE6Uw=;
        b=FzXsiAvLMPLBcf/HhxaBj0DyMKh9rz9XKDVz0We0C7xwTNCi7ldPjlgbt4t+AKuzmm
         ggp11jZnlqsIZoJYZ63txkCXbHeOccpgaQg8tCRyyU8O4LNysFq+k7Wt7RMXWR6eCjBY
         3tfQA1QhVvcRxtY0qTA2I/wFUoePCHL9vHE9gJdgBIqeldDPvz9f/ee5oxJZI13JeUls
         vAH3o+GWls9ZpYZZgnzhqGt+4rgBCK/w9kPU+YNLwKKitpGechp4Lm9801dAzoSv0F67
         zuGoXIwEFOTTyCS+CjLYxMKMpOywmL6bmjVT/fgaMOSYTF+Alxi2GC+tuxgMqYG4B6gU
         YuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709127175; x=1709731975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Rqdfw7u5pplnc2e2TFtlnNGF+ckTKLmulF+IZmE6Uw=;
        b=WdDXYFyHb3GQ7ChfU+3BPAe6cQuY2O3EHdZzcJi1ZoJLeb5H4IaXmDZ6MkV2AlVk0j
         5YvSF5fFGNfEDCmDP1QDrTTAv/oRh8SJstJj2Gwn/xS66g8wsYmJjCvhENt31JtFC5M+
         Nq0lRgnukwoF7A4RwkrnvoBxYCac3NJqOEScdvfgUpbRrS9WFr27CQt30E40ZZcwDVPA
         35X9A7twepUPDgUCXUY7GAMu45lIpWGLy+t74zYoM6AumtMZDfoW/HLpS4PLn7G288+W
         N+YVvOLpTrzUFRI3hvflx+JnjWSA6dbqgt3tnlliXS8SfDWjctCATp6EFws8DZKC4H/D
         VNgg==
X-Forwarded-Encrypted: i=1; AJvYcCXHcITswyI0bhobE1IzeIc0EPSkDZAS8RDChkQdBUp6XjXZFKGm+kGl4AjO+bebaPGLAN3ojVmFPRsE0QK/G+T3xa/oZr4Z3bib3Nr1MXQUNb29ioOc2QVVcfeiRSF5cjVgKU6N7AOF
X-Gm-Message-State: AOJu0Yza1idgKL6FRLBsTJwhBVTgax3EogcC4zX7QkgUX2UehW328Ipi
	HdS32lGBdBBdhfK3Kw2eb+DRm8+7OI/dp2+6rHodmUn4n/NvGyWN7qpIgZJd
X-Google-Smtp-Source: AGHT+IFoJpS62+1Hpqqh97YWZNamlPDZJTMiagrsMD+VMQMU8EXpAwcSygytktlsfYXJ/96lhKLEvQ==
X-Received: by 2002:a17:906:57c9:b0:a44:856:1368 with SMTP id u9-20020a17090657c900b00a4408561368mr987997ejr.12.1709127174675;
        Wed, 28 Feb 2024 05:32:54 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id vx5-20020a170907a78500b00a3f20a8d2f6sm1856952ejc.112.2024.02.28.05.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:32:52 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH 2/3] pwm: add support for NXPs high-side switch MC33XS2410
Date: Wed, 28 Feb 2024 14:32:34 +0100
Message-Id: <20240228133236.748225-3-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228133236.748225-1-dima.fedrau@gmail.com>
References: <20240228133236.748225-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MC33XS2410 is a four channel high-side switch. Featuring advanced
monitoring and control function, the device is operational from 3.0 V to
60 V. The device is controlled by SPI port for configuration.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/pwm/Kconfig          |  12 ++
 drivers/pwm/Makefile         |   1 +
 drivers/pwm/pwm-mc33xs2410.c | 324 +++++++++++++++++++++++++++++++++++
 3 files changed, 337 insertions(+)
 create mode 100644 drivers/pwm/pwm-mc33xs2410.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4b956d661755..da7048899ea7 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -384,6 +384,18 @@ config PWM_LPSS_PLATFORM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-lpss-platform.
 
+config PWM_MC33XS2410
+	tristate "MC33XS2410 PWM support"
+	depends on OF
+	depends on SPI
+	help
+	  NXP MC33XS2410 high-side switch driver. The MC33XS2410 is a four
+	  channel high-side switch. The device is operational from 3.0 V
+	  to 60 V. The device is controlled by SPI port for configuration.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-mc33xs2410.
+
 config PWM_MESON
 	tristate "Amlogic Meson PWM driver"
 	depends on ARCH_MESON || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index c5ec9e168ee7..6e7904e82c42 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
 obj-$(CONFIG_PWM_LPSS)		+= pwm-lpss.o
 obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
 obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
+obj-$(CONFIG_PWM_MC33XS2410)	+= pwm-mc33xs2410.o
 obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
 obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
 obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
new file mode 100644
index 000000000000..35753039da6b
--- /dev/null
+++ b/drivers/pwm/pwm-mc33xs2410.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/pwm.h>
+
+#include <asm/unaligned.h>
+
+#include <linux/spi/spi.h>
+
+#define MC33XS2410_GLB_CTRL		0x00
+#define MC33XS2410_GLB_CTRL_MODE_MASK	GENMASK(7, 6)
+#define MC33XS2410_GLB_CTRL_NORMAL_MODE	BIT(6)
+#define MC33XS2410_GLB_CTRL_SAFE_MODE	BIT(7)
+#define MC33XS2410_OUT1_4_CTRL		0x02
+#define MC33XS2410_PWM_CTRL1		0x05
+#define MC33XS2410_PWM_CTRL1_POL_INV(x)	BIT(x)
+#define MC33XS2410_PWM_CTRL3		0x07
+#define MC33XS2410_PWM_CTRL3_EN(x)	BIT(4 + (x))
+#define MC33XS2410_PWM_CTRL3_EN_MASK	GENMASK(7, 4)
+#define MC33XS2410_PWM_FREQ1		0x08
+#define MC33XS2410_PWM_FREQ(x)		(MC33XS2410_PWM_FREQ1 + (x))
+#define MC33XS2410_PWM_FREQ_STEP_MASK	GENMASK(7, 6)
+#define MC33XS2410_PWM_FREQ_MASK	GENMASK(5, 0)
+#define MC33XS2410_PWM_DC1		0x0c
+#define MC33XS2410_PWM_DC(x)		(MC33XS2410_PWM_DC1 + (x))
+#define MC33XS2410_WDT			0x14
+
+#define MC33XS2410_IN_OUT_STA		0x01
+#define MC33XS2410_IN_OUT_STA_OUT_EN(x)	BIT(4 + (x))
+
+#define MC33XS2410_WR_FLAG		BIT(7)
+#define MC33XS2410_RD_CTRL_FLAG		BIT(7)
+#define MC33XS2410_RD_DATA_MASK		GENMASK(13, 0)
+
+#define MC33XS2410_PERIOD_MAX	0
+#define MC33XS2410_PERIOD_MIN	1
+
+struct mc33xs2410_pwm {
+	struct pwm_chip chip;
+	struct spi_device *spi;
+	struct mutex lock;
+};
+
+enum mc33xs2410_freq_steps {
+	STEP_05HZ,
+	STEP_2HZ,
+	STEP_8HZ,
+	STEP_32HZ,
+};
+
+/*
+ * When outputs are controlled by SPI, the device supports four frequency ranges
+ * with following steps:
+ * - 0.5 Hz steps from 0.5 Hz to 32 Hz
+ * - 2 Hz steps from 2 Hz to 128 Hz
+ * - 8 Hz steps from 8 Hz to 512 Hz
+ * - 32 Hz steps from 32 Hz to 2048 Hz
+ * Below are the minimum and maximum frequencies converted to periods in ns for
+ * each of the four frequency ranges.
+ */
+static const u32 mc33xs2410_period[4][2] = {
+	[STEP_05HZ] = { 2000000000, 31250000 },
+	[STEP_2HZ] = { 500000000, 7812500 },
+	[STEP_8HZ] = { 125000000, 1953125 },
+	[STEP_32HZ] = { 31250000, 488281 },
+};
+
+static struct mc33xs2410_pwm *mc33xs2410_pwm_from_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct mc33xs2410_pwm, chip);
+}
+
+static int mc33xs2410_write_reg(struct spi_device *spi, u8 reg, u8 val)
+{
+	u8 tx[2];
+
+	tx[0] = reg | MC33XS2410_WR_FLAG;
+	tx[1] = val;
+
+	return spi_write(spi, tx, 2);
+}
+
+static int mc33xs2410_read_reg(struct spi_device *spi, u8 reg, bool ctrl)
+{
+	u8 tx[2], rx[2];
+	int ret;
+
+	tx[0] = reg;
+	tx[1] = ctrl ? MC33XS2410_RD_CTRL_FLAG : 0;
+
+	ret = spi_write(spi, tx, 2);
+	if (ret < 0)
+		return ret;
+
+	ret = spi_read(spi, rx, 2);
+	if (ret < 0)
+		return ret;
+
+	return FIELD_GET(MC33XS2410_RD_DATA_MASK, get_unaligned_be16(rx));
+}
+
+static int mc33xs2410_read_reg_ctrl(struct spi_device *spi, u8 reg)
+{
+	return mc33xs2410_read_reg(spi, reg, true);
+}
+
+static int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val)
+{
+	int ret;
+
+	ret = mc33xs2410_read_reg_ctrl(spi, reg);
+	if (ret < 0)
+		return ret;
+
+	ret &= ~mask;
+	ret |= val & mask;
+
+	return mc33xs2410_write_reg(spi, reg, ret);
+}
+
+static int mc33xs2410_read_reg_diag(struct spi_device *spi, u8 reg)
+{
+	return mc33xs2410_read_reg(spi, reg, false);
+}
+
+static u8 mc33xs2410_pwm_get_freq(const struct pwm_state *state)
+{
+	u32 period, freq, max, min;
+	int step;
+	u8 ret;
+
+	period = state->period;
+	/*
+	 * Check if period is within the limits of each of the four frequency
+	 * ranges, starting with the highest frequency(lowest period). Higher
+	 * frequencies are represented with better resolution by the device.
+	 */
+	for (step = STEP_32HZ; step >= STEP_05HZ; step--) {
+		min = mc33xs2410_period[step][MC33XS2410_PERIOD_MIN];
+		max = mc33xs2410_period[step][MC33XS2410_PERIOD_MAX];
+		if ((period <= max) && (period >= min))
+			break;
+	}
+
+	freq = DIV_ROUND_CLOSEST(max, period) - 1;
+	ret = FIELD_PREP(MC33XS2410_PWM_FREQ_MASK, freq);
+	return (ret | FIELD_PREP(MC33XS2410_PWM_FREQ_STEP_MASK, step));
+}
+
+static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+				const struct pwm_state *state)
+{
+	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_pwm_from_chip(chip);
+	struct spi_device *spi = mc33xs2410->spi;
+	u8 mask, val;
+	int ret;
+
+	if (state->period > mc33xs2410_period[STEP_05HZ][MC33XS2410_PERIOD_MAX])
+		return -EINVAL;
+
+	if (state->period < mc33xs2410_period[STEP_32HZ][MC33XS2410_PERIOD_MIN])
+		return -EINVAL;
+
+	guard(mutex)(&mc33xs2410->lock);
+	mask = MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm);
+	val = (state->polarity == PWM_POLARITY_INVERSED) ? mask : 0;
+	ret = mc33xs2410_modify_reg(spi, MC33XS2410_PWM_CTRL1, mask, val);
+	if (ret < 0)
+		return ret;
+
+	ret = mc33xs2410_write_reg(spi, MC33XS2410_PWM_FREQ(pwm->hwpwm),
+				   mc33xs2410_pwm_get_freq(state));
+	if (ret < 0)
+		return ret;
+
+	ret = mc33xs2410_write_reg(spi, MC33XS2410_PWM_DC(pwm->hwpwm),
+				   pwm_get_relative_duty_cycle(state, 255));
+	if (ret < 0)
+		return ret;
+
+	mask = MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm);
+	val = (state->enabled) ? mask : 0;
+	return mc33xs2410_modify_reg(spi, MC33XS2410_PWM_CTRL3, mask, val);
+}
+
+static int mc33xs2410_pwm_get_state(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    struct pwm_state *state)
+{
+	struct mc33xs2410_pwm *mc33xs2410 = mc33xs2410_pwm_from_chip(chip);
+	struct spi_device *spi = mc33xs2410->spi;
+	u32 freq, code, steps;
+	int ret;
+
+	guard(mutex)(&mc33xs2410->lock);
+	ret = mc33xs2410_read_reg_ctrl(spi, MC33XS2410_PWM_CTRL1);
+	if (ret < 0)
+		return ret;
+
+	state->polarity = (ret & MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm)) ?
+			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+
+	ret = mc33xs2410_read_reg_ctrl(spi, MC33XS2410_PWM_FREQ(pwm->hwpwm));
+	if (ret < 0)
+		return ret;
+
+	/* Lowest frequency steps are starting with 0.5Hz, scale them by two. */
+	steps = (FIELD_GET(MC33XS2410_PWM_FREQ_STEP_MASK, ret) * 2) << 1;
+	code = FIELD_GET(MC33XS2410_PWM_FREQ_MASK, ret);
+	/* Frequency = (code + 1) x steps */
+	freq = (code + 1) * steps;
+	/* Convert frequency to period in ns, considering scaled steps value. */
+	state->period = 2000000000ULL / (freq);
+
+	ret = mc33xs2410_read_reg_ctrl(spi, MC33XS2410_PWM_DC(pwm->hwpwm));
+	if (ret < 0)
+		return ret;
+
+	ret = pwm_set_relative_duty_cycle(state, ret, 255);
+	if (ret)
+		return ret;
+
+	ret = mc33xs2410_read_reg_diag(spi, MC33XS2410_IN_OUT_STA);
+	if (ret < 0)
+		return ret;
+
+	state->enabled = !!(ret & MC33XS2410_IN_OUT_STA_OUT_EN(pwm->hwpwm));
+
+	return 0;
+}
+
+static const struct pwm_ops mc33xs2410_pwm_ops = {
+	.apply = mc33xs2410_pwm_apply,
+	.get_state = mc33xs2410_pwm_get_state,
+};
+
+static int mc33xs2410_reset(struct device *dev)
+{
+	struct gpio_desc *reset_gpio;
+
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR_OR_NULL(reset_gpio))
+		return PTR_ERR_OR_ZERO(reset_gpio);
+
+	fsleep(1000);
+	gpiod_set_value_cansleep(reset_gpio, 0);
+	/* Wake-up time */
+	fsleep(10000);
+
+	return 0;
+}
+
+static int mc33xs2410_probe(struct spi_device *spi)
+{
+	struct mc33xs2410_pwm *mc33xs2410;
+	struct device *dev = &spi->dev;
+	int ret;
+
+	mc33xs2410 = devm_kzalloc(&spi->dev, sizeof(*mc33xs2410), GFP_KERNEL);
+	if (!mc33xs2410)
+		return -ENOMEM;
+
+	mc33xs2410->chip.dev = dev;
+	mc33xs2410->chip.ops = &mc33xs2410_pwm_ops;
+	mc33xs2410->chip.npwm = 4;
+	mc33xs2410->spi = spi;
+	mutex_init(&mc33xs2410->lock);
+
+	ret = mc33xs2410_reset(dev);
+	if (ret)
+		return ret;
+
+	/* Disable watchdog */
+	ret = mc33xs2410_write_reg(spi, MC33XS2410_WDT, 0x0);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to disable watchdog\n");
+
+	/* Transitition to normal mode */
+	ret = mc33xs2410_modify_reg(spi, MC33XS2410_GLB_CTRL,
+				    MC33XS2410_GLB_CTRL_MODE_MASK,
+				    MC33XS2410_GLB_CTRL_NORMAL_MODE);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to transition to normal mode\n");
+
+	ret = devm_pwmchip_add(dev, &mc33xs2410->chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
+
+	return 0;
+}
+
+static const struct spi_device_id mc33xs2410_spi_id[] = {
+	{ "mc33xs2410", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, mc33xs2410_spi_id);
+
+static const struct of_device_id mc33xs2410_of_match[] = {
+	{ .compatible = "nxp,mc33xs2410" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mc33xs2410_of_match);
+
+static struct spi_driver mc33xs2410_driver = {
+	.driver = {
+		.name = "mc33xs2410-pwm",
+		.of_match_table = mc33xs2410_of_match,
+	},
+	.probe = mc33xs2410_probe,
+	.id_table = mc33xs2410_spi_id,
+};
+module_spi_driver(mc33xs2410_driver);
+
+MODULE_DESCRIPTION("NXP MC33XS2410 high-side switch driver");
+MODULE_AUTHOR("Dimitri Fedrau <dima.fedrau@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.39.2


