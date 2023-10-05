Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336577B9F36
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbjJEOTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjJEOR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:17:26 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7E124E8C;
        Thu,  5 Oct 2023 04:26:57 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b2cee40de8so196387866b.1;
        Thu, 05 Oct 2023 04:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696505216; x=1697110016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+DmKqCIULKrNCF4CdnTVqFVH0GO4tyriLLf0pJhJwn8=;
        b=c8QMNDHBvspat2uzGkqpylt6eI5eKmwpZdEUgeW1P3d9/qEdr4ks0i8EHcEmJoRfmc
         WNrIPWIqGOF9idTc0wbJkTBZG8o4H1KZni2I72O4Kl65nq/giDF5WswlwbIXrF+FyCJM
         HxlRav71tu76r0eTOL3WEjt1592f/9YQ+q9arHBJhysSdEqDAyKpaNni5n2MgogXyCEW
         TA29UVIizTaPKj/rRhGz6bL5Hod3c5f643epJRbt9UAIeRil/Ip4XEsqXsencLpjC1ey
         Nze+19KcibFr0K6LZx2Gx8Xp8Cl4xJt+FCTeZqBmsDfutHRGW7wLPPQ6y18NDJyIy8rm
         zupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696505216; x=1697110016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DmKqCIULKrNCF4CdnTVqFVH0GO4tyriLLf0pJhJwn8=;
        b=nmInUbCianuIFNgzkoIDlKyrZnp8XwGgYm3rXJVK+WE0D4FsBv1UYgdg2k0nogxbt8
         OjptI7XgINB3Nrijpa+oXcWrxN6VQNErD0wNBuwfAYpFTvSBJf77SWGF33yrK4BWteKe
         zDEB/UtjgEQ/JmknS+8G3brsC+qkKPlb1e5fO6+y+d4QQJmG6DKRNs8jHUZxVwNqE41Z
         mPg8e6mfP4yhpFfE4/kzMoREeMzOFQS6vygcNi/VQMOvJ2h0ksh1WGyRLEwBF1NiVlBf
         1RDgVTNxDom1/s29mRaddJT4x0AhLBnP/kU8zytCTLifOQZ4aAyYqTbkligSvApBzAjN
         zXbQ==
X-Gm-Message-State: AOJu0YyNAxDKFKzDU12if1U8eUpulqrBB3fS2KyVt7HmxylhpQ6p/UDP
        AWv3xpdpyOz3Me0noB7Gq3I=
X-Google-Smtp-Source: AGHT+IGe57gqy2qwMkBLLrtA1T4Sr1o8fvynFQHz8ttqGVxzU1bwRTsfe9BIaT5YiwTSBH7iHBJvxg==
X-Received: by 2002:a17:907:7291:b0:9ad:8641:e91b with SMTP id dt17-20020a170907729100b009ad8641e91bmr1018565ejc.11.1696505216033;
        Thu, 05 Oct 2023 04:26:56 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id rn4-20020a170906d92400b0099bc038eb2bsm1025054ejb.58.2023.10.05.04.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 04:26:55 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 5 Oct 2023 13:26:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Xuewen Yan <xuewen.yan@unisoc.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        guohua.yan@unisoc.com, qyousef@layalina.io,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: next_freq need update when
 cpufreq_limits changed
Message-ID: <ZR6delkbZxl31zuY@gmail.com>
References: <20230719130527.8074-1-xuewen.yan@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719130527.8074-1-xuewen.yan@unisoc.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Xuewen Yan <xuewen.yan@unisoc.com> wrote:

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
>  		next_f = sg_policy->next_freq;
>  
>  		/* Restore cached freq as next_freq has changed */

Just wondering about the status of this fix - is it pending in
some tree, or should we apply it to the scheduler tree?

Thanks,

	Ingo
