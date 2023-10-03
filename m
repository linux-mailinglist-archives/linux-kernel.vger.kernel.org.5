Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EA67B68CE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjJCMQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240122AbjJCMQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:16:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9254B3;
        Tue,  3 Oct 2023 05:16:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E225C433C7;
        Tue,  3 Oct 2023 12:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696335390;
        bh=vCrLxVUxU041GfPbftQx8SOAL0xg3U3haI1Bam2Yye4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PoXGdtJ8lRr4pQtqvMOyQ9SENiaNq/lE6t5pVEd1JZqq1BP9C/b0Dd5T3UmB5wwE4
         gE1YJcr5QYKiJKLWf2JjPS8LlYfTbpHghXlqZYN1cqqQ0Zbw77FtQnxMt+ovYwiKwb
         KbQnXtCyiosh95L8+n4GsVuEP0PNegshh4ota7YUNMnuCTOEXEPrC1mjLaBaGK2CWJ
         XDMMPfEpSuB5LTrUAGVHEioAJrLQao+NPJcLLBi4mBOK8vqmwoK/XksGMBhQkXhI8B
         3nGrejfSODOZTVKZzJe96aCsnw5Fjdqxz/Bbq9aOVrGTJYPqEpClMQrfRtstK9O0jY
         qvCJ/dMscdxow==
Date:   Tue, 3 Oct 2023 13:16:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Input: cap11xx - Convert to use maple tree register
 cache
Message-ID: <e2a9124d-29de-4116-8b03-532a17b563d1@sirena.org.uk>
References: <20231001-input-maple-v1-0-ed3716051431@kernel.org>
 <20231001-input-maple-v1-2-ed3716051431@kernel.org>
 <ZRux0yLPxZGLNF5A@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a4qbqoBOi+H7/gUI"
Content-Disposition: inline
In-Reply-To: <ZRux0yLPxZGLNF5A@google.com>
X-Cookie: Oh Dad!  We're ALL Devo!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a4qbqoBOi+H7/gUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 02, 2023 at 11:16:51PM -0700, Dmitry Torokhov wrote:
> On Sun, Oct 01, 2023 at 01:43:39AM +0200, Mark Brown wrote:

> > -	.cache_type = REGCACHE_RBTREE,
> > +	.cache_type = REGCACHE_MAPLE,

> I do not think these driver care much about the cache type. Optimal one
> might even depend on the architecture. I wonder if we could have
> something like REGCACHE_DEFAULT to signal that whatever is the "best
> default" implementation it should be used?

I do sometimes wonder about that but there's also been enough issues
with the earlier stage of the transition and shaking out bugs in the
new code that it makes me a bit nervous about using one.  It has also
been a useful exercise to go through and actually look at the users, but
that could be done any time.

--a4qbqoBOi+H7/gUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUcBhkACgkQJNaLcl1U
h9CIdAf+MCnO8OZRy2u2aVEFeqz/zR/Sv9xDxvgQ3DdiwQc5VWs5IMoIVGtbx86e
SAFeQ/88w6MJF4+1vd7GAPzLBSVuqwGX/ySq/iU9qUoAP2R1AC/Ic+QUr9TbPd6F
17vRnNjZIVf2uZn4K9r/wxAZXmSy3mfoQLLq4riPHmpOGQvZWCB6K5EqTz+VNy1I
pQFocpewirdqlP/x/FKOr4nghMf2Z8Yt86XcrlUDWfHeJq+/dISu3Sr35e5JxROz
aR3s+5fCBcXPsuqTraJYTmyTNmAcbH3mKCPObDJprxJQ3YgUILn2gbp125BA9tUw
vfghf/cT/dDGArQcyDLQu+b2xFdycw==
=tF+I
-----END PGP SIGNATURE-----

--a4qbqoBOi+H7/gUI--
