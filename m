Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08AD75F670
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjGXMhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjGXMg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:36:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD7EE73;
        Mon, 24 Jul 2023 05:36:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FD2561138;
        Mon, 24 Jul 2023 12:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52267C433C8;
        Mon, 24 Jul 2023 12:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690202217;
        bh=88ZFk3sffyyY2UqISSAC8BtMuczRxt634akmlI6tswc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VsTUcYr6M6KZbWHpmSybSF2kiPASwGO9O/Da6Xt4PAdEOol8DxeuoASHA87SNSgnp
         AdqGdiW+QrNszQbSWQITXh0N7o1O3SNkVkWLKQSFIwuKZOoy8RCI5L4CLoHhH0H1If
         SvntMHGkld106u7dkAVdjqfQRmxP+8hS/Cy+1uo5uHOeZ0UdCJAyPta8ApvNP6uEwi
         VSKjbLe68cYCB7ko8nsLet7S86wdUhAXzpjieAzks5ysEjo6aHWJPGttpcwQ9OEjoD
         kw4aA4jLqICpXn45U0LNXKgMWG25Z96V8OuMQvlkJ7RpzvTKTkjVFp6IdwRScan40n
         3CnyZOvcx/z1w==
Date:   Mon, 24 Jul 2023 13:36:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <cbff36d5-cde7-43bd-b0d5-ede8950fd885@sirena.org.uk>
References: <20230713121627.17990c86@canb.auug.org.au>
 <ZK/ruOD4QFPQ3Q5q@smile.fi.intel.com>
 <ZK/w5LFanElxZazG@smile.fi.intel.com>
 <ZLES/6iNcmR7H+f7@smile.fi.intel.com>
 <20230724135858.3c1abb01@canb.auug.org.au>
 <ZL410jAw2ksuBx56@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5khjO9tSGN7eSIPD"
Content-Disposition: inline
In-Reply-To: <ZL410jAw2ksuBx56@smile.fi.intel.com>
X-Cookie: Please go away.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5khjO9tSGN7eSIPD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 24, 2023 at 11:26:58AM +0300, Andy Shevchenko wrote:
> On Mon, Jul 24, 2023 at 01:58:58PM +1000, Stephen Rothwell wrote:
> > On Fri, 14 Jul 2023 12:18:55 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> > > The 20230713165320.14199-1-andriy.shevchenko@linux.intel.com had been sent.

For the benefit of those playing at home that's "Documentation:
core-api: Drop :export: for int_log.h".

> > But not yet applied by anyone :-(

> Since the culprit went via ASoC tree, I think that tree is the best for the fix.
> Mark, can you apply that, please?

Jon's usually fairly responsive, perhaps there's something worrying
there, though I do note you only sent it a bit more than a week ago.

--5khjO9tSGN7eSIPD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS+cGQACgkQJNaLcl1U
h9CwWQf7BvBY/j0JK+vySCzKXmNl0/OyQ9obraEAHRrpReUNa7daw45cgOIdIA0E
Xmk1Ft5dcDf9kIEWLh/tZ2LIi3HtBbVvQZZqypQ4cW1/miBOY2vBdaK4IEkwtT3O
HIg7Ln7xhOElz8eb/K5S6ET+AgyBO/co5qMzOMlZm0wbDazaP99GOgcYqzwaUVvN
INVHJtnnOgdzhNkJ/FrM2Lu3mpmW8pxQ5wZhSQVHBLkttMds4/D3U/0HUXxOxRL6
a8HunKpowiLK2k31UIl6194g8KP5q4JvaFPsj51tolQzY2WTB0VhY+YPQb2NhnV/
Vw6SBTqm1tf5eXXm+czQqgu5yWM7sw==
=foTh
-----END PGP SIGNATURE-----

--5khjO9tSGN7eSIPD--
