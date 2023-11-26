Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBD17F963E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 00:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjKZXFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 18:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjKZXFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 18:05:35 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C54101;
        Sun, 26 Nov 2023 15:05:40 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C678E3200A5A;
        Sun, 26 Nov 2023 18:05:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 26 Nov 2023 18:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1701039939; x=
        1701126339; bh=4ijHKfQwA0D4YwrR5eZ/8CFnPujbdPSvz94VXQz+ZtA=; b=S
        k7GwLxBblNSOcSXNUVwCe69jKm0/A8PUj9vhrZcTXt7GvmBwdGs3WfoL3fDGo/PA
        mUGifaL7i/yCn5mPBMDKGj3ASV2ZnzCG55U2sTfijgmhtB/r/FyMPecqSONaJnsP
        SacJQh4FLT+l6Ru92S1CIvuBsaAdJA+ZuPLPCS0uxF5RJ2Mwue+pWd2bLHWVWrcm
        7NVuOxAZyJbSUrpP2/0q69XO2LOHViPMecoBkCivR55QSw4dyLh3N1BuqSgTK2md
        hmVfqiZDxEJ7ZxkQI/L7UsdVOK9DAXefkJRFCqof1YRu2wLQ2+PNvu1HwiuQKAbR
        +/FWvRU7nckcSMbP4OKug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701039939; x=
        1701126339; bh=4ijHKfQwA0D4YwrR5eZ/8CFnPujbdPSvz94VXQz+ZtA=; b=B
        O7ruGXsnjK+k0NZM3H11cE02SByuhBpEq4SScrHAUCUkvFqiKZkgqGoUtuqqdOhh
        QuhrS/4PzVKhfXdHzu1qssb/wKg4Q8WU8qudwNKbDgsTlvlHut4ACJtLR/38oT2w
        wG2TmpWlueH0WogYRRDeGZIGDYPI6vXrJnhDqgUd32E8q4weFRyQHXFkHNEUNVgc
        kT8Snb4p+QcGy4LHKzReko+/xG3rrqGIQbMTZMnV1ykXF5DRHcFNn5J0Uv2IH2ct
        yfdgNXQVITubUtjdqSxox3bWs6jiU8QY/t9jOD3ggbdmlL1ZFQ6eoVmDTMArhg5b
        VfNabyK4uNFXVuntNuWjg==
X-ME-Sender: <xms:Qs9jZQ6hUJJwIu_7Wci5R7iiWOufaG3iK3wbZn-7QxvZdgMffPK4sg>
    <xme:Qs9jZR5D5aHthwa5gLvnAEhP6ThZGuQjLcS-rTqyEXtrmR4Ob4HkGxMLpn3yIFIzj
    vf6COW9kx5-TR_L00Y>
X-ME-Received: <xmr:Qs9jZfff8sOGLmMiUNRxrCK8fvWjZnfYA8k7cDwGSGGVHEKq-8NCjVrnBj3O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeitddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:Qs9jZVKyOJLQbtDmeKklr-IoszSxwqLQ2TmOfwfDO4p_COiWFIMSsA>
    <xmx:Qs9jZUJdNe4fNpCeHPZ5AC1fInvIeRWNf3nkr9B2MrWeWW2YuGkcdA>
    <xmx:Qs9jZWydQBTO2392WRsIlMEjcAroG32bkFLeuAAK2xWrUGDu1N5rEQ>
    <xmx:Q89jZY3EXngMpH5Z-VV0yrkfXbfCy4dUbygbtSNp6WkbftG7innHXA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Nov 2023 18:05:36 -0500 (EST)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     ilpo.jarvinen@linux.intel.com, corentin.chary@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 1/1] platform/x86: asus-wmi: disable USB0 hub on ROG Ally before suspend
Date:   Mon, 27 Nov 2023 12:05:21 +1300
Message-ID: <20231126230521.125708-2-luke@ljones.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231126230521.125708-1-luke@ljones.dev>
References: <20231126230521.125708-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS have worked around an issue in XInput where it doesn't support USB
selective suspend, which causes suspend issues in Windows. They worked
around this by adjusting the MCU firmware to disable the USB0 hub when
the screen is switched off during the Microsoft DSM suspend path in ACPI.

The issue we have with this however is one of timing - the call the tells
the MCU to this isn't able to complete before suspend is done so we call
this in a prepare() and add a small msleep() to ensure it is done. This
must be done before the screen is switched off to prevent a variety of
possible races.

Further to this the MCU powersave option must also be disabled as it can
cause a number of issues such as:
- unreliable resume connection of N-Key
- complete loss of N-Key if the power is plugged in while suspended
Disabling the powersave option prevents this.

Without this the MCU is unable to initialise itself correctly on resume.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 50 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  3 ++
 2 files changed, 53 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 6a79f16233ab..4ba33dfebfd4 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -16,6 +16,7 @@
 #include <linux/acpi.h>
 #include <linux/backlight.h>
 #include <linux/debugfs.h>
+#include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/fb.h>
 #include <linux/hwmon.h>
@@ -132,6 +133,11 @@ module_param(fnlock_default, bool, 0444);
 #define ASUS_SCREENPAD_BRIGHT_MAX 255
 #define ASUS_SCREENPAD_BRIGHT_DEFAULT 60
 
+/* Controls the power state of the USB0 hub on ROG Ally which input is on */
+#define ASUS_USB0_PWR_EC0_CSEE "\\_SB.PCI0.SBRG.EC0.CSEE"
+/* 300ms so far seems to produce a reliable result on AC and battery */
+#define ASUS_USB0_PWR_EC0_CSEE_WAIT 300
+
 static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
 static int throttle_thermal_policy_write(struct asus_wmi *);
@@ -300,6 +306,9 @@ struct asus_wmi {
 
 	bool fnlock_locked;
 
+	/* The ROG Ally device requires the MCU USB device be disconnected before suspend */
+	bool ally_mcu_usb_switch;
+
 	struct asus_wmi_debug debug;
 
 	struct asus_wmi_driver *driver;
@@ -4488,6 +4497,8 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->nv_temp_tgt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_THERM_TARGET);
 	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
 	asus->mini_led_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
+	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
+						&& dmi_match(DMI_BOARD_NAME, "RC71L");
 
 	err = fan_boost_mode_check_present(asus);
 	if (err)
@@ -4654,6 +4665,43 @@ static int asus_hotk_resume(struct device *device)
 		asus_wmi_fnlock_update(asus);
 
 	asus_wmi_tablet_mode_get_state(asus);
+
+	return 0;
+}
+
+static int asus_hotk_resume_early(struct device *device)
+{
+	struct asus_wmi *asus = dev_get_drvdata(device);
+
+	if (asus->ally_mcu_usb_switch) {
+		if (ACPI_FAILURE(acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE, 0xB8)))
+			dev_err(device, "ROG Ally MCU failed to connect USB dev\n");
+		else
+			msleep(ASUS_USB0_PWR_EC0_CSEE_WAIT);
+	}
+	return 0;
+}
+
+static int asus_hotk_prepare(struct device *device)
+{
+	struct asus_wmi *asus = dev_get_drvdata(device);
+	int result, err;
+
+	if (asus->ally_mcu_usb_switch) {
+		/* When powersave is enabled it causes many issues with resume of USB hub */
+		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MCU_POWERSAVE);
+		if (result == 1) {
+			dev_warn(device, "MCU powersave enabled, disabling to prevent resume issues");
+			err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MCU_POWERSAVE, 0, &result);
+			if (err || result != 1)
+				dev_err(device, "Failed to set MCU powersave mode: %d\n", err);
+		}
+		/* sleep required to ensure USB0 is disabled before sleep continues */
+		if (ACPI_FAILURE(acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE, 0xB7)))
+			dev_err(device, "ROG Ally MCU failed to disconnect USB dev\n");
+		else
+			msleep(ASUS_USB0_PWR_EC0_CSEE_WAIT);
+	}
 	return 0;
 }
 
@@ -4701,6 +4749,8 @@ static const struct dev_pm_ops asus_pm_ops = {
 	.thaw = asus_hotk_thaw,
 	.restore = asus_hotk_restore,
 	.resume = asus_hotk_resume,
+	.resume_early = asus_hotk_resume_early,
+	.prepare = asus_hotk_prepare,
 };
 
 /* Registration ***************************************************************/
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 63e630276499..ab1c7deff118 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -114,6 +114,9 @@
 /* Charging mode - 1=Barrel, 2=USB */
 #define ASUS_WMI_DEVID_CHARGE_MODE	0x0012006C
 
+/* MCU powersave mode */
+#define ASUS_WMI_DEVID_MCU_POWERSAVE   0x001200E2
+
 /* epu is connected? 1 == true */
 #define ASUS_WMI_DEVID_EGPU_CONNECTED	0x00090018
 /* egpu on/off */
-- 
2.43.0

