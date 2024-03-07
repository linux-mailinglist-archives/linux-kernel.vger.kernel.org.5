Return-Path: <linux-kernel+bounces-95084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B87874910
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963911C20B59
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144716311E;
	Thu,  7 Mar 2024 07:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CWxXVfGx"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F881BF3A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709797818; cv=none; b=owEAi5lWY6HnlwC5C0oCvl88MInBnxikuvyNVTGFcyOLUxAT0UsdJURSNkZ4GDVkOuPnv0nROYuXwPgqvJ1UtBCm1KErR4tnLH+mHZdyDBG3aHNdM3O/0RxeH/2WJ5kxVs+RaP0MzvJtzt7wxuVd1RSQpmhs8z0J4OCZDsdXQZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709797818; c=relaxed/simple;
	bh=zaZejvaxya+QcPBAYnl0R1xoXRC+3MKw9yhltV+Izyk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPtLKErj6Fx9TRsU+E7jOoszzGWQ9jXejuTQR60PfRou1esHTkou7ISYUzVRlzS7rtqQJlyMtN+KpoEvJ0EviUQbAr3k3WMEK/iD6AbUlW5wUbp/MkAGPxO83/XQbgbjsgOwGNznIF3hXgXPsJxrs+JAinb+zOaJuswmhFZJnbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CWxXVfGx; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709797816; x=1741333816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zaZejvaxya+QcPBAYnl0R1xoXRC+3MKw9yhltV+Izyk=;
  b=CWxXVfGxL2q+zuAuqnB3zFJZHZEAvV7yM5yqq1T0a7UGDQUgsTiAFGNu
   5+bqxmhI2jo1k01LWml/r1/rUbmLhGbKOxwEnF5/npPSSiT/8m1igc7Lx
   wDsvEAkwdZVvSkiBS+z7DdPHMwutknT161nUXOHbjKIV6xDrVmFKHm35E
   8YvntkJSMuCRjXNc5Lw1ndg8mBdzo652PigUliUPDGyJRQUk1bw7ruhcI
   n75VDK2AZO+9gJ96yT4cetwH6IesuE8kmMAbG7gILm5sXTKoJ2JvjVfG5
   oyR3vE6LrzlHKQEZl02I53aE2WitRhYhglI6OuKNitg1WRF84XKPnNfNU
   Q==;
X-CSE-ConnectionGUID: GFFPYmVfTf+KMi7QeExFDg==
X-CSE-MsgGUID: U1mtnhNgTSWbawu19moz/Q==
X-IronPort-AV: E=Sophos;i="6.06,210,1705388400"; 
   d="asc'?scan'208";a="184603276"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2024 00:50:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 00:50:03 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 7 Mar 2024 00:50:01 -0700
Date: Thu, 7 Mar 2024 07:49:17 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Charlie Jenkins <charlie@rivosinc.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang
	<jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>, Eric Biggers
	<ebiggers@kernel.org>, Elliot Berman <quic_eberman@quicinc.com>, Charles Lohr
	<lohr85@gmail.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/4] riscv: lib: Introduce has_fast_unaligned_access
 function
Message-ID: <20240307-coronary-snagged-cf3409df8f7a@wendy>
References: <20240306-disable_misaligned_probe_config-v7-0-6c90419e7a96@rivosinc.com>
 <20240306-disable_misaligned_probe_config-v7-1-6c90419e7a96@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sY3+K8PtRfDhOk5h"
Content-Disposition: inline
In-Reply-To: <20240306-disable_misaligned_probe_config-v7-1-6c90419e7a96@rivosinc.com>

--sY3+K8PtRfDhOk5h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 12:00:01PM -0800, Charlie Jenkins wrote:

$subject: riscv: lib: Introduce has_fast_unaligned_access function

nit - s/ function/()/ & put the () after function names in commit
messages please.

> Create has_fast_unaligned_access to avoid needing to explicitly check
> the fast_misaligned_access_speed_key static key.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Evan Green <evan@rivosinc.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  arch/riscv/include/asm/cpufeature.h | 11 ++++++++---
>  arch/riscv/kernel/cpufeature.c      |  6 +++---
>  arch/riscv/lib/csum.c               |  7 ++-----
>  3 files changed, 13 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index 5a626ed2c47a..466e1f591919 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
> - * Copyright 2022-2023 Rivos, Inc
> + * Copyright 2022-2024 Rivos, Inc
>   */
> =20
>  #ifndef _ASM_CPUFEATURE_H
> @@ -53,6 +53,13 @@ static inline bool check_unaligned_access_emulated(int=
 cpu)
>  static inline void unaligned_emulation_finish(void) {}
>  #endif
> =20
> +DECLARE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
> +
> +static __always_inline bool has_fast_unaligned_accesses(void)
> +{
> +	return static_branch_likely(&fast_unaligned_access_speed_key);
> +}
> +
>  unsigned long riscv_get_elf_hwcap(void);
> =20
>  struct riscv_isa_ext_data {
> @@ -135,6 +142,4 @@ static __always_inline bool riscv_cpu_has_extension_u=
nlikely(int cpu, const unsi
>  	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
>  }
> =20
> -DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> -
>  #endif
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 89920f84d0a3..7878cddccc0d 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -810,14 +810,14 @@ static void check_unaligned_access_nonboot_cpu(void=
 *param)
>  		check_unaligned_access(pages[cpu]);
>  }
> =20
> -DEFINE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> +DEFINE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
> =20
>  static void modify_unaligned_access_branches(cpumask_t *mask, int weight)
>  {
>  	if (cpumask_weight(mask) =3D=3D weight)
> -		static_branch_enable_cpuslocked(&fast_misaligned_access_speed_key);
> +		static_branch_enable_cpuslocked(&fast_unaligned_access_speed_key);
>  	else
> -		static_branch_disable_cpuslocked(&fast_misaligned_access_speed_key);
> +		static_branch_disable_cpuslocked(&fast_unaligned_access_speed_key);
>  }
> =20
>  static void set_unaligned_access_static_branches_except_cpu(int cpu)
> diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
> index af3df5274ccb..7178e0acfa22 100644
> --- a/arch/riscv/lib/csum.c
> +++ b/arch/riscv/lib/csum.c
> @@ -3,7 +3,7 @@
>   * Checksum library
>   *
>   * Influenced by arch/arm64/lib/csum.c
> - * Copyright (C) 2023 Rivos Inc.
> + * Copyright (C) 2023-2024 Rivos Inc.
>   */
>  #include <linux/bitops.h>
>  #include <linux/compiler.h>
> @@ -318,10 +318,7 @@ unsigned int do_csum(const unsigned char *buff, int =
len)
>  	 * branches. The largest chunk of overlap was delegated into the
>  	 * do_csum_common function.
>  	 */
> -	if (static_branch_likely(&fast_misaligned_access_speed_key))
> -		return do_csum_no_alignment(buff, len);
> -
> -	if (((unsigned long)buff & OFFSET_MASK) =3D=3D 0)
> +	if (has_fast_unaligned_accesses() || (((unsigned long)buff & OFFSET_MAS=
K) =3D=3D 0))
>  		return do_csum_no_alignment(buff, len);
> =20
>  	return do_csum_with_alignment(buff, len);
>=20
> --=20
> 2.43.2
>=20

--sY3+K8PtRfDhOk5h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZelxZAAKCRB4tDGHoIJi
0hJKAQC2W/fGv9uhQGFJKKVUxs4qVTbkPKTSpM7O//BztxDsbQEAvy0LTEPXat2c
sWGUnjelciGQEV/dSAdDnYTNHFkXsws=
=wVOO
-----END PGP SIGNATURE-----

--sY3+K8PtRfDhOk5h--

