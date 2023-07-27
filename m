Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213FE764761
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjG0G5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjG0G5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:57:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002BF26A0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:57:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOuvw-00045C-TD; Thu, 27 Jul 2023 08:57:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOuvt-002Pr9-Av; Thu, 27 Jul 2023 08:57:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOuvs-0088K0-Hi; Thu, 27 Jul 2023 08:57:08 +0200
Date:   Thu, 27 Jul 2023 08:57:08 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     tomi.valkeinen@ideasonboard.com, airlied@gmail.com,
        daniel@ffwll.ch, laurent.pinchart@ideasonboard.com,
        guozhengkui@vivo.com, dianders@chromium.org, yuancan@huawei.com,
        arnd@arndb.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm: omapdrm: dss: Remove redundant DSSERR()
Message-ID: <20230727065708.q7wrmzb7egzc4tmy@pengutronix.de>
References: <20230727113923.3093070-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g7ii4rrgxi7ozkxs"
Content-Disposition: inline
In-Reply-To: <20230727113923.3093070-1-ruanjinjie@huawei.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g7ii4rrgxi7ozkxs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jul 27, 2023 at 11:39:23AM +0000, Ruan Jinjie wrote:
> There is no need to call the DSSERR() function directly to print
> a custom message when handling an error from platform_get_irq() function
> as it is going to display an appropriate error message
> in case of a failure.
>=20
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/gpu/drm/omapdrm/dss/dispc.c | 1 -
>  drivers/gpu/drm/omapdrm/dss/dsi.c   | 4 +---
>  drivers/gpu/drm/omapdrm/dss/hdmi4.c | 1 -
>  drivers/gpu/drm/omapdrm/dss/hdmi5.c | 1 -
>  4 files changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdr=
m/dss/dispc.c
> index c26aab4939fa..9209103f5dc5 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dispc.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
> @@ -4779,7 +4779,6 @@ static int dispc_bind(struct device *dev, struct de=
vice *master, void *data)
> =20
>  	dispc->irq =3D platform_get_irq(dispc->pdev, 0);
>  	if (dispc->irq < 0) {
> -		DSSERR("platform_get_irq failed\n");
>  		r =3D -ENODEV;
>  		goto err_free;
>  	}

Orthogonal to your patch I wonder about r =3D -ENODEV. Wouldn't r =3D
dispc->irq be the sensible option? Ditto for the other hunks.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--g7ii4rrgxi7ozkxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTCFUMACgkQj4D7WH0S
/k6/sQgAlu8JiIDWijjQAWnIm7W6LnXF2PcEFXJ49r+mqhkQSbgt0gLOgGA0QjSv
LmjYUBWKukx/vslwKD8uJEnZrSoOuf9pqPfbdP+seF66ORFKPwu0nfc//c0YL1Xa
f6zYLS3V+qJbtFFXblWXNk6HUGwRyOs6bVBL57pw/VReRSYXb7TQ52oTeSemY5Yc
G/WYD0j0nXQ85kW4dT68dkoG8qFcmM54sR6hYEvREBRlTbXAn3xAzo1Fbavaox6N
OPMeErq/w1KHmZKp24o413B9D2ON9GnSfVORXyS3SMZYK3Q7bKchWXvhM/FAz3W9
yDFOrEq9Y5O7dynaUS4ns8pWRW3oSw==
=Bhpn
-----END PGP SIGNATURE-----

--g7ii4rrgxi7ozkxs--
