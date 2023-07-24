Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6119575F7E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjGXNLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXNLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:11:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67184C6;
        Mon, 24 Jul 2023 06:11:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 022606115B;
        Mon, 24 Jul 2023 13:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF83DC433C8;
        Mon, 24 Jul 2023 13:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690204265;
        bh=YjJlTY1pKMB9FfrkO75nHA3/x0kYhk1ZjY0oocFIbWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tGcTy0vObwsbyfCNQgm66Pc4lebeQYW6RnHeANdXRbCsWVM4TQ5dpkk/k7We4Q49P
         q6zGsrmts4XUeiqCLNR43zzIOLGjd3vV3Wrz5F2nUAD8GFuV2IyJdHMeLi9StTJ4uK
         jijJFAEwb+tEsyztsBchvMWGMozvjkkWnxivrJUfHEx5am+3/7sZlBuY7dKB7F+Z+7
         ghhpaacuP1nep9Fw/oIeOYeJ4TZaVHkV8UzDn1bbppkPkt/8JMBteFWqgnVtBgF1ww
         j8bnKyjegVHd6S/cAaGnefyUjZhVwNSBfGK9kCKFRcjzcnETXRgrZWVaQUtUVg7aD0
         vT4ZCxNzo/FyA==
Date:   Mon, 24 Jul 2023 14:11:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <43862e72-eeb2-4670-8cd6-0e334044583d@sirena.org.uk>
References: <20230713121627.17990c86@canb.auug.org.au>
 <ZK/ruOD4QFPQ3Q5q@smile.fi.intel.com>
 <ZK/w5LFanElxZazG@smile.fi.intel.com>
 <ZLES/6iNcmR7H+f7@smile.fi.intel.com>
 <20230724135858.3c1abb01@canb.auug.org.au>
 <ZL410jAw2ksuBx56@smile.fi.intel.com>
 <cbff36d5-cde7-43bd-b0d5-ede8950fd885@sirena.org.uk>
 <ZL53HkIWuE4byo+R@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="grxtHfRk6t/sHSNy"
Content-Disposition: inline
In-Reply-To: <ZL53HkIWuE4byo+R@smile.fi.intel.com>
X-Cookie: Please go away.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--grxtHfRk6t/sHSNy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 24, 2023 at 04:05:34PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 24, 2023 at 01:36:53PM +0100, Mark Brown wrote:

> > Jon's usually fairly responsive, perhaps there's something worrying
> > there,

> Hmm... maybe my understanding of the :export: is wrong? Or what do you suggest?

I have no idea what any of that is doing.  I'm hoping Jon does.

> > though I do note you only sent it a bit more than a week ago.

> I fully aware of that and you can see that this reply has been induced by
> the ping from Stephen.

Sure, but that means that it's possible he's just not got round to it
yet rather than that there's a problem.

--grxtHfRk6t/sHSNy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS+eGQACgkQJNaLcl1U
h9B5IQf+LGzWPflmK7aQKUcZzp+6yHCq/wH1eYJjFlzEc7cDkZOT7YbVqBCETSUv
ydrZTskK6AW5C54ubBxwoc4UDSrh5OK0RzSlKY6GSRME9U7I3GI0Hzkb7Mbi5QP8
afFfQ3D9BZprgMzDqR+FDrYIpdLTsgxasGdsL6LJMg89O2Dm0hmq400BH2KyBxvR
RbN3+HVr/N2FZI9dgqkaYVf+VbjdyZjPoSsLjWxK23Pcop76UnD9iK5VmDJD11/u
KJbcK1RlkzJvi7nYSoVBhcSeOLuKjCC4S/cje9fFnk1SH+vchTpUNg8VHOM8vGNR
0y6P7/dKSDOCPrArzwt2RzA+Xxzs8Q==
=cbDd
-----END PGP SIGNATURE-----

--grxtHfRk6t/sHSNy--
