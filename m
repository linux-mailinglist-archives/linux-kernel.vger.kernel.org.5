Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0677F7820
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345869AbjKXPtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345714AbjKXPtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:49:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8585D1B5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:49:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C290C433C7;
        Fri, 24 Nov 2023 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700840989;
        bh=DPNUXFZ8krOO/zfEH0Ax/h+VZrud73hwWU+1GlI2Zx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WGurvF6Xgz485nbzHx9vsGClmcTs/4jSifsESVXcUgqmw9LZS5u4JEF9q91I8SXwP
         yxygxoluR1o6UohVbHFTqshFBC5LQEZvG0jXhN/966FkDcFLQQcJewP7ZHWjCajPcg
         Re/VdJHs6rx9LUYHAe9g6X1Gic/N/ojQaBbnPAw41DKd/TGHr9+CoDZU7s4/7+x9vl
         oc7ajP0Gdbe7lyS9Y1Ltf7640L76d6IP2mc1eFHIMXs/YWXDiDiwm02Ls0rQTwuJi3
         rF5Am2fGMI9G7QSmg76ivbqvK65HO6oBlG2z+VT356tewXXi0SMkOiFn84rDll0a2D
         SLqXQEdsOSPuA==
Date:   Fri, 24 Nov 2023 15:49:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <ZWDGGqsCq9iSnHtO@finisterre.sirena.org.uk>
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
 <2023112403-laxative-lustiness-6a7f@gregkh>
 <ZWC/hKav0JANhWKM@finisterre.sirena.org.uk>
 <2023112458-stature-commuting-c66f@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6939kKTjmQm/xsgi"
Content-Disposition: inline
In-Reply-To: <2023112458-stature-commuting-c66f@gregkh>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6939kKTjmQm/xsgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 24, 2023 at 03:27:48PM +0000, Greg Kroah-Hartman wrote:
> On Fri, Nov 24, 2023 at 03:21:40PM +0000, Mark Brown wrote:

> > This came out of some discussions about trying to handle emergency power
> > failure notifications.

> I'm sorry, but I don't know what that means.  Are you saying that the
> kernel is now going to try to provide a hard guarantee that some devices
> are going to be shut down in X number of seconds when asked?  If so, why
> not do this in userspace?

No, it was initially (or when I initially saw it anyway) handling of
notifications from regulators that they're in trouble and we have some
small amount of time to do anything we might want to do about it before
we expire.

--6939kKTjmQm/xsgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVgxhkACgkQJNaLcl1U
h9DHEwf/URLyuQsQNf8uufQIJEo3j+d7jM8LtXL5oRAPKTnE83+rtwxOtLMGUqwr
+ZwgTGJyPFNVx9fAj5hYLf43uOpGsaJFXuDeIFxg6N3VxOjCwE9NFysnbfVhdM4n
OOLNjh+xJvurdOYyOjEfXVAzG3LzuPnr1oDv4YEsdpxg1o8Mk8RCtnFPAwfTftZF
9bMuS4LhIP5pa7mKCS2x8cB/skT7YUVxWZQ7zFTyMTslPDkriWmHu/au6u0Q61tC
jX32e5ef0nyb51z4oIYsOh1qSndAUr3Cyfv17BgxDM4NPujvGfL+FAuPdEILTXZn
pUsfQrkuZFORZg/dJvKmTltQbIThNA==
=o4Vm
-----END PGP SIGNATURE-----

--6939kKTjmQm/xsgi--
