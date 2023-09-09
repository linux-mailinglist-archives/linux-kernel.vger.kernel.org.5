Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D9979966D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 07:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbjIIFPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 01:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjIIFPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 01:15:33 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A521BD3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 22:15:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-522dd6b6438so3388529a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 22:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694236527; x=1694841327; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pvt6Uv/sDq5WGIzPyS8q3KbPei3fZMH2luN+X6zhW4k=;
        b=YRHdtVGWnjdyr7moV2iJ8asO30dStglX3AOw4nWcUw1U2PNlRomTUUi7MFnFnQSSun
         UdrJYKAQu6axg/AS0pCeRmtGQxpvVAyheEc+u64wIjXNysSldyGBM7AwGeS0NAbqK5uU
         WxRbdJm4J+3M5NmWhZtp1zehNqw4FwWK8zR8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694236527; x=1694841327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvt6Uv/sDq5WGIzPyS8q3KbPei3fZMH2luN+X6zhW4k=;
        b=GGU3KXhNYoCrSs664xuxWxcO6HxHQp0gGcHquIFGg/GJTfQxbrSNf8MXJ0eZzu10ce
         kBlOMsGFUjvT4YAdIWtqxZYT2ng8J7gdFeP2wXc/EVxsETt7j33YbMn3XHMJZdUO+Vls
         HGbq+CH8VDfOvNh+1YqOEWP2rYvCQtiUs4fiVSG4iKFjsFozjg+b2/yycq7zGvCzEpWY
         BA594/G78hB1BeTnGS8BNCP9zBf414qt4mtlOIrNi54irzgKrwHODUm3PIkExTZUnQEI
         K0JrqjY+7zv5kIt5gI7yjdCzjyF43z6rjtwrqqqe+Do3GTrz/NnW8AVzw1/591twK4ob
         J7tQ==
X-Gm-Message-State: AOJu0YyJhFIImmgxoSd0cg6yuzmc/TQ3ce5pmrWtvxDYzkyLZZKFqlAh
        4iSyCFwGfk5u0eS/7p6Tm/hM22oOQcS4NMPsIAsRC2Sh
X-Google-Smtp-Source: AGHT+IE3Xi9bKKh9mCVWsYcasAMpTLJccg/C2gdY2SkwNoRBR33MawDYuRQp3Fd0RvaYwanu2C14zQ==
X-Received: by 2002:a50:ec90:0:b0:522:6e3f:b65 with SMTP id e16-20020a50ec90000000b005226e3f0b65mr3538285edr.33.1694236527102;
        Fri, 08 Sep 2023 22:15:27 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id d22-20020aa7ce16000000b005233609e39dsm1778896edv.30.2023.09.08.22.15.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 22:15:26 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9a9f139cd94so231048666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 22:15:26 -0700 (PDT)
X-Received: by 2002:a17:906:53c4:b0:9a5:cc73:a2a6 with SMTP id
 p4-20020a17090653c400b009a5cc73a2a6mr3122652ejo.14.1694236526447; Fri, 08 Sep
 2023 22:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com> <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <CAHk-=wif4WMu-k9Pi9BoVRZwH6npjS6Km9DR9aROxANZzN2iRQ@mail.gmail.com> <20230908225018.GB32012@noisy.programming.kicks-ass.net>
In-Reply-To: <20230908225018.GB32012@noisy.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Sep 2023 22:15:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiU+5XUG4mDcjjBZFbCrZO+mGY-LfCCMshRbt+NjSmWyA@mail.gmail.com>
Message-ID: <CAHk-=wiU+5XUG4mDcjjBZFbCrZO+mGY-LfCCMshRbt+NjSmWyA@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sept 2023 at 15:50, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > which actually makes me worry about the nested irq case, because this
> > would *not* be ok:
> >
> >         allow_resched();
> >            -> irq happens
> >                 -> *nested* irq happens
> >                 <- nested irq return (and preemption)
> >
> > ie the allow_resched() needs to still honor the irq count, and a
> > nested irq return obviously must not cause any preemption.
>
> I think we killed nested interrupts a fair number of years ago, but I'll
> recheck -- but not today, sleep is imminent.

I don't think it has to be an interrupt. I think the TIF_ALLOW_RESCHED
thing needs to look out for any nested exception (ie only ever trigger
if it's returning to the kernel "task" stack).

Because I could easily see us wanting to do "I'm going a big user
copy, it should do TIF_ALLOW_RESCHED, and I don't have preemption on",
and then instead of that first "irq happens", you have "page fault
happens" instead.

And inside that page fault handling you may well have critical
sections (like a spinlock) that is fine - but the fact that the
"process context" had TIF_ALLOW_RESCHED most certainly does *not* mean
that the page fault handler can reschedule.

Maybe it already does. As mentioned, I lost sight of the patch series,
even though I saw it originally (and liked it - only realizing on your
complaint that it migth be more dangerous than I thought).

Basically, the "allow resched" should be a marker for a single context
level only. Kind of like a register state bit that gets saved on the
exception stack. Not a "anything happening within this process is now
preemptible".

I'm hoping Ankur will just pipe in and say "of course I already
implemented it that way, see XYZ".

              Linus
