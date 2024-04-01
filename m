Return-Path: <linux-kernel+bounces-127014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D991E8945C2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C301C21498
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88885822A;
	Mon,  1 Apr 2024 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5DjHbkY"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBE657864;
	Mon,  1 Apr 2024 19:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000968; cv=none; b=kNlQq5Yqv0l2NahFJJR70hTLESLQ/AttoT5wtcr3sHXwQO0fVkj1z4NdecctJuoFsgRWk2vJWRY7U9w/cRz8QNrk7ztpkkGh71zadGSM0uQR3s5H0kodOgM5uCfXCI1gpD7qCz9WhV3yocSMBApFvy5GUdx4f3a3MNhZpqf00FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000968; c=relaxed/simple;
	bh=wcU0/V8BT70h2ej/n3TH2PuQobK7ecf6aEFqsZf2Zzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eM1ZZtdgaBL/r95nIscY18Z9SlNgC/YBCHYvK2/E6wDGz8r6DDGoE1rgSg+J0rWNL0GuTE/o8FdSKAuBxqiSbJOOFo6xZbZMaT7P4PgT6smwGfm+KYp0O4sM8L2GHGPEg55udacveNDcEyEKm8dcjJ4FnE+w45iijVjV+zslT74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5DjHbkY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so5034978a12.0;
        Mon, 01 Apr 2024 12:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712000965; x=1712605765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5oZUE6Cc0M0M67CoAZ2nF2cwdSxIisLsw0v4EDbGXc=;
        b=b5DjHbkYbK/InIeSAmhqeBY4evqP5nrEcbL/bs5jBKgGLX5+wj5aeQVIzrubqbzbf7
         nG05OCimk/fZ+2PG3L/4zAmTx9psptcIk4I2w/t73yZ5a3COccYQflkdnQxZVtt/JeEx
         hLq322A3Lrs7UtehDF4XLXHtugI7z/wltjE5LDrW3JBRMj+xGR7N78+17vBtBPR3JmEh
         2WLCceacUk8HQfy5Nh3JnOkGT3PmnHtweQEMqjHFPn68hUIDYS3kYBuM9w6ehyarEB06
         wsaXz0qJKhowqgeIaYptLEqLccTNrz8qg0dBRUbxDyj59JqwXb6+wAAH3+Pg7ITA4Y7Z
         Tdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000965; x=1712605765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5oZUE6Cc0M0M67CoAZ2nF2cwdSxIisLsw0v4EDbGXc=;
        b=RWVtmGF8fRhcssgC15V4FIR1TMCMwT/G1l2hM9ugWW1MmNxe7TO8H7+nRT1pjX0/Lq
         D7F1L0HJRSBkoWOmLFGxTIpeVF19NcOuUnI/xVSE35U1HmrZv7bpqtccq22bxaDlbjrq
         x5gFo44Mh1lUevZbFQ3ChNIDAttDnsqAqccv4/+l9IgDZZszvFxoxJdPFXrbRSxLE3a3
         yTDkVmVwZ3iVYsqnW4xXbeeliJ/P2Cpnj6wSUS2r4vm0jVihlRc/QBisahmPA4Fbxm1t
         IBj+wMdeAbzuzPYr4SgY/H7GCrpzB3BmW7PoCQeUgVA1FcEMcFyen53KZDCJThzhCwSv
         G3Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXhcp6yNsqH2/1EIc7X9Cbhj8GtC1LDvEKkiEsXDpOaGFu+tWJfVGNBthsuiqq6/RvoWGxyJqOt46W7otpNIiQFObekzQlt8m/rvhibHxSYnArLqGKdZd53w++t5NdEuF7BEa/45Y5ngw==
X-Gm-Message-State: AOJu0YxFKvKvbgGkQ/lt5UVUwkrnzUH4xwtB3s1hM0bkB/yKkFjg/v5R
	oQyhud5oe5rNNbgdZWQzm/X8Y0iQBhdU+3+UZAyTsSLlO2muc5P8KQmH6Zhr7Oo=
X-Google-Smtp-Source: AGHT+IFiLwGMMSIpuLh74HW6YtSEVtTpF8V1YJJE4d2OT/UWi6LY0YPWzCHT9au1LSErw9Fjgjqd/A==
X-Received: by 2002:a17:906:f58a:b0:a4e:3c1a:d6c with SMTP id cm10-20020a170906f58a00b00a4e3c1a0d6cmr9087899ejd.9.1712000965145;
        Mon, 01 Apr 2024 12:49:25 -0700 (PDT)
Received: from 13a4f82a8f12.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id dn21-20020a17090794d500b00a4588098c5esm5540575ejc.132.2024.04.01.12.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 12:49:24 -0700 (PDT)
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
Subject: [PATCH v7 8/8] iio: accel: adxl345: Add spi-3wire option
Date: Mon,  1 Apr 2024 19:49:06 +0000
Message-Id: <20240401194906.56810-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240401194906.56810-1-l.rubusch@gmail.com>
References: <20240401194906.56810-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a setup function implementation to the spi module to enable spi-3wire
when specified in the device-tree. If spi-3wire is not specified in the
device-tree, NULL is returned as bus pre-initialization. This behavior
is identical to the i2c initialization, hence the default initialization.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h     |  1 +
 drivers/iio/accel/adxl345_spi.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

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
index 1c0513bd3..57e16b441 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -20,6 +20,11 @@ static const struct regmap_config adxl345_spi_regmap_config = {
 	.read_flag_mask = BIT(7) | BIT(6),
 };
 
+static int adxl345_spi_setup(struct device *dev, struct regmap *regmap)
+{
+	return regmap_write(regmap, ADXL345_REG_DATA_FORMAT, ADXL345_DATA_FORMAT_SPI_3WIRE);
+}
+
 static int adxl345_spi_probe(struct spi_device *spi)
 {
 	struct regmap *regmap;
@@ -33,7 +38,10 @@ static int adxl345_spi_probe(struct spi_device *spi)
 	if (IS_ERR(regmap))
 		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
-	return adxl345_core_probe(&spi->dev, regmap, NULL);
+	if (spi->mode & SPI_3WIRE)
+		return adxl345_core_probe(&spi->dev, regmap, adxl345_spi_setup);
+	else
+		return adxl345_core_probe(&spi->dev, regmap, NULL);
 }
 
 static const struct adxl345_chip_info adxl345_spi_info = {
-- 
2.25.1


