Return-Path: <linux-kernel+bounces-14032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6723582172F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D2D1C2119C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F08D271;
	Tue,  2 Jan 2024 05:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kiVbE9zz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7270111C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 05:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e80d40a41so6605732e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 21:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704172651; x=1704777451; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9nrqlUma9bMibDMJHZraf4OOUJWsIotShYoRs7Id3Q=;
        b=kiVbE9zzhFrDFqnWJBhqLYfPt+Qspu/ZnNwgIeRixw5Se8GVaUQulpwxkHlmsTmIIE
         6bWRkLbZPgnzT6cWOgXeSR9fXwoqbMLRCRfvkd+ugXEwh0Bhd3LaX6DsiEh1v0aJ4hLf
         iJKVMQ5AuBoUTPYQPHwPhKeCb29AVAthaSIKwzxse9lQHmQv93BAJCoNuQOKxRoq6wa3
         m2kTD8ATXXdrA9hZmeZeBXYcoyYoaGRw7tc+3AQ4mXlJILaPV5kCM0dSCqPGGWVvR/GH
         k6wsYbJkjCq0C8UqJtA2AkrYqhA51cwOfbg+7JMJn56ZOacuO8lNIGRQRW7WwwkRRWvU
         prhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704172651; x=1704777451;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9nrqlUma9bMibDMJHZraf4OOUJWsIotShYoRs7Id3Q=;
        b=rbnDcpFXNWHXbbjHhFBkj2ctgDCZXBNqQwZt5xRu0YUnS//rPHBLmboi25FlGdIn6M
         En5fqGdjV7OEG4N2EMVEkVK11YmXjcylKXnVM0umblUEhWIhmAY5umi6TRTacLBfGbFI
         qYR1QelMRRl320uuNL+/xA9nTCa4fM0s/it8aTve8M9e1xJYn3f0u90sVXx3kZJzCCbR
         pcCygqL7cuUZNpN/jo30mu9//0Xjs8zhGBhnRCruMkWamxSLn+1OqAQ3W7d2LmY/06ch
         4hK7vkckeP/xNhMT7JCnHFp8MgRxryruaTVphBKRKWkrJdSVu0z7jeJF2j/IWAzVWkRV
         g5sw==
X-Gm-Message-State: AOJu0YywD+QGm4EmjiCqRlA9AdoZNSpXUN8QEzWLOdpNbzDOmWCMwsiW
	Q2Yu9B/FAA8xixSGpx7dJkITeZ8ux0Bnig==
X-Google-Smtp-Source: AGHT+IFwlBks49W22mQeqMFXOQs2/12sJCO0VdnP1NGhguGPZr2WwBKVFRQyC0Hppmkko+YqJ6WUUQ==
X-Received: by 2002:a05:6512:3b28:b0:50e:7f88:d34e with SMTP id f40-20020a0565123b2800b0050e7f88d34emr6110260lfv.33.1704172651070;
        Mon, 01 Jan 2024 21:17:31 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id r25-20020ac252b9000000b0050e810689e5sm2081827lfm.33.2024.01.01.21.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 21:17:30 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 02 Jan 2024 07:17:25 +0200
Subject: [PATCH v7 05/22] soc: qcom: spm: add support for voltage regulator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-saw2-spm-regulator-v7-5-0472ec237f49@linaro.org>
References: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
In-Reply-To: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=9725;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=kw0nF1B4E0+psReswT0aVUw4ujS4UEg+s5VY+LVJvIk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlk5xjVWklIoGiqKnan1HprwEDufSvyZVRuNKZU
 Wb4faY02TmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZZOcYwAKCRCLPIo+Aiko
 1eEvB/0aB4h/5PfR0W89IB8U3whoCkFWnzqvMyZeamHa5Q1bZZ/TfEC83V/fFiVpe4P1lMWD7pS
 SRBvmUWNvDOBjAkF1kVEV0BPVHobDbvcHaPwaiwaLw7wEB8Ex6Ce184S9hpQXd6sbRpF3hJrGol
 iZt2B5mSQXPywabwxyc2tpzDhu+NU4BB4Re7+AQ7ESnmqR5FZr5dGerf4HSvuTEdEXV5p+d8Q42
 t8eYwv0D3tEkvR3E9PgEI2fMs5yGDlh3+jzutmuWMz6Xo32b6hmC0YiGsa3Ph8ubhJRJQc93Bmc
 YSH6DZrzzU4OzzJExUtk4XGqoJSPhzsZKvUMisyx+Nv79rlC
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The SPM / SAW2 device also provides a voltage regulator functionality
with optional AVS (Adaptive Voltage Scaling) support. The exact register
sequence and voltage ranges differs from device to device.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/soc/qcom/spm.c | 234 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 229 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index b15435f7cb0d..5eefaec72a13 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -6,20 +6,40 @@
  * SAW power controller driver
  */
 
-#include <linux/kernel.h>
+#include <linux/bitfield.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/linear_range.h>
 #include <linux/module.h>
-#include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/err.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+
+#include <linux/regulator/driver.h>
+
 #include <soc/qcom/spm.h>
 
+#define FIELD_SET(current, mask, val)	\
+	(((current) & ~(mask)) | FIELD_PREP((mask), (val)))
+
 #define SPM_CTL_INDEX		0x7f
 #define SPM_CTL_INDEX_SHIFT	4
 #define SPM_CTL_EN		BIT(0)
 
+/* These registers might be specific to SPM 1.1 */
+#define SPM_VCTL_VLVL			GENMASK(7, 0)
+#define SPM_PMIC_DATA_0_VLVL		GENMASK(7, 0)
+#define SPM_PMIC_DATA_1_MIN_VSEL	GENMASK(5, 0)
+#define SPM_PMIC_DATA_1_MAX_VSEL	GENMASK(21, 16)
+
+#define SPM_1_1_AVS_CTL_AVS_ENABLED	BIT(27)
+#define SPM_AVS_CTL_MAX_VLVL		GENMASK(22, 17)
+#define SPM_AVS_CTL_MIN_VLVL		GENMASK(15, 10)
+
 enum spm_reg {
 	SPM_REG_CFG,
 	SPM_REG_SPM_CTL,
@@ -29,10 +49,12 @@ enum spm_reg {
 	SPM_REG_PMIC_DATA_1,
 	SPM_REG_VCTL,
 	SPM_REG_SEQ_ENTRY,
-	SPM_REG_SPM_STS,
+	SPM_REG_STS0,
+	SPM_REG_STS1,
 	SPM_REG_PMIC_STS,
 	SPM_REG_AVS_CTL,
 	SPM_REG_AVS_LIMIT,
+	SPM_REG_RST,
 	SPM_REG_NR,
 };
 
@@ -49,11 +71,20 @@ struct spm_reg_data {
 	u32 avs_limit;
 	u8 seq[MAX_SEQ_DATA];
 	u8 start_index[PM_SLEEP_MODE_NR];
+
+	smp_call_func_t set_vdd;
+	/* for now we support only a single range */
+	struct linear_range *range;
+	unsigned int ramp_delay;
+	unsigned int init_uV;
 };
 
 struct spm_driver_data {
 	void __iomem *reg_base;
 	const struct spm_reg_data *reg_data;
+	struct device *dev;
+	unsigned int volt_sel;
+	int reg_cpu;
 };
 
 static const u16 spm_reg_offset_v4_1[SPM_REG_NR] = {
@@ -189,6 +220,10 @@ static const struct spm_reg_data spm_reg_8226_cpu  = {
 
 static const u16 spm_reg_offset_v1_1[SPM_REG_NR] = {
 	[SPM_REG_CFG]		= 0x08,
+	[SPM_REG_STS0]		= 0x0c,
+	[SPM_REG_STS1]		= 0x10,
+	[SPM_REG_VCTL]		= 0x14,
+	[SPM_REG_AVS_CTL]	= 0x18,
 	[SPM_REG_SPM_CTL]	= 0x20,
 	[SPM_REG_PMIC_DLY]	= 0x24,
 	[SPM_REG_PMIC_DATA_0]	= 0x28,
@@ -196,7 +231,12 @@ static const u16 spm_reg_offset_v1_1[SPM_REG_NR] = {
 	[SPM_REG_SEQ_ENTRY]	= 0x80,
 };
 
+static void smp_set_vdd_v1_1(void *data);
+
 /* SPM register data for 8064 */
+static struct linear_range spm_v1_1_regulator_range =
+	REGULATOR_LINEAR_RANGE(700000, 0, 56, 12500);
+
 static const struct spm_reg_data spm_reg_8064_cpu = {
 	.reg_offset = spm_reg_offset_v1_1,
 	.spm_cfg = 0x1F,
@@ -207,6 +247,10 @@ static const struct spm_reg_data spm_reg_8064_cpu = {
 		0x10, 0x54, 0x30, 0x0C, 0x24, 0x30, 0x0F },
 	.start_index[PM_SLEEP_MODE_STBY] = 0,
 	.start_index[PM_SLEEP_MODE_SPC] = 2,
+	.set_vdd = smp_set_vdd_v1_1,
+	.range = &spm_v1_1_regulator_range,
+	.init_uV = 1300000,
+	.ramp_delay = 1250,
 };
 
 static inline void spm_register_write(struct spm_driver_data *drv,
@@ -258,6 +302,185 @@ void spm_set_low_power_mode(struct spm_driver_data *drv,
 	spm_register_write_sync(drv, SPM_REG_SPM_CTL, ctl_val);
 }
 
+static int spm_set_voltage_sel(struct regulator_dev *rdev, unsigned int selector)
+{
+	struct spm_driver_data *drv = rdev_get_drvdata(rdev);
+
+	drv->volt_sel = selector;
+
+	/* Always do the SAW register writes on the corresponding CPU */
+	return smp_call_function_single(drv->reg_cpu, drv->reg_data->set_vdd, drv, true);
+}
+
+static int spm_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct spm_driver_data *drv = rdev_get_drvdata(rdev);
+
+	return drv->volt_sel;
+}
+
+static const struct regulator_ops spm_reg_ops = {
+	.set_voltage_sel	= spm_set_voltage_sel,
+	.get_voltage_sel	= spm_get_voltage_sel,
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
+};
+
+static void smp_set_vdd_v1_1(void *data)
+{
+	struct spm_driver_data *drv = data;
+	unsigned int vctl, data0, data1, avs_ctl, sts;
+	unsigned int vlevel, volt_sel;
+	bool avs_enabled;
+
+	volt_sel = drv->volt_sel;
+	vlevel = volt_sel | 0x80; /* band */
+
+	avs_ctl = spm_register_read(drv, SPM_REG_AVS_CTL);
+	vctl = spm_register_read(drv, SPM_REG_VCTL);
+	data0 = spm_register_read(drv, SPM_REG_PMIC_DATA_0);
+	data1 = spm_register_read(drv, SPM_REG_PMIC_DATA_1);
+
+	avs_enabled = avs_ctl & SPM_1_1_AVS_CTL_AVS_ENABLED;
+
+	/* If AVS is enabled, switch it off during the voltage change */
+	if (avs_enabled) {
+		avs_ctl &= ~SPM_1_1_AVS_CTL_AVS_ENABLED;
+		spm_register_write(drv, SPM_REG_AVS_CTL, avs_ctl);
+	}
+
+	/* Kick the state machine back to idle */
+	spm_register_write(drv, SPM_REG_RST, 1);
+
+	vctl = FIELD_SET(vctl, SPM_VCTL_VLVL, vlevel);
+	data0 = FIELD_SET(data0, SPM_PMIC_DATA_0_VLVL, vlevel);
+	data1 = FIELD_SET(data1, SPM_PMIC_DATA_1_MIN_VSEL, volt_sel);
+	data1 = FIELD_SET(data1, SPM_PMIC_DATA_1_MAX_VSEL, volt_sel);
+
+	spm_register_write(drv, SPM_REG_VCTL, vctl);
+	spm_register_write(drv, SPM_REG_PMIC_DATA_0, data0);
+	spm_register_write(drv, SPM_REG_PMIC_DATA_1, data1);
+
+	if (read_poll_timeout_atomic(spm_register_read,
+				     sts, sts == vlevel,
+				     1, 200, false,
+				     drv, SPM_REG_STS1)) {
+		dev_err_ratelimited(drv->dev, "timeout setting the voltage (%x %x)!\n", sts, vlevel);
+		goto enable_avs;
+	}
+
+	if (avs_enabled) {
+		unsigned int max_avs = volt_sel;
+		unsigned int min_avs = max(max_avs, 4U) - 4;
+
+		avs_ctl = FIELD_SET(avs_ctl, SPM_AVS_CTL_MIN_VLVL, min_avs);
+		avs_ctl = FIELD_SET(avs_ctl, SPM_AVS_CTL_MAX_VLVL, max_avs);
+		spm_register_write(drv, SPM_REG_AVS_CTL, avs_ctl);
+	}
+
+enable_avs:
+	if (avs_enabled) {
+		avs_ctl |= SPM_1_1_AVS_CTL_AVS_ENABLED;
+		spm_register_write(drv, SPM_REG_AVS_CTL, avs_ctl);
+	}
+}
+
+static int spm_get_cpu(struct device *dev)
+{
+	int cpu;
+	bool found;
+
+	for_each_possible_cpu(cpu) {
+		struct device_node *cpu_node, *saw_node;
+
+		cpu_node = of_cpu_device_node_get(cpu);
+		if (!cpu_node)
+			continue;
+
+		saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
+		found = (saw_node == dev->of_node);
+		of_node_put(saw_node);
+		of_node_put(cpu_node);
+
+		if (found)
+			return cpu;
+	}
+
+	/* L2 SPM is not bound to any CPU, voltage setting is not supported */
+
+	return -EOPNOTSUPP;
+}
+
+#ifdef CONFIG_REGULATOR
+static int spm_register_regulator(struct device *dev, struct spm_driver_data *drv)
+{
+	struct regulator_config config = {
+		.dev = dev,
+		.driver_data = drv,
+	};
+	struct regulator_desc *rdesc;
+	struct regulator_dev *rdev;
+	int ret;
+	bool found;
+
+	if (!drv->reg_data->set_vdd)
+		return 0;
+
+	rdesc = devm_kzalloc(dev, sizeof(*rdesc), GFP_KERNEL);
+	if (!rdesc)
+		return -ENOMEM;
+
+	rdesc->name = "spm";
+	rdesc->of_match = of_match_ptr("regulator");
+	rdesc->type = REGULATOR_VOLTAGE;
+	rdesc->owner = THIS_MODULE;
+	rdesc->ops = &spm_reg_ops;
+
+	rdesc->linear_ranges = drv->reg_data->range;
+	rdesc->n_linear_ranges = 1;
+	rdesc->n_voltages = rdesc->linear_ranges[rdesc->n_linear_ranges - 1].max_sel + 1;
+	rdesc->ramp_delay = drv->reg_data->ramp_delay;
+
+	ret = spm_get_cpu(dev);
+	if (ret < 0)
+		return ret;
+
+	drv->reg_cpu = ret;
+	dev_dbg(dev, "SAW2 bound to CPU %d\n", drv->reg_cpu);
+
+	/*
+	 * Program initial voltage, otherwise registration will also try
+	 * setting the voltage, which might result in undervolting the CPU.
+	 */
+	drv->volt_sel = DIV_ROUND_UP(drv->reg_data->init_uV - rdesc->min_uV,
+				     rdesc->uV_step);
+	ret = linear_range_get_selector_high(drv->reg_data->range,
+					     drv->reg_data->init_uV,
+					     &drv->volt_sel,
+					     &found);
+	if (ret) {
+		dev_err(dev, "Initial uV value out of bounds\n");
+		return ret;
+	}
+
+	/* Always do the SAW register writes on the corresponding CPU */
+	smp_call_function_single(drv->reg_cpu, drv->reg_data->set_vdd, drv, true);
+
+	rdev = devm_regulator_register(dev, rdesc, &config);
+	if (IS_ERR(rdev)) {
+		dev_err(dev, "failed to register regulator\n");
+		return PTR_ERR(rdev);
+	}
+
+	return 0;
+}
+#else
+static int spm_register_regulator(struct device *dev, struct spm_driver_data *drv)
+{
+	return 0;
+}
+#endif
+
 static const struct of_device_id spm_match_table[] = {
 	{ .compatible = "qcom,sdm660-gold-saw2-v4.1-l2",
 	  .data = &spm_reg_660_gold_l2 },
@@ -308,6 +531,7 @@ static int spm_dev_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	drv->reg_data = match_id->data;
+	drv->dev = &pdev->dev;
 	platform_set_drvdata(pdev, drv);
 
 	/* Write the SPM sequences first.. */
@@ -335,7 +559,7 @@ static int spm_dev_probe(struct platform_device *pdev)
 	if (drv->reg_data->reg_offset[SPM_REG_SPM_CTL])
 		spm_set_low_power_mode(drv, PM_SLEEP_MODE_STBY);
 
-	return 0;
+	return spm_register_regulator(&pdev->dev, drv);
 }
 
 static struct platform_driver spm_driver = {

-- 
2.39.2


