Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77AF7AD104
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjIYHDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjIYHDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:03:16 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10425B8;
        Mon, 25 Sep 2023 00:03:09 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bdcbde9676so3922633a34.3;
        Mon, 25 Sep 2023 00:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695625388; x=1696230188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHhaL5m4pKA7+OJ/gcfrIM4dCYgUutLL3dqd1BkNZ1c=;
        b=E4FXoB1R+IHhwwpxavAHXSayQF6vse2H/xMMrlGnhtC7W/ePsz0qTr8SqLzHifagsF
         FRBzJQrAWUWuB7RlOwhbMbHr2bOShTxq7rEfUh9ZhOm3IHkuVAs+R+gB6mTOTj1ePUuf
         u9MhSt285Adjai2nJRDr9Xcn60Bqjiu3uHXOpaP+X6SC1OLw5wBQdZCKD1W6Osg/nbit
         gHgZ3sqMOdZEyzzdsz9ZRUi5OsK23tPvXHu1+on69s7F/VMbOQWAMtuw7Sz263/Mt4FG
         QcDYvSD8Uywr6WoO19UARJw7kMcBgET5/d+B96Hm2UU/x2d3uaCq/kmHbdIJykOYoHwy
         ZfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695625388; x=1696230188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHhaL5m4pKA7+OJ/gcfrIM4dCYgUutLL3dqd1BkNZ1c=;
        b=txhy3PXE11t/4hjBzYVGfDlTAVNY8/MVxHiqI9bxvGP52WUbECOxo7Z+SOhlCg1DOt
         iA1q2aoujo1zIrIBw3b2Ou+H2qofq57YhXSY3XuXpnAiQiRlnI+FB6+kQSurV/xEqMW8
         7VXTWXS0lPN4SWyZ6Ib1DYpDrtwEiNjgPjH9agCw9C2+E9XQmaix6Dm/D1V2EcdrIdZS
         0wEbMCZPEor1kXpK6yrIAu3C2J6b0Rv8S/G4/EI6Q4oBT1hP1zSoAmGBwd6qrBUvZJ2f
         F0aRM1BHBFKDiB2SmlFnfxFZjMJ61UCW/1/nj3BdjWpu1hoRE9Jg+2JatKdpDjMHvIc0
         OBdw==
X-Gm-Message-State: AOJu0Yww9ohB7aHrexvhZKUaOHTf4smd6aL77uwY/V8gsgATGkoROEKC
        pgzviU4yDSG0ZOMc4IbckSImiMlgbKo=
X-Google-Smtp-Source: AGHT+IH7ntprxS8kSVOpW37L1aIJAyRfN6R5YNyj8ToGfmfTjwHFm9YiSb7yZ3cor7GMm7fMF2lOFw==
X-Received: by 2002:a05:6358:9989:b0:142:fb84:92e6 with SMTP id j9-20020a056358998900b00142fb8492e6mr9007560rwb.9.1695625388117;
        Mon, 25 Sep 2023 00:03:08 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id y5-20020a62b505000000b0068ffb8da107sm7349833pfe.212.2023.09.25.00.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 00:03:07 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mjchen@nuvoton.com, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v4 3/3] rtc: Add driver for Nuvoton ma35d1 rtc controller
Date:   Mon, 25 Sep 2023 07:02:51 +0000
Message-Id: <20230925070251.28-4-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230925070251.28-1-ychuang570808@gmail.com>
References: <20230925070251.28-1-ychuang570808@gmail.com>
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
 drivers/rtc/rtc-ma35d1.c | 324 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 336 insertions(+)
 create mode 100644 drivers/rtc/rtc-ma35d1.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index d7502433c78a..0615b2831273 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1930,6 +1930,17 @@ config RTC_DRV_TI_K3
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
index 000000000000..07c9a083a9d5
--- /dev/null
+++ b/drivers/rtc/rtc-ma35d1.c
@@ -0,0 +1,324 @@
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
+#define RTC_INTEN_UIEN		BIT(1)
+#define RTC_INTEN_CLKFIEN	BIT(24)
+#define RTC_INTEN_CLKSTIEN	BIT(25)
+
+/* register MA35_REG_RTC_INTSTS */
+#define RTC_INTSTS_ALMIF	BIT(0)
+#define RTC_INTSTS_UIF		BIT(1)
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
+	if (rtc_irq & RTC_INTSTS_UIF) {
+		rtc_reg_write(rtc, MA35_REG_RTC_INTSTS, RTC_INTSTS_UIF);
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
+	do {
+		time = rtc_reg_read(rtc, MA35_REG_RTC_TIME);
+		cal  = rtc_reg_read(rtc, MA35_REG_RTC_CAL);
+		wday = rtc_reg_read(rtc, MA35_REG_RTC_WEEKDAY);
+	} while (time != rtc_reg_read(rtc, MA35_REG_RTC_TIME) ||
+		 cal != rtc_reg_read(rtc, MA35_REG_RTC_CAL));
+
+	tm->tm_mday = bcd2bin(cal >> 0);
+	tm->tm_wday = wday;
+	tm->tm_mon = bcd2bin(cal >> 8);
+	tm->tm_mon = tm->tm_mon - 1;
+	tm->tm_year = bcd2bin(cal >> 16) + 100;
+
+	tm->tm_sec = bcd2bin(time >> 0);
+	tm->tm_min = bcd2bin(time >> 8);
+	tm->tm_hour = bcd2bin(time >> 16);
+
+	return rtc_valid_tm(tm);
+}
+
+static int ma35d1_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct ma35_rtc *rtc = dev_get_drvdata(dev);
+	u32 val;
+
+	val = bin2bcd(tm->tm_mday) << 0 | bin2bcd(tm->tm_mon + 1) << 8 |
+	      bin2bcd(tm->tm_year - 100) << 16;
+	rtc_reg_write(rtc, MA35_REG_RTC_CAL, val);
+
+	val = bin2bcd(tm->tm_sec) << 0 | bin2bcd(tm->tm_min) << 8 |
+	      bin2bcd(tm->tm_hour) << 16;
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
+	calm = rtc_reg_read(rtc, MA35_REG_RTC_CALM);
+
+	alrm->time.tm_mday = bcd2bin(calm >> 0);
+	alrm->time.tm_mon = bcd2bin(calm >> 8);
+	alrm->time.tm_mon = alrm->time.tm_mon - 1;
+
+	alrm->time.tm_year = bcd2bin(calm >> 16) + 100;
+
+	alrm->time.tm_sec = bcd2bin(talm >> 0);
+	alrm->time.tm_min = bcd2bin(talm >> 8);
+	alrm->time.tm_hour = bcd2bin(talm >> 16);
+
+	return rtc_valid_tm(&alrm->time);
+}
+
+static int ma35d1_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct ma35_rtc *rtc = dev_get_drvdata(dev);
+	unsigned long val;
+
+	val = bin2bcd(alrm->time.tm_mday) << 0 | bin2bcd(alrm->time.tm_mon + 1) << 8 |
+	      bin2bcd(alrm->time.tm_year - 100) << 16;
+	rtc_reg_write(rtc, MA35_REG_RTC_CALM, val);
+
+	val = bin2bcd(alrm->time.tm_sec) << 0 | bin2bcd(alrm->time.tm_min) << 8 |
+	      bin2bcd(alrm->time.tm_hour) << 16;
+	rtc_reg_write(rtc, MA35_REG_RTC_TALM, val);
+
+	ma35d1_alarm_irq_enable(dev, alrm->enabled);
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
+	int ret;
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
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+
+	if (!(rtc_reg_read(rtc, MA35_REG_RTC_INIT) & RTC_INIT_ACTIVE)) {
+		ret = ma35d1_rtc_init(rtc, RTC_INIT_TIMEOUT);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret, "rtc init failed\n");
+	}
+
+	rtc->irq_num = platform_get_irq(pdev, 0);
+
+	ret = devm_request_irq(&pdev->dev, rtc->irq_num, ma35d1_rtc_interrupt,
+			       IRQF_NO_SUSPEND, "ma35d1rtc", rtc);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to request rtc irq\n");
+
+	platform_set_drvdata(pdev, rtc);
+
+	device_init_wakeup(&pdev->dev, true);
+
+	rtc->rtcdev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc->rtcdev))
+		return PTR_ERR(rtc->rtcdev);
+
+	rtc->rtcdev->ops = &ma35d1_rtc_ops;
+	rtc->rtcdev->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rtc->rtcdev->range_max = RTC_TIMESTAMP_END_2099;
+
+	ret = devm_rtc_register_device(rtc->rtcdev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to register rtc device\n");
+
+	regval = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
+	regval |= RTC_INTEN_UIEN;
+	rtc_reg_write(rtc, MA35_REG_RTC_INTEN, regval);
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
+	regval &= ~RTC_INTEN_UIEN;
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
+	regval |= RTC_INTEN_UIEN;
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
+MODULE_AUTHOR("Ming-Jen Chen <mjchen@nuvoton.com>");
+MODULE_DESCRIPTION("MA35D1 RTC driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

