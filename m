Return-Path: <linux-kernel+bounces-73896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8FB85CD3F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CFD284100
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E1923A8;
	Wed, 21 Feb 2024 01:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S54bans2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D7417D5;
	Wed, 21 Feb 2024 01:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708477874; cv=none; b=Y7mIMXSJTpUOLvcCDm2AkgAPkZduSqsZbNEjlnmo1eCZ7Qc1BfFwgtWuAjRpPMm3s1faJvQ0IVv/NszBNzqo1wtpCy/WPUS8TTZvFeInAVti1mQdyBBcPNd6NaSp0NvyO1/gWW2I3hqQCkBfXUG5iMrX6QG/ue8gb7JMfmeNwUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708477874; c=relaxed/simple;
	bh=btJOLopJktgGi2/wGoVtv1QtxSSCjSdVjxE6aY9Ek/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AglAjEU35Eet+gLfd+16AxEpEgl1DPEQSlGYwof2oGHrULRyeITlf6F7L+iWmPne7SD0AH/ncAASZAbbDc03HcZc0/lb5tmfdUj1B5AGp5Qizt3d0L8jOQe+7SbtGsRKBIBUXWRfdnAR45wBbWuaJ9tQOL1POiUUc+NNlrG3/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S54bans2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A791C433F1;
	Wed, 21 Feb 2024 01:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708477874;
	bh=btJOLopJktgGi2/wGoVtv1QtxSSCjSdVjxE6aY9Ek/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S54bans2BlnZaSoevee1TwMnZ3Z3UqHKYFnM5eKUMAyIF7yl9wKF/twxUlPaTSb0b
	 /f28cCjcxKNP2CauQPQkAOm5BDzn0pFNTKoAfjTRFNpbUJtx8YWqFB3ZFwDfujXraD
	 mbwAGAA0YBqF7CW7/G784mvdaWhs2M7pHiI9ckbEBsL41Z92cbc4X3RgwTKRG8acRx
	 3ICgwweV5lMk5U0vSPVuNJOxCnvB2Y6Zwgb3eMZMgY8fSuazrimy1VOwxmT0SD+Aim
	 SYenZvlu2BNC9JFJ2qOKr1cQoSERvBjV11btcAJ66vimZQSsTOQe/2ggI7PBCti7ac
	 LRLMVB6gao3XA==
Date: Wed, 21 Feb 2024 01:11:09 +0000
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] riscv: dts: Allow BUILTIN_DTB for all socs
Message-ID: <20240221-numerator-grill-1e5603841a8d@spud>
References: <tencent_AB625442CC1BCFF86E04D7B5891C43719109@qq.com>
 <tencent_C9E0DAC75884B0346EF2250A5E68673BA20A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Fp5d1QqaibeYLKMo"
Content-Disposition: inline
In-Reply-To: <tencent_C9E0DAC75884B0346EF2250A5E68673BA20A@qq.com>


--Fp5d1QqaibeYLKMo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 03:03:57AM +0800, Yangyu Chen wrote:
> The BUILTIN_DTB kernel feature on RISC-V only works on K210 SoC only. This
> patch moved this configuration to entire riscv.
>=20
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

A passing remark here only:
The detail in the cover letter belongs in the commit message. There's
very little value in a cover letter for a one patch "series" - it
either will duplicate information from the commit message (and is
therefore useless) or, as in this case, splits information that should
be in the commit message away from it.

Thanks,
Conor.

> ---
>  arch/riscv/Kconfig                  | 16 ++++++++++++++-
>  arch/riscv/Kconfig.socs             | 32 -----------------------------
>  arch/riscv/boot/dts/Makefile        |  2 +-
>  arch/riscv/boot/dts/canaan/Makefile |  2 --
>  4 files changed, 16 insertions(+), 36 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index b49016bb5077..23d501561e64 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -996,7 +996,21 @@ config RISCV_ISA_FALLBACK
>  config BUILTIN_DTB
>  	bool "Built-in device tree"
>  	depends on OF && NONPORTABLE
> -	default y if XIP_KERNEL
> +	default y if XIP_KERNEL || SOC_CANAAN
> +	help
> +	  Build a device tree into the Linux image.
> +	  This option should be selected if no bootloader is being used.
> +	  If unsure, say Y.
> +
> +
> +config BUILTIN_DTB_SOURCE
> +	string "Built-in device tree source"
> +	depends on BUILTIN_DTB
> +	default "canaan/k210_generic" if SOC_CANAAN
> +	help
> +	  DTS file path (without suffix, relative to arch/riscv/boot/dts)
> +	  for the DTS file that will be used to produce the DTB linked into the
> +	  kernel.
> =20
>  endmenu # "Boot options"
> =20
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index e08e91c49abe..623de5f8a208 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -84,36 +84,4 @@ config SOC_CANAAN
>  	help
>  	  This enables support for Canaan Kendryte K210 SoC platform hardware.
> =20
> -if ARCH_CANAAN
> -
> -config ARCH_CANAAN_K210_DTB_BUILTIN
> -	def_bool SOC_CANAAN_K210_DTB_BUILTIN
> -
> -config SOC_CANAAN_K210_DTB_BUILTIN
> -	bool "Builtin device tree for the Canaan Kendryte K210"
> -	depends on ARCH_CANAAN
> -	default y
> -	select OF
> -	select BUILTIN_DTB
> -	help
> -	  Build a device tree for the Kendryte K210 into the Linux image.
> -	  This option should be selected if no bootloader is being used.
> -	  If unsure, say Y.
> -
> -config ARCH_CANAAN_K210_DTB_SOURCE
> -	string
> -	default SOC_CANAAN_K210_DTB_SOURCE
> -
> -config SOC_CANAAN_K210_DTB_SOURCE
> -	string "Source file for the Canaan Kendryte K210 builtin DTB"
> -	depends on ARCH_CANAAN
> -	depends on ARCH_CANAAN_K210_DTB_BUILTIN
> -	default "k210_generic"
> -	help
> -	  Base name (without suffix, relative to arch/riscv/boot/dts/canaan)
> -	  for the DTS file that will be used to produce the DTB linked into the
> -	  kernel.
> -
> -endif # ARCH_CANAAN
> -
>  endmenu # "SoC selection"
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index 72030fd727af..318239d9423b 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -8,4 +8,4 @@ subdir-y +=3D sophgo
>  subdir-y +=3D starfive
>  subdir-y +=3D thead
> =20
> -obj-$(CONFIG_BUILTIN_DTB) :=3D $(addsuffix /, $(subdir-y))
> +obj-$(CONFIG_BUILTIN_DTB) :=3D $(addsuffix .dtb.o, $(CONFIG_BUILTIN_DTB_=
SOURCE))
> \ No newline at end of file
> diff --git a/arch/riscv/boot/dts/canaan/Makefile b/arch/riscv/boot/dts/ca=
naan/Makefile
> index 520623264c87..987d1f0c41f0 100644
> --- a/arch/riscv/boot/dts/canaan/Makefile
> +++ b/arch/riscv/boot/dts/canaan/Makefile
> @@ -5,5 +5,3 @@ dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maix_bit.dtb
>  dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maix_dock.dtb
>  dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maix_go.dtb
>  dtb-$(CONFIG_ARCH_CANAAN) +=3D sipeed_maixduino.dtb
> -
> -obj-$(CONFIG_ARCH_CANAAN_K210_DTB_BUILTIN) +=3D $(addsuffix .dtb.o, $(CO=
NFIG_ARCH_CANAAN_K210_DTB_SOURCE))
> --=20
> 2.43.0
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--Fp5d1QqaibeYLKMo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdVNrQAKCRB4tDGHoIJi
0sFAAP4h5Qi4wUH4zI2ZIpYCW4U7sB6GTty5lWkHW6FWrypX4AD/TYWKB0d+Ksve
mhB9mhYApbgHPMDwnSKtULPRnM7Hswg=
=hNmM
-----END PGP SIGNATURE-----

--Fp5d1QqaibeYLKMo--

