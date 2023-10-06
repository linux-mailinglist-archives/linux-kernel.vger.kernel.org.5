Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955797BB1EA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 09:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjJFHHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 03:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjJFHHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 03:07:12 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A03E4
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 00:07:11 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-692eed30152so1545293b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 00:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696576030; x=1697180830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0D1B3SZ/QYDtg8qv7mkYgD/tl+1/r/j69EpuD+M+9DM=;
        b=dZHyxrEGWQi5olaXYqYq8ubAfoO545rYO5wM8069KikWefsWOcj0C7T8wkCKQeEedV
         BOzAxAnUp4JBbn6lD82Uq3FOWs3c/cS6q0KpLR2Z8kPyquZmTOja4pzBQssNdc0dQoTF
         ruKMV83kL530fwM3/mze0lONitDo1XTh0zj9298U2xiCVWpGprmxCz7ESaWIdwDkq13U
         LBTQ0ZNlKc2eH0MkG/ZDieEhlyTIlfJxGGSN0RR2dTECLQ80T2T3q9w1Igq8R2ty5wyE
         4BHA0IdAYv2hGgK9LABNdYGQaiAWIhufg2Ulw11w22xgY1LOxEZDqJIY3gfmEs0wWH6q
         4eoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696576030; x=1697180830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0D1B3SZ/QYDtg8qv7mkYgD/tl+1/r/j69EpuD+M+9DM=;
        b=s6n7UFndwuiwUQNKIvsGjHk0txQkjOGa/lXFGmXyH98TmcTmv5aC+qGEA/hkP1k/G9
         ukD07p2Xphn0kzli/SYoOpAgWtxlZ59+vAtujHjw+U6ZhZFYm+BGm6GJDdbXTQQHH+Ra
         nQ3q0EyQJAKxbRI8F6kj10W2TOuzcYJnn2IABvZlTWrya7fzKWG8F/NSX1Ky0Y2sBIh/
         M9dVv0Rk0rcFRadpIwSIfSbB44fMp63FzEmYsOSj3+2EJcLqFm8+tNoPN++gOzHaZTRc
         kHK4DlNqnxIB89DQGmY3lFpgipOe17m7/4mLfR3aRiyGGId84OyKOcvwU6ceg46sCdSY
         Wr1Q==
X-Gm-Message-State: AOJu0YxWa7F5CnkJguC8AjOJ51n2UruFnyh/Df+qwhP7dSyCS6P4qN52
        /JgKC3vM/E674E06zckX31U0bw==
X-Google-Smtp-Source: AGHT+IHBvZy2r9Mba8Il+qMyIUdEqm47MGXHHJJULj98afmbMBXHLDlqaqSYL2XXgKk5gNqYeCMPIw==
X-Received: by 2002:a05:6a21:1f12:b0:149:f82a:2640 with SMTP id ry18-20020a056a211f1200b00149f82a2640mr6394778pzb.30.1696576030160;
        Fri, 06 Oct 2023 00:07:10 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id m29-20020a638c1d000000b0057406c4306fsm2597513pgd.12.2023.10.06.00.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 00:07:09 -0700 (PDT)
Date:   Fri, 6 Oct 2023 12:37:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: Rebuild sched-domains when removing cpufreq
 driver
Message-ID: <20231006070707.ia4qa25citvvbn45@vireshk-i7>
References: <20231005134120.1217829-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005134120.1217829-1-pierre.gondois@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-10-23, 15:41, Pierre Gondois wrote:
> The Energy Aware Scheduler (EAS) relies on the schedutil governor.
> When moving to/from the schedutil governor, sched domains must be
> rebuilt to allow re-evaluating the enablement conditions of EAS.
> This is done through sched_cpufreq_governor_change().
> 
> Having a cpufreq governor assumes a cpufreq driver is running.
> Inserting/removing a cpufreq driver should trigger a re-evaluation
> of EAS enablement conditions, avoiding to see EAS enabled when
> removing a running cpufreq driver.
> 
> Rebuild the sched domains in schedutil's sugov_init()/sugov_exit(),
> allowing to check EAS's enablement condition whenever schedutil
> governor is initialized/exited from.
> Move relevant code up in schedutil.c to avoid a split and conditional
> function declaration.
> Rename sched_cpufreq_governor_change() to sugov_eas_rebuild_sd().
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c        |  3 +-
>  include/linux/cpufreq.h          |  8 -----
>  kernel/sched/cpufreq_schedutil.c | 55 +++++++++++++++++---------------
>  3 files changed, 30 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 60ed89000e82..4bc15634d49c 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1544,7 +1544,7 @@ static int cpufreq_online(unsigned int cpu)
>  
>  		/*
>  		 * Register with the energy model before
> -		 * sched_cpufreq_governor_change() is called, which will result
> +		 * sugov_eas_rebuild_sd() is called, which will result
>  		 * in rebuilding of the sched domains, which should only be done
>  		 * once the energy model is properly initialized for the policy
>  		 * first.
> @@ -2652,7 +2652,6 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  		ret = cpufreq_start_governor(policy);
>  		if (!ret) {
>  			pr_debug("governor change\n");
> -			sched_cpufreq_governor_change(policy, old_gov);
>  			return 0;
>  		}
>  		cpufreq_exit_governor(policy);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 71d186d6933a..1c5ca92a0555 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1193,14 +1193,6 @@ static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
>  }
>  #endif
>  
> -#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> -void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
> -			struct cpufreq_governor *old_gov);
> -#else
> -static inline void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
> -			struct cpufreq_governor *old_gov) { }
> -#endif
> -
>  extern unsigned int arch_freq_get_on_cpu(int cpu);
>  
>  #ifndef arch_set_freq_scale
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 4492608b7d7f..901cada51ba7 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -555,6 +555,31 @@ static const struct kobj_type sugov_tunables_ktype = {
>  
>  /********************** cpufreq governor interface *********************/
>  
> +#ifdef CONFIG_ENERGY_MODEL
> +static void rebuild_sd_workfn(struct work_struct *work)
> +{
> +	rebuild_sched_domains_energy();
> +}
> +
> +static DECLARE_WORK(rebuild_sd_work, rebuild_sd_workfn);
> +
> +/*
> + * EAS shouldn't be attempted without sugov, so rebuild the sched_domains
> + * on governor changes to make sure the scheduler knows about it.
> + */
> +static void sugov_eas_rebuild_sd(void)
> +{
> +	/*
> +	 * When called from the cpufreq_register_driver() path, the
> +	 * cpu_hotplug_lock is already held, so use a work item to
> +	 * avoid nested locking in rebuild_sched_domains().
> +	 */
> +	schedule_work(&rebuild_sd_work);
> +}
> +#else
> +static inline void sugov_eas_rebuild_sd(void) { };
> +#endif
> +
>  struct cpufreq_governor schedutil_gov;
>  
>  static struct sugov_policy *sugov_policy_alloc(struct cpufreq_policy *policy)
> @@ -709,6 +734,8 @@ static int sugov_init(struct cpufreq_policy *policy)
>  	if (ret)
>  		goto fail;
>  
> +	sugov_eas_rebuild_sd();
> +
>  out:
>  	mutex_unlock(&global_tunables_lock);
>  	return 0;
> @@ -750,6 +777,8 @@ static void sugov_exit(struct cpufreq_policy *policy)
>  	sugov_kthread_stop(sg_policy);
>  	sugov_policy_free(sg_policy);
>  	cpufreq_disable_fast_switch(policy);
> +
> +	sugov_eas_rebuild_sd();
>  }
>  
>  static int sugov_start(struct cpufreq_policy *policy)
> @@ -838,29 +867,3 @@ struct cpufreq_governor *cpufreq_default_governor(void)
>  #endif
>  
>  cpufreq_governor_init(schedutil_gov);
> -
> -#ifdef CONFIG_ENERGY_MODEL
> -static void rebuild_sd_workfn(struct work_struct *work)
> -{
> -	rebuild_sched_domains_energy();
> -}
> -static DECLARE_WORK(rebuild_sd_work, rebuild_sd_workfn);
> -
> -/*
> - * EAS shouldn't be attempted without sugov, so rebuild the sched_domains
> - * on governor changes to make sure the scheduler knows about it.
> - */
> -void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
> -				  struct cpufreq_governor *old_gov)
> -{
> -	if (old_gov == &schedutil_gov || policy->governor == &schedutil_gov) {
> -		/*
> -		 * When called from the cpufreq_register_driver() path, the
> -		 * cpu_hotplug_lock is already held, so use a work item to
> -		 * avoid nested locking in rebuild_sched_domains().
> -		 */
> -		schedule_work(&rebuild_sd_work);
> -	}
> -
> -}
> -#endif

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
