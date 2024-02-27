Return-Path: <linux-kernel+bounces-83228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1720C86907F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484F21C23039
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE0F146001;
	Tue, 27 Feb 2024 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qPz2l0Fo"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9453A13A86C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036716; cv=none; b=ZgfzP8NaizU58PSMUf8tUGSU9ToAP6Yx4wLowMSxaTPu9qTRO8iVyVdm0gGi4TE9F5d7PA5x6rHGxoqtS0rPUJQ4wauYPPOQBcr14VNnnEa3LoybD92vNuwa34/HolzWPTCxZgnkTvn27AgyRdbOxjoCOONlUCuxxuIr9We+oEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036716; c=relaxed/simple;
	bh=dQplQx4E0wVG3NVHNT8C6T1/LS/PKWtnC857Cl8NoKM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdcLJLNOnLV9vBgnQ4eQDwFpm4izQJewjZoGO4DH18MU2d/xa0+jIRscwhnMiSB19csiWAVuF/2V4tp+fP+lZdArsV7+7ErtDwbgrknC8mKtmBLtb332kcvQLVJ0vHkmYNDpDmI+zt5pKM9FVMsECym3hiQ/w2ORiR+G+acZKlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qPz2l0Fo; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709036714; x=1740572714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dQplQx4E0wVG3NVHNT8C6T1/LS/PKWtnC857Cl8NoKM=;
  b=qPz2l0FoaA8MM5gsFxk4kp6O9Ma5DL1aQfdg+MSM1uhm9TykfAR4JsTN
   mqqEgxuBpf/M72QntxRCWZLFkZkx5n6+5N+XWok2lA+hZCZ5+1RgXsfO7
   6NBwRrsR6ZFwp0rjVggDWT9aJUOrTMA58ENf4Fq0XcCQNkICdyWVT+23K
   H9BiSWGS0tSzfCC17Jqmw3zZnvZUlvWRlYxwhE+ao12Tr+w6WqoI/OH1n
   6eByxvkjCMrTiQQMDQlPWaj33Pdqu63cm6uC+HWVNr7RfO7bAaHEoAnb2
   51LLOEiSiGfMAtzIRriOfftpDpCpKo0HlND29rdFi1TamFTt0TtrNsZnx
   Q==;
X-CSE-ConnectionGUID: yNBil63MQySjl9Tr6UCyNQ==
X-CSE-MsgGUID: K1P+HCaqRuC24Pz8R5JQ1g==
X-IronPort-AV: E=Sophos;i="6.06,187,1705388400"; 
   d="asc'?scan'208";a="17415151"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2024 05:25:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 05:24:53 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 05:24:52 -0700
Date: Tue, 27 Feb 2024 12:24:09 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Samuel Holland <samuel.holland@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] riscv: Allow NOMMU kernels to run in S-mode
Message-ID: <20240227-seventh-overgrown-2fa453e8a775@wendy>
References: <20240227003630.3634533-1-samuel.holland@sifive.com>
 <20240227003630.3634533-5-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aaEsmCaWxcFXJwfC"
Content-Disposition: inline
In-Reply-To: <20240227003630.3634533-5-samuel.holland@sifive.com>

--aaEsmCaWxcFXJwfC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 04:34:49PM -0800, Samuel Holland wrote:
> For ease of testing, it is convenient to run NOMMU kernels in supervisor
> mode. The only required change is to offset the kernel load address,
> since the beginning of RAM is usually reserved for M-mode firmware.
>=20
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>=20
>  arch/riscv/Kconfig | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ef53c00470d6..0dc09b2ac2f6 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -64,7 +64,7 @@ config RISCV
>  	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
>  	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
>  	select BUILDTIME_TABLE_SORT if MMU
> -	select CLINT_TIMER if !MMU
> +	select CLINT_TIMER if RISCV_M_MODE
>  	select CLONE_BACKWARDS
>  	select COMMON_CLK
>  	select CPU_PM if CPU_IDLE || HIBERNATION || SUSPEND
> @@ -220,8 +220,12 @@ config ARCH_MMAP_RND_COMPAT_BITS_MAX
> =20
>  # set if we run in machine mode, cleared if we run in supervisor mode
>  config RISCV_M_MODE
> -	bool
> -	default !MMU
> +	bool "Build a kernel that runs in machine mode"
> +	depends on !MMU
> +	default y
> +	help
> +	  Select this option if you want to run the kernel in M-mode,
> +	  without the assistance of any other firmware.
> =20
>  # set if we are running in S-mode and can use SBI calls
>  config RISCV_SBI
> @@ -238,8 +242,9 @@ config MMU
> =20
>  config PAGE_OFFSET
>  	hex
> -	default 0xC0000000 if 32BIT && MMU
> -	default 0x80000000 if !MMU
> +	default 0x80000000 if !MMU && RISCV_M_MODE
> +	default 0x80200000 if !MMU
> +	default 0xc0000000 if 32BIT
>  	default 0xff60000000000000 if 64BIT

The first default seen with a passing condition is the default chosen,
right?

Cheers,
Conor.

--aaEsmCaWxcFXJwfC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd3UaQAKCRB4tDGHoIJi
0rWUAQCYj2VzMZqjloyCYlH/8rJ600bZ72PC8LQeVI1wa+TlaQD/U6N2RrPtWIEt
9yhw7RZZXjwnLgcj/dY9G1ZI0rWF2QY=
=ZJON
-----END PGP SIGNATURE-----

--aaEsmCaWxcFXJwfC--

