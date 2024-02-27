Return-Path: <linux-kernel+bounces-83208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C996F869041
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59AE2B22452
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7C2145356;
	Tue, 27 Feb 2024 12:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EKstzD34"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB4313F006
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036355; cv=none; b=JF/FbITNRGPQLiJvpUBBZOlXzHfnzr5eMsbgTA/lerr89O4eSJY5v9fau8Bi/Fsl6aCmmc6PNcepz8CIqHgenGEtORoZxJg9Mmsaj1yXG+/I59bKuC8WhkaRg38On4pW+NJiLiJOng8HxmWd+rFeiUzzMXlNCj7g7m0U7ny9RmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036355; c=relaxed/simple;
	bh=NoB2fJENJEF1lOceRXQJkFncagd38TF5dH+WfCPzLgc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oneDWpkd6KXyFqGwxB/fnLCb3/hwlqLRMmTPm0s0q71CXaxhauYT9xtrwIwRk970NVPX1bMubmjzMdbunw6WHQFFinmwH8J1aUDtpOLWIaQ/737gDssnHcUgYm3POsdyxV4dV8CuqnBBTL49mrddHyJpsFMs3y5K+DJkX+7Icro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EKstzD34; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709036353; x=1740572353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NoB2fJENJEF1lOceRXQJkFncagd38TF5dH+WfCPzLgc=;
  b=EKstzD34UG1TzfB1itbONbaGaTJDm7XfK8mMZ3UuhQG3nkGacEIUKcyF
   m6i5U9DtnA+LxfMAoUOlrK0kJ8nTNX9fLJavak17bcbxD1P7eYpttQbdp
   M4Vm37BHQCM+VCg6DWAbJ2wP3+8bg4pZO+sdhFocu2UY9Q8/eyaLZHECI
   +yr7PiKDZjkV8P6TBwqdZO7dUGXXxH+F857n7kRyWefn+TbK6cXiA1Wmd
   zmDdURU69UDpJcFNNRaFGYfXeQit5VsF6BL6mKId6Hq5GFXY+XPmVC2wA
   GaH3MugIBGjnstRMI//bIQU6FOyGoeu0uiJimnAffKyhCA3ytnAmI48P/
   w==;
X-CSE-ConnectionGUID: gwxo7JWySZyq7n71kTiPrQ==
X-CSE-MsgGUID: aUX90sfwTdW/vMLuEfjRDg==
X-IronPort-AV: E=Sophos;i="6.06,187,1705388400"; 
   d="asc'?scan'208";a="17414830"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2024 05:19:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 05:19:03 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 05:19:02 -0700
Date: Tue, 27 Feb 2024 12:18:19 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Samuel Holland <samuel.holland@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] riscv: Fix loading 64-bit NOMMU kernels past the
 start of RAM
Message-ID: <20240227-unfitting-rectangle-cd0f23a4f3f1@wendy>
References: <20240227003630.3634533-1-samuel.holland@sifive.com>
 <20240227003630.3634533-3-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tfS8TWg82l+tp82L"
Content-Disposition: inline
In-Reply-To: <20240227003630.3634533-3-samuel.holland@sifive.com>

--tfS8TWg82l+tp82L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 04:34:47PM -0800, Samuel Holland wrote:
> commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear
> mapping") added logic to allow using RAM below the kernel load address.
> However, this does not work for NOMMU, where PAGE_OFFSET is fixed to the
> kernel load address. Since that range of memory corresponds to PFNs
> below ARCH_PFN_OFFSET, mm initialization runs off the beginning of
> mem_map and corrupts adjacent kernel memory. Fix this by restoring the
> previous behavior for NOMMU kernels.
>=20
> Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping=
")

This commit was a year ago, why has nobody reported this as being an
issue before?

> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>=20
>  arch/riscv/include/asm/page.h | 2 +-
>  arch/riscv/mm/init.c          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 57e887bfa34c..94b3d6930fc3 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -89,7 +89,7 @@ typedef struct page *pgtable_t;
>  #define PTE_FMT "%08lx"
>  #endif
> =20
> -#ifdef CONFIG_64BIT
> +#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
>  /*
>   * We override this value as its generic definition uses __pa too early =
in
>   * the boot process (before kernel_map.va_pa_offset is set).
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index fa34cf55037b..0c00efc75643 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -232,7 +232,7 @@ static void __init setup_bootmem(void)
>  	 * In 64-bit, any use of __va/__pa before this point is wrong as we
>  	 * did not know the start of DRAM before.
>  	 */
> -	if (IS_ENABLED(CONFIG_64BIT))
> +	if (IS_ENABLED(CONFIG_64BIT) && IS_ENABLED(CONFIG_MMU))
>  		kernel_map.va_pa_offset =3D PAGE_OFFSET - phys_ram_base;
> =20
>  	/*
> --=20
> 2.43.0
>=20

--tfS8TWg82l+tp82L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd3TCwAKCRB4tDGHoIJi
0s/zAQCS852scSonjy1Gj7apcbh2fxvVfWDrwwOmuGUBrmho0QEA44dOATliF775
3hhKWqWXuZEZSrQinzVHcHmNhWBkywA=
=Sol7
-----END PGP SIGNATURE-----

--tfS8TWg82l+tp82L--

