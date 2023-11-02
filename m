Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120717DF3B5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376516AbjKBN03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376495AbjKBN00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:26:26 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C95D7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 06:26:20 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so1550075a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 06:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698931578; x=1699536378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u9r7LTnb6BnC0CaoIZA+vajDcH3xjErVsZA1eDugTvM=;
        b=W3Gq1JLSa1A2Y8Dn5pAQ/20ewFSP3ob+8m7c/tpOBJUmjT1lyTVIEZuCOSh2r2bSWR
         d+qieIEaF+X4JccBS8yCV0VDBYvKMpGDzYcrUApIYN4iHMx/6NTXA8JTVB0s8Um9Gxdb
         LYBo6mSGL0QfZsdhxfqX1QXcwzkqkioIezeTMnOibNpaJ8fIaK/QuCXUTH6iftUphPqj
         iMMtQRaCA7tSggVIiWHBex+h0toFnrz7hRymrY5r0tp9p8ULNfFavcCdTeoL4AE75Q03
         slc1HPzL6rmfWkocxiUvjLPuxOL71lm57ypT91L04B8PXajja5GIQ8MflpF6XoRryh8V
         EffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698931578; x=1699536378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9r7LTnb6BnC0CaoIZA+vajDcH3xjErVsZA1eDugTvM=;
        b=iB2L6FEINUYLHF5HkdukacPTFAYpccr6XKaCDvRzv4qy5pZInlRQDjv4ihsPOy8sUH
         47SIrX40VU1DCfApxT1Y0cm+xol4LyvNBFzm7uNRUNoMNBvcSVTYA36eqkRhNuSaNlkY
         SWwW6KQyHWFXQ9mj3uZYscp3HryRsT6OiR5HCNg5jE9JwoW0Mr2tBsLrvBlk7sRfvd8z
         bspk0yIjV37SJVe/XdXfuzch31zkI7RSo59XhHrerLjoCIywxP3bcHL7+TqWx7Tsu3Po
         7l8Gic2ol8JgXVsZXM0xhi6KfDvHaClZ0Qq3Ra6Rp9hg/KmqsZkEyWoSyUNISiReYOiN
         58Gw==
X-Gm-Message-State: AOJu0Yw/4Zgh5CNpLaY61tnPoUZXSxl09se+JaFNj45sTdSc0CIpax/l
        0JOZw/mo83CJOy0+puowdDsODw==
X-Google-Smtp-Source: AGHT+IEKi28jgX0/lC1F1vpkzCTkPlDcKkh9K7W4OaBaxPr5IdboecKGFSH+IGZ7DssFsKNdBiwkKQ==
X-Received: by 2002:a17:907:9811:b0:9b2:b71f:83be with SMTP id ji17-20020a170907981100b009b2b71f83bemr5108978ejc.1.1698931578446;
        Thu, 02 Nov 2023 06:26:18 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:448:76e0:588c:af9c:bddc:7245])
        by smtp.gmail.com with ESMTPSA id s10-20020a05600c45ca00b0040776008abdsm2849831wmo.40.2023.11.02.06.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 06:26:18 -0700 (PDT)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, eblanc@baylibre.com, u-kumar1@ti.com
Subject: [PATCH v8] rtc: tps6594: Add driver for TPS6594 RTC
Date:   Thu,  2 Nov 2023 14:26:16 +0100
Message-Id: <20231102132616.1130960-1-eblanc@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPS6594 PMIC is a MFD. This patch adds support for
the RTC found inside TPS6594 family of PMIC.

Alarm is also supported.

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---

Notes:
    This patch was picked from a series since there is no dependency between
    the two patches.
    
    Changes since v7:
    https://lore.kernel.org/lkml/20230628133021.500477-1-eblanc@baylibre.com/
    - Remove useless variable and comment
    - Fix a typo
    
    Here is the old cover-letter:
    TPS6594 is a Power Management IC which provides regulators and others
    features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
    PFSM (Pre-configurable Finite State Machine). The SoC and the PMIC can
    communicate through the I2C or SPI interfaces.
    TPS6594 is the super-set device while TPS6593 and LP8764 are derivatives.
    
    This series adds support to TI TPS6594 PMIC and its derivatives.
    
    This should be applied on top of other patch series:
    - https://lore.kernel.org/all/20230511095126.105104-1-jpanis@baylibre.com/
      For core MFD driver. The necessary part of this patch series is already
      applied in linux-next.
    
    The features implemented in this series are:
    - RTC (child device)
    - Pinmux/GPIO (child device)
    - Regulator (child device)
    
    RTC description:
    The TPS6594 family has an RTC built-in, except for LP8764.
    It provides time and an alarm.
    
    Pinmux/GPIO:
    TPS6594 family has 11 GPIOs. Those GPIO can also serve different
    functions such as I2C or SPI interface, watchdog disable functions.
    The driver provides both pinmuxing for the functions and GPIO capability.
    
    Regulator:
    TPS6594/TPS6593: 5 BUCKs and 4LDOs
    LP8764: 4 BUCKs and no LDO
    Bucks can be used in multipahse mode.
    
    Regulators were applied to linux-next by Mark Brown on 06/06/2023 so this
    patch has been dropped from the patch series.
    There were some pending comments from Andy Shevchenko so a follow up patch will
    be sent later.
    
    Changes since v1:
    https://lore.kernel.org/all/20230224133129.887203-1-eblanc@baylibre.com/
    Rtc:
    - Removed struct tps6594_rtc.
    - Removed some dev_err messages.
    - Removed some comments.
    - Remove some whitespaces in comments and error messages.
    - Check if RTC is running before reading a timestamp in read_rtc.
    - Stop RTC at the end of probe to wait for a timestamp to be set.
    - Add default MFD_TPS6594 to Kconfig.
    
    Pinctrl:
    - Removed #define DEBUG.
    - Add default MFD_TPS6594 to Kconfig.
    - Fix typo and reword help message of Kconfig.
    
    Regulators:
    Further to Mark Brown review:
    - File header whole block C++ style.
    - Configuring modes not supported: omit all mode operations
    - Log the error before notifying.
    - Request the interrupts while registering the regulators (then remove
      the lookup function).
    Further to Matti review:
    - Postponed: devm_regulator_irq_helper() and
      regulator_irq_map_event_simple() can probably be used but code.
      refactoring is not so trivial. This can be done later as an enhancement
      after this patch list is merged.
    Buck Multi phase management:
    - Multiphase property can take an array when 2 multi phase buck, buck12
      and buck34.
    - Configuration multi phase buck34 without multiphase buck12 is not
      supported (when only one multiphase, must be buck12). Not clear from the
      spec but confirmed by TI.
    - Supported multiphase conficurations: buck12, buck123, buck1234,
      buck12 + buck34.
    - All interrupts are attached to the multiphase buck (ie: for regulator
      buck12, buck1 & buck2 interrupts are registered).
    
    Changes since v2:
    https://lore.kernel.org/all/20230328091448.648452-1-eblanc@baylibre.com/
    Rtc:
    - Add logic to avoid reinitializing a working clock.
    - Fix some multiline comments format.
    
    Regulators:
    Further to Mark Brown review:
    - Log the error before notifying.
    - Request the interrupts while registering the regulators.
    Further to Krzysztof Kozlowski:
    https://lore.kernel.org/all/75f0a18d-aed9-8610-2925-4e604b4b0241@baylibre.com/
    - Remove ti, multi-phase-id property which is redundant with buck dts naming
      rules.
    
    Changes since v3:
    https://lore.kernel.org/lkml/20230414101217.1342891-1-eblanc@baylibre.com/
    RTC:
    - Add wakeup source
    
    Pinctrl:
    - Switch to GPIO_REGMAP framework
    
    Change since v4:
    https://lore.kernel.org/lkml/20230512141755.1712358-1-eblanc@baylibre.com/
    Update Copyright notice date
    Reorder includes
    
    RTC:
    - Rework some comments, fixing punctuation and style
    - Use NANO macro from units.h for PPB_MULT
    - Rework to use bitwise types
    - Remove unnecessary casts
    - Add SAFETY comments
    - Use `dev_err_probe(...)` instead of print then return
    
    Pinctrl:
    - Reword help message and add module name in Kconfig
    - Rework code to use struct pinfunction and PINCTRL_PINFUNCTION() macro
    - Remove unnecessary casts
    - Use `dev_err_probe(...)` instead of print then return
    - Replace TPS6594_REG_GPIO1_CONF with a comment for TPS6594_REG_GPIOX_CONF
    
    Regulators:
    - nits: Add missing tabs, standard spaces, group "buck_multi".
    - Use OF dedicated of_node_cmp API instead of standard strcmp.
    - Use devm_kmalloc_array(...) API instead of devm_kmalloc(...) wherever
      possible.
    - return dev_err_probe(...) wherever possible.
    
    Changes since v5:
    https://lore.kernel.org/lkml/20230522163115.2592883-1-eblanc@baylibre.com/
    
    Pinctrl:
    - Rework code for clarity
    - Rework macro to fix checkpatch macro argument reuse
    - Coding style fixes
    - Reword some comments
    
    Rtc:
    - Grammar fixes
    - Removed unused macros
    - Use type MIN/MAX macro instead of magic numbers
    - Fix return code in calibration
    - Use cpu_to_le16 and le16_to_cpu APIs instead of casting.
    - Reintroduce mdelay before reading BIT_RUN as otherwise both AM62 and J784S4
      will report a -ENODEV on a working RTC.
    
    Changes since v6:
    https://lore.kernel.org/all/20230612125248.1235581-1-eblanc@baylibre.com/
    
    Pinctrl:
    - Remove a comment

 drivers/rtc/Kconfig       |  12 +
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/rtc-tps6594.c | 447 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 460 insertions(+)
 create mode 100644 drivers/rtc/rtc-tps6594.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 05f4b2d66290..bf457f03c19e 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -578,6 +578,18 @@ config RTC_DRV_TPS6586X
 	  along with alarm. This driver supports the RTC driver for
 	  the TPS6586X RTC module.
 
+config RTC_DRV_TPS6594
+	tristate "TI TPS6594 RTC driver"
+	depends on MFD_TPS6594
+	default MFD_TPS6594
+	help
+	  TI Power Management IC TPS6594 supports RTC functionality
+	  along with alarm. This driver supports the RTC driver for
+	  the TPS6594 RTC module.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-tps6594.
+
 config RTC_DRV_TPS65910
 	tristate "TI TPS65910 RTC driver"
 	depends on MFD_TPS65910
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index fd209883ee2e..5ed28639300c 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -175,6 +175,7 @@ obj-$(CONFIG_RTC_DRV_TEGRA)	+= rtc-tegra.o
 obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
 obj-$(CONFIG_RTC_DRV_TI_K3)	+= rtc-ti-k3.o
 obj-$(CONFIG_RTC_DRV_TPS6586X)	+= rtc-tps6586x.o
+obj-$(CONFIG_RTC_DRV_TPS6594)	+= rtc-tps6594.o
 obj-$(CONFIG_RTC_DRV_TPS65910)	+= rtc-tps65910.o
 obj-$(CONFIG_RTC_DRV_TWL4030)	+= rtc-twl.o
 obj-$(CONFIG_RTC_DRV_VT8500)	+= rtc-vt8500.o
diff --git a/drivers/rtc/rtc-tps6594.c b/drivers/rtc/rtc-tps6594.c
new file mode 100644
index 000000000000..35a246c127a0
--- /dev/null
+++ b/drivers/rtc/rtc-tps6594.c
@@ -0,0 +1,447 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RTC driver for tps6594 PMIC
+ *
+ * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
+ */
+
+#include <linux/bcd.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/limits.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/rtc.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/mfd/tps6594.h>
+
+// Total number of RTC registers needed to set time
+#define NUM_TIME_REGS (TPS6594_REG_RTC_WEEKS - TPS6594_REG_RTC_SECONDS + 1)
+
+// Total number of RTC alarm registers
+#define NUM_TIME_ALARM_REGS (NUM_TIME_REGS - 1)
+
+/*
+ * Min and max values supported by 'offset' interface (swapped sign).
+ * After conversion, the values do not exceed the range [-32767, 33767]
+ * which COMP_REG must conform to.
+ */
+#define MIN_OFFSET (-277774)
+#define MAX_OFFSET (277774)
+
+// Number of ticks per hour
+#define TICKS_PER_HOUR (32768 * 3600)
+
+// Multiplier for ppb conversions
+#define PPB_MULT NANO
+
+static int tps6594_rtc_alarm_irq_enable(struct device *dev,
+					unsigned int enabled)
+{
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	u8 val;
+
+	val = enabled ? TPS6594_BIT_IT_ALARM : 0;
+
+	return regmap_update_bits(tps->regmap, TPS6594_REG_RTC_INTERRUPTS,
+				  TPS6594_BIT_IT_ALARM, val);
+}
+
+/* Pulse GET_TIME field of RTC_CTRL_1 to store a timestamp in shadow registers. */
+static int tps6594_rtc_shadow_timestamp(struct device *dev, struct tps6594 *tps)
+{
+	int ret;
+
+	/*
+	 * Set GET_TIME to 0. Next time we set GET_TIME to 1 we will be sure to store
+	 * an up-to-date timestamp.
+	 */
+	ret = regmap_clear_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+				TPS6594_BIT_GET_TIME);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Copy content of RTC registers to shadow registers or latches to read
+	 * a coherent timestamp.
+	 */
+	return regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+			       TPS6594_BIT_GET_TIME);
+}
+
+static int tps6594_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	unsigned char rtc_data[NUM_TIME_REGS];
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	int ret;
+
+	// Check if RTC is running.
+	ret = regmap_test_bits(tps->regmap, TPS6594_REG_RTC_STATUS,
+			       TPS6594_BIT_RUN);
+	if (ret < 0)
+		return ret;
+	if (ret == 0)
+		return -EINVAL;
+
+	ret = tps6594_rtc_shadow_timestamp(dev, tps);
+	if (ret < 0)
+		return ret;
+
+	// Read shadowed RTC registers.
+	ret = regmap_bulk_read(tps->regmap, TPS6594_REG_RTC_SECONDS, rtc_data,
+			       NUM_TIME_REGS);
+	if (ret < 0)
+		return ret;
+
+	tm->tm_sec = bcd2bin(rtc_data[0]);
+	tm->tm_min = bcd2bin(rtc_data[1]);
+	tm->tm_hour = bcd2bin(rtc_data[2]);
+	tm->tm_mday = bcd2bin(rtc_data[3]);
+	tm->tm_mon = bcd2bin(rtc_data[4]) - 1;
+	tm->tm_year = bcd2bin(rtc_data[5]) + 100;
+	tm->tm_wday = bcd2bin(rtc_data[6]);
+
+	return 0;
+}
+
+static int tps6594_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	unsigned char rtc_data[NUM_TIME_REGS];
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	int ret;
+
+	rtc_data[0] = bin2bcd(tm->tm_sec);
+	rtc_data[1] = bin2bcd(tm->tm_min);
+	rtc_data[2] = bin2bcd(tm->tm_hour);
+	rtc_data[3] = bin2bcd(tm->tm_mday);
+	rtc_data[4] = bin2bcd(tm->tm_mon + 1);
+	rtc_data[5] = bin2bcd(tm->tm_year - 100);
+	rtc_data[6] = bin2bcd(tm->tm_wday);
+
+	// Stop RTC while updating the RTC time registers.
+	ret = regmap_clear_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+				TPS6594_BIT_STOP_RTC);
+	if (ret < 0)
+		return ret;
+
+	// Update all the time registers in one shot.
+	ret = regmap_bulk_write(tps->regmap, TPS6594_REG_RTC_SECONDS, rtc_data,
+				NUM_TIME_REGS);
+	if (ret < 0)
+		return ret;
+
+	// Start back RTC.
+	return regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+			       TPS6594_BIT_STOP_RTC);
+}
+
+static int tps6594_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
+{
+	unsigned char alarm_data[NUM_TIME_ALARM_REGS];
+	u32 int_val;
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	int ret;
+
+	ret = regmap_bulk_read(tps->regmap, TPS6594_REG_ALARM_SECONDS,
+			       alarm_data, NUM_TIME_ALARM_REGS);
+	if (ret < 0)
+		return ret;
+
+	alm->time.tm_sec = bcd2bin(alarm_data[0]);
+	alm->time.tm_min = bcd2bin(alarm_data[1]);
+	alm->time.tm_hour = bcd2bin(alarm_data[2]);
+	alm->time.tm_mday = bcd2bin(alarm_data[3]);
+	alm->time.tm_mon = bcd2bin(alarm_data[4]) - 1;
+	alm->time.tm_year = bcd2bin(alarm_data[5]) + 100;
+
+	ret = regmap_read(tps->regmap, TPS6594_REG_RTC_INTERRUPTS, &int_val);
+	if (ret < 0)
+		return ret;
+
+	alm->enabled = int_val & TPS6594_BIT_IT_ALARM;
+
+	return 0;
+}
+
+static int tps6594_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
+{
+	unsigned char alarm_data[NUM_TIME_ALARM_REGS];
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	int ret;
+
+	// Disable alarm irq before changing the alarm timestamp.
+	ret = tps6594_rtc_alarm_irq_enable(dev, 0);
+	if (ret)
+		return ret;
+
+	alarm_data[0] = bin2bcd(alm->time.tm_sec);
+	alarm_data[1] = bin2bcd(alm->time.tm_min);
+	alarm_data[2] = bin2bcd(alm->time.tm_hour);
+	alarm_data[3] = bin2bcd(alm->time.tm_mday);
+	alarm_data[4] = bin2bcd(alm->time.tm_mon + 1);
+	alarm_data[5] = bin2bcd(alm->time.tm_year - 100);
+
+	// Update all the alarm registers in one shot.
+	ret = regmap_bulk_write(tps->regmap, TPS6594_REG_ALARM_SECONDS,
+				alarm_data, NUM_TIME_ALARM_REGS);
+	if (ret < 0)
+		return ret;
+
+	if (alm->enabled)
+		ret = tps6594_rtc_alarm_irq_enable(dev, 1);
+
+	return ret;
+}
+
+static int tps6594_rtc_set_calibration(struct device *dev, int calibration)
+{
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	__le16 value;
+	int ret;
+
+	/*
+	 * TPS6594 uses two's complement 16 bit value for compensation of RTC
+	 * crystal inaccuracies. One time every hour when seconds counter
+	 * increments from 0 to 1 compensation value will be added to internal
+	 * RTC counter value.
+	 *
+	 * Valid range for compensation value: [-32767 .. 32767].
+	 */
+	if (calibration < S16_MIN + 1 || calibration > S16_MAX)
+		return -ERANGE;
+
+	value = cpu_to_le16(calibration);
+
+	// Update all the compensation registers in one shot.
+	ret = regmap_bulk_write(tps->regmap, TPS6594_REG_RTC_COMP_LSB, &value,
+				sizeof(value));
+	if (ret < 0)
+		return ret;
+
+	// Enable automatic compensation.
+	return regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+			       TPS6594_BIT_AUTO_COMP);
+}
+
+static int tps6594_rtc_get_calibration(struct device *dev, int *calibration)
+{
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	unsigned int ctrl;
+	__le16 value;
+	int ret;
+
+	ret = regmap_read(tps->regmap, TPS6594_REG_RTC_CTRL_1, &ctrl);
+	if (ret < 0)
+		return ret;
+
+	// If automatic compensation is not enabled report back zero.
+	if (!(ctrl & TPS6594_BIT_AUTO_COMP)) {
+		*calibration = 0;
+		return 0;
+	}
+
+	ret = regmap_bulk_read(tps->regmap, TPS6594_REG_RTC_COMP_LSB, &value,
+			       sizeof(value));
+	if (ret < 0)
+		return ret;
+
+	*calibration = le16_to_cpu(value);
+
+	return 0;
+}
+
+static int tps6594_rtc_read_offset(struct device *dev, long *offset)
+{
+	int calibration;
+	s64 tmp;
+	int ret;
+
+	ret = tps6594_rtc_get_calibration(dev, &calibration);
+	if (ret < 0)
+		return ret;
+
+	// Convert from RTC calibration register format to ppb format.
+	tmp = calibration * PPB_MULT;
+
+	if (tmp < 0)
+		tmp -= TICKS_PER_HOUR / 2LL;
+	else
+		tmp += TICKS_PER_HOUR / 2LL;
+	tmp = div_s64(tmp, TICKS_PER_HOUR);
+
+	/*
+	 * SAFETY:
+	 * Computatiion is the reverse operation of the one done in
+	 * `tps6594_rtc_set_offset`. The safety remarks applie here too.
+	 */
+
+	/*
+	 * Offset value operates in negative way, so swap sign.
+	 * See 8.3.10.5, (32768 - COMP_REG).
+	 */
+	*offset = (long)-tmp;
+
+	return 0;
+}
+
+static int tps6594_rtc_set_offset(struct device *dev, long offset)
+{
+	int calibration;
+	s64 tmp;
+
+	// Make sure offset value is within supported range.
+	if (offset < MIN_OFFSET || offset > MAX_OFFSET)
+		return -ERANGE;
+
+	// Convert from ppb format to RTC calibration register format.
+
+	tmp = offset * TICKS_PER_HOUR;
+	if (tmp < 0)
+		tmp -= PPB_MULT / 2LL;
+	else
+		tmp += PPB_MULT / 2LL;
+	tmp = div_s64(tmp, PPB_MULT);
+
+	/*
+	 * SAFETY:
+	 * - tmp = offset * TICK_PER_HOUR :
+	 *	`offset` can't be more than 277774, so `tmp` can't exceed 277774000000000
+	 *	which is lower than the maximum value in an `s64` (2^63-1). No overflow here.
+	 *
+	 * - tmp += TICK_PER_HOUR / 2LL :
+	 *	tmp will have a maximum value of 277774117964800 which is still inferior to 2^63-1.
+	 */
+
+	// Offset value operates in negative way, so swap sign.
+	calibration = (int)-tmp;
+
+	return tps6594_rtc_set_calibration(dev, calibration);
+}
+
+static irqreturn_t tps6594_rtc_interrupt(int irq, void *rtc)
+{
+	struct device *dev = rtc;
+	struct tps6594 *tps = dev_get_drvdata(dev->parent);
+	struct rtc_device *rtc_dev = dev_get_drvdata(dev);
+	int ret;
+	u32 rtc_reg;
+
+	ret = regmap_read(tps->regmap, TPS6594_REG_RTC_STATUS, &rtc_reg);
+	if (ret)
+		return IRQ_NONE;
+
+	rtc_update_irq(rtc_dev, 1, RTC_IRQF | RTC_AF);
+
+	return IRQ_HANDLED;
+}
+
+static const struct rtc_class_ops tps6594_rtc_ops = {
+	.read_time = tps6594_rtc_read_time,
+	.set_time = tps6594_rtc_set_time,
+	.read_alarm = tps6594_rtc_read_alarm,
+	.set_alarm = tps6594_rtc_set_alarm,
+	.alarm_irq_enable = tps6594_rtc_alarm_irq_enable,
+	.read_offset = tps6594_rtc_read_offset,
+	.set_offset = tps6594_rtc_set_offset,
+};
+
+static int tps6594_rtc_probe(struct platform_device *pdev)
+{
+	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct rtc_device *rtc;
+	int irq;
+	int ret;
+
+	rtc = devm_kzalloc(dev, sizeof(*rtc), GFP_KERNEL);
+	if (!rtc)
+		return -ENOMEM;
+
+	rtc = devm_rtc_allocate_device(dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+
+	// Enable crystal oscillator.
+	ret = regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_2,
+			      TPS6594_BIT_XTAL_EN);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_test_bits(tps->regmap, TPS6594_REG_RTC_STATUS,
+			       TPS6594_BIT_RUN);
+	if (ret < 0)
+		return ret;
+	// RTC not running.
+	if (ret == 0) {
+		ret = regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+				      TPS6594_BIT_STOP_RTC);
+		if (ret < 0)
+			return ret;
+
+		/*
+		 * On some boards, a 40 ms delay is needed before BIT_RUN is set.
+		 * 80 ms should provide sufficient margin.
+		 */
+		mdelay(80);
+
+		/*
+		 * RTC should be running now. Check if this is the case.
+		 * If not it might be a missing oscillator.
+		 */
+		ret = regmap_test_bits(tps->regmap, TPS6594_REG_RTC_STATUS,
+				       TPS6594_BIT_RUN);
+		if (ret < 0)
+			return ret;
+		if (ret == 0)
+			return -ENODEV;
+
+		// Stop RTC until first call to `tps6594_rtc_set_time`.
+		ret = regmap_clear_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
+					TPS6594_BIT_STOP_RTC);
+		if (ret < 0)
+			return ret;
+	}
+
+	platform_set_drvdata(pdev, rtc);
+
+	irq = platform_get_irq_byname(pdev, TPS6594_IRQ_NAME_ALARM);
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "Failed to get irq\n");
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, tps6594_rtc_interrupt,
+					IRQF_ONESHOT, TPS6594_IRQ_NAME_ALARM,
+					dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to request_threaded_irq\n");
+
+	ret = device_init_wakeup(dev, true);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to init rtc as wakeup source\n");
+
+	rtc->ops = &tps6594_rtc_ops;
+	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rtc->range_max = RTC_TIMESTAMP_END_2099;
+
+	return devm_rtc_register_device(rtc);
+}
+
+static struct platform_driver tps6594_rtc_driver = {
+	.probe		= tps6594_rtc_probe,
+	.driver		= {
+		.name	= "tps6594-rtc",
+	},
+};
+
+module_platform_driver(tps6594_rtc_driver);
+MODULE_ALIAS("platform:tps6594-rtc");
+MODULE_AUTHOR("Esteban Blanc <eblanc@baylibre.com>");
+MODULE_DESCRIPTION("TPS6594 RTC driver");
+MODULE_LICENSE("GPL");
-- 
2.40.1

