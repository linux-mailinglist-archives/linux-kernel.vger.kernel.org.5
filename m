Return-Path: <linux-kernel+bounces-57580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5813984DAF5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1DA71F235CF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDBF6A00A;
	Thu,  8 Feb 2024 08:05:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFBA69E1E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 08:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707379515; cv=none; b=VLYWA+M71mY6o2jsQNCbOxp55wMRsB6UVCvIbG4+/fhdegg2Rz8DR/E+H4/DWDVVX1wOZ7q0PVLEDy20AERLyQfe/GN637ow4FLDfZXOH0AQCfhmvDRSGqbDsXF3XO6+4sciiqBFmil1wl7F1bZlXCmRAu+zII0jU6X6ce+PrhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707379515; c=relaxed/simple;
	bh=XVKk8mNNyH2W2TKyOl5UrYU3KaPEK8JC6mLhXHUYDbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTNV752o1jdLIBBNJHLvJ6gIRBKyFziFnoCZGYzfGlqmmKyUPP912l/0JV/hNfv+7hOdQm8LmYox0z/0aHYd7fXPXQi1HWLq14q5Qi8TZA3AJtKcX3PpxUG7L7yJ5vc1syheIFxPK1HLIVX96+lcntMDlrtC04IA57oRgUqTTF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXzP7-0008V1-CL; Thu, 08 Feb 2024 09:05:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXzP6-005Amy-Bf; Thu, 08 Feb 2024 09:05:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXzP6-000D8b-0o;
	Thu, 08 Feb 2024 09:05:04 +0100
Date: Thu, 8 Feb 2024 09:05:04 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Finn Behrens <me@kloenk.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-pwm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Heisath <jannis@imserv.org>, 
	Yureka Lilian <yuka@yuka.dev>
Subject: Re: [PATCH] gpio-mvebu: no hardcoded timer assignment for pwm
Message-ID: <6chccjdn3yidi7rodcledxx7czt3adjxvaeeneii5ghfiw4oc3@t5qtmnlasvlo>
References: <20240130105515.30258-1-me@kloenk.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="365ufzjbjxz7grxt"
Content-Disposition: inline
In-Reply-To: <20240130105515.30258-1-me@kloenk.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--365ufzjbjxz7grxt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jan 30, 2024 at 11:55:13AM +0100, Finn Behrens wrote:
> Removes the hardcoded timer assignment of timers to pwm controllers.
> This allows to use more than one pwm per gpio bank.
>=20
> Original patch with chip_data interface by Heisath <jannis@imserv.org>
>=20
> Link: https://wiki.kobol.io/helios4/pwm/#patch-requirement
> Co-developed-by: Yureka Lilian <yuka@yuka.dev>
> Signed-off-by: Yureka Lilian <yuka@yuka.dev>
> Signed-off-by: Finn Behrens <me@kloenk.de>

I find this patch hard to understand and I hope it's more complicated
than it could be. I wonder if it would be beneficial to split this patch
in two. In the first patch just introduce the new structures with all
the necessary renaming and only in the second patch implement the added
flexibility.

Some more details below.

>  drivers/gpio/gpio-mvebu.c | 223 ++++++++++++++++++++++++--------------
>  1 file changed, 139 insertions(+), 84 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index a13f3c18ccd4..303ea3be0b69 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -94,21 +94,43 @@
> =20
>  #define MVEBU_MAX_GPIO_PER_BANK		32
> =20
> -struct mvebu_pwm {
> +enum mvebu_pwm_ctrl {
> +	MVEBU_PWM_CTRL_SET_A =3D 0,
> +	MVEBU_PWM_CTRL_SET_B,
> +	MVEBU_PWM_CTRL_MAX
> +};
> +
> +struct mvebu_pwmchip {
>  	struct regmap		*regs;
>  	u32			 offset;
>  	unsigned long		 clk_rate;
> -	struct gpio_desc	*gpiod;
> -	struct pwm_chip		 chip;
>  	spinlock_t		 lock;
> -	struct mvebu_gpio_chip	*mvchip;
> +	bool			 in_use;
> =20
>  	/* Used to preserve GPIO/PWM registers across suspend/resume */
> -	u32			 blink_select;
>  	u32			 blink_on_duration;
>  	u32			 blink_off_duration;
>  };
> =20
> +struct mvebu_pwm_chip_drv {
> +	enum mvebu_pwm_ctrl	 ctrl;
> +	struct gpio_desc	*gpiod;
> +	bool			 master;
> +};
> +
> +struct mvebu_pwm {
> +	struct pwm_chip		 chip;
> +	struct mvebu_gpio_chip	*mvchip;
> +	struct mvebu_pwmchip	 controller;
> +	enum mvebu_pwm_ctrl	 default_controller;
> +
> +	/* Used to preserve GPIO/PWM registers across suspend/resume */
> +	u32				 blink_select;
> +	struct mvebu_pwm_chip_drv	 drv[];
> +};

So we have three different structures related to pwm. Some highlevel
description (in a comment or at least the commit log) about how the
hardware works and which struct describes what would be helpful. I gave
up after 15 min of reading this patch and trying to understand it.

> +static struct mvebu_pwmchip  *mvebu_pwm_list[MVEBU_PWM_CTRL_MAX];

Huh, a static variable. Does that mean we can only have one mvebu_gpio
device?

> +
>  struct mvebu_gpio_chip {
>  	struct gpio_chip   chip;
>  	struct regmap     *regs;
> @@ -285,12 +307,12 @@ mvebu_gpio_write_level_mask(struct mvebu_gpio_chip =
*mvchip, u32 val)
>   * Functions returning offsets of individual registers for a given
>   * PWM controller.
>   */
> -static unsigned int mvebu_pwmreg_blink_on_duration(struct mvebu_pwm *mvp=
wm)
> +static unsigned int mvebu_pwmreg_blink_on_duration(struct mvebu_pwmchip =
*mvpwm)

I'm a fan of picking always the same variable name for the same thing
and different names for different things. "mvpwm" is used for variables
of type struct mvebu_pwmchip and struct mvebu_pwm.

>  {
>  	return mvpwm->offset + PWM_BLINK_ON_DURATION_OFF;
>  }

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--365ufzjbjxz7grxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXEiy8ACgkQj4D7WH0S
/k5ugQf+OkUaqWRhVyLcaDS6bt0BlPaDfFGG5XGSJ4EFd2g0a3kSQbzJvbwuUw8T
RfNfNV0jsjfD0M9IHAcCMwTQqK84zBkVJjcj3YtWnp0g0jeGJR8p7EfGBuLFVIBD
4X+ERnlo6fXwvXGC+y9APhR8254LRo76Jg6Me8RtI+5L8VuTVtBbm1s3M7chM81N
Ki/4lGRZfUhLQ0nRcaJ3Z82dcfqW6taaNwH7/tYLJ/QJ2x1aelxu8FwnBCjg/sRe
JlLn+todDMLP2c0Am2y6lxRiCQVwPmo0pRBBkKpQ2ML3uxyMRaO0BZKc2UxL9MGC
9s//pu6e7mtNE/5Kc4tokjAcxqNF4w==
=lVsG
-----END PGP SIGNATURE-----

--365ufzjbjxz7grxt--

