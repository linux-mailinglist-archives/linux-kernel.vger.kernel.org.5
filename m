Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFF77A3245
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 21:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjIPTjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 15:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbjIPTiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 15:38:55 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5E7CDE
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:38:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401ec23be82so34349855e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694893128; x=1695497928; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BeZ0NIpOmzeTyZCjOgYbHI0Gt5u0onUOD1oUG1cRlok=;
        b=HRoQL5RIDFZ0He+o4INrsz2v6P2E6zZMLk1t/L+zL0GyqEJlsDpQkPzg53sU5AdDHp
         nqp5nilF6Ko5EgCG++Wrj+DMjtdo+0Hq7HBqBGF3B214J2mFWmKLNHQB+X5M1qDal8oD
         SbmCEJPrg5VyS/kDw7peSPRErcgtLL4SKdh9otgE2L/UnZOUEW1vgVNQmIrcftLm5aKX
         o6ENd3UMYq1JnMOZPqAw5FGStpaZ08Im6hqZBCWAPDz8/nKdyFRb3n6X410Q+xEDzVeT
         3MO3FuAMQn2FlfA8BOGpZc+4v9FgJAkNjHe0ymYtp20PEI7EgTXe4aVw6atnHL1rMBR4
         hPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694893128; x=1695497928;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BeZ0NIpOmzeTyZCjOgYbHI0Gt5u0onUOD1oUG1cRlok=;
        b=IdijaE8disbdUDtjVfJkvxXvHnl2sy7Wx+wGpoybY77kqKF81NUzaLpUQZ7e2Ub3KJ
         nKrbo1iwYcFwIdfBM2OKl6SBNlOqZSOD2gkPOphqFjRpXRocghwZK1bikZgWltOva7dC
         gkYteV2gCqBffyGWKjiNscSFTG4fbwD6zJvUU67/iPbMbHAFYLch2L6xaHOid//gHelw
         h4UqxeTKk9Hfkz8Em65fM43yQVZ1btN68nsz9icvBRvt3Bz67a2z0e2bg+7CPwaCPYdZ
         qLs2LbMjPj3LiPZ5adLKKP06LgW7UmE1zPUbWlT5rIcQy6pXijaIDNeUEMY1oXjmW6a5
         rf3A==
X-Gm-Message-State: AOJu0YyznFVhTILqtvbJDBmqiACOZBHP5gfWpV70VvPCc49KE2xsL38D
        V7ovkv8+CNe9miWqMtVPSbQ1LA==
X-Google-Smtp-Source: AGHT+IHJwXa3gfND3C/MWf5h9JP4AjQysFATf6P0IvfVvrmYiaaYJq8kFBqOMOKKH6gsoSO4VuJjMg==
X-Received: by 2002:a5d:46cf:0:b0:31f:918a:ca9d with SMTP id g15-20020a5d46cf000000b0031f918aca9dmr3830791wrs.13.1694893128243;
        Sat, 16 Sep 2023 12:38:48 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id l12-20020a5d674c000000b0030ae53550f5sm7845395wrw.51.2023.09.16.12.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 12:38:47 -0700 (PDT)
Date:   Sat, 16 Sep 2023 20:38:46 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Message-ID: <20230916193846.ewjie23c4vtf4edn@airbuntu>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230907130805.GE10955@noisy.programming.kicks-ass.net>
 <20230908001725.mtqbse3xwhzvo5qp@airbuntu>
 <44fc6d03-c663-53de-e4f7-e56687c5718d@arm.com>
 <20230908140757.haewcuwsumphcv7p@airbuntu>
 <356ec193-5c89-4f7e-5e43-d600dff68cf9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <356ec193-5c89-4f7e-5e43-d600dff68cf9@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/23 19:18, Dietmar Eggemann wrote:
> On 08/09/2023 16:07, Qais Yousef wrote:
> > On 09/08/23 09:40, Dietmar Eggemann wrote:
> >> On 08/09/2023 02:17, Qais Yousef wrote:
> >>> On 09/07/23 15:08, Peter Zijlstra wrote:
> >>>> On Mon, Aug 28, 2023 at 12:31:56AM +0100, Qais Yousef wrote:
> 
> [...]
> 
> >>> And what was a high end A78 is a mid core today. So if you look at today's
> >>> mobile world topology we really have a tiy+big+huge combination of cores. The
> >>> bigs are called mids, but they're very capable. Fits capacity forces migration
> >>> to the 'huge' cores too soon with that 80% margin. While the 80% might be too
> >>> small for the tiny ones as some workloads really struggle there if they hang on
> >>> for too long. It doesn't help that these systems ship with 4ms tick. Something
> >>> more to consider changing I guess.
> >>
> >> If this is the problem then you could simply make the margin (headroom)
> >> a function of cpu_capacity_orig?
> > 
> > I don't see what you mean. instead of capacity_of() but keep the 80%?
> > 
> > Again, I could be delusional and misunderstanding everything, but what I really
> > see fits_capacity() is about is misfit detection. But a task is not really
> > misfit until it actually has a util above the capacity of the CPU. Now due to
> > implementation details there can be a delay between the task crossing this
> > capacity and being able to move it. Which what I believe this headroom is
> > trying to achieve.
> > 
> > I think we can better define this by tying this headroom to the worst case
> > scenario it takes to actually move this misfit task to the right CPU. If it can
> > continue to run without being impacted with this delay and crossing the
> > capacity of the CPU it is on, then we should not trigger misfit IMO.
> 
> 
> Instead of:
> 
>   fits_capacity(unsigned long util, unsigned long capacity)
> 
>       return approximate_util_avg(util, TICK_USEC) < capacity;
> 
> just make 1280 in:
> 
>   #define fits_capacity(cap, max) ((cap) * 1280 < (max) * 1024)
> 
> dependent on cpu's capacity_orig or the capacity diff to the next higher
> capacity_orig.
> 
> Typical example today: {little-medium-big capacity_orig} = {128, 896, 1024}
> 
> 896÷128 = 7
> 
> 1024/896 = 1.14
> 
> to achieve higher margin on little and lower margin on medium.

I am not keen on this personally. I think these numbers are random to me and
why they help (or not help) is not clear to me at least.

I do believe that the only reason why we want to move before a task util
crosses the capacity of the CPU is tied down to the misfit load balance to be
able to move the task. Because until the task crosses the capacity, it is
getting its computational demand per our PELT representation. But since load
balance is not an immediate action (especially on our platforms where it is
4ms, something I hope we can change); we need to preemptively exclude the CPU
as a misfit when we know the task will get 'stuck' on this CPU and not get its
computational demand (as per our representation of course).

I think this removes all guess work and provides a very meaningful decision
making process that I think will scale transparently so we utilize our
resources the best we can.

We can probably optimize the code to avoid the call to approximate_util_avg()
if this is a problem.

Why do you think the ratio of cpu capacities gives more meaningful method to
judge misfit?


Thanks!

--
Qais Yousef
