Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337167B22F6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjI1Qwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjI1Qwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:52:36 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD4A98
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:52:34 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c00e1d4c08so215889151fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695919952; x=1696524752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JAb91/e3qbkELNmBfazY7m5X2ZqQp3k26A2/IGPCVo=;
        b=qjiEb3kLTu5j4oUniPFQ0NRFnSqN3bunLwakDjuDcILId0Ex+x0HGtzyzU85HM++rb
         ZxxzxEDnatspPMBgSMoZWEQx8iUihD4xwypA5Sf4jNqRrO4emCCAhgC4t3qVS8iDUNmW
         0YY4/1aaIsOMUBg0G2XHYs+iQpXGY/pnbbw2xJzS2OO3o7PmJ7sOQv2c5uNrto4Zu1c1
         GMDrC1NVfEMJBs3aObo+GTlT+wNwWRs6DK9LocuIC/8IpmBuzvCA63OaphoQfk28xhD3
         y7iJf+uAxmLDKEMMlPY0G210y/eGb5T42Rrx1iI7+HRAVndJk3BbyvwW7czy9DsxX1Hz
         dP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695919952; x=1696524752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JAb91/e3qbkELNmBfazY7m5X2ZqQp3k26A2/IGPCVo=;
        b=g5Bd7yzV/fJd/3SBCFHocOFhh8PF1ZDkWzdtJJC9cggvcTNy4AnX3bNCGe09GtrkAS
         xGHbWiUgEz7T4FppyOYwj0dH+tCogZGh+xWgZP1tpbvuF/4gJ7ceYOEku0rhVfG/AEdE
         fAEkOZn3ys3u4EBxm+72JMfgHAMJIH019p+l3PtUf8qjXbRvdTMw24XXByH5kKpTIRq6
         sCgHzGtwSm1ubVe0x3zMbw9aSbqk/D5W7pTSQn6swWKrQeFzTTNLWT95nifyx9oJi4v2
         Ls6R5vcSNekRfBh0XaolZeTfoKj04YxB6lotVGcrPTWuS+rBdi78eRd/EE9ZUCAZeiY1
         iYSA==
X-Gm-Message-State: AOJu0Ywzt0p+rSa9au3/G7Gigtcwaa+Qka/5Eukdv9JL4bG/eFdDcF4G
        BwC4XwMl6po0U9josktTkWyyyJXl0ZzV0gTgNkNX+g==
X-Google-Smtp-Source: AGHT+IHdnhXwgy1aqPai95GEUvU0k+OSgLMhlcAFgey0ahxKUkv1Z2Cgm7MP/EwBzVmZBmSr5wx+GmmDVqxD7SMhhzE=
X-Received: by 2002:a2e:8603:0:b0:2c0:1cfd:8698 with SMTP id
 a3-20020a2e8603000000b002c01cfd8698mr1473140lji.36.1695919952531; Thu, 28 Sep
 2023 09:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230926150316.1129648-1-cleger@rivosinc.com> <20230926150316.1129648-7-cleger@rivosinc.com>
 <CALs-HssC7oEg0H84D4_gkHpujhBbOOqX-W3k=WrD3SBEGHmaYg@mail.gmail.com> <c9db8acf-98fe-4533-8fa1-7a4394e51e21@rivosinc.com>
In-Reply-To: <c9db8acf-98fe-4533-8fa1-7a4394e51e21@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 28 Sep 2023 09:51:56 -0700
Message-ID: <CALs-HsthB9BDwODEBUk7hFQ07qV=R0X7J8m3Y3KnoUntqGMPVA@mail.gmail.com>
Subject: Re: [PATCH 6/7] riscv: report misaligned accesses emulation to hwprobe
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?UTF-8?B?QmrDtnJuIFRvcGVs?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 12:46=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
>
>
> On 26/09/2023 23:57, Evan Green wrote:
> > On Tue, Sep 26, 2023 at 8:03=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger=
@rivosinc.com> wrote:
> >>
> >> hwprobe provides a way to report if misaligned access are emulated. In
> >> order to correctly populate that feature, we can check if it actually
> >> traps when doing a misaligned access. This can be checked using an
> >> exception table entry which will actually be used when a misaligned
> >> access is done from kernel mode.
> >>
> >> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> >> ---
> >>  arch/riscv/include/asm/cpufeature.h  |  6 +++
> >>  arch/riscv/kernel/cpufeature.c       |  6 ++-
> >>  arch/riscv/kernel/setup.c            |  1 +
> >>  arch/riscv/kernel/traps_misaligned.c | 63 +++++++++++++++++++++++++++=
-
> >>  4 files changed, 74 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/=
asm/cpufeature.h
> >> index d0345bd659c9..c1f0ef02cd7d 100644
> >> --- a/arch/riscv/include/asm/cpufeature.h
> >> +++ b/arch/riscv/include/asm/cpufeature.h
> >> @@ -8,6 +8,7 @@
> >>
> >>  #include <linux/bitmap.h>
> >>  #include <asm/hwcap.h>
> >> +#include <asm/hwprobe.h>
> >>
> >>  /*
> >>   * These are probed via a device_initcall(), via either the SBI or di=
rectly
> >> @@ -32,4 +33,9 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
> >>
> >>  void check_unaligned_access(int cpu);
> >>
> >> +bool unaligned_ctl_available(void);
> >> +
> >> +bool check_unaligned_access_emulated(int cpu);
> >> +void unaligned_emulation_finish(void);
> >> +
> >>  #endif
> >> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufea=
ture.c
> >> index 1cfbba65d11a..fbbde800bc21 100644
> >> --- a/arch/riscv/kernel/cpufeature.c
> >> +++ b/arch/riscv/kernel/cpufeature.c
> >> @@ -568,6 +568,9 @@ void check_unaligned_access(int cpu)
> >>         void *src;
> >>         long speed =3D RISCV_HWPROBE_MISALIGNED_SLOW;
> >>
> >> +       if (check_unaligned_access_emulated(cpu))
> >
> > This spot (referenced below).
> >
> >> +               return;
> >> +
> >>         page =3D alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_S=
IZE));
> >>         if (!page) {
> >>                 pr_warn("Can't alloc pages to measure memcpy performan=
ce");
> >> @@ -645,9 +648,10 @@ void check_unaligned_access(int cpu)
> >>         __free_pages(page, get_order(MISALIGNED_BUFFER_SIZE));
> >>  }
> >>
> >> -static int check_unaligned_access_boot_cpu(void)
> >> +static int __init check_unaligned_access_boot_cpu(void)
> >>  {
> >>         check_unaligned_access(0);
> >> +       unaligned_emulation_finish();
> >>         return 0;
> >>  }
> >>
> >> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> >> index e600aab116a4..3af6ad4df7cf 100644
> >> --- a/arch/riscv/kernel/setup.c
> >> +++ b/arch/riscv/kernel/setup.c
> >> @@ -26,6 +26,7 @@
> >>  #include <asm/acpi.h>
> >>  #include <asm/alternative.h>
> >>  #include <asm/cacheflush.h>
> >> +#include <asm/cpufeature.h>
> >>  #include <asm/cpu_ops.h>
> >>  #include <asm/early_ioremap.h>
> >>  #include <asm/pgtable.h>
> >> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/=
traps_misaligned.c
> >> index b5fb1ff078e3..fa81f6952fa4 100644
> >> --- a/arch/riscv/kernel/traps_misaligned.c
> >> +++ b/arch/riscv/kernel/traps_misaligned.c
> >> @@ -9,11 +9,14 @@
> >>  #include <linux/perf_event.h>
> >>  #include <linux/irq.h>
> >>  #include <linux/stringify.h>
> >> +#include <linux/prctl.h>
> >>
> >>  #include <asm/processor.h>
> >>  #include <asm/ptrace.h>
> >>  #include <asm/csr.h>
> >>  #include <asm/entry-common.h>
> >> +#include <asm/hwprobe.h>
> >> +#include <asm/cpufeature.h>
> >>
> >>  #define INSN_MATCH_LB                  0x3
> >>  #define INSN_MASK_LB                   0x707f
> >> @@ -396,8 +399,10 @@ union reg_data {
> >>         u64 data_u64;
> >>  };
> >>
> >> +static bool unaligned_ctl __read_mostly;
> >> +
> >>  /* sysctl hooks */
> >> -int unaligned_enabled __read_mostly =3D 1;       /* Enabled by defaul=
t */
> >> +int unaligned_enabled __read_mostly;
> >>
> >>  int handle_misaligned_load(struct pt_regs *regs)
> >>  {
> >> @@ -412,6 +417,9 @@ int handle_misaligned_load(struct pt_regs *regs)
> >>         if (!unaligned_enabled)
> >>                 return -1;
> >>
> >> +       if (user_mode(regs) && (current->thread.align_ctl & PR_UNALIGN=
_SIGBUS))
> >> +               return -1;
> >> +
> >>         if (get_insn(regs, epc, &insn))
> >>                 return -1;
> >>
> >> @@ -511,6 +519,9 @@ int handle_misaligned_store(struct pt_regs *regs)
> >>         if (!unaligned_enabled)
> >>                 return -1;
> >>
> >> +       if (user_mode(regs) && (current->thread.align_ctl & PR_UNALIGN=
_SIGBUS))
> >> +               return -1;
> >> +
> >>         if (get_insn(regs, epc, &insn))
> >>                 return -1;
> >>
> >> @@ -585,3 +596,53 @@ int handle_misaligned_store(struct pt_regs *regs)
> >>
> >>         return 0;
> >>  }
> >> +
> >> +bool check_unaligned_access_emulated(int cpu)
> >> +{
> >> +       unsigned long emulated =3D 1, tmp_var;
> >> +
> >> +       /* Use a fixup to detect if misaligned access triggered an exc=
eption */
> >> +       __asm__ __volatile__ (
> >> +               "1:\n"
> >> +               "       "REG_L" %[tmp], 1(%[ptr])\n"
> >> +               "       li %[emulated], 0\n"
> >> +               "2:\n"
> >> +               _ASM_EXTABLE(1b, 2b)
> >> +       : [emulated] "+r" (emulated), [tmp] "=3Dr" (tmp_var)
> >> +       : [ptr] "r" (&tmp_var)
> >> +       : "memory");
> >> +
> >> +       if (!emulated)
> >> +               return false;
> >> +
> >> +       per_cpu(misaligned_access_speed, cpu) =3D
> >> +               RISCV_HWPROBE_MISALIGNED_EMULATED;
> >
> > For tidiness, can we move the assignment of this per-cpu variable into
> > check_unaligned_access(), at the spot I referenced above. That way
> > people looking to see how this variable is set don't have to hunt
> > through multiple locations.
>
> Agreed, that seems better.
>
> >
> >> +
> >> +       return true;
> >> +}
> >> +
> >> +void __init unaligned_emulation_finish(void)
> >> +{
> >> +       int cpu;
> >> +
> >> +       /*
> >> +        * We can only support PR_UNALIGN controls if all CPUs have mi=
saligned
> >> +        * accesses emulated since tasks requesting such control can r=
un on any
> >> +        * CPU.
> >> +        */
> >> +       for_each_possible_cpu(cpu) {
> >> +               if (per_cpu(misaligned_access_speed, cpu) !=3D
> >> +                   RISCV_HWPROBE_MISALIGNED_EMULATED) {
> >> +                       goto out;
> >> +               }
> >> +       }
> >> +       unaligned_ctl =3D true;
> >
> > This doesn't handle the case where a CPU is hotplugged later that
> > doesn't match with the others. You may want to add a patch that fails
> > the onlining of that new CPU if unaligned_ctl is true and
> > new_cpu.misaligned_access_speed !=3D EMULATED.
>
> So actually, this will require a bit more plumbing as I realize the
> switch to disable misalignment support is global. This switch should
> only be disabled at boot which means I won't be able to disable it at
> runtime (while hiotplugging a CPU) for CPU detection. There are multiple
> ways to handle that:
>
> 1- Have a per-cpu switch for misalignment handling which would be
> disabled only when detection is needed.
>
> 2- Assume that once detected at boot-time, emulation will not change.
>
> Not sure which one is better though. Advice are welcomed.

If I gaze into my own crystal ball, my hope is that the Venn diagram
of "systems that support hotplug" and "systems that still use software
assist for misaligned access" is just two circles not touching. If
people agree with that, then the safe thing to do is enforce it, by
failing to online new hotplugged CPUs that don't conform to
misaligned_access_speed =3D=3D EMULATED if unaligned_ctl is true. We would
sacrifice some future flexibility by making this choice now though, so
it requires buy-in for this particular crystal ball vision.

-Evan
