Return-Path: <linux-kernel+bounces-127009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B278945B3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1F81F21D98
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B61C5645E;
	Mon,  1 Apr 2024 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDazVwEw"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1101754BF4;
	Mon,  1 Apr 2024 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000961; cv=none; b=ZXLA6EL4AkwmKrVKM6o+X6qNZzTOT04oTnMYXip3P1hph187pVhKV2ybTCzPE8GuChJhFpPYTOGc8ZIXgvMfBcBZWjSUg0yanQ7g+FJxNJirZiJypqxTbxBMjfdv2mVJHQ4gTOHxVPranNL2HRKT1DgrfSMHyj/XeAnXyUCPWzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000961; c=relaxed/simple;
	bh=6ZXgZbhGDSIPcTYrtwC02tp6vJicbM7TlNaYhlrKI0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DWlxXPQYMicF8o48/D91uGXhN4w0LuTRMf5gL/xySHpGmcP1QkyYs8o2ehnpp21SSdePmc4vCRm/a6cfsieQgf/quTScBZcCDEo6aN/17vW5444q6EbvXzC300HaGEnhXeollYJwSIlXI8w9wDVIY66aAYZQZUIKK9OFwsJoyY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDazVwEw; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d700beb60bso76724101fa.1;
        Mon, 01 Apr 2024 12:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712000958; x=1712605758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAw5A/7fgz9+mCxUB6RBM8azMqA/dmbwe5pXpOefMGE=;
        b=dDazVwEwzlJHE//8/+V0oAywpPM6/SOqNDPAPvG1TSXbFwFm/4p+DqXhbLQbWQJQMP
         PZDT5zQFp4DzIZw7+GHH1xhPunzXCuBk2WKtRdIfGCbViFWcZUh/vHsoOBJ5Dg469wt8
         lTeRMmWynfeMDt2doK+13J22kbKZovVlIBeq9hGLQkl9z19sPoQXHvCE3VKt4U5XP2y2
         4uit0btpOV4lHwkizqKdvnAxch98CobSJu4mFmxyqiVFhcahZq7d9+5Kn9x7UkjOdstA
         FhdVhy4Ego8jltEX43KwROnu5YSd86GXBHsLSyAQlkyy7MzF2qJl6BUlvCdXgZVc++KS
         nneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000958; x=1712605758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAw5A/7fgz9+mCxUB6RBM8azMqA/dmbwe5pXpOefMGE=;
        b=tXqWVRxji++MMIIZY1uIOlQX+tUdv6IOrx7rIEicZYjbkE2jxjmntpVBi0LjWUhuO0
         7fjUAw7WTQIEF2Xn5LN90eIE19ATfXUGY/aEJYxMkmWVlvB+O93wxEaWrLiS+9q0W6C7
         6CVxoMA9vOfBhsF4ZjPKkqOIJxJhXHkJIhd1wcBaLFuiZHWDNikWbgaIHvsXNIqcpFXA
         OBF8fgvWzitGMmWBJQIMcCQzl0TKpHC6CzEKAPZu27NQ+e7fElA8m9yYlG8yu2EwGxef
         g+p0o15ZNlEcC/pSa+ABhhh7kY/qrDdLdLDiMM1VBYWAjqicsLDyjktBJFmlHf13EUcv
         lndA==
X-Forwarded-Encrypted: i=1; AJvYcCX8jFxphpdOnqB8PTitoPkPTzd2sdXhvEjWOGaN/i9oTmGlL9d8N5XYDBDj9iRT6UMnSKN++AD327mHZ3R4pkhpwuza12GJtZtbLcNucFJVLEIJZMlHpSS3ereEqxDm8PqZQj1bSMMmWA==
X-Gm-Message-State: AOJu0Yx/UWa6nCVlZLIDb+vxnionlkW7AlDq0KmMZRxGK+ME/6tkb2Xt
	MCQvEe5Z55a3B+1PiDvw5ImM3koxeArRxcQ9TtnAQpDPir5m1GqS
X-Google-Smtp-Source: AGHT+IFg5XckEL2nafSgWUI0WOcYU4EOlo8slLZzICqg4YDieEaFCLAPw+PgmXGKf1PcMmwJ9BF7nw==
X-Received: by 2002:a2e:890f:0:b0:2d4:7373:2a5b with SMTP id d15-20020a2e890f000000b002d473732a5bmr7627618lji.47.1712000958019;
        Mon, 01 Apr 2024 12:49:18 -0700 (PDT)
Received: from 13a4f82a8f12.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id dn21-20020a17090794d500b00a4588098c5esm5540575ejc.132.2024.04.01.12.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 12:49:17 -0700 (PDT)
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
Subject: [PATCH v7 3/8] iio: accel: adxl345: Move defines to header
Date: Mon,  1 Apr 2024 19:49:01 +0000
Message-Id: <20240401194906.56810-4-l.rubusch@gmail.com>
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

Move defines from core to the header file. Keep the defines block together
in one location.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      | 32 ++++++++++++++++++++++++++++++++
 drivers/iio/accel/adxl345_core.c | 32 --------------------------------
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 284bd387c..732820d34 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -8,6 +8,38 @@
 #ifndef _ADXL345_H_
 #define _ADXL345_H_
 
+#define ADXL345_REG_DEVID		0x00
+#define ADXL345_REG_OFSX		0x1E
+#define ADXL345_REG_OFSY		0x1F
+#define ADXL345_REG_OFSZ		0x20
+#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
+#define ADXL345_REG_BW_RATE		0x2C
+#define ADXL345_REG_POWER_CTL		0x2D
+#define ADXL345_REG_DATA_FORMAT		0x31
+#define ADXL345_REG_DATAX0		0x32
+#define ADXL345_REG_DATAY0		0x34
+#define ADXL345_REG_DATAZ0		0x36
+#define ADXL345_REG_DATA_AXIS(index)	\
+	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
+
+#define ADXL345_BW_RATE			GENMASK(3, 0)
+#define ADXL345_BASE_RATE_NANO_HZ	97656250LL
+
+#define ADXL345_POWER_CTL_MEASURE	BIT(3)
+#define ADXL345_POWER_CTL_STANDBY	0x00
+
+#define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)	/* Set the g range */
+#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)	/* Left-justified (MSB) mode */
+#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)	/* Up to 13-bits resolution */
+#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)	/* Enable a self test */
+
+#define ADXL345_DATA_FORMAT_2G		0
+#define ADXL345_DATA_FORMAT_4G		1
+#define ADXL345_DATA_FORMAT_8G		2
+#define ADXL345_DATA_FORMAT_16G		3
+
+#define ADXL345_DEVID			0xE5
+
 /*
  * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
  * in all g ranges.
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index e4afc6d2a..f875a6275 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -17,38 +17,6 @@
 
 #include "adxl345.h"
 
-#define ADXL345_REG_DEVID		0x00
-#define ADXL345_REG_OFSX		0x1e
-#define ADXL345_REG_OFSY		0x1f
-#define ADXL345_REG_OFSZ		0x20
-#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
-#define ADXL345_REG_BW_RATE		0x2C
-#define ADXL345_REG_POWER_CTL		0x2D
-#define ADXL345_REG_DATA_FORMAT		0x31
-#define ADXL345_REG_DATAX0		0x32
-#define ADXL345_REG_DATAY0		0x34
-#define ADXL345_REG_DATAZ0		0x36
-#define ADXL345_REG_DATA_AXIS(index)	\
-	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
-
-#define ADXL345_BW_RATE			GENMASK(3, 0)
-#define ADXL345_BASE_RATE_NANO_HZ	97656250LL
-
-#define ADXL345_POWER_CTL_MEASURE	BIT(3)
-#define ADXL345_POWER_CTL_STANDBY	0x00
-
-#define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)	/* Set the g range */
-#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)	/* Left-justified (MSB) mode */
-#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)	/* Up to 13-bits resolution */
-#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)	/* Enable a self test */
-
-#define ADXL345_DATA_FORMAT_2G		0
-#define ADXL345_DATA_FORMAT_4G		1
-#define ADXL345_DATA_FORMAT_8G		2
-#define ADXL345_DATA_FORMAT_16G		3
-
-#define ADXL345_DEVID			0xE5
-
 struct adxl345_data {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
-- 
2.25.1


