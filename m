Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48CD7F3433
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjKUQsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjKUQst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:48:49 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C0A92
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:48:45 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4083dbc43cfso23669485e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1700585324; x=1701190124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dl6jzCpJc5F+w+WFK8foUYFSJQiUHkYrw+vDeVrDCAo=;
        b=gaHcTXh3pJK+6m2qUIAgeAzOsA3X6F0eZlaQdFAyjXoxqrpQO8So/F5uwUUWLXHDJC
         J+7aQG13G/WcCLdxPCmuJWVESaCa3qPcnhIporslDPpBPax3+cNknQafkNW5H0X/NeNX
         kNummQht3z5Pm/XxWIOvI7zfzVJV+owBVcwWnTpnz0Nzeu9Yj+YPcHMQ2GuQlaqQSpOS
         nCVBFSaYGPQhgAo19eqnFSVYzHR6mKTEMzAfWjtcUuIl0fc3SP9T3REKgl8eU1Qt3F+d
         as4rXPOSYXY0fDb8dVBvdsVovyIhW+vO6whK5bFDwpnOgCpOfDaIrPCvFl0kGK5I85Yg
         YWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700585324; x=1701190124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl6jzCpJc5F+w+WFK8foUYFSJQiUHkYrw+vDeVrDCAo=;
        b=UtyMuKMirR1qfrgqsLaVDKPgPPZsueleKeCqdSANWtC06Kl8WpSXoKOxf0uEuXNCLD
         a5hnqb8rrwK9NBZ/222AOOxNP/shwL5oB9ipSvKbfeiiXmEkoReZvWgXxdtux+oKchDm
         usjlIe/Ysffph6pDu4m06/LeOGv5DHzJMU4a+OSg4GXVlPEOgM5SbgXiZ8q4f7r2g/N5
         FZjp+TjMUl777+UZWSYasZPNAfFCZ7DbC3iyE5FK7sd+lCa1EJ5gUkMiS0sNZfL/d0hi
         pImLTTktYwqTGX/cMJB+ueDNWfUqUG53mf48w07MfUwTh+4PSOLVcw4FEHu9MhzwfAHR
         lsGQ==
X-Gm-Message-State: AOJu0YzrMSd9H4m+sMxjUgoeQOB4Cl+YytniiXZgTsyjl33ImMItUCRq
        iVywa3T6mHrVVAxzwjN9xI9bvg==
X-Google-Smtp-Source: AGHT+IG4dX7H/wqKA+5EWhJPHEt3WhqgO8tiLLdqJWn9aVJj7sNqBLUK1KzJFtvHSv6RGb7mUmrDJQ==
X-Received: by 2002:a05:600c:a4c:b0:40a:4609:9c90 with SMTP id c12-20020a05600c0a4c00b0040a46099c90mr9626807wmq.29.1700585323529;
        Tue, 21 Nov 2023 08:48:43 -0800 (PST)
Received: from airbuntu (host109-151-228-202.range109-151.btcentralplus.com. [109.151.228.202])
        by smtp.gmail.com with ESMTPSA id c20-20020a7bc854000000b0040a43d458c9sm21640037wml.25.2023.11.21.08.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 08:48:43 -0800 (PST)
Date:   Tue, 14 Nov 2023 20:59:38 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com
Subject: Re: [PATCH v3 2/2] sched/schedutil: Rework iowait boost
Message-ID: <20231114205938.kspmq6rtidwdsu4f@airbuntu>
References: <20231103131821.1176294-1-vincent.guittot@linaro.org>
 <20231103131821.1176294-3-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231103131821.1176294-3-vincent.guittot@linaro.org>
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/23 14:18, Vincent Guittot wrote:
> Use the max value that has already been computed inside sugov_get_util()
> to cap the iowait boost and remove dependency with uclamp_rq_util_with()
> which is not used anymore.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---

Reviewed-by: Qais Yousef <qyousef@layalina.io>

I didn't get a chance to reproduce the original issue I've seen with iowait
boost to test this, but will do and confirm back.


Thanks!

--
Qais Yousef

>  kernel/sched/cpufreq_schedutil.c | 29 ++++++++-------
>  kernel/sched/sched.h             | 60 --------------------------------
>  2 files changed, 14 insertions(+), 75 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 38accd8c854b..068c895517fb 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -174,11 +174,12 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
>  	return max(min, max);
>  }
>  
> -static void sugov_get_util(struct sugov_cpu *sg_cpu)
> +static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
>  {
>  	unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
>  
>  	util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
> +	util = max(util, boost);
>  	sg_cpu->bw_min = map_util_perf(min);
>  	sg_cpu->util = sugov_effective_cpu_perf(sg_cpu->cpu, util, min, max);
>  }
> @@ -271,18 +272,16 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
>   * This mechanism is designed to boost high frequently IO waiting tasks, while
>   * being more conservative on tasks which does sporadic IO operations.
>   */
> -static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
> +static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
>  			       unsigned long max_cap)
>  {
> -	unsigned long boost;
> -
>  	/* No boost currently required */
>  	if (!sg_cpu->iowait_boost)
> -		return;
> +		return 0;
>  
>  	/* Reset boost if the CPU appears to have been idle enough */
>  	if (sugov_iowait_reset(sg_cpu, time, false))
> -		return;
> +		return 0;
>  
>  	if (!sg_cpu->iowait_boost_pending) {
>  		/*
> @@ -291,7 +290,7 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
>  		sg_cpu->iowait_boost >>= 1;
>  		if (sg_cpu->iowait_boost < IOWAIT_BOOST_MIN) {
>  			sg_cpu->iowait_boost = 0;
> -			return;
> +			return 0;
>  		}
>  	}
>  
> @@ -301,10 +300,7 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
>  	 * sg_cpu->util is already in capacity scale; convert iowait_boost
>  	 * into the same scale so we can compare.
>  	 */
> -	boost = (sg_cpu->iowait_boost * max_cap) >> SCHED_CAPACITY_SHIFT;
> -	boost = uclamp_rq_util_with(cpu_rq(sg_cpu->cpu), boost, NULL);
> -	if (sg_cpu->util < boost)
> -		sg_cpu->util = boost;
> +	return (sg_cpu->iowait_boost * max_cap) >> SCHED_CAPACITY_SHIFT;
>  }
>  
>  #ifdef CONFIG_NO_HZ_COMMON
> @@ -334,6 +330,8 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
>  					      u64 time, unsigned long max_cap,
>  					      unsigned int flags)
>  {
> +	unsigned long boost;
> +
>  	sugov_iowait_boost(sg_cpu, time, flags);
>  	sg_cpu->last_update = time;
>  
> @@ -342,8 +340,8 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
>  	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
>  		return false;
>  
> -	sugov_get_util(sg_cpu);
> -	sugov_iowait_apply(sg_cpu, time, max_cap);
> +	boost = sugov_iowait_apply(sg_cpu, time, max_cap);
> +	sugov_get_util(sg_cpu, boost);
>  
>  	return true;
>  }
> @@ -444,9 +442,10 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>  
>  	for_each_cpu(j, policy->cpus) {
>  		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
> +		unsigned long boost;
>  
> -		sugov_get_util(j_sg_cpu);
> -		sugov_iowait_apply(j_sg_cpu, time, max_cap);
> +		boost = sugov_iowait_apply(j_sg_cpu, time, max_cap);
> +		sugov_get_util(j_sg_cpu, boost);
>  
>  		util = max(j_sg_cpu->util, util);
>  	}
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 302b451a3fd8..e3cb8e004bd1 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3025,59 +3025,6 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
>  	return rq->uclamp_flags & UCLAMP_FLAG_IDLE;
>  }
>  
> -/**
> - * uclamp_rq_util_with - clamp @util with @rq and @p effective uclamp values.
> - * @rq:		The rq to clamp against. Must not be NULL.
> - * @util:	The util value to clamp.
> - * @p:		The task to clamp against. Can be NULL if you want to clamp
> - *		against @rq only.
> - *
> - * Clamps the passed @util to the max(@rq, @p) effective uclamp values.
> - *
> - * If sched_uclamp_used static key is disabled, then just return the util
> - * without any clamping since uclamp aggregation at the rq level in the fast
> - * path is disabled, rendering this operation a NOP.
> - *
> - * Use uclamp_eff_value() if you don't care about uclamp values at rq level. It
> - * will return the correct effective uclamp value of the task even if the
> - * static key is disabled.
> - */
> -static __always_inline
> -unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
> -				  struct task_struct *p)
> -{
> -	unsigned long min_util = 0;
> -	unsigned long max_util = 0;
> -
> -	if (!static_branch_likely(&sched_uclamp_used))
> -		return util;
> -
> -	if (p) {
> -		min_util = uclamp_eff_value(p, UCLAMP_MIN);
> -		max_util = uclamp_eff_value(p, UCLAMP_MAX);
> -
> -		/*
> -		 * Ignore last runnable task's max clamp, as this task will
> -		 * reset it. Similarly, no need to read the rq's min clamp.
> -		 */
> -		if (uclamp_rq_is_idle(rq))
> -			goto out;
> -	}
> -
> -	min_util = max_t(unsigned long, min_util, uclamp_rq_get(rq, UCLAMP_MIN));
> -	max_util = max_t(unsigned long, max_util, uclamp_rq_get(rq, UCLAMP_MAX));
> -out:
> -	/*
> -	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
> -	 * RUNNABLE tasks with _different_ clamps, we can end up with an
> -	 * inversion. Fix it now when the clamps are applied.
> -	 */
> -	if (unlikely(min_util >= max_util))
> -		return min_util;
> -
> -	return clamp(util, min_util, max_util);
> -}
> -
>  /* Is the rq being capped/throttled by uclamp_max? */
>  static inline bool uclamp_rq_is_capped(struct rq *rq)
>  {
> @@ -3115,13 +3062,6 @@ static inline unsigned long uclamp_eff_value(struct task_struct *p,
>  	return SCHED_CAPACITY_SCALE;
>  }
>  
> -static inline
> -unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
> -				  struct task_struct *p)
> -{
> -	return util;
> -}
> -
>  static inline bool uclamp_rq_is_capped(struct rq *rq) { return false; }
>  
>  static inline bool uclamp_is_used(void)
> -- 
> 2.34.1
> 
