Return-Path: <linux-kernel+bounces-162874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E89EB8B618F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EAC128134A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57F413C9A9;
	Mon, 29 Apr 2024 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSguUk/V"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9F213C81A;
	Mon, 29 Apr 2024 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417269; cv=none; b=AL9OL+pU05ncvf2zCWuyFHpaVkF49ZJHBE3IpnVJyvIG1DUXldV6rNes5AkGVmAA26sAzkf/vbKnFv9Ozo/5b2BRNe5SIgZhSOC5hwSAYwDCSEr2GalikMaFyUl3q8k3EtC4RitZQ5Yq64WaBw4uQSZ1Cj1HGEJ3HI/0aeHeQug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417269; c=relaxed/simple;
	bh=7zD37O0cMqXfyAeXmkYzCAM0i0bqFUH6QgRBHqF6ofo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DaB2H3WPR/AB0SgdWBs0LOxmMGR4hbNCL2PWVExnxX/4ovNQKCe4ztW+V3lc2ckXOxFaib47TfDlS21/Dxsqt7tvaUi9NbF2RlVNJbWe/0nUSvQgW3zwDMu2YjDpg+Asqlm8yNlsdb+JmJa/BNvbMHFsSnRyeu5BlcqZ+5Ts9r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSguUk/V; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51bafbe7509so6818655e87.1;
        Mon, 29 Apr 2024 12:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714417266; x=1715022066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mwn2MMGvK9G2qY6gm++WhwbYwYr8tU2LoZssFpAE/v0=;
        b=iSguUk/V67KHG18VNe9dNBMikuC8WtWcZxAqXR3QNuruD0YIx5h9B+ybZyHe4YhEE7
         i4w5bg2Qzp0gfY1ZliCm8u3pePRmbYf2woyJXujLHApSTSrRroopBuwOTTLv44buJWHH
         8C2bUV0pU+c+uMiiCuC82dYom9xGDYwNVadOSPFFrwHlY6/siUoxThYeczFn9SMiU0xV
         fsceINeeFeC62DZNxFUfHm7VxsRiYHxx91JPtH9skgTtOYk2v2gVmq73LBQWkIHI+XOC
         /jCT+tk4l2gF039hAMwNSns11Ufw3NIWB0G8VEZl0dkJI/3T/s5pzXJfsoFtom455CGX
         RY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417266; x=1715022066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mwn2MMGvK9G2qY6gm++WhwbYwYr8tU2LoZssFpAE/v0=;
        b=W8REo9dwRwTIadXdVi8sh0Ax224za4vGZUg0XyvChYWOhdZMc0+ZZ26XCq8HxTT8bd
         NAoMgplIWChIw/edm6lKoB8VXN9Oq+bNEYSIxFxQr59Qq7+YqAkCMvXl1GnYqajG/G/C
         NWFTzuOSCx06QXVdrjM47VilxSLvDbtcWBjRmwiUBpAO4MH5ci8G8gEL+88c3smVSdRJ
         17d0QV/gcH9IvU7YqZwTnkNX+jqa4/uDyto0j4crcDg5UfkKnMIE+bN/xRSUxVg65Tea
         R/YspN9uneJSswxoeWn26P4XTCPeN/9VMwnYVcYn4CppAr8qUK3bOKsE1MdiedJ1QfDm
         C9HA==
X-Forwarded-Encrypted: i=1; AJvYcCXhYTNht/wPczsQwigHOQ0SWgs5Pj/LNsoZsYomMJq1cmU9N2oNyWkRk+BN1W/pZuF3aTr+KB0MkKsmzFKeI4rVxmvuzVcZmrGFCJADoT4rY3sFvBAerXxPd3AEawH5xFskKWIn61Tj
X-Gm-Message-State: AOJu0Yz8xv+qPnZ5KvRWB8r+waafuD1mR/q2O6KPGDEiKPrmK7VAPVlV
	IpJzBImSs4+wO4lF4M8L9AyLxxZGz9oCpdn7kZvmfBwOxKBNFgwd
X-Google-Smtp-Source: AGHT+IH9nzto04uH8933cCAEYLrUBd1ZEEDmgvM68qUx5wNp/TVq3+OMpWrPvi7mr6g+QkZfz1rUZA==
X-Received: by 2002:a05:6512:23a7:b0:51d:a1ab:98bc with SMTP id c39-20020a05651223a700b0051da1ab98bcmr4138196lfv.2.1714417266439;
        Mon, 29 Apr 2024 12:01:06 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:abbf:c98a:cf84:d14c])
        by smtp.gmail.com with ESMTPSA id x2-20020adfdd82000000b0034c78bba70bsm8469456wrl.72.2024.04.29.12.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:01:06 -0700 (PDT)
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
Subject: [PATCH v5 09/10] iio: pressure: bmp280: Add SCALE, RAW values in channels and refactorize them
Date: Mon, 29 Apr 2024 21:00:45 +0200
Message-Id: <20240429190046.24252-10-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240429190046.24252-1-vassilisamir@gmail.com>
References: <20240429190046.24252-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add extra IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_RAW channels in order
to be able to calculate the processed value with standard userspace
IIO tools. Can be used for triggered buffers as well.

Even though it is not a good design choice to have SCALE, RAW and
PROCESSED together, the PROCESSED channel is kept for ABI compatibility.

While at it, separate BMPxxx and BMExxx device channels since BME
supports also humidity measurements.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 86 +++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 668c4e8a2ebf..e349ed87aad6 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -137,17 +137,45 @@ enum {
 static const struct iio_chan_spec bmp280_channels[] = {
 	{
 		.type = IIO_PRESSURE,
+		/* PROCESSED maintained for ABI backwards compatibility */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 	},
 	{
 		.type = IIO_TEMP,
+		/* PROCESSED maintained for ABI backwards compatibility */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+	},
+};
+
+static const struct iio_chan_spec bme280_channels[] = {
+	{
+		.type = IIO_PRESSURE,
+		/* PROCESSED maintained for ABI backwards compatibility */
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+	},
+	{
+		.type = IIO_TEMP,
+		/* PROCESSED maintained for ABI backwards compatibility */
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 	},
 	{
 		.type = IIO_HUMIDITYRELATIVE,
+		/* PROCESSED maintained for ABI backwards compatibility */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 	},
 };
@@ -155,21 +183,20 @@ static const struct iio_chan_spec bmp280_channels[] = {
 static const struct iio_chan_spec bmp380_channels[] = {
 	{
 		.type = IIO_PRESSURE,
+		/* PROCESSED maintained for ABI backwards compatibility */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 	},
 	{
 		.type = IIO_TEMP,
+		/* PROCESSED maintained for ABI backwards compatibility */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
-				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
-	},
-	{
-		.type = IIO_HUMIDITYRELATIVE,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
@@ -529,6 +556,49 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_HUMIDITYRELATIVE:
+			ret = data->chip_info->read_humid(data, &chan_value);
+			if (ret < 0)
+				return ret;
+
+			*val = chan_value;
+			return IIO_VAL_INT;
+		case IIO_PRESSURE:
+			ret = data->chip_info->read_press(data, &chan_value);
+			if (ret < 0)
+				return ret;
+
+			*val = chan_value;
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			ret = data->chip_info->read_temp(data, &chan_value);
+			if (ret < 0)
+				return ret;
+
+			*val = chan_value;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_HUMIDITYRELATIVE:
+			*val = data->chip_info->humid_coeffs[0];
+			*val2 = data->chip_info->humid_coeffs[1];
+			return data->chip_info->humid_coeffs_type;
+		case IIO_PRESSURE:
+			*val = data->chip_info->press_coeffs[0];
+			*val2 = data->chip_info->press_coeffs[1];
+			return data->chip_info->press_coeffs_type;
+		case IIO_TEMP:
+			*val = data->chip_info->temp_coeffs[0];
+			*val2 = data->chip_info->temp_coeffs[1];
+			return data->chip_info->temp_coeffs_type;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
@@ -895,7 +965,7 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.num_chip_id = ARRAY_SIZE(bme280_chip_ids),
 	.regmap_config = &bmp280_regmap_config,
 	.start_up_time = 2000,
-	.channels = bmp280_channels,
+	.channels = bme280_channels,
 	.num_channels = 3,
 
 	.oversampling_temp_avail = bmp280_oversampling_avail,
-- 
2.25.1


