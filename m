Return-Path: <linux-kernel+bounces-88157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 567C986DDF7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5721C2030D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380136A8A3;
	Fri,  1 Mar 2024 09:15:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847796A34F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284531; cv=none; b=W2huq1u3/oL1Y9eiUDtLtYZMU4xIgBbEXeFQIp/SZqkNUXWP129nOS1oX3GBX+DBvg0tAoGWMZxJEh9VX1KmdaaGUJKuTInjCdRLvRa6OK4TAVIa284kf8Ou6pkb42/VnF29CoNLDGrtOR59WU+07bRXm+aL+lxLkID5sL1HjkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284531; c=relaxed/simple;
	bh=TSdl282jT/XjE0hf1mC2uPpBJjgfnCccVcSjhjs2qsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qT4QQNK7zUA43ox23/hsJ39aqHg5UiKoKMXKx/9sAjjPTsaTngcRYfTuN8+BakErJs207B65Nb9ZwnfhpJ8TpBe5IkhYVXbGxCAK8kqSLtSBaQ2AL8zuaclaA7cUlOd8whqKVYpYUwzKMFFWTQI9RqS58o7ACG/Lo/L2A16YdzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rfyzD-0006ij-8O; Fri, 01 Mar 2024 10:15:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rfyzB-003khx-PB; Fri, 01 Mar 2024 10:15:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rfyzB-00ES8C-2B;
	Fri, 01 Mar 2024 10:15:21 +0100
Date: Fri, 1 Mar 2024 10:15:21 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Magnus Damm <magnus.damm@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v7 2/4] pwm: Add support for RZ/V2M PWM driver
Message-ID: <ugotgpnicccowxv4d6wxc57mgznj4vdodvjplfma5mqxojuiyg@p42i56lx2vqr>
References: <20240212210652.368680-1-fabrizio.castro.jz@renesas.com>
 <20240212210652.368680-3-fabrizio.castro.jz@renesas.com>
 <wwkzprliai3vge53fcveosfkixmri4hoyfjeulbzoezmaayoci@6hor5uwwdag4>
 <TYCPR01MB12093649FED62A25C3504E4D2C25F2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g4pc3vuo4korf24b"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB12093649FED62A25C3504E4D2C25F2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--g4pc3vuo4korf24b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Fabrizio,

your MUA introduces strange line breaks. You could do every reader of
you mails a favour and fix that. I fixed it up for my reply.

On Thu, Feb 29, 2024 at 10:45:01PM +0000, Fabrizio Castro wrote:
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Sent: Thursday, February 29, 2024 4:42 PM
> > To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > Subject: Re: [PATCH v7 2/4] pwm: Add support for RZ/V2M PWM driver
> >=20
> > On Mon, Feb 12, 2024 at 09:06:50PM +0000, Fabrizio Castro wrote:
> > > +static inline u64 rzv2m_pwm_mul_u64_u64_div_u64_roundup(u64 a, u64 b,
> > u64 c)
> > > +{
> > > +	u64 ab =3D a * b;
> >=20
> > a * b might overflow?!
>=20
> In the context of this driver, this cannot overflow.
> The 2 formulas the above is needed for are:
> 1) period =3D (cyc + 1)*(NSEC_PER_SEC * frequency_divisor)/rate
> 2) duty_cycle =3D (cyc + 1 - low)*(NSEC_PER_SEC * frequency_divisor)/rate
>=20
> With respect to 1), the dividend overflows when period * rate also
> overflows (its product is calculated in rzv2m_pwm_config).
> However, limiting the period to a maximum value of U64_MAX / rate
> prevents the calculations from overflowing (in both directions, from peri=
od to cyc, and from cyc to period). v6 introduced max_period for this.
> The situation for 2) is very similar to 1), with duty_cycle<=3Dperiod,
> therefore limiting period to a max value (and clamping the duty cycle
> accordingly) will ensure that the calculation for duty_cycle won't
> overflow, either.

OK, so it might be right from a technical POV. From a maintainer POV
this is still bad. Authors for other drivers might copy it, or the driver
might be changed and there is no indication that the the function relies
on only be called with certain parameters.

> > > +	u64 d =3D div64_u64(ab, c);
> > > +	u64 e =3D d * c;
> > > +
> > > +	return d + ((ab - e) ? 1 : 0);
> > > +}
> > > +
> > > +static inline u64 rzv2m_pwm_mul_u64_u64_div_u64_rounddown(u64 a, u64=
 b,
> > u64 c)
> > > +{
> > > +	return div64_u64(a * b, c);
> >=20
> > ditto. This is the same function as mul_u64_u64_div_u64() isn't it?
>=20
> Since a * b cannot overflow in the case of this driver, I believe the
> above to be a better option than mul_u64_u64_div_u64.

Same technical POV vs maintainer POV as above. Plus: Even if
mul_u64_u64_div_u64 is a tad slower, reusing it has some benefits
nevertheless.
=20
> > > [...]
> > > +	cyc =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMCYC);
> > > +	state->period =3D rzv2m_pwm_mul_u64_u64_div_u64_roundup(cyc + 1,
> > > +				NSEC_PER_SEC * frequency_divisor,
> > > +				rzv2m_pwm->rate);
> > > +
> > > +	low =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMLOW);
> > > +	state->duty_cycle =3D rzv2m_pwm_mul_u64_u64_div_u64_roundup(cyc + 1=
 - low,
> > > +				NSEC_PER_SEC * frequency_divisor,
> > > +				rzv2m_pwm->rate);
> >=20
> > The register semantic makes me wonder if each period starts with the low
> > part. In that case the hardware called "normal" what is called inverted
> > in the pwm framework?!
>=20
> My understanding is that the PWM framework defines "normal" polarity a
> signal that starts high (and stays high) for the duration of the duty cyc=
le,
> and goes low for the remainder of the period. Conversely, a signal with
> "inversed" polarity starts low (and stays low) for the duration of the du=
ty
> cycle and goes high for the remainder of the period.

Ack.

> This IP _does_ start low, but it _doesn't_ stay low for the duration of t=
he
> duty cycle, as it then goes high for the duration of the duty cycle,
> therefore this IP doesn't perfectly fit either ("normal" or "inverted")
> definitions.
> I think you can say that the "normal" signal is _shifted_ in phase for th=
is
> IP, rather than being "inverted".

Alternatively (and a better match): What you describe is an inverted
wave form with duty_cycle =3D period - duty_cycle.

> > > +	return pm_runtime_put(chip->dev);
> >=20
> > If you evaluate the return value of pm_runtime_put() maybe check
> > pm_runtime_get_sync() for symmetry, too?
>=20
> Or I could just discard it and return 0?
> I am fine with either, what's your preference?

My preference would be to always check the return value, but given that
many drivers don't care for that, I agree to accept never checking it.
So choose one option and do it consistently please.
=20
> > > +	if (pwm_cyc && !FIELD_FIT(RZV2M_PWMCYC_PERIOD, pwm_cyc - 1))
> > > +		pwm_cyc =3D RZV2M_PWMCYC_PERIOD + 1;
> >=20
> > I don't understand the relevance of FIELD_FIT(RZV2M_PWMCYC_PERIOD,
> > pwm_cyc - 1).
>=20
> CYC is only made of 24 bits, therefore this is to make sure we don't
> go beyond a 24-bit representation.

I would have understood:

	if (FIELD_FIT(RZV2M_PWMCYC_PERIOD, pwm_cyc + 1))
		pwm_cyc =3D RZV2M_PWMCYC_PERIOD + 1;

Notice there are three changes compared to your variant:
 - drop pwm_cyc !=3D 0 check
 - drop ! from FIELD_FIT
 - pwm_cyc + 1 instead of pwm_cyc - 1

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--g4pc3vuo4korf24b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXhnKgACgkQj4D7WH0S
/k58tAgArtsUR4cecwJJFnhEcL0IyaKukaU4zwUIQiYuzQfhII61clEX46SIJDLV
gGdrrifbwdxbnAIGmmQA3HVSCz9+huSkGOCOBjqqUhE8wg2e7bk9xPIIiNOjtKc/
ltNFC2zJEGp4T4ebfaDqbwaJJIq4rvcyg0/fIGMKD2tegKcpbtJu0fXsCbDlwh9T
MLKgX5T4PzUyo4b0URHIwFRikdQKeZfgAreEqDyeF0DSZSgIPhUE91chjil81Sdy
MwqtM64I2YIk9yPSgCSF9hzpUorowxVVif4xPzZtZuHik+2wO5sim2ZvgI7ZUsem
NMSO5eIHqbiWejza8VkVzmWsytk9Ww==
=8kxZ
-----END PGP SIGNATURE-----

--g4pc3vuo4korf24b--

