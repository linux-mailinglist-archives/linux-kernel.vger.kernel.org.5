Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991D780B4B6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 15:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjLIN4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 08:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjLIN4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 08:56:22 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2209FC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 05:56:28 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBxoU-0001Tq-BD; Sat, 09 Dec 2023 14:56:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBxoP-00EecX-OV; Sat, 09 Dec 2023 14:56:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBxoP-00H5BC-Ep; Sat, 09 Dec 2023 14:56:09 +0100
Date:   Sat, 9 Dec 2023 14:56:09 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Arnd Bergmann <arnd@arndb.de>, Kalle Valo <kvalo@kernel.org>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 0/7] pcmcia: Convert to platform remove callback
 returning void
Message-ID: <20231209135609.c2vfba7age6xcrvp@pengutronix.de>
References: <cover.1702051073.git.u.kleine-koenig@pengutronix.de>
 <ZXNsLJfqs9DLHb1Q@shine.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aslpjjjvec5vvjkj"
Content-Disposition: inline
In-Reply-To: <ZXNsLJfqs9DLHb1Q@shine.dominikbrodowski.net>
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


--aslpjjjvec5vvjkj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Dominik,

On Fri, Dec 08, 2023 at 08:19:08PM +0100, Dominik Brodowski wrote:
> Am Fri, Dec 08, 2023 at 05:08:05PM +0100 schrieb Uwe Kleine-K=F6nig:
> > Hello,
> >=20
> > this series changes all platform drivers in drivers/pcmcia to use the
> > .remove_new() callback. See commit 5c5a7680e67b ("platform: Provide a
> > remove callback that returns no value") for an extended explanation and
> > the eventual goal.
> >=20
> > All conversations are trivial, because all .remove() callbacks returned
> > zero unconditionally already.
> >=20
> > There are no interdependencies between these patches, so they could be
> > picked up individually. However I'd expect them to go in all together.
> > It's unclrear to me though, who will pick them up. Dominik? Greg?
>=20
> Both options are fine with me. In the latter case:
>=20
> 	Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

Then I suggest you to take them. I only suggested Greg as a fallback
because I was unsure how active you are given the PCMCIA entry in
MAINTAINERS has status "Odd Fixes".

Best regards and a calm pre-Christmas period,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--aslpjjjvec5vvjkj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV0cfMACgkQj4D7WH0S
/k4QRwf/QMlIoBzRUMSio/L4sWcXoiVU3ntyznRfzHDS04dUwC1Wr1ykM+IV1XoZ
ZMucDDI19+5VlcDVrQcFSkNmG9yEIZGW7ME6nKtyTV+OOG+zuAXTJqajOxbk85TB
i9yjhZ/J3dk+4LuvtzwGl1Z1Bu+awZdPAU92xoYT8TVGF63JXreWNAF4uDP/fu4X
jJPH6Ua1S7ZuriDy8AkVLFBVhASqMgjbe52pr8W37UZ7ZAUxDkXybAbbsUyUT95g
/nz2+yCWfQnQBkTVJPG2i9o+xfiVAf+ipGgEAWNJh8i2QmFRKMP33lDTUbGREoVi
xOZa71kRsOE/OXpufA7DVVszPtB9hQ==
=LUXF
-----END PGP SIGNATURE-----

--aslpjjjvec5vvjkj--
