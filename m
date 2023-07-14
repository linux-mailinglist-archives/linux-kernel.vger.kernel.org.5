Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172FE75438D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 22:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbjGNUCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 16:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjGNUCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:02:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C99E5C;
        Fri, 14 Jul 2023 13:02:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB5A261DE6;
        Fri, 14 Jul 2023 20:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD564C433C8;
        Fri, 14 Jul 2023 20:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689364937;
        bh=UT9j9q6/BWfR67FxkI+ij2KTzELof0exJwjKYHRs4R8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YcBccN58eI766HtMQ2IQlB0kW1JvkiwsS5clOvALgM0UWC3MdI/3E5p+ACpxkHNQO
         wYpxnKfUwZfM1qWLFdxScfAXt40ygyI+xRoOhsOOMA0UaRJYmVvQqMy+bwixSC3bao
         19NUWX93HpVfXCXgnwZrNY4YqDvo7j7iBnaRnFKsse583R/hdW8UjXgCL8TNwJ/84U
         WHvuC8iw+hx52up83YpirfblY1ButPG7w0SM/EiGNWC7c26iRdHX5C1X2JaeZItxza
         PM7T2vItZzdSVitXTJTHHWyFuq9dJbgKxQatEYyROvSIrtdfAumRWioqrZhwvR7q0c
         iipeLmo15v5BQ==
Date:   Fri, 14 Jul 2023 21:02:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>, corbet@lwn.net,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH docs] docs: maintainer: document expectations of small
 time maintainers
Message-ID: <a5fcc05c-3549-491e-b28f-68ceedceb75e@sirena.org.uk>
References: <20230713223432.1501133-1-kuba@kernel.org>
 <f61a12c6-9587-9cb4-122e-dc3a74e58bd1@leemhuis.info>
 <20230714102218.687ee2ea@kernel.org>
 <a7d0381c-c99e-4dba-9156-cc07a86bdc39@sirena.org.uk>
 <20230714113418.49dfac7e@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZMGLOwCUDl6aLp+8"
Content-Disposition: inline
In-Reply-To: <20230714113418.49dfac7e@kernel.org>
X-Cookie: Preserve the old, but know the new.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZMGLOwCUDl6aLp+8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 11:34:18AM -0700, Jakub Kicinski wrote:
> On Fri, 14 Jul 2023 18:59:08 +0100 Mark Brown wrote:
> > > If we try to fend off anyone who doesn't understand common meaning=20
> > > of words the document will be very long and painful to read. =20

> > That's true, but "bug" is one of those things where there is a frequent
> > disconnect on definitions, and when coupled with the must respond bit I
> > can see things going wrong.

=2E..

> But we can't expect from the user to know if the problem is stable
> material, or even whether their problem is a bug in the first place.
> Simple example - WiFi cards which don't support AP mode. User may try
> to run an AP, and report it doesn't work. They may not know whether
> it's HW limitation or a bug. The maintainer responding with "it's not
> supported, sorry" does not seem to me to be a high bar.

Sure, there's cases where it's really clear and people ought to reply
but there's other things especially as you get into the automated
reports - for things like the fuzzers with automated reports and
sometimes janky bisection it's a lot more reasonable to just drop them
on the floor.

> Just in case someone thought that maintainers are their tech support.
> Then again, I don't want to completely exclude technical questions which
> aren't straight up crashes because some of those are reasonable, should
> be answered or even result in improving docs or error reporting.

> It's a balancing act :(

Honestly I think a lot of it is the "must" rather than "should", it
comes over as being a bit inflexible.

--ZMGLOwCUDl6aLp+8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSxqcMACgkQJNaLcl1U
h9BaWQf+ISEPJQXevs7v9RaLSpGDfpwmrHXZ2yL/97jE8US6G50yCCTI2pnHwDKA
kO9VWuxFj/ZQMx8xrbVJTGmQ3YlohH+s6a6obkVoRb+qSP68Sw0ekiG6b2Yv1gip
/RTHQ1rsigv+yFKd+n1n7tTKA8QLzHVJNlAN06Y8drdnNEGtyn+xMB2S3DQY1onb
u/BgR4frCSl+BIIvfeTPHA5SeE1/Adpjir/0wZMO0s8W2K1fCVNVtQCsT+fEAn2L
3qNYAjZIcCNTR1de44QGNY88zKYWQwTalrkTMYvxqmO/HlvhzeedwZIzsaHkjTQJ
vfzjMPbVZ5ff/SuzBO8bxhf50YyYQw==
=yOvy
-----END PGP SIGNATURE-----

--ZMGLOwCUDl6aLp+8--
