Return-Path: <linux-kernel+bounces-83826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FD0869EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45061C2819E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF0F158D92;
	Tue, 27 Feb 2024 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eaZlz6xQ"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6B44CB45
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057848; cv=none; b=pJyUzf7br712ukx18ybttMBRCWbdFQgORdHmVY9YiIr9gP44TlV02fOlsolDfkm2ZsbTtZo5kRD9fgl1jK5uM0EXc6speVip/NXutgMhqfWY2lwaT6kJ1QQxqcU7wicmiAHzdirEkEPS5NDAfq/BLWV+LFelwgrt9+5cQSpqTsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057848; c=relaxed/simple;
	bh=OEXbGYWFbhIYzCKV0yIkc9j7zt6nTGr1K3RgoCWdVYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzh2uBsol+KzK/lPBMRKBADKTAfzUrR5GSBbUsYUca+3PMRaCYy2nphVsb62lAAwiAip4NGExbzml6Iv6wrYlkOa9KFp990JZ8CJfKYeBOt64sC84rdPd7noovqk42FWyzvdqB4H6O8mpfptmPHPfx7h9zrf/cBa0BjTPz4ee0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=eaZlz6xQ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5e152c757a5so3435688a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709057845; x=1709662645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OUYBi4+KfOu0JAEtNL9AWAsUBQMXoYlnY+ySBFsQMrs=;
        b=eaZlz6xQ+cTEj1hEo/njD5d7gI7AXvQHZQT1z07LR32D459l76o17kYujR3hkxAtJ+
         A7GAzpypRQJ8pydwdZdB8Mgw5uHW8xS0vS/v9IyjdP9trDJrW8XAJcp51/Ilva1NwcUI
         7V5oVNDPzCSgWGVdD0N1ibg3nGHMTv41j2zDtoK2JhCWUs4tl9O9KTK0pVp226w5nbGz
         U4/bv6R0TbQ4XwEejHAjvK1D8+lolLdugHcSQONUIeQ8bfmK/CTSeIZ0zHj9UhnLKCU7
         0rw+okIfNuzeSnsRGEjut6G7CSLdhI9DEIMw3/4xeqYEtGXwscEnGv/FB4+4vyFsR8Z+
         6vdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709057845; x=1709662645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUYBi4+KfOu0JAEtNL9AWAsUBQMXoYlnY+ySBFsQMrs=;
        b=FxdrswSBWSRsloLFbCBWLmOulRgSqQM/yASESAL7HELnrL8+iQ+NWRkmIjAplZ8fnE
         144K/GjjC49LFtkxM1QPRv75IFNnoeQ7YOkYFreX3t1Wvt8tOQYlHbFe+vqxAjx6rhDY
         iCD0HfVbLppFwgxyXZLvTNcomaDzTL5qMokBoPFdUIVwtTE34kwguwlUeccpB7syZfaK
         kcuKeE/Q4U1X7qqieXzuUgyRehNurwEpGGC465rbf9qzDq4AKoHCq2qgwMsmMMDtDQqt
         W0m8hA6XAsxWGuFH5egQMdC2QI+FgncrdHOKT8RZPrwfileaGhfOrbZT9UJqhpz8o/9X
         B56g==
X-Forwarded-Encrypted: i=1; AJvYcCXBqsc6Omu2DXUVr/u3oRzl7PEMmr/rzGdjG4om6LYa/OSD5Kgt2WsbSlz/AC4GJU3tBQRpY8ojLRf8zPWTYXzNF+emorHcMkhJNQa7
X-Gm-Message-State: AOJu0YydxSMnO7BPTNz08W14Qe60CdoDsdijao9oMvSDwHF0ihxhpqrG
	zXc46pBL3O2njBNO4paEfrJ9KgfW/qyYff+iSA9CCuyWcQvAZD9wdQLtC4TYciY=
X-Google-Smtp-Source: AGHT+IHIzCgKUYaBLihRiZLAsPILDldDQpjFygUWyJUra30yXz5EZXV1H0/7xqOeMwDVdVeOg+aNkw==
X-Received: by 2002:a17:902:e809:b0:1dc:abe7:a1a6 with SMTP id u9-20020a170902e80900b001dcabe7a1a6mr6245406plg.17.1709057845372;
        Tue, 27 Feb 2024 10:17:25 -0800 (PST)
Received: from ghost ([2600:1010:b010:c64b:16cb:453c:679d:bee6])
        by smtp.gmail.com with ESMTPSA id km15-20020a17090327cf00b001dcabe7a182sm1821439plb.161.2024.02.27.10.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:17:24 -0800 (PST)
Date: Tue, 27 Feb 2024 10:17:21 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Charles Lohr <lohr85@gmail.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] riscv: Set unalignment speed at compile time
Message-ID: <Zd4nMa+x28omuhiF@ghost>
References: <20240216-disable_misaligned_probe_config-v4-0-dc01e581c0ac@rivosinc.com>
 <20240216-disable_misaligned_probe_config-v4-2-dc01e581c0ac@rivosinc.com>
 <20240227-condone-impeach-9469dffc6b47@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227-condone-impeach-9469dffc6b47@wendy>

On Tue, Feb 27, 2024 at 11:39:25AM +0000, Conor Dooley wrote:
> On Fri, Feb 16, 2024 at 12:33:19PM -0800, Charlie Jenkins wrote:
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
> >  arch/riscv/Kconfig                          |  58 +++++-
> >  arch/riscv/include/asm/cpufeature.h         |  30 +++-
> >  arch/riscv/kernel/Makefile                  |   6 +-
> >  arch/riscv/kernel/cpufeature.c              | 255 --------------------------
> >  arch/riscv/kernel/misaligned_access_speed.c | 265 ++++++++++++++++++++++++++++
> >  arch/riscv/kernel/probe_emulated_access.c   |  64 +++++++
> >  arch/riscv/kernel/sys_hwprobe.c             |  25 +++
> >  arch/riscv/kernel/traps_misaligned.c        |  54 +-----
> >  8 files changed, 442 insertions(+), 315 deletions(-)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index bffbd869a068..3cf700adc43b 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -690,25 +690,71 @@ config THREAD_SIZE_ORDER
> >  config RISCV_MISALIGNED
> 
> 
> Why can we not make up our minds on what to call this? The majority of
> users are "unaligned" but the file you add and this config option are
> "misaligned."

We have both everywhere, maybe we (I?) should go in and standardize the
wording everywhere. I personally prefer "misaligned" which means
"incorrectly aligned" over "unaligned" which means "not aligned" because
a 7-bit alignment is still "aligned" along a 7-bit boundary, but it is
certainly incorrectly aligned.

> 
> >  	bool "Support misaligned load/store traps for kernel and userspace"
> >  	select SYSCTL_ARCH_UNALIGN_ALLOW
> > +	depends on RISCV_PROBE_UNALIGNED_ACCESS || RISCV_EMULATED_UNALIGNED_ACCESS
> >  	default y
> >  	help
> >  	  Say Y here if you want the kernel to embed support for misaligned
> >  	  load/store for both kernel and userspace. When disable, misaligned
> >  	  accesses will generate SIGBUS in userspace and panic in kernel.
> >  
> > +choice
> > +	prompt "Unaligned Accesses Support"
> > +	default RISCV_PROBE_UNALIGNED_ACCESS
> > +	help
> > +	  This selects the hardware support for unaligned accesses. This
> > +	  information is used by the kernel to perform optimizations. It is also
> > +	  exposed to user space via the hwprobe syscall. The hardware will be
> > +	  probed at boot by default.
> > +
> > +config RISCV_PROBE_UNALIGNED_ACCESS
> > +	bool "Probe for hardware unaligned access support"
> > +	help
> > +	  During boot, the kernel will run a series of tests to determine the
> > +	  speed of unaligned accesses. This is the only portable option. This
> > +	  probing will dynamically determine the speed of unaligned accesses on
> > +	  the boot hardware.
> > +
> > +config RISCV_EMULATED_UNALIGNED_ACCESS
> > +	bool "Assume the CPU expects emulated unaligned memory accesses"
> > +	depends on NONPORTABLE
> 
> This is portable too, right?

I guess so? I think I would prefer to have the probing being the only
portable option.

> 
> > +	select RISCV_MISALIGNED
> > +	help
> > +	  Assume that the CPU expects emulated unaligned memory accesses.
> > +	  When enabled, this option notifies the kernel and userspace that
> > +	  unaligned memory accesses will be emulated by the kernel.
> 
> > To enforce
> > +	  this expectation, RISCV_MISALIGNED is selected by this option.
> 
> Drop this IMO, let Kconfig handle displaying the dependencies.
> 

I was debating if Kconfig handling was enough, so I am glad it is, I
will remove this.

> > +
> > +config RISCV_SLOW_UNALIGNED_ACCESS
> > +	bool "Assume the CPU supports slow unaligned memory accesses"
> > +	depends on NONPORTABLE
> > +	help
> > +	  Assume that the CPU supports slow unaligned memory accesses. When
> > +	  enabled, this option improves the performance of the kernel on such
> > +	  CPUs.
> 
> Does it? Are you sure that generating unaligned accesses on systems
> where they are slow is a performance increase?
> That said, I don't really see this option actually doing anything other
> than setting the value for hwprobe, so I don't actually know what the
> effect of this option actually is on the kernel's performance.
> 
> Generally I would like to suggest a change from "CPU" to "system" here,
> since the slow cases that exist are mostly because the unaligned access
> is actually emulated in firmware.

It would be ideal if "emulated" was used for any case of emulated
accesses (firmware or in the kernel).  Doing emulated accesses will be
orders of magnitude slower than a processor that "slowly" handles the
accesses.

So even if the processor performs a "slow" access, it could still be
beneficial for the kernel to do the misaligned access rather than manual
do the alignment.

Currently there is no place that takes into account this "slow" option
but I wanted to leave it open for future optimizations.

> 
> > However, the kernel will run much more slowly, or will not be
> > +	  able to run at all, on CPUs that do not support unaligned memory
> > +	  accesses.
> > +
> >  config RISCV_EFFICIENT_UNALIGNED_ACCESS
> >  	bool "Assume the CPU supports fast unaligned memory accesses"
> >  	depends on NONPORTABLE
> >  	select DCACHE_WORD_ACCESS if MMU
> >  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
> >  	help
> > -	  Say Y here if you want the kernel to assume that the CPU supports
> > -	  efficient unaligned memory accesses.  When enabled, this option
> > -	  improves the performance of the kernel on such CPUs.  However, the
> > -	  kernel will run much more slowly, or will not be able to run at all,
> > -	  on CPUs that do not support efficient unaligned memory accesses.
> > +	  Assume that the CPU supports fast unaligned memory accesses. When
> > +	  enabled, this option improves the performance of the kernel on such
> > +	  CPUs.  However, the kernel will run much more slowly, or will not be
> > +	  able to run at all, on CPUs that do not support efficient unaligned
> > +	  memory accesses.
> > +
> > +config RISCV_UNSUPPORTED_UNALIGNED_ACCESS
> 
> This option needs to be removed. The uabi states that unaligned access
> is supported in userspace, if the cpu or firmware does not implement
> unaligned access then the kernel must emulate it.

Should it removed from hwprobe as well then?

> 
> > +	bool "Assume the CPU doesn't support unaligned memory accesses"
> > +	depends on NONPORTABLE
> > +	help
> > +	  Assume that the CPU doesn't support unaligned memory accesses. Only
> > +	  select this option if there is no registered trap handler to emulate
> > +	  unaligned accesses.
> >  
> > -	  If unsure what to do here, say N.
> > +endchoice
> >  
> >  endmenu # "Platform type"
> 
> > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> > index eb3ac304fc42..928ad3384406 100644
> > --- a/arch/riscv/include/asm/cpufeature.h
> > +++ b/arch/riscv/include/asm/cpufeature.h
> > @@ -33,10 +33,26 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
> >  
> >  void riscv_user_isa_enable(void);
> >  
> > -#ifdef CONFIG_RISCV_MISALIGNED
> > +#if defined(CONFIG_RISCV_MISALIGNED)
> > +#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
> >  bool unaligned_ctl_available(void);
> >  bool check_unaligned_access_emulated(int cpu);
> >  void unaligned_emulation_finish(void);
> > +#elif defined(CONFIG_RISCV_EMULATED_UNALIGNED_ACCESS)
> > +static inline bool unaligned_ctl_available(void)
> > +{
> > +	return true;
> > +}
> > +
> > +static inline bool check_unaligned_access_emulated(int cpu)
> > +{
> > +	return true;
> > +}
> > +
> > +static inline void unaligned_emulation_finish(void) {}
> > +#else
> > +#error "CONFIG_RISCV_MISALIGNED is only supported if CONFIG_RISCV_PROBE_UNALIGNED_ACCESS or CONFIG_RISCV_EMULATED_UNALIGNED_ACCESS is selected."
> 
> Why is this an error? Enforce this in Kconfig (you already have) and drop
> the clause.

Awesome, I wasn't sure if the Kconfig was "enough".

- Charlie

> 
> Cheers,
> Conor.



