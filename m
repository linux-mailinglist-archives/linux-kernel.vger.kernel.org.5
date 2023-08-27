Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9150478A364
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjH0XYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjH0XYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:24:17 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FA2B2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:24:14 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 339B55C0038;
        Sun, 27 Aug 2023 19:24:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 27 Aug 2023 19:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1693178654; x=
        1693265054; bh=QFyeoLUMAKmtzkOAc9tf4dXjhHy8jzMusFa+Mfdd3K0=; b=g
        K49lAMawAiZ3sg5PCK3VmJoWu50i2CQYKdNFVWRLxLbUT72tyMgTx6hzH+rID1Sg
        4vyhHWjzY6ozmPprEN4YnjuWRyTjvzAXtJptHJoJmvjewDqJYthsGuQI11wWGGZR
        PG3hlMEqfCnYCOv53SElvcpih8XDjdyRtoKydxQMVeqC7FW7BANKF9mJpAs7eInv
        y9gGPKPaQ5mWkwvUU2Oi+eBI3Gx0Ez4Kh/0jIN2Rs40TuP6u6UwAleugBzHO4bX5
        X6bs9IfWEaYVKGg2nopdP6mDU7etlA4mUmaEPBjoN1aa/c9DSLhXXblZ5HA2pNCR
        XUQm2cqLiqph+tnxYpqcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1693178654; x=
        1693265054; bh=QFyeoLUMAKmtzkOAc9tf4dXjhHy8jzMusFa+Mfdd3K0=; b=h
        fh144jvazlZT1lEYvIsQ2jp9QDGpdxqMMYJYg31r826cYYDEP8Ma4dmx1wdsY1RA
        ncrh3IU6NZlbNS26TxSC70pEC+nYHXMzlzEOGHOTeG2PEA73afGF1Fu/6Ajc6V6K
        QqPTVcdv+9stjtD/cUx01Z28X9LfOdPgPAWgbd2vWfxmOFgV9YoE7t6GtI4ehQAs
        sEx9q3nzTJtgF4iO5Hxot6MmJphNq7kiCYmquA09lakpadJSYpUnK3bM378J+GEP
        Z0Z0d/KE5hdzZvA58+RGNgON88W/b2aEfPnLIE1p9Jgt7fOXNNpc5eeXFux/pX3V
        a6NyAlBoT3S1Keed09Ptg==
X-ME-Sender: <xms:HtvrZPQgeRZv0utfVnQuFtCNE9fgZScPfYl82QubAC84l6hL3r9yhg>
    <xme:HtvrZAxcFKZrl3Vsb-iKKeTi6Idr9a3GXNYag-OY8LFBypxVVhJBb5Hp0RtrKx9at
    Cf2WMd-Wm91Nl5wjh8>
X-ME-Received: <xmr:HtvrZE1RzjuqnuUvDPl0P2Uwvv6suAMNalRzJnucN8KlOR0GmAFf33SosRuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeffedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:HtvrZPA3w9G2zIeKMM0t-PFV6OlOJXnfFFdSe0zjmzLz0_1_IQSqmQ>
    <xmx:HtvrZIg15KFkPt1G22cfXc6R2J7IHcU6cb-G3ZsZ_SDK5QX_wOn78w>
    <xmx:HtvrZDqXicBPzNfKCns85pn56ZozgpK_c2PzHtZRzVjUWMPxt-xgrw>
    <xmx:HtvrZLtrHY1Cr9wXeOVXvH_G1ZcrbJtxAGjCPW9wUYO3eAHEB8b7qA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Aug 2023 19:24:11 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v5 1/1] platform/x86: asus-wmi: add support for ASUS screenpad
Date:   Mon, 28 Aug 2023 11:23:58 +1200
Message-ID: <20230827232358.80512-2-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230827232358.80512-1-luke@ljones.dev>
References: <20230827232358.80512-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the WMI methods used to turn off and adjust the
brightness of the secondary "screenpad" device found on some high-end
ASUS laptops like the GX650P series and others.

These methods are utilised in a new backlight device named asus_screenpad.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 131 +++++++++++++++++++++
 drivers/platform/x86/asus-wmi.h            |   1 +
 include/linux/platform_data/x86/asus-wmi.h |   4 +
 3 files changed, 136 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 13547e55ae82..2801c691133a 100644
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
@@ -127,6 +128,9 @@ module_param(fnlock_default, bool, 0444);
 #define NVIDIA_TEMP_MIN		75
 #define NVIDIA_TEMP_MAX		87
 
+#define ASUS_SCREENPAD_BRIGHT_MIN 20
+#define ASUS_SCREENPAD_BRIGHT_MAX 255
+
 static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
 static int throttle_thermal_policy_write(struct asus_wmi *);
@@ -212,6 +216,7 @@ struct asus_wmi {
 
 	struct input_dev *inputdev;
 	struct backlight_device *backlight_device;
+	struct backlight_device *screenpad_backlight_device;
 	struct platform_device *platform_device;
 
 	struct led_classdev wlan_led;
@@ -3776,6 +3781,123 @@ static int is_display_toggle(int code)
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
+		return asus->driver->screenpad_brightness;
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
+			ctrl_param = max(ASUS_SCREENPAD_BRIGHT_MIN, asus->driver->screenpad_brightness);
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
+	asus->driver->screenpad_brightness = bd->props.brightness + ASUS_SCREENPAD_BRIGHT_MIN;
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
+		brightness = ASUS_SCREENPAD_BRIGHT_MIN;
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
@@ -4431,6 +4553,12 @@ static int asus_wmi_add(struct platform_device *pdev)
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
@@ -4454,6 +4582,8 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus_wmi_backlight_exit(asus);
 fail_backlight:
 	asus_wmi_rfkill_exit(asus);
+fail_screenpad:
+	asus_screenpad_exit(asus);
 fail_rfkill:
 	asus_wmi_led_exit(asus);
 fail_leds:
@@ -4480,6 +4610,7 @@ static int asus_wmi_remove(struct platform_device *device)
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

