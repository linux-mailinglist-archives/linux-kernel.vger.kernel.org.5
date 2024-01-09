Return-Path: <linux-kernel+bounces-21020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C91C48288A4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DBB11F2598B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D93639AEB;
	Tue,  9 Jan 2024 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0csb2EM"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6285736AFB;
	Tue,  9 Jan 2024 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d60c49ee7so34799935e9.0;
        Tue, 09 Jan 2024 07:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704812480; x=1705417280; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kFSSTbq7IPBf5s843uaxKy0JnvdppW2Wga9+VXd4oEI=;
        b=I0csb2EMXTHAt9mBrt7T1DKe6+bVXCRUbwKGPP7H1jV78VANdwkKjkdbMkX62GJUJ5
         flgKVhgUFNN2ArpYOs/SZC/ir2a7xo/+b7kiFtuaFcw6ceRpsvFWJJzzmgUlAYNvgMZk
         71sY2VZw5ZJksuFsvpDXZMLG16yUSnkJQsjcI3YoVXDwb5uWs5jhMwD8tc+EhLpB1kJR
         yPCs9MWiQX7zj/ix1maeEYyXzNFRK5GR2NKAHu2RppyP309HO4pp0DtZaTJi7LGVHN4m
         hTGQQqFgVG+lzB0BzZM1eQT/mompXzxg46QB9FaA1i54o5wtsr2A5HYNM8t8zsbvr8OZ
         BDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704812480; x=1705417280;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFSSTbq7IPBf5s843uaxKy0JnvdppW2Wga9+VXd4oEI=;
        b=Eek/c5U845G6pWpha0WKKKsdo6GKdPmmmQUnC9wnRDeSaGYU6XdbA+J0IEwAd6EEDv
         c/Nog3OfS8QsEE1Ri5bQUxCOgAeNgWyvqxyXwEbWCN+EBSV4zdzp9yo97XHL4OeChC6i
         K1H9geb/tWaSs3j7Gs3F3nHiqt+HaIkDxETAWvXmV+fE9VXYkvGLQHGvm441lRuOHQ8g
         btc3SrYxpt5/eBmFR/j3IMvGzCqlOPs6zmYvA64yh1l7xjnO1EhNGpUHm4V050erUNmy
         vpSa2R164kWhBK+BJKnREG7fvb65+MTcKuHAq13G6QwixXVonzY1T8NmKTtJXr3pVOsK
         YBcw==
X-Gm-Message-State: AOJu0Yy0tYAmE5r4xq8Jpmba0QaLD8Z/2YIByBuZAjKT9RnRhYILed3+
	WNUL6QMhJ5z8z/sX31iweIg=
X-Google-Smtp-Source: AGHT+IFnCZV4eOcSwHP2r/qM2xNuE/Uh53VLu5Icgk7vJJUxvGy3erlqRBeM/fpa2jWk5pyp9xPW+A==
X-Received: by 2002:a05:600c:21c7:b0:40e:46b3:fe3a with SMTP id x7-20020a05600c21c700b0040e46b3fe3amr1964801wmj.47.1704812480117;
        Tue, 09 Jan 2024 07:01:20 -0800 (PST)
Received: from localhost (a109-49-32-45.cpe.netcabo.pt. [109.49.32.45])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c314400b0040d7c3d5454sm15009382wmo.3.2024.01.09.07.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 07:01:19 -0800 (PST)
From: Rui Miguel Silva <rmfrfs@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones
 <lee@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Heiner
 Kallweit <hkallweit1@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
 Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold
 <johan@kernel.org>, Alex Elder <elder@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Andreas Kemnade
 <andreas@kemnade.info>, greybus-dev@lists.linaro.org,
 linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/2] leds: make flash and multicolor dependencies
 unconditional
In-Reply-To: <20240109090715.982332-2-arnd@kernel.org>
References: <20240109090715.982332-1-arnd@kernel.org>
 <20240109090715.982332-2-arnd@kernel.org>
Date: Tue, 09 Jan 2024 15:01:18 +0000
Message-ID: <m3mstey2ip.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hey Arnd,
Many thanks for the patch.

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Along the same lines as making devm_led_classdev_register() declared
> extern unconditional, do the same thing for the two sub-classes
> that have similar stubs.
>
> The users of these interfaces go to great lengths to allow building
> with both the generic leds API and the extended version, but realistically
> there is not much use in this, so just simplify it to always rely
> on it and remove the confusing fallback logic.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/leds/Kconfig                 |  4 ++--
>  drivers/leds/flash/Kconfig           |  4 ++--
>  drivers/staging/greybus/Kconfig      |  2 +-
>  drivers/staging/greybus/light.c      | 21 --------------------
>  include/linux/led-class-flash.h      | 24 -----------------------
>  include/linux/led-class-multicolor.h | 29 ----------------------------
>  6 files changed, 5 insertions(+), 79 deletions(-)
>
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index d721b254e1e4..9613a45a35bd 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -395,7 +395,7 @@ config LEDS_LP3952
>  config LEDS_LP50XX
>  	tristate "LED Support for TI LP5036/30/24/18/12/09 LED driver chip"
>  	depends on LEDS_CLASS && REGMAP_I2C
> -	depends on LEDS_CLASS_MULTICOLOR || !LEDS_CLASS_MULTICOLOR
> +	depends on LEDS_CLASS_MULTICOLOR
>  	help
>  	  If you say yes here you get support for the Texas Instruments
>  	  LP5036, LP5030, LP5024, LP5018, LP5012 and LP5009 LED driver.
> @@ -406,7 +406,7 @@ config LEDS_LP50XX
>  config LEDS_LP55XX_COMMON
>  	tristate "Common Driver for TI/National LP5521/5523/55231/5562/8501"
>  	depends on LEDS_CLASS
> -	depends on LEDS_CLASS_MULTICOLOR || !LEDS_CLASS_MULTICOLOR
> +	depends on LEDS_CLASS_MULTICOLOR
>  	depends on OF
>  	depends on I2C
>  	select FW_LOADER
> diff --git a/drivers/leds/flash/Kconfig b/drivers/leds/flash/Kconfig
> index 4e08dbc05709..b95f90cd5749 100644
> --- a/drivers/leds/flash/Kconfig
> +++ b/drivers/leds/flash/Kconfig
> @@ -51,8 +51,8 @@ config LEDS_MAX77693
>  config LEDS_MT6360
>  	tristate "LED Support for Mediatek MT6360 PMIC"
>  	depends on LEDS_CLASS && OF
> -	depends on LEDS_CLASS_FLASH || !LEDS_CLASS_FLASH
> -	depends on LEDS_CLASS_MULTICOLOR || !LEDS_CLASS_MULTICOLOR
> +	depends on LEDS_CLASS_FLASH
> +	depends on LEDS_CLASS_MULTICOLOR
>  	depends on V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS
>  	depends on MFD_MT6360
>  	help
> diff --git a/drivers/staging/greybus/Kconfig b/drivers/staging/greybus/Kconfig
> index 927cfa4bc989..1e745a8d439c 100644
> --- a/drivers/staging/greybus/Kconfig
> +++ b/drivers/staging/greybus/Kconfig
> @@ -64,7 +64,7 @@ config GREYBUS_HID
>  
>  config GREYBUS_LIGHT
>  	tristate "Greybus LED Class driver"
> -	depends on LEDS_CLASS
> +	depends on LEDS_CLASS_FLASH

Agree with the change for the greybus driver, one note, since you are
cleaning up this, maybe also remove the other #if down when setting
the flash specific operations, right?

#if IS_REACHABLE(CONFIG_LEDS_CLASS_FLASH)
/* Flash specific operations */
static int gb_lights_flash_intensity_set(struct led_classdev_flash *fcdev,
					 u32 brightness)
{
	struct gb_channel *channel = container_of(fcdev, struct gb_channel,
						  fled);
	int ret;
.
.
.
.

#else
static int gb_lights_channel_flash_config(struct gb_channel *channel)
{
	struct gb_connection *connection = get_conn_from_channel(channel);

	dev_err(&connection->bundle->dev, "no support for flash devices\n");
	return 0;
}
.
.
.


Thanks again.

Cheers,
    Rui

>  	help
>  	  Select this option if you have a device that follows the
>  	  Greybus LED Class specification.
> diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
> index 87d36948c610..d62f97249aca 100644
> --- a/drivers/staging/greybus/light.c
> +++ b/drivers/staging/greybus/light.c
> @@ -29,13 +29,9 @@ struct gb_channel {
>  	struct attribute_group		*attr_group;
>  	const struct attribute_group	**attr_groups;
>  	struct led_classdev		*led;
> -#if IS_REACHABLE(CONFIG_LEDS_CLASS_FLASH)
>  	struct led_classdev_flash	fled;
>  	struct led_flash_setting	intensity_uA;
>  	struct led_flash_setting	timeout_us;
> -#else
> -	struct led_classdev		cled;
> -#endif
>  	struct gb_light			*light;
>  	bool				is_registered;
>  	bool				releasing;
> @@ -84,7 +80,6 @@ static bool is_channel_flash(struct gb_channel *channel)
>  				   | GB_CHANNEL_MODE_INDICATOR));
>  }
>  
> -#if IS_REACHABLE(CONFIG_LEDS_CLASS_FLASH)
>  static struct gb_channel *get_channel_from_cdev(struct led_classdev *cdev)
>  {
>  	struct led_classdev_flash *fled_cdev = lcdev_to_flcdev(cdev);
> @@ -153,22 +148,6 @@ static int __gb_lights_flash_brightness_set(struct gb_channel *channel)
>  
>  	return __gb_lights_flash_intensity_set(channel, intensity);
>  }
> -#else
> -static struct gb_channel *get_channel_from_cdev(struct led_classdev *cdev)
> -{
> -	return container_of(cdev, struct gb_channel, cled);
> -}
> -
> -static struct led_classdev *get_channel_cdev(struct gb_channel *channel)
> -{
> -	return &channel->cled;
> -}
> -
> -static int __gb_lights_flash_brightness_set(struct gb_channel *channel)
> -{
> -	return 0;
> -}
> -#endif
>  
>  static int gb_lights_color_set(struct gb_channel *channel, u32 color);
>  static int gb_lights_fade_set(struct gb_channel *channel);
> diff --git a/include/linux/led-class-flash.h b/include/linux/led-class-flash.h
> index 612b4cab3819..36df927ec4b7 100644
> --- a/include/linux/led-class-flash.h
> +++ b/include/linux/led-class-flash.h
> @@ -85,7 +85,6 @@ static inline struct led_classdev_flash *lcdev_to_flcdev(
>  	return container_of(lcdev, struct led_classdev_flash, led_cdev);
>  }
>  
> -#if IS_ENABLED(CONFIG_LEDS_CLASS_FLASH)
>  /**
>   * led_classdev_flash_register_ext - register a new object of LED class with
>   *				     init data and with support for flash LEDs
> @@ -116,29 +115,6 @@ int devm_led_classdev_flash_register_ext(struct device *parent,
>  void devm_led_classdev_flash_unregister(struct device *parent,
>  					struct led_classdev_flash *fled_cdev);
>  
> -#else
> -
> -static inline int led_classdev_flash_register_ext(struct device *parent,
> -				    struct led_classdev_flash *fled_cdev,
> -				    struct led_init_data *init_data)
> -{
> -	return 0;
> -}
> -
> -static inline void led_classdev_flash_unregister(struct led_classdev_flash *fled_cdev) {};
> -static inline int devm_led_classdev_flash_register_ext(struct device *parent,
> -				     struct led_classdev_flash *fled_cdev,
> -				     struct led_init_data *init_data)
> -{
> -	return 0;
> -}
> -
> -static inline void devm_led_classdev_flash_unregister(struct device *parent,
> -					struct led_classdev_flash *fled_cdev)
> -{};
> -
> -#endif  /* IS_ENABLED(CONFIG_LEDS_CLASS_FLASH) */
> -
>  static inline int led_classdev_flash_register(struct device *parent,
>  					   struct led_classdev_flash *fled_cdev)
>  {
> diff --git a/include/linux/led-class-multicolor.h b/include/linux/led-class-multicolor.h
> index 210d57bcd767..db9f34c6736e 100644
> --- a/include/linux/led-class-multicolor.h
> +++ b/include/linux/led-class-multicolor.h
> @@ -30,7 +30,6 @@ static inline struct led_classdev_mc *lcdev_to_mccdev(
>  	return container_of(led_cdev, struct led_classdev_mc, led_cdev);
>  }
>  
> -#if IS_ENABLED(CONFIG_LEDS_CLASS_MULTICOLOR)
>  /**
>   * led_classdev_multicolor_register_ext - register a new object of led_classdev
>   *				      class with support for multicolor LEDs
> @@ -64,34 +63,6 @@ int devm_led_classdev_multicolor_register_ext(struct device *parent,
>  
>  void devm_led_classdev_multicolor_unregister(struct device *parent,
>  					    struct led_classdev_mc *mcled_cdev);
> -#else
> -
> -static inline int led_classdev_multicolor_register_ext(struct device *parent,
> -					    struct led_classdev_mc *mcled_cdev,
> -					    struct led_init_data *init_data)
> -{
> -	return 0;
> -}
> -
> -static inline void led_classdev_multicolor_unregister(struct led_classdev_mc *mcled_cdev) {};
> -static inline int led_mc_calc_color_components(struct led_classdev_mc *mcled_cdev,
> -					       enum led_brightness brightness)
> -{
> -	return 0;
> -}
> -
> -static inline int devm_led_classdev_multicolor_register_ext(struct device *parent,
> -					  struct led_classdev_mc *mcled_cdev,
> -					  struct led_init_data *init_data)
> -{
> -	return 0;
> -}
> -
> -static inline void devm_led_classdev_multicolor_unregister(struct device *parent,
> -					    struct led_classdev_mc *mcled_cdev)
> -{};
> -
> -#endif  /* IS_ENABLED(CONFIG_LEDS_CLASS_MULTICOLOR) */
>  
>  static inline int led_classdev_multicolor_register(struct device *parent,
>  					    struct led_classdev_mc *mcled_cdev)
> -- 
> 2.39.2

