Return-Path: <linux-kernel+bounces-105159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F4387D9D8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 12:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C55B281D07
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 11:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DB5182B5;
	Sat, 16 Mar 2024 11:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9lmXG8B"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A6317BB9;
	Sat, 16 Mar 2024 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710587279; cv=none; b=qPE2imVVqQ9++GahKCn2X6kxshdUgh+m1jHgbw2x9Z2KS8Ww8IqTOd8JQR9Qzee6J+CUAO2RpQHtWRWGl7V9WKFs6ILoIfYIqLgekTBkXckWmJ21/dIHV5x4Zu3vfXOqeGjXgvjPAA/FPevAn65phFuQxOr6rLjZA34E+9BL074=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710587279; c=relaxed/simple;
	bh=t7LYZX6EKUgQo+LXunj7XiFMrdyQ/qdtMmGXsGcqKCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XkUGZFH00/f8Vm/Qr7DYcLEi9Pj29CwPxDITgAL44MI0fcsJetiXTceqcOI5eVDy39wtiEHQuGWp8DbjfvchAlt0/+WMP5v571Q1rtOb7VOhKmK4rplznmSuN9x34vLytFxX1q4KnWRBTe0YQjjxoL4ahgwhtK7h7pumrB5IlqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9lmXG8B; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a466a27d30aso381391566b.1;
        Sat, 16 Mar 2024 04:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710587275; x=1711192075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzhojDgRoybSBlASTJXy9XhM8QalAu20Y2x6klhiLUo=;
        b=T9lmXG8B1Zj32ndoJ6zNLXiCtAgyVnSW6mAxtKPmam9U2rIF3knMj7L5KsRsCrFpny
         rG38ZV+iAu2u9C5KP6XcJM9Ngw/DpAK0pX/1L2t5flqntkqOreZLssyPh47arlqh+3Xr
         RRZeWlHsUkjWRpUmoShG7kFMmy0GXbQa8KBnIaKY90t3P5URyZyY3Ok65JwPZ0aNAvpt
         YljjbzvNpzwj4+apUN3KwjZ5tN1UiD8xojN7C/AxmdWs2n+/JqrZKf0FRID19aAyQXQr
         6ygqkRtFInoXt57dOslDok79yiF21YZj9VT3K4p7oi/Y4HxXsJAd6J9Q+cHoih5ErFG4
         sQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710587275; x=1711192075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzhojDgRoybSBlASTJXy9XhM8QalAu20Y2x6klhiLUo=;
        b=GNVTj3N3x2Ehka+ykEElv6MCwAXUZFiUznjD2GrU3R+XlHuFj83SvWASnOoQHPVn7E
         TgKvwodRn1EscaYmcEUVsrUYT5ZITgXk8Vugn96NWRvU6XP4Ou72hmwAXMaxjgHi8qHC
         CizmvNh4xUhA4Pltrp1bY02hcniakbTWYmgHeUSRBREZVBYfXJETQP3VI1hwwglTIGIO
         1NBO0jD4FxHYYISvs1c9iaxDIQKMI5MKkdnI7E5KQQnr98NRtQiP3h/J7LvkCswOgqCe
         nIVbY03BoYrNB/iyb1txsQ5T1Ai+/mPW/p2n+9vWEfrtErVTsNqaM21wp3Mk9q1Zhi1m
         kBMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGIDmxqbSW4ijjRgU5f3h+6IANj0V156O8WbXRa94NLFu2kOJ+RYDYK4z72eQNPUOh6as4TnWWcCSqWDEanTCFOF+yIAHKk9Skr2jVvbf4aoQv/PfXLlAozSavTGo0D7Zu6wsIGFk8
X-Gm-Message-State: AOJu0YwNieu2o/6XGEuPon9/ziZAj+DfVDxaIOkSMGFwnS+h+ZyzcAop
	5isx+T7kB85dSnZZ1F8WxgBE5K+aVqh02boadVXLPtW/EQksT2s/
X-Google-Smtp-Source: AGHT+IHeGO3sFQuS706QJQR8+Od/qOSAjzSdeW2DTbU/Uo23rwzDsghcX0Fk8hADRWrQkEsY2MqZuQ==
X-Received: by 2002:a17:906:d296:b0:a46:aba1:cd71 with SMTP id ay22-20020a170906d29600b00a46aba1cd71mr319625ejb.54.1710587275312;
        Sat, 16 Mar 2024 04:07:55 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:c0f3:8008:e41a:ce01])
        by smtp.gmail.com with ESMTPSA id bx21-20020a170906a1d500b00a4655976025sm2627223ejb.82.2024.03.16.04.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 04:07:54 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v2 2/2] iio: pressure: Fixes SPI support for BMP3xx devices
Date: Sat, 16 Mar 2024 12:07:43 +0100
Message-Id: <20240316110743.1998400-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240316110743.1998400-1-vassilisamir@gmail.com>
References: <20240316110743.1998400-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bosch does not use unique BMPxxx_CHIP_ID for the different versions
of the device which leads to misidentification of devices if their
ID is used. Use a new value in the chip_info structure instead of
the BMPxxx_CHIP_ID, in order to choose the correct regmap_bus to
be used.

Fixes: a9dd9ba32311 ("iio: pressure: Fixes BMP38x and BMP390 SPI support")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 1 +
 drivers/iio/pressure/bmp280-spi.c  | 9 ++-------
 drivers/iio/pressure/bmp280.h      | 1 +
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index fe8734468ed3..62e9e93d915d 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1233,6 +1233,7 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.chip_id = bmp380_chip_ids,
 	.num_chip_id = ARRAY_SIZE(bmp380_chip_ids),
 	.regmap_config = &bmp380_regmap_config,
+	.spi_read_extra_byte = true,
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
 	.num_channels = 2,
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 038d36aad3eb..4e19ea0b4d39 100644
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
index 4012387d7956..5812a344ed8e 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -423,6 +423,7 @@ struct bmp280_chip_info {
 	int num_chip_id;
 
 	const struct regmap_config *regmap_config;
+	bool spi_read_extra_byte;
 
 	const struct iio_chan_spec *channels;
 	int num_channels;
-- 
2.25.1


