Return-Path: <linux-kernel+bounces-143763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941CE8A3D21
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59821C20CAD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A1623A9;
	Sat, 13 Apr 2024 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXnFYjZi"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC52262BD;
	Sat, 13 Apr 2024 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713021167; cv=none; b=Ek6MXH0KfoCgJwJ4XM7NgyimlgCf82yfuwg4rcxhhw9sOXAv2G6sNezjLGee4X4MqM96kwzWBNow/RdH3scP/zJWs0Tgfdvjwkdb4xi7/q6Byj5TvEPUFG6tfQcBAZsHOePDxdRyPiDzwEjAbTKN62gsnt7omPRHGAc9m4evQTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713021167; c=relaxed/simple;
	bh=O22EJf3Cxd7LhuWpyhu2TN+qJKoijknx7evp3ZrZrhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R4vpDiU37xu3RQkhxf9AG7Oj0au36rXIMN5AOCuYNsD0OsWFB4OmkSzV6Z7FbtMFnBsl8DGpMdFHXRUv1HIXjdLrqlmBL+Xw3bqoqLXHVQ8c+spxwcvE8eaeMJmp9hI5QeWynVClsOmsTh083CXgKgYOhk32u/pKyw6Iqeezn8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXnFYjZi; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56fffb1d14bso2413167a12.1;
        Sat, 13 Apr 2024 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713021164; x=1713625964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrAIbGvl062V/H8+KEradezmbkKsOapNvn4Za0W1owY=;
        b=UXnFYjZiUz+bVNVmPfBnnVB5aMzJJqleVloBbY7sOnbGQ3M0D9H7oqqHcCcsRFR0Vi
         mz2aUKCE90FcaLTZtR7dmCWTKpw00ee/+iC7Z/hvXbQiUJNQKI1OyMSeCRjWTgLypiSo
         Yn9o2E7UCTSCClVOk1GsUeiidjy1Zv4MU5GQP2R54u6BCicToi2gvzlOYvsW/NnvafQB
         SwlyVFn80zdYrOYcIImx8botxiDv/tu0Tr19NKbFC+rAcafEJYLT9q/AF3mh0xp2y4ea
         v79Nz6JmMLhZjRNvIEebStxzHPEj5tEpAWbihEbZGDQ+5u2rGigDC96+yI0c6Q6EnyBe
         CT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713021164; x=1713625964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrAIbGvl062V/H8+KEradezmbkKsOapNvn4Za0W1owY=;
        b=VUMPw35EjQPSjgaxCOQZxa/7WGYT1b22QD4WTAn1uvglrn2fqKFNjrrJEg7mrc03ug
         3h1qDoT2cx+RU/Uwnfjm6DXPQ4qRCAJgjWYEyHmGj+Bi8Ih8WWPvMrlHxoOiDGabtwc3
         utk5rBeUMJ7k3LQAez+Ea5E0MgK9UMSTglf5lIvUgRvoEKCFSbTk9oWrYEqdmq6fft5h
         8rLUr1d1MaaeIAtkkswpg/8NVI11a6aqzgCeU1eDwCpj5Vnk0nqIF6c3I8Y6Uvm8SZRX
         jNUAqCX27U2bDnMAzc6SQmSOUj4LhCzuIVO/MRw+Jzz3MiEzcLWPQU8fYasiZN1NLuy6
         udCg==
X-Forwarded-Encrypted: i=1; AJvYcCWN2AC3+CDIl2QISUCZ1/hQk6/TS/MBCJtQrlyMHAXL+wTf4W0m7QXIq+Lj5akm+mF1vqwVBFUxaC84SJegxA2k83iy2JjXXJ7pUhgxxJEQQnydhEsx3Mdl+k0whBbps8ufs0e5GnwMammVJJctGCwqOWQ2FIBlp8ZxyGRGNnWiLoejLQ==
X-Gm-Message-State: AOJu0YzLZtq7fLSiRzOHCChAFMbjT8d8hvIhI2EKBF3bvm8zJ5I9iMUT
	jlkxdglbHS5Z2oCEs+Z7NqwVdf39Rs9fHys/p9EhT+B/ugYOhY+3
X-Google-Smtp-Source: AGHT+IHoFqeoePISpFGsB074XF4BvxBF7Y4J0uSPtGuravVIiwQfD+AEvdW0dsUX5/ICFcaKh3kNKg==
X-Received: by 2002:a05:6402:380c:b0:56e:2b41:32c7 with SMTP id es12-20020a056402380c00b0056e2b4132c7mr6173192edb.10.1713021163869;
        Sat, 13 Apr 2024 08:12:43 -0700 (PDT)
Received: from spiri.. ([5.14.146.31])
        by smtp.gmail.com with ESMTPSA id w4-20020a056402128400b0056e2b351956sm2749883edv.22.2024.04.13.08.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 08:12:43 -0700 (PDT)
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
Subject: [PATCH v5 1/5] iio: adc: ad7192: Use standard attribute
Date: Sat, 13 Apr 2024 18:11:48 +0300
Message-Id: <20240413151152.165682-2-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240413151152.165682-1-alisa.roman@analog.com>
References: <20240413151152.165682-1-alisa.roman@analog.com>
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
index 7bcc7e2aa2a2..ac737221beae 100644
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


