Return-Path: <linux-kernel+bounces-143767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C258A3D2D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9DD1C20CAD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F90487B5;
	Sat, 13 Apr 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1RCDhW+"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64DC4597E;
	Sat, 13 Apr 2024 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713021199; cv=none; b=cuFOu+kKk2eWiZV1JpLsDC4zbh+run6c0is733Zp6r6kISvnSj4SqfGIIgBnCqWPv0kTRfl2z8jPmUZzxrHm37KMGnLgAHeKYq8iMG5hISSAr1VEY0Kjr/dwqpVuheFrMWNHbOp2bS7nxIFNJ7YbouhzP6uNBhtpk8l7rG1vnn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713021199; c=relaxed/simple;
	bh=HOzFAL8yYAEMAgDOJ95pg4Wj7zWkAIIRw10A3SkOE0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gx2QrsJnVlBP/4KqKgCHkQWyerJIAl32cynjzA9uKcsYADC+/ynv7msoOiig2joFRefH64pJgVmC1wg64HdBfNN1PmERMCe/VCh8t+44PnCK9w5hpfuJLw5BKBSjmz4/r0ryl1eX0BpnJAmKwrxOuUDPYZ4880Q3p8Wz9QE5oZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1RCDhW+; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso2883487a12.1;
        Sat, 13 Apr 2024 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713021196; x=1713625996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGBXZT9zN7ekVSL6HG3HPphozJFpFD+fpudeCxgE3nM=;
        b=Z1RCDhW+lhgIhUVTMaJtAhTZoRDdxp59dqtIeTQwt0YDgndbJMG3mgJQGyfYAzB9uq
         KcAK1tqf6bbW1n0lMfulM46YrMdxIPghZHjZ1SUQvEuetU+BJ6HXoC8nwXhhoFe+kiqJ
         zL/Q8vQw2qBbIj4sEBDGgyMvhAI6NmCx9NhRRYrBq7ghvIidVUucb6yJKbunH66/G1eZ
         V6ZN6LWXhlv1Jan5kjM2nfOyBQdXAC7YloFjasW2nhs+jCAko9OuktwA+klTNjDHbQ3g
         vQBTx1WnZxMxhqa54BvfJGfI+xDdJQ+laJdWrltkwObl6Z/QN+BB/7KWBqSBgb930g9i
         n3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713021196; x=1713625996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGBXZT9zN7ekVSL6HG3HPphozJFpFD+fpudeCxgE3nM=;
        b=ITJftT/aX4iFMxv46uY3PXFdkvStDw4q3LcWInHWBvVFoejOjfMQHnv/SejamtTNGX
         p/CiccSd4SOYKiEp/iUjUbqIypakY4GBUfML0cUEvUGt9dy0Ku03fR8LWj5slzx0uJuB
         spBo503WmjBC8igvKuWmHLjJhQnEoRBI6WNHAUtmYiiz1ed+GG4AhkeLXBm+CKK4ieRD
         hyRfgvIR8Lo1lWp2+pcgqQNyqw3sjXxxGH9eqsCbQPtHKYun2uKuf08rkXEEbfQyw3Iq
         QGrgMvreAO7E4oa8uYhoVLHmLoiZyrOZGV+kvTaA6lj1v90qC2HMg74dthQfO9mu2nBP
         y8cw==
X-Forwarded-Encrypted: i=1; AJvYcCV0e15scrau7JXh/J83/6CqDiVIMTPeQyIW9qge6ny8tcYq4ZC7rL5q1vr09hnlzLKSSsddFQcXN5hzBUVTWS2WG00JeGdTKfCo4+hO4FwZN7pSimihkxyUiDg791O5vyimgG4QeyNaQBADWYEK0t84ttGMXC5Eknpqxmq7ucw4sKynhQ==
X-Gm-Message-State: AOJu0YyB4jyLV0IzRjCX0iiMcG73ijOwTcyFOIEaDJA82X/WGb6dVQyc
	dANe8GfZOC4bpvGHcJrAByf2lpeln4S9sFRpwCrIL9Ks1FzeQbBg
X-Google-Smtp-Source: AGHT+IGZTsb04Cb1Z3Fq6VjXL8jX9l295NRiV65Hfmc9gP5pFkhTU2P8PnBWm1KkJmcrnSB0Ocua/w==
X-Received: by 2002:a50:9e4e:0:b0:56c:1db1:f9eb with SMTP id z72-20020a509e4e000000b0056c1db1f9ebmr4530504ede.19.1713021196065;
        Sat, 13 Apr 2024 08:13:16 -0700 (PDT)
Received: from spiri.. ([5.14.146.31])
        by smtp.gmail.com with ESMTPSA id w4-20020a056402128400b0056e2b351956sm2749883edv.22.2024.04.13.08.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 08:13:15 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alexandru.tachici@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	marcelo.schmitt@analog.com,
	bigunclemax@gmail.com,
	dlechner@baylibre.com,
	okan.sahin@analog.com,
	fr0st61te@gmail.com,
	alisa.roman@analog.com,
	marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: [PATCH v5 5/5] iio: adc: ad7192: Add AD7194 support
Date: Sat, 13 Apr 2024 18:11:52 +0300
Message-Id: <20240413151152.165682-6-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240413151152.165682-1-alisa.roman@analog.com>
References: <20240413151152.165682-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike the other AD719Xs, AD7194 has configurable differential
channels. The user can dynamically configure them in the devicetree.

Also modify config AD7192 description for better scaling.

Moved ad7192_chip_info struct definition to allow use of callback
function parse_channels().

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/Kconfig  |  11 ++-
 drivers/iio/adc/ad7192.c | 140 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 138 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 8db68b80b391..74fecc284f1a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -88,12 +88,17 @@ config AD7173
 	  called ad7173.
 
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
index a9eb4fab39ca..646ab56b87e3 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * AD7190 AD7192 AD7193 AD7195 SPI ADC driver
+ * AD7192 and similar SPI ADC driver
  *
  * Copyright 2011-2015 Analog Devices Inc.
  */
@@ -128,10 +128,21 @@
 #define AD7193_CH_AIN8		0x480 /* AIN7 - AINCOM */
 #define AD7193_CH_AINCOM	0x600 /* AINCOM - AINCOM */
 
+#define AD7194_CH_POS(x)	(((x) - 1) << 4)
+#define AD7194_CH_NEG(x)	((x) - 1)
+#define AD7194_CH_DIFF(pos, neg) \
+		(((neg) == 0 ? BIT(10) : AD7194_CH_NEG(neg)) | AD7194_CH_POS(pos))
+#define AD7194_CH_TEMP		0x100 /* Temp sensor */
+#define AD7194_CH_BASE_NR	18
+#define AD7194_CH_AIN_START	1
+#define AD7194_CH_AIN_NR	16
+#define AD7194_CH_DIFF_NR_MAX	256
+
 /* ID Register Bit Designations (AD7192_REG_ID) */
 #define CHIPID_AD7190		0x4
 #define CHIPID_AD7192		0x0
 #define CHIPID_AD7193		0x2
+#define CHIPID_AD7194		0x3
 #define CHIPID_AD7195		0x6
 #define AD7192_ID_MASK		GENMASK(3, 0)
 
@@ -169,17 +180,10 @@ enum {
 	ID_AD7190,
 	ID_AD7192,
 	ID_AD7193,
+	ID_AD7194,
 	ID_AD7195,
 };
 
-struct ad7192_chip_info {
-	unsigned int			chip_id;
-	const char			*name;
-	struct iio_chan_spec		*channels;
-	u8				num_channels;
-	const struct iio_info		*info;
-};
-
 struct ad7192_state {
 	const struct ad7192_chip_info	*chip_info;
 	struct regulator		*avdd;
@@ -201,6 +205,15 @@ struct ad7192_state {
 	struct ad_sigma_delta		sd;
 };
 
+struct ad7192_chip_info {
+	unsigned int			chip_id;
+	const char			*name;
+	struct iio_chan_spec		*channels;
+	u8				num_channels;
+	const struct iio_info		*info;
+	int (*parse_channels)(struct iio_dev *indio_dev);
+};
+
 static const char * const ad7192_syscalib_modes[] = {
 	[AD7192_SYSCALIB_ZERO_SCALE] = "zero_scale",
 	[AD7192_SYSCALIB_FULL_SCALE] = "full_scale",
@@ -925,6 +938,15 @@ static const struct iio_info ad7192_info = {
 	.update_scan_mode = ad7192_update_scan_mode,
 };
 
+static const struct iio_info ad7194_info = {
+	.read_raw = ad7192_read_raw,
+	.write_raw = ad7192_write_raw,
+	.write_raw_get_fmt = ad7192_write_raw_get_fmt,
+	.read_avail = ad7192_read_avail,
+	.validate_trigger = ad_sd_validate_trigger,
+	.update_scan_mode = ad7192_update_scan_mode,
+};
+
 static const struct iio_info ad7195_info = {
 	.read_raw = ad7192_read_raw,
 	.write_raw = ad7192_write_raw,
@@ -1016,6 +1038,90 @@ static struct iio_chan_spec ad7193_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(14),
 };
 
+static int ad7192_parse_channel(struct fwnode_handle *child,
+				struct iio_chan_spec *ad7194_channels)
+{
+	u32 ain[2];
+	int ret;
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
+	ad7194_channels->channel = ain[0];
+	ad7194_channels->channel2 = ain[1];
+	ad7194_channels->address = AD7194_CH_DIFF(ain[0], ain[1]);
+
+	return 0;
+}
+
+static int ad7192_parse_channels(struct iio_dev *indio_dev)
+{
+	struct ad7192_state *st = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
+	struct iio_chan_spec *ad7194_channels;
+	struct fwnode_handle *child;
+	struct iio_chan_spec ad7194_chan = AD7193_CHANNEL(0, 0, 0);
+	struct iio_chan_spec ad7194_chan_diff = AD7193_DIFF_CHANNEL(0, 0, 0, 0);
+	struct iio_chan_spec ad7194_chan_temp = AD719x_TEMP_CHANNEL(0, 0);
+	struct iio_chan_spec ad7194_chan_timestamp = IIO_CHAN_SOFT_TIMESTAMP(0);
+	unsigned int num_channels, index = 0, ain_chan;
+	int ret;
+
+	num_channels = device_get_child_node_count(dev);
+	if (num_channels > AD7194_CH_DIFF_NR_MAX)
+		return -EINVAL;
+
+	num_channels += AD7194_CH_BASE_NR;
+
+	ad7194_channels = devm_kcalloc(dev, sizeof(*ad7194_channels),
+				       num_channels, GFP_KERNEL);
+	if (!ad7194_channels)
+		return -ENOMEM;
+
+	indio_dev->channels = ad7194_channels;
+	indio_dev->num_channels = num_channels;
+
+	device_for_each_child_node(dev, child) {
+		*ad7194_channels = ad7194_chan_diff;
+		ad7194_channels->scan_index = index++;
+		ret = ad7192_parse_channel(child, ad7194_channels);
+		if (ret) {
+			fwnode_handle_put(child);
+			return ret;
+		}
+		ad7194_channels++;
+	}
+
+	*ad7194_channels = ad7194_chan_temp;
+	ad7194_channels->scan_index = index++;
+	ad7194_channels->address = AD7194_CH_TEMP;
+	ad7194_channels++;
+
+	for (ain_chan = 1; ain_chan <= 16; ain_chan++) {
+		if (st->aincom_mv) {
+			*ad7194_channels = ad7194_chan;
+		} else {
+			*ad7194_channels = ad7194_chan_diff;
+			ad7194_channels->channel2 = 0;
+		}
+		ad7194_channels->scan_index = index++;
+		ad7194_channels->channel = ain_chan;
+		ad7194_channels->address = AD7194_CH_DIFF(ain_chan, 0);
+		ad7194_channels++;
+	}
+
+	*ad7194_channels = ad7194_chan_timestamp;
+	ad7194_channels->scan_index = index;
+
+	return 0;
+}
+
 static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 	[ID_AD7190] = {
 		.chip_id = CHIPID_AD7190,
@@ -1038,6 +1144,12 @@ static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 		.num_channels = ARRAY_SIZE(ad7193_channels),
 		.info = &ad7192_info,
 	},
+	[ID_AD7194] = {
+		.chip_id = CHIPID_AD7194,
+		.name = "ad7194",
+		.info = &ad7194_info,
+		.parse_channels = ad7192_parse_channels,
+	},
 	[ID_AD7195] = {
 		.chip_id = CHIPID_AD7195,
 		.name = "ad7195",
@@ -1164,6 +1276,12 @@ static int ad7192_probe(struct spi_device *spi)
 	indio_dev->num_channels = st->chip_info->num_channels;
 	indio_dev->info = st->chip_info->info;
 
+	if (st->chip_info->parse_channels) {
+		ret = st->chip_info->parse_channels(indio_dev);
+		if (ret)
+			return ret;
+	}
+
 	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7192_sigma_delta_info);
 	if (ret)
 		return ret;
@@ -1201,6 +1319,7 @@ static const struct of_device_id ad7192_of_match[] = {
 	{ .compatible = "adi,ad7190", .data = &ad7192_chip_info_tbl[ID_AD7190] },
 	{ .compatible = "adi,ad7192", .data = &ad7192_chip_info_tbl[ID_AD7192] },
 	{ .compatible = "adi,ad7193", .data = &ad7192_chip_info_tbl[ID_AD7193] },
+	{ .compatible = "adi,ad7194", .data = &ad7192_chip_info_tbl[ID_AD7194] },
 	{ .compatible = "adi,ad7195", .data = &ad7192_chip_info_tbl[ID_AD7195] },
 	{}
 };
@@ -1210,6 +1329,7 @@ static const struct spi_device_id ad7192_ids[] = {
 	{ "ad7190", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7190] },
 	{ "ad7192", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7192] },
 	{ "ad7193", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7193] },
+	{ "ad7194", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7194] },
 	{ "ad7195", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7195] },
 	{}
 };
@@ -1226,6 +1346,6 @@ static struct spi_driver ad7192_driver = {
 module_spi_driver(ad7192_driver);
 
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
-MODULE_DESCRIPTION("Analog Devices AD7190, AD7192, AD7193, AD7195 ADC");
+MODULE_DESCRIPTION("Analog Devices AD7192 and similar ADC");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
-- 
2.34.1


