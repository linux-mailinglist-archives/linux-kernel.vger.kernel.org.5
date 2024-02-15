Return-Path: <linux-kernel+bounces-67321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 612DC8569D1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85EE41C23C76
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E995B136641;
	Thu, 15 Feb 2024 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLiVbRHY"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F18939FFA;
	Thu, 15 Feb 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015472; cv=none; b=lPpzXWqSGHzejYzhEHaXZRjqrfL3kFAOGRWAHLMLhw6TgQ6bIC2OTHeL6KU8gGpIA5xwXfEHt+qIFF9EKMYjseUvDwUVIfytsRj266E1b/629ANCVZ0LhIYInOyVt7pkHNz1aG+6C0aL66dfeSpy62455M1mx7fJcJ/ppsbq8Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015472; c=relaxed/simple;
	bh=GMzJUKfh0pZFT9mnw2FojixEMfapW3e0QRXrJatKCRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gn4sPmXZ+VJPQzvTPIZ+UiNzSQITKQljxa+UjBXjewdyJ3gL1/FtqfPSJF0LWmJqzcd+1e9oQKSlxpn2srA7SRBr5la8d4ghEBcluCs7LxnTSMBTazZKNrkLe+VYWHeZWhR6lnrN4RfT+8PewLbs/E/MfG1i7kGN24N0JIbHcE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLiVbRHY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso202377066b.0;
        Thu, 15 Feb 2024 08:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708015469; x=1708620269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1TLzx8puHnp9fRr2h2Fsmx/iYsbbA0ajrwZKXLailLc=;
        b=FLiVbRHY7kTTZRdIOZo/LOYcPZt1+kmUmQSYHev6uut8hZGyhizP6xz5WSSYerZLYK
         30H1FbJBqj4PvFsiDud9DFGq81yJhP8mNgI51aj0OW07XVYtRugoQYdL4hshoDNCIAKj
         uwBvUhR+yn8yLTtaOhYnaiTqsbk7UXvHt50M+ieR64pZRCm+uMcNQxw1PRBkxttixdgE
         87/S5cSme5s1MG80hZBWxRceZ9hQyGt8foZi1/1LZsQA/4SUeOEX772Nkg+0jUYCZdCD
         x3ROLyroXWm8p5KhuyzlWcRzQ2/gadzpO3TkLgEnatN3pqGyNWjfejWNnS2FQzP78zO3
         nQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708015469; x=1708620269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1TLzx8puHnp9fRr2h2Fsmx/iYsbbA0ajrwZKXLailLc=;
        b=JrxpyJNg7JwqrNsdHp3HceSy9e6w5vP0miVePNYh+uXCN5vSm8XVYFT4s9re9KnC9E
         F5RNCHboLq7k9fimmphkdlYOyJllwS6JrP1lm9CykccQYlike0AjRw3ryyakOLotzZS/
         qGPsfek5qtajyR/j7QqyQIyHLzra6UKLHdqg/1DFLxiGl5mfEcKtyOLoQM7XJ01OBIhb
         toDYd+JigI6YXqN9PxxAqhHxKptM7IQo0CayOxPMoc3Di5CypiBgoJ1Z01UBQVosJSGn
         6+D3coOKPE6rcvW6xeNnffmoH2IprOm2RtHcz01y9sjCuJB8fUm+u8uP/t2R//60E3r/
         D1KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLONArceth8VuW+8g8uUkAlZVorCTKmWgE2ET4TmVdHfxRmTLSz0F50b/rsB+wAyUyxngkbvnLn3nbKdmDoinkQNb2iqmNGo2OqNwhuLDETSw4X/UPKcupiW3Eh2pz6ISrPNcR+rJR
X-Gm-Message-State: AOJu0YxpEVbFfCzutudiMzqdyGag61hPgSX/5dNdRc7m7oPvhvhOWUbN
	gFzR21Xiae23pzsr78iYO+6p5WofQVb5mV3O7NPh663/HB1ZElUc50ieYqOLM/+LtTjQ
X-Google-Smtp-Source: AGHT+IGz+IX9TEQgvwux0eQfbbc+i9DG+dMuXoYp3tDjmXhJD5YvXRJlDRJqsin3YbegQ6ho7qzplQ==
X-Received: by 2002:a17:906:c284:b0:a3d:1f59:743d with SMTP id r4-20020a170906c28400b00a3d1f59743dmr4803646ejz.8.1708015468487;
        Thu, 15 Feb 2024 08:44:28 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:82:7577:bec0:4907:5147:9931])
        by smtp.gmail.com with ESMTPSA id s26-20020a170906a19a00b00a3d636e412bsm727645ejy.123.2024.02.15.08.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 08:44:27 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	ang.iglesiasg@gmail.com,
	andriy.shevchenko@linux.intel.com,
	579lpy@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH] drivers: iio: pressure: Add SPI support for BMP38x and BMP390
Date: Thu, 15 Feb 2024 17:43:32 +0100
Message-Id: <20240215164332.506736-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the datasheet of BMP38x and BMP390 devices, in SPI
operation, the first byte that returns after a read operation is
garbage and it needs to be dropped and return the rest of the
bytes.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-spi.c | 47 ++++++++++++++++++++++++++++++-
 drivers/iio/pressure/bmp280.h     |  2 ++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 433d6fac83c4..c4b4a5d67f94 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -35,6 +35,32 @@ static int bmp280_regmap_spi_read(void *context, const void *reg,
 	return spi_write_then_read(spi, reg, reg_size, val, val_size);
 }
 
+static int bmp380_regmap_spi_read(void *context, const void *reg,
+				  size_t reg_size, void *val, size_t val_size)
+{
+	struct spi_device *spi = to_spi_device(context);
+	u8 ret[BMP380_SPI_MAX_REG_COUNT_READ + 1];
+	ssize_t status;
+	u8 buf;
+
+	memcpy(&buf, reg, reg_size);
+	buf |= 0x80;
+
+	/*
+	 * According to the BMP380, BMP388, BMP390 datasheets, for a basic
+	 * read operation, after the write is done, 2 bytes are received and
+	 * the first one has to be dropped. The 2nd one is the requested
+	 * value.
+	 */
+	status = spi_write_then_read(spi, &buf, 1, ret, val_size + 1);
+	if (status)
+		return status;
+
+	memcpy(val, ret + 1, val_size);
+
+	return 0;
+}
+
 static struct regmap_bus bmp280_regmap_bus = {
 	.write = bmp280_regmap_spi_write,
 	.read = bmp280_regmap_spi_read,
@@ -42,10 +68,18 @@ static struct regmap_bus bmp280_regmap_bus = {
 	.val_format_endian_default = REGMAP_ENDIAN_BIG,
 };
 
+static struct regmap_bus bmp380_regmap_bus = {
+	.write = bmp280_regmap_spi_write,
+	.read = bmp380_regmap_spi_read,
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
 
@@ -58,8 +92,19 @@ static int bmp280_spi_probe(struct spi_device *spi)
 
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
+
 	regmap = devm_regmap_init(&spi->dev,
-				  &bmp280_regmap_bus,
+				  bmp_regmap_bus,
 				  &spi->dev,
 				  chip_info->regmap_config);
 	if (IS_ERR(regmap)) {
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 4012387d7956..ca482b7e4295 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -191,6 +191,8 @@
 #define BMP380_TEMP_SKIPPED		0x800000
 #define BMP380_PRESS_SKIPPED		0x800000
 
+#define BMP380_SPI_MAX_REG_COUNT_READ   3
+
 /* BMP280 specific registers */
 #define BMP280_REG_HUMIDITY_LSB		0xFE
 #define BMP280_REG_HUMIDITY_MSB		0xFD
-- 
2.25.1


