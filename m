Return-Path: <linux-kernel+bounces-58452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3482B84E6AC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0249293D0E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B05885C7E;
	Thu,  8 Feb 2024 17:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FD+Bo54/"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604C484A54;
	Thu,  8 Feb 2024 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413141; cv=none; b=CnmVHYrDTdjRwbT4Qh22y0X6Vm4/lUOtgLxPrLROwRAHLq3cMB3OiOK3ObYud+qJVtql9YcPTdwAD/6nKu/qwMrXCDWmoM/reD0JJISgn8E1UX9y3tIiHenMY6gn30v9McaPGAdP5w1aD54iqxF/+Dp+I+sZEwzkGeyrvNys2Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413141; c=relaxed/simple;
	bh=LzC2ystzC37WxgyPIpv8YIRAxLS51Mexs/EDjs9xPcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J/7TB0OktA8bTZs4MZfsU8KtpTL1pSo+tpesWGAjU190saoNYgpoaj1OWbsG6D5leF+tzLUBuntpEXxfHhV/Wg3oMwXy0QQ5msvgUG/ovJMAzpp73RlQ6ndDO8LAmvHqruLGsA8insEm/JTEP7Fezv6de4mdvvOtzqLiTnikUeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FD+Bo54/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4101565d20bso804245e9.2;
        Thu, 08 Feb 2024 09:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707413137; x=1708017937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3MkseDxVHIJLgIk4pUZBzJPKZ+hhYw5Ai0drdywXUQ=;
        b=FD+Bo54/QapSvLsMfI8yw0mcDqdQN/bXVszzEvNOA6OqyOR+6+NSLnj0hfsKVt+3sG
         Ext0PrMtA+jAX1DZuYvgUnicdmOEoTcSurDXuFneHdgCfbq+I96EaH9aG8YBuEa9O2EB
         CggDqv8Tn0fPAUjr3YpOHodJli9Rwc3zenApiRir9O+JHsqmS6zxfYpUIs6KoCgrgAwq
         5zX/klPhx80CaKNWcjNxAQ1hmN/pYPltYJdx6dYhDAAMMMGuVySQlmyijjC0j6HZJjcq
         xqf6WDRFsVEZxTKDCI9IO4G4Zg/q0rK5eYfGmRBs5CrPuE67N3YwWDe3A6b2Rk41wqV/
         P2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707413137; x=1708017937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3MkseDxVHIJLgIk4pUZBzJPKZ+hhYw5Ai0drdywXUQ=;
        b=YV2v2MAWI+DxzC5H4sUpg0zgkkwRvVgwBaeg7AphjAqU10kLyChtbCXQfpl3hZV5I6
         QyPQtgHZTsaFQwB5QdWfPrYbD2sPyigHklfpmYr2vX54DXNwiIg9ZIhY2Jp5FhAusd2W
         /8nSzTwoZQ6mFPuYzqparaPvScz1zDOTcIZxQOhdZOrSmdeP7iK9rIh+m559ZlO/kgO+
         DhdZMLeJJgQfftLTsmghDmhjGftCBW3Osb2oA2zdZ7rlV+PBxbTBpNdwDVW4L32ixtaS
         SHXTSiqLbifTHJylcsbFiUyldjmwPWvLPk/hhyP3tHAm/T5EZ2C1aCPiftTtxwlVfmHp
         RKKw==
X-Gm-Message-State: AOJu0YyU/6gmQ6x8S76GJ75v2W2aVV28gtHPJdAWCYuYjwikUrhl3Jnm
	HEGK5AOa6EiZ6n+MaBxlpWd9BN9u9lfDYmnKGWkFrz9X5v5+bvSvuptr/+2q9m4=
X-Google-Smtp-Source: AGHT+IGIB7t+vTyZTDRIh+FcR/k1FxK5xZhszwiZuiTr7vb+q8gd/yGAv0Hmu5PnNb5cAJ1lMr9P8g==
X-Received: by 2002:a05:600c:1d8f:b0:40f:b680:3e81 with SMTP id p15-20020a05600c1d8f00b0040fb6803e81mr14146wms.4.1707413137527;
        Thu, 08 Feb 2024 09:25:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKd5eSclMeOzXke6mhvEM1RINrGyFfWdYT1qAkGVLhd88TVd1dVRZ8+uYmZo/sFW6eAgM/OATsWsSh2kw+0UuJgp+eWbG2+tv2y9mEouMAUILWRINUe5hE9hFYIJlkJg3VMdm8dV3Sk7aRUOySyNniqbqMqWCBY0sHSGEhacyuQbNqjlJJ/EyeF4xqq479pypvZtxGeI7MTBxwXDMPGvaUu6kd9cfIWdsXhk6Vzoo/fcpPqj7KUYsXF1WAZWKSinOFXIznJVOh/d4SNN3eaZF6yEfZqeaLMtY4FOAvFvTOeZfy0LST6RZwjNfJcMQi+emJ4RSVZxCSlp8pJYZ8srkuE7u3WoNQJPoN0S+Hoyx5kvJlIIflpa89fa/Ht50hpQlVVibqaHBtqpPU36tY3mnHLSzjtAFmYyhJZk6tHP874fd1+lUKPQyZ/aCLQEiQ8DezlkoNYps/DeqHRK6qSscbpwwPCkS4mLoJfmLlaqHAGyCtFrbSJd0=
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b004101f27737asm2238214wmo.29.2024.02.08.09.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:25:37 -0800 (PST)
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
	robh+dt@kernel.org
Subject: [PATCH v3 3/5] iio: adc: ad7192: Use standard attribute
Date: Thu,  8 Feb 2024 19:24:57 +0200
Message-Id: <20240208172459.280189-4-alisa.roman@analog.com>
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

Replace custom attribute filter_low_pass_3db_frequency_available with
standard attribute.

Store the available values in ad7192_state struct.

The function that used to compute those values replaced by
ad7192_update_filter_freq_avail().

Function ad7192_show_filter_avail() is no longer needed.

Note that the initial available values are hardcoded.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 67 ++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 5e8043865233..d8393ac048e7 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -187,6 +187,7 @@ struct ad7192_state {
 	u32				mode;
 	u32				conf;
 	u32				scale_avail[8][2];
+	u32				filter_freq_avail[4][2];
 	u32				oversampling_ratio_avail[4];
 	u8				gpocon;
 	u8				clock_sel;
@@ -470,6 +471,16 @@ static int ad7192_setup(struct ad7192_state *st)
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
 
@@ -583,48 +594,24 @@ static int ad7192_get_f_adc(struct ad7192_state *st)
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
@@ -634,7 +621,6 @@ static IIO_DEVICE_ATTR(ac_excitation_en, 0644,
 		       AD7192_REG_CONF);
 
 static struct attribute *ad7192_attributes[] = {
-	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
 	NULL
 };
@@ -644,7 +630,6 @@ static const struct attribute_group ad7192_attribute_group = {
 };
 
 static struct attribute *ad7195_attributes[] = {
-	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
 	&iio_dev_attr_ac_excitation_en.dev_attr.attr,
 	NULL
@@ -662,17 +647,15 @@ static unsigned int ad7192_get_temp_scale(bool unipolar)
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
@@ -823,6 +806,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 		st->mode &= ~AD7192_MODE_RATE_MASK;
 		st->mode |= FIELD_PREP(AD7192_MODE_RATE_MASK, div);
 		ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
+		ad7192_update_filter_freq_avail(st);
 		break;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		ret = ad7192_set_3db_filter_freq(st, val, val2 / 1000);
@@ -843,6 +827,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 				break;
 			}
 		mutex_unlock(&st->lock);
+		ad7192_update_filter_freq_avail(st);
 		break;
 	default:
 		ret = -EINVAL;
@@ -885,6 +870,12 @@ static int ad7192_read_avail(struct iio_dev *indio_dev,
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
@@ -953,7 +944,9 @@ static const struct iio_info ad7195_info = {
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


