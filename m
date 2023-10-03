Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3859E7B65E0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbjJCJu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjJCJu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:50:26 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D41AC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:50:22 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50437c618b4so842316e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 02:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696326621; x=1696931421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m04Zc4Qw+KPeWjClrFQx+Z6rNPllv6QEFTEbcf+nuFE=;
        b=edtOa+PM7CmuNCuM6L78Ei6dRam1nmS7smRrA1zHUY+mk7ty9FaStOfpnaQmvfXCr0
         bcHP03BC3lyLtxhFcFhsjNWyZ/u5V7LMMbLX3NC6mg3EpLYEx6og7Tdj8TzO6imLqE+d
         9PAJDfidLnsziFlpzA+59VNZahlHNANe6uRnvA884Itd1x7S2ewW+aODcdRpjc2T+D0Z
         xew9/6kMGyk8W8AohOV+bMaLmUGCNf4M/oZAmL3E7eM51hL8NnxIR7I+gApNuIInmvjE
         OSOwhZuQe3REBvFl8vS8n+83koiXlXtD6KpTDherLWP15Ab9MWvCI6fxHrLwqMi0Xkfq
         TwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696326621; x=1696931421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m04Zc4Qw+KPeWjClrFQx+Z6rNPllv6QEFTEbcf+nuFE=;
        b=mNmDplHaUiumzoH8/S4c4kO0W5wcs3Ahnr9Tmi3w5MROu28WZ6mB87D6mo7m+wFSW0
         Yf2EJJlg19SiKQ5VFiFTxpsAwvsYnhHd/gHGLtm0DYVTnNsnFgk+XZbVEOqIJJr/6HjX
         khImECQ0iJtOfa/uuueY7Mxvy7UZEvgAwno2eGSqDA/iwpnGjExMar/X6LSrBf5Xd26c
         C5E36rv/M5JZmrocvmVyStQmBYY5stxIwfXqjW6dpdQ9UX1JsEMAEy0IABI+vscxDYdr
         10BN0lMJkqafD7aM83sKS7i/UdNvRgVd1NjuI431CWfhKihaoJ5j9jw0XEf/3/pzDh/U
         9K9Q==
X-Gm-Message-State: AOJu0YxCfU/QzQx9NstSQCPGPNciy7NFTpYOvSaZNzdxxnhVyAVa8uib
        4rutlBRUrF+fAwYnRZdXk+BmaA35S60duy7yJTSv7Q==
X-Google-Smtp-Source: AGHT+IE/Dx80NUeQDLPkx0yAJeqmcAacow65vSaEtd+dW0Iv/tars8Yzh0YqvrCA/mD0IRSG3Jb2FmH7VLb4Pho8KXA=
X-Received: by 2002:a05:6512:12c4:b0:500:c2d7:3ab4 with SMTP id
 p4-20020a05651212c400b00500c2d73ab4mr12854793lfg.8.1696326620582; Tue, 03 Oct
 2023 02:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230926150316.1129648-1-cleger@rivosinc.com> <20230926150316.1129648-7-cleger@rivosinc.com>
 <CALs-HssC7oEg0H84D4_gkHpujhBbOOqX-W3k=WrD3SBEGHmaYg@mail.gmail.com>
 <c9db8acf-98fe-4533-8fa1-7a4394e51e21@rivosinc.com> <CALs-HsthB9BDwODEBUk7hFQ07qV=R0X7J8m3Y3KnoUntqGMPVA@mail.gmail.com>
In-Reply-To: <CALs-HsthB9BDwODEBUk7hFQ07qV=R0X7J8m3Y3KnoUntqGMPVA@mail.gmail.com>
From:   Atish Kumar Patra <atishp@rivosinc.com>
Date:   Tue, 3 Oct 2023 02:50:09 -0700
Message-ID: <CAHBxVyH2w8y9sWkvoHenk5oU=6yYb79V1s=9Jfi9shsbakeEvg@mail.gmail.com>
Subject: Re: [PATCH 6/7] riscv: report misaligned accesses emulation to hwprobe
To:     Evan Green <evan@rivosinc.com>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
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

On Thu, Sep 28, 2023 at 9:52=E2=80=AFAM Evan Green <evan@rivosinc.com> wrot=
e:
>
> On Thu, Sep 28, 2023 at 12:46=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@=
rivosinc.com> wrote:
> >
> >
> >
> > On 26/09/2023 23:57, Evan Green wrote:
> > > On Tue, Sep 26, 2023 at 8:03=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleg=
er@rivosinc.com> wrote:
> > >>
> > >> hwprobe provides a way to report if misaligned access are emulated. =
In
> > >> order to correctly populate that feature, we can check if it actuall=
y
> > >> traps when doing a misaligned access. This can be checked using an
> > >> exception table entry which will actually be used when a misaligned
> > >> access is done from kernel mode.
> > >>
> > >> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> > >> ---
> > >>  arch/riscv/include/asm/cpufeature.h  |  6 +++
> > >>  arch/riscv/kernel/cpufeature.c       |  6 ++-
> > >>  arch/riscv/kernel/setup.c            |  1 +
> > >>  arch/riscv/kernel/traps_misaligned.c | 63 +++++++++++++++++++++++++=
++-
> > >>  4 files changed, 74 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/includ=
e/asm/cpufeature.h
> > >> index d0345bd659c9..c1f0ef02cd7d 100644
> > >> --- a/arch/riscv/include/asm/cpufeature.h
> > >> +++ b/arch/riscv/include/asm/cpufeature.h
> > >> @@ -8,6 +8,7 @@
> > >>
> > >>  #include <linux/bitmap.h>
> > >>  #include <asm/hwcap.h>
> > >> +#include <asm/hwprobe.h>
> > >>
> > >>  /*
> > >>   * These are probed via a device_initcall(), via either the SBI or =
directly
> > >> @@ -32,4 +33,9 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
> > >>
> > >>  void check_unaligned_access(int cpu);
> > >>
> > >> +bool unaligned_ctl_available(void);
> > >> +
> > >> +bool check_unaligned_access_emulated(int cpu);
> > >> +void unaligned_emulation_finish(void);
> > >> +
> > >>  #endif
> > >> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpuf=
eature.c
> > >> index 1cfbba65d11a..fbbde800bc21 100644
> > >> --- a/arch/riscv/kernel/cpufeature.c
> > >> +++ b/arch/riscv/kernel/cpufeature.c
> > >> @@ -568,6 +568,9 @@ void check_unaligned_access(int cpu)
> > >>         void *src;
> > >>         long speed =3D RISCV_HWPROBE_MISALIGNED_SLOW;
> > >>
> > >> +       if (check_unaligned_access_emulated(cpu))
> > >
> > > This spot (referenced below).
> > >
> > >> +               return;
> > >> +
> > >>         page =3D alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER=
_SIZE));
> > >>         if (!page) {
> > >>                 pr_warn("Can't alloc pages to measure memcpy perform=
ance");
> > >> @@ -645,9 +648,10 @@ void check_unaligned_access(int cpu)
> > >>         __free_pages(page, get_order(MISALIGNED_BUFFER_SIZE));
> > >>  }
> > >>
> > >> -static int check_unaligned_access_boot_cpu(void)
> > >> +static int __init check_unaligned_access_boot_cpu(void)
> > >>  {
> > >>         check_unaligned_access(0);
> > >> +       unaligned_emulation_finish();
> > >>         return 0;
> > >>  }
> > >>
> > >> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > >> index e600aab116a4..3af6ad4df7cf 100644
> > >> --- a/arch/riscv/kernel/setup.c
> > >> +++ b/arch/riscv/kernel/setup.c
> > >> @@ -26,6 +26,7 @@
> > >>  #include <asm/acpi.h>
> > >>  #include <asm/alternative.h>
> > >>  #include <asm/cacheflush.h>
> > >> +#include <asm/cpufeature.h>
> > >>  #include <asm/cpu_ops.h>
> > >>  #include <asm/early_ioremap.h>
> > >>  #include <asm/pgtable.h>
> > >> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kerne=
l/traps_misaligned.c
> > >> index b5fb1ff078e3..fa81f6952fa4 100644
> > >> --- a/arch/riscv/kernel/traps_misaligned.c
> > >> +++ b/arch/riscv/kernel/traps_misaligned.c
> > >> @@ -9,11 +9,14 @@
> > >>  #include <linux/perf_event.h>
> > >>  #include <linux/irq.h>
> > >>  #include <linux/stringify.h>
> > >> +#include <linux/prctl.h>
> > >>
> > >>  #include <asm/processor.h>
> > >>  #include <asm/ptrace.h>
> > >>  #include <asm/csr.h>
> > >>  #include <asm/entry-common.h>
> > >> +#include <asm/hwprobe.h>
> > >> +#include <asm/cpufeature.h>
> > >>
> > >>  #define INSN_MATCH_LB                  0x3
> > >>  #define INSN_MASK_LB                   0x707f
> > >> @@ -396,8 +399,10 @@ union reg_data {
> > >>         u64 data_u64;
> > >>  };
> > >>
> > >> +static bool unaligned_ctl __read_mostly;
> > >> +
> > >>  /* sysctl hooks */
> > >> -int unaligned_enabled __read_mostly =3D 1;       /* Enabled by defa=
ult */
> > >> +int unaligned_enabled __read_mostly;
> > >>
> > >>  int handle_misaligned_load(struct pt_regs *regs)
> > >>  {
> > >> @@ -412,6 +417,9 @@ int handle_misaligned_load(struct pt_regs *regs)
> > >>         if (!unaligned_enabled)
> > >>                 return -1;
> > >>
> > >> +       if (user_mode(regs) && (current->thread.align_ctl & PR_UNALI=
GN_SIGBUS))
> > >> +               return -1;
> > >> +
> > >>         if (get_insn(regs, epc, &insn))
> > >>                 return -1;
> > >>
> > >> @@ -511,6 +519,9 @@ int handle_misaligned_store(struct pt_regs *regs=
)
> > >>         if (!unaligned_enabled)
> > >>                 return -1;
> > >>
> > >> +       if (user_mode(regs) && (current->thread.align_ctl & PR_UNALI=
GN_SIGBUS))
> > >> +               return -1;
> > >> +
> > >>         if (get_insn(regs, epc, &insn))
> > >>                 return -1;
> > >>
> > >> @@ -585,3 +596,53 @@ int handle_misaligned_store(struct pt_regs *reg=
s)
> > >>
> > >>         return 0;
> > >>  }
> > >> +
> > >> +bool check_unaligned_access_emulated(int cpu)
> > >> +{
> > >> +       unsigned long emulated =3D 1, tmp_var;
> > >> +
> > >> +       /* Use a fixup to detect if misaligned access triggered an e=
xception */
> > >> +       __asm__ __volatile__ (
> > >> +               "1:\n"
> > >> +               "       "REG_L" %[tmp], 1(%[ptr])\n"
> > >> +               "       li %[emulated], 0\n"
> > >> +               "2:\n"
> > >> +               _ASM_EXTABLE(1b, 2b)
> > >> +       : [emulated] "+r" (emulated), [tmp] "=3Dr" (tmp_var)
> > >> +       : [ptr] "r" (&tmp_var)
> > >> +       : "memory");
> > >> +
> > >> +       if (!emulated)
> > >> +               return false;
> > >> +
> > >> +       per_cpu(misaligned_access_speed, cpu) =3D
> > >> +               RISCV_HWPROBE_MISALIGNED_EMULATED;
> > >
> > > For tidiness, can we move the assignment of this per-cpu variable int=
o
> > > check_unaligned_access(), at the spot I referenced above. That way
> > > people looking to see how this variable is set don't have to hunt
> > > through multiple locations.
> >
> > Agreed, that seems better.
> >
> > >
> > >> +
> > >> +       return true;
> > >> +}
> > >> +
> > >> +void __init unaligned_emulation_finish(void)
> > >> +{
> > >> +       int cpu;
> > >> +
> > >> +       /*
> > >> +        * We can only support PR_UNALIGN controls if all CPUs have =
misaligned
> > >> +        * accesses emulated since tasks requesting such control can=
 run on any
> > >> +        * CPU.
> > >> +        */
> > >> +       for_each_possible_cpu(cpu) {
> > >> +               if (per_cpu(misaligned_access_speed, cpu) !=3D
> > >> +                   RISCV_HWPROBE_MISALIGNED_EMULATED) {
> > >> +                       goto out;
> > >> +               }
> > >> +       }
> > >> +       unaligned_ctl =3D true;
> > >

Note: You probably want to loop through the present cpu mask instead
of possible cpus.
Possible cpus list will have all the cpus listed in DT/ACPI. However,
all of them may not come up during the boot.
Hardware errata, different kernel configuration, incorrect DT are few
examples where possible may not match present cpumask.

> > > This doesn't handle the case where a CPU is hotplugged later that
> > > doesn't match with the others. You may want to add a patch that fails
> > > the onlining of that new CPU if unaligned_ctl is true and
> > > new_cpu.misaligned_access_speed !=3D EMULATED.
> >
> > So actually, this will require a bit more plumbing as I realize the
> > switch to disable misalignment support is global. This switch should
> > only be disabled at boot which means I won't be able to disable it at
> > runtime (while hiotplugging a CPU) for CPU detection. There are multipl=
e
> > ways to handle that:
> >
> > 1- Have a per-cpu switch for misalignment handling which would be
> > disabled only when detection is needed.
> >
> > 2- Assume that once detected at boot-time, emulation will not change.
> >
> > Not sure which one is better though. Advice are welcomed.
>
> If I gaze into my own crystal ball, my hope is that the Venn diagram
> of "systems that support hotplug" and "systems that still use software
> assist for misaligned access" is just two circles not touching. If
> people agree with that, then the safe thing to do is enforce it, by

In a sane world, this is probably true. But given that errats exists,
who knows what systems
we may end up with.

> failing to online new hotplugged CPUs that don't conform to
> misaligned_access_speed =3D=3D EMULATED if unaligned_ctl is true. We woul=
d
> sacrifice some future flexibility by making this choice now though, so
> it requires buy-in for this particular crystal ball vision.
>
> -Evan
