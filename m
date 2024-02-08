Return-Path: <linux-kernel+bounces-58454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3304084E6B2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB391F2C056
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4CD1272A2;
	Thu,  8 Feb 2024 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiZbUpof"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9014286ACF;
	Thu,  8 Feb 2024 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413146; cv=none; b=qMNcw5Rf6HPzgJWNmDvbyXLWyg3cwFg/tXB/RqwqICj03QV5ESJUFCOkBUshhG4LJAuo9UebzfDm+7YVHegKr2RN8dxkFXL9Ct5eYxyqVV0tBzfdrdJMJxABUtJOFV/FBQLzoVmfiAj77WLM6qIaPqyJyfieZteNsrAet9ppur4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413146; c=relaxed/simple;
	bh=1HQw7aGBJQueXsgK8nlu0IkoBW2nbmv0iJsbuP5EPAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rcO+AUlfXZuWizG6sBpr8bbrNoxm2+9rf02FGK/BkEavtUxEABT4jegnG1Zxzednp2ss1V97V56c+V75p8fZzvo06EE6FJYGRoWFQBKTCt43Zol23mW0gqvzm6tfNfFUQFiSV7WTW7+R8f8umIBKDDrMLbJsalfglp2bi0PtBSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiZbUpof; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4104ebb050fso808315e9.2;
        Thu, 08 Feb 2024 09:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707413143; x=1708017943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvcPIhBw0ZkFOGOMebGpiUEgt1YSGQvRZVRF+GXWk7A=;
        b=fiZbUpofqYNLhg5pfCyucF3GK57BEB6e+a0uDT0tC0tHSwL3cqbBAG8u3lvYBpI8aQ
         EMT3qDjp8he1b6gxLGMrm/CZNS/QyYChwdnQrw9vSGqmC9ifKOA35u62lmYwSfupJpSl
         BJt/xgU+r3Dwdh8rR3LyX0InKu3Zh84GQ//6eJtmiaRRU1xPed0NhEIshfdokTbdeKzg
         xpg50+8rctJjI6awTQ62u+nqzNQ//uBNVhQyXjzrcBr8UZjLoTBVQQ+okvjqXicKmHuc
         fHMQrLAL6b0KiEpTSrOOevFzLUjmrHzFmwE2xQ7QUAoMPh7zMCmFJdDAiZJaCd5mXRbG
         cR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707413143; x=1708017943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvcPIhBw0ZkFOGOMebGpiUEgt1YSGQvRZVRF+GXWk7A=;
        b=cJOPAO4kv25xNd8lE/pu1KJo1FCE3bNrxHHLC+v7KKJeF3kFON2jwGQP2jqqeZ1dEB
         koZmjmVjvBVDpSMHWc8g0SVZYuIFWAJQIYWJFr7JkcgcKM42N9VauxeMlrbjcQy6ycgL
         LExc9UOV83IEYf75WaH8sOZMKXCveu9M//4Wb+7oOFj++vd4Nj+K9XELuUT0FNKYBbKd
         onKNN38vo3+y0rkzqzzlVxQsAHnzTu1A4Sdeh3bh72U0MI7wDw9NCbw9W6k1Cp2mr6nB
         djQyDEsN0uBGqnYcqrdCI3n7NTuE2Fxuay5kA/0WJACVIHlz0NDLpY3qA5MwKi+VN/aO
         oBvA==
X-Forwarded-Encrypted: i=1; AJvYcCVDSLZJe31S1Frs5wshu7t9/O6ezGi2TE7lEhxTU3ixq06lSbOU43elRTH4vm0u4XwZyp6Q276mFM9FS6Fe+RQEAwbxnmj+BHXR8BBFMakvD8qTj0qiNm0eVx50vIH9+xsG2hRT0+AA/g8ct3wILs1TPJjF9eeed2ZSf+ERaY26asXakA==
X-Gm-Message-State: AOJu0Yz4NfunG8BEsaEDdtGPbWSszSY+U0AnWoOfj6TA39DWIVr5AQvv
	WYUMHhvmbHZqrbzmqC/E/3rC6xwRyJNyBFZv/c398DIApelWhUQ5
X-Google-Smtp-Source: AGHT+IF9At71rGC6pYv2iefQSIxVwLKN9azFRD3wnCS2og3xiH5ZWxJuurHMh3wZ3zHZZ1nZWamF6g==
X-Received: by 2002:a05:600c:1994:b0:40e:f8a2:4a8e with SMTP id t20-20020a05600c199400b0040ef8a24a8emr12943wmq.15.1707413142561;
        Thu, 08 Feb 2024 09:25:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUy2Lx9C0JEW11MumnivrJ0/F/oIJy2+qqQ305t5zacf//2NKr2KDDy6hOB5dMNjvjZrppYeWUKhikiaPC+8ywvx3TEkYYl0KcBsQXkGXzwXIUeWlhXNG5BEuq3ZfUSsvNqSY/WdGR0iwKUgIRRK0WVuUSRqU0tK9XNGQxfILrwicQOxZNBQu5st4RCr8BT2gyGqvjG6ub8PB1q+0Oai1CjCTSyBsJsI7YREwg94CVw/rAkV/22dnMty+XSpE3M22Qj5OoBqv+QV5gh9YK7Zgyl0iku15JaCLpOEeSwneitNRelwAQ4Z49vhYzjXj/V7mAUQaIrEXLsSbwspQttHR7dSn263vr2cuXxTrQHu2PEkEUgbwf89TGQ+d1rN9Oro0V1lPT/xsfl9MqBVYbycXQixGgpJciSX70pvtcaVpDd5W4RNS4zyalhTuVVVF3eHinBSvuHUzXAOU9lPQsFJDaXkUUv11WjIj+ALF2N+/ywf2pTsu1pSjxrfU5EOk6Bh4sOzQp31FzF7SAwZQ==
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b004101f27737asm2238214wmo.29.2024.02.08.09.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:25:42 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: 
Cc: alexandru.tachici@analog.com,
	alisa.roman@analog.com,
	alisadariana@gmail.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.hennerich@analog.com,
	robh+dt@kernel.org,
	Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v3 5/5] iio: adc: ad7192: Add AD7194 support
Date: Thu,  8 Feb 2024 19:24:59 +0200
Message-Id: <20240208172459.280189-6-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208172459.280189-1-alisa.roman@analog.com>
References: <20240208172459.280189-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike the other AD719Xs, AD7194 has configurable differential
channels. The default configuration for these channels can be changed
from the devicetree.

The default configuration is hardcoded in order to have a stable number
of channels.

Also modify config AD7192 description for better scaling.

Moved ad7192_chip_info struct definition to allow use of callback
function parse_channels().

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/Kconfig  |  11 ++-
 drivers/iio/adc/ad7192.c | 150 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 148 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 59ae1d17b50d..8062a4d1cbe7 100644
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
index d8393ac048e7..a3ff60ed6f63 100644
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
 
@@ -166,17 +195,10 @@ enum {
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
@@ -197,6 +219,15 @@ struct ad7192_state {
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
@@ -918,6 +949,15 @@ static const struct iio_info ad7192_info = {
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
@@ -1009,6 +1049,80 @@ static const struct iio_chan_spec ad7193_channels[] = {
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
@@ -1031,6 +1145,14 @@ static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
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
@@ -1142,6 +1264,12 @@ static int ad7192_probe(struct spi_device *spi)
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
@@ -1153,6 +1281,7 @@ static const struct of_device_id ad7192_of_match[] = {
 	{ .compatible = "adi,ad7190", .data = &ad7192_chip_info_tbl[ID_AD7190] },
 	{ .compatible = "adi,ad7192", .data = &ad7192_chip_info_tbl[ID_AD7192] },
 	{ .compatible = "adi,ad7193", .data = &ad7192_chip_info_tbl[ID_AD7193] },
+	{ .compatible = "adi,ad7194", .data = &ad7192_chip_info_tbl[ID_AD7194] },
 	{ .compatible = "adi,ad7195", .data = &ad7192_chip_info_tbl[ID_AD7195] },
 	{}
 };
@@ -1162,6 +1291,7 @@ static const struct spi_device_id ad7192_ids[] = {
 	{ "ad7190", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7190] },
 	{ "ad7192", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7192] },
 	{ "ad7193", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7193] },
+	{ "ad7194", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7194] },
 	{ "ad7195", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7195] },
 	{}
 };
@@ -1178,6 +1308,6 @@ static struct spi_driver ad7192_driver = {
 module_spi_driver(ad7192_driver);
 
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
-MODULE_DESCRIPTION("Analog Devices AD7190, AD7192, AD7193, AD7195 ADC");
+MODULE_DESCRIPTION("Analog Devices AD7192 and similar ADC");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
-- 
2.34.1


