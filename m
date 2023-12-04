Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879ED803257
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjLDMS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjLDMS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:18:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1059AC0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:18:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56D8C433C8;
        Mon,  4 Dec 2023 12:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701692312;
        bh=T+xH+c12nEUIGt4znl2b05KSsW8hT+OJWg+Nyn7R+oQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UCu8zrmmc/O02VAqencGVAdm39VVWXDtSKTPd1ty1iTOFQv2Tyw15rc3rh17flAit
         ljS12k+HbiRn4rFBlpJ4buR2MvOMrR48S1MMka/FgWxsNcKojYDsYupSK2XCoHEisO
         m7B40xScupwqSx5Yinb5iJccngykXAPODZtR3/2R/3P1o6yOJdLT9nGkXBATXvWVcQ
         zUEwu/L0A9bv56kv7V9GTIs4yU2gdEVS2VdXlY3VkSquN9XXi0RITbV3Wfg/U8Z2Wm
         TghJvBXYIcqm9YPnGHUlhO5zumF5Fn48ZSDQSwXZDyD0XG8O1qFzpy44RmpqW0GLdZ
         Mm31MSZJUjgGg==
Date:   Mon, 4 Dec 2023 12:18:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V15 1/8] arm64/sysreg: Add BRBE registers and fields
Message-ID: <85fdf472-d979-4b11-95fb-5a738aa2bb9c@sirena.org.uk>
References: <20231201053906.1261704-1-anshuman.khandual@arm.com>
 <20231201053906.1261704-2-anshuman.khandual@arm.com>
 <fd278f4e-0632-4474-8609-7711ad725f85@sirena.org.uk>
 <86f91d68-207d-40a5-9d76-1cbb80e4f210@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hPtSfgwzhsGcMKsD"
Content-Disposition: inline
In-Reply-To: <86f91d68-207d-40a5-9d76-1cbb80e4f210@arm.com>
X-Cookie: For office use only.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hPtSfgwzhsGcMKsD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 04, 2023 at 09:33:56AM +0530, Anshuman Khandual wrote:
> On 12/1/23 22:28, Mark Brown wrote:
> > On Fri, Dec 01, 2023 at 11:08:59AM +0530, Anshuman Khandual wrote:

> >> +SysregFields BRBINFx_EL1
> >> +Enum	13:8		TYPE

> > DDI0601 2023-09 also defines 0b110000 as an IMPLEMENTATION DEFINED
> > exception to EL3.

> Should this field be just IMPDEF or IMPDEF_TRAP_EL3 sounds better ?

I don't have a strong opinon either way.

--hPtSfgwzhsGcMKsD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVtw5EACgkQJNaLcl1U
h9CaZwf7BPNljXbr3ZrNYFdIPrSOd6LtAlgIS4DJslS2GKZu8x9dvPi0RJP9Q6i/
2jbBcfWS3sWoI4SI9vGoeK0TzphKeApE17hNtrmpTzo9z06y4JuW26O8uFQzY5ow
OC47FnxbMM+Vtf8m0XBu64kFfMbaxLpXbjCY+LCPunYLeOwv9C67aQ3odgSPdOSh
FLn74sMu/Wb8eXoN93JtGctMssUcRdpBxo5Op3nzYdT5qn8hhOXTdoTD6CRFPMKY
2NFW7jASe4oMWZMceuJ1Z1LNnmPRkxxDpC7ridKn3Txr1j3Lrh1DLuaRuXyQKObE
ZeRy723xZ+EWgZ4QivVRDIV0Z6Lgdg==
=qexa
-----END PGP SIGNATURE-----

--hPtSfgwzhsGcMKsD--
