Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513F17BF3F3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442416AbjJJHTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442394AbjJJHTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:19:21 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D18AC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 00:19:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq71J-00046H-8A; Tue, 10 Oct 2023 09:19:09 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq71I-000bZx-HG; Tue, 10 Oct 2023 09:19:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq71I-00CuRr-7u; Tue, 10 Oct 2023 09:19:08 +0200
Date:   Tue, 10 Oct 2023 09:19:08 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     linux-pwm@vger.kernel.org, Angus Clark <angus.clark@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] pwm: bcm2835: Add support for suspend/resume
Message-ID: <20231010071908.azpqdx3eff442fxh@pengutronix.de>
References: <20231009204226.3224521-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="isqqdgvdw4a6nj5a"
Content-Disposition: inline
In-Reply-To: <20231009204226.3224521-1-florian.fainelli@broadcom.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--isqqdgvdw4a6nj5a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2023 at 01:42:26PM -0700, Florian Fainelli wrote:
> Similar to other drivers, we need to make sure that the clock is
> disabled during suspend and re-enabled during resume.
>=20
> Reported-by: Angus Clark <angus.clark@broadcom.com>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
> Changes in v2:
>=20
> - use DEFINE_SIMPLE_DEV_PM_OPS as suggested by Uwe
>=20
>  drivers/pwm/pwm-bcm2835.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
> index bdfc2a5ec0d6..938f993ae746 100644
> --- a/drivers/pwm/pwm-bcm2835.c
> +++ b/drivers/pwm/pwm-bcm2835.c
> @@ -182,6 +182,25 @@ static void bcm2835_pwm_remove(struct platform_devic=
e *pdev)
>  	clk_disable_unprepare(pc->clk);
>  }
> =20
> +static int __maybe_unused bcm2835_pwm_suspend(struct device *dev)
> +{
> +	struct bcm2835_pwm *pc =3D dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(pc->clk);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused bcm2835_pwm_resume(struct device *dev)

With DEFINE_SIMPLE_DEV_PM_OPS you don't need the __maybe_unused (which
is one of the upsides of DEFINE_SIMPLE_DEV_PM_OPS compared to
SIMPLE_DEV_PM_OPS)

> +{
> +	struct bcm2835_pwm *pc =3D dev_get_drvdata(dev);
> +
> +	return clk_prepare_enable(pc->clk);
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(bcm2835_pwm_pm_ops, bcm2835_pwm_suspend,
> +				bcm2835_pwm_resume);
> +
>  static const struct of_device_id bcm2835_pwm_of_match[] =3D {
>  	{ .compatible =3D "brcm,bcm2835-pwm", },
>  	{ /* sentinel */ }
> @@ -192,6 +211,7 @@ static struct platform_driver bcm2835_pwm_driver =3D {
>  	.driver =3D {
>  		.name =3D "bcm2835-pwm",
>  		.of_match_table =3D bcm2835_pwm_of_match,
> +		.pm =3D &bcm2835_pwm_pm_ops,

I think=20

+		.pm =3D pm_ptr(&bcm2835_pwm_pm_ops),

is the right thing here.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--isqqdgvdw4a6nj5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUk+usACgkQj4D7WH0S
/k5ECwf+NPkcT3mWWY2ZBSoYzazNLuQvKMVs9Lt7KSbMFBoHA7ipNqgsZABLPrXU
4hHgmDZAlpEvzTv/i5g3o2Q1GpGUA+AT42Dm7ds2oAh6g9OwyPcUhju9FztPQ2kJ
R9sYJwNCdAdFw0w9QSG59Q42PR7Ad6v3wBFfokn96MweTm9GewxVdjsXxWCFa8B9
gAfv3dEv5fFHjp+wvri89clKGBKn4CCXjtyHGgfkgnV2GnZOXeCFwjagauC+VKSW
H3FFc5GrhjE0p3Kl0iGoGuNv0ucPAGJdkffObP9MmkNJSfUfySJZt/rNGH54yOZT
4dkeEJf29RscME49f0Lx2BgFiEND+g==
=2uy8
-----END PGP SIGNATURE-----

--isqqdgvdw4a6nj5a--
