Return-Path: <linux-kernel+bounces-167309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4526A8BA78E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66AB01C20B5F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3F2146D48;
	Fri,  3 May 2024 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwDHBorD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634081465BF;
	Fri,  3 May 2024 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714720800; cv=none; b=FHgZBFAAQL1NogK0Ejp2SwXXAs6sWgZZxeuQm0fa23aS9cmEFnlYotynghEnEp/jq59KGtYc4zhJAz1/LW7nMNfLhFhFvdMuVwGhsSmeRJw8L9RFYVhhUGPPhjOd4X5QmPjYa2QewNu+WxbW3UdGeH8gikPyJIsMUBQIyE3doiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714720800; c=relaxed/simple;
	bh=RJ1nEjBsIaMicTjHu8ja7622TkaDgjGt3Kh0OrLQIoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4RT2AJ5mrUEksKnlBorx+pdJy7IHWT354uqsJAoxWMOkWW2aPPrH652rdRAZzzhFAgRMm+XaqIbqMI3yuXpvzi+kweIfpJ0A1772WjpSdGk4CdfjCVjTy1t5rnGkaO/aNC0xb+4EA3H344eVk7lfd5TGaXKrRT0MWKYh+KycSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwDHBorD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE1AC116B1;
	Fri,  3 May 2024 07:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714720799;
	bh=RJ1nEjBsIaMicTjHu8ja7622TkaDgjGt3Kh0OrLQIoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HwDHBorD2RYP8Pi09Ei2b1WNbXfi+XSUGzCVPkDNN3SoznXoAq9c9cjT9iYDqySMK
	 ngWqdZc2f/dEWKdiZSUf7PBzD0R9bbu7Ghd6dwLvxruRK/kisBa3jp2P6vgyZvtSWa
	 36fQ17vT/JekfqeDlLfT/J8GOhjOYea1p3oRiYUXHIazIucywEJmvh+O6mSW4iJc3x
	 5bER6gR9eOJoIhCNlzzqTcdC0XZJDuN4+XEnU+DwHxx397ii0fqG/tg0h7BII8JWcD
	 w6JF7qK58QSOwq5aB9kYj76CrPOz6OzeqZibL4CDbkc+1SSLZ2l0nWO8/8WGafHC5A
	 F3fD0KKSC47lA==
Date: Fri, 3 May 2024 08:19:53 +0100
From: Lee Jones <lee@kernel.org>
To: git@apitzsch.eu
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] leds: sy7802: Add support for Silergy SY7802
 flash LED controller
Message-ID: <20240503071953.GD1227636@google.com>
References: <20240401-sy7802-v2-0-1138190a7448@apitzsch.eu>
 <20240401-sy7802-v2-2-1138190a7448@apitzsch.eu>
 <20240411124855.GJ1980182@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240411124855.GJ1980182@google.com>

On Thu, 11 Apr 2024, Lee Jones wrote:

> On Mon, 01 Apr 2024, André Apitzsch via B4 Relay wrote:
> 
> > From: André Apitzsch <git@apitzsch.eu>
> > 
> > Add support for SY7802 flash LED controller. It can support up to 1.8A
> > flash current.
> 
> This is a very small commit message for a 500+ line change!
> 
> Please, tell us more.
> 
> > Signed-off-by: André Apitzsch <git@apitzsch.eu>
> > ---
> >  drivers/leds/flash/Kconfig       |  11 +
> >  drivers/leds/flash/Makefile      |   1 +
> >  drivers/leds/flash/leds-sy7802.c | 532 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 544 insertions(+)
> > 
> > diff --git a/drivers/leds/flash/Kconfig b/drivers/leds/flash/Kconfig
> > index 809b6d98bb3e..f39f0bfe6eef 100644
> > --- a/drivers/leds/flash/Kconfig
> > +++ b/drivers/leds/flash/Kconfig
> > @@ -121,4 +121,15 @@ config LEDS_SGM3140
> >  	  This option enables support for the SGM3140 500mA Buck/Boost Charge
> >  	  Pump LED Driver.
> >  
> > +config LEDS_SY7802
> > +	tristate "LED support for the Silergy SY7802"
> > +	depends on I2C && OF
> > +	depends on GPIOLIB
> > +	select REGMAP_I2C
> > +	help
> > +	  This option enables support for the SY7802 flash LED controller.
> > +	  SY7802 includes torch and flash functions with programmable current.
> > +
> > +	  This driver can be built as a module, it will be called "leds-sy7802".
> > +
> >  endif # LEDS_CLASS_FLASH
> > diff --git a/drivers/leds/flash/Makefile b/drivers/leds/flash/Makefile
> > index 91d60a4b7952..48860eeced79 100644
> > --- a/drivers/leds/flash/Makefile
> > +++ b/drivers/leds/flash/Makefile
> > @@ -11,3 +11,4 @@ obj-$(CONFIG_LEDS_QCOM_FLASH)	+= leds-qcom-flash.o
> >  obj-$(CONFIG_LEDS_RT4505)	+= leds-rt4505.o
> >  obj-$(CONFIG_LEDS_RT8515)	+= leds-rt8515.o
> >  obj-$(CONFIG_LEDS_SGM3140)	+= leds-sgm3140.o
> > +obj-$(CONFIG_LEDS_SY7802)	+= leds-sy7802.o
> > diff --git a/drivers/leds/flash/leds-sy7802.c b/drivers/leds/flash/leds-sy7802.c
> > new file mode 100644
> > index 000000000000..c03a571b0e08
> > --- /dev/null
> > +++ b/drivers/leds/flash/leds-sy7802.c
> > @@ -0,0 +1,532 @@

[...]

> > +static int sy7802_torch_brightness_set(struct led_classdev *lcdev, enum led_brightness level)
> 
> s/level/brightness/
> 
> > +{
> > +	struct sy7802_led *led = container_of(lcdev, struct sy7802_led, flash.led_cdev);
> > +	u32 led_enable_mask = led->led_no == SY7802_LED_JOINT ? SY7802_LEDS_MASK_ALL :
> > +			      SY7802_LEDS_MASK(led->led_no);
> 
> Do all of the fancy multi-line assignment outside of the declaration block.
> 
> > +	u32 enable_mask = SY7802_MODE_MASK | led_enable_mask;
> > +	u32 val = level ? led_enable_mask : SY7802_MODE_OFF;
> > +	struct sy7802 *chip = led->chip;
> > +	u32 curr;
> 
> This is a temporary placeholder for fled_torch_used, right?
> 
> fled_torch_used_tmp?  Sometimes abbreviated to tmp.
> 
> > +	u32 mask;
> 
> That's a lot of masks.  Which one is this?
> 
> > +	int ret;
> > +
> > +	mutex_lock(&chip->mutex);
> > +
> > +	/*
> > +	 * There is only one set of flash control logic, and this flag is used to check if 'strobe'
> 
> The ',' before 'and' is superfluous.
> 
> > +	 * is currently being used.
> > +	 */
> 
> Doesn't the variable name kind of imply this?
> 
> > +	if (chip->fled_strobe_used) {
> > +		dev_warn(chip->dev, "Please disable strobe first [%d]\n", chip->fled_strobe_used);
> 
> "Cannot set torch brightness whilst strobe is enabled"
> 
> > +		ret = -EBUSY;
> > +		goto unlock;
> > +	}
> > +
> > +	if (level)
> > +		curr = chip->fled_torch_used | BIT(led->led_no);
> > +	else
> > +		curr = chip->fled_torch_used & ~BIT(led->led_no);
> > +
> > +	if (curr)
> > +		val |= SY7802_MODE_TORCH;
> > +
> > +	/* Torch needs to be disabled first to apply new brightness */
> 
> "Disable touch to apply brightness"
> 
> > +	ret = regmap_update_bits(chip->regmap, SY7802_REG_ENABLE, SY7802_MODE_MASK,
> > +				 SY7802_MODE_OFF);
> > +	if (ret)
> > +		goto unlock;
> > +
> > +	mask = led->led_no == SY7802_LED_JOINT ? SY7802_TORCH_CURRENT_MASK_ALL :
> 
> Why not just use led->led_no in place of mask?

mask and led->led_no are assigned the same value from this point on.

> Easier to read if you drop SY7802_TORCH_CURRENT_MASK_ALL to its own line.
> 
> > +	       SY7802_TORCH_CURRENT_MASK(led->led_no);
> > +
> > +	/* Register expects brightness between 0 and MAX_BRIGHTNESS - 1 */
> > +	if (level)
> > +		level -= 1;
> > +
> > +	level |= (level << SY7802_TORCH_CURRENT_SHIFT);
> > +
> > +	ret = regmap_update_bits(chip->regmap, SY7802_REG_TORCH_BRIGHTNESS, mask, level);

So why not kill the single-use 'mask' variable and use a cast version of
led->led_no here instead?

> > +	if (ret)
> > +		goto unlock;
> > +
> > +	ret = regmap_update_bits(chip->regmap, SY7802_REG_ENABLE, enable_mask, val);
> > +	if (ret)
> > +		goto unlock;
> > +
> > +	chip->fled_torch_used = curr;
> > +
> > +unlock:
> > +	mutex_unlock(&chip->mutex);
> > +	return ret;
> > +}

-- 
Lee Jones [李琼斯]

