Return-Path: <linux-kernel+bounces-134591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5374989B352
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67B61F21EAE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD363F9EA;
	Sun,  7 Apr 2024 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRucIA77"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DAD3D38E;
	Sun,  7 Apr 2024 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712510978; cv=none; b=kADk/HfHF7T4URBeM+vLjXF89hMcm2B5PffQT9BkF7JB9B7nEoBUbx0UPhrlCGs/IExdfJ3Yu0SL92j8Cez2LZMSJAf2MO6N0LZ/75uZfHuxJwU9tRcX9qMyMvf3hB5WREbANJy5yPJd22GftG2AvmzQOEAtInQkuoZaYeZNTF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712510978; c=relaxed/simple;
	bh=waXpgbqs+YDJlizPFcNwNWh6wFHdm2ad5xe+z4rmx18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l2XpALx74Kl73W+ekJ1khkMXS7QeSSSF3rNidtbd7w7v1cShpQb8xZxokooA5d2HrUl2dJv+rq8udc8rqCpYkKT23DmWo1rwRUFSAg532VymlOORKjZ0ABvPSbuUdwfc05FcOXXlmBbX4J/W75iPO3JwA63CJwP4a44TvKnbH2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRucIA77; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e4a148aecso802639a12.1;
        Sun, 07 Apr 2024 10:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712510974; x=1713115774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/kCOnj04yhCR4pGwNru1IKJg1FYdWbxqRrBLoehj9k=;
        b=IRucIA77ZqdTW+YhjuMy1bu6vuQepJr0FYrk0f+2nR6RHIMvQL5bvWhaF2bmKdgt3U
         DnYr+0RiYXUB8AxT1wHuJ5ASddV93nZVNSTcBHd+ZccNCGtkk3oPMyfDIWXGGbBiBknF
         kXT4Lu8PzYLVaIjX4aIoOI/LApQnUOmkBX9PakXArqCERKW7EB5hWgkcJ06tWLbIi1Od
         Cr1Pwa6msDD1sAK7Ahu3p9IJKLAepWiqKkpr0z9LaWF0+OwDfhh2mOSOFeCHbu3hzccL
         7UM+eqSGHWPnPa7tLsrzbVSgPSPc7/L/1VO3GDbap0tzH8w3pkP55a2IBD5vwjL8Okn0
         9kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712510974; x=1713115774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/kCOnj04yhCR4pGwNru1IKJg1FYdWbxqRrBLoehj9k=;
        b=nW3lRN95l6b0Mp8rIv1MYvhXobDXUHLRWKMbB0igL7HoRP2Ci+TUVAc75wNNgOTa2b
         YK385UAKC9drwEklYIT6KTe5U9AE2CTBuuTalFYxu6RQ4zK1g7ni4WbwLlYZSMHQ8SkB
         B6MceZ6WFX0tRaFW9aZ+9E4Y8UqwysYqVqUiyEsGAxaue63xEyX+P6KDK8b0YTfJxA0r
         99wpnq8t1ASaIILoi0gxuOfOXoqVFZe/xUv+T91NcUEOi3DqN8Tx+aeo/9kyXLjLyCOM
         YcxCM+Ema1jT9QWCOjumpZi6pY1h+drWaLgRz+lBck6TG1Qoy0MsoSRfAjtz4dFp3Hya
         ri8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCjYr++Qia4snOlbSc8c0g2hLffS7o6Mty6VEIfF0XglwgSMqcjyyJBYdkabzXyIJ44KOOZWeo5c72zW7JUq5XrFZPij1rjrMDegYmpP34gtTSUHu8DrevJA25OtI6kLOzGAjDVf8F
X-Gm-Message-State: AOJu0Yw0mayIDywA5yKHadIGS0TdwHXyZa1PTqvGWdOce3bnrPfI8Hdc
	Vb0M9a0JZLP77pvJvYzEwSSc/tW5Pt18yl84l1I95Jv4Jc5XzMK9
X-Google-Smtp-Source: AGHT+IFptHT6Wnt60bWbiUDmekxQb+ZI89rmEgjYI40+yLCbPXIPpJytb7mgqtua07ockoljN6wR0Q==
X-Received: by 2002:a50:cdd4:0:b0:56e:2b31:b111 with SMTP id h20-20020a50cdd4000000b0056e2b31b111mr5456457edj.7.1712510974328;
        Sun, 07 Apr 2024 10:29:34 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:c509:e54e:6ef:eb0c])
        by smtp.gmail.com with ESMTPSA id j22-20020aa7c416000000b0056e4b9ec1aasm1307134edq.52.2024.04.07.10.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 10:29:34 -0700 (PDT)
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
	u.kleine-koenig@pengutronix.de,
	biju.das.jz@bp.renesas.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v4 5/6] iio: pressure: bmp280: Add SCALE, RAW values in channels and refactorize them
Date: Sun,  7 Apr 2024 19:29:19 +0200
Message-Id: <20240407172920.264282-6-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240407172920.264282-1-vassilisamir@gmail.com>
References: <20240407172920.264282-1-vassilisamir@gmail.com>
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
index d05035574683..1b894feb717b 100644
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
@@ -529,6 +556,49 @@ static int bmp_read_raw_impl(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_HUMIDITYRELATIVE:
+			ret = data->chip_info->read_humid(data, &chan_value);
+			if (ret)
+				return ret;
+
+			*val = chan_value;
+			return IIO_VAL_INT;
+		case IIO_PRESSURE:
+			ret = data->chip_info->read_press(data, &chan_value);
+			if (ret)
+				return ret;
+
+			*val = chan_value;
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			ret = data->chip_info->read_temp(data, &chan_value);
+			if (ret)
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


