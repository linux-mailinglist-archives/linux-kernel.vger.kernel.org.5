Return-Path: <linux-kernel+bounces-48797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C3B8461B3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C121B2DBF1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20682127B49;
	Thu,  1 Feb 2024 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2C7GRIf"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A8D43AC7
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 19:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706817440; cv=none; b=tP65Thg3doTxH28uVepnLh5vwHH4LqMR9CYBYD2ktbDgbZZB/TrrSXEcESFuRQP1kFMhhTZnBlZ4VUzpFDC3CyhryDTEmNVoqQeBwh4eGEso/jhRxyfrZp6VPBCw7gOAgvb97PD/Vu1vCF1UNjV6IYd+9sYGYmriC70xcw9VhDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706817440; c=relaxed/simple;
	bh=MhU1cxNfDL9h10UBjWoX52LNOX/xG+PilXCypbWUPyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOWWvCrbVsdYCFj+PtHoeesmNtPxVQLMk/E17Gwzna893+WIPVNTbWIC8u0k8rAboKFgVO5F8qlGPmddVx2YrkbI0chSmWwXaPVujAWbH7K8KAKTZ7yuerbLcRABw+BeReEDRQLIAz9A+T9eWwSJHz4m7/zV6Au362qav6sMl8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2C7GRIf; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-511234430a4so2185302e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 11:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706817436; x=1707422236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3021VM+AzQ6ZeLoFr/6H0XVQqS/2Wt7K7IALF5phVY=;
        b=J2C7GRIfWwxNqOBavLNZ5nI3SjJfZR1W76GroxFIUf6j5Jl14GELmaMov96RbYrmER
         P4MKyS7JGNTs3CmZ1SzMBKVedp8MxWNbRzDxa6iFRznv2ITxVFaH8zAjcl4PUrvS73Yo
         1qRMRGKM3kindbte7jakgQi1YYg/handA9AD2Ls7cwrhdvm3/h+vj+forvyk8oIC5QWs
         J5PTzCbKhm0EmdFrgNJJl0Ot0Jlgsi03/AakjKG3dRD0afcO8PxOYROtsiILPVI379mT
         EDNRVZ2pDI3+2APBwPvy8KBaBzrF/C5GCIKssF+CQMY8yp3CguvvueZotZT5r5B0furZ
         meuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706817436; x=1707422236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3021VM+AzQ6ZeLoFr/6H0XVQqS/2Wt7K7IALF5phVY=;
        b=X6TyejWTpk3FmRFfll7juaAdmNRXkzz2+U37M/acv/oC+k7HgHh7H3sepL52duMi+f
         jPwWzkrFQDczip18PzOldV7Wq2HpGSsb2cnrE4JNHCnhS0funIguxO36o3eMLSo4lqgf
         4xJxqGOj9MHQZxn0sHSTYvgAzm1+1XNvG31SVoC/zRFDPgHHkWvvWGX9r5pWSWbh66XR
         3GTo09ZR0noDrnYlSHcW+KO96OH95j6/YsrIP52sOpCMU2BaRwv1tBTK75LvoyHzUoI/
         5sFIVf01h7o2yTAjKgOxWxDtQ3zV85gTEHqpFNjgVbSCWq4NlOwCFu5lUgr217SRw8T+
         6p5Q==
X-Gm-Message-State: AOJu0YxWPPKrQiaWuGhEf77MMbhfkQ9AYdmqJYRwiZaB4f49D2VKlH/n
	hqkU62CPBDuWAhISw1vUQEefof+CvzC9+m16Um8cO2y2dMT676U1/sz+LS7YAcCqJAaEDYslZQi
	ZwOLYHRfOsjYJimb/NzMzJTf3cQE=
X-Google-Smtp-Source: AGHT+IEL+1Id5JbB0KpcKfsYDu9j5VFxy4YYttvnukZ2wtdTLmliIK9RUEhbRanRVr91KaMO/3VLj6DKge1amnqIVZo=
X-Received: by 2002:a2e:8791:0:b0:2d0:8088:c069 with SMTP id
 n17-20020a2e8791000000b002d08088c069mr595286lji.30.1706817435960; Thu, 01 Feb
 2024 11:57:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131-disable_misaligned_probe_config-v1-0-98d155e9cda8@rivosinc.com>
 <20240131-disable_misaligned_probe_config-v1-2-98d155e9cda8@rivosinc.com>
 <48e6b009-c79c-4a2e-a532-e46c7b8b6fc8@rivosinc.com> <Zbvslcl7YTy38HNF@ghost>
In-Reply-To: <Zbvslcl7YTy38HNF@ghost>
From: Charles Lohr <lohr85@gmail.com>
Date: Thu, 1 Feb 2024 11:57:04 -0800
Message-ID: <CAGu26P85ZO1dY+qftMndKzwBpsA72x=KNWVyry=38uPhfuFweQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Disable misaligned access probe when CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>, 
	Evan Green <evan@rivosinc.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am a little confused here - I was testing with 6.8-rc1 and it didn't
seem to have the behavior of performing the probe (The probe kills
boot performance in my application and I've had to patch out the probe
in mid-6.x kernels).

Did something get reverted to bring back the probe even when
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3DY between rc1 and trunk?  Or am
I misremembering/accidentally patched?

On Thu, Feb 1, 2024 at 11:10=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> On Thu, Feb 01, 2024 at 02:43:43PM +0100, Cl=C3=A9ment L=C3=A9ger wrote:
> >
> >
> > On 01/02/2024 07:40, Charlie Jenkins wrote:
> > > When CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is selected, the cpus can=
 be
> > > set to have fast misaligned access without needing to probe.
> > >
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > >  arch/riscv/include/asm/cpufeature.h  | 7 +++++++
> > >  arch/riscv/kernel/cpufeature.c       | 4 ++++
> > >  arch/riscv/kernel/sys_hwprobe.c      | 4 ++++
> > >  arch/riscv/kernel/traps_misaligned.c | 4 ++++
> > >  4 files changed, 19 insertions(+)
> > >
> > > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include=
/asm/cpufeature.h
> > > index dfdcca229174..7d8d64783e38 100644
> > > --- a/arch/riscv/include/asm/cpufeature.h
> > > +++ b/arch/riscv/include/asm/cpufeature.h
> > > @@ -137,10 +137,17 @@ static __always_inline bool riscv_cpu_has_exten=
sion_unlikely(int cpu, const unsi
> > >     return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
> > >  }
> > >
> > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > >  DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> > >
> > >  static __always_inline bool has_fast_misaligned_accesses(void)
> > >  {
> > >     return static_branch_likely(&fast_misaligned_access_speed_key);
> > >  }
> > > +#else
> > > +static __always_inline bool has_fast_misaligned_accesses(void)
> > > +{
> > > +   return true;
> > > +}
> > > +#endif
> > >  #endif
> > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufe=
ature.c
> > > index 89920f84d0a3..d787846c0b68 100644
> > > --- a/arch/riscv/kernel/cpufeature.c
> > > +++ b/arch/riscv/kernel/cpufeature.c
> > > @@ -43,10 +43,12 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MA=
X) __read_mostly;
> > >  /* Per-cpu ISA extensions. */
> > >  struct riscv_isainfo hart_isa[NR_CPUS];
> > >
> > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > >  /* Performance information */
> > >  DEFINE_PER_CPU(long, misaligned_access_speed);
> > >
> > >  static cpumask_t fast_misaligned_access;
> > > +#endif
> > >
> > >  /**
> > >   * riscv_isa_extension_base() - Get base extension word
> > > @@ -706,6 +708,7 @@ unsigned long riscv_get_elf_hwcap(void)
> > >     return hwcap;
> > >  }
> > >
> > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > >  static int check_unaligned_access(void *param)
> > >  {
> > >     int cpu =3D smp_processor_id();
> > > @@ -946,6 +949,7 @@ static int check_unaligned_access_all_cpus(void)
> > >  }
> > >
> > >  arch_initcall(check_unaligned_access_all_cpus);
> > > +#endif /* CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS */
> > >
> > >  void riscv_user_isa_enable(void)
> > >  {
> >
> > Hi Charlie,
> >
> > Generally, having so much ifdef in various pieces of code is probably
> > not a good idea.
> >
> > AFAICT, if CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is enabled, the whole
> > misaligned access speed checking could be opt-out. which means that
> > probably everything related to misaligned accesses should be moved in
> > it's own file build it only for CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=
=3Dn
> > only.
>
> I will look into doing something more clever here! I agree it is not
> very nice to have so many ifdefs scattered.
>
> >
> > > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_=
hwprobe.c
> > > index a7c56b41efd2..3f1a6edfdb08 100644
> > > --- a/arch/riscv/kernel/sys_hwprobe.c
> > > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > > @@ -149,6 +149,7 @@ static bool hwprobe_ext0_has(const struct cpumask=
 *cpus, unsigned long ext)
> > >
> > >  static u64 hwprobe_misaligned(const struct cpumask *cpus)
> > >  {
> > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > >     int cpu;
> > >     u64 perf =3D -1ULL;
> > >
> > > @@ -168,6 +169,9 @@ static u64 hwprobe_misaligned(const struct cpumas=
k *cpus)
> > >             return RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> > >
> > >     return perf;
> > > +#else
> > > +   return RISCV_HWPROBE_MISALIGNED_FAST;
> > > +#endif
> > >  }
> > >
> > >  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
> > > diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel=
/traps_misaligned> index 8ded225e8c5b..c24f79d769f6 100644
> > > --- a/arch/riscv/kernel/traps_misaligned.c
> > > +++ b/arch/riscv/kernel/traps_misaligned.c
> > > @@ -413,7 +413,9 @@ int handle_misaligned_load(struct pt_regs *regs)
> > >
> > >     perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
> > >
> > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > >     *this_cpu_ptr(&misaligned_access_speed) =3D RISCV_HWPROBE_MISALIG=
NED_EMULATED;
> > > +#endif
> >
> > I think that rather using ifdefery inside this file (traps_misaligned.c=
)
> >  it can be totally opt-out in case we have
> > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS since it implies that misaligned
> > accesses are not emulated (at least that is my understanding).
> >
>
> That's a great idea, I believe that is correct.
>
> - Charlie
>
> > Thanks,
> >
> > Cl=C3=A9ment
> >
> >
> > >
> > >     if (!unaligned_enabled)
> > >             return -1;
> > > @@ -596,6 +598,7 @@ int handle_misaligned_store(struct pt_regs *regs)
> > >     return 0;
> > >  }
> > >
> > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > >  bool check_unaligned_access_emulated(int cpu)
> > >  {
> > >     long *mas_ptr =3D per_cpu_ptr(&misaligned_access_speed, cpu);
> > > @@ -640,6 +643,7 @@ void unaligned_emulation_finish(void)
> > >     }
> > >     unaligned_ctl =3D true;
> > >  }
> > > +#endif
> > >
> > >  bool unaligned_ctl_available(void)
> > >  {
> > >
> >
> >
> >
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

