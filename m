Return-Path: <linux-kernel+bounces-55898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721E384C329
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 294B5284CF7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CBF101DA;
	Wed,  7 Feb 2024 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXh5Pyp7"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF25FC01;
	Wed,  7 Feb 2024 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707277029; cv=none; b=NxwzWoh6li9d73Kcs43jCQyhdCwqJIzlm2fK5ySd/69QMSBRwsSPci94UGCR/fIEibkRgT+OoOCzpajlgGjKdMhIYGGdJYKHOQjADvvjm7J2WVVbsRWz86VW/UVws2zp9cFfyH0FeKh0oOx03qbHVkCLolL1IiUfUn5iTyCqZos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707277029; c=relaxed/simple;
	bh=wozcyVvHzNR5E7VXBY2YzZhSgKWE1j9Dee975ulTgvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2uXN3NzUXocGZSDPNmU3Y8jhhI1uPfY0vHs73HjYQ+KP3Ch7SGgsdgTtfJDGEf3WtLSdfnJxYIwbj6IXtBSSiUYG6utycizaOxqa8RVV/X1EpZxBh+s66d1u70xuQUEyGCjDE/pa5Xo/9Tb6HFLydUXriEEmSeQFMV96LeBpsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXh5Pyp7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33b409fc4aeso135580f8f.1;
        Tue, 06 Feb 2024 19:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707277026; x=1707881826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K0oMvXuXT/Bmvr7nKfz+tfHKE7zRujYl4odDXMOJ8fY=;
        b=mXh5Pyp7dEVConkKN4fi+USUDQLNbA8E3PRXVsdkVH+VlGWQ9cDVwMM/F/tUebanw0
         hU+6qSFcirzmTIG4wuvktwK+0Y9yyZGPlRK0WYCXlAAtU0RK+w36G+B/3WqC0GcP5LmU
         t5TWwHydoA3PzcxEZs/4ayTLHQZphbo+bxiKSfk+gCm9RkhoQYu3Fb7iR7XaEL1DHb5P
         5y0dF+GQT4rJWx4C/NiYezarF7b1f2DZM4MAPC5CQAX8rQEbGUO3TIAP9XOs8T1QbFu+
         o4Acd/EzXZUDC7NWxmFwseu0l6BS/kopijSFMRUuOrS9/10tBDmnwZO0k+5VCc75MrrG
         GkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707277026; x=1707881826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0oMvXuXT/Bmvr7nKfz+tfHKE7zRujYl4odDXMOJ8fY=;
        b=BoD1pTmpgSs4E2gm4dwrHhcOJw0cQdwznsEh5DZCHWnqeeWRf4fQ1Im5joQKRAczOp
         wrKclLvIoHCyNWKzHX2iX/clszBuOJVh1U8+I/vMcvijF5w8fbbh/Qfkxoo6J7j8Pus2
         yDkfLs9NSLwfDbmc2yzOPmh7xc37sC/3Urb1Ogl/i6R20K/boLNfQud4DKlSn1DKxmuf
         rxsQ2BUz/hfJO7NPmAECBtZCq1+J8q1U0/DeIcdVUPibfMIAcuFRclxmjllevBo9JWOk
         UvUP7D3sgMZCkG+EIkxmnP8ROOetFmpVRJSS83L7Q40M7KyY0feqeH9jy8wPzEq9Yj0O
         ShLw==
X-Gm-Message-State: AOJu0YyJPn828ADuaKoqfHQQUkADdNd/r7KppuYzuH63Ri3EYFBAogpU
	I3UXmSZMyby/u2oHSYLrRtuVueSL2Ooc4JWKXO9aC2YDwY2YXHDN
X-Google-Smtp-Source: AGHT+IEC6OTMVKiiwXaTRW+EcaHTMMylrzmtal242jiHjAS9EFELdo3ZaRubLUREoBU4Ip5csdvfzQ==
X-Received: by 2002:a5d:460b:0:b0:33b:4ebd:1462 with SMTP id t11-20020a5d460b000000b0033b4ebd1462mr147974wrq.40.1707277025582;
        Tue, 06 Feb 2024 19:37:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYQrgi4CPyFz0nIMqpFUYqmQ082XxzQPgdfQbNOWxnfpu2DyM35zyk5XvEXPVI7qgJHj5uTzqJXPfZb966sodUZNbN0qKR/TXaZWDo8iCVzhirdvZ8X/wBjb5lO2E7osceGmA5NLQkcKcB7TsBxpfaHIVq2r0uH370BoNdGhINB5iYE33oVtY+t8f3Zl9EwMPsmMG+Lp39x9FPp6mqIQm2Awq8dTtTfzlHrCxg26sN/M6W2KGib8vhsy2DzJp2R1xrmB0IBYs1f2kc
Received: from demon-pc.localdomain ([188.24.52.65])
        by smtp.gmail.com with ESMTPSA id p5-20020a5d4e05000000b0033b422356fbsm373447wrt.80.2024.02.06.19.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 19:37:05 -0800 (PST)
From: Cosmin Tanislav <demonsingur@gmail.com>
To: 
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <demonsingur@gmail.com>
Subject: [PATCH 1/2] iio: accel: adxl367: fix DEVID read after reset
Date: Wed,  7 Feb 2024 05:36:50 +0200
Message-ID: <20240207033657.206171-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

regmap_read_poll_timeout() will not sleep before reading,
causing the first read to return -ENXIO on I2C, since the
chip does not respond to it while it is being reset.

The datasheet specifies that a soft reset operation has a
latency of 7.5ms.

Add a 15ms sleep between reset and reading the DEVID register,
and switch to a simple regmap_read() call.

Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
---
 drivers/iio/accel/adxl367.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 834ee6d63947..210228affb80 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -1368,9 +1368,11 @@ static int adxl367_verify_devid(struct adxl367_state *st)
 	unsigned int val;
 	int ret;
 
-	ret = regmap_read_poll_timeout(st->regmap, ADXL367_REG_DEVID, val,
-				       val == ADXL367_DEVID_AD, 1000, 10000);
+	ret = regmap_read(st->regmap, ADXL367_REG_DEVID, &val);
 	if (ret)
+		return dev_err_probe(st->dev, ret, "Failed to read dev id\n");
+
+	if (val != ADXL367_DEVID_AD)
 		return dev_err_probe(st->dev, -ENODEV,
 				     "Invalid dev id 0x%02X, expected 0x%02X\n",
 				     val, ADXL367_DEVID_AD);
@@ -1449,6 +1451,8 @@ int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
 	if (ret)
 		return ret;
 
+	fsleep(15000);
+
 	ret = adxl367_verify_devid(st);
 	if (ret)
 		return ret;
-- 
2.43.0


