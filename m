Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F3D7CFEFA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345620AbjJSQC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345951AbjJSQC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:02:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDC2124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:02:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30FCC433C7;
        Thu, 19 Oct 2023 16:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697731345;
        bh=yZXzCmRk3ufriSIQXgt6TeP6axLbf0VDHMcw/aRKvKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ha4MIUcOWDM7KryrnXdqTqRki9LFrT+ZiU8klxqgx9E5zJ2tEPgOkSmjU9KM8sV6v
         EYu9Qdi7wK1elAyP6K0JEc4nff0FHIxl1+P8YXxwGgnOuMBqMCBJJ6sRwBKOCkItTe
         GN0G6KNB47iwp0RvTWKHSK6uVOR2+pmvwWyD3GuSo38wCRzNdvvxLaYFPB+ZhW7Z4K
         vpbT0QbhZ8q9/4GVzGiR34VkhGulJK96eAP92C9mfEKGRNq9jxiJws+HCaIJLTarxB
         sBtQlK7pQqMfhzLI9MKpMpCW3GjCvgXepBAMja6QBjf+s7nwP4eNBfSC93WR5UZ9VG
         wXmqb6peDMoYw==
Date:   Thu, 19 Oct 2023 17:02:18 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yu Chien Peter Lin <peterlin@andestech.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, will@kernel.org, mark.rutland@arm.com,
        atishp@atishpatra.org, anup@brainfault.org,
        conor.dooley@microchip.com, ajones@ventanamicro.com,
        heiko@sntech.de, jszhang@kernel.org, evan@rivosinc.com,
        sunilvl@ventanamicro.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, tim609@andestech.com,
        dylan@andestech.com, locus84@andestech.com, dminus@andestech.com,
        Leo Yu-Chi Liang <ycliang@andestech.com>
Subject: Re: [RFC PATCH v2 08/10] perf: RISC-V: Introduce Andes PMU for perf
 event sampling
Message-ID: <20231019-daybed-preschool-8663d5a86798@spud>
References: <20231019140156.3660000-1-peterlin@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x6otgCaD773VMsNY"
Content-Disposition: inline
In-Reply-To: <20231019140156.3660000-1-peterlin@andestech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x6otgCaD773VMsNY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 10:01:56PM +0800, Yu Chien Peter Lin wrote:
> The Andes PMU extension provides the same mechanism as Sscofpmf,
> allowing us to reuse the SBI PMU driver to support event sampling
> and mode filtering.
>=20
> To make use of this custom PMU extension, "xandespmu" needs
> to be appended to the riscv,isa-extensions for each cpu node
> in device-tree, and enable CONFIG_ANDES_CUSTOM_PMU.
>=20
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> Co-developed-by: Locus Wei-Han Chen <locus84@andestech.com>
> Signed-off-by: Locus Wei-Han Chen <locus84@andestech.com>
> ---
> Changes v1 -> v2:
>   - New patch
> ---
>  arch/riscv/include/asm/hwcap.h |  1 +
>  arch/riscv/kernel/cpufeature.c |  1 +
>  drivers/perf/Kconfig           | 14 ++++++++++++++
>  drivers/perf/riscv_pmu_sbi.c   | 35 +++++++++++++++++++++++++++++-----
>  4 files changed, 46 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index d3082391c901..eecfe95d5050 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -59,6 +59,7 @@
>  #define RISCV_ISA_EXT_ZIFENCEI		41
>  #define RISCV_ISA_EXT_ZIHPM		42
>  #define RISCV_ISA_EXT_XTHEADPMU		43
> +#define RISCV_ISA_EXT_XANDESPMU		44
> =20
>  #define RISCV_ISA_EXT_MAX		64
> =20
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 4a3fb017026c..a8e71c6dfb3e 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -182,6 +182,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>  	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
>  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
>  	__RISCV_ISA_EXT_DATA(xtheadpmu, RISCV_ISA_EXT_XTHEADPMU),
> +	__RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_EXT_XANDESPMU),

This does not following the ordering convention (see the comment above
this datastructure) and is not documented in the dt-binding AFAICT.

Cheers,
Conor.

--x6otgCaD773VMsNY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTFTCgAKCRB4tDGHoIJi
0nKIAP0UYudx+3t/W6mnFhUaOfIabhcVo8jVyLwKpJExRKvqSQEA5xL0ZAdqpAiu
Ivu2MDucdOVHqs2n8o6sWhz+K4N3UAY=
=k5/I
-----END PGP SIGNATURE-----

--x6otgCaD773VMsNY--
