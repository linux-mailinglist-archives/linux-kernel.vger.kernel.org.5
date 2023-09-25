Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B797AD7A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjIYMGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjIYMGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:06:34 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF41BE6E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:05:56 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27751ac0653so1134636a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695643556; x=1696248356; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3AQMzFTiHHxsEkB1mP8F0ofwmLCD3NmtCDXLCwWRp38=;
        b=MqQmLKyWZbO6gqn5Wu11uUykZ9CnrCDbEVjnTO3cI6GF0Zl5z2yniMrhBm9XDjc/0I
         Y99egt8ebCV7Magx+8Bu1SJ3yxWusd5cCepUOIfBpCSD0ggsgk0f8L9oMKlXBSAHhe2V
         D+UrLv5Ofp/jF1sOlT9+vXM16Zth3CT1hlwoaktN3MIg/5rpt4gA9ivNORw9qPJrm4sb
         10krBe7MUZcVgZVFJxdMe2umkCIG1cAcs66AmezelfZrCRRQvclWZgiBKAvoRWU/W7Yy
         vI7On0Z9zGweN7ys9g4oV1cEm5ohPhy1nxXAtZAyvN55DYvftKJtxVolcnGP5Sv/vszN
         7Emg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695643556; x=1696248356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3AQMzFTiHHxsEkB1mP8F0ofwmLCD3NmtCDXLCwWRp38=;
        b=o8/LwyiBrWZ3F5NgPlKbQcroa+iQ2dLyK8lZPJFZ8FSsDqdfCbtnJdMtSUOQpovgye
         pkV461RRCHzK3wHZOsnGrlYcmU224iEzNpSChcD9OEDzI9CaoAYl/LbPAjv+tujS7f3e
         1AYaAxzQlZwHSin2akyNKUGsmDu/+TA9Xvik+o7KWqWHPmXgMXW61CJfOtVMkk5FKIgC
         YO571eMXq9g2yD0rDhP/PEcK+9q8q8TubgrHFSvx/jd2Vp6C6vfwC0Cu3NS1HhFrTdF1
         axTBUbWCGvj2PKt6qNGJ84yWHox1veBnllh2gmmc15jX3NWL76oOaBX982qOo76Q8sR8
         c0MQ==
X-Gm-Message-State: AOJu0Yzb5glDx0GOtnDee2dsMtkTcIevhbGaGDsEqcDRsgKfL58AH/ge
        6ozp6pU9o8pNyVc6rhwHQFV1z9gR0N4vKTMNyg1/ig==
X-Google-Smtp-Source: AGHT+IEMG7wYE1v5WNPowSB4OI1pjxJk59BVXgECJSpoy8JeeRRykPlun/yJH3SD+MYcGrEgbFO/3NawGB+miB/mjAA=
X-Received: by 2002:a17:90a:d354:b0:273:f584:40ca with SMTP id
 i20-20020a17090ad35400b00273f58440camr4169349pjx.16.1695643555929; Mon, 25
 Sep 2023 05:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230901130312.247719-1-vincent.guittot@linaro.org> <ZQwW+XoOFqvyuQ63@arm.com>
In-Reply-To: <ZQwW+XoOFqvyuQ63@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 25 Sep 2023 14:05:43 +0200
Message-ID: <CAKfTPtC+qBEjnwketZRdF6Lgbr9aCYNW1sqSVe5-TJfUq25p8w@mail.gmail.com>
Subject: Re: [PATCH 0/4] consolidate and cleanup CPU capacity
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sept 2023 at 12:12, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> On Friday 01 Sep 2023 at 15:03:08 (+0200), Vincent Guittot wrote:
> > This is the 1st part of consolidating how the max compute capacity is
> > used in the scheduler and how we calculate the frequency for a level of
> > utilization.
> >
> > Fix some unconsistancy when computing frequency for an utilization. There
> > can be a mismatch between energy model and schedutil.
>
> There are a few more pieces of functionality that would be worth
> consolidating in this set as well, if you'd like to consider them:
>
> - arch_set_freq_scale() still uses policy->cpuinfo.max_freq. It might be
>   good to use the boot time stored max_freq here as well. Given that
>   arch_scale_cpu_capacity() would be based on that stored value, if
>   arch_scale_freq_capacity() ends up using a different value, it could
>   have interesting effects on the utilization signals in case of
>   boosting.

That's a good point, I will have a look at this part too. From a quick
look, this seems to be only used by  architecture that are using
arch_topology.c too


>
> - As Pierre mentioned in a previous comment, there is already a
>   cpufreq_get_hw_max_freq() weak function that returns
>   policy->cpuinfo.max_freq and it's only used at boot time by
>   the setup code for AMU use for frequency invariance. I'm tempted to
>   suggest to use this to initialize what is now "freq_factor" as my
>   intention when I created that function was to provide platform
>   providers with the possibility to implement their own and decide on
>   the frequency they choose as their maximum. This could have been an
>   arch_ function as well, but as you mentioned before, mobile and server
>   platforms might want to choose different maximum values even if they
>   are using the same architecture.
>
> Thanks,
> Ionela.
>
> >
> > Next step will be to make a difference between the original
> > max compute capacity of a CPU and what is currently available when
> > there is a capping applying forever (i.e. seconds or more).
> >
> > Vincent Guittot (4):
> >   sched: consolidate and cleanup access to CPU's max compute capacity
> >   topology: add a new arch_scale_freq_reference
> >   cpufreq/schedutil: use a fixed reference frequency
> >   energy_model: use a fixed reference frequency
> >
> >  arch/arm/include/asm/topology.h   |  1 +
> >  arch/arm64/include/asm/topology.h |  1 +
> >  arch/riscv/include/asm/topology.h |  1 +
> >  drivers/base/arch_topology.c      |  9 +++------
> >  include/linux/arch_topology.h     |  7 +++++++
> >  include/linux/energy_model.h      | 20 +++++++++++++++++---
> >  kernel/sched/core.c               |  2 +-
> >  kernel/sched/cpudeadline.c        |  2 +-
> >  kernel/sched/cpufreq_schedutil.c  | 29 +++++++++++++++++++++++++++--
> >  kernel/sched/deadline.c           |  4 ++--
> >  kernel/sched/fair.c               | 18 ++++++++----------
> >  kernel/sched/rt.c                 |  2 +-
> >  kernel/sched/sched.h              |  6 ------
> >  kernel/sched/topology.c           |  7 +++++--
> >  14 files changed, 75 insertions(+), 34 deletions(-)
> >
> > --
> > 2.34.1
> >
> >
