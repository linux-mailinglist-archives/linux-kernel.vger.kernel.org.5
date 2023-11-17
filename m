Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B569F7EFB5E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 23:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344561AbjKQW14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 17:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjKQW1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 17:27:55 -0500
X-Greylist: delayed 372 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Nov 2023 14:27:49 PST
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F51D4D;
        Fri, 17 Nov 2023 14:27:49 -0800 (PST)
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
        by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4SXBFp6jnXz80JR;
        Fri, 17 Nov 2023 23:21:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zint.sh; s=key2;
        t=1700259694; bh=8cPzMbNG0DX6cFdHPd1MkVo89CqNNcaJQJvTt+7sLAk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=JeRaIjjBqiarYF3UbzgDpi1CEAESAIy63bVderJPyadTtd6wgkc33oRGDYS1bv0n8
         SIVaPekjIiixLSBrGntaP9nSycz6VO7gwN/D1cKnlAD8skjRJhrfPWTMcO0Ci9CMec
         oP6tp3+gVblZXiW7M7c1qnDj4g7W77sZUJlL0D/hv/AA552/ajpvHSpQAWdsT0zKBA
         xNy0luibAsxVm0JkKPYtRr1pQqLbLqKYHf24V2Onw4aYJo4E+I282Nez/iuwRXoGmB
         vLHmW4ZXh2NIcP/H9zmwO3pe1cd5goqotwKF8vRkxfXaFIvkzgB3pOwjWlHq7V9t1h
         LrBBHyW+5HfFg==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
        by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4SXBFp6BdRz80G8;
        Fri, 17 Nov 2023 23:21:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Received: from mxe217.netcup.net (unknown [10.243.12.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by policy01-mors.netcup.net (Postfix) with ESMTPS id 4SXBFg0tDcz8sbW;
        Fri, 17 Nov 2023 23:21:27 +0100 (CET)
Received: from thinkpad (p5795f559.dip0.t-ipconnect.de [87.149.245.89])
        by mxe217.netcup.net (Postfix) with ESMTPSA id C7D4982435;
        Fri, 17 Nov 2023 23:21:12 +0100 (CET)
Date:   Fri, 17 Nov 2023 23:21:12 +0100 (CET)
From:   Julius Zint <julius@zint.sh>
To:     Sean Aguinaga <sean.a@hey.com>
cc:     daniel.thompson@linaro.org, deller@gmx.de,
        dri-devel@lists.freedesktop.org, jingoohan1@gmail.com,
        lee@kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sam@ravnborg.org, zajec5@gmail.com
Subject: Re: [PATCH 0/1] Backlight driver for the Apple Studio Display
In-Reply-To: <43d33bc0374ff57f45020c35d8234a0c74cffb77@hey.com>
Message-ID: <60ceac99-1375-8c16-7159-5dbb3332bdff@zint.sh>
References: <43d33bc0374ff57f45020c35d8234a0c74cffb77@hey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: C7D4982435
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: 6m/GaDdIo5M/tpv8rebjpyTMfpqNZoMH8nxjpJ99
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Nov 2023, Sean Aguinaga wrote:

Hi,

> Did you get a chance to implement V2?

Yes, v2 is here [1] and v3 is here [2]. Currently I do have the
a few changes on top of v3 that are appended here as a patch. I use it
with DMKS and it works (mostly). I do see the userspace confusion when
the monitor is plugged in after boot.

Its still possible to set it by writing to the brightness file.

Julius

[1] https://lore.kernel.org/dri-devel/20230806091403.10002-1-julius@zint.sh/
[2] https://lore.kernel.org/dri-devel/20230820094118.20521-1-julius@zint.sh/

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index b964a820956d..35864cc1afee 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -477,8 +477,7 @@ config BACKLIGHT_HID
 	depends on HID
 	help
 	  If you have an external display with VESA compliant HID brightness
-	  controls then say Y to enable this backlight driver. Currently the
-	  only supported device is the Apple Studio Display.
+	  controls then say Y to enable this backlight driver.
 
 endif # BACKLIGHT_CLASS_DEVICE
 
diff --git a/drivers/video/backlight/hid_bl.c b/drivers/video/backlight/hid_bl.c
index b40f8f412ee2..38b82de8224f 100644
--- a/drivers/video/backlight/hid_bl.c
+++ b/drivers/video/backlight/hid_bl.c
@@ -4,8 +4,8 @@
 #include <linux/module.h>
 #include <linux/backlight.h>
 
-#define APPLE_STUDIO_DISPLAY_VENDOR_ID  0x05ac
-#define APPLE_STUDIO_DISPLAY_PRODUCT_ID 0x1114
+#define APPLE_STUDIO_DISPLAY_VENDOR_ID  	0x05ac
+#define APPLE_STUDIO_DISPLAY_PRODUCT_ID 	0x1114
 
 #define HID_USAGE_MONITOR_CTRL			0x800001
 #define HID_USAGE_VESA_VCP_BRIGHTNESS		0x820010
@@ -59,7 +59,8 @@ struct hid_bl_data {
 
 static struct hid_field *hid_get_usage_field(struct hid_device *hdev,
 					     unsigned int report_type,
-					     unsigned int application, unsigned int usage)
+					     unsigned int application,
+					     unsigned int usage)
 {
 	struct hid_report_enum *re = &hdev->report_enum[report_type];
 	struct hid_report *report;
@@ -82,18 +83,8 @@ static struct hid_field *hid_get_usage_field(struct hid_device *hdev,
 
 static void hid_bl_remove(struct hid_device *hdev)
 {
-	struct backlight_device *bl;
-	struct hid_bl_data *data;
-
-	hid_dbg(hdev, "remove\n");
-	bl = hid_get_drvdata(hdev);
-	data = bl_get_data(bl);
-
-	devm_backlight_device_unregister(&hdev->dev, bl);
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
-	hid_set_drvdata(hdev, NULL);
-	devm_kfree(&hdev->dev, data);
 }
 
 static int hid_bl_get_brightness_raw(struct hid_bl_data *data)
@@ -105,7 +96,6 @@ static int hid_bl_get_brightness_raw(struct hid_bl_data *data)
 	hid_hw_request(data->hdev, field->report, HID_REQ_GET_REPORT);
 	hid_hw_wait(data->hdev);
 	result = *field->new_value;
-	hid_dbg(data->hdev, "get brightness: %d\n", result);
 
 	return result;
 }
@@ -128,7 +118,6 @@ static void hid_bl_set_brightness_raw(struct hid_bl_data *data, int brightness)
 	*field->value = brightness;
 	hid_hw_request(data->hdev, field->report, HID_REQ_SET_REPORT);
 	hid_hw_wait(data->hdev);
-	hid_dbg(data->hdev, "set brightness: %d\n", brightness);
 }
 
 static int hid_bl_update_status(struct backlight_device *bl)
@@ -157,8 +146,6 @@ static int hid_bl_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct backlight_properties props;
 	struct backlight_device *bl;
 
-	hid_dbg(hdev, "probe\n");
-
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "parse failed: %d\n", ret);
@@ -203,8 +190,6 @@ static int hid_bl_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto exit_stop;
 	}
 
-	hid_dbg(hdev, "Monitor VESA VCP with brightness control\n");
-
 	ret = hid_hw_open(hdev);
 	if (ret) {
 		hid_err(hdev, "hw open failed: %d\n", ret);
@@ -214,7 +199,7 @@ static int hid_bl_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	data = devm_kzalloc(&hdev->dev, sizeof(*data), GFP_KERNEL);
 	if (data == NULL) {
 		ret = -ENOMEM;
-		goto exit_stop;
+		goto exit_close;
 	}
 	data->hdev = hdev;
 	data->min_brightness = input_field->logical_minimum;
@@ -233,16 +218,15 @@ static int hid_bl_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (IS_ERR(bl)) {
 		ret = PTR_ERR(bl);
 		hid_err(hdev, "failed to register backlight: %d\n", ret);
-		goto exit_free;
+		goto exit_close;
 	}
 
 	hid_set_drvdata(hdev, bl);
 
 	return 0;
 
-exit_free:
+exit_close:
 	hid_hw_close(hdev);
-	devm_kfree(&hdev->dev, data);
 
 exit_stop:
 	hid_hw_stop(hdev);
