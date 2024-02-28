Return-Path: <linux-kernel+bounces-85015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A06986AF2D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05661F257A5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA60E12C7E8;
	Wed, 28 Feb 2024 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TK9obehP"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA94070CBF;
	Wed, 28 Feb 2024 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123222; cv=none; b=heVOLmW4NC1soxllMRBsNkp8zX5auT+QNBluxnJtG0RG8m3gT3SIFVNHnOOvt9ChUyzNDkn7GO0GLXZfaCf8gwnFQPL9NwdfbpyRVlMhxVLsD7rM0Cl9kSEMtRJECLz+5ViiJstzOBjvihp+K+FXwrAptqDWBo1eHo6FurosOhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123222; c=relaxed/simple;
	bh=4vjVPSbQRueHialpwEubrD6PO9J/x/oRHPgEpMYoY9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DBvG1BmShf7bkyiale1Gy19icIbQZKZU9TO9uZmnqrw9b07Wj8JSwehK0lQ+tblJUUOshYJUD3gSLw/ccFwgpK25PfmbgaHJZsNMyhsZfepycWeJGAy+TOkJQlYEhYQLtQC5aNWHLppDh/ZwbOablkioQqi6PGgQXoteh+3epgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TK9obehP; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56648955ac5so1820168a12.3;
        Wed, 28 Feb 2024 04:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709123219; x=1709728019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXEIb8x+lTkSaotXd6kZaJQ7rsEXDwK0LNJdeI+qvBI=;
        b=TK9obehPh58ajWdezyPaioAntT/Sd2vBLxAPsOE/Gps5FaKcHxi0N9aBID3BUJCbul
         hgQtDyyNVUgkY3OJSj4sCXs8w+MOIQnrmNJh/kTnNTUOKk3Ono+WnxLg0KHRBVV7w2Wz
         1GpiVs/sZcfvQHiZSdiLfcZKk8cNi9DNzRaISU9c6jYlgbE4RCbAWhX3oOdZ1XU67GNH
         lHPvfc08iH1Fc1bBJWyzjPCUhm9wgWE4ZKO3iRKKA4Ufwy2+QL2eHrW2Rjs9T+pC6j39
         jxI9OEnv9wFLQQAa3vVYw9xJ/BLG1dXtz140sA9GMWjm/6Slge0R2QCaph7HvS7bqr1l
         Oswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709123219; x=1709728019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXEIb8x+lTkSaotXd6kZaJQ7rsEXDwK0LNJdeI+qvBI=;
        b=ah1b2Jmr5SQWyvxJ5iqU974SoN2P9KNJp/Ekb9iMdklcLC2jpeF56k/BGSnZl35mh0
         d6Vpd2p6NSGGUB5O+Baru9XFO17jemwk828G57ax7w+5S/CQJaylZeVLFH4QQ1JMdD2A
         U9E9xOZq8P/cAJKSnxN0rbVFjHsAQadcKB+5lnY43EDpG2oQUsZxgQb3KDRo3xkWdl90
         +ik4GrXRHwKRt4iylWVPAnV0H3vICf61j0y14jdhWE3caFxnYXkaY5VTIjBYKrUPLS4z
         Z6kiMlWn5yyQXUdUci1lACb9TrqBrcUC/2+E2+QKlMo2r44/jU41kR6VknFYnqdr+KL/
         d6zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzQWfI39aiXM3R/iMIFq75CN76ZscdoL8HS5EKmmPhSm/fKyCokLlF2SrV2NNSc61KA/syX48qa2t4MtRwKNj9pBVyBB5vUC6+NIL2U1HDj36lCIciGEQG2g+BemDzOzN+nt0y0ysX+Xnl8F0Q/ShQBxJfBm1rM3iK2cqrylgAH3geAQ==
X-Gm-Message-State: AOJu0Yw8ctNF28wKZHMxdPX0yFXyPn7sAazaWUliKtpFJySbtPJ0lEKK
	uZhSXlr5ubuYw4om1+nKdHFw+896LOyHaQ4GoJHbriKvtyPHLuTuKiek1YOkxew=
X-Google-Smtp-Source: AGHT+IFGYENJob99u16qaJNdZQw8s6fSzJRnKSY/XsZ02Fx1+SFGSyVUzrgQ5sXGiyT0I+5nj4iqwQ==
X-Received: by 2002:a17:906:119a:b0:a43:5dbc:4bfc with SMTP id n26-20020a170906119a00b00a435dbc4bfcmr5673652eja.1.1709123219031;
        Wed, 28 Feb 2024 04:26:59 -0800 (PST)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id f3-20020a170906c08300b00a3d1c0a3d5dsm1800417ejz.63.2024.02.28.04.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 04:26:58 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com,
	nuno.sa@analog.com,
	alisa.roman@analog.com,
	dlechner@baylibre.com
Subject: [PATCH v4 4/4] iio: adc: ad7192: Add AD7194 support
Date: Wed, 28 Feb 2024 14:26:17 +0200
Message-Id: <20240228122617.185814-5-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228122617.185814-1-alisa.roman@analog.com>
References: <20240228122617.185814-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike the other AD719Xs, AD7194 has configurable differential
channels. The configuration for the 16 differential channels can be
changed in the devicetree.

The default configuration includes 16 differential channels
corresponding to the voltage difference between each AINx input and
AINCOM input.

Also modify config AD7192 description for better scaling.

Moved ad7192_chip_info struct definition to allow use of callback
function parse_channels().

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: romandariana <alisa.roman@analog.com>
---
 drivers/iio/adc/Kconfig  |  11 ++-
 drivers/iio/adc/ad7192.c | 143 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 141 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 0d9282fa67f5..6d8202d9f501 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -71,12 +71,17 @@ config AD7124
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
index e0f1c9eaf9ae..f8ba724bc143 100644
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
@@ -128,10 +128,39 @@
 #define AD7193_CH_AIN8		0x480 /* AIN7 - AINCOM */
 #define AD7193_CH_AINCOM	0x600 /* AINCOM - AINCOM */
 
+#define AD7194_CH_POS(x)	(((x) - 1) << 4)
+#define AD7194_CH_NEG(x)	((x) - 1)
+#define AD7194_CH_DIFF(pos, neg) \
+		(((neg) == 0 ? BIT(10) : AD7194_CH_NEG(neg)) | AD7194_CH_POS(pos))
+#define AD7194_CH_AIN1		AD7194_CH_DIFF(1, 0) /* AIN1 - AINCOM */
+#define AD7194_CH_AIN2		AD7194_CH_DIFF(2, 0) /* AIN2 - AINCOM */
+#define AD7194_CH_AIN3		AD7194_CH_DIFF(3, 0) /* AIN3 - AINCOM */
+#define AD7194_CH_AIN4		AD7194_CH_DIFF(4, 0) /* AIN4 - AINCOM */
+#define AD7194_CH_AIN5		AD7194_CH_DIFF(5, 0) /* AIN5 - AINCOM */
+#define AD7194_CH_AIN6		AD7194_CH_DIFF(6, 0) /* AIN6 - AINCOM */
+#define AD7194_CH_AIN7		AD7194_CH_DIFF(7, 0) /* AIN7 - AINCOM */
+#define AD7194_CH_AIN8		AD7194_CH_DIFF(8, 0) /* AIN8 - AINCOM */
+#define AD7194_CH_AIN9		AD7194_CH_DIFF(9, 0) /* AIN9 - AINCOM */
+#define AD7194_CH_AIN10		AD7194_CH_DIFF(10, 0) /* AIN10 - AINCOM */
+#define AD7194_CH_AIN11		AD7194_CH_DIFF(11, 0) /* AIN11 - AINCOM */
+#define AD7194_CH_AIN12		AD7194_CH_DIFF(12, 0) /* AIN12 - AINCOM */
+#define AD7194_CH_AIN13		AD7194_CH_DIFF(13, 0) /* AIN13 - AINCOM */
+#define AD7194_CH_AIN14		AD7194_CH_DIFF(14, 0) /* AIN14 - AINCOM */
+#define AD7194_CH_AIN15		AD7194_CH_DIFF(15, 0) /* AIN15 - AINCOM */
+#define AD7194_CH_AIN16		AD7194_CH_DIFF(16, 0) /* AIN16 - AINCOM */
+#define AD7194_CH_TEMP		0x100 /* Temp sensor */
+#define AD7194_CH_DIFF_START	1
+#define AD7194_CH_DIFF_NR	16
+#define AD7194_CH_AIN0_START	1
+#define AD7194_CH_AIN0_NR	16
+#define AD7194_CH_AIN1_START	0
+#define AD7194_CH_AIN1_NR	17
+
 /* ID Register Bit Designations (AD7192_REG_ID) */
 #define CHIPID_AD7190		0x4
 #define CHIPID_AD7192		0x0
 #define CHIPID_AD7193		0x2
+#define CHIPID_AD7194		0x3
 #define CHIPID_AD7195		0x6
 #define AD7192_ID_MASK		GENMASK(3, 0)
 
@@ -169,17 +198,10 @@ enum {
 	ID_AD7190,
 	ID_AD7192,
 	ID_AD7193,
+	ID_AD7194,
 	ID_AD7195,
 };
 
-struct ad7192_chip_info {
-	unsigned int			chip_id;
-	const char			*name;
-	const struct iio_chan_spec	*channels;
-	u8				num_channels;
-	const struct iio_info		*info;
-};
-
 struct ad7192_state {
 	const struct ad7192_chip_info	*chip_info;
 	struct regulator		*avdd;
@@ -200,6 +222,15 @@ struct ad7192_state {
 	struct ad_sigma_delta		sd;
 };
 
+struct ad7192_chip_info {
+	unsigned int			chip_id;
+	const char			*name;
+	const struct iio_chan_spec	*channels;
+	u8				num_channels;
+	const struct iio_info		*info;
+	int (*parse_channels)(struct ad7192_state *st);
+};
+
 static const char * const ad7192_syscalib_modes[] = {
 	[AD7192_SYSCALIB_ZERO_SCALE] = "zero_scale",
 	[AD7192_SYSCALIB_FULL_SCALE] = "full_scale",
@@ -921,6 +952,15 @@ static const struct iio_info ad7192_info = {
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
@@ -1012,6 +1052,73 @@ static const struct iio_chan_spec ad7193_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(14),
 };
 
+static struct iio_chan_spec ad7194_channels[] = {
+	AD7193_DIFF_CHANNEL(0, 1, 0, AD7194_CH_AIN1),
+	AD7193_DIFF_CHANNEL(1, 2, 0, AD7194_CH_AIN2),
+	AD7193_DIFF_CHANNEL(2, 3, 0, AD7194_CH_AIN3),
+	AD7193_DIFF_CHANNEL(3, 4, 0, AD7194_CH_AIN4),
+	AD7193_DIFF_CHANNEL(4, 5, 0, AD7194_CH_AIN5),
+	AD7193_DIFF_CHANNEL(5, 6, 0, AD7194_CH_AIN6),
+	AD7193_DIFF_CHANNEL(6, 7, 0, AD7194_CH_AIN7),
+	AD7193_DIFF_CHANNEL(7, 8, 0, AD7194_CH_AIN8),
+	AD7193_DIFF_CHANNEL(8, 9, 0, AD7194_CH_AIN9),
+	AD7193_DIFF_CHANNEL(9, 10, 0, AD7194_CH_AIN10),
+	AD7193_DIFF_CHANNEL(10, 11, 0, AD7194_CH_AIN11),
+	AD7193_DIFF_CHANNEL(11, 12, 0, AD7194_CH_AIN12),
+	AD7193_DIFF_CHANNEL(12, 13, 0, AD7194_CH_AIN13),
+	AD7193_DIFF_CHANNEL(13, 14, 0, AD7194_CH_AIN14),
+	AD7193_DIFF_CHANNEL(14, 15, 0, AD7194_CH_AIN15),
+	AD7193_DIFF_CHANNEL(15, 16, 0, AD7194_CH_AIN16),
+	AD719x_TEMP_CHANNEL(16, AD7194_CH_TEMP),
+	IIO_CHAN_SOFT_TIMESTAMP(17),
+};
+
+static int ad7192_parse_channel(struct fwnode_handle *child)
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
+	if (!in_range(ain[0], AD7194_CH_AIN0_START, AD7194_CH_AIN0_NR) ||
+	    !in_range(ain[1], AD7194_CH_AIN1_START, AD7194_CH_AIN1_NR))
+		return -EINVAL;
+
+	reg--;
+	ad7194_channels[reg].channel = ain[0];
+	ad7194_channels[reg].channel2 = ain[1];
+	ad7194_channels[reg].address = AD7194_CH_DIFF(ain[0], ain[1]);
+
+	return 0;
+}
+
+static int ad7192_parse_channels(struct ad7192_state *st)
+{
+	struct device *dev = &st->sd.spi->dev;
+	struct fwnode_handle *child;
+	int ret;
+
+	device_for_each_child_node(dev, child) {
+		ret = ad7192_parse_channel(child);
+		if (ret) {
+			fwnode_handle_put(child);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 	[ID_AD7190] = {
 		.chip_id = CHIPID_AD7190,
@@ -1034,6 +1141,14 @@ static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 		.num_channels = ARRAY_SIZE(ad7193_channels),
 		.info = &ad7192_info,
 	},
+	[ID_AD7194] = {
+		.chip_id = CHIPID_AD7194,
+		.name = "ad7194",
+		.channels = ad7194_channels,
+		.num_channels = ARRAY_SIZE(ad7194_channels),
+		.info = &ad7194_info,
+		.parse_channels = ad7192_parse_channels,
+	},
 	[ID_AD7195] = {
 		.chip_id = CHIPID_AD7195,
 		.name = "ad7195",
@@ -1145,6 +1260,12 @@ static int ad7192_probe(struct spi_device *spi)
 		}
 	}
 
+	if (st->chip_info->parse_channels) {
+		ret = st->chip_info->parse_channels(st);
+		if (ret)
+			return ret;
+	}
+
 	ret = ad7192_setup(st);
 	if (ret)
 		return ret;
@@ -1156,6 +1277,7 @@ static const struct of_device_id ad7192_of_match[] = {
 	{ .compatible = "adi,ad7190", .data = &ad7192_chip_info_tbl[ID_AD7190] },
 	{ .compatible = "adi,ad7192", .data = &ad7192_chip_info_tbl[ID_AD7192] },
 	{ .compatible = "adi,ad7193", .data = &ad7192_chip_info_tbl[ID_AD7193] },
+	{ .compatible = "adi,ad7194", .data = &ad7192_chip_info_tbl[ID_AD7194] },
 	{ .compatible = "adi,ad7195", .data = &ad7192_chip_info_tbl[ID_AD7195] },
 	{}
 };
@@ -1165,6 +1287,7 @@ static const struct spi_device_id ad7192_ids[] = {
 	{ "ad7190", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7190] },
 	{ "ad7192", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7192] },
 	{ "ad7193", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7193] },
+	{ "ad7194", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7194] },
 	{ "ad7195", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7195] },
 	{}
 };
@@ -1181,6 +1304,6 @@ static struct spi_driver ad7192_driver = {
 module_spi_driver(ad7192_driver);
 
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
-MODULE_DESCRIPTION("Analog Devices AD7190, AD7192, AD7193, AD7195 ADC");
+MODULE_DESCRIPTION("Analog Devices AD7192 and similar ADC");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
-- 
2.34.1


