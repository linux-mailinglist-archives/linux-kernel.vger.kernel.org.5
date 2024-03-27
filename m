Return-Path: <linux-kernel+bounces-122074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F199C88F18B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578C5B23A50
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B888154453;
	Wed, 27 Mar 2024 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdYO9H2p"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5473153BCF;
	Wed, 27 Mar 2024 22:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711577015; cv=none; b=PsC3zQ78TcyX6+pCA2lqi0rccicxd9/ZpWwCm6nKCddMw1ea1n1/wvvRXHBrIZCTmU/T0tCoE14AY1J6C+xAhlIyrxXLQgZ3kSAZR8HXt2NfxPteYnaElbTzT9xs/n4f3YreDetx4i8otbj/gA6wA22blSmm1k3hJC1HVg/3Zyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711577015; c=relaxed/simple;
	bh=bUKmaf3w477eneb/ertNd9ZH7tWlllpSq8rPnqnMyso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LBs+WJClTsStHRkev3qcwBVrWl5K56gDb2Y9k9WA0avCRcMqK1Z8QzAD4xFhftd5JVk3ffAozAEbslFH3aN9oH7L1+/1dNibhEsFgNUx62K3S54FL+li4EaSLLzlmyRVruppJrRsGUshWrZBJrgVVkc+8oQgM0oVz9qDTpe/CA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdYO9H2p; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5688eaf1165so400937a12.1;
        Wed, 27 Mar 2024 15:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711577012; x=1712181812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+bZnogdTxm5jEl9PmBGFg1RXApDv/sG0IrNxF3UtxM=;
        b=bdYO9H2pTN5Ai3I81DTtOK8wVM5aX2c8A5xRTkv1djM/YW6D7QaA/eWONyhS0FHsNp
         VWJIpj0vc5DemQVK518dkCLyfzlC+Tj4Ryj+r6BRH7INUROIXThdeo5zUtYefzpYuVkr
         koeIsmADZjgya81L64LfrHH7AvJ2DTHNqGwWYaxqCrsbydSlQFE4W4HYNhvOmcKmj7Wu
         gdCnaZGVuxSQViKiDd0WzZSzWxHE9XDlygnZJOr11326DPFnY25G3K8gXN+rpjFH670W
         A/PuXVkc2NQY5/cpDjUrPJYh6qh+o7OfbR5dI5gGtAsydw2VrfylD8eLETuVo1xGNnFE
         zIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711577012; x=1712181812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+bZnogdTxm5jEl9PmBGFg1RXApDv/sG0IrNxF3UtxM=;
        b=fPSRFLLGQgd/c+Zfh69VRPk1WFVWBRZqY/4CUTJt4o0EX6PaKkDzGU0kFLP478+wt6
         im6D5s6JtXTRN8AvtlNvAnlPbkiqRWxmSrQSLDTSDj4NjuMPJbWUHt/l3RJ5RYGgjbnD
         8QAWyaagsTmEOHqWS9eO/J7HJ4CbqAyl6AkeWz+4qWRQqAZEAYc5+xfVj7mJICLE1q/f
         W5YRCEoWNRWLfvkYEStbx0XFivREHn7di+qplFzRyxYIghdsL/MU26UMYU5ljao9pvFM
         P7wl8etrSD18Wup2wDRxMzWVJqWMkY7YBPthNg/Fv8PuOZA2pZeNiakIp9KV4AJvunVh
         RoGA==
X-Forwarded-Encrypted: i=1; AJvYcCXdOooWaMSxRQTY6pGxzLOXQvUWp/IqQoHwOXwV7C/8nd31umEGdlpZqYi67fwYS8zV1/5EZ6sPwHFWCLl5GMkBoCc7Y6OuVUSdlzL40cewhWpjPv5I3YynDUHG4b2XpSV26PzIWDQOzQ==
X-Gm-Message-State: AOJu0YxpkLc4IId7OdNVrZBFm+Sac4u/0TGO1/L6ZCvnyWnS+3Zyan/v
	qLbqMUHn7yGnKtOlZR4vRpgY1+IRYatZWiIRVZ/hltu70nfV5VshFn59Pyu5gkw=
X-Google-Smtp-Source: AGHT+IFJbWM5ojETYCNxLfzAYXdzO/Wc+JAzNiVHEkzqB7Amlqp5vKRLrFS42yKSAQMY2ydWZJB5vg==
X-Received: by 2002:a50:ab15:0:b0:56b:a852:74b7 with SMTP id s21-20020a50ab15000000b0056ba85274b7mr861934edc.6.1711577011984;
        Wed, 27 Mar 2024 15:03:31 -0700 (PDT)
Received: from 51a0132e405f.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id f25-20020a056402161900b0056bc0c44f02sm59151edv.96.2024.03.27.15.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 15:03:31 -0700 (PDT)
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
Subject: [PATCH v5 3/7] iio: accel: adxl345: Move defines to header
Date: Wed, 27 Mar 2024 22:03:16 +0000
Message-Id: <20240327220320.15509-4-l.rubusch@gmail.com>
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

Move defines to the header file. This keeps the defines block together in
one location, when extended by new shared defines which then have to be
in the header file.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      | 37 ++++++++++++++++++++++++++++++++
 drivers/iio/accel/adxl345_core.c | 36 -------------------------------
 2 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 284bd387c..564f7baf1 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -8,6 +8,43 @@
 #ifndef _ADXL345_H_
 #define _ADXL345_H_
 
+#include <linux/iio/iio.h>
+
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
+#define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0) /* Set the g range */
+#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2) /* Left-justified (MSB) mode */
+#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3) /* Up to 13-bits resolution */
+#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7) /* Enable a self test */
+#define ADXL345_DATA_FORMAT_MSK		(ADXL345_DATA_FORMAT_RANGE |	\
+					 ADXL345_DATA_FORMAT_JUSTIFY |	\
+					 ADXL345_DATA_FORMAT_FULL_RES | \
+					 ADXL345_DATA_FORMAT_SELF_TEST)
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
index 5c24ef9ca..c7c1156e8 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -17,42 +17,6 @@
 
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
-#define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0) /* Set the g range */
-#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2) /* Left-justified (MSB) mode */
-#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3) /* Up to 13-bits resolution */
-#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7) /* Enable a self test */
-#define ADXL345_DATA_FORMAT_MSK		(ADXL345_DATA_FORMAT_RANGE | \
-					 ADXL345_DATA_FORMAT_JUSTIFY |  \
-					 ADXL345_DATA_FORMAT_FULL_RES | \
-					 ADXL345_DATA_FORMAT_SELF_TEST)
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


