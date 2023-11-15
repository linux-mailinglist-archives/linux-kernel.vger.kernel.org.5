Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5897EC990
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjKORVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKORVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:21:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B39BB;
        Wed, 15 Nov 2023 09:21:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE19C433C8;
        Wed, 15 Nov 2023 17:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700068894;
        bh=keotLdJ3OuMV7zjvLmTI9+oSoIh1qPKq5R+BhIJz/Xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=afIyOxIMiyp8+lnr8JqutH076LZNxhNF9sD6cDlr/guK4S7rriUT+XqpAkxBJSAVT
         ygF2AHTiog+Z5dYurkwoU8w57GsFZbeFocixCiaStmrGZz9JliwdpDACMVywmiRwi8
         gb6iwv3HYGzzrUulLHwoYFMo2R0+qYcWXt2p95lAlENDz2P0eGG3fCRCe6odYQXKDt
         Q0cRdilOSuc6dW7HLNzT6e5HQQ8zt1VDeHkWbzWKc2tsS6xJ5Ye6+Ea+ijWCxu9Z7u
         qfjJu6jGI2s3i54ZHkw6Uf/705yKjH21A74sXZ1hPdbktZxCZIWYuzAAoHbAsf64d6
         4NXSLO3jPNlAQ==
Date:   Wed, 15 Nov 2023 12:21:26 -0500
From:   Wolfram Sang <wsa@kernel.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Len Brown <lenb@kernel.org>,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        Xueqin Luo <luoxueqin@kylinos.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  PM: tools: Fix sleepgraph syntax error
Message-ID: <ZVT+Fq1yVZ9G8pqx@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>, Len Brown <lenb@kernel.org>,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        Xueqin Luo <luoxueqin@kylinos.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <a5f86bcf03b2ed809245d57f5971ae42a8b85128.camel@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pjjjDalug1el5NOW"
Content-Disposition: inline
In-Reply-To: <a5f86bcf03b2ed809245d57f5971ae42a8b85128.camel@infradead.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pjjjDalug1el5NOW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 11:47:51AM -0500, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> The sleepgraph tool currently fails:
>=20
>   File "/usr/bin/sleepgraph", line 4155
>     or re.match('psci: CPU(?P<cpu>[0-9]*) killed.*', msg)):
>                                                          ^
> SyntaxError: unmatched ')'
>=20
> Fixes: 34ea427e01ea ("PM: tools: sleepgraph: Recognize "CPU killed" messa=
ges")
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Had the same issue:

Reviewed-by: Wolfram Sang <wsa@kernel.org>


--pjjjDalug1el5NOW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmVU/hMACgkQFA3kzBSg
Kbb7dw/9FDJNZjoZia5jzZPGExrXDVMCyniisbfjPnr9Ej7RcV+jsTm8Cypm9kl4
Ifn531OBY2Ch7wsJiPNAfnde6p2mcnmy5Wzc9OgCHyzxSHJpX6OMs8QAEzfqpnRs
AMA7UuDMiqQNIYeU/9VqvIyHPuSv9EZjPxu3vOmShNonjNiaNdQRYlb8CGeQMWCV
LB46EjEu92DzJFwN9XZZZlutlIHZkIv9mBwznXBF7GodIUAPWnEHvIeoJXfZowgN
VZgO2fzNRU7NKjBJ+kdi7oUAUl7TIYD/7JHfZP6yW9fJ+FV3wD3i5UioMGcxA2Qd
WGAqf5I/NF38L4o86D9WIavnSdmPwhwODM3GC/+2DnddUV0xgSD1zHJ/yIkQsu7x
sdZTkoCdpI8LZKXyfjEatG6uicwvOdF4DzDd0XaYYQgYdYoUCUkaFBq30mYsurr2
3ahRtDpC3UPcd/tvq5n3AZIHnZhlAFixjMnMgVfIuQcZ0nqnEx3x26kJs4zveL/a
Ub9AHlM40ixvktIXEHWFnFv4Rc/fgc51iThf7BW3mN3A/MrtL0j/gRfgXtHk9d8a
fZhU96aAe4ADJr8cxqId3VzyNEpwFbmJgnRrCKJ0acVbZZCdUBMKYpF08hWnSicN
gAVzoQipG5ePMzBe474jPxs7nVegJJnvlGzEA30fQhq/OFLAMqw=
=2NWQ
-----END PGP SIGNATURE-----

--pjjjDalug1el5NOW--
