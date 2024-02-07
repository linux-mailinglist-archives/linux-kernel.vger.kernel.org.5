Return-Path: <linux-kernel+bounces-55995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15B684C4B7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13897B24317
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320351E4A8;
	Wed,  7 Feb 2024 06:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITOLueP6"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E671D549;
	Wed,  7 Feb 2024 06:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707286161; cv=none; b=ngOObbv9fhXu80RRzCE+Ze3WaBZ7xgwkvv27+VtYw3yp/NOCPU6mXnKEyCZ1HeWiPWBGGaPo6JwDruW7RzoE4xm50gtRjjTNjfE/0xoPz+5hnzWx2ZLyVzRDK8eN5J0rLRBT5PUZzdHYgQf/TiQ9PkMFako+vHc1WVh2AokJhF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707286161; c=relaxed/simple;
	bh=A/DJHmh0XJOvuah/D5lZPVfH+nS9+ETgI/RcbKawubM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=msGnDtQMsMzMCk9G1peCUFHj63OUKRxWy0NA1Chjf0vEyqozRwQDVJihVw6MM4TDLmXTrZYGSb+L4MvjUhkKdLeLpY133sAgq1hNLbfEYCWjmH9yXzRC/c5ewYy8IgxcHuvrSNyNem1GtyWxLrwqhRQJpj5s/1R3Mp8whI0w+7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITOLueP6; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bd72353d9fso226738b6e.3;
        Tue, 06 Feb 2024 22:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707286158; x=1707890958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOCigBVBBBspIi0p1lxtYszF6WmD5xOXo1RR8ILaV44=;
        b=ITOLueP6yf0oZL/oGM9YObyUR4sq7Fv9BMOLF1nePEaWqbLB1QeauTfPGGgC9FSvY7
         YlikTXWaIL76a67ebtxFOdNlCAfZ47KumIj/0DeakKI1/5086m6CCII5cR7jUs7FFcXS
         rHnPo00V7IyC4ctuVkhEm1IDEgJrFkxmLzL0IgUMLJdDe2sC5BNiOyv+bh9Oz1aVojft
         cJtKIqRB6zz+OAFcrJezjHAreFGRDLVI0IG4ERfHWpxSgIgXSPCBFCpYS2nudONnIhds
         h1k3kv/mNHvidu2GgiEPvtty24q2Hw81ol4Du0XA7p9502i93oABSgVNE0ujS2Aj2ehl
         22Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707286158; x=1707890958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOCigBVBBBspIi0p1lxtYszF6WmD5xOXo1RR8ILaV44=;
        b=QJ33mqVDmMRG9BUR9vRDc8PXGprDbM0VZ6+aVjnoqasDdqu88rwxHHsDXOrzuXBi+9
         xp8hsFgH/Xn/A+lZ5SdzaGTZsYZ0mjKzfUJk0cTXMiE8Ht6L6wP/NOdM7AD5wXRYeay2
         YnB6z4QiXN26whn4x0jEVAeVu5obqWA9CLZlIwtOBoG985QL+CWvUu3AkAHaxS2NbtAP
         1F/1XkLGSMWXz9ZYibvQCSRNu4RfQwvPU2Fb79P6HK+v2mdFGAyQhyQb/rl7HGebfIGq
         aXwXwcMQCMhK2GIZmAKhx9HRrOA/Eic5phlDyYjoVcQ3Dk4wKQRALXFKoG/MvkX6E32a
         DcoA==
X-Gm-Message-State: AOJu0Yyy0nNS8TQVtRtsb0nrY1PNYa6wsB+XDsjLRK/ukDu/O+/M8WOC
	9XGYRvqLbrW+K43XtODMIwnuHF8bpZkbiTG8RT0E5P5tqAQSOBuj
X-Google-Smtp-Source: AGHT+IHjcSRNhjdpiDizYjB5tVnNmWy+hv7bqmHg5NK4M1lB7uQCHWXSjX79eFWSxoNbmechVTucEQ==
X-Received: by 2002:a05:6808:238e:b0:3bd:db8e:b1d8 with SMTP id bp14-20020a056808238e00b003bddb8eb1d8mr5063741oib.31.1707286157690;
        Tue, 06 Feb 2024 22:09:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5Z/IPm1PzlvZ/4DoLoupXpww8RtUS6z8HvQbyiN7ng0X4zFS3SdNz4Jq9y4Gni8dbDCPC9kPJKRkgpnj1A1SVquB3JXvIwTvE/EA07sczOr/9cJPVZq0nVwxPkF2FPIRx6dzfjSieCWUkuYHWJq27xY2/oh4uZJEz+zUG5yuHng588d9OoCg4vnIi6SCAFMbQGUlQ55OOPz3Kj4n4VTnqEDV6E48aXw6efEQWV0pg8RqiFlowPpkJUzy1Gtjw0uSvv2qYhDbN/sN4i90dtENREYyJ/Z+hERJkLndUwErphE1Fuw3z6CltU83lCNF427bpO73pqxVBgHPpUDzhj++crlGa3kcu+3bZR4XCrQZqrKrKEIfSD79gyxF15CuazRvj9RFec9CwIA+hV9PY8f/tZ3yuqNUIacLGdgnZXdJfnORJptRdHEa/dDRCzV4ihBBTotO5ed0POFNFMF4Q
Received: from localhost ([46.3.240.101])
        by smtp.gmail.com with ESMTPSA id r18-20020aa78b92000000b006d9c216a9e6sm577543pfd.56.2024.02.06.22.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 22:09:17 -0800 (PST)
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
Subject: [PATCH v1 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
Date: Wed,  7 Feb 2024 14:09:13 +0800
Message-Id: <20240207060913.672554-1-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240207055856.672184-1-qiujingbao.dlmu@gmail.com>
References: <20240207055856.672184-1-qiujingbao.dlmu@gmail.com>
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
 drivers/pwm/pwm-cv1800.c | 218 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 229 insertions(+)
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
index 000000000000..4d4f233c9087
--- /dev/null
+++ b/drivers/pwm/pwm-cv1800.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * rtc-cv1800.c: PWM driver for Sophgo cv1800 RTC
+ *
+ * Author: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
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
+#define HLPERIOD_BASE  0x00
+#define PERIOD_BASE    0x04
+#define POLARITY       0x040
+#define PWMSTART       0x044
+#define PWMDONE        0x048
+#define PWMUPDATE      0x4c
+#define PWM_OE         0xd0
+#define HLPERIOD_SHIFT 0x08
+#define PERIOD_SHIFT   0x08
+
+#define HLPERIOD(n)    (HLPERIOD_BASE + ((n) * HLPERIOD_SHIFT))
+#define PERIOD(n)      (PERIOD_BASE + ((n) * PERIOD_SHIFT))
+#define UPDATE(n)      (BIT(0) << (n))
+#define OE_MASK(n)     (BIT(0) << (n))
+#define START_MASK(n)  (BIT(0) << (n))
+
+#define PERIOD_RESET   0x02
+#define HLPERIOD_RESET 0x1
+#define REG_DISABLE    0x0U
+#define REG_ENABLE     BIT(0)
+
+struct soc_info {
+	unsigned int num_pwms;
+};
+
+struct cv1800_pwm {
+	struct pwm_chip chip;
+	struct regmap *map;
+	struct clk *clk;
+};
+
+static inline struct cv1800_pwm *to_cv1800_pwm_dev(struct pwm_chip *chip)
+{
+	return container_of(chip, struct cv1800_pwm, chip);
+}
+
+static int cv1800_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
+			     u32 enable)
+{
+	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
+	u32 pwm_enable;
+
+	regmap_read(priv->map, PWMSTART, &pwm_enable);
+	pwm_enable >>= pwm->hwpwm;
+
+	if (enable)
+		clk_prepare_enable(priv->clk);
+	else
+		clk_disable_unprepare(priv->clk);
+
+	/*
+	 * If the parameters are changed during runtime, Register needs
+	 * to be updated to take effect.
+	 */
+	if (pwm_enable) {
+		regmap_update_bits(priv->map, PWMUPDATE, UPDATE(pwm->hwpwm),
+				   REG_ENABLE << pwm->hwpwm);
+		regmap_update_bits(priv->map, PWMUPDATE, UPDATE(pwm->hwpwm),
+				   REG_DISABLE << pwm->hwpwm);
+	} else {
+		regmap_update_bits(priv->map, PWM_OE, OE_MASK(pwm->hwpwm),
+				   enable << pwm->hwpwm);
+		regmap_update_bits(priv->map, PWMSTART, START_MASK(pwm->hwpwm),
+				   enable << pwm->hwpwm);
+	}
+
+	return 0;
+}
+
+static int cv1800_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
+	u64 period_ns, duty_ns;
+	u32 period_val, hlperiod_val;
+	unsigned long long rate, div;
+
+	period_ns = state->period;
+	duty_ns = state->duty_cycle;
+
+	rate = (unsigned long long)clk_get_rate(priv->clk);
+
+	div = rate * period_ns;
+	do_div(div, NSEC_PER_SEC);
+	period_val = div;
+
+	div = rate * (period_ns - duty_ns);
+	do_div(div, NSEC_PER_SEC);
+	hlperiod_val = div;
+
+	regmap_write(priv->map, PERIOD(pwm->hwpwm), period_val);
+	regmap_write(priv->map, HLPERIOD(pwm->hwpwm), hlperiod_val);
+
+	cv1800_pwm_enable(chip, pwm, state->enabled);
+
+	return 0;
+}
+
+static int cv1800_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
+	u32 period_val, hlperiod_val, tem;
+	u64 rate;
+	u64 period_ns = 0;
+	u64 duty_ns = 0;
+	u32 enable = 0;
+
+	regmap_read(priv->map, PERIOD(pwm->hwpwm), &period_val);
+	regmap_read(priv->map, HLPERIOD(pwm->hwpwm), &hlperiod_val);
+
+	if (period_val != PERIOD_RESET || hlperiod_val != HLPERIOD_RESET) {
+		rate = (u64)clk_get_rate(priv->clk);
+
+		tem = NSEC_PER_SEC * period_val;
+		do_div(tem, rate);
+		period_ns = tem;
+
+		tem = period_val * period_ns;
+		do_div(tem, hlperiod_val);
+		duty_ns = tem;
+
+		regmap_read(priv->map, PWMSTART, &enable);
+		enable >>= pwm->hwpwm;
+	}
+
+	state->period = period_ns;
+	state->duty_cycle = duty_ns;
+	state->enabled = enable;
+
+	return 0;
+}
+
+static const struct pwm_ops cv1800_pwm_ops = {
+	.apply = cv1800_pwm_apply,
+	.get_state = cv1800_pwm_get_state,
+};
+
+static const struct regmap_config cv1800_pwm_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+static int cv1800_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cv1800_pwm *cv_pwm;
+	void __iomem *base;
+	const struct soc_info *info;
+
+	info = device_get_match_data(dev);
+	if (!info)
+		return -EINVAL;
+
+	cv_pwm = devm_kzalloc(dev, sizeof(*cv_pwm), GFP_KERNEL);
+	if (!cv_pwm)
+		return -ENOMEM;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	cv_pwm->map = devm_regmap_init_mmio(&pdev->dev, base,
+					    &cv1800_pwm_regmap_config);
+	if (IS_ERR(cv_pwm->map))
+		return PTR_ERR(cv_pwm->map);
+
+	cv_pwm->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(cv_pwm->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(cv_pwm->clk),
+				     "clk not found\n");
+
+	cv_pwm->chip.dev = dev;
+	cv_pwm->chip.ops = &cv1800_pwm_ops;
+	cv_pwm->chip.npwm = info->num_pwms;
+
+	return devm_pwmchip_add(dev, &cv_pwm->chip);
+}
+
+static const struct soc_info cv1800b_soc_info = {
+	.num_pwms = 4,
+};
+
+static const struct of_device_id cv1800_pwm_dt_ids[] = {
+	{ .compatible = "sophgo,cv1800-pwm", .data = &cv1800b_soc_info },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cv1800_pwm_dt_ids);
+
+static struct platform_driver cv1800_pwm_driver = {
+	.driver = {
+		.name = "cv1800-pwm",
+		.of_match_table = cv1800_pwm_dt_ids,
+	},
+	.probe = cv1800_pwm_probe,
+};
+module_platform_driver(cv1800_pwm_driver);
+
+MODULE_ALIAS("platform:cv1800-pwm");
+MODULE_AUTHOR("Jingbao Qiu");
+MODULE_DESCRIPTION("Sophgo cv1800 RTC Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


