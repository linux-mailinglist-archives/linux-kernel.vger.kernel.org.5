Return-Path: <linux-kernel+bounces-148963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 855A18A89BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A921B1C23828
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786AE17A92C;
	Wed, 17 Apr 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PO5cLLea"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B12178CE8;
	Wed, 17 Apr 2024 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373290; cv=none; b=Qkaejqd/mhDIopH9mIbaaFAJcQnm7qSMgmD9L/QSYNvLVZcQs9IZzAIdrKrLCHiTbKMzn7Ent6F1OICoCGOwJrQ8m7y7SWFY7eE3ggk0j+dZAC6yICBuzqW8AH3KmkDBb0Jk13eb/qEp3INi68p0fasaKprtx0CgGDXP8niyETo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373290; c=relaxed/simple;
	bh=ZSYcEoEeIbTMMApoUpft+vWV6+yLewZlnSX6ans5n7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O+EebquhKymOc1Zu1zIdChqn/Pee3Et/yXh7LQ429PcPWNu3Wh0BjnkaUWVnvmbyqh0QE/gtXAMTDxOyfKzzcNVqQdA2bFMI/WaYErSt28ErECF72EbGdo/qaJYz01h8VWiC0cysCE247FZivwohC6Jp4lUGP0zQ05Ovyr7msVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PO5cLLea; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3455ff1339dso3969013f8f.0;
        Wed, 17 Apr 2024 10:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713373284; x=1713978084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhLj2QxSVDUqsIOYdaogivE14AODPOTFZug6/MH3QPU=;
        b=PO5cLLeaHJf35DN0mjZfE+tizcu6HP0kmEGx5Cmmc7sIlLRLoPR9bEd8uXXiP8P5oL
         aHdpCiAOxdnpY4n7pr8tIQOVHhG4eUxRq96IBFC0ehoUwfXJ70kwY0PAOJpUxliPH1QK
         hlUp87ZuPg+YK4Ep+ACfCAY/A1EKP9TA6aJ+mNZbKs+FT99uYjzlpIOuAYk5mSrWVf9J
         as8Iz2VR+RKKicVxBIPAGjj8KGNOK9hKWq3bwBc8sctJfiE39N3V12TD9e15ODQ2WFou
         dt9ON0cFtkk6khkuEmVvuf3xKlEdbKYP+Fj8bmUDoJBrcwFkwmc3PHDAlVdDZsW6A6rU
         edOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713373284; x=1713978084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhLj2QxSVDUqsIOYdaogivE14AODPOTFZug6/MH3QPU=;
        b=MgkD1THHDLr6SE+R9y9ev7P2BRwzj/pJXGJte9mNoHiXxJh1/4QjhaoUxse5AojHrN
         N837WLFw8NzI0R6nRqot2zqqAOlzDXaFHqZxKu7fKGXmWFS/oP/XbMpmhnBUWZg90aO9
         xt6LpaJyetCNiJVkcmsi5pQgxq/jGVhQluz1B7wfWYTYULNnL28CMYxmmN/2zR/B2f9z
         9EQ8Ymfd6XAHM6NH2O6QcVPAq/Z8Sk0bUrGCwFIrAplXF5EZe9XelKjPAJaNzZinHQ/D
         ghcqoJrAEhG8o499TljAyUEHR+64J6ppiyTYGSygD0sCRcKKmtFGp3pIq+oAB90s/FM3
         iO3A==
X-Forwarded-Encrypted: i=1; AJvYcCUn4au04MWwdVjELx8+kGz+cP3BjrgDCABpXYAZF+t0oc2DL6BlZ2Obhviz9+XQ6XWBCzkZ5IVBqqEUN2QBGP2BLv9PvfkynpBF1R2JqPJNrDEMD78IUtqiAqRwehJEavUydgYVvbG4Rivv/BS1mkro7PxucwwTqpTSz+KdvtbmCnlvEA==
X-Gm-Message-State: AOJu0YwV4q9zYiFZQKvyMsBFRRnLr28epZo+pOPeBysQd88xjG+y6Vjb
	DHy2tG82lWhU0IDcEwGfToSm4OByMxKLKk60PyFBqngKqdWaFvn0CXHEL9KB
X-Google-Smtp-Source: AGHT+IGXrK591hj3hABFljdZRz43asx7yRqpdEIWY8sPqqC54ulXCqVUZ2fyaKMrPebr4TOku8xTxA==
X-Received: by 2002:a5d:6da6:0:b0:343:30a2:3a3d with SMTP id u6-20020a5d6da6000000b0034330a23a3dmr16258824wrs.62.1713373284421;
        Wed, 17 Apr 2024 10:01:24 -0700 (PDT)
Received: from spiri.. ([86.124.122.31])
        by smtp.gmail.com with ESMTPSA id g2-20020adff3c2000000b00343300a4eb8sm17949441wrp.49.2024.04.17.10.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:01:24 -0700 (PDT)
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
Subject: [PATCH v6 5/5] iio: adc: ad7192: Add AD7194 support
Date: Wed, 17 Apr 2024 20:00:54 +0300
Message-Id: <20240417170054.140587-6-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417170054.140587-1-alisa.roman@analog.com>
References: <20240417170054.140587-1-alisa.roman@analog.com>
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

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/Kconfig  |  11 +++-
 drivers/iio/adc/ad7192.c | 122 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 126 insertions(+), 7 deletions(-)

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
index 8d56cf889973..dc113405f1bc 100644
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
 
@@ -169,6 +180,7 @@ enum {
 	ID_AD7190,
 	ID_AD7192,
 	ID_AD7193,
+	ID_AD7194,
 	ID_AD7195,
 };
 
@@ -178,6 +190,7 @@ struct ad7192_chip_info {
 	const struct iio_chan_spec	*channels;
 	u8				num_channels;
 	const struct iio_info		*info;
+	int (*parse_channels)(struct iio_dev *indio_dev);
 };
 
 struct ad7192_state {
@@ -931,6 +944,15 @@ static const struct iio_info ad7192_info = {
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
@@ -1022,6 +1044,84 @@ static const struct iio_chan_spec ad7193_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(14),
 };
 
+static int ad7194_parse_channel(struct fwnode_handle *child,
+				struct iio_chan_spec *ad7194_channel)
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
+	ad7194_channel->channel = ain[0];
+	ad7194_channel->channel2 = ain[1];
+	ad7194_channel->address = AD7194_CH_DIFF(ain[0], ain[1]);
+
+	return 0;
+}
+
+static int ad7194_parse_channels(struct iio_dev *indio_dev)
+{
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
+	ad7194_channels = devm_kcalloc(dev, num_channels,
+				       sizeof(*ad7194_channels), GFP_KERNEL);
+	if (!ad7194_channels)
+		return -ENOMEM;
+
+	indio_dev->channels = ad7194_channels;
+	indio_dev->num_channels = num_channels;
+
+	device_for_each_child_node(dev, child) {
+		*ad7194_channels = ad7194_chan_diff;
+		ad7194_channels->scan_index = index++;
+		ret = ad7194_parse_channel(child, ad7194_channels);
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
+		*ad7194_channels = ad7194_chan;
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
@@ -1044,6 +1144,12 @@ static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 		.num_channels = ARRAY_SIZE(ad7193_channels),
 		.info = &ad7192_info,
 	},
+	[ID_AD7194] = {
+		.chip_id = CHIPID_AD7194,
+		.name = "ad7194",
+		.info = &ad7194_info,
+		.parse_channels = ad7194_parse_channels,
+	},
 	[ID_AD7195] = {
 		.chip_id = CHIPID_AD7195,
 		.name = "ad7195",
@@ -1148,9 +1254,15 @@ static int ad7192_probe(struct spi_device *spi)
 
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = st->chip_info->channels;
-	indio_dev->num_channels = st->chip_info->num_channels;
 	indio_dev->info = st->chip_info->info;
+	if (st->chip_info->parse_channels) {
+		ret = st->chip_info->parse_channels(indio_dev);
+		if (ret)
+			return ret;
+	} else {
+		indio_dev->channels = st->chip_info->channels;
+		indio_dev->num_channels = st->chip_info->num_channels;
+	}
 
 	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7192_sigma_delta_info);
 	if (ret)
@@ -1189,6 +1301,7 @@ static const struct of_device_id ad7192_of_match[] = {
 	{ .compatible = "adi,ad7190", .data = &ad7192_chip_info_tbl[ID_AD7190] },
 	{ .compatible = "adi,ad7192", .data = &ad7192_chip_info_tbl[ID_AD7192] },
 	{ .compatible = "adi,ad7193", .data = &ad7192_chip_info_tbl[ID_AD7193] },
+	{ .compatible = "adi,ad7194", .data = &ad7192_chip_info_tbl[ID_AD7194] },
 	{ .compatible = "adi,ad7195", .data = &ad7192_chip_info_tbl[ID_AD7195] },
 	{}
 };
@@ -1198,6 +1311,7 @@ static const struct spi_device_id ad7192_ids[] = {
 	{ "ad7190", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7190] },
 	{ "ad7192", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7192] },
 	{ "ad7193", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7193] },
+	{ "ad7194", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7194] },
 	{ "ad7195", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7195] },
 	{}
 };
@@ -1214,6 +1328,6 @@ static struct spi_driver ad7192_driver = {
 module_spi_driver(ad7192_driver);
 
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
-MODULE_DESCRIPTION("Analog Devices AD7190, AD7192, AD7193, AD7195 ADC");
+MODULE_DESCRIPTION("Analog Devices AD7192 and similar ADC");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
-- 
2.34.1


