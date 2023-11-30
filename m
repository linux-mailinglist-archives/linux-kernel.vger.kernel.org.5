Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7797FF022
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345554AbjK3N3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345542AbjK3N3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:29:07 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C257010DF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:29:13 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7c500dcdd7dso297559241.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701350953; x=1701955753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GaZdUcof5XjDf+X5zkRshJUxUnTsKxTLWHlD+h1i55Q=;
        b=R4xLGEEjfUD5Oe2BT5TvKUYRh+lhgnOog2jkG4zPo2+uvKkeTDCu6utTHFJ6mvnGh2
         KVm/Ye8fjN3T4sPlPsvIE2DMsiperJHVjlUaas43qk+ltr92HZqYatP5tWSpA4lUHCyo
         MbBXKgPcz/gsTx7YTrfxifHNqFg8bYg44YB1xv5Qu3agLCl10Iy4zfW5JBZm0Vvo+uxs
         0aABaq+3+azbjA27rrxXQH/Ds22wGCJUOiL5DtIHgWrLhftrXyMTkc4WvsTxuHrsYo+b
         DJqj8jJGlyABEzsVf5FWUwb9i3OZEAXChX8jOI9G4fxn5z6b2KcuHM7rJbydapI95mCA
         xmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701350953; x=1701955753;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaZdUcof5XjDf+X5zkRshJUxUnTsKxTLWHlD+h1i55Q=;
        b=DwZdOOGSWhmrtnddXg7LqwptKt5l3kyeXqIJOYtfDI6QFct5V8x4whjPkZBgImva8u
         quo0+3GvnaYGQRK6xvZBtACrBRC4GNnoEcMnXlGOWpiwBXyg+0z5IbAEKVSvIC5JePa/
         21VVVUL/JmoXejOMiGtukGQMUyGcQYaoKCcoORhyLzZ8w12dLB2A4aoFONGAoMDJxCiG
         qnpeeTfdKJKzvfli5/h2+dqRN8oDs41YNJa96CLcUfWexFYHuFSr6khpNxOFWOSyygU7
         38f/NtvCTnd8ZiMDeCQHv6WFvsUb/oJDuO98AZu7yvDc9FNspPdhpnhxLiP9rjCiBxLU
         Y7bQ==
X-Gm-Message-State: AOJu0Yz82Xa6mUgmeI2ltQQfhLTmjGOXBlliEQcEjwCDm3lodI3UiJqq
        XsWQvo0MrgMJ4P9Iqw1v9z5mQtt9ad8JZGrSpLLWag==
X-Google-Smtp-Source: AGHT+IFrg8PoC9BDlbB+lP3tYKm70vwJBufD+MJtDfNABL41x93ikSiIu/3BIGytJ0eWp06aIkXKg4NwwScaTBzt7hw=
X-Received: by 2002:a05:6102:1794:b0:464:4b26:5111 with SMTP id
 je20-20020a056102179400b004644b265111mr4474014vsb.8.1701350952674; Thu, 30
 Nov 2023 05:29:12 -0800 (PST)
MIME-Version: 1.0
References: <20231129154718.326330-1-acme@kernel.org> <20231129154718.326330-3-acme@kernel.org>
 <CANpmjNMftTuqPwmujNx5e+ajgdYtik9uL6dt62Ucotc7oz-uUw@mail.gmail.com>
 <ZWeiNj7B+5dJosE9@kernel.org> <ZWiHm/RmtmOfQwVI@kernel.org>
In-Reply-To: <ZWiHm/RmtmOfQwVI@kernel.org>
From:   Marco Elver <elver@google.com>
Date:   Thu, 30 Nov 2023 14:28:33 +0100
Message-ID: <CANpmjNOQpqKO27Pbox0j+=aKAnpGCR6vV_6rwF4AWTssXc+c3w@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf tests sigtrap: Skip if running on a kernel with
 sleepable spinlocks
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>
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

On Thu, 30 Nov 2023 at 14:01, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Wed, Nov 29, 2023 at 05:42:30PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Nov 29, 2023 at 04:57:47PM +0100, Marco Elver escreveu:
> > > > @@ -175,7 +208,16 @@ static int run_stress_test(int fd, pthread_t *threads, pthread_barrier_t *barrie
> > > >         ret = run_test_threads(threads, barrier);
> > > >         TEST_ASSERT_EQUAL("disable failed", ioctl(fd, PERF_EVENT_IOC_DISABLE, 0), 0);
>
> > > > -       TEST_ASSERT_EQUAL("unexpected sigtraps", ctx.signal_count, NUM_THREADS * ctx.iterate_on);
> > > > +       expected_sigtraps = NUM_THREADS * ctx.iterate_on;
>
> > > > +       if (ctx.signal_count < expected_sigtraps && kernel_with_sleepable_spinlocks()) {
> > > > +               pr_debug("Expected %d sigtraps, got %d, running on a kernel with sleepable spinlocks.\n",
> > > > +                        expected_sigtraps, ctx.signal_count);
> > > > +               pr_debug("See https://lore.kernel.org/all/e368f2c848d77fbc8d259f44e2055fe469c219cf.camel@gmx.de/\n");
>
> > > No changes from the RT side since? A fix exists, but apparently not
> > > good enough... Sigh.
>
> > Yeah, my impression, and first attempt at writing that patch wast that
> > no sigtraps were being sent, but then when I tried with a random, more
> > recent machine in the Red Hat labs, I got some signals, way less than
> > the expected ones, but some, maybe this is an interesting data point?
>
> > I'll try again to reproduce in the local machine, old i7 lenovo notebook
> > and at the newer machine, a Xeon(R) Silver 4216, 32 cpu and report here.
>
> So, on the i7 lenovo:
>
> [root@nine ~]# uname -a
> Linux nine 5.14.0-284.30.1.rt14.315.el9_2.x86_64 #1 SMP PREEMPT_RT Fri Aug 25 10:53:59 EDT 2023 x86_64 x86_64 x86_64 GNU/Linux
[...]
>
> I guess I'll try to get hold of the older kernel with 0 sigtraps to see
> if I get the same behaviour (consistent 0 sigtraps) on that kernel on
> the bigger machine :-\

Thanks for checking.

In any case, it looks like it's still broken. If the fix (bf9ad37dc8a
+ small diff by Mike) from [1] still works, what's blocking it from
being upstreamed?

https://lore.kernel.org/all/e368f2c848d77fbc8d259f44e2055fe469c219cf.camel@gmx.de/
