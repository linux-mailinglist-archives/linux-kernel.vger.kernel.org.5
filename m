Return-Path: <linux-kernel+bounces-117380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA6F88AAAD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380371C3CF2C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAD912DDA4;
	Mon, 25 Mar 2024 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWJDz+yz"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB00A82D74;
	Mon, 25 Mar 2024 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380897; cv=none; b=YCkgz6AKHps+1i76WZglMLpyZGqGpM0WXIVo53s2qO4imgq/NKN1m9dxcYWuSKQxsEGeZu9ZtK10C7/sRdQZvr62UUQA8yC95MRLlx1codyon6d7JjmRoElqpBg+CVxI+nk3fNQoeA27J99V0CM+BfHKE1KYbvVhO+BP8tofE+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380897; c=relaxed/simple;
	bh=VpmSCUo4LCSDAreg17AyaXZjU/kMgoCoxrBfLAVsbns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kk4i5vZXgCn18DNbj4E3Puoajum0c/GzWDlPgkdMgtR08CGG6975am7501rVgwOhwXN8NXi+uXA9W3c670SxIGfCzrWxbLLoYEHn0VmVIL4v4z70mMjB6/puF+AK1SxI3caPdgL/IxKMyxUvrwE3i16UtSOkThDEuTWl4aQXqH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWJDz+yz; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513dc9d6938so5617942e87.2;
        Mon, 25 Mar 2024 08:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711380894; x=1711985694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiSHINdO4QQ9dGEkUNG8gKxPDwA7BezRYNLVvF2c4GI=;
        b=FWJDz+yzomkrbc6FXZUNN8OTlDrCAwaVNBb9ATK7zlo3//HaVnlcy4f4DUKoW0tZS7
         m5fzTb9JpOGNmwZBaZG3sbvv4WiXnGz+njQrett79NQ8NoeInXPYCR/Fwziex1Wa/sJ7
         6Mu/jX7F30qdWexK8CtrpdLdhh8s+/qEx+t+oTQ5T4w2YLCi1gxnnvdp0m0tUhY9+LXn
         GEJ177dQZpAq8jfjSN+QG3Y298VaTQmHznd2bzrTQ+xUbCSDlYkg4yEYIb1c7pbitvk/
         NnTPA6Li01IgrJhVlFoZixjBKuPnO21qyxmIudegx7lpuP+9QIQbOPQN/Z6kg1Jbu/fp
         BN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711380894; x=1711985694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CiSHINdO4QQ9dGEkUNG8gKxPDwA7BezRYNLVvF2c4GI=;
        b=HanqLK1OhkTA4wl96vwuJhRRFCJ8WDp569eLZbiebjHVcWJWyh/4pf54d+pkv7w+RI
         iGmYUqXvDfBFeiupkazvIhKDKBkSlKD8XrFurz1zray68JmFfvqv1K/vz8UGpMLKYTVZ
         EUOxrt8giwuOfg/OJm0JX76SzBsW/w+euPgonU21agmwk7GRs9mz62/8kocx9DIcDrrM
         wCo7BcWTFP5A/Ks9zPeV3rE74unJrbuOsHP4LdUHUSD2Yu4sHTNSfWqbS9F79s2vavIU
         uuC4IaZjyeL3VdNs0PG0wOucbLACLKsMCRXjKoanFoDROS7/tfja7qeSBdhwdHFuO2i9
         b+2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWN83047bVa8EdEMJPROixvC7ubyd+C7SAdzNEcCsnanwOfS6KME9bhG20VVtCsuirPpq+VuP6DW5nv/I5Al5Tg5RzZZf5fme5/Gmmauw8A08ss/XD0SLCQwgM/TaBbcWpjVJzMOgsRyQ==
X-Gm-Message-State: AOJu0Yztj+e+t0/6qzbPwI0a/DZsu/Timc3Iah2yi6nuApMsd9UznJWs
	q3NmxTrVQpDyL+xFQwRCC+RDuEgZou8c3FiKdUkg+K8q2sJkrd4/
X-Google-Smtp-Source: AGHT+IEwy3EYA8kKvQPY3gjgvTL1CYxxrX54THrLiN66C1zBx3z6uDkuHjcp5TU9+9lJcfYG7H660w==
X-Received: by 2002:ac2:554c:0:b0:513:d339:8b1 with SMTP id l12-20020ac2554c000000b00513d33908b1mr4663596lfk.27.1711380893781;
        Mon, 25 Mar 2024 08:34:53 -0700 (PDT)
Received: from 764c7355c69b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090626cd00b00a45200fe2b5sm3142382ejc.224.2024.03.25.08.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 08:34:53 -0700 (PDT)
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
Subject: [PATCH v4 7/7] iio: accel: adxl345: Add spi-3wire option
Date: Mon, 25 Mar 2024 15:33:56 +0000
Message-Id: <20240325153356.46112-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240325153356.46112-1-l.rubusch@gmail.com>
References: <20240325153356.46112-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a setup function implementation to the spi module to enable
spi-3wire as option when specified in the device-tree.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h     |  1 +
 drivers/iio/accel/adxl345_spi.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 620a2e0f0..55a72ca38 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -36,6 +36,7 @@
 #define ADXL345_DATA_FORMAT_8G		2
 #define ADXL345_DATA_FORMAT_16G		3
 #define ADXL345_DATA_FORMAT_MSK		~((u8) BIT(6)) /* ignore spi-3wire */
+#define ADXL345_DATA_FORMAT_SPI_3WIRE	BIT(6)
 
 #define ADXL345_DEVID			0xE5
 
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


