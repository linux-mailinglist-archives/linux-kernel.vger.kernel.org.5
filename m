Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCB47E4765
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbjKGRps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbjKGRpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:45:17 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8665C10FA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 09:45:12 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ce532451c7so3139174a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 09:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1699379111; x=1699983911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLw1ycS53eoBey8p/LpxiLSZTGGyXo8/Ae2SXePJVaQ=;
        b=bfGGWXex+cAK0UYoTmP2CGyY6S565VVNbCKViz/b3tQDGJBJWlHsJ7JVqQo1grFzPP
         RIzBdUcBrOwyQiM39IxIM6e/6SYkbSiNxc+Sa9z/yFQNRIC8dgBsUr1r/HIbkVGPtq2d
         FhhvMcBQKi+4FWU4ZLOhlf1L1bMV9CQJcO+UDgBH/HfK15wWmxdLUjdZXE+o6eHdLxC4
         8FwAfZUoasy9UKdX/7QPUZHzrU0CoRVl5d0Ghd+TGVPe7LKA0eL4Fch91Pupe6KFdFS0
         fbSLaD4yRe6CAYzORsilY2+0+vvlPEdUkoBs86HP9gPbZW4BQbC4hsEbYx3ieuMu1Czm
         O0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699379111; x=1699983911;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLw1ycS53eoBey8p/LpxiLSZTGGyXo8/Ae2SXePJVaQ=;
        b=FAKwWUJm3DJlmT07Pz+DSIqgmnf9QCV/Gg2iI9YW3uucuFyf23QY83ERv8me6f4a1A
         ICFS+SQ9d/aZKWA5RgQeYeA1Ean0cE0gNC3xDy7YjvQeiukuBCQnyQt/JMAJVuy5zKGP
         WiSQC/pYI9TWWSnkk4ExFLQD05bpUkPji15rRt4MTpSE7lH8PGB0DsRO+aguWhWSor1G
         5XxU6GYUPQ7786wvJV4yGQsXUOuJqyijf96QCQ+kJrQK8ixuHQ2lJKo6x2X2LxXlgWV2
         xIcF7nxg2dJt3TALMkabYaEhnzT6NQnRaQ00X79re/hkZv/n9mm7m7BKvjlcXC6s8A1H
         EaEw==
X-Gm-Message-State: AOJu0Yw64HvxN1UeYNOk8pPeEeJFezKZfmW9BZMJUKJj+2ayIhug9EGa
        AOPC8iG3+IFuVNKN6sb6XmafJg==
X-Google-Smtp-Source: AGHT+IHlLVdERqtE0XvCqLkdz065+DVCPLV1AtuGY6e3yJ09g92r1jrGx//kJTvNDqRtAkpZI5gK9A==
X-Received: by 2002:a54:4114:0:b0:3a8:4d1f:9da5 with SMTP id l20-20020a544114000000b003a84d1f9da5mr28836438oic.31.1699379110989;
        Tue, 07 Nov 2023 09:45:10 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id j26-20020aca171a000000b003b2df32d9a9sm1617905oii.19.2023.11.07.09.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 09:45:10 -0800 (PST)
Date:   Tue, 07 Nov 2023 09:45:10 -0800 (PST)
X-Google-Original-Date: Tue, 07 Nov 2023 09:45:08 PST (-0800)
Subject:     Re: [PATCH v3] RISC-V: Probe misaligned access speed in parallel
In-Reply-To: <CALs-HsvX=zHvSKV5Skuxk=7jWq_mGqhsRSeuefD7OiYOCr3Gkw@mail.gmail.com>
CC:     bigeasy@linutronix.de, jszhang@kernel.org, David.Laight@aculab.com,
        aou@eecs.berkeley.edu, ajones@ventanamicro.com,
        apatel@ventanamicro.com, cleger@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        greentime.hu@sifive.com, heiko@sntech.de,
        leyfoon.tan@starfivetech.com, Marc Zyngier <maz@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        sunilvl@ventanamicro.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Evan Green <evan@rivosinc.com>
Message-ID: <mhng-7b97d1d2-d230-42ef-b3e8-5312da36495e@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2023 09:26:03 PST (-0800), Evan Green wrote:
> On Tue, Nov 7, 2023 at 12:34 AM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
>>
>> On 2023-11-06 14:58:55 [-0800], Evan Green wrote:
>> > Probing for misaligned access speed takes about 0.06 seconds. On a
>> > system with 64 cores, doing this in smp_callin() means it's done
>> > serially, extending boot time by 3.8 seconds. That's a lot of boot time.
>> >
>> > Instead of measuring each CPU serially, let's do the measurements on
>> > all CPUs in parallel. If we disable preemption on all CPUs, the
>> > jiffies stop ticking, so we can do this in stages of 1) everybody
>> > except core 0, then 2) core 0. The allocations are all done outside of
>> > on_each_cpu() to avoid calling alloc_pages() with interrupts disabled.
>> >
>> > For hotplugged CPUs that come in after the boot time measurement,
>> > register CPU hotplug callbacks, and do the measurement there. Interrupts
>> > are enabled in those callbacks, so they're fine to do alloc_pages() in.
>>
>> I think this is dragged out of proportion. I would do this (if needed
>> can can't be identified by CPU-ID or so) on boot CPU only. If there is
>> evidence/ proof/ blessing from the high RiscV council that different
>> types of CPU cores are mixed together then this could be extended.
>> You brought Big-Little up in the other thread. This is actually known.
>> Same as with hyper-threads on x86, you know which CPU is the core and
>> which hyper thread (CPU) belongs to it.
>> So in terms of BigLittle you _could_ limit this to one Big and one
>> Little core instead running it on all.
>
> Doing it on one per cluster might also happen to work, but I still see
> nothing that prevents variety within a cluster, so I'm not comfortable
> with that assumption. It also doesn't buy much. I'm not sure what kind
> of guidance RVI is providing on integrating multiple CPUs into a
> system. I haven't seen any myself, but am happy to reassess if there's
> documentation banning the scenarios I'm imagining.

IIUC there's pretty much no rules here, and vendors are already building 
wacky systems (the K230 just showed up with heterogenous-ISA cores, 
we've got a handful now).  I guess we could write up some guidance in 
Documentation/riscv describing what sort of systems we generally test 
on, but given how RISC-V generally goes vendors are just going to build 
the crazy stuff anyway and we'll have to deal with it.

>
>>
>> But this is just my few on this. From PREEMPT_RT's point of view, the
>> way you restructured the memory allocation should work now.
>
> Thanks!
>
>>
>> > Reported-by: Jisheng Zhang <jszhang@kernel.org>
>> > Closes: https://lore.kernel.org/all/mhng-9359993d-6872-4134-83ce-c97debe1cf9a@palmer-ri-x1c9/T/#mae9b8f40016f9df428829d33360144dc5026bcbf
>> > Fixes: 584ea6564bca ("RISC-V: Probe for unaligned access speed")
>> > Signed-off-by: Evan Green <evan@rivosinc.com>
>> >
>> >
>> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> > index 6a01ded615cd..fe59e18dbd5b 100644
>> > --- a/arch/riscv/kernel/cpufeature.c
>> > +++ b/arch/riscv/kernel/cpufeature.c
>> …
>> >
>> > -static int __init check_unaligned_access_boot_cpu(void)
>> > +/* Measure unaligned access on all CPUs present at boot in parallel. */
>> > +static int check_unaligned_access_all_cpus(void)
>> >  {
>> > -     check_unaligned_access(0);
>> > +     unsigned int cpu;
>> > +     unsigned int cpu_count = num_possible_cpus();
>> > +     struct page **bufs = kzalloc(cpu_count * sizeof(struct page *),
>> > +                                  GFP_KERNEL);
>>
>> kcalloc(). For beauty reasons you could try a reverse xmas tree.
>>
>> > +
>> > +     if (!bufs) {
>> > +             pr_warn("Allocation failure, not measuring misaligned performance\n");
>> > +             return 0;
>> > +     }
>> > +
>> > +     /*
>> > +      * Allocate separate buffers for each CPU so there's no fighting over
>> > +      * cache lines.
>> > +      */
>> > +     for_each_cpu(cpu, cpu_online_mask) {
>> > +             bufs[cpu] = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
>> > +             if (!bufs[cpu]) {
>> > +                     pr_warn("Allocation failure, not measuring misaligned performance\n");
>> > +                     goto out;
>> > +             }
>> > +     }
>> > +
>> > +     /* Check everybody except 0, who stays behind to tend jiffies. */
>> > +     on_each_cpu(check_unaligned_access_nonboot_cpu, bufs, 1);
>>
>> comments! _HOW_ do you ensure that CPU0 is left out? You don't. CPU0
>> does this and the leaves which is a waste. Using on_each_cpu_cond()
>> could deal with this. And you have the check within the wrapper
>> (check_unaligned_access_nonboot_cpu()) anyway.
>>
>> > +     /* Check core 0. */
>> > +     smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
>>
>> Now that comment is obvious. If you want to add a comment, why not state
>> why CPU0 has to be done last?
>>
>> > +
>> > +     /* Setup hotplug callback for any new CPUs that come online. */
>> > +     cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
>> > +                               riscv_online_cpu, NULL);
>> Instead riscv:online you could use riscv:unaliged_check or something
>> that pin points the callback to something obvious. This is exported via
>> sysfs.
>>
>> Again, comment is obvious. For that to make sense would require RiscV to
>> support physical-hotplug. For KVM like environment (where you can plug in
>> CPUs later) this probably doesn't make sense at all. Why not? Because
>>
>> - without explicit CPU pinning your slow/ fast CPU mapping (host <->
>>   guest) could change if the scheduler on the host moves the threads
>>   around.
>
> Taking a system with non-identical cores and allowing vcpus to bounce
> between them sounds like a hypervisor configuration issue to me,
> regardless of this patch.
>
>>
>> - without explicit task offload and resource partitioning on the host
>>   your guest thread might get interrupt during the measurement. This is
>>   done during boot so chances are high that it runs 100% of its time
>>   slice and will be preempted once other tasks on the host ask for CPU
>>   run time.
>
> The measurement takes the best (lowest time) iteration. So unless
> every iteration gets interrupted, I should get a good read in there
> somewhere.
> -Evan
