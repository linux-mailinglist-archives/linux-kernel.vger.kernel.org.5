Return-Path: <linux-kernel+bounces-161487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D01298B4CAA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443F71F2143F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BCA70CAA;
	Sun, 28 Apr 2024 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cS3M9jZ0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XfashZ9a"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC57F41A89;
	Sun, 28 Apr 2024 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714321437; cv=none; b=Ttc5mrUdSIhA099kf83RZvN8uctKgUkN8cY/gzbI10hYDSc42/KFjT6F4J3fimnDY8MS3AiO2to69/VOtt0MMzvXJ5w65t5+tOiKtQH1SAr41/iM9PSIEwIvACBtWu/xesU/1Aq8vSWO5nLr+r+c0wGn+DvrYs/Gw92nrshTanM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714321437; c=relaxed/simple;
	bh=yc+vVuIUbLEFGhTuY+aDcOSUawVz2veCXGwRNBZ7X7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g8ZpOJSTKPB961/6gmRUdeDBzmqlpVlKjK2cBL+wS+fuRu4E+/6W5nub3ybsEQ912W3cAtaO2fu86hcypdidh8jNtSqjCXJKKl4AVu8nAgQKd+wn2yQhmOoVhvqo5Mk1Cl3vq8lsiGFzvBl/4ep5Vy8zShEIq20VZLzUIKYeMXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=cS3M9jZ0; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=XfashZ9a; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VSBbl0sVrz9sb4;
	Sun, 28 Apr 2024 18:23:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1714321427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p+To69/YuoCEj84lC7oPWjntpUgI4yDYayfumx3cxfw=;
	b=cS3M9jZ0oQnqTHDunix2kfnhEopCLft7SoYMgUBpkPSxZVNJatnIAFZLqRoWhGo61pSRqi
	c+O+YewdG+TF7mj8x8MctWP0qmzyjZP2zhklAy0lftAfLN9fuytSguu9keQX0VUPpVEZTp
	cZGcj5a9DmRH2+SeQefr7AA730rAsAKFP2LIL+TLnV3tzqq9wMmT2pH+rYnC4e9WLbc+RC
	iNa2Jj2M7KQ7V8POoOezuvkeTxNbgNKsQTxC9FucxnyNylj8h+rZvkzm2Byq5z9u3AiHtt
	t7q/o1n+wGgVKZ/XWB7bXx4rdVt9xoMBJLM8Kjh7W5LqD+N3rF+pE31qsmigJw==
From: Joseph Strauss <jstrauss@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1714321425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p+To69/YuoCEj84lC7oPWjntpUgI4yDYayfumx3cxfw=;
	b=XfashZ9aL/gEGfGJnk+XZHl1CBdEHosJsAZ50kn3SxbOHwrKqAO0xOnONdcVtAi455eWLB
	NNz/DA2muJDc80UJhRGaVaLRaRuF5HWMUmoMyFlj720HVUbNYnE7igzNTR8vk24MNEmeXG
	9rw55eyfIBfk06klw0NpIWX/GLfMw/2a77QOdd2K5SUXjqSY5TmNXdheIaWVM4eSzCjQrP
	60ZeXW6gcKdSSOlo3MIXsGrsIiPVjWXoRB1I8/SuyqQPDkrUyfd5QeEDw3M1BTBZZzCPA1
	v/fQ55BLC9l7eP7htfLGaiho9QHdEvBZdb68fjMp/odffpbB58oGXNdFRzzzCg==
To: lee@kernel.org
Cc: pavel@ucw.cz,
	jansimon.moeller@gmx.de,
	conor@kernel.org,
	christophe.jaillet@wanadoo.fr,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joseph Strauss <jstrauss@mailbox.org>
Subject: [PATCH v6] Add multicolor support to BlinkM LED driver
Date: Sun, 28 Apr 2024 11:19:19 -0500
Message-ID: <20240428162309.32111-1-jstrauss@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8ugpatkmsuwe88djeq6m6uwrtphpeq1s
X-MBO-RS-ID: a57d1a4b37e2803753b
X-Rspamd-Queue-Id: 4VSBbl0sVrz9sb4

Add multicolor support to the BlinkM driver, making it easier to control
from userspace. The BlinkM LED is a programmable RGB LED. The driver
currently supports only the regular LED sysfs class, resulting in the
creation of three distinct classes, one for red, green, and blue. The
user then has to input three values into the three seperate brightness
files within those classes. The multicolor LED framework makes the
device easier to control with the multi_intensity file: the user can
input three values at once to form a color, while still controlling the
lightness with the brightness file.

The main struct blinkm_led has changed slightly. The struct led_classdev
for the regular sysfs classes remain. The blinkm_probe function checks
CONFIG_LEDS_BLINKM_MULTICOLOR to decide whether to load the seperate
sysfs classes or the single multicolor one, but never both. The
blinkm_set_mc_brightness() function had to be added to calculate the
three color components and then set the fields of the blinkm_data
structure accordingly.

Signed-off-by: Joseph Strauss <jstrauss@mailbox.org>
---
Changes in v2:
- Replaced instances of the constant 3 with NUM_LEDS, where applicable
- Fixed formatting errors
- Replaced loop inside of blinkm_set_mc_brightness() with equivalent
  statements
- Changed id of multicolor class from 4 to 3
- Replaced call to devm_kmalloc_array() with devm_kcalloc()
Changes in v3:
- Add CONFIG_LEDS_BLINKM_MULTICOLOR to check whether to use multicolor
  funcitonality
- Extend well-known-leds.txt to include standard names for RGB and indicator
  LEDS
- Change name of Blinkm sysfs class according to well-known-leds.txt
- Simplify struct blinkm_led and struct blinkm_data
- Remove magic numbers
- Fix formatting errors
- Remove unrelated changes
Changes in v4:
- Fix indentation
- Add default case to switch statement
Changes in v5:
- Fix warnings related to snprintf on s390 architecture, reported by
  0-DAY CI Kernel Test Service
Changes in v6:
- Refactored struct blinkm_led to use a union
- Refactored blinkm_probe()
- Clarified documentation

 Documentation/leds/leds-blinkm.rst     |  31 +++-
 Documentation/leds/well-known-leds.txt |   8 +
 drivers/leds/Kconfig                   |   8 +
 drivers/leds/leds-blinkm.c             | 223 +++++++++++++++++--------
 4 files changed, 198 insertions(+), 72 deletions(-)

diff --git a/Documentation/leds/leds-blinkm.rst b/Documentation/leds/leds-blinkm.rst
index c74b5bc877b1..5eb3a174ae18 100644
--- a/Documentation/leds/leds-blinkm.rst
+++ b/Documentation/leds/leds-blinkm.rst
@@ -13,9 +13,31 @@ The device accepts RGB and HSB color values through separate commands.
 Also you can store blinking sequences as "scripts" in
 the controller and run them. Also fading is an option.
 
-The interface this driver provides is 2-fold:
+The interface this driver provides is 3-fold:
 
-a) LED class interface for use with triggers
+a) LED multicolor class interface for use with triggers
+#######################################################
+
+The registration follows the scheme::
+
+  blinkm-<i2c-bus-nr>-<i2c-device-nr>:rgb:indicator
+
+  $ ls -h /sys/class/leds/blinkm-1-9:rgb:indicator
+  brightness  device  max_brightness  multi_index  multi_intensity  power  subsystem  trigger  uevent
+
+Hue is controlled by the multi_intensity file and lightness is controlled by
+the brightness file.
+
+The order in which to write the intensity values can be found in multi_index.
+Exactly three values between 0 and 255 must be written to multi_intensity to
+change the color::
+
+  $ echo 255 100 50 > multi_intensity
+
+The overall lightness be changed by writing a value between 0 and 255 to the
+brightness file.
+
+b) LED class interface for use with triggers
 ############################################
 
 The registration follows the scheme::
@@ -50,7 +72,7 @@ E.g.::
   $
 
 
-b) Sysfs group to control rgb, fade, hsb, scripts ...
+c) Sysfs group to control rgb, fade, hsb, scripts ...
 #####################################################
 
 This extended interface is available as folder blinkm
@@ -79,6 +101,7 @@ E.g.::
 
 
 
-as of 6/2012
+as of 01/2024
 
 dl9pf <at> gmx <dot> de
+jstrauss <at> mailbox <dot> org
diff --git a/Documentation/leds/well-known-leds.txt b/Documentation/leds/well-known-leds.txt
index 2160382c86be..2ac4eaed1454 100644
--- a/Documentation/leds/well-known-leds.txt
+++ b/Documentation/leds/well-known-leds.txt
@@ -70,3 +70,11 @@ Good: "platform:*:charging" (allwinner sun50i)
 * Screen
 
 Good: ":backlight" (Motorola Droid 4)
+
+* Indicators
+
+Good: ":indicator" (Blinkm)
+
+* RGB
+
+Good: ":rgb" (Blinkm)
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 499d0f215a8b..f38d786f9a89 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -736,6 +736,14 @@ config LEDS_BLINKM
 	  This option enables support for the BlinkM RGB LED connected
 	  through I2C. Say Y to enable support for the BlinkM LED.
 
+config LEDS_BLINKM_MULTICOLOR
+	bool "Enable multicolor support for BlinkM I2C RGB LED"
+	depends on LEDS_BLINKM
+	depends on LEDS_CLASS_MULTICOLOR
+	help
+	  This option enables multicolor sysfs class support for BlinkM LED and
+	  disables the older, separated sysfs interface
+
 config LEDS_POWERNV
 	tristate "LED support for PowerNV Platform"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/leds-blinkm.c b/drivers/leds/leds-blinkm.c
index e19cc8a7b7ca..6457a21bf77f 100644
--- a/drivers/leds/leds-blinkm.c
+++ b/drivers/leds/leds-blinkm.c
@@ -2,6 +2,7 @@
 /*
  *  leds-blinkm.c
  *  (c) Jan-Simon Möller (dl9pf@gmx.de)
+ *  (c) Joseph Strauss (jstrauss@mailbox.org)
  */
 
 #include <linux/module.h>
@@ -15,6 +16,10 @@
 #include <linux/pm_runtime.h>
 #include <linux/leds.h>
 #include <linux/delay.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/kconfig.h>
+
+#define NUM_LEDS 3
 
 /* Addresses to scan - BlinkM is on 0x09 by default*/
 static const unsigned short normal_i2c[] = { 0x09, I2C_CLIENT_END };
@@ -22,19 +27,26 @@ static const unsigned short normal_i2c[] = { 0x09, I2C_CLIENT_END };
 static int blinkm_transfer_hw(struct i2c_client *client, int cmd);
 static int blinkm_test_run(struct i2c_client *client);
 
+/* Contains data structures for both the color-seperated sysfs classes, and the new multicolor class */
 struct blinkm_led {
 	struct i2c_client *i2c_client;
-	struct led_classdev led_cdev;
+	union {
+		/* used when multicolor support is disabled */
+		struct led_classdev led_cdev;
+		struct led_classdev_mc mcled_cdev;
+	} cdev;
 	int id;
 };
 
-#define cdev_to_blmled(c)          container_of(c, struct blinkm_led, led_cdev)
+#define led_cdev_to_blmled(c)				container_of(c, struct blinkm_led, cdev.led_cdev)
+#define mcled_cdev_to_led(c)				container_of(c, struct blinkm_led, cdev.mcled_cdev)
 
 struct blinkm_data {
 	struct i2c_client *i2c_client;
 	struct mutex update_lock;
 	/* used for led class interface */
-	struct blinkm_led blinkm_leds[3];
+	struct blinkm_led blinkm_leds[NUM_LEDS];
+
 	/* used for "blinkm" sysfs interface */
 	u8 red;			/* color red */
 	u8 green;		/* color green */
@@ -419,11 +431,29 @@ static int blinkm_transfer_hw(struct i2c_client *client, int cmd)
 	return 0;
 }
 
+static int blinkm_set_mc_brightness(struct led_classdev *led_cdev,
+				 enum led_brightness value)
+{
+	struct led_classdev_mc *mcled_cdev = lcdev_to_mccdev(led_cdev);
+	struct blinkm_led *led = mcled_cdev_to_led(mcled_cdev);
+	struct blinkm_data *data = i2c_get_clientdata(led->i2c_client);
+
+	led_mc_calc_color_components(mcled_cdev, value);
+
+	data->next_red = (u8) mcled_cdev->subled_info[RED].brightness;
+	data->next_green = (u8) mcled_cdev->subled_info[GREEN].brightness;
+	data->next_blue = (u8) mcled_cdev->subled_info[BLUE].brightness;
+
+	blinkm_transfer_hw(led->i2c_client, BLM_GO_RGB);
+
+	return 0;
+}
+
 static int blinkm_led_common_set(struct led_classdev *led_cdev,
 				 enum led_brightness value, int color)
 {
 	/* led_brightness is 0, 127 or 255 - we just use it here as-is */
-	struct blinkm_led *led = cdev_to_blmled(led_cdev);
+	struct blinkm_led *led = led_cdev_to_blmled(led_cdev);
 	struct blinkm_data *data = i2c_get_clientdata(led->i2c_client);
 
 	switch (color) {
@@ -565,118 +595,175 @@ static int blinkm_detect(struct i2c_client *client, struct i2c_board_info *info)
 	return 0;
 }
 
-static int blinkm_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int register_seperate_colors(struct i2c_client *client, struct blinkm_data *data)
 {
-	struct blinkm_data *data;
-	struct blinkm_led *led[3];
-	int err, i;
+	/* 3 seperate classes for red, green, and blue respectively */
+	struct blinkm_led *leds[NUM_LEDS];
+	int err;
 	char blinkm_led_name[28];
-
-	data = devm_kzalloc(&client->dev,
-			sizeof(struct blinkm_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
-
-	data->i2c_addr = 0x08;
-	/* i2c addr  - use fake addr of 0x08 initially (real is 0x09) */
-	data->fw_ver = 0xfe;
-	/* firmware version - use fake until we read real value
-	 * (currently broken - BlinkM confused!) */
-	data->script_id = 0x01;
-	data->i2c_client = client;
-
-	i2c_set_clientdata(client, data);
-	mutex_init(&data->update_lock);
-
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &blinkm_group);
-	if (err < 0) {
-		dev_err(&client->dev, "couldn't register sysfs group\n");
-		goto exit;
-	}
-
-	for (i = 0; i < 3; i++) {
+	/* Register red, green, and blue sysfs classes */
+	for (int i = 0; i < NUM_LEDS; i++) {
 		/* RED = 0, GREEN = 1, BLUE = 2 */
-		led[i] = &data->blinkm_leds[i];
-		led[i]->i2c_client = client;
-		led[i]->id = i;
-		led[i]->led_cdev.max_brightness = 255;
-		led[i]->led_cdev.flags = LED_CORE_SUSPENDRESUME;
+		leds[i] = &data->blinkm_leds[i];
+		leds[i]->i2c_client = client;
+		leds[i]->id = i;
+		leds[i]->cdev.led_cdev.max_brightness = 255;
+		leds[i]->cdev.led_cdev.flags = LED_CORE_SUSPENDRESUME;
 		switch (i) {
 		case RED:
-			snprintf(blinkm_led_name, sizeof(blinkm_led_name),
+			scnprintf(blinkm_led_name, sizeof(blinkm_led_name),
 					 "blinkm-%d-%d-red",
 					 client->adapter->nr,
 					 client->addr);
-			led[i]->led_cdev.name = blinkm_led_name;
-			led[i]->led_cdev.brightness_set_blocking =
+			leds[i]->cdev.led_cdev.name = blinkm_led_name;
+			leds[i]->cdev.led_cdev.brightness_set_blocking =
 							blinkm_led_red_set;
 			err = led_classdev_register(&client->dev,
-						    &led[i]->led_cdev);
+							&leds[i]->cdev.led_cdev);
 			if (err < 0) {
 				dev_err(&client->dev,
 					"couldn't register LED %s\n",
-					led[i]->led_cdev.name);
+					leds[i]->cdev.led_cdev.name);
 				goto failred;
 			}
 			break;
 		case GREEN:
-			snprintf(blinkm_led_name, sizeof(blinkm_led_name),
+			scnprintf(blinkm_led_name, sizeof(blinkm_led_name),
 					 "blinkm-%d-%d-green",
 					 client->adapter->nr,
 					 client->addr);
-			led[i]->led_cdev.name = blinkm_led_name;
-			led[i]->led_cdev.brightness_set_blocking =
+			leds[i]->cdev.led_cdev.name = blinkm_led_name;
+			leds[i]->cdev.led_cdev.brightness_set_blocking =
 							blinkm_led_green_set;
 			err = led_classdev_register(&client->dev,
-						    &led[i]->led_cdev);
+						&leds[i]->cdev.led_cdev);
 			if (err < 0) {
 				dev_err(&client->dev,
 					"couldn't register LED %s\n",
-					led[i]->led_cdev.name);
+					leds[i]->cdev.led_cdev.name);
 				goto failgreen;
 			}
 			break;
 		case BLUE:
-			snprintf(blinkm_led_name, sizeof(blinkm_led_name),
+			scnprintf(blinkm_led_name, sizeof(blinkm_led_name),
 					 "blinkm-%d-%d-blue",
 					 client->adapter->nr,
 					 client->addr);
-			led[i]->led_cdev.name = blinkm_led_name;
-			led[i]->led_cdev.brightness_set_blocking =
+			leds[i]->cdev.led_cdev.name = blinkm_led_name;
+			leds[i]->cdev.led_cdev.brightness_set_blocking =
 							blinkm_led_blue_set;
 			err = led_classdev_register(&client->dev,
-						    &led[i]->led_cdev);
+							&leds[i]->cdev.led_cdev);
 			if (err < 0) {
 				dev_err(&client->dev,
 					"couldn't register LED %s\n",
-					led[i]->led_cdev.name);
+					leds[i]->cdev.led_cdev.name);
 				goto failblue;
 			}
 			break;
+		default:
+			break;
 		}		/* end switch */
 	}			/* end for */
-
-	/* Initialize the blinkm */
-	blinkm_init_hw(client);
-
 	return 0;
 
 failblue:
-	led_classdev_unregister(&led[GREEN]->led_cdev);
-
+	led_classdev_unregister(&leds[GREEN]->cdev.led_cdev);
 failgreen:
-	led_classdev_unregister(&led[RED]->led_cdev);
-
+	led_classdev_unregister(&leds[RED]->cdev.led_cdev);
 failred:
 	sysfs_remove_group(&client->dev.kobj, &blinkm_group);
-exit:
+
 	return err;
 }
 
+static int register_multicolor(struct i2c_client *client, struct blinkm_data *data)
+{
+	struct blinkm_led *mc_led;
+	struct mc_subled *mc_led_info;
+	char blinkm_led_name[28];
+	int err;
+
+	/* Register multicolor sysfs class */
+	/* The first element of leds is used for multicolor facilities */
+	mc_led = &data->blinkm_leds[RED];
+	mc_led->i2c_client = client;
+
+	mc_led_info = devm_kcalloc(&client->dev, NUM_LEDS, sizeof(*mc_led_info),
+					GFP_KERNEL);
+	if (!mc_led_info)
+		return -ENOMEM;
+
+	mc_led_info[RED].color_index = LED_COLOR_ID_RED;
+	mc_led_info[GREEN].color_index = LED_COLOR_ID_GREEN;
+	mc_led_info[BLUE].color_index = LED_COLOR_ID_BLUE;
+
+	mc_led->cdev.mcled_cdev.subled_info = mc_led_info;
+	mc_led->cdev.mcled_cdev.num_colors = NUM_LEDS;
+	mc_led->cdev.mcled_cdev.led_cdev.brightness = 255;
+	mc_led->cdev.mcled_cdev.led_cdev.max_brightness = 255;
+	mc_led->cdev.mcled_cdev.led_cdev.flags = LED_CORE_SUSPENDRESUME;
+
+	scnprintf(blinkm_led_name, sizeof(blinkm_led_name),
+		 "blinkm-%d-%d:rgb:indicator",
+		 client->adapter->nr,
+		 client->addr);
+	mc_led->cdev.mcled_cdev.led_cdev.name = blinkm_led_name;
+	mc_led->cdev.mcled_cdev.led_cdev.brightness_set_blocking = blinkm_set_mc_brightness;
+
+	err = led_classdev_multicolor_register(&client->dev, &mc_led->cdev.mcled_cdev);
+	if (err < 0) {
+		dev_err(&client->dev, "couldn't register LED %s\n",
+				mc_led->cdev.led_cdev.name);
+		sysfs_remove_group(&client->dev.kobj, &blinkm_group);
+	}
+	return 0;
+}
+
+
+static int blinkm_probe(struct i2c_client *client, const struct i2c_device_id * id) 
+{
+	struct blinkm_data *data;
+	int err;
+
+	data = devm_kzalloc(&client->dev,
+			sizeof(struct blinkm_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->i2c_addr = 0x08;
+	/* i2c addr  - use fake addr of 0x08 initially (real is 0x09) */
+	data->fw_ver = 0xfe;
+	/* firmware version - use fake until we read real value
+	 * (currently broken - BlinkM confused!) */
+	data->script_id = 0x01;
+	data->i2c_client = client;
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->update_lock);
+
+	/* Register sysfs hooks */
+	err = sysfs_create_group(&client->dev.kobj, &blinkm_group);
+	if (err < 0) {
+		dev_err(&client->dev, "couldn't register sysfs group\n");
+		return err;
+	}
+
+	if (!IS_ENABLED(CONFIG_LEDS_BLINKM_MULTICOLOR)) {
+		err = register_seperate_colors(client, data);
+		if (err < 0)
+			return err;
+	} else {
+		err = register_multicolor(client, data);
+		if (err < 0)
+			return err;
+	}
+
+	blinkm_init_hw(client);
+
+	return 0;
+}
+
 static void blinkm_remove(struct i2c_client *client)
 {
 	struct blinkm_data *data = i2c_get_clientdata(client);
@@ -684,8 +771,8 @@ static void blinkm_remove(struct i2c_client *client)
 	int i;
 
 	/* make sure no workqueue entries are pending */
-	for (i = 0; i < 3; i++)
-		led_classdev_unregister(&data->blinkm_leds[i].led_cdev);
+	for (i = 0; i < NUM_LEDS; i++)
+		led_classdev_unregister(&data->blinkm_leds[i].cdev.led_cdev);
 
 	/* reset rgb */
 	data->next_red = 0x00;
@@ -741,6 +828,6 @@ static struct i2c_driver blinkm_driver = {
 module_i2c_driver(blinkm_driver);
 
 MODULE_AUTHOR("Jan-Simon Moeller <dl9pf@gmx.de>");
+MODULE_AUTHOR("Joseph Strauss <jstrauss@mailbox.org>");
 MODULE_DESCRIPTION("BlinkM RGB LED driver");
 MODULE_LICENSE("GPL");
-
-- 
2.42.0


