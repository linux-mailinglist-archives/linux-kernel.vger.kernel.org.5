Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2CA80AA9A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574497AbjLHRVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjLHRVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:21:31 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88822102
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:21:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBeWo-0000mC-64; Fri, 08 Dec 2023 18:20:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBeWm-00ESz6-Dt; Fri, 08 Dec 2023 18:20:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBeWm-00GWT3-4b; Fri, 08 Dec 2023 18:20:40 +0100
Date:   Fri, 8 Dec 2023 18:20:40 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Young <sean@mess.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] pwm: bcm2835: allow pwm driver to be used in
 atomic context
Message-ID: <20231208172040.mgw7aicmwlw6yjyb@pengutronix.de>
References: <cover.1701248996.git.sean@mess.org>
 <179dc1ce85702a8b64b43c0e0df656b0c5e3ce30.1701248996.git.sean@mess.org>
 <ZXNC3JYy7CTfYsyC@orome.fritz.box>
 <ZXNL5upeUPc4gC1R@gofer.mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ct5bcsf4uq5e5wn5"
Content-Disposition: inline
In-Reply-To: <ZXNL5upeUPc4gC1R@gofer.mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ct5bcsf4uq5e5wn5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 05:01:26PM +0000, Sean Young wrote:
> On Fri, Dec 08, 2023 at 05:22:52PM +0100, Thierry Reding wrote:
> > On Wed, Nov 29, 2023 at 09:13:36AM +0000, Sean Young wrote:
> > > clk_get_rate() may do a mutex lock. Fetch the clock rate once, and pr=
event
> > > rate changes using clk_rate_exclusive_get().
> > >=20
> > > Signed-off-by: Sean Young <sean@mess.org>
> > > ---
> > >  drivers/pwm/pwm-bcm2835.c | 31 +++++++++++++++++++++----------
> > >  1 file changed, 21 insertions(+), 10 deletions(-)
> >=20
> > s/pwm/PWM/ in the subject. Although, I guess you could just drop the
> > "PWM" altogether because the subject prefix implies that this is for
> > PWM.
>=20
> $ git log --no-merges --oneline drivers/pwm/ | sed -r 's/^\w* ([^:]+): .*=
/\1/' | sort | uniq -c
>    1197 pwm
>       1 PWM
>   ...
>=20
> The vast majority of the commits use pwm: as a prefix, only one uses PWM:=
=2E=20
> In fact if you look across the tree almost everywhere lower case is used
> for the prefix.

Thierry doesn't want you to change the subject prefix, but only the
second "pwm" to make it read:

	pwm: bcm2835: allow PWM driver to be used in atomic context

While I understand Thierry here, I'm fine with a lowercase pwm here,
too. In my book a PWM in all uppercase is the type of hardware and pwm
in all lowercase is the framework's name. If you use "PWM driver" or
"pwm driver" then doesn't matter much.

=09
>=20
> I'm just trying to follow convention.
>=20
> Having said that, I think the prefix is totally redundant, it is clear fr=
om
> the commit files what they are affecting. I am not sure what it really ad=
ds.
>=20
> > Also, please capitalize after the subject prefix.
>=20
> $ git log --no-merges --oneline drivers/pwm/ | grep -E '^\w* ([^:]+): [A-=
Z]' | wc -l
> 217
> $ git log --no-merges --oneline drivers/pwm/ | grep -E '^\w* ([^:]+): [a-=
z]' | wc -l
> 1069

Your matching things like:

	pwm: pwm-tiehrpwm: Add support for configuring polarity of PWM

with the second command. These are perfectly fine as pwm-tiehrpwm is the
driver name and so shouldn't be capitalized. With a bit more care here,
we get:

	$ git log --no-merges --oneline drivers/pwm/ | grep -E '^.+: [a-z][^:]*$' =
| wc -l
	114
	$ git log --no-merges --oneline drivers/pwm/ | grep -E '^.+: [A-Z][^:]*$' =
| wc -l
	1167

And the newest of the 114 with a small letter is from 2013.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ct5bcsf4uq5e5wn5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVzUGcACgkQj4D7WH0S
/k6tQQf/bona8Fvzxu0QxMsufyqPimaBLCRvs+l5rduG1l4p1h3vBMvs+rbPrQ1o
PLKdltnHbhtp6Apn0v5IFZmRPk7wvVDya9TsGLXK/YXe8WT9/k0knB/00jVxvrh4
mYycPSvlTZNICuEMrsy+Wmeh3GXP8jLWFK/qwZzgPUa7RkUSl5AKiiPHSjpB/eaG
NEiXFDDIxn12GuEqO8CxUoOCGit1LeTNCNWwA7ZJeu15KpUfLh9O6KfiEiNV2+50
gpdzR68mRKh9g36Egru+mSQKm42ybuZBDGUnRoUsH/ZXli+LYzHBIStuAzhg8031
LbR+ApCpUJvPQApRmYToKH2UmPWUxQ==
=s4Zz
-----END PGP SIGNATURE-----

--ct5bcsf4uq5e5wn5--
