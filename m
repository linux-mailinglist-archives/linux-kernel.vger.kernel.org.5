Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C06D75D75A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 00:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjGUWTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 18:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGUWTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:19:51 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49223A9F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:19:47 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so21355345e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1689977986; x=1690582786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HA79BQgwsJeaJ+dBBhrIgaZ5KRLkKi7x8npwgQbblx4=;
        b=dBCH6sMwMn4TDQpacWLOVfOTp2mrC+B40sU8xl6DAMIrhZBwh3ocMRNHPJzuU1n9ks
         vjrzz8Dwd3Lhq1jeBCRadGmlRT+ORMnog7W4Mr7BaUYRy45D3AI7MKe4uAxYotEr0hQi
         Au4Nqys2M7JyO07DLKdXpqGaY6vUeQPZP0Wtk4W22uUM79clFw4l/brDDPYRbeEZ7crv
         Bryk6GGKx9OcPf4EbvYhXWfLDcBxw2lrRbgmojUsjqtnSZEBd4UFoSghDGTMhVKNRyv7
         u2YxlS0HV9CXalGTcLofC5j4ehSl/rYNdooJEU+/w6KkkwrDIIaTqyNtyYLQ6RetKB9e
         bdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689977986; x=1690582786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HA79BQgwsJeaJ+dBBhrIgaZ5KRLkKi7x8npwgQbblx4=;
        b=RI4tyNYZaM1alaOE1OWoZGk27XjZ1OoN0ojg6LZsxLA7NcysV52ZwIovEYal77/Dp0
         fA+D8AFR1KgPDjVQEioe0p73SWYPOKOb9NZ2cQIu2iAMxdRYCJiNrM9C3zZY5mDMris7
         bHsMIfcQIfW+EcZCnvdpgsNz0tlPtRsxuyTiwMKIVMocC9F9A20PEIhzsJ2mgjQ95ZGw
         dvi18ZnPkUtXg4so/NdIdxxVSZmActszCzeIL/ruNk4DiCyPZQP8SXSUXAUR34umP7gP
         S8ShhOrOyhhZjX5sWXoZiyYQXVK4vhZ0C90QYAOTlyH4iQydj8Lpb3GiPJl0kSZNgn8V
         7wOg==
X-Gm-Message-State: ABy/qLa09BYrChl3BzwUOgq+bQQfcp1dDxz9FAR3HA/SVnVg8TwzPkax
        HturXELxJKz40YLnNRfPtR1vfQ==
X-Google-Smtp-Source: APBJJlF5p72aGKNasqZOBHXYJz7M25ePp1XGrrf3bFB8WVjC8iNzcb7aeTkbnyTzhzRH2KMJOuITkg==
X-Received: by 2002:a7b:cd8e:0:b0:3fc:8e:4287 with SMTP id y14-20020a7bcd8e000000b003fc008e4287mr2372705wmj.12.1689977985982;
        Fri, 21 Jul 2023 15:19:45 -0700 (PDT)
Received: from airbuntu (host86-163-217-97.range86-163.btcentralplus.com. [86.163.217.97])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c290700b003fbb06af219sm4040690wmd.32.2023.07.21.15.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 15:19:45 -0700 (PDT)
Date:   Fri, 21 Jul 2023 23:19:44 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Xuewen Yan <xuewen.yan@unisoc.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        guohua.yan@unisoc.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: next_freq need update when
 cpufreq_limits changed
Message-ID: <20230721221944.dthg3tf25j4qgc2z@airbuntu>
References: <20230719130527.8074-1-xuewen.yan@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230719130527.8074-1-xuewen.yan@unisoc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19/23 21:05, Xuewen Yan wrote:
> When cpufreq's policy is single, there is a scenario that will
> cause sg_policy's next_freq to be unable to update.
> 
> When the cpu's util is always max, the cpufreq will be max,
> and then if we change the policy's scaling_max_freq to be a
> lower freq, indeed, the sg_policy's next_freq need change to
> be the lower freq, however, because the cpu_is_busy, the next_freq
> would keep the max_freq.
> 
> For example:
> The cpu7 is single cpu:
> 
> unisoc:/sys/devices/system/cpu/cpufreq/policy7 # while true;do done&
> [1] 4737
> unisoc:/sys/devices/system/cpu/cpufreq/policy7 # taskset -p 80 4737
> pid 4737's current affinity mask: ff
> pid 4737's new affinity mask: 80
> unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_max_freq
> 2301000
> unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_cur_freq
> 2301000
> unisoc:/sys/devices/system/cpu/cpufreq/policy7 # echo 2171000 > scaling_max_freq
> unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_max_freq
> 2171000
> 
> At this time, the sg_policy's next_freq would keep 2301000.
> 
> To prevent the case happen, add the judgment of the need_freq_update flag.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Co-developed-by: Guohua Yan <guohua.yan@unisoc.com>
> Signed-off-by: Guohua Yan <guohua.yan@unisoc.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 4492608b7d7f..458d359f5991 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -350,7 +350,8 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
>  	 * Except when the rq is capped by uclamp_max.
>  	 */
>  	if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
> -	    sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
> +	    sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq &&
> +	    !sg_policy->need_freq_update) {

What about sugov_update_single_perf()? It seems to have the same problem, no?

LGTM otherwise.


Cheers

--
Qais Yousef

>  		next_f = sg_policy->next_freq;
>  
>  		/* Restore cached freq as next_freq has changed */
> -- 
> 2.25.1
> 
