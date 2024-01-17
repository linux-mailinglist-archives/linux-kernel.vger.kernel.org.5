Return-Path: <linux-kernel+bounces-29070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51B38307D9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3141C23E67
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDE920330;
	Wed, 17 Jan 2024 14:18:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1B22031B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705501117; cv=none; b=ZnXqOqz11KoS4wxMW0S7ndfKOq2+HjSG4LDLPrrjEFdBOMdSnCx1H8+7xuxXTZXirDF/kiNm428YCZG3FNYY4TTwZliFIvJ7CBDtC0LnW7neFQo3bVkcpeufK4TLk/QK2cvd0UDy3ZUWd/M7v4nicfNwzZivfKSmA1atXFWzKFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705501117; c=relaxed/simple;
	bh=0vI/iw4mkCiFIxi1iYkkIkW0s6RagRQLcWMYC3yha58=;
	h=Received:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:
	 X-SA-Exim-Scanned:X-PTX-Original-Recipient; b=lOKi5vU5lZwzbT4uWPAyr6eYLzKt5wP2/3jjOwC8u77BmR87PmFpMRnTJYJsye5pDCAP2G2zCrvSdsEizBuYlY12cGacq2h+pdRK//QFdrIK1ut1dz0pluA+QhUd6qmEPvnZFT0WmPsi/lQx7UlA/JuPwInqxPk1ba9SQFDhFvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQ6kP-0003p0-6z; Wed, 17 Jan 2024 15:18:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQ6kO-000UJe-67; Wed, 17 Jan 2024 15:18:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQ6kO-001mWl-0I;
	Wed, 17 Jan 2024 15:18:28 +0100
Date: Wed, 17 Jan 2024 15:18:27 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.hennerich@analog.com, nuno.sa@analog.com, devicetree@vger.kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Subject: Re: [PATCH 2/2] pwm: Add driver for AXI PWM generator
Message-ID: <rph3di2izoqdlxbj2dzdt7nydvmze373pazeopmim5bny4d7qi@d2fus3wzuhj7>
References: <20240115201222.1423626-1-tgamblin@baylibre.com>
 <20240115201222.1423626-3-tgamblin@baylibre.com>
 <gbessnmierg5gvdguhwauoe2mxr3krwcfk2afhazrqvz45md64@itbchezepncg>
 <e6fbf553-f2f8-47ea-8781-cf01d37196a5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="az43kqsaevecs6w2"
Content-Disposition: inline
In-Reply-To: <e6fbf553-f2f8-47ea-8781-cf01d37196a5@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--az43kqsaevecs6w2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Trevor,

On Wed, Jan 17, 2024 at 07:51:26AM -0500, Trevor Gamblin wrote:
> On 2024-01-15 16:18, Uwe Kleine-K=F6nig wrote:
> > On Mon, Jan 15, 2024 at 03:12:21PM -0500, Trevor Gamblin wrote:
> > > +#define AXI_PWMGEN_TEST_DATA		0x5A0F0081
> > Is this a documented constant, or just a random (as in xkcd#221) value?
>=20
> This is just a random (as in xkcd#221) value to write to the scratch
> register.

Then I suggest to add a comment telling that.

> > > +	period_cnt =3D DIV_ROUND_UP_ULL(state->period * clk_rate_hz, NSEC_P=
ER_SEC);
> > The multiplication might overflow. Please use mul_u64_u64_div_u64() (or
> > one of its variant) and error out on clk_rate_hz > NSEC_PER_SEC.
> >=20
> > Also round-up is wrong. I would expect that enabling PWM_DEBUG and
> > enough testing should tell you that. .apply is supposed to implement the
> > biggest period not bigger than the requested one. So you have to round
> > down here.
> To be clear, I should use mul_u64_u64_div_u64 only, or should I round down
> afterwards with another function as well?

mul_u64_u64_div_u64() already rounds down.

> > > +	if (period_cnt > UINT_MAX)
> > > +		return -EINVAL;
> > That's wrong. Please continue with period_cnd =3D UINT_MAX here.
> >=20
> > Instead you should probably error out on period_cnt =3D=3D 0.
> >=20
> > > +	pwm->ch_period[ch] =3D period_cnt;
> > > +	pwm->ch_enabled[ch] =3D state->enabled;
> > > +	ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), state->enab=
led ? period_cnt : 0);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	duty_cnt =3D DIV_ROUND_UP_ULL(state->duty_cycle * clk_rate_hz, NSEC=
_PER_SEC);
> > > +	ret =3D regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), duty_cnt);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return regmap_write(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_LOAD_=
CONFIG);
> > I assume this means that the writes above are to shadow registers and on
> > this write they are latched into the hardware. So there is no glitch?!
> >=20
> > Does this wait for the currently running period to complete before
> > switching to the new configuration?
> >=20
> > Please document these two hardware properties in a "Limitations"
> > paragraph at the top of the driver. See other drivers for the format.
>=20
> The registers are shadow registers and changes don't take effect right aw=
ay.
> It also keeps the phase offset in sync between outputs.

I don't understand that. This only makes sense if the different PWMs
share the same period length, doesn't it?

Please add this to the Limitations paragraph, too.

> > > +static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_de=
vice *device,
> > > +				struct pwm_state *state)
> > > +{
> > > +	struct axi_pwmgen *pwm =3D to_axi_pwmgen(chip);
> > > +	unsigned long clk_rate_hz =3D clk_get_rate(pwm->clk);
> > > +	struct regmap *regmap =3D pwm->regmap;
> > > +	unsigned int ch =3D device->hwpwm;
> > > +	u32 cnt;
> > > +	int ret;
> > > +
> > > +	if (!clk_rate_hz) {
> > > +		dev_err(device->chip->dev, "axi pwm clock has no frequency\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	state->enabled =3D pwm->ch_enabled[ch];
> > > +
> > > +	if (state->enabled) {
> > > +		ret =3D regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(ch), &cnt);
> > > +		if (ret)
> > > +			return ret;
> > > +	} else {
> > > +		cnt =3D pwm->ch_period[ch];
> > > +	}
> > If state->enabled is false, state->period is (or should) be ignored by
> > the caller, so there shouldn't be a need to track ch_period.
> >=20
> > Also ch_enabled shouldn't be needed. Just reporting
> > AXI_PWMGEN_CHX_PERIOD(ch) =3D=3D 0 as disabled should work fine?!
> >=20
> > I think then you also don't need to artificially limit npwm to four.
> The only concern I have with not tracking ch_period is that it might not =
be
> clear what period to restore after disabling and re-enabling the device,
> unless I'm missing something.

A consumer that reenables the device should use pwm_apply_* which gets
the complete state that should be configured. (And for the few other
cases, this is solved in the core.)

> > > +	pwm->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> > > +	if (IS_ERR(pwm->clk))
> > > +		return dev_err_probe(&pdev->dev, PTR_ERR(pwm->clk), "failed to get=
 clock\n");
> > Please call clk_rate_exclusive_get() on pwm->clk and cache the rate in
> > struct axi_pwmgen.
> >=20
> > > +	pwm->chip.dev =3D &pdev->dev;
> > > +	pwm->chip.ops =3D &axi_pwmgen_pwm_ops;
> > > +	pwm->chip.base =3D -1;
> > Don't assign .base.
> Alright. I will set pwm->chip.atomic as per Sean's comment as well.

Sounds good.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--az43kqsaevecs6w2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWn4bIACgkQj4D7WH0S
/k54cwf/VyTy7fh72MUwhCHWYDFU0aaQNBu38femzw3/fReWeSnnTuvZUVAzloej
m6x0XoXw8jiJBDyxKXvSA3OETB94CKLDZc5iuREBneSx0rcKGYPxekzdNqwMgp4l
5Du7drDCvISRaUWn9mreacHTraxkroHl6XmZ2szEHagKAxx40ZiiV/yuGqMLlS2q
tuErCfNKVDzMLknNE9qNRRI4+0Qdq2r62u2xFDbQhV3RgfkfKO8g35NrFg1rGlyr
a/kaWf5WgaSXwbNB6iR0JaLc16I0cSueok3cFZUbIo0dNsXUnYoyul7hfySZEQjG
GKbW+wQyNyST4rC7PqpiKMFgJ0+1bg==
=ImPA
-----END PGP SIGNATURE-----

--az43kqsaevecs6w2--

