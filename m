Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA130812CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443626AbjLNK1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443599AbjLNK1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:27:15 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBB0AF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:27:20 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rDivZ-0005Kt-Gg; Thu, 14 Dec 2023 11:26:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rDivW-00FmF0-F7; Thu, 14 Dec 2023 11:26:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rDivW-002mZ5-5e; Thu, 14 Dec 2023 11:26:46 +0100
Date:   Thu, 14 Dec 2023 11:26:45 +0100
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
Message-ID: <20231214102645.xrbcbfc5hks6kltv@pengutronix.de>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
 <20231212-ep93xx-v6-36-c307b8ac9aa8@maquefel.me>
 <ZXn0-pHxIztvRFLK@smile.fi.intel.com>
 <20231213183349.hdjoxxszrrc4hqrg@pengutronix.de>
 <ZXn8lzb953iDiM_m@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dth4xo4ryvh6joel"
Content-Disposition: inline
In-Reply-To: <ZXn8lzb953iDiM_m@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dth4xo4ryvh6joel
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 08:48:55PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 13, 2023 at 07:33:49PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Wed, Dec 13, 2023 at 08:16:26PM +0200, Andy Shevchenko wrote:
> > > On Tue, Dec 12, 2023 at 11:20:53AM +0300, Nikita Shubin wrote:
> > > > Drop legacy acquire/release since we are using pinctrl for this now.
>=20
> ...
>=20
> > > I think you wanted
> > >=20
> > > 	ret =3D PTR_ERR_OR_ZERO(drv_data->dma_rx_channel);
> > > 	if (ret)
> > > 		return dev_err_probe(dev, ret, "rx DMA setup failed");
> >=20
> > How is that different from
> >=20
> > 	if (IS_ERR(drv_data->dma_rx_channel))
> > 		return dev_err_probe(dev, PTR_ERR(drv_data->dma_rx_channel), "....");
> >=20
> > (which seems to be more idiomatic to me)? While I was involved in
> > creating PTR_ERR_OR_ZERO, I don't particularily like it (today).
>=20
> Makes lines shorter, either works for me.

If you want shorter lines, I'd prefer

	if (IS_ERR(drv_data->dma_rx_channel)) {
		ret =3D PTR_ERR(drv_data->dma_rx_channel);
		return dev_err_probe(dev, ret, "...\n");
	}

over
	ret =3D PTR_ERR_OR_ZERO(drv_data->dma_rx_channel);
	if (ret)
		return dev_err_probe(dev, ret, "\n");

even though it's one line longer because the if body needs curly braces.
I think it's easier to parse for a human which IMHO matters more than
the additional line. But I'm aware that might be subjective.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dth4xo4ryvh6joel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV62GQACgkQj4D7WH0S
/k7gVAf9FW9phBqCXoQs5yyoEo+pqJl4IRkgv17YccuXumIWRP0PGwkQ1Whdo6Ol
J80HUjV/PR9XC+G0fZPVv2lLhNXYQNjyEnJW6MQrwyV0T8iXA5/ev/7Z284Oq3rS
L0easWHyqtbSFem6zmBs/d+d9nUUVz2oehMfED5QMH3Mp+J3WlJavD9sZSSNt2XI
iYu0hJgMXQ9+06wkH6AjYDPBK8qCd1Ztlqx6cAkJewrhm3uC8X6DQ2mRvPav95he
abLn7gOtL29q+EONYs3UmtJGJiJLA24w5Dp8/ieczR8CGcQrFlw37wFj0g1a4nsX
FShcuY89+oPsKy06QUJrMYfFj/+8+g==
=vn13
-----END PGP SIGNATURE-----

--dth4xo4ryvh6joel--
