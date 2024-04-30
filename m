Return-Path: <linux-kernel+bounces-164377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1D08B7CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD93C1F22909
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC4517F370;
	Tue, 30 Apr 2024 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTeDtJun"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1489417F387;
	Tue, 30 Apr 2024 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494611; cv=none; b=Tg3J9KYWL1DzfqV6/7Gxuushkxn2cGtEoodjg7INbS8YFk8/U6W1ipsLbj2lt6HYIPQU6vPdpz+IB4hZm51pRiZPUaS7ZzuGBJeqIg6WGGYP0jPKLgI8zetrTl9exDX2DLPsruDX+G7voy0+azmFSmV9yH7VNZBMdfqquZaUqmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494611; c=relaxed/simple;
	bh=QsLboOF/0XsOlx2s9z3ovT/6p1lVRlJ7eCoAhPOhAhY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pWwP660E6oBC3rc4spKY1N8KS8rk3jmjSFC2gLVSTxW6PUj9BDXF61jfiRz2HkEqfYfAWiBi1jp3KZSAhAJQlIHtdOhkHWMhhv+S/UzvFCS2Gc4jskkKDD0NLD0ftmbQulww+UW6tH/pyFROxmgS5u5E7FEy0FK/31p4dmO4JEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTeDtJun; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41bca450fa3so26764755e9.2;
        Tue, 30 Apr 2024 09:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714494608; x=1715099408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuvzW96VsPwYsZBpvEgeCq9QRjq4qCJkvunjr2kYGgc=;
        b=nTeDtJuncxRalxvFX84UyEc82slhxxuxx5bjNl+FXAZc/a+QjGD4kU6iHqznwDOL1h
         20M/cgNI19CIisFhflVClEtDM8oDDsDPhVc82CHIeT86DRFrzE3X7FE/VY4QWLoLWBfo
         bdbZ2AiaHsCTNTESDIW8RNG2uprnNI/uXNJOlOlb/WxoHc2AJzhJqidWGEriF9saAJs7
         5VOHPNMfGYM8X9+fS/ePDzsEr6G/k/5FDBtRES66J6V7hnA1IoAmhbj1zVtUwnl2/ssA
         wBqUU7gEMu9QWKw4Iatp+SE9k4u674H/Ot4ne5Ef9YIg/zvmByK/0DlpAyoY1quFj4Ow
         O37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714494608; x=1715099408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuvzW96VsPwYsZBpvEgeCq9QRjq4qCJkvunjr2kYGgc=;
        b=VAXX9rkTQ3c2DeC9cJRadcWmbRnmwQsVjlWtClkbgHq81BU+QHM2KwYIwmCVUP84gF
         gdYUQEOJzdLbqUq0pY/KIGe6nbOE4RQx78jjSH1Mf7nrb/8bc6MGBVqFVeocZH2HLnUs
         VTFYUYxr5UzoT8WDEQ9GhLJ3ourdq0O4whVgzQBp9En/Lysx5DsLugeC2zXtg6K3b5YV
         lS0Y65IzkK+Zavm2f0GsS2m+Zl5NStk2jWO/uCVplugcq4FBQuFR6nRgtKFwyk8MfFz1
         U3hfjjXjLY3pdft1AsFcy61MVg7H3JPDich8WhCEpyG10YvHjIeFHakvx0a1zWSWYJPg
         +uqw==
X-Forwarded-Encrypted: i=1; AJvYcCU2eHfxSjZqVyNDwAgrvIMGTcjWqc1B6mWXIqCI6BLmUzce3vhGIv7P8JSyNZaSkBYnu1ijdnBY3ePlVTDy5CgBDr+podUXyOO1HWQ/bCM6z039XGhzGb7eE0RO+oNQvxtx9/yfZv9AyFYtLwOus2fknSjkj9cdJrTDHmjRapNA2boMaA==
X-Gm-Message-State: AOJu0YxcpOyqTKwJUmoQsaCyityhBtWk0GI6JORSX7HJ7CDhzPMdArMC
	5YSMTuHOzaak14WnmwgTvn3nit4hm/ByU3ZedaenqJBx9aTiOT9W
X-Google-Smtp-Source: AGHT+IFYrA+0KJZwn8kBfRqlmf9QE2S7bNx3Ycr3UVFWfmK9C2ZpcJRZXrVVuHlb0gQi3RB+xJaTuA==
X-Received: by 2002:a05:600c:1e09:b0:41a:7065:430a with SMTP id ay9-20020a05600c1e0900b0041a7065430amr11986wmb.41.1714494608327;
        Tue, 30 Apr 2024 09:30:08 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a105:8300:da4d:6b2c:f166:22e6])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b00418d68df226sm46505396wmq.0.2024.04.30.09.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 09:30:08 -0700 (PDT)
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
Subject: [PATCH v7 3/6] iio: adc: ad7192: Add aincom supply
Date: Tue, 30 Apr 2024 19:29:43 +0300
Message-Id: <20240430162946.589423-4-alisa.roman@analog.com>
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

AINCOM should actually be a supply. AINx inputs are referenced to AINCOM
in pseudo-differential operation mode. AINCOM voltage represents the
offset of corresponding channels.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 41 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index ace81e3817a1..3e797ff48086 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -186,6 +187,7 @@ struct ad7192_state {
 	struct regulator		*vref;
 	struct clk			*mclk;
 	u16				int_vref_mv;
+	u32				aincom_mv;
 	u32				fclk;
 	u32				mode;
 	u32				conf;
@@ -742,10 +744,19 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 			*val = -(1 << (chan->scan_type.realbits - 1));
 		else
 			*val = 0;
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			if (st->aincom_mv && !chan->differential)
+				*val += DIV_ROUND_CLOSEST_ULL((u64)st->aincom_mv * NANO,
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
@@ -1052,6 +1063,7 @@ static int ad7192_probe(struct spi_device *spi)
 {
 	struct ad7192_state *st;
 	struct iio_dev *indio_dev;
+	struct regulator *aincom;
 	int ret;
 
 	if (!spi->irq) {
@@ -1067,6 +1079,31 @@ static int ad7192_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 
+	/*
+	 * Regulator aincom is optional to maintain compatibility with older DT.
+	 * Newer firmware should provide a zero volt fixed supply if wired to
+	 * ground.
+	 */
+	aincom = devm_regulator_get_optional(&spi->dev, "aincom");
+	if (IS_ERR(aincom)) {
+		st->aincom_mv = 0;
+	} else {
+		ret = regulator_enable(aincom);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to enable specified AINCOM supply\n");
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
+	}
+
 	st->avdd = devm_regulator_get(&spi->dev, "avdd");
 	if (IS_ERR(st->avdd))
 		return PTR_ERR(st->avdd);
-- 
2.34.1


