Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618D67C938C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 10:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjJNIrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 04:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjJNIrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 04:47:20 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A692BB
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 01:47:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qraIZ-0000cq-7e; Sat, 14 Oct 2023 10:47:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qraIX-001aEA-Vi; Sat, 14 Oct 2023 10:47:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qraIX-00G784-Ls; Sat, 14 Oct 2023 10:47:01 +0200
Date:   Sat, 14 Oct 2023 10:47:01 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] pwm: bcm2835: allow pwm driver to be used in
 atomic context
Message-ID: <20231014084701.6fuuwcu4pknm7jju@pengutronix.de>
References: <cover.1697193646.git.sean@mess.org>
 <6ce73b2688f059e7169935699044104cf37b2425.1697193646.git.sean@mess.org>
 <84429d39-aa54-462d-85cd-c5d06a614a0e@gmx.net>
 <5203415.ElGaqSPkdT@steina-w>
 <20231013175140.dzlz4grrgngoyxbc@pengutronix.de>
 <e3e1bca1-bffa-d97a-d4af-27a10c43c064@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="giqnk66nh3wiw3cc"
Content-Disposition: inline
In-Reply-To: <e3e1bca1-bffa-d97a-d4af-27a10c43c064@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--giqnk66nh3wiw3cc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ivaylo,

On Sat, Oct 14, 2023 at 09:51:12AM +0300, Ivaylo Dimitrov wrote:
> On 13.10.23 =D0=B3. 20:51 =D1=87., Uwe Kleine-K=C3=B6nig wrote:
> > Hello,
> >=20
> > On Fri, Oct 13, 2023 at 01:13:50PM +0200, Alexander Stein wrote:
> > > Am Freitag, 13. Oktober 2023, 13:04:48 CEST schrieb Stefan Wahren:
> > > > Am 13.10.23 um 12:46 schrieb Sean Young:
> > > > > clk_get_rate() may do a mutex lock. Since the clock rate cannot c=
hange on
> > > > > an rpi, simply fetch it once.
> > > >=20
> > > > does it mean you checked all possible SoCs (BCM2835, BCM2836, BCM28=
37,
> > > > BCM2711, BCM2712) for this change?
> > > >=20
> > > > Is it impossible that the real clock can never be influenced by tur=
bo
> > > > mode like SPI?
> > >=20
> > > Assuming the clock can change, which I would, then a clock notifier s=
eems
> > > appropriate. See [1] for an example.
> >=20
> > I'm not a fan. If the clock changes, the output also changes. With a
> > clock notifier you can soften the issue and reconfigure to something
> > similar as the original wave form, but a glitch happens for sure.
> >=20
>=20
> Right, but without notifier, everything rate related after the change will
> be wrong

So we agree clk_rate_exclusive_get() is the way to go?! It's simple, no
need for a notifier and no glitches.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--giqnk66nh3wiw3cc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUqVYUACgkQj4D7WH0S
/k4wigf9HHL4tqjTV1EyBXB1X+oKJKBONPLDUgJ+rE5Gw+/6EoqDq+HBK1UMKuaT
PojCSO0QM0v7tHpApWQ51j9mZxkFWF9UJZCURBEP5mPSr4zVBrpa4oMh7E8Ga/2P
SL7R9xAZxpl2TJbF5FnMQUlsRNP0LJf/KKjW0nknisJeqbziyeXcVVaLEBh+B84v
OzpgTugHJhfb+T4T0842KaI4sVm2yLGlY4L75EssrwWWEBIYWLknh5VPb1G1my1f
sP7n71Z6FbqLR1Jk5o3TTWdsJiD0whcTkbUgfFsVUO18Pat9LzYksSOK8zP6+TSn
LPcN7mgljq64D0MtjOPK7lYfGkoZcA==
=YY+P
-----END PGP SIGNATURE-----

--giqnk66nh3wiw3cc--
