Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B294078D282
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 05:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239827AbjH3DXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 23:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239195AbjH3DWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:22:55 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700DE1A6;
        Tue, 29 Aug 2023 20:22:50 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 7898432009C0;
        Tue, 29 Aug 2023 23:22:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 29 Aug 2023 23:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1693365768; x=
        1693452168; bh=vsEup5oEKhREVymNYwmWKs3tcwfR0BNBMuzEr/8hfZU=; b=X
        W42FbQmUJWgOu4Nz6tYTAeY+NDQjFckGvoeHEPBTBosuYYSukT8K5wTXRhlqdz/9
        E1GZYItcVWWrH9fbisC8VILmvCEo9Gmt6YmEXXoYBxeQn6gqoSRnnYpPFgnmZLVl
        jKoA3GPwUc9r985HfX9yA4Ptv6a2YwfDYmodBV+1PbiY8Y45QWThnF+zblyM7UiQ
        v0ey0M0mYBOxAN5S8wRxROgadXOqOgLV0f18BCl+BdgRNgSMgEAehxYzuu5s+yeu
        w6T0IMcDZG4otfOVtIOpztGt+bFqIWOaTZSjm5ZQruk65ueoCXRwAoIc+Lx6zWA1
        d/iEGK2bndagTaU2ocGfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1693365768; x=
        1693452168; bh=vsEup5oEKhREVymNYwmWKs3tcwfR0BNBMuzEr/8hfZU=; b=M
        sh1prcE/wmVXfBI9gfDoVJuz0/PxUYUxfYNNhJPuxMgM+mbGXKeOi4WS/MflT5AT
        cQFAco02urbnHMDslyu9fpYvwFaLM6z18ttkQBMGhcUC0g1vlp6cZdWz7svgJ7eY
        frJMZllF9bBl1qMOgofUE6w3jw6iZiZRVOI5GsDuCfuhfft6InLdvb6cIuxr6d4E
        G4TLOLq79npsIZld8BvEff6fV/Mpx5F7Mm90ZRg5wR4qO2Wj9jm55n2JV2zC/Jwu
        vgrWe5DrEuGEYf3G4j2I5oRMjb3BUGquQQ8+y7FNr/1sTm5yQcDv5iQjXe1xG7AW
        75g9Qk31mOsL4vEGvt88Q==
X-ME-Sender: <xms:CLbuZMeHATuRkch1vrCy0XR5TWaXSAcoiIXADnEBchHhl6YHP2UZTA>
    <xme:CLbuZOO1DYXfWt72e98CdxpgjJmtyEebgxq_vJXX4te4Bjhe0akFWKbX32G7fAnnN
    F62yhHhW6o8MW6gpRw>
X-ME-Received: <xmr:CLbuZNi75HaMe7EZwmHSMd1BJxssQkN1ahdzMsCvwhTRAYj63d_AwqPBB2Pi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefjedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:CLbuZB93K-D1QODpwkJTQTmIkXaZvgwa7u3dDm_bDMD9S-mrGuWF7w>
    <xmx:CLbuZItWX277-h14VKQ9ue7aLs22--DDIUDvGFeTITxhjsohJ-1FcA>
    <xmx:CLbuZIFXY3mwaLZpzoo2KFhb-XUqvuiU5uTkHdZjOmccuOLRamF7Ug>
    <xmx:CLbuZELMdAOsR_85c0qmPgKhpZl6ncL8EV3n-VxQG4UXeXAaezpo_g>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Aug 2023 23:22:46 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v6 1/1] platform/x86: asus-wmi: add support for ASUS screenpad
Date:   Wed, 30 Aug 2023 15:22:37 +1200
Message-ID: <20230830032237.42987-2-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830032237.42987-1-luke@ljones.dev>
References: <20230830032237.42987-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the WMI methods used to turn off and adjust the
brightness of the secondary "screenpad" device found on some high-end
ASUS laptops like the GX650P series and others.

There are some small quirks with this device when considering only the
raw WMI methods:
1. The Off method can only switch the device off
2. Changing the brightness turns the device back on
3. To turn the device back on the brightness must be > 1
4. When the device is off the brightness can't be changed (so it is
   stored by the driver if device is off).
5. Booting with a value of 0 brightness (retained by bios) means the bios
   will set a value of >0 <15
6. When the device is off it is "unplugged"

asus_wmi sets the minimum brightness as 20 in general use, and 60 for
booting with values <= min.

The ACPI methods are used in a new backlight device named asus_screenpad.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 133 +++++++++++++++++++++
 drivers/platform/x86/asus-wmi.h            |   1 +
 include/linux/platform_data/x86/asus-wmi.h |   4 +
 3 files changed, 138 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index f54178d6f780..0b13be703856 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -25,6 +25,7 @@
 #include <linux/input/sparse-keymap.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
@@ -127,6 +128,10 @@ module_param(fnlock_default, bool, 0444);
 #define NVIDIA_TEMP_MIN		75
 #define NVIDIA_TEMP_MAX		87
 
+#define ASUS_SCREENPAD_BRIGHT_MIN 20
+#define ASUS_SCREENPAD_BRIGHT_MAX 255
+#define ASUS_SCREENPAD_BRIGHT_DEFAULT 60
+
 static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
 static int throttle_thermal_policy_write(struct asus_wmi *);
@@ -212,6 +217,7 @@ struct asus_wmi {
 
 	struct input_dev *inputdev;
 	struct backlight_device *backlight_device;
+	struct backlight_device *screenpad_backlight_device;
 	struct platform_device *platform_device;
 
 	struct led_classdev wlan_led;
@@ -3776,6 +3782,124 @@ static int is_display_toggle(int code)
 	return 0;
 }
 
+/* Screenpad backlight *******************************************************/
+
+static int read_screenpad_backlight_power(struct asus_wmi *asus)
+{
+	int ret;
+
+	ret = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_SCREENPAD_POWER);
+	if (ret < 0)
+		return ret;
+	/* 1 == powered */
+	return ret ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
+}
+
+static int read_screenpad_brightness(struct backlight_device *bd)
+{
+	struct asus_wmi *asus = bl_get_data(bd);
+	u32 retval;
+	int err;
+
+	err = read_screenpad_backlight_power(asus);
+	if (err < 0)
+		return err;
+	/* The device brightness can only be read if powered, so return stored */
+	if (err == FB_BLANK_POWERDOWN)
+		return asus->driver->screenpad_brightness - ASUS_SCREENPAD_BRIGHT_MIN;
+
+	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_SCREENPAD_LIGHT, &retval);
+	if (err < 0)
+		return err;
+
+	return (retval & ASUS_WMI_DSTS_BRIGHTNESS_MASK) - ASUS_SCREENPAD_BRIGHT_MIN;
+}
+
+static int update_screenpad_bl_status(struct backlight_device *bd)
+{
+	struct asus_wmi *asus = bl_get_data(bd);
+	int power, err = 0;
+	u32 ctrl_param;
+
+	power = read_screenpad_backlight_power(asus);
+	if (power < 0)
+		return power;
+
+	if (bd->props.power != power) {
+		if (power != FB_BLANK_UNBLANK) {
+			/* Only brightness > 0 can power it back on */
+			ctrl_param = asus->driver->screenpad_brightness - ASUS_SCREENPAD_BRIGHT_MIN;
+			err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_LIGHT,
+						    ctrl_param, NULL);
+		} else {
+			err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_POWER, 0, NULL);
+		}
+	} else if (power == FB_BLANK_UNBLANK) {
+		/* Only set brightness if powered on or we get invalid/unsync state */
+		ctrl_param = bd->props.brightness + ASUS_SCREENPAD_BRIGHT_MIN;
+		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_LIGHT, ctrl_param, NULL);
+	}
+
+	/* Ensure brightness is stored to turn back on with */
+	if (err == 0)
+		asus->driver->screenpad_brightness = bd->props.brightness + ASUS_SCREENPAD_BRIGHT_MIN;
+
+	return err;
+}
+
+static const struct backlight_ops asus_screenpad_bl_ops = {
+	.get_brightness = read_screenpad_brightness,
+	.update_status = update_screenpad_bl_status,
+	.options = BL_CORE_SUSPENDRESUME,
+};
+
+static int asus_screenpad_init(struct asus_wmi *asus)
+{
+	struct backlight_device *bd;
+	struct backlight_properties props;
+	int err, power;
+	int brightness = 0;
+
+	power = read_screenpad_backlight_power(asus);
+	if (power < 0)
+		return power;
+
+	if (power != FB_BLANK_POWERDOWN) {
+		err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_SCREENPAD_LIGHT, &brightness);
+		if (err < 0)
+			return err;
+	}
+	/* default to an acceptable min brightness on boot if too low */
+	if (brightness < ASUS_SCREENPAD_BRIGHT_MIN)
+		brightness = ASUS_SCREENPAD_BRIGHT_DEFAULT;
+
+	memset(&props, 0, sizeof(struct backlight_properties));
+	props.type = BACKLIGHT_RAW; /* ensure this bd is last to be picked */
+	props.max_brightness = ASUS_SCREENPAD_BRIGHT_MAX - ASUS_SCREENPAD_BRIGHT_MIN;
+	bd = backlight_device_register("asus_screenpad",
+				       &asus->platform_device->dev, asus,
+				       &asus_screenpad_bl_ops, &props);
+	if (IS_ERR(bd)) {
+		pr_err("Could not register backlight device\n");
+		return PTR_ERR(bd);
+	}
+
+	asus->screenpad_backlight_device = bd;
+	asus->driver->screenpad_brightness = brightness;
+	bd->props.brightness = brightness;
+	bd->props.power = power;
+	backlight_update_status(bd);
+
+	return 0;
+}
+
+static void asus_screenpad_exit(struct asus_wmi *asus)
+{
+	backlight_device_unregister(asus->screenpad_backlight_device);
+
+	asus->screenpad_backlight_device = NULL;
+}
+
 /* Fn-lock ********************************************************************/
 
 static bool asus_wmi_has_fnlock_key(struct asus_wmi *asus)
@@ -4431,6 +4555,12 @@ static int asus_wmi_add(struct platform_device *pdev)
 	} else if (asus->driver->quirks->wmi_backlight_set_devstate)
 		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL);
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_SCREENPAD_LIGHT)) {
+		err = asus_screenpad_init(asus);
+		if (err && err != -ENODEV)
+			goto fail_screenpad;
+	}
+
 	if (asus_wmi_has_fnlock_key(asus)) {
 		asus->fnlock_locked = fnlock_default;
 		asus_wmi_fnlock_update(asus);
@@ -4454,6 +4584,8 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus_wmi_backlight_exit(asus);
 fail_backlight:
 	asus_wmi_rfkill_exit(asus);
+fail_screenpad:
+	asus_screenpad_exit(asus);
 fail_rfkill:
 	asus_wmi_led_exit(asus);
 fail_leds:
@@ -4480,6 +4612,7 @@ static int asus_wmi_remove(struct platform_device *device)
 	asus = platform_get_drvdata(device);
 	wmi_remove_notify_handler(asus->driver->event_guid);
 	asus_wmi_backlight_exit(asus);
+	asus_screenpad_exit(asus);
 	asus_wmi_input_exit(asus);
 	asus_wmi_led_exit(asus);
 	asus_wmi_rfkill_exit(asus);
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index a478ebfd34df..5fbdd0eafa02 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -57,6 +57,7 @@ struct quirk_entry {
 struct asus_wmi_driver {
 	int			brightness;
 	int			panel_power;
+	int			screenpad_brightness;
 	int			wlan_ctrl_by_user;
 
 	const char		*name;
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 16e99a1c37fc..63e630276499 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -58,6 +58,10 @@
 #define ASUS_WMI_DEVID_KBD_BACKLIGHT	0x00050021
 #define ASUS_WMI_DEVID_LIGHT_SENSOR	0x00050022 /* ?? */
 #define ASUS_WMI_DEVID_LIGHTBAR		0x00050025
+/* This can only be used to disable the screen, not re-enable */
+#define ASUS_WMI_DEVID_SCREENPAD_POWER	0x00050031
+/* Writing a brightness re-enables the screen if disabled */
+#define ASUS_WMI_DEVID_SCREENPAD_LIGHT	0x00050032
 #define ASUS_WMI_DEVID_FAN_BOOST_MODE	0x00110018
 #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
 
-- 
2.41.0

