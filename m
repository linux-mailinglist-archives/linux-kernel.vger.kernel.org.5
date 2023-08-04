Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36FE770589
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjHDQET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjHDQEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:04:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEED49EF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:03:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68C6D62093
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 16:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CDCC433C8;
        Fri,  4 Aug 2023 16:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691165034;
        bh=wC1m67ImHISvj4AzBsW1U4Nhm8/KyDRI6F1fpNbGyu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j8OZTvIKJZenXKc5jnItkdyUDMwQD5mOte+QklB6LkgPCs/Lm2RF7vBf9wMHfkMnF
         01oe/h7hoycCaSQ6dkCik98O413AuYdYhohyqqghw6+SVjhQuoYd/zq2akSvVlQvjd
         pSA/ZSg/kBp2kA0oz87O42Au/wCFnzB0mT4K5G9+C3hVmw6MgXhq5ZqN1h2HIXNDDd
         CJgMe3fMQSWcLleBzaqN91mqXCo0c9paMkEM30pqhDVDqyuy2uoGbzoNM6gWywlPv0
         ++BszlsageWhiRuohjwjXAAbcN43HIrr2hrcUcYsG2WIbC/520Danp/KPaynKOW6Ur
         Uy4kfNnSXoHOA==
Date:   Fri, 4 Aug 2023 17:03:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Morse <james.morse@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jintack Lim <jintack.lim@linaro.org>,
        Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64/sysreg: Move TRFCR definitions to sysreg
Message-ID: <016cbd81-3aad-4160-88b7-13aa303e1821@sirena.org.uk>
References: <20230804085219.260790-1-james.clark@arm.com>
 <20230804085219.260790-2-james.clark@arm.com>
 <143152c8-61b8-4a71-9090-7203342b661c@sirena.org.uk>
 <a8e15838-42e5-3f49-62e3-0a6646566b8e@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d2rkxrb7n6zeRl/C"
Content-Disposition: inline
In-Reply-To: <a8e15838-42e5-3f49-62e3-0a6646566b8e@arm.com>
X-Cookie: I'm hungry, time to eat lunch.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d2rkxrb7n6zeRl/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 04, 2023 at 04:55:19PM +0100, James Clark wrote:
> On 04/08/2023 13:10, Mark Brown wrote:
> > On Fri, Aug 04, 2023 at 09:52:16AM +0100, James Clark wrote:

> >> TRFCR_EL2_CX needs to become TRFCR_ELx_CX to avoid unnecessary
> >> duplication and make the SysregFields block re-usable.

> > That field is only present in the EL2 version.  I would tend to leave
> > the registers split for that reason, there's some minor potential for
> > confusion if people refer to the sysreg file rather than the docs, or
> > potentially confuse some future automation.  However that's not a super
> > strongly held opinion.

> True, the potential for confusion is a good reason to not try to avoid
> duplication. Probably helps if it is ever auto generated or validated as
> well.

> I could update it on the next version. But do I leave all the existing
> _ELx usages in the code, or change them all to _EL1 (Except CX_EL2)? To
> leave them as _ELx sysreg would look like this, even though _EL1 would
> probably be more accurate:

>   SysregFields TRFCR_EL2

You could just leave this as _ELx and simply not reference it for the
EL1 definition which is proably fair?  Perhaps with a comment saying why
there's an expanded definition for EL1.  I don't think it fundamentally
matters which way it's done so long as EL1 stays a subset of the EL2
definition (which seems likely, and we can always revisit should that
happen).

--d2rkxrb7n6zeRl/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTNIWMACgkQJNaLcl1U
h9DiUgf/bryWefgita5AL0aOugwkBFYKLVa0Y9DAOskmI+VddalSFJ/DZK6XOa6J
ezXal989d6CGQFqlQ5puuQ7kaHdJTe5s8FmNqr2TQUwJ09o2QES2qOxBlSjheYad
rmjBLPHdqfm3mSO5g8JuldAHmTHaZr0iYgwSUslo/cGDlyEwgVjwSIm9SQR1AUNv
yAsZiP0u4Sb5GazTU+u0VfrthvFDle12Mt7MDw09hZPtM614FVVLvVr3lOGG5HWu
uQVbGCVd4QyeN/UcHZs1LdYVK+oKbCWPqxFax/yHyjc0UOj/AqW60led7n05uGQZ
fKvnYm/hfuNJKaVeLBeF96/xOGcZog==
=f08w
-----END PGP SIGNATURE-----

--d2rkxrb7n6zeRl/C--
