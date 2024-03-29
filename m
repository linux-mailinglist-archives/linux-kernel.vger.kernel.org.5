Return-Path: <linux-kernel+bounces-123922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA530890FCF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53478B248B2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C934C374C3;
	Fri, 29 Mar 2024 00:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpE4F/GI"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629312E3E4;
	Fri, 29 Mar 2024 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711672850; cv=none; b=oZTUZAXGKHQkKAwmFnruFj4YerZjJdYSvHbiTmWXx7sk/ReM3TwaRecJ1br7HVijNNFcdJtOK2f0iqAfEly4l40xPycEl1o6k9c6YAXR8O/WxOuQx/g3h6WBhr1mI/HnC+D7bmm8qiKj0sujbXQSWREthVwdfkOEmjwyfRsQJZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711672850; c=relaxed/simple;
	bh=NSe/liSARxHCFd61SUaS5BJlcIU6UF1iYHqxn3SBHPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KJhQwF+ZfQLawU7Ut/t4c4J/cNSwY7yP9YOJwuoBNT5FbGvcUQXEzi0Lx27a0kt7rZ8KCxSFTGakEedY1xCqSeSyGNrbfNRkF33UmrzKV/9KwiBdXDRbxIZ9aZUVeGDMDM6BHrc16cgT2WNZeOqK4ushR67fQZLzuhNWI2jPeTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpE4F/GI; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51588f70d2dso1751713e87.3;
        Thu, 28 Mar 2024 17:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711672846; x=1712277646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWDCltR+Y0wCwsz+KfQOWGNlirk4O0tCkzhshtRNMtE=;
        b=GpE4F/GIVKVKT2AA1MhkrM27AhPnd9KPX1nb/C/GgBjsc84J+E9lbwmBNQ1MJGg8Y2
         xQV7Ld+hOl0WhP5ozbG/MHmb9cZWKS3t/X7sNFzHZP4gP1s76dDxnnkA7v9DlHfRbzA1
         +Z9woe4IkfXxJ3btnz3uYd/bwp6Exxi5Re8B7NnyZnWndr8EVYFTdQTgyrIHDLjRr2IU
         7/JqeIlKjkS/Hf45LTm+YtgU2E9leLDjX8C0BsKZw5SviICyk7WYRaDBQ/CoyygLu2R9
         4G2jKsL8G2e8q7F0iisZO4VhKWiHStp4xRc+OT2ehQ3cm1g9eg/o4Wtc8bNASgzzYBDp
         p3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711672846; x=1712277646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWDCltR+Y0wCwsz+KfQOWGNlirk4O0tCkzhshtRNMtE=;
        b=JEkjHBYXyTuvzmCewOzljMtkvvUtzd08JkpxYha8cVQcjP5MK5Tq6D8aBgb28ttBXD
         OJA6QlS2BWlSaralPw5gpFcQkynEwr+OzcdAXD11/rC2Sip6ue/zWGYo0kPsT9qecPkA
         Bc9jm5TpLAPBeEXs0V2r1wVW4mwMEAeI1md7ceBBXr6T+ctTQVnQTbvi2/PqoRn3Xd12
         m8yBaZY1yCLtsGTg9PY3sTxoG9UpGLrfV9mNGlRK9+6uChodBf2Zb4lAjuHuFVnmZt8l
         puXHFPGQzRmG8ryKnV+efyinaGDLNJOKTAZUK9faHDmJRns1j1gnw27Rw3OTixEMWvhz
         IoVw==
X-Forwarded-Encrypted: i=1; AJvYcCVBMCE0mldLmmj4AbMz3HkEgtPg3vep/CW2IBndYA35zJWaKnneq5DhW3wAlpHc3NkFt83lU9X5x6FhoUHAXimwaYMctKlH+yxQDgHj/swSuLBpg2IZ+rJ2SkFq97XIXoqgPtkO7W5KyQ==
X-Gm-Message-State: AOJu0YzErxVccGDOMPMVEKlyjHc2nDFQHUO+uQUcy5kGy6f0+SvBdQpU
	iAwuPIpTOV4WlSiY+0+08sGcusVz0L7uD9+ZA6ztYsodtAmWjhai
X-Google-Smtp-Source: AGHT+IFfU522CAsPYJZupOVr0I9Lv9VQDy4tTJgSmd5P8rmRqKVKhe+9Ur+tEMAOoHAMG58D8qPMng==
X-Received: by 2002:a05:6512:3e4:b0:515:ccd8:37c2 with SMTP id n4-20020a05651203e400b00515ccd837c2mr542083lfq.44.1711672846487;
        Thu, 28 Mar 2024 17:40:46 -0700 (PDT)
Received: from 13a4f82a8f12.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id h7-20020a0564020e0700b00568e3d3337bsm1391679edh.18.2024.03.28.17.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 17:40:46 -0700 (PDT)
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
Subject: [PATCH v6 7/7] iio: accel: adxl345: Add spi-3wire option
Date: Fri, 29 Mar 2024 00:40:30 +0000
Message-Id: <20240329004030.16153-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240329004030.16153-1-l.rubusch@gmail.com>
References: <20240329004030.16153-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a setup function implementation to the spi module to enable spi-3wire
when specified in the device-tree.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h     |  1 +
 drivers/iio/accel/adxl345_spi.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index e859c01d4..3d5c8719d 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -31,6 +31,7 @@
 #define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)	/* Set the g range */
 #define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)	/* Left-justified (MSB) mode */
 #define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)	/* Up to 13-bits resolution */
+#define ADXL345_DATA_FORMAT_SPI_3WIRE	BIT(6)	/* 3-wire SPI mode */
 #define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)	/* Enable a self test */
 
 #define ADXL345_DATA_FORMAT_2G		0
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index 1c0513bd3..f145d5c1d 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -20,6 +20,16 @@ static const struct regmap_config adxl345_spi_regmap_config = {
 	.read_flag_mask = BIT(7) | BIT(6),
 };
 
+static int adxl345_spi_setup(struct device *dev, struct regmap *regmap)
+{
+	struct spi_device *spi = container_of(dev, struct spi_device, dev);
+
+	if (spi->mode & SPI_3WIRE)
+		return regmap_write(regmap, ADXL345_REG_DATA_FORMAT,
+				    ADXL345_DATA_FORMAT_SPI_3WIRE);
+	return 0;
+}
+
 static int adxl345_spi_probe(struct spi_device *spi)
 {
 	struct regmap *regmap;
@@ -33,7 +43,7 @@ static int adxl345_spi_probe(struct spi_device *spi)
 	if (IS_ERR(regmap))
 		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
-	return adxl345_core_probe(&spi->dev, regmap, NULL);
+	return adxl345_core_probe(&spi->dev, regmap, adxl345_spi_setup);
 }
 
 static const struct adxl345_chip_info adxl345_spi_info = {
-- 
2.25.1


