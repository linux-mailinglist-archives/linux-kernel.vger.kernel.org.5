Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874337FC66C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345269AbjK1Uzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346555AbjK1Uzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:55:47 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369A9DA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:55:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r857W-000642-Be; Tue, 28 Nov 2023 21:55:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r857V-00CFst-5c; Tue, 28 Nov 2023 21:55:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r857U-00AO4d-Sc; Tue, 28 Nov 2023 21:55:48 +0100
Date:   Tue, 28 Nov 2023 21:55:48 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: bcm2835: Fix NPD in suspend/resume
Message-ID: <20231128205548.hfvknhimerqdunpx@pengutronix.de>
References: <20231113164632.2439400-1-florian.fainelli@broadcom.com>
 <170119374441.445690.2721498852495955001.b4-ty@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zpjmgeplms2lxjvo"
Content-Disposition: inline
In-Reply-To: <170119374441.445690.2721498852495955001.b4-ty@gmail.com>
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


--zpjmgeplms2lxjvo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 06:49:22PM +0100, Thierry Reding wrote:
>=20
> On Mon, 13 Nov 2023 08:46:32 -0800, Florian Fainelli wrote:
> > When 119a508c4dc9 ("pwm: bcm2835: Add support for suspend/resume") was
> > sent out on October 11th,, there was still a call to
> > platform_set_drvdata() which would ensure that the driver private data
> > structure could be used in bcm2835_pwm_{suspend,resume}.
> >=20
> > A cleanup now merged as commit commit 2ce7b7f6704c ("pwm: bcm2835:
> > Simplify using devm functions") removed that call which would now cause
> > a NPD in bcm2835_pwm_{suspend,resume} as a consequence.
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [1/1] pwm: bcm2835: Fix NPD in suspend/resume
>       commit: fba7e9f839d7fcb0888094697da45c5668226455

This one should IMHO go into v6.7. Do you intend to send it to Linus
during the current cycle?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zpjmgeplms2lxjvo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVmU9MACgkQj4D7WH0S
/k7w+wf/VBFWTtFUiFmsjqBwF8/k+2ydZQP7ek+8yFnPGFfkK7SghmrTO/qglBT7
8hLOB5kqgTUcBV8mUDfHlLF7Lob9wjeGbF4Xm59qLUXITkQf42tEs3WW37/JWC5O
jBzmIl3rimD+busg0/Kx+xL4f+oK2VIsK9FMKy9qITATNO+HemqI7LxhFdfI+n+t
gDbKf1MvEjTKXrMWv105QCatsuDvafudW2ZebvB4vH2lRu7KrEHQTwR66LBhhBjz
3TZCOB2W79P331WK9hxDXqMJ5cnZE/iZWnBbt+cx+SRnDOBobG0b1DDxTcVApzdY
5Sm3F6LA7BauNeqf4yLBm94q6ovLLw==
=cgCg
-----END PGP SIGNATURE-----

--zpjmgeplms2lxjvo--
