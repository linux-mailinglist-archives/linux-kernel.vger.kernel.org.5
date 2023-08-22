Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE8C7843FB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbjHVOZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjHVOY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:24:59 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20637CD1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:24:58 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-56e99f97f0fso2556876eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692714297; x=1693319097;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OFGMF6bcGMZZC92fwyfQGf3wf3ZewzE1L+corQ9L5+8=;
        b=KmUR/h58wS4CPwF7dTTAoEmoVh4ntgAg+5zevPT+H6hksStT4T2nZiAX8xTSflK3g9
         aAP7544VCUb7ywvL7MvKqMZJ/0wlCaqDw8npWG1ZcLMObqAjrMyFowrSa295LNopvaI3
         b/0Ybup1LtGa24cif9uVt1AmaL04v4BmKxuz6iI4ZaYPVFa82r1z9XMdGKQ2Uj/cxtwb
         soiM6TE2vOfPeHwoVvz3bMKy92irygehXg8/4b5hn8Rv8y1n1RzlUpcq6QxCKyLnBnTs
         zd2+fq/ac/0ksRhsi4YWsPqSYEbKVZS+c6hcZQYfbRoNc/xwRlw2/SQsa8nCKyenFOnz
         rg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692714297; x=1693319097;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFGMF6bcGMZZC92fwyfQGf3wf3ZewzE1L+corQ9L5+8=;
        b=iDM9lt/b8aV8IDcus7KKMnkOjf6kGlMbOBfVij62fjgmubx5NjGLEk2QaS7TWYRYwF
         78Et6b7uxlYb78BB4qqlZJ3cLq7cxdipnjZEbD7F/59dg3yrr69Y3Kz15LrDJDmnro3f
         3TfZm/GmX3J9bQE65/ZUvSNqTHGMhsFqh9i+f+/UKSopvw4P4jhO6a6Hh44njw+A8WJF
         yT+1IETOf2bMT76RFIqu5sJB++ylfiu8fz5uZZCVBKa2eMDrmd4AQ4zoSLD4VOCA+C8w
         Vap2GSge9lWra8x6q2rmFz7Wdahv5kH9gbX6VC7dtvvcLRZ/wEnAXJ+5dylpFCcoFGxm
         rFQg==
X-Gm-Message-State: AOJu0YwGnz9RwmsYtf6k65dGPQQJ3luc8MhK0wXMi0WrJOajPXv+fVgG
        l3Z/ZwR0UpsHnZb2LzLCpHIJyr7hEl9yrJFB/iU=
X-Google-Smtp-Source: AGHT+IFkxxDZfD4EH7dcr8h0nrHXTNxvBsjY/gDCbkvc9Bo2D3WpqIrtMXQJvz04yKHBxfqwav8CsP8f9t3QB73Y3A4=
X-Received: by 2002:a4a:dfb8:0:b0:56e:68a8:7f5d with SMTP id
 k24-20020a4adfb8000000b0056e68a87f5dmr10933306ook.3.1692714297342; Tue, 22
 Aug 2023 07:24:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:6647:0:b0:4f0:1250:dd51 with HTTP; Tue, 22 Aug 2023
 07:24:56 -0700 (PDT)
In-Reply-To: <20230822095154.7cr5ofogw552z3jk@quack3>
References: <20230821202829.2163744-1-mjguzik@gmail.com> <ZOPSEJTzrow8YFix@snowbird>
 <20230821213951.bx3yyqh7omdvpyae@f> <CAGudoHHJECp2-DfSr5hudooAdV6mivvSO+4mC9kwUrWnSiob5g@mail.gmail.com>
 <20230822095154.7cr5ofogw552z3jk@quack3>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 22 Aug 2023 16:24:56 +0200
Message-ID: <CAGudoHHe5nzRTuj4G1fphD+JJ02TE5BnHEDwFm=-W6DoEj2qVQ@mail.gmail.com>
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

On 8/22/23, Jan Kara <jack@suse.cz> wrote:
> On Tue 22-08-23 00:29:49, Mateusz Guzik wrote:
>> On 8/21/23, Mateusz Guzik <mjguzik@gmail.com> wrote:
>> > True Fix(tm) is a longer story.
>> >
>> > Maybe let's sort out this patchset first, whichever way. :)
>> >
>>
>> So I found the discussion around the original patch with a perf
>> regression report.
>>
>> https://lore.kernel.org/linux-mm/20230608111408.s2minsenlcjow7q3@quack3/
>>
>> The reporter suggests dodging the problem by only allocating per-cpu
>> counters when the process is going multithreaded. Given that there is
>> still plenty of forever single-threaded procs out there I think that's
>> does sound like a great plan regardless of what happens with this
>> patchset.
>>
>> Almost all access is already done using dedicated routines, so this
>> should be an afternoon churn to sort out, unless I missed a
>> showstopper. (maybe there is no good place to stuff a flag/whatever
>> other indicator about the state of counters?)
>>
>> That said I'll look into it some time this or next week.
>
> Good, just let me know how it went, I also wanted to start looking into
> this to come up with some concrete patches :). What I had in mind was that
> we could use 'counters == NULL' as an indication that the counter is still
> in 'single counter mode'.
>

In the current state there are only pointers to counters in mm_struct
and there is no storage for them in task_struct. So I don't think
merely null-checking the per-cpu stuff is going to cut it -- where
should the single-threaded counters land?

Bonus problem, non-current can modify these counters and this needs to
be safe against current playing with them at the same time. (and it
would be a shame to require current to use atomic on them)

That said, my initial proposal adds a union:
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5e74ce4a28cd..ea70f0c08286 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -737,7 +737,11 @@ struct mm_struct {

                unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for
/proc/PID/auxv */

-               struct percpu_counter rss_stat[NR_MM_COUNTERS];
+               union {
+                       struct percpu_counter rss_stat[NR_MM_COUNTERS];
+                       u64 *rss_stat_single;
+               };
+               bool    magic_flag_stuffed_elsewhere;

                struct linux_binfmt *binfmt;


Then for single-threaded case an area is allocated for NR_MM_COUNTERS
countes * 2 -- first set updated without any synchro by current
thread. Second set only to be modified by others and protected with
mm->arg_lock. The lock protects remote access to the union to begin
with.

Transition to per-CPU operation sets the magic flag (there is plenty
of spare space in mm_struct, I'll find a good home for it without
growing the struct). It would be a one-way street -- a process which
gets a bunch of threads and goes back to one stays with per-CPU.

Then you get the true value of something by adding both counters.

arg_lock is sparingly used, so remote ops are not expected to contend
with anything. In fact their cost is going to go down since percpu
summation takes a spinlock which also disables interrupts.

Local ops should be about the same in cost as they are right now.

I might have missed some detail in the above description, but I think
the approach is decent.

-- 
Mateusz Guzik <mjguzik gmail.com>
