Return-Path: <linux-kernel+bounces-106856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED8C87F48E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06AA71F219B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E376AC0;
	Tue, 19 Mar 2024 00:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2+hrSPU"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F2B816;
	Tue, 19 Mar 2024 00:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710808179; cv=none; b=fN9BR9DSDdJgCRY08T6UtLIXL4zxaE7MRus30C5i9ujfKGVAWksFWQwlzyKcUTLFbMtxhGzRq/BawxMUC/9elogtz/BT4k1UNOEC1iMd3dDjOXhyPEQkHDfRbZrdxsVFCWHO0qyOj2+A3cQjieA1vVYXvLR9tL36sjmSOs4ZEcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710808179; c=relaxed/simple;
	bh=GDXxRCQUXzRN1ga8hPMGsDuymxwy19feZsEsXaV5plU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OXtk+nZ9D1bxerwbua2lKhRSvXZfxYjekwEyRuE45C0zkKNoz/24mqE1e0kiw6Q3wA2i09wq7I7v19UO8LzKge6cSHlGZ8UEKEgoLRH6zQfUgcNBGfc4cUckdBm8FoE37czPCZT0UDES0LwlTWbJ8BZnQitJonhsHasZpzxmQHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2+hrSPU; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56b857bac38so515258a12.0;
        Mon, 18 Mar 2024 17:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710808176; x=1711412976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bcqw3pjUKDeXJIPJrkT7cyeEObF+uyQDSXsN/wtA9Y=;
        b=d2+hrSPU8LllxBC9r2RJOmHrGrrYIZ/wuU8Yq3sVjxoJ3/1EpwfWgIngJBYM4A+qI9
         LVYhCAEe9v8bKZo2+V4hPyH0CxBifj0Q6rTRplZtPG6Qa7gzxJt6flKTHgBXlgZW6naN
         YwgF9Ueo9K+gPln/FImJ1n9J9ho2vNN2Ka4qK6YA5s7+Izun0rJmqB/0d8MfA1TawvOv
         11IeNqDh2liyvEQG+5VJHDtpl646o2BvzTZRrODlu8G0aIncmTVr3dpTcEAhjeZahP0H
         9XPLuKbUhY355NCGm1Z8kzhFsvQhxcoVDmHeoy7ictv/V84M9aN+c9cqIRWEvMWAkjak
         QEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710808176; x=1711412976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bcqw3pjUKDeXJIPJrkT7cyeEObF+uyQDSXsN/wtA9Y=;
        b=AMZSZqA0IHslF8hjSf17VMZGjQlqqmbcjLE66fuGw+4spZ/AG0IHenNBTdQDTbvbzz
         jGSwjcnQtNmogvLzZ9sG+3Ikje2AkeJDz2xeAFMm3FtnMLmj8tKVlewc0nbPrZV9h+ij
         W2hxlkRMqREhb9DdngSjr3eLL0gfbebTj5ngxLdzAPGTRGwKBpSIW/EJc+k9NKcSHZQc
         aJX+x/plxO0PMf4VKJOMRVGImWm6jZ2oPVqkiinvz12SxA6J3GdgSqyqGQd+ay+glGuT
         NOz7VCSJOAi5zXab+wZmlwJL8ltAga0NDWy5Z2Lvyo3iTPph/L3XX7uc3B3DQLfL4LVS
         MBoA==
X-Forwarded-Encrypted: i=1; AJvYcCXcILvDpPna2VHmE3T6UTgyzL6nSDxwf+1ON5yZlLGy16vhWTnPpeaJ/6oJrJQTE5PMQ9GScBF71HT+dObRr+AxxmHQkajQjEvKK3gxjU22+Z+oK/qT+nl9Z/lJdcHOkLzWoxmbSmDI
X-Gm-Message-State: AOJu0YzabsCZiF/swRYI10Ye6KwwQswfi2zRpej5V+5gHYfhHeffcCDr
	ntbLvdMl8uqAozVJvhJnu8cFjxmY1VP71arnZt8JEzHeP732Qw74
X-Google-Smtp-Source: AGHT+IHM8MuacX6G3Ak+84rJE51NTny1+mKzSzluC385ybhxP1KDFoKBQBOsW+2y1yZLRIZj28vp+g==
X-Received: by 2002:a05:6402:1d34:b0:568:29f8:1d79 with SMTP id dh20-20020a0564021d3400b0056829f81d79mr5691526edb.38.1710808175734;
        Mon, 18 Mar 2024 17:29:35 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:8c96:c55f:eab0:860])
        by smtp.gmail.com with ESMTPSA id co24-20020a0564020c1800b00568c613570dsm2700227edb.79.2024.03.18.17.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 17:29:35 -0700 (PDT)
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
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 2/6] iio: pressure: Introduce new cleanup routines to BMP280 driver *_raw() functions
Date: Tue, 19 Mar 2024 01:29:21 +0100
Message-Id: <20240319002925.2121016-3-vassilisamir@gmail.com>
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

Introduce the new linux/cleanup.h with the guard(mutex) functionality
in the {read/write}_raw() functions

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 125 +++++++++++++----------------
 1 file changed, 58 insertions(+), 67 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 871b2214121b..f7a13ff6f26c 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -460,77 +460,74 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 	return IIO_VAL_INT;
 }
 
-static int bmp280_read_raw(struct iio_dev *indio_dev,
-			   struct iio_chan_spec const *chan,
-			   int *val, int *val2, long mask)
+static int bmp280_read_raw_guarded(struct iio_dev *indio_dev,
+				   struct iio_chan_spec const *chan,
+				   int *val, int *val2, long mask)
 {
 	struct bmp280_data *data = iio_priv(indio_dev);
-	int ret;
 
-	pm_runtime_get_sync(data->dev);
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
-			ret = data->chip_info->read_humid(data, val, val2);
-			break;
+			return data->chip_info->read_humid(data, val, val2);
 		case IIO_PRESSURE:
-			ret = data->chip_info->read_press(data, val, val2);
-			break;
+			return data->chip_info->read_press(data, val, val2);
 		case IIO_TEMP:
-			ret = data->chip_info->read_temp(data, val, val2);
-			break;
+			return data->chip_info->read_temp(data, val, val2);
 		default:
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
-		break;
+		return 0;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
 			*val = 1 << data->oversampling_humid;
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		case IIO_PRESSURE:
 			*val = 1 << data->oversampling_press;
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		case IIO_TEMP:
 			*val = 1 << data->oversampling_temp;
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		default:
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
-		break;
+		return 0;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (!data->chip_info->sampling_freq_avail) {
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
 
 		*val = data->chip_info->sampling_freq_avail[data->sampling_freq][0];
 		*val2 = data->chip_info->sampling_freq_avail[data->sampling_freq][1];
-		ret = IIO_VAL_INT_PLUS_MICRO;
-		break;
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		if (!data->chip_info->iir_filter_coeffs_avail) {
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
 
 		*val = (1 << data->iir_filter_coeff) - 1;
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
 
-	mutex_unlock(&data->lock);
+	return 0;
+}
+
+
+static int bmp280_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct bmp280_data *data = iio_priv(indio_dev);
+	int ret;
+
+	pm_runtime_get_sync(data->dev);
+	ret = bmp280_read_raw_guarded(indio_dev, chan, val, val2, mask);
 	pm_runtime_mark_last_busy(data->dev);
 	pm_runtime_put_autosuspend(data->dev);
 
@@ -662,13 +659,13 @@ static int bmp280_write_iir_filter_coeffs(struct bmp280_data *data, int val)
 	return -EINVAL;
 }
 
-static int bmp280_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val, int val2, long mask)
+static int bmp280_write_raw_guarded(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    int val, int val2, long mask)
 {
 	struct bmp280_data *data = iio_priv(indio_dev);
-	int ret = 0;
 
+	guard(mutex)(&data->lock);
 	/*
 	 * Helper functions to update sensor running configuration.
 	 * If an error happens applying new settings, will try restore
@@ -677,46 +674,40 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
 	 */
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		pm_runtime_get_sync(data->dev);
-		mutex_lock(&data->lock);
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
-			ret = bmp280_write_oversampling_ratio_humid(data, val);
-			break;
+			return bmp280_write_oversampling_ratio_humid(data, val);
 		case IIO_PRESSURE:
-			ret = bmp280_write_oversampling_ratio_press(data, val);
-			break;
+			return bmp280_write_oversampling_ratio_press(data, val);
 		case IIO_TEMP:
-			ret = bmp280_write_oversampling_ratio_temp(data, val);
-			break;
+			return bmp280_write_oversampling_ratio_temp(data, val);
 		default:
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
-		mutex_unlock(&data->lock);
-		pm_runtime_mark_last_busy(data->dev);
-		pm_runtime_put_autosuspend(data->dev);
-		break;
+		return 0;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		pm_runtime_get_sync(data->dev);
-		mutex_lock(&data->lock);
-		ret = bmp280_write_sampling_frequency(data, val, val2);
-		mutex_unlock(&data->lock);
-		pm_runtime_mark_last_busy(data->dev);
-		pm_runtime_put_autosuspend(data->dev);
-		break;
+		return bmp280_write_sampling_frequency(data, val, val2);
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		pm_runtime_get_sync(data->dev);
-		mutex_lock(&data->lock);
-		ret = bmp280_write_iir_filter_coeffs(data, val);
-		mutex_unlock(&data->lock);
-		pm_runtime_mark_last_busy(data->dev);
-		pm_runtime_put_autosuspend(data->dev);
-		break;
+		return bmp280_write_iir_filter_coeffs(data, val);
 	default:
 		return -EINVAL;
 	}
 
+	return 0;
+}
+
+static int bmp280_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct bmp280_data *data = iio_priv(indio_dev);
+	int ret = 0;
+
+	pm_runtime_get_sync(data->dev);
+	ret = bmp280_write_raw_guarded(indio_dev, chan, val, val2, mask);
+	pm_runtime_mark_last_busy(data->dev);
+	pm_runtime_put_autosuspend(data->dev);
+
 	return ret;
 }
 
-- 
2.25.1


