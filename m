Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAB5785C66
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbjHWPom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbjHWPoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:44:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB786E78;
        Wed, 23 Aug 2023 08:44:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79FA964171;
        Wed, 23 Aug 2023 15:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4006DC433CA;
        Wed, 23 Aug 2023 15:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692805469;
        bh=v+F5qVNBnDPT0ow+PQY3LNqNk+ehfsGslEzfY//TfAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gEFgywyp5/ykToGR+ILRJn8bgUMJws+XqbkLh7A5kgrXdHOZ3dg59cMA43c/TyFXj
         AJdfV2hlWovCgnP7+4IMn9vAboOCEFj23FqbHw+woIgRA+/b7jpBq7NsFYnon5Iwnd
         JG667DX2pgKm0fiLuPT+x+Ti0faiVlgk9IjxLiZASTYqNt+aswaTuGB7EMffDLQp5R
         M4q9/ablZWbHH91Z1LvyW7PJ9+no3z/QZ+1xULaql78pEbH6h0FClad7HGT4i5PfD/
         uZIWoDTf0tFjUrl4SHhAOiS/V9Ibx2cz293AbYlteBrt4QjNg4zd40z5dtT28QxBFI
         QB4XOdAYwOkag==
Date:   Wed, 23 Aug 2023 16:44:24 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Randy Dunlap <rdunlap@infradead.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>,
        linux-next@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] riscv: Require FRAME_POINTER for some configurations
Message-ID: <20230823-disown-footman-e326acc3270c@spud>
References: <20230823082845.354839-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o0g/CRFRrx5sGNGu"
Content-Disposition: inline
In-Reply-To: <20230823082845.354839-1-bjorn@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o0g/CRFRrx5sGNGu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:28:45AM +0200, Bj=F6rn T=F6pel wrote:
> From: Bj=F6rn T=F6pel <bjorn@rivosinc.com>
>=20
> Some V configurations implicitly turn on '-fno-omit-frame-pointer',
> but leaving FRAME_POINTER disabled. This makes it hard to reason about
> the FRAME_POINTER config, and also triggers build failures introduced
> in by the commit in the Fixes: tag.
>=20
> Select FRAME_POINTER explicitly for these configurations.
>=20
> Fixes: ebc9cb03b21e ("riscv: stack: Fixup independent softirq stack for C=
ONFIG_FRAME_POINTER=3Dn")
> Signed-off-by: Bj=F6rn T=F6pel <bjorn@rivosinc.com>

I think this is reasonable, even if you pre-patch version of this seemed
quite sceptical.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  arch/riscv/Kconfig  | 1 +
>  arch/riscv/Makefile | 3 ---
>  2 files changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 10e7a7ad175a..cd8075c092c3 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -62,6 +62,7 @@ config RISCV
>  	select COMMON_CLK
>  	select CPU_PM if CPU_IDLE || HIBERNATION
>  	select EDAC_SUPPORT
> +	select FRAME_POINTER if PERF_EVENTS || (FUNCTION_TRACER && !DYNAMIC_FTR=
ACE)
>  	select GENERIC_ARCH_TOPOLOGY
>  	select GENERIC_ATOMIC64 if !64BIT
>  	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 6ec6d52a4180..1329e060c548 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -87,9 +87,6 @@ endif
>  ifeq ($(CONFIG_CMODEL_MEDANY),y)
>  	KBUILD_CFLAGS +=3D -mcmodel=3Dmedany
>  endif
> -ifeq ($(CONFIG_PERF_EVENTS),y)
> -        KBUILD_CFLAGS +=3D -fno-omit-frame-pointer
> -endif
> =20
>  # Avoid generating .eh_frame sections.
>  KBUILD_CFLAGS +=3D -fno-asynchronous-unwind-tables -fno-unwind-tables
>=20
> base-commit: 89bf6209cad66214d3774dac86b6bbf2aec6a30d
> --=20
> 2.39.2
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--o0g/CRFRrx5sGNGu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOYpWAAKCRB4tDGHoIJi
0mKaAP0aaEUhXRcAHwUXqe9ooYV73f52MonjrCsYxXzCTPH9FwD+PUiPpzSF10EG
X7kxYMCXzvZnWVpAPtS/hvQvMG7HJgM=
=0Fx+
-----END PGP SIGNATURE-----

--o0g/CRFRrx5sGNGu--
