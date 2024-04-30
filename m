Return-Path: <linux-kernel+bounces-164375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 959578B7CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D10F1F22FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730CEDF78;
	Tue, 30 Apr 2024 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAZQgyUW"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0C117BB0C;
	Tue, 30 Apr 2024 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494606; cv=none; b=lp64m70SZW0llBcNM9iXtbbb4ld2IOnPYwQ4OwhfeVaU1QgrRBPlHM1MeQsU/LOaQ6sXvzkQjXBGBQgm1MUpv5xLhlHJPHxClzCl+fD0WwhpmmMZMkvGSTiwTeM9nV/jUAqCRcdE28dSPAFtBU8WI7ud6kG7gyvUveOLqy7fTCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494606; c=relaxed/simple;
	bh=6Ot2Zt8xQ6gTbpCKhK6ZQoVffyGKgVaC07JA7IwyaZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wrnz84L5Aymgh6/R8/HvuAwpuf8CSewkAXeXU1HrDtQTBQQszRzVzdcaozCdTB9J5fFUiJ1NWqooqFsQy4Nj/xPSPheoXJWPjIC8b0Y4wtjsbCh4zCsUbvMaMxQvjNXqM49Srv9wkvujl4s1ptfeaXUmBLYwwzu0+XNfK8lEtFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAZQgyUW; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e09138a2b1so28872591fa.3;
        Tue, 30 Apr 2024 09:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714494603; x=1715099403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wShCpOhd/iedbhwtjzlwTTiwMIbq6GX/2w8mb07zQE=;
        b=OAZQgyUWq1ByrRKFTVJ68N0oOkT8fd7i7O+eMBa8cSIgIZonNKkYftSwYIHOtxlGMH
         g7Zv1s2zfxaKu/4sKZIvxKJFj3w3Iqw8X4KJBJHxrNTqO4fVTL/X3PJqlv2bieQsdNrx
         aSaSZFosLV6Fx69p88AsZ4CZVbokiT1P7DbO0NJIM49sf2++Cbh1EADgE6FS7pv1Vng9
         Da/5+H3UlpS2Tmv/poe7inUDLi2I5yJJO1F7OO8gGykISBY3NYTYGey5+/wIRuQAE3Pf
         LhXU4zYfveoWPm6BzNkbf0VLHMjGNLwZD2I94LbliHfdwlujmXGq/TEmuhS9pqPPJ/s+
         dnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714494603; x=1715099403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wShCpOhd/iedbhwtjzlwTTiwMIbq6GX/2w8mb07zQE=;
        b=BwHDkRCVvB9kvhLy7EYMFTxm9WkfdE6hygxv4274pwf/HAEYriR3+0QPTjQiJBzldJ
         eRKToLlB0ciAI9idzviDGgmmyBuERV/22UM+4VHhk4g6eC0rwIXZ2Esf14aPLBuPpeHc
         lHnJioD/S+05NlkpfmyZYUH81mKGL/USR4N+XjMgGZLYvnSKVbClyWEA0AZ2xCZFkMEU
         ZbmcYm1N/2KJKuM6a5Pz1ayOdosgtcwMsqPqlm5ZzA9BpVGqJI5emXd/4biv1w9YjCaN
         lGRr1/CmXs7DUGtr8eIr+Q0ertRx0PXJYSb3xlcx0vyHJT7rkbNSBMblAnB0WAaLylyg
         O8ug==
X-Forwarded-Encrypted: i=1; AJvYcCU92oYlq8IswT9kVFcQall8tf7rlBbT47Vqsgiwaah44maSIiwZyzFiqnpFmKc9FAVIpBs2ar1bEmxnIOT56r8SQEtGfix9/sY7c/Mb+EYLNqoH/BB3P73z29bcqkVWOoLWc/o/BK02hxZG+p59IJsMh/hOkrKstF9yyGsga1kDVI5hsA==
X-Gm-Message-State: AOJu0Yx0jWkjnodf0aaJuvMBz63cfHkRWRdE3ED/287LTY1+kmg2NajC
	gP0dW7DH+w5E7U9/k1UrMPHgIKSQ6/GSVTfoTGQiwnCagpX7Wz3v
X-Google-Smtp-Source: AGHT+IH+W9S1KJT0Z7qxSGWrvWA/DEzi6+M2i097A2M0b5J/81kit+MeS0G/tWrJMM6vXGgFoOXSVQ==
X-Received: by 2002:a2e:3e01:0:b0:2e0:c659:3a8d with SMTP id l1-20020a2e3e01000000b002e0c6593a8dmr133230lja.21.1714494600115;
        Tue, 30 Apr 2024 09:30:00 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a105:8300:da4d:6b2c:f166:22e6])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b00418d68df226sm46505396wmq.0.2024.04.30.09.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 09:29:59 -0700 (PDT)
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
Subject: [PATCH v7 1/6] iio: adc: ad7192: Use standard attribute
Date: Tue, 30 Apr 2024 19:29:41 +0300
Message-Id: <20240430162946.589423-2-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430162946.589423-1-alisa.roman@analog.com>
References: <20240430162946.589423-1-alisa.roman@analog.com>
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

Also moved the mutex lock and unlock in order to protect the whole
switch statement since each branch modifies the state of the device.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 75 ++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 7bcc7e2aa2a2..ace81e3817a1 100644
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
@@ -792,10 +775,11 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	mutex_lock(&st->lock);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		ret = -EINVAL;
-		mutex_lock(&st->lock);
 		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
 			if (val2 == st->scale_avail[i][1]) {
 				ret = 0;
@@ -809,7 +793,6 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 				ad7192_calibrate_all(st);
 				break;
 			}
-		mutex_unlock(&st->lock);
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (!val) {
@@ -826,13 +809,13 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 		st->mode &= ~AD7192_MODE_RATE_MASK;
 		st->mode |= FIELD_PREP(AD7192_MODE_RATE_MASK, div);
 		ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
+		ad7192_update_filter_freq_avail(st);
 		break;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		ret = ad7192_set_3db_filter_freq(st, val, val2 / 1000);
 		break;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		ret = -EINVAL;
-		mutex_lock(&st->lock);
 		for (i = 0; i < ARRAY_SIZE(st->oversampling_ratio_avail); i++)
 			if (val == st->oversampling_ratio_avail[i]) {
 				ret = 0;
@@ -845,12 +828,14 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 						3, st->mode);
 				break;
 			}
-		mutex_unlock(&st->lock);
+		ad7192_update_filter_freq_avail(st);
 		break;
 	default:
 		ret = -EINVAL;
 	}
 
+	mutex_unlock(&st->lock);
+
 	iio_device_release_direct_mode(indio_dev);
 
 	return ret;
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


