Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E55751CEC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjGMJNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbjGMJNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:13:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF4C213B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:12:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJsNb-00061v-9n; Thu, 13 Jul 2023 11:12:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJsNa-00E5JW-Ii; Thu, 13 Jul 2023 11:12:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJsNZ-004WHr-OI; Thu, 13 Jul 2023 11:12:53 +0200
Date:   Thu, 13 Jul 2023 11:12:53 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 26/58] mmc: f-sdh30: Convert to platform remove callback
 returning void
Message-ID: <20230713091253.ugyduhpsda3dr6ov@pengutronix.de>
References: <20230713080807.69999-1-frank.li@vivo.com>
 <20230713080807.69999-26-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mqoekenw6tymbw4e"
Content-Disposition: inline
In-Reply-To: <20230713080807.69999-26-frank.li@vivo.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mqoekenw6tymbw4e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 04:07:35PM +0800, Yangtao Li wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/mmc/host/sdhci_f_sdh30.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_=
sdh30.c
> index a202a69a4b08..6016e183c03c 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -208,7 +208,7 @@ static int sdhci_f_sdh30_probe(struct platform_device=
 *pdev)
>  	return ret;
>  }
> =20
> -static int sdhci_f_sdh30_remove(struct platform_device *pdev)
> +static void sdhci_f_sdh30_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host =3D platform_get_drvdata(pdev);
>  	struct f_sdhost_priv *priv =3D sdhci_priv(host);
> @@ -222,8 +222,6 @@ static int sdhci_f_sdh30_remove(struct platform_devic=
e *pdev)
> =20
>  	sdhci_free_host(host);
>  	platform_set_drvdata(pdev, NULL);
> -
> -	return 0;
>  }
> =20
>  #ifdef CONFIG_OF
> @@ -252,7 +250,7 @@ static struct platform_driver sdhci_f_sdh30_driver =
=3D {
>  		.pm	=3D &sdhci_pltfm_pmops,
>  	},
>  	.probe	=3D sdhci_f_sdh30_probe,
> -	.remove	=3D sdhci_f_sdh30_remove,
> +	.remove_new =3D sdhci_f_sdh30_remove,

Given that the alignment of =3Ds in sdhci_f_sdh30_driver is very
inconsistent, you might want to consider to do s/\t/ / in it for the two
remaining offenders while touching this anyhow.

With or without that adapted:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mqoekenw6tymbw4e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSvwBQACgkQj4D7WH0S
/k5csggApph1hCOPSYnnSu939bLupMfFJ5lWGu+NIHl7CVLS+jcOFo3DIDvP15nX
9W3KmfSMQcKaPJw/sZIMI+3LAn7NYoSkhV/CNxAscipoW5q6Q96A7RerplzgFdkF
fFM5jFxZMhPyYiDiUBnZgctoF6gsTsHWUYR/71ChRO0l2lwyagyTbUXaq/g8Kke5
4PA3q0iXepJX3yBHe1XnO/q6109jhbjMRZiZOWJV6rBRg976TNbXIt9BjcPBX14w
W6JqMShddWXBS99UqydjZBgdMKUcxf8MZQZATwZegd+D4HpO2RHk9T/dI6vIWyWL
LJB8wfpEicdVJwfa3UQiJN88TTD8Gg==
=TgoG
-----END PGP SIGNATURE-----

--mqoekenw6tymbw4e--
