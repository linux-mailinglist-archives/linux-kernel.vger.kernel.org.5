Return-Path: <linux-kernel+bounces-117379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF0288AAAB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE751302A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51BD12B14F;
	Mon, 25 Mar 2024 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fszZjiXl"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76677839E6;
	Mon, 25 Mar 2024 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380896; cv=none; b=XBJfnT2qd6syEmWhlrgjyscNB5X+wN6xxx6ahJk/6Zt5NBK/4GQ0iWxDnEsQYxcHm9XdiB4B0xatf7lUrtbU/QLtr2nD5g1FEPIuQaXeFmwJod16GAiZC47Yqc6YMoUi+Wi+KWkzKIHhcqo4q+WRA3F7mxLThkMCAC4gLMVsr+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380896; c=relaxed/simple;
	bh=hARmtm4rTtaFJuBULTQfdo9eTIL2pJjKJoGGzQJIVXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NpPDNpbrD8TOArGz66u2+NhIZ9ZEN5qvE+JmjwU0chVslPYSMPPC0/kHTFl8aUOqUw19f8vP5bH47frBHmnfEo7S+bMKuOSVoTy150VismO8QOKvJ6aqtvy88hBl7Z5aBL4zqiDA9nHUIQEQAKLIMY8GkOpxUbikA3VQw8QoJRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fszZjiXl; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56c1364ff79so1276484a12.1;
        Mon, 25 Mar 2024 08:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711380893; x=1711985693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kncRhP2pT3ITSlMJR34JQI/1lm9wSvt8Ld4xw8gbYnM=;
        b=fszZjiXl3bOgpfU3XybGPV1BwO/yhW3kwTN9ra6hI2mEQG0pX6wUHXJBJAHcWV+4LW
         mA6llR/x7SKqEBKcp3+a33U06OmyEgQ4B/DmdfYPCCb5zS3r1C1Qyib6biKXFxv/1mz+
         CibdoTlqRH9TVGyOHmsvbfRfR5uvdWdNgRVPS9nSLAWSm9S5j5s9VB5E0ORMJpzN+vk3
         H7xMe2OUqjRuXHX2VZmZ8SU852FYg1HGcQn6Q6PZ3aP/43nYbjazWM2D4yBitA2D4mfm
         eKtHTQy1Dih/z997BLeamyk6AD7REButmQJB06l2Dl/SgkIAXFZmZqMmR2iVrnIqV99e
         32dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711380893; x=1711985693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kncRhP2pT3ITSlMJR34JQI/1lm9wSvt8Ld4xw8gbYnM=;
        b=g5+wNEIKps00c4htFPg35QJRh3BQV3NZZQNSwqYZmb70ey1Kd65ub0NnVKJ+5i+641
         mruAzmCv6qvZV/M2xmdRApuyW6QGJ6PPcfdRR5VKOmch9nFpeShiQ0ZIJlIOQ89OzcCY
         4H6ZNi8QlbfcpQzoKuS7VR48dTS/HOaXlZrsbIVKs+w6pB2/6cHL3MNbVUpE9uI/nMPQ
         /pOxXU87MraJ3Fj6FCZ+OuX1GGrIjymr3k2ZbhfeyOZXR0Xln2ce8jrwpYv6skMhAgm7
         5N3C4yfFj7gPDZM7k+KIOzX4vP0GSEaaLYGW6zz6dGwbmMJ+9bvqOeSYeIsU/S0Nl3u0
         ELDA==
X-Forwarded-Encrypted: i=1; AJvYcCUgdW1c1LGR3aMwH2wyWbRKH92skw5VCr3mwg97Tmeu4TtBaGKHy+rRZBBZGeBH2Mw4PCOI66lq1euI6PbnRg+bBUCGiBsTefcS/V4zGES5f8oLd0ByaUzNadOoHTRY1ejvD/ugJYI+pA==
X-Gm-Message-State: AOJu0YyeEr1EvBjgCNFiyhG5L8hVMw1SZoVUsOVFHOH6yagHlRqPGAmt
	TsWlNHY4Qky0SxHXGyGkSUNSegXB4mWo4NaAQkh9/GkJCRMEra8b
X-Google-Smtp-Source: AGHT+IFWO/l7ZW7wmITmIZ6PJURGgtIwl+CB/Bp7KN0Pbr87Q40eX4kT41S98QRPKjK/9t26KqRAag==
X-Received: by 2002:a17:906:289b:b0:a47:1b14:423 with SMTP id o27-20020a170906289b00b00a471b140423mr4806853ejd.57.1711380892631;
        Mon, 25 Mar 2024 08:34:52 -0700 (PDT)
Received: from 764c7355c69b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090626cd00b00a45200fe2b5sm3142382ejc.224.2024.03.25.08.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 08:34:52 -0700 (PDT)
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
Subject: [PATCH v4 6/7] iio: accel: adxl345: Add comment to probe
Date: Mon, 25 Mar 2024 15:33:55 +0000
Message-Id: <20240325153356.46112-7-l.rubusch@gmail.com>
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

Add a comment to the probe() function to describe the
passed function pointer setup in particular.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 476d729bc..cc3da4ece 100644
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


