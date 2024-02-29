Return-Path: <linux-kernel+bounces-86337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B315086C40C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CBF01F23BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1608C535DE;
	Thu, 29 Feb 2024 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daPbjyxw"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4074EB23;
	Thu, 29 Feb 2024 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196423; cv=none; b=NEztAbeOelcTIcA5UD1fDVnzrrvMPRrC41EaZ9SKDN6LuqPpF1s6iBtcnfvKzfF5j9t7F38P8xJDcC4oj5a3wSkbM7m8D243kpwUCFSHsWgiMXoTf/x5QJlUC8INICynjqh+q0Cw00TsYOq0XW8NjCM0tJ/FmZC/mvw4trQMKh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196423; c=relaxed/simple;
	bh=3ZhFsifEiBm8P5023gzhvbL0FCLFDrjA9snDnqTw2K4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9Fb2vsyzkfC0CJZWb7QB9sYF0OxNntGU5LNuDsTcQHm0Lm/5/FYMwz4+0S7JmvkYBAWwU6Ur74m/FeSG7AnBg/cToY2WGxsKAGxuTXb7nBiWt2/hU1+eDJiGdGVPNAICqDbhLmKoAryWTevefqDmhJPNkwvtcBJTNWr8YfePzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daPbjyxw; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso837699a12.3;
        Thu, 29 Feb 2024 00:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709196420; x=1709801220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q9xUwc2qLxO6ucHgRQ6Y9z6Noz81Pr/8DKZ7yEqv8T0=;
        b=daPbjyxwIggDioQCx613HMjJiXOK20Lbdu4SdACmw26jI4PsOd8I8PWRbXNf4Znbkq
         5ls55AHuh/+D7/+1AgHW2d9VaWhEir3yzoEvEq5FarMVh07KLC6IJQNZowXAxjTCb1N1
         PvMYJEBzBP9wo+aweBVHDMUCRuwpCKlf0ksg8q5ucNf8Ei9T0mCYDVlRXRaQeHnTjqz1
         hCfkzc3GwbI3RieoGVth88s+wTS+fGMCp1WKqj12pV1T/I5qL4I6sDRXBZpMP+A5LWtQ
         uG1nvGpwMRzCMIm3VuzvW+bloMPyg/Rl5q3U8v0tEuueBqnzXbnH0KqNxj8CiGTVqY4y
         ipDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709196420; x=1709801220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9xUwc2qLxO6ucHgRQ6Y9z6Noz81Pr/8DKZ7yEqv8T0=;
        b=IXPyS/6qdebSijPRgEn3NcZMTjyhg7p/p5Tex4YQ5MPqbbzAh49L9M0DhSmGevLdMZ
         9DgVo2l/+ILn3rKbeW5ZVN+7EqhPRdCUrYTWqUrZ67Y1OdL6GvRU4XIYbKw1/tODr12B
         UQKONuitfBZyrOB6ii2v8YugeIcmjhAUUqY6+1lFwsm9FKJNuSLmq2Ky4XelLsfKI45m
         u0TxhZDEgLfS/tpEWvj75A9pnEUndaNPDHayjj9PYAcOEXUW5Eh1w7Gce6qkIUyp72Ub
         VLtfsYim1GWVMRNcnbjxgsrSKGsxAdmP7beZTQgty0vjtPei7CyhDBmKyjTsjJhtzAMI
         8LJw==
X-Forwarded-Encrypted: i=1; AJvYcCU7RI+n8HB/NyKj1KU2c4VW5VyoDxLMNNsjNFjoBfDuMeIprs3A1kYO8KnOVXO3p3gmilYwUer7zasPYkj6/6rVI4TQHUiu6SgDOG92
X-Gm-Message-State: AOJu0Yx5XUszqph38hslX08x8XHo/dRNoDACdxfWzLpn0CcNHwaf9ZT5
	g15MRfyGVkIU++HyUvxc3OYu3f0YhD52kKQBAnBJA+Rk7lX7omsb
X-Google-Smtp-Source: AGHT+IFnsygNFW7MjDfAVTqsRuXIpxrBN2qFHR7KQjRrqNQ0v+4tUMsRmc4swIvWnksIuX+z4/BtUQ==
X-Received: by 2002:a50:ef07:0:b0:566:2a1a:fe18 with SMTP id m7-20020a50ef07000000b005662a1afe18mr942975eds.36.1709196420119;
        Thu, 29 Feb 2024 00:47:00 -0800 (PST)
Received: from localhost.localdomain (IN-84-15-190-167.bitemobile.lt. [84.15.190.167])
        by smtp.gmail.com with ESMTPSA id s12-20020a056402164c00b005667516866dsm404064edx.33.2024.02.29.00.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 00:46:59 -0800 (PST)
From: Arturas Moskvinas <arturas.moskvinas@gmail.com>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	u.kleine-koenig@pengutronix.de,
	andriy.shevchenko@linux.intel.com
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arturas Moskvinas <arturas.moskvinas@gmail.com>
Subject: [PATCH v2] gpio: 74x164: Enable output pins after registers are reset
Date: Thu, 29 Feb 2024 10:45:56 +0200
Message-ID: <20240229084555.43701-2-arturas.moskvinas@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Chip outputs are enabled[1] before actual reset is performed[2] which might
cause pin output value to flip flop if previous pin value was set to 1 in chip.
Change fixes that behavior by making sure chip is fully reset before all outputs
are enabled.

Flip-flop can be noticed when module is removed and inserted again and one of
the pins was changed to 1 before removal. 100 microsecond flipping is
noticeable on oscilloscope (100khz SPI bus).

For a properly reset chip - output is enabled around 100 microseconds (on 100khz
SPI bus) later during probing process hence should be irrelevant behavioral
change.

[1] - https://elixir.bootlin.com/linux/v6.7.4/source/drivers/gpio/gpio-74x164.c#L130
[2] - https://elixir.bootlin.com/linux/v6.7.4/source/drivers/gpio/gpio-74x164.c#L150

Signed-off-by: Arturas Moskvinas <arturas.moskvinas@gmail.com>

---
v1 -> v2
* Updated commit message to contain more information why a change is made.
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
2.44.0


