Return-Path: <linux-kernel+bounces-51423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A946848B0E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 05:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5007B283292
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF978F5C;
	Sun,  4 Feb 2024 04:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klRRWt1b"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022528C01;
	Sun,  4 Feb 2024 04:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707021717; cv=none; b=JrVfQ2E1PwV2ON7FM34wo4i2YEP4AoBwZm7zsex82jFNbKX1CR7S1mW3MX+RWOthKXNrn8mzwwTqq3xL94ABgNDzMO6/uQ9ZSNd0liIWxmaS6h/9GUbDF64K696wX7rBcPmA5zSg0GAwOm9NQnM3o3GWxii28Mt7E+arXBj7rP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707021717; c=relaxed/simple;
	bh=aH0Hq69qTFO9G+gVEopYTuCzG7xKtDisAqk3HBcwXXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iPrcVt1rOfCwSa1LQJupNt2gb1Q9KOyxb+Th+vZvJZq41uPl7a7GsdxdMv6Fr+V3V07KUwcVAGgcjAMqiq1Uks7ojj1Lk1TQvGjnRTKtESXoTSuHwTnGdi/1s09nE1BTy8bfrvGZgOAUvmld0ZEkFM0grWs+90IVZuxr2RdjMVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klRRWt1b; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7bc332d3a8cso186055039f.2;
        Sat, 03 Feb 2024 20:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707021715; x=1707626515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFP99fff3r5mwjujhUJyQkBzJ87OUfg244De9Pja3tU=;
        b=klRRWt1bsG3PUJerOG7MvbeychIc7vKmYy76kNWbSOgs5aJCIaD4k86hR3bJekhXOB
         mx8mnpXoQzkEv4859BAIUVKVgEJF62Qnhf4xGclEpanfipIuULJzyb5trRJA4RbbDa1a
         tgB4QsoewKnAK/URleT194V0KQf6+/HA2qNSOXVeDoW90SffN5C2evCEPcseX/onHRBu
         ha07U5urcIzC9dg8dmx7i40yvoPU03rsU+F6mrh8qMiRJyn4OvtSa7gb2kQb4f/jKaev
         cnfslpyX3VZ0s45/EDvjwgaiJQco0XFGhhdQxzNEtvENge6i6urXTncGCcoxgzbaI5CO
         ggjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707021715; x=1707626515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFP99fff3r5mwjujhUJyQkBzJ87OUfg244De9Pja3tU=;
        b=cSwaUPOUhlnJiiTOLviMKIeBiU58uWOm+upz+U4TqAgUsQ583ouio0PV5ubr5RHDK3
         K7GxlZwlLC+9Og6SXubC9n74wizMWtz0jzS81NvFny62Q4qG2MfttmBe407fZyEtkoLY
         mg1ff+nGalNE1iqtpgU21fKSZ4HcFLEjNYwUGklgN7Cot0oAV0G+dCzQkmD7+A0HHYIP
         YPU5x8wQQ8gh6drRvjB5a5pjHn9AJFS9hmkiIcPmupmfy5O13OBejlFltvPYvRsW99eh
         njaZ33g7/N4WgbA5iNST5Lp6azew9xZ1GonlVp+PO4ZRXG3bhFi7X+p7ghctZibdKczH
         OhNA==
X-Gm-Message-State: AOJu0Yw3liRAJi2tIHEX/bBDQt/UKd2tyiCNzcKud0Z1WojzJ+35blTB
	CqbKBf6JGSKFny/xZeNB3znEGNmHZJTV+BR0uz3DlefvScogQcVH
X-Google-Smtp-Source: AGHT+IHOTkIXJmJkqKTdzoxW4ijltI+jedvkng8VSEpQVS88ut4bN0Sb1L9A80WHtgsurCpdr+RJSw==
X-Received: by 2002:a92:cc47:0:b0:363:b93d:8b31 with SMTP id t7-20020a92cc47000000b00363b93d8b31mr5392364ilq.10.1707021714279;
        Sat, 03 Feb 2024 20:41:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXzy/rdQo5uYrtak5KS/hAS1+/MSIm4eODmQvdglCrI8Eh725Zx0wIZOvHYGP+UIrLaey0974dsBivkNv2zNYuROiqfqjLmfZm301Yz7jl187PQTkbzowBwM1Lz7+2Ios4R+2SlDI6f8MSzAIfy2pgI7X7Xowi0FsRx1tr6yxAj7kgXAYOLEaTn5mfHkmdRWAIyHYLy6UUheLUsTs2B82bgmmonEIctehqXekmQ1PoVNE0+7A6WKB6HMEeupG0nBY5YEF1WWkMFMIFSgS3xWXqR5bBbgDn7UmBRbmBhdpccaxW7EygGu+hGSWzy8kOp8IfMYRuadVhCf5PGF6TCH07FrIE9k5yEcbXdBX8iKnkB0krQ5zvBbpt2FD9XHBy9bzDIz1UJ5oP1nrp+3i8e+Ca2pBQDELYdCVDE0xI0
Received: from localhost ([46.3.240.106])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709029a4400b001d7726c4a40sm3875552plv.277.2024.02.03.20.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 20:41:53 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlan@gentoo.org,
	inochiama@outlook.com,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v8 2/2] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
Date: Sun,  4 Feb 2024 12:41:43 +0800
Message-Id: <20240204044143.415915-3-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240204044143.415915-1-qiujingbao.dlmu@gmail.com>
References: <20240204044143.415915-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the RTC driver for CV1800, which able to provide time alarm.

Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 drivers/rtc/Kconfig      |  10 ++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-cv1800.c | 244 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 255 insertions(+)
 create mode 100644 drivers/rtc/rtc-cv1800.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e37a4341f442..3c6ed45a3b03 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1128,6 +1128,16 @@ config RTC_DRV_DS2404
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-ds2404.
 
+config RTC_DRV_CV1800
+	tristate "Sophgo CV1800 RTC"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	help
+	  If you say yes here you get support the RTC driver
+	  for Sophgo CV1800 chip.
+
+	  This driver can also be built as a module.If so, the
+	  module will be called rtc-cv1800.
+
 config RTC_DRV_DA9052
 	tristate "Dialog DA9052/DA9053 RTC"
 	depends on PMIC_DA9052
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 6efff381c484..4efdd2d1e963 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_RTC_DRV_CADENCE)	+= rtc-cadence.o
 obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc-cmos.o
 obj-$(CONFIG_RTC_DRV_CPCAP)	+= rtc-cpcap.o
 obj-$(CONFIG_RTC_DRV_CROS_EC)	+= rtc-cros-ec.o
+obj-$(CONFIG_RTC_DRV_CV1800)	+= rtc-cv1800.o
 obj-$(CONFIG_RTC_DRV_DA9052)	+= rtc-da9052.o
 obj-$(CONFIG_RTC_DRV_DA9055)	+= rtc-da9055.o
 obj-$(CONFIG_RTC_DRV_DA9063)	+= rtc-da9063.o
diff --git a/drivers/rtc/rtc-cv1800.c b/drivers/rtc/rtc-cv1800.c
new file mode 100644
index 000000000000..60a7192659f5
--- /dev/null
+++ b/drivers/rtc/rtc-cv1800.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * rtc-cv1800.c: RTC driver for Sophgo cv1800 RTC
+ *
+ * Author: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/rtc.h>
+
+#define CTRL                   0x08
+#define ANA_CALIB              0x1000
+#define SEC_PULSE_GEN          0x1004
+#define ALARM_TIME             0x1008
+#define ALARM_ENABLE           0x100C
+#define SET_SEC_CNTR_VAL       0x1010
+#define SET_SEC_CNTR_TRIG      0x1014
+#define SEC_CNTR_VAL           0x1018
+#define APB_RDATA_SEL          0x103C
+#define POR_DB_MAGIC_KEY       0x1068
+#define EN_PWR_WAKEUP          0x10BC
+
+/*
+ * When in VDDBKUP domain, this MACRO register
+ * does not power down
+ */
+#define MACRO_DA_CLEAR_ALL     0x1480
+#define MACRO_DA_SOC_READY     0x148C
+#define MACRO_RO_T             0x14A8
+#define MACRO_RG_SET_T         0x1498
+
+#define CTRL_MODE_MASK         BIT(10)
+#define CTRL_MODE_OSC32K       0x00UL
+#define CTRL_MODE_XTAL32K      BIT(0)
+#define REG_ENABLE_FUN         BIT(0)
+#define REG_DISABLE_FUN        0x00UL
+#define ALARM_ENABLE_MASK      BIT(0)
+#define SET_SEC_CNTR_VAL_INIT  (BIT(28) || BIT(29))
+#define SEC_PULSE_SEL_INNER    BIT(31)
+#define SEC_PULSE_GEN_SEL_MASK GENMASK(30, 0)
+#define CALIB_SEL_FTUNE_MASK   GENMASK(30, 0)
+#define CALIB_SEL_FTUNE_INNER  0x00UL
+
+struct cv1800_rtc_priv {
+	struct rtc_device *rtc_dev;
+	struct regmap *rtc_map;
+	struct clk *clk;
+	int irq;
+};
+
+static const struct regmap_config cv1800_rtc_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+static int cv1800_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
+
+	regmap_write(info->rtc_map, ALARM_ENABLE, enabled);
+
+	return 0;
+}
+
+static int cv1800_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
+	unsigned long alarm_time;
+
+	alarm_time = rtc_tm_to_time64(&alrm->time);
+
+	cv1800_rtc_alarm_irq_enable(dev, REG_DISABLE_FUN);
+
+	regmap_write(info->rtc_map, ALARM_TIME, alarm_time);
+
+	cv1800_rtc_alarm_irq_enable(dev, alrm->enabled);
+
+	return 0;
+}
+
+static int cv1800_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
+	u32 enabled;
+	u32 time;
+
+	regmap_read(info->rtc_map, ALARM_ENABLE, &enabled);
+
+	alarm->enabled = enabled & ALARM_ENABLE_MASK;
+
+	regmap_read(info->rtc_map, ALARM_TIME, &time);
+
+	rtc_time64_to_tm(time, &alarm->time);
+
+	return 0;
+}
+
+static void rtc_enable_sec_counter(struct cv1800_rtc_priv *info)
+{
+	u32 sec_ro_t;
+	u32 sec;
+
+	/* select inner sec pulse */
+	regmap_update_bits(info->rtc_map, SEC_PULSE_GEN,
+			   (u32)(~SEC_PULSE_GEN_SEL_MASK),
+			   (u32)(~SEC_PULSE_SEL_INNER));
+
+	regmap_update_bits(info->rtc_map, ANA_CALIB,
+			   (u32)(~CALIB_SEL_FTUNE_MASK),
+			   CALIB_SEL_FTUNE_INNER);
+
+	sec = SET_SEC_CNTR_VAL_INIT;
+
+	/* load from MACRO register */
+	regmap_read(info->rtc_map, MACRO_RO_T, &sec_ro_t);
+	if (sec_ro_t > (SET_SEC_CNTR_VAL_INIT))
+		sec = sec_ro_t;
+
+	regmap_write(info->rtc_map, SET_SEC_CNTR_VAL, sec);
+	regmap_write(info->rtc_map, SET_SEC_CNTR_TRIG, REG_ENABLE_FUN);
+}
+
+static int cv1800_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
+	u32 sec;
+
+	regmap_read(info->rtc_map, SEC_CNTR_VAL, &sec);
+
+	rtc_time64_to_tm(sec, tm);
+
+	return 0;
+}
+
+static int cv1800_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
+	unsigned long sec;
+
+	sec = rtc_tm_to_time64(tm);
+
+	regmap_write(info->rtc_map, SET_SEC_CNTR_VAL, sec);
+	regmap_write(info->rtc_map, SET_SEC_CNTR_TRIG, REG_ENABLE_FUN);
+
+	regmap_write(info->rtc_map, MACRO_RG_SET_T, sec);
+
+	return 0;
+}
+
+static irqreturn_t cv1800_rtc_irq_handler(int irq, void *dev_id)
+{
+	struct rtc_device *rtc = dev_id;
+
+	rtc_update_irq(rtc, 1, RTC_IRQF | RTC_AF);
+
+	return IRQ_HANDLED;
+}
+
+static const struct rtc_class_ops cv1800_rtc_ops = {
+	.read_time = cv1800_rtc_read_time,
+	.set_time = cv1800_rtc_set_time,
+	.read_alarm = cv1800_rtc_read_alarm,
+	.set_alarm = cv1800_rtc_set_alarm,
+	.alarm_irq_enable = cv1800_rtc_alarm_irq_enable,
+};
+
+static int cv1800_rtc_probe(struct platform_device *pdev)
+{
+	struct cv1800_rtc_priv *rtc;
+	u32 ctrl_val;
+	void __iomem *base;
+	int ret;
+
+	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
+	if (!rtc)
+		return -ENOMEM;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	rtc->rtc_map = devm_regmap_init_mmio(&pdev->dev, base,
+					     &cv1800_rtc_regmap_config);
+	if (IS_ERR(rtc->rtc_map))
+		return PTR_ERR(rtc->rtc_map);
+
+	rtc->irq = platform_get_irq(pdev, 0);
+	if (rtc->irq < 0)
+		return rtc->irq;
+
+	ret = devm_request_irq(&pdev->dev, rtc->irq, cv1800_rtc_irq_handler,
+			       IRQF_TRIGGER_HIGH, "alarm", &pdev->dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "cannot register interrupt handler\n");
+
+	rtc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(rtc->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->clk),
+				     "clk not found\n");
+
+	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc->rtc_dev))
+		return PTR_ERR(rtc->rtc_dev);
+
+	platform_set_drvdata(pdev, rtc);
+
+	rtc->rtc_dev->ops = &cv1800_rtc_ops;
+	rtc->rtc_dev->range_max = U32_MAX;
+
+	regmap_read(rtc->rtc_map, CTRL, &ctrl_val);
+	ctrl_val &= CTRL_MODE_MASK;
+
+	if (ctrl_val == CTRL_MODE_OSC32K)
+		rtc_enable_sec_counter(rtc);
+
+	return devm_rtc_register_device(rtc->rtc_dev);
+}
+
+static const struct of_device_id cv1800_dt_ids[] = {
+	{ .compatible = "sophgo,cv1800-rtc" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, cv1800_dt_ids);
+
+static struct platform_driver cv1800_rtc_driver = {
+	.driver = {
+		.name = "sophgo-cv1800-rtc",
+		.of_match_table = cv1800_dt_ids,
+	},
+	.probe = cv1800_rtc_probe,
+};
+
+module_platform_driver(cv1800_rtc_driver);
+MODULE_AUTHOR("Jingbao Qiu");
+MODULE_DESCRIPTION("Sophgo cv1800 RTC Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


