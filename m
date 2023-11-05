Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A4F7E1618
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 20:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjKETcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 14:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjKETcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 14:32:35 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F029710B;
        Sun,  5 Nov 2023 11:32:31 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9d10972e63eso541129366b.2;
        Sun, 05 Nov 2023 11:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699212750; x=1699817550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbmxP9d5CEEm5ls5ZDP7F4AFpxyhhDcqMp2/9VvDYlA=;
        b=HfKyU4Vc5S73elW5/sg93lvV6bpxRYLVEL9xoOKtcy0qE/kI8LKdEiklwECAaLNTrP
         waZrmuAn/ScP7f38jjE6J3y6y0JsvRUZXx1MP7SHxEY6pcTqZFf5XbLVJlRCo2cuDhdl
         DBENEgQjZgQtDn93B1EU2v4b6584YgwuQwAJ1/SG5yJZZGPoxCBYUZcfnD74SvYPcel7
         SIle0ve0uXxfh7lPaHvMh2O/9JzaDNge8JwBMcSRQaNDatpRxl21CyfzVRq0nnNbxYRq
         QZOQSKKTFfomsZqxqxhp9yRo9tm6fztXvw8YarzdHzSlC0BRRYdxqsH3mGJaM32exvU6
         3LGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699212750; x=1699817550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbmxP9d5CEEm5ls5ZDP7F4AFpxyhhDcqMp2/9VvDYlA=;
        b=BM4VTMv88s5Q6E0FlDLJ2KTU66u1dIrpB9WI0jfKZbZYfUUQ62tIGyRvSD3ZwbUplT
         xzOF2Vna5wG+hZxnuEV07/aJqPOGkQ74AgR7yIJKyoNEe1AZcfs5Nj2HDRx6p+z3OGMR
         dp+tysMWN+CZy73Enl9WYBomvSjOSEsxkXSXK1n5eTImW51oRB7TJ6Y4IwvKYOpLObPz
         IGUS5Feol0CwTeSbNJVdBjBmmIatWdUZNybVTf5/5U6Yii4p2n3mdpro7cQDBOn90oMg
         Bw6D/o/vjlA9FhW6m8OsdMfTcUC0HBJqB1BFwuKZ9X0KBiTdu9TSTY4d5LYPuartt+NG
         UP0w==
X-Gm-Message-State: AOJu0YzvJwvA2OzVlkyYPCkPxiLK4kLxXNy2OsJoipLmYT4r6d6hX3uP
        eipGF4Sz3Ryv+l/B9ydIhT4=
X-Google-Smtp-Source: AGHT+IEY/00As0STjEXviNBr7fr1k/UIdPumVuX2NuFQByToEzAQojLKncQ+wPL+sBoPj8zCeuAxyg==
X-Received: by 2002:a17:907:954f:b0:9c4:4b20:44a1 with SMTP id ex15-20020a170907954f00b009c44b2044a1mr8575753ejc.65.1699212750240;
        Sun, 05 Nov 2023 11:32:30 -0800 (PST)
Received: from spiri.. ([5.14.137.80])
        by smtp.gmail.com with ESMTPSA id d26-20020a1709064c5a00b009b947aacb4bsm3300259ejw.191.2023.11.05.11.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 11:32:29 -0800 (PST)
From:   alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Okan Sahin <okan.sahin@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Marius Cristea <marius.cristea@microchip.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iio: adc: ad7192: Add AD7194 support
Date:   Sun,  5 Nov 2023 21:31:31 +0200
Message-Id: <20231105193132.47009-4-alisadariana@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105193132.47009-1-alisadariana@gmail.com>
References: <20231105193132.47009-1-alisadariana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alisa-Dariana Roman <alisa.roman@analog.com>

Unlike the other AD719Xs, AD7194 has configurable differential
channels. The default configuration for these channels can be changed
from the devicetree.

The default configuration is hardcoded in order to have a stable number
of channels.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/Kconfig  |   4 +-
 drivers/iio/adc/ad7192.c | 144 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 144 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 1e2b7a2c67c6..020d37457d81 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -55,12 +55,12 @@ config AD7124
 	  called ad7124.
 
 config AD7192
-	tristate "Analog Devices AD7190 AD7192 AD7193 AD7195 ADC driver"
+	tristate "Analog Devices AD7190 AD7192 AD7193 AD7194 AD7195 ADC driver"
 	depends on SPI
 	select AD_SIGMA_DELTA
 	help
 	  Say yes here to build support for Analog Devices AD7190,
-	  AD7192, AD7193 or AD7195 SPI analog to digital converters (ADC).
+	  AD7192, AD7193, AD7194 or AD7195 SPI analog to digital converters (ADC).
 	  If unsure, say N (but it's safe to say "Y").
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 48e0357564af..9c716c5c18b3 100644
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
+#define AD7194_CH_DIFF_NR_MIN	0
+#define AD7194_CH_DIFF_NR_MAX	7
+#define AD7194_CH_AIN_MIN	1
+#define AD7194_CH_AIN_MAX	16
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
+	if (reg < AD7194_CH_DIFF_NR_MIN || reg > AD7194_CH_DIFF_NR_MAX)
+		return -EINVAL;
+
+	ret = fwnode_property_read_u32_array(child, "diff-channels", ain,
+					     ARRAY_SIZE(ain));
+	if (ret)
+		return ret;
+
+	if (ain[0] < AD7194_CH_AIN_MIN || ain[0] > AD7194_CH_AIN_MAX ||
+	    ain[1] < AD7194_CH_AIN_MIN || ain[1] > AD7194_CH_AIN_MAX)
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

