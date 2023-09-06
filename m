Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28D479409D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239014AbjIFPoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjIFPoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:44:19 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50341BC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 08:44:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qduhM-0000sf-Ru; Wed, 06 Sep 2023 17:44:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qduhM-004SQS-Cz; Wed, 06 Sep 2023 17:44:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qduhK-00GuOy-Lp; Wed, 06 Sep 2023 17:44:06 +0200
Date:   Wed, 6 Sep 2023 17:44:06 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Leif Middelschulte <leif.middelschulte@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] pwm: imx27: return error, if clean PWM setup fails
Message-ID: <20230906154406.efxdo4gpgl57n6l3@pengutronix.de>
References: <20230310174517.rb7xxrougkse2lrc@pengutronix.de>
 <20230815104332.55044-1-Leif.Middelschulte@gmail.com>
 <20230815104332.55044-4-Leif.Middelschulte@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ul2hn5jfy4crdfgy"
Content-Disposition: inline
In-Reply-To: <20230815104332.55044-4-Leif.Middelschulte@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ul2hn5jfy4crdfgy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 12:43:32PM +0200, Leif Middelschulte wrote:
> Instead of issuing a warning, return an error (as adviced[0]), if the
> FIFO cannot be cleanly set up.
>=20
> [0] https://lore.kernel.org/lkml/20230310174517.rb7xxrougkse2lrc@pengutro=
nix.de/T/#ec9560c1f613d9c0d7b77d72ad9051768812f80db
>=20
> Signed-off-by: Leif Middelschulte <Leif.Middelschulte@gmail.com>
> ---
>  drivers/pwm/pwm-imx27.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 9673e809d212..5fd6d34a7722 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -133,14 +133,15 @@ static int pwm_imx27_wait_fifo_empty(struct pwm_chi=
p *chip,
>  		sr =3D readl(imx->mmio_base + MX3_PWMSR);
>  		fifoav =3D FIELD_GET(MX3_PWMSR_FIFOAV, sr);
>  		if (fifoav =3D=3D MX3_PWMSR_FIFOAV_EMPTY)
> -			return;
> +			return 0;
>  		/* if the FIFO value does not decrease, there is another problem */
>  		if (previous_fifoav =3D=3D fifoav)
>  			break;
>  		previous_fifoav =3D fifoav;
>  		msleep(period_ms);
>  	}
> -	dev_warn(dev, "FIFO has been refilled concurrently\n");
> +
> +	return -EAGAIN;
>  }
> =20
>  static int pwm_imx27_get_state(struct pwm_chip *chip,
> @@ -208,7 +209,9 @@ static int pwm_imx27_get_state(struct pwm_chip *chip,
>  		 * been supplied and a period expired between the call of the wait
>  		 * function and the subsequent readl.
>  		 */
> -		pwm_imx27_wait_fifo_empty(chip, pwm);
> +		ret =3D pwm_imx27_wait_fifo_empty(chip, pwm);
> +		if (ret)
> +			return ret;
>  		val =3D readl(imx->mmio_base + MX3_PWMSAR);
>  	} else {
>  		val =3D imx->duty_cycle;

I'd squash this into the patch introducing pwm_imx27_wait_fifo_empty,
too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ul2hn5jfy4crdfgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmT4nkUACgkQj4D7WH0S
/k6XFQgAiVf4pkJzMu7XfVuxDzh6MuolGXMt3ilyzSVCfT1nVmQf6NX9cieoUOQ5
XemQB2eAMC3vf660xSZgXUzl/yXHte4RRScZE+3NqCl8PcGvK8A5Lnqw9dz0DDPV
dicT/37HSdF1XQ8d3is98mBSTZqnHJVyZ63Z3fvPXp0AeDHRxyDJreo9PCwsfrZg
qSxN+ImAtpYlhxlY26edEdpUI5ZI313Bmf1F7L/UCBqdyqXeX9+JVGK0Vcez4B74
te7fPIjLZ3MQY5Bjq7YA/g44JCK5aSDs9BkwoyDaCkxqnD/HfUK4LpoBwOe9p5GN
Wsy1JHr6z1MTOFgm5y6ietBrxXxwQw==
=Ke3K
-----END PGP SIGNATURE-----

--ul2hn5jfy4crdfgy--
