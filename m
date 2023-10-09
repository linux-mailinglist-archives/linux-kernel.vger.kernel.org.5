Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B708B7BD923
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346159AbjJILBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346148AbjJILBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:01:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBB099;
        Mon,  9 Oct 2023 04:01:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-313e742a787so2574217f8f.1;
        Mon, 09 Oct 2023 04:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696849276; x=1697454076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//K5iOSx+LhnQE5qyVFs7BiRBbgN/L2K75+Fy0+HDh4=;
        b=HZ7WDkNRwjPuZD7WzE1Ua8CiF0yPRwZ6HOTS6ByHwWSVOlz6zJC7w3ehPyOyeoZrNZ
         moOjziTGlPRypN+LFav92bmKxebyx5R3BC3M3rg1N3qGwPPPRjPVx/0CQ+MhE/hCW7UY
         Bxj7bqGNJg81tF88ibZ5jjwCJORBctgqZUPaOoj+UFIh3oCsUbvo3oARYlBg1kgK/2Pm
         4eNsY1fgQqX3YnyBfGtXZ8bNGK4MbU5TvYtKlTs33laKKY+v9jtvZ1PXZSYEZ+qLASWX
         YV+N0eQ3kKuo/3ok5ionwylKmzbeqXxfqKk+5Tt5uQ9sQjrGA2qqJ1tb5XLZZUMhhEdX
         nY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696849276; x=1697454076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//K5iOSx+LhnQE5qyVFs7BiRBbgN/L2K75+Fy0+HDh4=;
        b=lECx71qzBZyr0BXMQzfhjBStGBPWOsSlTKmyvDBW6mWNANyBd47QBn45vBu3r67WRv
         HUXMKdEFj2nzMUfUQ6swxA4qaWU14H9yq9emGQmn+PbbuiooQuFTzmcu/3pnqg+9vkvR
         1M3gkROzWC4bCW5HFfwAjteRiVFhEq0ADegQotE9r5S1xX+PIIuLBri7dms0lR2dz5jn
         pkpz8froWys/mJPVWgRtj+UCyrAFOK8lHUxmNZOeXXYDBYK3rhDCI65LsvXi6BRanQY6
         8OmpY3T0OUR0w1iqLHzWRKdHKplGDAzftw5NlKKKvQgD/WcN0vxgXy92hyTtZY54V7ix
         97Rg==
X-Gm-Message-State: AOJu0Yze2bmwFdhBdUzU88KvI1CxJG/tStJ5m/THLza9ybhyRLfEJ97d
        g2VPJr4D2KmvXE1wTLBsdGs=
X-Google-Smtp-Source: AGHT+IEFkAwgr/vL1oef8RnFaRM4o2hfmBtyLBgYWVUESswjOL3cwhDGTXs4EkSMp162uqsg+l3/dQ==
X-Received: by 2002:a5d:4690:0:b0:318:720c:bb3 with SMTP id u16-20020a5d4690000000b00318720c0bb3mr10012693wrq.20.1696849275995;
        Mon, 09 Oct 2023 04:01:15 -0700 (PDT)
Received: from gmail.com (1F2EF237.nat.pool.telekom.hu. [31.46.242.55])
        by smtp.gmail.com with ESMTPSA id b6-20020adfee86000000b0031f300a4c26sm9257600wro.93.2023.10.09.04.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 04:01:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 9 Oct 2023 13:01:12 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lukasz.luba@arm.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH v2 1/6] sched: consolidate and cleanup access to CPU's
 max compute capacity
Message-ID: <ZSPdeMzCzDRCIqUw@gmail.com>
References: <20231009103621.374412-1-vincent.guittot@linaro.org>
 <20231009103621.374412-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009103621.374412-2-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> Remove struct rq cpu_capacity_orig field and use arch_scale_cpu_capacity()
> instead.
> 
> Scheduler uses 3 methods to get access to the CPU's max compute capacity:
> - arch_scale_cpu_capacity(cpu) which is the default way to get CPU's capacity.
> - cpu_capacity_orig field which is periodically updated with
>   arch_scale_cpu_capacity().
> - capacity_orig_of(cpu) which encapsulates rq->cpu_capacity_orig.
> 
> There is no real need to save the value returned by arch_scale_cpu_capacity()
> in struct rq. arch_scale_cpu_capacity() returns:
> - either a per_cpu variable.
> - or a const value for systems which have only one capacity.
> 
> Remove cpu_capacity_orig and use arch_scale_cpu_capacity() everywhere.
> 
> No functional changes.
> 
> some tests of Arm64
> small SMP device (hikey): no noticeable changes
> HMP device (RB5): hackbench shows minor improvement (1-2%)
> large smp (thx2): hackbench and tbench shows minor improvement (1%)
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> ---
>  Documentation/scheduler/sched-capacity.rst | 13 +++++++------
>  kernel/sched/core.c                        |  2 +-
>  kernel/sched/cpudeadline.c                 |  2 +-
>  kernel/sched/deadline.c                    |  4 ++--
>  kernel/sched/fair.c                        | 18 ++++++++----------
>  kernel/sched/rt.c                          |  2 +-
>  kernel/sched/sched.h                       |  6 ------
>  kernel/sched/topology.c                    |  7 +++++--
>  8 files changed, 25 insertions(+), 29 deletions(-)

I've applied patch #1 to tip:sched/core, thanks!

	Ingo
