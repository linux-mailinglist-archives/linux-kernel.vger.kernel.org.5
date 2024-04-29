Return-Path: <linux-kernel+bounces-162872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E64928B618B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15CD81C21003
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986A913C3C0;
	Mon, 29 Apr 2024 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIFVNKCT"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40C213C671;
	Mon, 29 Apr 2024 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417267; cv=none; b=CtDoXRWBb+nNZJUGom0zDZ3HLbVOO9EA7hTT/7fOn5NJ5IjuqRIdAU4fcQSgBtxsfykn9g49dkObaz/S6kssM/ri/dmz02LLDcqkRrQwnoovE6zIy+R73fYxHKYCC996U7FIJPNoM45LpdEIp7v0+LuSxdMf+Zj4XPsQXFl9oMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417267; c=relaxed/simple;
	bh=NOrJb6p7v7/w/7jahStUJxBEPe+89T748ZsfhUu2POc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sRc+vRc33nwCpn+/6sR4KePQkjepiNv7SeXYdd46djvTK8Ju9lVam0VKzukeI57RK7e80gYVlkBudAW5mR9MyF5FuAOdS6s8VTK/sqMnS0TanGpMHvPLRFwDwjZSbyOiP8xYTlUimmNay32K58CAA+MSW0JJtbGaAK8bLHuSSw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIFVNKCT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34d13789e2fso994980f8f.3;
        Mon, 29 Apr 2024 12:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714417264; x=1715022064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9G5hRyuWFdVeJfPqoqlg4bo6BPBFgmGTi1O6KMvVv+Q=;
        b=UIFVNKCT50aJ2SqRfD3Wy+yIxFG8L6JqFlK31L9TsvYz1g4ZYcaXCIsHskgNGi/hQp
         Y9ZUXdpDycqZS6xfwJHbXM1ePI4RLqr+CatDtox+lp9kn6jFaHKCwXoO13JNkExbVD2n
         3gYqQyHiMT5n2hxJ2GAYUmOExXBOxA3kUyLZ7t8Qc5HcNpqs6NCbiW+pJHng0A3FKTtQ
         D5U7xSBlqDvE9U73WmlcWEjpW91PWeW7bxjFkIWLhDYe+Xq5uWqF60ehDP6bk97qimZk
         ubgmEQpQMHROa6FYjMlNj/ywaaroQDFaZwmF1FS8W+AmpEUmwKqAG9gA2H3g3/RAAHYw
         ygSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417264; x=1715022064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9G5hRyuWFdVeJfPqoqlg4bo6BPBFgmGTi1O6KMvVv+Q=;
        b=Zr9QHP53fBjL0s219dBY27/H+rsXNlzFBVK/HkRA9EQ11Jg+IHO5bjI4XeKdhWkGCy
         OrRulLTMfSuJLhOdjsKiXNNVhd0tgS5rCVKH35Xfs5Q9coMmalUFWJ6WW25FubPSA8Su
         D2ZVQhq5PK+EMXpqfezFkQAdMMjHB6yUcDNMHLhUk+9jVeBhg850dry/QOJA/S9F43XX
         1bW6YcNybIYGg7/AiTnAi0ynUeeZSm42c7lYbqwZlTv6d6MmYIj8cWrxZ6/msHejSIXJ
         JqvuZ4E7jU1yluIGuMIA5wi9VzezxiWE8SkbKffPduJ/YxuLc/4gPDKjD0UG8MLzKn4R
         c83w==
X-Forwarded-Encrypted: i=1; AJvYcCWwpGcweoBUhkz71pV0ddpGHcXapj58BlAv2aMZk+kjIA72FOR2jBxaQ4oInV7bRiw6CdwI0CYeFCxpDgXU310+OVMeZvImxg9mocuGd0ALyloD0Ud0wO28Yckih3Va9tNmjqf5yIu6
X-Gm-Message-State: AOJu0YxaTl43igqzUdHMjlMl5G6YkxnmDimrDMtQcJzozZuk8kX+BcWN
	yWPfiMG+visfrWpztFwqbCl3BemY6Fsvhu+miYFg7LNr+8glkttG
X-Google-Smtp-Source: AGHT+IETR4IWEKTl5LAaTBFHjCqIkPl5Pe31CYpkAyFrfX65RMvDe5sLd2th/Nur0SOUdhv9ZUOC4A==
X-Received: by 2002:a5d:444d:0:b0:34c:c66c:5624 with SMTP id x13-20020a5d444d000000b0034cc66c5624mr338749wrr.35.1714417264233;
        Mon, 29 Apr 2024 12:01:04 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:abbf:c98a:cf84:d14c])
        by smtp.gmail.com with ESMTPSA id x2-20020adfdd82000000b0034c78bba70bsm8469456wrl.72.2024.04.29.12.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:01:03 -0700 (PDT)
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
Subject: [PATCH v5 07/10] iio: pressure: bmp280: Introduce new cleanup routines
Date: Mon, 29 Apr 2024 21:00:43 +0200
Message-Id: <20240429190046.24252-8-vassilisamir@gmail.com>
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

Introduce new linux/cleanup.h with the guard(mutex) functionality
in the {read,write}_raw() functions.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 125 +++++++++++++----------------
 1 file changed, 54 insertions(+), 71 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 5ebce38e99f6..f14277bb882d 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -27,6 +27,7 @@
 
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -501,77 +502,67 @@ static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
 	return IIO_VAL_INT;
 }
 
-static int bmp280_read_raw(struct iio_dev *indio_dev,
-			   struct iio_chan_spec const *chan,
-			   int *val, int *val2, long mask)
+static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
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
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (!data->chip_info->sampling_freq_avail) {
-			ret = -EINVAL;
-			break;
-		}
+		if (!data->chip_info->sampling_freq_avail)
+			return -EINVAL;
 
 		*val = data->chip_info->sampling_freq_avail[data->sampling_freq][0];
 		*val2 = data->chip_info->sampling_freq_avail[data->sampling_freq][1];
-		ret = IIO_VAL_INT_PLUS_MICRO;
-		break;
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		if (!data->chip_info->iir_filter_coeffs_avail) {
-			ret = -EINVAL;
-			break;
-		}
+		if (!data->chip_info->iir_filter_coeffs_avail)
+			return -EINVAL;
 
 		*val = (1 << data->iir_filter_coeff) - 1;
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
+}
 
-	mutex_unlock(&data->lock);
+static int bmp280_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct bmp280_data *data = iio_priv(indio_dev);
+	int ret;
+
+	pm_runtime_get_sync(data->dev);
+	ret = bmp280_read_raw_impl(indio_dev, chan, val, val2, mask);
 	pm_runtime_mark_last_busy(data->dev);
 	pm_runtime_put_autosuspend(data->dev);
 
@@ -703,12 +694,13 @@ static int bmp280_write_iir_filter_coeffs(struct bmp280_data *data, int val)
 	return -EINVAL;
 }
 
-static int bmp280_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val, int val2, long mask)
+static int bmp280_write_raw_impl(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int val, int val2, long mask)
 {
 	struct bmp280_data *data = iio_priv(indio_dev);
-	int ret = 0;
+
+	guard(mutex)(&data->lock);
 
 	/*
 	 * Helper functions to update sensor running configuration.
@@ -718,45 +710,36 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
 	 */
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		pm_runtime_get_sync(data->dev);
-		mutex_lock(&data->lock);
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
-			ret = bme280_write_oversampling_ratio_humid(data, val);
-			break;
+			return bme280_write_oversampling_ratio_humid(data, val);
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
+}
+
+static int bmp280_write_raw(struct iio_dev *indio_dev,
+			 struct iio_chan_spec const *chan,
+			 int val, int val2, long mask)
+{
+	struct bmp280_data *data = iio_priv(indio_dev);
+	int ret;
+
+	pm_runtime_get_sync(data->dev);
+	ret = bmp280_write_raw_impl(indio_dev, chan, val, val2, mask);
+	pm_runtime_mark_last_busy(data->dev);
+	pm_runtime_put_autosuspend(data->dev);
 
 	return ret;
 }
-- 
2.25.1


