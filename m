Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AF279D311
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbjILOBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjILOBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:01:40 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DC210CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:01:36 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-573ccec985dso4379200a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694527296; x=1695132096; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJSOLzlJ3uaAmgqgSlNPgliDIBP335CffCep/lv3ykg=;
        b=I/+gSz9Y6W6FH26dDpCnW2YAwBil5V5QUDyNlMQ6+JWSPC6IdFvi7Dy4Yh9jVPR7v2
         1RyVmzNCH/9Wfd5hkla8zhHW0d4LnlOBlEZ+3UKzvWXAUt1DfAcSHhL+4gRD+US4h/ui
         mdXM8b45WqnKn/SeEXyLbOsgFw8/U95DLrJWxCO4zq1umdiPiCe72wRuEmY6fkuSSIPR
         1YyjLGfsF3HKUOwwFleu/TnmcnJ91wbM1YEnL8jxEex8wx6jKUXqd8fcZpFs4ohvBJJN
         WRWH8yZRd9iW0caY9y4T7WiVLO1B3kxaVeW17OKiOkGx4qs6Egmpy13LDyvh4bVaSOy+
         dJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694527296; x=1695132096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJSOLzlJ3uaAmgqgSlNPgliDIBP335CffCep/lv3ykg=;
        b=YJMNh/6yoTcv9qONNZ299TpGFvUprGcVRKMGvwYYxs8KZrK7/ro8wp7e587rkSUKVS
         EXRRxAUW70Xqezc2s9dmpcevr39071A6N1CX8vVPlH5J0p320h13GfOYFVeu/WEz4Fyx
         zRTxqXRQNmcRmN55D8c6IEVW2L8S2ZZIuj+aDh6EvKRFXdgzfJHXEZ28sc5EPqdFQWck
         RjLqPwnzvw42+XV0lAP/g50fzXK+cX1dkEtiqMYQzZKzraFyGRexLiUh5mjDdhhqwhgB
         Ur6s52Wh6+ubdFmhVhZ8KV+xiGfmDc725V33z4fGmSS/i6gtb+i9MFUHVt+P88pr6wxk
         keUQ==
X-Gm-Message-State: AOJu0Yy0QH7ukCjqnQyCM9M+qGVnjzRa0YMpLG9TD+s82v2nUbzz7D+S
        EWOFokHn4BAWn8v0NPmw4MPZmuoDf0exeaSmc5ygkw==
X-Google-Smtp-Source: AGHT+IHlls2qoouUQ/250g/ONr3QazZ7LQ9FyYt2at/sxQIjLHPmpoltPEGjzad8DZSVOaaKTMbIqt7wfFymqXQikiI=
X-Received: by 2002:a17:90a:c28b:b0:25c:8b5e:814 with SMTP id
 f11-20020a17090ac28b00b0025c8b5e0814mr12036397pjt.44.1694527295703; Tue, 12
 Sep 2023 07:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230827233203.1315953-1-qyousef@layalina.io> <a6365f63-4669-15e5-b843-f4bfb1bd5e68@arm.com>
 <20230906211850.zyvk6qtt6fvpxaf3@airbuntu> <20230907132631.GF10955@noisy.programming.kicks-ass.net>
 <8919ed14-8d19-d964-2278-3303a5bda8ee@arm.com> <20230907142923.GJ10955@noisy.programming.kicks-ass.net>
 <cf5c628a-e047-b5e0-b2a0-f2b280015d02@arm.com> <20230907201609.GC14243@noisy.programming.kicks-ass.net>
 <f1b1b663-3a12-9e5d-932b-b3ffb5f02e14@arm.com>
In-Reply-To: <f1b1b663-3a12-9e5d-932b-b3ffb5f02e14@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 12 Sep 2023 16:01:23 +0200
Message-ID: <CAKfTPtDd-HhF-YiNTtL9i5k0PfJbF819Yxu4YquzfXgwi7voyw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Qais Yousef <qyousef@layalina.io>,
        Chris Redpath <Chris.Redpath@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Tue, 12 Sept 2023 at 13:51, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Peter,
>
> On 9/7/23 21:16, Peter Zijlstra wrote:
> > On Thu, Sep 07, 2023 at 03:42:13PM +0100, Lukasz Luba wrote:
> >
> >>> What task characteristic is tied to this? That is, this seems trivial to
> >>> modify per-task.
> >>
> >> In particular Speedometer test and the main browser task, which reaches
> >> ~900util, but sometimes vanish and waits for other background tasks
> >> to do something. In the meantime it can decay and wake-up on
> >> Mid/Little (which can cause a penalty to score up to 5-10% vs. if
> >> we pin the task to big CPUs). So, a longer util_est helps to avoid
> >> at least very bad down migration to Littles...
> >
> > Do they do a few short activations (wakeup/sleeps) while waiting? That
> > would indeed completely ruin things since the EWMA thing is activation
> > based.
> >
> > I wonder if there's anything sane we can do here...
>
> My apologies for a delay, I have tried to push the graphs for you.
>
> The experiment is on pixel7*. It's running the browser on the phone
> with the test 'Speedometer 2.0'. It's a web test (you can also run on
> your phone) available here, no need to install anything:
> https://browserbench.org/Speedometer2.0/
>
> Here is the Jupiter notebook [1], with plots of the signals:
> - top 20 tasks' (based on runtime) utilization
> - Util EST signals for the top 20 tasks, with the longer decaying ewma
>    filter (which is the 'red' plot called 'ewma')
> - the main task (comm=CrRendererMain) Util, Util EST and task residency
>    (which tires to stick to CPUs 6,7* )
> - the test score was 144.6 (while with fast decay ewma is ~134), so
>    staying at big cpus (helps the score in this case)
>
> (the plots are interactive, you can zoom in with the icon 'Box Zoom')
> (e.g. you can zoom in the task activation plot which is also linked
> with the 'Util EST' on top, for this main task)
>
> You can see the util signal of that 'CrRendererMain' task and those
> utilization drops in time, which I was referring to. When the util
> drops below some threshold, the task might 'fit' into smaller CPU,
> which could be prevented automatically byt maintaining the util est
> for longer (but not for all).

I was looking at your nice chart and I wonder if you could also add
the runnable _avg of the tasks ?

My 1st impression is that the decrease happens when your task starts
to share the CPU with some other tasks and this ends up with a
decrease of its utilization because util_avg doesn't take into account
the waiting time so typically task with an utilization of 1024, will
see its utilization decrease because of other tasks running on the
same cpu. This would explain the drop that you can see.

 I wonder if we should not take into account the runnable_avg when
applying the ewm on util_est ? so the util_est will not decrease
because of time sharing with other

>
> I do like your idea that Util EST might be per-task. I'm going to
> check this, because that might help to get rid of the overutilized state
> which is probably because small tasks are also 'bigger' for longer.
>
> If this util est have chance to fly upstream, I could send an RFC if
> you don't mind.
>
> Regards,
> Lukasz
>
> *CPUs 6,7 - big (1024 capacity), CPUs 4,5 Mid (768 capacity), CPUs 0-3
> Littles (~150 capacity)
>
> [1]
> https://nbviewer.org/github/lukaszluba-arm/lisa/blob/public_tests/p7_wa_speedometer2_small_size.ipynb
