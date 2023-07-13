Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AEF751CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjGMJKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjGMJJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:09:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34065272A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:09:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJsJW-0005MX-W9; Thu, 13 Jul 2023 11:08:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJsJW-00E5Is-8v; Thu, 13 Jul 2023 11:08:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJsJV-004WH9-3v; Thu, 13 Jul 2023 11:08:41 +0200
Date:   Thu, 13 Jul 2023 11:08:40 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/58] mmc: sdhci_am654: Convert to platform remove
 callback returning void
Message-ID: <20230713090840.dc2ejoz6cieq4dyg@pengutronix.de>
References: <20230713080807.69999-1-frank.li@vivo.com>
 <20230713080807.69999-24-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hpncxr6mfxobixq5"
Content-Disposition: inline
In-Reply-To: <20230713080807.69999-24-frank.li@vivo.com>
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


--hpncxr6mfxobixq5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 04:07:33PM +0800, Yangtao Li wrote:
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
>  drivers/mmc/host/sdhci_am654.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am65=
4.c
> index 7cdf0f54e3a5..3cfaf7dca274 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -866,7 +866,7 @@ static int sdhci_am654_probe(struct platform_device *=
pdev)
>  	return ret;
>  }
> =20
> -static int sdhci_am654_remove(struct platform_device *pdev)
> +static void sdhci_am654_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host =3D platform_get_drvdata(pdev);
>  	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> @@ -874,14 +874,13 @@ static int sdhci_am654_remove(struct platform_devic=
e *pdev)
> =20
>  	ret =3D pm_runtime_resume_and_get(&pdev->dev);
>  	if (ret < 0)
> -		return ret;
> +		return;

This is changing semantics. You shouldn't ignore errors here. This is
one of the cases where a driver leaks resources. You need something like
22f407278ea43df46f90cece6595e5e8a0d5447c here.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hpncxr6mfxobixq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSvvxgACgkQj4D7WH0S
/k7zlQf/RvEu2cnSVXe7Hmj9SJ6zuFOhSBuFOikWudB536hrocckhd6f3Q5x8nBv
mZid4zWQ4+EPtyGwpRcMva1jw47HdS/SegY2DHazQxUKBPn18CigK220qnp56gz1
KXIsOgLqJa+zG6PDAWaL4JVAmmxIGE3SR0N0Oe1MJjp2RDXhLAVqHAMWAmwzlttd
xofRdoJBrzf0wxbkofT7DHYkwRTKlivRCi3d26Nm0AZgkTyDtDixMoVvuCzkmj08
EVIifzyeUixWthMwe+165BlJ2xrIhYLUp5U/60ZtZ2KDd+bfBCcu3udFTqAstIEI
m91KOQcrsbBBbEOpCf463yZvHFyjtA==
=RTtS
-----END PGP SIGNATURE-----

--hpncxr6mfxobixq5--
