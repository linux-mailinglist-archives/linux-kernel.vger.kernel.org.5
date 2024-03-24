Return-Path: <linux-kernel+bounces-112794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC375887E37
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820C82813A5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F3D1A5AC;
	Sun, 24 Mar 2024 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+Aik10Q"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145DF1A587;
	Sun, 24 Mar 2024 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711303608; cv=none; b=d2bFjQO6WWUWNl/C1VGSTOk4G0RfiQX1GPg88ALUi9XX2RDtSeLD9vUslmJ0Fu4OETwLqH0UhyBRVeKckrr+phuyHZbLhxmMm/1+KtaLxWxkhvgLnXnvjUBt6FyBzYXeFo3eP1LOrWixm6XgOWlLPbVN9lNrKdwLeklp/KOZmOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711303608; c=relaxed/simple;
	bh=Ti6PojbAFg8oQ9g3hgSII0y1HsqtOuHJvsZBgqHFwVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QuJvjJmoQnTCZpDNDsRTGqDK8bUr+D6lGpW9ixTVF/AYtx+Ad5H6D9vDzinIhmt+gA+tqnM7H4ZTfbiVQk2BJxWwuYm5gkWOj98u3KLR9jf0DrcJrzaRnFL0kDmxYEF+m6iJ491n5uvOgYpCYf1bpOLPHKMoMPhHfrIWskgK5Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+Aik10Q; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33fd8a2a407so2484528f8f.2;
        Sun, 24 Mar 2024 11:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711303604; x=1711908404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zT3ivNnXPiMEzMuiy9eiAtLpGLgrTy5Xrcv+/J6D7X4=;
        b=I+Aik10QN+PEITsgdWm4j51iA83q6f2f3ICnSvZNP9HpmMtECXUJqiOdlD2O4JMKdP
         CO6mmmEV8wqJjS8aUcf4FGrGcD4f+lkSmtzh5IDjpy3rdBhZkWZJjrc49VURg5aT0ldN
         lEIJnXtAgple4l8Frly4FOIHSmOvto6xDqXOzMtKp+qO0uMG6LNVDyf/rI4WUwshWO6r
         pEAtiG/qeUELFzm2CcN5AwPzdS9rq+IBVO/4l5kLeb/Pmfo8gv/zMbgcX3y4KnmeeVbm
         05wi3CWHXBGxNBP12jWIxazea1b6k1LxF8esjQFM3MsJyj+lVxvPCgxTW4OQsA0pQh8o
         04sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711303604; x=1711908404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zT3ivNnXPiMEzMuiy9eiAtLpGLgrTy5Xrcv+/J6D7X4=;
        b=rjVngdqz/HEcfk9UI+CyFFkRt99RJG7VbK7A2cVLo1W7B3/iULOLOM6hmxGrEp6xhM
         JjVjhCmf6MIt5cq7r4TSLBStb5K29lGz3yM2DkQTe0RH3YHJLHOFXy8jnjYP9VIdDLUR
         ebgI0c7hfnxmqtzcLM7WBinTPPh8PEiBqm3gfAfmmrJeKcHwzpE9l/CRM4qGiS9ZmFbt
         AmoMnBsxxAIeyVhbJa0Ij5v57yCYB83UPoONA44rz0POIZd7nHoGxfndg0W9iUB9kAvU
         9v0OKJNusFTVn7Irf5nT++34G/khy4n/Unz9Pm27umFmYRc93EaCzBLV1240oJCOg6+g
         93jg==
X-Forwarded-Encrypted: i=1; AJvYcCXIfLv/Cm61Dlb2HVrdoZQjFj3rfEbgAeJfm5joqmrYUnwowzF0EYpUXAJEcNkizaO1zSVdapPnA8KZxI1PNp4EF22BjSzcpnxLBUWD
X-Gm-Message-State: AOJu0Yyax93X3Ne1fih8tx0ucKCfDfMqY0pK4ZpKCfXubtVe7yZcHpmu
	IwAJtHIsNYTppBiDxpQVl3YXgyKTIoCzuWX803iul++BRICKk3uf
X-Google-Smtp-Source: AGHT+IEog1jxZzLUDzgS0p9yhg6PBx07S6V+aOeIrh7pB6x4iN6lL2bfQFYYN/nhzzMwPfa/LjD18A==
X-Received: by 2002:a5d:48c5:0:b0:33e:2f4c:61c1 with SMTP id p5-20020a5d48c5000000b0033e2f4c61c1mr2904632wrs.52.1711303604299;
        Sun, 24 Mar 2024 11:06:44 -0700 (PDT)
Received: from laptop-arch.Home ([2001:8a0:ed72:2800:4fbb:3beb:7045:e257])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d47cd000000b0033e45930f35sm7348302wrc.6.2024.03.24.11.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 11:06:44 -0700 (PDT)
From: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
To: hdegoede@redhat.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
Subject: [PATCH] HP: wmi: added support for 4 zone keyboard rgb
Date: Sun, 24 Mar 2024 18:05:49 +0000
Message-ID: <20240324180549.148812-1-carlosmiguelferreira.2003@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added support for 4 zone keyboard rgb on omen laptops.

Signed-off-by: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
---
 drivers/platform/x86/hp/hp-wmi.c | 308 +++++++++++++++++++++++++++----
 1 file changed, 273 insertions(+), 35 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index e53660422..f420f41c7 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -103,7 +103,7 @@ enum hp_wmi_event_ids {
 /*
  * struct bios_args buffer is dynamically allocated.  New WMI command types
  * were introduced that exceeds 128-byte data size.  Changes to handle
- * the data size allocation scheme were kept in hp_wmi_perform_qurey function.
+ * the data size allocation scheme were kept in hp_wmi_perform_query function.
  */
 struct bios_args {
 	u32 signature;
@@ -114,15 +114,15 @@ struct bios_args {
 };
 
 enum hp_wmi_commandtype {
-	HPWMI_DISPLAY_QUERY		= 0x01,
-	HPWMI_HDDTEMP_QUERY		= 0x02,
-	HPWMI_ALS_QUERY			= 0x03,
+	HPWMI_DISPLAY_QUERY			= 0x01,
+	HPWMI_HDDTEMP_QUERY			= 0x02,
+	HPWMI_ALS_QUERY				= 0x03,
 	HPWMI_HARDWARE_QUERY		= 0x04,
 	HPWMI_WIRELESS_QUERY		= 0x05,
-	HPWMI_BATTERY_QUERY		= 0x07,
-	HPWMI_BIOS_QUERY		= 0x09,
-	HPWMI_FEATURE_QUERY		= 0x0b,
-	HPWMI_HOTKEY_QUERY		= 0x0c,
+	HPWMI_BATTERY_QUERY			= 0x07,
+	HPWMI_BIOS_QUERY			= 0x09,
+	HPWMI_FEATURE_QUERY			= 0x0b,
+	HPWMI_HOTKEY_QUERY			= 0x0c,
 	HPWMI_FEATURE2_QUERY		= 0x0d,
 	HPWMI_WIRELESS2_QUERY		= 0x1b,
 	HPWMI_POSTCODEERROR_QUERY	= 0x2a,
@@ -131,18 +131,36 @@ enum hp_wmi_commandtype {
 };
 
 enum hp_wmi_gm_commandtype {
-	HPWMI_FAN_SPEED_GET_QUERY = 0x11,
-	HPWMI_SET_PERFORMANCE_MODE = 0x1A,
+	HPWMI_FAN_SPEED_GET_QUERY	  = 0x11,
+	HPWMI_SET_PERFORMANCE_MODE    = 0x1A,
 	HPWMI_FAN_SPEED_MAX_GET_QUERY = 0x26,
 	HPWMI_FAN_SPEED_MAX_SET_QUERY = 0x27,
-	HPWMI_GET_SYSTEM_DESIGN_DATA = 0x28,
+	HPWMI_GET_SYSTEM_DESIGN_DATA  = 0x28,
+	HPWMI_GET_KEYBOARD_TYPE		  = 0x2B,
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
+	HPWMI_KEYBOARD_INVALID		  = 0x00,
+	HPWMI_KEYBOARD_NORMAL		  = 0x01,
+	HPWMI_KEYBOARD_WITH_NUMPAD	  = 0x02,
+	HPWMI_KEYBOARD_WITHOUT_NUMPAD = 0x03,
+	HPWMI_KEYBOARD_RGB			  = 0x04,
 };
 
 enum hp_wmi_command {
-	HPWMI_READ	= 0x01,
-	HPWMI_WRITE	= 0x02,
-	HPWMI_ODM	= 0x03,
-	HPWMI_GM	= 0x20008,
+	HPWMI_READ	   = 0x01,
+	HPWMI_WRITE	   = 0x02,
+	HPWMI_ODM	   = 0x03,
+	HPWMI_GM	   = 0x20008,
+	HPWMI_FOURZONE = 0x20009,
 };
 
 enum hp_wmi_hardware_mask {
@@ -156,18 +174,18 @@ struct bios_return {
 };
 
 enum hp_return_value {
-	HPWMI_RET_WRONG_SIGNATURE	= 0x02,
-	HPWMI_RET_UNKNOWN_COMMAND	= 0x03,
-	HPWMI_RET_UNKNOWN_CMDTYPE	= 0x04,
-	HPWMI_RET_INVALID_PARAMETERS	= 0x05,
+	HPWMI_RET_WRONG_SIGNATURE	 = 0x02,
+	HPWMI_RET_UNKNOWN_COMMAND	 = 0x03,
+	HPWMI_RET_UNKNOWN_CMDTYPE	 = 0x04,
+	HPWMI_RET_INVALID_PARAMETERS = 0x05,
 };
 
 enum hp_wireless2_bits {
-	HPWMI_POWER_STATE	= 0x01,
-	HPWMI_POWER_SOFT	= 0x02,
-	HPWMI_POWER_BIOS	= 0x04,
-	HPWMI_POWER_HARD	= 0x08,
-	HPWMI_POWER_FW_OR_HW	= HPWMI_POWER_BIOS | HPWMI_POWER_HARD,
+	HPWMI_POWER_STATE	 = 0x01,
+	HPWMI_POWER_SOFT	 = 0x02,
+	HPWMI_POWER_BIOS	 = 0x04,
+	HPWMI_POWER_HARD	 = 0x08,
+	HPWMI_POWER_FW_OR_HW = HPWMI_POWER_BIOS | HPWMI_POWER_HARD,
 };
 
 enum hp_thermal_profile_omen_v0 {
@@ -177,22 +195,22 @@ enum hp_thermal_profile_omen_v0 {
 };
 
 enum hp_thermal_profile_omen_v1 {
-	HP_OMEN_V1_THERMAL_PROFILE_DEFAULT	= 0x30,
-	HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE	= 0x31,
-	HP_OMEN_V1_THERMAL_PROFILE_COOL		= 0x50,
+	HP_OMEN_V1_THERMAL_PROFILE_DEFAULT	   = 0x30,
+	HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE = 0x31,
+	HP_OMEN_V1_THERMAL_PROFILE_COOL		   = 0x50,
 };
 
 enum hp_thermal_profile_victus {
-	HP_VICTUS_THERMAL_PROFILE_DEFAULT		= 0x00,
-	HP_VICTUS_THERMAL_PROFILE_PERFORMANCE		= 0x01,
-	HP_VICTUS_THERMAL_PROFILE_QUIET			= 0x03,
+	HP_VICTUS_THERMAL_PROFILE_DEFAULT	  = 0x00,
+	HP_VICTUS_THERMAL_PROFILE_PERFORMANCE = 0x01,
+	HP_VICTUS_THERMAL_PROFILE_QUIET		  = 0x03,
 };
 
 enum hp_thermal_profile {
-	HP_THERMAL_PROFILE_PERFORMANCE	= 0x00,
-	HP_THERMAL_PROFILE_DEFAULT		= 0x01,
-	HP_THERMAL_PROFILE_COOL			= 0x02,
-	HP_THERMAL_PROFILE_QUIET		= 0x03,
+	HP_THERMAL_PROFILE_PERFORMANCE = 0x00,
+	HP_THERMAL_PROFILE_DEFAULT	   = 0x01,
+	HP_THERMAL_PROFILE_COOL		   = 0x02,
+	HP_THERMAL_PROFILE_QUIET	   = 0x03,
 };
 
 #define IS_HWBLOCKED(x) ((x & HPWMI_POWER_FW_OR_HW) != HPWMI_POWER_FW_OR_HW)
@@ -754,6 +772,67 @@ static ssize_t postcode_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
+static int fourzone_get_colors(u32 *colors);
+static int fourzone_set_colors(u32 *colors);
+
+static ssize_t colors_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	u32 colors[4];
+
+	/* read the colors from wmi and write them to the buf */
+	if (fourzone_get_colors(colors) == 0)
+		return sprintf(buf, "%06x %06x %06x %06x\n",
+					colors[0], colors[1], colors[2], colors[3]);
+
+	return -EINVAL;
+}
+
+static ssize_t colors_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	u32 colors[4];
+
+	if (sscanf(buf, "%6x %6x %6x %6x", &colors[0], &colors[1], &colors[2], &colors[3]) != 4)
+		return -EINVAL;
+
+	/* set the colors */
+	int ret = fourzone_set_colors(colors);
+
+	return ret == 0 ? count : ret;
+}
+
+static int fourzone_get_mode(void);
+static int fourzone_set_mode(u32 mode);
+
+static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	/* read the mode from wmi and write it to the buf */
+	u32 ret = fourzone_get_mode();
+
+	if (ret >= 0)
+		return sprintf(buf, "%d\n", ret);
+
+	return ret;
+}
+
+static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	u32 mode;
+
+	int ret = kstrtou32(buf, 10, &mode);
+
+	if (ret)
+		return ret;
+
+	/* set the mode */
+	ret = fourzone_set_mode(mode);
+
+	return ret == 0 ? count : ret;
+}
+
 static int camera_shutter_input_setup(void)
 {
 	int err;
@@ -781,6 +860,22 @@ static int camera_shutter_input_setup(void)
 	return err;
 }
 
+static enum hp_wmi_keyboardtype fourzone_get_keyboard_type(void);
+
+static ssize_t type_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	enum hp_wmi_keyboardtype type = fourzone_get_keyboard_type();
+
+	if (type != HPWMI_KEYBOARD_INVALID)
+		return sprintf(buf, "%d\n", type - 1);
+
+	return -EINVAL;
+}
+
+/*
+ * Generic device attributes.
+ */
 static DEVICE_ATTR_RO(display);
 static DEVICE_ATTR_RO(hddtemp);
 static DEVICE_ATTR_RW(als);
@@ -797,7 +892,35 @@ static struct attribute *hp_wmi_attrs[] = {
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
@@ -1446,6 +1569,118 @@ static int thermal_profile_setup(void)
 	return 0;
 }
 
+static bool fourzone_supports_lighting(void)
+{
+	u8 buff[128];
+
+	int ret = hp_wmi_perform_query(HPWMI_SUPPORTS_LIGHTNING, HPWMI_FOURZONE,
+								&buff, sizeof(buff), sizeof(buff));
+	/* the first bit in the response is set to 1 if the system supports lighting */
+	if (ret == 0)
+		return (buff[0] & 0x01) == 1;
+
+	return false;
+}
+
+static enum hp_wmi_keyboardtype fourzone_get_keyboard_type(void)
+{
+	u8 buff[128];
+
+	int ret = hp_wmi_perform_query(HPWMI_GET_KEYBOARD_TYPE, HPWMI_GM,
+								&buff, sizeof(buff), sizeof(buff));
+	/* the first byte in the response represents the keyborad type */
+	if (ret == 0)
+		return (enum hp_wmi_keyboardtype)(buff[0] + 1);
+
+	return HPWMI_KEYBOARD_INVALID;
+}
+
+static int fourzone_get_colors(u32 *colors)
+{
+	u8 buff[128];
+
+	if (hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE,
+							&buff, sizeof(buff), sizeof(buff)) == 0) {
+		for (int i = 0; i < 4; i++) {
+			colors[3 - i] = ((buff[25 + i * 3]     & 0xFF) << 16)  // r
+						  | ((buff[25 + i * 3 + 1] & 0xFF) <<  8)  // g
+						  | ((buff[25 + i * 3 + 2] & 0xFF) <<  0); // b
+		}
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int fourzone_set_colors(u32 *colors)
+{
+	u8 buff[128];
+
+	if (hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE,
+							&buff, sizeof(buff), sizeof(buff)) == 0) {
+		for (int i = 0; i < 4; i++) {
+			buff[25 + i * 3]	 = (colors[3 - i] >> 16) & 0xFF; // r
+			buff[25 + i * 3 + 1] = (colors[3 - i] >>  8) & 0xFF; // g
+			buff[25 + i * 3 + 2] = (colors[3 - i] >>  0) & 0xFF; // b
+		}
+
+		return hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_SET, HPWMI_FOURZONE,
+						&buff, sizeof(buff), sizeof(buff));
+	}
+
+	return -EINVAL;
+}
+
+/*
+ * Returns a negative number on error or 0/1 for the mode.
+ */
+static int fourzone_get_mode(void)
+{
+	u8 buff[4];
+
+	int ret = hp_wmi_perform_query(HPWMI_FOURZONE_MODE_GET, HPWMI_FOURZONE,
+								&buff, sizeof(buff), sizeof(buff));
+
+	if (ret == 0)
+		return buff[0] == 228 ? 1 : 0;
+
+	return ret;
+}
+
+/*
+ * This device supports only two different modes:
+ * 1 -> lights on
+ * 0 -> lights off
+ */
+static int fourzone_set_mode(u32 mode)
+{
+	u8 buff[4] = {mode ? 228 : 100, 0, 0, 0};
+
+	return hp_wmi_perform_query(HPWMI_FOURZONE_MODE_SET, HPWMI_FOURZONE,
+								&buff, sizeof(buff), 0);
+}
+
+static int fourzone_setup(struct platform_device *device)
+{
+	/* check if the system supports lighting */
+	bool supports_lighting = fourzone_supports_lighting();
+
+	if (!supports_lighting)
+		return -ENODEV;
+
+	/* check if we have a supported keyboard type */
+	enum hp_wmi_keyboardtype kbd_type = fourzone_get_keyboard_type();
+
+	if (kbd_type != HPWMI_KEYBOARD_WITHOUT_NUMPAD)
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
@@ -1475,6 +1710,9 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 
 	thermal_profile_setup();
 
+	/* setup 4 zone rgb, no problem if it fails */
+	fourzone_setup(device);
+
 	return 0;
 }
 
-- 
2.44.0


