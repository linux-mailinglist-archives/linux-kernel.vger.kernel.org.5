Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D1680BDC2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 23:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjLJWym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 17:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJWyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 17:54:40 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A54E3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 14:54:45 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c2308faedso41394545e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 14:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702248884; x=1702853684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HH2FjCQNNYGYoIJfmRFs+x4t/mZOfCSMx9xQ44KDDKg=;
        b=Ane0pls4UjFUBGSMJCEg7vmMVRVET04hhuZos1Ip59Ydz+W+YZcjcISCFtFCGl44gF
         dZUNKbO8aCDEZgMM775CkcJU8suchKquL9OpcaYfkUaofRhZsMitVCXKrk9appPFtbt0
         G1I0LgENCClz70K+XCcNkE2uU8/Xwug5FC6fs/nLBuwUJwJfpdr6ZowwFTa6/uT93lZI
         /ucuIVwWbDfN6zBQqFLUqQQ3BBdl4abWwEOVXojDQ1mj2D0r+6TACtyDsYEDVVNzLSMB
         fQS6SLYRm4fNPGa17+Y4kdROI60GMc7kq+spu9+vZwLPGQkxKenCmDmovEvORJbfL1fH
         KcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702248884; x=1702853684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HH2FjCQNNYGYoIJfmRFs+x4t/mZOfCSMx9xQ44KDDKg=;
        b=qEgyQME21h8Nzu3nyHdbTzqVU01aFuh5kYSq5r1qrj3LxAfuj7GhguC+LpsgpU5BAX
         ojS9UNmDr6L23lqzZDCwRyBdmPg3q7Qo2muKEIno6YBWGjTQmuOAh1sX+0GPSGSLBlNO
         rCC5XNG2a+vq8g0Be8fV3PexoJP+JYVY2/SwR/YXRwwwoX8EV9FK2suqblqfitYxM5tl
         msg3TMaWy6OqLybLX+PxaM0CykqrnGmNYHxzEj5ZNv21BdJbjSNZ4qwFCneRiRjAeR7H
         WYzkD8BZwVt9jiowK52q5YXgyRXChZSwP6ZEY34TxUzRDxwpOPnv13l1N7fdJ5ALLx1+
         fZhg==
X-Gm-Message-State: AOJu0YyxqSdtyoDosIO8HHHcHeaKAacRxmxJRUtteULFej58ALpfA8wB
        C1466hcO0DurI0xvN7KP/Qzc+A==
X-Google-Smtp-Source: AGHT+IFCES1JeshzUlrMIaS4l+VBg6o6JFpJkzLv4KnmIc5e/ecMZaVBv4EZs2T7CT3uu6hAv8CPAw==
X-Received: by 2002:a05:600c:b43:b0:40b:5e1e:cf2 with SMTP id k3-20020a05600c0b4300b0040b5e1e0cf2mr1735797wmr.45.1702248883245;
        Sun, 10 Dec 2023 14:54:43 -0800 (PST)
Received: from airbuntu (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c1d8100b0040b47c69d08sm13256227wms.18.2023.12.10.14.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 14:54:42 -0800 (PST)
Date:   Sun, 10 Dec 2023 22:22:25 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Hongyan Xia <hongyan.xia2@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH 3/4] sched/schedutil: Ignore update requests for short
 running tasks
Message-ID: <20231210222225.ukocvimws6ecgsmy@airbuntu>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-4-qyousef@layalina.io>
 <f61a3329-4223-4995-8732-030430d19ea4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f61a3329-4223-4995-8732-030430d19ea4@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hongyan

On 12/08/23 10:42, Hongyan Xia wrote:

> What is a big concern is a normal task and a uclamp_max task running on the
> same rq. If the uclamp_max task is 1024 but capped by uclamp_max at the
> lowest OPP, and the normal task has no uclamp but a duty cycle, then when

You mean util_avg is 1024 but capped to lowest OPP? uclamp_max is repeated but
couldn't decipher what you meant to write instead.

> the normal task wakes up on the rq, it'll be the highest OPP. When it
> sleeps, the ulamp_max is back and at the lowest OPP. This square-wave
> problem to me is a much bigger concern than an infrequent spike. If
> CONFIG_HZ is 1000, this square wave's frequency is 500 switching between

If the rq->util_avg is 1024, then for any task that is running, the requested
frequency should be max. If there's a task that is capped by uclamp_max, then
this task should not run at max.

So other tasks should have run at max; why you don't want them to run at max?

> highest and lowest OPP, which is definitely unacceptable.

How come so definitive? How did you reach this definitive conclusion?

> The problem I think with filtering is, under this condition, should we
> filter out the lowest OPP or the highest? Neither sounds like a good answer
> because neither is a short-running task and the correct answer might be
> somewhere in between.

We only ignore uclamp requirement with the filter. schedutil is drive by the rq
utilization signal as normal. It is only the fact should we apply
uclamp_min/max or not.

It seems you think we need to modify the rq->util_avg. And this should not be
the case. uclamp should not change how PELT accounting works; just modify how
some decisions based on it are taken.

It is true there's a corner case where util_avg could be wrong under the
documented limitation. But this is not related to max-aggregation and its
solution needs some creativity in handling pelt accounting under these
conditions.

Generally; capping that hard stirs question why userspace is doing this. We
don't want to cripple tasks, but prevent them from consuming inefficient energy
points. Otherwise they should make adequate progress. I'd expect uclamp_max to
be more meaningful for tasks that actually need to run at those higher
expensive frequencies.

So the corner case warrants fixing, but it is not a nuance in practice yet. And
it is a problem of failing to calculate the stolen idle time as we don't have
any under these corner conditions (Vincent can make a more accurate statement
than me here). It has nothing to do with how to handle performance requirements
of multiple RUNNABLE tasks.

> Sorry to ramble on this again and again, but I think filtering is addressing
> the symptom, not the cause. The cause is we have no idea under what
> condition a util_avg was achieved. The 1024 task in the previous example
> would be much better if we extend it into

I think the other way around :-) I think you're mixing the root cause of that
limitation with how uclamp hints for multiple tasks should be handled - which
is what is being fixed here.

I wrote the documentation and did the experiments to see how PELT behaves under
extreme conditions. And it says *it can break PELT*.

> [1024, achieved at uclamp_min 0, achieved at uclamp_max 300]

Why you think this is the dominant use case? And why do you think this is
caused by max-aggregation? This is a limitation of PELT accounting and has
nothing to do with max-aggregation which is how multiple uclamp hints for
RUNNABLE tasks are handled.

Have you actually seen it practice? We haven't come across this problem yet. We
just want to avoid using expensive OPPs, but capping too had is actually
a problem as it can cause starvation for those tasks.

Is it only the documentation what triggered this concern about this corner
case? I'm curious what have you seen.

> If we know 1024 was done under uclamp_max of 300, then we know we don't need
> to raise to the max OPP. So far, we carry around a lot of different new
> variables but not these two which we really need.

This problem is independent of how uclamp hint of multiple tasks should be
accounted for by the governor. This is a limitation of how PELT accounting
works. And to be honest, if you think more about it, this 300 tasks is already
a 1024 on current littles that has a capacity of 200 or less. And the capacity
of the mids at lowest OPP usually starts at a capacity around 100 or something.
Can't see it hit this problem while running on middle.  I think this 300 tasks
will already run near lowest OPP at the big even without uclamp_max being
0 - it is that small for it.

So not sure on what systems you saw this problem on, and whether at all this is
a problem in practice. Like priority/nice and other sched attributes; you can
pick a wrong combination and shoot your self in the foot.

As I put in the documentation, this limitation will only hit if the actual task
capacity reaches some magical ratio. I'd expect practically these tasks to
still see idle time and get their util_avg corrected eventually.

So worth a fix, not related to handling performance requests for multiple
tasks, and not urgently needed as nothing is falling apart because of it for
the time being at least.


Cheers

--
Qais Yousef
