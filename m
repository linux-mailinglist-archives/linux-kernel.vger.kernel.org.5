Return-Path: <linux-kernel+bounces-48890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CC78462DD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F881C233B8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007083F8C3;
	Thu,  1 Feb 2024 21:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qmh82Q8c"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184123DBBB
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 21:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824187; cv=none; b=Jd/hp84cGSx2zoY21DluPP5TriFXP3rCoa9QxqsIgFredY7a+v3f6Yw5l6Vuods8qmx5R9IuQtyqXX/F0boeRRk4mgB43vulWT9MKd8Ferdv5ZpYCOgAbnd6vIh5LQrf/odf0XNpEaHziOVIZk4jND9BOvf/aBrWzJ8TacjzsYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824187; c=relaxed/simple;
	bh=8EFwgWlpHOyC1k+B9AkTA/n9fyHLXM8Rygo5e9uJonk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6Ad/P3l6XNAMqTSJsA5zMwooT7ps2ZDVfnE4uay4dg8JbmuXMuz+3HOZF6xoegk0Qwxbk3R1ZDViRP1AohkzarD1Re2fWC39u2WlbNIzf8VOkF3lDzCWNp5VWpkbzyl15SZoIjS87GEguCL5Ok3E/8o5A4UrW3+zgLKTUj/19Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qmh82Q8c; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6de28744a46so1087952b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 13:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706824184; x=1707428984; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oG7NBQ4bFtrw2hwU4RxQa/ZPxvhKKV36pfeutXbMKF4=;
        b=qmh82Q8cPriLnOoISPlZws7A0+h0R4JVjHpA/sJgVvM9SM2Wcqen7LTZTjcpJ+QVAU
         NB2M3OtG4UzmEP14hi7RfiPPGkwHcXdTryskWATgTezl2pvXjRgAMUiLa2ffaRshPYlH
         Gs/z2kgdqO42Lz0rBKX1IPotTCCenAdnsUsheE6fPe0K6XoZVLTVGz+2aRVIBQaIOpdK
         I9mQryOv30u+tNfyg4yfhS4iAvdY4gJMv9tsaghuNS4SXSjoPkQgVCSuRQyY78rmd7Lg
         KbEDkjWMUeVTpcCLCX2Ahi/3mn5lfckDxylENkudAH3FbjQ8b1vEtzRQW1ccuEnywSWR
         j8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706824184; x=1707428984;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oG7NBQ4bFtrw2hwU4RxQa/ZPxvhKKV36pfeutXbMKF4=;
        b=HkDlFe6wQ6al5BPQ73tpQAYle3Ll1IdkucE5NVnE5eOlKu1SsmnhlLRA8ZEq+n0B7W
         RJ1cajG+7G0O+XhnC7Ql81ltOAMcV1m6R+vZ/1ink1tpUOsvzujbyDJkEISvxCt3bazy
         QNdsVk8EFhHGLWKrAHdcKjxZsfOs1m3avwWy61YjlUSaId5YYxnRGuRZPsyIwnJh5n30
         KuK5ZKEhji9voFrcEKsUnF0wCJ8gG683a2pNk6xKTejvPloiWTys+AKruQKerBSaWDyP
         /rJOW+PznQtSQgKy9NxpK6VaBAYzf0trYwFfPFpPhYNLMYusCPhDyC1WRI4cBXucunnN
         PJqQ==
X-Gm-Message-State: AOJu0YzIpCGoWPisoVgxjkq3YnAjlpGejWyauByZUBu5rQgpsKHK7Sl7
	+FfKyGt3VK4htJom6ZuA12djGCpiC6ZG5onez1Uu+thZMKVnkrf/YMeF+BFXd+VGbI5WflQ1aJg
	vU2A=
X-Google-Smtp-Source: AGHT+IFaiNK4dD+Uo2q94OSpSJCPEcl+nMxlf2gqE/nDLsb71Umwi3+ih1anW8YdZeAqnJX3SeA3kQ==
X-Received: by 2002:a05:6a20:e61a:b0:19e:4007:aba9 with SMTP id my26-20020a056a20e61a00b0019e4007aba9mr3614744pzb.39.1706824184142;
        Thu, 01 Feb 2024 13:49:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVBTPLnzDj/zzXlKfWlB1CepPnGhls0B3I1nUDQLHJowA5cP9u/CfKIGt1p/Uf/zR5+hDIOU32hQv0P3YE+DO+Sxuj3XKialdPzLJzL2luBm75jpBSpGUrzn3myGfOdxgTazf+CfXR82VUWmPGJWXRYVxX7FSCR3S31Y4pI+1kotlB8xjFXd3tq/6zd12o7f3HoNQOFNUHOv0+41lHU6Y7LSa2LLjGltRg13Tjlb1G2YvTnkPlzFI2MjtKR7HQj5QDa747fWhD6jPLSS1juU9bobwDmvbyf7fxx
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id p14-20020a056a0026ce00b006dddd046e54sm214935pfw.206.2024.02.01.13.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 13:49:43 -0800 (PST)
Date: Thu, 1 Feb 2024 13:49:41 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Charles Lohr <lohr85@gmail.com>
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: Disable misaligned access probe when
 CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
Message-ID: <ZbwR9bk2z2meLmtz@ghost>
References: <20240131-disable_misaligned_probe_config-v1-0-98d155e9cda8@rivosinc.com>
 <20240131-disable_misaligned_probe_config-v1-2-98d155e9cda8@rivosinc.com>
 <48e6b009-c79c-4a2e-a532-e46c7b8b6fc8@rivosinc.com>
 <Zbvslcl7YTy38HNF@ghost>
 <CAGu26P85ZO1dY+qftMndKzwBpsA72x=KNWVyry=38uPhfuFweQ@mail.gmail.com>
 <ZbwDdLmO1l9WDLxF@ghost>
 <CAGu26P8j25EgeqCrVwxKgyeDKDrP4=tHVW-kRLcRQC8rk3Xqng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGu26P8j25EgeqCrVwxKgyeDKDrP4=tHVW-kRLcRQC8rk3Xqng@mail.gmail.com>

On Thu, Feb 01, 2024 at 01:39:53PM -0800, Charles Lohr wrote:
> I am very sorry for wasting your time - I did have it patched out in
> the build system here. I can't wait for this feature to land, so I can
> enjoy faster boot times without a patch.
> 
> Charles

No worries!

- Charlie

> 
> On Thu, Feb 1, 2024 at 12:47 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > On Thu, Feb 01, 2024 at 11:57:04AM -0800, Charles Lohr wrote:
> > > I am a little confused here - I was testing with 6.8-rc1 and it didn't
> > > seem to have the behavior of performing the probe (The probe kills
> > > boot performance in my application and I've had to patch out the probe
> > > in mid-6.x kernels).
> > >
> > > Did something get reverted to bring back the probe even when
> > > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=Y between rc1 and trunk?  Or am
> > > I misremembering/accidentally patched?
> >
> > After pulling a clean version of 6.8-rc1 and setting
> > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS I still see the probe happen.
> > Before sending this I looked for a patch that disabled the probe but was
> > unable to find one, if there exists a patch can you point me to it?
> >
> > - Charlie
> >
> > >
> > > On Thu, Feb 1, 2024 at 11:10 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > >
> > > > On Thu, Feb 01, 2024 at 02:43:43PM +0100, Clément Léger wrote:
> > > > >
> > > > >
> > > > > On 01/02/2024 07:40, Charlie Jenkins wrote:
> > > > > > When CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is selected, the cpus can be
> > > > > > set to have fast misaligned access without needing to probe.
> > > > > >
> > > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > > > ---
> > > > > >  arch/riscv/include/asm/cpufeature.h  | 7 +++++++
> > > > > >  arch/riscv/kernel/cpufeature.c       | 4 ++++
> > > > > >  arch/riscv/kernel/sys_hwprobe.c      | 4 ++++
> > > > > >  arch/riscv/kernel/traps_misaligned.c | 4 ++++
> > > > > >  4 files changed, 19 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> > > > > > index dfdcca229174..7d8d64783e38 100644
> > > > > > --- a/arch/riscv/include/asm/cpufeature.h
> > > > > > +++ b/arch/riscv/include/asm/cpufeature.h
> > > > > > @@ -137,10 +137,17 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
> > > > > >     return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
> > > > > >  }
> > > > > >
> > > > > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > > > >  DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> > > > > >
> > > > > >  static __always_inline bool has_fast_misaligned_accesses(void)
> > > > > >  {
> > > > > >     return static_branch_likely(&fast_misaligned_access_speed_key);
> > > > > >  }
> > > > > > +#else
> > > > > > +static __always_inline bool has_fast_misaligned_accesses(void)
> > > > > > +{
> > > > > > +   return true;
> > > > > > +}
> > > > > > +#endif
> > > > > >  #endif
> > > > > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > > > > > index 89920f84d0a3..d787846c0b68 100644
> > > > > > --- a/arch/riscv/kernel/cpufeature.c
> > > > > > +++ b/arch/riscv/kernel/cpufeature.c
> > > > > > @@ -43,10 +43,12 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
> > > > > >  /* Per-cpu ISA extensions. */
> > > > > >  struct riscv_isainfo hart_isa[NR_CPUS];
> > > > > >
> > > > > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > > > >  /* Performance information */
> > > > > >  DEFINE_PER_CPU(long, misaligned_access_speed);
> > > > > >
> > > > > >  static cpumask_t fast_misaligned_access;
> > > > > > +#endif
> > > > > >
> > > > > >  /**
> > > > > >   * riscv_isa_extension_base() - Get base extension word
> > > > > > @@ -706,6 +708,7 @@ unsigned long riscv_get_elf_hwcap(void)
> > > > > >     return hwcap;
> > > > > >  }
> > > > > >
> > > > > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > > > >  static int check_unaligned_access(void *param)
> > > > > >  {
> > > > > >     int cpu = smp_processor_id();
> > > > > > @@ -946,6 +949,7 @@ static int check_unaligned_access_all_cpus(void)
> > > > > >  }
> > > > > >
> > > > > >  arch_initcall(check_unaligned_access_all_cpus);
> > > > > > +#endif /* CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS */
> > > > > >
> > > > > >  void riscv_user_isa_enable(void)
> > > > > >  {
> > > > >
> > > > > Hi Charlie,
> > > > >
> > > > > Generally, having so much ifdef in various pieces of code is probably
> > > > > not a good idea.
> > > > >
> > > > > AFAICT, if CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is enabled, the whole
> > > > > misaligned access speed checking could be opt-out. which means that
> > > > > probably everything related to misaligned accesses should be moved in
> > > > > it's own file build it only for CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=n
> > > > > only.
> > > >
> > > > I will look into doing something more clever here! I agree it is not
> > > > very nice to have so many ifdefs scattered.
> > > >
> > > > >
> > > > > > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> > > > > > index a7c56b41efd2..3f1a6edfdb08 100644
> > > > > > --- a/arch/riscv/kernel/sys_hwprobe.c
> > > > > > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > > > > > @@ -149,6 +149,7 @@ static bool hwprobe_ext0_has(const struct cpumask *cpus, unsigned long ext)
> > > > > >
> > > > > >  static u64 hwprobe_misaligned(const struct cpumask *cpus)
> > > > > >  {
> > > > > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > > > >     int cpu;
> > > > > >     u64 perf = -1ULL;
> > > > > >
> > > > > > @@ -168,6 +169,9 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
> > > > > >             return RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> > > > > >
> > > > > >     return perf;
> > > > > > +#else
> > > > > > +   return RISCV_HWPROBE_MISALIGNED_FAST;
> > > > > > +#endif
> > > > > >  }
> > > > > >
> > > > > >  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
> > > > > > diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned> index 8ded225e8c5b..c24f79d769f6 100644
> > > > > > --- a/arch/riscv/kernel/traps_misaligned.c
> > > > > > +++ b/arch/riscv/kernel/traps_misaligned.c
> > > > > > @@ -413,7 +413,9 @@ int handle_misaligned_load(struct pt_regs *regs)
> > > > > >
> > > > > >     perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
> > > > > >
> > > > > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > > > >     *this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
> > > > > > +#endif
> > > > >
> > > > > I think that rather using ifdefery inside this file (traps_misaligned.c)
> > > > >  it can be totally opt-out in case we have
> > > > > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS since it implies that misaligned
> > > > > accesses are not emulated (at least that is my understanding).
> > > > >
> > > >
> > > > That's a great idea, I believe that is correct.
> > > >
> > > > - Charlie
> > > >
> > > > > Thanks,
> > > > >
> > > > > Clément
> > > > >
> > > > >
> > > > > >
> > > > > >     if (!unaligned_enabled)
> > > > > >             return -1;
> > > > > > @@ -596,6 +598,7 @@ int handle_misaligned_store(struct pt_regs *regs)
> > > > > >     return 0;
> > > > > >  }
> > > > > >
> > > > > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > > > >  bool check_unaligned_access_emulated(int cpu)
> > > > > >  {
> > > > > >     long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
> > > > > > @@ -640,6 +643,7 @@ void unaligned_emulation_finish(void)
> > > > > >     }
> > > > > >     unaligned_ctl = true;
> > > > > >  }
> > > > > > +#endif
> > > > > >
> > > > > >  bool unaligned_ctl_available(void)
> > > > > >  {
> > > > > >
> > > > >
> > > > >
> > > > >
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv

