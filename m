Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA8B77503C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjHIBQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjHIBP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:15:58 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96964E5E;
        Tue,  8 Aug 2023 18:15:56 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-26871992645so4172225a91.0;
        Tue, 08 Aug 2023 18:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691543756; x=1692148556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPNCweX+5ma/GkGVGkz+d+I063Vnz2ba+24+RFVQOm8=;
        b=YBEElAZ9XtCK4Cd2b/3zMZzs/E7/iE7wsUtNV5tm/9aTeMLQBS9jkTu4uWA24q/ZXA
         62QShqlHqpH4cbYgVyeOT6Oza5YzcYRzog+SzDZtu6P/yEJYw2Z3UIeXdWlKBMZv+hf3
         5R3U7jfRvEgHLk0Tg7eNt7BkApJe0tm73MPRetyJ0HuqGPNoOohF4AW7jCIJlktaEAQ6
         nYetYMJ0eXXpTJg+YOku9OKf32o52X+Qc2mPIJaH3Kg9aTJRxEKJxabMWmA1M2QCaBD7
         3/YxOnmW2+BJm8Bw0SDoDY3b13C6VmkuwAdgi+bGlkXWYX54F0pWTk9MFFdI5VQCTZl+
         76UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691543756; x=1692148556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPNCweX+5ma/GkGVGkz+d+I063Vnz2ba+24+RFVQOm8=;
        b=UeQqyDpl6+oMmPRmQBzszvTxV+NRthbqZIvq5hrlGRccynM7MFE1mYFolNioprA2I3
         9BvmiwxqO7O+cuhOdnSATl7iVKleKEACeNicAJOYiaFLqq77R+keeD14mo1OpATPMNJQ
         Y/fPt/tEs9Eb1Gx2Y6aCnX17wWcOuWa9xXgkGZ4Od+qEhud8a1odtoYRQ8gMLzgJjw6c
         O8u219mAs9+TrkybKAsY5cxlMshceq4pAFuBBEQNZjiTHzsbdByVmXHdGQuI7iJ0Insj
         OLo1ktapc0VxZhXIXNLiBqEjkfVnVWSrBjAVUdTjvs9vLetAQJt2kNP1It+DpWGpWXjt
         Gg9w==
X-Gm-Message-State: AOJu0YwBeKsvtbgTDTltqTYnZ7vuwkEme0Riby6vdDqfbcsmSECT8hYs
        G5tL8YpgpPyEG1q8ac5icw4=
X-Google-Smtp-Source: AGHT+IGoV5P8FQ/Uv/2KcsV8fH+WqZH8q+JmsnCATTjJfdRLrh7tOwl+RxZNZQyNyy8Bu2HLwOiBaQ==
X-Received: by 2002:a17:90a:72cc:b0:268:1b62:2f6c with SMTP id l12-20020a17090a72cc00b002681b622f6cmr1117935pjk.2.1691543755848;
        Tue, 08 Aug 2023 18:15:55 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id t22-20020a1709028c9600b001bc68602e54sm5730449plo.142.2023.08.08.18.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 18:15:55 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, mjchen@nuvoton.com, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [RESEND PATCH v2 3/3] rtc: Add driver for Nuvoton ma35d1 rtc controller
Date:   Wed,  9 Aug 2023 01:15:42 +0000
Message-Id: <20230809011542.429945-4-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230809011542.429945-1-ychuang570808@gmail.com>
References: <20230809011542.429945-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/rtc/rtc-ma35d1.c | 355 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 367 insertions(+)
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
index 000000000000..f63b484ee37f
--- /dev/null
+++ b/drivers/rtc/rtc-ma35d1.c
@@ -0,0 +1,355 @@
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
+static int ma35d1_rtc_init(struct ma35_rtc *rtc, u32 ms_timeout)
+{
+	const unsigned long timeout = jiffies + msecs_to_jiffies(ms_timeout);
+
+	do {
+		if (rtc_reg_read(rtc, MA35_REG_RTC_INIT) & RTC_INIT_ACTIVE)
+			return 0;
+
+		rtc_reg_write(rtc, MA35_REG_RTC_INIT, RTC_INIT_MAGIC_CODE);
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
+	struct ma35_rtc *rtc;
+	struct clk *clk;
+	u32 regval;
+	int err;
+
+	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
+	if (!rtc)
+		return -ENOMEM;
+
+	rtc->rtc_reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rtc->rtc_reg))
+		return PTR_ERR(rtc->rtc_reg);
+
+	clk = of_clk_get(pdev->dev.of_node, 0);
+	if (IS_ERR(clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk), "failed to find rtc clock\n");
+
+	err = clk_prepare_enable(clk);
+	if (err)
+		return -ENOENT;
+
+	platform_set_drvdata(pdev, rtc);
+
+	rtc->rtcdev = devm_rtc_device_register(&pdev->dev, pdev->name,
+					       &ma35d1_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc->rtcdev))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->rtcdev),
+				     "failed to register rtc device\n");
+
+	err = ma35d1_rtc_init(rtc, RTC_INIT_TIMEOUT);
+	if (err)
+		return err;
+
+	regval = rtc_reg_read(rtc, MA35_REG_RTC_CLKFMT);
+	regval |= RTC_CLKFMT_24HEN;
+	rtc_reg_write(rtc, MA35_REG_RTC_CLKFMT, regval);
+
+	rtc->irq_num = platform_get_irq(pdev, 0);
+
+	err = devm_request_irq(&pdev->dev, rtc->irq_num, ma35d1_rtc_interrupt,
+			       IRQF_NO_SUSPEND, "ma35d1rtc", rtc);
+	if (err)
+		return dev_err_probe(&pdev->dev, err, "Failed to request rtc irq\n");
+
+	regval = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
+	regval |= RTC_INTEN_TICKIEN;
+	rtc_reg_write(rtc, MA35_REG_RTC_INTEN, regval);
+
+	device_init_wakeup(&pdev->dev, true);
+
+	return 0;
+}
+
+static int ma35d1_rtc_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct ma35_rtc *rtc = platform_get_drvdata(pdev);
+	u32 regval;
+
+	if (device_may_wakeup(&pdev->dev))
+		enable_irq_wake(rtc->irq_num);
+
+	regval = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
+	regval &= ~RTC_INTEN_TICKIEN;
+	rtc_reg_write(rtc, MA35_REG_RTC_INTEN, regval);
+
+	return 0;
+}
+
+static int ma35d1_rtc_resume(struct platform_device *pdev)
+{
+	struct ma35_rtc *rtc = platform_get_drvdata(pdev);
+	u32 regval;
+
+	if (device_may_wakeup(&pdev->dev))
+		disable_irq_wake(rtc->irq_num);
+
+	regval = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
+	regval |= RTC_INTEN_TICKIEN;
+	rtc_reg_write(rtc, MA35_REG_RTC_INTEN, regval);
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
+	.suspend    = ma35d1_rtc_suspend,
+	.resume     = ma35d1_rtc_resume,
+	.probe      = ma35d1_rtc_probe,
+	.driver		= {
+		.name	= "rtc-ma35d1",
+		.of_match_table = ma35d1_rtc_of_match,
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

