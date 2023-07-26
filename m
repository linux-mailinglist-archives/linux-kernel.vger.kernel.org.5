Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D527762BF5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjGZGyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGZGyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:54:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5193C1FEC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:54:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOYPJ-0003UX-LV; Wed, 26 Jul 2023 08:54:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOYPI-002AvY-M8; Wed, 26 Jul 2023 08:54:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOYPI-007rbX-2s; Wed, 26 Jul 2023 08:54:00 +0200
Date:   Wed, 26 Jul 2023 08:53:57 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 25/61] mmc: f-sdh30: Convert to platform remove
 callback returning void
Message-ID: <20230726065357.afriboprvkup5kiw@pengutronix.de>
References: <20230726040041.26267-1-frank.li@vivo.com>
 <20230726040041.26267-25-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lybcthqmrubegsjn"
Content-Disposition: inline
In-Reply-To: <20230726040041.26267-25-frank.li@vivo.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lybcthqmrubegsjn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 12:00:05PM +0800, Yangtao Li wrote:
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
> Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/mmc/host/sdhci_f_sdh30.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_=
sdh30.c
> index b01ffb4d0973..840084ee72e6 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -206,7 +206,7 @@ static int sdhci_f_sdh30_probe(struct platform_device=
 *pdev)
>  	return ret;
>  }
> =20
> -static int sdhci_f_sdh30_remove(struct platform_device *pdev)
> +static void sdhci_f_sdh30_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host =3D platform_get_drvdata(pdev);
>  	struct f_sdhost_priv *priv =3D sdhci_f_sdhost_priv(host);
> @@ -216,8 +216,6 @@ static int sdhci_f_sdh30_remove(struct platform_devic=
e *pdev)
>  	clk_disable_unprepare(priv->clk_iface);
> =20
>  	sdhci_pltfm_unregister(pdev);
> -
> -	return 0;
>  }

While looking in more detail into this series I noticed a problem in
this driver. (The patch is fine, and so is my Ack.)

The order of function calls in sdhci_f_sdh30_remove is wrong. It first
reasserts the reset and disables clocks and only then unregisters the
sdhci-host which should stay functional until sdhci_remove_host() (called
by sdhci_pltfm_unregister()) completes.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lybcthqmrubegsjn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTAwwQACgkQj4D7WH0S
/k5/9Qf/ZCJznZ4ncxfHfX/h7tqjAeMzmN3IOzOka0ZL0Lgkvt2LSEufX5AEQ4d5
yYJRYQUjkco7xvctkyGr2UavRU73z5RlLBVtfN2GU2QjSamh1/0E0F5goOAc7sdK
Ge/34MlYEQwfdjJVmg/3VAA8bRQ2YfrcTOzZv5fcnTKHoROJzKOtWczNpFh4izy7
88YEhX//WtIBU8iqlBngvQR+i5dOfPWCh2pLAdOJPFDWPA5ZlxXz6yGEY+b/Cfmv
CyQe9dmzK9rtn701YYwA44AXWm/Hw9cYsAaiGQtBr2+4FVymfIavuOHlblSo6waX
e+g/Mb9X5rMVyC6eaRp5lmWy8m820w==
=DoOc
-----END PGP SIGNATURE-----

--lybcthqmrubegsjn--
