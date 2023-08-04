Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8596976FFFF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjHDMNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjHDMNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:13:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B51346A6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 05:13:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29E9661FB8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 12:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D32FC433C7;
        Fri,  4 Aug 2023 12:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691151186;
        bh=LvHDtvnmmIQrh15+9EicxRPjB9Hh6NlOSYzuk+m2gFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uMWEBeTlYkGRl9s4RhzkSBY39NwFaJ68zBLM6W8dLwpyZIFuSjitac1083ErcyihJ
         m3JKNTtWkfZHdBYzVVXH4XOTWnve4a6WdturCW8SdbLWUNxjmdJWlMhNTvgSHYwpTC
         sNdcQddGnTtZbzroUTNp9xxXpeFxOxXqIrTQFYIc3DP5eftJ5+Kq62JfbfwOwIYFYg
         mogWo0nrSi6H5MCtxMBU2gaccN8aH5qD9F5INQe1vDI0Jx3wcZdTJ0slV0T1H+3NKk
         PWxilukjsYZPLBlvCBXEuSBVPATvciZt11LKxG9MzF8a1DOe+wAQ7ctivc91QW7GB7
         CCDocm4g2Y81Q==
Date:   Fri, 4 Aug 2023 13:13:00 +0100
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
Subject: Re: [PATCH 2/2] coresight: Allow guests to be traced when FEAT_TRF
 and VHE are present
Message-ID: <f289eae2-cafb-435a-84a2-797f738e2e6b@sirena.org.uk>
References: <20230804085219.260790-1-james.clark@arm.com>
 <20230804085219.260790-3-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hP5UAZEwmGfDxBo6"
Content-Disposition: inline
In-Reply-To: <20230804085219.260790-3-james.clark@arm.com>
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


--hP5UAZEwmGfDxBo6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 04, 2023 at 09:52:17AM +0100, James Clark wrote:

> +
> +Sysreg TRFCR_EL12	3	5	1	2	1
> +Fields	TRFCR_ELx
> +EndSysreg

This bit checks out against DDI0601 2023-06:

Reviewed-by: Mark Brown <broonie@kernel.org> (sysreg)

--hP5UAZEwmGfDxBo6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTM60sACgkQJNaLcl1U
h9Ckigf/TORYqt0WUUaxLqxm/gR6yodt2kwPsPDg71ZJUEWBFvhsC8vaFa1SL+hW
yAtBU55sX5UTnKViNAnlV+Tln/nV62OhSw5a727h4h+CskebjuMbIxNDVLf53ZiK
bUBAJX8UNAhmjhRiWg5QQ9xBFOf9afX6zThsk1ifjzSuCIqzMho/AOe7tjXaS5GZ
KgxiK2AL0myYhdDRWhwmWatgyJH/KQR8Lai1P9MLDuKQau0QWsCEfMymzkcg/3Ih
CvJOvSxHJwH5s9JmnFO4ChQdDUrGiuxKzoIhg/dakzdl4pGzdC2dgQvcFwz31f+K
5wtUFLikBbFP3704F+j0uVsbax2KJg==
=xwWg
-----END PGP SIGNATURE-----

--hP5UAZEwmGfDxBo6--
