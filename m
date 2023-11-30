Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860EB7FF96A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346469AbjK3SbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbjK3SbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:31:07 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8C41721
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:31:09 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-332fd81fc8dso811526f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1701369067; x=1701973867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zgma66cq79dfti6R/iK5aQPSOpkfXFIFxZ632L2H0eY=;
        b=uGlHxXV0mzP1wNzFufzl+pORxJE9TPGx70e5a2CnZNYArgIkpySIVRmdQoYCmosueL
         qZ7A1ql6Jc0rFRd/Abmus6hT2enfq+glGGa7UgpUnXFn9d/zYB4/1UPaX8IfdLQ5yjW9
         CW3/9m8PiMsfMbMXSqTtkCNivc8YiU43tUwgsEVNc+0MhAJ64XPOY49hXyXjaSdp2OT1
         /bKNMFQtDGwGKrK0wEFrpyRQXFW7TdEPAZ4Hd7oM73BlADfFYFPFXnMXX6zChuHwxgwN
         wZSYoNCVxJ/nP2BvRokYT3/5Ken87zgVZDA3Qbr43DL2DNCgg/zRpSBy9HMwGDPVSDjK
         sVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701369067; x=1701973867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zgma66cq79dfti6R/iK5aQPSOpkfXFIFxZ632L2H0eY=;
        b=Nl43TUqpRfxtu0nXCdCxe8UiFCG1eew6e9TxokAGTu+3pNrBAtiC7vOZhMgaf+3z+4
         o61nfaFfNIFbvszWnEvWjJUNAPKRSs+nHL4RAGTvN44ysaw/bxqnj4x5OI3sVzK+Cjck
         oVXTkoJ1hNWReVj0J/VUFNFRtTa+oPryeuCRukL6uSHtJHzJl6rCp5sJAG305TcGK6Fb
         zL9CMeycW7egY8ga9GhCWBQJM7wmbmQQpSoUL58IkG7BlgzV368YCPTEc/k1JbimwD+e
         JRU7vxafRd9a19+6IQyOSVCHp7Kg2do6Mc+S0inW0zd/ROsI/Zy9+Mmc7hJ37gAZU6Mq
         Epmg==
X-Gm-Message-State: AOJu0Yxj2Rb/4SjbG5a9GC9P3C4t6Y1B1rznTTkPNjy+KJrHwmlcg5pU
        PA5iZAoQi7LbaLo4t7tYjrd4/ColzJmG1LOtkqM=
X-Google-Smtp-Source: AGHT+IFtGGTzGrQ29LNvbdTMdbUsM07ikCDzxZLtZts5ZoHw9i8HJIgrcK8AIR6HQ8OvpMxQvuSZsg==
X-Received: by 2002:a2e:800e:0:b0:2c9:c888:1d71 with SMTP id j14-20020a2e800e000000b002c9c8881d71mr32825ljg.34.1701365443406;
        Thu, 30 Nov 2023 09:30:43 -0800 (PST)
Received: from airbuntu (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id d13-20020a05600c34cd00b0040b540ff0a5sm2688322wmq.19.2023.11.30.09.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:30:42 -0800 (PST)
Date:   Thu, 30 Nov 2023 17:30:41 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v2] sched/fair: Use all little CPUs for CPU-bound workload
Message-ID: <20231130173041.sg6bsoar73npy2sf@airbuntu>
References: <20231124153323.3202444-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231124153323.3202444-1-pierre.gondois@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/23 16:33, Pierre Gondois wrote:
> Running n CPU-bound tasks on an n CPUs platform:
> - with asymmetric CPU capacity
> - not having SD_SHARE_PKG_RESOURCES flag set at the DIE
>   sched domain level (i.e. not DynamIQ systems)
> might result in a task placement where two tasks run on a big CPU
> and none on a little CPU. This placement could be more optimal by
> using all CPUs.
> 
> Testing platform:
> Juno-r2:
> - 2 big CPUs (1-2), maximum capacity of 1024
> - 4 little CPUs (0,3-5), maximum capacity of 383
> 
> Testing workload ([1]):
> Spawn 6 CPU-bound tasks. During the first 100ms (step 1), each tasks
> is affine to a CPU, except for:
> - one little CPU which is left idle.
> - one big CPU which has 2 tasks affine.
> After the 100ms (step 2), remove the cpumask affinity.
> 
> Before patch:
> During step 2, the load balancer running from the idle CPU tags sched
> domains as:
> - little CPUs: 'group_has_spare'. Indeed, 3 CPU-bound tasks run on a
>   4 CPUs sched-domain, and the idle CPU provides enough spare
>   capacity.
> - big CPUs: 'group_overloaded'. Indeed, 3 tasks run on a 2 CPUs
>   sched-domain, so the following path is used:
>   group_is_overloaded()
>   \-if (sgs->sum_nr_running <= sgs->group_weight) return true;
> 
>   The following path which would change the migration type to
>   'migrate_task' is not taken:
>   calculate_imbalance()
>   \-if (env->idle != CPU_NOT_IDLE && env->imbalance == 0)
>   as the local group has some spare capacity, so the imbalance
>   is not 0.
> 
> The migration type requested is 'migrate_util' and the busiest
> runqueue is the big CPU's runqueue having 2 tasks (each having a
> utilization of 512). The idle little CPU cannot pull one of these
> task as its capacity is too small for the task. The following path
> is used:
> detach_tasks()
> \-case migrate_util:
>   \-if (util > env->imbalance) goto next;
> 
> After patch:
> As the number of failed balancing attempts grows (with
> 'nr_balance_failed'), progressively make it easier to migrate
> a big task to the idling little CPU. A similar mechanism is
> used for the 'migrate_load' migration type.
> 
> Improvement:
> Running the testing workload [1] with the step 2 representing
> a ~10s load for a big CPU:
> Before patch: ~19.3s
> After patch: ~18s (-6.7%)
> 
> Similar issue reported at:
> https://lore.kernel.org/lkml/20230716014125.139577-1-qyousef@layalina.io/
> 
> v1:
> https://lore.kernel.org/all/20231110125902.2152380-1-pierre.gondois@arm.com/
> 
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index df348aa55d3c..53c18fd23ae7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8907,7 +8907,7 @@ static int detach_tasks(struct lb_env *env)
>  		case migrate_util:
>  			util = task_util_est(p);
>  
> -			if (util > env->imbalance)
> +			if (shr_bound(util, env->sd->nr_balance_failed) > env->imbalance)

FWIW, this did help but not entirely when I tried it in the past

	https://lore.kernel.org/lkml/20230718161829.ws3vn3ufnod6kpxh@airbuntu/

And nit, the comment in that posted diff was useful.

No objections anyway but I suspect there's room for further improvement if
somebody still cares.


Cheers

--
Qais Yousef
