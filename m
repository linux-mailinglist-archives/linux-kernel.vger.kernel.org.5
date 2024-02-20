Return-Path: <linux-kernel+bounces-73775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1091285CAFB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08F9286692
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE8B154448;
	Tue, 20 Feb 2024 22:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZLJuqEV"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FF9153BFF;
	Tue, 20 Feb 2024 22:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469048; cv=none; b=kJEZZX+zK2nZ1ssmjDhE+qw7jqhKVIL5IfU6gt3Cj/Bf1bwq+1Sqb2OBfPLzDRTUAN+lkVmU6+K9yzLy1mRHQE5zONVtkKmXM7JKdhyTJJqvclQzPdlxLeX4+h7k60DQVaL3f64fum1wLa9IhJ5hf2r7rYohUT5QNxXw1u9Nr3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469048; c=relaxed/simple;
	bh=/pVkv4ahqKqlMfpVpKXwkQU6mvxYDlM+vpKV0K0Y2i8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QA3Zb5D9nCrTlRw99DctFRIkX6pmvvGS8be/rzUuyRVaZt0cM0lAgUrWGwKcknprbMD13d8FaXa6hdQnnrJzOK2obYmbhJJ4w7Hl6zsZlhwHzgJbSeAvlBenptXSUrDQxxcDqXJ6gT44ss1OKlDwgK/JpdVH99UbC6xFZBzEn5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZLJuqEV; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3f1bf03722so90779766b.1;
        Tue, 20 Feb 2024 14:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708469045; x=1709073845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDvZdKqqAEQWTERmxxTyBVJONY656Jlnfr4NEFK+UlQ=;
        b=WZLJuqEVgBHEeviE4+s4tyyIU7UecjHBVD2raLwpq4PsnVkXFRWxOan354vplnMnjr
         CgfyIBZTlFkiI2xSF/PT9SN1l/90uc6EJ/VmSScrlm752jlnV/io3Da42VPsFt6zLWqh
         dzoVYDasJQtMwe5LxID5hGm0ljeu9fQWsm/YQd6s9bpse5jRBh8xqJo4bDGw5B3UgT8O
         chUeCxjcjyoLubYHHhj0SePmG5D3lM9AeyVcUo1NqC6IsllchyT4dwuEC3QT2PHGapu2
         O3nXQqSoxAZYFjjUHuh33N5cTR3a/LUOhULJaZOHj4JBX/Vi3PGzcRO3OyL/SFO8dluI
         6OfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708469045; x=1709073845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDvZdKqqAEQWTERmxxTyBVJONY656Jlnfr4NEFK+UlQ=;
        b=C+U9L2K7piYBXmLj+j9IB8vUsFQnjzcQmGrh2TNU7/72/S38KnKer4WNipiLKXvuyo
         yiVgKXUzEmvNwHqk/nw9Su9++neNt57gh+z0InfQimgQsg43lyIK2DndgQqVVLDh08HY
         G5G787fNneXewqbWKvBFraYKeHf5AslD74fahhYjTi6azfC7+dRDY+2acDg9slq0oP00
         s724khfDmLnTzQS5HNlltmqrqFYialD9n28zO0TyPRABhr7/JL3DLDZOeq+l/ODA1vsz
         lUS13Zoynuu0TsqHVx4DXM0bQ/GhfatP83Pj432bJ+IZX8Cgo1so0osfyNetEka2fQU7
         3OgA==
X-Forwarded-Encrypted: i=1; AJvYcCUcAQ5TZrqoooEeZ60cS4kiiVFSWjgqBwmb8+knEbtlF8a3LCBlofM0ue5fzlVdjFH7XDiuMeIrLvh3Bq3sBp//C/mUb/D/eo7SVmz+99x2YF7OCDjsTR34pX3yTF1QHMWj6qbj6ym1
X-Gm-Message-State: AOJu0YwypPATjaNeAtTlp++u5LqfgprRpRt34+2WHIUhcDOWWK2s7aDT
	743Uc2xpmzlJDNPcVNcbus9X6CraaO7YUNxWNF60+CxPT4qbrsAs
X-Google-Smtp-Source: AGHT+IGTA9rs4XK3xLUoJnEUnhuvWSDMuSCJP8DRqX0O1OxxoD6AwNDr9F6IrJiFCRqqiPUwi97j8A==
X-Received: by 2002:a17:906:6408:b0:a3d:19e4:113f with SMTP id d8-20020a170906640800b00a3d19e4113fmr11608828ejm.76.1708469045105;
        Tue, 20 Feb 2024 14:44:05 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4de1:dcc0:a48:7f])
        by smtp.gmail.com with ESMTPSA id xg11-20020a170907320b00b00a3d83cff358sm4328489ejb.70.2024.02.20.14.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:44:04 -0800 (PST)
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
Subject: [PATCH 2/2] drivers: iio: pressure: Fixes BMP38x and BMP390 SPI support
Date: Tue, 20 Feb 2024 23:43:29 +0100
Message-Id: <20240220224329.53729-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240220224329.53729-1-vassilisamir@gmail.com>
References: <20240220224329.53729-1-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-spi.c | 50 ++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index fd7ec6a5bca3..7ea79fe57cfd 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -4,6 +4,7 @@
  *
  * Inspired by the older BMP085 driver drivers/misc/bmp085-spi.c
  */
+#include <linux/bits.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
@@ -36,6 +37,34 @@ static int bmp280_regmap_spi_read(void *context, const void *reg,
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
+
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
@@ -43,10 +72,19 @@ static struct regmap_bus bmp280_regmap_bus = {
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
 
@@ -59,8 +97,18 @@ static int bmp280_spi_probe(struct spi_device *spi)
 
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


