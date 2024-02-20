Return-Path: <linux-kernel+bounces-73774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 218B485CAF4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D062828660E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A664915442B;
	Tue, 20 Feb 2024 22:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieqhiT33"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E0F55787;
	Tue, 20 Feb 2024 22:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469041; cv=none; b=W91yo1oRonU14lkK4phmJWz96oKqO7Rl0630VtV0hl7vMozq+xqI2JAcmd8InvK8/qyYQihVor3y6+2BccPHP8M36nVYbwfP2w4dq3lRQfe7+7tvdpQH0c4KjYuI+saJqfjZX6fF/UehscsCxrcGYcMIoa3XdRw0qZDuBP4Z8xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469041; c=relaxed/simple;
	bh=7OBXl7slkbYXNkGIWbZGvBwkUN2P3K/p4aq4Pl//018=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uLYzlmlZjl1FtLjKUUp9k47ZGKnZ/SvNRHrOdtjYjmpcMLAV0NWRxCu8LHj2QGYrYlX5hXY7pZ1dnNMUSlw0tZWw9dcGM8Lx24Jh7TTcpOWkkgeULB6Nzj9h670RbaQGZTkQTwmY+kC8tz3xqerLFlRR2z3vbBlkTVbpo6S0LEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieqhiT33; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3e87b2de41so266895866b.2;
        Tue, 20 Feb 2024 14:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708469038; x=1709073838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DHuB3jZibZ6qtCUb9uZTADnW27tWsLt6G/FLrbSZCEs=;
        b=ieqhiT33QBrWIosXfxuF6R2nzZv/hAVRDUns/c/dsfVfni0XzH20tT7EZU0KbIhXRp
         Tj1eznH/IceQX7ZRsF9Sc0f2qZKlbr/m2GpJw6o87oQeKtcN9MIYR47HnSGr8Wxd+tN1
         p9onkqrANL4kanaFLljG91ooGEEOUxWFZx1gENvF66A3z60e+zr/tmLT+ecBpoJO2V5k
         a39AHFG1wPNL2E67rKKj0yoyjce7xuR+CBm42HtynLHFy2av9F/8a/0+ol5zZctnp9dz
         hTOo+KZwlR6eLtru6E6eG+zIXwNDJckGsBpSMpUCZCnpp2g7mbqE1Z+8ARVg5Q10/pjl
         6eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708469038; x=1709073838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DHuB3jZibZ6qtCUb9uZTADnW27tWsLt6G/FLrbSZCEs=;
        b=nh9lYMliKO8CF7ft53X+3N3PB/j4eS2+Zavu5C3E9lO7V7fG04OKD0ihjtUEEjbM0S
         76v/DezBl9J340TBVoSJYpHlKbqCIkb28WWI6J65nnyvRxaJ6K54dHiMN1Mz9qsk+UID
         d/r0Dgu0oOv5lTHaMMRlpkCHl/P+sLN+9ogdpHMCsWmMxwpDnIrX6vnZYmymBWtUi4HG
         u1qIxU3SnDTdTKBakzy5Duz62GItO8aVhJRLEBdxy9AA65ge8cBnTmNgcT9yASXCKiSW
         JyeRlhR8ofcMdHfPipV5/CWiKO6T07Dh1K/d2mGO7yQp6SPtLHZyXvYNsWQhz+teb2d7
         mlpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/ESNCPBNtYAZX5Hx8Ed7mrVzZySQUZcILUegzHwqYBW+z/bmS3Tvt32Qzz4fPvxQRbo34NG5/XIgYsZPv/kV59WBbb2yO35hZhhanWwwwHLW3MNAjZbgsaySJf7/unSs/rbKTgWb3
X-Gm-Message-State: AOJu0YxQQZHia4nexg0vpv8vDzADPyXtVqygZtHwUpsLkNzKNniNd8Nl
	KuIdZrobyqDopmlgNk6jwejH83l+JDGalaL/0j49/T1v19jfDuZF
X-Google-Smtp-Source: AGHT+IGef7cRx9p63So5jxOp2xHPGDx88OvziqNvplGafUO49cZ0JlsFYG1MOnGYkhXrNduPY2WEog==
X-Received: by 2002:a17:906:af09:b0:a3e:d515:cdf3 with SMTP id lx9-20020a170906af0900b00a3ed515cdf3mr3933296ejb.27.1708469037440;
        Tue, 20 Feb 2024 14:43:57 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4de1:dcc0:a48:7f])
        by smtp.gmail.com with ESMTPSA id xg11-20020a170907320b00b00a3d83cff358sm4328489ejb.70.2024.02.20.14.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:43:57 -0800 (PST)
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
Subject: [PATCH 1/2] drivers: iio: pressure: Sort headers of BMPxxx SPI driver
Date: Tue, 20 Feb 2024 23:43:28 +0100
Message-Id: <20240220224329.53729-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
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
 drivers/iio/pressure/bmp280-spi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index e8a5fed07e88..fd7ec6a5bca3 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -4,11 +4,12 @@
  *
  * Inspired by the older BMP085 driver drivers/misc/bmp085-spi.c
  */
-#include <linux/module.h>
-#include <linux/spi/spi.h>
 #include <linux/err.h>
+#include <linux/module.h>
 #include <linux/regmap.h>
 
+#include <linux/spi/spi.h>
+
 #include "bmp280.h"
 
 static int bmp280_regmap_spi_write(void *context, const void *data,
-- 
2.25.1


