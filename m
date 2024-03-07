Return-Path: <linux-kernel+bounces-95092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EF4874925
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928F11C21750
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A2663128;
	Thu,  7 Mar 2024 07:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZWRnljvn"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9608E6310D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709798144; cv=none; b=lp7xAlns5VXmwCda59Ex+Jwx+Gvoe0P5vNzYXiEIhRsHKhxpxUwkNTfFvO29PoJ+3hv0RxH8T9aKOZqfbwEOtQJj6ct6zzB/KBHaKJBcLzLZ/yAR/T3LKQ23kwbp30xoNBQDBr9csGBOk72mdEJX0eS69nDE5tJFLAlnNVq0azE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709798144; c=relaxed/simple;
	bh=hJjhdaNUwAxii5nQBmY/ltozS1ZCFSHYR02AZtzuvzM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXyldW246jFsP0V+l6yPlPmZGPzCvpw8aEHL5puhRH6rDmLrKYdisdnAWGBFdOU76UtJfZGmfB2Z0n9SBejK3u+az8kOGyrthZZm6pEWDOEgHkPQrVmmmso05gwvi3Ghp1DHd+d8KnHvL4a9DOZIJUjY9RfUBruuLhr5ZnPNVcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZWRnljvn; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709798143; x=1741334143;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hJjhdaNUwAxii5nQBmY/ltozS1ZCFSHYR02AZtzuvzM=;
  b=ZWRnljvnwDNoVc2Izc7kqTA8RRWbC9IWubyEAlzqS+2sOVO8ll2GEBtY
   J7W5SI6JE/LUy4gCJrLkBuaMS3gwbB8GlrF/x6LSJY4fviAchspBTN/+4
   UIEqBds5kHAZAtAUg3BV8bqxhMiZSkugxJsaHhTYrkbWXoNPaollJfOR5
   dNVlXDUI/SBOEcvJG6NRfOUD4mWJ+heX9GwQbObCMu2RZ/QfXA/qiSw5m
   8Nh0XcBJymDSx1buRz8OBBcp7jJPgqTVqMha4pmuOK/sXlad6bSaERY1G
   B/tU9dfBt7zaijNmY1muWbgWuEpgKcHJW+gT68Ty5GU90CPHU59qFT9nL
   w==;
X-CSE-ConnectionGUID: yLB2gpleSK6dHLSN/Bgr/Q==
X-CSE-MsgGUID: MZdFEMxTQiiSfCbGlN/hYA==
X-IronPort-AV: E=Sophos;i="6.06,210,1705388400"; 
   d="asc'?scan'208";a="17336139"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2024 00:55:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 00:55:20 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 7 Mar 2024 00:55:18 -0700
Date: Thu, 7 Mar 2024 07:54:34 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Charlie Jenkins <charlie@rivosinc.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang
	<jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>, Eric Biggers
	<ebiggers@kernel.org>, Elliot Berman <quic_eberman@quicinc.com>, Charles Lohr
	<lohr85@gmail.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 3/4] riscv: Decouple emulated unaligned accesses from
 access speed
Message-ID: <20240307-during-unlovely-d5c3cd6dc4a6@wendy>
References: <20240306-disable_misaligned_probe_config-v7-0-6c90419e7a96@rivosinc.com>
 <20240306-disable_misaligned_probe_config-v7-3-6c90419e7a96@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yMPX+f2X0itTroHT"
Content-Disposition: inline
In-Reply-To: <20240306-disable_misaligned_probe_config-v7-3-6c90419e7a96@rivosinc.com>

--yMPX+f2X0itTroHT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 12:00:03PM -0800, Charlie Jenkins wrote:
> Detecting if a system traps into the kernel on an unaligned access
> can be performed separately from checking the speed of unaligned
> accesses. This decoupling will make it possible to selectively enable
> or disable each of these checks

> as is done in the following patch.

nit: these sort of comments can bitrot if things get backported or
may not be accurate if only partial series get applied to a branch.

> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  arch/riscv/include/asm/cpufeature.h  |  2 +-
>  arch/riscv/kernel/cpufeature.c       | 25 +++++++++++++++++++++----
>  arch/riscv/kernel/traps_misaligned.c | 15 +++++++--------
>  3 files changed, 29 insertions(+), 13 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index 466e1f591919..6fec91845aa0 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -37,7 +37,7 @@ void riscv_user_isa_enable(void);
> =20
>  #ifdef CONFIG_RISCV_MISALIGNED
>  bool unaligned_ctl_available(void);
> -bool check_unaligned_access_emulated(int cpu);
> +bool check_unaligned_access_emulated_all_cpus(void);
>  void unaligned_emulation_finish(void);
>  #else
>  static inline bool unaligned_ctl_available(void)
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 7878cddccc0d..abb3a2f53106 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -719,7 +719,8 @@ static int check_unaligned_access(void *param)
>  	void *src;
>  	long speed =3D RISCV_HWPROBE_MISALIGNED_SLOW;
> =20
> -	if (check_unaligned_access_emulated(cpu))
> +	if (IS_ENABLED(CONFIG_RISCV_MISALIGNED) &&
> +	    per_cpu(misaligned_access_speed, cpu) !=3D RISCV_HWPROBE_MISALIGNED=
_UNKNOWN)
>  		return 0;
> =20
>  	/* Make an unaligned destination buffer. */
> @@ -896,8 +897,8 @@ static int riscv_offline_cpu(unsigned int cpu)
>  	return 0;
>  }
> =20
> -/* Measure unaligned access on all CPUs present at boot in parallel. */
> -static int check_unaligned_access_all_cpus(void)
> +/* Measure unaligned access speed on all CPUs present at boot in paralle=
l. */
> +static int check_unaligned_access_speed_all_cpus(void)
>  {
>  	unsigned int cpu;
>  	unsigned int cpu_count =3D num_possible_cpus();
> @@ -935,7 +936,6 @@ static int check_unaligned_access_all_cpus(void)
>  				  riscv_online_cpu, riscv_offline_cpu);
> =20
>  out:
> -	unaligned_emulation_finish();
>  	for_each_cpu(cpu, cpu_online_mask) {
>  		if (bufs[cpu])
>  			__free_pages(bufs[cpu], MISALIGNED_BUFFER_ORDER);
> @@ -945,6 +945,23 @@ static int check_unaligned_access_all_cpus(void)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_RISCV_MISALIGNED
> +static int check_unaligned_access_all_cpus(void)
> +{
> +	bool all_cpus_emulated =3D check_unaligned_access_emulated_all_cpus();
> +
> +	if (!all_cpus_emulated)
> +		return check_unaligned_access_speed_all_cpus();
> +
> +	return 0;
> +}
> +#else
> +static int check_unaligned_access_all_cpus(void)
> +{
> +	return check_unaligned_access_speed_all_cpus();
> +}
> +#endif
> +
>  arch_initcall(check_unaligned_access_all_cpus);
> =20
>  void riscv_user_isa_enable(void)
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/tra=
ps_misaligned.c
> index c2ed4e689bf9..e55718179f42 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -596,7 +596,7 @@ int handle_misaligned_store(struct pt_regs *regs)
>  	return 0;
>  }
> =20
> -bool check_unaligned_access_emulated(int cpu)
> +static bool check_unaligned_access_emulated(int cpu)
>  {
>  	long *mas_ptr =3D per_cpu_ptr(&misaligned_access_speed, cpu);
>  	unsigned long tmp_var, tmp_val;
> @@ -623,7 +623,7 @@ bool check_unaligned_access_emulated(int cpu)
>  	return misaligned_emu_detected;
>  }
> =20
> -void unaligned_emulation_finish(void)
> +bool check_unaligned_access_emulated_all_cpus(void)
>  {
>  	int cpu;
> =20
> @@ -632,13 +632,12 @@ void unaligned_emulation_finish(void)
>  	 * accesses emulated since tasks requesting such control can run on any
>  	 * CPU.
>  	 */
> -	for_each_online_cpu(cpu) {
> -		if (per_cpu(misaligned_access_speed, cpu) !=3D
> -					RISCV_HWPROBE_MISALIGNED_EMULATED) {
> -			return;
> -		}
> -	}
> +	for_each_online_cpu(cpu)
> +		if (!check_unaligned_access_emulated(cpu))
> +			return false;
> +
>  	unaligned_ctl =3D true;
> +	return true;
>  }
> =20
>  bool unaligned_ctl_available(void)
>=20
> --=20
> 2.43.2
>=20

--yMPX+f2X0itTroHT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZelyugAKCRB4tDGHoIJi
0g3VAP9QiE8HW9ysP2EHv2XnwmEKajEm0LsQscHBZIVHRWhFYQEAvADvRw/xG0WR
7PP/F8RBUjLO3kGm9BX/dVzrWZ0I9gk=
=bbOd
-----END PGP SIGNATURE-----

--yMPX+f2X0itTroHT--

