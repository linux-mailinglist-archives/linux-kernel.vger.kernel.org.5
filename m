Return-Path: <linux-kernel+bounces-81527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1557E86771E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5CC4291856
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3487212A145;
	Mon, 26 Feb 2024 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsRnmU4w"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7F612883D;
	Mon, 26 Feb 2024 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955232; cv=none; b=YrtKuMYDCAQZt4O432Js41OCYjNulGvKNzXdjQQjJU5QdEf8r208VP973Dg++Xu74yYRAHWQ+GbHm19/Qfs9cIYSPEOal2qu7GwWOL6cHXD3stiWLqxnNNeZ88kSTeLKu8T8gqAb2qVOFCS0pXxSWdQQAYfhqW/2pzzxh2+3JR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955232; c=relaxed/simple;
	bh=emmNAZR0TiWv4VK6jP9M06m7OTVL5Q43QTl22ARJLOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZkJIbLwj6nnT+arUHamK81NACtAAIJPEOpKgqCzWXL6FsQpcxK2xAeYX88NOpZCeiL4hqW6OL9YhEMhsMADle+pForufH3FGjcHDy7ZeelKEYbpvmlYflVPAG0qIYwsjyic4fewYpSi1Iq9pNIA/kE6znnnA69wDcU31BH4X3MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsRnmU4w; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51197ca63f5so4659160e87.1;
        Mon, 26 Feb 2024 05:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708955229; x=1709560029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gSizykDxdC8x5yUdc/x3m/4mR390jcmCw+184ntuZ5s=;
        b=GsRnmU4wqHZE87CalYzriwPOiMhj3fTw218ng1RwhX0f1XpAaGRdevLJkl/VsnxQoz
         6Qt4WfkVZ7cY5qeVnDVT+/Yh7afjTLheuSJZ1pBkTex4ssUtDiyoWZJy69VUgJjyEOnI
         /moblCFM6cNkrzPbmX1h0M7Czc2xDc2VJcZprhMJzP2QUSVEKitOB0JYlhH9w3SYBFg4
         x/HXXHY881J8EXzd3D7bfif7eJbEHKSmwYoNex0Le2esije0qgj9k6OMi6Ylo9RCxdqb
         NK0YpR96UIKRAtB1UXdbKpGbpKypWyIa3Sqywm5MLijHdLc3/7I3F22c9Ui+eV6fYvnU
         vR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708955229; x=1709560029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSizykDxdC8x5yUdc/x3m/4mR390jcmCw+184ntuZ5s=;
        b=oupy5l7JxzS8bc2e7tgr1fCFRpvbsDhiKWqymJp/bN9L7Y2WZuD07acKiuN9028ebg
         unmrQqMdsqi3gqyV0UWRueRyFavYaLHlO1Smg8tI46U9EEyzuuxZ8YoNDAP8ucXeTCxx
         /B2Y1P1q5a1jWO2LQXxfMfgbxJ/1Yn96NOLx4KlxlglOh7JjVHom1dAvUw304U7DJ8JX
         J6wwGhl12fsnKu9qTxVYudnU9361J0dwQUcQByiez09Jrz4APVI254z/kqEGqMr+bwoO
         ycoVnt+9f1jQU6+qjDgUZZg+j3wB58eL/9MvU9M4l/1Q3X4lhP6YV2uOtxxmJcPnltjd
         V+BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBuL723WFMHCR/sVLnB7J69M64n3v8Nz5pmi8LPNgGIjhV7ah8iZ3LB4XWQWgF+uMs78AaCSc2jiGwxjBdeq1/LhzROzRsFPOOhn8w
X-Gm-Message-State: AOJu0YxNgIYizyMqWE8MuKJPAAp5LvrTZaPBFxzqChPebtJWi97N1Eyg
	Y6o6QUrEMM75Yp15xJXyhC/pZoL6MqcDmhR7fbB6HdPmVlv0hz4i
X-Google-Smtp-Source: AGHT+IHf9hAovCwUz9WxnDcvUvW4s5oVieA8gxvLqkp3SqYdyddY8vdPB/cL5mzw+tUovt4IL2keDg==
X-Received: by 2002:ac2:4c2b:0:b0:512:bd81:80e4 with SMTP id u11-20020ac24c2b000000b00512bd8180e4mr4195304lfq.44.1708955228714;
        Mon, 26 Feb 2024 05:47:08 -0800 (PST)
Received: from localhost.localdomain (IN-84-15-189-254.bitemobile.lt. [84.15.189.254])
        by smtp.gmail.com with ESMTPSA id k24-20020a17090666d800b00a3d00616e1fsm2450012ejp.193.2024.02.26.05.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 05:47:08 -0800 (PST)
From: Arturas Moskvinas <arturas.moskvinas@gmail.com>
To: fabio.estevam@nxp.com,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	u.kleine-koenig@pengutronix.de,
	andriy.shevchenko@linux.intel.com
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arturas Moskvinas <arturas.moskvinas@gmail.com>
Subject: [PATCH] gpio: 74x164: Enable output pins after registers are reset
Date: Mon, 26 Feb 2024 15:46:56 +0200
Message-ID: <20240226134656.608559-1-arturas.moskvinas@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move output enabling after chip registers are cleared.

Signed-off-by: Arturas Moskvinas <arturas.moskvinas@gmail.com>
---
 drivers/gpio/gpio-74x164.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index e00c33310517..753e7be039e4 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -127,8 +127,6 @@ static int gen_74x164_probe(struct spi_device *spi)
 	if (IS_ERR(chip->gpiod_oe))
 		return PTR_ERR(chip->gpiod_oe);
 
-	gpiod_set_value_cansleep(chip->gpiod_oe, 1);
-
 	spi_set_drvdata(spi, chip);
 
 	chip->gpio_chip.label = spi->modalias;
@@ -153,6 +151,8 @@ static int gen_74x164_probe(struct spi_device *spi)
 		goto exit_destroy;
 	}
 
+	gpiod_set_value_cansleep(chip->gpiod_oe, 1);
+
 	ret = gpiochip_add_data(&chip->gpio_chip, chip);
 	if (!ret)
 		return 0;

base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
-- 
2.43.2


