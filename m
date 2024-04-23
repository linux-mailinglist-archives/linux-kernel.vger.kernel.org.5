Return-Path: <linux-kernel+bounces-154719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D80C68AE020
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F288281E34
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF689768F0;
	Tue, 23 Apr 2024 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+KGpn32"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF1D612F5;
	Tue, 23 Apr 2024 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861767; cv=none; b=rVAq1VLqUYwnhfb+YaLBHDsCh9QBOC4A4qwGQPzeKkTugbP2DTRXgwvsBKN73QXpR7Vx80w2pMf+Mx+kM5F5oXywTuIAwbHQ+yrcVuHpu/ITpMV6ly2BjU6YkomiuL7jaVvLgAzXZm1CHQUIAvsr4daFKw1Y57ic84gImxNWPhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861767; c=relaxed/simple;
	bh=L/dV8VBeeiLpiO/7u7guKB1YnfK6Zy2VJWhiirSr000=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQEz4NpW0Mqr1VD55p7M0Amw/6yAQR3rn0xhgA8aJwbr/MnYX/h9f7r2SLTbq2OHzCK/d6XCuvmkvID18Ni4CVDVcvKNi8S6gR+e1MAxsSYITusDwE/JQbmXIIQgRqq+o9HMCN88eCOaChG+6jGj0YqF6m1dLS3vrq9kuc+lZXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+KGpn32; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-346406a5fb9so4283988f8f.1;
        Tue, 23 Apr 2024 01:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713861763; x=1714466563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YB73JlYFnDlcsmhQl4eDUMeA5RC0hbTDUOZZngCdft0=;
        b=M+KGpn320zTTb4AwjloKmMb7YGHBcRMLMFTzuMxqZlNYcrHJOSBl0Zri4l6HgcQyp/
         bN7bHlKogx/bc0W53a070qbYpdobGXp7ex0frrKQWcy+CglC4TcGbFf2bkNaFaUMzLnW
         DDdp61xQh5/HacaubJrCGBTTDXTXM8ko+68m8C6CzXgaGZrRNE7ok+QZzFF+cQY4/xDU
         ESIEU+xzFNbFUxn+M5aQL5i7+HVSIcistrvhdDD1l1W/TZm2GFwXx2DPgh/IVkhFMLWT
         evd0Jt/KcNh4L5wiO8nKjc869fo4ziH5KTnOIu7tD6H/dfrh7M8YAHK2NSJUYD1puWYv
         Syzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713861763; x=1714466563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YB73JlYFnDlcsmhQl4eDUMeA5RC0hbTDUOZZngCdft0=;
        b=Us5FClsZJGCdGAri6JnX2ESgPvrq0mED4nFb3qoZkkBlCo4Hh/bLxc5dcCmf1iysiy
         4968SBh6o8Mk+IfCy1M3IxpXXxgwZfbUnv69Sdk2tyAbnKWyQlUHRwM4cNffAJdjtlFi
         fkqO7GfBbelcz5+eRNF95g5DVhxt7F1kIK0tnqHoN6oSsK3s6O3ftmxYW4+Y1S8kcbKw
         pFMJDQVu4P9mQt0hC/nNDf2wp1wn6INPLvygVsV8QRqHaP64JrX++CdDmXbzSP0JZltD
         D66Dl71ygxOLc7HsLUDO5LytyfsEDz1iCnJhNY0SVvoMD7v6/EVFrZNXWaQzPaGxO73X
         gmlw==
X-Forwarded-Encrypted: i=1; AJvYcCWVZy+USyLf0nG7mNQh2eT/m9XF7xWMvfoSydiqEFUh7B31ZJVHtmXD0KrUhy4nE6/t7RuTkarw71CBfF4TFfMmoarLpy1Vi39d+Of3lzAvk6c5O3vjiKBQS3/Zpu0Ohvau6HKR5sH/FHVTHEWnINSu9pvRz9THisiGRk4VIvGdMA==
X-Gm-Message-State: AOJu0YxoWRgWaVvuz0tSHZGJcE2Ht/j+YWWI5yVxEfads3/a50fIau7C
	ErieUxLouYbVRkNF8LsQk7+/demq/4EZca0hXpWF/fmFVEUIopbgRSGwtkry
X-Google-Smtp-Source: AGHT+IFY9Z3ReQGE26+JVhbT5WRDbGHx17yXXryb9m9b2s8B+25k3imAZ1LgRnIakpPKmYXcwsDv8Q==
X-Received: by 2002:a05:6000:23a:b0:346:ab3c:1753 with SMTP id l26-20020a056000023a00b00346ab3c1753mr7658906wrz.40.1713861763092;
        Tue, 23 Apr 2024 01:42:43 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:320d:e800:cce2:61fe:1efc:ce48])
        by smtp.gmail.com with ESMTPSA id a16-20020adffb90000000b0034af18ef68csm5989939wrr.5.2024.04.23.01.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 01:42:42 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
X-Google-Original-From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	corbet@lwn.net,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 4/5] iio: adis16480: add support for adis16545/7 families
Date: Tue, 23 Apr 2024 11:42:09 +0300
Message-Id: <20240423084210.191987-5-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423084210.191987-1-ramona.gradinariu@analog.com>
References: <20240423084210.191987-1-ramona.gradinariu@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ADIS16545 and ADIS16547 are a complete inertial system that
includes a triaxis gyroscope and a triaxis accelerometer.
The serial peripheral interface (SPI) and register structure provide a
simple interface for data collection and configuration control.

These devices are similar to the ones already supported in the driver,
with changes in the scales, timings and the max spi speed in burst
mode.
Also, they support delta angle and delta velocity readings in burst
mode, for which support was added in the trigger handler.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
---
 drivers/iio/imu/adis16480.c | 222 ++++++++++++++++++++++++++++++++++--
 1 file changed, 215 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 4adc2244a4ef..e0020b7b5fb5 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -132,6 +132,10 @@
 #define ADIS16480_SYNC_MODE_MSK		BIT(8)
 #define ADIS16480_SYNC_MODE(x)		FIELD_PREP(ADIS16480_SYNC_MODE_MSK, x)
 
+#define ADIS16545_BURST_DATA_SEL_0_CHN_MASK	GENMASK(5, 0)
+#define ADIS16545_BURST_DATA_SEL_1_CHN_MASK	GENMASK(16, 11)
+#define ADIS16545_BURST_DATA_SEL_MASK		BIT(8)
+
 struct adis16480_chip_info {
 	unsigned int num_channels;
 	const struct iio_chan_spec *channels;
@@ -147,6 +151,7 @@ struct adis16480_chip_info {
 	const unsigned int *filter_freqs;
 	bool has_pps_clk_mode;
 	bool has_sleep_cnt;
+	bool has_burst_delta_data;
 	const struct adis_data adis_data;
 };
 
@@ -170,6 +175,7 @@ struct adis16480 {
 	struct clk *ext_clk;
 	enum adis16480_clock_mode clk_mode;
 	unsigned int clk_freq;
+	u16 burst_id;
 	/* Alignment needed for the timestamp */
 	__be16 data[ADIS16495_BURST_MAX_DATA] __aligned(8);
 };
@@ -882,6 +888,23 @@ static const struct iio_chan_spec adis16485_channels[] = {
 	ADIS16480_DELTVEL_CHANNEL_NO_SCAN(Z),
 };
 
+static const struct iio_chan_spec adis16545_channels[] = {
+	ADIS16480_GYRO_CHANNEL(X),
+	ADIS16480_GYRO_CHANNEL(Y),
+	ADIS16480_GYRO_CHANNEL(Z),
+	ADIS16480_ACCEL_CHANNEL(X),
+	ADIS16480_ACCEL_CHANNEL(Y),
+	ADIS16480_ACCEL_CHANNEL(Z),
+	ADIS16480_TEMP_CHANNEL(),
+	ADIS16480_DELTANG_CHANNEL(X),
+	ADIS16480_DELTANG_CHANNEL(Y),
+	ADIS16480_DELTANG_CHANNEL(Z),
+	ADIS16480_DELTVEL_CHANNEL(X),
+	ADIS16480_DELTVEL_CHANNEL(Y),
+	ADIS16480_DELTVEL_CHANNEL(Z),
+	IIO_CHAN_SOFT_TIMESTAMP(13),
+};
+
 enum adis16480_variant {
 	ADIS16375,
 	ADIS16480,
@@ -894,6 +917,12 @@ enum adis16480_variant {
 	ADIS16497_1,
 	ADIS16497_2,
 	ADIS16497_3,
+	ADIS16545_1,
+	ADIS16545_2,
+	ADIS16545_3,
+	ADIS16547_1,
+	ADIS16547_2,
+	ADIS16547_3
 };
 
 #define ADIS16480_DIAG_STAT_XGYRO_FAIL 0
@@ -975,6 +1004,12 @@ static const struct adis_timeout adis16495_1_timeouts = {
 	.self_test_ms = 20,
 };
 
+static const struct adis_timeout adis16545_timeouts = {
+	.reset_ms = 315,
+	.sw_reset_ms = 270,
+	.self_test_ms = 35,
+};
+
 static const struct adis16480_chip_info adis16480_chip_info[] = {
 	[ADIS16375] = {
 		.channels = adis16485_channels,
@@ -1176,6 +1211,126 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 					    ADIS16495_BURST_MAX_DATA * 2,
 					    6000000),
 	},
+	[ADIS16545_1] = {
+		.channels = adis16545_channels,
+		.num_channels = ARRAY_SIZE(adis16545_channels),
+		.gyro_max_val = 20000 << 16,
+		.gyro_max_scale = IIO_DEGREE_TO_RAD(125),
+		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
+		.accel_max_scale = 8,
+		.temp_scale = 7000, /* 7 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(360),
+		.deltvel_max_val = 100,
+		.int_clk = 4250000,
+		.max_dec_rate = 4250,
+		.filter_freqs = adis16495_def_filter_freqs,
+		.has_pps_clk_mode = true,
+		.has_burst_delta_data = true,
+		/* 20 elements of 16bits */
+		.adis_data = ADIS16480_DATA(16545, &adis16545_timeouts,
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    3200000),
+	},
+	[ADIS16545_2] = {
+		.channels = adis16545_channels,
+		.num_channels = ARRAY_SIZE(adis16545_channels),
+		.gyro_max_val = 18000 << 16,
+		.gyro_max_scale = IIO_DEGREE_TO_RAD(450),
+		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
+		.accel_max_scale = 8,
+		.temp_scale = 7000, /* 7 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+		.deltvel_max_val = 100,
+		.int_clk = 4250000,
+		.max_dec_rate = 4250,
+		.filter_freqs = adis16495_def_filter_freqs,
+		.has_pps_clk_mode = true,
+		.has_burst_delta_data = true,
+		/* 20 elements of 16bits */
+		.adis_data = ADIS16480_DATA(16545, &adis16545_timeouts,
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    3200000),
+	},
+	[ADIS16545_3] = {
+		.channels = adis16545_channels,
+		.num_channels = ARRAY_SIZE(adis16545_channels),
+		.gyro_max_val = 20000 << 16,
+		.gyro_max_scale = IIO_DEGREE_TO_RAD(2000),
+		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
+		.accel_max_scale = 8,
+		.temp_scale = 7000, /* 7 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(2160),
+		.deltvel_max_val = 100,
+		.int_clk = 4250000,
+		.max_dec_rate = 4250,
+		.filter_freqs = adis16495_def_filter_freqs,
+		.has_pps_clk_mode = true,
+		.has_burst_delta_data = true,
+		/* 20 elements of 16bits */
+		.adis_data = ADIS16480_DATA(16545, &adis16545_timeouts,
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    3200000),
+	},
+	[ADIS16547_1] = {
+		.channels = adis16545_channels,
+		.num_channels = ARRAY_SIZE(adis16545_channels),
+		.gyro_max_val = 20000 << 16,
+		.gyro_max_scale = IIO_DEGREE_TO_RAD(125),
+		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
+		.accel_max_scale = 40,
+		.temp_scale = 7000, /* 7 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(360),
+		.deltvel_max_val = 400,
+		.int_clk = 4250000,
+		.max_dec_rate = 4250,
+		.filter_freqs = adis16495_def_filter_freqs,
+		.has_pps_clk_mode = true,
+		.has_burst_delta_data = true,
+		/* 20 elements of 16bits */
+		.adis_data = ADIS16480_DATA(16547, &adis16545_timeouts,
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    3200000),
+	},
+	[ADIS16547_2] = {
+		.channels = adis16545_channels,
+		.num_channels = ARRAY_SIZE(adis16545_channels),
+		.gyro_max_val = 18000 << 16,
+		.gyro_max_scale = IIO_DEGREE_TO_RAD(450),
+		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
+		.accel_max_scale = 40,
+		.temp_scale = 7000, /* 7 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+		.deltvel_max_val = 400,
+		.int_clk = 4250000,
+		.max_dec_rate = 4250,
+		.filter_freqs = adis16495_def_filter_freqs,
+		.has_pps_clk_mode = true,
+		.has_burst_delta_data = true,
+		/* 20 elements of 16bits */
+		.adis_data = ADIS16480_DATA(16547, &adis16545_timeouts,
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    3200000),
+	},
+	[ADIS16547_3] = {
+		.channels = adis16545_channels,
+		.num_channels = ARRAY_SIZE(adis16545_channels),
+		.gyro_max_val = 20000 << 16,
+		.gyro_max_scale = IIO_DEGREE_TO_RAD(2000),
+		.accel_max_val = IIO_M_S_2_TO_G(32000 << 16),
+		.accel_max_scale = 40,
+		.temp_scale = 7000, /* 7 milli degree Celsius */
+		.deltang_max_val = IIO_DEGREE_TO_RAD(2160),
+		.deltvel_max_val = 400,
+		.int_clk = 4250000,
+		.max_dec_rate = 4250,
+		.filter_freqs = adis16495_def_filter_freqs,
+		.has_pps_clk_mode = true,
+		.has_burst_delta_data = true,
+		/* 20 elements of 16bits */
+		.adis_data = ADIS16480_DATA(16547, &adis16545_timeouts,
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    3200000),
+	},
 };
 
 static bool adis16480_validate_crc(const u16 *buf, const u8 n_elem, const u32 crc)
@@ -1200,7 +1355,7 @@ static irqreturn_t adis16480_trigger_handler(int irq, void *p)
 	struct adis16480 *st = iio_priv(indio_dev);
 	struct adis *adis = &st->adis;
 	struct device *dev = &adis->spi->dev;
-	int ret, bit, offset, i = 0;
+	int ret, bit, offset, i = 0, buff_offset = 0;
 	__be16 *buffer;
 	u32 crc;
 	bool valid;
@@ -1233,8 +1388,8 @@ static irqreturn_t adis16480_trigger_handler(int irq, void *p)
 	 * 16-bit responses containing the BURST_ID depending on the sclk. If
 	 * clk > 3.6MHz, then we will have two BURST_ID in a row. If clk < 3MHZ,
 	 * we have only one. To manage that variation, we use the transition from the
-	 * BURST_ID to the SYS_E_FLAG register, which will not be equal to 0xA5A5. If
-	 * we not find this variation in the first 4 segments, then the data should
+	 * BURST_ID to the SYS_E_FLAG register, which will not be equal to 0xA5A5/0xC3C3.
+	 * If we not find this variation in the first 4 segments, then the data should
 	 * not be valid.
 	 */
 	buffer = adis->buffer;
@@ -1242,7 +1397,7 @@ static irqreturn_t adis16480_trigger_handler(int irq, void *p)
 		u16 curr = be16_to_cpu(buffer[offset]);
 		u16 next = be16_to_cpu(buffer[offset + 1]);
 
-		if (curr == ADIS16495_BURST_ID && next != ADIS16495_BURST_ID) {
+		if (curr == st->burst_id && next != st->burst_id) {
 			offset++;
 			break;
 		}
@@ -1269,11 +1424,22 @@ static irqreturn_t adis16480_trigger_handler(int irq, void *p)
 		switch (bit) {
 		case ADIS16480_SCAN_TEMP:
 			st->data[i++] = buffer[offset + 1];
+			/*
+			 * The temperature channel has 16-bit storage size.
+			 * We need to perform the padding to have the buffer
+			 * elements naturally aligned in case there are any
+			 * 32-bit storage size channels enabled which have a
+			 * scan index higher than the temperature channel scan
+			 * index.
+			 */
+			if (*indio_dev->active_scan_mask &
+			    GENMASK(ADIS16480_SCAN_DELTVEL_Z, ADIS16480_SCAN_DELTANG_X))
+				st->data[i++] = 0;
 			break;
 		case ADIS16480_SCAN_GYRO_X ... ADIS16480_SCAN_ACCEL_Z:
 			/* The lower register data is sequenced first */
-			st->data[i++] = buffer[2 * bit + offset + 3];
-			st->data[i++] = buffer[2 * bit + offset + 2];
+			st->data[i++] = buffer[2 * (bit - buff_offset) + offset + 3];
+			st->data[i++] = buffer[2 * (bit - buff_offset) + offset + 2];
 			break;
 		}
 	}
@@ -1285,10 +1451,38 @@ static irqreturn_t adis16480_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static int adis16480_update_scan_mode(struct iio_dev *indio_dev,
+				      const unsigned long *scan_mask)
+{
+	u16 en;
+	int ret;
+	struct adis16480 *st = iio_priv(indio_dev);
+
+	if (st->chip_info->has_burst_delta_data) {
+		if ((*scan_mask & ADIS16545_BURST_DATA_SEL_0_CHN_MASK) &&
+		    (*scan_mask & ADIS16545_BURST_DATA_SEL_1_CHN_MASK))
+			return -EINVAL;
+		if (*scan_mask & ADIS16545_BURST_DATA_SEL_0_CHN_MASK) {
+			en = FIELD_PREP(ADIS16545_BURST_DATA_SEL_MASK, 0);
+			st->burst_id = 0xA5A5;
+		} else {
+			en = FIELD_PREP(ADIS16545_BURST_DATA_SEL_MASK, 1);
+			st->burst_id = 0xC3C3;
+		}
+
+		ret = __adis_update_bits(&st->adis, ADIS16480_REG_CONFIG,
+					 ADIS16545_BURST_DATA_SEL_MASK, en);
+		if (ret)
+			return ret;
+	}
+
+	return adis_update_scan_mode(indio_dev, scan_mask);
+}
+
 static const struct iio_info adis16480_info = {
 	.read_raw = &adis16480_read_raw,
 	.write_raw = &adis16480_write_raw,
-	.update_scan_mode = adis_update_scan_mode,
+	.update_scan_mode = &adis16480_update_scan_mode,
 	.debugfs_reg_access = adis_debugfs_reg_access,
 };
 
@@ -1498,6 +1692,8 @@ static int adis16480_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	st->burst_id = ADIS16495_BURST_ID;
+
 	if (st->chip_info->has_sleep_cnt) {
 		ret = devm_add_action_or_reset(dev, adis16480_stop, indio_dev);
 		if (ret)
@@ -1571,6 +1767,12 @@ static const struct spi_device_id adis16480_ids[] = {
 	{ "adis16497-1", ADIS16497_1 },
 	{ "adis16497-2", ADIS16497_2 },
 	{ "adis16497-3", ADIS16497_3 },
+	{ "adis16545-1", ADIS16545_1 },
+	{ "adis16545-2", ADIS16545_2 },
+	{ "adis16545-3", ADIS16545_3 },
+	{ "adis16547-1", ADIS16547_1 },
+	{ "adis16547-2", ADIS16547_2 },
+	{ "adis16547-3", ADIS16547_3 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adis16480_ids);
@@ -1587,6 +1789,12 @@ static const struct of_device_id adis16480_of_match[] = {
 	{ .compatible = "adi,adis16497-1" },
 	{ .compatible = "adi,adis16497-2" },
 	{ .compatible = "adi,adis16497-3" },
+	{ .compatible = "adi,adis16545-1" },
+	{ .compatible = "adi,adis16545-2" },
+	{ .compatible = "adi,adis16545-3" },
+	{ .compatible = "adi,adis16547-1" },
+	{ .compatible = "adi,adis16547-2" },
+	{ .compatible = "adi,adis16547-3" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, adis16480_of_match);
-- 
2.34.1


