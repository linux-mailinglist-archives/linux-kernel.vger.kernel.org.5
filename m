Return-Path: <linux-kernel+bounces-2539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07936815EA3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A2BBB21FDE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3DD14ABF;
	Sun, 17 Dec 2023 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft+EAiiq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBDD14A81;
	Sun, 17 Dec 2023 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso1720377a12.3;
        Sun, 17 Dec 2023 03:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702811403; x=1703416203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djvnfR+DlffXR2n7oCGYkrh+PH9JdnKZ6rFFSZRw/4g=;
        b=Ft+EAiiqxaL9surHt9YekmQ0PWIkHHb33KuEjM18g+Te7StT1FmUmuDB1EHcQLowu7
         ziGWZwvfpMfrBO9cBE1nYPsNtiKO/56BkwasU6EDSzzaIWN+hbS6vs1qfzeKxT+neR1U
         DzwjSQJt4HYE8yiiCZ3X6e6rVhbHNlwLP/WX4dJw/zynGhxZPcCbVzo8lcnQUIXVxQzC
         z2tJcJ2Ni1w9HBTdpKJr+1kXz+dSBY4dA0+Wjn5e9F/fPY5N9aPxvpfaJp8VPh4F2MtD
         NBxY6o5m7z8Z440tcL+0wWk9cuS7Cns+IGtwYeyuMofK21iBxKgJffFt5dhE/KXAoG2P
         zlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702811403; x=1703416203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djvnfR+DlffXR2n7oCGYkrh+PH9JdnKZ6rFFSZRw/4g=;
        b=F3lJykCNXS/vn9ot7QNNFz/SxgrE30N2uDpT37LwNgyB4IfAOSVzfjgueRGKwgI7f1
         9774IpXRJzXycR26w9HRBMxAjgkm5G+37naC25FxGSrPvsfPBRsirNdrxAaALEnHkiYX
         clswx+tPVpy7nUDVcXcn8OpjwwRhV+5OK0zNv4VkA2HFGI1ZIxYBClibOAI0hQiyORUx
         lJqxWGMnfN3Mnc4JGoEx/x0fVKIvzAEQwOWBc6QyAFr5y1KHPLMLj9VFivMVz8KHuZac
         Q4TIkr6UEFG4KMmgNuNn/2kh+W/tVJeY5s/wiR2Q99EmmOPUrwnskUhsvn/NrG3CDHiy
         iW8Q==
X-Gm-Message-State: AOJu0YyNXbmg+FU5vG/nyVZG9wtbF+b4Kq+Eb5hvzlYrCgXmzhISt7he
	jNYFSEi2TwymirsOu6DRxpw=
X-Google-Smtp-Source: AGHT+IHUiwJ4ZG4DMkjqafNx4wm7F0Q8nzSwPggUNmeNVcIs6wYwrOcdvB0qd0A9WcAPtrZWLM5/mw==
X-Received: by 2002:a05:6a21:3286:b0:194:503d:1ab1 with SMTP id yt6-20020a056a21328600b00194503d1ab1mr295160pzb.70.1702811402694;
        Sun, 17 Dec 2023 03:10:02 -0800 (PST)
Received: from localhost ([2404:7ac0:44a7:a6c8:e693:c4a1:1ac3:afc2])
        by smtp.gmail.com with ESMTPSA id m15-20020a17090a2c0f00b0028b43d3250csm2827375pjd.43.2023.12.17.03.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 03:10:02 -0800 (PST)
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
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v2 2/3] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
Date: Sun, 17 Dec 2023 19:09:51 +0800
Message-Id: <20231217110952.78784-3-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231217110952.78784-1-qiujingbao.dlmu@gmail.com>
References: <20231217110952.78784-1-qiujingbao.dlmu@gmail.com>
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
 drivers/rtc/rtc-cv1800.c | 400 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 407 insertions(+)
 create mode 100644 drivers/rtc/rtc-cv1800.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 3814e0845e77..bdcd9132ff1a 100644
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
index 7b03c3abfd78..69005a2b7ac6 100644
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
index 000000000000..f4c76593ef80
--- /dev/null
+++ b/drivers/rtc/rtc-cv1800.c
@@ -0,0 +1,400 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * rtc-cv1800.c: RTC driver for Sophgo cv1800 RTC
+ *
+ * Author: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
+ */
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/rtc.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+
+#define ANA_CALIB                   0x0
+#define SEC_PULSE_GEN               0x4
+#define ALARM_TIME                  0x8
+#define ALARM_ENABLE                0xC
+#define SET_SEC_CNTR_VAL            0x10
+#define SET_SEC_CNTR_TRIG           0x14
+#define SEC_CNTR_VAL                0x18
+#define APB_RDATA_SEL               0x3C
+#define POR_DB_MAGIC_KEY            0x68
+#define EN_PWR_WAKEUP               0xBC
+#define MACRO_DA_CLEAR_ALL          0x480
+#define MACRO_DA_SOC_READY          0x48C
+#define MACRO_RO_T                  0x4A8
+#define MACRO_RG_SET_T              0x498
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
+
+#define CALIB_INIT_VAL              (BIT(8) || BIT(16))
+#define CALIB_SEL_FTUNE_MASK        GENMASK(30, 0)
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
+struct cv1800_priv {
+	struct rtc_device *dev;
+	void __iomem *base_data;
+	void __iomem *base_ctrl;
+	struct clk *clk;
+	spinlock_t rtc_lock;
+	int irq;
+};
+
+static int cv1800_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct cv1800_priv *info = dev_get_drvdata(dev);
+
+	if (enabled)
+		writel(REG_ENABLE_FUN, info->base_data + ALARM_ENABLE);
+	else
+		writel(REG_DISABLE_FUN, info->base_data + ALARM_ENABLE);
+
+	return 0;
+}
+
+static int cv1800_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct cv1800_priv *info = dev_get_drvdata(dev);
+	unsigned long alarm_time;
+
+	alarm_time = rtc_tm_to_time64(&alrm->time);
+
+	if (alarm_time > SEC_MAX_VAL)
+		return -EINVAL;
+
+	writel(REG_DISABLE_FUN, info->base_data + ALARM_ENABLE);
+
+	udelay(DEALY_TIME_PREPARE);
+
+	writel(alarm_time, info->base_data + ALARM_TIME);
+	writel(REG_ENABLE_FUN, info->base_data + ALARM_ENABLE);
+
+	readl(info->base_data + SEC_CNTR_VAL);
+
+	return 0;
+}
+
+static int cv1800_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct cv1800_priv *info = dev_get_drvdata(dev);
+
+	alarm->enabled = readl(info->base_data + ALARM_ENABLE) &
+			 ALARM_ENABLE_MASK;
+
+	rtc_time64_to_tm(readl(info->base_data + ALARM_TIME), &alarm->time);
+
+	return 0;
+}
+
+static int cv1800_rtc_32k_coarse_val_calib(struct cv1800_priv *info)
+{
+	uint32_t calib_val = 0;
+	uint32_t coarse_val = 0;
+	uint32_t coarse_time_now = 0;
+	uint32_t coarse_time_next = 0;
+	uint32_t offset = CALIB_OFFSET_INIT;
+	uint32_t timeout = REG_INIT_TIMEOUT;
+	uint32_t get_val_timeout;
+	uint32_t sec_pulse_val;
+
+	writel(CALIB_INIT_VAL, info->base_data + ANA_CALIB);
+	udelay(DEALY_TIME_PREPARE);
+
+	/* Select 32K OSC tuning val source from sys */
+	sec_pulse_val = readl(info->base_data + SEC_PULSE_GEN) &
+			SEC_PULSE_GEN_SEL_MASK;
+	writel(sec_pulse_val, info->base_data + SEC_PULSE_GEN);
+
+	calib_val = readl(info->base_data + ANA_CALIB);
+
+	writel(REG_ENABLE_FUN, info->base_ctrl + FC_COARSE_EN);
+
+	while (--timeout) {
+		coarse_time_now = readl(info->base_ctrl + FC_COARSE_CAL) >>
+				  FC_COARSE_CAL_TIME_SHIFT;
+
+		get_val_timeout = REG_INIT_TIMEOUT;
+
+		while (coarse_time_next <= coarse_time_now &&
+		       --get_val_timeout) {
+			coarse_time_next =
+				readl(info->base_ctrl + FC_COARSE_CAL) >>
+				FC_COARSE_CAL_TIME_SHIFT;
+			udelay(DEALY_TIME_LOOP);
+		}
+
+		if (!get_val_timeout)
+			return -1;
+
+		udelay(DEALY_TIME_PREPARE);
+
+		coarse_val = readl(info->base_ctrl + FC_COARSE_CAL) &
+			     FC_COARSE_CAL_VAL_MASK;
+
+		if (coarse_val > CALIB_FC_COARSE_PLUS_OFFSET) {
+			calib_val += offset;
+			offset >>= CALIB_OFFSET_SHIFT;
+			writel(calib_val, info->base_data + ANA_CALIB);
+		} else if (coarse_val < CALIB_FC_COARSE_SUB_OFFSET) {
+			calib_val -= offset;
+			offset >>= CALIB_OFFSET_SHIFT;
+			writel(calib_val, info->base_data + ANA_CALIB);
+		} else {
+			writel(REG_DISABLE_FUN, info->base_ctrl + FC_COARSE_EN);
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
+static int cv1800_rtc_32k_fine_val_calib(struct cv1800_priv *info)
+{
+	uint32_t fc_val;
+	uint64_t freq = CALIB_FREQ;
+	uint32_t sec_cnt;
+	uint32_t timeout = REG_INIT_TIMEOUT;
+	uint32_t fc_time_now = 0;
+	uint32_t fc_time_next = 0;
+
+	writel(REG_ENABLE_FUN, info->base_ctrl + FC_FINE_EN);
+
+	fc_time_now = readl(info->base_ctrl + FC_FINE_CAL) >>
+		      FC_FINE_CAL_TIME_SHIFT;
+
+	while (fc_time_next <= fc_time_now && --timeout) {
+		fc_time_next = readl(info->base_ctrl + FC_FINE_CAL) >>
+			       FC_FINE_CAL_TIME_SHIFT;
+		udelay(DEALY_TIME_LOOP);
+	}
+
+	if (!timeout)
+		return -1;
+
+	fc_val = readl(info->base_ctrl + FC_FINE_CAL) & FC_FINE_CAL_VAL_MASK;
+
+	do_div(freq, CALIB_FREQ_NS);
+	freq = freq * CALIB_FRAC_EXT;
+	do_div(freq, fc_val);
+
+	sec_cnt = ((do_div(freq, CALIB_FRAC_EXT) * CALIB_FREQ_MULT) /
+			   CALIB_FRAC_EXT &
+		   SEC_PULSE_GEN_INT_MASK) +
+		  (freq << SEC_PULSE_GEN_FRAC_SHIFT);
+
+	writel(sec_cnt, info->base_data + SEC_PULSE_GEN);
+	writel(REG_DISABLE_FUN, info->base_ctrl + FC_FINE_EN);
+
+	return 0;
+}
+
+static void rtc_enable_sec_counter(struct cv1800_priv *info)
+{
+	uint32_t val;
+
+	/* select inner sec pulse and select reg set calibration val */
+	val = readl(info->base_data + SEC_PULSE_GEN) & SEC_PULSE_GEN_SEL_MASK;
+	writel(val, info->base_data + SEC_PULSE_GEN);
+
+	val = readl(info->base_data + ANA_CALIB) & CALIB_SEL_FTUNE_MASK;
+	writel(val, info->base_data + ANA_CALIB);
+
+	readl(info->base_data + SEC_CNTR_VAL);
+	writel(REG_DISABLE_FUN, info->base_data + ALARM_ENABLE);
+}
+
+static int cv1800_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct cv1800_priv *info = dev_get_drvdata(dev);
+	unsigned long sec;
+	unsigned long sec_ro_t;
+	unsigned long flag;
+
+	spin_lock_irqsave(&info->rtc_lock, flag);
+
+	sec = readl(info->base_data + SEC_CNTR_VAL);
+	sec_ro_t = readl(info->base_data + MACRO_RO_T);
+
+	if (sec_ro_t > SET_SEC_CNTR_VAL_UPDATE) {
+		sec = sec_ro_t;
+		writel(sec, info->base_data + SET_SEC_CNTR_VAL);
+		writel(REG_ENABLE_FUN, info->base_data + SET_SEC_CNTR_TRIG);
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
+	struct cv1800_priv *info = dev_get_drvdata(dev);
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
+	writel(sec, info->base_data + SET_SEC_CNTR_VAL);
+	writel(REG_ENABLE_FUN, info->base_data + SET_SEC_CNTR_TRIG);
+
+	writel(sec, info->base_data + MACRO_RG_SET_T);
+
+	spin_unlock_irqrestore(&info->rtc_lock, flag);
+
+	return 0;
+}
+
+static irqreturn_t cv1800_irq_handler(int irq, void *dev_id)
+{
+	struct device *dev = dev_id;
+	struct cv1800_priv *info = dev_get_drvdata(dev);
+	struct rtc_wkalrm alrm;
+
+	writel(REG_DISABLE_FUN, info->base_data + ALARM_ENABLE);
+
+	rtc_read_alarm(info->dev, &alrm);
+	alrm.enabled = 0;
+	rtc_set_alarm(info->dev, &alrm);
+
+	return IRQ_HANDLED;
+}
+
+static const struct rtc_class_ops cv800b_ops = {
+	.read_time = cv1800_rtc_read_time,
+	.set_time = cv1800_rtc_set_time,
+	.read_alarm = cv1800_rtc_read_alarm,
+	.set_alarm = cv1800_rtc_set_alarm,
+	.alarm_irq_enable = cv1800_rtc_alarm_irq_enable,
+};
+
+static int cv1800_rtc_probe(struct platform_device *pdev)
+{
+	struct cv1800_priv *rtc;
+	int ret;
+
+	rtc = devm_kzalloc(&pdev->dev, sizeof(struct cv1800_priv), GFP_KERNEL);
+	if (!rtc)
+		return -ENOMEM;
+
+	rtc->base_ctrl = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rtc->base_ctrl))
+		return PTR_ERR(rtc->base_ctrl);
+
+	rtc->base_data = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(rtc->base_data))
+		return PTR_ERR(rtc->base_data);
+
+	rtc->irq = platform_get_irq(pdev, 0);
+	if (rtc->irq < 0)
+		return rtc->irq;
+
+	ret = devm_request_irq(&pdev->dev, rtc->irq, cv1800_irq_handler,
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
+	spin_lock_init(&rtc->rtc_lock);
+
+	rtc->dev = devm_rtc_device_register(&pdev->dev, dev_name(&pdev->dev),
+					    &cv800b_ops, THIS_MODULE);
+	if (IS_ERR(rtc->dev))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->dev),
+				     "can't register rtc device\n");
+
+	/* if use internal clk,so coarse calibrate rtc */
+	if ((readl(rtc->base_ctrl + CTRL) & CTRL_MODE_MASK) ==
+	    CTRL_MODE_OSC32K) {
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
+	{ .compatible = "sophgo,cv1800-rtc" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, cv1800_dt_ids);
+
+static struct platform_driver cv1800_driver = {
+	.driver = {
+		.name = "cv1800-rtc",
+		.of_match_table = cv1800_dt_ids,
+	},
+	.probe = cv1800_rtc_probe,
+};
+
+module_platform_driver(cv1800_driver);
+MODULE_AUTHOR("Jingbao Qiu");
+MODULE_DESCRIPTION("Sophgo CV1800 RTC Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


