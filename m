Return-Path: <linux-kernel+bounces-48105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D2D84574C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2986D2874AC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1247715DBD8;
	Thu,  1 Feb 2024 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fzd8bced";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R4qP/vmr"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B19A15DBAD;
	Thu,  1 Feb 2024 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790042; cv=none; b=oOLLyqNgajgnUVJr3ctqHIQNirP4AgEBMTMkcjAn9jgsboirZLpJLruvEswfYT1SsGrmUb8iCa9SlDvu8KWy8v4vQjOSIfK76X9I7W4+goRaI3jFzBuMJXnqr7UMhK31xy/J/HEzmogAUtas4Qtc+iynJ27SAVMDmg/ikSd3qvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790042; c=relaxed/simple;
	bh=tOP+bBy+gPxTby3oIIGh7ePBi6kc5+Afd0fsLy4hUTI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=d9pTwm2zvsgaWiBRHhGdSyqFl5+oABByNWJb2+mk9TEG43mE3zqvi9sbsrsH9cBvPSTtxHJKFEdLBq3DmiXS6TMR9u9Wp48yYGnN5VpHH9K0g9NEwBEmEdFDpw6DjgFqsVW2SxKzo8SbyqYIyol+QN8RPbg+ONMghvVm9av5fjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=fzd8bced; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R4qP/vmr; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 1F6815C00BB;
	Thu,  1 Feb 2024 07:20:38 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 01 Feb 2024 07:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706790038; x=1706876438; bh=La5/o2fuH4
	d2jzM5dDIc729uivU7xUPCDoZbXIMHbm8=; b=fzd8bcedQz3ADHtkz2SiEai2OK
	9Hy1v0TCsqzgK7Zn4tabYuwaleqMctOqumBuWJdzJk5VJx/SeWVAbmb+3Iv4uSfg
	bUq6VBj4Ub+oQAuZk+mjXZ8gy1BNYwL+O6et8X69GjLeyFxT6p26/h9t6SKC7/EC
	NAcrj+s8DumP/tDzI7elppPBR1vgWTJt5uu1PLHpGBi9v3YFsKIBJlXvx3za2Sz8
	aaSySP4sM3K0dhajoBXbOqCDsfT1+n2eTxWqsViFZSJf7pKrMVycBeFSV/VnR3MG
	Av9DhwUbHpXQm3TTiLL10c+yt1fqa9z/Xtb67X2bdS5X9ZkJsbTZYPCAHcSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706790038; x=1706876438; bh=La5/o2fuH4d2jzM5dDIc729uivU7
	xUPCDoZbXIMHbm8=; b=R4qP/vmrvhjDNvG73TUFwjwvJfckA7U+UU3jlxQUicLH
	7pz4XX3x4fkqMehRNI7QrMWJIfJmzyfKCslLWOgQ9vW5H4R+weVjVLLT/mPp/gnT
	tEPl9/WWrnk/p4jXaJXr7I4BRnMYk5cZLOQiD0ufHJzNNlb9wXzV7xWJARuoiz7T
	LgxQfKZTGCEGmv1VVLpbVsRtOfpc+9MU4Pm2qlgXkAWAT9NnyoynNgo2EgtBc2Qh
	2YUVLB1cW9eQO9LA3snXVTop6bL0Jft9WB0qzLWm7cNc2N2kvpzaLQfEIdYBug3k
	R321w0IouZUmRfXNsUchavw7zMGfeBUXrSWDo0Zbig==
X-ME-Sender: <xms:lYy7ZSW6KCFLzmQjvXYD7Hz06vbgNcyWSn3CpLoXn9pME96UZp3cbg>
    <xme:lYy7Zembpq19R7hEDvJbXX7PK_2CqWH2qmWk_6yTZ8VtLp2NTzMXVwvBJZpG_vvmd
    4LqU1lnsySDIgl6COE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffejteevieefudffudeghedvlefftdejvdfgjeeuffekjeekteevtedtvdfg
    veehnecuffhomhgrihhnpehophgvnhifrhhtrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:lYy7ZWYQMGDxAgWXiBS6nj-vkexTaZ-xtJk33rHjcRuz-YydcdqQWA>
    <xmx:lYy7ZZULHvqwGRlC6h6fX1XWgViGKKlMAPOrhF64JJ_pld9qFRRlOw>
    <xmx:lYy7ZcmQ0pydlIFR-8NpFSutTL2ptyU0e_bb1OVnm5CET0xOvYlvcA>
    <xmx:loy7ZVfnEgJWZ5kJ4dtAO37UGyT6D2k3MvKwlP9z62rPrIXCKCA3tQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 012C9B6008D; Thu,  1 Feb 2024 07:20:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <613ae419-9a2c-477e-8b19-8a29d42a3164@app.fastmail.com>
In-Reply-To: <20240131-descriptors-wireless-v1-1-e1c7c5d68746@linaro.org>
References: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
 <20240131-descriptors-wireless-v1-1-e1c7c5d68746@linaro.org>
Date: Thu, 01 Feb 2024 13:20:16 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Walleij" <linus.walleij@linaro.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 "Kalle Valo" <kvalo@kernel.org>, "Arend van Spriel" <aspriel@gmail.com>,
 "Franky Lin" <franky.lin@broadcom.com>,
 "Hante Meuleman" <hante.meuleman@broadcom.com>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Lee Jones" <lee@kernel.org>, "Brian Norris" <briannorris@chromium.org>,
 "Srinivasan Raju" <srini.raju@purelifi.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 1/6] wifi: ath9k: Obtain system GPIOS from descriptors
Content-Type: text/plain

On Wed, Jan 31, 2024, at 23:37, Linus Walleij wrote:
> The ath9k has an odd use of system-wide GPIOs: if the chip
> does not have internal GPIO capability, it will try to obtain a
> GPIO line from the system GPIO controller:
>
>   if (BIT(gpio) & ah->caps.gpio_mask)
>         ath9k_hw_gpio_cfg_wmac(...);
>   else if (AR_SREV_SOC(ah))
>         ath9k_hw_gpio_cfg_soc(ah, gpio, out, label);
>
> Where ath9k_hw_gpio_cfg_soc() will attempt to issue
> gpio_request_one() passing the local GPIO number of the controller
> (0..31) to gpio_request_one().
>
> This is somewhat peculiar and possibly even dangerous: there is
> nowadays no guarantee of the numbering of these system-wide
> GPIOs, and assuming that GPIO 0..31 as used by ath9k would
> correspond to GPIOs 0..31 on the system as a whole seems a bit
> wild.

I would expect that it still works, as the SoCs that integrate
ath9k hardware tend to be quite simple and only have a single
gpio controller (drivers/gpio/gpio-ath79.c) with no more than
32 lines. Even on machines with an i2c gpio expander they
likely come first.

ath9k_gpio_cap_init() is how the gpio_mask gets initialized
based on the chip model, and none of them have a mask with
anything higher than the low 16 bits set. However, this is
a mix of PCI devices with on-chip GPIOs that are handled
through gpiolib.

> My best guess is that everyone actually using this driver has
> support for the local (custom) GPIO API and the bit in
> h->caps.gpio_mask is always set for any GPIO the driver may
> try to obtain, so this facility to use system-wide GPIOs is
> actually unused and could be deleted.
>
> Anyway: I cannot know if this is really the case, so implement
> a fallback handling using GPIO descriptors obtained from the
> ah->dev device indexed 0..31. These can for example be passed
> in the device tree, ACPI or through board files. I doubt that
> anyone will use them, but this makes it possible to obtain a
> system-wide GPIO for any of the 0..31 GPIOs potentially
> requested by the driver.

The platform data was dropped in favor of DT in commit
85b9686dae30 ("MIPS: ath79: drop platform device registration
code"), but neither version actually initializes the btcoex
gpio lines, and as far as I can tell, btcoex only really
happens in the PCI version with internal gpio, so there
is no need to actually read it from pdata in

static void ath9k_hw_btcoex_pin_init(struct ath_hw *ah, u8 wlanactive_gpio,
                                     u8 btactive_gpio, u8 btpriority_gpio)
{
        struct ath_btcoex_hw *btcoex_hw = &ah->btcoex_hw;
        struct ath9k_platform_data *pdata = ah->dev->platform_data;

        if (btcoex_hw->scheme != ATH_BTCOEX_CFG_2WIRE &&
            btcoex_hw->scheme != ATH_BTCOEX_CFG_3WIRE)
                return;

        /* bt priority GPIO will be ignored by 2 wire scheme */
        if (pdata && (pdata->bt_active_pin || pdata->bt_priority_pin ||
                      pdata->wlan_active_pin)) {
                btcoex_hw->btactive_gpio = pdata->bt_active_pin;
                btcoex_hw->wlanactive_gpio = pdata->wlan_active_pin;
                btcoex_hw->btpriority_gpio = pdata->bt_priority_pin;
        } else {
                btcoex_hw->btactive_gpio = btactive_gpio;
                btcoex_hw->wlanactive_gpio = wlanactive_gpio;
                btcoex_hw->btpriority_gpio = btpriority_gpio;
        }
}

After the board file removal, the LED gpio line seems to have
exactly one remaining user in openwrt using a board file for
a PCI connected (non-soc) ath9k device on a powerpc platform:

https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/mpc85xx/files/arch/powerpc/platforms/85xx/tl_wdr4900_v1.c;hb=refs/heads/main#l50

> @@ -2832,8 +2833,8 @@ u32 ath9k_hw_gpio_get(struct ath_hw *ah, u32 gpio)
>  			val = REG_READ(ah, AR_GPIO_IN(ah)) & BIT(gpio);
>  		else
>  			val = MS_REG_READ(AR, gpio);
> -	} else if (BIT(gpio) & ah->caps.gpio_requested) {
> -		val = gpio_get_value(gpio) & BIT(gpio);
> +	} else if (ah->gpiods[gpio]) {
> +		val = gpiod_get_value(ah->gpiods[gpio]);
>  	} else {
>  		WARN_ON(1);
>  	}
> @@ -2856,8 +2857,8 @@ void ath9k_hw_set_gpio(struct ath_hw *ah, u32 
> gpio, u32 val)
>  			AR7010_GPIO_OUT : AR_GPIO_IN_OUT(ah);
> 
>  		REG_RMW(ah, out_addr, val << gpio, BIT(gpio));
> -	} else if (BIT(gpio) & ah->caps.gpio_requested) {
> -		gpio_set_value(gpio, val);
> +	} else if (ah->gpiods[gpio]) {
> +		gpiod_set_value(ah->gpiods[gpio], val);
>  	} else {
>  		WARN_ON(1);
>  	}

I don't think this is a good way to handle the gpiolib
variants. What I'd try instead is to move the abstraction
so on-chip gpio numbers don't get confused with gpiolib
numbers, essentially getting rid of the latter entirely.

I think something like the experiment below would work:

    Arnd


diff --git a/drivers/net/wireless/ath/ath9k/btcoex.c b/drivers/net/wireless/ath/ath9k/btcoex.c
index 9b393a8f7c3a..32f2113c13cb 100644
--- a/drivers/net/wireless/ath/ath9k/btcoex.c
+++ b/drivers/net/wireless/ath/ath9k/btcoex.c
@@ -115,23 +115,15 @@ static void ath9k_hw_btcoex_pin_init(struct ath_hw *ah, u8 wlanactive_gpio,
 				     u8 btactive_gpio, u8 btpriority_gpio)
 {
 	struct ath_btcoex_hw *btcoex_hw = &ah->btcoex_hw;
-	struct ath9k_platform_data *pdata = ah->dev->platform_data;
 
 	if (btcoex_hw->scheme != ATH_BTCOEX_CFG_2WIRE &&
 	    btcoex_hw->scheme != ATH_BTCOEX_CFG_3WIRE)
 		return;
 
 	/* bt priority GPIO will be ignored by 2 wire scheme */
-	if (pdata && (pdata->bt_active_pin || pdata->bt_priority_pin ||
-		      pdata->wlan_active_pin)) {
-		btcoex_hw->btactive_gpio = pdata->bt_active_pin;
-		btcoex_hw->wlanactive_gpio = pdata->wlan_active_pin;
-		btcoex_hw->btpriority_gpio = pdata->bt_priority_pin;
-	} else {
-		btcoex_hw->btactive_gpio = btactive_gpio;
-		btcoex_hw->wlanactive_gpio = wlanactive_gpio;
-		btcoex_hw->btpriority_gpio = btpriority_gpio;
-	}
+	btcoex_hw->btactive_gpio = btactive_gpio;
+	btcoex_hw->wlanactive_gpio = wlanactive_gpio;
+	btcoex_hw->btpriority_gpio = btpriority_gpio;
 }
 
 void ath9k_hw_btcoex_init_scheme(struct ath_hw *ah)
diff --git a/drivers/net/wireless/ath/ath9k/gpio.c b/drivers/net/wireless/ath/ath9k/gpio.c
index b457e52dd365..82b19c6a11fc 100644
--- a/drivers/net/wireless/ath/ath9k/gpio.c
+++ b/drivers/net/wireless/ath/ath9k/gpio.c
@@ -15,6 +15,7 @@
  */
 
 #include "ath9k.h"
+#include <linux/gpio/consumer.h>
 
 /********************************/
 /*	 LED functions		*/
@@ -27,7 +28,11 @@ static void ath_fill_led_pin(struct ath_softc *sc)
 	struct ath_hw *ah = sc->sc_ah;
 
 	/* Set default led pin if invalid */
-	if (ah->led_pin < 0) {
+	if (AR_SREV_SOC(ah)) {
+		ah->led_gpio = gpiod_get(ah->dev, "led", 0);
+		if (IS_ERR(ah->led_gpio))
+			ah->led_gpio = NULL;
+	} else if (ah->led_pin < 0) {
 		if (AR_SREV_9287(ah))
 			ah->led_pin = ATH_LED_PIN_9287;
 		else if (AR_SREV_9485(ah))
@@ -57,7 +62,10 @@ static void ath_led_brightness(struct led_classdev *led_cdev,
 	if (sc->sc_ah->config.led_active_high)
 		val = !val;
 
-	ath9k_hw_set_gpio(sc->sc_ah, sc->sc_ah->led_pin, val);
+	if (sc->sc_ah->led_gpio)
+		gpiod_set_value(sc->sc_ah->led_gpio, val);
+	else
+		ath9k_hw_set_gpio(sc->sc_ah, sc->sc_ah->led_pin, val);
 }
 
 void ath_deinit_leds(struct ath_softc *sc)
@@ -68,7 +76,8 @@ void ath_deinit_leds(struct ath_softc *sc)
 	ath_led_brightness(&sc->led_cdev, LED_OFF);
 	led_classdev_unregister(&sc->led_cdev);
 
-	ath9k_hw_gpio_free(sc->sc_ah, sc->sc_ah->led_pin);
+	if (sc->sc_ah->led_gpio)
+		gpiod_put(sc->sc_ah->led_gpio);
 }
 
 void ath_init_leds(struct ath_softc *sc)
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_gpio.c b/drivers/net/wireless/ath/ath9k/htc_drv_gpio.c
index ecb848b60725..07720101e9cb 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_gpio.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_gpio.c
@@ -15,6 +15,7 @@
  */
 
 #include "htc.h"
+#include <linux/gpio/consumer.h>
 
 /******************/
 /*     BTCOEX     */
@@ -229,8 +230,11 @@ void ath9k_led_work(struct work_struct *work)
 						   struct ath9k_htc_priv,
 						   led_work);
 
-	ath9k_hw_set_gpio(priv->ah, priv->ah->led_pin,
-			  (priv->brightness == LED_OFF));
+	if (priv->ah->led_gpio)
+		gpiod_set_value(priv->ah->led_gpio, priv->brightness != LED_OFF);
+	else
+		ath9k_hw_set_gpio(priv->ah, priv->ah->led_pin,
+				  (priv->brightness == LED_OFF));
 }
 
 static void ath9k_led_brightness(struct led_classdev *led_cdev,
@@ -254,12 +258,20 @@ void ath9k_deinit_leds(struct ath9k_htc_priv *priv)
 	led_classdev_unregister(&priv->led_cdev);
 	cancel_work_sync(&priv->led_work);
 
-	ath9k_hw_gpio_free(priv->ah, priv->ah->led_pin);
+	if (priv->ah->led_gpio)
+		gpiod_put(priv->ah->led_gpio);
+	else
+		ath9k_hw_gpio_free(priv->ah, priv->ah->led_pin);
 }
 
 
 void ath9k_configure_leds(struct ath9k_htc_priv *priv)
 {
+	if (priv->ah->led_gpio) {
+		gpiod_set_value(priv->ah->led_gpio, 1);
+		return;
+	}
+
 	/* Configure gpio 1 for output */
 	ath9k_hw_gpio_request_out(priv->ah, priv->ah->led_pin,
 				  "ath9k-led",
@@ -272,7 +284,11 @@ void ath9k_init_leds(struct ath9k_htc_priv *priv)
 {
 	int ret;
 
-	if (AR_SREV_9287(priv->ah))
+	if (AR_SREV_SOC(priv->ah)) {
+		priv->ah->led_gpio = gpiod_get(priv->ah->dev, "led", 0);
+		if (IS_ERR(priv->ah->led_gpio))
+			priv->ah->led_gpio = NULL;
+	} else if (AR_SREV_9287(priv->ah))
 		priv->ah->led_pin = ATH_LED_PIN_9287;
 	else if (AR_SREV_9271(priv->ah))
 		priv->ah->led_pin = ATH_LED_PIN_9271;
diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index 5982e0db45f9..d8663bd9df7c 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -2722,26 +2722,6 @@ static void ath9k_hw_gpio_cfg_output_mux(struct ath_hw *ah, u32 gpio, u32 type)
 	}
 }
 
-/* BSP should set the corresponding MUX register correctly.
- */
-static void ath9k_hw_gpio_cfg_soc(struct ath_hw *ah, u32 gpio, bool out,
-				  const char *label)
-{
-	int err;
-
-	if (ah->caps.gpio_requested & BIT(gpio))
-		return;
-
-	err = gpio_request_one(gpio, out ? GPIOF_OUT_INIT_LOW : GPIOF_IN, label);
-	if (err) {
-		ath_err(ath9k_hw_common(ah), "request GPIO%d failed:%d\n",
-			gpio, err);
-		return;
-	}
-
-	ah->caps.gpio_requested |= BIT(gpio);
-}
-
 static void ath9k_hw_gpio_cfg_wmac(struct ath_hw *ah, u32 gpio, bool out,
 				   u32 ah_signal_type)
 {
@@ -2775,8 +2755,6 @@ static void ath9k_hw_gpio_request(struct ath_hw *ah, u32 gpio, bool out,
 
 	if (BIT(gpio) & ah->caps.gpio_mask)
 		ath9k_hw_gpio_cfg_wmac(ah, gpio, out, ah_signal_type);
-	else if (AR_SREV_SOC(ah))
-		ath9k_hw_gpio_cfg_soc(ah, gpio, out, label);
 	else
 		WARN_ON(1);
 }
@@ -2800,11 +2778,6 @@ void ath9k_hw_gpio_free(struct ath_hw *ah, u32 gpio)
 		return;
 
 	WARN_ON(gpio >= ah->caps.num_gpio_pins);
-
-	if (ah->caps.gpio_requested & BIT(gpio)) {
-		gpio_free(gpio);
-		ah->caps.gpio_requested &= ~BIT(gpio);
-	}
 }
 EXPORT_SYMBOL(ath9k_hw_gpio_free);
 
@@ -2832,8 +2805,6 @@ u32 ath9k_hw_gpio_get(struct ath_hw *ah, u32 gpio)
 			val = REG_READ(ah, AR_GPIO_IN(ah)) & BIT(gpio);
 		else
 			val = MS_REG_READ(AR, gpio);
-	} else if (BIT(gpio) & ah->caps.gpio_requested) {
-		val = gpio_get_value(gpio) & BIT(gpio);
 	} else {
 		WARN_ON(1);
 	}
@@ -2856,8 +2827,6 @@ void ath9k_hw_set_gpio(struct ath_hw *ah, u32 gpio, u32 val)
 			AR7010_GPIO_OUT : AR_GPIO_IN_OUT(ah);
 
 		REG_RMW(ah, out_addr, val << gpio, BIT(gpio));
-	} else if (BIT(gpio) & ah->caps.gpio_requested) {
-		gpio_set_value(gpio, val);
 	} else {
 		WARN_ON(1);
 	}
diff --git a/drivers/net/wireless/ath/ath9k/hw.h b/drivers/net/wireless/ath/ath9k/hw.h
index 450ab19b1d4e..eff27c901a81 100644
--- a/drivers/net/wireless/ath/ath9k/hw.h
+++ b/drivers/net/wireless/ath/ath9k/hw.h
@@ -910,6 +910,8 @@ struct ath_hw {
 	u32 gpio_mask;
 	u32 gpio_val;
 
+	struct gpio_desc *led_gpio;
+
 	struct ar5416IniArray ini_dfs;
 	struct ar5416IniArray iniModes;
 	struct ar5416IniArray iniCommon;
diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index 7fad7e75af6a..68562310bf18 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -632,9 +632,6 @@ static int ath9k_init_platform(struct ath_softc *sc)
 
 	if (!pdata->use_eeprom) {
 		ah->ah_flags &= ~AH_USE_EEPROM;
-		ah->gpio_mask = pdata->gpio_mask;
-		ah->gpio_val = pdata->gpio_val;
-		ah->led_pin = pdata->led_pin;
 		ah->is_clk_25mhz = pdata->is_clk_25mhz;
 		ah->get_mac_revision = pdata->get_mac_revision;
 		ah->external_reset = pdata->external_reset;
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index c48ff0ffbfef..89bb773c5e15 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -16,6 +16,7 @@
 
 #include <linux/nl80211.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include "ath9k.h"
 #include "btcoex.h"
 
@@ -731,6 +732,8 @@ static int ath9k_start(struct ieee80211_hw *hw)
 		ath9k_hw_gpio_request_out(ah, ah->led_pin, NULL,
 					  AR_GPIO_OUTPUT_MUX_AS_OUTPUT);
 	}
+	if (ah->led_gpio)
+		gpiod_set_value(ah->led_gpio, 1);
 
 	/*
 	 * Reset key cache to sane defaults (all entries cleared) instead of
@@ -948,6 +951,8 @@ static void ath9k_stop(struct ieee80211_hw *hw)
 				  (ah->config.led_active_high) ? 0 : 1);
 		ath9k_hw_gpio_request_in(ah, ah->led_pin, NULL);
 	}
+	if (ah->led_gpio)
+		gpiod_set_value(ah->led_gpio, 0);
 
 	ath_prepare_reset(sc);
 
diff --git a/include/linux/ath9k_platform.h b/include/linux/ath9k_platform.h
index 76860a461ed2..cffdb5de407e 100644
--- a/include/linux/ath9k_platform.h
+++ b/include/linux/ath9k_platform.h
@@ -27,14 +27,6 @@ struct ath9k_platform_data {
 	u16 eeprom_data[ATH9K_PLAT_EEP_MAX_WORDS];
 	u8 *macaddr;
 
-	int led_pin;
-	u32 gpio_mask;
-	u32 gpio_val;
-
-	u32 bt_active_pin;
-	u32 bt_priority_pin;
-	u32 wlan_active_pin;
-
 	bool endian_check;
 	bool is_clk_25mhz;
 	bool tx_gain_buffalo;

