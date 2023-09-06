Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA6D7939DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239072AbjIFK3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbjIFK3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:29:06 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F51171F;
        Wed,  6 Sep 2023 03:29:01 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a1d9b5dc64so96718766b.1;
        Wed, 06 Sep 2023 03:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693996140; x=1694600940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vd+9rnQ6cnFdF0qBt6D5Trk5JH+UbDhEI58U1iEBhMA=;
        b=qBTI3mYiATQo4KbW4OgQvGCjBmtHMr75NgabTMYrPLS5lGLWtTmN+Au0I1ULJZ6c4b
         yKV8sylxYnBsYTCDXRKTX6qM7MIJ3XvEUOuA0KVCpToHhdX+J1kW0l3waTf5S9UWcUp5
         XiHa+5ut9yWhpLVdLxa94xUcdITAsXNl9nTNkmnPx5YLyLadQ4qLi3HhsBwRZn6golWm
         byjbTiiXxOkFs7sBPfblulPIAHcXndFv+x7F/ypBnTAnUnIjBv+M5QcfzNoFVx1HkjdH
         qWn2sKL5YhmC6t+ljIdp9smHypbhzH6lQ9QjcV4onRN6C7iXVGce1T2zALjnvRvY3jd2
         Ialg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693996140; x=1694600940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vd+9rnQ6cnFdF0qBt6D5Trk5JH+UbDhEI58U1iEBhMA=;
        b=cg6alygPnTxa1na41qLf4mESX+7EHTK9Ao7EHcY2EqaWnVInuVkiVAaJh0kPpUx1bn
         nMK/mwkx+kzlFekwwOkb79zj31Qtvf7B+OVuNm/+iq0NBYh+da7N0tpzKMKqUWuF8X/P
         b2jfYLVXuimtDQtAJ7CAjscQ/vxmqNrXukxEnznWI/c+HlZMLFTuRWNY/A6OJUYTI4B4
         PrpaG4Y/IIsyFa2biw5Eg2nTss12R9R/T1mXoNQx2RLmEnb0D4r38Z7Rggh2B+yxfWGJ
         VPJsuYK0jZbAcR4RsLGD0dtoq/ldY6/9AxXv8gLzTuAGif4mgE9sG9cfPxl7TJm7MSPH
         7ooA==
X-Gm-Message-State: AOJu0Ywp4gAVqOXGXmpCM52Qh6j/+TM4FE65BAFHTSBG4ti/l2saXRFh
        iaGKgTL6FSbzBf45l6xp/D4=
X-Google-Smtp-Source: AGHT+IHk7wXUSF1Q5KAjgP3BY1kQH1aYC3amVZVzC8/fsZ7X7Opwm6Ke0yAW/xPMSUXxnmkLTaa5bQ==
X-Received: by 2002:a17:906:74d0:b0:9a1:c352:b6a3 with SMTP id z16-20020a17090674d000b009a1c352b6a3mr10153024ejl.7.1693996139997;
        Wed, 06 Sep 2023 03:28:59 -0700 (PDT)
Received: from desktop-nixos-martino.. ([2a01:e11:5004:180:d575:320e:c3b7:48cc])
        by smtp.gmail.com with ESMTPSA id lu7-20020a170906fac700b0099bcf1c07c6sm8827049ejb.138.2023.09.06.03.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:28:59 -0700 (PDT)
From:   Martino Fontana <tinozzo123@gmail.com>
To:     djogorchock@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Martino Fontana <tinozzo123@gmail.com>
Subject: [PATCH v2 RESEND] HID: nintendo: cleanup LED code
Date:   Wed,  6 Sep 2023 12:26:33 +0200
Message-ID: <20230906102831.16734-2-tinozzo123@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Only turn on the nth LED, instead of all the LEDs up to n. This better
  matches Nintendo consoles' behaviour, as they never turn on more than
  one LED.
  (Note that the behavior still consinsts in increasing the player number
  every time a controller is connected, never decreasing it. It should be
  as is described in https://bugzilla.kernel.org/show_bug.cgi?id=216225.
  However, any implementation here would stop making sense as soon as a
  non-Nintendo controller is connected, which is why I'm not bothering.)

- Split part of `joycon_home_led_brightness_set` (which is called by hid)
  into `joycon_set_home_led` (which is what actually sets the LEDs), for
  consistency with player LEDs.

- `joycon_player_led_brightness_set` won't try it to "determine which player
  led this is" anymore: it's already looking at every LED brightness value.

- Instead of first registering the `led_classdev`, then attempting to set
  the LED and unregistering the `led_classdev` if it fails, first attempt
  to set the LED, then register the `led_classdev` only if it succeeds
  (the class is still filled up in either case).

- If setting the player LEDs fails, still attempt setting the home LED.
  (I don't know there's a third party controller where this may actually
  happen, but who knows...)

- Use `JC_NUM_LEDS` where appropriate instead of 4.

- Print return codes in more places.

- Use spinlock instead of mutex for `input_num`. Copy its value to a local
  variable, so that it can be unlocked immediately.

- `input_num` starts counting from 0

- Less holding of mutexes in general.

Changes for v2:

Applied suggestions, commit message explains more stuff, restored `return ret`
when `devm_led_classdev_register` fails (since all other hid drivers do this).
If setting LED fails, `hid_warn` now explicitly says "skipping registration".

Signed-off-by: Martino Fontana <tinozzo123@gmail.com>
---
 drivers/hid/hid-nintendo.c | 117 ++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 60 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index a5ebe857a..dd7c7fce3 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -699,6 +699,25 @@ static int joycon_set_player_leds(struct joycon_ctlr *ctlr, u8 flash, u8 on)
 	return joycon_send_subcmd(ctlr, req, 1, HZ/4);
 }
 
+static int joycon_set_home_led(struct joycon_ctlr *ctlr, enum led_brightness brightness)
+{
+	struct joycon_subcmd_request *req;
+	u8 buffer[sizeof(*req) + 5] = { 0 };
+	u8 *data;
+
+	req = (struct joycon_subcmd_request *)buffer;
+	req->subcmd_id = JC_SUBCMD_SET_HOME_LIGHT;
+	data = req->data;
+	data[0] = 0x01;
+	data[1] = brightness << 4;
+	data[2] = brightness | (brightness << 4);
+	data[3] = 0x11;
+	data[4] = 0x11;
+
+	hid_dbg(ctlr->hdev, "setting home led brightness\n");
+	return joycon_send_subcmd(ctlr, req, 5, HZ/4);
+}
+
 static int joycon_request_spi_flash_read(struct joycon_ctlr *ctlr,
 					 u32 start_addr, u8 size, u8 **reply)
 {
@@ -1849,7 +1868,6 @@ static int joycon_player_led_brightness_set(struct led_classdev *led,
 	int val = 0;
 	int i;
 	int ret;
-	int num;
 
 	ctlr = hid_get_drvdata(hdev);
 	if (!ctlr) {
@@ -1857,21 +1875,10 @@ static int joycon_player_led_brightness_set(struct led_classdev *led,
 		return -ENODEV;
 	}
 
-	/* determine which player led this is */
-	for (num = 0; num < JC_NUM_LEDS; num++) {
-		if (&ctlr->leds[num] == led)
-			break;
-	}
-	if (num >= JC_NUM_LEDS)
-		return -EINVAL;
+	for (i = 0; i < JC_NUM_LEDS; i++)
+		val |= ctlr->leds[i].brightness << i;
 
 	mutex_lock(&ctlr->output_mutex);
-	for (i = 0; i < JC_NUM_LEDS; i++) {
-		if (i == num)
-			val |= brightness << i;
-		else
-			val |= ctlr->leds[i].brightness << i;
-	}
 	ret = joycon_set_player_leds(ctlr, 0, val);
 	mutex_unlock(&ctlr->output_mutex);
 
@@ -1884,9 +1891,6 @@ static int joycon_home_led_brightness_set(struct led_classdev *led,
 	struct device *dev = led->dev->parent;
 	struct hid_device *hdev = to_hid_device(dev);
 	struct joycon_ctlr *ctlr;
-	struct joycon_subcmd_request *req;
-	u8 buffer[sizeof(*req) + 5] = { 0 };
-	u8 *data;
 	int ret;
 
 	ctlr = hid_get_drvdata(hdev);
@@ -1894,25 +1898,13 @@ static int joycon_home_led_brightness_set(struct led_classdev *led,
 		hid_err(hdev, "No controller data\n");
 		return -ENODEV;
 	}
-
-	req = (struct joycon_subcmd_request *)buffer;
-	req->subcmd_id = JC_SUBCMD_SET_HOME_LIGHT;
-	data = req->data;
-	data[0] = 0x01;
-	data[1] = brightness << 4;
-	data[2] = brightness | (brightness << 4);
-	data[3] = 0x11;
-	data[4] = 0x11;
-
-	hid_dbg(hdev, "setting home led brightness\n");
 	mutex_lock(&ctlr->output_mutex);
-	ret = joycon_send_subcmd(ctlr, req, 5, HZ/4);
+	ret = joycon_set_home_led(ctlr, brightness);
 	mutex_unlock(&ctlr->output_mutex);
-
 	return ret;
 }
 
-static DEFINE_MUTEX(joycon_input_num_mutex);
+static DEFINE_SPINLOCK(joycon_input_num_spinlock);
 static int joycon_leds_create(struct joycon_ctlr *ctlr)
 {
 	struct hid_device *hdev = ctlr->hdev;
@@ -1920,17 +1912,16 @@ static int joycon_leds_create(struct joycon_ctlr *ctlr)
 	const char *d_name = dev_name(dev);
 	struct led_classdev *led;
 	char *name;
-	int ret = 0;
+	int ret;
 	int i;
-	static int input_num = 1;
+	unsigned long flags;
+	int player_led_number;
+	static int input_num;
 
-	/* Set the default controller player leds based on controller number */
-	mutex_lock(&joycon_input_num_mutex);
-	mutex_lock(&ctlr->output_mutex);
-	ret = joycon_set_player_leds(ctlr, 0, 0xF >> (4 - input_num));
-	if (ret)
-		hid_warn(ctlr->hdev, "Failed to set leds; ret=%d\n", ret);
-	mutex_unlock(&ctlr->output_mutex);
+	/* Set the player leds based on controller number */
+	spin_lock_irqsave(&joycon_input_num_spinlock, flags);
+	player_led_number = input_num++ % JC_NUM_LEDS;
+	spin_unlock_irqrestore(&joycon_input_num_spinlock, flags);
 
 	/* configure the player LEDs */
 	for (i = 0; i < JC_NUM_LEDS; i++) {
@@ -1938,31 +1929,34 @@ static int joycon_leds_create(struct joycon_ctlr *ctlr)
 				      d_name,
 				      "green",
 				      joycon_player_led_names[i]);
-		if (!name) {
-			mutex_unlock(&joycon_input_num_mutex);
+		if (!name)
 			return -ENOMEM;
-		}
 
 		led = &ctlr->leds[i];
 		led->name = name;
-		led->brightness = ((i + 1) <= input_num) ? 1 : 0;
+		led->brightness = (i == player_led_number) ? 1 : 0;
 		led->max_brightness = 1;
 		led->brightness_set_blocking =
 					joycon_player_led_brightness_set;
 		led->flags = LED_CORE_SUSPENDRESUME | LED_HW_PLUGGABLE;
+	}
+	mutex_lock(&ctlr->output_mutex);
+	ret = joycon_set_player_leds(ctlr, 0, 0x1 << player_led_number);
+	mutex_unlock(&ctlr->output_mutex);
+	if (ret) {
+		hid_warn(hdev, "Failed to set players LEDs, skipping registration; ret=%d\n", ret);
+		goto home_led;
+	}
 
+	for (i = 0; i < JC_NUM_LEDS; i++) {
+		led = &ctlr->leds[i];
 		ret = devm_led_classdev_register(&hdev->dev, led);
-		if (ret) {
-			hid_err(hdev, "Failed registering %s LED\n", led->name);
-			mutex_unlock(&joycon_input_num_mutex);
+		if (ret)
+			hid_err(hdev, "Failed to register player %d LED; ret=%d\n", i + 1, ret);
 			return ret;
-		}
 	}
 
-	if (++input_num > 4)
-		input_num = 1;
-	mutex_unlock(&joycon_input_num_mutex);
-
+home_led:
 	/* configure the home LED */
 	if (jc_type_has_right(ctlr)) {
 		name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s:%s",
@@ -1978,17 +1972,20 @@ static int joycon_leds_create(struct joycon_ctlr *ctlr)
 		led->max_brightness = 0xF;
 		led->brightness_set_blocking = joycon_home_led_brightness_set;
 		led->flags = LED_CORE_SUSPENDRESUME | LED_HW_PLUGGABLE;
-		ret = devm_led_classdev_register(&hdev->dev, led);
-		if (ret) {
-			hid_err(hdev, "Failed registering home led\n");
-			return ret;
-		}
+
 		/* Set the home LED to 0 as default state */
-		ret = joycon_home_led_brightness_set(led, 0);
+		mutex_lock(&ctlr->output_mutex);
+		ret = joycon_set_home_led(ctlr, 0);
+		mutex_unlock(&ctlr->output_mutex);
 		if (ret) {
-			hid_warn(hdev, "Failed to set home LED default, unregistering home LED");
-			devm_led_classdev_unregister(&hdev->dev, led);
+			hid_warn(hdev, "Failed to set home LED, skipping registration; ret=%d\n", ret);
+			return 0;
 		}
+
+		ret = devm_led_classdev_register(&hdev->dev, led);
+		if (ret)
+			hid_err(hdev, "Failed to register home LED; ret=%d\n", ret);
+			return ret
 	}
 
 	return 0;
-- 
2.41.0

