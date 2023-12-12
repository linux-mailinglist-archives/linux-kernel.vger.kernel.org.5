Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0795D80F1EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjLLQIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjLLQIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:08:43 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2618E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:08:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rD5JH-0004jR-QV; Tue, 12 Dec 2023 17:08:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rD5JH-00FNhj-2l; Tue, 12 Dec 2023 17:08:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rD5JG-001kiF-PY; Tue, 12 Dec 2023 17:08:38 +0100
Date:   Tue, 12 Dec 2023 17:08:38 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/6] pwm: bcm2835: Allow PWM driver to be used in
 atomic context
Message-ID: <20231212160838.k4z4csy455a7qnje@pengutronix.de>
References: <cover.1702369869.git.sean@mess.org>
 <e9e32c9789da3c90b5a2aa7d5a093120b76421fb.1702369869.git.sean@mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wlqgufhnyonivmrn"
Content-Disposition: inline
In-Reply-To: <e9e32c9789da3c90b5a2aa7d5a093120b76421fb.1702369869.git.sean@mess.org>
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


--wlqgufhnyonivmrn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Tue, Dec 12, 2023 at 08:34:04AM +0000, Sean Young wrote:
> @@ -169,6 +179,7 @@ static int bcm2835_pwm_suspend(struct device *dev)
>  {
>  	struct bcm2835_pwm *pc =3D dev_get_drvdata(dev);
> =20
> +	clk_rate_exclusive_put(pc->clk);
>  	clk_disable_unprepare(pc->clk);

I thought this was the remove function, but that's suspend. Adding
clk_rate_exclusive_put() there is wrong.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wlqgufhnyonivmrn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV4hYUACgkQj4D7WH0S
/k7CGwf8CNDJo8J8DGsUCNsNPFcJnPGhEI5nHgeeIHjn5tWVeMMh4VTcS5OPtH2b
lVGGS2AKxudNdoodSJ/x50nT0o/PdjrcXmWX2V6WVx2P3kmHrPk7lvExuQlaWmhd
LmdKyjfjUXEJ3Cr+TEZ2MwmVxyvrqhvEqqKHKE88hxeb+WU6pz3Jc9bivEEoQttV
PbLO5ghpdc5JjT4TR/q0Tfm/bOfQpLx7fIodBvZ7pzqLWO7/ExmK9ektbG60oJXq
sVSjGYJta2hqOzGxcfXZgBpBDtXvGB0fl5O/c7vyG59aLZkwcSQpp2y9L8NXe54r
C/R7Dp4x1L/tF2BExdxbEZ7sXvOJWA==
=Shxu
-----END PGP SIGNATURE-----

--wlqgufhnyonivmrn--
