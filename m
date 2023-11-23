Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B5D7F622B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjKWO72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWO70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:59:26 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C254D44
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:59:32 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50aa698b384so3620e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700751570; x=1701356370; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rjsWntyf3ek48ZMQ86Tl47VHUhxQBToAw1VMl26tGwI=;
        b=ypfUEMC1zhDbP8TPD+o/xxlQVco6ux0itqjb/6qbuuj+MLiwJJQHHiaSYOn8c9jnBj
         GLVjNVIYwWMPCby4k/rffYQAr6Gk61jcY15KNhZU3b7lvNwnA6x7GGGDflxtqNJKv/dt
         iKLaQGL5PumCedxR4gACm+G3Vy1Ypr+cFlKscGHYkfcdn6ZSD46GY1MELmN2QAKtKIRC
         o1rCfvFtOIFURduE0ulPvD+OYP5YEghn91pvOST8bC85fOII/L/2fGfjZEeBgdAUw1ay
         vtmKxr9JNKO1meE3Q6moNJ4NLK2D408XpEcGSIPYYeuZyvnY0SAiU9MLrdRlmoD5LQfd
         SrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700751570; x=1701356370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjsWntyf3ek48ZMQ86Tl47VHUhxQBToAw1VMl26tGwI=;
        b=vZpnPFlGNcyHCU5Kuso84+9NyQlvS3TV8Yox24Qnw5iSmIZS5XqbC0E/pmjZa+n10n
         j8uqxx41xR90rKnUg81HzZxx2V9quUpxh0OE9pf7dHikKbtGINgOUKOVRPpRYcLwm/xs
         YjRK5FdNcr2HDN8DNTeIm9SyPduQzF8fsR01NDiFvAdhK5qHZ/ZXBqDVMGFGcmoJLMIq
         FuFq0FEIjFdeoRm1j38ucl63rzpp1NJ+lCEZpZMCUVI6ltlHufJstdIJ3fKVrBXT9TcZ
         r+0iyB0y51NHHM4T5GU+O6eGRI3VTVyH4UTXsuS45XSy8GNldA1U3tmV+vqTuqTaEo+e
         YqbA==
X-Gm-Message-State: AOJu0YwCz9RKAbgqstFVz/rxDKmniadYpUYlXnLeWwu6CoyNL7CFyB+A
        bN469Rdk5tE5+PzdtbZwo7y61nVYVT+K81jSg5Yo7A==
X-Google-Smtp-Source: AGHT+IHIl/WBZ2iDyzl0IR+ziEaFAWIlCfOa3lmlYRCwgZw978+0QVt/5bBPs7XrHN1JL0NxP4OnuWDIrySOcoIbrbs=
X-Received: by 2002:a19:ad43:0:b0:504:7b50:ec9a with SMTP id
 s3-20020a19ad43000000b005047b50ec9amr144412lfd.1.1700751569826; Thu, 23 Nov
 2023 06:59:29 -0800 (PST)
MIME-Version: 1.0
References: <VI1P193MB0752058FAECD2AC1E5E68D7399B3A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CACT4Y+Ya4yTvAmaELJN5st3GJYo1KKzC9qw9sdD0g3jb48O7tg@mail.gmail.com>
 <VI1P193MB075265616010AF82CE201ADD99B1A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CACT4Y+ZE8DO1u6NHATXC9tfcVS4diM0LO4r3cQ15HaGHVoFAbQ@mail.gmail.com> <VI1P193MB075296EFE305E5A6C3A4701699B9A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <VI1P193MB075296EFE305E5A6C3A4701699B9A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 23 Nov 2023 15:59:17 +0100
Message-ID: <CACT4Y+akBeAOBhyxj4jBmOOS73+yVRJvh0rSXfDV8dt_aAGkwg@mail.gmail.com>
Subject: Re: [RFC PATCH] kasan: Record and report more information
To:     Juntong Deng <juntong.deng@outlook.com>,
        Marco Elver <elver@google.com>
Cc:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        vincenzo.frascino@arm.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 at 11:06, Juntong Deng <juntong.deng@outlook.com> wrote:
>
> On 2023/11/20 19:06, Dmitry Vyukov wrote:
> > On Wed, 15 Nov 2023 at 22:53, Juntong Deng <juntong.deng@outlook.com> wrote:
> >>
> >> On 2023/11/14 15:27, Dmitry Vyukov wrote:
> >>> On Mon, 13 Nov 2023 at 22:17, Juntong Deng <juntong.deng@outlook.com> wrote:
> >>>>
> >>>> Record and report more information to help us find the cause of
> >>>> the bug (for example, bugs caused by subtle race condition).
> >>>>
> >>>> This patch adds recording and showing CPU number and timestamp at
> >>>> allocation and free (controlled by CONFIG_KASAN_EXTRA_INFO), and
> >>>> adds recording and showing timestamp at error occurrence (CPU number
> >>>> is already shown by dump_stack_lvl). The timestamps in the report use
> >>>> the same format and source as printk.
> >>>>
> >>>> In order to record CPU number and timestamp at allocation and free,
> >>>> corresponding members need to be added to the relevant data structures,
> >>>> which may lead to increased memory consumption.
> >>>>
> >>>> In Generic KASAN, members are added to struct kasan_track. Since in
> >>>> most cases, alloc meta is stored in the redzone and free meta is
> >>>> stored in the object or the redzone, memory consumption will not
> >>>> increase much.
> >>>>
> >>>> In SW_TAGS KASAN and HW_TAGS KASAN, members are added to
> >>>> struct kasan_stack_ring_entry. Memory consumption increases as the
> >>>> size of struct kasan_stack_ring_entry increases (this part of the
> >>>> memory is allocated by memblock), but since this is configurable,
> >>>> it is up to the user to choose.
> >>>>
> >>>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> >>>> ---
> >>>>    lib/Kconfig.kasan      | 11 +++++++++++
> >>>>    mm/kasan/common.c      |  5 +++++
> >>>>    mm/kasan/kasan.h       |  9 +++++++++
> >>>>    mm/kasan/report.c      | 28 ++++++++++++++++++++++------
> >>>>    mm/kasan/report_tags.c | 18 ++++++++++++++++++
> >>>>    mm/kasan/tags.c        | 15 +++++++++++++++
> >>>>    6 files changed, 80 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> >>>> index fdca89c05745..d9611564b339 100644
> >>>> --- a/lib/Kconfig.kasan
> >>>> +++ b/lib/Kconfig.kasan
> >>>> @@ -207,4 +207,15 @@ config KASAN_MODULE_TEST
> >>>>             A part of the KASAN test suite that is not integrated with KUnit.
> >>>>             Incompatible with Hardware Tag-Based KASAN.
> >>>>
> >>>> +config KASAN_EXTRA_INFO
> >>>> +       bool "Record and report more information"
> >>>> +       depends on KASAN
> >>>> +       help
> >>>> +         Record and report more information to help us find the cause of
> >>>> +         the bug. The trade-off is potentially increased memory consumption
> >>>> +         (to record more information).
> >>>> +
> >>>> +         Currently the CPU number and timestamp are additionally recorded
> >>>> +         at allocation and free.
> >>>
> >>> Hi Juntong,
> >>>
> >>> Thanks for working on this.
> >>>
> >>
> >>
> >> Thanks for your reply!
> >>
> >>
> >>> As a KASAN developer I understand what this is doing, but I am trying
> >>> to think from a position of a user that does not know details of KASAN
> >>> implementation. From this position it may be useful to say somewhere
> >>> that information is recorded "per heap allocation". Perhaps something
> >>> like:
> >>>
> >>> "Currently the CPU number and timestamp are additionally recorded for
> >>> each heap block at allocation and free time".
> >>
> >>
> >> Yes, I agree, that is a better expression.
> >>
> >>
> >>>
> >>> Also it's unclear what the memory consumption increase is. You say
> >>> "potentially|, so may it not increase at all? If it increases, by how
> >>> much? I obviously want more information, if I can afford it, but I
> >>> can't understand if I can or not based on this description. I would
> >>> assume that this may be a problem only for small/embedded devices.
> >>> Can we provide some ballpark estimation of the memory consumption
> >>> increase? And somehow say that's probably not an issue for larger
> >>> machines?
> >>>
> >>
> >>
> >> How about this expression?
> >>
> >> Currently, in order to record CPU number and timestamp, the data
> >> structure to record allocation and free information will increase
> >> by 12 bytes.
> >>
> >> In Generic KASAN, this affects all allocations less than 32 bytes.
> >> In SW_TAGS KASAN and HW_TAGS KASAN, depending on the stack_ring_size
> >> boot parameter increases the memory consumption by
> >> 12 * stack_ring_size bytes.
> >
> > Let's go with this version.
> >
> >
> >>>>    endif # KASAN
> >>>> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> >>>> index 256930da578a..7a81566d9d66 100644
> >>>> --- a/mm/kasan/common.c
> >>>> +++ b/mm/kasan/common.c
> >>>> @@ -20,6 +20,7 @@
> >>>>    #include <linux/module.h>
> >>>>    #include <linux/printk.h>
> >>>>    #include <linux/sched.h>
> >>>> +#include <linux/sched/clock.h>
> >>>>    #include <linux/sched/task_stack.h>
> >>>>    #include <linux/slab.h>
> >>>>    #include <linux/stacktrace.h>
> >>>> @@ -50,6 +51,10 @@ void kasan_set_track(struct kasan_track *track, gfp_t flags)
> >>>>    {
> >>>>           track->pid = current->pid;
> >>>>           track->stack = kasan_save_stack(flags, true);
> >>>> +#ifdef CONFIG_KASAN_EXTRA_INFO
> >>>> +       track->cpu = raw_smp_processor_id();
> >>>> +       track->ts_nsec = local_clock();
> >>>
> >>> What does "local_" mean? Is this clock value comparable across CPUs?
> >>>
> >>
> >>
> >> No, local_clock is the local CPU clock and cannot be used for comparison
> >> across CPUs, I made a mistake here.
> >>
> >> I delved into the clock subsystem of the Linux kernel today and I found
> >> that we have two choices.
> >>
> >> - sched_clock(): based on jiffies, high performance, but on some
> >> hardware, it will drift between CPUs.
> >>
> >> - ktime_get_boot_fast_ns(): based on clocksource, highly accurate,
> >> can be compared between CPUs, but performance is worse (seqlock).
> >>
> >> I tested 100000 calls respectively on my laptop, the average of
> >> sched_clock() is 17ns and the average of ktime_get_boot_fast_ns()
> >> is 25ns.
> >>
> >> ktime_get_boot_fast_ns() takes about 1.5 times as long as sched_clock().
> >>
> >> With Generic KASAN enabled, the average of one memory allocation is
> >> 3512ns on my laptop.
> >>
> >> Personally, I prefer ktime_get_boot_fast_ns() because it is more
> >> accurate and the extra time is insignificant for the time required for
> >> one memory allocation with Generic KASAN enabled.
> >>
> >> But maybe using ktime_get_boot_fast_ns() would have a more serious
> >> impact on small/embedded devices.
> >>
> >> Which do you think is the better choice?
> >
> > I don't have a strong preference.
> >
> > Re drift of sched_clock(), do you mean unsynchronized RDTSC on
> > different cores? I had the impression that RDTSC is synchronized
> > across cores on all recent CPUs/systems.
> >
>
>
> After discussions with Marco Elver, I now think that perhaps continuing
> to use local_clock() is a better option.
>
> The full discussion with Marco Elver can be found at
> https://groups.google.com/g/kasan-dev/c/zmxwYv8wZTg
>
> Because local_clock() is the clock source used by printk and is the
> default clock source for ftrace.
>
> Using local_clock() as the clock source for KASAN reports makes it
> easier to correlate the timestamps of allocations, frees, and errors
> with the timestamps of other events in the system.
>
> This is perhaps more important than being able to accurately compare
> across CPUs.
>
> What do you think?


If other similar tools (kfence, ftrace, printk) use local_clock(),
then it's reasonable to use it in kasan as well.
