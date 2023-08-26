Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19083789609
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 12:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjHZKoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 06:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjHZKoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 06:44:16 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05C4AD;
        Sat, 26 Aug 2023 03:44:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31c4d5bd69cso1392947f8f.3;
        Sat, 26 Aug 2023 03:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693046652; x=1693651452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/C4x/hTrmKiRaEYUrNM9oFSxwi2qXvH1zCeFJdbxME=;
        b=p9ETMnLf5DTT/n8Wxkwu5e2kyZIiZYPV1RTsLmDEC8P+B317UCKtY8vIgg8GAErjNM
         RosKAz6iq/1WCDkpO749hAcgVPpJUQOSYy+FKChH1etSjAvENcu9IYeIX2S0dDWDAZmU
         usLbrpUboLSmNYr8FAKiomdQU0nuoishyRYlhyWKXRZpDB/GcLL3AlMnfA0tfwBeMHWs
         QaNzackvVamPUiO7kmrbPzCb+EC8Agg5viUU7mQyNMDufX+PoLlrVwXFRT7rjWMeVNi/
         MoFnNQy1Rjet3eQO/iNBOElZJ3CI0l8zNXnbnSOaBvXP7MFGPiZxNJu780/9IMiuYiR6
         byjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693046652; x=1693651452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/C4x/hTrmKiRaEYUrNM9oFSxwi2qXvH1zCeFJdbxME=;
        b=Us4rwc3PnmsEsL+ZicRtWKNWqmm+x6PJRRn7zujkpDSWrpcFICeRdmBMnWwj+2CsbQ
         LCHl7HFTlSnGB/xlziX+QcynKalYbs0xgI438jM5gBNTYACCxXwQcP4UFTsnzLOBVRJC
         D0l1aG8SqjjIRRjiBC9ZBOv8vcQJaz6pjOisTiC6hNnKuXejGwB3j+ud+s/S83JHrBJ0
         VO9FstrH4fGEjICYZH2YogBpECNrgNM3aKPT0FEvGm8V96K9zZTKtJvNV2FHnKG0oXgX
         mjygAmaDuDCAP0WkeyrNeuCDzjN6lVfrb0t1scf+n4qWNLLNUJ/yTJjYJWzDryh5QbXt
         G46w==
X-Gm-Message-State: AOJu0YxzhybAYtNFE6JF0zldNi3kqODrjBpzvKih1sr1pXqc2TdR3R0x
        lYFxiWbtB4MErzxUcJmP4u2g5+AJGXe4jQ==
X-Google-Smtp-Source: AGHT+IHLByqWoC7LACF1/D4PlkivuyE/SSe0J9HP/ibzNaVzo6ZRxqLyBjgvTrCz7hXg+HGbzrtEqA==
X-Received: by 2002:adf:cf02:0:b0:317:6b0d:1b1 with SMTP id o2-20020adfcf02000000b003176b0d01b1mr15894262wrj.4.1693046651600;
        Sat, 26 Aug 2023 03:44:11 -0700 (PDT)
Received: from localhost.localdomain (cpc157791-rdng31-2-0-cust585.15-3.cable.virginm.net. [86.24.214.74])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0acc00b003fee6f027c7sm7777114wmr.19.2023.08.26.03.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 03:44:11 -0700 (PDT)
From:   Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ike Panhc <ike.pan@canonical.com>,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v2] platform/x86: ideapad-laptop: Add support for keyboard backlights using KBLC ACPI symbol
Date:   Sat, 26 Aug 2023 11:35:32 +0100
Message-ID: <20230826103530.9641-1-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
In-Reply-To: <7ab13275-b433-597a-bc5b-d1416c637974@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer Lenovo laptops seem to use the KBLC symbol to control the backlight
Add support for handling the keyboard backlight on these devices

Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
---

v1 -> v2:
 - Replace keyboard identification hex literals with defines
 - Use a helper macro for checking a keyboard type is tristate
 - Reworked ideapad_kbd_bl_brightness_set
 - Reworked ideapad_kbd_bl_brightness_get
 - Clean up newlines and stray change
 - Use GENMASK, FIELD_GET and FIELD_PUT instead of manual masking and shifting
 - Correct format specifiers for new warnings

---
 drivers/platform/x86/ideapad-laptop.c | 113 ++++++++++++++++++++++++--
 1 file changed, 107 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index d2fee9a3e239..6149852bf27f 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -10,6 +10,7 @@
 
 #include <linux/acpi.h>
 #include <linux/backlight.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/debugfs.h>
@@ -85,6 +86,32 @@ enum {
 	SALS_FNLOCK_OFF       = 0xf,
 };
 
+/*
+ * These correspond to the number of supported states - 1
+ * Future keyboard types may need a new system, if there's a collision
+ * KBD_BL_TRISTATE_AUTO has no way to report or set the auto state
+ * so it effectively has 3 states, but needs to handle 4
+ */
+enum {
+	KBD_BL_STANDARD      = 1,
+	KBD_BL_TRISTATE      = 2,
+	KBD_BL_TRISTATE_AUTO = 3,
+};
+
+#define KBD_BL_QUERY_TYPE		0x1
+#define KBD_BL_TRISTATE_TYPE		0x5
+#define KBD_BL_TRISTATE_AUTO_TYPE	0x7
+
+#define KBD_BL_COMMAND_GET		0x2
+#define KBD_BL_COMMAND_SET		0x3
+
+#define KBD_BL_GET_BRIGHTNESS_MASK	GENMASK(15, 0)
+#define KBD_BL_SET_BRIGHTNESS_MASK	GENMASK(19, 16)
+#define KBD_BL_SET_TYPE_MASK		GENMASK(7, 4)
+
+#define CHECK_KBD_BL_TRISTATE(TYPE)	(TYPE == KBD_BL_TRISTATE || \
+					TYPE == KBD_BL_TRISTATE_AUTO)
+
 struct ideapad_dytc_priv {
 	enum platform_profile_option current_profile;
 	struct platform_profile_handler pprof;
@@ -122,6 +149,7 @@ struct ideapad_private {
 	} features;
 	struct {
 		bool initialized;
+		int type;
 		struct led_classdev led;
 		unsigned int last_brightness;
 	} kbd_bl;
@@ -242,6 +270,16 @@ static int exec_sals(acpi_handle handle, unsigned long arg)
 	return exec_simple_method(handle, "SALS", arg);
 }
 
+static int exec_kblc(acpi_handle handle, unsigned long arg)
+{
+	return exec_simple_method(handle, "KBLC", arg);
+}
+
+static int eval_kblc(acpi_handle handle, unsigned long cmd, unsigned long *res)
+{
+	return eval_int_with_arg(handle, "KBLC", cmd, res);
+}
+
 static int eval_dytc(acpi_handle handle, unsigned long cmd, unsigned long *res)
 {
 	return eval_int_with_arg(handle, "DYTC", cmd, res);
@@ -1272,14 +1310,39 @@ static void ideapad_backlight_notify_brightness(struct ideapad_private *priv)
  */
 static int ideapad_kbd_bl_brightness_get(struct ideapad_private *priv)
 {
-	unsigned long hals;
+	unsigned long value;
 	int err;
 
-	err = eval_hals(priv->adev->handle, &hals);
+	if (CHECK_KBD_BL_TRISTATE(priv->kbd_bl.type)) {
+		err = eval_kblc(priv->adev->handle,
+				(priv->kbd_bl.type << 4) | KBD_BL_COMMAND_GET,
+				&value);
+
+		if (err)
+			return err;
+
+		/* Convert returned value to brightness level */
+		value = FIELD_GET(KBD_BL_GET_BRIGHTNESS_MASK, value) >> 1;
+
+		/* Off, low or high */
+		if (value <= priv->kbd_bl.led.max_brightness)
+			return value;
+
+		/* Auto, report as off */
+		if (value == priv->kbd_bl.led.max_brightness + 1)
+			return 0;
+
+		/* Unknown value */
+		dev_warn(&priv->platform_device->dev,
+			 "Unknown keyboard backlight value: %lu", value);
+		return -EINVAL;
+	}
+
+	err = eval_hals(priv->adev->handle, &value);
 	if (err)
 		return err;
 
-	return !!test_bit(HALS_KBD_BL_STATE_BIT, &hals);
+	return !!test_bit(HALS_KBD_BL_STATE_BIT, &value);
 }
 
 static enum led_brightness ideapad_kbd_bl_led_cdev_brightness_get(struct led_classdev *led_cdev)
@@ -1291,7 +1354,21 @@ static enum led_brightness ideapad_kbd_bl_led_cdev_brightness_get(struct led_cla
 
 static int ideapad_kbd_bl_brightness_set(struct ideapad_private *priv, unsigned int brightness)
 {
-	int err = exec_sals(priv->adev->handle, brightness ? SALS_KBD_BL_ON : SALS_KBD_BL_OFF);
+	int err;
+	unsigned long value;
+	int type = priv->kbd_bl.type;
+
+	if (CHECK_KBD_BL_TRISTATE(type)) {
+		if (brightness > priv->kbd_bl.led.max_brightness)
+			return -EINVAL;
+
+		value = FIELD_PREP(KBD_BL_SET_BRIGHTNESS_MASK, brightness) |
+			FIELD_PREP(KBD_BL_SET_TYPE_MASK, type) |
+			KBD_BL_COMMAND_SET;
+		err = exec_kblc(priv->adev->handle, value);
+	} else {
+		err = exec_sals(priv->adev->handle, brightness ? SALS_KBD_BL_ON : SALS_KBD_BL_OFF);
+	}
 
 	if (err)
 		return err;
@@ -1344,8 +1421,13 @@ static int ideapad_kbd_bl_init(struct ideapad_private *priv)
 
 	priv->kbd_bl.last_brightness = brightness;
 
+	if (CHECK_KBD_BL_TRISTATE(priv->kbd_bl.type)) {
+		priv->kbd_bl.led.max_brightness = 2;
+	} else {
+		priv->kbd_bl.led.max_brightness = 1;
+	}
+
 	priv->kbd_bl.led.name                    = "platform::" LED_FUNCTION_KBD_BACKLIGHT;
-	priv->kbd_bl.led.max_brightness          = 1;
 	priv->kbd_bl.led.brightness_get          = ideapad_kbd_bl_led_cdev_brightness_get;
 	priv->kbd_bl.led.brightness_set_blocking = ideapad_kbd_bl_led_cdev_brightness_set;
 	priv->kbd_bl.led.flags                   = LED_BRIGHT_HW_CHANGED;
@@ -1456,6 +1538,7 @@ static void ideapad_acpi_notify(acpi_handle handle, u32 event, void *data)
 		case 2:
 			ideapad_backlight_notify_power(priv);
 			break;
+		case 12:
 		case 1:
 			/*
 			 * Some IdeaPads report event 1 every ~20
@@ -1557,13 +1640,31 @@ static void ideapad_check_features(struct ideapad_private *priv)
 			if (test_bit(HALS_FNLOCK_SUPPORT_BIT, &val))
 				priv->features.fn_lock = true;
 
-			if (test_bit(HALS_KBD_BL_SUPPORT_BIT, &val))
+			if (test_bit(HALS_KBD_BL_SUPPORT_BIT, &val)) {
 				priv->features.kbd_bl = true;
+				priv->kbd_bl.type = KBD_BL_STANDARD;
+			}
 
 			if (test_bit(HALS_USB_CHARGING_SUPPORT_BIT, &val))
 				priv->features.usb_charging = true;
 		}
 	}
+
+	if (acpi_has_method(handle, "KBLC")) {
+		if (!eval_kblc(priv->adev->handle, KBD_BL_QUERY_TYPE, &val)) {
+			if (val == KBD_BL_TRISTATE_TYPE) {
+				priv->features.kbd_bl = true;
+				priv->kbd_bl.type = KBD_BL_TRISTATE;
+			} else if (val == KBD_BL_TRISTATE_AUTO_TYPE) {
+				priv->features.kbd_bl = true;
+				priv->kbd_bl.type = KBD_BL_TRISTATE_AUTO;
+			} else {
+				dev_warn(&priv->platform_device->dev,
+					 "Unknown keyboard type: %lu",
+					 val);
+			}
+		}
+	}
 }
 
 #if IS_ENABLED(CONFIG_ACPI_WMI)
-- 
2.40.1.521.gf1e218fcd8

