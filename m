Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC78811C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjLMSeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjLMSeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:34:01 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8976CB2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:34:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rDU3L-0001yx-Og; Wed, 13 Dec 2023 19:33:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rDU3J-00FdAP-Jv; Wed, 13 Dec 2023 19:33:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rDU3J-002QXw-AB; Wed, 13 Dec 2023 19:33:49 +0100
Date:   Wed, 13 Dec 2023 19:33:49 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 36/40] ata: pata_ep93xx: remove legacy pinctrl use
Message-ID: <20231213183349.hdjoxxszrrc4hqrg@pengutronix.de>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
 <20231212-ep93xx-v6-36-c307b8ac9aa8@maquefel.me>
 <ZXn0-pHxIztvRFLK@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hwsnzd5s6bhsmoqq"
Content-Disposition: inline
In-Reply-To: <ZXn0-pHxIztvRFLK@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hwsnzd5s6bhsmoqq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 08:16:26PM +0200, Andy Shevchenko wrote:
> On Tue, Dec 12, 2023 at 11:20:53AM +0300, Nikita Shubin wrote:
> > Drop legacy acquire/release since we are using pinctrl for this now.
>=20
> ...
>=20
> > -	if (IS_ERR(drv_data->dma_rx_channel)) {
> > +	if (PTR_ERR_OR_ZERO(drv_data->dma_rx_channel)) {
>=20
> This seems incorrect.
>=20
> >  		ret =3D PTR_ERR(drv_data->dma_rx_channel);
> >  		return dev_err_probe(dev, ret, "rx DMA setup failed");
>=20
> 		return dev_err_probe(...);
>=20
> >  	}
>=20
> I think you wanted
>=20
> 	ret =3D PTR_ERR_OR_ZERO(drv_data->dma_rx_channel);
> 	if (ret)
> 		return dev_err_probe(dev, ret, "rx DMA setup failed");

How is that different from

	if (IS_ERR(drv_data->dma_rx_channel))
		return dev_err_probe(dev, PTR_ERR(drv_data->dma_rx_channel), "....");

(which seems to be more idiomatic to me)? While I was involved in
creating PTR_ERR_OR_ZERO, I don't particularily like it (today).

Also note that you want a \n at the end of error messages.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hwsnzd5s6bhsmoqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV5+QwACgkQj4D7WH0S
/k7P7wgAsKHiIZEGiHCPIsRxffuVGHyfChdfi9FNHXa6YOcrVkAqOlbOe3uq+ab2
Ox0facnFCB5/BnVywxpivfme8J3KYfKvzG2KLLTzsVkCmIPA3L6ulgoSihKp/eWZ
yWM+XYHag7xo2f4bGCOYPs68QOtZDDdOiQKo+ATvzAqhIhpjBd/5Ie3U3VNcrKT4
TIajgdpwXYNaPZDUKy8JwQ8uVVUqQebW02xgNV1VhreG6/ywbX5mvWlnQLp5D/6c
3aJXEJTwe9IcRo5W4mC8xQltsrrtiuRWW3Q/wPS1qsmqIS8Dmn3mmcBoKq7iGxmM
1RZZFHo+yr0rRsB3Re0Q/E4Do2LnCQ==
=BQyO
-----END PGP SIGNATURE-----

--hwsnzd5s6bhsmoqq--
