Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4847A76D6B4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjHBSUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjHBST6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:19:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814ED1FC2;
        Wed,  2 Aug 2023 11:19:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 172D261A88;
        Wed,  2 Aug 2023 18:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADBFC433C8;
        Wed,  2 Aug 2023 18:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691000396;
        bh=2mY6RWsid4MKxODez7iIsenojC64trTIG4Y5LLPdYRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gyRrIVt8EH9ix5L/EA/uYiTRQ/fdg9/fdoYbDvRD2oM4YfuZwhxpUAG6li80w+7pa
         piQQYRdS4fQPkqlLZB/R619xQZPmwh8xFs0mMD0t3JURPZ0A7J08p13lPmQ2L5/J5G
         DUV1FgERFKmi5dynVloIcwTiK9Uu9zpO6rMjr3AX/aW4ZwKcrIecJftQ5iMMbuHJx6
         04uOE2TONKBclmoseHrAqdMEGNHMWKTsw3VRLnZOYEEco6cQT98ZGlHlYvC/3cvNRS
         N6Gj+50yrrTL02dG8X+ObUWYr0Z+GpFLbb6S7NmJ4PSQag68now7dSo5140Jd5g/sC
         vsUcY/6slGKZg==
Date:   Wed, 2 Aug 2023 19:19:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Tony Lindgren <tony@atomide.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v5 3/3] serial: core: Fix serial core controller port
 name to show controller id
Message-ID: <ca09d15f-50ab-452c-a3d5-f2b4cde6426f@sirena.org.uk>
References: <20230725054216.45696-4-tony@atomide.com>
 <202308021529.35b3ad6c-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FtSNUiXiugn7UOqY"
Content-Disposition: inline
In-Reply-To: <202308021529.35b3ad6c-oliver.sang@intel.com>
X-Cookie: Your present plans will be successful.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FtSNUiXiugn7UOqY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 04:15:28PM +0800, kernel test robot wrote:

> kernel test robot noticed machine hang on:

> commit: 4de64f4800a581e7eeba6392b3b2ce2131195145 ("[PATCH v5 3/3] serial:=
 core: Fix serial core controller port name to show controller id")
> url: https://github.com/intel-lab-lkp/linux/commits/Tony-Lindgren/serial-=
core-Controller-id-cannot-be-negative/20230725-134452
> base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git tty-tes=
ting
> patch link: https://lore.kernel.org/all/20230725054216.45696-4-tony@atomi=
de.com/
> patch subject: [PATCH v5 3/3] serial: core: Fix serial core controller po=
rt name to show controller id
>=20
> in testcase: boot
>=20
> compiler: gcc-12
> test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10G=
Hz (Cascade Lake) with 512G memory

I've also bisected this commit as causing boot hangs on at least the
i.MX8MP-EVK, though most of the boards in my lab and a huge swathe of
those in KernelCI are out:

   https://linux.kernelci.org/test/job/next/branch/master/kernel/next-20230=
802/plan/baseline/

which is having a pretty devastating effect on -next testing.

--FtSNUiXiugn7UOqY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTKnkUACgkQJNaLcl1U
h9BxCwf/fQzBjT6EzjqGQzPFRwTJ/05CYpVVA9bJWr4oG+ZDO1T9djXWj0tbuvc4
lx2MWX+kIKF2T2BxSU7WORpy0TRvXZn2x0/wahnAt4dOnt18Y48seKNA8iW9P3Vs
+S23UT+CTkNjHb19/5frPcYgfZwFcF9KJxmRHrkVjPTq24TGDmF59xWhj6Zm1Dej
fCltnbwBHSL34KThMXcLcp7/SjJdDc1leDneDqsNpIaTb1Um1uvEsP6KWgot60aD
XvwHZRaEGGszxsXO+hQp1ieYv+1FcnbuXe/ojdsBSCYwPL3tIqywYuyuCpaq/uOp
1Ur30i38ymeKThvgXlKUKwyYLDtGoQ==
=crqL
-----END PGP SIGNATURE-----

--FtSNUiXiugn7UOqY--
