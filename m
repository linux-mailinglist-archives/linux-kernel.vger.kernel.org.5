Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D877D72D0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjJYSDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjJYSDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:03:36 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B711A137
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:03:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qviE7-0005w4-J4; Wed, 25 Oct 2023 20:03:31 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qviE7-004EbE-5O; Wed, 25 Oct 2023 20:03:31 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CFC5B23E3CD;
        Wed, 25 Oct 2023 18:03:30 +0000 (UTC)
Date:   Wed, 25 Oct 2023 20:03:30 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: imx8mp: add imx8mp-venice-gw74xx-rpidsi
 overlay for display
Message-ID: <20231025-unfunded-skeptic-20f560692af7-mkl@pengutronix.de>
References: <20230719152920.2173-1-tharvey@gateworks.com>
 <20231025-pessimist-irritate-927b64fbd2fa-mkl@pengutronix.de>
 <20231025-payback-parachute-72fb483c34ae-mkl@pengutronix.de>
 <CAJ+vNU2c=5HopuJ60JFx4CA9dyOGminFAPDeZg494GE9dHTe5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ontvm7r4wcnvuxpp"
Content-Disposition: inline
In-Reply-To: <CAJ+vNU2c=5HopuJ60JFx4CA9dyOGminFAPDeZg494GE9dHTe5g@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ontvm7r4wcnvuxpp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.10.2023 09:06:21, Tim Harvey wrote:
> On Wed, Oct 25, 2023 at 8:25=E2=80=AFAM Marc Kleine-Budde <mkl@pengutroni=
x.de> wrote:
> >
> > On 25.10.2023 16:33:07, Marc Kleine-Budde wrote:
> > > Hey Tim,
> > >
> > > On 19.07.2023 08:29:20, Tim Harvey wrote:
> > > > Add support for the following Raspberry Pi displays:
> > > >  - DFROBOT DRF0678 7in 800x480 TFT DSI capacitive touch
> > > >  - DFROBOT DRF0550 5in 800x480 TFT DSI capacitive touch
> > > >
> > > > Both have the following hardware:
> > > >  - FocalTech FT5406 10pt touch controller (with no interrupt)
> > > >  - Powertip PH800480T013-IDF02 compatible panel
> > > >  - Toshiba TC358762 compatible DSI to DBI bridge
> > > >  - ATTINY based regulator used for backlight controller and panel e=
nable
> > > >
> > > > Support is added via a device-tree overlay. The touch controller is=
 not
> > > > yet supported as polling mode is needed.
> > >
> > > I'm just integrating the 7in Raspberry Pi display for a customer on an
> > > imx8mp. Do you have a (non-mainline) touch driver that works for the
> > > Raspberry Pi display? I might fight some time in this project to work=
 on
> > > it.
> >
> > Replying to myself:
> >
> > Have a look at drivers/input/touchscreen/edt-ft5x06.c
>=20
> The specific display I have is the one from DFROBOT which emulates the
> original Rpi display as far as I know.
>=20
> I came up with two different approaches, neither of which I got any
> comments from. I haven't spent any additional time on it and have just
> been carrying around a custom patch to support it.
>=20
> You can find my patches here:
> https://patchwork.kernel.org/project/linux-input/list/?series=3D596977&st=
ate=3D%2A&archive=3Dboth
> - add support for DFROBOT touch controller
> https://www.spinics.net/lists/linux-input/msg76457.html - proposal of
> adding a new driver

Thanks for the links to the patches.

> There's possibly a newer version of the patch that adds a new driver
> on a 6.1 kernel here:
> https://github.com/Gateworks/linux-venice/commit/5bf0ffcf0352b45c29d33184=
e933a35dd53f27bb
>=20
> Is this the same touch controller you are working with?

I'm working with the original 7" RPi display. Currently it's for
development use for the customer. Not sure which display they will use
in the final product.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ontvm7r4wcnvuxpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmU5WG8ACgkQvlAcSiqK
BOgMxggAtXo/Yt26fLjPg58hS39cG0gCSvGjBgUe+wAzo2fMrf7SwcUNyKlXOCTi
MQQWW0lMa7y4+V2zSRaf3SuJeyloDr7CrrvV7AXL943r2xt5DuPGqEGITjEk7qBc
ILOgCwfQS6fLBl9LbzK7SzHUegpnst4Sz8f/l5rmY+NSFHwvKZT22pxNqLQwGI8y
Y8Yc+Z7Qyu8QHSXtxdXcGdbCZKc/kwrbymT4nEt/14MvRifZ/OZqJ7l/mJEqSFOj
eKo56TNp6MUm+JbR0Jedpj/GEClTV0pwTBGSrOEvuDGBWV19He8eD+MU3Ie/hshx
JATpOP7iNfCxcGcclgIQgrprZYaBlw==
=HhTZ
-----END PGP SIGNATURE-----

--ontvm7r4wcnvuxpp--
