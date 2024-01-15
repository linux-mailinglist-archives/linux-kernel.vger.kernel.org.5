Return-Path: <linux-kernel+bounces-26467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC5682E15A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53522837E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A74199D4;
	Mon, 15 Jan 2024 20:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ec6KjOdQ"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F6A19473
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-429ca07044eso27506351cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 12:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705349546; x=1705954346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlyjMbXX7dD5x9ylf1SatJOm6rOrNdvCTEfPJ8hoU0M=;
        b=ec6KjOdQVrK6LYJXM1YcZLxgRvPuTtyQxcnpc9BLtK2PQtyw/qJXE7ec/N0c0T90AB
         mxNY6Pu+9vnvGD+uyJKtTPXFHDSc+0BaOikdYXdXcdyyENMTEdx2VYYfcUeEtwwAtuYJ
         No7cjVJ5XzDhJRnb1/Aa7reoTns4+wtWemYvjCEm6ICDQE+213V2a4Ai02lakv7x2kqO
         hmtZByBSPdsUPkVGMbySaPwny4f5HOtwJALO0G7KmT0fsIsqT0RXe1M6bazOWNVBWsqA
         vIcmfkZKzBE6lce2HfetY9UjVSDYCjQnCFUN+FXJwRGoIqC+1J5GZE+rm5g4c6ge2oDT
         8SEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705349546; x=1705954346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlyjMbXX7dD5x9ylf1SatJOm6rOrNdvCTEfPJ8hoU0M=;
        b=d04E6OJdhO0FdjhVpXULNTFCwuQBATrTYC3tf0Lr9/4fVcvCOnXEWfJ/plvd/45yo8
         HStClaqUeek4aJt/ImQA3QqzCdv8aiwNjN3uTKQ9s6WpXXLXfe3q3MhFKBfXUlC4ZyT7
         TMCPGGdt+FZuuX7glYiKiGaI4FPLGcrSXNtKou1EoQ1FgUeL4uyTKm9R5QTf4VLQAASr
         WdbaK98XvKei8LKDGah0iWiAc/1oA3PZhedEJ7knxJioOShxHvpu/jmV1JIYQ7b2q8s/
         8A7EqrFUOoSPqVxI622p71wsQff5M/s2ih5zDgvy0rendYDghoNrugS7M9zc9B4NoWUx
         FFPg==
X-Gm-Message-State: AOJu0Yy2IFjZn7fbQJqrJGO39bl40iOv5kPMa0zCUKtbHGDqlzjs6LZZ
	//zY79YwXSKcR/dYglVMwk9sIDEAk7TM5w==
X-Google-Smtp-Source: AGHT+IHsFPnlDe8aM68LuUQaHgo/5cq5TNgRW9YoSSPFEEgOy1wK5a6BjNA7QiTisgd5YcIpmQ5pgQ==
X-Received: by 2002:a05:622a:1ba4:b0:429:f4f8:8143 with SMTP id bp36-20020a05622a1ba400b00429f4f88143mr1982881qtb.61.1705349546342;
        Mon, 15 Jan 2024 12:12:26 -0800 (PST)
Received: from workbox.taildc8f3.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id y26-20020ac8525a000000b004298b33cdcasm4219170qtn.50.2024.01.15.12.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 12:12:26 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Subject: [PATCH 2/2] pwm: Add driver for AXI PWM generator
Date: Mon, 15 Jan 2024 15:12:21 -0500
Message-ID: <20240115201222.1423626-3-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115201222.1423626-1-tgamblin@baylibre.com>
References: <20240115201222.1423626-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Drew Fustini <dfustini@baylibre.com>

Add support for the Analog Devices AXI PWM Generator. This device is an
FPGA-implemented peripheral used as PWM signal generator and can be
interfaced with AXI4. The register map of this peripheral makes it
possible to configure the period and duty cycle of the output signal.

Link: https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen
Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Co-developed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 MAINTAINERS                  |   1 +
 drivers/pwm/Kconfig          |  12 ++
 drivers/pwm/Makefile         |   1 +
 drivers/pwm/pwm-axi-pwmgen.c | 229 +++++++++++++++++++++++++++++++++++
 4 files changed, 243 insertions(+)
 create mode 100644 drivers/pwm/pwm-axi-pwmgen.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b0f3aec5381..3abe90dec82e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3422,6 +3422,7 @@ L:	linux-pwm@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
+F:	drivers/pwm/pwm-axi-pwmgen.c
 
 AXXIA I2C CONTROLLER
 M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4b956d661755..b105c0db4936 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -98,6 +98,18 @@ config PWM_ATMEL_TCB
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-atmel-tcb.
 
+config PWM_AXI_PWMGEN
+	tristate "Analog Devices AXI PWM generator"
+	select REGMAP_MMIO
+	help
+	  This enables support for the Analog Devices AXI PWM generator.
+
+	  This is a configurable PWM generator with variable pulse width and
+	  period.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called pwm-axi-pwmgen.
+
 config PWM_BCM_IPROC
 	tristate "iProc PWM support"
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index c5ec9e168ee7..8322089954e9 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
 obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
+obj-$(CONFIG_PWM_AXI_PWMGEN)	+= pwm-axi-pwmgen.o
 obj-$(CONFIG_PWM_BCM_IPROC)	+= pwm-bcm-iproc.o
 obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
 obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
new file mode 100644
index 000000000000..5e91636b88b4
--- /dev/null
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Analog Devices AXI PWM generator
+ *
+ * Copyright 2024 Analog Devices Inc.
+ * Copyright 2024 Baylibre SAS
+ */
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define AXI_PWMGEN_NPWM			4
+#define AXI_PWMGEN_REG_CORE_VERSION	0x00
+#define AXI_PWMGEN_REG_ID		0x04
+#define AXI_PWMGEN_REG_SCRATCHPAD	0x08
+#define AXI_PWMGEN_REG_CORE_MAGIC	0x0C
+#define AXI_PWMGEN_REG_CONFIG		0x10
+#define AXI_PWMGEN_REG_NPWM		0x14
+#define AXI_PWMGEN_CH_PERIOD_BASE	0x40
+#define AXI_PWMGEN_CH_DUTY_BASE		0x44
+#define AXI_PWMGEN_CH_OFFSET_BASE	0x48
+#define AXI_PWMGEN_CHX_PERIOD(ch)	(AXI_PWMGEN_CH_PERIOD_BASE + (12 * (ch)))
+#define AXI_PWMGEN_CHX_DUTY(ch)		(AXI_PWMGEN_CH_DUTY_BASE + (12 * (ch)))
+#define AXI_PWMGEN_CHX_OFFSET(ch)	(AXI_PWMGEN_CH_OFFSET_BASE + (12 * (ch)))
+#define AXI_PWMGEN_TEST_DATA		0x5A0F0081
+#define AXI_PWMGEN_LOAD_CONFIG		BIT(1)
+#define AXI_PWMGEN_RESET		BIT(0)
+#define AXI_PWMGEN_MAX_REGISTER		0x6C
+
+struct axi_pwmgen {
+	struct pwm_chip		chip;
+	struct clk		*clk;
+	struct regmap		*regmap;
+
+	/* Used to store the period when the channel is disabled */
+	unsigned int		ch_period[AXI_PWMGEN_NPWM];
+	bool			ch_enabled[AXI_PWMGEN_NPWM];
+};
+
+static const struct regmap_config axi_pwm_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = AXI_PWMGEN_MAX_REGISTER,
+};
+
+static struct axi_pwmgen *to_axi_pwmgen(struct pwm_chip *chip)
+{
+	return container_of(chip, struct axi_pwmgen, chip);
+}
+
+static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *device,
+			    const struct pwm_state *state)
+{
+	struct axi_pwmgen *pwm = to_axi_pwmgen(chip);
+	unsigned long clk_rate_hz = clk_get_rate(pwm->clk);
+	unsigned int ch = device->hwpwm;
+	struct regmap *regmap = pwm->regmap;
+	u64 period_cnt, duty_cnt;
+	int ret;
+
+	if (!clk_rate_hz)
+		return -EINVAL;
+
+	period_cnt = DIV_ROUND_UP_ULL(state->period * clk_rate_hz, NSEC_PER_SEC);
+	if (period_cnt > UINT_MAX)
+		return -EINVAL;
+
+	pwm->ch_period[ch] = period_cnt;
+	pwm->ch_enabled[ch] = state->enabled;
+	ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), state->enabled ? period_cnt : 0);
+	if (ret)
+		return ret;
+
+	duty_cnt = DIV_ROUND_UP_ULL(state->duty_cycle * clk_rate_hz, NSEC_PER_SEC);
+	ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), duty_cnt);
+	if (ret)
+		return ret;
+
+	return regmap_write(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_LOAD_CONFIG);
+}
+
+static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_device *device,
+				struct pwm_state *state)
+{
+	struct axi_pwmgen *pwm = to_axi_pwmgen(chip);
+	unsigned long clk_rate_hz = clk_get_rate(pwm->clk);
+	struct regmap *regmap = pwm->regmap;
+	unsigned int ch = device->hwpwm;
+	u32 cnt;
+	int ret;
+
+	if (!clk_rate_hz) {
+		dev_err(device->chip->dev, "axi pwm clock has no frequency\n");
+		return -EINVAL;
+	}
+
+	state->enabled = pwm->ch_enabled[ch];
+
+	if (state->enabled) {
+		ret = regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(ch), &cnt);
+		if (ret)
+			return ret;
+	} else {
+		cnt = pwm->ch_period[ch];
+	}
+
+	state->period = DIV_ROUND_CLOSEST_ULL((u64)cnt * NSEC_PER_SEC, clk_rate_hz);
+
+	ret = regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(ch), &cnt);
+	if (ret)
+		return ret;
+
+	state->duty_cycle = DIV_ROUND_CLOSEST_ULL((u64)cnt * NSEC_PER_SEC, clk_rate_hz);
+
+	return 0;
+}
+
+static const struct pwm_ops axi_pwmgen_pwm_ops = {
+	.apply = axi_pwmgen_apply,
+	.get_state = axi_pwmgen_get_state,
+};
+
+static int axi_pwmgen_setup(struct axi_pwmgen *pwm, struct device *dev)
+{
+	struct regmap *regmap = pwm->regmap;
+	int idx;
+	int ret;
+	u32 val;
+
+	ret = regmap_write(regmap, AXI_PWMGEN_REG_SCRATCHPAD, AXI_PWMGEN_TEST_DATA);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(regmap, AXI_PWMGEN_REG_SCRATCHPAD, &val);
+	if (ret)
+		return ret;
+
+	if (val != AXI_PWMGEN_TEST_DATA)
+		return dev_err_probe(dev, -EIO, "failed to access the device registers\n");
+
+	ret = regmap_read(regmap, AXI_PWMGEN_REG_NPWM, &pwm->chip.npwm);
+	if (ret)
+		return ret;
+
+	if (pwm->chip.npwm > AXI_PWMGEN_NPWM) {
+		dev_warn(dev, "driver is limited to %d channels but hardware reported %u\n",
+				AXI_PWMGEN_NPWM, pwm->chip.npwm);
+		pwm->chip.npwm = AXI_PWMGEN_NPWM;
+	}
+
+	/* Disable all the outputs */
+	for (idx = 0; idx < pwm->chip.npwm; idx++) {
+		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(idx), 0);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(idx), 0);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(regmap, AXI_PWMGEN_CHX_OFFSET(idx), 0);
+		if (ret)
+			return ret;
+	}
+
+	/* Enable the core */
+	return regmap_update_bits(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_RESET, 0);
+}
+
+static int axi_pwmgen_probe(struct platform_device *pdev)
+{
+	struct axi_pwmgen *pwm;
+	void __iomem *io_base;
+	int ret;
+
+	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+
+	io_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(io_base))
+		return PTR_ERR(io_base);
+
+	pwm->regmap = devm_regmap_init_mmio(&pdev->dev, io_base, &axi_pwm_regmap_config);
+	if (IS_ERR(pwm->regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pwm->regmap),
+				     "failed to init register map\n");
+
+	pwm->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(pwm->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pwm->clk), "failed to get clock\n");
+
+	pwm->chip.dev = &pdev->dev;
+	pwm->chip.ops = &axi_pwmgen_pwm_ops;
+	pwm->chip.base = -1;
+
+	ret = axi_pwmgen_setup(pwm, &pdev->dev);
+	if (ret < 0)
+		return ret;
+
+	return devm_pwmchip_add(&pdev->dev, &pwm->chip);
+}
+
+static const struct of_device_id axi_pwmgen_ids[] = {
+	{ .compatible = "adi,axi-pwmgen-1.00.a" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, axi_pwmgen_ids);
+
+static struct platform_driver axi_pwmgen_driver = {
+	.driver = {
+		.name = "axi-pwmgen",
+		.of_match_table = axi_pwmgen_ids,
+	},
+	.probe = axi_pwmgen_probe,
+};
+
+module_platform_driver(axi_pwmgen_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sergiu Cuciurean <sergiu.cuciurean@analog.com>");
+MODULE_DESCRIPTION("Driver for the Analog Devices AXI PWM generator");
-- 
2.43.0


