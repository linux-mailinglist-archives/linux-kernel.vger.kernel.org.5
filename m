Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18907A5CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjISInU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjISInT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:43:19 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E88E6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:43:13 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50308217223so4154909e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695112992; x=1695717792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3UHR2InkgMMl7Hda2d0jV09VYBGVKmUXlu3if1+WOa8=;
        b=WJQgneiaRnsONFZMoNgB3RyRS2tj0k0LVQUbHTld8PDzQzB8Q/5uV5jJszxZs9WNcs
         2kji5U1s7B8Bs2wqtlRSAmHIsp0D5/kjfYevWx3qGRyCGitbDxpT+lELvvQOdTH4EKnh
         ZyvroMI2c/PIbkvqEelVLe07CgRgRQ82mQY0Cw7KR8J4k/Gpt/mlH5H/KiERtRBg4BB1
         CxU/IAy+UQ8qwVNW6u/Ludov9V+iM8cM3juDeFpyIawdgUNmgTDlD1K/OWuJm+S3nxET
         aqglAzZJmBg70YZvS5MbslzqP7zHkzUYY5GmQ0wE1bBRrKv001Ep5RkTuoBD7oh/ii53
         AQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695112992; x=1695717792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UHR2InkgMMl7Hda2d0jV09VYBGVKmUXlu3if1+WOa8=;
        b=fkfbUisvg+IeWlYVkKA12BIOkELNM2BctJHBMhR9bgqu5CEOjh25hptu24qPztQURZ
         VbyFXpc0v09apMYRHzU13sS7SPBZp7gNXkVXCT3fQRVsiwwcWF/NkogpIHgNGgqtOtfY
         4DPT2ZVFgj9v49D1lwewwc/rTkjn1AxMhzJQ1H2MpbLASuYxYnPKc6DCerdCfJOmKPwY
         d/F7X+OxFaSa9GexNOIIcMvp+M73BZaBPC8Xkvo8gGiiuSvmbASX6P0TNcvlbLoF+y76
         mhZUmEfKbKDjasNCUrm3iXEgbDu1QeKqIeK7QgREzlXcS34esl+j8IfymasOzQk8Ti35
         BAgg==
X-Gm-Message-State: AOJu0YxNyGT+m6eBEaG8mRLFmWXuUhEurs9xLymlWpm7jx29I+bswSmT
        3nTlp4kTOzC/8543KTvVhHg=
X-Google-Smtp-Source: AGHT+IHDIYI0ozuHYLl6CdJx+c7nxfQSHLLeQ5+F9gl+D3iOdIMHKn3+g5eZ0l1UKZ1Cdx4PMoIHmQ==
X-Received: by 2002:a05:6512:110d:b0:503:17d6:7dac with SMTP id l13-20020a056512110d00b0050317d67dacmr5014224lfg.42.1695112991707;
        Tue, 19 Sep 2023 01:43:11 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id l12-20020a1ced0c000000b003fed4fa0c19sm17344003wmh.5.2023.09.19.01.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 01:43:11 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 19 Sep 2023 10:43:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <ZQlfHAXFFPZBPFgD@gmail.com>
References: <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <ZQlV5l4pbKunQJug@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQlV5l4pbKunQJug@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> > Yeah, the fact that we do presumably have PREEMPT_COUNT enabled in most 
> > distros does speak for just admitting that the PREEMPT_NONE / VOLUNTARY 
> > approach isn't actually used, and is only causing pain.
> 
> The macro-behavior of NONE/VOLUNTARY is still used & relied upon in 
> server distros - and that's the behavior that enterprise distros truly 
> cared about.
> 
> Micro-overhead of NONE/VOLUNTARY vs. FULL is nonzero but is in the 
> 'noise' category for all major distros I'd say.
> 
> And that's what Thomas's proposal achieves: keep the nicely 
> execution-batched NONE/VOLUNTARY scheduling behavior for SCHED_OTHER 
> tasks, while having the latency advantages of fully-preemptible kernel 
> code for RT and critical tasks.
> 
> So I'm fully on board with this. It would reduce the number of preemption 
> variants to just two: regular kernel and PREEMPT_RT. Yummie!

As an additional side note: with various changes such as EEVDF the 
scheduler is a lot less preemption-happy these days, without wrecking 
latencies & timeslice distribution.

So in principle we might not even need the NEED_RESCHED_LAZY extra bit, 
which -rt uses as a kind of additional layer to make sure they don't change 
scheduling policy.

Ie. a modern scheduler might have mooted much of this change:

   4542057e18ca ("mm: avoid 'might_sleep()' in get_mmap_lock_carefully()")

... because now we'll only reschedule on timeslice exhaustion, or if a task 
comes in with a big deadline deficit.

And even the deadline-deficit wakeup preemption can be turned off further 
with:

    $ echo NO_WAKEUP_PREEMPTION > /debug/sched/features

And we are considering making that the default behavior for same-prio tasks 
- basically turn same-prio SCHED_OTHER tasks into SCHED_BATCH - which 
should be quite similar to what NEED_RESCHED_LAZY achieves on -rt.

Thanks,

	Ingo
