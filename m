Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37B975A3F4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 03:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjGTB3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 21:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGTB27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 21:28:59 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EA62123;
        Wed, 19 Jul 2023 18:28:41 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b89114266dso2005465ad.0;
        Wed, 19 Jul 2023 18:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689816521; x=1690421321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vF98fHpwax0Zc0/s3DhXChVek/qggsLafsYLHscMqpE=;
        b=JJ/ZQm5mNhv/s6ghFu0gO4ZT0Fs4A6LcMJ635qvnnghcNt6qAsAkzz9bNoIlOryydJ
         CA7QidGqUe+bDS3C5fYLvbLF+eaHVBKTH9p5X9fU98dAyQQ3UASZRxZWdtJWGEnHkWAo
         /w0ZMy9RRsAORJHI2iAvPuvMXb7SulnnkuT/rA3glN03CtpB5Q6LhR5igW41wOk0lbJI
         Qc+6O1v7SrFHNdPAgrW6vmjWzjf6oS72vMZ0qOxERCA0+xFUHO28afslEQcW8LAXGWYw
         zupB2LJdgro8swbYMBRi7dZmERBQwQq7Bj8WrUH4m0vvYXwo1UDufLQxmNEL4QGZscCf
         j6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689816521; x=1690421321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vF98fHpwax0Zc0/s3DhXChVek/qggsLafsYLHscMqpE=;
        b=OQfSpEnxgwGNhclNx/lTzwk3C4atgTcCPpMhEVLSc6tZgwuiDgSOYfxEZEJuZ5imej
         a3OS5FLkL+bNSUa3s+pLCHUHU+IWBxaNY7jTB82Q2AbTbZdRYkwrCmiM4vYODQdJAYyW
         D3NDZbw945pTdhzBTWAEKFv7w15cWXoRJwTYKYFtixqyTVUGnCL6BgW884c4rZrPSqAb
         0DQTfF2rVRrmtmaj2w2hupUfVKnQRHwILDLfrtXO6dTwyZbHLyeJpWEqgJw5Yt+AQPdJ
         bJ4eGHPt66tfT+qk8iWf7muNzeSs840HWklCYT/KF8uqzFbA/QN80A2kIvB+5hSwRXfa
         eJVg==
X-Gm-Message-State: ABy/qLaOWi1uFaR9AcbTbI4QTaVQAJAhs26ZlABpw1M9CVtDteYxG7Rg
        ly6txkBxu3wfJ/KlkTM1Kl8=
X-Google-Smtp-Source: APBJJlGv2NNq1pJpkuA+XM/BsZ15tBeCSl5UdI8m9KcIIjgkfVJpPAVrqgxpQJ4d7JVa62oTRaMI2A==
X-Received: by 2002:a17:902:ba8f:b0:1b8:5bd0:fe12 with SMTP id k15-20020a170902ba8f00b001b85bd0fe12mr3979821pls.16.1689816520861;
        Wed, 19 Jul 2023 18:28:40 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id jc18-20020a17090325d200b001b1a2c14a4asm4673998plb.38.2023.07.19.18.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 18:28:40 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, mjchen@nuvoton.com, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 3/3] rtc: Add driver for nuvoton ma35d1 rtc controller
Date:   Thu, 20 Jul 2023 01:28:26 +0000
Message-Id: <20230720012826.430026-4-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720012826.430026-1-ychuang570808@gmail.com>
References: <20230720012826.430026-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

The ma35d1 rtc controller provides real-time and calendar messaging
capabilities. It supports programmable time tick and alarm match
interrupts. The time and calendar messages are expressed in BCD format.
This driver supports the built-in rtc controller of the ma35d1. It
enables setting and reading the rtc time and configuring and reading
the rtc alarm.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 drivers/rtc/Kconfig      |  11 ++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-ma35d1.c | 371 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 383 insertions(+)
 create mode 100644 drivers/rtc/rtc-ma35d1.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 05f4b2d66290..95ddd8f616f4 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1929,6 +1929,17 @@ config RTC_DRV_TI_K3
 	  This driver can also be built as a module, if so, the module
 	  will be called "rtc-ti-k3".
 
+config RTC_DRV_MA35D1
+	tristate "Nuvoton MA35D1 RTC"
+	depends on ARCH_MA35 || COMPILE_TEST
+	select REGMAP_MMIO
+	help
+	   If you say yes here you get support for the Nuvoton MA35D1
+	   On-Chip Real Time Clock.
+
+	   This driver can also be built as a module, if so, the module
+	   will be called "rtc-ma35d1".
+
 comment "HID Sensor RTC drivers"
 
 config RTC_DRV_HID_SENSOR_TIME
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index fd209883ee2e..763c9cb5dde1 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -88,6 +88,7 @@ obj-$(CONFIG_RTC_DRV_M41T94)	+= rtc-m41t94.o
 obj-$(CONFIG_RTC_DRV_M48T35)	+= rtc-m48t35.o
 obj-$(CONFIG_RTC_DRV_M48T59)	+= rtc-m48t59.o
 obj-$(CONFIG_RTC_DRV_M48T86)	+= rtc-m48t86.o
+obj-$(CONFIG_RTC_DRV_MA35D1)	+= rtc-ma35d1.o
 obj-$(CONFIG_RTC_DRV_MAX6900)	+= rtc-max6900.o
 obj-$(CONFIG_RTC_DRV_MAX6902)	+= rtc-max6902.o
 obj-$(CONFIG_RTC_DRV_MAX6916)	+= rtc-max6916.o
diff --git a/drivers/rtc/rtc-ma35d1.c b/drivers/rtc/rtc-ma35d1.c
new file mode 100644
index 000000000000..48c991a8f669
--- /dev/null
+++ b/drivers/rtc/rtc-ma35d1.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RTC driver for Nuvoton MA35D1
+ *
+ * Copyright (C) 2023 Nuvoton Technology Corp.
+ */
+
+#include <linux/bcd.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+
+/* MA35D1 RTC Control Registers */
+#define MA35_REG_RTC_INIT	0x00
+#define MA35_REG_RTC_SINFASTS	0x04
+#define MA35_REG_RTC_FREQADJ	0x08
+#define MA35_REG_RTC_TIME	0x0c
+#define MA35_REG_RTC_CAL	0x10
+#define MA35_REG_RTC_CLKFMT	0x14
+#define MA35_REG_RTC_WEEKDAY	0x18
+#define MA35_REG_RTC_TALM	0x1c
+#define MA35_REG_RTC_CALM	0x20
+#define MA35_REG_RTC_LEAPYEAR	0x24
+#define MA35_REG_RTC_INTEN	0x28
+#define MA35_REG_RTC_INTSTS	0x2c
+#define MA35_REG_RTC_TICK	0x30
+
+/* register MA35_REG_RTC_INIT */
+#define RTC_INIT_ACTIVE		BIT(0)
+#define RTC_INIT_MAGIC_CODE	0xa5eb1357
+
+/* register MA35_REG_RTC_CLKFMT */
+#define RTC_CLKFMT_24HEN	BIT(0)
+#define RTC_CLKFMT_DCOMPEN	BIT(16)
+
+/* register MA35_REG_RTC_INTEN */
+#define RTC_INTEN_ALMIEN	BIT(0)
+#define RTC_INTEN_TICKIEN	BIT(1)
+#define RTC_INTEN_CLKFIEN	BIT(24)
+#define RTC_INTEN_CLKSTIEN	BIT(25)
+
+/* register MA35_REG_RTC_INTSTS */
+#define RTC_INTSTS_ALMIF	BIT(0)
+#define RTC_INTSTS_TICKIF	BIT(1)
+#define RTC_INTSTS_CLKFIF	BIT(24)
+#define RTC_INTSTS_CLKSTIF	BIT(25)
+
+#define RTC_INIT_TIMEOUT	250
+
+struct ma35_rtc {
+	int irq_num;
+	void __iomem *rtc_reg;
+	struct rtc_device *rtcdev;
+};
+
+struct ma35_bcd_time {
+	int bcd_sec;
+	int bcd_min;
+	int bcd_hour;
+	int bcd_mday;
+	int bcd_mon;
+	int bcd_year;
+};
+
+static u32 rtc_reg_read(struct ma35_rtc *p, u32 offset)
+{
+	return __raw_readl(p->rtc_reg + offset);
+}
+
+static inline void rtc_reg_write(struct ma35_rtc *p, u32 offset, u32 value)
+{
+	__raw_writel(value, p->rtc_reg + offset);
+}
+
+static irqreturn_t ma35d1_rtc_interrupt(int irq, void *data)
+{
+	struct ma35_rtc *rtc = (struct ma35_rtc *)data;
+	unsigned long events = 0, rtc_irq;
+
+	rtc_irq = rtc_reg_read(rtc, MA35_REG_RTC_INTSTS);
+
+	if (rtc_irq & RTC_INTSTS_ALMIF) {
+		rtc_reg_write(rtc, MA35_REG_RTC_INTSTS, RTC_INTSTS_ALMIF);
+		events |= RTC_AF | RTC_IRQF;
+	}
+
+	if (rtc_irq & RTC_INTSTS_TICKIF) {
+		rtc_reg_write(rtc, MA35_REG_RTC_INTSTS, RTC_INTSTS_TICKIF);
+		events |= RTC_UF | RTC_IRQF;
+	}
+
+	rtc_update_irq(rtc->rtcdev, 1, events);
+
+	return IRQ_HANDLED;
+}
+
+static int ma35d1_rtc_init(struct ma35_rtc *ma35_rtc, u32 ms_timeout)
+{
+	const unsigned long timeout = jiffies + msecs_to_jiffies(ms_timeout);
+
+	do {
+		if (rtc_reg_read(ma35_rtc, MA35_REG_RTC_INIT) & RTC_INIT_ACTIVE)
+			return 0;
+
+		rtc_reg_write(ma35_rtc, MA35_REG_RTC_INIT, RTC_INIT_MAGIC_CODE);
+
+		mdelay(1);
+
+	} while (time_before(jiffies, timeout));
+
+	return -ETIMEDOUT;
+}
+
+static int ma35d1_rtc_bcd2bin(u32 time, u32 cal, u32 wday, struct rtc_time *tm)
+{
+	tm->tm_mday	= bcd2bin(cal >> 0);
+	tm->tm_mon	= bcd2bin(cal >> 8);
+	tm->tm_mon	= tm->tm_mon - 1;
+	tm->tm_year	= bcd2bin(cal >> 16) + 100;
+
+	tm->tm_sec	= bcd2bin(time >> 0);
+	tm->tm_min	= bcd2bin(time >> 8);
+	tm->tm_hour	= bcd2bin(time >> 16);
+
+	tm->tm_wday = wday;
+
+	return rtc_valid_tm(tm);
+}
+
+static int ma35d1_rtc_alarm_bcd2bin(u32 talm, u32 calm, struct rtc_time *tm)
+{
+	tm->tm_mday	= bcd2bin(calm >> 0);
+	tm->tm_mon	= bcd2bin(calm >> 8);
+	tm->tm_mon	= tm->tm_mon - 1;
+	tm->tm_year	= bcd2bin(calm >> 16) + 100;
+
+	tm->tm_sec	= bcd2bin(talm >> 0);
+	tm->tm_min	= bcd2bin(talm >> 8);
+	tm->tm_hour	= bcd2bin(talm >> 16);
+
+	return rtc_valid_tm(tm);
+}
+
+static void ma35d1_rtc_bin2bcd(struct device *dev, struct rtc_time *settm,
+			       struct ma35_bcd_time *gettm)
+{
+	gettm->bcd_mday = bin2bcd(settm->tm_mday) << 0;
+	gettm->bcd_mon  = bin2bcd((settm->tm_mon + 1)) << 8;
+
+	if (settm->tm_year < 100) {
+		dev_warn(dev, "The year will be between 1970-1999, right?\n");
+		gettm->bcd_year = bin2bcd(settm->tm_year) << 16;
+	} else {
+		gettm->bcd_year = bin2bcd(settm->tm_year - 100) << 16;
+	}
+
+	gettm->bcd_sec  = bin2bcd(settm->tm_sec) << 0;
+	gettm->bcd_min  = bin2bcd(settm->tm_min) << 8;
+	gettm->bcd_hour = bin2bcd(settm->tm_hour) << 16;
+}
+
+static int ma35d1_alarm_irq_enable(struct device *dev, u32 enabled)
+{
+	struct ma35_rtc *rtc = dev_get_drvdata(dev);
+	u32 reg_ien;
+
+	reg_ien = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
+
+	if (enabled)
+		rtc_reg_write(rtc, MA35_REG_RTC_INTEN, reg_ien | RTC_INTEN_ALMIEN);
+	else
+		rtc_reg_write(rtc, MA35_REG_RTC_INTEN, reg_ien & ~RTC_INTEN_ALMIEN);
+
+	return 0;
+}
+
+static int ma35d1_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct ma35_rtc *rtc = dev_get_drvdata(dev);
+	u32 time, cal, wday;
+
+	time = rtc_reg_read(rtc, MA35_REG_RTC_TIME);
+	cal  = rtc_reg_read(rtc, MA35_REG_RTC_CAL);
+	wday = rtc_reg_read(rtc, MA35_REG_RTC_WEEKDAY);
+
+	return ma35d1_rtc_bcd2bin(time, cal, wday, tm);
+}
+
+static int ma35d1_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct ma35_rtc *rtc = dev_get_drvdata(dev);
+	struct ma35_bcd_time gettm;
+	u32 val;
+
+	ma35d1_rtc_bin2bcd(dev, tm, &gettm);
+
+	val = gettm.bcd_mday | gettm.bcd_mon | gettm.bcd_year;
+	rtc_reg_write(rtc, MA35_REG_RTC_CAL, val);
+
+	val = gettm.bcd_sec | gettm.bcd_min | gettm.bcd_hour;
+	rtc_reg_write(rtc, MA35_REG_RTC_TIME, val);
+
+	val = tm->tm_wday;
+	rtc_reg_write(rtc, MA35_REG_RTC_WEEKDAY, val);
+
+	return 0;
+}
+
+static int ma35d1_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct ma35_rtc *rtc = dev_get_drvdata(dev);
+	u32 talm, calm;
+
+	talm = rtc_reg_read(rtc, MA35_REG_RTC_TALM);
+	calm  = rtc_reg_read(rtc, MA35_REG_RTC_CALM);
+
+	return ma35d1_rtc_alarm_bcd2bin(talm, calm, &alrm->time);
+}
+
+static int ma35d1_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct ma35_rtc *rtc = dev_get_drvdata(dev);
+	struct ma35_bcd_time tm;
+	unsigned long val;
+
+	ma35d1_rtc_bin2bcd(dev, &alrm->time, &tm);
+
+	val = tm.bcd_mday | tm.bcd_mon | tm.bcd_year;
+	rtc_reg_write(rtc, MA35_REG_RTC_CALM, val);
+
+	val = tm.bcd_sec | tm.bcd_min | tm.bcd_hour;
+	rtc_reg_write(rtc, MA35_REG_RTC_TALM, val);
+
+	return 0;
+}
+
+static const struct rtc_class_ops ma35d1_rtc_ops = {
+	.read_time = ma35d1_rtc_read_time,
+	.set_time = ma35d1_rtc_set_time,
+	.read_alarm = ma35d1_rtc_read_alarm,
+	.set_alarm = ma35d1_rtc_set_alarm,
+	.alarm_irq_enable = ma35d1_alarm_irq_enable,
+};
+
+static int ma35d1_rtc_probe(struct platform_device *pdev)
+{
+	struct ma35_rtc *ma35_rtc;
+	struct clk *clk;
+	u32 regval;
+	int err;
+
+	ma35_rtc = devm_kzalloc(&pdev->dev, sizeof(struct ma35_rtc),
+								GFP_KERNEL);
+	if (!ma35_rtc)
+		return -ENOMEM;
+
+	ma35_rtc->rtc_reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ma35_rtc->rtc_reg))
+		return PTR_ERR(ma35_rtc->rtc_reg);
+
+	clk = of_clk_get(pdev->dev.of_node, 0);
+	if (IS_ERR(clk)) {
+		err = PTR_ERR(clk);
+		dev_err(&pdev->dev, "failed to get core clk: %d\n", err);
+		return -ENOENT;
+	}
+	err = clk_prepare_enable(clk);
+	if (err)
+		return -ENOENT;
+
+	platform_set_drvdata(pdev, ma35_rtc);
+
+	ma35_rtc->rtcdev = devm_rtc_device_register(&pdev->dev, pdev->name,
+						    &ma35d1_rtc_ops, THIS_MODULE);
+	if (IS_ERR(ma35_rtc->rtcdev)) {
+		dev_err(&pdev->dev, "rtc device register failed\n");
+		return PTR_ERR(ma35_rtc->rtcdev);
+	}
+
+	err = ma35d1_rtc_init(ma35_rtc, RTC_INIT_TIMEOUT);
+	if (err)
+		return err;
+
+	regval = rtc_reg_read(ma35_rtc, MA35_REG_RTC_CLKFMT);
+	regval |= RTC_CLKFMT_24HEN;
+	rtc_reg_write(ma35_rtc, MA35_REG_RTC_CLKFMT, regval);
+
+	ma35_rtc->irq_num = platform_get_irq(pdev, 0);
+
+	if (devm_request_irq(&pdev->dev, ma35_rtc->irq_num, ma35d1_rtc_interrupt,
+			     IRQF_NO_SUSPEND, "ma35d1rtc", ma35_rtc)) {
+		dev_err(&pdev->dev, "ma35d1 RTC request irq failed\n");
+		return -EBUSY;
+	}
+
+	regval = rtc_reg_read(ma35_rtc, MA35_REG_RTC_INTEN);
+	regval |= RTC_INTEN_TICKIEN;
+	rtc_reg_write(ma35_rtc, MA35_REG_RTC_INTEN, regval);
+
+	device_init_wakeup(&pdev->dev, true);
+
+	return 0;
+}
+
+static int __exit ma35d1_rtc_remove(struct platform_device *pdev)
+{
+	device_init_wakeup(&pdev->dev, false);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static int ma35d1_rtc_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct ma35_rtc *ma35_rtc = platform_get_drvdata(pdev);
+	u32 regval;
+
+	if (device_may_wakeup(&pdev->dev))
+		enable_irq_wake(ma35_rtc->irq_num);
+
+	regval = rtc_reg_read(ma35_rtc, MA35_REG_RTC_INTEN);
+	regval &= ~RTC_INTEN_TICKIEN;
+	rtc_reg_write(ma35_rtc, MA35_REG_RTC_INTEN, regval);
+
+	return 0;
+}
+
+static int ma35d1_rtc_resume(struct platform_device *pdev)
+{
+	struct ma35_rtc *ma35_rtc = platform_get_drvdata(pdev);
+	u32 regval;
+
+	if (device_may_wakeup(&pdev->dev))
+		disable_irq_wake(ma35_rtc->irq_num);
+
+	regval = rtc_reg_read(ma35_rtc, MA35_REG_RTC_INTEN);
+	regval |= RTC_INTEN_TICKIEN;
+	rtc_reg_write(ma35_rtc, MA35_REG_RTC_INTEN, regval);
+
+	return 0;
+}
+
+static const struct of_device_id ma35d1_rtc_of_match[] = {
+	{ .compatible = "nuvoton,ma35d1-rtc", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ma35d1_rtc_of_match);
+
+static struct platform_driver ma35d1_rtc_driver = {
+	.remove     = __exit_p(ma35d1_rtc_remove),
+	.suspend    = ma35d1_rtc_suspend,
+	.resume     = ma35d1_rtc_resume,
+	.probe      = ma35d1_rtc_probe,
+	.driver		= {
+		.name	= "rtc-ma35d1",
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(ma35d1_rtc_of_match),
+	},
+};
+
+module_platform_driver(ma35d1_rtc_driver);
+
+MODULE_AUTHOR("Min-Jen Chen <mjchen@nuvoton.com>");
+MODULE_DESCRIPTION("MA35D1 RTC driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

