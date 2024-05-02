Return-Path: <linux-kernel+bounces-166177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 514B48B9737
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84275B21E7C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B1653384;
	Thu,  2 May 2024 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pN9ZH4yc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF6E17591;
	Thu,  2 May 2024 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641024; cv=none; b=Tq4Zm7mTxticNYCTzSdbyezVWZRpxzMMiEMQFFOJNTWX8b7L7U6m4VeorlVSUpLJxIjrf6qtC/iZ1f4HqZv55cWF2R0KnPPLtzb6cjRQWZKQfK2IHtS3CiPBXnVf4qTW2mXaWQLWNpWVn21J185pgWJjnJGKXR5K+Ww2ij1YQgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641024; c=relaxed/simple;
	bh=pqUEMpywbjL3PGTluBP7AbWWNUfliHG6Wg20yX2Op8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dH7Ugm7awtr31x+dufd3MwUwW29MCwd7RXToBk+QC9qVYb2SmdxqPH4BUZy8nCCb4m3inv1wf7PADCiyZ5U2InI3uV7PEgRgT3AhANnAgB4iZQn/4ykCC54EGsP1OSGAO3rox6WTLQN53A80QS1vopaHdok5rKNTXlejOeOT+Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pN9ZH4yc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF47C4DDE9;
	Thu,  2 May 2024 09:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714641024;
	bh=pqUEMpywbjL3PGTluBP7AbWWNUfliHG6Wg20yX2Op8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pN9ZH4yc5k1wNcjOQi+aVMZQ6j0QRtiZxFXyIjaHyw4Z2nKqc3N7+n0hq0EDd3XVc
	 CJS+eFiTGegvVg7SrTnH5vgPOmffhFPzMP+OkONJEc3yOWrYtePqaHnTSoCt0nfZXv
	 MEWDlkFfhtCLu3s99ZDQwcUFWr81u6cZ5nbHB9HNEpAu1HdSoameSmGP0M9vE5vE7a
	 5jZQWHp1WwitYTNwLv2WkwHA9w4Pb38SflRFECB/RYxC+9HZqEsBzyYeXJ2lfEkNfz
	 lG3/RS8hrsPCcDw+T2wLIVt4xVcVUVYT8dbL8xbR1PEJ23bLAoNvNI2zk7lTZQKIlE
	 0HQUJhTqZv0iQ==
Date: Thu, 2 May 2024 10:10:17 +0100
From: Lee Jones <lee@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
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
Message-ID: <20240502091017.GF5338@google.com>
References: <20240401-sy7802-v2-0-1138190a7448@apitzsch.eu>
 <20240401-sy7802-v2-2-1138190a7448@apitzsch.eu>
 <20240411124855.GJ1980182@google.com>
 <c5e5f49295350ada2cdb280a77b1c877058d4d64.camel@apitzsch.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5e5f49295350ada2cdb280a77b1c877058d4d64.camel@apitzsch.eu>

On Wed, 01 May 2024, André Apitzsch wrote:

> Hi Lee Jones,
> 
> thanks for the feedback. I will address your comments in the next
> version. I have a few comments/questions though, see below.
> 
> Best regards,
> André
> 
> Am Donnerstag, dem 11.04.2024 um 13:48 +0100 schrieb Lee Jones:
> > On Mon, 01 Apr 2024, André Apitzsch via B4 Relay wrote:
> > > 
> > > [..]
> > > +
> > > +#define SY7802_TIMEOUT_DEFAULT_US	512000U
> > > +#define SY7802_TIMEOUT_MIN_US		32000U
> > > +#define SY7802_TIMEOUT_MAX_US		1024000U
> > > +#define SY7802_TIMEOUT_STEPSIZE_US	32000U
> > > +
> > > +#define SY7802_TORCH_BRIGHTNESS_MAX 8
> > > +
> > > +#define SY7802_FLASH_BRIGHTNESS_DEFAULT	14
> > > +#define SY7802_FLASH_BRIGHTNESS_MIN	0
> > > +#define SY7802_FLASH_BRIGHTNESS_MAX	15
> > > +#define SY7802_FLASH_BRIGHTNESS_STEP	1
> > 
> > Much nicer to read if everything was aligned.
> 
> Using tab size 8, SY7802_FLASH_BRIGHTNESS_* look aligned to me. Do you
> refer to SY7802_TORCH_BRIGHTNESS_MAX here? 

These were not aligned in my mailer.  You can ignore.

> > > [..]
> > > +
> > > +	/*
> > > +	 * There is only one set of flash control logic, and this
> > > flag is used to check if 'strobe'
> > 
> > The ',' before 'and' is superfluous.
> > 
> > > +	 * is currently being used.
> > > +	 */
> > 
> > Doesn't the variable name kind of imply this?
> > 
> > > +	if (chip->fled_strobe_used) {
> > > +		dev_warn(chip->dev, "Please disable strobe first
> > > [%d]\n", chip->fled_strobe_used);
> > 
> > "Cannot set torch brightness whilst strobe is enabled"
> 
> The comment and the warn message are taken from 'leds-mt6370-flash.c'.
> But I think using the warn message you suggested the comment can be
> removed.

It's an improvement, right?

> > > +		ret = -EBUSY;
> > > +		goto unlock;
> > > +	}
> > > +
> > > +	if (level)
> > > +		curr = chip->fled_torch_used | BIT(led->led_no);
> > > +	else
> > > +		curr = chip->fled_torch_used & ~BIT(led->led_no);
> > > +
> > > +	if (curr)
> > > +		val |= SY7802_MODE_TORCH;
> > > +
> > > +	/* Torch needs to be disabled first to apply new
> > > brightness */
> > 
> > "Disable touch to apply brightness"
> > 
> > > +	ret = regmap_update_bits(chip->regmap, SY7802_REG_ENABLE,
> > > SY7802_MODE_MASK,
> > > +				 SY7802_MODE_OFF);
> > > +	if (ret)
> > > +		goto unlock;
> > > +
> > > +	mask = led->led_no == SY7802_LED_JOINT ?
> > > SY7802_TORCH_CURRENT_MASK_ALL :
> > 
> > Why not just use led->led_no in place of mask?
> 
> I might be missing something, but I don't know how to use led->led_no
> in place of mask, when
> led->led_no is in {0,1,2} and
> mask is in {0x07, 0x38, 0x3f}.

This doesn't make much sense.

I guess you mean that led_no is a u8 and mask is a u32.

What happens if you cast led_no to u32 in the call to regmap_update_bits()?

> > Easier to read if you drop SY7802_TORCH_CURRENT_MASK_ALL to its own
> > line.
> > 
> > > +	       SY7802_TORCH_CURRENT_MASK(led->led_no);
> > > +
> > > [..]
> > > +
> > > +static int sy7802_probe(struct i2c_client *client)
> > > +{
> > > +	struct device *dev = &client->dev;
> > > +	struct sy7802 *chip;
> > > +	size_t count;
> > > +	int ret;
> > > +
> > > +	count = device_get_child_node_count(dev);
> > > +	if (!count || count > SY7802_MAX_LEDS)
> > > +		return dev_err_probe(dev, -EINVAL,
> > > +		       "No child node or node count over max led
> > > number %zu\n", count);
> > 
> > Split them up and report on them individually or combine the error
> > message:
> > 
> > "Invalid amount of LED nodes"
> 
> This snippet was also taken from 'leds-mt6370-flash.c'.

Old mistakes should not be repeated. :)

-- 
Lee Jones [李琼斯]

