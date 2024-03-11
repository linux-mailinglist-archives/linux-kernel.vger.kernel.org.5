Return-Path: <linux-kernel+bounces-98390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9F387795E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 01:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A661C20E11
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9827CA35;
	Mon, 11 Mar 2024 00:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBL7+as6"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4578F622;
	Mon, 11 Mar 2024 00:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710118492; cv=none; b=bC5mLAukTKwIv2DZGZP9/f4O8CIi1QVutbD8yaxR66ZFrOAAYqlAivAgDoVHCUwXseMGm368Y1yMCQJSIMtQ/AzLrhsO6nIetnP3nd5TU81guyFqLueRrOpKLKOB2NBSTZTmcsNHt22v8lFZ+yqPd9WN6lWRUJvEm83+MSCFh60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710118492; c=relaxed/simple;
	bh=HJxx/b9XqDNTujCI2CqDQmRKxxztVUqH1ZaHHY1D4J0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RHj3aiC96kM2Jx34FP3K0hkOvXxAD/WoZ9NxUL7XeZH929XCEgMD098S438Oqcrm+BObRv8TP9TKXX7+YvGbLqmwJ3W+BFEz28LvhVeRzJrxbhatjGNhoW7QUVsbNRhug8guuq9Quq6d491Q3a7rVRDJOOztv2PXKT57Uef0QHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBL7+as6; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a28a6cef709so363167266b.1;
        Sun, 10 Mar 2024 17:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710118489; x=1710723289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jRtxWB8Q0Yuuhy6rs9UUDDIt6Ct+XJ8tkpooJ1CMz/E=;
        b=KBL7+as6qx6sQ8lQ22I7vwLTv7pkd0CM9VrTd0yBzqEttv2lEC7g2UFaJ6rIj8HpB5
         cVFavcBRmV+JMURKdAM6B4R3b1JcTJ1b2+9zprlzEG2fawzAQF21QrJnoYlHlo4/2jJX
         r8cfMEGhDTjVS6ASIiPyvVOPqKL/4tuyRuBgCfZHd5JREAsy5/5lG8azILcWLPjyjGGz
         FRf4YdZhLERQbKgtfr59qFy8Zg5onF0QMUcTUFaTIOmz6dy0ARL6MiKKSdZqvmlQDbbU
         z1JQZ+J3eHSiVQKiy4qIXD50PHLtjSaCzcFxPXBXM3XuLjbFWeNjcy3ZoZyvtJvfE0GK
         2nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710118489; x=1710723289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jRtxWB8Q0Yuuhy6rs9UUDDIt6Ct+XJ8tkpooJ1CMz/E=;
        b=PM0W4jYroRvcUujpS0RtlgexSApPKXxyaSmbE4NnQjhoqMxaSHwj7rXB6n/2JWxbGA
         0eAQBJ/dhFQrWQ9qcWCJDNT02VCobgPAzTI4+MTFW5pUsN10wkckVG2Bx1qVqQTjY3cf
         uk04gV0TrZr8xgRospkOyZ4SGG4bOxx1g0v90sLUiL4+OJ1H6/yVw7Awvr7tHCMkoBzX
         fJVvQ99h3c6jFckD1rOsxxKghI5pa5co6rYZdouzyyJxNWQ1G47qVUldLT2zTP46cFe+
         6WMvsavuvdvfVYjYMkCjfifP53a9N4+krknRftrR7qfyi4x95RGHAEgCYbIVYBI8GxHD
         AqaA==
X-Forwarded-Encrypted: i=1; AJvYcCWAGEZZS9OQUqF2vhvXU4fjM44uEmZ0VXEG6T1FHCT0wLPNA0dJNDPcURLp6Oo05on284b/zezKg9ySW7yvIJtvUbZjQt05X9dWn3jybpYf0wFFe4EFMKUtjlekfI9QdlBDWTQ5x6H7
X-Gm-Message-State: AOJu0YxCIfGAjwWoIZ5Fvo5mJomnUoE9FP1ZDNqtwj+LH03U2p8JY3lQ
	9g/vYf1Nv70Yk9O5lrWvJ3JpPLh23G2GvX65OBtGSaQLUnbVDkVn
X-Google-Smtp-Source: AGHT+IHQwN7D9vCo1ffxDPINsTxfXuuu4MZDHo7+8KW3I8FK46QB4W7VJcGbdfe6eELYv3OTCzQ2OQ==
X-Received: by 2002:a17:906:7084:b0:a3f:804f:c1a4 with SMTP id b4-20020a170906708400b00a3f804fc1a4mr3505703ejk.74.1710118489342;
        Sun, 10 Mar 2024 17:54:49 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:b24d:a5cc:76ea:4a7a])
        by smtp.gmail.com with ESMTPSA id qu21-20020a170907111500b00a45d17148a3sm2403535ejb.13.2024.03.10.17.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 17:54:48 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH] iio: pressure: Fixes SPI support for BMP3xx devices
Date: Mon, 11 Mar 2024 01:54:32 +0100
Message-Id: <20240311005432.1752853-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bosch does not use unique BMPxxx_CHIP_ID for the different versions of
the device which leads to misidentification of devices if their ID is
used. Use a new value in the chip_info structure instead of the
BMPxxx_CHIP_ID, in order to choose the regmap_bus to be used.

Fixes: a9dd9ba32311 ("iio: pressure: Fixes BMP38x and BMP390 SPI support")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 1 +
 drivers/iio/pressure/bmp280-spi.c  | 9 ++-------
 drivers/iio/pressure/bmp280.h      | 1 +
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index fe8734468ed3..5ea9039caf75 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1233,6 +1233,7 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.chip_id = bmp380_chip_ids,
 	.num_chip_id = ARRAY_SIZE(bmp380_chip_ids),
 	.regmap_config = &bmp380_regmap_config,
+	.spi_read_extra_byte = 1,
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
 	.num_channels = 2,
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index a444d4b2978b..3a5fec5d47fd 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -96,15 +96,10 @@ static int bmp280_spi_probe(struct spi_device *spi)
 
 	chip_info = spi_get_device_match_data(spi);
 
-	switch (chip_info->chip_id[0]) {
-	case BMP380_CHIP_ID:
-	case BMP390_CHIP_ID:
+	if (chip_info->spi_read_extra_byte)
 		bmp_regmap_bus = &bmp380_regmap_bus;
-		break;
-	default:
+	else
 		bmp_regmap_bus = &bmp280_regmap_bus;
-		break;
-	}
 
 	regmap = devm_regmap_init(&spi->dev,
 				  bmp_regmap_bus,
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 4012387d7956..70bceaccf447 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -423,6 +423,7 @@ struct bmp280_chip_info {
 	int num_chip_id;
 
 	const struct regmap_config *regmap_config;
+	int spi_read_extra_byte;
 
 	const struct iio_chan_spec *channels;
 	int num_channels;
-- 
2.25.1


