Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702CA7ED61D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344664AbjKOVfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjKOVe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:34:59 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8A5B0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:34:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3NXA-0004XD-Ec; Wed, 15 Nov 2023 22:34:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3NX9-009JIF-R8; Wed, 15 Nov 2023 22:34:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3NX9-002Dev-Ht; Wed, 15 Nov 2023 22:34:51 +0100
Date:   Wed, 15 Nov 2023 22:34:51 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [RESEND PATCH] pwm: Use device_get_match_data()
Message-ID: <20231115213451.cvrmuzdbtfrpysth@pengutronix.de>
References: <20231115210121.3738487-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jc2xrudroiknumgj"
Content-Disposition: inline
In-Reply-To: <20231115210121.3738487-1-robh@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jc2xrudroiknumgj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rob,

this is a resend of v2, I'd say. Would have been helpful to indicate
that in the Subject line.

On Wed, Nov 15, 2023 at 03:01:20PM -0600, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
>=20
> As these drivers only do DT based matching, of_match_device() will never
> return NULL if we've gotten to probe(). Therefore, the NULL check and
> error returns can be dropped.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

I send a Reviewed-by tag in reply to (original) v2 that wasn't added
here. As v2 is still "new" in the pwm patchwork, I'll mark this resend
as non-actionable.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jc2xrudroiknumgj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVVOXoACgkQj4D7WH0S
/k7kpAf/bl4KKfAUBzghYI6z/50HL7esIThFBaGzzgnzJERN+uCxApkuHsLFN9kn
/he+aasBSn8kXa1A3DELf0byviI8xBJRn+OFXJbWkVMk0VIc8BQavnm0iE/NaxuH
KnyOdFDwc4Rcmip0Yus5iP8U3kaj6ikdMNYla9NFMuQ61AaWZHnQX/SQ+bTVJmeX
p3JF7ZJPvC9YNHXAFJwbPRWhWn6dLYRSOWoV6ulHWhuQg8/zJKUxW5s97eLPNHL5
X1pqlVJr+KUCaxNfAgjrQCweQs5y5hyUj7aarrhTBKtZtw1YYdcpgiRszp4qD0Qu
0CJwfOp3awhDbcSIav0CxkeTQZQDrQ==
=DR7L
-----END PGP SIGNATURE-----

--jc2xrudroiknumgj--
