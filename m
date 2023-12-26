Return-Path: <linux-kernel+bounces-11470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADF381E6D2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 11:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135441C21E22
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1484E616;
	Tue, 26 Dec 2023 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="If2LlITQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0E64E611;
	Tue, 26 Dec 2023 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28bfdf3cd12so1567851a91.3;
        Tue, 26 Dec 2023 02:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703585091; x=1704189891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WH5u2wlH3NTED2V98sPXWdI5Qeh7rya9dsblguYzApI=;
        b=If2LlITQPB9V71s4eeN/8kGdYt/yZ/eeZ8UmDh7B4tJ1xlWoSAUC5vFKed3QymBOdY
         HqMjhj0z99BRttgLp0z6ICCUkIX2FPr/qYNzYBkk12c8ToXq0JKHgzdosnE5p/cj58Hc
         jE144Mf/EerBj+bm+QASc1frTzp/QPo7qG7iS4sqcFyw26u4sPbPZ4fIZfL5xBwMQh2W
         dcQx46oq1XCxRzGnb5nXOhB0bA/+LUqJ697CQrISiQQL2UQgvjnUnJccb3V0UmEXP8tN
         DZUtYujEsDn62czschXAFagzdhjkd92ul1cFO9V7mG1xxAQIyZajrs4VA10YnEmv4lRQ
         8INw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703585091; x=1704189891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WH5u2wlH3NTED2V98sPXWdI5Qeh7rya9dsblguYzApI=;
        b=m3BqBEKE0z626omuuva5CPz2w6D75DB95exX4YJY966MiI4W5SZC4Ds1WQVMpO7SDi
         DRI6PAVsgFhCWd63ijnXz9Lkih0mAoqin1I9TrcY2P0ElhG2IzUiZT/cebPuIKwR5dIx
         fB+oHBSagJhsXgMT/REJxB8QEfglox77B+eEnOwQJvToCEIFO+vBYhA9daspXKBFDuLn
         YoV5VFijFazvJwqY6ey7NjCcYCIEGRwvUkTODZDWkgOmVGTCgIQw0LH3oo7epXYVi6qQ
         wmQTCuYL/xepyMHbIPKO1CG/rTdxjbnjYE1/xpb0A4wKMrzq8o4G/fX7xGM9UmJvIRke
         O21Q==
X-Gm-Message-State: AOJu0YxEzNrMQQ3+MY1hBcBl3GKmfyl4PKUXfRjeH1g2M/9bGMI2GDOf
	Vs7a7ebrQd1K/zvMFr+kINg=
X-Google-Smtp-Source: AGHT+IHINhAgvg+AHKznN88LblyDYGNpA415ET8ikDMMfarA/9vrPRAYAW7wsT77z8Cf+UxfsbTQOA==
X-Received: by 2002:a17:90a:d48a:b0:28b:d707:3d64 with SMTP id s10-20020a17090ad48a00b0028bd7073d64mr1885182pju.28.1703585090641;
        Tue, 26 Dec 2023 02:04:50 -0800 (PST)
Received: from localhost ([46.3.240.105])
        by smtp.gmail.com with ESMTPSA id mf14-20020a17090b184e00b0028ae0184bfasm14247229pjb.49.2023.12.26.02.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 02:04:50 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org,
	conor+dt@kernel.org,
	chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlan@gentoo.org,
	inochiama@outlook.com,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v3 3/4] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
Date: Tue, 26 Dec 2023 18:04:30 +0800
Message-Id: <20231226100431.331616-4-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231226100431.331616-1-qiujingbao.dlmu@gmail.com>
References: <20231226100431.331616-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the RTC driver for CV1800, which able to provide time alarm
and calibrate functionality.

Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 drivers/rtc/Kconfig      |   6 +
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-cv1800.c | 417 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 424 insertions(+)
 create mode 100644 drivers/rtc/rtc-cv1800.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 4e3c2fde2d6a..d0b35ad92d52 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1103,6 +1103,12 @@ config RTC_DRV_DS2404
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-ds2404.
 
+config RTC_DRV_CV1800
+	tristate "Sophgo CV1800 RTC"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	help
+	  Say y here to support the RTC driver for Sophgo CV1800.
+
 config RTC_DRV_DA9052
 	tristate "Dialog DA9052/DA9053 RTC"
 	depends on PMIC_DA9052
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 6817ea4e4468..c08433c2126c 100644
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
index 000000000000..865577bc3246
--- /dev/null
+++ b/drivers/rtc/rtc-cv1800.c
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * rtc-cv1800.c: RTC driver for Sophgo cv1800 RTC
+ *
+ * Author: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
+ */
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/irq.h>
+#include <linux/delay.h>
+#include <linux/rtc.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+
+#define ANA_CALIB                   0x1000
+#define SEC_PULSE_GEN               0x1004
+#define ALARM_TIME                  0x1008
+#define ALARM_ENABLE                0x100C
+#define SET_SEC_CNTR_VAL            0x1010
+#define SET_SEC_CNTR_TRIG           0x1014
+#define SEC_CNTR_VAL                0x1018
+#define APB_RDATA_SEL               0x103C
+#define POR_DB_MAGIC_KEY            0x1068
+#define EN_PWR_WAKEUP               0x10BC
+#define MACRO_DA_CLEAR_ALL          0x1480
+#define MACRO_DA_SOC_READY          0x148C
+#define MACRO_RO_T                  0x14A8
+#define MACRO_RG_SET_T              0x1498
+
+#define CTRL                        0x08
+#define FC_COARSE_EN                0x40
+#define FC_COARSE_CAL               0x44
+#define FC_FINE_EN                  0x48
+#define FC_FINE_CAL                 0x50
+#define CTRL_MODE_MASK              BIT(10)
+#define CTRL_MODE_OSC32K            0x00UL
+#define CTRL_MODE_XTAL32K           BIT(0)
+
+#define FC_COARSE_CAL_VAL_SHIFT     0
+#define FC_COARSE_CAL_VAL_MASK      GENMASK(15, 0)
+#define FC_COARSE_CAL_TIME_SHIFT    16
+#define FC_COARSE_CAL_TIME_MASK     GENMASK(31, 16)
+#define FC_FINE_CAL_VAL_SHIFT       0
+#define FC_FINE_CAL_VAL_MASK        GENMASK(23, 0)
+#define FC_FINE_CAL_TIME_SHIFT      24
+#define FC_FINE_CAL_TIME_MASK       GENMASK(31, 24)
+
+#define SEC_PULSE_GEN_INT_SHIFT     0
+#define SEC_PULSE_GEN_INT_MASK      GENMASK(7, 0)
+#define SEC_PULSE_GEN_FRAC_SHIFT    8
+#define SEC_PULSE_GEN_FRAC_MASK     GENMASK(24, 8)
+#define SEC_PULSE_GEN_SEL_SHIFT     31
+#define SEC_PULSE_GEN_SEL_MASK      GENMASK(30, 0)
+#define SEC_PULSE_SEL_INNER         BIT(31)
+
+#define CALIB_INIT_VAL              (BIT(8) || BIT(16))
+#define CALIB_SEL_FTUNE_MASK        GENMASK(30, 0)
+#define CALIB_SEL_FTUNE_INNER       0x00UL
+#define CALIB_OFFSET_INIT           128
+#define CALIB_OFFSET_SHIFT          BIT(0)
+#define CALIB_FREQ                  256000000000
+#define CALIB_FRAC_EXT              10000
+#define CALIB_FREQ_NS               40
+#define CALIB_FREQ_MULT             256
+#define CALIB_FC_COARSE_PLUS_OFFSET 770
+#define CALIB_FC_COARSE_SUB_OFFSET  755
+
+#define REG_ENABLE_FUN              BIT(0)
+#define REG_DISABLE_FUN             0x00UL
+#define REG_INIT_TIMEOUT            100
+#define SEC_MAX_VAL                 0xFFFFFFFF
+#define ALARM_ENABLE_MASK           BIT(0)
+#define SET_SEC_CNTR_VAL_UPDATE     (BIT(28) || BIT(29))
+#define DEALY_TIME_PREPARE          400
+#define DEALY_TIME_LOOP             100
+
+struct cv1800_rtc_priv {
+	struct rtc_device *rtc_dev;
+	struct device *dev;
+	struct regmap *rtc_map;
+	struct clk *clk;
+	spinlock_t rtc_lock;
+	int irq;
+};
+
+static int cv1800_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
+
+	if (enabled)
+		regmap_write(info->rtc_map, ALARM_ENABLE, REG_ENABLE_FUN);
+	else
+		regmap_write(info->rtc_map, ALARM_ENABLE, REG_DISABLE_FUN);
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
+	if (alarm_time > SEC_MAX_VAL)
+		return -EINVAL;
+
+	regmap_write(info->rtc_map, ALARM_ENABLE, REG_DISABLE_FUN);
+
+	udelay(DEALY_TIME_PREPARE);
+
+	regmap_write(info->rtc_map, ALARM_TIME, alarm_time);
+	regmap_write(info->rtc_map, ALARM_ENABLE, REG_ENABLE_FUN);
+
+	return 0;
+}
+
+static int cv1800_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
+	uint32_t enabled;
+	uint32_t time;
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
+static int cv1800_rtc_32k_coarse_val_calib(struct cv1800_rtc_priv *info)
+{
+	uint32_t calib_val = 0;
+	uint32_t coarse_val = 0;
+	uint32_t time_now = 0;
+	uint32_t time_next = 0;
+	uint32_t offset = CALIB_OFFSET_INIT;
+	uint32_t coarse_timeout = REG_INIT_TIMEOUT;
+	uint32_t get_val_timeout = 0;
+
+	regmap_write(info->rtc_map, ANA_CALIB, CALIB_INIT_VAL);
+
+	udelay(DEALY_TIME_PREPARE);
+
+	/* Select 32K OSC tuning val source from rtc_sys */
+	regmap_update_bits(info->rtc_map, SEC_PULSE_GEN,
+			   (unsigned int)(~SEC_PULSE_GEN_SEL_MASK),
+			   (unsigned int)(~SEC_PULSE_SEL_INNER));
+
+	regmap_read(info->rtc_map, ANA_CALIB, &calib_val);
+
+	regmap_write(info->rtc_map, FC_COARSE_EN, REG_ENABLE_FUN);
+
+	while (--coarse_timeout) {
+		regmap_read(info->rtc_map, FC_COARSE_CAL, &time_now);
+		time_now >>= FC_COARSE_CAL_TIME_SHIFT;
+
+		get_val_timeout = REG_INIT_TIMEOUT;
+
+		while (time_next <= time_now &&
+		       --get_val_timeout) {
+			regmap_read(info->rtc_map, FC_COARSE_CAL,
+				    &time_next);
+			time_next >>= FC_COARSE_CAL_TIME_SHIFT;
+			udelay(DEALY_TIME_LOOP);
+		}
+
+		if (!get_val_timeout)
+			return -1;
+
+		udelay(DEALY_TIME_PREPARE);
+
+		regmap_read(info->rtc_map, FC_COARSE_CAL, &coarse_val);
+		coarse_val &= FC_COARSE_CAL_VAL_MASK;
+
+		if (coarse_val > CALIB_FC_COARSE_PLUS_OFFSET) {
+			calib_val += offset;
+			offset >>= CALIB_OFFSET_SHIFT;
+			regmap_write(info->rtc_map, ANA_CALIB,
+				     calib_val);
+		} else if (coarse_val < CALIB_FC_COARSE_SUB_OFFSET) {
+			calib_val -= offset;
+			offset >>= CALIB_OFFSET_SHIFT;
+			regmap_write(info->rtc_map, ANA_CALIB,
+				     calib_val);
+		} else {
+			regmap_write(info->rtc_map, FC_COARSE_EN,
+				     REG_DISABLE_FUN);
+			break;
+		}
+
+		if (offset == 0)
+			return -1;
+	}
+
+	return 0;
+}
+
+static int cv1800_rtc_32k_fine_val_calib(struct cv1800_rtc_priv *info)
+{
+	uint32_t val;
+	uint64_t freq = CALIB_FREQ;
+	uint32_t sec_cnt;
+	uint32_t timeout = REG_INIT_TIMEOUT;
+	uint32_t time_now = 0;
+	uint32_t time_next = 0;
+
+	regmap_write(info->rtc_map, FC_FINE_EN, REG_ENABLE_FUN);
+
+	regmap_read(info->rtc_map, FC_FINE_CAL, &time_now);
+	time_now >>= FC_FINE_CAL_TIME_SHIFT;
+
+	while (time_next <= time_now && --timeout) {
+		regmap_read(info->rtc_map, FC_FINE_CAL, &time_next);
+		time_next >>= FC_FINE_CAL_TIME_SHIFT;
+		udelay(DEALY_TIME_LOOP);
+	}
+
+	if (!timeout)
+		return -1;
+
+	regmap_read(info->rtc_map, FC_FINE_CAL, &val);
+	val &= FC_FINE_CAL_VAL_MASK;
+
+	do_div(freq, CALIB_FREQ_NS);
+	freq = freq * CALIB_FRAC_EXT;
+	do_div(freq, val);
+
+	sec_cnt = ((do_div(freq, CALIB_FRAC_EXT) * CALIB_FREQ_MULT) /
+			   CALIB_FRAC_EXT &
+		   SEC_PULSE_GEN_INT_MASK) +
+		  (freq << SEC_PULSE_GEN_FRAC_SHIFT);
+
+	regmap_write(info->rtc_map, SEC_PULSE_GEN, sec_cnt);
+	regmap_write(info->rtc_map, FC_FINE_EN, REG_DISABLE_FUN);
+
+	return 0;
+}
+
+static void rtc_enable_sec_counter(struct cv1800_rtc_priv *info)
+{
+	/* select inner sec pulse and select reg set calibration val */
+	regmap_update_bits(info->rtc_map, SEC_PULSE_GEN,
+			   (unsigned int)(~SEC_PULSE_GEN_SEL_MASK),
+			   (unsigned int)(~SEC_PULSE_SEL_INNER));
+
+	regmap_update_bits(info->rtc_map, ANA_CALIB,
+			   (unsigned int)(~CALIB_SEL_FTUNE_MASK),
+			   CALIB_SEL_FTUNE_INNER);
+
+	regmap_write(info->rtc_map, ALARM_ENABLE, REG_DISABLE_FUN);
+}
+
+static int cv1800_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
+	unsigned int sec;
+	unsigned int sec_ro_t;
+	unsigned long flag;
+
+	spin_lock_irqsave(&info->rtc_lock, flag);
+
+	regmap_read(info->rtc_map, SEC_CNTR_VAL, &sec);
+	regmap_read(info->rtc_map, MACRO_RO_T, &sec_ro_t);
+
+	if (sec_ro_t > (SET_SEC_CNTR_VAL_UPDATE)) {
+		sec = sec_ro_t;
+		regmap_write(info->rtc_map, SET_SEC_CNTR_VAL, sec);
+		regmap_write(info->rtc_map, SET_SEC_CNTR_TRIG, REG_ENABLE_FUN);
+	}
+
+	spin_unlock_irqrestore(&info->rtc_lock, flag);
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
+	int ret;
+	unsigned long flag;
+
+	ret = rtc_valid_tm(tm);
+	if (ret)
+		return ret;
+
+	sec = rtc_tm_to_time64(tm);
+
+	spin_lock_irqsave(&info->rtc_lock, flag);
+
+	regmap_write(info->rtc_map, SET_SEC_CNTR_VAL, sec);
+	regmap_write(info->rtc_map, SET_SEC_CNTR_TRIG, REG_ENABLE_FUN);
+
+	regmap_write(info->rtc_map, MACRO_RG_SET_T, sec);
+
+	spin_unlock_irqrestore(&info->rtc_lock, flag);
+
+	return 0;
+}
+
+static irqreturn_t cv1800_rtc_irq_handler(int irq, void *dev_id)
+{
+	struct device *dev = dev_id;
+	struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
+	struct rtc_wkalrm alrm;
+
+	regmap_write(info->rtc_map, ALARM_ENABLE, REG_DISABLE_FUN);
+
+	rtc_read_alarm(info->rtc_dev, &alrm);
+	alrm.enabled = 0;
+	rtc_set_alarm(info->rtc_dev, &alrm);
+
+	return IRQ_HANDLED;
+}
+
+static const struct rtc_class_ops cv800b_rtc_ops = {
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
+	uint32_t ctrl_val;
+	int ret;
+
+	rtc = devm_kzalloc(&pdev->dev, sizeof(struct cv1800_rtc_priv),
+			   GFP_KERNEL);
+	if (!rtc)
+		return -ENOMEM;
+
+	rtc->dev = &pdev->dev;
+
+	rtc->rtc_map = syscon_node_to_regmap(rtc->dev->of_node->parent);
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
+	rtc->clk = devm_clk_get(rtc->dev, NULL);
+	if (IS_ERR(rtc->clk))
+		return PTR_ERR(rtc->clk);
+
+	rtc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(rtc->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->clk),
+				     "clk not found\n");
+
+	platform_set_drvdata(pdev, rtc);
+
+	spin_lock_init(&rtc->rtc_lock);
+
+	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev,
+								dev_name(&pdev->dev),
+								&cv800b_rtc_ops,
+								THIS_MODULE);
+	if (IS_ERR(rtc->rtc_dev))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->rtc_dev),
+				     "can't register rtc device\n");
+
+	/* if use internal clk,so coarse calibrate rtc */
+	regmap_read(rtc->rtc_map, CTRL, &ctrl_val);
+	ctrl_val &= CTRL_MODE_MASK;
+
+	if (ctrl_val == CTRL_MODE_OSC32K) {
+		ret = cv1800_rtc_32k_coarse_val_calib(rtc);
+		if (ret)
+			dev_err(&pdev->dev, "failed to coarse RTC val !\n");
+
+		ret = cv1800_rtc_32k_fine_val_calib(rtc);
+		if (ret)
+			dev_err(&pdev->dev, "failed to fine RTC val !\n");
+	}
+
+	rtc_enable_sec_counter(rtc);
+
+	return 0;
+}
+
+static const struct of_device_id cv1800_dt_ids[] = {
+	{ .compatible = "sophgo,cv1800b-rtc" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, cv1800_dt_ids);
+
+static struct platform_driver cv1800_rtc_driver = {
+	.driver = {
+			.name = "sophgo-cv800b-rtc",
+			.of_match_table = cv1800_dt_ids,
+		},
+	.probe = cv1800_rtc_probe,
+};
+
+module_platform_driver(cv1800_rtc_driver);
+MODULE_AUTHOR("Jingbao Qiu");
+MODULE_DESCRIPTION("Sophgo cv1800 RTC Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


