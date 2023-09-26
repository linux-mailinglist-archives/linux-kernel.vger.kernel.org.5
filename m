Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6207F7AED30
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbjIZMsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjIZMsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:48:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCF59F;
        Tue, 26 Sep 2023 05:48:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D1BC433C7;
        Tue, 26 Sep 2023 12:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695732510;
        bh=KZMQWNVIuax7Wlh86L+MzuOV8fgqYYBNlK7DfVfqPdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cROrY4GycJmb6gp+Id3adfPD4B081HYGqiZXt21oMoQMZ8qsa/k0M8JM96tqcKzLs
         1v1KIXfEEaBFqOJR0ie6V84V6Nn+/QfzHhEofVaF+pAkkzfpo60q/MX91Ipxw3FeuM
         73w6vbI16eDyGYVhUFNbxvLwXZY7Hs5QE92brbMoPYJoIRE6FXPsed9PwiAUCpf0ne
         gRnLCDPpkVNLQKLN3QmRT67b9r5ZAopuqDyK3dRbElt1sqgr9mojMaURFJCw5qVQh0
         jtxXeJ2z8Tz/hQF3BIGmjHAsghJPnhI+q+H2DHEjC0FCaCdunRkdSP9jB3tZwkTV5i
         hMsGCGet5fHTA==
Date:   Tue, 26 Sep 2023 14:48:27 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH V2] spi: spi-cadence-quadspi: Fix missing unwind goto
 warnings
Message-ID: <ZRLTG4pogXW5FTgJ@finisterre.sirena.org.uk>
References: <20230919074658.41666-1-d-gole@ti.com>
 <ZRK+oDrT4vaZ0R/G@finisterre.sirena.org.uk>
 <20230926114046.5ukretunoud3yv45@dhruva>
 <ZRLHVReL9Bq4PNvS@finisterre.sirena.org.uk>
 <20230926121908.mcyyj42buqr4ov3m@dhruva>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mj78KMmgqMWE5ALb"
Content-Disposition: inline
In-Reply-To: <20230926121908.mcyyj42buqr4ov3m@dhruva>
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


--mj78KMmgqMWE5ALb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 26, 2023 at 05:49:08PM +0530, Dhruva Gole wrote:

> Umm I don't think the commit being fixed is there in 6.6?
> I am not really sure how I should base/format the patch? Please can you
> tell me what's expected in such a case ideally?

Including a full 12 character commit hash would help with matching,
there were only 10 there.  Not mix'n'matching Link:/Close: with links in
the body of the commit message would help as well.

--mj78KMmgqMWE5ALb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUS0xsACgkQJNaLcl1U
h9AuGAf/WhUmEmpl3HYuZJHXC8QYrYJc4tJscENSwDqJ/zeMcsjNutiMcsgHpuCN
HG+tbjEHVYfkNjaPw/YZ0T/xIX4QhzYBeapi1td9iFq9hNkSbOe2kcjdzXg5ofWD
mk2G4ZU0duSfAKVVqSACRSjfCp+18vJ6If5ZmUvgIU8Mzao8bGTCjlz+1Zzv9fYk
mfN+eiA0xEQYYrRIqsh//VUGgcP/ifZ8u1/qV3h7ImojIKf0k5x9Gvkdv/aBEa60
KJwU/KmK3i87QmADEm1Sj0zv0Rmrece4ut6ZWsk2C4DlJd3m3abFfmWi3syRN5Er
3wBR1ctFRgPLr5GkHbrpiQ/jPqNTwQ==
=QWxD
-----END PGP SIGNATURE-----

--mj78KMmgqMWE5ALb--
