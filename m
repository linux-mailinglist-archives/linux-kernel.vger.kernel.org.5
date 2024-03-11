Return-Path: <linux-kernel+bounces-98445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFF4877A40
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3CB2820DC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6F11C33;
	Mon, 11 Mar 2024 04:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CCYm4irL"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDCA17D2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 04:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710129872; cv=none; b=lvmUa+ayLgY6dK6ip+N3a7vge+jcI+v+1z3X5yl0aFpdBwreTvNcP8YBI7Wi3excfrQI9uk31KoO6P82zIKootVgXQABKDYwwZmeh1F5CH2yHYi6sNeSPw8JY1uP+GhKUqNBxYiSQmuleky72bB1cwk0P6X7dBECnSvYNYJ7q7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710129872; c=relaxed/simple;
	bh=foN6BR5gdVPm2+qQpYFEVbhdqFWIb+9e1nLhjYipYXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOgiqPKDkDkyqzbq1veJaplCcCXZlrxjpCXdvuNKRYeBgEpoOqtlB5GRVhv6jwhoc6GhU1c5e0mByxTCraPSQpkRne0aGx1Qq4iWn6hmCSM6TAPVhyJ4do7646ObchML9LnOm7qLaFBFqmj0H5mnSBVHBw9E+aJ67Tg7tLb5e90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CCYm4irL; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51344bebe2fso2479106e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 21:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1710129868; x=1710734668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xc6qlt3tYz1xU+agIFUlEMelM1Chn1nFipeeGtEvSt8=;
        b=CCYm4irL9D+3UnWP1qrir/de+bCnCZh7A2yNbjOyHt9wNlws4cWOJWHJeIwZKZCCRl
         VJBfWhxkDgDHGdir7AtG7RZYqBT8hPbtOVAaDjZYPbX7PusWgfXD6smlXmvbD12xgxyG
         sC+NFpxSm1a4OU1EtXsPEKDbzYnFmXBwifvDAGj1EcMQr6PlpkXW6Nt7Naev9Mx7i6mT
         h4wi8MZAyavAiAvt2lVayBe11zkjQVk0znr7PPY1ZFvmI7WbZdDJgNj34seyVnErgBDn
         b1XbocaI2yA2QiEiNNtgenB5iVVJARYuwXEytjlDgGdJwdxxbD98/7oPRgjjqLoM75ba
         i7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710129868; x=1710734668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xc6qlt3tYz1xU+agIFUlEMelM1Chn1nFipeeGtEvSt8=;
        b=ZZf3Sj3BURhDdheYJweV4IVLtoMJuUm+4HVbOeOzS3I3ria47AW2LVyX0OrcXa99TT
         TRFwMMpvXbwyAtAmnNIoOVh7vwnV+NSAT6aVgrGJW7YofED4fhYoEO1xWOWXhVgTqCIC
         +PrRal5nlk9MjtG8TDk9/QF8zolJm+D/L6FIhtOYvYb42YzTQAPNpUlu3KJkyF4XinFj
         umq9tlHi7DViM6oqaf11MSqLUme0pYS5uGBjVh/JchyOy9njgiy/ET87QiXry83nayMh
         SxetartLwYDfDI6D3TmRSy94YS/QhRpNNog0E4HMKzdwwdealx6TkmSEkiXiexF0poQw
         3BTg==
X-Forwarded-Encrypted: i=1; AJvYcCULSCedOhDQbtKnBw/K/h13pzJUZ3ILjSh9WF5nWQXglXbElMQ702o9TADWgndluG4OTl30sOsyExQ/IhLX1+l96/QLqlLv6Q7XNTum
X-Gm-Message-State: AOJu0YwDGABbjSoOAnMWNriN9KhwRBnBAa5R3QOmVH2UzscUW4mzw1tR
	NHMA2foj0GmVwxzzOITuBPWsJcf09plXW0ra/Empo5uwsrWDQR+YKaBshFtGLN84vwwCEuKei2g
	k3ipw5XO53BToChKWcPfwNRf9laIswHM7jo15zQ==
X-Google-Smtp-Source: AGHT+IEBqMEWcwQaY9IHzFKudbkiZKwer2VV6UuYvD2bgPKPN4KeI57z7cuCsN+2+ytu6S8QbmCCD9/h4vvD2gW7tuU=
X-Received: by 2002:a19:2d0f:0:b0:513:2c86:3498 with SMTP id
 k15-20020a192d0f000000b005132c863498mr3452192lfj.48.1710129868383; Sun, 10
 Mar 2024 21:04:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229232211.161961-1-samuel.holland@sifive.com>
 <20240229232211.161961-4-samuel.holland@sifive.com> <10c4851d-a8d8-4289-a9f9-509c70a0ca22@app.fastmail.com>
In-Reply-To: <10c4851d-a8d8-4289-a9f9-509c70a0ca22@app.fastmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 11 Mar 2024 09:34:16 +0530
Message-ID: <CAK9=C2X9GR4SVU_VisAakM4Ae4=59D84MkXU-5_0y192Kzv_-Q@mail.gmail.com>
Subject: Re: [PATCH v5 03/13] riscv: Use IPIs for remote cache/TLB flushes by default
To: "Stefan O'Rear" <sorear@fastmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>, 
	yunhui cui <cuiyunhui@bytedance.com>, Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 8:37=E2=80=AFAM Stefan O'Rear <sorear@fastmail.com>=
 wrote:
>
> On Thu, Feb 29, 2024, at 6:21 PM, Samuel Holland wrote:
> > An IPI backend is always required in an SMP configuration, but an SBI
> > implementation is not. For example, SBI will be unavailable when the
> > kernel runs in M mode.
> >
> > Generally, IPIs are assumed to be faster than SBI calls due to the SBI
> > context switch overhead. However, when SBI is used as the IPI backend,
> > then the context switch cost must be paid anyway, and performing the
> > cache/TLB flush directly in the SBI implementation is more efficient
> > than inserting an interrupt to the kernel. This is the only scenario
> > where riscv_ipi_set_virq_range()'s use_for_rfence parameter is false.
> >
> > Thus, it makes sense for remote fences to use IPIs by default, and make
> > the SBI remote fence extension the special case.
>
> The historical intention of providing SBI calls for remote fences is that
> it abstracts over hardware that allows for performing remote fences
> _without an IPI at all_. The TH1520 is an example of such hardware, since
> it can (at least according to the documentation) perform broadcast fence,
> fence.i, and sfence.vma operations using bits in the mhint register.
>
> T-Head's public opensbi repository doesn't actually use this feature, and
> in general SBI remote fences come from a much more optimistic time about
> how much we can successfully hide from supervisor software. But I don't
> think we can generalize that an IPI will always do less work than a SBI
> remote fence.

On platforms where SBI is the only way of injecting IPIs in S-mode, the
SBI based remote fences are actually much faster. This is because on
such platforms injecting an IPI from a HART to a set of HARTs will
require multiple SBI calls which can be directly replaced by one (or
few) SBI remote fence SBI calls.

Most of the current platforms still have M-mode CLINT and depend on
SBI IPI for S-mode IPI injection so we should not slow down remote
fences for these platforms.

Until all platforms have moved to RISC-V AIA (which supports S-mode
IPIs), we should keep this boot-time choice of SBI RFENCEs versus
direct S-mode IPIs.

IMO, this patch is ahead of its time.

Regards,
Anup

>
> -s
>
> > sbi_ipi_init() already checks riscv_ipi_have_virq_range(), so it only
> > calls riscv_ipi_set_virq_range() when no other IPI device is available.
> > So we can move the static key and drop the use_for_rfence parameter.
> >
> > Furthermore, the static branch only makes sense when CONFIG_RISCV_SBI i=
s
> > enabled. Optherwise, IPIs must be used. Add a fallback definition of
> > riscv_use_sbi_for_rfence() which handles this case and removes the need
> > to check CONFIG_RISCV_SBI elsewhere, such as in cacheflush.c.
> >
> > Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> > ---
> >
> > Changes in v5:
> >  - Also switch to riscv_use_sbi_for_rfence() in asm/pgalloc.h
> >
> > Changes in v4:
> >  - New patch for v4
> >
> >  arch/riscv/include/asm/pgalloc.h  |  7 ++++---
> >  arch/riscv/include/asm/sbi.h      |  4 ++++
> >  arch/riscv/include/asm/smp.h      | 15 ++-------------
> >  arch/riscv/kernel/sbi-ipi.c       | 11 ++++++++++-
> >  arch/riscv/kernel/smp.c           | 11 +----------
> >  arch/riscv/mm/cacheflush.c        |  5 ++---
> >  arch/riscv/mm/tlbflush.c          | 31 ++++++++++++++-----------------
> >  drivers/clocksource/timer-clint.c |  2 +-
> >  8 files changed, 38 insertions(+), 48 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/=
pgalloc.h
> > index 87468f67951a..6578054977ef 100644
> > --- a/arch/riscv/include/asm/pgalloc.h
> > +++ b/arch/riscv/include/asm/pgalloc.h
> > @@ -8,6 +8,7 @@
> >  #define _ASM_RISCV_PGALLOC_H
> >
> >  #include <linux/mm.h>
> > +#include <asm/sbi.h>
> >  #include <asm/tlb.h>
> >
> >  #ifdef CONFIG_MMU
> > @@ -90,10 +91,10 @@ static inline pud_t *pud_alloc_one(struct mm_struct
> > *mm, unsigned long addr)
> >
> >  static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, voi=
d *pt)
> >  {
> > -     if (riscv_use_ipi_for_rfence())
> > -             tlb_remove_page_ptdesc(tlb, pt);
> > -     else
> > +     if (riscv_use_sbi_for_rfence())
> >               tlb_remove_ptdesc(tlb, pt);
> > +     else
> > +             tlb_remove_page_ptdesc(tlb, pt);
> >  }
> >
> >  #define pud_free pud_free
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.=
h
> > index 6e68f8dff76b..ea84392ca9d7 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -375,8 +375,12 @@ unsigned long riscv_cached_marchid(unsigned int cp=
u_id);
> >  unsigned long riscv_cached_mimpid(unsigned int cpu_id);
> >
> >  #if IS_ENABLED(CONFIG_SMP) && IS_ENABLED(CONFIG_RISCV_SBI)
> > +DECLARE_STATIC_KEY_FALSE(riscv_sbi_for_rfence);
> > +#define riscv_use_sbi_for_rfence() \
> > +     static_branch_unlikely(&riscv_sbi_for_rfence)
> >  void sbi_ipi_init(void);
> >  #else
> > +static inline bool riscv_use_sbi_for_rfence(void) { return false; }
> >  static inline void sbi_ipi_init(void) { }
> >  #endif
> >
> > diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.=
h
> > index 0d555847cde6..7ac80e9f2288 100644
> > --- a/arch/riscv/include/asm/smp.h
> > +++ b/arch/riscv/include/asm/smp.h
> > @@ -49,12 +49,7 @@ void riscv_ipi_disable(void);
> >  bool riscv_ipi_have_virq_range(void);
> >
> >  /* Set the IPI interrupt numbers for arch (called by irqchip drivers) =
*/
> > -void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence);
> > -
> > -/* Check if we can use IPIs for remote FENCEs */
> > -DECLARE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
> > -#define riscv_use_ipi_for_rfence() \
> > -     static_branch_unlikely(&riscv_ipi_for_rfence)
> > +void riscv_ipi_set_virq_range(int virq, int nr);
> >
> >  /* Check other CPUs stop or not */
> >  bool smp_crash_stop_failed(void);
> > @@ -104,16 +99,10 @@ static inline bool riscv_ipi_have_virq_range(void)
> >       return false;
> >  }
> >
> > -static inline void riscv_ipi_set_virq_range(int virq, int nr,
> > -                                         bool use_for_rfence)
> > +static inline void riscv_ipi_set_virq_range(int virq, int nr)
> >  {
> >  }
> >
> > -static inline bool riscv_use_ipi_for_rfence(void)
> > -{
> > -     return false;
> > -}
> > -
> >  #endif /* CONFIG_SMP */
> >
> >  #if defined(CONFIG_HOTPLUG_CPU) && (CONFIG_SMP)
> > diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
> > index a4559695ce62..1026e22955cc 100644
> > --- a/arch/riscv/kernel/sbi-ipi.c
> > +++ b/arch/riscv/kernel/sbi-ipi.c
> > @@ -13,6 +13,9 @@
> >  #include <linux/irqdomain.h>
> >  #include <asm/sbi.h>
> >
> > +DEFINE_STATIC_KEY_FALSE(riscv_sbi_for_rfence);
> > +EXPORT_SYMBOL_GPL(riscv_sbi_for_rfence);
> > +
> >  static int sbi_ipi_virq;
> >
> >  static void sbi_ipi_handle(struct irq_desc *desc)
> > @@ -72,6 +75,12 @@ void __init sbi_ipi_init(void)
> >                         "irqchip/sbi-ipi:starting",
> >                         sbi_ipi_starting_cpu, NULL);
> >
> > -     riscv_ipi_set_virq_range(virq, BITS_PER_BYTE, false);
> > +     riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
> >       pr_info("providing IPIs using SBI IPI extension\n");
> > +
> > +     /*
> > +      * Use the SBI remote fence extension to avoid
> > +      * the extra context switch needed to handle IPIs.
> > +      */
> > +     static_branch_enable(&riscv_sbi_for_rfence);
> >  }
> > diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> > index 45dd4035416e..8e6eb64459af 100644
> > --- a/arch/riscv/kernel/smp.c
> > +++ b/arch/riscv/kernel/smp.c
> > @@ -171,10 +171,7 @@ bool riscv_ipi_have_virq_range(void)
> >       return (ipi_virq_base) ? true : false;
> >  }
> >
> > -DEFINE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
> > -EXPORT_SYMBOL_GPL(riscv_ipi_for_rfence);
> > -
> > -void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence)
> > +void riscv_ipi_set_virq_range(int virq, int nr)
> >  {
> >       int i, err;
> >
> > @@ -197,12 +194,6 @@ void riscv_ipi_set_virq_range(int virq, int nr,
> > bool use_for_rfence)
> >
> >       /* Enabled IPIs for boot CPU immediately */
> >       riscv_ipi_enable();
> > -
> > -     /* Update RFENCE static key */
> > -     if (use_for_rfence)
> > -             static_branch_enable(&riscv_ipi_for_rfence);
> > -     else
> > -             static_branch_disable(&riscv_ipi_for_rfence);
> >  }
> >
> >  static const char * const ipi_names[] =3D {
> > diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> > index 55a34f2020a8..47c485bc7df0 100644
> > --- a/arch/riscv/mm/cacheflush.c
> > +++ b/arch/riscv/mm/cacheflush.c
> > @@ -21,7 +21,7 @@ void flush_icache_all(void)
> >  {
> >       local_flush_icache_all();
> >
> > -     if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
> > +     if (riscv_use_sbi_for_rfence())
> >               sbi_remote_fence_i(NULL);
> >       else
> >               on_each_cpu(ipi_remote_fence_i, NULL, 1);
> > @@ -69,8 +69,7 @@ void flush_icache_mm(struct mm_struct *mm, bool local=
)
> >                * with flush_icache_deferred().
> >                */
> >               smp_mb();
> > -     } else if (IS_ENABLED(CONFIG_RISCV_SBI) &&
> > -                !riscv_use_ipi_for_rfence()) {
> > +     } else if (riscv_use_sbi_for_rfence()) {
> >               sbi_remote_fence_i(&others);
> >       } else {
> >               on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
> > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > index 8d12b26f5ac3..0373661bd1c4 100644
> > --- a/arch/riscv/mm/tlbflush.c
> > +++ b/arch/riscv/mm/tlbflush.c
> > @@ -78,10 +78,10 @@ static void __ipi_flush_tlb_all(void *info)
> >
> >  void flush_tlb_all(void)
> >  {
> > -     if (riscv_use_ipi_for_rfence())
> > -             on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
> > -     else
> > +     if (riscv_use_sbi_for_rfence())
> >               sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, F=
LUSH_TLB_NO_ASID);
> > +     else
> > +             on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
> >  }
> >
> >  struct flush_tlb_range_data {
> > @@ -102,7 +102,6 @@ static void __flush_tlb_range(struct cpumask
> > *cmask, unsigned long asid,
> >                             unsigned long start, unsigned long size,
> >                             unsigned long stride)
> >  {
> > -     struct flush_tlb_range_data ftd;
> >       bool broadcast;
> >
> >       if (cpumask_empty(cmask))
> > @@ -118,20 +117,18 @@ static void __flush_tlb_range(struct cpumask
> > *cmask, unsigned long asid,
> >               broadcast =3D true;
> >       }
> >
> > -     if (broadcast) {
> > -             if (riscv_use_ipi_for_rfence()) {
> > -                     ftd.asid =3D asid;
> > -                     ftd.start =3D start;
> > -                     ftd.size =3D size;
> > -                     ftd.stride =3D stride;
> > -                     on_each_cpu_mask(cmask,
> > -                                      __ipi_flush_tlb_range_asid,
> > -                                      &ftd, 1);
> > -             } else
> > -                     sbi_remote_sfence_vma_asid(cmask,
> > -                                                start, size, asid);
> > -     } else {
> > +     if (!broadcast) {
> >               local_flush_tlb_range_asid(start, size, stride, asid);
> > +     } else if (riscv_use_sbi_for_rfence()) {
> > +             sbi_remote_sfence_vma_asid(cmask, start, size, asid);
> > +     } else {
> > +             struct flush_tlb_range_data ftd;
> > +
> > +             ftd.asid =3D asid;
> > +             ftd.start =3D start;
> > +             ftd.size =3D size;
> > +             ftd.stride =3D stride;
> > +             on_each_cpu_mask(cmask, __ipi_flush_tlb_range_asid, &ftd,=
 1);
> >       }
> >
> >       if (cmask !=3D cpu_online_mask)
> > diff --git a/drivers/clocksource/timer-clint.c
> > b/drivers/clocksource/timer-clint.c
> > index 09fd292eb83d..0bdd9d7ec545 100644
> > --- a/drivers/clocksource/timer-clint.c
> > +++ b/drivers/clocksource/timer-clint.c
> > @@ -251,7 +251,7 @@ static int __init clint_timer_init_dt(struct
> > device_node *np)
> >       }
> >
> >       irq_set_chained_handler(clint_ipi_irq, clint_ipi_interrupt);
> > -     riscv_ipi_set_virq_range(rc, BITS_PER_BYTE, true);
> > +     riscv_ipi_set_virq_range(rc, BITS_PER_BYTE);
> >       clint_clear_ipi();
> >  #endif
> >
> > --
> > 2.43.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>

