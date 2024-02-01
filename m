Return-Path: <linux-kernel+bounces-48829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7D1846222
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46CBA2864ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627963BB2D;
	Thu,  1 Feb 2024 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OXe8tpiI"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEAD3A1BA
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706820473; cv=none; b=sKht3545s0rx6Uzl5OP4Yt1RKhHXCBUVV7y/nM9CDc4KvvOBbCCoaZ1nx++J5E2/odyRyorS04gRX/GnenAdRGZzLNJ6J1TB395U8N6BRX/BfspWC4YLwk8HW/nNDxH+d1xBcbR0fg3USvR6udCbiMQk/UdDZyOctXHn7ge3Y/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706820473; c=relaxed/simple;
	bh=8+xV4hM00I349jTbE0tWi8okdRXci+2FlIun4v7dDG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3FIp8LF+sl7/VyKlgtPyww9Xv0TTtplH1/bj05CO+SxZIH2zWvBcvQwNjYeF7h4dpkkuQwlMvOdNWvFecqx8XyzACHvLtBwrlh2q1WTtgFbyjUWYFhJbt/Nh/GVLkyYkB+1he3h3AU+1R5M4ynGtQWRyJZRolbcSGhLNnarS/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OXe8tpiI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d95d67ff45so5697425ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 12:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706820470; x=1707425270; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V5OFv3V9vAEx3/vFkSC2MQ2MFNooXfm20T7y4yL4xMo=;
        b=OXe8tpiIU28nZAX+qufo+iJ9/hfmJ4kzMF5QLpQoVl4jGj8ltcMOpc8HIR4IY+LBWm
         SKrKYc2TLYXXWLKm/49eU2MjLprdkf6udJpHV+Jwp3gwYQbnG/fs1HTxxYuaJxgXXvGN
         BR0LzfYRww3ksqkxsSWr802WhNJDN9akU/eFiGKOIJnrP4aOyeEJv24f+iqkEPijimx/
         FVKGMonBjG8vs15h/S3CsuP5cH8GrAm7UpJb3qvh2AFDTnlyAOVj0ptoJEke7EcxUFYK
         lclT+ZGtmohjYEaqNVarBJiup6jquT7Tg6DyfWaFCbVmzwyPcjzKlCzPBsbvZIzNYlzO
         K2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706820470; x=1707425270;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5OFv3V9vAEx3/vFkSC2MQ2MFNooXfm20T7y4yL4xMo=;
        b=DmBVhcb/X6q13r08Xz4UQOjM4tYLZRC5b5AQgxOmU4rvmnr+9z0XUOyCsTJaECCgP/
         QywbncqiJcwtxDQNS7YY4fVKbkXoK07hJt2z7FyvbWhvtG23YdzFfssAjMs8nrZ1u/DG
         KlZp6K6ggwf7QbRkb5iuyJSoFL9ASLWSEpvES4ET8LGM+ljKrjKUfOx2sgk/l0uk0Cmm
         bE0IAQCcpf4OPDULVkS3p3hiNYi/Ibk6iclbV12OvvqZq7CoEjsKREV9OoosVaIylB7t
         5gv/lJM3CVHUkuAUByIX3IA0ux3ORqdsaHwwvuq4xbN/qyVYy8cguPtA9X6tulQMOmKF
         Qu0Q==
X-Gm-Message-State: AOJu0Ywye7NvFQsk+Oq97jxwXSJNkx/x1V8zZhR2km9YcccF6vG2EGQC
	dbBiaaoe35NiH9e98MlbRITcmBq1Gpf5X3HqhiIwbstZVAFeA1p0VKcJMsDy50w=
X-Google-Smtp-Source: AGHT+IETKfl4OA1GZ8qBdST/c29q6Nx1vfHqTF5Ti6cPOho9knL2dpu/n3IyickJQBQ8qVAx/Vr2/g==
X-Received: by 2002:a17:90b:1196:b0:296:67b:eea0 with SMTP id gk22-20020a17090b119600b00296067beea0mr184787pjb.38.1706820470558;
        Thu, 01 Feb 2024 12:47:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVFaL7pxWSuq8dC99seakjEMZFyui3q7s2BZhpFYoVSG/AjHBCe7OrZeEqB+SGopkx/HRJZUO6JrSupiAZN+LE8933hIFcyrTRMMSDvke3byPI6NJIuvzL951EzpGtICSLBWWO+9ehHuSEIuby+VVHaY//1LgQmhoD0xXys1rSoqr3IshVuzLFDZKR6BG1rOQ9GphXo2F1ZV4LFhkbyNi0xUY2noEsUCDOIdgEZ4796EW3l7/QuVDP5wGnwMt7oqIY4RmVUmVKX/ll6vLnudNhTBfQPQT8Ltz3n
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id w14-20020a17090a780e00b002961a98c181sm1784666pjk.56.2024.02.01.12.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 12:47:50 -0800 (PST)
Date: Thu, 1 Feb 2024 12:47:48 -0800
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
Message-ID: <ZbwDdLmO1l9WDLxF@ghost>
References: <20240131-disable_misaligned_probe_config-v1-0-98d155e9cda8@rivosinc.com>
 <20240131-disable_misaligned_probe_config-v1-2-98d155e9cda8@rivosinc.com>
 <48e6b009-c79c-4a2e-a532-e46c7b8b6fc8@rivosinc.com>
 <Zbvslcl7YTy38HNF@ghost>
 <CAGu26P85ZO1dY+qftMndKzwBpsA72x=KNWVyry=38uPhfuFweQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGu26P85ZO1dY+qftMndKzwBpsA72x=KNWVyry=38uPhfuFweQ@mail.gmail.com>

On Thu, Feb 01, 2024 at 11:57:04AM -0800, Charles Lohr wrote:
> I am a little confused here - I was testing with 6.8-rc1 and it didn't
> seem to have the behavior of performing the probe (The probe kills
> boot performance in my application and I've had to patch out the probe
> in mid-6.x kernels).
> 
> Did something get reverted to bring back the probe even when
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=Y between rc1 and trunk?  Or am
> I misremembering/accidentally patched?

After pulling a clean version of 6.8-rc1 and setting
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS I still see the probe happen.
Before sending this I looked for a patch that disabled the probe but was
unable to find one, if there exists a patch can you point me to it?

- Charlie

> 
> On Thu, Feb 1, 2024 at 11:10 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > On Thu, Feb 01, 2024 at 02:43:43PM +0100, Clément Léger wrote:
> > >
> > >
> > > On 01/02/2024 07:40, Charlie Jenkins wrote:
> > > > When CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is selected, the cpus can be
> > > > set to have fast misaligned access without needing to probe.
> > > >
> > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > ---
> > > >  arch/riscv/include/asm/cpufeature.h  | 7 +++++++
> > > >  arch/riscv/kernel/cpufeature.c       | 4 ++++
> > > >  arch/riscv/kernel/sys_hwprobe.c      | 4 ++++
> > > >  arch/riscv/kernel/traps_misaligned.c | 4 ++++
> > > >  4 files changed, 19 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> > > > index dfdcca229174..7d8d64783e38 100644
> > > > --- a/arch/riscv/include/asm/cpufeature.h
> > > > +++ b/arch/riscv/include/asm/cpufeature.h
> > > > @@ -137,10 +137,17 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
> > > >     return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
> > > >  }
> > > >
> > > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > >  DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> > > >
> > > >  static __always_inline bool has_fast_misaligned_accesses(void)
> > > >  {
> > > >     return static_branch_likely(&fast_misaligned_access_speed_key);
> > > >  }
> > > > +#else
> > > > +static __always_inline bool has_fast_misaligned_accesses(void)
> > > > +{
> > > > +   return true;
> > > > +}
> > > > +#endif
> > > >  #endif
> > > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > > > index 89920f84d0a3..d787846c0b68 100644
> > > > --- a/arch/riscv/kernel/cpufeature.c
> > > > +++ b/arch/riscv/kernel/cpufeature.c
> > > > @@ -43,10 +43,12 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
> > > >  /* Per-cpu ISA extensions. */
> > > >  struct riscv_isainfo hart_isa[NR_CPUS];
> > > >
> > > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > >  /* Performance information */
> > > >  DEFINE_PER_CPU(long, misaligned_access_speed);
> > > >
> > > >  static cpumask_t fast_misaligned_access;
> > > > +#endif
> > > >
> > > >  /**
> > > >   * riscv_isa_extension_base() - Get base extension word
> > > > @@ -706,6 +708,7 @@ unsigned long riscv_get_elf_hwcap(void)
> > > >     return hwcap;
> > > >  }
> > > >
> > > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > >  static int check_unaligned_access(void *param)
> > > >  {
> > > >     int cpu = smp_processor_id();
> > > > @@ -946,6 +949,7 @@ static int check_unaligned_access_all_cpus(void)
> > > >  }
> > > >
> > > >  arch_initcall(check_unaligned_access_all_cpus);
> > > > +#endif /* CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS */
> > > >
> > > >  void riscv_user_isa_enable(void)
> > > >  {
> > >
> > > Hi Charlie,
> > >
> > > Generally, having so much ifdef in various pieces of code is probably
> > > not a good idea.
> > >
> > > AFAICT, if CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is enabled, the whole
> > > misaligned access speed checking could be opt-out. which means that
> > > probably everything related to misaligned accesses should be moved in
> > > it's own file build it only for CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=n
> > > only.
> >
> > I will look into doing something more clever here! I agree it is not
> > very nice to have so many ifdefs scattered.
> >
> > >
> > > > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> > > > index a7c56b41efd2..3f1a6edfdb08 100644
> > > > --- a/arch/riscv/kernel/sys_hwprobe.c
> > > > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > > > @@ -149,6 +149,7 @@ static bool hwprobe_ext0_has(const struct cpumask *cpus, unsigned long ext)
> > > >
> > > >  static u64 hwprobe_misaligned(const struct cpumask *cpus)
> > > >  {
> > > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > >     int cpu;
> > > >     u64 perf = -1ULL;
> > > >
> > > > @@ -168,6 +169,9 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
> > > >             return RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> > > >
> > > >     return perf;
> > > > +#else
> > > > +   return RISCV_HWPROBE_MISALIGNED_FAST;
> > > > +#endif
> > > >  }
> > > >
> > > >  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
> > > > diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned> index 8ded225e8c5b..c24f79d769f6 100644
> > > > --- a/arch/riscv/kernel/traps_misaligned.c
> > > > +++ b/arch/riscv/kernel/traps_misaligned.c
> > > > @@ -413,7 +413,9 @@ int handle_misaligned_load(struct pt_regs *regs)
> > > >
> > > >     perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
> > > >
> > > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > >     *this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
> > > > +#endif
> > >
> > > I think that rather using ifdefery inside this file (traps_misaligned.c)
> > >  it can be totally opt-out in case we have
> > > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS since it implies that misaligned
> > > accesses are not emulated (at least that is my understanding).
> > >
> >
> > That's a great idea, I believe that is correct.
> >
> > - Charlie
> >
> > > Thanks,
> > >
> > > Clément
> > >
> > >
> > > >
> > > >     if (!unaligned_enabled)
> > > >             return -1;
> > > > @@ -596,6 +598,7 @@ int handle_misaligned_store(struct pt_regs *regs)
> > > >     return 0;
> > > >  }
> > > >
> > > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > >  bool check_unaligned_access_emulated(int cpu)
> > > >  {
> > > >     long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
> > > > @@ -640,6 +643,7 @@ void unaligned_emulation_finish(void)
> > > >     }
> > > >     unaligned_ctl = true;
> > > >  }
> > > > +#endif
> > > >
> > > >  bool unaligned_ctl_available(void)
> > > >  {
> > > >
> > >
> > >
> > >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

