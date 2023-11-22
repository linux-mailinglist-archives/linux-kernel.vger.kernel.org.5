Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583C87F534A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344672AbjKVWUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbjKVWUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:20:20 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0354E1A5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:20:15 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-4acb1260852so90083e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700691614; x=1701296414; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PHkAYUggtPd4uMdHb4XHRFzN0AgwRbLCE5uILh47HBE=;
        b=0oq4Yy4VCTrO2CeVXxmfG/iEO34llA3yG1K+NkFIa6hExgKMHiBR3li3OXS1oC+bC9
         DZ/rdPiybihnNmDo8FU7UKuHUujvrxRaILBaIKhF+N7kF5i8EP4bYmN8v2DFrqUiIEXR
         EADLj10y+npoAvx+xyEc40SA1bJKkUPIX2WFxt1T/5XM+EQDM5hFkkyB5MJQ2GQCHXqw
         ZH51tZgws3Xh4P/cjlHhBwtqjr3Pw2ysutRPOWYmhcwUXhWOj3VWiGgcJ00jvXYu1yeZ
         8toE8XPe9bHDp5OtBz9izNLXAs3YEXjSlwKS05YEDZcD+hZ9OcRCHTzTqEJlPUL+4EoH
         bYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700691614; x=1701296414;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHkAYUggtPd4uMdHb4XHRFzN0AgwRbLCE5uILh47HBE=;
        b=g41a4jSKl2MkjVIYnw4+J3qu5ychTp3NXRUpsirPUPAg2a8n3znbi0f1b3rpuWuMyB
         BFuQD0ntHX8m3/MCuUSU6bBEPa9PhWjCpWGtc5b4mSmUEmw3tkerCdfS5BxItnIaBj5t
         uKT8TrbLRU+qdUllWp5xkXF9eE1pR0OYCDHz5VyzLZDnVjWzKwhoerH62xhqNyE/WFb+
         ZyZbmMFMPIdcawmdZzQZUYKL92DZrspWodFUk5rtUxOV3Ok3HxRrfecWYVCnjNhtiJIJ
         I9EGJdJWGqo7MMMCGC6xjxGYLmmrNTqHtmxD98atIHpOAroS68FsNh7I3jVDAgD78h7H
         nBig==
X-Gm-Message-State: AOJu0Yza+oTloWlWrhb/cXrsUyyGwt12Xw6GG7QegJtSLEFwA7uoDLPF
        S+L2wWXFLClBy3VPBKMUAwuUlgIqLQWT760yubTF9g==
X-Google-Smtp-Source: AGHT+IFate+YdNASiWbkRDefRDtU7E8A6dqXpNDhx+XtpJEer5cvZlKtiKAL9dSFRVOsdEKqz7fMij15vwd/bC8YBds=
X-Received: by 2002:a05:6122:4019:b0:4b0:8de:d09c with SMTP id
 ca25-20020a056122401900b004b008ded09cmr4901290vkb.7.1700691613877; Wed, 22
 Nov 2023 14:20:13 -0800 (PST)
MIME-Version: 1.0
References: <VI1P193MB0752A2F21C050D701945B62799BAA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CANpmjNPvDhyEcc0DdxrL8hVd0rZ-J4k95R5M5AwoeSotg-HCVg@mail.gmail.com> <VI1P193MB0752E3CA6B2660860BD3923D99BAA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <VI1P193MB0752E3CA6B2660860BD3923D99BAA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
From:   Marco Elver <elver@google.com>
Date:   Wed, 22 Nov 2023 23:19:35 +0100
Message-ID: <CANpmjNMejg7ekEhuuwdxpzOk5-mO+xn+qEL1qmx8ZVQG9bz_XA@mail.gmail.com>
Subject: Re: [PATCH] kfence: Replace local_clock() with ktime_get_boot_fast_ns()
To:     Juntong Deng <juntong.deng@outlook.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
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

On Wed, 22 Nov 2023 at 22:36, Juntong Deng <juntong.deng@outlook.com> wrote:
>
> On 2023/11/23 4:35, Marco Elver wrote:
> > On Wed, 22 Nov 2023 at 21:01, Juntong Deng <juntong.deng@outlook.com> wrote:
> >>
> >> The time obtained by local_clock() is the local CPU time, which may
> >> drift between CPUs and is not suitable for comparison across CPUs.
> >>
> >> It is possible for allocation and free to occur on different CPUs,
> >> and using local_clock() to record timestamps may cause confusion.
> >
> > The same problem exists with printk logging.
> >
> >> ktime_get_boot_fast_ns() is based on clock sources and can be used
> >> reliably and accurately for comparison across CPUs.
> >
> > You may be right here, however, the choice of local_clock() was
> > deliberate: it's the same timestamp source that printk uses.
> >
> > Also, on systems where there is drift, the arch selects
> > CONFIG_HAVE_UNSTABLE_SCHED_CLOCK (like on x86) and the drift is
> > generally bounded.
> >
> >> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> >> ---
> >>   mm/kfence/core.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> >> index 3872528d0963..041c03394193 100644
> >> --- a/mm/kfence/core.c
> >> +++ b/mm/kfence/core.c
> >> @@ -295,7 +295,7 @@ metadata_update_state(struct kfence_metadata *meta, enum kfence_object_state nex
> >>          track->num_stack_entries = num_stack_entries;
> >>          track->pid = task_pid_nr(current);
> >>          track->cpu = raw_smp_processor_id();
> >> -       track->ts_nsec = local_clock(); /* Same source as printk timestamps. */
> >> +       track->ts_nsec = ktime_get_boot_fast_ns();
> >
> > You have ignored the comment placed here - now it's no longer the same
> > source as printk timestamps. I think not being able to correlate
> > information from KFENCE reports with timestamps in lines from printk
> > is worse.
> >
> > For now, I have to Nack: Unless you can prove that
> > ktime_get_boot_fast_ns() can still be correlated with timestamps from
> > printk timestamps, I think this change only trades one problem for
> > another.
> >
> > Thanks,
> > -- Marco
>
> Honestly, the possibility of accurately matching a message in the printk
> log by the timestamp in the kfence report is very low, since allocation
> and free do not directly correspond to a certain event.

It's about being able to compare the timestamps. I don't want to match
an exact event, but be able to figure out which event happened
before/after an allocation or free, i.e. the logical ordering of
events.

With CONFIG_PRINTK_CALLER we can see the CPU ID in printk lines and
are therefore able to accurately compare printk lines with information
given by KFENCE alloc/free info.

> Since time drifts across CPUs, timestamps may be different even if
> allocation and free can correspond to a certain event.

This is not a problem with CONFIG_PRINTK_CALLER.

> If we really need to find the relevant printk logs by the timestamps in
> the kfence report, all we can do is to look for messages that are within
> a certain time range.
>
> If we are looking for messages in a certain time range, there is not
> much difference between local_clock() and ktime_get_boot_fast_ns().
>
> Also, this patch is in preparation for my next patch.
>
> My next patch is to show the PID, CPU number, and timestamp when the
> error occurred, in this case time drift from different CPUs can
> cause confusion.

It's not quite clear how there's a dependency between this patch and a
later patch, but generally it's good practice to send related patches
as a patch series. That way it's easier to see what the overall
changes are and provide feedback as a whole - as is, it's difficult to
provide feedback.

However, from what you say this information is already given.
dump_stack_print_info() shows this - e.g this bit here is printed by
where the error occurred:

| CPU: 0 PID: 484 Comm: kunit_try_catch Not tainted 5.13.0-rc3+ #7
| Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2
04/01/2014

And if the printk log has timestamps, then these lines are prefixed
with the timestamp where the error occurred.

> For example, use-after-free caused by a subtle race condition, in which
> the time between the free and the error occur will be very close.
>
> Time drift from different CPUs may cause it to appear in the report that
> the error timestamp precedes the free timestamp.

That doesn't matter. I recommend that you go through a hypothetical
debugging scenario:
1. We are not interested in the absolute timings of events, but the
logical ordering between them.

2. The logical ordering of events is inherent from how KFENCE
operates: an error _always_ follows an allocation and/or free. From a
debugging point of view, the timestamps do not have any value here.

3. The timestamps _do_ add value when trying to figure out the logical
ordering between allocation, free, or the erroneous access _with
other_ events in the system. A stream of other events is always shown
in the kernel log (printk). Other streams of events can be obtained
via e.g. ftrace (which also uses local_clock(), see
kernel/trace/trace_clock.c).

So, the timestamp that KFENCE should show is the one that most likely
allows us to deduce the logical ordering with other events in the
system.
