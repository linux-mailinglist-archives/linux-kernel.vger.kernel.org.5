Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49C3801167
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378170AbjLAQXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjLAQXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:23:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBE999
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:23:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57517C433C9;
        Fri,  1 Dec 2023 16:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701447790;
        bh=VqD6tqAKvBli0h35Lj6ytxi1kUwFp8UhPyDk4jHxCVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zn6nBJb88f438PDuNJ2l8qSmfontxShAiF6h1RwXvJ7Q60gMerp/4QmQpqNNvmFEd
         q+r5m4IAcYgnodZUUIzO+PcIpEBlO5smp4dS0GGGlJWLVBvwzkXinFTHV4nxkGyRch
         iwD0lTtYmlZ0PwvJR4+QnDXMnkwa/OSY0rgSR3qMDH42od2ijJrvUxvBn/kdMQ8aaE
         bj0IeTRCjS4+0ABevO6F//NRmMI1vr71mF97PLV2ezUnBcDxU52nCrQc8+JVT79LTg
         IYNKXxCNW8GMZcXDq7Sx4MaLfckZMjGRFRUeMlci0jQTB3jFnLelcp+5z5iSFiBR3I
         0TxAdNDAAW4+w==
Date:   Fri, 1 Dec 2023 16:23:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: max310x: work around regmap->regcache data
 corruption
Message-ID: <6986fb70-bc99-4210-a622-16f0d0303d27@sirena.org.uk>
References: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
 <CAHp75VcRQ6UaBbS4fWZhShEdFyd2NL1qWszkgrXBC-APJmg8tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qdnQx0uLPm9zl6Yh"
Content-Disposition: inline
In-Reply-To: <CAHp75VcRQ6UaBbS4fWZhShEdFyd2NL1qWszkgrXBC-APJmg8tw@mail.gmail.com>
X-Cookie: The early worm gets the late bird.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qdnQx0uLPm9zl6Yh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 01, 2023 at 06:14:02PM +0200, Andy Shevchenko wrote:

> > +       };
> > +       spi_sync_transfer(to_spi_device(port->dev), xfer, ARRAY_SIZE(xfer));

> Can you add a comment like FIXME explaining why regmap is not used
> here, otherwise I will expect some clever guy to "fix" this again.

Or just do the fix in the right place rather than throwing a bodge
about...

--qdnQx0uLPm9zl6Yh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVqCGkACgkQJNaLcl1U
h9Dtqwf/T8oP4v0AyPIKO1zvOA+lyfyHC9EWOqm1zbfbKYha19ktbkao6KGFdodN
61bbwqOhNGeQ0JdyStJZsYAep4253CjTZ1yfTI5KhB17w1+JGVCxio7wAibun4le
TTNJ3WsJvFBZMw9IsFfycyzUBm5YJ63jZefVmoBXyW7o48XYJw3YlhRY5BSxENYZ
+xROEb9n/gEOcmSdL6Cwts2AkBnBgi2bMsVFJ0oBSXus8SwjzsEReWjtSlwTFI7S
YuaAgciYaqPIbbfM4Lo5DWJ1vUfmK4DgN9Dxc2q9gIROidRekmvaU8D1BvKoPmz4
P2HHb61PkD301vrZ2Nza0Wn7qW/5Cg==
=0qNi
-----END PGP SIGNATURE-----

--qdnQx0uLPm9zl6Yh--
