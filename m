Return-Path: <linux-kernel+bounces-148957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47E88A89A8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048841C23F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E2E173326;
	Wed, 17 Apr 2024 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8wXOVlD"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3181487F7;
	Wed, 17 Apr 2024 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373273; cv=none; b=ay0mt+0zYbtCmMp4M4F2YV7TBYQ88Bh6XtzmDxI3LoOSVE4ItZoFbGovRCnmK4HesVv6dAgo3IkA4n8f3gIsFHTAoX0E9J/4zj9WwUVV8zGmm2yTIU7pxxn3LPl9skTS0B6DMt9I1xrXeqwVHh6x3vL4auZ/Ti44wm/XSuNjD+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373273; c=relaxed/simple;
	bh=Fnq/TM5nqxh6n4xvyFsAt9TORsJQjjD4YNC+GMRMdPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EqTB2KWJMD8O02Gc3epjUXi/+45xHAHk80M1ORTjZFyqjMDx1sslJ6qWTJwxSi/o5qYnd1KNUawG9YIy4Vg/bMP4LMy4eHjcQEV6KWNR22mX7G9aJgt5beDQ6Gj3fsYDOWta2MjEyr5Ds3b0CrQGpyNLCeFxqeKVC3nKaSuDTU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8wXOVlD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-418c2bf2f15so5282545e9.3;
        Wed, 17 Apr 2024 10:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713373268; x=1713978068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dykPh5RAPxYJdWFmBmCaPuYTC+omHF64St3jDBsho9o=;
        b=b8wXOVlDEpylL2kjabn2Ypy+kfRmW1bsv2OClOURcWIPVSsX9xHGtoROC0JiPnUtob
         M5dMufUwiJ5d+LC38PECbuGCddDxio1hv4+nBbDFGtqYCAfpzS36l23i+CtIK/4ltgbX
         CrSZKD82oPT8cZ6ox/dhlD0i/dk/ks7rG/W7HQaok8+5S8WKq6Su4uekNFA3b1tAgeHI
         IsehunymSR8+ex25sTyNhz74iLd4s/2pkqrtL1X6sj5sNI/9wSCSXHoCvorzuM3yeb3H
         +rXQq/iL0pNiHHxdCZP8r99wAlF7Qmep/6D+go2XuJWt9uztqBNxUuWOHIsytVdQGu0L
         UeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713373268; x=1713978068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dykPh5RAPxYJdWFmBmCaPuYTC+omHF64St3jDBsho9o=;
        b=NvBPiGlf5dRDkuCF8Zaakl3EZSJlC9cJ/lO0BrIxExeSedanr2zDnO5dZBETUf4qxx
         068RbpxE9k46yPB/gUYJQrRpor8i1zS6XHkLNdYqgYslLDpLrUN/kUZ7A1g805s46uol
         5BDlpcZlUATGxqH8SlccqRGhrK8hCXuDEnbQEFL2+uY4uZn+gjiWygRgs2As8fdrMxAO
         jwh8kyHX2HaBXkDB753CA12hlB10ulxUz9//nVt18mppQgdCuRQIHT6lXcd6hj4AHeCL
         kB2DxUPfIom9iP6yWtY9ogffqLE7vCWKM23T9Hss4d5HC4sTTWpF1/c/8ZXhKZToYRQk
         m0CA==
X-Forwarded-Encrypted: i=1; AJvYcCVFdCqRBRrrWnwf9ESudwepIo7TkLBvCo0zYLxo98fYceJsMk8w+xiyy53Vl3rFwMhcNtfB9vCRXuZ8gE94U1l20o8SuXkY+LXfVXWfnSkdAUSThXVuE1RLs7EG81aFVpjlctgm4HVCdrUnr3r5OX2Me8gJemnXhiCGAcBPCEVvM4KqHw==
X-Gm-Message-State: AOJu0YyKboB0KgVhLScabdFuD46oPKtVWdwYH/mtKCxcs99Ge0zJJrXi
	qSfQiE+6Lmd4HgQmOwTw4N7zNVDeotICzK/5NF3nfmu8cwjqS7NN
X-Google-Smtp-Source: AGHT+IHO3P7G2ACgRgHRWuPR2N7doNp8zWEKcCg2aPHO3ocLIJTd+T1tQkqgT2neR0+ux3KUa1ErbA==
X-Received: by 2002:a05:600c:458d:b0:418:2a04:d8cb with SMTP id r13-20020a05600c458d00b004182a04d8cbmr144543wmo.14.1713373268328;
        Wed, 17 Apr 2024 10:01:08 -0700 (PDT)
Received: from spiri.. ([86.124.122.31])
        by smtp.gmail.com with ESMTPSA id g2-20020adff3c2000000b00343300a4eb8sm17949441wrp.49.2024.04.17.10.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:01:08 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alexandru.tachici@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	marcelo.schmitt@analog.com,
	bigunclemax@gmail.com,
	dlechner@baylibre.com,
	okan.sahin@analog.com,
	fr0st61te@gmail.com,
	alisa.roman@analog.com,
	marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: [PATCH v6 1/5] iio: adc: ad7192: Use standard attribute
Date: Wed, 17 Apr 2024 20:00:50 +0300
Message-Id: <20240417170054.140587-2-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417170054.140587-1-alisa.roman@analog.com>
References: <20240417170054.140587-1-alisa.roman@analog.com>
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
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7192.c | 67 ++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 7bcc7e2aa2a2..fe8dbb68a8ba 100644
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
@@ -473,6 +474,16 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device *dev)
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
@@ -845,6 +829,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 						3, st->mode);
 				break;
 			}
+		ad7192_update_filter_freq_avail(st);
 		mutex_unlock(&st->lock);
 		break;
 	default:
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


