Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6177176B1C2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjHAK1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjHAK0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:26:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443AA2700
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:25:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3178dd81ac4so3987531f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 03:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1690885512; x=1691490312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yfm4ST9M/aYY+GAoGsq3y3woTtO8emAzJ31sBEpbtvc=;
        b=KWO1VcEBNmlJc5Q+as18igJ+Uf9M7IQqlDJiQDqV6R6GkoREyWGu20+Kh3FtywH28Q
         aLyqPM/AZUlmWC5iQR7H3DG2vjPe2xtsswq3fvHhQZK+CSm4qmK9Sst+hSKevlj915iX
         Q/2PPm3BO+OC/K7cbSa4p3ORSaolUdz4glq5bee6P26d6UuSdC8YuuYCThzDSaqquI0I
         wCQKfmH1cfWLsuJWq3resBuzPDCov1ukBFjDibDb13AtBo2jU6CT20XLt0cgxBLQpmu4
         q2v8lisb3l5QRGAteDKa+iDG6B0POS4HU/uUm3V4meaF7/F3Q/PrgmdMRqZxYawhi+2D
         FaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690885512; x=1691490312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yfm4ST9M/aYY+GAoGsq3y3woTtO8emAzJ31sBEpbtvc=;
        b=EQ+towL2h+pVQa4JyuQ8hHqMHW2hip6BhuaIk2m/imQhWcMno5lYULv63kfA7gdRa4
         Fje80xUKDndJCKcon0VnzpIy3mnFRDiino79TdO7495hHbRsWJfjLVDi5Eh06U21vDzi
         et1W2pdKKY+Pc80Phlksw6eD3TQCX67oCuHdjzqfXIDIqU58a0ssHXF5PjLSmHgfJA/p
         hQKGpMPBK5wLEEAN2LiVTzj+23TLucRBr5gGvVK6+39O4yvKqNAODk1Mc/7I/gTtAaPD
         qhUCbivBiZ3ScolPVgjIv45AUZO1dtcFE9myuD6y8DdD44cB3pWvmNnG7P+3RAgpzb9R
         q1Sg==
X-Gm-Message-State: ABy/qLbtecoHTP6bijjwL3j5ryURw+PgW+kCosGrj+dBCqIBYGJJO5ST
        u2HunxHNdaDhn4Su7i32mQ+RDw==
X-Google-Smtp-Source: APBJJlElbkK3gk86uOg2sift4l18SRzhsl7wMNRLpo+sVR4ZdpMY0w44c3MRZRZlwHBBNiqvK1rkzA==
X-Received: by 2002:a5d:591b:0:b0:317:71a6:f408 with SMTP id v27-20020a5d591b000000b0031771a6f408mr2172903wrd.67.1690885511677;
        Tue, 01 Aug 2023 03:25:11 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id i8-20020adfefc8000000b0030ada01ca78sm15713678wrp.10.2023.08.01.03.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 03:25:11 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee@kernel.org>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: max5970: Rename driver and remove wildcard
Date:   Tue,  1 Aug 2023 12:24:52 +0200
Message-ID: <20230801102453.1798292-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous version of this driver included wildcards in file names and
descriptions. This patch renames the driver to only support MAX5970 and
MAX5978, which are the only chips that the driver actually supports.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/regulator/Kconfig                     |  6 ++--
 drivers/regulator/Makefile                    |  2 +-
 ...ax597x-regulator.c => max5970-regulator.c} | 28 +++++++++----------
 3 files changed, 18 insertions(+), 18 deletions(-)
 rename drivers/regulator/{max597x-regulator.c => max5970-regulator.c} (94%)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 94f44736473e..a5c9de1cab2b 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -546,11 +546,11 @@ config REGULATOR_MAX1586
 	  regulator via I2C bus. The provided regulator is suitable
 	  for PXA27x chips to control VCC_CORE and VCC_USIM voltages.
 
-config REGULATOR_MAX597X
-	tristate "Maxim 597x power switch and monitor"
+config REGULATOR_MAX5970
+	tristate "Maxim 5970/5978 power switch and monitor"
 	depends on I2C
 	depends on OF
-	depends on MFD_MAX597X
+	depends on MFD_MAX5970
 	help
 	  This driver controls a Maxim 5970/5978 switch via I2C bus.
 	  The MAX5970/5978 is a smart switch with no output regulation, but
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 77b22bdd2791..453289cdd444 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -67,7 +67,7 @@ obj-$(CONFIG_REGULATOR_LTC3589) += ltc3589.o
 obj-$(CONFIG_REGULATOR_LTC3676) += ltc3676.o
 obj-$(CONFIG_REGULATOR_MAX14577) += max14577-regulator.o
 obj-$(CONFIG_REGULATOR_MAX1586) += max1586.o
-obj-$(CONFIG_REGULATOR_MAX597X) += max597x-regulator.o
+obj-$(CONFIG_REGULATOR_MAX5970) += max5970-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77541) += max77541-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77620) += max77620-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77650) += max77650-regulator.o
diff --git a/drivers/regulator/max597x-regulator.c b/drivers/regulator/max5970-regulator.c
similarity index 94%
rename from drivers/regulator/max597x-regulator.c
rename to drivers/regulator/max5970-regulator.c
index 7873a5267555..b56a174cde3d 100644
--- a/drivers/regulator/max597x-regulator.c
+++ b/drivers/regulator/max5970-regulator.c
@@ -20,9 +20,9 @@
 #include <linux/regulator/of_regulator.h>
 #include <linux/platform_device.h>
 
-#include <linux/mfd/max597x.h>
+#include <linux/mfd/max5970.h>
 
-struct max597x_regulator {
+struct max5970_regulator {
 	int num_switches, mon_rng, irng, shunt_micro_ohms, lim_uA;
 	struct regmap *regmap;
 };
@@ -58,7 +58,7 @@ static int max597x_set_vp(struct regulator_dev *rdev, int lim_uV, int severity,
 			  bool enable, bool overvoltage)
 {
 	int off_h, off_l, reg, ret;
-	struct max597x_regulator *data = rdev_get_drvdata(rdev);
+	struct max5970_regulator *data = rdev_get_drvdata(rdev);
 	int channel = rdev_get_id(rdev);
 
 	if (overvoltage) {
@@ -140,7 +140,7 @@ static int max597x_set_ocp(struct regulator_dev *rdev, int lim_uA,
 	int val, reg;
 	unsigned int vthst, vthfst;
 
-	struct max597x_regulator *data = rdev_get_drvdata(rdev);
+	struct max5970_regulator *data = rdev_get_drvdata(rdev);
 	int rdev_id = rdev_get_id(rdev);
 	/*
 	 * MAX5970 doesn't has enable control for ocp.
@@ -222,7 +222,7 @@ static int max597x_dt_parse(struct device_node *np,
 			    const struct regulator_desc *desc,
 			    struct regulator_config *cfg)
 {
-	struct max597x_regulator *data = cfg->driver_data;
+	struct max5970_regulator *data = cfg->driver_data;
 	int ret = 0;
 
 	ret =
@@ -274,7 +274,7 @@ static int max597x_irq_handler(int irq, struct regulator_irq_data *rid,
 			       unsigned long *dev_mask)
 {
 	struct regulator_err_state *stat;
-	struct max597x_regulator *d = (struct max597x_regulator *)rid->data;
+	struct max5970_regulator *d = (struct max5970_regulator *)rid->data;
 	int val, ret, i;
 
 	ret = max597x_regmap_read_clear(d->regmap, MAX5970_REG_FAULT0, &val);
@@ -394,7 +394,7 @@ static int max597x_adc_range(struct regmap *regmap, const int ch,
 static int max597x_setup_irq(struct device *dev,
 			     int irq,
 			     struct regulator_dev *rdevs[MAX5970_NUM_SWITCHES],
-			     int num_switches, struct max597x_regulator *data)
+			     int num_switches, struct max5970_regulator *data)
 {
 	struct regulator_irq_desc max597x_notif = {
 		.name = "max597x-irq",
@@ -425,9 +425,9 @@ static int max597x_setup_irq(struct device *dev,
 
 static int max597x_regulator_probe(struct platform_device *pdev)
 {
-	struct max597x_data *max597x;
+	struct max5970_data *max597x;
 	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	struct max597x_regulator *data;
+	struct max5970_regulator *data;
 	struct i2c_client *i2c = to_i2c_client(pdev->dev.parent);
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
@@ -438,16 +438,16 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 	if (!regmap)
 		return -EPROBE_DEFER;
 
-	max597x = devm_kzalloc(&i2c->dev, sizeof(struct max597x_data), GFP_KERNEL);
+	max597x = devm_kzalloc(&i2c->dev, sizeof(struct max5970_data), GFP_KERNEL);
 	if (!max597x)
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, max597x);
 
 	if (of_device_is_compatible(i2c->dev.of_node, "maxim,max5978"))
-		max597x->num_switches = MAX597x_TYPE_MAX5978;
+		max597x->num_switches = MAX5978_NUM_SWITCHES;
 	else if (of_device_is_compatible(i2c->dev.of_node, "maxim,max5970"))
-		max597x->num_switches = MAX597x_TYPE_MAX5970;
+		max597x->num_switches = MAX5970_NUM_SWITCHES;
 	else
 		return -ENODEV;
 
@@ -456,7 +456,7 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 
 	for (i = 0; i < num_switches; i++) {
 		data =
-		    devm_kzalloc(&i2c->dev, sizeof(struct max597x_regulator),
+		    devm_kzalloc(&i2c->dev, sizeof(struct max5970_regulator),
 				 GFP_KERNEL);
 		if (!data)
 			return -ENOMEM;
@@ -500,7 +500,7 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 
 static struct platform_driver max597x_regulator_driver = {
 	.driver = {
-		.name = "max597x-regulator",
+		.name = "max5970-regulator",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = max597x_regulator_probe,

base-commit: 1519454ab7686d3902ae65aef422c3c662b5944a
-- 
2.41.0

