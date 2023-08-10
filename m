Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB0C77705D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjHJGcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjHJGck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:32:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5086E5B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 23:32:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTzDm-0004TT-DO; Thu, 10 Aug 2023 08:32:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTzDh-002NiC-5p; Thu, 10 Aug 2023 08:32:29 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTzDg-00BsYz-Ew; Thu, 10 Aug 2023 08:32:28 +0200
Date:   Thu, 10 Aug 2023 08:32:25 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Ioana Ciornei <ciorneiioana@gmail.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Andre Edich <andre.edich@microchip.com>,
        Antoine Tenart <atenart@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Divya Koppera <Divya.Koppera@microchip.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Kresin <dev@kresin.me>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Michael Walle <michael@walle.cc>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nisar Sayed <Nisar.Sayed@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Willy Liu <willy.liu@realtek.com>,
        Yuiko Oshino <yuiko.oshino@microchip.com>
Subject: Re: [PATCH] net: phy: Don't disable irqs on shutdown if WoL is
 enabled
Message-ID: <20230810063225.2dm7gpnrozjiakdo@pengutronix.de>
References: <20230809135702.4dencx4ikij7d33y@skbuf>
 <50f0b253-8eae-a4bd-0c5d-d23b020ce8df@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qv37uyg22vdr5bs4"
Content-Disposition: inline
In-Reply-To: <50f0b253-8eae-a4bd-0c5d-d23b020ce8df@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qv37uyg22vdr5bs4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Florian,

On Wed, Aug 09, 2023 at 08:35:24AM -0700, Florian Fainelli wrote:
> this does make me wonder whether Uwe tested with a prior system
> suspend/resume cycle before shutting down?

No, he didn't. That's why he wrote "Note that this change is
only compile tested as next doesn't boot on my test machine (because of
https://git.kernel.org/linus/b3574f579ece24439c90e9a179742c61205fbcfa)
and 6.1 (which is the other kernel I have running) doesn't know about
=2Ewol_enabled. I don't want to delay this fix until I bisected this new
issue." in the mail containing the patch.

The issue in next is resolved, but I didn't come around to test this
patch yet.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qv37uyg22vdr5bs4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTUhHkACgkQj4D7WH0S
/k5BqQf/YGqEkYSNALN94+eORwQDB/vEdP2VZvutTiNkhmpgtlrsQGs4nqe5ugkD
Htbc72n8FarwvuknvQzMGNEc1eTiUBV+ZYmQ0SXZwFtLY/ykVsYOvIET2oduSckG
AJu/kVA48leARUpN1Jg7sCrv8qQqwMpcrG1QYPSDh1Li5FqYLi2CtYIEvuSh6qpa
Cf68T3R3shEByZGVKbHLtl4EyqOMjz2IBOPinPMkLps4rWvkcAL0v/F0mWgnzCdt
kQOUxGLGHu6WzDqP6zGOS/+76OxNBXPEfZ/bhzZVlShfODuL4Q/88nlC9FEBel8R
Ugs3mTZG77AXktZPQo0jdJRztDLOwA==
=DEiO
-----END PGP SIGNATURE-----

--qv37uyg22vdr5bs4--
