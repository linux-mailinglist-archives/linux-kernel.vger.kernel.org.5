Return-Path: <linux-kernel+bounces-160096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E06918B3910
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2A91C21BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD98148845;
	Fri, 26 Apr 2024 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0iGB8wx"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980EF148315;
	Fri, 26 Apr 2024 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139631; cv=none; b=VS4S5IgxNLDeb/brDJWTwiC+GfltOVZguW2CSWsOtJ6/OpUiJXmDlPnKS/a6yvpn9HZzpkOSlvqWKPRpQIEx1claGIoUmvr21Pq116vzhKlpVmCWotjOvPyE5q5nCxsoxxOiKg9H9h/wPFS3qjJcguWJR3tjzPfdwnf62MEOZv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139631; c=relaxed/simple;
	bh=1QGay2Hfl/jmLzw9AMlc080b/HzXD5PzQDCQZR5eI9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OpRVBvjRPnbSQ07mEGcwjASCdqVhInPABOmwTZ/P9HQ9m+DXTjzNX8OSoBoR97W8fh0PFrL7fHtfcqLP2E0WZY65XwncPcMhMoB7/juMmvJCLH6epZJHPoKLABFktvytXF5lnFK61qll5+8/boTov3Xo5MvdNumJ3Ic4YqogY7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0iGB8wx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41b9dff6be8so2908585e9.3;
        Fri, 26 Apr 2024 06:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714139628; x=1714744428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNj7uanEHO11oDZAHjwfACtzLhB1XMhzYg/IGylKoL4=;
        b=i0iGB8wxATsCokO+JpuYwp2ixFnQT82eCZyrRwPufWW0tyWp6h2RBGi7yr6ZouCQKt
         u2c4X+HVKjypV8YVzXByAHrha3U/BKkT8tiJwNnFiX2CYPjMsnIYAdsLnS9F3VzjZiYr
         BoUdr/1a1GurXuJpRvAG40Fik1VC2vN6YDxpUEBP6h2RKJ9ilA96Hj0KmfEazIi4Ytzw
         972lFgzPTR4AZICNzUNIgc5//LG5huHf4cEqE26RDyf0nbeOR/qD/EOENvhvOZecxGQb
         w1bY1xGWLMIX+Ifo2zRvtnOFxfracfZ8LaG7L021xiFpTt+ZZ1+RvmXs5PZoiMlHpmxn
         5+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714139628; x=1714744428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNj7uanEHO11oDZAHjwfACtzLhB1XMhzYg/IGylKoL4=;
        b=kYxaa6vb7zw+h9eip6Lwuk7APcZU9W63sWK+z+PybitJdPdoCYXHkFD1gOqwlzh9AU
         yeljG46vuLMWLN8waYsi/TXpU4kbnY3pIR0F3N37Bpr1nMMEwYEh2mY++5LPEmwQfB/e
         g3dWAFQfgXSWjJpHS+4ixGEtQ3RDM4DMDXWiZWbT3uuQcGA0bVYU4JUqo21F0R6pjPJq
         JHU4/sHXI4/tbNGzIRjxwBTpsv4qQmyxGu3PvJ/qidlHP9pk16VSFQBo3/BlwAz5Ad81
         KTXWrnhKVIfBXC5G5wUqyibx+/fr7vk54smBvjLvJlXneyT4vjUpwZnPFUKy9TEUj6Ys
         X2/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUg/LAS198Q9iOoITCmdarRMfZ/QiiN/nXwTBaFOHF8d+X40t2YiQ8VJu0gFHFNVsuM562dqA1E7bT/dLDjUqfD9tmDcbf7IjK03ygxIP5bQ05LI+w/NRQx6Wes46GeSpQFfzauXQ==
X-Gm-Message-State: AOJu0Yx3RI+ZyNKtEN8DcZNhBqZXm7eEuYvm6juZnNER5bQIDufovKXw
	Coj4jR+0uKprAQAdKsgx6/zx4PO+TeTGqtk1ZzKNnBOeUaGqOp8pbmlOQY6E
X-Google-Smtp-Source: AGHT+IHpsfxWro17MY42FzMYbH+MNJFNyyR2QQv3DjBIFhw14wIz1XHnyUsFQX07TDEAjCa3naQVDw==
X-Received: by 2002:a05:600c:4587:b0:418:4851:a08a with SMTP id r7-20020a05600c458700b004184851a08amr2229989wmo.37.1714139627792;
        Fri, 26 Apr 2024 06:53:47 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:320d:e800:f4f8:b5e1:d7d4:bf65])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d6d46000000b003434f526cb5sm22302919wri.95.2024.04.26.06.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:53:47 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	nuno.sa@analog.com
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: [PATCH 2/7] drivers: iio: imu: Add support for ADIS16501
Date: Fri, 26 Apr 2024 16:53:34 +0300
Message-Id: <20240426135339.185602-3-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426135339.185602-1-ramona.bolboaca13@gmail.com>
References: <20240426135339.185602-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for ADIS16501 device in already existing ADIS16475
driver.

Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
 drivers/iio/imu/Kconfig     |  4 ++--
 drivers/iio/imu/adis16475.c | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index 52a155ff3250..782fb80e44c2 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -36,8 +36,8 @@ config ADIS16475
 	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
 	help
 	  Say yes here to build support for Analog Devices ADIS16470, ADIS16475,
-	  ADIS16477, ADIS16465, ADIS16467, ADIS16500, ADIS16505, ADIS16507 inertial
-	  sensors.
+	  ADIS16477, ADIS16465, ADIS16467, ADIS16500, ADIS16501, ADIS16505,
+	  ADIS16507 inertial sensors.
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called adis16475.
diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 01f55cc902fa..7fab40daa659 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -661,6 +661,7 @@ enum adis16475_variant {
 	ADIS16467_2,
 	ADIS16467_3,
 	ADIS16500,
+	ADIS16501,
 	ADIS16505_1,
 	ADIS16505_2,
 	ADIS16505_3,
@@ -980,6 +981,25 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16500, &adis1650x_timeouts),
 	},
+	[ADIS16501] = {
+		.name = "adis16501",
+		.num_channels = ARRAY_SIZE(adis16477_channels),
+		.channels = adis16477_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(40 << 16),
+		.accel_max_val = 1,
+		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
+		.temp_scale = 100,
+		.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+		.deltvel_max_val = 125,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		/* pulse sync not supported */
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
+		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
+		.adis_data = ADIS16475_DATA(16501, &adis1650x_timeouts),
+	},
 	[ADIS16505_1] = {
 		.name = "adis16505-1",
 		.num_channels = ARRAY_SIZE(adis16477_channels),
@@ -1482,6 +1502,8 @@ static const struct of_device_id adis16475_of_match[] = {
 		.data = &adis16475_chip_info[ADIS16467_3] },
 	{ .compatible = "adi,adis16500",
 		.data = &adis16475_chip_info[ADIS16500] },
+	{ .compatible = "adi,adis16501",
+		.data = &adis16475_chip_info[ADIS16501] },
 	{ .compatible = "adi,adis16505-1",
 		.data = &adis16475_chip_info[ADIS16505_1] },
 	{ .compatible = "adi,adis16505-2",
-- 
2.34.1


