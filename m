Return-Path: <linux-kernel+bounces-119760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2275888CCB5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7B02C7006
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6358713CAA8;
	Tue, 26 Mar 2024 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VomeyNdW"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F1E1C6B0;
	Tue, 26 Mar 2024 19:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480146; cv=none; b=ddyNAIAggfBQA7I8hN1Wi+hyz1GobDkyOjbVoDT0aDyzFCfPW2Sp37CC7q6QDD9DF5lVBIgWp0yuu/dooeEflx/wZj4wamUIjZLObGttfRpTaBzKWcTk/qE6WX23Fp5fHfw1jtfsUHIrI/YeMxcW+bekKQ9Q1EcxW+ie8nv6zoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480146; c=relaxed/simple;
	bh=afp00zbGBZ2wjlhDAfCsEbh3U5GY/V4UnG2hHb9bFAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=oFxFGzu/+XqzoT6jY0Y/UmECBkJWBOR2zaAMtEtrMVX3J1DrFlMShRC6eLBaJlckhvIMHs6O5wORuWR2tDI/c+yzjTcCbd3PMmjHm3vu8ieM2WKZOOHqJIyp9y3aU3BYihRpcgmqcRnDqVYG1JbQ4hMjZsy3bUNO5L6ceDUnQig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VomeyNdW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4149258d97aso870385e9.0;
        Tue, 26 Mar 2024 12:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711480142; x=1712084942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kKUeylA/kUbMi7mUkzdYqLZ2Z/k0fi706NnSX/cpFFk=;
        b=VomeyNdWaiNbGcrArxWOgJuRuj6Q1MrEclY0vEPH6t9tUs2IbYFDDyoqmjoTH4oNLP
         Gpi9qF3FaGCIppDNS09WjmCFGOUOgK3Zv21ta7gnGqjq9tybtNubT9lTO9Dd2qyntmhY
         7ZqmI8XZe2A9E5Qkeo4QOZCv81UoWhiesjGPh3z3oIz2FPOChqRxGWlOtRg5h1+JOalE
         YvPHIJzldwzoNT/QWKcJnpIltrqNrV+MPediuen5rUoY831g18gWLsfAA8xJeRkYRS+g
         wRYbLffHhwIjG3tvX8fwB5UsH5u4jv628XwWN0CxMzhh4569lBBEHG3/1FeHQq+34tdE
         GOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711480142; x=1712084942;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKUeylA/kUbMi7mUkzdYqLZ2Z/k0fi706NnSX/cpFFk=;
        b=AJCgN21go1aEj+VP91RlrQSSWZgDgSE6TCitj2+l+8Kvp/ixrV6y5OlVLGrqykv67D
         TAmLck8cTf8ettqi5Ln0GAiXOdnkA2HNjGD1ZtcJ0v8V0qtAIl9Qq5K9+t0cB7sfxvoB
         mLtEyYpxtE1gc6E+dTJ3sonRTeT2Cp7xtdJUnPORFC7q7zwkP2VS3GKd+82jYCoxcY6r
         PgecE4+i89ZwzEgWRUbp0skvxI3OTChklfJCgin40WU0xGBBL4BLN3AmEVLmZ4OAKFxK
         Hb2DgSmxukE3GfBsk+YjQMSZ/ipCqX9DqtLrlFdFQki5YHjR/7BFfGH/IHGzmElTH4ql
         dnwg==
X-Forwarded-Encrypted: i=1; AJvYcCXMzDRPzGSKCFJZ59dnU2tG46wExhFMd2lXrLBrgiQQWJ1jstYqIgjUzCelsyQS+CZg2Mrse44bAbcslp9Rh36hNarRydFl7hZH2JPj/RMGVA7XnVPa9oTjlPH0lZ09JGfIZOrhIPH9JftTOJhBNyYAjQ==
X-Gm-Message-State: AOJu0YzQnGSgBA8g+JTFlrnOK2o1Upxb8UlzxlmqvPvDzL5mwW6zsXd1
	zWCNWhsDGA28FROzGK2ASo5PlWaCIz3hmlHvjB1lgG6vFtNEc33j
X-Google-Smtp-Source: AGHT+IHqRarE98sM+c8DHb/b9d6+brqlQPQyxMZZYFm869VBn3RI4CtnZ8dlJWWFcZe3gqOFyF4uMg==
X-Received: by 2002:a05:600c:4e8e:b0:414:5e9b:804b with SMTP id f14-20020a05600c4e8e00b004145e9b804bmr2222400wmq.10.1711480142522;
        Tue, 26 Mar 2024 12:09:02 -0700 (PDT)
Received: from ?IPV6:2001:8a0:ed72:2800:4fbb:3beb:7045:e257? ([2001:8a0:ed72:2800:4fbb:3beb:7045:e257])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c139300b004147cfe50e2sm12411991wmf.2.2024.03.26.12.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 12:09:01 -0700 (PDT)
Message-ID: <998ee474-5e0c-4877-8a95-b22b0edd7837@gmail.com>
Date: Tue, 26 Mar 2024 19:09:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HP: wmi: added support for 4 zone keyboard rgb
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240324180549.148812-1-carlosmiguelferreira.2003@gmail.com>
 <980459bc-a781-1d2b-374c-da023d601c58@linux.intel.com>
Content-Language: en-US
Cc: hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
In-Reply-To: <980459bc-a781-1d2b-374c-da023d601c58@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, i have changed some of the code. How does it look now?

Signed-off-by: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
---
 drivers/platform/x86/hp/hp-wmi.c | 251 +++++++++++++++++++++++++++++--
 1 file changed, 241 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index e53660422..8108ca7e9 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -27,6 +27,7 @@
 #include <linux/rfkill.h>
 #include <linux/string.h>
 #include <linux/dmi.h>
+#include <linux/bitfield.h>
 
 MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
 MODULE_DESCRIPTION("HP laptop WMI hotkeys driver");
@@ -40,6 +41,10 @@ MODULE_ALIAS("wmi:5FB7F034-2C63-45e9-BE91-3D44E2C707E4");
 #define HP_OMEN_EC_THERMAL_PROFILE_OFFSET 0x95
 #define zero_if_sup(tmp) (zero_insize_support?0:sizeof(tmp)) // use when zero insize is required
 
+#define FOURZONE_LIGHTING_SUPPORTED_BIT 0x01
+#define FOURZONE_LIGHTING_ON  228
+#define FOURZONE_LIGHTING_OFF 100
+
 /* DMI board names of devices that should use the omen specific path for
  * thermal profiles.
  * This was obtained by taking a look in the windows omen command center
@@ -131,18 +136,36 @@ enum hp_wmi_commandtype {
 };
 
 enum hp_wmi_gm_commandtype {
-	HPWMI_FAN_SPEED_GET_QUERY = 0x11,
-	HPWMI_SET_PERFORMANCE_MODE = 0x1A,
-	HPWMI_FAN_SPEED_MAX_GET_QUERY = 0x26,
-	HPWMI_FAN_SPEED_MAX_SET_QUERY = 0x27,
-	HPWMI_GET_SYSTEM_DESIGN_DATA = 0x28,
+	HPWMI_FAN_SPEED_GET_QUERY	= 0x11,
+	HPWMI_SET_PERFORMANCE_MODE	= 0x1A,
+	HPWMI_FAN_SPEED_MAX_GET_QUERY	= 0x26,
+	HPWMI_FAN_SPEED_MAX_SET_QUERY	= 0x27,
+	HPWMI_GET_SYSTEM_DESIGN_DATA	= 0x28,
+	HPWMI_GET_KEYBOARD_TYPE		= 0x2B,
+};
+
+enum hp_wmi_fourzone_commandtype {
+	HPWMI_SUPPORTS_LIGHTNING = 0x01,
+	HPWMI_FOURZONE_COLOR_GET = 0x02,
+	HPWMI_FOURZONE_COLOR_SET = 0x03,
+	HPWMI_FOURZONE_MODE_GET  = 0x04,
+	HPWMI_FOURZONE_MODE_SET  = 0x05,
+};
+
+enum hp_wmi_keyboardtype {
+	HPWMI_KEYBOARD_INVALID        = 0x00,
+	HPWMI_KEYBOARD_NORMAL         = 0x01,
+	HPWMI_KEYBOARD_WITH_NUMPAD    = 0x02,
+	HPWMI_KEYBOARD_WITHOUT_NUMPAD = 0x03,
+	HPWMI_KEYBOARD_RGB	      = 0x04,
 };
 
 enum hp_wmi_command {
-	HPWMI_READ	= 0x01,
-	HPWMI_WRITE	= 0x02,
-	HPWMI_ODM	= 0x03,
-	HPWMI_GM	= 0x20008,
+	HPWMI_READ     = 0x01,
+	HPWMI_WRITE    = 0x02,
+	HPWMI_ODM      = 0x03,
+	HPWMI_GM       = 0x20008,
+	HPWMI_FOURZONE = 0x20009,
 };
 
 enum hp_wmi_hardware_mask {
@@ -652,6 +675,74 @@ static int hp_wmi_rfkill2_refresh(void)
 	return 0;
 }
 
+static int fourzone_get_colors(u32 *colors)
+{
+	int ret;
+	u8 buff[128];
+
+	ret = hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE,
+				   &buff, sizeof(buff), sizeof(buff));
+	if (ret != 0)
+		return -EINVAL;
+
+	for (int i = 0; i < 4; i++) {
+		colors[3 - i] = FIELD_PREP(GENMASK(23, 16), buff[25 + i * 3])	   // r
+			      |	FIELD_PREP(GENMASK(15, 8),  buff[25 + i * 3 + 1])  // g
+			      | FIELD_PREP(GENMASK(7, 0),   buff[25 + i * 3 + 2]); // b
+	}
+
+	return 0;
+}
+
+static int fourzone_set_colors(u32 *colors)
+{
+	int ret;
+	u8 buff[128];
+
+	ret = hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE,
+				   &buff, sizeof(buff), sizeof(buff));
+	if (ret != 0)
+		return -EINVAL;
+
+	for (int i = 0; i < 4; i++) {
+		buff[25 + i * 3]     = FIELD_GET(GENMASK(23, 16), colors[3 - i]); // r
+		buff[25 + i * 3 + 1] = FIELD_GET(GENMASK(15, 8),  colors[3 - i]); // g
+		buff[25 + i * 3 + 2] = FIELD_GET(GENMASK(7, 0),	  colors[3 - i]); // b
+	}
+
+	return hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_SET, HPWMI_FOURZONE,
+				    &buff, sizeof(buff), sizeof(buff));
+}
+
+/*
+ * Returns a negative number on error or 0/1 for the mode.
+ */
+static int fourzone_get_mode(void)
+{
+	int ret;
+	u8 buff[4];
+
+	ret = hp_wmi_perform_query(HPWMI_FOURZONE_MODE_GET, HPWMI_FOURZONE,
+				   &buff, sizeof(buff), sizeof(buff));
+	if (ret != 0)
+		return ret;
+
+	return buff[0] == FOURZONE_LIGHTING_ON ? 1 : 0;
+}
+
+/*
+ * This device supports only two different modes:
+ * 1 -> lights on
+ * 0 -> lights off
+ */
+static int fourzone_set_mode(u32 mode)
+{
+	u8 buff[4] = {mode ? FOURZONE_LIGHTING_ON : FOURZONE_LIGHTING_OFF, 0, 0, 0};
+
+	return hp_wmi_perform_query(HPWMI_FOURZONE_MODE_SET, HPWMI_FOURZONE,
+				    &buff, sizeof(buff), 0);
+}
+
 static ssize_t display_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
@@ -754,6 +845,58 @@ static ssize_t postcode_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
+static ssize_t colors_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	int ret;
+	u32 colors[4];
+
+	ret = fourzone_get_colors(colors);
+	if (ret != 0)
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%06x %06x %06x %06x\n", colors[0], colors[1], colors[2], colors[3]);
+}
+
+static ssize_t colors_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	int ret;
+	u32 colors[4];
+
+	ret = sscanf(buf, "%6x %6x %6x %6x", &colors[0], &colors[1], &colors[2], &colors[3]);
+	if (ret != 4)
+		return -EINVAL;
+
+	ret = fourzone_set_colors(colors);
+	return ret == 0 ? count : ret;
+}
+
+static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	u32 ret = fourzone_get_mode();
+
+	if (ret < 0)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", ret);
+}
+
+static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	int ret;
+	u32 mode;
+
+	ret = kstrtou32(buf, 10, &mode);
+	if (ret)
+		return ret;
+
+	ret = fourzone_set_mode(mode);
+	return ret == 0 ? count : ret;
+}
+
 static int camera_shutter_input_setup(void)
 {
 	int err;
@@ -781,6 +924,34 @@ static int camera_shutter_input_setup(void)
 	return err;
 }
 
+static enum hp_wmi_keyboardtype fourzone_get_keyboard_type(void)
+{
+	int ret;
+	u8 buff[128];
+
+	ret = hp_wmi_perform_query(HPWMI_GET_KEYBOARD_TYPE, HPWMI_GM,
+				   &buff, sizeof(buff), sizeof(buff));
+	if (ret != 0)
+		return HPWMI_KEYBOARD_INVALID;
+
+	/* the first byte in the response represents the keyboard type */
+	return (enum hp_wmi_keyboardtype)(buff[0] + 1);
+}
+
+static ssize_t type_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	enum hp_wmi_keyboardtype type = fourzone_get_keyboard_type();
+
+	if (type == HPWMI_KEYBOARD_INVALID)
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%d\n", type - 1);
+}
+
+/*
+ * Generic device attributes.
+ */
 static DEVICE_ATTR_RO(display);
 static DEVICE_ATTR_RO(hddtemp);
 static DEVICE_ATTR_RW(als);
@@ -797,7 +968,35 @@ static struct attribute *hp_wmi_attrs[] = {
 	&dev_attr_postcode.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(hp_wmi);
+
+static struct attribute_group hp_wmi_group = {
+	.attrs = hp_wmi_attrs,
+};
+
+/*
+ * Omen fourzone specific device attributes.
+ */
+static DEVICE_ATTR_RW(colors);
+static DEVICE_ATTR_RW(mode);
+static DEVICE_ATTR_RO(type);
+
+static struct attribute *hp_wmi_fourzone_attrs[] = {
+	&dev_attr_colors.attr,
+	&dev_attr_mode.attr,
+	&dev_attr_type.attr,
+	NULL,
+};
+
+static struct attribute_group hp_wmi_fourzone_group = {
+	.attrs = hp_wmi_fourzone_attrs,
+	.name = "kbd-backlight",
+};
+
+static const struct attribute_group *hp_wmi_groups[] = {
+	&hp_wmi_group,
+	NULL,
+	NULL,
+};
 
 static void hp_wmi_notify(u32 value, void *context)
 {
@@ -1446,6 +1645,35 @@ static int thermal_profile_setup(void)
 	return 0;
 }
 
+static bool fourzone_supports_lighting(void)
+{
+	int ret;
+	u8 buff[128];
+
+	ret = hp_wmi_perform_query(HPWMI_SUPPORTS_LIGHTNING, HPWMI_FOURZONE,
+				   &buff, sizeof(buff), sizeof(buff));
+	if (ret != 0)
+		return false;
+
+	return buff[0] & FOURZONE_LIGHTING_SUPPORTED_BIT;
+}
+
+static int fourzone_setup(struct platform_device *device)
+{
+	/* check if the system supports lighting */
+	if (!fourzone_supports_lighting())
+		return -ENODEV;
+
+	/* check if we have a supported keyboard type */
+	if (fourzone_get_keyboard_type() != HPWMI_KEYBOARD_WITHOUT_NUMPAD)
+		return -ENODEV;
+
+	/* register the new groups */
+	hp_wmi_groups[1] = &hp_wmi_fourzone_group;
+
+	return 0;
+}
+
 static int hp_wmi_hwmon_init(void);
 
 static int __init hp_wmi_bios_setup(struct platform_device *device)
@@ -1475,6 +1703,9 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 
 	thermal_profile_setup();
 
+	/* setup 4 zone rgb, no problem if it fails */
+	fourzone_setup(device);
+
 	return 0;
 }
 
-- 
2.44.0



