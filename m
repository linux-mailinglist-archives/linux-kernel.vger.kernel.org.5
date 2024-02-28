Return-Path: <linux-kernel+bounces-84839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2294886AC4E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E9C1F22AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9610712B16C;
	Wed, 28 Feb 2024 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJAHOj4z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB90A12A145
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709117005; cv=none; b=FVsAe9/9sHCfXJpuEMR0DR3w1yL99osTPr5egriyJYuYINnBvAKnRJ40Vll8W3bfMixY91SfhN4SY/FFlkK7/SpkBKZY9GaPn1HMqHSCgyhRXI0uEXedz5p1zTLz291I0+Wet3gF4p7Snjmlsae1vFebEEU7M25+fzFYa97O36I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709117005; c=relaxed/simple;
	bh=+PNQdYZp5tbsIrdA8nTu1RfAGQZkhr7Zkz00Q7/gAUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uK4A3om0B7HutBNoTzbCitsuPMEW1RAh8HkCTrC+DvDhKZXEwZy/RcE8Qmdi175lUnusDvvsShiItPszamVRJI/3QxLuZ32VUMcto9X4s+nacq9+w1oiZQ0U7XDbgE3jFz5pAIT+3iR0V0BOYkAMrODRqTVTBlTWtV7y2+eu9GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJAHOj4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A759EC433C7;
	Wed, 28 Feb 2024 10:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709117005;
	bh=+PNQdYZp5tbsIrdA8nTu1RfAGQZkhr7Zkz00Q7/gAUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eJAHOj4zdO9enJQy5VFMdXPDBguUh4tM/45N335HJWEfvQAZd4nTk7MQpqp/oNhkE
	 ouJd7dR7oo4uLOsusAg7Wqu/QxPRmL4vdSFA7bheMMK/yvgNwlcv66OEr2Fz42phdA
	 R9cD0+zmBSErmIdfMDw3GBPIB5I3rLcGX4BA8AHeQuAGFLnUhLi62TRsolSdEoTM8w
	 WmJDuX2VkdAiNvA56P7enErrMADYdQWQJLdyiudeT03pX342V5cRb+Z8VG+iNj+jgv
	 SjQ5TKjxvnNB6/4hh1/SxIwNaeaVbK3EwBftCI/YTijEvuDrK5yjIHqLuIJPNM/BxW
	 Hxt6XMkeBOE+w==
Date: Wed, 28 Feb 2024 10:43:20 +0000
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Charles Lohr <lohr85@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] riscv: Set unaligned access speed at compile time
Message-ID: <20240228-denote-subscribe-9832cddbd307@spud>
References: <20240227-disable_misaligned_probe_config-v5-0-b6853846e27a@rivosinc.com>
 <20240227-disable_misaligned_probe_config-v5-2-b6853846e27a@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0Z+bsYN10/Aht3x5"
Content-Disposition: inline
In-Reply-To: <20240227-disable_misaligned_probe_config-v5-2-b6853846e27a@rivosinc.com>


--0Z+bsYN10/Aht3x5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 03:13:14PM -0800, Charlie Jenkins wrote:
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwpr=
obe.c
> index a7c56b41efd2..69df8eaad9e7 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -147,8 +147,10 @@ static bool hwprobe_ext0_has(const struct cpumask *c=
pus, unsigned long ext)
>  	return (pair.value & ext);
>  }
> =20
> +#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
>  static u64 hwprobe_misaligned(const struct cpumask *cpus)
>  {

> +	return RISCV_HWPROBE_MISALIGNED_FAST;

This looks like a left over testing hack.

>  	int cpu;
>  	u64 perf =3D -1ULL;
> =20
> @@ -169,6 +171,27 @@ static u64 hwprobe_misaligned(const struct cpumask *=
cpus)
> =20
>  	return perf;
>  }
> +#elif defined(CONFIG_RISCV_EMULATED_UNALIGNED_ACCESS)
> +static u64 hwprobe_misaligned(const struct cpumask *cpus)
> +{
> +	return RISCV_HWPROBE_MISALIGNED_EMULATED;
> +}
> +#elif defined(CONFIG_RISCV_SLOW_UNALIGNED_ACCESS)
> +static u64 hwprobe_misaligned(const struct cpumask *cpus)
> +{
> +	return RISCV_HWPROBE_MISALIGNED_SLOW;
> +}
> +#elif defined(CONFIG_RISCV_EFFICIENT_UNALIGNED_ACCESS)
> +static u64 hwprobe_misaligned(const struct cpumask *cpus)
> +{
> +	return RISCV_HWPROBE_MISALIGNED_FAST;
> +}
> +#elif defined(CONFIG_RISCV_UNSUPPORTED_UNALIGNED_ACCESS)
> +static u64 hwprobe_misaligned(const struct cpumask *cpus)
> +{
> +	return RISCV_HWPROBE_MISALIGNED_UNSUPPORTED;
> +}
> +#endif

I'm curious why we need multiple definitions of this here. My first
question is why we cannot have
if (IS_ENABLED(foo))
	return bar;
inside the existing function for these cases.

My second question would be why fiddle with this in hwprobe at all?
I was specifically wondering why the kernel would not track this
information in the per-cpu variable misaligned_access_speed and the
syscall code could be left in the dark about how this is implemented.

> =20
>  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>  			     const struct cpumask *cpus)
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/tra=
ps_misaligned.c
> index 8ded225e8c5b..ba6763dd9895 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -398,8 +398,6 @@ union reg_data {
>  	u64 data_u64;
>  };
> =20
> -static bool unaligned_ctl __read_mostly;
> -
>  /* sysctl hooks */
>  int unaligned_enabled __read_mostly =3D 1;	/* Enabled by default */
> =20
> @@ -413,7 +411,9 @@ int handle_misaligned_load(struct pt_regs *regs)
> =20
>  	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
> =20
> +#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS

if (IS_ENABLED()), no?
But perhaps more interestingly - why is this being set here at all?
My understanding of the emulated stuff was that if the in-kernel
emulation was enabled, it would be used unless the CPU itself supported
fast accesses. I would expect this to be advertised to userspace once
the system has booted, not set the first time that a cpu emulates an
access,
I feel like I need to take a look at how this has been implemented, I
never really looked too closely at it and how it is enabled does not
match my expectations.

Cheers,
Conor.

>  	*this_cpu_ptr(&misaligned_access_speed) =3D RISCV_HWPROBE_MISALIGNED_EM=
ULATED;
> +#endif
> =20
>  	if (!unaligned_enabled)
>  		return -1;
> @@ -595,53 +595,3 @@ int handle_misaligned_store(struct pt_regs *regs)
> =20
>  	return 0;
>  }
> -
> -bool check_unaligned_access_emulated(int cpu)
> -{
> -	long *mas_ptr =3D per_cpu_ptr(&misaligned_access_speed, cpu);
> -	unsigned long tmp_var, tmp_val;
> -	bool misaligned_emu_detected;
> -
> -	*mas_ptr =3D RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> -
> -	__asm__ __volatile__ (
> -		"       "REG_L" %[tmp], 1(%[ptr])\n"
> -		: [tmp] "=3Dr" (tmp_val) : [ptr] "r" (&tmp_var) : "memory");
> -
> -	misaligned_emu_detected =3D (*mas_ptr =3D=3D RISCV_HWPROBE_MISALIGNED_E=
MULATED);
> -	/*
> -	 * If unaligned_ctl is already set, this means that we detected that all
> -	 * CPUS uses emulated misaligned access at boot time. If that changed
> -	 * when hotplugging the new cpu, this is something we don't handle.
> -	 */
> -	if (unlikely(unaligned_ctl && !misaligned_emu_detected)) {
> -		pr_crit("CPU misaligned accesses non homogeneous (expected all emulate=
d)\n");
> -		while (true)
> -			cpu_relax();
> -	}
> -
> -	return misaligned_emu_detected;
> -}
> -
> -void unaligned_emulation_finish(void)
> -{
> -	int cpu;
> -
> -	/*
> -	 * We can only support PR_UNALIGN controls if all CPUs have misaligned
> -	 * accesses emulated since tasks requesting such control can run on any
> -	 * CPU.
> -	 */
> -	for_each_present_cpu(cpu) {
> -		if (per_cpu(misaligned_access_speed, cpu) !=3D
> -					RISCV_HWPROBE_MISALIGNED_EMULATED) {
> -			return;
> -		}
> -	}
> -	unaligned_ctl =3D true;
> -}
> -
> -bool unaligned_ctl_available(void)
> -{
> -	return unaligned_ctl;
> -}
>=20
> --=20
> 2.43.2
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--0Z+bsYN10/Aht3x5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd8OSAAKCRB4tDGHoIJi
0ltiAQC8i6Hx0y+ThDW1JOhn9VP0EVcTCCjoHjdHFb3bJQv6dAEAqI6mYHq1XL/n
xcu3yEaeOzw+8xd7doxNLfYmIeuGLQg=
=Ba3T
-----END PGP SIGNATURE-----

--0Z+bsYN10/Aht3x5--

