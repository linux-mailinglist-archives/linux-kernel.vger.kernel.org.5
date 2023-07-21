Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FF175CEF6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjGUQ0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjGUQ0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:26:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C853ABF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:22:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29D1B61D34
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3C0C433C7;
        Fri, 21 Jul 2023 16:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689956563;
        bh=57/7gKphzxTLf7vAFlilksQSzLFJ170eDAIN3ZR4eVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qe1AP4YfjQrqFLh6Qjlov794qoKRJ7HFIntro44/zrpMk6HdakJqJUQrKlWPyWAvP
         iPqBh1YrIjSBjRzDCPoLXJd6JuJpRK7Xa2Akv2nqT5V+IogtLd8180mPecbt2OWOYH
         9Q68tFJqgpMIQV74YivD1IVSL+yCh0iHOjpAIFAREmehVKgySCHjLZTKqbQUc3GvQC
         fTKG0Pbxtxpa0nlRU8ZAIF/DylUVGRY4osvmWYhkpZ/5+x2O1eZwFTrAcEqShR10em
         qt3oYXTLoexMgh7rxZzDtRLNHwo3J2zxM3oposO4/LN+MpVs0s+l+3+ISmacPYMVH4
         3FYU5hi/3QFxw==
Date:   Fri, 21 Jul 2023 17:22:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [RFC PATCH 2/2] regmap: Reject fast_io regmap configurations
 with RBTREE and MAPLE caches
Message-ID: <66c4e1ca-7b76-4611-8627-994a924f5e6f@sirena.org.uk>
References: <20230720032848.1306349-1-linux@roeck-us.net>
 <20230720032848.1306349-2-linux@roeck-us.net>
 <CGME20230721145342eucas1p12e658a54d36d985b2811e2c21f7810ee@eucas1p1.samsung.com>
 <c2bba4df-da1f-5666-89aa-28c6700575ca@samsung.com>
 <fe31bb86-40ec-4b77-9edd-eeaa61bb5e08@sirena.org.uk>
 <c9614ffb-7840-6a84-883d-ed4371d75c11@roeck-us.net>
 <205a83df-c67b-457f-a9bf-a9c6def4bb3e@sirena.org.uk>
 <1c90db79-4a1a-d3cb-5250-f30cf6b5a90c@roeck-us.net>
 <e61ebbfd-98d2-4dad-98e7-67d81c0cc04e@kadam.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="km90a0rdseyGaDyW"
Content-Disposition: inline
In-Reply-To: <e61ebbfd-98d2-4dad-98e7-67d81c0cc04e@kadam.mountain>
X-Cookie: Do, or do not
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--km90a0rdseyGaDyW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 21, 2023 at 07:18:03PM +0300, Dan Carpenter wrote:
> On Fri, Jul 21, 2023 at 09:01:03AM -0700, Guenter Roeck wrote:

> > Dan, let me know if you don't have time to send a proper patch.
> > I have one based on your suggestion prepared that I could send out
> > if needed.

> I sent it but, aww crud, I forgot to CC you.  Really, get_maintainer.pl
> should add everyone from the tag section to the CC list...

b4 prep --auto-to-cc does that IIRC!

--km90a0rdseyGaDyW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS6sM0ACgkQJNaLcl1U
h9DKrwf+KDdIBnn2bGLmUILiQnwPyx+HKGZb/6VY7kRDdeigO7PRNgdl0I1jWmwU
1apKIDqWPWZiA0GI5cP/Jd8rlmp1IYnHCg40XeMqOX2XZXjMIiHNLcpnbO+5lGOh
yTqWENvQqSuSLrmYhDgf6x03cA4d5Itm4ln3nKG0MeLot7GIYKrmLYMiFvZ7pNbV
/aEDai71tcB/iTkcQeN8HcYLH68q5y2KV4v+FLp3R3x5/ctIiHO/ekVYwj2mXPi7
6Cm++nXEMLknjKVurFJu9ijGNOZGUGMPBS/k3ixClQuGJNChwoP3QaApTUr/GFOT
4tTBF4ZSQ6GqFi6GTRAHNtcIYdixsQ==
=duhz
-----END PGP SIGNATURE-----

--km90a0rdseyGaDyW--
