Return-Path: <linux-kernel+bounces-65693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43EA855084
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94BD1C29065
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606EA60DFD;
	Wed, 14 Feb 2024 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ycOBkUH8"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD7184A42;
	Wed, 14 Feb 2024 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932380; cv=none; b=kxLrTkRYVfjxxsACdrncLYXUNvq40z4zx55uGO2vrbSu+5Bn6mUsNgLIskTi45oDTZVZ3QYv2PV31F8zEsU9PeQMJPatCWvpTwUjwTgzRf2btYK42JUHMwouPh5IiLwlQ6isDfLwwEn14pGbuQCeEyda3yfaPXmBSIRurV7dMx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932380; c=relaxed/simple;
	bh=omdx/KfJlhaUg2u12dhwnl25Wgh51BntVoM2oQsGza0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsBQ2WocAjDEHlQcj+4HaAkAWjtj86Mo4HuXLGdOEEEcDeQva7nzesLujff09wi/pTB46JX3uAXQlulI9/K45i3HTUvf/2yQqMi+8Qyfo3xu/FirIilHInv3BnJgfZ3zUPkmaALlbbR7fEWv0BXc5Du9eBYlNc21ztgXnrjQ1Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ycOBkUH8; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TZlnL0dzvz9sqY;
	Wed, 14 Feb 2024 18:39:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1707932374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+tWbN3qeaS5+lZ7/75AZYJL9TeOIJPH2xLl7EVlSvbU=;
	b=ycOBkUH8ldIvxz3yeACyrVo3x7lXOdz/d2eEwKWzi4MuiR+/M2QVE2dfA1NocSV41tSs7u
	r39+hkxLCR7/9jDIfeluXcHNN54IAjQje13ujkDU25nqEeGAgoNJqJc4TcU5tXNKZW58cQ
	jAxaURh/MLj2DLXIDXS/eAJnqs5D8+1LqHgu5gyApQWhU8Bivme1dA5q1KiCI+FtxgZyQo
	1SunABC6F0ItM8ucXjyItqW5SRrAC2x/HsflLcBJPH8G7+Cbx5n5q4G4FcYCo9d3V/ZMHn
	Y5Y70m5kIHqodFxA7ojuqSUBxBSKb066U8Upseiy4rb/nzMomMq6zqmG20sGjQ==
Date: Wed, 14 Feb 2024 11:39:28 -0600
From: Joseph Strauss <jstrauss@mailbox.org>
To: Lee Jones <lee@kernel.org>
Cc: pavel@ucw.cz, jansimon.moeller@gmx.de, conor@kernel.org, 
	christophe.jaillet@wanadoo.fr, linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] Add multicolor support to BlinkM LED driver
Message-ID: <elbxycn3r5defipgo2ae4bjoo2zqipzf6yjv7vhuoo4chs2ybb@ksugpxnygvu3>
References: <20240114190652.7109-2-jstrauss@mailbox.org>
 <20240125132212.GH74950@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240125132212.GH74950@google.com>
X-MBO-RS-ID: d4c31249701a819d11f
X-MBO-RS-META: irj5gps14ns4up6jkpqux75nu6puq9r1

On 24/01/25 01:22PM, Lee Jones wrote:
> On Sun, 14 Jan 2024, Joseph Strauss wrote:
> 
> > Add multicolor support to the BlinkM driver, making it easier to control
> > from userspace. The BlinkM LED is a programmable RGB LED. The driver
> > currently supports only the regular LED sysfs class, resulting in the
> > creation of three distinct classes, one for red, green, and blue. The
> > user then has to input three values into the three seperate brightness
> > files within those classes. The multicolor LED framework makes the
> > device easier to control with the multi_intensity file: the user can
> > input three values at once to form a color, while still controlling the
> > lightness with the brightness file.
> > 
> > The main struct blinkm_led has changed slightly. The struct led_classdev
> > for the regular sysfs classes remain. The blinkm_probe function checks
> > CONFIG_LEDS_BLINKM_MULTICOLOR to decide whether to load the seperate
> > sysfs classes or the single multicolor one, but never both. The
> > blinkm_set_mc_brightness() function had to be added to calculate the
> > three color components and then set the fields of the blinkm_data
> > structure accordingly.
> > 
> > All of the feedback has been much appreciated. Thanks!
> 
> This needs to go below the '---'.
> 
> So you've had feedback but no positive reviews resulting in a *-by?
Correct, I've received feedback, but no positive reviews.
> 
> Have you Cc:ed all of your reviewers in this version?
> 
> > Signed-off-by: Joseph Strauss <jstrauss@mailbox.org>
> > ---
> > Changes in v2:
> > - Replaced instances of the constant 3 with NUM_LEDS, where applicable
> > - Fixed formatting errors
> > - Replaced loop inside of blinkm_set_mc_brightness() with equivalent
> >   statements
> > - Changed id of multicolor class from 4 to 3
> > - Replaced call to devm_kmalloc_array() with devm_kcalloc()
> > Changes in v3:
> > - Add CONFIG_LEDS_BLINKM_MULTICOLOR to check whether to use multicolor
> >   funcitonality
> > - Extend well-known-leds.txt to include standard names for RGB and indicator
> >   LEDS
> > - Change name of Blinkm sysfs class according to well-known-leds.txt
> > - Simplify struct blinkm_led and struct blinkm_data
> > - Remove magic numbers
> > - Fix formatting errors
> > - Remove unrelated changes
> > Changes in v4:
> > - Fix indentation
> > - Add default case to switch statement
> > Changes in v5:
> > - Fix warnings related to snprintf on s390 architecture, reported by
> >   0-DAY CI Kernel Test Service
> > 
> >  Documentation/leds/leds-blinkm.rst     |  27 ++-
> >  Documentation/leds/well-known-leds.txt |   8 +
> >  drivers/leds/Kconfig                   |   8 +
> >  drivers/leds/leds-blinkm.c             | 217 +++++++++++++++++--------
> >  4 files changed, 185 insertions(+), 75 deletions(-)
> 
> Looking pretty good.  Just a couple of minor nits.
> 
> > diff --git a/Documentation/leds/leds-blinkm.rst b/Documentation/leds/leds-blinkm.rst
> > index c74b5bc877b1..16883c2a9a99 100644
> > --- a/Documentation/leds/leds-blinkm.rst
> > +++ b/Documentation/leds/leds-blinkm.rst
> > @@ -13,9 +13,27 @@ The device accepts RGB and HSB color values through separate commands.
> >  Also you can store blinking sequences as "scripts" in
> >  the controller and run them. Also fading is an option.
> >  
> > -The interface this driver provides is 2-fold:
> > +The interface this driver provides is 3-fold:
> >  
> > -a) LED class interface for use with triggers
> > +a) LED multicolor class interface for use with triggers
> > +#######################################################
> > +
> > +The registration follows the scheme::
> > +
> > +  blinkm-<i2c-bus-nr>-<i2c-device-nr>:rgb:indicator
> > +
> > +  $ ls -h /sys/class/leds/blinkm-1-9:rgb:indicator
> 
> The `-h` is superfluous, no?
The current leds-blinkm.rst documentation file uses `ls -h` in several
other places, so I continued the pattern. But it does seem superfluous.
Would it be better to remove the `-h` only from the line I added, or the
other instances as well?
> 
> > +  brightness  device  max_brightness  multi_index  multi_intensity  power  subsystem  trigger  uevent
> > +
> > +The order in which to write the intensity values can be found in multi_index.
> > +Exactly three values between 0 and 255 must be written to multi_intensity to change the color::
> 
> :: ?
I used :: here because I thought a shell command should be shown as
code in the documentation.
> 
> > +
> > +  $ echo 255 100 50 > multi_intensity
> > +
> > +The overall brightness of the color that you choose can also be changed by
> > +writing a value between 0 and 255 to the brightness file.
> 
> So what's the difference between brightness and intensity?
Documentation/leds/leds-class-multicolor.rst describes the
multi_intensity file as controlling the hue of the LED, whereas the
brightness file controls the lightness. I could change my documentation
to say "The overall lightness of the color that you choose..." to
clarify that.
> 
> > +b) LED class interface for use with triggers
> >  ############################################
> >  
> >  The registration follows the scheme::
> > @@ -50,7 +68,7 @@ E.g.::
> >    $
> >  
> >  
> > -b) Sysfs group to control rgb, fade, hsb, scripts ...
> > +c) Sysfs group to control rgb, fade, hsb, scripts ...
> >  #####################################################
> >  
> >  This extended interface is available as folder blinkm
> > @@ -79,6 +97,7 @@ E.g.::
> >  
> >  
> >  
> > -as of 6/2012
> > +as of 01/2024
> >  
> >  dl9pf <at> gmx <dot> de
> > +jstrauss <at> mailbox <dot> org
> > diff --git a/Documentation/leds/well-known-leds.txt b/Documentation/leds/well-known-leds.txt
> > index 2160382c86be..2ac4eaed1454 100644
> > --- a/Documentation/leds/well-known-leds.txt
> > +++ b/Documentation/leds/well-known-leds.txt
> > @@ -70,3 +70,11 @@ Good: "platform:*:charging" (allwinner sun50i)
> >  * Screen
> >  
> >  Good: ":backlight" (Motorola Droid 4)
> > +
> > +* Indicators
> > +
> > +Good: ":indicator" (Blinkm)
> > +
> > +* RGB
> > +
> > +Good: ":rgb" (Blinkm)
> > diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> > index 499d0f215a8b..f38d786f9a89 100644
> > --- a/drivers/leds/Kconfig
> > +++ b/drivers/leds/Kconfig
> > @@ -736,6 +736,14 @@ config LEDS_BLINKM
> >  	  This option enables support for the BlinkM RGB LED connected
> >  	  through I2C. Say Y to enable support for the BlinkM LED.
> >  
> > +config LEDS_BLINKM_MULTICOLOR
> > +	bool "Enable multicolor support for BlinkM I2C RGB LED"
> > +	depends on LEDS_BLINKM
> > +	depends on LEDS_CLASS_MULTICOLOR
> > +	help
> > +	  This option enables multicolor sysfs class support for BlinkM LED and
> > +	  disables the older, separated sysfs interface
> > +
> >  config LEDS_POWERNV
> >  	tristate "LED support for PowerNV Platform"
> >  	depends on LEDS_CLASS
> > diff --git a/drivers/leds/leds-blinkm.c b/drivers/leds/leds-blinkm.c
> > index e19cc8a7b7ca..d6ce2cccb816 100644
> > --- a/drivers/leds/leds-blinkm.c
> > +++ b/drivers/leds/leds-blinkm.c
> > @@ -2,6 +2,7 @@
> >  /*
> >   *  leds-blinkm.c
> >   *  (c) Jan-Simon Möller (dl9pf@gmx.de)
> > + *  (c) Joseph Strauss (jstrauss@mailbox.org)
> >   */
> >  
> >  #include <linux/module.h>
> > @@ -15,6 +16,10 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/leds.h>
> >  #include <linux/delay.h>
> > +#include <linux/led-class-multicolor.h>
> > +#include <linux/kconfig.h>
> > +
> > +#define NUM_LEDS 3
> >  
> >  /* Addresses to scan - BlinkM is on 0x09 by default*/
> >  static const unsigned short normal_i2c[] = { 0x09, I2C_CLIENT_END };
> > @@ -22,19 +27,24 @@ static const unsigned short normal_i2c[] = { 0x09, I2C_CLIENT_END };
> >  static int blinkm_transfer_hw(struct i2c_client *client, int cmd);
> >  static int blinkm_test_run(struct i2c_client *client);
> >  
> > +/* Contains data structures for both the color-seperated sysfs classes, and the new multicolor class */
> >  struct blinkm_led {
> >  	struct i2c_client *i2c_client;
> > +	/* used when multicolor support is disabled */
> 
> There's a syntax for either/or in structs.  Isn't it 'union'?
> 
> Can/does that apply here?
Yes, I think that would be applicable. led_cdev and mcled_cdev are used
in two seperate cases.
> 
> >  	struct led_classdev led_cdev;
> > +	struct led_classdev_mc mcled_cdev;
> >  	int id;
> >  };
> >  
> > -#define cdev_to_blmled(c)          container_of(c, struct blinkm_led, led_cdev)
> > +#define led_cdev_to_blmled(c)				container_of(c, struct blinkm_led, led_cdev)
> > +#define mcled_cdev_to_led(c)				container_of(c, struct blinkm_led, mcled_cdev)
> >  
> >  struct blinkm_data {
> >  	struct i2c_client *i2c_client;
> >  	struct mutex update_lock;
> >  	/* used for led class interface */
> > -	struct blinkm_led blinkm_leds[3];
> > +	struct blinkm_led blinkm_leds[NUM_LEDS];
> > +
> >  	/* used for "blinkm" sysfs interface */
> >  	u8 red;			/* color red */
> >  	u8 green;		/* color green */
> > @@ -419,11 +429,29 @@ static int blinkm_transfer_hw(struct i2c_client *client, int cmd)
> >  	return 0;
> >  }
> >  
> > +static int blinkm_set_mc_brightness(struct led_classdev *led_cdev,
> > +				 enum led_brightness value)
> > +{
> > +	struct led_classdev_mc *mcled_cdev = lcdev_to_mccdev(led_cdev);
> > +	struct blinkm_led *led = mcled_cdev_to_led(mcled_cdev);
> > +	struct blinkm_data *data = i2c_get_clientdata(led->i2c_client);
> > +
> > +	led_mc_calc_color_components(mcled_cdev, value);
> > +
> > +	data->next_red = (u8) mcled_cdev->subled_info[RED].brightness;
> > +	data->next_green = (u8) mcled_cdev->subled_info[GREEN].brightness;
> > +	data->next_blue = (u8) mcled_cdev->subled_info[BLUE].brightness;
> > +
> > +	blinkm_transfer_hw(led->i2c_client, BLM_GO_RGB);
> > +
> > +	return 0;
> > +}
> > +
> >  static int blinkm_led_common_set(struct led_classdev *led_cdev,
> >  				 enum led_brightness value, int color)
> >  {
> >  	/* led_brightness is 0, 127 or 255 - we just use it here as-is */
> > -	struct blinkm_led *led = cdev_to_blmled(led_cdev);
> > +	struct blinkm_led *led = led_cdev_to_blmled(led_cdev);
> >  	struct blinkm_data *data = i2c_get_clientdata(led->i2c_client);
> >  
> >  	switch (color) {
> > @@ -569,7 +597,11 @@ static int blinkm_probe(struct i2c_client *client,
> >  			const struct i2c_device_id *id)
> >  {
> >  	struct blinkm_data *data;
> > -	struct blinkm_led *led[3];
> > +	/* For multicolor support */
> > +	struct blinkm_led *mc_led;
> > +	struct mc_subled *mc_led_info;
> > +	/* 3 seperate classes for red, green, and blue respectively */
> > +	struct blinkm_led *leds[NUM_LEDS];
> >  	int err, i;
> >  	char blinkm_led_name[28];
> >  
> > @@ -580,6 +612,12 @@ static int blinkm_probe(struct i2c_client *client,
> >  		goto exit;
> >  	}
> >  
> > +	mc_led_info = devm_kcalloc(&client->dev, NUM_LEDS, sizeof(*mc_led_info),
> > +					GFP_KERNEL);
> > +	if (!mc_led_info) {
> > +		err = -ENOMEM;
> > +		goto exit;
> > +	}
> >  	data->i2c_addr = 0x08;
> >  	/* i2c addr  - use fake addr of 0x08 initially (real is 0x09) */
> >  	data->fw_ver = 0xfe;
> > @@ -598,81 +636,118 @@ static int blinkm_probe(struct i2c_client *client,
> >  		goto exit;
> >  	}
> >  
> > -	for (i = 0; i < 3; i++) {
> > -		/* RED = 0, GREEN = 1, BLUE = 2 */
> > -		led[i] = &data->blinkm_leds[i];
> > -		led[i]->i2c_client = client;
> > -		led[i]->id = i;
> > -		led[i]->led_cdev.max_brightness = 255;
> > -		led[i]->led_cdev.flags = LED_CORE_SUSPENDRESUME;
> > -		switch (i) {
> > -		case RED:
> > -			snprintf(blinkm_led_name, sizeof(blinkm_led_name),
> > -					 "blinkm-%d-%d-red",
> > -					 client->adapter->nr,
> > -					 client->addr);
> > -			led[i]->led_cdev.name = blinkm_led_name;
> > -			led[i]->led_cdev.brightness_set_blocking =
> > -							blinkm_led_red_set;
> > -			err = led_classdev_register(&client->dev,
> > -						    &led[i]->led_cdev);
> > -			if (err < 0) {
> > -				dev_err(&client->dev,
> > -					"couldn't register LED %s\n",
> > -					led[i]->led_cdev.name);
> > -				goto failred;
> > -			}
> > -			break;
> > -		case GREEN:
> > -			snprintf(blinkm_led_name, sizeof(blinkm_led_name),
> > -					 "blinkm-%d-%d-green",
> > -					 client->adapter->nr,
> > -					 client->addr);
> > -			led[i]->led_cdev.name = blinkm_led_name;
> > -			led[i]->led_cdev.brightness_set_blocking =
> > -							blinkm_led_green_set;
> > -			err = led_classdev_register(&client->dev,
> > -						    &led[i]->led_cdev);
> > -			if (err < 0) {
> > -				dev_err(&client->dev,
> > -					"couldn't register LED %s\n",
> > -					led[i]->led_cdev.name);
> > -				goto failgreen;
> > -			}
> > -			break;
> > -		case BLUE:
> > -			snprintf(blinkm_led_name, sizeof(blinkm_led_name),
> > -					 "blinkm-%d-%d-blue",
> > -					 client->adapter->nr,
> > -					 client->addr);
> > -			led[i]->led_cdev.name = blinkm_led_name;
> > -			led[i]->led_cdev.brightness_set_blocking =
> > -							blinkm_led_blue_set;
> > -			err = led_classdev_register(&client->dev,
> > -						    &led[i]->led_cdev);
> > -			if (err < 0) {
> > -				dev_err(&client->dev,
> > -					"couldn't register LED %s\n",
> > -					led[i]->led_cdev.name);
> > -				goto failblue;
> > -			}
> > -			break;
> > -		}		/* end switch */
> > -	}			/* end for */
> > -
> > -	/* Initialize the blinkm */
> > +	if (!IS_ENABLED(CONFIG_LEDS_BLINKM_MULTICOLOR)) {
> > +		/* Register red, green, and blue sysfs classes */
> > +		for (i = 0; i < NUM_LEDS; i++) {
> 
> *Even* more indentation!
> 
> Probably worth moving the whole section into a function at this point.
Yes, I think you are right. Thank you for the review.
> 
> > +			/* RED = 0, GREEN = 1, BLUE = 2 */
> > +			leds[i] = &data->blinkm_leds[i];
> > +			leds[i]->i2c_client = client;
> > +			leds[i]->id = i;
> > +			leds[i]->led_cdev.max_brightness = 255;
> > +			leds[i]->led_cdev.flags = LED_CORE_SUSPENDRESUME;
> > +			switch (i) {
> > +			case RED:
> > +				scnprintf(blinkm_led_name, sizeof(blinkm_led_name),
> > +						 "blinkm-%d-%d-red",
> > +						 client->adapter->nr,
> > +						 client->addr);
> > +				leds[i]->led_cdev.name = blinkm_led_name;
> > +				leds[i]->led_cdev.brightness_set_blocking =
> > +								blinkm_led_red_set;
> > +				err = led_classdev_register(&client->dev,
> > +								&leds[i]->led_cdev);
> > +				if (err < 0) {
> > +					dev_err(&client->dev,
> > +						"couldn't register LED %s\n",
> > +						leds[i]->led_cdev.name);
> > +					goto failred;
> > +				}
> > +				break;
> > +			case GREEN:
> > +				scnprintf(blinkm_led_name, sizeof(blinkm_led_name),
> > +						 "blinkm-%d-%d-green",
> > +						 client->adapter->nr,
> > +						 client->addr);
> > +				leds[i]->led_cdev.name = blinkm_led_name;
> > +				leds[i]->led_cdev.brightness_set_blocking =
> > +								blinkm_led_green_set;
> > +				err = led_classdev_register(&client->dev,
> > +							&leds[i]->led_cdev);
> > +				if (err < 0) {
> > +					dev_err(&client->dev,
> > +						"couldn't register LED %s\n",
> > +						leds[i]->led_cdev.name);
> > +					goto failgreen;
> > +				}
> > +				break;
> > +			case BLUE:
> > +				scnprintf(blinkm_led_name, sizeof(blinkm_led_name),
> > +						 "blinkm-%d-%d-blue",
> > +						 client->adapter->nr,
> > +						 client->addr);
> > +				leds[i]->led_cdev.name = blinkm_led_name;
> > +				leds[i]->led_cdev.brightness_set_blocking =
> > +								blinkm_led_blue_set;
> > +				err = led_classdev_register(&client->dev,
> > +								&leds[i]->led_cdev);
> > +				if (err < 0) {
> > +					dev_err(&client->dev,
> > +						"couldn't register LED %s\n",
> > +						leds[i]->led_cdev.name);
> > +					goto failblue;
> > +				}
> > +				break;
> > +			default:
> > +				break;
> > +			}		/* end switch */
> > +		}			/* end for */
> > +	} else {
> > +		/* Register multicolor sysfs class */
> > +		/* The first element of leds is used for multicolor facilities */
> > +		mc_led = &data->blinkm_leds[RED];
> > +		mc_led->i2c_client = client;
> > +
> > +		mc_led_info[RED].color_index = LED_COLOR_ID_RED;
> > +		mc_led_info[GREEN].color_index = LED_COLOR_ID_GREEN;
> > +		mc_led_info[BLUE].color_index = LED_COLOR_ID_BLUE;
> > +
> > +		mc_led->mcled_cdev.subled_info = mc_led_info;
> > +		mc_led->mcled_cdev.num_colors = NUM_LEDS;
> > +		mc_led->mcled_cdev.led_cdev.brightness = 255;
> > +		mc_led->mcled_cdev.led_cdev.max_brightness = 255;
> > +		mc_led->mcled_cdev.led_cdev.flags = LED_CORE_SUSPENDRESUME;
> > +
> > +		scnprintf(blinkm_led_name, sizeof(blinkm_led_name),
> > +			 "blinkm-%d-%d:rgb:indicator",
> > +			 client->adapter->nr,
> > +			 client->addr);
> > +		mc_led->mcled_cdev.led_cdev.name = blinkm_led_name;
> > +		mc_led->mcled_cdev.led_cdev.brightness_set_blocking = blinkm_set_mc_brightness;
> > +
> > +		err = led_classdev_multicolor_register(&client->dev, &mc_led->mcled_cdev);
> > +		if (err < 0) {
> > +			dev_err(&client->dev, "couldn't register LED %s\n",
> > +					mc_led->led_cdev.name);
> > +			goto failmulti;
> > +		}
> > +	}
> > +
> >  	blinkm_init_hw(client);
> >  
> >  	return 0;
> >  
> > +failmulti:
> > +	led_classdev_unregister(&leds[BLUE]->led_cdev);
> > +
> >  failblue:
> > -	led_classdev_unregister(&led[GREEN]->led_cdev);
> > +	led_classdev_unregister(&leds[GREEN]->led_cdev);
> >  
> >  failgreen:
> > -	led_classdev_unregister(&led[RED]->led_cdev);
> > +	led_classdev_unregister(&leds[RED]->led_cdev);
> >  
> >  failred:
> >  	sysfs_remove_group(&client->dev.kobj, &blinkm_group);
> > +
> >  exit:
> >  	return err;
> >  }
> > @@ -684,7 +759,7 @@ static void blinkm_remove(struct i2c_client *client)
> >  	int i;
> >  
> >  	/* make sure no workqueue entries are pending */
> > -	for (i = 0; i < 3; i++)
> > +	for (i = 0; i < NUM_LEDS; i++)
> >  		led_classdev_unregister(&data->blinkm_leds[i].led_cdev);
> >  
> >  	/* reset rgb */
> > @@ -741,6 +816,6 @@ static struct i2c_driver blinkm_driver = {
> >  module_i2c_driver(blinkm_driver);
> >  
> >  MODULE_AUTHOR("Jan-Simon Moeller <dl9pf@gmx.de>");
> > +MODULE_AUTHOR("Joseph Strauss <jstrauss@mailbox.org>");
> >  MODULE_DESCRIPTION("BlinkM RGB LED driver");
> >  MODULE_LICENSE("GPL");
> > -
> > -- 
> > 2.42.0
> > 
> 
> -- 
> 1)
> Lee Jones [李琼斯]

Joseph Strauss

