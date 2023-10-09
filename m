Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998FC7BD920
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346077AbjJILBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbjJILBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:01:16 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567A09C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:01:14 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-691c05bc5aaso3905279b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 04:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696849274; x=1697454074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=20UBSnZ21RVqEDRJGZ13WLMQlN/IzJeVLBl1dR+JWvA=;
        b=SyuHM73QZaxDoPGX22cjAdV1/EJ64tT156cd54rUQtMhuEBfs87xFRQuDMmmRZlkTq
         ULFjT0u8qNok/ApgZaaWZci08cDiAlwYrqltGj7QJyfKic1/TkK9pomiCde7JwB42mqE
         nb+qEGva+HCgaWRkNEhAx1ineQHwxFsDNfa0J9aGB2+e2HZNCMm2s4t/OIcPO7xkgo/Q
         1UeR9Rrv+8c2TyuSvGxAx+kRr7dh19Qn9eftWLHjUqrtA2+1d/zo0EgY/qbmkd3PApYp
         i+yTSWj8zr8nO8XQuHj+vbwn0Z3o2ZHawA448Giah38NFc61p2puuACE7XIrROJo1gnv
         m7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696849274; x=1697454074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20UBSnZ21RVqEDRJGZ13WLMQlN/IzJeVLBl1dR+JWvA=;
        b=DxUbahcDw6RVPTkrC9vaTgym0iRl3C/P3xvpVMXYoO3sdOFiYtkxw0UJhXEa7c5B7t
         +KZVnCcabANI39RE9seLR2zi8ADJStaB6Q1TRX2XSYCWZ+ISXuUcBRu0i8DbPn+tuVXp
         cQh8iqpd7/BwnUL5kfws0JZJIzVxwduJhyEcsyh2oo/K2Luss41jM5SG3vbfzEB7tIIq
         V+JcY9fWTgI94qmuXpdHFPZ4Zf2AHwzVeQZUxiV9J2i3gt0Kznea+nuE91L9h5S+2GtD
         hkWmcpwsC4BnxCCd1jIddVILQ3fe26b0soFkbPZRw5PWKMZprjvYepwNXPOBt84f5Oh0
         O2rg==
X-Gm-Message-State: AOJu0YxwAYnQbnabC2oIkHNsNbJKR94jh0NWmWOX/ipQyuWVg1zV+5ll
        9hiZbJJeWw19w7fzIpBoB2LNzBvdwI7mjZL6zZg=
X-Google-Smtp-Source: AGHT+IHe1jCSbOpGTUJ7WuGxCNpKASE8C+Y2DxHdiDOD36WoYmFY8Ro/O/Bx/pkU+uFk/jP4FO5q8Q==
X-Received: by 2002:a05:6a00:2da2:b0:68f:cc47:fcd7 with SMTP id fb34-20020a056a002da200b0068fcc47fcd7mr17093067pfb.28.1696849273710;
        Mon, 09 Oct 2023 04:01:13 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id gu21-20020a056a004e5500b00690c2cd7e0esm6146001pfb.49.2023.10.09.04.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 04:01:13 -0700 (PDT)
Date:   Mon, 9 Oct 2023 16:31:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        lukasz.luba@arm.com, ionela.voinescu@arm.com,
        pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH v2 3/6] cpufreq: use the fixed and coherent frequency for
 scaling capacity
Message-ID: <20231009110111.tdehkpammwyigzia@vireshk-i7>
References: <20231009103621.374412-1-vincent.guittot@linaro.org>
 <20231009103621.374412-4-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009103621.374412-4-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-10-23, 12:36, Vincent Guittot wrote:
> cpuinfo.max_freq can change at runtime because of boost as an example. This
> implies that the value could be different from the frequency that has been
> used to compute the capacity of a CPU.
> 
> The new arch_scale_freq_ref() returns a fixed and coherent frequency
> that can be used to compute the capacity for a given frequency.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 4 ++--
>  include/linux/cpufreq.h   | 9 +++++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 60ed89000e82..8c4f9c2f9c44 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -454,7 +454,7 @@ void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
>  
>  	arch_set_freq_scale(policy->related_cpus,
>  			    policy->cur,
> -			    policy->cpuinfo.max_freq);
> +			    arch_scale_freq_ref(policy->cpu));
>  
>  	spin_lock(&policy->transition_lock);
>  	policy->transition_ongoing = false;
> @@ -2174,7 +2174,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>  
>  	policy->cur = freq;
>  	arch_set_freq_scale(policy->related_cpus, freq,
> -			    policy->cpuinfo.max_freq);
> +			    arch_scale_freq_ref(policy->cpu));
>  	cpufreq_stats_record_transition(policy, freq);
>  
>  	if (trace_cpu_frequency_enabled()) {
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 71d186d6933a..bbc483b4b6e5 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1211,6 +1211,15 @@ void arch_set_freq_scale(const struct cpumask *cpus,
>  {
>  }
>  #endif
> +
> +#ifndef arch_scale_freq_ref
> +static __always_inline
> +unsigned int arch_scale_freq_ref(int cpu)
> +{
> +	return 0;
> +}
> +#endif
> +
>  /* the following are really really optional */
>  extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
>  extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
