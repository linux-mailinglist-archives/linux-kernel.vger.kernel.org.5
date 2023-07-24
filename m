Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC2875FB3A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjGXPxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjGXPxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:53:33 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E36B8E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:53:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so34565475e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1690214010; x=1690818810;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qvVqE0O3Yk2XtzPHMOoIFSa9njEhSRCYnLtdHAIhE6U=;
        b=lpLmG6bu/RqaGoZqs6oX5PZsdNPUaxfYR1f0K67vW7MKIjnNVYEO383t5uPjCnPVp8
         GWQHPKYdFmMEvbo7osTvSi7VTzIxDdhe2Ysfw4FKNL+ihDd/HWBR3pignMlhVKZAuKA6
         ytirBxDYpzPOWmK+S5Be9lJwA61kmbYd6sZWwRbX+19KCikZt631hk4AZnBOHTorLriI
         pJ+ByKpJZ0vzjYsDZGW4YOAMb/1jmjmMQYIRiYC3Ax2o9n4QKNxiVgNj3G8hLWebGSrV
         YChoQ/f9eofIszqFydZk3/cDFuL89b3VmKHLaYPFQCmaTev+3qmH3f+LQ5EwIZhW6bZ2
         F0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690214010; x=1690818810;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvVqE0O3Yk2XtzPHMOoIFSa9njEhSRCYnLtdHAIhE6U=;
        b=KmxgWDeZRHVMtWeeClYLAchlPGB83QsNkH7NX/kkUqxcj8S+MBqBIJ+9CSGFhxN3Oy
         9pnL6QVbppOk4/OGor4w6ikj2PpR/6uI0KSSFBgnv3ckTxTgglZtD9PyLIgiQ57hXzcn
         xbx0HDEGckuzBv7kCtKo9nUqHGkov8P9Mw6Q89MWEho793Z0+sYpz6zum4UgbED7OMxh
         +RbjDL90FRsvTSEuSobdu5gkMBLOjaNFw2kFM/KJD1f8onsieRU6hPhRrpuIhC3Ybu2x
         f7cG6XwYzbSuGr26tL6UfQsPG45FIKDMO7t8Ac5m1dxqwNVVF2cLaVs4ScoWnBwi0Al9
         AQdQ==
X-Gm-Message-State: ABy/qLYoEH6DCi4LF5U/K5XIFUNvaeo/RAIYja2ydd+KBZDoDwcWuENZ
        Y8EoDioIn49oIVXR+A0HxL3Rsw==
X-Google-Smtp-Source: APBJJlGfoMrt7qECIp+RgNleYhlciipGcPewl2nbb95GXJujHw97/3gUt3Na5RMfYTx/hh9e3jKiWw==
X-Received: by 2002:a5d:4564:0:b0:314:1096:6437 with SMTP id a4-20020a5d4564000000b0031410966437mr8279435wrc.19.1690214009930;
        Mon, 24 Jul 2023 08:53:29 -0700 (PDT)
Received: from airbuntu (host86-163-217-97.range86-163.btcentralplus.com. [86.163.217.97])
        by smtp.gmail.com with ESMTPSA id k5-20020a5d6285000000b0031455482d1fsm13486858wru.47.2023.07.24.08.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 08:53:29 -0700 (PDT)
Date:   Mon, 24 Jul 2023 16:53:28 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, guohua.yan@unisoc.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: next_freq need update when
 cpufreq_limits changed
Message-ID: <20230724155328.7odez6dcoafksr3i@airbuntu>
References: <20230719130527.8074-1-xuewen.yan@unisoc.com>
 <20230721221944.dthg3tf25j4qgc2z@airbuntu>
 <CAB8ipk8b8ZfwXN7KK-zFVPQ-8i37h64v-wz2ErB3AANaZ9w7aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk8b8ZfwXN7KK-zFVPQ-8i37h64v-wz2ErB3AANaZ9w7aA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/23 11:36, Xuewen Yan wrote:
> On Sat, Jul 22, 2023 at 7:02 AM Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 07/19/23 21:05, Xuewen Yan wrote:
> > > When cpufreq's policy is single, there is a scenario that will
> > > cause sg_policy's next_freq to be unable to update.
> > >
> > > When the cpu's util is always max, the cpufreq will be max,
> > > and then if we change the policy's scaling_max_freq to be a
> > > lower freq, indeed, the sg_policy's next_freq need change to
> > > be the lower freq, however, because the cpu_is_busy, the next_freq
> > > would keep the max_freq.
> > >
> > > For example:
> > > The cpu7 is single cpu:
> > >
> > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # while true;do done&
> > > [1] 4737
> > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # taskset -p 80 4737
> > > pid 4737's current affinity mask: ff
> > > pid 4737's new affinity mask: 80
> > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_max_freq
> > > 2301000
> > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_cur_freq
> > > 2301000
> > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # echo 2171000 > scaling_max_freq
> > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_max_freq
> > > 2171000
> > >
> > > At this time, the sg_policy's next_freq would keep 2301000.
> > >
> > > To prevent the case happen, add the judgment of the need_freq_update flag.
> > >
> > > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > > Co-developed-by: Guohua Yan <guohua.yan@unisoc.com>
> > > Signed-off-by: Guohua Yan <guohua.yan@unisoc.com>
> > > ---
> > >  kernel/sched/cpufreq_schedutil.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > index 4492608b7d7f..458d359f5991 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -350,7 +350,8 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
> > >        * Except when the rq is capped by uclamp_max.
> > >        */
> > >       if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
> > > -         sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
> > > +         sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq &&
> > > +         !sg_policy->need_freq_update) {
> >
> > What about sugov_update_single_perf()? It seems to have the same problem, no?
> 
> There is no problem in sugov_update_single_perf, because the next_freq
> is updated by drivers, maybe the next_freq is not used when using
> sugov_update_single_perf..

Ah I see; we just use prev_util but the request will go through and the driver
should observe the new limit regardless of what util value we pass to it. Got
ya.

> 
> But  for the last_freq_update_time, I think there are some problems
> when using sugov_update_single_perf:
> Now, there is no judgment condition for the update of the
> last_freq_update_time. That means the last_freq_update_time is always
> updated in sugov_update_single_perf.
> And in sugov_should_update_freq: it would judge the
> freq_update_delay_ns. As a result, If we use the
> sugov_update_single_perf, the cpu frequency would only be periodically
> updated according to freq_update_delay_ns.
> Maybe we should judge the cpufreq_driver_adjust_perf's return value,
> if the freq is not updated, the last_freq_update_time also does not
> have to update.
> 
> Just like:
> ---
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 458d359f5991..10f18b054f01 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -381,6 +381,7 @@ static void sugov_update_single_perf(struct
> update_util_data *hook, u64 time,
>         struct sugov_cpu *sg_cpu = container_of(hook, struct
> sugov_cpu, update_util);
>         unsigned long prev_util = sg_cpu->util;
>         unsigned long max_cap;
> +       bool freq_updated;
> 
>         /*
>          * Fall back to the "frequency" path if frequency invariance is not
> @@ -407,10 +408,11 @@ static void sugov_update_single_perf(struct
> update_util_data *hook, u64 time,
>             sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
>                 sg_cpu->util = prev_util;
> 
> -       cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
> +       freq_updated = cpufreq_driver_adjust_perf(sg_cpu->cpu,
> map_util_perf(sg_cpu->bw_dl),
>                                    map_util_perf(sg_cpu->util), max_cap);
> 
> -       sg_cpu->sg_policy->last_freq_update_time = time;
> +       if (freq_updated)
> +               sg_cpu->sg_policy->last_freq_update_time = time;
>  }

Sound reasonable in principle, but it could lead to overhead; for example when
the system is busy and maxed out, the last_freq_update_time will never be
updated and will end up continuously calling to the driver to change frequency
without any rate limit AFAICS. Which might not be an acceptable overhead,
I don't know. Logically this is wasted cycles preventing the tasks from doing
useful work. I think we need to look at such corner cases and treat them
appropriately to not call the driver if we go with this approach.


Cheers

--
Qais Yousef

> 
> 
> BR
> Thanks!
> 
> ---
> xuewen
> >
> > LGTM otherwise.
> >
> >
> > Cheers
> >
> > --
> > Qais Yousef
> >
> > >               next_f = sg_policy->next_freq;
> > >
> > >               /* Restore cached freq as next_freq has changed */
> > > --
> > > 2.25.1
> > >
