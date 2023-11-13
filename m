Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C50C7EA515
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 21:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjKMUx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 15:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjKMUx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 15:53:28 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C82189
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 12:53:24 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2dvt-0001Fx-Tf; Mon, 13 Nov 2023 21:53:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2dvt-008q3z-0W; Mon, 13 Nov 2023 21:53:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2dvs-0013tX-NP; Mon, 13 Nov 2023 21:53:20 +0100
Date:   Mon, 13 Nov 2023 21:53:20 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] pwm: bcm2835: Fix NPD in suspend/resume
Message-ID: <20231113205320.bkh5kkon3w2yf4pq@pengutronix.de>
References: <20231113164632.2439400-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xogulhhqz7et46rr"
Content-Disposition: inline
In-Reply-To: <20231113164632.2439400-1-florian.fainelli@broadcom.com>
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


--xogulhhqz7et46rr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Nov 13, 2023 at 08:46:32AM -0800, Florian Fainelli wrote:
> When 119a508c4dc9 ("pwm: bcm2835: Add support for suspend/resume") was
> sent out on October 11th,, there was still a call to
> platform_set_drvdata() which would ensure that the driver private data
> structure could be used in bcm2835_pwm_{suspend,resume}.
>=20
> A cleanup now merged as commit commit 2ce7b7f6704c ("pwm: bcm2835:
> Simplify using devm functions") removed that call which would now cause
> a NPD in bcm2835_pwm_{suspend,resume} as a consequence.
>=20
> Fixes: 119a508c4dc9 ("pwm: bcm2835: Add support for suspend/resume")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

oops, indeed.

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xogulhhqz7et46rr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVSjL8ACgkQj4D7WH0S
/k5/gAf+Plpoji+oarx+qw4vy3iu1xj906Fy+FPqxDCKVfVnzlDtU5U6QOK6Pbct
td64ms01pzmeO7d0/MYO37oaeURTDxeV6Vu897qwYGxrCI2xtXRLdxftxsmJFKYD
TN1Qlhpboo2sgaD6TrIGDQBQS24Tk0tcuOrYkUsk2z38OS+ocT/oGAJsYOKKSprw
Ja/zCxB2dkCO47HN8OS9PZuKVj9SYkzawpDxdGDf9A3eFbvBcIjwUJ9l5btuxHDL
Qy4kOEaulF03NHnU/MExH/51Gfas7hT2uRCZ74SgMvhENzTsJ0PExm5VwCLkx2an
4ykIVjMG+n44aS7I9UwI2wdjIlGZwg==
=naiA
-----END PGP SIGNATURE-----

--xogulhhqz7et46rr--
