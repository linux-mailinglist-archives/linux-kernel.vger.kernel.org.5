Return-Path: <linux-kernel+bounces-9432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC2E81C56A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710981C24DD1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBCF9444;
	Fri, 22 Dec 2023 07:10:51 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127E38F67
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 07:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGZg7-00065I-6s; Fri, 22 Dec 2023 08:10:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGZg4-000hWu-Q2; Fri, 22 Dec 2023 08:10:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGZg5-001a8v-JY; Fri, 22 Dec 2023 08:10:37 +0100
Date: Fri, 22 Dec 2023 08:10:32 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-pwm@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Thierry Reding <thierry.reding@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: Re: [RFC PATCH v1] regulator: pwm-regulator: Fix continuous
 get_voltage for disabled PWM
Message-ID: <2f2bc3xvemk2x3sno65so6vglmpavjtyeiqzy6yyzwvx5hqtmi@tsfx2hr7rmqp>
References: <20231221211222.1380658-1-martin.blumenstingl@googlemail.com>
 <tek6c6symqgm6x6ujh4m67q32en24pzrkjbchffir7qljo4gor@7qpu4zmgyzpq>
 <CAFBinCAxh0xU2mDRX3t42j6oJ534p9RPUV+dYoRe0oacTw_7iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4gmofv63e2ybipgt"
Content-Disposition: inline
In-Reply-To: <CAFBinCAxh0xU2mDRX3t42j6oJ534p9RPUV+dYoRe0oacTw_7iA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--4gmofv63e2ybipgt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Good morning Martin,

On Fri, Dec 22, 2023 at 01:17:44AM +0100, Martin Blumenstingl wrote:
> On Thu, Dec 21, 2023 at 11:03=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> [...]
> > Note this isn't save in general. You're implicitly assuming that a
> > disabled PWM runs with the minimal supported duty_cycle. Most disabled
> > PWMs yield the inactive level (which corresponds to a 0% relative duty
> > cycle). But there are exceptions.
> Good catch - thank you!
>=20
> [...]
> > Without claiming to understand all implications, I'd say
> > pwm_regulator_get_voltage should signal to the caller when the
> > duty_cycle isn't contained in [min(max_uV_duty, min_uV_duty),
> > max(max_uV_duty, min_uV_duty)].
> It seems like there's -ENOTRECOVERABLE that we can signal to the caller.
> This makes the following message appear in my kernel log:
>   VDDEE: Setting 1100000-1140000uV
> Which means that pwm_regulator_set_voltage() is called which will then
> pick the minimum voltage.
>=20
> To make this work I will need to update meson8b-odroidc1.dts (which
> isn't a problem, I just want to point it out as it's mandatory for
> that solution. also I will send that in a separate patch).
>=20
> See my attached patch (which replaces the initial patch I sent, it's
> not meant to be applied on top).
> One question that I still have is whether we are allowed to just
> enable the PWM output within pwm_regulator_set_voltage().
> Doing so is actually mandatory, otherwise we end up in an infinite
> loop of not being able to read the voltage, then sets the minimum
> voltage (but leaves the PWM output disabled) which then means that it
> can't read back the voltage which means it tries to set the minimum
> voltage ....

Without enabling the PWM pwm_regulator_set_voltage() doesn't work if the
PWM isn't enabled already when the function is entered. So I'd say yes,
you must enable it.

> diff --git a/arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts b/arch/arm/bo=
ot/dts/amlogic/meson8b-odroidc1.dts
> index b03273d90ad8..df348e119643 100644
> --- a/arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts
> +++ b/arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts
> @@ -217,13 +217,13 @@ vddee: regulator-vddee {
>  		compatible =3D "pwm-regulator";
> =20
>  		regulator-name =3D "VDDEE";
> -		regulator-min-microvolt =3D <860000>;
> +		regulator-min-microvolt =3D <1100000>;
>  		regulator-max-microvolt =3D <1140000>;
> =20
>  		pwm-supply =3D <&p5v0>;
> =20
>  		pwms =3D <&pwm_cd 1 12218 0>;
> -		pwm-dutycycle-range =3D <91 0>;
> +		pwm-dutycycle-range =3D <14 0>;

This is ugly. You have to take away the description that a relative
duty-cycle of 91% yields 860 mV just because the linux driver behaves in
a certain way.

Also the calculation is wrong: If a relative duty-cyle in the interval
[91%; 0%] maps lineary to [860 mV; 1140 mV] you get 1100 mV at

	     1100 mV - 860 mV
	91 + ---------------- * (0 - 91) =3D 13
	     1140 mV - 860 mV

(If the calculations in the driver used signed multiplication and
division, all the checks for max_uV_duty < min_uV_duty could just go
away.)

So you want

+		pwm-dutycycle-range =3D <13 0>;

(if this restriction is really necessary).

>  		regulator-boot-on;
>  		regulator-always-on;

> diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-re=
gulator.c
> index 30402ee18392..cb4e5fad5702 100644
> --- a/drivers/regulator/pwm-regulator.c
> +++ b/drivers/regulator/pwm-regulator.c
> @@ -156,13 +156,10 @@ static int pwm_regulator_get_voltage(struct regulat=
or_dev *rdev)
>  	unsigned int voltage;
> =20
>  	pwm_get_state(drvdata->pwm, &pstate);
> +	if (!pstate.enabled)
> +		return -ENOTRECOVERABLE;

This is good.

> =20
> -	if (pstate.enabled)
> -		voltage =3D pwm_get_relative_duty_cycle(&pstate, duty_unit);
> -	else if (max_uV_duty < min_uV_duty)
> -		voltage =3D max_uV_duty;
> -	else
> -		voltage =3D min_uV_duty;
> +	voltage =3D pwm_get_relative_duty_cycle(&pstate, duty_unit);

I'd add here:

	if (voltage < min(max_uV_duty, min_uV_duty) ||
	    voltage > max(max_uV_duty, min_uV_duty))
		return -ENOTRECOVERABLE;

>  	/*
>  	 * The dutycycle for min_uV might be greater than the one for max_uV.
> @@ -221,6 +218,7 @@ static int pwm_regulator_set_voltage(struct regulator=
_dev *rdev,
> =20
>  	pwm_set_relative_duty_cycle(&pstate, dutycycle, duty_unit);
> =20
> +	pstate.enabled =3D true;
>  	ret =3D pwm_apply_state(drvdata->pwm, &pstate);
>  	if (ret) {
>  		dev_err(&rdev->dev, "Failed to configure PWM: %d\n", ret);

Otherwise the change to the driver looks fine to me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4gmofv63e2ybipgt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWFNmQACgkQj4D7WH0S
/k4TOQf/d8O8wmX+LkJC2a8BSERU4HtUlWlaHabQJIiBMC3U9ZMB2wlEboBiR0zz
z6oXxw2jFOMCF4JWmQtBFJAamwLMQzs/6AqOPNWXfmv4WAM/W0jbQejTQkCjo3n4
irm/kIzBSf1QY45/j1PJ+2QGb3q/tHmTHIo3oaSZ997tLi7tHvOHsiqkveyPdnyZ
ZN/r6dI7VDAYb7hycjBTSb/jNrMG7ls7BejTDJYt5jDtv8VZyiT2eb6IhO8fz9n0
6AwxpFpKLdbzweHgZ8gCYa+5/zOB6W7vjicRXs7O7SJvBGYfPwr3W+oRQsb+AAED
8ZatcPYn9Uclzl8dfI+XDh3ZkQ/NJg==
=2XZr
-----END PGP SIGNATURE-----

--4gmofv63e2ybipgt--

