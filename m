Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C42751CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjGMJHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbjGMJGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:06:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F65F268A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:06:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJsHR-00052L-Bg; Thu, 13 Jul 2023 11:06:33 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJsHQ-00E5Ic-DS; Thu, 13 Jul 2023 11:06:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJsHP-004WGy-Pm; Thu, 13 Jul 2023 11:06:31 +0200
Date:   Thu, 13 Jul 2023 11:06:31 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/58] mmc: rtsx_pci: Convert to platform remove callback
 returning void
Message-ID: <20230713090631.qq2ffit3wt3rpt7k@pengutronix.de>
References: <20230713080807.69999-1-frank.li@vivo.com>
 <20230713080807.69999-16-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="szvbp7ls2vj2sehh"
Content-Disposition: inline
In-Reply-To: <20230713080807.69999-16-frank.li@vivo.com>
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


--szvbp7ls2vj2sehh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 04:07:25PM +0800, Yangtao Li wrote:
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
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pc=
i_sdmmc.c
> index 8098726dcc0b..5465a7225df4 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -1523,14 +1523,14 @@ static int rtsx_pci_sdmmc_drv_probe(struct platfo=
rm_device *pdev)
>  	return 0;
>  }
> =20
> -static int rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
> +static void rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
>  {
>  	struct realtek_pci_sdmmc *host =3D platform_get_drvdata(pdev);
>  	struct rtsx_pcr *pcr;
>  	struct mmc_host *mmc;
> =20
>  	if (!host)
> -		return 0;
> +		return;

If host is NULL, there is a problem. While sometimes (rarely) driver
maintainers object, I usually remove these, see for example
3d82dca0f27ac5a0bfbbce439bba5c6452f3b7da.
=20
>  	pcr =3D host->pcr;
>  	pcr->slots[RTSX_SD_CARD].p_dev =3D NULL;

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--szvbp7ls2vj2sehh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSvvpYACgkQj4D7WH0S
/k7JNgf/RG5cqOCaaxShFaOqw3hQBTAAgvsgmEenLL5pkOyjowFizwD1JgI7SiZ6
vg296AEls6JKu2e+yXMGZ8lVryBLDz2JHF/LS7Swu5RHMMsttRDFbOEoHWN0IMUV
bPgassf0Blg9x2pWNySdZMTd+aQAkheiqx3LFeu78onlnWgV7uXz5sstcvj9ibid
piGsp96kpsleMyMKdfpqgl+MLDSDGnWTkXymR/Ztqmt1yGGqqTsRTKbd1uapu0Sh
DMVe82qce+L7Dkf8qPoOcR/bbEVULBK6bRO6uq0dHlJ8OL0pUJvokiSAyXJL2fVZ
1IrwZXFrWiu0UmSyUeo3OWahrZM05g==
=fYRF
-----END PGP SIGNATURE-----

--szvbp7ls2vj2sehh--
