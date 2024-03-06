Return-Path: <linux-kernel+bounces-94433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 871EC873FBC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1692F1F231B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2464513774C;
	Wed,  6 Mar 2024 18:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="E93zEFjq"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224FD13F010
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749961; cv=none; b=RSp0nqpI3wZ5pjcbD/wua4D2WqTtMhIpbpVrQuZihzwmKjNEQwETyJ5u946ZvJaWyIETMw2G/HYjiv3NEPtbR61xtzrsRTR+1eGMeSav9HD7HrPMP/uDDC/rW1w+4QzD/uvpBnubsrLUaMGgfCz3ABm0a7qiH/sNGSMSqpPb5W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749961; c=relaxed/simple;
	bh=olQTicqfYcmVTsm3FQKV2F3k0dMzmxjbtiI0dKzapRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOuXnIolshzuFGvuVjCZdlFOOazCAdH/9W8Its83JSRd4uKL2i8tGHtXY4BzaCzBk3sWLZyM6InHhHC3Bb9bbncAh0OTnS2UWVllZ0ZVIRcPGhLP9iI4HrU6eSU2X9BTgFVsYcsaDfc9VzlwvtWI17CdrXCDnLbM/gC80CUK24A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=E93zEFjq; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29b7b9a4908so551693a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 10:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709749958; x=1710354758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XfZjj69mDmLoiwD1gM4D487QZWwlC1Dl/rzDgzdNAo0=;
        b=E93zEFjq+aO6YnfTyp/TWQ5Dua7u8cwCqzNJU0chcIWqcSj22d5GhzoMdCDDjxjS5t
         nu0GaI/kL66gXFP29hs3RteYeiUf6WlcRpZcM92kEz+JtTqXrXWlqqS0Yi/HLIukzHTI
         p5K0KYaNP/AdUjOFCjTMjBMD8j4N+oNpD8veM7FPXIkpv1qyCxmfG4b2/jwr0XszwYgu
         H1CdVOZQ0mH3kts4LEuyD8vK+DgDVMQa44fDkYkaGvLGHW9aH9XRSKZ3HaJa4cufZWlD
         ODtrdWBqENoU5UfpG08XzXJ5gw8uuQewsEZ5PANNUmqNDcLLS4LibiuaAboHZYswyxKA
         3vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749958; x=1710354758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfZjj69mDmLoiwD1gM4D487QZWwlC1Dl/rzDgzdNAo0=;
        b=jwha1QwmIfh0yN+AX5AOXnl29GMWjC6/HPTWBRsoQVMIz/ASZ47dPs68NMkQjSYx63
         RpvV2w/LLGbirP2v0j7eDlYmj8o9YwrFeTp2k7g1u30n7EIr6zDe7EtqFh6KVuLKFrJy
         EUb/Zn60s8VvcbeAUrNkfQZV3dd+0Ne4M45zugN552O7dQOzI35owSKTD73zt/qH2QDK
         lG+o3Y/Kk0XnhyoETbiHIxWwT16hTXmK0etd2/4INFRCqQFhRFglNfCB4Oz6Ej0X1GS9
         IlZwrEDqquu658NoaY1dKhgo4rGTeheh7Vtg3IhsXUj3PfzTXnHTUoxUQIAu944lry7w
         hVCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJWJKuF1XBxiV2fVvKVzwmhrVT+SS+xlvQGC315jO5EpXh9Ff7VgHyJ86LsuTh/py36qj1XfAz1mBDO4/QcOheHbKLUHhENP4eskjb
X-Gm-Message-State: AOJu0Ywe/dtZahrRiseklORuw+pqrodjxzHFlwi3egXer0IAhx6k8xxa
	UGjvyomMP/5YXYNSGZw66flSehL+/Q5TO+Ns4TTr8LaTybmZwRAkadGfGtvq0Lw=
X-Google-Smtp-Source: AGHT+IGE0QhAzn32NXbkD7EesqkeigncptlI/KdVReqMmdcHMJEeZ5illDHoQWS5vVOvh7EgAo8WUQ==
X-Received: by 2002:a17:90b:b04:b0:29a:c89a:bcdb with SMTP id bf4-20020a17090b0b0400b0029ac89abcdbmr11603810pjb.46.1709749958262;
        Wed, 06 Mar 2024 10:32:38 -0800 (PST)
Received: from ghost ([2600:1010:b05d:dc52:3fa4:a88f:2bde:e9a])
        by smtp.gmail.com with ESMTPSA id ig11-20020a17090b154b00b0029b82aa1523sm36634pjb.28.2024.03.06.10.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 10:32:37 -0800 (PST)
Date: Wed, 6 Mar 2024 10:32:34 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
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
Subject: Re: [PATCH v6 4/4] riscv: Set unaligned access speed at compile time
Message-ID: <Zei2wrx4oFB5lj6i@ghost>
References: <20240301-disable_misaligned_probe_config-v6-0-612ebd69f430@rivosinc.com>
 <20240301-disable_misaligned_probe_config-v6-4-612ebd69f430@rivosinc.com>
 <20240306-bring-gullible-72ec4260fd56@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306-bring-gullible-72ec4260fd56@spud>

On Wed, Mar 06, 2024 at 04:19:33PM +0000, Conor Dooley wrote:
> Hey,
> 
> On Fri, Mar 01, 2024 at 05:45:35PM -0800, Charlie Jenkins wrote:
> > Introduce Kconfig options to set the kernel unaligned access support.
> > These options provide a non-portable alternative to the runtime
> > unaligned access probe.
> > 
> > To support this, the unaligned access probing code is moved into it's
> > own file and gated behind a new RISCV_PROBE_UNALIGNED_ACCESS_SUPPORT
> > option.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/Kconfig                         |  58 ++++--
> >  arch/riscv/include/asm/cpufeature.h        |  26 +--
> >  arch/riscv/kernel/Makefile                 |   4 +-
> >  arch/riscv/kernel/cpufeature.c             | 272 ----------------------------
> >  arch/riscv/kernel/sys_hwprobe.c            |  21 +++
> >  arch/riscv/kernel/traps_misaligned.c       |   2 +
> >  arch/riscv/kernel/unaligned_access_speed.c | 282 +++++++++++++++++++++++++++++
> >  7 files changed, 369 insertions(+), 296 deletions(-)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index bffbd869a068..60b6de35599d 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -688,27 +688,61 @@ config THREAD_SIZE_ORDER
> >  	  affects irq stack size, which is equal to thread stack size.
> >  
> >  config RISCV_MISALIGNED
> > -	bool "Support misaligned load/store traps for kernel and userspace"
> > +	bool
> >  	select SYSCTL_ARCH_UNALIGN_ALLOW
> > -	default y
> >  	help
> > -	  Say Y here if you want the kernel to embed support for misaligned
> > -	  load/store for both kernel and userspace. When disable, misaligned
> > -	  accesses will generate SIGBUS in userspace and panic in kernel.
> > +	  Embed support for misaligned load/store for both kernel and userspace.
> > +	  When disabled, misaligned accesses will generate SIGBUS in userspace
> > +	  and panic in kernel.
> 
> "in the kernel".
> 
> > +
> > +choice
> > +	prompt "Unaligned Accesses Support"
> > +	default RISCV_PROBE_UNALIGNED_ACCESS
> > +	help
> 
> > +	  This selects the hardware support for unaligned accesses. This
> 
> "This determines what level of support for..."
> 
> > +	  information is used by the kernel to perform optimizations. It is also
> > +	  exposed to user space via the hwprobe syscall. The hardware will be
> > +	  probed at boot by default.
> > +
> > +config RISCV_PROBE_UNALIGNED_ACCESS
> > +	bool "Probe for hardware unaligned access support"
> > +	select RISCV_MISALIGNED
> > +	help
> > +	  During boot, the kernel will run a series of tests to determine the
> > +	  speed of unaligned accesses. This probing will dynamically determine
> > +	  the speed of unaligned accesses on the boot hardware.
> 
> "on the underlying system"?
> 
> > The kernel will
> > +	  also check if unaligned memory accesses will trap into the kernel and
> > +	  handle such traps accordingly.
> 
> I think I would phrase this to be more understandable to users. I think
> we need to explain why it would trap and what we will do. Maybe
> something like: "if unaligned memory accesses trap into the kernel as
> they are not supported by the system, the kernel will emulate the
> unaligned accesses to preserve the UABI".
> 
> > +config RISCV_EMULATED_UNALIGNED_ACCESS
> > +	bool "Assume the system expects emulated unaligned memory accesses"
> > +	select RISCV_MISALIGNED
> > +	help
> > +	  Assume that the system expects unaligned memory accesses to be
> > +	  emulated. The kernel will check if unaligned memory accesses will
> > +	  trap into the kernel and handle such traps accordingly.
> 
> I guess the same suggestion applies here, but I think the description
> here isn't quite accurate. This option is basically the same as above,
> but without the speed test, right? It doesn't actually assume emulation
> is required at all, in fact the assumption we make is that if the
> hardware supports unaligned access that access is slow.
> 
> I think I'd do:
> ```
> boot "Emulate unaligned access where system support is missing"
> help
>   If unaligned accesses trap into the kernel as they are not supported
>   by the system, the kernel will emulate the unaligned accesses to
>   preserve the UABI. When the underlying system does support unaligned
>   accesses, probing at boot is not done and unaligned accesses are
>   assumed to be slow.

Great suggestions thank you. I think I will change up the second
sentence a little bit to be "When the underlying system does support
unaligned accesses, the unaligned accesses are assumed to be slow."

> 
> > +config RISCV_SLOW_UNALIGNED_ACCESS
> > +	bool "Assume the system supports slow unaligned memory accesses"
> > +	depends on NONPORTABLE
> > +	help
> > +	  Assume that the system supports slow unaligned memory accesses. The
> > +	  kernel may not be able to run at all on systems that do not support
> > +	  unaligned memory accesses.
> 
> ...and userspace programs cannot use unaligned access either, I think
> that is worth mentioning.
> 
> >  
> >  config RISCV_EFFICIENT_UNALIGNED_ACCESS
> > -	bool "Assume the CPU supports fast unaligned memory accesses"
> > +	bool "Assume the system supports fast unaligned memory accesses"
> >  	depends on NONPORTABLE
> >  	select DCACHE_WORD_ACCESS if MMU
> >  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
> >  	help
> > -	  Say Y here if you want the kernel to assume that the CPU supports
> > -	  efficient unaligned memory accesses.  When enabled, this option
> > -	  improves the performance of the kernel on such CPUs.  However, the
> > -	  kernel will run much more slowly, or will not be able to run at all,
> > -	  on CPUs that do not support efficient unaligned memory accesses.
> > +	  Assume that the system supports fast unaligned memory accesses. When
> > +	  enabled, this option improves the performance of the kernel on such
> > +	  systems.  However, the kernel will run much more slowly, or will not
> > +	  be able to run at all, on systems that do not support efficient
> > +	  unaligned memory accesses.
> >  
> > -	  If unsure what to do here, say N.
> > +endchoice
> >  
> >  endmenu # "Platform type"
> 
> > +#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
> >  DECLARE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
> >  
> >  static __always_inline bool has_fast_unaligned_accesses(void)
> >  {
> >  	return static_branch_likely(&fast_unaligned_access_speed_key);
> >  }
> > +#elif defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
> > +static __always_inline bool has_fast_unaligned_accesses(void)
> > +{
> > +	return true;
> > +}
> > +#else
> > +static __always_inline bool has_fast_unaligned_accesses(void)
> > +{
> > +	return false;
> > +}
> > +#endif
> 
> These tree could just be one function with if(IS_ENABLED), whatever code
> gets made dead should be optimised out.
> 

Sure, will do.

> > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> > index a7c56b41efd2..dad02f5faec3 100644
> > --- a/arch/riscv/kernel/sys_hwprobe.c
> > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > @@ -147,8 +147,10 @@ static bool hwprobe_ext0_has(const struct cpumask *cpus, unsigned long ext)
> >  	return (pair.value & ext);
> >  }
> >  
> > +#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
> >  static u64 hwprobe_misaligned(const struct cpumask *cpus)
> >  {
> > +	return RISCV_HWPROBE_MISALIGNED_FAST;
> 
> This hack is still here.

Oh no! I removed it locally but it snuck back in...

> 
> >  	int cpu;
> >  	u64 perf = -1ULL;
> >  
> > @@ -169,6 +171,25 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
> >  
> >  	return perf;
> >  }
> 
> > +#elif defined(CONFIG_RISCV_EMULATED_UNALIGNED_ACCESS)
> > +static u64 hwprobe_misaligned(const struct cpumask *cpus)
> > +{
> > +	if (unaligned_ctl_available())
> > +		return RISCV_HWPROBE_MISALIGNED_EMULATED;
> > +	else
> > +		return RISCV_HWPROBE_MISALIGNED_SLOW;
> > +}
> > +#elif defined(CONFIG_RISCV_SLOW_UNALIGNED_ACCESS)
> > +static u64 hwprobe_misaligned(const struct cpumask *cpus)
> > +{
> > +	return RISCV_HWPROBE_MISALIGNED_SLOW;
> > +}
> > +#elif defined(CONFIG_RISCV_EFFICIENT_UNALIGNED_ACCESS)
> > +static u64 hwprobe_misaligned(const struct cpumask *cpus)
> > +{
> > +	return RISCV_HWPROBE_MISALIGNED_FAST;
> > +}
> > +#endif
> 
> Same applies to these three functions.
> 
> Thanks,
> Conor.

Thank you, I will send out a new version shortly.

- Charlie


