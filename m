Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CF47A357F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 14:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjIQMM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 08:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbjIQMMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 08:12:12 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC06135
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 05:12:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qhqd8-0006Pi-8o; Sun, 17 Sep 2023 14:12:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qhqd2-006ywg-UO; Sun, 17 Sep 2023 14:11:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qhqd2-002K98-KK; Sun, 17 Sep 2023 14:11:56 +0200
Date:   Sun, 17 Sep 2023 14:11:54 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Marek Vasut <marex@denx.de>, Rob Herring <robh@kernel.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sergey Organov <sorganov@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Tom Rix <trix@redhat.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH tty v1 29/74] serial: imx: Use port lock wrappers
Message-ID: <20230917121154.q3qopymscpodaago@pengutronix.de>
References: <20230914183831.587273-1-john.ogness@linutronix.de>
 <20230914183831.587273-30-john.ogness@linutronix.de>
 <20230915202122.ulgy4fdxpsxmecbo@pengutronix.de>
 <875y49nbq3.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l7zqlu23qfo3bmuk"
Content-Disposition: inline
In-Reply-To: <875y49nbq3.fsf@jogness.linutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l7zqlu23qfo3bmuk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 16, 2023 at 09:51:40PM +0206, John Ogness wrote:
> On 2023-09-15, Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
> >> Converted with coccinelle. No functional change.
> >>=20
> >> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >
> > This lacks a Signed-off line by John.
>=20
> I really didn't have anything to do with the development of this
> series. (I just did basic testing and the posting to LKML.) But I have
> no problems adding my SoB if that is more appropriate.

If you sent it, you have enough to do with it, that your S-o-b is
required. See Documentation/process/submitting-patches.rst for the
details, which has for example:

	Notably, the last Signed-off-by: must always be that of the
	developer submitting the patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--l7zqlu23qfo3bmuk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUG7QkACgkQj4D7WH0S
/k4l1wgAhPgVKOI/Ns+ehxDqtdNDTj7YzMZ4kngFH8ul/aEkAfoOeLTPFDY085UN
d3D25kBr5qYQnBhyjbnMep3KF8LnTJtSSLukAL6G9J2MF3QWkbnP/LQbWTdFSnwL
kDfLxBDjyHckVT0KSG9WxAxbNEqvUBiyjPcYRp2Zu1ycfluNHc7B0NR31DGT6XX0
J7cp8aiPXlDHZ+pYXcd7w/epJIXbp8wZzjI5ajbt/vhFLDfGQKJjPkiBqugw7vPE
f8xYYbcFU2TifQUpvCCKX3wOfzmfyyL2lV2PvKViitXeOqm22cMIgAqSnqvkmVTL
kRtzlb4y8xqH9AZvnsqGIvxQXuw11A==
=OIHx
-----END PGP SIGNATURE-----

--l7zqlu23qfo3bmuk--
