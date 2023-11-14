Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A7C7EB750
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjKNUHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbjKNUGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:06:49 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4F3124;
        Tue, 14 Nov 2023 12:06:40 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507ad511315so8678546e87.0;
        Tue, 14 Nov 2023 12:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699992398; x=1700597198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzxakurDFhuOGXvo9vBEbL3SYK0M5/oRNZ8JnfWuaeI=;
        b=kHYNKJ0NNj7JKW4mX+xqeLKIK0uKAMJWwdTRRW9u/zSLEPfPZ3SlNVW1DOfw9IC3Qy
         2XgrRGQVSqIPUMKIwSdyvFtIoOQ4/aTezPzfTbH2dontSOF1d9q3lD33/u2dBgRBgjzJ
         TmW+7ZBQRm/fndTmQPaQQ93WPlPDUOfifQlmV/lVZ0PH9sQQrlm1wW/riOCcbOdYjSSH
         I4ieof5y0XkKjtAk8F7fIPPKnFGwlrgbfNVlwIQApGcJ7OIDhOv9kaPPdrcgEtPdilyB
         AIFEsKATbygqaPnQZM/G6tbmtWGVoSU1L5tXqXhV1W/mgFQWs5LUsBhDJqpKa3hpdfgh
         QXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699992398; x=1700597198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzxakurDFhuOGXvo9vBEbL3SYK0M5/oRNZ8JnfWuaeI=;
        b=svSw0n/WIbBKGnBPTAHKmOe3glRLieNYkCJ64SK9U2vORlanhZ9zDEqPqfuBv1AMlC
         5yc9Zf4qPB+t1lM2ZwhIcFVEmnK4vpW1AeGzbh0U8MbR23k038W8iyf+4mZLoNAlBgnl
         uP3zfeVqRqyL7TaCHmm88jKV8qJQkQW2YeyBdCGMva/hHGeBvi9LWEL3lrZIs32RGsfp
         wMao6cr1t02K1wOvQhLkgnR0ZvmV2Z9VkEt+523CKnHk4nSJaLNoQaqhBUU00mMK9CAy
         9LXPBUVhoOjEQrzYZQlPpyuuZUcWIu9T4dadoH5a+yt5yyxU7qOB/sFtb6+Fq5gZy6xp
         4PzQ==
X-Gm-Message-State: AOJu0YxmoJILJPz75mGrR3lV2njWi8MdJmrhM1milpRauo6i4p0y2/Y6
        E1yMUdx9AuRyhZ8SIgsIJMs=
X-Google-Smtp-Source: AGHT+IHv+HkF9SxXDR9kYtk+0rkvDn+zNvMDjKRgzljxGkAIYywFP2s9pZ8mqEjVLz2sFBjn98aOAA==
X-Received: by 2002:a19:5017:0:b0:502:ff3b:766f with SMTP id e23-20020a195017000000b00502ff3b766fmr6978545lfb.6.1699992398234;
        Tue, 14 Nov 2023 12:06:38 -0800 (PST)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id me19-20020a170906aed300b009ae587ce133sm5984429ejb.188.2023.11.14.12.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 12:06:37 -0800 (PST)
From:   Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alisa-Dariana Roman <alisa.roman@analog.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v2 4/4] iio: adc: ad7192: Add AD7194 support
Date:   Tue, 14 Nov 2023 22:05:33 +0200
Message-Id: <20231114200533.137995-5-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114200533.137995-1-alisa.roman@analog.com>
References: <20231114200533.137995-1-alisa.roman@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike the other AD719Xs, AD7194 has configurable differential
channels. The default configuration for these channels can be changed
from the devicetree.

The default configuration is hardcoded in order to have a stable number
of channels.

Also modify config AD7192 description for better scaling.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/Kconfig  |  11 ++-
 drivers/iio/adc/ad7192.c | 144 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 150 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 1e2b7a2c67c6..05344054b88e 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -55,12 +55,17 @@ config AD7124
 	  called ad7124.
 
 config AD7192
-	tristate "Analog Devices AD7190 AD7192 AD7193 AD7195 ADC driver"
+	tristate "Analog Devices AD7192 and similar ADC driver"
 	depends on SPI
 	select AD_SIGMA_DELTA
 	help
-	  Say yes here to build support for Analog Devices AD7190,
-	  AD7192, AD7193 or AD7195 SPI analog to digital converters (ADC).
+	  Say yes here to build support for Analog Devices SPI analog to digital
+	  converters (ADC):
+	  - AD7190
+	  - AD7192
+	  - AD7193
+	  - AD7194
+	  - AD7195
 	  If unsure, say N (but it's safe to say "Y").
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 48e0357564af..0532678ad665 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * AD7190 AD7192 AD7193 AD7195 SPI ADC driver
+ * AD7190 AD7192 AD7193 AD7194 AD7195 SPI ADC driver
  *
  * Copyright 2011-2015 Analog Devices Inc.
  */
@@ -125,10 +125,39 @@
 #define AD7193_CH_AIN8		0x480 /* AIN7 - AINCOM */
 #define AD7193_CH_AINCOM	0x600 /* AINCOM - AINCOM */
 
+#define AD7194_CH_TEMP		0x100 /* Temp sensor */
+#define AD7194_CH_AIN1		0x400 /* AIN1 - AINCOM */
+#define AD7194_CH_AIN2		0x410 /* AIN2 - AINCOM */
+#define AD7194_CH_AIN3		0x420 /* AIN3 - AINCOM */
+#define AD7194_CH_AIN4		0x430 /* AIN4 - AINCOM */
+#define AD7194_CH_AIN5		0x440 /* AIN5 - AINCOM */
+#define AD7194_CH_AIN6		0x450 /* AIN6 - AINCOM */
+#define AD7194_CH_AIN7		0x460 /* AIN7 - AINCOM */
+#define AD7194_CH_AIN8		0x470 /* AIN8 - AINCOM */
+#define AD7194_CH_AIN9		0x480 /* AIN9 - AINCOM */
+#define AD7194_CH_AIN10		0x490 /* AIN10 - AINCOM */
+#define AD7194_CH_AIN11		0x4A0 /* AIN11 - AINCOM */
+#define AD7194_CH_AIN12		0x4B0 /* AIN12 - AINCOM */
+#define AD7194_CH_AIN13		0x4C0 /* AIN13 - AINCOM */
+#define AD7194_CH_AIN14		0x4D0 /* AIN14 - AINCOM */
+#define AD7194_CH_AIN15		0x4E0 /* AIN15 - AINCOM */
+#define AD7194_CH_AIN16		0x4F0 /* AIN16 - AINCOM */
+#define AD7194_CH_POS_MASK	GENMASK(7, 4)
+#define AD7194_CH_POS(x)	FIELD_PREP(AD7194_CH_POS_MASK, (x))
+#define AD7194_CH_NEG_MASK	GENMASK(3, 0)
+#define AD7194_CH_NEG(x)	FIELD_PREP(AD7194_CH_NEG_MASK, (x))
+#define AD7194_CH_DIFF(pos, neg) \
+		(AD7194_CH_POS(pos) | AD7194_CH_NEG(neg))
+#define AD7194_CH_DIFF_START	0
+#define AD7194_CH_DIFF_NR	8
+#define AD7194_CH_AIN_START	1
+#define AD7194_CH_AIN_NR	16
+
 /* ID Register Bit Designations (AD7192_REG_ID) */
 #define CHIPID_AD7190		0x4
 #define CHIPID_AD7192		0x0
 #define CHIPID_AD7193		0x2
+#define CHIPID_AD7194		0x3
 #define CHIPID_AD7195		0x6
 #define AD7192_ID_MASK		GENMASK(3, 0)
 
@@ -166,6 +195,7 @@ enum {
 	ID_AD7190,
 	ID_AD7192,
 	ID_AD7193,
+	ID_AD7194,
 	ID_AD7195,
 };
 
@@ -644,6 +674,15 @@ static const struct attribute_group ad7192_attribute_group = {
 	.attrs = ad7192_attributes,
 };
 
+static struct attribute *ad7194_attributes[] = {
+	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group ad7194_attribute_group = {
+	.attrs = ad7194_attributes,
+};
+
 static struct attribute *ad7195_attributes[] = {
 	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
@@ -928,6 +967,16 @@ static const struct iio_info ad7192_info = {
 	.update_scan_mode = ad7192_update_scan_mode,
 };
 
+static const struct iio_info ad7194_info = {
+	.read_raw = ad7192_read_raw,
+	.write_raw = ad7192_write_raw,
+	.write_raw_get_fmt = ad7192_write_raw_get_fmt,
+	.read_avail = ad7192_read_avail,
+	.attrs = &ad7194_attribute_group,
+	.validate_trigger = ad_sd_validate_trigger,
+	.update_scan_mode = ad7192_update_scan_mode,
+};
+
 static const struct iio_info ad7195_info = {
 	.read_raw = ad7192_read_raw,
 	.write_raw = ad7192_write_raw,
@@ -1017,6 +1066,35 @@ static const struct iio_chan_spec ad7193_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(14),
 };
 
+static struct iio_chan_spec ad7194_channels[] = {
+	AD7193_DIFF_CHANNEL(0, 1, 2, 0x001),
+	AD7193_DIFF_CHANNEL(1, 3, 4, 0x023),
+	AD7193_DIFF_CHANNEL(2, 5, 6, 0x045),
+	AD7193_DIFF_CHANNEL(3, 7, 8, 0x067),
+	AD7193_DIFF_CHANNEL(4, 9, 10, 0x089),
+	AD7193_DIFF_CHANNEL(5, 11, 12, 0x0AB),
+	AD7193_DIFF_CHANNEL(6, 13, 14, 0x0CD),
+	AD7193_DIFF_CHANNEL(7, 15, 16, 0x0EF),
+	AD719x_TEMP_CHANNEL(8, AD7194_CH_TEMP),
+	AD7193_CHANNEL(9, 1, AD7194_CH_AIN1),
+	AD7193_CHANNEL(10, 2, AD7194_CH_AIN2),
+	AD7193_CHANNEL(11, 3, AD7194_CH_AIN3),
+	AD7193_CHANNEL(12, 4, AD7194_CH_AIN4),
+	AD7193_CHANNEL(13, 5, AD7194_CH_AIN5),
+	AD7193_CHANNEL(14, 6, AD7194_CH_AIN6),
+	AD7193_CHANNEL(15, 7, AD7194_CH_AIN7),
+	AD7193_CHANNEL(16, 8, AD7194_CH_AIN8),
+	AD7193_CHANNEL(17, 9, AD7194_CH_AIN9),
+	AD7193_CHANNEL(18, 10, AD7194_CH_AIN10),
+	AD7193_CHANNEL(19, 11, AD7194_CH_AIN11),
+	AD7193_CHANNEL(20, 12, AD7194_CH_AIN12),
+	AD7193_CHANNEL(21, 13, AD7194_CH_AIN13),
+	AD7193_CHANNEL(22, 14, AD7194_CH_AIN14),
+	AD7193_CHANNEL(23, 15, AD7194_CH_AIN15),
+	AD7193_CHANNEL(24, 16, AD7194_CH_AIN16),
+	IIO_CHAN_SOFT_TIMESTAMP(25),
+};
+
 static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 	[ID_AD7190] = {
 		.chip_id = CHIPID_AD7190,
@@ -1039,6 +1117,13 @@ static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 		.num_channels = ARRAY_SIZE(ad7193_channels),
 		.info = &ad7192_info,
 	},
+	[ID_AD7194] = {
+		.chip_id = CHIPID_AD7194,
+		.name = "ad7194",
+		.channels = ad7194_channels,
+		.num_channels = ARRAY_SIZE(ad7194_channels),
+		.info = &ad7194_info,
+	},
 	[ID_AD7195] = {
 		.chip_id = CHIPID_AD7195,
 		.name = "ad7195",
@@ -1053,6 +1138,53 @@ static void ad7192_reg_disable(void *reg)
 	regulator_disable(reg);
 }
 
+static int ad7192_parse_channel(struct iio_dev *indio_dev,
+				struct fwnode_handle *child)
+{
+	u32 reg, ain[2];
+	int ret;
+
+	ret = fwnode_property_read_u32(child, "reg", &reg);
+	if (ret)
+		return ret;
+
+	if (!in_range(reg, AD7194_CH_DIFF_START, AD7194_CH_DIFF_NR))
+		return -EINVAL;
+
+	ret = fwnode_property_read_u32_array(child, "diff-channels", ain,
+					     ARRAY_SIZE(ain));
+	if (ret)
+		return ret;
+
+	if (!in_range(ain[0], AD7194_CH_AIN_START, AD7194_CH_AIN_NR) ||
+	    !in_range(ain[1], AD7194_CH_AIN_START, AD7194_CH_AIN_NR))
+		return -EINVAL;
+
+	ad7194_channels[reg].channel = ain[0];
+	ad7194_channels[reg].channel2 = ain[1];
+	ad7194_channels[reg].address = AD7194_CH_DIFF(ain[0], ain[1]);
+
+	return 0;
+}
+
+static int ad7192_parse_channels(struct iio_dev *indio_dev)
+{
+	struct ad7192_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->sd.spi->dev;
+	struct fwnode_handle *child;
+	int ret;
+
+	device_for_each_child_node(dev, child) {
+		ret = ad7192_parse_channel(indio_dev, child);
+		if (ret) {
+			fwnode_handle_put(child);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int ad7192_probe(struct spi_device *spi)
 {
 	struct ad7192_state *st;
@@ -1150,6 +1282,12 @@ static int ad7192_probe(struct spi_device *spi)
 		}
 	}
 
+	if (st->chip_info->chip_id == CHIPID_AD7194) {
+		ret = ad7192_parse_channels(indio_dev);
+		if (ret)
+			return ret;
+	}
+
 	ret = ad7192_setup(indio_dev);
 	if (ret)
 		return ret;
@@ -1161,6 +1299,7 @@ static const struct of_device_id ad7192_of_match[] = {
 	{ .compatible = "adi,ad7190", .data = &ad7192_chip_info_tbl[ID_AD7190] },
 	{ .compatible = "adi,ad7192", .data = &ad7192_chip_info_tbl[ID_AD7192] },
 	{ .compatible = "adi,ad7193", .data = &ad7192_chip_info_tbl[ID_AD7193] },
+	{ .compatible = "adi,ad7194", .data = &ad7192_chip_info_tbl[ID_AD7194] },
 	{ .compatible = "adi,ad7195", .data = &ad7192_chip_info_tbl[ID_AD7195] },
 	{}
 };
@@ -1170,6 +1309,7 @@ static const struct spi_device_id ad7192_ids[] = {
 	{ "ad7190", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7190] },
 	{ "ad7192", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7192] },
 	{ "ad7193", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7193] },
+	{ "ad7194", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7194] },
 	{ "ad7195", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7195] },
 	{}
 };
@@ -1186,6 +1326,6 @@ static struct spi_driver ad7192_driver = {
 module_spi_driver(ad7192_driver);
 
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
-MODULE_DESCRIPTION("Analog Devices AD7190, AD7192, AD7193, AD7195 ADC");
+MODULE_DESCRIPTION("Analog Devices AD7190, AD7192, AD7193, AD7194, AD7195 ADC");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
-- 
2.34.1

