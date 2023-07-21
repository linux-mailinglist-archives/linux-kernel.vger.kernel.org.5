Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F7375CB28
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjGUPNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjGUPNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:13:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8642733
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:13:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 684AB61C5B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F97C433C8;
        Fri, 21 Jul 2023 15:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689952418;
        bh=b33sDAISkKV45WBEX5IzlIU/TjTS8gTHgqCN2HMCJ1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X5x1zqYUlFeJQgBW14/FU/BH5BY6Z8FahtYXhYpCV+yrsl6GOPj37FPHX1DNqt8rG
         NrmPi+JUSk+okxxJeGLkoV7duC/S+AalncspSPAep/ZUYCCFh0dokU6uyTs7fE4w2r
         dQa4sK6WZ5us3RnkR09u1ExVBeexW8WU+rdJdBjDnCwf72+eLZeCpTg5KVANZwrtFw
         5aGpZucnNTCg4T5AjT3awfcbDSoZmJTOV7/2hUORUPP5BNg+ySyPfC8wMonmKqPeum
         mgTHS1ONhEzly+3Mk6ZWjUwBE3PVbscsltaOnwctLw4YdLWCxvSYc9Zxsd0JVDDoDH
         /Ye0R0Kc7EqmA==
Date:   Fri, 21 Jul 2023 16:13:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [RFC PATCH 2/2] regmap: Reject fast_io regmap configurations
 with RBTREE and MAPLE caches
Message-ID: <205a83df-c67b-457f-a9bf-a9c6def4bb3e@sirena.org.uk>
References: <20230720032848.1306349-1-linux@roeck-us.net>
 <20230720032848.1306349-2-linux@roeck-us.net>
 <CGME20230721145342eucas1p12e658a54d36d985b2811e2c21f7810ee@eucas1p1.samsung.com>
 <c2bba4df-da1f-5666-89aa-28c6700575ca@samsung.com>
 <fe31bb86-40ec-4b77-9edd-eeaa61bb5e08@sirena.org.uk>
 <c9614ffb-7840-6a84-883d-ed4371d75c11@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MvLmq+n55EGfR3CH"
Content-Disposition: inline
In-Reply-To: <c9614ffb-7840-6a84-883d-ed4371d75c11@roeck-us.net>
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


--MvLmq+n55EGfR3CH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 21, 2023 at 08:07:28AM -0700, Guenter Roeck wrote:
> On 7/21/23 08:03, Mark Brown wrote:

> > Actually Guenter and Dan have made the required updates to support this
> > so the warning will be gone soon (hopefully Dan will send his patch
> > properly shortly).

> Do you plan to revert this patch ? If not regmap_init() would still fail
> for the affected drivers, even after my and Dan's patches have been applied.

Yeah.  You *can* use the dynamically allocating caches safely if you
ensure that no new cache nodes are allocated during I/O.  I'd not
realised people were actually doing this.

--MvLmq+n55EGfR3CH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS6oJwACgkQJNaLcl1U
h9C2ZQf/SeZqv8XIiU1U2sg8EbxhVckHThG0e9cFL7zfYTG8LUV4IFgLGOUejX29
+/Ujqt+3kfeb31VqLKjBMudpvYSKl8WAofq1zaNCJwVzZj9azZeZIdDSM5LHcMfq
Uek47AlWQWTY1ZkS2dNY02KB0SnSv/3wCNkV2O41n9OpSle3McC0FHCJzD4K19Tp
z2XYic3KnoJEgshPGmOt3z1rqqtTjjXTLwNkDxWBJqJduV+Ml5vCUd02LqD2/j7X
ZgYyyCl7GtHXhtOHpBCTQz3M1vDSAlOafTDQSlX54849DYIbMtb4k3yqRGBggKoh
wjsRzQkyBUgNcgEIRjmAkhEZLXDY4g==
=ELvA
-----END PGP SIGNATURE-----

--MvLmq+n55EGfR3CH--
