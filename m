Return-Path: <linux-kernel+bounces-77360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6949D860453
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A39B1F267A1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78E273F16;
	Thu, 22 Feb 2024 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzRRZwXi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B956E5F8;
	Thu, 22 Feb 2024 21:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635960; cv=none; b=EpLNoZDOUcJ3jvfH9htZ46+0PIQSsJZRIIrSZIxY6rrjPgQGFMU8+rCc4KwsieNw5F+ZX/FSjmpwpHGJ/0MfWzwXM2bxmojfjTAsWxIU+FRxhjf3bk642IAqpzO4Vt5edYLqGSs0TiNBz/eoiSn/r1nBOhnMQ7xbHZFRDvvk/XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635960; c=relaxed/simple;
	bh=U58sud556eDeQ1ZmImtKrBLUvfMuIE+mzW0XTCAiPso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+u48kuAh3K253BvEOD0ujutPZur9Q2/yufMIHDRPzrMKsf7G7JTdDZPZ2mU07qL4LzvySruvrW8InvHnEOAx+YecgWmBsV9Dk92Smbshz9AVkRNyeIgX75rNZkEp4vfKe/mB1LEusC20tghbW/OCdaEBOw47RidxyqbMmJQc0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzRRZwXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AE9C433C7;
	Thu, 22 Feb 2024 21:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708635959;
	bh=U58sud556eDeQ1ZmImtKrBLUvfMuIE+mzW0XTCAiPso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LzRRZwXidNQzDxeJIbnP4nNXwp+aEQYkFr6bel+eg3jxqQJtKMRG5WULKe+Az0SJH
	 QTWLexadcq60LJgYMmy/t2OD1pRUKuLkjMjxZ49eutxO0Rd4LnylMLRymWOy0KgEZQ
	 abHQdGj5bxoqH3xKhLrgVbJrVE4Rc74QSkEMbIiQig0vu6kO5yCE58FYNzDmkUKSF9
	 UCNoS7zUQfcTFRLXHgcnrDGhglnCpGcgBfaaHMCXZ/tiDP/WMzn8bnd+EHSKO7D6f8
	 8HTO8hxVXSNdQiumIaFDZmZf4Cus+wCT1ZKAcTJ3EzypWz2VW5WhyPxJUul6x/wYDr
	 JzQn38Zj1f3Xw==
Date: Thu, 22 Feb 2024 21:05:55 +0000
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
Message-ID: <20240222-wound-dedicate-8622374372c0@spud>
References: <tencent_AB625442CC1BCFF86E04D7B5891C43719109@qq.com>
 <tencent_C9E0DAC75884B0346EF2250A5E68673BA20A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5zmUS5d2XUx6ACNS"
Content-Disposition: inline
In-Reply-To: <tencent_C9E0DAC75884B0346EF2250A5E68673BA20A@qq.com>


--5zmUS5d2XUx6ACNS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Feb 21, 2024 at 03:03:57AM +0800, Yangyu Chen wrote:
> The BUILTIN_DTB kernel feature on RISC-V only works on K210 SoC only. This
> patch moved this configuration to entire riscv.
>=20
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
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

s/SOC/ARCH/

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

I think we should drop this default, I don't think that "k210_generic"
should really exist in the first place. And suggest that there are
platform-wide default devicetrees isn't something I think should be
encouraged.

> +	help
> +	  DTS file path (without suffix, relative to arch/riscv/boot/dts)
> +	  for the DTS file that will be used to produce the DTB linked into the
> +	  kernel.
> =20
>  endmenu # "Boot options"

> -config SOC_CANAAN_K210_DTB_BUILTIN
> -config SOC_CANAAN_K210_DTB_SOURCE

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

There are two more instances of this that need to be removed.

Thanks,
Conor.

--5zmUS5d2XUx6ACNS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZde3MwAKCRB4tDGHoIJi
0ryjAP911F6vJIsVOELuA0YuESC2m71QaGZIPmuzmNmO5beULgEA3vRKcYuNh9//
rbNn0MGJyAPpzfbA5l3oinawqjujDgA=
=abz2
-----END PGP SIGNATURE-----

--5zmUS5d2XUx6ACNS--

