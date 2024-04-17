Return-Path: <linux-kernel+bounces-148959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA918A89AF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0711F1F2546E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DBC172768;
	Wed, 17 Apr 2024 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToSFFcbE"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05EE171099;
	Wed, 17 Apr 2024 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373282; cv=none; b=jSv/H00p/Ika32fJ+8kyxrctc1ZvWzOH6hN3Nr9lcm+eoRylj3mvWsC5SR0R2gxoFvXO8dYR6ju0zUNIL46Mh/D55tVtbAclGPGy8pxE79ZOU46cBhsvufYqrpf3/dQyMf7fVP/4HbXr8ThOTjFq4a01bXrUZXpiKesTQnMYdDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373282; c=relaxed/simple;
	bh=pCvbn1jf61MwV669wcYaAao51BqGxjxViYHqPph/RqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aPKnDTpEjIrjsf/xlcU/a37dmCIaFuyilnPOP5Sh/3t0X3dcXlSaghmmE+KyXv8/TLwT/2wKZpPrTQfWYCMJ7q28JVVCG0fFp/pPLHXImQyaSPRTgT8n1OpowgtLAp7o6Mo+Y7dI41BOkJtnP85YD6DZK8FWEWJrKIf3APck+J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToSFFcbE; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-343d1003106so4078906f8f.1;
        Wed, 17 Apr 2024 10:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713373277; x=1713978077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZG4WqLxP5AYNlP8VpmeGoz9TMkj0yHMcCFSjBYjuRRE=;
        b=ToSFFcbEQfUEBaKNvdLMVQgqLsWgD3E1rSsxBR6UmxHwhp2SJAEq1wr3nh0ePGtIBR
         or5rJ3bMOMXqV6q/QzRdTISWkDTLLpIC1sJ1Y2f2RGX9cvnEKcMzFtKL4Yz95CoP4m9j
         lLTEACzARpRiQQTEZMriiWbH3qvy/DejZIgvDhV9ZnIlAEoiHvnxu1EGlBeg6eGJGBYT
         10T6SDdchL0O1la9iiVPAhBRCuK4GSGvP5uZo6qz+G86X5aScupRZQrgS0FYd//gMBt3
         8gLXuqe5O0XjkV+aiMkccjsbOqIFFuDlAk9Vs2M1EEgLO0YWt/ljd6try6t+ssyVl0/Q
         cegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713373277; x=1713978077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZG4WqLxP5AYNlP8VpmeGoz9TMkj0yHMcCFSjBYjuRRE=;
        b=B3ciQbMTqIp/URG6j6zrCbqYawXYOD47M2ap4RKF10GpZpZtgouWUgyT8p16CWfd41
         48I+JXC6kYouV08S6xanxT7yRCulZKrH3LcCF21I6H3VoJO1VeaiFVm+5x4HpkKzLt/i
         /N4Qc4hDPOoEz/oy335kp+qL9utik8D+8E0e6RgbhU4dSL1lIzX3YK3PIoKF/gqGeelS
         h+EAlJ16VmGfmysvUZA913wE6S2Lm7aPNuqipTu140t1phkBt39nFRR6E5kZtAQnBByZ
         /dYQleZRcfiNeMdTFcDJnfS2JEIGzEpzDNZm8lgzfWLsbWG9DP8PosalDgJPReqmUwN/
         +vFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr03w3xqbrr1xwNpZWA2ZLrmzkcuWzPLJDUtngXjcP7PnhO1K6t/urC93A5yocZcKC9gxR70Nhj90So2ES47jmkukLKnR4hvIlSLrA1/cPNAo/FLuLKFf2TVf5JC0TK7fazcfcViBF9TMMg3f3H8RK2nxyQZIr4q78RxxYURXkEF18hA==
X-Gm-Message-State: AOJu0Yy0kIUK99sa+iDdU3zeB7WXm57Z0FDhv2lB2Ev5zCwzkbK3YNIV
	a4ZwcvwU0f6SXMFhMVmHOU958ibUIEZ4Gue9KYE8TbBrfVn1lCrO
X-Google-Smtp-Source: AGHT+IGabgp0ffGze20cmg3gFkaG8DErVtupbaTCdQjsgtC1r5LnagzvVjbp+F6lV6IWNTAkPYw89Q==
X-Received: by 2002:adf:f542:0:b0:349:d779:3d60 with SMTP id j2-20020adff542000000b00349d7793d60mr1261551wrp.57.1713373276711;
        Wed, 17 Apr 2024 10:01:16 -0700 (PDT)
Received: from spiri.. ([86.124.122.31])
        by smtp.gmail.com with ESMTPSA id g2-20020adff3c2000000b00343300a4eb8sm17949441wrp.49.2024.04.17.10.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:01:16 -0700 (PDT)
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
Subject: [PATCH v6 3/5] iio: adc: ad7192: Add aincom supply
Date: Wed, 17 Apr 2024 20:00:52 +0300
Message-Id: <20240417170054.140587-4-alisa.roman@analog.com>
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

AINCOM should actually be a supply. AINx inputs are referenced to AINCOM
in pseduo-differential operation mode. AINCOM voltage represets the
offset of corresponding channels.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index fe8dbb68a8ba..8d56cf889973 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -186,6 +186,7 @@ struct ad7192_state {
 	struct regulator		*vref;
 	struct clk			*mclk;
 	u16				int_vref_mv;
+	u32				aincom_mv;
 	u32				fclk;
 	u32				mode;
 	u32				conf;
@@ -742,10 +743,19 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 			*val = -(1 << (chan->scan_type.realbits - 1));
 		else
 			*val = 0;
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			if (st->aincom_mv && !chan->differential)
+				*val += DIV_ROUND_CLOSEST_ULL((u64)st->aincom_mv * 1000000000,
+							      st->scale_avail[gain][1]);
+			return IIO_VAL_INT;
 		/* Kelvin to Celsius */
-		if (chan->type == IIO_TEMP)
+		case IIO_TEMP:
 			*val -= 273 * ad7192_get_temp_scale(unipolar);
-		return IIO_VAL_INT;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = DIV_ROUND_CLOSEST(ad7192_get_f_adc(st), 1024);
 		return IIO_VAL_INT;
@@ -1052,6 +1062,7 @@ static int ad7192_probe(struct spi_device *spi)
 {
 	struct ad7192_state *st;
 	struct iio_dev *indio_dev;
+	struct regulator *aincom;
 	int ret;
 
 	if (!spi->irq) {
@@ -1067,6 +1078,27 @@ static int ad7192_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 
+	aincom = devm_regulator_get_optional(&spi->dev, "aincom");
+	if (!IS_ERR(aincom)) {
+		ret = regulator_enable(aincom);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to enable specified AINCOM supply\n");
+			return ret;
+		}
+
+		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, aincom);
+		if (ret)
+			return ret;
+
+		ret = regulator_get_voltage(aincom);
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "Device tree error, AINCOM voltage undefined\n");
+		st->aincom_mv = ret / 1000;
+	} else {
+		st->aincom_mv = 0;
+	}
+
 	st->avdd = devm_regulator_get(&spi->dev, "avdd");
 	if (IS_ERR(st->avdd))
 		return PTR_ERR(st->avdd);
@@ -1113,6 +1145,7 @@ static int ad7192_probe(struct spi_device *spi)
 	st->int_vref_mv = ret / 1000;
 
 	st->chip_info = spi_get_device_match_data(spi);
+
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channels;
-- 
2.34.1


