Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80B17CA05D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjJPHRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjJPHRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:17:11 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9245EA
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:17:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qsHqa-0001mi-Uk; Mon, 16 Oct 2023 09:17:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qsHqZ-0021sI-QO; Mon, 16 Oct 2023 09:17:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qsHqZ-00GxzK-H4; Mon, 16 Oct 2023 09:17:03 +0200
Date:   Mon, 16 Oct 2023 09:16:59 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Greg KH <greg@kroah.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wentong Wu <wentong.wu@intel.com>
Subject: Re: linux-next: manual merge of the gpio-brgl tree with the usb tree
Message-ID: <20231016071659.qbc4s7syiv3zgqsk@pengutronix.de>
References: <20231016134159.11d8f849@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ry7z4n62q7an2p3j"
Content-Disposition: inline
In-Reply-To: <20231016134159.11d8f849@canb.auug.org.au>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ry7z4n62q7an2p3j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Oct 16, 2023 at 01:41:59PM +1100, Stephen Rothwell wrote:
> Today's linux-next merge of the gpio-brgl tree got a conflict in:
>=20
>   drivers/gpio/gpio-ljca.c
>=20
> between commit:
>=20
>   1034cc423f1b ("gpio: update Intel LJCA USB GPIO driver")
>=20
> from the usb tree and commit:
>=20
>   da2ad5fe2292 ("gpio: ljca: Convert to platform remove callback returnin=
g void")
>=20
> from the gpio-brgl tree.
>=20
> I fixed it up (I just used the former version) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Looks right. As this isn't a platform_driver any more, dropping the
conversion to .remove_new is the right thing.

Thanks
Uwe



--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ry7z4n62q7an2p3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUs42oACgkQj4D7WH0S
/k4kggf+LjzZK6fUvEOgjgm0dlQMjXhBBbPdn1ELYpf+PrBVDoWJP0Q8KHiA+ct/
YAfeSK4a8qrisKUHafb1Ne4x8TfCTv76Pa1VDjCEM+BLCbaT0FOoE3bVpxru32gp
Ac2GsPNOW7CI4QGyTWpCbLBlW2jb3NAXuXvL6d3RPhM2jcHwAZU+vleT+nxkasD9
LHISSTzq4gZsq+9ZX0e0m9R/4qKaDhoBrr6oq5ZviAuXBnqOLC2KUgySZpE9Izvo
ygDcAuye9jXYl+URwEBjIEveTd5+WYYI6fZJUaX65erv0Ah2icuOTNqxm3wdf7m9
ZiQonmJUUSaVmCvHdgTAe+Bd0zkp/A==
=68Ft
-----END PGP SIGNATURE-----

--ry7z4n62q7an2p3j--
