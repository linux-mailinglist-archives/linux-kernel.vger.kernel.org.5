Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81047AEC07
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbjIZMAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjIZMAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:00:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104C9EB;
        Tue, 26 Sep 2023 05:00:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587A3C433C7;
        Tue, 26 Sep 2023 12:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695729642;
        bh=/yLlFiYuhKy6EYECMYkjsNP2uduAHqwDcIglQN4WwtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5lYBxyscJ5T8UW4xixnUUdC0+dsTjAsPGZ/CuNmD+wuWJCBj26RRMxsaeAfffWIw
         4Unm5Yo1CitgA+o0Zg6/CBgnR06SGTHeLpN88rNR/U5MeddftfR+EKThQ0/j5lVOTQ
         zplRC0et1dxoXzzdvsz6fAFaje5wKQUq0cVnawDYmP5S7jRfe97ybU+sDK+Sr/PsrU
         AZZufERCbgkDPSAKNY3BZNLdSMy13YmFV/HQefNWRAnv+q+u2RrcqSxXt08x2EuAaQ
         QXLLAHaQgMHAhdxpB8NDcbfzxxGmZ97CIVrudkpvzdrEpXHZO04Zt35ZiRi1BgVkfx
         Pk9LYYQDYQ/kg==
Date:   Tue, 26 Sep 2023 14:00:40 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Vaishnav Achath <vaishnav.a@ti.com>, linux-spi@vger.kernel.org,
        vigneshr@ti.com, linux-kernel@vger.kernel.org, u-kumar1@ti.com
Subject: Re: [PATCH v2] spi: omap2-mcspi: Fix hardcoded reference clock
Message-ID: <ZRLH6JbEABFrfQMw@finisterre.sirena.org.uk>
References: <20230926113812.30692-1-vaishnav.a@ti.com>
 <20230926115554.4hpcgnu6wn4uurpy@dhruva>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wlaR+fo1N57A2AWz"
Content-Disposition: inline
In-Reply-To: <20230926115554.4hpcgnu6wn4uurpy@dhruva>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wlaR+fo1N57A2AWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 26, 2023 at 05:25:54PM +0530, Dhruva Gole wrote:
> On Sep 26, 2023 at 17:08:12 +0530, Vaishnav Achath wrote:

> > +	ctlr->max_speed_hz = mcspi->ref_clk_hz;
> > +	ctlr->min_speed_hz = mcspi->ref_clk_hz >> 15;

> nit: Can we improve on previous code by making 15 into a macro?

I'll queue this for CI now, please send an incremental fix for this
style issue with the constant.

--wlaR+fo1N57A2AWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUSx+cACgkQJNaLcl1U
h9Du8AgAhY4Mb0c9WCdh+HMkR9VSRtrmoaJyuvRa4/PncocVjeK81RMCBYbHI8Lj
tS+0CGQIj+/vS+R24GpjKhR4zqKageZT71xYHYVXgjyRB4n2ylX9f8lp6fMYfx/o
R/WluvJ0/Xe97pTT7AP28oDH91gKR6VmLVAHUlG68/oO2hqPO1LNpcP+L+S55hYV
NmEjLyRqNEvSneXWzdCINZBRTATOXZYWJZbOJU6wp5WVNUOS4npJj9myoCrOg4vD
F6ic3PA67ygAo6kW6CPdoYrFn+Sz/MY39v2fto1yNzVtBw5M9deqwgYuVVInJ2kB
9LlWrbPtw4jT2iAfcGizNt5g+CuwsQ==
=U3go
-----END PGP SIGNATURE-----

--wlaR+fo1N57A2AWz--
