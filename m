Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EF47AF656
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 00:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjIZWeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 18:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjIZWcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 18:32:07 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5622D1F9C8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:58:07 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bffa8578feso166405821fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695765485; x=1696370285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfa8a/1GSowkpRTiJNRKMjBAyn9dIA/JPayfLXP3jPU=;
        b=3KZJAg36AFqIApAXAa98tCjhyHp8LebK6z/u+MBJJnX6bRLHulvQJAkLQMZhzeLLIW
         H3noSx3lE7HrWDdox0Z+Joe/qARb88kiVOHEtaoRHeU8qgP6XUFqIZ8r334u/qLl6NpJ
         w/ooCGUZN3Vols2jva0QFw2SDqtzSJLDDzDTSYsVuDBhxNxbDBE1HeOicykMBat8h9DG
         KmrDsWki0Z41nKGwEVHhX8xv7TJYtPK+XXh3bJhHZXwxIwkECj0Nr8sy1tztBLMBVDKn
         Rz3+6GNPRZRCXOTTBTAWvk2DW8+h1xmbwfyV5IIKsOCKEFxFAr8foyV4WjMqLWLMR8PP
         gx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695765485; x=1696370285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfa8a/1GSowkpRTiJNRKMjBAyn9dIA/JPayfLXP3jPU=;
        b=XGxC0a513FtqKZgmK83FSvIHVUHUA18OkCehU02ebhCOuToePAKKfxiCbPdNlF94Lj
         bdgt8pBw9LMhN6izx/l8l1ncCG12GRTGhtU+HwhB5Wm31e1SPsToyy3STZBIDHOSzvfc
         gIxA83sXeJ99gAd8mG35ZUkVzIZNKBHsChroaeCRwnu6o4YUnHpNiYMf21fr0gJgBn8L
         VFpMx2C/LW6FXYz2EAWhHGaCF7TRMZnIaVMHiCJrzn06JE2hXP1wNx6tBjUGjOeVaGI9
         BQlJujzTJK1FNXyiLNITg+Cm7VOKXwNpIZ77kvl4QEcyqacWCeCtWmcucW1RF8HJDF01
         khgA==
X-Gm-Message-State: AOJu0Yx7fkZ1PBi0dbS539lRByEsuPWALxLntg/wYeClbdwjYgC8JE1U
        L5cUz9jaULLkGYfoNWy4LkRfRsBRnVM5JLozO9DdKGuYMFoQfAy/
X-Google-Smtp-Source: AGHT+IELHg4iClXrg2XQwcs4V04PtO3ntPGBgMBfR4g0YyZ38rcBdStsJaz2ygfB3/0N6jU3py/kf3iNczVuvs0T73E=
X-Received: by 2002:a2e:3315:0:b0:2bc:f78a:e5e0 with SMTP id
 d21-20020a2e3315000000b002bcf78ae5e0mr234102ljc.43.1695765485516; Tue, 26 Sep
 2023 14:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230926150316.1129648-1-cleger@rivosinc.com> <20230926150316.1129648-7-cleger@rivosinc.com>
In-Reply-To: <20230926150316.1129648-7-cleger@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Tue, 26 Sep 2023 14:57:29 -0700
Message-ID: <CALs-HssC7oEg0H84D4_gkHpujhBbOOqX-W3k=WrD3SBEGHmaYg@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 8:03=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> hwprobe provides a way to report if misaligned access are emulated. In
> order to correctly populate that feature, we can check if it actually
> traps when doing a misaligned access. This can be checked using an
> exception table entry which will actually be used when a misaligned
> access is done from kernel mode.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/cpufeature.h  |  6 +++
>  arch/riscv/kernel/cpufeature.c       |  6 ++-
>  arch/riscv/kernel/setup.c            |  1 +
>  arch/riscv/kernel/traps_misaligned.c | 63 +++++++++++++++++++++++++++-
>  4 files changed, 74 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index d0345bd659c9..c1f0ef02cd7d 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -8,6 +8,7 @@
>
>  #include <linux/bitmap.h>
>  #include <asm/hwcap.h>
> +#include <asm/hwprobe.h>
>
>  /*
>   * These are probed via a device_initcall(), via either the SBI or direc=
tly
> @@ -32,4 +33,9 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
>
>  void check_unaligned_access(int cpu);
>
> +bool unaligned_ctl_available(void);
> +
> +bool check_unaligned_access_emulated(int cpu);
> +void unaligned_emulation_finish(void);
> +
>  #endif
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 1cfbba65d11a..fbbde800bc21 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -568,6 +568,9 @@ void check_unaligned_access(int cpu)
>         void *src;
>         long speed =3D RISCV_HWPROBE_MISALIGNED_SLOW;
>
> +       if (check_unaligned_access_emulated(cpu))

This spot (referenced below).

> +               return;
> +
>         page =3D alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE=
));
>         if (!page) {
>                 pr_warn("Can't alloc pages to measure memcpy performance"=
);
> @@ -645,9 +648,10 @@ void check_unaligned_access(int cpu)
>         __free_pages(page, get_order(MISALIGNED_BUFFER_SIZE));
>  }
>
> -static int check_unaligned_access_boot_cpu(void)
> +static int __init check_unaligned_access_boot_cpu(void)
>  {
>         check_unaligned_access(0);
> +       unaligned_emulation_finish();
>         return 0;
>  }
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index e600aab116a4..3af6ad4df7cf 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -26,6 +26,7 @@
>  #include <asm/acpi.h>
>  #include <asm/alternative.h>
>  #include <asm/cacheflush.h>
> +#include <asm/cpufeature.h>
>  #include <asm/cpu_ops.h>
>  #include <asm/early_ioremap.h>
>  #include <asm/pgtable.h>
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/tra=
ps_misaligned.c
> index b5fb1ff078e3..fa81f6952fa4 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -9,11 +9,14 @@
>  #include <linux/perf_event.h>
>  #include <linux/irq.h>
>  #include <linux/stringify.h>
> +#include <linux/prctl.h>
>
>  #include <asm/processor.h>
>  #include <asm/ptrace.h>
>  #include <asm/csr.h>
>  #include <asm/entry-common.h>
> +#include <asm/hwprobe.h>
> +#include <asm/cpufeature.h>
>
>  #define INSN_MATCH_LB                  0x3
>  #define INSN_MASK_LB                   0x707f
> @@ -396,8 +399,10 @@ union reg_data {
>         u64 data_u64;
>  };
>
> +static bool unaligned_ctl __read_mostly;
> +
>  /* sysctl hooks */
> -int unaligned_enabled __read_mostly =3D 1;       /* Enabled by default *=
/
> +int unaligned_enabled __read_mostly;
>
>  int handle_misaligned_load(struct pt_regs *regs)
>  {
> @@ -412,6 +417,9 @@ int handle_misaligned_load(struct pt_regs *regs)
>         if (!unaligned_enabled)
>                 return -1;
>
> +       if (user_mode(regs) && (current->thread.align_ctl & PR_UNALIGN_SI=
GBUS))
> +               return -1;
> +
>         if (get_insn(regs, epc, &insn))
>                 return -1;
>
> @@ -511,6 +519,9 @@ int handle_misaligned_store(struct pt_regs *regs)
>         if (!unaligned_enabled)
>                 return -1;
>
> +       if (user_mode(regs) && (current->thread.align_ctl & PR_UNALIGN_SI=
GBUS))
> +               return -1;
> +
>         if (get_insn(regs, epc, &insn))
>                 return -1;
>
> @@ -585,3 +596,53 @@ int handle_misaligned_store(struct pt_regs *regs)
>
>         return 0;
>  }
> +
> +bool check_unaligned_access_emulated(int cpu)
> +{
> +       unsigned long emulated =3D 1, tmp_var;
> +
> +       /* Use a fixup to detect if misaligned access triggered an except=
ion */
> +       __asm__ __volatile__ (
> +               "1:\n"
> +               "       "REG_L" %[tmp], 1(%[ptr])\n"
> +               "       li %[emulated], 0\n"
> +               "2:\n"
> +               _ASM_EXTABLE(1b, 2b)
> +       : [emulated] "+r" (emulated), [tmp] "=3Dr" (tmp_var)
> +       : [ptr] "r" (&tmp_var)
> +       : "memory");
> +
> +       if (!emulated)
> +               return false;
> +
> +       per_cpu(misaligned_access_speed, cpu) =3D
> +               RISCV_HWPROBE_MISALIGNED_EMULATED;

For tidiness, can we move the assignment of this per-cpu variable into
check_unaligned_access(), at the spot I referenced above. That way
people looking to see how this variable is set don't have to hunt
through multiple locations.

> +
> +       return true;
> +}
> +
> +void __init unaligned_emulation_finish(void)
> +{
> +       int cpu;
> +
> +       /*
> +        * We can only support PR_UNALIGN controls if all CPUs have misal=
igned
> +        * accesses emulated since tasks requesting such control can run =
on any
> +        * CPU.
> +        */
> +       for_each_possible_cpu(cpu) {
> +               if (per_cpu(misaligned_access_speed, cpu) !=3D
> +                   RISCV_HWPROBE_MISALIGNED_EMULATED) {
> +                       goto out;
> +               }
> +       }
> +       unaligned_ctl =3D true;

This doesn't handle the case where a CPU is hotplugged later that
doesn't match with the others. You may want to add a patch that fails
the onlining of that new CPU if unaligned_ctl is true and
new_cpu.misaligned_access_speed !=3D EMULATED.

-Evan
