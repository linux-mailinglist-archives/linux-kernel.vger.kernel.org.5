Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2654E7D9DD1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjJ0QN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjJ0QN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:13:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E626CCC;
        Fri, 27 Oct 2023 09:13:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AFAC433C8;
        Fri, 27 Oct 2023 16:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698423206;
        bh=2amW8hO5pSblSAS2ngGT4cPRc2S9uFDMytAsEa9wSjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mZjIYffBpuxs+lVj1K+zNnix+Sz4MlpmuJYJpfU3apnjMMlLjtrN9oU4VqEgY2T3H
         rv0U2IjRtuefgrrcVkc2supZkDFb0UcXicK/z3iu9wZWYvPTgNUFaP8c4cAXGzY7E1
         /TKWTWQgggm3JsfXMvboSbT60ktOHOsNfLnz0DtDMoi5oucr8KCqhruh1+kW1WG/TS
         sR0hndYQVXya4ekZqtBb6Snk5PcW8WW+YyNWjJSYbO2YkqGXvEDqwXwZX9iuI/Zm5S
         g1ukZdL/KdDKmNe0D9mtDRDASrWdwC4u8BWRcke3ypb5Xtr3lMvgcIOCI3rdWXS1ss
         HQoXEKPL92GFw==
Date:   Fri, 27 Oct 2023 17:13:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     "Stoll, Eberhard" <eberhard.stoll@kontron.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Eberhard Stoll <estl@gmx.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "Schrempf, Frieder" <frieder.schrempf@kontron.de>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH 1/4] spi: Add parameter for clock to rx delay
Message-ID: <ZTvhnGCLKVNUpqLT@finisterre.sirena.org.uk>
References: <20231026152316.2729575-1-estl@gmx.net>
 <20231026152316.2729575-2-estl@gmx.net>
 <20231027005643.4b95f17e@xps-13>
 <DB9PR10MB82468A8BD333B12D3FCB3C43F1DCA@DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM>
 <ZTujIs2O+GYKIPlU@smile.fi.intel.com>
 <DB9PR10MB8246A77EE4E7140E845D82FAF1DCA@DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM>
 <20231027144646.577210ff@xps-13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r6tszLL0X6vze7iV"
Content-Disposition: inline
In-Reply-To: <20231027144646.577210ff@xps-13>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r6tszLL0X6vze7iV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 27, 2023 at 02:46:46PM +0200, Miquel Raynal wrote:

> Yes, if the information is discoverable, we should propagate it to the
> spi layer so that the relevant action is taken, from the most desirable
> to the less desirable:
> - adapting the sampling point
> - lowering the bus frequency
> - refusing the probe if none of these solutions are possible

> Can you update your patchset with this in mind?

Yes, this sounds exactly like what I'd expect the SPI core to be doing.

--r6tszLL0X6vze7iV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU74ZMACgkQJNaLcl1U
h9ADmQf/S48Sn3S4AZ9rQkpTekUNnasT90UQg1hVm1Tz6POQhv6zVezMCUR+7CXk
3MHDCNy394RjxcdMR1Gee6DwK0Ql7lXszRokS535HZzrsN4XFSf3Znwf+FUc0+y4
HViaaxBO1UeN+ixK7OhIwSlW5t9v/8LH5xihEqsfu84MQdU8bYuCGBtNGk4sONxO
fTZDGhNSlp5e99soOgU6gtPB61o3rMluHqCMFaiGkPltSm1Cbwi17/yPKELtoc9Y
qyHQhmYLe1GzBNgyXq+XL3pm+ryU/WAkP9s8HdfiEcemS4v2S65ovf30UqJG6eVR
l0YJmKFjUfc82OGPl+3pmj4tjS6fBA==
=3AIB
-----END PGP SIGNATURE-----

--r6tszLL0X6vze7iV--
