Return-Path: <linux-kernel+bounces-5613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E84E818D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56A01C24AC8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3174225B2;
	Tue, 19 Dec 2023 16:58:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C920B1B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdPy-0007od-5Z; Tue, 19 Dec 2023 17:58:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdPw-0003mc-EF; Tue, 19 Dec 2023 17:58:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdPx-000BOf-7p; Tue, 19 Dec 2023 17:58:05 +0100
Date: Tue, 19 Dec 2023 17:58:05 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sean Young <sean@mess.org>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 5/6] pwm: bcm2835: Allow PWM driver to be used in
 atomic context
Message-ID: <3tkfjp64hw42kzj4pex2ql6lyp7r6gm2u42nq6e3av736cinrq@ykylo7d2zs3i>
References: <cover.1703003288.git.sean@mess.org>
 <6c5852c902e6603571e4fde5955d1aeb537059ba.1703003288.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ykfv3uzkobwzwt6x"
Content-Disposition: inline
In-Reply-To: <6c5852c902e6603571e4fde5955d1aeb537059ba.1703003288.git.sean@mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--ykfv3uzkobwzwt6x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 04:30:28PM +0000, Sean Young wrote:
> clk_get_rate() may do a mutex lock. Fetch the clock rate once, and prevent
> rate changes using clk_rate_exclusive_get().
>=20
> Signed-off-by: Sean Young <sean@mess.org>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/pwm/pwm-bcm2835.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
> index ab30667f4f95..d9ac50a5b04e 100644
> --- a/drivers/pwm/pwm-bcm2835.c
> +++ b/drivers/pwm/pwm-bcm2835.c
> @@ -28,6 +28,7 @@ struct bcm2835_pwm {
>  	struct device *dev;
>  	void __iomem *base;
>  	struct clk *clk;
> +	unsigned long rate;
>  };
> =20
>  static inline struct bcm2835_pwm *to_bcm2835_pwm(struct pwm_chip *chip)
> @@ -63,17 +64,11 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  {
> =20
>  	struct bcm2835_pwm *pc =3D to_bcm2835_pwm(chip);
> -	unsigned long rate =3D clk_get_rate(pc->clk);
>  	unsigned long long period_cycles;
>  	u64 max_period;
> =20
>  	u32 val;
> =20
> -	if (!rate) {
> -		dev_err(pc->dev, "failed to get clock rate\n");
> -		return -EINVAL;
> -	}
> -
>  	/*
>  	 * period_cycles must be a 32 bit value, so period * rate / NSEC_PER_SEC
>  	 * must be <=3D U32_MAX. As U32_MAX * NSEC_PER_SEC < U64_MAX the
> @@ -88,13 +83,13 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  	 * <=3D> period < ((U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC/2) / rate
>  	 * <=3D> period <=3D ceil((U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC/2) / r=
ate) - 1
>  	 */
> -	max_period =3D DIV_ROUND_UP_ULL((u64)U32_MAX * NSEC_PER_SEC + NSEC_PER_=
SEC / 2, rate) - 1;
> +	max_period =3D DIV_ROUND_UP_ULL((u64)U32_MAX * NSEC_PER_SEC + NSEC_PER_=
SEC / 2, pc->rate) - 1;
> =20
>  	if (state->period > max_period)
>  		return -EINVAL;
> =20
>  	/* set period */
> -	period_cycles =3D DIV_ROUND_CLOSEST_ULL(state->period * rate, NSEC_PER_=
SEC);
> +	period_cycles =3D DIV_ROUND_CLOSEST_ULL(state->period * pc->rate, NSEC_=
PER_SEC);
> =20
>  	/* don't accept a period that is too small */
>  	if (period_cycles < PERIOD_MIN)
> @@ -103,7 +98,7 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	writel(period_cycles, pc->base + PERIOD(pwm->hwpwm));
> =20
>  	/* set duty cycle */
> -	val =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle * rate, NSEC_PER_SEC);
> +	val =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle * pc->rate, NSEC_PER_SE=
C);
>  	writel(val, pc->base + DUTY(pwm->hwpwm));
> =20
>  	/* set polarity */
> @@ -131,6 +126,13 @@ static const struct pwm_ops bcm2835_pwm_ops =3D {
>  	.apply =3D bcm2835_pwm_apply,
>  };
> =20
> +static void devm_clk_rate_exclusive_put(void *data)
> +{
> +	struct clk *clk =3D data;
> +
> +	clk_rate_exclusive_put(clk);
> +}
> +
>  static int bcm2835_pwm_probe(struct platform_device *pdev)
>  {
>  	struct bcm2835_pwm *pc;
> @@ -151,8 +153,22 @@ static int bcm2835_pwm_probe(struct platform_device =
*pdev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
>  				     "clock not found\n");
> =20
> +	ret =3D clk_rate_exclusive_get(pc->clk);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "fail to get exclusive rate\n");
> +
> +	devm_add_action_or_reset(&pdev->dev, devm_clk_rate_exclusive_put,
> +				 pc->clk);

Missing error checking.

Otherwise looks good now.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ykfv3uzkobwzwt6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWBy5wACgkQj4D7WH0S
/k6gJQgAgo9tsiy0//qsFfI4pYOet8s3QDSprouQpHeAfs3PK2lwF890jwSSnqMf
Zf4vjZqjRqFqI9fG7I46hZ5bXZs0fEDCRqwjgSpQlvdTnLuAnbDHI3lS5zdHeqr+
TkH5oA/8ad1mJLqFOnoUjatDhvrlvvSV54mGmFa9DuqxNrmWWLAVJWHfKZsWIgjz
8sXf2bbY4iF7Wr8qveVUqrKgrb26ewpJljgDBF4jPpQ12vN0I/7yxzrUbsko1yIZ
D/b8LLJOmCnL+96YEQ04ECl5nuU3yaWFdn+rxkYG/Do0/Kx4Qhm2DHlxKIXy3RNR
J2sTmUvbW67H7EkD+3s65bVEf9JP3A==
=G8Df
-----END PGP SIGNATURE-----

--ykfv3uzkobwzwt6x--

