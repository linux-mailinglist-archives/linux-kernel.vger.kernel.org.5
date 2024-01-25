Return-Path: <linux-kernel+bounces-38067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7408583BA90
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5AAB284185
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D425711C92;
	Thu, 25 Jan 2024 07:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/HoMvL8"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813BF12B72;
	Thu, 25 Jan 2024 07:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706167306; cv=none; b=jQqYCNvN3OGBQ4CKPmbssG25pfPpPNx1vaFgf1meflCmcLWyDud+lBJaAUF+xQtUt6Mas9RMRAfB9ZORLYUOuvnKe8I00Hn4xCFHp0A0t+gUuLZxhVfIkC+pFnbc3X8R0xavHQbRuLK9OMQkmqolyAIB9b43ZqxPW7HYygfsE40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706167306; c=relaxed/simple;
	bh=wWGFv8wX5KgVDWx8aougVjj7FmcBQ1M7zx64c0M7Rs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/y1gKR8WkPM9GzrJzmA4pZXVJOEnNob9GDorGwrx3ujwMm6LIVJcqtbTZs69MH74wNewvvY4Nxio5F/8GmHOrmsuG2duBhk8kZqXhiWm6KtdqTKTlBYyPOCwbvrZ1yFLTCXaHOVIVnf5eqsJ7KKgW/A+oZZBgX5wvn56p51q/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/HoMvL8; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-510133ed214so1983210e87.1;
        Wed, 24 Jan 2024 23:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706167302; x=1706772102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucwfhF0Wm+thFoShz/kiL2gWd8fvBX4xoOT4gyUeOfc=;
        b=H/HoMvL8Opgf0x3KFS/2opEaEWt+X3FW3NsUM2TtJKwLd1yOTEZH3crOMRyhMqYrK1
         gpD0oyofk5S2MOAPnZdS/Ilcq//flBeVuUUiqWn9IELoilm7xDeSBuIC3rWEVmrv28kx
         MfbQEVXAk4ZhpAVsPfRGA6vRY0cmNUTG2yd+kaTGzUySHjpnrK+8TD1JpKncFf9xjg4q
         KQAh1VF0LxPymbxKVNeSIw9QROnt6gMrzQWxolpTFXFkQuO/IkiR1qJYqEdLZ6eQr0oZ
         wto/tyEkv2fWhBeS6gA9pmBLqjpsVsT2NTxowcp1Ah6x0KDVOJ1Jns9PSjf1IRoQw1EC
         v1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706167302; x=1706772102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucwfhF0Wm+thFoShz/kiL2gWd8fvBX4xoOT4gyUeOfc=;
        b=lwiDeCmXWdF+bw+ikdNUjvhzxBEsvXrGYcDnlbCENMcD2CBJ01lq8X9w+7EQujYRY4
         SnX+GY7j8RnAWucMSvXtAUMZ/FavkQVXfcoQpMk74OMUOENkmpK6e7lNlAcbMN6FA465
         RMtN44o7ml41j/0JBiyZzLhuQT1IwZy4qSp/SJdJDQo4q6LuqHGxCFqbdPYpeXjGYfKJ
         A5RS32vXOZ3l5KLyS5iiAVJYduOd9Tw2uIo70coEi+oT8SwmEgXz0ru5jACaX5wOgN8M
         SN+j02+UFyEyaKNVISafDsAWYbW6/4p6n8k20oWdHcEPfnlg8tzKScF5dxrQxH2dXhU0
         hnig==
X-Gm-Message-State: AOJu0YzKtGifiltoThNCJ4VTLxPHXgLRQvMPVM2gPRd9SIHNRLb+VHdL
	ZNCqkH+zDf2h5hpoFIRDh62gHbBw44C69Pja+V6x89VSOF8uGE68+e4jOBtYSONdzx0=
X-Google-Smtp-Source: AGHT+IHzkiQqW34PpAqYJnMR1uNL+qWN9VamDeetuhxzGdPRM05aWVOokeTgbCSzXzS9AjPemNQYzg==
X-Received: by 2002:a05:6512:b8a:b0:50e:7c08:4350 with SMTP id b10-20020a0565120b8a00b0050e7c084350mr330060lfv.42.1706167301789;
        Wed, 24 Jan 2024 23:21:41 -0800 (PST)
Received: from localhost.localdomain ([188.162.200.139])
        by smtp.gmail.com with ESMTPSA id x37-20020a056512132500b0050e75f9e8c8sm2780070lfu.98.2024.01.24.23.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 23:21:41 -0800 (PST)
From: Aleksandr Shubin <privatesub2@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Aleksandr Shubin <privatesub2@gmail.com>,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	John Watts <contact@jookia.org>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH v7 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
Date: Thu, 25 Jan 2024 10:19:42 +0300
Message-Id: <20240125072032.1151383-3-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125072032.1151383-1-privatesub2@gmail.com>
References: <20240125072032.1151383-1-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Allwinner's D1, T113-S3 and R329 SoCs have a quite different PWM
controllers with ones supported by pwm-sun4i driver.

This patch adds a PWM controller driver for Allwinner's D1,
T113-S3 and R329 SoCs. The main difference between these SoCs
is the number of channels defined by the DT property.

Co-developed-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
---
 drivers/pwm/Kconfig      |  10 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-sun20i.c | 380 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 391 insertions(+)
 create mode 100644 drivers/pwm/pwm-sun20i.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4b956d661755..d2e0a080eb3c 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -625,6 +625,16 @@ config PWM_SUN4I
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sun4i.
 
+config PWM_SUN20I
+	tristate "Allwinner D1/T113s/R329 PWM support"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on COMMON_CLK
+	help
+	  Generic PWM framework driver for Allwinner D1/T113s/R329 SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-sun20i.
+
 config PWM_SUNPLUS
 	tristate "Sunplus PWM support"
 	depends on ARCH_SUNPLUS || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index c5ec9e168ee7..dcad0d5a2430 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
 obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
 obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
 obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
+obj-$(CONFIG_PWM_SUN20I)	+= pwm-sun20i.o
 obj-$(CONFIG_PWM_SUNPLUS)	+= pwm-sunplus.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
 obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
diff --git a/drivers/pwm/pwm-sun20i.c b/drivers/pwm/pwm-sun20i.c
new file mode 100644
index 000000000000..d9e151f27f20
--- /dev/null
+++ b/drivers/pwm/pwm-sun20i.c
@@ -0,0 +1,380 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PWM Controller Driver for sunxi platforms (D1, T113-S3 and R329)
+ *
+ * Limitations:
+ * - When the parameters change, current running period will not be completed
+ *   and run new settings immediately.
+ * - It output HIGH-Z state when PWM channel disabled.
+ *
+ * Copyright (c) 2023 Aleksandr Shubin <privatesub2@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/pwm.h>
+#include <linux/reset.h>
+
+#define SUN20I_PWM_CLK_CFG(chan)		(0x20 + (((chan) >> 1) * 0x4))
+#define SUN20I_PWM_CLK_CFG_SRC			GENMASK(8, 7)
+#define SUN20I_PWM_CLK_CFG_DIV_M		GENMASK(3, 0)
+#define SUN20I_PWM_CLK_DIV_M_MAX		8
+
+#define SUN20I_PWM_CLK_GATE			0x40
+#define SUN20I_PWM_CLK_GATE_BYPASS(chan)	BIT((chan) + 16)
+#define SUN20I_PWM_CLK_GATE_GATING(chan)	BIT(chan)
+
+#define SUN20I_PWM_ENABLE			0x80
+#define SUN20I_PWM_ENABLE_EN(chan)		BIT(chan)
+
+#define SUN20I_PWM_CTL(chan)			(0x100 + (chan) * 0x20)
+#define SUN20I_PWM_CTL_ACT_STA			BIT(8)
+#define SUN20I_PWM_CTL_PRESCAL_K		GENMASK(7, 0)
+#define SUN20I_PWM_CTL_PRESCAL_K_MAX		0xff
+
+#define SUN20I_PWM_PERIOD(chan)			(0x104 + (chan) * 0x20)
+#define SUN20I_PWM_PERIOD_ENTIRE_CYCLE		GENMASK(31, 16)
+#define SUN20I_PWM_PERIOD_ACT_CYCLE		GENMASK(15, 0)
+
+#define SUN20I_PWM_PCNTR_SIZE			BIT(16)
+
+/**
+ * SUN20I_PWM_MAGIC is used to quickly compute the values of the clock dividers
+ * div_m (SUN20I_PWM_CLK_CFG_DIV_M) & prescale_k (SUN20I_PWM_CTL_PRESCAL_K)
+ * without using a loop. These dividers limit the # of cycles in a period
+ * to SUN20I_PWM_PCNTR_SIZE by applying a scaling factor of
+ * 1/(div_m * (prescale_k + 1)) to the clock source.
+ *
+ * SUN20I_PWM_MAGIC is derived by solving for div_m and prescale_k
+ * such that for a given requested period,
+ *
+ * i) div_m is minimized for any prescale_k ≤ SUN20I_PWM_CTL_PRESCAL_K_MAX,
+ * ii) prescale_k is minimized.
+ *
+ * The derivation proceeds as follows, with val = # of cycles for reqested
+ * period:
+ *
+ * for a given value of div_m we want the smallest prescale_k such that
+ *
+ * (val >> div_m) // (prescale_k + 1) ≤ 65536 (SUN20I_PWM_PCNTR_SIZE)
+ *
+ * This is equivalent to:
+ *
+ * (val >> div_m) ≤ 65536 * (prescale_k + 1) + prescale_k
+ * ⟺ (val >> div_m) ≤ 65537 * prescale_k + 65536
+ * ⟺ (val >> div_m) - 65536 ≤ 65537 * prescale_k
+ * ⟺ ((val >> div_m) - 65536) / 65537 ≤ prescale_k
+ *
+ * As prescale_k is integer, this becomes
+ *
+ * ((val >> div_m) - 65536) // 65537 ≤ prescale_k
+ *
+ * And is minimized at
+ *
+ * ((val >> div_m) - 65536) // 65537
+ *
+ * Now we pick the smallest div_m that satifies prescale_k ≤ 255
+ * (i.e SUN20I_PWM_CTL_PRESCAL_K_MAX),
+ *
+ * ((val >> div_m) - 65536) // 65537 ≤ 255
+ * ⟺ (val >> div_m) - 65536 ≤ 255 * 65537 + 65536
+ * ⟺ val >> div_m ≤ 255 * 65537 + 2 * 65536
+ * ⟺ val >> div_m < (255 * 65537 + 2 * 65536 + 1)
+ * ⟺ div_m = fls((val) / (255 * 65537 + 2 * 65536 + 1))
+ *
+ * Suggested by Uwe Kleine-König
+ */
+#define SUN20I_PWM_MAGIC			(255 * 65537 + 2 * 65536 + 1)
+
+struct sun20i_pwm_chip {
+	struct clk *clk_bus, *clk_hosc, *clk_apb0;
+	struct reset_control *rst;
+	struct pwm_chip chip;
+	void __iomem *base;
+	/* Mutex to protect pwm apply state */
+	struct mutex mutex;
+};
+
+static inline struct sun20i_pwm_chip *to_sun20i_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct sun20i_pwm_chip, chip);
+}
+
+static inline u32 sun20i_pwm_readl(struct sun20i_pwm_chip *chip,
+				   unsigned long offset)
+{
+	return readl(chip->base + offset);
+}
+
+static inline void sun20i_pwm_writel(struct sun20i_pwm_chip *chip,
+				     u32 val, unsigned long offset)
+{
+	writel(val, chip->base + offset);
+}
+
+static int sun20i_pwm_get_state(struct pwm_chip *chip,
+				struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct sun20i_pwm_chip *sun20i_chip = to_sun20i_pwm_chip(chip);
+	u16 ent_cycle, act_cycle, prescale_k;
+	u64 clk_rate, tmp;
+	u8 div_m;
+	u32 val;
+
+	mutex_lock(&sun20i_chip->mutex);
+
+	val = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CLK_CFG(pwm->hwpwm));
+	div_m = FIELD_GET(SUN20I_PWM_CLK_CFG_DIV_M, val);
+	if (div_m > SUN20I_PWM_CLK_DIV_M_MAX)
+		div_m = SUN20I_PWM_CLK_DIV_M_MAX;
+
+	if (FIELD_GET(SUN20I_PWM_CLK_CFG_SRC, val) == 0)
+		clk_rate = clk_get_rate(sun20i_chip->clk_hosc);
+	else
+		clk_rate = clk_get_rate(sun20i_chip->clk_apb0);
+
+	val = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CTL(pwm->hwpwm));
+	state->polarity = (SUN20I_PWM_CTL_ACT_STA & val) ?
+			   PWM_POLARITY_NORMAL : PWM_POLARITY_INVERSED;
+
+	prescale_k = FIELD_GET(SUN20I_PWM_CTL_PRESCAL_K, val) + 1;
+
+	val = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_ENABLE);
+	state->enabled = (SUN20I_PWM_ENABLE_EN(pwm->hwpwm) & val) ? true : false;
+
+	val = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_PERIOD(pwm->hwpwm));
+
+	mutex_unlock(&sun20i_chip->mutex);
+
+	act_cycle = FIELD_GET(SUN20I_PWM_PERIOD_ACT_CYCLE, val);
+	ent_cycle = FIELD_GET(SUN20I_PWM_PERIOD_ENTIRE_CYCLE, val);
+
+	/*
+	 * The duration of the active phase should not be longer
+	 * than the duration of the period
+	 */
+	if (act_cycle > ent_cycle)
+		act_cycle = ent_cycle;
+
+	tmp = ((u64)(act_cycle) * prescale_k << div_m) * NSEC_PER_SEC;
+	state->duty_cycle = DIV_ROUND_UP_ULL(tmp, clk_rate);
+	tmp = ((u64)(ent_cycle) * prescale_k << div_m) * NSEC_PER_SEC;
+	state->period = DIV_ROUND_UP_ULL(tmp, clk_rate);
+
+	return 0;
+}
+
+static int sun20i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct sun20i_pwm_chip *sun20i_chip = to_sun20i_pwm_chip(chip);
+	u64 bus_rate, hosc_rate, val, ent_cycle, act_cycle;
+	u32 clk_gate, clk_cfg, pwm_en, ctl, reg_period;
+	u32 prescale_k, div_m;
+	bool use_bus_clk;
+	int ret = 0;
+
+	mutex_lock(&sun20i_chip->mutex);
+
+	pwm_en = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_ENABLE);
+
+	if (state->enabled != pwm->state.enabled) {
+		clk_gate = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CLK_GATE);
+
+		if (!state->enabled) {
+			clk_gate &= ~SUN20I_PWM_CLK_GATE_GATING(pwm->hwpwm);
+			pwm_en &= ~SUN20I_PWM_ENABLE_EN(pwm->hwpwm);
+			sun20i_pwm_writel(sun20i_chip, pwm_en, SUN20I_PWM_ENABLE);
+			sun20i_pwm_writel(sun20i_chip, clk_gate, SUN20I_PWM_CLK_GATE);
+		}
+	}
+
+	if (state->polarity != pwm->state.polarity ||
+	    state->duty_cycle != pwm->state.duty_cycle ||
+	    state->period != pwm->state.period) {
+		ctl = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CTL(pwm->hwpwm));
+		clk_cfg = sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CLK_CFG(pwm->hwpwm));
+		hosc_rate = clk_get_rate(sun20i_chip->clk_hosc);
+		bus_rate = clk_get_rate(sun20i_chip->clk_apb0);
+		if (pwm_en & SUN20I_PWM_ENABLE_EN(pwm->hwpwm ^ 1)) {
+			/* if the neighbor channel is enable, check period only */
+			use_bus_clk = FIELD_GET(SUN20I_PWM_CLK_CFG_SRC, clk_cfg) != 0;
+			val = mul_u64_u64_div_u64(state->period,
+						  (use_bus_clk ? bus_rate : hosc_rate),
+						  NSEC_PER_SEC);
+
+			div_m = FIELD_GET(SUN20I_PWM_CLK_CFG_DIV_M, clk_cfg);
+		} else {
+			/* check period and select clock source */
+			use_bus_clk = false;
+			val = mul_u64_u64_div_u64(state->period, hosc_rate, NSEC_PER_SEC);
+			if (val <= 1) {
+				use_bus_clk = true;
+				val = mul_u64_u64_div_u64(state->period, bus_rate, NSEC_PER_SEC);
+				if (val <= 1) {
+					ret = -EINVAL;
+					goto unlock_mutex;
+				}
+			}
+			div_m = fls(DIV_ROUND_DOWN_ULL(val, SUN20I_PWM_MAGIC));
+			if (div_m > SUN20I_PWM_CLK_DIV_M_MAX) {
+				ret = -EINVAL;
+				goto unlock_mutex;
+			}
+
+			/* set up the CLK_DIV_M and clock CLK_SRC */
+			clk_cfg = FIELD_PREP(SUN20I_PWM_CLK_CFG_DIV_M, div_m);
+			clk_cfg |= FIELD_PREP(SUN20I_PWM_CLK_CFG_SRC, use_bus_clk);
+
+			sun20i_pwm_writel(sun20i_chip, clk_cfg, SUN20I_PWM_CLK_CFG(pwm->hwpwm));
+		}
+
+		/* calculate prescale_k, PWM entire cycle */
+		ent_cycle = val >> div_m;
+		prescale_k = DIV_ROUND_DOWN_ULL(ent_cycle, 65537);
+		if (prescale_k > SUN20I_PWM_CTL_PRESCAL_K_MAX)
+			prescale_k = SUN20I_PWM_CTL_PRESCAL_K_MAX;
+
+		do_div(ent_cycle, prescale_k + 1);
+
+		/* for N cycles, PPRx.PWM_ENTIRE_CYCLE = (N-1) */
+		reg_period = FIELD_PREP(SUN20I_PWM_PERIOD_ENTIRE_CYCLE, ent_cycle - 1);
+
+		/* set duty cycle */
+		val = mul_u64_u64_div_u64(state->duty_cycle,
+					  (use_bus_clk ? bus_rate : hosc_rate),
+					  NSEC_PER_SEC);
+		act_cycle = val >> div_m;
+		do_div(act_cycle, prescale_k + 1);
+
+		/*
+		 * The formula of the output period and the duty-cycle for PWM are as follows.
+		 * T period = (PWM01_CLK / PWM0_PRESCALE_K)^-1 * (PPR0.PWM_ENTIRE_CYCLE + 1)
+		 * T high-level = (PWM01_CLK / PWM0_PRESCALE_K)^-1 * PPR0.PWM_ACT_CYCLE
+		 * Duty-cycle = T high-level / T period
+		 */
+		reg_period |= FIELD_PREP(SUN20I_PWM_PERIOD_ACT_CYCLE, act_cycle);
+		sun20i_pwm_writel(sun20i_chip, reg_period, SUN20I_PWM_PERIOD(pwm->hwpwm));
+
+		ctl = FIELD_PREP(SUN20I_PWM_CTL_PRESCAL_K, prescale_k);
+		if (state->polarity == PWM_POLARITY_NORMAL)
+			ctl |= SUN20I_PWM_CTL_ACT_STA;
+
+		sun20i_pwm_writel(sun20i_chip, ctl, SUN20I_PWM_CTL(pwm->hwpwm));
+	}
+
+	if (state->enabled != pwm->state.enabled && state->enabled) {
+		clk_gate &= ~SUN20I_PWM_CLK_GATE_BYPASS(pwm->hwpwm);
+		clk_gate |= SUN20I_PWM_CLK_GATE_GATING(pwm->hwpwm);
+		pwm_en |= SUN20I_PWM_ENABLE_EN(pwm->hwpwm);
+		sun20i_pwm_writel(sun20i_chip, pwm_en, SUN20I_PWM_ENABLE);
+		sun20i_pwm_writel(sun20i_chip, clk_gate, SUN20I_PWM_CLK_GATE);
+	}
+
+unlock_mutex:
+	mutex_unlock(&sun20i_chip->mutex);
+
+	return ret;
+}
+
+static const struct pwm_ops sun20i_pwm_ops = {
+	.get_state = sun20i_pwm_get_state,
+	.apply = sun20i_pwm_apply,
+	.owner = THIS_MODULE,
+};
+
+static const struct of_device_id sun20i_pwm_dt_ids[] = {
+	{ .compatible = "allwinner,sun20i-d1-pwm" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sun20i_pwm_dt_ids);
+
+static int sun20i_pwm_probe(struct platform_device *pdev)
+{
+	struct sun20i_pwm_chip *sun20i_chip;
+	int ret;
+
+	sun20i_chip = devm_kzalloc(&pdev->dev, sizeof(*sun20i_chip), GFP_KERNEL);
+	if (!sun20i_chip)
+		return -ENOMEM;
+
+	sun20i_chip->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(sun20i_chip->base))
+		return PTR_ERR(sun20i_chip->base);
+
+	sun20i_chip->clk_bus = devm_clk_get_enabled(&pdev->dev, "bus");
+	if (IS_ERR(sun20i_chip->clk_bus))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_bus),
+				     "failed to get bus clock\n");
+
+	sun20i_chip->clk_hosc = devm_clk_get_enabled(&pdev->dev, "hosc");
+	if (IS_ERR(sun20i_chip->clk_hosc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_hosc),
+				     "failed to get hosc clock\n");
+
+	sun20i_chip->clk_apb0 = devm_clk_get_enabled(&pdev->dev, "apb0");
+	if (IS_ERR(sun20i_chip->clk_apb0))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_apb0),
+				     "failed to get apb0 clock\n");
+
+	sun20i_chip->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(sun20i_chip->rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->rst),
+				     "failed to get bus reset\n");
+
+	ret = of_property_read_u32(pdev->dev.of_node, "allwinner,pwm-channels",
+				   &sun20i_chip->chip.npwm);
+	if (ret)
+		sun20i_chip->chip.npwm = 8;
+
+	if (sun20i_chip->chip.npwm > 16)
+		sun20i_chip->chip.npwm = 16;
+
+	/* Deassert reset */
+	ret = reset_control_deassert(sun20i_chip->rst);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to deassert reset\n");
+
+	sun20i_chip->chip.dev = &pdev->dev;
+	sun20i_chip->chip.ops = &sun20i_pwm_ops;
+
+	mutex_init(&sun20i_chip->mutex);
+
+	ret = pwmchip_add(&sun20i_chip->chip);
+	if (ret < 0) {
+		reset_control_assert(sun20i_chip->rst);
+		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
+	}
+
+	platform_set_drvdata(pdev, sun20i_chip);
+
+	return 0;
+}
+
+static void sun20i_pwm_remove(struct platform_device *pdev)
+{
+	struct sun20i_pwm_chip *sun20i_chip = platform_get_drvdata(pdev);
+
+	pwmchip_remove(&sun20i_chip->chip);
+
+	reset_control_assert(sun20i_chip->rst);
+}
+
+static struct platform_driver sun20i_pwm_driver = {
+	.driver = {
+		.name = "sun20i-pwm",
+		.of_match_table = sun20i_pwm_dt_ids,
+	},
+	.probe = sun20i_pwm_probe,
+	.remove_new = sun20i_pwm_remove,
+};
+module_platform_driver(sun20i_pwm_driver);
+
+MODULE_AUTHOR("Aleksandr Shubin <privatesub2@gmail.com>");
+MODULE_DESCRIPTION("Allwinner sun20i PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


