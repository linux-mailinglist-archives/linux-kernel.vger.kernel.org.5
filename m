Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B85783E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjHVKnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjHVKnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:43:13 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2A4198;
        Tue, 22 Aug 2023 03:43:10 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id DA8491C000B; Tue, 22 Aug 2023 12:43:08 +0200 (CEST)
Date:   Tue, 22 Aug 2023 12:43:08 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        rafael@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.4 18/54] thermal: core: constify params in
 thermal_zone_device_register
Message-ID: <ZOSRPJxpVfCiyUWb@duo.ucw.cz>
References: <20230813154934.1067569-1-sashal@kernel.org>
 <20230813154934.1067569-18-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1xaNy7ZXwp7ZgfS1"
Content-Disposition: inline
In-Reply-To: <20230813154934.1067569-18-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1xaNy7ZXwp7ZgfS1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 80ddce5f2dbd0e83eadc9f9d373439180d599fe5 ]
>=20
> Since commit 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone
> parameters structure"), thermal_zone_device_register() allocates a copy
> of the tzp argument and callers need not explicitly manage its lifetime.
>=20
> This means the function no longer cares about the parameter being
> mutable, so constify it.
>=20
> No functional change.

Not a bugfix, should not be in stable.

3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone
parameters structure") is not in 6.1, so this is not correct patch for
6.1.

Why was this selected for AUTOSEL? Can you make sure patches marked
"No functional change." are not selected in future?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--1xaNy7ZXwp7ZgfS1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZOSRPAAKCRAw5/Bqldv6
8n+/AJ9bC7UNEM8hdwrPGg29kHY6XOaceACgwNExJs5qnKVG5LqwN0sgmmmsWJQ=
=+ETA
-----END PGP SIGNATURE-----

--1xaNy7ZXwp7ZgfS1--
