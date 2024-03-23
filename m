Return-Path: <linux-kernel+bounces-112340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3946388789C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666751C226BA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D219141757;
	Sat, 23 Mar 2024 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNNLVOmm"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797CF3D0CD;
	Sat, 23 Mar 2024 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711196445; cv=none; b=dkoqxIao6sIzKeJXw+C9Pg6nATNyKR5+L+xq/lNzUiFTklQ63Ptn7dPmIdLrblev9MhzCPyWckwxIMfgpOe6rPQkLLjekofvvC+h0fkuxcvP08VTSMextEKHP8xJAEMrwTrhmnnyIBZqX7mD7Yy5T7ZKaAsyw8GMvUEwUPh486w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711196445; c=relaxed/simple;
	bh=FAvMVuNp7mg5L7oKkcGsDQhCb9LCgqTOmyldi4lvU7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bc3nIh/fZVAMaI1DK7F87bp11N2G8Ewo4D459HvgrF7d2/W30yZ7uDQ+w5ecq1k/20Fcp0tprdyH6u9cHy2Js2cprTSqkV3kixE0ZcVeJA/jSzyv7YZCLLEIc0aBZgziZYzCoWnNEAow4ErB0qfgveQA15hqwNUuxroHToXIuR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNNLVOmm; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56be159c0b3so1838232a12.3;
        Sat, 23 Mar 2024 05:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711196442; x=1711801242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfD9ogcu0YmTy1/lsVwah5XVZmwlR7yt3/IMurcSlXI=;
        b=gNNLVOmmkUzZ7RQccNruNzTYurYejQSpZZUJQQicr/aUSPP1OLdAa+KIJdjpXrGNI0
         RXwuPFonjp1aMR6XQKyJZ330RSxjaBbqjnpZ3OZ4TGceICb9DNIomt4oZWDZiQISW+xv
         J9JjsHUCwZGhyotcfmB1nMb0kXMh1kHWDO7vMUAm9i28ApK+UCvWk+emuLY3vom57Hgr
         0zWP9zECoXAxyXugeqmW3ex1+ZyjnfdwnjijzA3GylJjux3Y9o78qCzdszYFaUJoBCvl
         fBDQcXaNStAOA8Wq6WI3T4flT1XRq1Pi9U/5l+2P73hrS2fDWaB0ODBKSUOLw60v5xaa
         CCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711196442; x=1711801242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfD9ogcu0YmTy1/lsVwah5XVZmwlR7yt3/IMurcSlXI=;
        b=OYjdLqlyaeL8QErkmh5+y2BLDeXiL8C0C5sQeHpcd323mGMPmcPQ12mZwOFg92bADg
         cj2yjANz9F6/O56FXPrDVZ+UQYpyEA8a+aGnjXmr8EhUkS0RpINpfC2JOX1EqeRwfd3R
         EaTepd8n2hZdl2liGkAATtrR56IBDyi11E9t30Rq0OkAtsP8bczh7HsJ4c2dCwGOoMVo
         JDV41CjvQ46ObM6+0LygcjZ6rLwTtF7foOCUc52J9+dDWXd5Zee8MmAxGphU3MgzIMtd
         oRK1uINtVKvMsXtV0lxGmxgo0QVcic8Oh4LLrHyOpEg4iTYI0PX25I/+fBa5ilRz5OuH
         6nCw==
X-Forwarded-Encrypted: i=1; AJvYcCVS4EIqJgrtFoCsrPKZ+6a5ugHzRPfJgcoEnTBYsYMZNpfoZCAifaIDplvoUZTcT86269LKfwMI81Ybkwzp0UsU1YHPSJB7PfBMcLORX1ScgiShAAkVfCzY2murqCUEONQc6lxa1dBBxw==
X-Gm-Message-State: AOJu0YxwfVTCHF9kF263f70r1M4O7yrjVid3v69CHcg0Ss3vWg/sx/lV
	CUNOJULYC2LQNsMoMCHJgbamb+oFt2vA6NZhnNm1okJrxM12Fajb
X-Google-Smtp-Source: AGHT+IFs0dFgeRNaPVOY9h1HgOX/80K85jL0TE6TFdzWwZzq+TZJOQe8wZ/rWzadVd0jlOz3G1xtCw==
X-Received: by 2002:a17:906:24d9:b0:a45:2e21:c776 with SMTP id f25-20020a17090624d900b00a452e21c776mr1568865ejb.3.1711196441841;
        Sat, 23 Mar 2024 05:20:41 -0700 (PDT)
Received: from 764c7355c69b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id gx24-20020a1709068a5800b00a46f0d133b9sm857265ejc.98.2024.03.23.05.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 05:20:41 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v3 2/6] iio: accel: adxl345: Make data_range obsolete
Date: Sat, 23 Mar 2024 12:20:26 +0000
Message-Id: <20240323122030.21800-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240323122030.21800-1-l.rubusch@gmail.com>
References: <20240323122030.21800-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace write() data_format by regmap_update_bits(), because
bus specific pre-configuration may have happened before on
the same register. Changes then need to be masked.

Remove the data_range field from the struct adxl345_data,
because it is not used anymore.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index ae12836b5..33424edca 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -42,13 +42,13 @@
 #define ADXL345_DATA_FORMAT_4G		1
 #define ADXL345_DATA_FORMAT_8G		2
 #define ADXL345_DATA_FORMAT_16G		3
+#define ADXL345_DATA_FORMAT_MSK		~((u8) BIT(6)) /* ignore spi-3wire */
 
 #define ADXL345_DEVID			0xE5
 
 struct adxl345_data {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
-	u8 data_range;
 };
 
 #define ADXL345_CHANNEL(index, axis) {					\
@@ -227,14 +227,13 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	data = iio_priv(indio_dev);
 	data->regmap = regmap;
 	/* Enable full-resolution mode */
-	data->data_range = ADXL345_DATA_FORMAT_FULL_RES;
 	data->info = device_get_match_data(dev);
 	if (!data->info)
 		return -ENODEV;
 
-	ret = regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
-			   data->data_range);
-	if (ret < 0)
+	ret = regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
+				 ADXL345_DATA_FORMAT_MSK, ADXL345_DATA_FORMAT_FULL_RES);
+	if (ret)
 		return dev_err_probe(dev, ret, "Failed to set data range\n");
 
 	indio_dev->name = data->info->name;
-- 
2.25.1


