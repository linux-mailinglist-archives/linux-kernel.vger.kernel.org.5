Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D079278074E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358662AbjHRIjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358707AbjHRIi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:38:58 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA813A94
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:38:56 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4ff9abf18f9so862956e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692347934; x=1692952734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SakvWqPGx9fobEht8A7pj++O7Q0VjRY2AuuunBqxg3s=;
        b=Qjiu4+A9e8mfkqmlUr0mLXdwn9TmseGacRGI2rvvCm+EaeYWKASObQKHmi4xPkMFGo
         odkvJ6gmIByU+byCPx/YF2r0vcdRgIUmuBgWu3QzMIHzJIPi+t/Xf/q/DXfI9YaAUHAr
         bwNfdZrD8p9WCJ0C7hddvvYYq3okHW2yScTpqlty0FI3G0p7H0wL5umY0fxVINWBfvnP
         hjhwmGST/COg9+NvEx+WY6wRoR9b+7Z5idaIOYLTR3riRlEqGgAe0hbclhxswHmL//kl
         JMWUoRsAd1y4boDka6GD/eXhTtONCW0w6hupdKlEeLgfTxJ2LcksJZL2yd5mar1tyGY2
         ETEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692347934; x=1692952734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SakvWqPGx9fobEht8A7pj++O7Q0VjRY2AuuunBqxg3s=;
        b=XPqCT/J6YL5Abk4RtTovnGcMymILC0ocpYWopxEJqsYf/GstJ3RJrduomJT4amKgy8
         W3vONSxFilo/VKSIpQnO4syJRXlbTDtQmz5P0TqUgOQt+RDDqeg3sHdlCrIaDQk2XiWD
         B7idsHpXddO/R73uCPcpt9+nw5MJVF8ZJp3GWnXgXneBEJMspVbKbfdHbbhngEZ2RxyO
         0nFB93gwZkzYp8shT0O5nOqeXa6sCV34G0RmMl1Oq9wX3a0OtDSFh6fcYJWSsM2wK09L
         xQbxYl4E3GduWpJpt842Ki6aA2IMHpWHQkkkNajtVtSe1yC9jnaLc/XXVsCsBswNjgYU
         HT5g==
X-Gm-Message-State: AOJu0YzD3DZ25jAvZU/H5Hgd5RrV9GpCQ6PMSAYt8rJuC+8X+DvqmRk2
        eoIO81R53esGONfnil3xIB5n4LfXsTw=
X-Google-Smtp-Source: AGHT+IEVHKoXghcbuU89DtbEBGBq6fjiYmsLX2PD9SibDTv1njBudG4/YMoTPQ5X9hFKEwC19cM7pw==
X-Received: by 2002:a05:6512:3f0f:b0:4ff:7e04:7575 with SMTP id y15-20020a0565123f0f00b004ff7e047575mr1495842lfa.14.1692347934262;
        Fri, 18 Aug 2023 01:38:54 -0700 (PDT)
Received: from ws-565760.systec.local ([212.185.67.148])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c020500b003fbb5506e54sm2046748wmi.29.2023.08.18.01.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 01:38:54 -0700 (PDT)
From:   werneazc@gmail.com
X-Google-Original-From: andre.werner@systec-electronic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH v2 2/2] regulator: (tps65086): Select dedicated regulator config for chip variant
Date:   Fri, 18 Aug 2023 10:37:24 +0200
Message-ID: <20230818083721.29790-5-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818083721.29790-2-andre.werner@systec-electronic.com>
References: <20230818083721.29790-2-andre.werner@systec-electronic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Werner <andre.werner@systec-electronic.com>

Some configurations differ between chip variants, e,g. the register
to control the on of state of LDOA1 and SWB2. Thus, it is necessary
to choose the correct configuration for a dedicated device.
If the wrong configuration was used, the LDOA1 output that was
disabled by the bootloader was enabled in  Kernel again.

Each chip variant gets its dedicated configuration selected by
the chip ID previously collected from MFD probe function.
The VTT enum value (tps65086_regulators) is shifted because not all
chip variants have a separate SWB2 switch. Sometimes they are merged.
So the configuration possibilities differ, thus the regulator
configuration arrays have a different length.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
---
v2: Move interpretation from MFD probe to regulator probe to select the right regulator
configuration.
---
 drivers/regulator/tps65086-regulator.c | 188 +++++++++++++++++++++++--
 include/linux/mfd/tps65086.h           |   3 +
 2 files changed, 183 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/tps65086-regulator.c b/drivers/regulator/tps65086-regulator.c
index 663789198ba5..2d284c64eeb7 100644
--- a/drivers/regulator/tps65086-regulator.c
+++ b/drivers/regulator/tps65086-regulator.c
@@ -15,7 +15,15 @@
 #include <linux/mfd/tps65086.h>
 
 enum tps65086_regulators { BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6, LDOA1,
-	LDOA2, LDOA3, SWA1, SWB1, SWB2, VTT };
+	LDOA2, LDOA3, VTT, SWA1, SWB1, SWB2 };
+
+/* Selector for regulator configuration regarding PMIC chip ID. */
+enum tps65086_ids {
+	TPS6508640 = 0,
+	TPS65086401,
+	TPS6508641,
+	TPS65086470,
+};
 
 #define TPS65086_REGULATOR(_name, _of, _id, _nv, _vr, _vm, _er, _em, _lr, _dr, _dm)	\
 	[_id] = {							\
@@ -57,12 +65,24 @@ enum tps65086_regulators { BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6, LDOA1,
 		},							\
 	}
 
+
+#define TPS65086_REGULATOR_CONFIG(_chip_id, _config)			\
+	[_chip_id] = {							\
+		.config = _config,					\
+		.num_elems = ARRAY_SIZE(_config),			\
+	}
+
 struct tps65086_regulator {
 	struct regulator_desc desc;
 	unsigned int decay_reg;
 	unsigned int decay_mask;
 };
 
+struct tps65086_regulator_config {
+	struct tps65086_regulator * const config;
+	const unsigned int num_elems;
+};
+
 static const struct linear_range tps65086_10mv_ranges[] = {
 	REGULATOR_LINEAR_RANGE(0, 0x0, 0x0, 0),
 	REGULATOR_LINEAR_RANGE(410000, 0x1, 0x7F, 10000),
@@ -114,7 +134,125 @@ static int tps65086_of_parse_cb(struct device_node *dev,
 				const struct regulator_desc *desc,
 				struct regulator_config *config);
 
-static struct tps65086_regulator regulators[] = {
+static struct tps65086_regulator tps6508640_regulator_config[] = {
+	TPS65086_REGULATOR("BUCK1", "buck1", BUCK1, 0x80, TPS65086_BUCK1CTRL,
+			   BUCK_VID_MASK, TPS65086_BUCK123CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK1CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK2", "buck2", BUCK2, 0x80, TPS65086_BUCK2CTRL,
+			   BUCK_VID_MASK, TPS65086_BUCK123CTRL, BIT(1),
+			   tps65086_10mv_ranges, TPS65086_BUCK2CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK3", "buck3", BUCK3, 0x80, TPS65086_BUCK3VID,
+			   BUCK_VID_MASK, TPS65086_BUCK123CTRL, BIT(2),
+			   tps65086_10mv_ranges, TPS65086_BUCK3DECAY,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK4", "buck4", BUCK4, 0x80, TPS65086_BUCK4VID,
+			   BUCK_VID_MASK, TPS65086_BUCK4CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK4VID,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK5", "buck5", BUCK5, 0x80, TPS65086_BUCK5VID,
+			   BUCK_VID_MASK, TPS65086_BUCK5CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK5CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK6", "buck6", BUCK6, 0x80, TPS65086_BUCK6VID,
+			   BUCK_VID_MASK, TPS65086_BUCK6CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK6CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("LDOA1", "ldoa1", LDOA1, 0xF, TPS65086_LDOA1CTRL,
+			   VDOA1_VID_MASK, TPS65086_SWVTT_EN, BIT(7),
+			   tps65086_ldoa1_ranges, 0, 0),
+	TPS65086_REGULATOR("LDOA2", "ldoa2", LDOA2, 0x10, TPS65086_LDOA2VID,
+			   VDOA23_VID_MASK, TPS65086_LDOA2CTRL, BIT(0),
+			   tps65086_ldoa23_ranges, 0, 0),
+	TPS65086_REGULATOR("LDOA3", "ldoa3", LDOA3, 0x10, TPS65086_LDOA3VID,
+			   VDOA23_VID_MASK, TPS65086_LDOA3CTRL, BIT(0),
+			   tps65086_ldoa23_ranges, 0, 0),
+	TPS65086_SWITCH("VTT", "vtt", VTT, TPS65086_SWVTT_EN, BIT(4)),
+	TPS65086_SWITCH("SWA1", "swa1", SWA1, TPS65086_SWVTT_EN, BIT(5)),
+	TPS65086_SWITCH("SWB1", "swb1", SWB1, TPS65086_SWVTT_EN, BIT(6)),
+	TPS65086_SWITCH("SWB2", "swb2", SWB2, TPS65086_LDOA1CTRL, BIT(0)),
+};
+
+static struct tps65086_regulator tps65086401_regulator_config[] = {
+	TPS65086_REGULATOR("BUCK1", "buck1", BUCK1, 0x80, TPS65086_BUCK1CTRL,
+			   BUCK_VID_MASK, TPS65086_BUCK123CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK1CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK2", "buck2", BUCK2, 0x80, TPS65086_BUCK2CTRL,
+			   BUCK_VID_MASK, TPS65086_BUCK123CTRL, BIT(1),
+			   tps65086_10mv_ranges, TPS65086_BUCK2CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK3", "buck3", BUCK3, 0x80, TPS65086_BUCK3VID,
+			   BUCK_VID_MASK, TPS65086_BUCK123CTRL, BIT(2),
+			   tps65086_10mv_ranges, TPS65086_BUCK3DECAY,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK4", "buck4", BUCK4, 0x80, TPS65086_BUCK4VID,
+			   BUCK_VID_MASK, TPS65086_BUCK4CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK4VID,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK5", "buck5", BUCK5, 0x80, TPS65086_BUCK5VID,
+			   BUCK_VID_MASK, TPS65086_BUCK5CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK5CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK6", "buck6", BUCK6, 0x80, TPS65086_BUCK6VID,
+			   BUCK_VID_MASK, TPS65086_BUCK6CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK6CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("LDOA1", "ldoa1", LDOA1, 0xF, TPS65086_LDOA1CTRL,
+			   VDOA1_VID_MASK, TPS65086_SWVTT_EN, BIT(7),
+			   tps65086_ldoa1_ranges, 0, 0),
+	TPS65086_REGULATOR("LDOA2", "ldoa2", LDOA2, 0x10, TPS65086_LDOA2VID,
+			   VDOA23_VID_MASK, TPS65086_LDOA2CTRL, BIT(0),
+			   tps65086_ldoa23_ranges, 0, 0),
+	TPS65086_REGULATOR("LDOA3", "ldoa3", LDOA3, 0x10, TPS65086_LDOA3VID,
+			   VDOA23_VID_MASK, TPS65086_LDOA3CTRL, BIT(0),
+			   tps65086_ldoa23_ranges, 0, 0),
+	TPS65086_SWITCH("VTT", "vtt", VTT, TPS65086_SWVTT_EN, BIT(4)),
+	TPS65086_SWITCH("SWA1", "swa1", SWA1, TPS65086_SWVTT_EN, BIT(5)),
+	TPS65086_SWITCH("SWB1", "swb1", SWB1, TPS65086_SWVTT_EN, BIT(6)),
+};
+
+static struct tps65086_regulator tps6508641_regulator_config[] = {
+	TPS65086_REGULATOR("BUCK1", "buck1", BUCK1, 0x80, TPS65086_BUCK1CTRL,
+			   BUCK_VID_MASK, TPS65086_BUCK123CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK1CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK2", "buck2", BUCK2, 0x80, TPS65086_BUCK2CTRL,
+			   BUCK_VID_MASK, TPS65086_BUCK123CTRL, BIT(1),
+			   tps65086_10mv_ranges, TPS65086_BUCK2CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK3", "buck3", BUCK3, 0x80, TPS65086_BUCK3VID,
+			   BUCK_VID_MASK, TPS65086_BUCK123CTRL, BIT(2),
+			   tps65086_10mv_ranges, TPS65086_BUCK3DECAY,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK4", "buck4", BUCK4, 0x80, TPS65086_BUCK4VID,
+			   BUCK_VID_MASK, TPS65086_BUCK4CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK4VID,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK5", "buck5", BUCK5, 0x80, TPS65086_BUCK5VID,
+			   BUCK_VID_MASK, TPS65086_BUCK5CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK5CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("BUCK6", "buck6", BUCK6, 0x80, TPS65086_BUCK6VID,
+			   BUCK_VID_MASK, TPS65086_BUCK6CTRL, BIT(0),
+			   tps65086_10mv_ranges, TPS65086_BUCK6CTRL,
+			   BIT(0)),
+	TPS65086_REGULATOR("LDOA1", "ldoa1", LDOA1, 0xF, TPS65086_LDOA1CTRL,
+			   VDOA1_VID_MASK, TPS65086_SWVTT_EN, BIT(7),
+			   tps65086_ldoa1_ranges, 0, 0),
+	TPS65086_REGULATOR("LDOA2", "ldoa2", LDOA2, 0x10, TPS65086_LDOA2VID,
+			   VDOA23_VID_MASK, TPS65086_LDOA2CTRL, BIT(0),
+			   tps65086_ldoa23_ranges, 0, 0),
+	TPS65086_REGULATOR("LDOA3", "ldoa3", LDOA3, 0x10, TPS65086_LDOA3VID,
+			   VDOA23_VID_MASK, TPS65086_LDOA3CTRL, BIT(0),
+			   tps65086_ldoa23_ranges, 0, 0),
+	TPS65086_SWITCH("VTT", "vtt", VTT, TPS65086_SWVTT_EN, BIT(4)),
+	TPS65086_SWITCH("SWA1", "swa1", SWA1, TPS65086_SWVTT_EN, BIT(5)),
+	TPS65086_SWITCH("SWB1", "swb1", SWB1, TPS65086_SWVTT_EN, BIT(6)),
+};
+
+static struct tps65086_regulator tps65086470_regulator_config[] = {
 	TPS65086_REGULATOR("BUCK1", "buck1", BUCK1, 0x80, TPS65086_BUCK1CTRL,
 			   BUCK_VID_MASK, TPS65086_BUCK123CTRL, BIT(0),
 			   tps65086_10mv_ranges, TPS65086_BUCK1CTRL,
@@ -148,16 +286,25 @@ static struct tps65086_regulator regulators[] = {
 	TPS65086_REGULATOR("LDOA3", "ldoa3", LDOA3, 0x10, TPS65086_LDOA3VID,
 			   VDOA23_VID_MASK, TPS65086_LDOA3CTRL, BIT(0),
 			   tps65086_ldoa23_ranges, 0, 0),
+	TPS65086_SWITCH("VTT", "vtt", VTT, TPS65086_SWVTT_EN, BIT(4)),
 	TPS65086_SWITCH("SWA1", "swa1", SWA1, TPS65086_SWVTT_EN, BIT(5)),
 	TPS65086_SWITCH("SWB1", "swb1", SWB1, TPS65086_SWVTT_EN, BIT(6)),
 	TPS65086_SWITCH("SWB2", "swb2", SWB2, TPS65086_SWVTT_EN, BIT(7)),
-	TPS65086_SWITCH("VTT", "vtt", VTT, TPS65086_SWVTT_EN, BIT(4)),
+};
+
+static const struct tps65086_regulator_config regulator_configs[] = {
+	TPS65086_REGULATOR_CONFIG(TPS6508640, tps6508640_regulator_config),
+	TPS65086_REGULATOR_CONFIG(TPS65086401, tps65086401_regulator_config),
+	TPS65086_REGULATOR_CONFIG(TPS6508641, tps6508641_regulator_config),
+	TPS65086_REGULATOR_CONFIG(TPS65086470, tps65086470_regulator_config)
 };
 
 static int tps65086_of_parse_cb(struct device_node *node,
 				const struct regulator_desc *desc,
 				struct regulator_config *config)
 {
+	struct tps65086 * const tps = dev_get_drvdata(config->dev);
+	struct tps65086_regulator *regulators = tps->reg_config->config;
 	int ret;
 
 	/* Check for 25mV step mode */
@@ -203,9 +350,30 @@ static int tps65086_regulator_probe(struct platform_device *pdev)
 {
 	struct tps65086 *tps = dev_get_drvdata(pdev->dev.parent);
 	struct regulator_config config = { };
+	unsigned int selector_reg_config;
 	struct regulator_dev *rdev;
 	int i;
 
+	/* Select regulator configuration for used PMIC device */
+	switch (tps->chip_id) {
+	case TPS6508640_ID:
+		selector_reg_config = TPS6508640;
+		break;
+	case TPS65086401_ID:
+		selector_reg_config = TPS65086401;
+		break;
+	case TPS6508641_ID:
+		selector_reg_config = TPS6508641;
+		break;
+	case TPS65086470_ID:
+		selector_reg_config = TPS65086470;
+		break;
+	default:
+		dev_err(tps->dev, "Unknown device ID. Cannot determine regulator config.\n");
+		return -ENODEV;
+	}
+	tps->reg_config = &regulator_configs[selector_reg_config];
+
 	platform_set_drvdata(pdev, tps);
 
 	config.dev = &pdev->dev;
@@ -213,12 +381,16 @@ static int tps65086_regulator_probe(struct platform_device *pdev)
 	config.driver_data = tps;
 	config.regmap = tps->regmap;
 
-	for (i = 0; i < ARRAY_SIZE(regulators); i++) {
-		rdev = devm_regulator_register(&pdev->dev, &regulators[i].desc,
-					       &config);
+	for (i = 0; i < tps->reg_config->num_elems; ++i) {
+		struct regulator_desc * const desc_ptr = &tps->reg_config->config[i].desc;
+
+		dev_dbg(tps->dev, "Index: %u; Regulator name: \"%s\"; Regulator ID: %d\n",
+			i, desc_ptr->name, desc_ptr->id);
+
+		rdev = devm_regulator_register(&pdev->dev, desc_ptr, &config);
 		if (IS_ERR(rdev)) {
-			dev_err(tps->dev, "failed to register %s regulator\n",
-				pdev->name);
+			dev_err(tps->dev, "failed to register %d \"%s\" regulator\n",
+				i, desc_ptr->name);
 			return PTR_ERR(rdev);
 		}
 	}
diff --git a/include/linux/mfd/tps65086.h b/include/linux/mfd/tps65086.h
index 87e590de6ca5..9185b5cd8371 100644
--- a/include/linux/mfd/tps65086.h
+++ b/include/linux/mfd/tps65086.h
@@ -99,6 +99,8 @@ enum tps65086_irqs {
 	TPS65086_IRQ_FAULT,
 };
 
+struct tps65086_regulator_config;
+
 /**
  * struct tps65086 - state holder for the tps65086 driver
  *
@@ -108,6 +110,7 @@ struct tps65086 {
 	struct device *dev;
 	struct regmap *regmap;
 	unsigned int chip_id;
+	const struct tps65086_regulator_config *reg_config;
 
 	/* IRQ Data */
 	int irq;
-- 
2.41.0

