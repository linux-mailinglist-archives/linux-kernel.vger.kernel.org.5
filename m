Return-Path: <linux-kernel+bounces-89832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2593D86F63B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98B1D1F23214
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18136D51F;
	Sun,  3 Mar 2024 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFKiGhKU"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D556F534;
	Sun,  3 Mar 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709484796; cv=none; b=R42PEkPzBQaVRAZGnkB9jP9q7+CGhmeaDqf48LEzmRZzMBvvA0We5og8iQ5N/BVhU0xoIaZdNNfBAaKXBeBjFu1P4v0uAtKRDyZoxjnGLiDcCUBOTUvMu9zCFB/7ESsJFkK2vMMe+eh3OR5/rJ/8BORUpe2sjn6O0z1r3/d/Eyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709484796; c=relaxed/simple;
	bh=bNnxFftLPMdf7q3HsaLS/01VslR/IOK6Av5LVYV91qI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JJRHNtREw7igwt71W1FzM96AXio3+eDHVFNDnUxSgmVojpNOVf48f+duOkYQV1i3TuMSS4YydWF7sApNB82B6VlH2t82p4aHqmto0OMtJLgUzyCX9uYP+SbWsEwbavi2/wThdq9mxyH5fGnUWR2mAqDM3rMAPFPFFnk3z4os3y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFKiGhKU; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5131c0691feso4566221e87.1;
        Sun, 03 Mar 2024 08:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709484792; x=1710089592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5saPLXm4A0oh+uwK5Efp69UNd7Y9kGQOB8iQdyZT3QE=;
        b=IFKiGhKUFwG5UY1XtQjU1ykl0HKGVKztIb7NosiHaZ4NwlsV1JqJ7DCBAdbKQ42k9f
         GNfP3JrDEOh/irORDBuEoAuH9UxqFnRnpyHUTjMtJrqYzemu1pNfXnLvUIdqCERuW97H
         J5hRwaZnA9sLc+ljVJ9yYuUjK6qUR/BmdfCQjui/ry6W3McGgYM5XA7bvHKdPjtiLMpc
         ydaNHpx8SrcuV9zq8xUaNUzE489moU6KELV7q6ve2DYVl9yTyHdwEcSBaZ9U2Hw7n9rW
         k4jMpmVhSvFiO+1IZQbcLFoRMoI9ZyMVMirgZDZbtQWUZW0BC5nTL2JkSlqQAXL6i3Be
         LBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709484792; x=1710089592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5saPLXm4A0oh+uwK5Efp69UNd7Y9kGQOB8iQdyZT3QE=;
        b=Nu5/ei7Xm6RO/mhBiT6GC1Tav2500VhdGkAoGjiiK9td+RrBNzLMKnAto/yhfjDSK1
         uCbgr1r6phpiiNxIrZ9/AcuF9ZLBfx7MJ2TMHtZBQXLQr3jvxClLLPj2WzH5gKvuZurE
         rxA/NzaX7E4ej/4XE+qWReDKLaN/c3HerFgN4Uaj12g8L8iTO5pmuiF3RFqcgqhcLVXw
         SksZT1/7KbQkb1dTxgApMDMO0UUAf4yEtuY/vALXSUyAWcVV70P9ZAarAwF+yES2LJr7
         kxQ1fEPM20BPIutqj7ESekIAlxvb0HCZUDFudY4xtsTvOUvUgWMMOer79EoQgnuHZ27W
         Gd+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXW7kfynKv00T6sqelrRoTuSIZb9tB/wap5BWqU4iZlo+0IqoWOt2ctKhuL06Kh7gaT4wq3V33rB3Xfclaa71RriY2SM8Njgs8OLgtUWklJ97JWJbfvbcUHunfqdyPKjWpZ6YsYpcFf
X-Gm-Message-State: AOJu0YxqIZ9rsoiDoYF1JT6qPtrJLDVzlNX6/G8zkcZXcrDHdqa35kLO
	phgNxB61Uamy7U4KXzzFPqXCLtw/IL3Y72xbiCIg45YPQnqk3rtw
X-Google-Smtp-Source: AGHT+IFRjPG0V3oZ18GlJzZ+Cb6FNCWz/92E47uZgIKx6pU3nz0gB3lwFVhTO15rAdHE+MVhluXiKA==
X-Received: by 2002:a05:6512:3a83:b0:513:39c8:10f2 with SMTP id q3-20020a0565123a8300b0051339c810f2mr3508767lfu.30.1709484792128;
        Sun, 03 Mar 2024 08:53:12 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:82:7577:d4e3:724b:4d69:34b2])
        by smtp.gmail.com with ESMTPSA id lh15-20020a170906f8cf00b00a44f14c8d64sm1413992ejb.135.2024.03.03.08.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 08:53:11 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	petre.rodan@subdimension.ro,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH 3/4] iio: pressure: Add timestamp and scan_masks for BMP280 driver
Date: Sun,  3 Mar 2024 17:52:59 +0100
Message-Id: <20240303165300.468011-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240303165300.468011-1-vassilisamir@gmail.com>
References: <20240303165300.468011-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The scan mask for the BME280 device which contains humidity
measurement needs to become different in order for the timestamp
to be able to work. Scan masks are added for different combinations
of measurements. The temperature measurement is needed for either
pressure or humidity measurements.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 113 +++++++++++++++++++++++++----
 drivers/iio/pressure/bmp280.h      |   1 +
 2 files changed, 100 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index acdf6138d317..3bdf6002983f 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -134,36 +134,86 @@ enum {
 	BMP380_P11 = 20,
 };
 
+enum bmp280_scan {
+	BMP280_TEMP,
+	BMP280_PRESS,
+	BME280_HUMID,
+};
+
 static const struct iio_chan_spec bmp280_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
+	},
 	{
 		.type = IIO_PRESSURE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
+};
+
+static const struct iio_chan_spec bme280_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
 	{
-		.type = IIO_HUMIDITYRELATIVE,
+		.type = IIO_PRESSURE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
-};
-
-static const struct iio_chan_spec bmp380_channels[] = {
 	{
-		.type = IIO_PRESSURE,
+		.type = IIO_HUMIDITYRELATIVE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.scan_index = 2,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+static const struct iio_chan_spec bmp380_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
@@ -171,15 +221,30 @@ static const struct iio_chan_spec bmp380_channels[] = {
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
 	{
-		.type = IIO_HUMIDITYRELATIVE,
+		.type = IIO_PRESSURE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
 static int bmp280_read_calib(struct bmp280_data *data)
@@ -835,6 +900,20 @@ static const struct iio_info bmp280_info = {
 	.write_raw = &bmp280_write_raw,
 };
 
+static const unsigned long bmp280_avail_scan_masks[] = {
+	BIT(BMP280_TEMP),
+	BIT(BMP280_PRESS) | BIT(BMP280_TEMP),
+	0,
+};
+
+static const unsigned long bme280_avail_scan_masks[] = {
+	BIT(BMP280_TEMP),
+	BIT(BMP280_PRESS) | BIT(BMP280_TEMP),
+	BIT(BME280_HUMID) | BIT(BMP280_TEMP),
+	BIT(BME280_HUMID) | BIT(BMP280_PRESS) | BIT(BMP280_TEMP),
+	0,
+};
+
 static int bmp280_chip_config(struct bmp280_data *data)
 {
 	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
@@ -874,7 +953,8 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.regmap_config = &bmp280_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
-	.num_channels = 2,
+	.num_channels = 3,
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp280_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
@@ -927,8 +1007,9 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.num_chip_id = ARRAY_SIZE(bme280_chip_ids),
 	.regmap_config = &bmp280_regmap_config,
 	.start_up_time = 2000,
-	.channels = bmp280_channels,
-	.num_channels = 3,
+	.channels = bme280_channels,
+	.num_channels = 4,
+	.avail_scan_masks = bme280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp280_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
@@ -1305,7 +1386,8 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.regmap_config = &bmp380_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
-	.num_channels = 2,
+	.num_channels = 3,
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp380_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp380_oversampling_avail),
@@ -1807,7 +1889,8 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.regmap_config = &bmp580_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
-	.num_channels = 2,
+	.num_channels = 3,
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp580_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp580_oversampling_avail),
@@ -2072,7 +2155,8 @@ const struct bmp280_chip_info bmp180_chip_info = {
 	.regmap_config = &bmp180_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
-	.num_channels = 2,
+	.num_channels = 3,
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp180_oversampling_temp_avail,
 	.num_oversampling_temp_avail =
@@ -2179,6 +2263,7 @@ int bmp280_common_probe(struct device *dev,
 	/* Apply initial values from chip info structure */
 	indio_dev->channels = chip_info->channels;
 	indio_dev->num_channels = chip_info->num_channels;
+	indio_dev->available_scan_masks = chip_info->avail_scan_masks;
 	data->oversampling_press = chip_info->oversampling_press_default;
 	data->oversampling_humid = chip_info->oversampling_humid_default;
 	data->oversampling_temp = chip_info->oversampling_temp_default;
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 4012387d7956..d77402cb3121 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -426,6 +426,7 @@ struct bmp280_chip_info {
 
 	const struct iio_chan_spec *channels;
 	int num_channels;
+	const unsigned long *avail_scan_masks;
 	unsigned int start_up_time;
 
 	const int *oversampling_temp_avail;
-- 
2.25.1


