Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274C97DE55B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344486AbjKAR3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjKAR3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:29:35 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D23ED
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:29:32 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c5210a1515so471491fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 10:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698859770; x=1699464570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jozclAAkbWuK97ktQVhF6Gb4xkBxslqFZB+YvHk0zU=;
        b=I+N1cKar73xpA5NQAV/Yf5Zl2YzwvvIJS6RNOJa22rI+FEA3ivyMpYPbPDIZxYPGOb
         gfFwx9CtQQwu5y+aqd2EHMW6xhA0MwKprRUb6t8zeFhO7MvsgcZAkvYIbLJeW7C2LAC+
         yvlD54zBpXMrsgg9hUdRMVEx9g4hSQWiitCfKMQVqkgULPtuiS7nzAvJOWbRNSGKLPbf
         vendYiXAvR8HCbcMm0RxLw0EjFFjLtljQcOEDT06CKtc5bWqgZQXHO/Mo6+au56OijA6
         nYE98Ad/PTlkdXfohvs+ymkcNab39rrNicfe1BmeoaeH9xsAV3lbNFvBz3d8i2pD46hz
         HkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698859770; x=1699464570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jozclAAkbWuK97ktQVhF6Gb4xkBxslqFZB+YvHk0zU=;
        b=xMhRDrL4RZ9Zaop26ZWuHcx5rKr4YZ6VrTLXnHfifxSWviRD/EaHLo4XTMNb22qiPn
         p40I15Qw+s5khBZQXjR5tmfavDC720U35MrbQ/ztACtsXXl7m/Nz9AKOzhDTq9OwO+q3
         8uP3P75aIvvkbqDldreZsw0Q+gZcKEpEfAPdEVx+jEPP/q9nwPomhmjYy5ys7+VpR21q
         RQ96BU6hbpIlV/Aai5yw4T6EVqB7ZfXt8tVcUOZG18SP+zkNEPonnXKWnlYzvzhTMS7l
         cfIAkDU417dCQMerYoY7sBBex6R8Clx88z7yhZaRx3qdE/eVK1LvxT5HRTZLgNSJCt6N
         37tw==
X-Gm-Message-State: AOJu0YxwxOQOxvxjAsQIAzd1gpMi0v3xSNYDQOika9MAuFTwCGKweIO8
        sw0dzt4KLOa+cPyB8gdCrfxTqOrtjhbJQfGWRtHWxQ==
X-Google-Smtp-Source: AGHT+IGWQObjLc7wXHFqqsCDGzmWEby8otQ5d0nNiX7UCUcOOynIg8dO7u4lpTwkyE2ZCDYfWKtySykmAy2TMJbjPBc=
X-Received: by 2002:a2e:9943:0:b0:2c5:21e3:f21a with SMTP id
 r3-20020a2e9943000000b002c521e3f21amr13312951ljj.53.1698859770095; Wed, 01
 Nov 2023 10:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230915184904.1976183-1-evan@rivosinc.com> <ZQVp1PJb+HuEdu4L@xhacker>
 <ZUI3JKff9SgsA3Z/@xhacker>
In-Reply-To: <ZUI3JKff9SgsA3Z/@xhacker>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 1 Nov 2023 10:28:53 -0700
Message-ID: <CALs-HsvA8xW01UrS08MmeRSBb+eic9KX_=jKDZvf59LASnm=Zw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Probe misaligned access speed in parallel
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        David Laight <David.Laight@aculab.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
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

On Wed, Nov 1, 2023 at 4:44=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> w=
rote:
>
> On Sat, Sep 16, 2023 at 04:39:54PM +0800, Jisheng Zhang wrote:
> > On Fri, Sep 15, 2023 at 11:49:03AM -0700, Evan Green wrote:
> > > Probing for misaligned access speed takes about 0.06 seconds. On a
> > > system with 64 cores, doing this in smp_callin() means it's done
> > > serially, extending boot time by 3.8 seconds. That's a lot of boot ti=
me.
> > >
> > > Instead of measuring each CPU serially, let's do the measurements on
> > > all CPUs in parallel. If we disable preemption on all CPUs, the
> > > jiffies stop ticking, so we can do this in stages of 1) everybody
> > > except core 0, then 2) core 0.
> > >
> > > The measurement call in smp_callin() stays around, but is now
> > > conditionalized to only run if a new CPU shows up after the round of
> > > in-parallel measurements has run. The goal is to have the measurement
> > > call not run during boot or suspend/resume, but only on a hotplug
> > > addition.
> > >
> > > Signed-off-by: Evan Green <evan@rivosinc.com>
> >
> > Reported-by: Jisheng Zhang <jszhang@kernel.org>
>
> Hi Evan, Palmer,
>
> This patch seems missing in v6.6, I dunno what happened.
>
> And this patch doesn't fix the boot time regression but also fix a real
> bug during cpu hotplug on and off.

Hi Jisheng,
Just to clarify, you're saying this both fixes the boot regression,
and fixes a hotplug crash? I was slightly thrown off by the "doesn't
fix the boot time regression", holler if there's still something wrong
with boot time.

The splat you pasted suggests the CPU isn't coming back online. Off
the top of my head I can't think of what that might be or why this
patch would fix it. I tried this on an old palmer/for-next and didn't
repro the issue:

# echo 0 > online
[   31.777280] CPU3: off
[   31.777740] CPU3 may not have stopped: 3
# echo 1 > online
[   36.236313] cpu3: Ratio of byte access time to unaligned word
access is 7.26, unaligned accesses are fast

FWIW, Palmer's for-next branch now has the v2 of this patch. I
verified that branch is booting, and hotplug seems to work as well.
-Evan



>
> Here is the reproduce script:
>
> while true
> do
> echo 0 > /sys/devices/system/cpu/cpu1/online
> echo 1 > /sys/devices/system/cpu/cpu1/online
> done
>
>
> Here is the BUG log on qemu:
>
> [   20.950753] CPU1: failed to come online
> [   20.951875] ------------[ cut here ]------------
> [   20.952070] kernel BUG at kernel/time/hrtimer.c:2227!
> [   20.952341] Kernel BUG [#1]
> [   20.952366] Modules linked in:
> [   20.952515] CPU: 0 PID: 46 Comm: sh Not tainted 6.6.0 #3
> [   20.952607] Hardware name: riscv-virtio,qemu (DT)
> [   20.952695] epc : hrtimers_dead_cpu+0x22e/0x230
> [   20.952808]  ra : cpuhp_invoke_callback+0xe4/0x54e
> [   20.952844] epc : ffffffff8007d6c0 ra : ffffffff8000f904 sp : ff600000=
011ebb30
> [   20.952863]  gp : ffffffff80d081d0 tp : ff6000000134da00 t0 : 00000000=
00000040
> [   20.952880]  t1 : 0000000000000000 t2 : 0000000000000000 s0 : ff600000=
011ebbb0
> [   20.952895]  s1 : 0000000000000001 a0 : 0000000000000001 a1 : 00000000=
0000002c
> [   20.952911]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 00000000=
00000000
> [   20.952926]  a5 : 0000000000000001 a6 : 0000000000000538 a7 : 00000000=
00000000
> [   20.952941]  s2 : 000000000000002c s3 : 0000000000000000 s4 : ff600000=
3ffd4390
> [   20.952957]  s5 : ffffffff80d0a1f8 s6 : 0000000000000000 s7 : ffffffff=
8007d492
> [   20.952972]  s8 : 0000000000000001 s9 : fffffffffffffffb s10: 00000000=
00000000
> [   20.952987]  s11: 00005555820dc708 t3 : 0000000000000002 t4 : 00000000=
00000402
> [   20.953002]  t5 : ff600000010f0710 t6 : ff600000010f0718
> [   20.953016] status: 0000000200000120 badaddr: 0000000000000000 cause: =
0000000000000003
> [   20.953124] [<ffffffff8007d6c0>] hrtimers_dead_cpu+0x22e/0x230
> [   20.953226] [<ffffffff8000f904>] cpuhp_invoke_callback+0xe4/0x54e
> [   20.953241] [<ffffffff80010fb8>] _cpu_up+0x200/0x2a2
> [   20.953254] [<ffffffff800110ac>] cpu_up+0x52/0x8a
> [   20.953266] [<ffffffff80011654>] cpu_device_up+0x14/0x1c
> [   20.953279] [<ffffffff8029abb6>] cpu_subsys_online+0x1e/0x68
> [   20.953296] [<ffffffff802957de>] device_online+0x3c/0x70
> [   20.953306] [<ffffffff8029587a>] online_store+0x68/0x8c
> [   20.953317] [<ffffffff802909ba>] dev_attr_store+0xe/0x1a
> [   20.953330] [<ffffffff801df8aa>] sysfs_kf_write+0x2a/0x34
> [   20.953346] [<ffffffff801def06>] kernfs_fop_write_iter+0xde/0x162
> [   20.953360] [<ffffffff8018154a>] vfs_write+0x136/0x320
> [   20.953372] [<ffffffff801818e4>] ksys_write+0x4a/0xb4
> [   20.953383] [<ffffffff80181962>] __riscv_sys_write+0x14/0x1c
> [   20.953394] [<ffffffff803dec7e>] do_trap_ecall_u+0x4a/0x110
> [   20.953420] [<ffffffff80003666>] ret_from_exception+0x0/0x66
> [   20.953648] Code: 7c42 7ca2 7d02 6de2 4501 6109 8082 c0ef 7463 bd1d (9=
002) 1141
> [   20.953897] ---[ end trace 0000000000000000 ]---
> [   20.954068] Kernel panic - not syncing: Fatal exception in interrupt
> [   20.954128] SMP: stopping secondary CPUs
> [   22.749953] SMP: failed to stop secondary CPUs 0-1
> [   22.803768] ---[ end Kernel panic - not syncing: Fatal exception in in=
terrupt ]---
>
>
> > >
> > > ---
> > >
> > > Jisheng, I didn't add your Tested-by tag since the patch evolved from
> > > the one you tested. Hopefully this one brings you the same result.
> > >
> > > ---
> > >  arch/riscv/include/asm/cpufeature.h |  3 ++-
> > >  arch/riscv/kernel/cpufeature.c      | 28 +++++++++++++++++++++++----=
-
> > >  arch/riscv/kernel/smpboot.c         | 11 ++++++++++-
> > >  3 files changed, 35 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include=
/asm/cpufeature.h
> > > index d0345bd659c9..19e7817eba10 100644
> > > --- a/arch/riscv/include/asm/cpufeature.h
> > > +++ b/arch/riscv/include/asm/cpufeature.h
> > > @@ -30,6 +30,7 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
> > >  /* Per-cpu ISA extensions. */
> > >  extern struct riscv_isainfo hart_isa[NR_CPUS];
> > >
> > > -void check_unaligned_access(int cpu);
> > > +extern bool misaligned_speed_measured;
> > > +int check_unaligned_access(void *unused);
> > >
> > >  #endif
> > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufe=
ature.c
> > > index 1cfbba65d11a..8eb36e1dfb95 100644
> > > --- a/arch/riscv/kernel/cpufeature.c
> > > +++ b/arch/riscv/kernel/cpufeature.c
> > > @@ -42,6 +42,9 @@ struct riscv_isainfo hart_isa[NR_CPUS];
> > >  /* Performance information */
> > >  DEFINE_PER_CPU(long, misaligned_access_speed);
> > >
> > > +/* Boot-time in-parallel unaligned access measurement has occurred. =
*/
> > > +bool misaligned_speed_measured;
> >
> > This var can be avoided, see below.
> >
> > > +
> > >  /**
> > >   * riscv_isa_extension_base() - Get base extension word
> > >   *
> > > @@ -556,8 +559,9 @@ unsigned long riscv_get_elf_hwcap(void)
> > >     return hwcap;
> > >  }
> > >
> > > -void check_unaligned_access(int cpu)
> > > +int check_unaligned_access(void *unused)
> > >  {
> > > +   int cpu =3D smp_processor_id();
> > >     u64 start_cycles, end_cycles;
> > >     u64 word_cycles;
> > >     u64 byte_cycles;
> > > @@ -571,7 +575,7 @@ void check_unaligned_access(int cpu)
> > >     page =3D alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE=
));
> > >     if (!page) {
> > >             pr_warn("Can't alloc pages to measure memcpy performance"=
);
> > > -           return;
> > > +           return 0;
> > >     }
> > >
> > >     /* Make an unaligned destination buffer. */
> > > @@ -643,15 +647,29 @@ void check_unaligned_access(int cpu)
> > >
> > >  out:
> > >     __free_pages(page, get_order(MISALIGNED_BUFFER_SIZE));
> > > +   return 0;
> > > +}
> > > +
> > > +static void check_unaligned_access_nonboot_cpu(void *param)
> > > +{
> > > +   if (smp_processor_id() !=3D 0)
> > > +           check_unaligned_access(param);
> > >  }
> > >
> > > -static int check_unaligned_access_boot_cpu(void)
> > > +static int check_unaligned_access_all_cpus(void)
> > >  {
> > > -   check_unaligned_access(0);
> > > +   /* Check everybody except 0, who stays behind to tend jiffies. */
> > > +   on_each_cpu(check_unaligned_access_nonboot_cpu, NULL, 1);
> > > +
> > > +   /* Check core 0. */
> > > +   smp_call_on_cpu(0, check_unaligned_access, NULL, true);
> > > +
> > > +   /* Boot-time measurements are complete. */
> > > +   misaligned_speed_measured =3D true;
> > >     return 0;
> > >  }
> > >
> > > -arch_initcall(check_unaligned_access_boot_cpu);
> > > +arch_initcall(check_unaligned_access_all_cpus);
> > >
> > >  #ifdef CONFIG_RISCV_ALTERNATIVE
> > >  /*
> > > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.=
c
> > > index 1b8da4e40a4d..39322ae20a75 100644
> > > --- a/arch/riscv/kernel/smpboot.c
> > > +++ b/arch/riscv/kernel/smpboot.c
> > > @@ -27,6 +27,7 @@
> > >  #include <linux/sched/mm.h>
> > >  #include <asm/cpu_ops.h>
> > >  #include <asm/cpufeature.h>
> > > +#include <asm/hwprobe.h>
> > >  #include <asm/irq.h>
> > >  #include <asm/mmu_context.h>
> > >  #include <asm/numa.h>
> > > @@ -246,7 +247,15 @@ asmlinkage __visible void smp_callin(void)
> > >
> > >     numa_add_cpu(curr_cpuid);
> > >     set_cpu_online(curr_cpuid, 1);
> > > -   check_unaligned_access(curr_cpuid);
> > > +
> > > +   /*
> > > +    * Boot-time misaligned access speed measurements are done in par=
allel
> > > +    * in an initcall. Only measure here for hotplug.
> > > +    */
> > > +   if (misaligned_speed_measured &&
> > > +       (per_cpu(misaligned_access_speed, curr_cpuid) =3D=3D RISCV_HW=
PROBE_MISALIGNED_UNKNOWN)) {
> >
> > I believe this check is for cpu not-booted during boot time but hotplug=
 in
> > after that, if so I'm not sure whether
> > misaligned_speed_measured can be replaced with
> > (system_state =3D=3D SYSTEM_RUNNING)
> > then we don't need misaligned_speed_measured at all.
> >
> > > +           check_unaligned_access(NULL);
> > > +   }
> > >
> > >     if (has_vector()) {
> > >             if (riscv_v_setup_vsize())
> > > --
> > > 2.34.1
> > >
