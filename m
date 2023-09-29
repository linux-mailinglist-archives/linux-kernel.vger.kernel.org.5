Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9577B3BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 23:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbjI2VJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 17:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjI2VJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 17:09:10 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6581A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:09:08 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmKjB-0002ue-N9; Fri, 29 Sep 2023 23:08:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmKjA-009tcM-MS; Fri, 29 Sep 2023 23:08:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmKjA-0064Jb-Ct; Fri, 29 Sep 2023 23:08:48 +0200
Date:   Fri, 29 Sep 2023 23:08:48 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Young <sean@mess.org>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-media@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Timo Kokkonen <timo.t.kokkonen@iki.fi>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>,
        "Sicelo A . Mhlongo" <absicsz@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/2] media: rc: remove ir-rx51 in favour of generic
 pwm-ir-tx
Message-ID: <20230929210848.u4nzfttiyzde3ass@pengutronix.de>
References: <cover.1693577725.git.sean@mess.org>
 <e5325e826935f0bd8566152b6a5fa799b2429d43.1693577725.git.sean@mess.org>
 <99f0042f-538c-bcaf-96fd-bac24a87f88e@gmail.com>
 <ZRKFUb1vRtn82bgn@gofer.mess.org>
 <1715e2bf-5d02-4f20-1476-29a1fdf350b1@gmail.com>
 <ZRM8iLORjKw3z/h5@gofer.mess.org>
 <179c4674-aa5c-0573-6d1f-ea6f2694d156@gmail.com>
 <ZRb5OWvx3GxYWf9g@gofer.mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u4jmzjzd7ymfkcg2"
Content-Disposition: inline
In-Reply-To: <ZRb5OWvx3GxYWf9g@gofer.mess.org>
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


--u4jmzjzd7ymfkcg2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Fri, Sep 29, 2023 at 05:20:09PM +0100, Sean Young wrote:
> On Fri, Sep 29, 2023 at 11:49:52AM +0300, Ivaylo Dimitrov wrote:
> > On 26.09.23 =D0=B3. 23:18 =D1=87., Sean Young wrote:
> > > I've never known of a solution to the pwm-ir-tx driver. If using hrti=
mers
> > > directly improves the situation even a bit, then that would be great.
> >=20
> > The issue with hrtimers is that we cannot use them directly, as
> > pwm_apply_state() may sleep, but hrtimer function is called in atomic
> > context.
>=20
> I've also been looking at this problem and came to same conclusion: the
> fact that pwm_apply_state() sleeps is a huge problem.
>=20
> 1) The vast majority of pwm drivers don't sleep, or could even be convert=
ed
>    to spinlocks (e.g pwm-sifive.c could use spinlocks, as far as I can se=
e).
>=20
> 2) Sure, some pwm devices are on i2c busses, so the driver needs to sleep.
>    Those devices aren't great for what we're trying to do here, since the
>    sleeping may cause delays and affect the generated signal.
>=20
> What would be ideal here is to have pwm-ir-tx work in atomic context if
> a non-sleeping pwm device is used, and another (non-optimal) code path
> for sleeping pwm drivers. We could even just refuse to run on sleeping pwm
> drivers.
>=20
> Uwe what do you think of this idea? The pwm api could have a
> bool pwm_may_sleep(struct pwm *pwm) function,

It's certainly possible. The idea of introducing the might_sleep() was
to catch atomic users and if some appear to be able to evaluate if
something needs to be done. See commit 4ad91a227817 ("pwm: Make it
explicit that pwm_apply_state() might sleep").

It complicates things concerning my last bigger pwm series, see
https://lore.kernel.org/linux-pwm/20230808171931.944154-102-u.kleine-koenig=
@pengutronix.de/
which introduces a mutex_lock() in pwm_apply_state(). Hmm.

> and pwm_apply_state() does=20
> not contain might_sleep() - only the driver-specific apply calls might_sl=
eep().

I'd replace the might_sleep() by something like
might_sleep_if(pwm_may_sleep(pwm)); but that's an implementation detail.

> It would be nice if this could all be done at compile time through e.g. a
> device tree attribute.

I wouldn't have something like "linux,slow-pwm" or similar in the device
tree, and I'd expect the dt maintainers to shoot down something like
that, too. What is the problem with a pwm_can_sleep() function only?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--u4jmzjzd7ymfkcg2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUXPN8ACgkQj4D7WH0S
/k77GQf/V8FMnrkeJGagdrDY/0MiSQ4rfssA9y/TF+9BTZaMroFiEWqRUsnGY1De
Ry21ynn5GebPW+ocFZMO81g8XDjZo4g6XfVB4SMdKOZu2cnQ66ibeLh+JE7nZpHu
GOrpZQY8izyrFnByEHNrsjaVUUJy886hFZ5CfxgU5ofXDFzlC+UA9w6tOpLVKSN7
RoFVkafau5OkPn8On3GkI/qaTJmh20EUGvQL5tmoXn0rbZoCb6pbDa8k9m9LSTUx
QNGgK5cqH8+jbWDqJhBXFSe6mgjLV4x+Zy3KTrAFzUo8IFA4Z7HNnG5ZhXOxL2SG
h76J6e2dAO+wSvZ8zTZMXIrGQhPswg==
=IWbA
-----END PGP SIGNATURE-----

--u4jmzjzd7ymfkcg2--
