Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DDE79411B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242406AbjIFQF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjIFQFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:05:53 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D540D10C7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 09:05:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qdv0v-0007ag-Fx; Wed, 06 Sep 2023 18:04:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qdv0u-004SsU-Fj; Wed, 06 Sep 2023 18:04:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qdv0t-00Gv6d-HS; Wed, 06 Sep 2023 18:04:19 +0200
Date:   Wed, 6 Sep 2023 18:04:19 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Timo Kokkonen <timo.t.kokkonen@iki.fi>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        "Sicelo A . Mhlongo" <absicsz@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/2] media: rc: remove ir-rx51 in favour of generic
 pwm-ir-tx
Message-ID: <20230906160419.bzaaxiqup3g7wix3@pengutronix.de>
References: <cover.1693577725.git.sean@mess.org>
 <e5325e826935f0bd8566152b6a5fa799b2429d43.1693577725.git.sean@mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yna66eufovoorr7v"
Content-Disposition: inline
In-Reply-To: <e5325e826935f0bd8566152b6a5fa799b2429d43.1693577725.git.sean@mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yna66eufovoorr7v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Sep 01, 2023 at 03:18:56PM +0100, Sean Young wrote:
> The ir-rx51 is a pwm-based TX driver specific to the N900. This can be
> handled entirely by the generic pwm-ir-tx driver, and in fact the
> pwm-ir-tx driver has been compatible with ir-rx51 from the start.
>=20
> Note that the suspend code in the ir-rx51 driver is unnecessary, since
> during transmit, the process is not in interruptable sleep. The process
> is not put to sleep until the transmit completes.
>=20
> Cc: Timo Kokkonen <timo.t.kokkonen@iki.fi>
> Cc: Pali Roh=E1r <pali.rohar@gmail.com>
> Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> Tested-by: Sicelo A. Mhlongo <absicsz@gmail.com>
> Signed-off-by: Sean Young <sean@mess.org>

I just commented on v3 of this patch. It was an

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

which I forward hereby to this v5. As with the previous revisions I'll
mark this as handled-elsewhere in the pwm patchwork in the assumption
that the pwm tree isn't involved to get this into the mainline.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yna66eufovoorr7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmT4owIACgkQj4D7WH0S
/k6/JAgAsSZiojUOSo9/ubljxgVGkTW9fai2HK7SGW78N3QOnrALLaxCsvSYVWWb
VDF0OGkp/X19r/eULawRMqSnAWCtFdmV1Un14IAAVN246nAQXWb4NyZGsHZZmqY6
EEjPgRUkr64p8Or2j+PToEsPsmelOAf6Rd+1JKOVfl5869LcfYG4zt2co8iG/kvM
6YdrNeIKb/7WFQc2O9aoOY93Bwjt+dJ7Fa4tOcaeaJmSvwxQaTblBHjVo/+el4Sx
LpN6SFO8gCG5h3DjUCrneIFpEr4fmgAOMKg+V7KtV52+8RBczCPxxKcSor7o0WlF
MMj/RmVqCjOLmHYJ6xG373qNS1cmTA==
=qihs
-----END PGP SIGNATURE-----

--yna66eufovoorr7v--
