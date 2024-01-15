Return-Path: <linux-kernel+bounces-26216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543B482DCED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB841F228B4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3A3179B0;
	Mon, 15 Jan 2024 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nN9IKMYT"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8EB17BCD;
	Mon, 15 Jan 2024 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3e05abcaeso58091505ad.1;
        Mon, 15 Jan 2024 08:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705334777; x=1705939577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdyaIvxmmOjRunOX/oOw4o3WkHS+fs6RCTmeYumhAog=;
        b=nN9IKMYTDDuJ5j5c9sqOUPO7qKHsXSoUyDK4rb56V5t+vVHIurRJESVwtm6hcXJ4Ha
         1RJc8V930nurW48N8gjmZBEOZwpaA1wZ5MbVLQaQDc2BJxChIRhY/f4hD83vMvlGriD0
         MXrUsQGs2jbgXzPW0i9iKOnUPnkNqJWIyj0C3jHzqTRwSj5ts9X+IXVT12Jyrm4eB1kL
         LMzHEZ+bNQWacMGk2H6g2TSvKXWJ3DUbzF2R0AJ5kXR/RljozAGSDFOxZSc9zxAqZBy+
         T8DgmysrlOYTGGoKLPrzaj6oJsfaSfxOpKG+eFniIiA2ve7cH0dAoSnrE62EKbrGB6r0
         g4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705334777; x=1705939577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdyaIvxmmOjRunOX/oOw4o3WkHS+fs6RCTmeYumhAog=;
        b=qXAw/3NJGuVwOsou36I1+Ww8ifWPnrcfzxg+Rx+OAbEiA5BVfCcfAqBN93tCUJusQh
         LfG/JJBBXuKlwpbDdx/+X96yqVmOqdewTFm4LsOJ3ixneZ0r3njb95KYFTYE20Pvz07U
         R+9T4tI0j/aqnt1X7BkjgmwnCkxEaB9O5+/zY8Mo8sgg/taPJL6GKHT+/vCZx+FUvk9E
         FZk1HeUmO4KIwctJV0OkNaxgAyfmI3ObFT6Q7pu+Vjc0ig3kqcN1U3Pq4jsMljxU8h6R
         JNzEJ0gqxwJAm7vrp+dk+vPgTqsoSF2s0XVVNZxH2PH5f6w2wU3J/K/yoN0RdVC50UxK
         RpmQ==
X-Gm-Message-State: AOJu0YxArj5VyBwDbs+c0qDV4bDd4Wf7zFaA4m61U9t6P5AnuKdy5eFG
	71pMBxjzkDuxw0MBwNJR1Sg=
X-Google-Smtp-Source: AGHT+IGIW3TzoHc4UGPm+e1BbSQfHy2FtGkiV9wGvQ9hBSn4ADjSrXUPj0yHTaGgHhkuH07IRsDlOQ==
X-Received: by 2002:a17:902:dac4:b0:1d3:45b7:bc26 with SMTP id q4-20020a170902dac400b001d345b7bc26mr3680287plx.54.1705334776899;
        Mon, 15 Jan 2024 08:06:16 -0800 (PST)
Received: from localhost ([124.131.233.112])
        by smtp.gmail.com with ESMTPSA id ml12-20020a17090334cc00b001d4f607ab24sm7793969plb.205.2024.01.15.08.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 08:06:16 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	dlan@gentoo.org,
	inochiama@outlook.com
Subject: [PATCH v6 2/3] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
Date: Tue, 16 Jan 2024 00:05:59 +0800
Message-ID: <20240115160600.5444-3-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115160600.5444-1-qiujingbao.dlmu@gmail.com>
References: <20240115160600.5444-1-qiujingbao.dlmu@gmail.com>
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

Depends on https://lore.kernel.org/all/IA1PR20MB4953C774D41EDF1EADB6EC18BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com/

---
 drivers/rtc/Kconfig      |   7 +
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-cv1800.c | 397 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 405 insertions(+)
 create mode 100644 drivers/rtc/rtc-cv1800.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 1ea9c7600150..3633f45c7fa0 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1115,6 +1115,13 @@ config RTC_DRV_DS2404
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-ds2404.
 
+config RTC_DRV_CV1800
+	tristate "Sophgo CV1800 RTC"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	help
+	  If you say Y here you will get support for the RTC found on
+	  CV1800
+
 config RTC_DRV_DA9052
 	tristate "Dialog DA9052/DA9053 RTC"
 	depends on PMIC_DA9052
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 31c4606fd9bf..a5fc78ac0094 100644
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
index 000000000000..836f15a881e0
--- /dev/null
+++ b/drivers/rtc/rtc-cv1800.c
@@ -0,0 +1,397 @@
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
+#include <linux/of.h>
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
+
+/*
+ * When in VDDBKUP domain, this MACRO register
+ * does not power down
+ */
+#define MACRO_DA_CLEAR_ALL          0x1480
+#define MACRO_DA_SOC_READY          0x148C
+#define MACRO_RO_T                  0x14A8
+#define MACRO_RG_SET_T              0x1498
+#define CTRL                        0x08
+#define FC_COARSE_EN                0x40
+#define FC_COARSE_CAL               0x44
+#define FC_FINE_EN                  0x48
+#define FC_FINE_CAL                 0x50
+#define CTRL_MODE_MASK              BIT(10)
+#define CTRL_MODE_OSC32K            0x00UL
+#define CTRL_MODE_XTAL32K           BIT(0)
+#define FC_COARSE_CAL_VAL_SHIFT     0
+#define FC_COARSE_CAL_VAL_MASK      GENMASK(15, 0)
+#define FC_COARSE_CAL_TIME_SHIFT    16
+#define FC_COARSE_CAL_TIME_MASK     GENMASK(31, 16)
+#define FC_FINE_CAL_VAL_SHIFT       0
+#define FC_FINE_CAL_VAL_MASK        GENMASK(23, 0)
+#define FC_FINE_CAL_TIME_SHIFT      24
+#define FC_FINE_CAL_TIME_MASK       GENMASK(31, 24)
+#define SEC_PULSE_GEN_INT_SHIFT     0
+#define SEC_PULSE_GEN_INT_MASK      GENMASK(7, 0)
+#define SEC_PULSE_GEN_FRAC_SHIFT    8
+#define SEC_PULSE_GEN_FRAC_MASK     GENMASK(24, 8)
+#define SEC_PULSE_GEN_SEL_SHIFT     31
+#define SEC_PULSE_GEN_SEL_MASK      GENMASK(30, 0)
+#define SEC_PULSE_SEL_INNER         BIT(31)
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
+#define REG_ENABLE_FUN              BIT(0)
+#define REG_DISABLE_FUN             0x00UL
+#define REG_INIT_TIMEOUT            100
+#define SEC_MAX_VAL                 0xFFFFFFFF
+#define ALARM_ENABLE_MASK           BIT(0)
+#define SET_SEC_CNTR_VAL_INIT       (BIT(28) || BIT(29))
+#define DEALY_TIME_PREPARE          400
+#define DEALY_TIME_LOOP             100
+
+struct cv1800_rtc_priv {
+	struct rtc_device *rtc_dev;
+	struct device *dev;
+	struct regmap *rtc_map;
+	struct clk *clk;
+	int irq;
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
+/**
+ * cv1800_rtc_32k_coarse_val_calib() - Using an external
+ * clock to coarse calibrate the crystal oscillator
+ * @info: the device of calibrated
+ *
+ * @return 0 on success, or -1 on fail
+ *
+ * This RTC has an independent 32KHz oscillator. However,
+ * the accuracy of this oscillator is easily affected by
+ * external environmental interference,resulting in lower
+ * accuracy than the internal oscillator.Therefore, a 25M
+ * crystal oscillator is used as a reference source to
+ * calibrate the RTC and improve its accuracy.Calibration
+ * is completed through two steps, namely rough calibration
+ * and fine calibration.
+ */
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
+		while (time_next <= time_now && --get_val_timeout) {
+			regmap_read(info->rtc_map, FC_COARSE_CAL, &time_next);
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
+			regmap_write(info->rtc_map, ANA_CALIB, calib_val);
+		} else if (coarse_val < CALIB_FC_COARSE_SUB_OFFSET) {
+			calib_val -= offset;
+			offset >>= CALIB_OFFSET_SHIFT;
+			regmap_write(info->rtc_map, ANA_CALIB, calib_val);
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
+	unsigned int sec_ro_t;
+	unsigned int sec;
+
+	/* select inner sec pulse and select reg set calibration val */
+	regmap_update_bits(info->rtc_map, SEC_PULSE_GEN,
+			   (unsigned int)(~SEC_PULSE_GEN_SEL_MASK),
+			   (unsigned int)(~SEC_PULSE_SEL_INNER));
+
+	regmap_update_bits(info->rtc_map, ANA_CALIB,
+			   (unsigned int)(~CALIB_SEL_FTUNE_MASK),
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
+	unsigned int sec;
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
+	rtc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(rtc->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->clk),
+				     "clk not found\n");
+
+	platform_set_drvdata(pdev, rtc);
+
+	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc->rtc_dev))
+		return PTR_ERR(rtc->rtc_dev);
+
+	rtc->rtc_dev->ops = &cv800b_rtc_ops;
+	rtc->rtc_dev->range_max = U32_MAX;
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
+
+		rtc_enable_sec_counter(rtc);
+	}
+
+	return devm_rtc_register_device(rtc->rtc_dev);
+}
+
+static const struct of_device_id cv1800_dt_ids[] = {
+	{ .compatible = "sophgo,cv1800b-rtc" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, cv1800_dt_ids);
+
+static struct platform_driver cv1800_rtc_driver = {
+	.driver = {
+		.name = "sophgo-cv800b-rtc",
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
2.43.0


