Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1954580EA6C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjLLLbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjLLLbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:31:05 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871A2EB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:31:12 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rD0yi-00040o-6c; Tue, 12 Dec 2023 12:31:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rD0yh-00FKF9-JA; Tue, 12 Dec 2023 12:31:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rD0yh-001b0d-A2; Tue, 12 Dec 2023 12:31:07 +0100
Date:   Tue, 12 Dec 2023 12:31:07 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/6] pwm: Replace ENOTSUPP with EOPNOTSUPP
Message-ID: <20231212113107.4yykyuptc7zz7lzp@pengutronix.de>
References: <cover.1702369869.git.sean@mess.org>
 <af5b2e8ac6695383111328267a689bcf1c0ecdb1.1702369869.git.sean@mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="einuuad7epqbrnz6"
Content-Disposition: inline
In-Reply-To: <af5b2e8ac6695383111328267a689bcf1c0ecdb1.1702369869.git.sean@mess.org>
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


--einuuad7epqbrnz6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 08:34:01AM +0000, Sean Young wrote:
> ENOTSUPP is not a standard error code and should be avoided.

I'd write:

	According to Documentation/dev-tools/checkpatch.rst ENOTSUPP is
	not recommended and EOPNOTSUPP should be used instead.

to give the sentence a bit of authority.

Other than that I'm fine with the change.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--einuuad7epqbrnz6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV4RHoACgkQj4D7WH0S
/k6GBQf/XgiUjmr+wovqNyanDNWjL+x5SDSVzmAtyOhfCPCk4FLDLxeVZLV34aTi
d43qNyiIzdMcXYfn5BfrPwpQP/yYDkD26cZwDScqrtbVe8XBwP5wJMuoL4x9HwlO
J21gnxysAfYhqZCtilGOiMqJy1ixjByrEr4wR8MDGMtvguCnb1LgMw/zIvtRAC0A
VrU6nhr0AQZ6d8Av7Wi9KHyoJ7ylgi/8T4TPZcHO3QPIH98MbVDiqTXv619+0Osg
kAL5wAJ7Qp+1GgmcvaUFBnr53iBAhsWY/EKOCuSAxosLEPpGbOdmePCWN97uyArl
CvBMWfzpNKt4fvOdQLdKveefWnS+EQ==
=t4xt
-----END PGP SIGNATURE-----

--einuuad7epqbrnz6--
