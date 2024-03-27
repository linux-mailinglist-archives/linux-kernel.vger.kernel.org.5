Return-Path: <linux-kernel+bounces-122078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDC688F196
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E545B24083
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1289E15539F;
	Wed, 27 Mar 2024 22:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRyZ2gRP"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787C51552EB;
	Wed, 27 Mar 2024 22:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711577020; cv=none; b=CjlmS8hpIWaEu4PHPI+qbbFvGx+wy0SsHIW3a+BLbaOr1rtgdtrRMfLbKkXReCFm/1CqXLfZ0RMxk1fLElbb0z9NXY3IOUPvhXuoAF3iUlKE+YQvpRbWbQ23LI+DgPUHYM6ygA6CGGHG08QscoY2JVTOHryHX1qEa9J3pJ1HTZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711577020; c=relaxed/simple;
	bh=M6AuuuSxjeMQyVLwZxWmhaaq1eq0ZZCoM/yjkhatSRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dkqxveqDklJE8vvUzDJC2PO/EcDbiLen6vIjyPDxCf2cmWD5Y5xwtnGXtHtQA7A0AU5Iyv/9OJYgoiQC0FX5Nh3/HS1nbwHNO8TARYE0QDNkLTLKDTJ+5FD2HN2y8IerQmNxB7nwID1zg3EYUKoHEfNgZTwjSadlf2xz8DIBBdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRyZ2gRP; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513da1c1f26so273538e87.3;
        Wed, 27 Mar 2024 15:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711577016; x=1712181816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZUndJ3DD47y3ywaAfiwyQ7ryKmAeKm2Vgw1guGNzKQ=;
        b=YRyZ2gRPoinKDUCjmMawKZ6VSIkGO4b1zMavBaUtQtNC/g5bUyi59QNxiJJgAvnCK/
         qq4/t0GLh9vaSBT9YA8OimdDBVB/GmnxRSvbrHrqWxhRiDFFGUFY14GKF6J5bDY00LWN
         7LCN+LUf3UsGmDNGUr/eb9dOpttSrndJzdSqmAjgL8Uh/2bxX6GbGRCViD4i6QuD31JU
         olYT4ZM05j/Q2zCBrqokE8E03q0pXbOrn8BQ0YUgRdF1hTWDf66HjYwsLSzM8ZcfF4+Y
         /b8EMphnL/0mUgmAhdiruRJwx0YDrh6cklP81hJ3yS4zwed28+I684CODAG2xpHPVD+r
         iyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711577016; x=1712181816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZUndJ3DD47y3ywaAfiwyQ7ryKmAeKm2Vgw1guGNzKQ=;
        b=CSmQu/ltjoPUpfy6yMOnVshBYJGwEMrP14FAqFLH+HY18Uv8dynPpp8FwaDXedRzxq
         ind76Jz7KGJEK8/OzJXtGbnoncSK8Y8WmBzwkFCRswEq/NQg2llspcMH/Qe4/ZBqlrVN
         QuHHdKOcoQ+lRyzDlXA1dlztZOkEdTebGNfmO29wQOY2/nOT2DhYWlgEjBRIQyaAZssR
         mWH2Ivxl76leGkKu+KpiHEMyq9jajIjEzgG9AIfB9i1Z+RX6a2hZ/PxdW2d9kSxCY4vb
         VSt5UlbAxyQxm3vc3xlYFl+kdyCIZvWmA+faNUpRQT3xuG9Iz9pO7oVsn2jtNYyxt8wi
         kG4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVCjpRh69Zm5LnwqoZqioSEjUs+HSJ+v6NSv5X3PtRozF+nOBaf7PMem4KYinb6qcGBjJNlWjGu2A+Vm/r3n0kpjfQ0KF9q1QqdB6hLxueZkr3HKBeZPxnLcl8OPAYkEKjU/I1nYFnsA==
X-Gm-Message-State: AOJu0YyleuCbVMQhSLwsiNsSlIcM6m32aaEITi/qrtYyHeK8Nj1GS7RO
	t/syOyDyP4IA3K0hF6V9r43zw5IDoPhTYv9YHb2KRV5TqtXnoBv+
X-Google-Smtp-Source: AGHT+IH28rgpRyR91X0Tct3qGtcWzyLxHNUYT+ZeaaaAVeqgBmaoWIsnlixLlp7pthnLeGPhuNp0UA==
X-Received: by 2002:a19:5e58:0:b0:513:a88b:3296 with SMTP id z24-20020a195e58000000b00513a88b3296mr474509lfi.9.1711577016344;
        Wed, 27 Mar 2024 15:03:36 -0700 (PDT)
Received: from 51a0132e405f.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id f25-20020a056402161900b0056bc0c44f02sm59151edv.96.2024.03.27.15.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 15:03:35 -0700 (PDT)
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
Subject: [PATCH v5 7/7] iio: accel: adxl345: Add spi-3wire option
Date: Wed, 27 Mar 2024 22:03:20 +0000
Message-Id: <20240327220320.15509-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240327220320.15509-1-l.rubusch@gmail.com>
References: <20240327220320.15509-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a setup function implementation to the spi module to enable spi-3wire
as option when specified in the device-tree.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h     |  2 ++
 drivers/iio/accel/adxl345_spi.c | 12 +++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 4ea9341d4..e6bc3591c 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -30,6 +30,8 @@
 #define ADXL345_POWER_CTL_MEASURE	BIT(3)
 #define ADXL345_POWER_CTL_STANDBY	0x00
 
+#define ADXL345_DATA_FORMAT_SPI_3WIRE	BIT(6) /* 3-wire SPI mode */
+
 #define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0) /* Set the g range */
 #define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2) /* Left-justified (MSB) mode */
 #define ADXL345_DATA_FORMAT_FULL_RES	BIT(3) /* Up to 13-bits resolution */
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


