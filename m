Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D492C7F62A2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346058AbjKWPXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346049AbjKWPXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:23:23 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555A3C1;
        Thu, 23 Nov 2023 07:23:30 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cf52e5e07eso14925065ad.0;
        Thu, 23 Nov 2023 07:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700753010; x=1701357810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=er0tOmx71t3kRF+sJtcJFohjaQYKHdu0ri/MYPaslMU=;
        b=PIHroE1j75Bl12mxdFDtjDvfCO9RczOP8gAwsFaMZ8Ocx0di7RzKwb9jBD5gJwdPh1
         jaLqtyTBvQjpHmgkp6PYGQ762r0onr9tdmqakAlgeigDyxL0bpfo+m1GG712Lpmz4iNI
         JT56wT8udjqWzfrvege4zKLVCDIf1hIUIIR8FdGZ3LvXnb+HB5DuTnHlXyYNvvVDIF3N
         NRTMOKlPJ7hgPz3rlRqn8bGh6wa1GQoR4RBy8f1MXxbgTx96Ai60pIrecpt7CMnKcVO1
         SC9suXSZuoH5K3Lp5UhwKmVkPesgnwmDcadFO5gXCb/d1c8566Gs2Fy2bH9/5pdOwaa5
         qItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700753010; x=1701357810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=er0tOmx71t3kRF+sJtcJFohjaQYKHdu0ri/MYPaslMU=;
        b=E4qzxzsnE74QY8i3FuSNHZ8KkDdg8fKWpc002eBqU3c/oTLJtZXD1nArVDB3wgi+WE
         T7kqfln6xSIpk1+VzYvrbxbpcQJTY1Epe0WVHT70ZJbOGXEM3CLZ+Dv3BSr3ayVFswbP
         7ucGWbCHpSEDl6LcCarINNbEf6RcP+bjeZVkO6yVoLnjWlNjx23B19avowSNe18xe907
         Si9QJl17lbb1wjNI3ctMDfNCrDtw4uZj+bXT0oWtOp8Ds7jmh+nR6O1j400IzcLkRRiC
         YMXpgxgZsCdxycU+CNDwHebhDS2jSEXr4q6BsocSsIrGD4OegTaZsYFvY/QL2QqCTTm8
         Q4EQ==
X-Gm-Message-State: AOJu0Yw5jFDhph5PaBjmtR+lU1rbxzUI5tSBnwSoih4oQBSpgVw3OM5Q
        gRKJsd4iv38W/VZbrSzVomjjcPMdo8bBSQ==
X-Google-Smtp-Source: AGHT+IHgAS4Tb9n7kVYDmGJ6n4Db7afPC11zCFXLxI0vV3gGFsQNzv4705dikKcZtJq5iAoNSU55PQ==
X-Received: by 2002:a17:902:dac2:b0:1cc:644a:2129 with SMTP id q2-20020a170902dac200b001cc644a2129mr4275303plx.32.1700753009654;
        Thu, 23 Nov 2023 07:23:29 -0800 (PST)
Received: from localhost.localdomain ([110.46.146.116])
        by smtp.gmail.com with ESMTPSA id e12-20020a17090301cc00b001c737950e4dsm418565plh.2.2023.11.23.07.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 07:23:29 -0800 (PST)
From:   SungHwan Jung <onenowy@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     SungHwan Jung <onenowy@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [PATCH v3 2/2] platform/x86: acer-wmi: add fan speed monitoring for Predator PHN16-71
Date:   Fri, 24 Nov 2023 00:22:27 +0900
Message-ID: <20231123152229.4920-3-onenowy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231123152229.4920-1-onenowy@gmail.com>
References: <20231123152229.4920-1-onenowy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support CPU and GPU fan speed monitoring through WMI for Predator
PHN16-71.

This patch depends on patch "platform/x86: acer-wmi: Add platform
profile and mode key support for Predator PHN16-71"

"select ACPI_VIDEO" cause recursive dependency and it is not recommended
to use "select" for visible symbol, "select" has changed to "depends on".

Signed-off-by: SungHwan Jung <onenowy@gmail.com>
---
 drivers/platform/x86/Kconfig    |  3 +-
 drivers/platform/x86/acer-wmi.c | 98 ++++++++++++++++++++++++++++++++-
 2 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 7e69fdacc..33ddb644e 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -177,7 +177,8 @@ config ACER_WMI
 	depends on INPUT
 	depends on RFKILL || RFKILL = n
 	depends on ACPI_WMI
-	select ACPI_VIDEO
+	depends on HWMON
+	depends on ACPI_VIDEO
 	select INPUT_SPARSEKMAP
 	select LEDS_CLASS
 	select NEW_LEDS
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index e3650dce0..f2f3b1c45 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -30,6 +30,7 @@
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
 #include <acpi/video.h>
+#include <linux/hwmon.h>
 
 MODULE_AUTHOR("Carlos Corbacho");
 MODULE_DESCRIPTION("Acer Laptop WMI Extras Driver");
@@ -96,6 +97,8 @@ enum acer_wmi_event_ids {
 
 enum acer_wmi_predator_v4_sys_info_command {
 	ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS = 0x02,
+	ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED = 0x0201,
+	ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED = 0x0601,
 };
 
 static const struct key_entry acer_wmi_keymap[] __initconst = {
@@ -241,6 +244,7 @@ struct hotkey_function_type_aa {
 #define ACER_CAP_TURBO_LED     BIT(8)
 #define ACER_CAP_TURBO_FAN     BIT(9)
 #define ACER_CAP_PLATFORM_PROFILE BIT(10)
+#define ACER_CAP_FAN_SPEED_READ BIT(11)
 
 /*
  * Interface type flags
@@ -353,7 +357,8 @@ static void __init set_quirks(void)
 					 | ACER_CAP_TURBO_FAN;
 
 	if (quirks->predator_v4)
-		interface->capability |= ACER_CAP_PLATFORM_PROFILE;
+		interface->capability |= ACER_CAP_PLATFORM_PROFILE |
+					 ACER_CAP_FAN_SPEED_READ;
 }
 
 static int __init dmi_matched(const struct dmi_system_id *dmi)
@@ -1722,6 +1727,25 @@ static int acer_gsensor_event(void)
 	return 0;
 }
 
+static int acer_get_fan_speed(int fan)
+{
+	if (quirks->predator_v4) {
+		acpi_status status;
+		u64 fanspeed;
+
+		status = WMI_gaming_execute_u64(
+			ACER_WMID_GET_GAMING_SYS_INFO_METHODID,
+			fan == 0 ? ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED :
+				   ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED,
+			&fanspeed);
+
+		if (ACPI_FAILURE(status))
+			return -EIO;
+		return fanspeed >> 8;
+	}
+	return -EOPNOTSUPP;
+}
+
 /*
  *  Predator series turbo button
  */
@@ -2476,6 +2500,8 @@ static u32 get_wmid_devices(void)
 	return devices;
 }
 
+static int acer_wmi_hwmon_init(void);
+
 /*
  * Platform device
  */
@@ -2505,6 +2531,9 @@ static int acer_platform_probe(struct platform_device *device)
 			goto error_platform_profile;
 	}
 
+	if (has_cap(ACER_CAP_FAN_SPEED_READ))
+		err = acer_wmi_hwmon_init();
+
 	return err;
 
 error_rfkill:
@@ -2617,6 +2646,73 @@ static void __init create_debugfs(void)
 			   &interface->debug.wmid_devices);
 }
 
+static umode_t acer_wmi_hwmon_is_visible(const void *data,
+					 enum hwmon_sensor_types type, u32 attr,
+					 int channel)
+{
+	switch (type) {
+	case hwmon_fan:
+		if (acer_get_fan_speed(channel) >= 0)
+			return 0444;
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int acer_wmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			       u32 attr, int channel, long *val)
+{
+	int ret;
+
+	switch (type) {
+	case hwmon_fan:
+		ret = acer_get_fan_speed(channel);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static const struct hwmon_channel_info *const acer_wmi_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT, HWMON_F_INPUT), NULL
+};
+
+static const struct hwmon_ops acer_wmi_hwmon_ops = {
+	.read = acer_wmi_hwmon_read,
+	.is_visible = acer_wmi_hwmon_is_visible,
+};
+
+static const struct hwmon_chip_info acer_wmi_hwmon_chip_info = {
+	.ops = &acer_wmi_hwmon_ops,
+	.info = acer_wmi_hwmon_info,
+};
+
+static int acer_wmi_hwmon_init(void)
+{
+	struct device *dev = &acer_platform_device->dev;
+	struct device *hwmon;
+
+	hwmon = devm_hwmon_device_register_with_info(dev, "acer",
+						     &acer_platform_driver,
+						     &acer_wmi_hwmon_chip_info,
+						     NULL);
+
+	if (IS_ERR(hwmon)) {
+		dev_err(dev, "Could not register acer hwmon device\n");
+		return PTR_ERR(hwmon);
+	}
+
+	return 0;
+}
+
 static int __init acer_wmi_init(void)
 {
 	int err;
-- 
2.43.0

