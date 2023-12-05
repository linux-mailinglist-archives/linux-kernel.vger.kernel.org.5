Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECABA804E1D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjLEJlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjLEJlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:41:44 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01BBA0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:41:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rARve-0002oj-Qq; Tue, 05 Dec 2023 10:41:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rARvb-00DiEE-96; Tue, 05 Dec 2023 10:41:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rARva-00EdG6-Vg; Tue, 05 Dec 2023 10:41:18 +0100
Date:   Tue, 5 Dec 2023 10:41:18 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-fsd@tesla.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: pwm: samsung: add specific compatible
 for Tesla FSD
Message-ID: <20231205094118.jmzeyf23rv6gdiin@pengutronix.de>
References: <20231205092229.19135-1-krzysztof.kozlowski@linaro.org>
 <20231205092229.19135-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cp7g3cuaqtzc7z3g"
Content-Disposition: inline
In-Reply-To: <20231205092229.19135-3-krzysztof.kozlowski@linaro.org>
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


--cp7g3cuaqtzc7z3g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Dec 05, 2023 at 10:22:25AM +0100, Krzysztof Kozlowski wrote:
> Tesla FSD is a derivative of Samsung Exynos SoC, thus just like the
> others it reuses several devices from older designs.  Historically we
> kept the old (block's) compatible only.  This works fine and there is no
> bug here, however guidelines expressed in
> Documentation/devicetree/bindings/writing-bindings.rst state that:
> 1. Compatibles should be specific.
> 2. We should add new compatibles in case of bugs or features.
>=20
> Add Tesla FSD compatible specific to be used with an existing fallback.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cp7g3cuaqtzc7z3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVu8D4ACgkQj4D7WH0S
/k6WcwgAnoOjaDQOULY0T9a1mZleUthBs7BZfHbzl654kG/dUyPLtgTqvHicRyzy
5XJaEwWEbpi85HooPmSwOS8gpZlJzSaojw6Ypsq7JKwEZGYc4+UyVpIwNlK26lSn
7AIAlQjVOYZd477x1pnWSpFuCT2LKSGTl3+wTZRCEICVEsuaAaa6yPFQF8zYq7sL
u5IwHfdUPCsJ0hZ8Ak2gogdw4vhl2vGI5aqcA8dFRt6XbByvRtNmVgcgF3I+DjLO
dW9wCF1NleYaKeFyVMiXNMxC8Z0Nj72X60JIY6dDv6BQn1fOzhqHjNSIyboKhhiu
QM7ZDuHdH8leR3uTw4prmiK/JsnATw==
=r1vU
-----END PGP SIGNATURE-----

--cp7g3cuaqtzc7z3g--
