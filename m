Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DB680DC0C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344838AbjLKUtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344816AbjLKUtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:49:49 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E271FB5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 12:49:55 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rCnDs-0001wT-1G; Mon, 11 Dec 2023 21:49:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rCnDr-00FBHA-DA; Mon, 11 Dec 2023 21:49:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rCnDr-0018OB-3U; Mon, 11 Dec 2023 21:49:51 +0100
Date:   Mon, 11 Dec 2023 21:49:50 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nylon Chen <nylon.chen@sifive.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, thierry.reding@gmail.com,
        emil.renner.berthing@canonical.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, zong.li@sifive.com, nylon7717@gmail.com
Subject: Re: [v5 2/2] pwm: sifive: change the PWM controlled LED algorithm
Message-ID: <20231211204950.fkaqsnpzb6kixqf2@pengutronix.de>
References: <20231024101902.6689-1-nylon.chen@sifive.com>
 <20231024101902.6689-3-nylon.chen@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u262zj72p5ucybub"
Content-Disposition: inline
In-Reply-To: <20231024101902.6689-3-nylon.chen@sifive.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u262zj72p5ucybub
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nylon,

On Tue, Oct 24, 2023 at 06:19:02PM +0800, Nylon Chen wrote:
> The `frac` variable represents the pulse inactive time, and the result
> of this algorithm is the pulse active time. Therefore, we must reverse th=
e result.
>=20
> The reference is SiFive FU740-C000 Manual[0]
>=20
> Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b=
16acba_fu740-c000-manual-v1p6.pdf [0]
>=20
> Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> ---
>  drivers/pwm/pwm-sifive.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> index eabddb7c7820..353c2342fbf1 100644
> --- a/drivers/pwm/pwm-sifive.c
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -101,7 +101,7 @@ static void pwm_sifive_update_clock(struct pwm_sifive=
_ddata *ddata,
> =20
>  	/* As scale <=3D 15 the shift operation cannot overflow. */
>  	num =3D (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWIDTH + scal=
e);
> -	ddata->real_period =3D div64_ul(num, rate);
> +	ddata->real_period =3D DIV_ROUND_UP_ULL(num, rate);

It's unclear to me, why you changed that.

>  	dev_dbg(ddata->chip.dev,
>  		"New real_period =3D %u ns\n", ddata->real_period);
>  }
> @@ -121,13 +121,14 @@ static int pwm_sifive_get_state(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
>  		state->enabled =3D false;
> =20
>  	state->period =3D ddata->real_period;
> +
> +	duty =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - duty;

I would have placed that directly after

	duty =3D readl(...);

which then also influences

	state->enabled =3D duty > 0;

(as it should?).

>  	state->duty_cycle =3D
>  		(u64)duty * ddata->real_period >> PWM_SIFIVE_CMPWIDTH;
> -	state->polarity =3D PWM_POLARITY_INVERSED;
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> =20
>  	return 0;
>  }
> -
>  static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
>  			    const struct pwm_state *state)
>  {
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
> @@ -158,6 +159,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	num =3D (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
>  	frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
>  	/* The hardware cannot generate a 100% duty cycle */
> +	frac =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
>  	frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);

frac can only be > (1U << PWM_SIFIVE_CMPWIDTH) - 1 if an overflow
happend the line above. Is that what you want here?

>  	mutex_lock(&ddata->lock);

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--u262zj72p5ucybub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV3de4ACgkQj4D7WH0S
/k5Qzwf+LxNerZNq1fsWhPxwliLRort8Hzk5VF2VeREIjSWu6hPHY5Uu2Jx/wumV
bnRMjYJaLsgFWf6NS4NPrAUTKmsika76v2c6AcQdWtRpc/1xlEwsVrX4nZMruAzv
mBmCPb5zqeDf4X4LhIR7Y1oAFejSg/uyVY1WDABJzbqt8Z/E4JHXIsxB4C6eqfl3
bC+q7XOlWu6C6YO3/fsZ/A7W9o+S1/mFMkyggloi5YJyjhn75SqG6IYvE9wsOOQX
LnRHy2LITZlrzGRIukkQvPIfPWgCaSESmsXIJR0mi0KyCMPd/p2ttcDM6o2y27JM
4sCF7nZA15bQcx6WfqQyQwexbDoy+A==
=WoBu
-----END PGP SIGNATURE-----

--u262zj72p5ucybub--
