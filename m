Return-Path: <linux-kernel+bounces-165412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F318B8C69
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D9AAB21410
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6518612F58D;
	Wed,  1 May 2024 15:01:36 +0000 (UTC)
Received: from smtprelay03.ispgateway.de (smtprelay03.ispgateway.de [80.67.29.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2382A5FBB1;
	Wed,  1 May 2024 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.29.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575696; cv=none; b=lSQXEbJf2RDY0jyneU+bkO08P4YmLzu/F0mJcsO3RXVjOadtW/wezVJs/EoKpHOMTbBNOzd+6oFEZi43fNBEd8g0QC5KYh78wkrXkHV7cHxn7SDEfwT+chrip19KRd7lu96kOgzifnlHNTd3nQcDBuJwNzeD9ZrxEQag2BKsBZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575696; c=relaxed/simple;
	bh=NvCi5JvUW+/oPdxAzW+ciyt2Sx1QV/dEnicrPhl7NDg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t2BlLAdFAWQO09n5ePpsE8dakZRvR+pvDXC0OKZik9QrLRiGZgSztyY0Tk4672Y1PukUugc4kOM31SZSW7ueminl9L5PShwUkOmk1izIvA5Zh0/oGNTulL7bqA8NlUd/sbqNxqyMtyM5WOf8Z8aZHE+2gP8Xbgz8pT2HgW2VsYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apitzsch.eu; spf=pass smtp.mailfrom=apitzsch.eu; arc=none smtp.client-ip=80.67.29.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apitzsch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apitzsch.eu
Received: from [92.206.191.65] (helo=framework.lan)
	by smtprelay03.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <git@apitzsch.eu>)
	id 1s2BQb-000000002oW-10Po;
	Wed, 01 May 2024 16:59:25 +0200
Message-ID: <c5e5f49295350ada2cdb280a77b1c877058d4d64.camel@apitzsch.eu>
Subject: Re: [PATCH v2 2/3] leds: sy7802: Add support for Silergy SY7802
 flash LED controller
From: =?ISO-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
To: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Kees Cook <keescook@chromium.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>,  Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Date: Wed, 01 May 2024 16:59:34 +0200
In-Reply-To: <20240411124855.GJ1980182@google.com>
References: <20240401-sy7802-v2-0-1138190a7448@apitzsch.eu>
	 <20240401-sy7802-v2-2-1138190a7448@apitzsch.eu>
	 <20240411124855.GJ1980182@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=

Hi Lee Jones,

thanks for the feedback. I will address your comments in the next
version. I have a few comments/questions though, see below.

Best regards,
Andr=C3=A9

Am Donnerstag, dem 11.04.2024 um 13:48 +0100 schrieb Lee Jones:
> On Mon, 01 Apr 2024, Andr=C3=A9 Apitzsch via B4 Relay wrote:
> >=20
> > [..]
> > +
> > +#define SY7802_TIMEOUT_DEFAULT_US	512000U
> > +#define SY7802_TIMEOUT_MIN_US		32000U
> > +#define SY7802_TIMEOUT_MAX_US		1024000U
> > +#define SY7802_TIMEOUT_STEPSIZE_US	32000U
> > +
> > +#define SY7802_TORCH_BRIGHTNESS_MAX 8
> > +
> > +#define SY7802_FLASH_BRIGHTNESS_DEFAULT	14
> > +#define SY7802_FLASH_BRIGHTNESS_MIN	0
> > +#define SY7802_FLASH_BRIGHTNESS_MAX	15
> > +#define SY7802_FLASH_BRIGHTNESS_STEP	1
>=20
> Much nicer to read if everything was aligned.

Using tab size 8, SY7802_FLASH_BRIGHTNESS_* look aligned to me. Do you
refer to SY7802_TORCH_BRIGHTNESS_MAX here?=20

>=20
> > [..]
> > +
> > +	/*
> > +	 * There is only one set of flash control logic, and this
> > flag is used to check if 'strobe'
>=20
> The ',' before 'and' is superfluous.
>=20
> > +	 * is currently being used.
> > +	 */
>=20
> Doesn't the variable name kind of imply this?
>=20
> > +	if (chip->fled_strobe_used) {
> > +		dev_warn(chip->dev, "Please disable strobe first
> > [%d]\n", chip->fled_strobe_used);
>=20
> "Cannot set torch brightness whilst strobe is enabled"

The comment and the warn message are taken from 'leds-mt6370-flash.c'.
But I think using the warn message you suggested the comment can be
removed.

>=20
> > +		ret =3D -EBUSY;
> > +		goto unlock;
> > +	}
> > +
> > +	if (level)
> > +		curr =3D chip->fled_torch_used | BIT(led->led_no);
> > +	else
> > +		curr =3D chip->fled_torch_used & ~BIT(led->led_no);
> > +
> > +	if (curr)
> > +		val |=3D SY7802_MODE_TORCH;
> > +
> > +	/* Torch needs to be disabled first to apply new
> > brightness */
>=20
> "Disable touch to apply brightness"
>=20
> > +	ret =3D regmap_update_bits(chip->regmap, SY7802_REG_ENABLE,
> > SY7802_MODE_MASK,
> > +				 SY7802_MODE_OFF);
> > +	if (ret)
> > +		goto unlock;
> > +
> > +	mask =3D led->led_no =3D=3D SY7802_LED_JOINT ?
> > SY7802_TORCH_CURRENT_MASK_ALL :
>=20
> Why not just use led->led_no in place of mask?

I might be missing something, but I don't know how to use led->led_no
in place of mask, when
led->led_no is in {0,1,2} and
mask is in {0x07, 0x38, 0x3f}.

>=20
> Easier to read if you drop SY7802_TORCH_CURRENT_MASK_ALL to its own
> line.
>=20
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SY7802_TORCH_CURRENT_MASK(led->l=
ed_no);
> > +
> > [..]
> > +
> > +static int sy7802_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev =3D &client->dev;
> > +	struct sy7802 *chip;
> > +	size_t count;
> > +	int ret;
> > +
> > +	count =3D device_get_child_node_count(dev);
> > +	if (!count || count > SY7802_MAX_LEDS)
> > +		return dev_err_probe(dev, -EINVAL,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "No child node or node count ov=
er max led
> > number %zu\n", count);
>=20
> Split them up and report on them individually or combine the error
> message:
>=20
> "Invalid amount of LED nodes"

This snippet was also taken from 'leds-mt6370-flash.c'.

>=20

