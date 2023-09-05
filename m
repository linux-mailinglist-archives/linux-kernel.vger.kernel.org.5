Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF37D79250A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbjIEQBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354521AbjIEMQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:16:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14131A8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:16:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42A836068B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 12:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FCEC433C7;
        Tue,  5 Sep 2023 12:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693916213;
        bh=z3FvD646feiqjVMf9SuHNB5V1He3cLtJqtYnrcddmpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pTbwzHwALq3lKJ58J+ZoptPRYvEX8cTd+zk0IPY3COPakM8YKZWc/38AYqdgNDKlv
         OR1198eoYVJqJUutamKFk3h7jy3rQGGlWEQZQ37f0hM9D3n4P9HA5jwd/fqTHkaSym
         20vLyRRRUBs4H94Zvlt87Zox8Yq2/0pJb+pR8jBbfaoFm7pCflt+8PS7P5kAZ74EaS
         7NsBkdE3vpD1MB0aRYGP/r6XIZidA3G3S6nQaZX29gMamIQx39HukWQ8oJpuyIFPp3
         fBMbGTDEEG6VLVBfSPEXknPSAUill/o+xl9y8ZoENQmaB0gj7/wms9hOWbG7MT2hAK
         E3EWSqRBSCc5A==
Date:   Tue, 5 Sep 2023 13:16:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, maz@kernel.org,
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
Subject: Re: [PATCH v3 1/2] arm64/sysreg: Move TRFCR definitions to sysreg
Message-ID: <5c75e612-121e-42e9-b8f1-99d286562b74@sirena.org.uk>
References: <20230905102117.2011094-1-james.clark@arm.com>
 <20230905102117.2011094-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KH+svxDlGVspbVSW"
Content-Disposition: inline
In-Reply-To: <20230905102117.2011094-2-james.clark@arm.com>
X-Cookie: I can't drive 55.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KH+svxDlGVspbVSW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 05, 2023 at 11:21:14AM +0100, James Clark wrote:
> Add separate definitions for ELx and EL2 as TRFCR_EL1 doesn't have CX.
> This also mirrors the previous definition so no code change is required.

Reviewed-by: Mark Brown <broonie@kernel.org>

Matches DDI0601 2023-06.

--KH+svxDlGVspbVSW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT3HC0ACgkQJNaLcl1U
h9CFzAf+MG6Rt9HmgZ1gptS0a7UHw9uVM2T99NLNfVSxID6n4PFcgc0cZgVNucsn
ZP5YDx6aMMO922oOJeFXKQxOxPASZ7ESk5oSOJOe95p9FfOje2sLAA7+HW39AX2W
IqWrI/52BrdNkK6MRcI/Tb8hgyT3ARXyRQoSWh7vmmMSCuvnljjEnPD0S+tozJ4z
R4ssDiOcrVMRUF7uD1JLNfF5VkjItjxX/0kwWqJ14nyyAT6d0u9NSx85gnghzgZf
GdGH4B0iC8aJ5t5P3yP85vLevAj1q8ltou4CaaGgOWjifYHmfqRNOzxVQzTEsJdn
qIB5IY8llT+mou603I/GdhDFungnXw==
=o9pu
-----END PGP SIGNATURE-----

--KH+svxDlGVspbVSW--
