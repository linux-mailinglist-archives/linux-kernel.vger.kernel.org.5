Return-Path: <linux-kernel+bounces-60508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF8E8505D8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5625285B67
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D015D725;
	Sat, 10 Feb 2024 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRRs7VbZ"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183AE14010;
	Sat, 10 Feb 2024 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707587976; cv=none; b=ebgWcb1pfgnM2xrk7KS0C/PyJpGzwO49XmCvfoNUgNHmpU4hPAAUkcl3AbA//MOV1ZfNZA/QzOT+R5NFSvFODdDqSS0tma6oHhm8trG89zPkSwQJX9Z7SlyiLM844aFe/l7zt15bqSJAhFtZ4CwNcuTsI4Ldy0g0XwvsHL/VjVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707587976; c=relaxed/simple;
	bh=ofvYy2DHhC0W7iu8njA+VnVzd7UnOeA0ZueES5hgPgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j1dIteN13uIGHLhG/4mS7omfepem3ps56yj+96/756diUlk5g7ZX77BWb0ITs1y/yZoM+sjQYg9pDUXdsyiVpVo8vfvpbHfoGk9l9Nj5Xaro94VsuZp2Fu5K348rE+hFcciThxDvDewyIXfXxNZp25TJRdwA332OWmUKM+n9350=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRRs7VbZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so1278738f8f.0;
        Sat, 10 Feb 2024 09:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707587973; x=1708192773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4LbC+Fjw1FiZVBj473YjAqVsX4xPnBElsTDNcgK7XY=;
        b=bRRs7VbZw3dFCWHoY751wmKNBj23EI42RzkpZn7Frb99yROnPAbwwdIHNX3uUmygul
         tsqkDP7iqSNhKOX0jqaeyZ8mCCVYADBWHKwRnCOKl0zCHdnlVBZmmMOxtCe58mIatKXs
         RKeHhEZgGIFZIUBstJeSYH/61h3VwePVJDiMCZ4m3N/XwXFYQLI/tioOv7+qUsg5sfsB
         WYsvLYEYDb9ODOui8Dia9EEbVsAON3pud4a9qI1iGVWwWf43nuBfFUOQG/pGVUMlMW8O
         FKm60XMzJAABtoYSE1jfAGQUfQ1cKawK59j2swPkvIcQF6XwsOevSRGJ+hxM6zUqeyPf
         eKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707587973; x=1708192773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4LbC+Fjw1FiZVBj473YjAqVsX4xPnBElsTDNcgK7XY=;
        b=aZk7mNn0D/48YWiAhndIGW+OXeZG0R+C9Pa1H074FZLBWJhutBQJBEmG9Ilmzc752u
         3MUC+NWgh0hFZZZOhQb4SMYcAwNBIlML+yGPpglBEgI5aftfhpXDfH5jP6qWAl2plNT6
         jjNCOhz8zYf0fGhDxC5KH0J2mZd9sw8b9uv1A7z7y+JBjBwVwup5jQjAwHIdAFcD0eoL
         C4su7NuH5Y2nSgJWNmyqa1i447RSpvi2JMRLdwiX+AqBH1EYw3dLkXDbHGan5mXdap50
         CZWhEnM1BMm030jLVz0TqsOAfM7ScTzXVy1bGei3p81HpyVRUkBVy76LPepEiJfhAzh1
         7FjA==
X-Forwarded-Encrypted: i=1; AJvYcCW6DwUwxu1KSmlycV/LzNG/wY4bj82SYUtNdJBBv5CEpM88X72b0/wKQcKH9xtsVIVfrfbadXILkYMzCepRz8kKvnB2y6GL1EUzzrZD
X-Gm-Message-State: AOJu0Yx3ybum7MAniyJxz18Q7gOrfl541d/77lgO/HUgroYF6+NnTcqJ
	zCqPFTYJ1+3LhjHfZ43bnSGYP2C0LQQ4JelVbyk4G73Vcib+6gqW
X-Google-Smtp-Source: AGHT+IHKG3ngVvh5+jlIe7KX0NSPfgtD3nwMRRrwhdxDEmOY0VnDdE3JKdsk6in3HEyciSKYsvopdw==
X-Received: by 2002:a5d:5484:0:b0:33b:6585:9ab7 with SMTP id h4-20020a5d5484000000b0033b65859ab7mr1728428wrv.46.1707587973159;
        Sat, 10 Feb 2024 09:59:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWL5kSwQnXePP0J41cu4mwdqXEHw3dVzk3sXBGJHKkokOawu1XZGgMeUtMU6mqgSUd7tvQNQ/pHUCpZQJDGkIAUn4MXXXv2pFrFfpl+53kDhJFUAsZEEQz9bhx9FitABC/HOs0n99XC0vl21hXumks5xogYJ+VEwtcLoeRa2/y2gyAIkxe1FL1oMOqRH7YyRWZD
Received: from xeon.. ([188.163.112.73])
        by smtp.gmail.com with ESMTPSA id y1-20020adffa41000000b0033b67f6ec80sm2379920wrr.80.2024.02.10.09.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 09:59:32 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] thermal: thermal-generic-adc: add temperature sensor function
Date: Sat, 10 Feb 2024 19:59:22 +0200
Message-Id: <20240210175922.137704-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240210175922.137704-1-clamor95@gmail.com>
References: <20240210175922.137704-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Existing thermal-generic-adc states to be an adc-based thermal
sensor, which is not entirely true. It provides a thermal sensor
cell, but it does not provide an IIO sensor cell, which would
benefit devices that use adc sensors to detect temperature and
need a custom calibration table.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/thermal/thermal-generic-adc.c | 57 ++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 1717e4a19dcb..7e87d928512c 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -7,6 +7,7 @@
  * Author: Laxman Dewangan <ldewangan@nvidia.com>
  */
 #include <linux/iio/consumer.h>
+#include <linux/iio/iio.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -73,6 +74,60 @@ static const struct thermal_zone_device_ops gadc_thermal_ops = {
 	.get_temp = gadc_thermal_get_temp,
 };
 
+static const struct iio_chan_spec gadc_thermal_iio_channel[] = {
+	{
+		.datasheet_name = "temp",
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.indexed = 1,
+		.channel = 0,
+	}
+};
+
+static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int *temp, int *val2, long mask)
+{
+	struct gadc_thermal_info *gtinfo = iio_priv(indio_dev);
+	int ret;
+
+	if (mask != IIO_CHAN_INFO_RAW)
+		return -EINVAL;
+
+	ret = gadc_thermal_get_temp(gtinfo->tz_dev, temp);
+	if (ret < 0)
+		return ret;
+
+	*temp /= 1000;
+
+	return IIO_VAL_INT;
+}
+
+static const struct iio_info gadc_thermal_iio_info = {
+	.read_raw = gadc_thermal_read_raw,
+};
+
+static int gadc_iio_register(struct device *dev, struct gadc_thermal_info *gti)
+{
+	struct gadc_thermal_info *gtinfo;
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct gadc_thermal_info));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	gtinfo = iio_priv(indio_dev);
+	memcpy(gtinfo, gti, sizeof(struct gadc_thermal_info));
+
+	indio_dev->name = dev_name(dev);
+	indio_dev->info = &gadc_thermal_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = gadc_thermal_iio_channel;
+	indio_dev->num_channels = ARRAY_SIZE(gadc_thermal_iio_channel);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
 static int gadc_thermal_read_linear_lookup_table(struct device *dev,
 						 struct gadc_thermal_info *gti)
 {
@@ -156,7 +211,7 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 
 	devm_thermal_add_hwmon_sysfs(&pdev->dev, gti->tz_dev);
 
-	return 0;
+	return gadc_iio_register(&pdev->dev, gti);
 }
 
 static const struct of_device_id of_adc_thermal_match[] = {
-- 
2.40.1


