Return-Path: <linux-kernel+bounces-127013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069358945BF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B781028254D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9F35811B;
	Mon,  1 Apr 2024 19:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmsXM0P3"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911AD5730A;
	Mon,  1 Apr 2024 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000967; cv=none; b=M1F967HAMlX0fPzkQtk2TQv1y9ykXkH/gVYuAjl5YGcMPGaz8VN0CNpfDpsJdQDruM5Ab6F3foCTXnkQc4e0HdNsUkljYMPFn9CjaPJT6ZSXFW02LqWogymdtOefXHVwE4OOWX6J/rYGuo/PYsarUgQmF5SPbiyoa0GSQQjmqmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000967; c=relaxed/simple;
	bh=igZSiokSHxZZYZbPJ3bqgHJfKaRxjkQxdwMAadgF1wA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D3vfaWRil43wTiACPjSYKJMm/jkBVauoutgGNqr0nKVQ69gHLFw+G9aYdTDsDbOYcDDEARAJDzwnZdM7GIRIS4LabrR33R5bffxB9sN+BEiKSpRSKHC0p0BBgxBKcKX/VKpuhmlju7KzUL8kiukmHlx9ah4jORINpmFj2nA0Ogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmsXM0P3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4e60a64abcso203190366b.1;
        Mon, 01 Apr 2024 12:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712000964; x=1712605764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9u6xO0mso3s0p6mb+hwA3wZM2r51h58gapOfOhMuxY=;
        b=OmsXM0P34FgrDwALrz4NeehDa3vHEtEgEeFkUsE9GzV2qx9yoMo/jDBHMXj7I294bI
         K9BEvNzMw2AcwBeOHQgMDDJEOnn0dILGXXYymVWz5e5pbgzh/y5aUel8NKE2sprDZsxK
         gy6Y+R0Yu8gYAWyV1aAVvekNXMZQMbgJJQg8Rgi6312HnZn62dufvq4HZ7YU6ItwDkWI
         jahfdx+l+3keBCCayVa39HTwzzJeYxLv4qvvyEcNBiKqKjUMusaiq1qrBSYTLoM8N+pN
         QKUoMy6EKplsJeBOvFHscQO3wmb0OSCP+coXOBIMztWfP/3dj0ND/i5ewwMVTyrI1pD7
         FWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000964; x=1712605764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9u6xO0mso3s0p6mb+hwA3wZM2r51h58gapOfOhMuxY=;
        b=JCKcaGwjYWcokde7g/+3KyTSttF/MSXVZLGupPZqj89BvjD7HZ4LHhF4/yTdkzwGMs
         iDzWkUqGJY2eWP0Lyx2Vd4tyR2wbFVy29xMsFH2L+psO41KdgBJuNjP03eXkkCIv2Ls8
         ATLnEUTKClJlJhWzBxdOhGYFfV32TfNPrXlrnhJgXtf6FI/JMW+foqW56xMpKQIuQko1
         ++a8eQfptkEsMm2/MtbTCfIVEN0zvGvyR587RLkpNCyzutcnWNE1LupiImK5dwgIRcZm
         f0bzNfzZpVbg/TezZw6VjxoHRDOTlJrRd1Z0Y9/b9On1h1dnsqNhUMOsYzn96ALCEva7
         iQ9A==
X-Forwarded-Encrypted: i=1; AJvYcCX9PkrrWu66orZ9s1sqWWnH+yuodctcCj42uelXS7llPHSfq8qDNUqiefrdSrAmD4pR70E1nye494fdZIAGeq6TnY6J5Pib1O2nu1xE2+d2bpmz8OHmemzQgo/8QnVz+Jx2YcM/3uMxjA==
X-Gm-Message-State: AOJu0YweDomKs+/5ISyEYMe602D3rp0gXs564XGZLjBtlcRVAkvIiq97
	e8tmUzXw6pyfdoCqXoxFQT6ZrTIiuofpenLmwWeU8Ls4f4nOJuEH
X-Google-Smtp-Source: AGHT+IGrbhHcNHGFHhyx53bSueu6goilXaADw7MGcBw1c8D3DRlP8uz2Z1xUkHW5u2I2LReYwTnrUQ==
X-Received: by 2002:a17:906:d0d3:b0:a4e:68af:b1d8 with SMTP id bq19-20020a170906d0d300b00a4e68afb1d8mr3488845ejb.2.1712000963797;
        Mon, 01 Apr 2024 12:49:23 -0700 (PDT)
Received: from 13a4f82a8f12.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id dn21-20020a17090794d500b00a4588098c5esm5540575ejc.132.2024.04.01.12.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 12:49:23 -0700 (PDT)
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
Subject: [PATCH v7 7/8] iio: accel: adxl345: Add comment to probe
Date: Mon,  1 Apr 2024 19:49:05 +0000
Message-Id: <20240401194906.56810-8-l.rubusch@gmail.com>
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

Add a comment to the probe() function to describe the passed function
pointer argument in particular.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 5d0f3243e..006ce66c0 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -168,6 +168,16 @@ static void adxl345_powerdown(void *regmap)
 	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
 }
 
+/**
+ * adxl345_core_probe() - probe and setup for the adxl345 accelerometer,
+ *                        also covers the adlx375 accelerometer
+ * @dev:	Driver model representation of the device
+ * @regmap:	Regmap instance for the device
+ * @setup:	Setup routine to be executed right before the standard device
+ *		setup
+ *
+ * Return: 0 on success, negative errno on error
+ */
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		       int (*setup)(struct device*, struct regmap*))
 {
-- 
2.25.1


