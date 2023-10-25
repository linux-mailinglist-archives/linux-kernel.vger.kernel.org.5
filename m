Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8907D70E6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344736AbjJYP0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbjJYP0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:26:23 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2869D1701
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:25:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qvfl1-0002cE-N1; Wed, 25 Oct 2023 17:25:19 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qvfl1-004Cwl-7N; Wed, 25 Oct 2023 17:25:19 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D065223E2F6;
        Wed, 25 Oct 2023 15:25:18 +0000 (UTC)
Date:   Wed, 25 Oct 2023 17:25:18 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: imx8mp: add imx8mp-venice-gw74xx-rpidsi
 overlay for display
Message-ID: <20231025-payback-parachute-72fb483c34ae-mkl@pengutronix.de>
References: <20230719152920.2173-1-tharvey@gateworks.com>
 <20231025-pessimist-irritate-927b64fbd2fa-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="repydmmjpx2avbav"
Content-Disposition: inline
In-Reply-To: <20231025-pessimist-irritate-927b64fbd2fa-mkl@pengutronix.de>
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


--repydmmjpx2avbav
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.10.2023 16:33:07, Marc Kleine-Budde wrote:
> Hey Tim,
>=20
> On 19.07.2023 08:29:20, Tim Harvey wrote:
> > Add support for the following Raspberry Pi displays:
> >  - DFROBOT DRF0678 7in 800x480 TFT DSI capacitive touch
> >  - DFROBOT DRF0550 5in 800x480 TFT DSI capacitive touch
> >=20
> > Both have the following hardware:
> >  - FocalTech FT5406 10pt touch controller (with no interrupt)
> >  - Powertip PH800480T013-IDF02 compatible panel
> >  - Toshiba TC358762 compatible DSI to DBI bridge
> >  - ATTINY based regulator used for backlight controller and panel enable
> >=20
> > Support is added via a device-tree overlay. The touch controller is not
> > yet supported as polling mode is needed.
>=20
> I'm just integrating the 7in Raspberry Pi display for a customer on an
> imx8mp. Do you have a (non-mainline) touch driver that works for the
> Raspberry Pi display? I might fight some time in this project to work on
> it.

Replying to myself:

Have a look at drivers/input/touchscreen/edt-ft5x06.c

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--repydmmjpx2avbav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmU5M1sACgkQvlAcSiqK
BOjtcggArOZLXvIeQkjmF1/pB3PNuU9xL2AXBV2C4hS23PVDc6RpE1YbqwFoWJE2
pa0zUDioWpxs5PeW4ITcu4l3OWPNzcm15Qw82cTAGyXZMPObrTTqhRbxO/FA+Xg3
7nS2EdwUeYhS9np95UfIDmZ9eH24/WR6WG99Rlb7kwzwPU2pwoxTM8jwVtRnATl0
i02sVxloIehZsL2ePoeNeRqGiMHhxOUxikcxxzZGdbhSKtWtdfhnyDO3jX/PAY5p
X8HA/tfD3tYx6YByC1NS+eLEkJ93fhXHrqB+ijj4FPwjDywSJoixIWFTVaYpGUW/
2uMwpjHYCp5lEJb9kIgt2fQSUKvALg==
=aLhj
-----END PGP SIGNATURE-----

--repydmmjpx2avbav--
