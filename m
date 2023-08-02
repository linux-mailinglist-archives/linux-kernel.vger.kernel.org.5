Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B6176C7D9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjHBIDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbjHBIDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:03:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F171DE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:02:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qR6ob-00014N-Je; Wed, 02 Aug 2023 10:02:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qR6oZ-000Z21-8a; Wed, 02 Aug 2023 10:02:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qR6oY-009oiE-C2; Wed, 02 Aug 2023 10:02:38 +0200
Date:   Wed, 2 Aug 2023 10:02:38 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: st: convert sti-pwm to DT schema
Message-ID: <20230802080238.d3nam6elnern65rb@pengutronix.de>
References: <20230801220559.32530-1-rgallaispou@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eqf6j4lfzsakv7hz"
Content-Disposition: inline
In-Reply-To: <20230801220559.32530-1-rgallaispou@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eqf6j4lfzsakv7hz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Aug 02, 2023 at 12:05:59AM +0200, Raphael Gallais-Pou wrote:
> +  st,capture-num-chan:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description: Number of available Capture channels.

I have the theory that nobody actually uses the capture feature and I'd
like to get rid of it. People who do use it, should better switch to the
counter driver.

I wonder if this is the opportunity to drop st,capture-num-chan. There
is no mainline user.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--eqf6j4lfzsakv7hz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTKDZ0ACgkQj4D7WH0S
/k5zTgf/YMXkn4+IaR5EJs87z5iA9g5W0naGT+tEOMy4cjKWUqo0+cox5GIingac
Llf7sagBGptLz1QaAxmDN15xttJN3UKlMAPjEqd4qoGImtKHD4BJB/h3hTws4oou
kmczBRqACrMc6dK94h5tBALgr8pSJTbS0uBTh876LUd4SOt7E87RtYW2vAt35egg
BWRYDboRuoYOgdqooovR5aMNRdF2DO1J4pj81e1QStZkmO7tLhltoIdBiAVgljpM
Vznh9oB3uAm7u8vXoXolhhxEuFvtNoN8cqRcCTkXD1NJlVAuIu/ExBN8+p0Us7eJ
9Raywx/nuKQGqlp5Hz7Sx83egthP6w==
=PiiY
-----END PGP SIGNATURE-----

--eqf6j4lfzsakv7hz--
