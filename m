Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0E0751C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjGMJD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbjGMJC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:02:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9091BF4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:02:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJsDZ-0004Hj-Dl; Thu, 13 Jul 2023 11:02:33 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJsDX-00E4qI-So; Thu, 13 Jul 2023 11:02:31 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJsDW-004WGM-Om; Thu, 13 Jul 2023 11:02:30 +0200
Date:   Thu, 13 Jul 2023 11:02:30 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/58] mmc: dw_mmc: exynos: Convert to platform remove
 callback returning void
Message-ID: <20230713090230.iwhicjbirll5icec@pengutronix.de>
References: <20230713080807.69999-1-frank.li@vivo.com>
 <20230713080807.69999-14-frank.li@vivo.com>
 <75d2dc5e-4cbf-2519-cdf7-8fde374126ec@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d6d7itv6cdabafnt"
Content-Disposition: inline
In-Reply-To: <75d2dc5e-4cbf-2519-cdf7-8fde374126ec@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6d7itv6cdabafnt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 10:11:15AM +0200, Krzysztof Kozlowski wrote:
> On 13/07/2023 10:07, Yangtao Li wrote:
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code. However the value returned is (mostly) ignored
> > and this typically results in resource leaks. To improve here there is a
> > quest to make the remove callback return void. In the first step of this
> > quest all drivers are converted to .remove_new() which already returns
> > void.
> >=20
> > Trivially convert this driver from always returning zero in the remove
> > callback to the void returning variant.
>=20
> You even copied Uwe's commit msg... Aren't you duplicate his work or is
> it being coordinated?

We communicated and I politely asked to not interfer. This series is
just what Yangtao had still pending. That's fine for me.

Thanks for noticing,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--d6d7itv6cdabafnt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSvvaUACgkQj4D7WH0S
/k48vgf7B9pOCj8BEtBTeW/UjDXpN6Ydodk3PjPhDksAVMx3pfZiUm43bOVMgD/G
30npFfBBlwWgCrzx3XoBoJ2qFYHoq+pjTlH1EZcipdXN3/AONF5YUQ/OR3+CnwZd
CWFxvF6RFK/LwkErVlFsrF6WBHpSkJ14lfMvSkAIPtOZ3JoykZtHd+D3YsQJvceS
rikOZOHI3LJEKOmAPtfRNk+PjEfERw0T+2+/JiLIe4Cip7GZ2vOz5K+2YXRWHeRy
8vgSXOKRfegphqtSuE0qQxMrTafPsKsck4OKS5U8PC+ebYaW/MUwWTiU45RBiMiz
QqeKHVZV1Vp2TKVzQSkDkGgoNkxFOw==
=XV+K
-----END PGP SIGNATURE-----

--d6d7itv6cdabafnt--
