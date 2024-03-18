Return-Path: <linux-kernel+bounces-106501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7296D87EF88
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2835F1F2399C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A93A56441;
	Mon, 18 Mar 2024 18:16:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4749655E50
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710785785; cv=none; b=SKpbjE9XC9CGpVSC4DkwpWho+Xb0wky7DoISD7EBtMj40fjeSr0U4/C/ddZ6MEzRK+UvzE6mlvT6U6TF6HopQ0QcsGUv/a+hnLYMjx6tuz/G5x9e865m/UtxXz8FNulqGVs8xPXAcRp+h47kqYvcukQN2lnWOQhMBlCAufOQLCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710785785; c=relaxed/simple;
	bh=OMoSLdVOhugL9CaocEM0BFlIYi0g7blZ2jo89hV4xCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFbn2+ruEIH+mahFdDoNAnl3nKGTpz+JTiRqhCDO/DcFczc+9WtPqVkeTVbrDA1xf2mwxvnjjroEQW9SVj8zkjYTh7IciosXHdiBAMlo5khcd3Q8uuHI1elKazjfLI1BvSb+Iuj60OzZVn37mS2LnvayqhpsJUHY44fQUKqx55s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rmHWy-0007zD-DD; Mon, 18 Mar 2024 19:16:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rmHWw-0077xD-MN; Mon, 18 Mar 2024 19:16:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rmHWw-00872I-1u;
	Mon, 18 Mar 2024 19:16:14 +0100
Date: Mon, 18 Mar 2024 19:16:14 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Nylon Chen <nylon.chen@sifive.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, conor@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	aou@eecs.berkeley.edu, thierry.reding@gmail.com, vincent.chen@sifive.com, 
	zong.li@sifive.com, nylon7717@gmail.com
Subject: Re: [PATCH v9 2/3] pwm: sifive: change the PWM algorithm
Message-ID: <f5ukvah2ujko2iht3pd5jxq5kaukbs5z3pn5s7qwcnx4aqr3yv@mwtbwkcfa44a>
References: <20240222081231.213406-1-nylon.chen@sifive.com>
 <20240222081231.213406-3-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sht7baa5xh6fhhdu"
Content-Disposition: inline
In-Reply-To: <20240222081231.213406-3-nylon.chen@sifive.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--sht7baa5xh6fhhdu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 04:12:30PM +0800, Nylon Chen wrote:
> The `frac` variable represents the pulse inactive time, and the result
> of this algorithm is the pulse active time.
> Therefore, we must reverse the result.
>=20
> The reference is SiFive FU740-C000 Manual[0]
>=20
> Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b=
16acba_fu740-c000-manual-v1p6.pdf [0]
>=20
> Co-developed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> ---
>  drivers/pwm/pwm-sifive.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> index eabddb7c7820..a586cfe4191b 100644
> --- a/drivers/pwm/pwm-sifive.c
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -110,9 +110,10 @@ static int pwm_sifive_get_state(struct pwm_chip *chi=
p, struct pwm_device *pwm,
>  				struct pwm_state *state)
>  {
>  	struct pwm_sifive_ddata *ddata =3D pwm_sifive_chip_to_ddata(chip);
> -	u32 duty, val;
> +	u32 duty, val, inactive;
> =20
> -	duty =3D readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
> +	inactive =3D readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
> +	duty =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - inactive;
> =20
>  	state->enabled =3D duty > 0;
> =20
> @@ -123,7 +124,7 @@ static int pwm_sifive_get_state(struct pwm_chip *chip=
, struct pwm_device *pwm,
>  	state->period =3D ddata->real_period;
>  	state->duty_cycle =3D
>  		(u64)duty * ddata->real_period >> PWM_SIFIVE_CMPWIDTH;
> -	state->polarity =3D PWM_POLARITY_INVERSED;
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> =20
>  	return 0;
>  }
> @@ -139,7 +140,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	int ret =3D 0;
>  	u32 frac;
> =20
> -	if (state->polarity !=3D PWM_POLARITY_INVERSED)
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
>  		return -EINVAL;
> =20
>  	cur_state =3D pwm->state;
> @@ -159,6 +160,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
>  	/* The hardware cannot generate a 100% duty cycle */

Is this still true now that we know that PWM_SIFIVE_PWMCMP is the
inactive time in a period? If you fix that, the same claim in the header
of the driver needs adaption, too.

>  	frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> +	frac =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;

I like the additional variable in pwm_sifive_get_state(). Can you please
add one here, too?

>  	mutex_lock(&ddata->lock);
>  	if (state->period !=3D ddata->approx_period) {

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sht7baa5xh6fhhdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmX4hO0ACgkQj4D7WH0S
/k5I7Af/anilkuBk6OcjkFY2IstjOdldOJ1UOGE/SIMZvUFUkjlFsQ1Lx9KpG5dY
kIGEQ6h7q9iYUnvK5QwPHm1lj7KReDWg//hJZw0KkbrO7v22cGdcHmA/RS4wGs9u
o0nbvSLnJszi/akI8CbQqiuebkMRzcIaSP3+3mjnxMWeT+74L9jMs17quPen1Jo7
36aLy03/Gd5p+NkUlC9r+6z6s5qWdTzC2c2RpwtRdsujiUJ35TJ70gS/+nCH+dyd
//eyVjdPJRDVx0EYF+mcBjWyGe+Q+3+oh1Mj+LvYtyJY8PFieAceNA8E8hU39pAC
dWsfG3vp+3zxsicL0snmhFPcMqw3+Q==
=LMZN
-----END PGP SIGNATURE-----

--sht7baa5xh6fhhdu--

