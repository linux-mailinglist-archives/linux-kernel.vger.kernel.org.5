Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56871785D03
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjHWQKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbjHWQKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:10:39 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CA2E7B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 09:10:31 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-570f0cb0c1eso1380759eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692807030; x=1693411830;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Z12QXPm+RDkF84iA+wv+FJPe57vLFa9VFZMfDdgrZg=;
        b=Oj2bD1BYQrsDedtb975jwrwTiBtwGojHELCp43NyXpurcwTEyAl3cjHeAtkk3+H9i2
         4zc6vx83c/fwBTkk/yBUCtM1BTyehyvCe9WT531ISPzmaCAsaU6YMSOf0Fd5J5nWZNRh
         +4uNp15MLj5lrzcSAkFMvG0SIfj9+LkOt2xteHQc0nviquFtOiXY7BSTWMPhduCWowuz
         hn6G5HRhPW3QJYaJED5VbXUaMCszaJz7jlsFHpyEmCG1vBTb9Db5YmEFDg5Pvd+fRk71
         WxXq1ihjBkDF9vE8gxW/Z3iLNurl70/yv649QA71xHr/Q1R1wja9PFOJrQz4uxOMzZ3H
         Y0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692807030; x=1693411830;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Z12QXPm+RDkF84iA+wv+FJPe57vLFa9VFZMfDdgrZg=;
        b=dpwyKj6d/nyo7Hbn4AV7RJvri2GpN2c90c5VekiXKmtbqHlgLYuCcvKw93nvBgUesR
         K30Du60P6dlnAjx6t6AKa48oYrJNop8gsr8lhLRk2KlRmqItB7iH1rsNfwIVe67xQEpl
         L6dwJhuUI9cvgWeCXTP//wcFZbAtJIyKBIBVtgwkue4kYRth5Lvkz94Zh7ksn1bqxVUW
         U622eF0ZKbP6Z76+L5Sy12FmJMDpwXsuzedBM5YcxnU5sH1HI/qSFGYnetZk50u4ut9o
         GecuG7V19Oux4eNp0PV4frBTmxfPqDJqXU8MI4B/s2GmmiTGEZyKDVGqbwExFxdG8q4L
         h64w==
X-Gm-Message-State: AOJu0Yx9qSXDN/V2YDN52JGVaaJEkvcrVSGzLWrPP+aAvkf8GA3C2TXb
        XnCoG3RnB7Hyh6QlThMmn40vhqDZXOZDg6/y5vg=
X-Google-Smtp-Source: AGHT+IGRSsNS00IocQRpXaHBCdTfIY/2jeMXsBQOdIeS808Lmcjm5mO2fEjc+m0Y/BGpPdci2J1A5fcxtMMLCte23Ik=
X-Received: by 2002:a4a:2a1e:0:b0:56c:7149:7db6 with SMTP id
 k30-20020a4a2a1e000000b0056c71497db6mr11355508oof.3.1692807030389; Wed, 23
 Aug 2023 09:10:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5797:0:b0:4f0:1250:dd51 with HTTP; Wed, 23 Aug 2023
 09:10:29 -0700 (PDT)
In-Reply-To: <20230823154728.rpkw6fpwvwqbnnh3@quack3>
References: <20230821202829.2163744-1-mjguzik@gmail.com> <ZOPSEJTzrow8YFix@snowbird>
 <20230821213951.bx3yyqh7omdvpyae@f> <CAGudoHHJECp2-DfSr5hudooAdV6mivvSO+4mC9kwUrWnSiob5g@mail.gmail.com>
 <20230822095154.7cr5ofogw552z3jk@quack3> <CAGudoHHe5nzRTuj4G1fphD+JJ02TE5BnHEDwFm=-W6DoEj2qVQ@mail.gmail.com>
 <20230823094915.ggv3spzevgyoov6i@quack3> <CAGudoHFFt5wvYWrwNkz813KaXBmROJ7YJ67s1h3_CBgcoV2fCA@mail.gmail.com>
 <20230823154728.rpkw6fpwvwqbnnh3@quack3>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Wed, 23 Aug 2023 18:10:29 +0200
Message-ID: <CAGudoHFvGwcQ+8JOjwR3B=KtHiVqC1=eiNgGv33z29443VJdFg@mail.gmail.com>
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
> I didn't express myself well. Sure atomics are expensive compared to plain
> arithmetic operations. But I wanted to say - we had atomics for RSS
> counters before commit f1a7941243 ("mm: convert mm's rss stats into
> percpu_counter") and people seemed happy with it until there were many CPUs
> contending on the updates. So maybe RSS counters aren't used heavily enough
> for the difference to practically matter? Probably operation like faulting
> in (or unmapping) tmpfs file has the highest chance of showing the cost of
> rss accounting compared to the cost of the remainder of the operation...
>

These stats used to be decentralized by storing them in task_struct,
the commit complains about values deviating too much.

The value would get synced every 64 uses, from the diff:
-/* sync counter once per 64 page faults */
-#define TASK_RSS_EVENTS_THRESH (64)
-static void check_sync_rss_stat(struct task_struct *task)
-{
-       if (unlikely(task != current))
-               return;
-       if (unlikely(task->rss_stat.events++ > TASK_RSS_EVENTS_THRESH))
-               sync_mm_rss(task->mm);
-}

other than that it was a non-atomic update in struct thread.

-static void add_mm_counter_fast(struct mm_struct *mm, int member, int val)
-{
-       struct task_struct *task = current;
-
-       if (likely(task->mm == mm))
-               task->rss_stat.count[member] += val;
-       else
-               add_mm_counter(mm, member, val);
-}

So the question is how much does this matter. My personal approach is
that avoidable slowdowns (like atomics here) only facilitate further
avoidable slowdowns as people can claim there is a minuscule change in
% to baseline. But if the baseline is already slow....

Anyhow, I just found that patch failed to completely remove
SPLIT_RSS_COUNTING. I'm going to submit something about that later.

-- 
Mateusz Guzik <mjguzik gmail.com>
