Return-Path: <linux-kernel+bounces-122077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BF288F193
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED9DCB22387
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F952155316;
	Wed, 27 Mar 2024 22:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grIFYLcE"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E66154BF6;
	Wed, 27 Mar 2024 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711577018; cv=none; b=FzDjuXQ5pUpQ1y8Xki+UTTwEAY6wklT9W8XdiJuzmL583xcB4u4Vi2pT8ZeeHLV1saMTum6fwz/iV0dMVw8GgzKd0xOYJEf5x3H7X+fDFopotR9mG1zEskMYG8BO7/Mr0RNcTGj3m0yIxsQpGce1rXtOE5lpXgSFZYMNF8mOkXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711577018; c=relaxed/simple;
	bh=f2SyvaQht8iOeJ+BWcT+RNA5GlwZAoeKF3kxpV8wFn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Myb2isILLoCnc425a0uvbUUovUWtnKLhGZFPPlRDQBMxSjASJNVbjOJ/kcEd50NOkWP5rSCDkfnk0ccD7Ft1fD+1ixxqGuEVMUvwJffo8VaxaTIxsIB7eB1xEKfKWBj4tcLuncfMhbu0tytSlOhvdQS11Cb/1JPxx3I7xexaxnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grIFYLcE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56c50e8f578so19645a12.1;
        Wed, 27 Mar 2024 15:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711577015; x=1712181815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eQZ1LzVNbcIDbdXkwgHYpSYK2z5Qvzz7kN5c5cp8Yc=;
        b=grIFYLcE8SRYOJjzSJYKypr25zakTelF7+8ETlErMQGuUODnW45LQv+hbdJC18hh7u
         nIgFBcrxfthHxm1vj578RG3NXqMYm1rT1WHbz/jd9eYssUx1LGWLgE9xUQZ5S5UbDixL
         Olg9zqsvweCZiz5UYZCxv6aqL6y7/rKY2+S2P/QnYaRl0q9FAJb5k37Hqg4FUgPk3Bmg
         jePZREYLPEAOJeBnyLJQZFo9JggMvhNcCCrFGY9ftR18OVAYSc/V8giKSEsT5jqJDch/
         7Eyy6IQc59yEHjtQV2cyghXwcf5/zqEtKc5VayxrzHCxeKwbsA/x1anhI7uUcSt+lyYI
         /sLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711577015; x=1712181815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eQZ1LzVNbcIDbdXkwgHYpSYK2z5Qvzz7kN5c5cp8Yc=;
        b=Qk76mG98uLXg1zS/bPdPc0XpUXZnsxJfwGkFYWxFtaNf3kkwqXm91LnXtJTLoZAxaa
         4Mlg7vCSpd/x2ePckoArO5ECQZborqAqxivLmBlkc5I4sOKk/S/mFH0G929+EydROPaE
         7o7ivvb8AvLGavQwoGREps+xa8mcMdon488mEIRO2Zmfw+Ob2hH3oUDgHaLRetjxS2N3
         Xp7Zrq4rY1wjDn2uVoj+VQQqanmYgdnyfDhj8ZhIGr1F5x2nHnHvLP7aTZjSIfcEQCL+
         j0Z9TtaFOKPBbahBCNGfGU5OYv++NaReM75poS3yjx8R49TZ2zUBs5NjWiUXOdjq1bKN
         z82A==
X-Forwarded-Encrypted: i=1; AJvYcCUt3DI8CGlJzOkrnQ1d2sqTdNO5j06T5+Xq69Zs9iOIaUXXlW1LlX5qV7sOW4JQkvWbnn0P+ED4Nma8GbVUhp+0joK2DlbUYjjOnKftdgA8sEULXs6a7Ex2y9g/xW6Jv6e2KHjP1kwFfQ==
X-Gm-Message-State: AOJu0Yz3dohLOKgRShxJaihqDYrUFqAzlqoQd3TvO8Ow/uuKb1an/MNy
	lSN9X3W/kmfgBhm/tr/hGMPXCY7ZcObeu0EPrs4ZLjl/DzfN6f/wvYr1EAjGIHk=
X-Google-Smtp-Source: AGHT+IG7GFR5cZyJ46FF5WJUtOn4xpuxo/hXSA3SDuQlczwKPtFG5R2Z7p+qniinJK4cA3gYjRCdkA==
X-Received: by 2002:a05:6402:4313:b0:56b:e535:6b01 with SMTP id m19-20020a056402431300b0056be5356b01mr621984edc.4.1711577015130;
        Wed, 27 Mar 2024 15:03:35 -0700 (PDT)
Received: from 51a0132e405f.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id f25-20020a056402161900b0056bc0c44f02sm59151edv.96.2024.03.27.15.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 15:03:34 -0700 (PDT)
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
Subject: [PATCH v5 6/7] iio: accel: adxl345: Add comment to probe
Date: Wed, 27 Mar 2024 22:03:19 +0000
Message-Id: <20240327220320.15509-7-l.rubusch@gmail.com>
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

Add a comment to the probe() function to describe the passed function
pointer setup in particular.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 40aab7683..0046e8d19 100644
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


