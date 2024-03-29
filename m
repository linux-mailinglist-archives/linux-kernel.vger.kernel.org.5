Return-Path: <linux-kernel+bounces-123917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A700F890FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635EF28FA24
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B879D1DFF5;
	Fri, 29 Mar 2024 00:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVMR6B+X"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5944411720;
	Fri, 29 Mar 2024 00:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711672844; cv=none; b=SgsfRiv/sHUilWukwXWXDHPDy8p9Nm0SeCth/1cjvUl3s1ohfKnKLfMShNhp1SXS8shI3YnFX5srIs/tJO9BjBGXXM6JHKn7BpogD+avsuqIdPbWZbIHNZtEdlQ3sF0r3BQcni6ISwds4Ng89lJf/YIhf64yLCeU8JhyfUN5iHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711672844; c=relaxed/simple;
	bh=HHf07n/B+1VkiALybuaC6O5pR6Els/Bni9LZ9AlsDXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WvZ/ihiZd4LcPpwYunvV0Nri5ZTkfLI80BFqeVqykcW2eNzautNy/gLB9Ay0Wv10bxz5D90DMDcCTBwKQsvu0KeMzCLQZzXcF/BSMYwS3MQCUGBdrvGHDEp0KaTJVpOnu2wniSVFVVe3ar06yTtQ5twPTweMr8mtRtbvimyipOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVMR6B+X; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56bc5a3aeb9so1935746a12.3;
        Thu, 28 Mar 2024 17:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711672840; x=1712277640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiaRmyfs00yXQyFJiot+MPjs/cJdjRS0zbVlH6tELQU=;
        b=HVMR6B+XDlono+CJhQCW+jbew17aKuv5Hsg51FdRyz5+Atlrb6UKdsqlpjCcMmxYgP
         WcUogOcoQNY8p8Qb2mgsu94Y4JNYEyhJs979vWYyctEIEog2RHDzK7R6Ydhlk/DsDZZS
         iSxwckIDWdZk6gF+fGntvo30od0CXcbjlXrzSWugxSQe1T072LOateBNQB1wMF/Rg+4d
         6BXIJrazyfyPUFHsmV1ufBLcNpcmOLYFfIe5rQE7a8KN10YHqagQ3aEM3lrX83dkS8dF
         vgpl0Z3/oILmDU7m/HkKGQ1EHIj8HrB6y9TW1Ii47ASSmnU/7Cr9rGuSkVUFIUmOrbJJ
         EMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711672840; x=1712277640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xiaRmyfs00yXQyFJiot+MPjs/cJdjRS0zbVlH6tELQU=;
        b=GfhEacjuQT4wUQePYYuhy5sN3vx9oO3w/Q+mjI4CJU6vxvPj700Vg4B5N99grRj7OX
         yY+lQ7q+DPMNAs6jWuRuQW8XivssarpF8vbgtuHd3By6ZOdluT8CJ8gaPyMFeFswMdsg
         hZRZ7OAQnKG+q4sdV4e/X0Dgs+JpkFWH1q1h6efNRLMtzDsX028wNip5PDVHIyYlEv0C
         VY8CA0RHG5xwju9ju6XcWHJb+BfVUqCDnzXBmOWi0GogX1VXCIeX0fK03/vxbzrtTlw+
         7qSytZoQB3aYZHo1w4+Ws+qucsS/cWh5yUxxNHg7O0KnXeujs9Q350s2Jbxqh749ZUws
         ggaA==
X-Forwarded-Encrypted: i=1; AJvYcCXUCsHuuPceJHUqpk9g4VHAX74YRUD6ZzuWpiqZIT4Y4ki2ed8gdr1pYu5X03xNhVL8o945uBRPTQfCkMNzjxK6UIOhgrQOXiAD1fvaAMugoGNwfAYAp+texD3SxwdF2Wa1dKkcT4o6kQ==
X-Gm-Message-State: AOJu0YzFOGMZvjYpGtoExfIBtLgjEjlnDXMKfmPMhG+0kbtMzwJ4idxi
	6o+uScmPg9JcwjqwKX+lYhILRLxfO8Q6mMfIdJRKT6/rrfalud9I
X-Google-Smtp-Source: AGHT+IGrOQLOHCIZRvmmqqZdSFPOBaphyM/PBSqIAVyvQU18lLULmNIxtsZA4NKOkZUaxso6VriP+g==
X-Received: by 2002:a50:ccdd:0:b0:568:b41b:afd7 with SMTP id b29-20020a50ccdd000000b00568b41bafd7mr471627edj.29.1711672839536;
        Thu, 28 Mar 2024 17:40:39 -0700 (PDT)
Received: from 13a4f82a8f12.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id h7-20020a0564020e0700b00568e3d3337bsm1391679edh.18.2024.03.28.17.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 17:40:39 -0700 (PDT)
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
Subject: [PATCH v6 2/7] iio: accel: adxl345: Group bus configuration
Date: Fri, 29 Mar 2024 00:40:25 +0000
Message-Id: <20240329004030.16153-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240329004030.16153-1-l.rubusch@gmail.com>
References: <20240329004030.16153-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Group the indio_dev initialization and bus configuration for improved
readability.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index f4dec5ff1..78ac6ea54 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -226,6 +226,12 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
 	if (!data->info)
 		return -ENODEV;
 
+	indio_dev->name = data->info->name;
+	indio_dev->info = &adxl345_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = adxl345_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
+
 	/*
 	 * Only allow updates of bus independent bits to the data_format
 	 * register. Keep the bus specific pre-configuration.
@@ -241,12 +247,6 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to set data range\n");
 
-	indio_dev->name = data->info->name;
-	indio_dev->info = &adxl345_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = adxl345_channels;
-	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
-
 	/* Enable measurement mode */
 	ret = adxl345_powerup(data->regmap);
 	if (ret < 0)
-- 
2.25.1


