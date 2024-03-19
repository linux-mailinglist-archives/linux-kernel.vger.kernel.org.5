Return-Path: <linux-kernel+bounces-106859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E789287F494
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7827B282DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5994814011;
	Tue, 19 Mar 2024 00:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipWecq1T"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4978BE2;
	Tue, 19 Mar 2024 00:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710808183; cv=none; b=QtmMm6bdzgoXcXUZQ7TlBegxAdPY2UkI8+YKNODGDUwGHvBd2uaCvGiQQI9OvRleW/diKuT5a6O8RhBI0Q7ps2wHjkNiKGeJgYrV+WKdP1e5Rd+n2i1nWqlKRXeBZ3tAv2Qj/QbA0I7LIEDQIj8BGpwsH7EjBU5FnRsjR2k+7JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710808183; c=relaxed/simple;
	bh=l7f6Z0XDhtNxCIB1P4UObxHpCLmdQD4EPCI2L4JO+xM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RCcQti6MULUdm6m9NhIFAsxp61im6LGsHJLTMGZ9Kr9+PDnVUj45zf63eLMY+6KrvfsyZPATpC3zbYcbu7ePlJduuOtSq1pjJwGXmYsK6E4ZKfRB1wUcfnTbw5cQgwUjy+8eRjQay+FZk1spMTqA+9m03lGWAHX6FrnZAaiu+SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipWecq1T; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d220e39907so72166201fa.1;
        Mon, 18 Mar 2024 17:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710808179; x=1711412979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfvj86vKtlcJm2UnyEfOzzQiI5fSWunqj8tDd9RzXJI=;
        b=ipWecq1TvO63Tk6GBzGY37lkI7ztFZeG8Yg6+G+F1o2qE3tDIesa2c3bHro60acz+d
         oWVwwDhg4is55sf4utmWdaiE4JjJMdAxK3ZuUIwbg9MFpuwHCpeeIgME8K8IXT7zoQ0G
         xMBbLlmV1gr0DYE6LWSsdhvkBICDJl6Ny2ow3+TGRPIadD+cRyaZjXklz8S/BxJZDds7
         CxdXd9vAuYHim09YoQfmnbkZUdYvDTZhXZxDC69I01u3TnKxMHiJohXK+GTey/uL4JWV
         CavMGZGUf6s6Xv6eA5gg5Yj7pScWI/fPA3e89TeekPjnm0ioB3LtK6hu4QGfG+O8p7hm
         3udA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710808179; x=1711412979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfvj86vKtlcJm2UnyEfOzzQiI5fSWunqj8tDd9RzXJI=;
        b=KA0ppD75Br/mjXICzW7za6EeeDOoCtBXqXKTHQr9wsLsym/mqZvr51JZBTN8Jdv4Ft
         0dVI056OlPNKqe7XvkXqEK1R2Hi3FYi402m5haHoyCjLJlzURA4MWXcvjbpSitPYJpSQ
         xitOyBHYaljxSJHHmBtjQJ+ym4TvgjBnk5drBFlSNO4CtOY2OGnhgdARZsGG2Y8Ul5zT
         ndC1GLx3rw6kn3HpyhMiZEkjJDvH0FK4O9glqUK8FIXHyOFBU52STD4zdLL9cmJNjrRQ
         zNkCfYs3GQQW0/HTibL0xb+R5QR0MLY8ChaWT2qSDidNewBcSWTxZqBk0TV8CwTI/UqF
         R/Qw==
X-Forwarded-Encrypted: i=1; AJvYcCU+PZf+0NQWWDV4eKjdAh6xkCQIiTr7rNGrMV9SQmYbIDjJJ+se643hT4SH/yg1TQO1SsxA5v3kZ2LbBWbAWzVf7ym8Ff13ViWQRun249Y78jiX8NzDLvpiX/ilrThLtHvlzjukkmQS
X-Gm-Message-State: AOJu0YwK82UmghRc6y6Fg26Ta0+as30Et2f8Db/pqohdp4r8k5mKpxZv
	XmASxPatOp6sFwbD+Ey0a1qCihq1JDFyeJQYnJqHUrJkqgDwnPwW
X-Google-Smtp-Source: AGHT+IHtR9z2o+YMCMEKWpxs/XoUaMWovrA1ziNOe8ZNTiJ/92HpfzqQFvC9qkyqLPe+MFmd1cVEOA==
X-Received: by 2002:a2e:3508:0:b0:2d4:96ae:2d9d with SMTP id z8-20020a2e3508000000b002d496ae2d9dmr6002145ljz.33.1710808179196;
        Mon, 18 Mar 2024 17:29:39 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:8c96:c55f:eab0:860])
        by smtp.gmail.com with ESMTPSA id co24-20020a0564020c1800b00568c613570dsm2700227edb.79.2024.03.18.17.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 17:29:38 -0700 (PDT)
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
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v3 5/6] iio: pressure: Add timestamp and scan_masks for BMP280 driver
Date: Tue, 19 Mar 2024 01:29:24 +0100
Message-Id: <20240319002925.2121016-6-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240319002925.2121016-1-vassilisamir@gmail.com>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The scan mask for the BME280 supports humidity measurement and
needs to be distinguished from the rest in order for the timestamp
to be able to work.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 111 +++++++++++++++++++++++++----
 drivers/iio/pressure/bmp280.h      |   1 +
 2 files changed, 98 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 312bc2617583..ddfcd23f29a0 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -134,7 +134,28 @@ enum {
 	BMP380_P11 = 20,
 };
 
+enum bmp280_scan {
+	BMP280_TEMP,
+	BMP280_PRESS,
+	BME280_HUMID
+};
+
 static const struct iio_chan_spec bmp280_channels[] = {
+	{
+		.type = IIO_TEMP,
+		/* PROCESSED maintained for ABI backwards compatibility */
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
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
 		/* PROCESSED maintained for ABI backwards compatibility */
@@ -142,7 +163,18 @@ static const struct iio_chan_spec bmp280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
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
 		/* PROCESSED maintained for ABI backwards compatibility */
@@ -150,28 +182,48 @@ static const struct iio_chan_spec bmp280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
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
 		/* PROCESSED maintained for ABI backwards compatibility */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
 				      BIT(IIO_CHAN_INFO_RAW) |
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
 		/* PROCESSED maintained for ABI backwards compatibility */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
 				      BIT(IIO_CHAN_INFO_RAW) |
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
 		/* PROCESSED maintained for ABI backwards compatibility */
@@ -181,9 +233,16 @@ static const struct iio_chan_spec bmp380_channels[] = {
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
 		/* PROCESSED maintained for ABI backwards compatibility */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
 				      BIT(IIO_CHAN_INFO_RAW) |
@@ -191,7 +250,15 @@ static const struct iio_chan_spec bmp380_channels[] = {
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
@@ -825,6 +892,16 @@ static const struct iio_info bmp280_info = {
 	.write_raw = &bmp280_write_raw,
 };
 
+static const unsigned long bmp280_avail_scan_masks[] = {
+	BIT(BMP280_PRESS) | BIT(BMP280_TEMP),
+	0
+};
+
+static const unsigned long bme280_avail_scan_masks[] = {
+	BIT(BME280_HUMID) | BIT(BMP280_PRESS) | BIT(BMP280_TEMP),
+	0
+};
+
 static int bmp280_chip_config(struct bmp280_data *data)
 {
 	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
@@ -866,7 +943,8 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.regmap_config = &bmp280_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
-	.num_channels = 2,
+	.num_channels = 3,
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp280_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
@@ -925,8 +1003,9 @@ const struct bmp280_chip_info bme280_chip_info = {
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
@@ -1300,7 +1379,8 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.regmap_config = &bmp380_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
-	.num_channels = 2,
+	.num_channels = 3,
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp380_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp380_oversampling_avail),
@@ -1795,7 +1875,8 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.regmap_config = &bmp580_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
-	.num_channels = 2,
+	.num_channels = 3,
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp580_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp580_oversampling_avail),
@@ -2054,7 +2135,8 @@ const struct bmp280_chip_info bmp180_chip_info = {
 	.regmap_config = &bmp180_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
-	.num_channels = 2,
+	.num_channels = 3,
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp180_oversampling_temp_avail,
 	.num_oversampling_temp_avail =
@@ -2166,6 +2248,7 @@ int bmp280_common_probe(struct device *dev,
 	/* Apply initial values from chip info structure */
 	indio_dev->channels = chip_info->channels;
 	indio_dev->num_channels = chip_info->num_channels;
+	indio_dev->available_scan_masks = chip_info->avail_scan_masks;
 	data->oversampling_press = chip_info->oversampling_press_default;
 	data->oversampling_humid = chip_info->oversampling_humid_default;
 	data->oversampling_temp = chip_info->oversampling_temp_default;
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 6d1dca31dd52..8cc3eed70c18 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -427,6 +427,7 @@ struct bmp280_chip_info {
 	const struct iio_chan_spec *channels;
 	int num_channels;
 	unsigned int start_up_time;
+	const unsigned long *avail_scan_masks;
 
 	const int *oversampling_temp_avail;
 	int num_oversampling_temp_avail;
-- 
2.25.1


