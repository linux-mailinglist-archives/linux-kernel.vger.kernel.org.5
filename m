Return-Path: <linux-kernel+bounces-167849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DC88BB037
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253761F2315D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA871552E4;
	Fri,  3 May 2024 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBE/r6+H"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F12155396;
	Fri,  3 May 2024 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714751016; cv=none; b=NCRAOxSLTuHeNxnlHbZLELXaUpxi1lUDAr3JVD3oWhzK7wHBj7dvDBnJT/o8DZtKRJePdkxCqVW/5Yrcd9I1+nrD3BcxJ4N9ftEgE7cOTN1EzaNbZ37wWto085n8icDJv/KdBAQM4B4FxL6suMgQzM4trdS4BY+MyIJ+FDuvZ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714751016; c=relaxed/simple;
	bh=PEVfHsKVqJrLVORbYjTTPtbni+Sdp7MMEgl+6WLrZKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gtJzxuigRL/fbOFga07S0y8fpsYYy3skRDpbS2DqOf9tozOxHCFrtI/A1k4w2g55b9t3i21rqKCcbQM/LwEeoQIjoIS1q1rFv5ewDRK6TFNobWQnqOR0nOcoe8WkfG1OHSl0Lg5xKXUVYJnjlmbW/XxH9zRJAz1MeAB/lSz0G5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBE/r6+H; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f44881ad9eso1048859b3a.3;
        Fri, 03 May 2024 08:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714751013; x=1715355813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x46qWktsx1gk+X3hwmzwMx96hZmNS+C0rkh5a42172w=;
        b=IBE/r6+HTvGpOfC8XKYnuiyw7lehGzyvPCOhmMTY6ImLBXaHy4a+6wcgG1E+GXqq1c
         eHrBXSgBsW2KFLktY+PZAGJsyUE47ghuv2hHf7vkzx4VfYjNg9b6H9ljmITR/3Fd5tS3
         403Amxu2A3yAcMi5lAGJwuRCMHYDgnwEZW0oRoF0UNLYX8748Agb3KCv4D08VPJZg5tY
         lI4SKW/Wbvc76YHb+drviGlxhi7w7MMZ0ta0TfHdn+5nOWFknxPH4WsTS3/ITRKBPR8e
         +gTgPdEl8FR5tbjKGcj/isy5f02M2g4vD0fKQpDMrp1uow4ZeJZ/Fm3X2+P5YXncTVOO
         43Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714751013; x=1715355813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x46qWktsx1gk+X3hwmzwMx96hZmNS+C0rkh5a42172w=;
        b=pvoTeHSuRO1rZGl9jxzNBTBPZXhe+YFZ79tdGreSCGlsxD7ptDFfg7VuQarwpedOMJ
         yctcxxBZe1vOFDrLAb/5+nbRxMGgZntoiktGf8vq5cz6XXdJfuBhltQM0I+XxmbVHqL9
         v2GsQW+ysRq9xVhzKYkGcY5UdYBNnkhh7byPpF1CBAL6l7m5l802gpOiXiaFkZiG3UQU
         nbd2DAVA2Ir1OJr6PUZkQQHDXIVOEXEtVLyMMAZQJz/N7Brgl2RnZOn4wJjf71EyVEy6
         0xbf5o5fsc3Gh2yR5j7ZX73ZsWXJIFMP1NpFHuaWsEmR1WR1UNrpMDaEp+1+Dp2s4Zu6
         c/+Q==
X-Gm-Message-State: AOJu0YyQUhU2so83+pl8wRJVOh4rxSBiVAqDERw4DYxKzbVr7efDh0T+
	Jt4ZYDjurxTNWQepOAfi5cN997syRpARKretKzF0ojKvJYhWVXty64xwZw==
X-Google-Smtp-Source: AGHT+IEpxISKvKRmXyHHr0VzGaiUEkLF/5sG5HPzkwdZhXLVZYHtgzUUJ0eZifiHOzqoqZ5ocsEInw==
X-Received: by 2002:a05:6a20:8424:b0:1a7:a3cb:7901 with SMTP id c36-20020a056a20842400b001a7a3cb7901mr3574088pzd.61.1714751012649;
        Fri, 03 May 2024 08:43:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m22-20020a056a00081600b006f2e10b00d6sm3199995pfk.41.2024.05.03.08.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 08:43:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Lars Petter Mostad <lars.petter.mostad@appear.net>
Subject: [PATCH v2 3/3] hwmon: (emc1403) Add support for conversion interval configuration
Date: Fri,  3 May 2024 08:43:24 -0700
Message-Id: <20240503154324.517246-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503154324.517246-1-linux@roeck-us.net>
References: <20240503154324.517246-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The chips supported by the emc1403 driver support configurable
conversion rates. Add support for it.

Cc: Lars Petter Mostad <lars.petter.mostad@appear.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added patch

 drivers/hwmon/emc1403.c | 67 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index e53bb4d8bc1b..43322bb9aaa1 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -19,6 +19,7 @@
 #include <linux/sysfs.h>
 #include <linux/mutex.h>
 #include <linux/regmap.h>
+#include <linux/util_macros.h>
 
 #define THERMAL_PID_REG		0xfd
 #define THERMAL_SMSC_ID_REG	0xfe
@@ -333,6 +334,31 @@ static int emc1403_temp_read(struct thermal_data *data, u32 attr, int channel, l
 	return ret;
 }
 
+static int emc1403_get_convrate(struct thermal_data *data, long *val)
+{
+	unsigned int convrate;
+	int ret;
+
+	ret = regmap_read(data->regmap, 0x04, &convrate);
+	if (ret < 0)
+		return ret;
+	if (convrate > 10)
+		convrate = 4;
+
+	*val = 16000 >> convrate;
+	return 0;
+}
+
+static int emc1403_chip_read(struct thermal_data *data, u32 attr, long *val)
+{
+	switch (attr) {
+	case hwmon_chip_update_interval:
+		return emc1403_get_convrate(data, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int emc1403_read(struct device *dev, enum hwmon_sensor_types type,
 			u32 attr, int channel, long *val)
 {
@@ -341,6 +367,8 @@ static int emc1403_read(struct device *dev, enum hwmon_sensor_types type,
 	switch (type) {
 	case hwmon_temp:
 		return emc1403_temp_read(data, attr, channel, val);
+	case hwmon_chip:
+		return emc1403_chip_read(data, attr, val);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -409,6 +437,30 @@ static int emc1403_temp_write(struct thermal_data *data, u32 attr, int channel,
 	}
 }
 
+/* Lookup table for temperature conversion times in msec */
+static const u16 ina3221_conv_time[] = {
+	16000, 8000, 4000, 2000, 1000, 500, 250, 125, 62, 31, 16
+};
+
+static int emc1403_set_convrate(struct thermal_data *data, unsigned int interval)
+{
+	int convrate;
+
+	convrate = find_closest_descending(interval, ina3221_conv_time,
+					   ARRAY_SIZE(ina3221_conv_time));
+	return regmap_write(data->regmap, 0x04, convrate);
+}
+
+static int emc1403_chip_write(struct thermal_data *data, u32 attr, long val)
+{
+	switch (attr) {
+	case hwmon_chip_update_interval:
+		return emc1403_set_convrate(data, clamp_val(val, 0, 100000));
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int emc1403_write(struct device *dev, enum hwmon_sensor_types type,
 			 u32 attr, int channel, long val)
 {
@@ -417,6 +469,8 @@ static int emc1403_write(struct device *dev, enum hwmon_sensor_types type,
 	switch (type) {
 	case hwmon_temp:
 		return emc1403_temp_write(data, attr, channel, val);
+	case hwmon_chip:
+		return emc1403_chip_write(data, attr, val);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -453,18 +507,31 @@ static umode_t emc1403_temp_is_visible(const void *_data, u32 attr, int channel)
 	}
 }
 
+static umode_t emc1403_chip_is_visible(const void *_data, u32 attr)
+{
+	switch (attr) {
+	case hwmon_chip_update_interval:
+		return 0644;
+	default:
+		return 0;
+	}
+}
+
 static umode_t emc1403_is_visible(const void *data, enum hwmon_sensor_types type,
 				  u32 attr, int channel)
 {
 	switch (type) {
 	case hwmon_temp:
 		return emc1403_temp_is_visible(data, attr, channel);
+	case hwmon_chip:
+		return emc1403_chip_is_visible(data, attr);
 	default:
 		return 0;
 	}
 }
 
 static const struct hwmon_channel_info * const emc1403_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
 			   HWMON_T_CRIT | HWMON_T_MIN_HYST | HWMON_T_MAX_HYST |
-- 
2.39.2


