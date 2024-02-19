Return-Path: <linux-kernel+bounces-71855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB3485ABD2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B261C21373
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B23050270;
	Mon, 19 Feb 2024 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmG+t0ry"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E217550263;
	Mon, 19 Feb 2024 19:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708370056; cv=none; b=qyyhk5Qy4pTP/cFGUlaZUjicIf/SNkyupW214VC3O9GargtbjnX35DeskPZlhPXey+NTsJirD8J5aD0OvsLZmjrQno3YU7CXlFKejE/V91RaFPh6fB4q8PyBUFzPlDaiTDFc7VLoLu9S7bMmnRCmcOXBNXQ0w6NUYsJ487qgcyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708370056; c=relaxed/simple;
	bh=da68WG+9+cs957jLvUmfFPFLoRDwIl9aLR3Jrh8OnoI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OD2svPes8vth4+JMRCYQYn7vw/33wUCvqckKy8zsS3BlHaA980XVFBdfVgnhyHhc/pYf/Ld1QZY5opyR35Sad1Q16oQPELtWUyHFp7jUqhwvQsdSCOgDi0Asp3ImNT9gzyi7m+M3A0NWQsJPCYWpa7uvrJXvRR3YMNyg+sSqWv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmG+t0ry; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563c0f13cabso5618888a12.3;
        Mon, 19 Feb 2024 11:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708370053; x=1708974853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DGtUAbZnMVEONtWd84sI7JZiujmslAIFb19qhDo+qH0=;
        b=cmG+t0ryK5YzJH3mAi2RQzBWPChpTA3yYoeiwWxhvSH/0AL706FnXBwyFTXslAhtce
         SXcoKb+k0bUKfoSz3mnrD+PiW/2G2RvHbC2+UzKBuP9YeN6dLUybkq4ewasWZP/Nzgts
         fniwn6civAKqTNd+QokeKs7wkur9m5oOA/fPhjYWXQgyI2S3nq70WgDATWJaMHxR9Rd/
         yZePnYvtsV4komVpTWMGJ10hMVz5Qe7Ryhj0ATWSVsKbHmqajwoIfLWG59FI8UZNgaCo
         ZCh1rf9kS5RT1VR1AQWFejP5sjDa/RdZu04tdbQWaOE5tZgn4SjsmVONyGLPG8QFDgg0
         QsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708370053; x=1708974853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGtUAbZnMVEONtWd84sI7JZiujmslAIFb19qhDo+qH0=;
        b=umNhHepnrOQgffof2FW33UE/ftTxcm59Wj5bkfHIBIjMt8EGQ2X45cNnsWn4UM0bOj
         V8XcSsPgWaQZbZseahXUyePCH3GKqgpemj8jUrGqQT7kjNRdDSO1y+dxhZvudhgi09xx
         6sfqkAXdQmCWrKSb8EnWGUJmUhr14Fq5MH1dqpAJPL9P8YvJS7gnBeqGYC47XUYercV2
         xahz+wjrTWTdEFNJzIFdBMe6OS4I6dhrahZ+CZflM1bVdF6KpvD9UkhSCM2Q6ms1oviU
         icW82rZwiW7aLmEQata5p+lOThyDnN13QtLR95fIA48POYTNJTcta1x6Rdoc5Tbej2Us
         Mhqg==
X-Forwarded-Encrypted: i=1; AJvYcCWP3tC30QKjMeqRUC1mxSbagl+RNuXO8/gmpIrWc9nnggZLIaYL5q+04Qi1HbVZpSQi8EWMxqnXPHQAsX8prFYVxh4xT97PRGT48tQVwc3yNY8Jxa7zFyt+ALmcftKYHzxM8cZrYuC3
X-Gm-Message-State: AOJu0Yz9QQ2AGnU/e+Rb+qNA2w+48ip29KwA1b/p5VWNbcHzcdro7GpR
	YfJJd2dIzvhB5YijqM+DUj+NB0ZpwZgOgWo5u/Ql4vXi4+N8Sy0OBxNcFgi8JMGc5g==
X-Google-Smtp-Source: AGHT+IGyfjKvhzur+bVsa+RMjDwNnRcOF8FZrWj7+1IitS/HqQwcm+CjUOGJJhHtmJxykAaBpxpD/w==
X-Received: by 2002:aa7:d152:0:b0:564:3887:4fea with SMTP id r18-20020aa7d152000000b0056438874feamr3747128edo.18.1708370052898;
        Mon, 19 Feb 2024 11:14:12 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:82:7577:3f11:8c45:6350:e419])
        by smtp.gmail.com with ESMTPSA id y5-20020aa7d505000000b0056200715130sm2939061edq.54.2024.02.19.11.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 11:14:12 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	ang.iglesiasg@gmail.com,
	andriy.shevchenko@linux.intel.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH] drivers: iio: pressure: Fixes BMP38x and BMP390 SPI support
Date: Mon, 19 Feb 2024 20:13:59 +0100
Message-Id: <20240219191359.18367-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the datasheet of BMP38x and BMP390 devices, for an SPI
read operation the first byte that is returned needs to be dropped,
and the rest of the bytes are the actual data returned from the
sensor.

Fixes: 8d329309184d ("iio: pressure: bmp280: Add support for BMP380 sensor family")

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-spi.c | 49 ++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index e8a5fed07e88..1972014dca93 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -8,6 +8,7 @@
 #include <linux/spi/spi.h>
 #include <linux/err.h>
 #include <linux/regmap.h>
+#include <linux/bits.h>
 
 #include "bmp280.h"
 
@@ -35,6 +36,33 @@ static int bmp280_regmap_spi_read(void *context, const void *reg,
 	return spi_write_then_read(spi, reg, reg_size, val, val_size);
 }
 
+static int bmp380_regmap_spi_read(void *context, const void *reg,
+				  size_t reg_size, void *val, size_t val_size)
+{
+	struct spi_device *spi = to_spi_device(context);
+	u8 rx_buf[4];
+	ssize_t status;
+
+	/*
+	 * Maximum number of consecutive bytes read for a temperature or
+	 * pressure measurement is 3.
+	 */
+	if (val_size > 3)
+		return -EINVAL;
+	/*
+	 * According to the BMP3xx datasheets, for a basic SPI read opertion,
+	 * the first byte needs to be dropped and the rest are the requested
+	 * data.
+	 */
+	status = spi_write_then_read(spi, reg, 1, rx_buf, val_size + 1);
+	if (status)
+		return status;
+
+	memcpy(val, rx_buf + 1, val_size);
+
+	return 0;
+}
+
 static struct regmap_bus bmp280_regmap_bus = {
 	.write = bmp280_regmap_spi_write,
 	.read = bmp280_regmap_spi_read,
@@ -42,10 +70,19 @@ static struct regmap_bus bmp280_regmap_bus = {
 	.val_format_endian_default = REGMAP_ENDIAN_BIG,
 };
 
+static struct regmap_bus bmp380_regmap_bus = {
+	.write = bmp280_regmap_spi_write,
+	.read = bmp380_regmap_spi_read,
+	.read_flag_mask = BIT(7),
+	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
+	.val_format_endian_default = REGMAP_ENDIAN_BIG,
+};
+
 static int bmp280_spi_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
 	const struct bmp280_chip_info *chip_info;
+	struct regmap_bus *bmp_regmap_bus;
 	struct regmap *regmap;
 	int ret;
 
@@ -58,8 +95,18 @@ static int bmp280_spi_probe(struct spi_device *spi)
 
 	chip_info = spi_get_device_match_data(spi);
 
+	switch (chip_info->chip_id[0]) {
+	case BMP380_CHIP_ID:
+	case BMP390_CHIP_ID:
+		bmp_regmap_bus = &bmp380_regmap_bus;
+		break;
+	default:
+		bmp_regmap_bus = &bmp280_regmap_bus;
+		break;
+	}
+
 	regmap = devm_regmap_init(&spi->dev,
-				  &bmp280_regmap_bus,
+				  bmp_regmap_bus,
 				  &spi->dev,
 				  chip_info->regmap_config);
 	if (IS_ERR(regmap)) {
-- 
2.25.1


