Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2657857B7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbjHWMNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbjHWMNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:13:41 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F01170B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:13:25 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1c4dda61eb0so3400533fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692792801; x=1693397601;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V5n8dcsSkaPczsJ91/cZeyLOa5xNAMTik18nOZGKjWM=;
        b=OEgf0Z3OHDaaXNtAxW3skcnZ59oOFouD7wcjrCygmYINhiNMc8YVggS8fLVuDefEaN
         MIhoYKNb/NKdbVnTLIfOYQysavScjZMoaXDeB4sWlm6NmDL8KhyY8GcsHXouqkDKLxn0
         dgyNisSQhQitQn539mS2FknBWqLQGjUm3tpUbMFupNIFnvUUuqm7ugs4xgBgMU0b/9Mn
         ddi0W5aFVqYcXV9DJKey+GuVTUIgTCiNOvTfopcy8LcVVwG2278JFuSPrZFK3dB8V9Y8
         48ErYdwk08HLUXvsJ1K61DBCvF6by21aDL218hS8PYVVUGEYMGiE5u6BJSZ7Tu72v4tX
         NLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692792801; x=1693397601;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5n8dcsSkaPczsJ91/cZeyLOa5xNAMTik18nOZGKjWM=;
        b=CcXu7iqvN3NhuMWDCVyDSzPGWd9AvsFj+UggKWe9qhEicRUq34VYn81pXiIQFblNIO
         mY2FhwlMU4sx6SIM5/s9l4V9EPevDjzDNQR1E3RvMioYb83vjZXV1V7lVdFYj1IUKQAS
         OPhPDDUC+sX9MDAFHuz9g6dvaYecHo1o/2sA/6lpM64o+jZNcUDEvfU7znPygggfpTKU
         0K2blIs+4JDoE8sys9S9r+iq5fyNAFPId5oF3h4O4iBgH/B92O9wlu4cUylkm6/W0EUe
         /DhjYyP9HJjjsnlME2uHwrT9CLd2Ry6hNpMaBv6VMS6Pbhx4ZeWv8i/O5+SmiwZ/fgTZ
         7osA==
X-Gm-Message-State: AOJu0Yx+KFZSJMLhxirnt3AUpAxXwFUV59SzF5AwrnXAJF1SUNhewsK5
        GwPQW6ahClZ0nrJTKJSc1xquMLEAN9FbccmbTK8ZEYfovV0=
X-Google-Smtp-Source: AGHT+IGQaEdMlIEr6H7kHKXBL8qte+h+BZNTPdhFpPOR9eOlH9CsTDitZGCEWNydlmq3igWfADFk3sNZNl3lf0hg63g=
X-Received: by 2002:a05:6870:9a25:b0:1b0:5b04:ebec with SMTP id
 fo37-20020a0568709a2500b001b05b04ebecmr14292816oab.59.1692792801408; Wed, 23
 Aug 2023 05:13:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5797:0:b0:4f0:1250:dd51 with HTTP; Wed, 23 Aug 2023
 05:13:20 -0700 (PDT)
In-Reply-To: <20230823094915.ggv3spzevgyoov6i@quack3>
References: <20230821202829.2163744-1-mjguzik@gmail.com> <ZOPSEJTzrow8YFix@snowbird>
 <20230821213951.bx3yyqh7omdvpyae@f> <CAGudoHHJECp2-DfSr5hudooAdV6mivvSO+4mC9kwUrWnSiob5g@mail.gmail.com>
 <20230822095154.7cr5ofogw552z3jk@quack3> <CAGudoHHe5nzRTuj4G1fphD+JJ02TE5BnHEDwFm=-W6DoEj2qVQ@mail.gmail.com>
 <20230823094915.ggv3spzevgyoov6i@quack3>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Wed, 23 Aug 2023 14:13:20 +0200
Message-ID: <CAGudoHFFt5wvYWrwNkz813KaXBmROJ7YJ67s1h3_CBgcoV2fCA@mail.gmail.com>
Subject: Re: [PATCH 0/2] execve scalability issues, part 1
To:     Jan Kara <jack@suse.cz>
Cc:     Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        shakeelb@google.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/23, Jan Kara <jack@suse.cz> wrote:
> On Tue 22-08-23 16:24:56, Mateusz Guzik wrote:
>> On 8/22/23, Jan Kara <jack@suse.cz> wrote:
>> > On Tue 22-08-23 00:29:49, Mateusz Guzik wrote:
>> >> On 8/21/23, Mateusz Guzik <mjguzik@gmail.com> wrote:
>> >> > True Fix(tm) is a longer story.
>> >> >
>> >> > Maybe let's sort out this patchset first, whichever way. :)
>> >> >
>> >>
>> >> So I found the discussion around the original patch with a perf
>> >> regression report.
>> >>
>> >> https://lore.kernel.org/linux-mm/20230608111408.s2minsenlcjow7q3@quack3/
>> >>
>> >> The reporter suggests dodging the problem by only allocating per-cpu
>> >> counters when the process is going multithreaded. Given that there is
>> >> still plenty of forever single-threaded procs out there I think that's
>> >> does sound like a great plan regardless of what happens with this
>> >> patchset.
>> >>
>> >> Almost all access is already done using dedicated routines, so this
>> >> should be an afternoon churn to sort out, unless I missed a
>> >> showstopper. (maybe there is no good place to stuff a flag/whatever
>> >> other indicator about the state of counters?)
>> >>
>> >> That said I'll look into it some time this or next week.
>> >
>> > Good, just let me know how it went, I also wanted to start looking into
>> > this to come up with some concrete patches :). What I had in mind was
>> > that
>> > we could use 'counters == NULL' as an indication that the counter is
>> > still
>> > in 'single counter mode'.
>> >
>>
>> In the current state there are only pointers to counters in mm_struct
>> and there is no storage for them in task_struct. So I don't think
>> merely null-checking the per-cpu stuff is going to cut it -- where
>> should the single-threaded counters land?
>
> I think you misunderstood. What I wanted to do it to provide a new flavor
> of percpu_counter (sharing most of code and definitions) which would have
> an option to start as simple counter (indicated by pcc->counters == NULL
> and using pcc->count for counting) and then be upgraded by a call to real
> percpu thing. Because I think such counters would be useful also on other
> occasions than as rss counters.
>

Indeed I did -- I had tunnel vision on dodging atomics for current
given remote modifications, which wont be done in your proposal.

I concede your idea solves the problem at hand, I question whether it
is the right to do though. Not my call to make.

>> Then for single-threaded case an area is allocated for NR_MM_COUNTERS
>> countes * 2 -- first set updated without any synchro by current
>> thread. Second set only to be modified by others and protected with
>> mm->arg_lock. The lock protects remote access to the union to begin
>> with.
>
> arg_lock seems a bit like a hack. How is it related to rss_stat? The scheme
> with two counters is clever but I'm not 100% convinced the complexity is
> really worth it. I'm not sure the overhead of always using an atomic
> counter would really be measurable as atomic counter ops in local CPU cache
> tend to be cheap. Did you try to measure the difference?
>

arg_lock is not as is, it would have to be renamed to something more generic.

Atomics on x86-64 are very expensive to this very day. Here is a
sample measurement of 2 atomics showing up done by someone else:
https://lore.kernel.org/oe-lkp/202308141149.d38fdf91-oliver.sang@intel.com/T/#u

tl;dr it is *really* bad.

> If the second counter proves to be worth it, we could make just that one
> atomic to avoid the need for abusing some spinlock.
>

The spinlock would be there to synchronize against the transition to
per-cpu -- any trickery is avoided and we trivially know for a fact
the remote party either sees the per-cpu state if transitioned, or
local if not. Then one easily knows no updates have been lost and the
buf for 2 sets of counters can be safely freed.

While writing down the idea previously I did not realize the per-cpu
counter ops disable interrupts around the op. That's already very slow
and the trip should be comparable to paying for an atomic (as in the
patch which introduced percpu counters here slowed things down for
single-threaded processes).

With your proposal the atomic would be there, but interrupt trip could
be avoided. This would roughly maintain the current cost of doing the
op (as in it would not get /worse/). My patch would make it lower.

All that said, I'm going to refrain from writing a patch for the time
being. If powers to be decide on your approach, I'm not going to argue
-- I don't think either is a clear winner over the other.

-- 
Mateusz Guzik <mjguzik gmail.com>
