Return-Path: <linux-kernel+bounces-162870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A118B6187
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3776C1C217DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFC713C3E0;
	Mon, 29 Apr 2024 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuSF7+R5"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEB113B5BB;
	Mon, 29 Apr 2024 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417264; cv=none; b=Jlh5c8DZcjiRz1ql7v/ibQKx+Avyzi5hDIeJfx40dtsbF3ZTLI21NaCzqreKJisyVStJJ3S1J0AkyDN/HDLes6Q7Mi8XwpuqY9RsI5zZRxyE3K9uhrFSD8bMM7ixqqf4VHKyqiqLI6+uxjkWAcN30CmI2QWkDW2yHNQ8DcI+5v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417264; c=relaxed/simple;
	bh=n7ZnkHS6L2EjKJdsc7qHUDXg5Zssd+Z6n1RohBzL08Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y8LYtyqs0O71dO855EB3FGk62XEFPcEsgxFnTcHQIhBeT95gd2NE//PNHSlh2mmQ9fwyNpNhxaSeWJxJxmBRTFNnR7WyinrUHHBKHds8ka1pPUc/uYUnTHJoMWB1C3zcrlOOyQNx4xdsu7sh6bqgzHoeU41DD4HQmGNXeuHMqj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuSF7+R5; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5194cebd6caso5515285e87.0;
        Mon, 29 Apr 2024 12:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714417261; x=1715022061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d03SxwYQEgO9ihhxcMsHW4m7sHTd0aWe30L6xyAn2MA=;
        b=ZuSF7+R5Hc+0sCmIOaWVQZ6Z9d9H8zdo0Uv9anwSHINWAibAujQ7QGOcuzOzqJLvci
         KrGdzVRE6/k5QFl+o8DE0zfxqYhf7V0isFRfC22Cw1a5tNNKa7ca5AymawEMZJpCzERj
         1Rc7A7/OodxfiqImeCiz9+uz51BqCItIbY3S3N4l8JfDgwvUh7Ol3V38VfcsMOEKl0+Q
         cp/Aw8CbiI2D53Ei+9qsNNsOx4237vyiJYsHLEFHIv8V9IKCwur+aaIQ8k38B2OWSQYa
         IRHfHvfmCucwaxVoC9hP2SdgTK8R9KRKw81zipf6FYW1ZV2led646N/0NXjRGPCWkisC
         e6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417261; x=1715022061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d03SxwYQEgO9ihhxcMsHW4m7sHTd0aWe30L6xyAn2MA=;
        b=VN7Sd2c9Qfh9UCKnFtAkYtXtL0H6GJbutuKIY46jSysmf0UvNIiSJIJpqZ+lvdgg0f
         uN1SsouTRf5JDFvozbZVxMZSKtXrWcdgMWc5R+ySu751Y/owX1Ylc+EmPS0+IziCuYcW
         Crdi+d6GYLAi6AVVQ12hlAACMZLGFpXc6nlGnnt1r+JEqQZOOGQGuN80QOoTpR6cpIav
         6RMIi3mh3D120HHKy6mWuZ/M+qeU16ZewIOVBfXZUXsP6KO/CyAQY4nvAic62Ep5EcHC
         izNpQgUBQO+hczd48fKrUCwnFRxVjs+rkiY/wuu/ao5G/FVHbnlBRbrmjOSO6CddeyST
         najQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPlP5Wu2EfsVsiWckEu/QVE7rmDeeSdv/m0uE6bubbaZQJMwAdXk0+aLklojHYb2d091Nf9+zoPqWP85rtdtfkLtUWZix6vANvTnFN0rp0uRAwM++A1xIMSrAxt1eLlz0BcxdIbX5M
X-Gm-Message-State: AOJu0YxkmFGXctxRjZmJOVqUYVQbBcVnNtAwIHhZIjtK8KPjCjVZqqfJ
	crL6rNmz+EVoy0VzGmxFdsyVH2PbWvipMQDjb7cBGv1k6e3O5g49
X-Google-Smtp-Source: AGHT+IHcEWUGYUu+eGd8rvmoytYJkD9N9qMYjCvgbDtw8yPFkdfJGBJp8RjNto3w/S9EmSXgROm/vw==
X-Received: by 2002:ac2:59c1:0:b0:51a:f2fb:b13c with SMTP id x1-20020ac259c1000000b0051af2fbb13cmr6071080lfn.11.1714417260730;
        Mon, 29 Apr 2024 12:01:00 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:abbf:c98a:cf84:d14c])
        by smtp.gmail.com with ESMTPSA id x2-20020adfdd82000000b0034c78bba70bsm8469456wrl.72.2024.04.29.12.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:01:00 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	petre.rodan@subdimension.ro,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v5 04/10] iio: pressure: bmp280: Add more intuitive name for bmp180_measure()
Date: Mon, 29 Apr 2024 21:00:40 +0200
Message-Id: <20240429190046.24252-5-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240429190046.24252-1-vassilisamir@gmail.com>
References: <20240429190046.24252-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bmp180_measure() function essentially waits for the end of the
current conversion in order to read the values from the sensors. The
name bmp180_measure() could be misinterpreted because it could be
translated as "measure sensor values" even though it was probably
trying to say "measure time for eoc". Give a more intuitive name
to this function to be less confusing.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index edfa66953f87..ed49e0779d41 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1771,7 +1771,7 @@ const struct bmp280_chip_info bmp580_chip_info = {
 };
 EXPORT_SYMBOL_NS(bmp580_chip_info, IIO_BMP280);
 
-static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
+static int bmp180_wait_for_eoc(struct bmp280_data *data, u8 ctrl_meas)
 {
 	const int conversion_time_max[] = { 4500, 7500, 13500, 25500 };
 	unsigned int delay_us;
@@ -1820,9 +1820,9 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
 {
 	int ret;
 
-	ret = bmp180_measure(data,
-			     FIELD_PREP(BMP180_MEAS_CTRL_MASK, BMP180_MEAS_TEMP) |
-			     BMP180_MEAS_SCO);
+	ret = bmp180_wait_for_eoc(data,
+				  FIELD_PREP(BMP180_MEAS_CTRL_MASK, BMP180_MEAS_TEMP) |
+				  BMP180_MEAS_SCO);
 	if (ret)
 		return ret;
 
@@ -1920,10 +1920,10 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
 	u8 oss = data->oversampling_press;
 	int ret;
 
-	ret = bmp180_measure(data,
-			     FIELD_PREP(BMP180_MEAS_CTRL_MASK, BMP180_MEAS_PRESS) |
-			     FIELD_PREP(BMP180_OSRS_PRESS_MASK, oss) |
-			     BMP180_MEAS_SCO);
+	ret = bmp180_wait_for_eoc(data,
+				  FIELD_PREP(BMP180_MEAS_CTRL_MASK, BMP180_MEAS_PRESS) |
+				  FIELD_PREP(BMP180_OSRS_PRESS_MASK, oss) |
+				  BMP180_MEAS_SCO);
 	if (ret)
 		return ret;
 
-- 
2.25.1


