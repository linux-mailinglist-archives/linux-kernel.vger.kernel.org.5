Return-Path: <linux-kernel+bounces-73523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D78785C3BC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4380F285A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E550D1339B5;
	Tue, 20 Feb 2024 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdM6V29I"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA3612E1D8;
	Tue, 20 Feb 2024 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708454495; cv=none; b=nClh6xRoNpiZVxu1Y86T1QEoyIxezDY6K5TGEKdrn+H2yw0WiZakdL9SwDjLIb6D08MeSfRFmJ6VyQvLOaJpcwTeZh4eBnaJoPX7jxmVCaXQJuBQ11l/m0F7UEY2jrfB7Ws0Xv8t3kSgLAze8CWDv5cQcP2dH8FgBQVggsNvYQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708454495; c=relaxed/simple;
	bh=BWfTajOPUTzLygxio5pKNoa4Z8AGiKngDpmKELsS4hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LcrrZeR2x1v1qC4TZUJf3qKuknQZjXjYx5fE3PWSmwk/8OE9EAU8+sAaVxic5Tovci8zWLD0jNWtELbkBgwXPxRufuUR8Gp4fyb+0N42xsGEturzWby7N1jmm9Wyx1Tu9Eg4xmD98+4vb1/sq6XDmzN1tQLBTaEHNtDFv0SFaTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdM6V29I; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512bde3d197so2316460e87.0;
        Tue, 20 Feb 2024 10:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708454491; x=1709059291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sO+tJy+OcpVtqK+jntLOR303MXxAWwT3SO7chMYMGqE=;
        b=gdM6V29I2xHgOxOegYFv2PNYM7042yJdxvR7efLlZ5ZQPvjAvFZRca119wDEMXSrSy
         yD+hJzdn12jROCQwxHJubEt4m/TZIOgwGwrO/O6G3g3VR1FqHMclb5UA4/O3/wm0ArLu
         Lcvrx76pL41c6PP3LT2s14lWjJMwd5nHH4IaPge40Dfvw4yk+qv/EEKTvCOg4OySHjoY
         OxMYGgaoPmEXSG1EK8K/579lzEbbpMrMeXT0tNWD0GQao8OX7Dfqabf0XaOY4TGou1Vq
         ZGp4M6Jf3ktssPfHfcSFddF/7zG19RiZgDvyIteRt2a7NgTaHIgKdFXppFUmHsyDo3l9
         JsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708454491; x=1709059291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sO+tJy+OcpVtqK+jntLOR303MXxAWwT3SO7chMYMGqE=;
        b=kMEUZq5c2/iPZDxzYGaf80+h6eMIaF51QMQAGjKGksmnGkrh8RVmn7fRVRlyX+0ZBW
         MaoCkpprWFaSIjWsa21KLJYDAzzHfq1fO+tnMdZEQzN8ZoAmZClhkwKSHQJONbEg2eh6
         14QEQY2pgRi1+agV1O/vi7iq9C4ZeJlw406B5rMPV0kZZdgvPmMfVWeMVsBhgXSH8VLf
         e0iJ5YHr32fnzv81z544FHMUAyIKWAJ+E5TSOCPHZpm4myF+IhfJWB7ACNZwzftkUigI
         jEv7/Ef3Dp9Y5QzVVkAhK03P6x+bfzYuBN22wFVfMDZuYucDFFvwIJGbFRVr3x0ge7J6
         pijg==
X-Forwarded-Encrypted: i=1; AJvYcCX3qdgUuO7yLU0HEE+07kUr8f0wRLKULIuwuP/X6GU9yCpm9gDz54fd6tBsw48LpOrVivDwqB21V6lT8QLW9ppta4a3ycPCnELK92a7k2BRz2fFVcuvpR0Q3IVJuG5Ron2icPQD+7th
X-Gm-Message-State: AOJu0YzpjRjxgh4z/mwxNIEPTB4Eig6WbPUehzCpVCpesOJ8yhq0+LSk
	4TGTzugKPNCIZT+PcZqGUIVd8GC8nvdK3KnuRORtdgIEubGGuNbG
X-Google-Smtp-Source: AGHT+IHtWYfkDBoLoAYirXD9KiiCz8Ftzjhn1hRyEgC5esQHBNHHN/zxhNoamgNoIf6uAxqJ8H1zNg==
X-Received: by 2002:a05:6512:488a:b0:512:afcf:771 with SMTP id eq10-20020a056512488a00b00512afcf0771mr4718567lfb.42.1708454491250;
        Tue, 20 Feb 2024 10:41:31 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4de1:dcc0:a48:7f])
        by smtp.gmail.com with ESMTPSA id bm8-20020a170906c04800b00a3d9e6e9983sm4269594ejb.174.2024.02.20.10.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:41:30 -0800 (PST)
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
Subject: [PATCH 2/2] drivers: iio: pressure: Sort headers of BMPxxx SPI driver
Date: Tue, 20 Feb 2024 19:41:25 +0100
Message-Id: <20240220184125.32602-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240220184125.32602-1-vassilisamir@gmail.com>
References: <20240220184125.32602-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alphabetical sorting and separation of headers for the BMPxxx
SPI driver.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-spi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 1972014dca93..3458806f11fb 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -4,11 +4,12 @@
  *
  * Inspired by the older BMP085 driver drivers/misc/bmp085-spi.c
  */
-#include <linux/module.h>
-#include <linux/spi/spi.h>
+#include <linux/bits.h>
 #include <linux/err.h>
+#include <linux/module.h>
 #include <linux/regmap.h>
-#include <linux/bits.h>
+
+#include <linux/spi/spi.h>
 
 #include "bmp280.h"
 
-- 
2.25.1


