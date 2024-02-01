Return-Path: <linux-kernel+bounces-48745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8E18460A9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C61B5B241B4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213B785269;
	Thu,  1 Feb 2024 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="o9XP5Wri"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AFD85272
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814619; cv=none; b=nVB6567D79QYF/YJ12wdw07lxSYCYuAnOWoTBKCvGf25dLU/I8w6ngPYgoMud+dtJS2RGywO22rj4o/HPAjw6/0gclG2WP5/nYy6NJWjcIF3mA15RTcMyt/omT8z6iUsw4eJQvdP/+5Mp3sJgNGT/0yj1jGjYE46Bzy3+5j0hTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814619; c=relaxed/simple;
	bh=tM6ftN8xLCUvdx4LF0ARdOgBsLNTOf/O/wITfqCXk2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+CnEy6k0FgWqOytmwoR2j4vTVeD6MSlN1gWJp0vadLyGgpKiitBOPyRCJVbMPRbxwa1R0HkOo7IREhYqZFqSLSgdkgutclkTGVCeHC5WnmTXDGlQWo61g5X/ASWmOm+qTUuRksuH/RMTQqsjytBmsYbNMeUHBtG0LzdYVl03cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=o9XP5Wri; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d71cb97937so12122705ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 11:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706814616; x=1707419416; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vnpiHKKwfUlrX0ITwOMT1EB7yYZoFWJ0YNJ6+FbPfrs=;
        b=o9XP5WrifhmtM7fwEPkhFLRnZTGE/Aq9gEgWXueL73vVGMjU0hVe0ltY/J4DQRpq/6
         gtRlPVubZBZRKZE6Q13vaUKixv6xgapxWfODTvM0n19AtVOdIz7+H44tvf6PEYEmCa8u
         Hs+yUImZx3/qXPVfokyTmZshqrASpotFI0UO3MCLbGgamUcctbiF+sgXShuOJO4R9y3v
         CJf6UMTURvmW/fIEUKEcCL1BzwV5KlXOwu7vYuCnoC5ZTHSmDJBx9BtsALutMVigZQkU
         pJ3b7lKXP757KCvs/gyHiOUtGGEIzNgUHqEm2C9vG8lfJQ7GUg6ZZcfcCTlWQ8t2FjKq
         /R3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814616; x=1707419416;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnpiHKKwfUlrX0ITwOMT1EB7yYZoFWJ0YNJ6+FbPfrs=;
        b=kHNOay/kk715sfISG3bW2RL0Zx0NzflJGKyphi+9tp0Q7tQGpp/bEuKRb5axbDTvLJ
         HwuoOF0sncr4/ojacmDOim/dx38r3DbgZ1p4s3a4cYnwkVnyqvMF5QBMDHdVUd0hdV5R
         VM+Kw0ppUO8gGGVf8gEJBqRv97KqbOmdCfYdON3MCUPoax3vmtK8wH6KU3oNW5wYcoTp
         tGQCGHF0EY27nh0qb/PQ9JkC4sRnyeFrI7dbPLlcUhSnhnkQaf7ygwnnerGAMkbnAYub
         f5+pIfMP6H/M90Cpefd/7nSrnUtVBGpKKQQP2+jX3kq+WqTYvCnTx+aCQI6P3un0kkVL
         vsAw==
X-Gm-Message-State: AOJu0Yy5+ghLvq+1JO5Nuazs23dArm+/bxMPhaNAqei4gguXOa+IhRXX
	Ifmj6awj5BmnKNk4jyn3sXJ1KlsfvP84uH2+5waWQvbi6o4iOk6ok5XRFQYZM8c=
X-Google-Smtp-Source: AGHT+IEEh6zIPPyE6ZPLLhCZk2+fdnD/jMzkQ1zdFt61aMYHO5D3OTV3KOoGih57XHhquKHsAfCVEg==
X-Received: by 2002:a17:902:d548:b0:1d9:3f27:42ed with SMTP id z8-20020a170902d54800b001d93f2742edmr6623789plf.1.1706814616495;
        Thu, 01 Feb 2024 11:10:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWHAG5I8gxxjoh1AcatD1SAqxpxtPf8UGxvX3r9GM+ywhtc7ieyu4nyEdFT14bR0Dl9mGMCVkxyxmavYj0PXoVxvgEKIxCME+s7wzJ0+dOGZ/QX8ahHPxJA6CZ0qb0XTtLFnwQXTSzQBoa6ak8envKP9+8pxcIhLMESiF2WBsv57BEVLCS/wwMVj3J53fScRU/FcL0eN4cNiCqNV41FAPETZ83vVm5wmvGjMI9nmLsniJFItPCAVTIIWdJf5EeJVQ==
Received: from ghost ([2601:647:5700:6860:9d41:fcba:2e6a:3328])
        by smtp.gmail.com with ESMTPSA id lb15-20020a170902fa4f00b001d934c80f73sm145938plb.241.2024.02.01.11.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 11:10:16 -0800 (PST)
Date: Thu, 1 Feb 2024 11:10:13 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: Disable misaligned access probe when
 CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
Message-ID: <Zbvslcl7YTy38HNF@ghost>
References: <20240131-disable_misaligned_probe_config-v1-0-98d155e9cda8@rivosinc.com>
 <20240131-disable_misaligned_probe_config-v1-2-98d155e9cda8@rivosinc.com>
 <48e6b009-c79c-4a2e-a532-e46c7b8b6fc8@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48e6b009-c79c-4a2e-a532-e46c7b8b6fc8@rivosinc.com>

On Thu, Feb 01, 2024 at 02:43:43PM +0100, Clément Léger wrote:
> 
> 
> On 01/02/2024 07:40, Charlie Jenkins wrote:
> > When CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is selected, the cpus can be
> > set to have fast misaligned access without needing to probe.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/cpufeature.h  | 7 +++++++
> >  arch/riscv/kernel/cpufeature.c       | 4 ++++
> >  arch/riscv/kernel/sys_hwprobe.c      | 4 ++++
> >  arch/riscv/kernel/traps_misaligned.c | 4 ++++
> >  4 files changed, 19 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> > index dfdcca229174..7d8d64783e38 100644
> > --- a/arch/riscv/include/asm/cpufeature.h
> > +++ b/arch/riscv/include/asm/cpufeature.h
> > @@ -137,10 +137,17 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
> >  	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
> >  }
> >  
> > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> >  DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> >  
> >  static __always_inline bool has_fast_misaligned_accesses(void)
> >  {
> >  	return static_branch_likely(&fast_misaligned_access_speed_key);
> >  }
> > +#else
> > +static __always_inline bool has_fast_misaligned_accesses(void)
> > +{
> > +	return true;
> > +}
> > +#endif
> >  #endif
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 89920f84d0a3..d787846c0b68 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -43,10 +43,12 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
> >  /* Per-cpu ISA extensions. */
> >  struct riscv_isainfo hart_isa[NR_CPUS];
> >  
> > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> >  /* Performance information */
> >  DEFINE_PER_CPU(long, misaligned_access_speed);
> >  
> >  static cpumask_t fast_misaligned_access;
> > +#endif
> >  
> >  /**
> >   * riscv_isa_extension_base() - Get base extension word
> > @@ -706,6 +708,7 @@ unsigned long riscv_get_elf_hwcap(void)
> >  	return hwcap;
> >  }
> >  
> > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> >  static int check_unaligned_access(void *param)
> >  {
> >  	int cpu = smp_processor_id();
> > @@ -946,6 +949,7 @@ static int check_unaligned_access_all_cpus(void)
> >  }
> >  
> >  arch_initcall(check_unaligned_access_all_cpus);
> > +#endif /* CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS */
> >  
> >  void riscv_user_isa_enable(void)
> >  {
> 
> Hi Charlie,
> 
> Generally, having so much ifdef in various pieces of code is probably
> not a good idea.
> 
> AFAICT, if CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is enabled, the whole
> misaligned access speed checking could be opt-out. which means that
> probably everything related to misaligned accesses should be moved in
> it's own file build it only for CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=n
> only.

I will look into doing something more clever here! I agree it is not
very nice to have so many ifdefs scattered.

> 
> > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> > index a7c56b41efd2..3f1a6edfdb08 100644
> > --- a/arch/riscv/kernel/sys_hwprobe.c
> > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > @@ -149,6 +149,7 @@ static bool hwprobe_ext0_has(const struct cpumask *cpus, unsigned long ext)
> >  
> >  static u64 hwprobe_misaligned(const struct cpumask *cpus)
> >  {
> > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> >  	int cpu;
> >  	u64 perf = -1ULL;
> >  
> > @@ -168,6 +169,9 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
> >  		return RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> >  
> >  	return perf;
> > +#else
> > +	return RISCV_HWPROBE_MISALIGNED_FAST;
> > +#endif
> >  }
> >  
> >  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
> > diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned> index 8ded225e8c5b..c24f79d769f6 100644
> > --- a/arch/riscv/kernel/traps_misaligned.c
> > +++ b/arch/riscv/kernel/traps_misaligned.c
> > @@ -413,7 +413,9 @@ int handle_misaligned_load(struct pt_regs *regs)
> >  
> >  	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
> >  
> > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> >  	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
> > +#endif
> 
> I think that rather using ifdefery inside this file (traps_misaligned.c)
>  it can be totally opt-out in case we have
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS since it implies that misaligned
> accesses are not emulated (at least that is my understanding).
> 

That's a great idea, I believe that is correct.

- Charlie

> Thanks,
> 
> Clément
> 
> 
> >  
> >  	if (!unaligned_enabled)
> >  		return -1;
> > @@ -596,6 +598,7 @@ int handle_misaligned_store(struct pt_regs *regs)
> >  	return 0;
> >  }
> >  
> > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> >  bool check_unaligned_access_emulated(int cpu)
> >  {
> >  	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
> > @@ -640,6 +643,7 @@ void unaligned_emulation_finish(void)
> >  	}
> >  	unaligned_ctl = true;
> >  }
> > +#endif
> >  
> >  bool unaligned_ctl_available(void)
> >  {
> > 
> 
> 
> 

