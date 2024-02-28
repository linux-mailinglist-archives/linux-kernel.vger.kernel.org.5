Return-Path: <linux-kernel+bounces-85013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C670A86AF26
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B72E28212C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A0B3BBD8;
	Wed, 28 Feb 2024 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPKAdDyf"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707546CDC6;
	Wed, 28 Feb 2024 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123218; cv=none; b=YzUeZ3ZYOX/2mbhlqo+5UZLcY3ZxkNh9oRms2Xove/zJOteZKB0fd88ytmyhBmb/YpuRwsSj2q0KnmnyxWIGO7W7bQGVZt5Zx4aFu1yiuvP7cQtSEfNNhN2Wahcz59REuu7ysHAL5Y3fllxc9xN5jtdvlkpha2qwi2kNzln1/Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123218; c=relaxed/simple;
	bh=BBWiHnJ/r7xpKFZE4Kz1164OVbYXkJ/2croGM6AzAsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KJYzeDQJPBUYoW4Gg5TpcU7+ARz6FgfTd1Hm7VvAgWHaN9ig6E6ocZSs55gH3okZD+L0iAm96hISd8Tk3Je79e+U/RxTR7Fxeg+lAhAsUXXl8LDNpZ9t5U0InCUAuOCN5ubr50FNRWOWZMn3RdB5Wrfhcictid7w72zaheujQI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPKAdDyf; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5656e5754ccso6728279a12.0;
        Wed, 28 Feb 2024 04:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709123215; x=1709728015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/Xp0WhuiHGrQ1r2Hb53CPJ6S7Yc2qjybrALOzmpRZg=;
        b=dPKAdDyfruEb4Tc5nSruUz3hUBy09D626NHt8008P1TQBO9rVn/opkNX9kbUNcee4y
         L81PBZvwMuGgqDuYnAX4vvolJsxw+W7oUGBI5zO10EZqCFnPQxT0yJK65eplnDHIwsXE
         5QaI91+4epmftu37mygAwpihWeaTTjBnGptujgvhk+GgOGJWbtRSU1kibUpO2/VJfN8I
         XEEyUjmFWuHYy01k/tgregB0Z7cfhLD+0lZI2C9E0aLj/2haIYn+hHDI3mXiC4zPatjk
         I8l23DBVz1Sc98SGqTuAMzPhHIHbhKb1DdvMtx3bRYWgci4fzt0oIJnVTonb8c5m0hhN
         g+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709123215; x=1709728015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/Xp0WhuiHGrQ1r2Hb53CPJ6S7Yc2qjybrALOzmpRZg=;
        b=U9fZNp1OnE1JtDsNWud4B2wqtjZ93ELT7pTX9M8Tx+O2CNs+tX7paPAd97pKhKVgDC
         ZbHkUe7/zjweGylESU1pmYttDA05ND04v+CynZItZARuso/+jVj8wRw0ZNPdVF98XSVU
         ze+ZQWE6Yd1uBKOTgZ6jA1xxuSasvCUmk6NHbt/HC3iQLoVyWv3dKaxUZ3qXZMCdfa0x
         MSpqBf0dfvTUWXZ5zyq00wD+k1K/gWNRhVfKgG19olLTX1UBhT59VTSgdM7O3BErfE+4
         FDrXyCUDYNg8lyFNt5R//n8T1LXPg6O65kULIA5q+OZSIbeQD+/r2tC02gXoSYI/8VNu
         xr7A==
X-Forwarded-Encrypted: i=1; AJvYcCXo5JHinz0MG2Vvm211DxSs8023PY2qJ/ej6ne0KkEUESMDJAQ39I1ssN0CyKqQvJlPecXMAdW/e7GrkzY/b2fRD5MbnIP5bkLR19WgdbSAYmcpbOdMpLFxVyeHm3eBZE+PbuamKCE7h6sZ0ZFVCkY7yoBEyixq5kwP1zthtr02HR4RNQ==
X-Gm-Message-State: AOJu0YwrFTBQkXPyy5Xl1yOzOalL2GokpAGvVkdSGv/4PSq8dGQcJz5D
	YZ/ava+Le8jrh+2nLf0tFCBEuCGGAyslBKcshkp2w7inBjt1CoY1
X-Google-Smtp-Source: AGHT+IFCDMwvCCnJzvoLdQvqmjtCmFeXcmSPfal9yrIEj5kVJoG4sKvUOCLwj3kof+F9Is21thLELQ==
X-Received: by 2002:a17:906:139b:b0:a43:e4b4:b8cc with SMTP id f27-20020a170906139b00b00a43e4b4b8ccmr1993155ejc.38.1709123214430;
        Wed, 28 Feb 2024 04:26:54 -0800 (PST)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id f3-20020a170906c08300b00a3d1c0a3d5dsm1800417ejz.63.2024.02.28.04.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 04:26:54 -0800 (PST)
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
Subject: [PATCH v4 2/4] iio: adc: ad7192: Use standard attribute
Date: Wed, 28 Feb 2024 14:26:15 +0200
Message-Id: <20240228122617.185814-3-alisa.roman@analog.com>
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

Replace custom attribute filter_low_pass_3db_frequency_available with
standard attribute.

Store the available values in ad7192_state struct.

The function that used to compute those values replaced by
ad7192_update_filter_freq_avail().

Function ad7192_show_filter_avail() is no longer needed.

Note that the initial available values are hardcoded.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
Signed-off-by: romandariana <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 67 ++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 72de9cc6716e..e0f1c9eaf9ae 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -190,6 +190,7 @@ struct ad7192_state {
 	u32				mode;
 	u32				conf;
 	u32				scale_avail[8][2];
+	u32				filter_freq_avail[4][2];
 	u32				oversampling_ratio_avail[4];
 	u8				gpocon;
 	u8				clock_sel;
@@ -473,6 +474,16 @@ static int ad7192_setup(struct ad7192_state *st)
 	st->oversampling_ratio_avail[2] = 8;
 	st->oversampling_ratio_avail[3] = 16;
 
+	st->filter_freq_avail[0][0] = 600;
+	st->filter_freq_avail[1][0] = 800;
+	st->filter_freq_avail[2][0] = 2300;
+	st->filter_freq_avail[3][0] = 2720;
+
+	st->filter_freq_avail[0][1] = 1000;
+	st->filter_freq_avail[1][1] = 1000;
+	st->filter_freq_avail[2][1] = 1000;
+	st->filter_freq_avail[3][1] = 1000;
+
 	return 0;
 }
 
@@ -586,48 +597,24 @@ static int ad7192_get_f_adc(struct ad7192_state *st)
 				 f_order * FIELD_GET(AD7192_MODE_RATE_MASK, st->mode));
 }
 
-static void ad7192_get_available_filter_freq(struct ad7192_state *st,
-						    int *freq)
+static void ad7192_update_filter_freq_avail(struct ad7192_state *st)
 {
 	unsigned int fadc;
 
 	/* Formulas for filter at page 25 of the datasheet */
 	fadc = ad7192_compute_f_adc(st, false, true);
-	freq[0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
+	st->filter_freq_avail[0][0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
 
 	fadc = ad7192_compute_f_adc(st, true, true);
-	freq[1] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
+	st->filter_freq_avail[1][0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
 
 	fadc = ad7192_compute_f_adc(st, false, false);
-	freq[2] = DIV_ROUND_CLOSEST(fadc * 230, 1024);
+	st->filter_freq_avail[2][0] = DIV_ROUND_CLOSEST(fadc * 230, 1024);
 
 	fadc = ad7192_compute_f_adc(st, true, false);
-	freq[3] = DIV_ROUND_CLOSEST(fadc * 272, 1024);
+	st->filter_freq_avail[3][0] = DIV_ROUND_CLOSEST(fadc * 272, 1024);
 }
 
-static ssize_t ad7192_show_filter_avail(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7192_state *st = iio_priv(indio_dev);
-	unsigned int freq_avail[4], i;
-	size_t len = 0;
-
-	ad7192_get_available_filter_freq(st, freq_avail);
-
-	for (i = 0; i < ARRAY_SIZE(freq_avail); i++)
-		len += sysfs_emit_at(buf, len, "%d.%03d ", freq_avail[i] / 1000,
-				     freq_avail[i] % 1000);
-
-	buf[len - 1] = '\n';
-
-	return len;
-}
-
-static IIO_DEVICE_ATTR(filter_low_pass_3db_frequency_available,
-		       0444, ad7192_show_filter_avail, NULL, 0);
-
 static IIO_DEVICE_ATTR(bridge_switch_en, 0644,
 		       ad7192_show_bridge_switch, ad7192_set,
 		       AD7192_REG_GPOCON);
@@ -637,7 +624,6 @@ static IIO_DEVICE_ATTR(ac_excitation_en, 0644,
 		       AD7192_REG_CONF);
 
 static struct attribute *ad7192_attributes[] = {
-	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
 	NULL
 };
@@ -647,7 +633,6 @@ static const struct attribute_group ad7192_attribute_group = {
 };
 
 static struct attribute *ad7195_attributes[] = {
-	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
 	&iio_dev_attr_ac_excitation_en.dev_attr.attr,
 	NULL
@@ -665,17 +650,15 @@ static unsigned int ad7192_get_temp_scale(bool unipolar)
 static int ad7192_set_3db_filter_freq(struct ad7192_state *st,
 				      int val, int val2)
 {
-	int freq_avail[4], i, ret, freq;
+	int i, ret, freq;
 	unsigned int diff_new, diff_old;
 	int idx = 0;
 
 	diff_old = U32_MAX;
 	freq = val * 1000 + val2;
 
-	ad7192_get_available_filter_freq(st, freq_avail);
-
-	for (i = 0; i < ARRAY_SIZE(freq_avail); i++) {
-		diff_new = abs(freq - freq_avail[i]);
+	for (i = 0; i < ARRAY_SIZE(st->filter_freq_avail); i++) {
+		diff_new = abs(freq - st->filter_freq_avail[i][0]);
 		if (diff_new < diff_old) {
 			diff_old = diff_new;
 			idx = i;
@@ -826,6 +809,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 		st->mode &= ~AD7192_MODE_RATE_MASK;
 		st->mode |= FIELD_PREP(AD7192_MODE_RATE_MASK, div);
 		ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
+		ad7192_update_filter_freq_avail(st);
 		break;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		ret = ad7192_set_3db_filter_freq(st, val, val2 / 1000);
@@ -846,6 +830,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 				break;
 			}
 		mutex_unlock(&st->lock);
+		ad7192_update_filter_freq_avail(st);
 		break;
 	default:
 		ret = -EINVAL;
@@ -888,6 +873,12 @@ static int ad7192_read_avail(struct iio_dev *indio_dev,
 		/* Values are stored in a 2D matrix  */
 		*length = ARRAY_SIZE(st->scale_avail) * 2;
 
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*vals = (int *)st->filter_freq_avail;
+		*type = IIO_VAL_FRACTIONAL;
+		*length = ARRAY_SIZE(st->filter_freq_avail) * 2;
+
 		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*vals = (int *)st->oversampling_ratio_avail;
@@ -956,7 +947,9 @@ static const struct iio_info ad7195_info = {
 			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) | \
 			(_mask_all), \
 		.info_mask_shared_by_type_available = (_mask_type_av), \
-		.info_mask_shared_by_all_available = (_mask_all_av), \
+		.info_mask_shared_by_all_available = \
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) | \
+			(_mask_all_av), \
 		.ext_info = (_ext_info), \
 		.scan_index = (_si), \
 		.scan_type = { \
-- 
2.34.1


