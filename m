Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639B87CBFBA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbjJQJmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjJQJm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:42:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A91100
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:42:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qsgah-0000U7-CE; Tue, 17 Oct 2023 11:42:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qsgag-002HtD-5K; Tue, 17 Oct 2023 11:42:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qsgaf-000AKh-SC; Tue, 17 Oct 2023 11:42:17 +0200
Date:   Tue, 17 Oct 2023 11:42:17 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the samsung-krzk tree
Message-ID: <20231017094217.vwz5vfmqsbfvi3ua@pengutronix.de>
References: <20231017110118.3712e78e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="slm22x6xvwckr345"
Content-Disposition: inline
In-Reply-To: <20231017110118.3712e78e@canb.auug.org.au>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--slm22x6xvwckr345
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Oct 17, 2023 at 11:01:18AM +1100, Stephen Rothwell wrote:
> The following commit is also in the arm-soc tree as a different commit
> (but the same patch):
>=20
>   0da7c05d232d ("soc: samsung: exynos-chipid: Convert to platform remove =
callback returning void")
>=20
> This is commit
>=20
>   55fa358ca89f ("soc: samsung: exynos-chipid: Convert to platform remove =
callback returning void")
>=20
> in the arm-soc tree.

a few more details that I worked out for this situation, so (hopefully)
others don't have to duplicate this effort:

The commit in the samsung-krzk tree was applied by Krzysztof at Sep 28
and sent later (Oct 16) as a patch to Arnd (and others) in reply to a PR
(https://lore.kernel.org/all/20231016072911.27148-1-krzysztof.kozlowski@lin=
aro.org/)
and without further explanation.

My guess is that the patch in question wasn't applied to a topic branch
but to Krzysztof's for-next directly and so was missed to be included in
the PR. Or it was on a topic branch but as the only patch on that and so
it was sent out individually. I'd expect that 0da7c05d232d won't make it
into the mainline.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--slm22x6xvwckr345
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUuVvgACgkQj4D7WH0S
/k4OMggArFtYagFh1156QdoHQyQjATaHnW7oc3Vfp3bY+ZcUiUvR2PE6jglceuc1
delEwOVa6cvJz0wpd1+e/2hqQwXFYWO2ZABVFh2ezNuWm1pQOWVzufPFYHgDU8Q1
Holn8CfiL7eLOa9l+A8ESwSVpn8oLzEwTF2hgX6L65Ms3tilAlH3J2rOyFkxx1KR
Kxg16UvZ7v0T1FOMqJx+OW+7kvk90tUfhg+q5qM8Jjka85K7y1lTCOYTZS9syYTW
r8mg3GCoNtf56Xoar7SQi3LJ8pw5lAKg8QhHpsS41LrxZD9oUkO78VEAT027dggH
dMIGINXRYENJoLGDcIeiE57keYs/1Q==
=98Ju
-----END PGP SIGNATURE-----

--slm22x6xvwckr345--
