Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB817AC9F1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 16:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjIXOQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 10:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjIXOQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 10:16:26 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102DBAB;
        Sun, 24 Sep 2023 07:16:19 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bbbe81185dso15834741fa.0;
        Sun, 24 Sep 2023 07:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695564977; x=1696169777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mloVG+vDINJ90n4uGIjDe8N4nrGZXHgD5DW4er1MCho=;
        b=VvF3uL1XHtQQyIa1YwbDVOAdybUyKVXPJDsTtiYh2ebK2lt3oAwoixJlzwT0LPou7O
         KxgyR7mlt529hFMEGEQ79AGNE7eb1U7IH1QlaCU613o3FDwDEjUwDoPWhrxMahl9Arxf
         l3XnsXUGNx74YKumZ/nOJpoYOJKp3tD5H4VijbYQoELsrPutxz21tX9vRQbPB3hUBTqc
         V4zLvQhKit8whwsOL+OXapYXZ9WU6kuQ/8NufDAIoG291jngkzcEHBsnrjAhHzYnJSF8
         zmUWZgjxU7+NYhl2KZwx5WM8vdOfnFaqs0PG/sYFBohbAr70R0sfzhtzwdKpYH+sF5Q/
         aDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695564977; x=1696169777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mloVG+vDINJ90n4uGIjDe8N4nrGZXHgD5DW4er1MCho=;
        b=GyZz6ji1hiCBIjax7yd4DAohH1KW4G7vxvdRurYZr2IShThN7K3PevEy+uhy7HxSJL
         fTNL1CqfMNbhRDAfEGAvBexaSnQtTnoEAPvIjnNEWHcS13pBxDZ00KZqPq1GJZuZwRsn
         CiE5rNKn9u7I3ev03OopdCtOYEcJ18WadL/vdTxEjhRd+0GvT9T0ll68cjEAAhgmj8PR
         XaNrKO3zDMIKObbnQt7mCe/MsUkVevTLggmvTg4pKl4Apdnp+sZtjecLYmqER3+tujiv
         vpBydyP+kb2+1ZfDLaZgeaT4aITXW9u96UZsXUy1rcuW4GR+u0tZzcqDLASeI6qOKjJb
         t1Uw==
X-Gm-Message-State: AOJu0Yxl3Zu2uCI/BuGXNdix3toKUMETslG6t/9KOxSbKefCVzlW8sWD
        yRif4j2eI5AK1OFyBM/X8Ck=
X-Google-Smtp-Source: AGHT+IGUXDHP1Ctigv/7ojXpuavkEOH6w5xyJB4UuxTmjhSKeOTT+4y86wdsbasd0QRe/pj2Nd6gFA==
X-Received: by 2002:a2e:be09:0:b0:2be:6262:36f1 with SMTP id z9-20020a2ebe09000000b002be626236f1mr3557872ljq.5.1695564976842;
        Sun, 24 Sep 2023 07:16:16 -0700 (PDT)
Received: from desktop-nixos-martino.. ([2a01:e11:5004:180::bd5a:12c2])
        by smtp.gmail.com with ESMTPSA id zg22-20020a170907249600b009a5f1d15642sm5043433ejb.158.2023.09.24.07.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 07:16:16 -0700 (PDT)
From:   Martino Fontana <tinozzo123@gmail.com>
To:     djogorchock@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Martino Fontana <tinozzo123@gmail.com>
Subject: [PATCH v5 RESEND] HID: nintendo: cleanup LED code
Date:   Sun, 24 Sep 2023 16:13:34 +0200
Message-ID: <20230924141547.11597-1-tinozzo123@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Support player LED patterns up to 8 players.
  (Note that the behavior still consinsts in increasing the player number
  every time a controller is connected, never decreasing it. It should be
  as is described in https://bugzilla.kernel.org/show_bug.cgi?id=216225.
  However, any implementation here would stop making sense as soon as a
  non-Nintendo controller is connected, which is why I'm not bothering.)

- Split part of `joycon_home_led_brightness_set` (which is called by hid)
  into `joycon_set_home_led` (which is what actually sets the LEDs), for
  consistency with player LEDs.

- `joycon_player_led_brightness_set` won't try it to "determine which
  player led this is" anymore: it's already looking at every LED
  brightness value.

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

Signed-off-by: Martino Fontana <tinozzo123@gmail.com>
---
Changes for v2:

Applied suggestions, commit message explains more stuff, restored `return ret`
when `devm_led_classdev_register` fails (since all other hid drivers do this).
If setting LED fails, `hid_warn` now explicitly says "skipping registration".

Changes for v3 and v4:

Fixed errors and warnings from test robot.

Changes for v5:

I thought that when connecting the controller on an actual Nintendo Switch,
only the nth player LED would turn on, which is true... on Wii and Wii U.
So I reverted that, and to compensate, now this supports the LED patterns
up to 8 players.

 drivers/hid/hid-nintendo.c | 133 +++++++++++++++++++++----------------
 1 file changed, 76 insertions(+), 57 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 10468f727..138f154fe 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -410,6 +410,18 @@ static const char * const joycon_player_led_names[] = {
 	LED_FUNCTION_PLAYER4,
 };
 #define JC_NUM_LEDS		ARRAY_SIZE(joycon_player_led_names)
+#define JC_NUM_LED_PATTERNS 8
+/* Taken from https://www.nintendo.com/my/support/qa/detail/33822 */
+static const enum led_brightness joycon_player_led_patterns[JC_NUM_LED_PATTERNS][JC_NUM_LEDS] = {
+	{ 1, 0, 0, 0 },
+	{ 1, 1, 0, 0 },
+	{ 1, 1, 1, 0 },
+	{ 1, 1, 1, 1 },
+	{ 1, 0, 0, 1 },
+	{ 1, 0, 1, 0 },
+	{ 1, 0, 1, 1 },
+	{ 0, 1, 1, 0 },
+};
 
 /* Each physical controller is associated with a joycon_ctlr struct */
 struct joycon_ctlr {
@@ -699,6 +711,25 @@ static int joycon_set_player_leds(struct joycon_ctlr *ctlr, u8 flash, u8 on)
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
@@ -1840,6 +1871,7 @@ static int joycon_input_create(struct joycon_ctlr *ctlr)
 	return 0;
 }
 
+/* Because the subcommand sets all the leds at once, the brightness argument is ignored */
 static int joycon_player_led_brightness_set(struct led_classdev *led,
 					    enum led_brightness brightness)
 {
@@ -1849,7 +1881,6 @@ static int joycon_player_led_brightness_set(struct led_classdev *led,
 	int val = 0;
 	int i;
 	int ret;
-	int num;
 
 	ctlr = hid_get_drvdata(hdev);
 	if (!ctlr) {
@@ -1857,21 +1888,10 @@ static int joycon_player_led_brightness_set(struct led_classdev *led,
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
 
@@ -1884,9 +1904,6 @@ static int joycon_home_led_brightness_set(struct led_classdev *led,
 	struct device *dev = led->dev->parent;
 	struct hid_device *hdev = to_hid_device(dev);
 	struct joycon_ctlr *ctlr;
-	struct joycon_subcmd_request *req;
-	u8 buffer[sizeof(*req) + 5] = { 0 };
-	u8 *data;
 	int ret;
 
 	ctlr = hid_get_drvdata(hdev);
@@ -1894,43 +1911,35 @@ static int joycon_home_led_brightness_set(struct led_classdev *led,
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
 	struct device *dev = &hdev->dev;
 	const char *d_name = dev_name(dev);
 	struct led_classdev *led;
+	int led_val = 0;
 	char *name;
-	int ret = 0;
+	int ret;
 	int i;
-	static int input_num = 1;
+	unsigned long flags;
+	int player_led_pattern;
+	static int input_num;
 
-	/* Set the default controller player leds based on controller number */
-	mutex_lock(&joycon_input_num_mutex);
-	mutex_lock(&ctlr->output_mutex);
-	ret = joycon_set_player_leds(ctlr, 0, 0xF >> (4 - input_num));
-	if (ret)
-		hid_warn(ctlr->hdev, "Failed to set leds; ret=%d\n", ret);
-	mutex_unlock(&ctlr->output_mutex);
+	/*
+	 * Set the player leds based on controller number
+	 * Because there is no standard concept of "player number", the pattern
+	 * number will simply increase by 1 every time a controller is connected.
+	 */
+	spin_lock_irqsave(&joycon_input_num_spinlock, flags);
+	player_led_pattern = input_num++ % JC_NUM_LED_PATTERNS;
+	spin_unlock_irqrestore(&joycon_input_num_spinlock, flags);
 
 	/* configure the player LEDs */
 	for (i = 0; i < JC_NUM_LEDS; i++) {
@@ -1938,31 +1947,37 @@ static int joycon_leds_create(struct joycon_ctlr *ctlr)
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
+		led->brightness = joycon_player_led_patterns[player_led_pattern][i];
 		led->max_brightness = 1;
 		led->brightness_set_blocking =
 					joycon_player_led_brightness_set;
 		led->flags = LED_CORE_SUSPENDRESUME | LED_HW_PLUGGABLE;
 
+		led_val |= joycon_player_led_patterns[player_led_pattern][i] << i;
+	}
+	mutex_lock(&ctlr->output_mutex);
+	ret = joycon_set_player_leds(ctlr, 0, led_val);
+	mutex_unlock(&ctlr->output_mutex);
+	if (ret) {
+		hid_warn(hdev, "Failed to set players LEDs, skipping registration; ret=%d\n", ret);
+		goto home_led;
+	}
+
+	for (i = 0; i < JC_NUM_LEDS; i++) {
+		led = &ctlr->leds[i];
 		ret = devm_led_classdev_register(&hdev->dev, led);
 		if (ret) {
-			hid_err(hdev, "Failed registering %s LED\n", led->name);
-			mutex_unlock(&joycon_input_num_mutex);
+			hid_err(hdev, "Failed to register player %d LED; ret=%d\n", i + 1, ret);
 			return ret;
 		}
 	}
 
-	if (++input_num > 4)
-		input_num = 1;
-	mutex_unlock(&joycon_input_num_mutex);
-
+home_led:
 	/* configure the home LED */
 	if (jc_type_has_right(ctlr)) {
 		name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s:%s",
@@ -1978,16 +1993,20 @@ static int joycon_leds_create(struct joycon_ctlr *ctlr)
 		led->max_brightness = 0xF;
 		led->brightness_set_blocking = joycon_home_led_brightness_set;
 		led->flags = LED_CORE_SUSPENDRESUME | LED_HW_PLUGGABLE;
-		ret = devm_led_classdev_register(&hdev->dev, led);
+
+		/* Set the home LED to 0 as default state */
+		mutex_lock(&ctlr->output_mutex);
+		ret = joycon_set_home_led(ctlr, 0);
+		mutex_unlock(&ctlr->output_mutex);
 		if (ret) {
-			hid_err(hdev, "Failed registering home led\n");
-			return ret;
+			hid_warn(hdev, "Failed to set home LED, skipping registration; ret=%d\n", ret);
+			return 0;
 		}
-		/* Set the home LED to 0 as default state */
-		ret = joycon_home_led_brightness_set(led, 0);
+
+		ret = devm_led_classdev_register(&hdev->dev, led);
 		if (ret) {
-			hid_warn(hdev, "Failed to set home LED default, unregistering home LED");
-			devm_led_classdev_unregister(&hdev->dev, led);
+			hid_err(hdev, "Failed to register home LED; ret=%d\n", ret);
+			return ret;
 		}
 	}
 
-- 
2.42.0

