Return-Path: <linux-kernel+bounces-53182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0122084A1CA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9C11C22F96
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A21047F52;
	Mon,  5 Feb 2024 18:07:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA92481AA
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156442; cv=none; b=k5GR8k9Z4aASMLXdNDgaWU3J1ZoDZAHultAa5qZ03mik7CR1GpqqS++lLuQ14Nx8GpS4r8TDTKv2WoM+WHzm5Ggu17uzNUcEyIBT00zJACZK91hLDdkYRIjG/6IVqQXvb2FoCWBz9mFUKCLFXMaiY2GFvGz2gJuI7B785rzvrdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156442; c=relaxed/simple;
	bh=WekkH0x+wQr8GCr9nI/D/6WcaPx85LhuLjShRfa0J68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5r7+hL29+W/VhF4XIf5kfHKJSVHOONtkbMVE50Z2Lza6sIISV45forYjzd6QRi628h3jemOA3Eps4LCYcti/JSO82sYc8rb+fRUG46+bx4ECt218n9uUe7uzIntg2gtzl5gicfs5M6Plu50rUyB6Cg/QDXX6T3Jt+l8FwQN5nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rX3ND-0002rX-MG; Mon, 05 Feb 2024 19:07:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rX3NC-004fwa-68; Mon, 05 Feb 2024 19:07:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rX3NC-00Fkrt-0H;
	Mon, 05 Feb 2024 19:07:14 +0100
Date: Mon, 5 Feb 2024 19:07:13 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Nylon Chen <nylon.chen@sifive.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, conor@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	aou@eecs.berkeley.edu, thierry.reding@gmail.com, vincent.chen@sifive.com, 
	zong.li@sifive.com, nylon7717@gmail.com
Subject: Re: [PATCH v8 2/3] pwm: sifive: change the PWM controlled LED
 algorithm
Message-ID: <4kqkazromkzyhic2mgyyjrh4jlnp6djfuotu37btdfolqp5e2o@6jkbjnahvrbo>
References: <20240126074045.20159-1-nylon.chen@sifive.com>
 <20240126074045.20159-3-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ngq5sitimfjzgek5"
Content-Disposition: inline
In-Reply-To: <20240126074045.20159-3-nylon.chen@sifive.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--ngq5sitimfjzgek5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Regarding the Subject: The patch has nothing to do with an LED, has it?

On Fri, Jan 26, 2024 at 03:40:44PM +0800, Nylon Chen wrote:
> The `frac` variable represents the pulse inactive time, and the result
> of this algorithm is the pulse active time. Therefore, we must reverse th=
e result.

Please break lines at 75 columns in the commit log.

> The reference is SiFive FU740-C000 Manual[0]
>=20
> Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b=
16acba_fu740-c000-manual-v1p6.pdf [0]

I looked at Figure 29 in this document (version v1p6, pdf page 148). Not
sure I understand that correctly, but I expect that the output of the
">=3D?" node below pwmcmp0 to become 1 if pwms has reached pwmcmp0, is
that right? In that case this output is zero when pwmcount is zero and
then pwmcmp0ip is zero, too. So a period starts with the inactive part
and so it's inversed polarity.

What made you think that the current driver implementation is wrong?

> Co-developed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> ---
>  drivers/pwm/pwm-sifive.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> index eabddb7c7820..b07c8598bb21 100644
> --- a/drivers/pwm/pwm-sifive.c
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -113,6 +113,7 @@ static int pwm_sifive_get_state(struct pwm_chip *chip=
, struct pwm_device *pwm,
>  	u32 duty, val;
> =20
>  	duty =3D readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
> +	duty =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - duty;

I find it irritating that both values are assigned to duty. I'd spend
another variable and make this:

	inactive =3D readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
	duty =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - inactive;


> =20
>  	state->enabled =3D duty > 0;
> =20
> @@ -123,11 +124,10 @@ static int pwm_sifive_get_state(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
>  	state->period =3D ddata->real_period;
>  	state->duty_cycle =3D
>  		(u64)duty * ddata->real_period >> PWM_SIFIVE_CMPWIDTH;
> -	state->polarity =3D PWM_POLARITY_INVERSED;
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> =20
>  	return 0;
>  }
> -

Please keep this empty line between functions.

>  static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
>  			    const struct pwm_state *state)
>  {

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ngq5sitimfjzgek5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXBI9AACgkQj4D7WH0S
/k5uxQgAnQ/SvX4+QQISrWgnYygCgVlr4ryD5EN3wAHNeDGn3EvG8hNVvZTlQtZV
CA5wYClIyGjAq6Qeg/tlfwjhthtMinqwQZpZ0K67c/Fr51cp0ic7PNKWkQF3UMWf
EaShSF6NIyFsCX25OZNa9lUpMgp9hx+klZ0gFSL5aZ9n/MGmgM4In68YfKEQsS01
X/LgQj0AwDo5utQmLL+zp8sKneEs5WM7/Wcs7910eC/+bpo4fBBs5D1R7ap8LHts
J6qse4XMtdHJyHQxXuDq2/tH4+ttAz7lodvJuYSjGoU/OAhCOUNx0rF+TgUFs5zj
FqHeGOJyQ2QKYeqv3kqqjdd3VpHLjw==
=4mPe
-----END PGP SIGNATURE-----

--ngq5sitimfjzgek5--

