Return-Path: <linux-kernel+bounces-32489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51591835C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A279EB265C6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04811AAC9;
	Mon, 22 Jan 2024 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDtmeyYe"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD81B20DDB;
	Mon, 22 Jan 2024 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910797; cv=none; b=oEfbA3sIMygLvm/NkVLNxVEKiZZo6N4L6p1v6fJokrhQTKyFBi+DwFGgt7SqZHa0x2dHhVI1I6ycnncVXGv9GRznGbQ+b5RSr19bYCkuwvsGjYf+4yE5ncCi/MZH2KsLN5Dd4oSHFjQFyrG7AIUX2IN5odZ9rtLF1goadVe8Ey8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910797; c=relaxed/simple;
	bh=OlI/lZjMybTrijVFj7/y4+G6fZIA0TOPmkvNztbrbxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TzLBZwInDS6rg53ypDq6KdA7hRTS7XX3Bg2BOLj2jqAAVJllVvpSGHo7NIa7zJc/Iu0DVYWOg1lxFhfOaRxgUYrI0Prxm5OQPDN/Rh+om8LYUpMeBmFfaCJvj5uL4T7r+ORc/6lxRCb+GZ7WTYDg6LZv9ywrm+ed1+6COxRDkls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDtmeyYe; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6dddfdc3244so2242796a34.1;
        Mon, 22 Jan 2024 00:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705910795; x=1706515595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yYt1iYYu8y5X4WKAN21BcT55k/3WYhhR/r3DiZfbX9E=;
        b=cDtmeyYehkoxhrIajd5cytszezi5ITeeuDnBEKfXFuj/L44ZIc4x8fmhfYQhoNVY+R
         bJ/FBtx1ecfMjFJxaOd1yGyyDN9ciGa7zweLy4/SDAma+gVKTvajX4oAAGbfu2EvWfbS
         gVJQveUzyFNjmAQgPnM06bnd4ipzlLqIQp1vIrUc6V0H8Y4Y7l3eVowAIS4S21XXWwAu
         Gg4C42NUsyCOEydSqxGBp3C6QHi7/7SImwppphlWDUS+EbNZp/LF8AuQGyhdtoVdgdGH
         ONQh0+9ytmnDobv35ayPvR/9ljrdb1jS5CilioXGzTyaN6lLlFWmOtuCwph8aJ78GHbQ
         ymPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705910795; x=1706515595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yYt1iYYu8y5X4WKAN21BcT55k/3WYhhR/r3DiZfbX9E=;
        b=KrUy3Xblwc2ASHIApzxjjXzhFIgIEkS9FpZSGfJ3PYacjmn8ueJzw+RTjF2aP8stUn
         F4OOjgt/sNNHdUNU5QrqB1r2r6j/bToTX1AIhucEGcUVxi+UGCz1sc+U5l+3/7XFGHr0
         dXEA16qIRJ6KMe0u2gYAveUtsAmTErHu0NnzhUsgk0Onfi9ysRLjswCcyMV3Og9xHN7o
         BVoPnyih0urUSk9/Z3l7hP6hXRrw3gU9kqYOyjGT3rfu9a7caHU71Tsc3i+j5DJb6o7C
         yL+2zmyoVjbNDWt2xEMG91iihJWiBwtHcOsb2kFgl9J62GhayZV8IJNLiqxY/9wxDp6A
         uReQ==
X-Gm-Message-State: AOJu0Ywb9lyZh8fdPoCjbM/CqozeL3kEju9cRhE2ugKC/I4pqdmb0IQw
	ByY70ERLgcGJp2MeYp/qJJ+ltxskvkJGYr01DPKvzXeZ2MSYrvxR
X-Google-Smtp-Source: AGHT+IFp/7IQ+9OJHEql9p4DBa/xpL8mZ66kHL2spdwR0siNHlhiOU/cobAOyRERRmXo4P21tPNeDw==
X-Received: by 2002:a05:6358:338c:b0:176:7be:3022 with SMTP id i12-20020a056358338c00b0017607be3022mr2184765rwd.44.1705910794324;
        Mon, 22 Jan 2024 00:06:34 -0800 (PST)
Received: from localhost ([46.3.240.101])
        by smtp.gmail.com with ESMTPSA id o8-20020a056a00214800b006d9a38fe569sm9021826pfk.89.2024.01.22.00.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 00:06:34 -0800 (PST)
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
	dlan@gentoo.org
Subject: [PATCH v7 2/3] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
Date: Mon, 22 Jan 2024 16:06:30 +0800
Message-ID: <20240122080631.2880-1-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.43.0
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
 drivers/rtc/rtc-cv1800.c | 406 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 414 insertions(+)
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
index 000000000000..fbf2e575ea94
--- /dev/null
+++ b/drivers/rtc/rtc-cv1800.c
@@ -0,0 +1,406 @@
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
+	uint32_t ctrl_val;
+	void __iomem *base;
+	int ret;
+
+	rtc = devm_kzalloc(&pdev->dev, sizeof(struct cv1800_rtc_priv),
+			   GFP_KERNEL);
+	if (!rtc)
+		return -ENOMEM;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	rtc->rtc_map =
+		devm_regmap_init_mmio(&pdev->dev, base, &cv1800_rtc_regmap_config);
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
2.43.0


