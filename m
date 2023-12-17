Return-Path: <linux-kernel+bounces-2619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7F1815F87
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9FB1F21B21
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90F944395;
	Sun, 17 Dec 2023 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYUtrDzZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5C844381;
	Sun, 17 Dec 2023 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c3ca9472dso25426025e9.2;
        Sun, 17 Dec 2023 05:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702821239; x=1703426039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7l6SuuWclfbVcOTuZs6JSfev7h3TS/9oDDExwi6b7pM=;
        b=AYUtrDzZEXPnvmD1WORjxddC3/6IIbhf+QCOHpEQE5QnGh/qU1rHwfsHu7LvJMDVm0
         ihfvMOAf5TkxiQR8mX78VOeb9T+lxUpMFWQ0Bpo1Ll8P2b61+u25cKGE3vKuEowKmttd
         V5KPfu9TC7+p81lnZLGaPHbbnOz0k5l8PgR+Bq2xf57bEFaBc2lEEb4DCN1BETxeTHJ3
         7l6DFdK+0+2T02ntfFPTlBmEwA/ya5w7FBZtl97NLEQ9EKs5aeBuXt0wTvIBfUekbtXZ
         jyLHm05g0OOw6kDQ2c9hsS9QY3ZB8HIoZYlONbyYuPh9wHqTcCXXvNxjiFNbm+KNl9zn
         A7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702821239; x=1703426039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7l6SuuWclfbVcOTuZs6JSfev7h3TS/9oDDExwi6b7pM=;
        b=Vg4WpMWuds3vXj/5mtSBcOe/651HhKHi0JIxxUeKYB5ysectVSDCTWC87SiwvV/0rB
         MgYV5IwI6/DyZdWn20UFJZMCZm/ugu5AQY0T/L2ib9u3KBYEXOEXsUFpcutkahS4oTAt
         dL6hnGq4caIQRoSt8TCtJ9KokNIlITEAAy/J+K8nUx6kYvSVUPbCxUycdZPa8b0TOBzi
         TDEHZRjoq/VhUslW+osf5luNvDXr6LDNXVXwggjDEgKKO27ImNJyLnAyF4wvakRjeHQU
         z1ZgEwR726KVU2vEchcek0c+7ryuY2AkrjUqVrtovpeRWxVzilMuVua0xn1UYqBIJ+qd
         V6AA==
X-Gm-Message-State: AOJu0YyA2UKG9mRer5HUO4CK4gXPpLWUWUQxjoIE7BhB5l7lSA/AQpVb
	Rv/FGdYqEN9ialhZUw9TTQ4=
X-Google-Smtp-Source: AGHT+IEW3JCvQI7Q3hwLZUTOI9M8yh3XX24F2pz+loq7Z2S4XB7vyZmMIT7P0YAlr69z8+T0dBsjDQ==
X-Received: by 2002:a05:600c:a45:b0:40d:1773:4c57 with SMTP id c5-20020a05600c0a4500b0040d17734c57mr264600wmq.195.1702821238481;
        Sun, 17 Dec 2023 05:53:58 -0800 (PST)
Received: from wpc.yadro.com (188-169-139-214.dsl.utg.ge. [188.169.139.214])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600c354900b003fee6e170f9sm37413770wmq.45.2023.12.17.05.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 05:53:58 -0800 (PST)
From: Maksim Kiselev <bigunclemax@gmail.com>
To: 
Cc: Maksim Kiselev <bigunclemax@gmail.com>,
	Martin Botka <martin.botka@somainline.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-pm@vger.kernel.org (open list:ALLWINNER THERMAL DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner sunXi SoC support),
	linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1] thermal: sun8i: extend H6 calibration function to support 4 sensors
Date: Sun, 17 Dec 2023 16:36:36 +0300
Message-Id: <20231217133637.54773-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The H616 SoC resembles the H6 thermal sensor controller, with a few
changes like four sensors.

Extend sun50i_h6_ths_calibrate() function to support calibration of
these sensors.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index f989b55a8aa8..9af95b4785be 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -221,16 +221,21 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
 	struct device *dev = tmdev->dev;
 	int i, ft_temp;
 
-	if (!caldata[0] || callen < 2 + 2 * tmdev->chip->sensor_num)
+	if (!caldata[0])
 		return -EINVAL;
 
 	/*
 	 * efuse layout:
 	 *
-	 *	0   11  16	 32
-	 *	+-------+-------+-------+
-	 *	|temp|  |sensor0|sensor1|
-	 *	+-------+-------+-------+
+	 * 0      11  16     27   32     43   48    57
+	 * +----------+-----------+-----------+-----------+
+	 * |  temp |  |sensor0|   |sensor1|   |sensor2|   |
+	 * +----------+-----------+-----------+-----------+
+	 *                      ^           ^           ^
+	 *                      |           |           |
+	 *                      |           |           sensor3[11:8]
+	 *                      |           sensor3[7:4]
+	 *                      sensor3[3:0]
 	 *
 	 * The calibration data on the H6 is the ambient temperature and
 	 * sensor values that are filled during the factory test stage.
@@ -243,9 +248,16 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
 	ft_temp = (caldata[0] & FT_TEMP_MASK) * 100;
 
 	for (i = 0; i < tmdev->chip->sensor_num; i++) {
-		int sensor_reg = caldata[i + 1] & TEMP_CALIB_MASK;
-		int cdata, offset;
-		int sensor_temp = tmdev->chip->calc_temp(tmdev, i, sensor_reg);
+		int sensor_reg, sensor_temp, cdata, offset;
+
+		if (i == 3)
+			sensor_reg = (caldata[1] >> 12)
+				     | ((caldata[2] >> 12) << 4)
+				     | ((caldata[3] >> 12) << 8);
+		else
+			sensor_reg = caldata[i + 1] & TEMP_CALIB_MASK;
+
+		sensor_temp = tmdev->chip->calc_temp(tmdev, i, sensor_reg);
 
 		/*
 		 * Calibration data is CALIBRATE_DEFAULT - (calculated
-- 
2.40.1


