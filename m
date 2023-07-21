Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABF575CDE5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjGUQPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjGUQPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:15:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C873AB2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:14:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28B9261D44
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D07EC433C7;
        Fri, 21 Jul 2023 16:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689956087;
        bh=Tp6m6Ynzv0PZqY6S2XJ0BIUu1olztmgp2bDcjXIC/Ik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KLDjXxS/KEUupMuXXBjUapvolg7EiOqJBkonnte4ZUByhqOZxr1mya2vorljCqILF
         yhR2NukquI3diHzktROs3CNWSxaVdeXXkA4UizWK4rhzoIZ/XBiONvR9BSSCVwop4H
         LDzpqxCZfGXCDNPyoMxdnycbwrsKON5miZ4a9okxoSMd+Q7KXwa20S8KGzNxLVjsPn
         yiA+igsRTQ+AG5jE5vzVjL51oJQWSnMKjicR4hFcqyzaznLWVn2QUAVzGy51TzLD3v
         6Q5d/GfQJ0flY4pHtIPyyEufnihukWHp9KPN6n73UMEd1Ypz79FXEctb52skzMeJsY
         HzHPT9oS4nQhw==
Date:   Fri, 21 Jul 2023 17:14:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [RFC PATCH 2/2] regmap: Reject fast_io regmap configurations
 with RBTREE and MAPLE caches
Message-ID: <52f21f66-96e3-4ff9-b1bf-625bdc535b42@sirena.org.uk>
References: <20230720032848.1306349-1-linux@roeck-us.net>
 <20230720032848.1306349-2-linux@roeck-us.net>
 <CGME20230721145342eucas1p12e658a54d36d985b2811e2c21f7810ee@eucas1p1.samsung.com>
 <c2bba4df-da1f-5666-89aa-28c6700575ca@samsung.com>
 <fe31bb86-40ec-4b77-9edd-eeaa61bb5e08@sirena.org.uk>
 <c9614ffb-7840-6a84-883d-ed4371d75c11@roeck-us.net>
 <205a83df-c67b-457f-a9bf-a9c6def4bb3e@sirena.org.uk>
 <1c90db79-4a1a-d3cb-5250-f30cf6b5a90c@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y5Ora18Azgbblbsy"
Content-Disposition: inline
In-Reply-To: <1c90db79-4a1a-d3cb-5250-f30cf6b5a90c@roeck-us.net>
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


--y5Ora18Azgbblbsy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 21, 2023 at 09:01:03AM -0700, Guenter Roeck wrote:
> On 7/21/23 08:13, Mark Brown wrote:

> > Yeah.  You *can* use the dynamically allocating caches safely if you
> > ensure that no new cache nodes are allocated during I/O.  I'd not
> > realised people were actually doing this.

> Ok.

> Dan, let me know if you don't have time to send a proper patch.
> I have one based on your suggestion prepared that I could send out
> if needed.

Dan sent the patch already, assuming my CI doesn't blow up unexpectedly
it should be applied tonight.

--y5Ora18Azgbblbsy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS6rvEACgkQJNaLcl1U
h9DWgwf9HKwgSix/kA8JSz+x3BXLgjXeeYOKuz4Cos8d6oDZbQOQ0pu2wnCk7b4I
+Q7qIjfFkhVeFvJN+vwMtWkKMiU/uOMAqi3PtuRIEsRolK/9i7g85HK1+/pVi6NH
Ec9wDamU7ED9L5y8VxD6JYV6wcCGp7KqX1Z+HuStIllxqcNf1T0AFC7wqR+Mq33P
cmKQMqL+n/dz1mD0S85vt7s0WFS7SDi6wtSqY7nyIiVBlUNxZiPvaej3QMpoi/t/
uNkqjq2i5lvS26SrZ+pN6Gw9fjER9XlBYkXxJUpgNyAlUFbTbbARBBppM8/dhlaP
w/gduGTZTVdSBivpvxmMr31J4tk7lA==
=90DQ
-----END PGP SIGNATURE-----

--y5Ora18Azgbblbsy--
