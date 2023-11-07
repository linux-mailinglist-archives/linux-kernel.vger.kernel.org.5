Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207C07E46E2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343599AbjKGR0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjKGR0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:26:44 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102159C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 09:26:42 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c59a4dd14cso79707401fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 09:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699378000; x=1699982800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZkd52T+YeGKBl1CYuJ00AYOxiV6R4Ssf73ETNqj2ro=;
        b=wfpI4fZIYD2FY18rmTuqhs1y8OIUW5vd6zjPiM3NTOu7cjDhq1p0We7z8CKVu4oAvb
         jOETT44cZumddSwF1DOP/dNIRrfetCrwniUHtiOFGv2EN7mZm5tLF7GuUvEt2qTHPGiu
         J8KM9QJdbY00BOgrGlbbSYzZ4C7qpD3uFASqJecrhchYvuMSwuvNgePdWzyheIbSgD+N
         UYKFPh0QJgx3X1AzYUZE65MRm+wi6DAYh1zOJId7wHHXkwvSmWMoAbFCxKvEHvvuuWeG
         8b4Qw/QFQwqJmWbHQ9hwy/M1+O/cOs+b1oMokWCYy4dpchsp6x5V6A0mdyqY85sSPFqz
         L2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699378000; x=1699982800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZkd52T+YeGKBl1CYuJ00AYOxiV6R4Ssf73ETNqj2ro=;
        b=swAaMXGR289rrJ4R/Psz1NR+w9hGfPUTmqzjiGHQHgm2wzkB99WfImVhNx4mYO16Ph
         81NKYA/9egQndfAiIADpKDvacOA0nwEWoPuU62UoF5M02ky0W85GRw8RCnRwntJBpcnH
         KQx3SK27Io7FuKtxG+GWtOJwnwZk/j/Yb+gjj9g3uSLKIoyIZQPK0JcJPvn4QrA317w5
         1MTwzZmi1VEivV1y6Cn46IxPm/ZWhAJ/3wdjjCoOUJlZWsS1WQb0Htt+YDc7LsLGIbzO
         hDoKdwvsrfB16+ObfJmQT3CqE51ywaDIwxjvzQhUvMQTOmZ7U2xLK//NN0HYfdTGLjrd
         YlLA==
X-Gm-Message-State: AOJu0Yz5ss99/rdRdTKdLueAajQX0XQSLqUPdYCwc84MVZCF0NwTPCa9
        XLQwuRLZADWQBgfte6QIjyyWIPC6Kt2TC35YjCSLlQ==
X-Google-Smtp-Source: AGHT+IGl3P2xisn8Pi9jVTal1vZEOJryHpdqi/VfjD1sA5j/mthxIgAxL+CVC4H+Kt5HKX96fyStWaaIsFoUI3IyO/o=
X-Received: by 2002:a2e:5056:0:b0:2c5:1640:3c97 with SMTP id
 v22-20020a2e5056000000b002c516403c97mr27445634ljd.22.1699378000137; Tue, 07
 Nov 2023 09:26:40 -0800 (PST)
MIME-Version: 1.0
References: <20231106225855.3121724-1-evan@rivosinc.com> <20231107083411.J3ga0YmA@linutronix.de>
In-Reply-To: <20231107083411.J3ga0YmA@linutronix.de>
From:   Evan Green <evan@rivosinc.com>
Date:   Tue, 7 Nov 2023 09:26:03 -0800
Message-ID: <CALs-HsvX=zHvSKV5Skuxk=7jWq_mGqhsRSeuefD7OiYOCr3Gkw@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: Probe misaligned access speed in parallel
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 12:34=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2023-11-06 14:58:55 [-0800], Evan Green wrote:
> > Probing for misaligned access speed takes about 0.06 seconds. On a
> > system with 64 cores, doing this in smp_callin() means it's done
> > serially, extending boot time by 3.8 seconds. That's a lot of boot time=
.
> >
> > Instead of measuring each CPU serially, let's do the measurements on
> > all CPUs in parallel. If we disable preemption on all CPUs, the
> > jiffies stop ticking, so we can do this in stages of 1) everybody
> > except core 0, then 2) core 0. The allocations are all done outside of
> > on_each_cpu() to avoid calling alloc_pages() with interrupts disabled.
> >
> > For hotplugged CPUs that come in after the boot time measurement,
> > register CPU hotplug callbacks, and do the measurement there. Interrupt=
s
> > are enabled in those callbacks, so they're fine to do alloc_pages() in.
>
> I think this is dragged out of proportion. I would do this (if needed
> can can't be identified by CPU-ID or so) on boot CPU only. If there is
> evidence/ proof/ blessing from the high RiscV council that different
> types of CPU cores are mixed together then this could be extended.
> You brought Big-Little up in the other thread. This is actually known.
> Same as with hyper-threads on x86, you know which CPU is the core and
> which hyper thread (CPU) belongs to it.
> So in terms of BigLittle you _could_ limit this to one Big and one
> Little core instead running it on all.

Doing it on one per cluster might also happen to work, but I still see
nothing that prevents variety within a cluster, so I'm not comfortable
with that assumption. It also doesn't buy much. I'm not sure what kind
of guidance RVI is providing on integrating multiple CPUs into a
system. I haven't seen any myself, but am happy to reassess if there's
documentation banning the scenarios I'm imagining.

>
> But this is just my few on this. From PREEMPT_RT's point of view, the
> way you restructured the memory allocation should work now.

Thanks!

>
> > Reported-by: Jisheng Zhang <jszhang@kernel.org>
> > Closes: https://lore.kernel.org/all/mhng-9359993d-6872-4134-83ce-c97deb=
e1cf9a@palmer-ri-x1c9/T/#mae9b8f40016f9df428829d33360144dc5026bcbf
> > Fixes: 584ea6564bca ("RISC-V: Probe for unaligned access speed")
> > Signed-off-by: Evan Green <evan@rivosinc.com>
> >
> >
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index 6a01ded615cd..fe59e18dbd5b 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> =E2=80=A6
> >
> > -static int __init check_unaligned_access_boot_cpu(void)
> > +/* Measure unaligned access on all CPUs present at boot in parallel. *=
/
> > +static int check_unaligned_access_all_cpus(void)
> >  {
> > -     check_unaligned_access(0);
> > +     unsigned int cpu;
> > +     unsigned int cpu_count =3D num_possible_cpus();
> > +     struct page **bufs =3D kzalloc(cpu_count * sizeof(struct page *),
> > +                                  GFP_KERNEL);
>
> kcalloc(). For beauty reasons you could try a reverse xmas tree.
>
> > +
> > +     if (!bufs) {
> > +             pr_warn("Allocation failure, not measuring misaligned per=
formance\n");
> > +             return 0;
> > +     }
> > +
> > +     /*
> > +      * Allocate separate buffers for each CPU so there's no fighting =
over
> > +      * cache lines.
> > +      */
> > +     for_each_cpu(cpu, cpu_online_mask) {
> > +             bufs[cpu] =3D alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_O=
RDER);
> > +             if (!bufs[cpu]) {
> > +                     pr_warn("Allocation failure, not measuring misali=
gned performance\n");
> > +                     goto out;
> > +             }
> > +     }
> > +
> > +     /* Check everybody except 0, who stays behind to tend jiffies. */
> > +     on_each_cpu(check_unaligned_access_nonboot_cpu, bufs, 1);
>
> comments! _HOW_ do you ensure that CPU0 is left out? You don't. CPU0
> does this and the leaves which is a waste. Using on_each_cpu_cond()
> could deal with this. And you have the check within the wrapper
> (check_unaligned_access_nonboot_cpu()) anyway.
>
> > +     /* Check core 0. */
> > +     smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
>
> Now that comment is obvious. If you want to add a comment, why not state
> why CPU0 has to be done last?
>
> > +
> > +     /* Setup hotplug callback for any new CPUs that come online. */
> > +     cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
> > +                               riscv_online_cpu, NULL);
> Instead riscv:online you could use riscv:unaliged_check or something
> that pin points the callback to something obvious. This is exported via
> sysfs.
>
> Again, comment is obvious. For that to make sense would require RiscV to
> support physical-hotplug. For KVM like environment (where you can plug in
> CPUs later) this probably doesn't make sense at all. Why not? Because
>
> - without explicit CPU pinning your slow/ fast CPU mapping (host <->
>   guest) could change if the scheduler on the host moves the threads
>   around.

Taking a system with non-identical cores and allowing vcpus to bounce
between them sounds like a hypervisor configuration issue to me,
regardless of this patch.

>
> - without explicit task offload and resource partitioning on the host
>   your guest thread might get interrupt during the measurement. This is
>   done during boot so chances are high that it runs 100% of its time
>   slice and will be preempted once other tasks on the host ask for CPU
>   run time.

The measurement takes the best (lowest time) iteration. So unless
every iteration gets interrupted, I should get a good read in there
somewhere.
-Evan
