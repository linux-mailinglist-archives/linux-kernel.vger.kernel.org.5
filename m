Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D47D7F58A3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjKWGwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKWGwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:52:42 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6D3E7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:52:48 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so428806a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700722367; x=1701327167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8//NOAhlLP4wa8ToVqytaJsPoKkTmYQnkHrIBEwHVk=;
        b=2gew962MYCYuQ3T4jyp0TY3uKknsJ+3GH7h6Yw7ncspeu9srOaQ/zkbl1K/2dMzyEl
         V6XF9DLI4RzfQbAh9ZSLCm1FxTh+i5pT4GuqInwwLXyeh7aTxc5YBLo7apvM+bhc0bpn
         vPWDT8FDGWaYmebk0BvsSPL5Vr5YBCVEJhNr6zNy+6JCHRmsOALCGEo1Y6f5Oo4sE9I8
         gyUWt2mtNVzd02bSiQFPCnKseoM9vTg6dRH4CrfrUlqRls7gfpUFOP0zvLd8Sj8qwZwq
         /zcoT9c2SkcMweC5pIQh4J8fHcnVPJexkVTJCOZEg7OKW+IAeJoHZZ4cFTGNNf+MAwb2
         lTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700722367; x=1701327167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8//NOAhlLP4wa8ToVqytaJsPoKkTmYQnkHrIBEwHVk=;
        b=gWaU5I3zPyVXYx6Ps+74Z7yB9U6ET/Tvpu4kqYyEg/QsddlHSxFo2zkbcrpOmg9JT4
         uJwD7idiAkJQOz5StiSFdzdIWoMYyNuuKBKWnJ4Hn+lyuvbZ7sYVqqpMxWQbHAhhBxTh
         qIBd+C628tQmHS6EdKNvYZukXxIFLlUUp2+DrezuuedCLrWpiPbIu9thFZBrpEoS1JK2
         AgbTlmuEZ61koLJxQ5dcZ55w1kacVygTMDRF3XAn2Q4OvrnE4RSq49pkELkC6a/Qm6k3
         5cQl6cIj3D7Y6M5izrtuGtZ2FGokXJiExQxifk4u+GJFD/uz6MSny4XvnaF6y6PT2Aw0
         hWQQ==
X-Gm-Message-State: AOJu0YyHD1sTj3czdyttmeGUMwU9SIcw9XAoDLPLc2P+WzGLj1/vhxZ4
        m7Vvraz7DG3c2L7vwmeB+WCw7ytWpXK2dbrKpwvxWQ==
X-Google-Smtp-Source: AGHT+IHT5/bWnrGKHx/dJsAQaxVlXJf8uuhbWOCl6TgQ0RoomySFhOhzMjdjKgEaUvH2zuDfC7mavpoNdfaiRnVYBSI=
X-Received: by 2002:a17:90b:1d92:b0:27d:5964:4ee6 with SMTP id
 pf18-20020a17090b1d9200b0027d59644ee6mr5147744pjb.2.1700722367233; Wed, 22
 Nov 2023 22:52:47 -0800 (PST)
MIME-Version: 1.0
References: <mhng-b720eb90-633f-498b-a487-0cfdc9f00ddd@palmer-ri-x1c9>
 <65e98129-0617-49ca-9802-8e3a46d58d29@efficios.com> <ZU0sliwUQJyNAH1y@andrea> <ZV6lxsRmuN7bYFnD@ghost>
In-Reply-To: <ZV6lxsRmuN7bYFnD@ghost>
From:   Robbin Ehn <rehn@rivosinc.com>
Date:   Thu, 23 Nov 2023 07:52:36 +0100
Message-ID: <CAEEvPLA-Y4rO7KVq9MRYtqwUrMSQaTeQL+RbBZ+_6Xga-iMQ5Q@mail.gmail.com>
Subject: Re: [RFC PATCH] membarrier: riscv: Provide core serializing command
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, paulmck@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 2:07=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> On Thu, Nov 09, 2023 at 08:24:58PM +0100, Andrea Parri wrote:
> > Mathieu, all,
> >
> > Sorry for the delay,
> >
> > > AFAIR this patch implements sync_core_before_usermode which gets used=
 by
> > > membarrier_mm_sync_core_before_usermode() to handle the uthread->kthr=
ead->uthread
> > > case. It relies on switch_mm issuing a core serializing instruction a=
s well.
> > >
> > > Looking at RISC-V switch_mm(), I see that switch_mm() calls:
> > >
> > >   flush_icache_deferred(next, cpu);
> > >
> > > which only issues a fence.i if a deferred icache flush was required. =
We're
> > > missing the part that sets the icache_stale_mask cpumask bits when a
> > > MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE is invoked.
> >
> > [...]
> >
> > > The only part where I think you may want to keep some level of deferr=
ed
> > > icache flushing as you do now is as follows:
> > >
> > > - when membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE is invok=
ed,
> > >   call a new architecture hook which sets cpumask bits in the mm cont=
ext
> > >   that tells the next switch_mm on each cpu to issue fence.i for that=
 mm.
> > > - keep something like flush_icache_deferred as you have now.
> > >
> > > Otherwise, I fear the overhead of a very expensive fence.i would be t=
oo
> > > much when processes registering with MEMBARRIER_CMD_REGISTER_PRIVATE_=
EXPEDITED_SYNC_CORE
> > > and start doing fence.i on each and every switch_mm().
> > >
> > > So you'd basically rely on membarrier to only issue IPIs to the CPUs =
which are
> > > currently running threads belonging to the mm, and handle the switch_=
mm with
> > > the sync_core_before_usermode() for uthread->kthread->uthread case, a=
nd implement
> > > a deferred icache flush for the typical switch_mm() case.
> >
> > I've (tried to) put this together and obtained the two patches reported=
 below.
> > Please let me know if this aligns with your intentions and/or there's i=
nterest
> > in a proper submission.
> >
> >   Andrea
> >
> >
> > From e7d07a6c04b2565fceedcd71c2175e7df7e11d96 Mon Sep 17 00:00:00 2001
> > From: Andrea Parri <parri.andrea@gmail.com>
> > Date: Thu, 9 Nov 2023 11:03:00 +0100
> > Subject: [PATCH 1/2] locking: Introduce prepare_sync_core_cmd()
> >
> > Introduce an architecture function that architectures can use to set
> > up ("prepare") SYNC_CORE commands.
> >
> > The function will be used by RISC-V to update its "deferred icache-
> > flush" data structures (icache_stale_mask).
> >
> > Architectures defining prepare_sync_core_cmd() static inline need to
> > select ARCH_HAS_PREPARE_SYNC_CORE_CMD.
> >
> > Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> > Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > ---
> >  include/linux/sync_core.h | 16 +++++++++++++++-
> >  init/Kconfig              |  3 +++
> >  kernel/sched/membarrier.c |  1 +
> >  3 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/sync_core.h b/include/linux/sync_core.h
> > index 013da4b8b3272..67bb9794b8758 100644
> > --- a/include/linux/sync_core.h
> > +++ b/include/linux/sync_core.h
> > @@ -17,5 +17,19 @@ static inline void sync_core_before_usermode(void)
> >  }
> >  #endif
> >
> > -#endif /* _LINUX_SYNC_CORE_H */
> > +#ifdef CONFIG_ARCH_HAS_PREPARE_SYNC_CORE_CMD
> > +#include <asm/sync_core.h>
> > +#else
> > +/*
> > + * This is a dummy prepare_sync_core_cmd() implementation that can be =
used on
> > + * all architectures which provide unconditional core serializing inst=
ructions
> > + * in switch_mm().
> > + * If your architecture doesn't provide such core serializing instruct=
ions in
> > + * switch_mm(), you may need to write your own functions.
> > + */
> > +static inline void prepare_sync_core_cmd(struct mm_struct *mm)
> > +{
> > +}
> > +#endif
> >
> > +#endif /* _LINUX_SYNC_CORE_H */
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 6d35728b94b2b..61f5f982ca451 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1972,6 +1972,9 @@ source "kernel/Kconfig.locks"
> >  config ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
> >       bool
> >
> > +config ARCH_HAS_PREPARE_SYNC_CORE_CMD
> > +     bool
> > +
> >  config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
> >       bool
> >
> > diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> > index 2ad881d07752c..58f801e013988 100644
> > --- a/kernel/sched/membarrier.c
> > +++ b/kernel/sched/membarrier.c
> > @@ -320,6 +320,7 @@ static int membarrier_private_expedited(int flags, =
int cpu_id)
> >                     MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY)=
)
> >                       return -EPERM;
> >               ipi_func =3D ipi_sync_core;
> > +             prepare_sync_core_cmd(mm);
> >       } else if (flags =3D=3D MEMBARRIER_FLAG_RSEQ) {
> >               if (!IS_ENABLED(CONFIG_RSEQ))
> >                       return -EINVAL;
> > --
> > 2.34.1
> >
> >
> > From 617896a1d58a5f8b0e5895dbc928a54e0461d959 Mon Sep 17 00:00:00 2001
> > From: Andrea Parri <parri.andrea@gmail.com>
> > Date: Tue, 7 Nov 2023 21:08:06 +0100
> > Subject: [PATCH 2/2] membarrier: riscv: Provide core serializing comman=
d
> >
> > RISC-V uses xRET instructions on return from interrupt and to go back
> > to user-space; the xRET instruction is not core serializing.
> >
> > Use FENCE.I for providing core serialization as follows:
> >
> >  - by calling sync_core_before_usermode() on return from interrupt (cf.
> >    ipi_sync_core()),
> >
> >  - via switch_mm() and sync_core_before_usermode() (respectively, for
> >    uthread->uthread and kthread->uthread transitions) to go back to
> >    user-space.
> >
> > On RISC-V, the serialization in switch_mm() is activated by resetting
> > the icache_stale_mask of the mm at prepare_sync_core_cmd().
> >
> > Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> > Suggested-by: Palmer Dabbelt <palmer@dabbelt.com>
> > ---
> >  .../membarrier-sync-core/arch-support.txt     |  2 +-
> >  arch/riscv/Kconfig                            |  3 +++
> >  arch/riscv/include/asm/sync_core.h            | 23 +++++++++++++++++++
> >  3 files changed, 27 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/riscv/include/asm/sync_core.h
> >
> > diff --git a/Documentation/features/sched/membarrier-sync-core/arch-sup=
port.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.t=
xt
> > index 23260ca449468..a17117d76e6d8 100644
> > --- a/Documentation/features/sched/membarrier-sync-core/arch-support.tx=
t
> > +++ b/Documentation/features/sched/membarrier-sync-core/arch-support.tx=
t
> > @@ -44,7 +44,7 @@
> >      |    openrisc: | TODO |
> >      |      parisc: | TODO |
> >      |     powerpc: |  ok  |
> > -    |       riscv: | TODO |
> > +    |       riscv: |  ok  |
> >      |        s390: |  ok  |
> >      |          sh: | TODO |
> >      |       sparc: | TODO |
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 9c48fecc67191..b70a0b9ea3ee7 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -27,14 +27,17 @@ config RISCV
> >       select ARCH_HAS_GCOV_PROFILE_ALL
> >       select ARCH_HAS_GIGANTIC_PAGE
> >       select ARCH_HAS_KCOV
> > +     select ARCH_HAS_MEMBARRIER_SYNC_CORE
> >       select ARCH_HAS_MMIOWB
> >       select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
> >       select ARCH_HAS_PMEM_API
> > +     select ARCH_HAS_PREPARE_SYNC_CORE_CMD
> >       select ARCH_HAS_PTE_SPECIAL
> >       select ARCH_HAS_SET_DIRECT_MAP if MMU
> >       select ARCH_HAS_SET_MEMORY if MMU
> >       select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
> >       select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
> > +     select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
> >       select ARCH_HAS_SYSCALL_WRAPPER
> >       select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> >       select ARCH_HAS_UBSAN_SANITIZE_ALL
> > diff --git a/arch/riscv/include/asm/sync_core.h b/arch/riscv/include/as=
m/sync_core.h
> > new file mode 100644
> > index 0000000000000..8be5e07d641ab
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/sync_core.h
> > @@ -0,0 +1,23 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_RISCV_SYNC_CORE_H
> > +#define _ASM_RISCV_SYNC_CORE_H
> > +
> > +/*
> > + * RISC-V implements return to user-space through an xRET instruction,
> > + * which is not core serializing.
> > + */
> > +static inline void sync_core_before_usermode(void)
> > +{
> > +     asm volatile ("fence.i" ::: "memory");
> > +}
> > +
> > +/*
> > + * Ensure the next switch_mm() on every CPU issues a core serializing
> > + * instruction for the given @mm.
> > + */
> > +static inline void prepare_sync_core_cmd(struct mm_struct *mm)
> > +{
> > +     cpumask_setall(&mm->context.icache_stale_mask);
> > +}
> > +
> > +#endif /* _ASM_RISCV_SYNC_CORE_H */
> > --
> > 2.34.1
> >
>
> This looks good to me, can you send out a non-RFC? I just sent out
> patches to support userspace fence.i:
> https://lore.kernel.org/linux-riscv/20231122-fencei-v1-0-bec0811cb212@riv=
osinc.com/T/#t.

Thank you Charlie, exactly what we are looking for!

Perfect that you added selection for fence.i, so we in the future can
select Zjid/import.i instead.

/Robbin

>
> - Charlie
>
