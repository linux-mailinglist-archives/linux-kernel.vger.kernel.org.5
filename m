Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C62767E39
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 12:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjG2Kep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 06:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjG2Ken (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 06:34:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43D91AB
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 03:34:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40B2560A2B
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 10:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E02C433C8;
        Sat, 29 Jul 2023 10:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690626881;
        bh=5mvU38WFmD6aiPJH00I1q1misTN6TeP/eYb46wUKo/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o3JDPlsAa7XqHqEJen3RNbtENp7NwAiMUE3LDSbwrPSkIBQ89NOt2R7wxsFObMyQE
         oAWzYxtMIFIxk7/aySsmFpUQEdmkOgZbIoYFCPzBQRGEBma0GXMQipgTT3V8JSDGHH
         hgpkqnhHTwfcV2hAwjSNLSI2bn5l6Vy0p6vHHUJzFd0h5Xu6dpQcOAz+pkO3bNlkQW
         FLMC7Pvh3YuaOz3saTKs56/BUm0QLwG3PPAHKkYdU7/gI+bbRuhxKbuHiT9v8U1US4
         hqP9pQcvcJutKn9rjKtvhPhMfheT46KjEhl32JuoIQmUslPFwza0urCQif8N+fjfmL
         tbRCfRzssX9mQ==
Date:   Sat, 29 Jul 2023 11:34:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: enable DEBUG_FORCE_FUNCTION_ALIGN_64B
Message-ID: <20230729-shucking-slang-370c6baa358e@spud>
References: <20230727160356.3874-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LxHC1VpAZFy1zAHq"
Content-Disposition: inline
In-Reply-To: <20230727160356.3874-1-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LxHC1VpAZFy1zAHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Fri, Jul 28, 2023 at 12:03:56AM +0800, Jisheng Zhang wrote:
> Allow to force all function address 64B aligned as it is possible for
> other architectures. This may be useful when verify if performance
> bump is caused by function alignment changes.
>=20
> Before commit 1bf18da62106 ("lib/Kconfig.debug: add ARCH dependency
> for FUNCTION_ALIGN option"), riscv supports enabling the
> DEBUG_FORCE_FUNCTION_ALIGN_64B option, but after that commit, each
> arch needs to claim the support explicitly. I tried the config file in
> [1] for both RV64 and RV32, I can't reproduce the build error as [1],
> there is no reason for not allowing to enforce this function alignment.
>=20
> Link: https://lore.kernel.org/lkml/202202271612.W32UJAj2-lkp@intel.com/ [=
1]

This is a CSKY randconfig, is there any particular reason that running
that randconfig (over a year later) and on a different architecture
would trigger whatever the condition was?

The original commit here seems far too penal - why was it not just
disabled on CSKY??? I tried looking a bit on lore, but didn't see
anything explaining the subset of supported archs they picked.
I did see Guo Ren wondering if rv32 would be similarly problematic - but
since this is something likely to just trip up randconfigs, I think we
should go for it and if rv32 becomes a problem, restrict this to 64-bit.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  lib/Kconfig.debug | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index fbc89baf7de6..39ffd218e960 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -502,7 +502,7 @@ config SECTION_MISMATCH_WARN_ONLY
> =20
>  config DEBUG_FORCE_FUNCTION_ALIGN_64B
>  	bool "Force all function address 64B aligned"
> -	depends on EXPERT && (X86_64 || ARM64 || PPC32 || PPC64 || ARC || S390)
> +	depends on EXPERT && (X86_64 || ARM64 || PPC32 || PPC64 || ARC || RISCV=
 || S390)
>  	select FUNCTION_ALIGNMENT_64B
>  	help
>  	  There are cases that a commit from one domain changes the function
> --=20
> 2.40.1
>=20

--LxHC1VpAZFy1zAHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMTrPQAKCRB4tDGHoIJi
0iGdAQDyN75O2rQ1WW8cAOtDv2dka5BxnhOAnhZQPU4T3q4cpgD+LfZKzuDdbrub
ytNDwsKc2dgDCxjr1N0tLkggxyp44ws=
=mi/7
-----END PGP SIGNATURE-----

--LxHC1VpAZFy1zAHq--
