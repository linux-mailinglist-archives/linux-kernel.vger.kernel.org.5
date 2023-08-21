Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8967D7835B5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjHUW3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjHUW3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:29:52 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD88E4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:29:50 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-570c36ec14bso1223025eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692656990; x=1693261790;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bByHTAoSMwXQhgutrmKi7vY3xVY9axwow/bBYsVP5PU=;
        b=GLc0jDAVC+hAEQCGZab9r02F2j9te7aJ1K7varId7cx3zQuR+KC7jUWEtaaHvltpS4
         fq5N3Z2urcg5FpCb0jqenUa7vOQSP9kGGWq/8aUsgjAPQRKlTya02jub9hrYIfe6byW4
         BB36Y6W1NYTmUZo8c8H42sdZGrclb4yu7y1P1PCtahreIX+PxiP1xtw/NoEGeSoyGR9p
         L9fWQiDipbXy9O1XirvpMjp6D/2qTfuinCf6YLKOJAbHx9vS1oKJPWnDGp/hb92rJCtb
         iX74QoGlA0Zt9i+vwhenpUkgP7s/tQc9JMiY72sGmyfIJOngvLpZM/ovoFVRwUc6FQis
         oqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692656990; x=1693261790;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bByHTAoSMwXQhgutrmKi7vY3xVY9axwow/bBYsVP5PU=;
        b=c1NpZ4CTBn3jTI7VHSAKubU+euJjha22s+EB1XNbid6DoxhjBkmWTqhzSb78ykyKId
         i6fqrae2MpxCjyVi9XjDkkQdYte/IEuxl7HjBof/1hasj9jSsfxtdTU/P01u3bIcRWDS
         NsZQ5UcfjRqTxdaSVKG1gbjw24m0WftNv+wCtMei2VqG84zQJ9BNI4f8er3+gxkOeQt6
         xtDwsB5UCnjccwIJSDE9CrvPcPgwfcyL27kunsYZ0Nzhlc6QrbAJJnkR6avZvzXNwAZc
         LmI1Lp1g7tvE6Zkt/w0mS3/Vnp7TOLm9qQRzXPtf0/fcituwekKLUcQUDX/KFiKY/Md6
         SnkA==
X-Gm-Message-State: AOJu0YwsLtBTxiVF50IvshBoSLm9Z0/xUxOiAiifs0S+LXT/T2tQNH7+
        hdpPgiOeh6AQzObYZsNhke7/XDP5lcEfqQYpm+U=
X-Google-Smtp-Source: AGHT+IFr8rgYrKmJd9wvFbzfrOc9GGx70WJc7FI9jmUVB/CQViecPImO3BRlUxxgt5hBgJh5ngGfClmuqIt7Np+gFNk=
X-Received: by 2002:a4a:d1c3:0:b0:570:c0c3:8319 with SMTP id
 a3-20020a4ad1c3000000b00570c0c38319mr5851057oos.3.1692656989992; Mon, 21 Aug
 2023 15:29:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:6647:0:b0:4f0:1250:dd51 with HTTP; Mon, 21 Aug 2023
 15:29:49 -0700 (PDT)
In-Reply-To: <20230821213951.bx3yyqh7omdvpyae@f>
References: <20230821202829.2163744-1-mjguzik@gmail.com> <ZOPSEJTzrow8YFix@snowbird>
 <20230821213951.bx3yyqh7omdvpyae@f>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 22 Aug 2023 00:29:49 +0200
Message-ID: <CAGudoHHJECp2-DfSr5hudooAdV6mivvSO+4mC9kwUrWnSiob5g@mail.gmail.com>
Subject: Re: [PATCH 0/2] execve scalability issues, part 1
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org,
        jack@suse.cz
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

On 8/21/23, Mateusz Guzik <mjguzik@gmail.com> wrote:
> On Mon, Aug 21, 2023 at 02:07:28PM -0700, Dennis Zhou wrote:
>> On Mon, Aug 21, 2023 at 10:28:27PM +0200, Mateusz Guzik wrote:
>> > With this out of the way I'll be looking at some form of caching to
>> > eliminate these allocs as a problem.
>> >
>>
>> I'm not against caching, this is just my first thought. Caching will
>> have an impact on the backing pages of percpu. All it takes is 1
>> allocation on a page for the current allocator to pin n pages of memory.
>> A few years ago percpu depopulation was implemented so that limits the
>> amount of resident backing pages.
>>
>
> I'm painfully aware.
>
>> Maybe the right thing to do is preallocate pools of common sized
>> allocations so that way they can be recycled such that we don't have to
>> think too hard about fragmentation that can occur if we populate these
>> pools over time?
>>
>
> This is what I was going to suggest :)
>
> FreeBSD has a per-cpu allocator which pretends to be the same as the
> slab allocator, except handing out per-cpu bufs. So far it has sizes 4,
> 8, 16, 32 and 64 and you can act as if you are mallocing in that size.
>
> Scales perfectly fine of course since it caches objs per-CPU, but there
> is some waste and I have 0 idea how it compares to what Linux is doing
> on that front.
>
> I stress though that even if you were to carve out certain sizes, a
> global lock to handle ops will still kill scalability.
>
> Perhaps granularity better than global, but less than per-CPU would be a
> sweet spot for scalabability vs memory waste.
>
> That said...
>
>> Also as you've pointed out, it wasn't just the percpu allocation being
>> the bottleneck, but percpu_counter's global lock too for hotplug
>> support. I'm hazarding a guess most use cases of percpu might have
>> additional locking requirements too such as percpu_counter.
>>
>
> True Fix(tm) is a longer story.
>
> Maybe let's sort out this patchset first, whichever way. :)
>

So I found the discussion around the original patch with a perf
regression report.

https://lore.kernel.org/linux-mm/20230608111408.s2minsenlcjow7q3@quack3/

The reporter suggests dodging the problem by only allocating per-cpu
counters when the process is going multithreaded. Given that there is
still plenty of forever single-threaded procs out there I think that's
does sound like a great plan regardless of what happens with this
patchset.

Almost all access is already done using dedicated routines, so this
should be an afternoon churn to sort out, unless I missed a
showstopper. (maybe there is no good place to stuff a flag/whatever
other indicator about the state of counters?)

That said I'll look into it some time this or next week.

>> Thanks,
>> Dennis
>>
>> > Thoughts?
>> >
>> > Mateusz Guzik (2):
>> >   pcpcntr: add group allocation/free
>> >   fork: group allocation of per-cpu counters for mm struct
>> >
>> >  include/linux/percpu_counter.h | 19 ++++++++---
>> >  kernel/fork.c                  | 13 ++------
>> >  lib/percpu_counter.c           | 61 ++++++++++++++++++++++++----------
>> >  3 files changed, 60 insertions(+), 33 deletions(-)
>> >
>> > --
>> > 2.39.2
>> >
>


-- 
Mateusz Guzik <mjguzik gmail.com>
