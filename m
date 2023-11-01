Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9AB7DE730
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347764AbjKAUYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346367AbjKAUYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:24:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B02BC1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 13:24:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED79C433C8;
        Wed,  1 Nov 2023 20:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698870290;
        bh=V4XWXLOskRiU2rpSI2A0zW4xTKdtIMk7gWepPoY6w40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yv3wHlDwVdgrESn4WQNQcB1nVsKFxkObcaE6UT9sIzAGI/2UZVm40m80Z3MWQ8f+G
         dqKQGkwk6hBq1q1MgRk1uNdV5JCz1Jl/+qT4cEtdAYTUw/iO1KWHG6cYYDuF48g1Qj
         9XBU4EmFvrT3opbgoajOI9Ioi+pwgCVe8ga912mIttJKcvYxubibtTNWxCCHEuH9Ha
         5YIbvRrKE6hT9/AmWnBdl1C6ciZIAge924uiOkpb3EOQW8I5L6ZKSn0SvzdjdmOvnS
         9+R1L/dciJlEHhFQyX1jscYaYFf7LjjGHDzZhiII40m7psnYkDb7hpbbitn9dbAU3v
         WcEP/ND6adNfA==
Date:   Wed, 1 Nov 2023 20:24:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ben Whitten <ben.whitten@gmail.com>
Subject: Re: [PATCH] regmap: prevent noinc writes from clobbering cache
Message-ID: <72d79cd8-9054-4e98-8e44-808aca952221@sirena.org.uk>
References: <20231101142926.2722603-2-ben.wolsieffer@hefring.com>
 <b0e8c9f5-7aff-4adc-b5bc-d61c6107c07f@sirena.org.uk>
 <ZUKy-ETSbM7yNvNK@dell-precision-5540>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yUEH5eSKC+ZgWt5k"
Content-Disposition: inline
In-Reply-To: <ZUKy-ETSbM7yNvNK@dell-precision-5540>
X-Cookie: P-K4
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yUEH5eSKC+ZgWt5k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 01, 2023 at 04:20:08PM -0400, Ben Wolsieffer wrote:
> On Wed, Nov 01, 2023 at 05:05:39PM +0000, Mark Brown wrote:

> > Could you please add a kunit test for this?

> I started to look into this, but it is not currently possible to test
> noinc behavior with regmap_[raw_]ram. The same bulk write operation is
> used by both incrementing and non-incrementing writes, and the difference
> in behavior is due to how the hardware handles the bulk write to a
> particular register.

> To test this behavior, regmap_raw_ram (raw because it supports bulk
> writes) would have to be told that certain of its registers should
> implement noinc semantics.

> Is this something I should implement?

That would be great, yes - I've just been implementing features in those
map types on an as needed basis as I've been writing tests and I didn't
get round to covering noinc yet.

--yUEH5eSKC+ZgWt5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVCtAwACgkQJNaLcl1U
h9CFqgf+IAvxgv1u5i8u68leci7wxjTzOR/8CpWhu1UIW2Vs1jRMLJ2jpSUkosO1
5ZDFKRW2jhXRrHGoHBLMl1ocMwDklWCoMmR7OYPjB9OWLsPWUSrdbb49Pd+qIfqr
TwY1AlQIt4Djd8GMCzZf6e/wZFfm70R9OsVqeyeBYQM1V/Oh4IxfOzz1OWs3bifz
tNbOl0VT76AD5uIeb++32BUSihTN5D5DEECZmUxRPe1tgCz325bxzA4qRQKDONrn
8FZIJn6oMNaWRHtlBH/szoCSAAy72DaPP9TAEQRnxcPYKPfJo39eVjwLBdhtbm45
/iWYVjtIffHrKJIUMxjW/+TsbUQ1Lg==
=KgNz
-----END PGP SIGNATURE-----

--yUEH5eSKC+ZgWt5k--
