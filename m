Return-Path: <linux-kernel+bounces-57767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A74184DD2E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0432F1F26AA2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65046BFC2;
	Thu,  8 Feb 2024 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1VVWaRQ"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A956BB2F;
	Thu,  8 Feb 2024 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707385440; cv=none; b=T1WSsmLGM8Tz/NNh5zq8JS2N5lU5trJA3GainDHuh3Ts6pWcSNyH0/NEXetqxsyDO7PTm1RTdojvrMt1Ed+zFd17ZFlLeZ/0FM0TR3sH7ApmHQ/UT88ATP/zKutDeWo7jkF+vdosskvRJRfzdPnVBlK6Vx93fd+180F3JrDjOLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707385440; c=relaxed/simple;
	bh=4tBQV8gIEupd+sa2dqqJq1oLCjTr6Cb01Cl4c1CjyP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r6OmEf1t2SUdTW74iUGJ8Ezp023+HaTXVPzJZHjgeSCakLckA9ETt52JOyWjYsCIFKX4ES+eegnvcP/CbMbuOh9ZfBWE8/RSjWVVIbXjfZ/R78HvGFgkK7iDZeGK4Jc+ihX8KqQ0PYwMwyWWaoA1yYYf9zXVso5wvGl5rs+a26o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1VVWaRQ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so1914055a12.2;
        Thu, 08 Feb 2024 01:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707385436; x=1707990236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X7p3K02PhD++htjnyCnKJ+dGMFyKbZmZX7f+kzBf0cY=;
        b=b1VVWaRQ6jWv3rC5gs1fcsAqAuYhioNHnyhMjEtieVEK1NljC8MpkSNAwlDMseO5EQ
         qszNe2AyP5SeWYqdDHaAS31moaAJhTCDdBqeCHVjqvnW94QRiim+icTfAX0VE5niWH1/
         KTLQ6/zx0oTqWhA0PtYzq7ByItgKqDYuoMJrj/6VkmrC5GYVVu1N3J9wiCTCk4hyk6Qk
         x0GF3zCYH115PpG/W6T4j4gYo+sisrMCHS/SmnItD0tn9Y6QkwBcA9R2kdeWN49J0+Wz
         HxTBOooAJ5fQnKdoOY0d/qYmnzgPMzTAFXJOIc0WjzvyiRmeIRGUdpdVqEAqCCSiEBV2
         bApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707385436; x=1707990236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7p3K02PhD++htjnyCnKJ+dGMFyKbZmZX7f+kzBf0cY=;
        b=eOfJX/rhg4jh32E9pCV4IBpiYpWWCcripE7MeF30EluzxwMM2M1/KDg0oRQCWwJ7yq
         MVb9xphZxmMcLN8uUsphDZZH/Uuo7eFX0FE1eg3syaKp1tpWf88aAvMQZsw2kDX5hHl/
         bJSxy1+CvliDy47dkGa22dqShTj/uuARO+Ea5qZjbirOCWemymX8JS9DWp1qksX2I2SK
         2VqkkCZ080COohSlSWSvmX1AUDrmaM5/Q1bcNZRRT06f2/04DphuLnazuieEPZwIp3RV
         jtZIIOOav3REQIU7EVafbIq6fy3UF/5XaaI7ORqv+XpIr/EJ1zsm/SH+RpVxZhitMX5i
         vtxg==
X-Gm-Message-State: AOJu0Yz0JfU9db+3IigZ7l9FjZj0hBPhNpQiVMycaRIHS9O1sH+O9wQC
	NzLDmBI78QFc9BO2XPiIS9HsWpHMBPzBB5cxa+w0Q7QlTm9AmZQ9
X-Google-Smtp-Source: AGHT+IFeHhhLNi2XeEumL9GDfE4RisQS+7reTda1BObqjiO4TLk3jTgKVSzd8zhevxE2kWJweaXyJQ==
X-Received: by 2002:a17:906:c456:b0:a38:a6a1:3d7f with SMTP id ck22-20020a170906c45600b00a38a6a13d7fmr1796806ejb.4.1707385436404;
        Thu, 08 Feb 2024 01:43:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMoZI4ou2aBBrPumIZDMSRTKAFeKwfzIrh7D56ujwnwLWECa4iZOeT0bATYWr6fPPAcus0BELZ1fjuT8YlRSs/8ysR7CphdSk6Nq5utClc9c8ASG9IjHFuYXtzJWIt4J0O8qLf31IW2Dk4qTQqFlJlMnBWd1JBlFmGjyCPJO68NxMYwznfmCi6lK3nRxkCATprpqKbIok6y5MzgsnQujUTyuvf
Received: from localhost.localdomain (IN-84-15-188-071.bitemobile.lt. [84.15.188.71])
        by smtp.gmail.com with ESMTPSA id tj7-20020a170907c24700b00a38a2fa2d4bsm937211ejc.45.2024.02.08.01.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:43:55 -0800 (PST)
From: Arturas Moskvinas <arturas.moskvinas@gmail.com>
To: Jonathan.Cameron@huawei.com,
	oskar.andero@gmail.com,
	lars@metafoo.de,
	lukas@wunner.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arturas Moskvinas <arturas.moskvinas@gmail.com>
Subject: [PATCH] iio: adc: mcp320x: Simplify device removal logic
Date: Thu,  8 Feb 2024 11:43:39 +0200
Message-ID: <20240208094339.82633-1-arturas.moskvinas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_* APIs to enable regulator and to register in IIO infrastructure.

Signed-off-by: Arturas Moskvinas <arturas.moskvinas@gmail.com>
---
 drivers/iio/adc/mcp320x.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index f3b81798b3c9..4685eed35271 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -388,7 +388,6 @@ static int mcp320x_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mcp320x_info;
-	spi_set_drvdata(spi, indio_dev);
 
 	device_index = spi_get_device_id(spi)->driver_data;
 	chip_info = &mcp320x_chip_infos[device_index];
@@ -441,31 +440,17 @@ static int mcp320x_probe(struct spi_device *spi)
 	if (IS_ERR(adc->reg))
 		return PTR_ERR(adc->reg);
 
-	ret = regulator_enable(adc->reg);
+	ret = devm_regulator_get_enable(&spi->dev, "vref");
 	if (ret < 0)
 		return ret;
 
 	mutex_init(&adc->lock);
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0)
-		goto reg_disable;
-
-	return 0;
-
-reg_disable:
-	regulator_disable(adc->reg);
-
-	return ret;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static void mcp320x_remove(struct spi_device *spi)
 {
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct mcp320x *adc = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	regulator_disable(adc->reg);
 }
 
 static const struct of_device_id mcp320x_dt_ids[] = {

base-commit: 047371968ffc470769f541d6933e262dc7085456
-- 
2.43.0


