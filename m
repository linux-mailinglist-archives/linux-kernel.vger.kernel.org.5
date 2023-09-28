Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329247B27B1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjI1VrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjI1VrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:47:09 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC33419D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:47:06 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32336a30d18so5448500f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1695937625; x=1696542425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x6mhsQevOu9wY0QSnPPxlu/BC2xWiEmZ6bW+vSsBlaE=;
        b=dsexqT4um42YjBYaBSi6Of7zY+5Ye+XTyHV3SXMB/dUanJaqN7YGgV3INuUC4VQh7F
         PUMaBwSZv4P41kZJdNL3TMGO47VvW2C747u5jZ3rvxqKGSSGZY/WDsrJkXIm+dvVY3FD
         ew1Pr+b35eY13vSw7Bw68/mBNjOAvpQqRkDUxXcnFUUadgzRNM/3enS//cnXey+4gf38
         8YAxR61S1RTeWc+2COCmWv4nhU+eRg+PJMkxN3BmVUU/TObNEzYYHrKVqBYbIq8oLu16
         r5e6fiv2rndydu4jcsKLsdTTTo8/lHi9bOIdJHrgX1+FR1HpNfkjchgBfw47j8qPSZUu
         8kSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695937625; x=1696542425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6mhsQevOu9wY0QSnPPxlu/BC2xWiEmZ6bW+vSsBlaE=;
        b=eOPL/KbM5LinRqNnLjgle9aTFxb3W8sibBiKSP3z0+zPmfDnmw0gnD5YHutcm0a5h+
         iYOxnhlfzUvM2Rguvb8fM50vs9JuBGvtpI7Ikw0T/WwdrDjOcHj1wQakl59nDA7ik0Ut
         Eycg2U2tQE+KJiHiNvme29p76EAQrhEAhqMZy/Rxn2An6WDaPT2y5kxOPQRsWD1AsrDQ
         qPdH2nTBt16uAokpGq1ZcfXI4IcDeHFGeVojXn7tQ8EU2U/1uPBKiKAWmr4yNmECu4ov
         /fiGoLb6JQCYpOqwywSWV98SKyoDUoYL4BtQbNtX24YzYa9HEbxqHg3af1Yr8afXSGN0
         TzSw==
X-Gm-Message-State: AOJu0YzWf7dbxyk0/34MNpwSi0LphTXvBv4AO+y2DVj24UxVC3Hts1+y
        0K3dzQ72fUnTLZfKF4v1tcu/7w==
X-Google-Smtp-Source: AGHT+IHg7yXhBsVXVkU1RT7IvXMKFTqAa3dc9J6Fo8BX3WQJ4puSATKv7NkVbDvqLdQ0jc+KZDOmvQ==
X-Received: by 2002:a5d:4047:0:b0:324:84cd:5e67 with SMTP id w7-20020a5d4047000000b0032484cd5e67mr2159649wrp.6.1695937625181;
        Thu, 28 Sep 2023 14:47:05 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id i11-20020a0560001acb00b0032415213a6fsm5222768wry.87.2023.09.28.14.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 14:47:04 -0700 (PDT)
Date:   Thu, 28 Sep 2023 22:47:03 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, stable@vger.kernel.org,
        Xuewen Yan <xuewen.yan94@gmail.com>
Subject: Re: [PATCH] sched/rt: Fix live lock between select_fallback_rq() and
 RT push
Message-ID: <20230928214703.h6p6sbs3mfdu4xqq@airbuntu>
References: <20230923011409.3522762-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230923011409.3522762-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Joel

On 09/23/23 01:14, Joel Fernandes (Google) wrote:
> During RCU-boost testing with the TREE03 rcutorture config, I found that
> after a few hours, the machine locks up.
> 
> On tracing, I found that there is a live lock happening between 2 CPUs.
> One CPU has an RT task running, while another CPU is being offlined
> which also has an RT task running.  During this offlining, all threads
> are migrated. The migration thread is repeatedly scheduled to migrate
> actively running tasks on the CPU being offlined. This results in a live
> lock because select_fallback_rq() keeps picking the CPU that an RT task
> is already running on only to get pushed back to the CPU being offlined.
> 
> It is anyway pointless to pick CPUs for pushing tasks to if they are
> being offlined only to get migrated away to somewhere else. This could
> also add unwanted latency to this task.
> 
> Fix these issues by not selecting CPUs in RT if they are not 'active'
> for scheduling, using the cpu_active_mask. Other parts in core.c already
> use cpu_active_mask to prevent tasks from being put on CPUs going
> offline.

I think this is the same report as this one from Xuewen

	https://lore.kernel.org/lkml/20221114120453.3233-1-xuewen.yan@unisoc.com/

You also have only 2 CPUs system, so when one CPU is offline, the other becomes
overloaded.

I think it is worth trying to fix rto_next_cpu() to consider the
cpu_active_mask too (see my reply to Xuewen then). Keep your change as well.

I think Xuewen and I considered disabling the overloaded logic when we devolve
to a UP system too as the whole logic doesn't make sense anymore then. This is
more of an optimization than correctness though. Don't feel strongly about it
now though.


Thanks!

--
Qais Yousef


> 
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/sched/cpupri.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
> index a286e726eb4b..42c40cfdf836 100644
> --- a/kernel/sched/cpupri.c
> +++ b/kernel/sched/cpupri.c
> @@ -101,6 +101,7 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
>  
>  	if (lowest_mask) {
>  		cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
> +		cpumask_and(lowest_mask, lowest_mask, cpu_active_mask);
>  
>  		/*
>  		 * We have to ensure that we have at least one bit
> -- 
> 2.42.0.515.g380fc7ccd1-goog
> 
