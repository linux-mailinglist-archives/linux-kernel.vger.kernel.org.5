Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECD479FC0C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbjINGdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjINGdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:33:06 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6571BB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:33:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qgfuH-0002S0-Ns; Thu, 14 Sep 2023 08:32:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qgfuD-006EyS-B7; Thu, 14 Sep 2023 08:32:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qgfuD-001WMf-1c; Thu, 14 Sep 2023 08:32:49 +0200
Date:   Thu, 14 Sep 2023 08:32:48 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Myunguk Kim <mwkim@gaonchips.com>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org, fido_max@inbox.ru,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
        xingyu.wu@starfivetech.com
Subject: Re: [PATCH] [v2] ASoC: dwc: fix typo in comment
Message-ID: <20230914063248.rquitqthmddgm5oa@pengutronix.de>
References: <64683b6c-1e31-4037-a47d-b8a19ea77c72@sirena.org.uk>
 <20230914005633.2423696-1-mwkim@gaonchips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tnq7qun57gracq7w"
Content-Disposition: inline
In-Reply-To: <20230914005633.2423696-1-mwkim@gaonchips.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tnq7qun57gracq7w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 09:56:34AM +0900, Myunguk Kim wrote:
> > The patch is obviously corrupted, the { there should be on the prior
> > line and even fixing that by hand there appear to be some other issues.
>=20
> The patch file should have been attached as shown below.=20
> Is there a problem with my git send-email?
>=20
> ---
>  sound/soc/dwc/dwc-i2s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
> index 22c004179214..c71c17ef961d 100644
> --- a/sound/soc/dwc/dwc-i2s.c
> +++ b/sound/soc/dwc/dwc-i2s.c
> @@ -138,7 +138,7 @@ static irqreturn_t i2s_irq_handler(int irq, void *dev=
_id)
>  			irq_valid =3D true;
>  		}
> =20
> -		/* Error Handling: TX */
> +		/* Error Handling: RX */
>  		if (isr[i] & ISR_RXFO)=20
> { 			dev_err_ratelimited(dev->dev, "RX overrun (ch_id=3D%d)\n", i);
>  			irq_valid =3D true;

FTR: I get this mail directly (so no mailing list server involved), and
the patch is mangled in the same way as broonie pointed out in his mail
earlier in this thread.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tnq7qun57gracq7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUCqRAACgkQj4D7WH0S
/k6/MAf+I/52SaIDC1qZLMYxlnyDxUjH539VR2QRgRXO7DXBqXvj68ubzhtEuFwM
SZZxtZucf7jjCjpu6IW64QpuZ8JoTZhlf6u5LBn008ADG0juzr4bNsMbP8R5M+ra
kqPd2n1kLRPf9G1BSiwnPDpL7Lfj0jjMZBHG88VRYsypYfbzK9zxPfeYi71wK52q
1IYtflj9ZlHbmSdcpNrKj7jXo4+FeBZzT8e8xcHgI0S2QBKK0WUdBgzzgLcCXKQD
J2uWgCChBfBrGn8FMMsB1OBtENbca0zcKPswZ0LKLDqwV2/OC8GIU+tpRxluCEw7
m9vSAczJxZVEAaJPNFOEbNyGGvT4MQ==
=PYSR
-----END PGP SIGNATURE-----

--tnq7qun57gracq7w--
