Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A1277DA75
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 08:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242114AbjHPG2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 02:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242115AbjHPG2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:28:03 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DF41FC1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:28:00 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bc8045e09dso39269135ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692167280; x=1692772080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R9swZ9sobe/UyaVKZ0ksxQMitw8thN1Q9u7bV7nG1uY=;
        b=cvImbZnTYQoZ9txKjQ0qTOvVJRFxUFIG4pfT7z6GQqWPDb4oyqRtDxJ7IvWcA+WWXT
         ZWz7q0sNpzb0kabUVuf4AfhUbbwLDFLOkgqXu0yOvosFxXAqyt8wyreKrVA+TcCcsnLR
         8SvUGMO5vyUbt02rZ2aRiqok8hhv0eXZD5fcQ85e1kw6Oh5wZY0rTjJzP4uR84fdcfvY
         hDQTa6GEmQZnW/iu6xaypzd73KZOK2/nDftBjodhsuKZZIfzg+WvmhAOKNQQszW8Mw+3
         lakcraer/uqUTMPjwMIAgN3nnxuCkR9ZiI77vPF7d4VaqAsnP6PTkB1eAOANwyRnvxwf
         mR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692167280; x=1692772080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9swZ9sobe/UyaVKZ0ksxQMitw8thN1Q9u7bV7nG1uY=;
        b=bft9L5WTHroqu13sU0VAJNJzHG1G54xlP6c1aMLGgdgRXBGPKBW5yN9RQw71M+9bTw
         gZDkFF0NoUlTZTquB5Um+sKK/Jfa2t9BQp7/qsMTPIkUkhWz+SgB8Xk983GpdEXabHWt
         5BCxN2Cujv084/Gs/8w8tD1Hh3KigCHfpbbWLbbTN+ON3etNfywyWXvQczbS2kR1kmhs
         +Q6rjilXjSyi14N49mLxDm6uVJgMVr1ZiLin1QnSjtNqVt3Pb5DurtThqX5ypZyhYr9w
         aIY1LPDjfGUMlq4dLBrcO5zsaCHS6imYpot0sJZIssuseUraX7ZNCvoD6Hl8kxZk2RGn
         t6XA==
X-Gm-Message-State: AOJu0Yy7D7t76oVcz47zBV6Bqvx22lrPswYxU3P81wSuPvKfuMS5rK1/
        n3fNVt0IJeabbXHaQ6whEz+ydA==
X-Google-Smtp-Source: AGHT+IG+7YkbZ3410JWVHZ1nOSSxRvqGUiSUTPvOM7VFDZgTy0GOMytoHqUZQnyQD/fllIOZfZswXA==
X-Received: by 2002:a17:902:e84c:b0:1b8:a569:f980 with SMTP id t12-20020a170902e84c00b001b8a569f980mr1330252plg.65.1692167280004;
        Tue, 15 Aug 2023 23:28:00 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902820700b001b392bf9192sm12205855pln.145.2023.08.15.23.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 23:27:59 -0700 (PDT)
Date:   Wed, 16 Aug 2023 11:57:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jie Zhan <zhanjie9@hisilicon.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        xuwei5@huawei.com, wanghuiqiang@huawei.com,
        jonathan.cameron@huawei.com, wangxiongfeng2@huawei.com
Subject: Re: [RFC PATCH] cpufreq: Support per-policy performance boost
Message-ID: <20230816062757.tocdrqh3isxcrt3r@vireshk-i7>
References: <20230724075827.4160512-1-zhanjie9@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724075827.4160512-1-zhanjie9@hisilicon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jie,

I am not sure how useful this per-policy boost is for your use case,
but I have no objection to the same if it is worth it.

On 24-07-23, 15:58, Jie Zhan wrote:
> The boost control currently applies to the whole system.  However, users
> may prefer to boost a subset of cores in order to provide prioritized
> performance to workloads running on the boosted cores.
> 
> Enable per-policy boost by adding a 'local_boost' sysfs interface.  This
> can be found at:
> 
> 	/sys/devices/system/cpu/cpufreq/policy<*>/local_boost

Just name it boost instead of local_boost, it is present in the
policy's directory, that is enough.

> 
> Same to the global boost switch, writing 1/0 to 'local_boost'
> enables/disables boost on a cpufreq policy respectively.
> 
> The user view of global and local boost controls should be:
> 
> 1. Enabling global boost initially enables local boost on all policies, and
> local boost can then be enabled or disabled individually on each policy,
> given that the platform does support so.
> 
> 2. Disabling global boost makes enabling local boost illegal, while writing
> 0 to 'local_boost' is fine but takes no effect.
> 
> A possible question could be: why not just limiting 'scaling_max_freq'?
> Well, the fundamental difference is that 'local_boost' could be more
> user-friendly.  When global boost is enabled, it is not straightforward to
> figure out the base frequency for setting 'scaling_max_freq' to a non-boost
> value. Also, this is supposed to take effect on the physical upper
> frequency limit, reflected through 'cpuinfo_max_freq'.
> 
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> Reviewed-by: Wei Xu <xuwei5@hisilicon.com>
> ---
>  drivers/cpufreq/cpufreq.c | 33 +++++++++++++++++++++++++++++++++
>  include/linux/cpufreq.h   |  3 +++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6b52ebe5a890..14579c59f7ba 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -621,6 +621,35 @@ static ssize_t store_boost(struct kobject *kobj, struct kobj_attribute *attr,
>  }
>  define_one_global_rw(boost);
>  
> +static ssize_t show_local_boost(struct cpufreq_policy *policy, char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", policy->local_boost_enabled);
> +}
> +
> +static ssize_t store_local_boost(struct cpufreq_policy *policy,
> +				 const char *buf, size_t count)
> +{
> +	int ret, enable;
> +
> +	ret = kstrtoint(buf, 10, &enable);
> +	if (ret || enable < 0 || enable > 1)
> +		return -EINVAL;
> +
> +	if (enable && !cpufreq_driver->boost_enabled)
> +		return -EINVAL;

Not just while enabling it, you should check for boost_enabled all the
time.

Also, you can optimize here if the state is being set to existing
state and quit early. This is done in the case of global boost
already. Have a look.

> +
> +	cpus_read_lock();
> +	ret = cpufreq_driver->set_boost(policy, enable);
> +	cpus_read_unlock();
> +
> +	if (ret)
> +		return ret;
> +
> +	policy->local_boost_enabled = enable;

s/local_//

> +
> +	return count;
> +}
> +
>  static struct cpufreq_governor *find_governor(const char *str_governor)
>  {
>  	struct cpufreq_governor *t;
> @@ -931,6 +960,7 @@ cpufreq_freq_attr_rw(scaling_min_freq);
>  cpufreq_freq_attr_rw(scaling_max_freq);
>  cpufreq_freq_attr_rw(scaling_governor);
>  cpufreq_freq_attr_rw(scaling_setspeed);
> +cpufreq_freq_attr_rw(local_boost);
>  
>  static struct attribute *cpufreq_attrs[] = {
>  	&cpuinfo_min_freq.attr,
> @@ -944,6 +974,7 @@ static struct attribute *cpufreq_attrs[] = {
>  	&scaling_driver.attr,
>  	&scaling_available_governors.attr,
>  	&scaling_setspeed.attr,
> +	&local_boost.attr,

Making this file available if the global boost file isn't present is a
bit tricky I think. Maybe at least check for cpufreq_boost_supported()
before doing so.

>  	NULL
>  };
>  ATTRIBUTE_GROUPS(cpufreq);
> @@ -2716,6 +2747,8 @@ int cpufreq_boost_trigger_state(int state)
>  		ret = cpufreq_driver->set_boost(policy, state);
>  		if (ret)
>  			goto err_reset_state;
> +
> +		policy->local_boost_enabled = state;
>  	}
>  	cpus_read_unlock();
>  
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 26e2eb399484..a99a48ac9fdb 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -140,6 +140,9 @@ struct cpufreq_policy {
>  	 */
>  	bool			dvfs_possible_from_any_cpu;
>  
> +	/* Per policy boost enabled flag. */
> +	bool			local_boost_enabled;
> +
>  	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
>  	unsigned int cached_target_freq;
>  	unsigned int cached_resolved_idx;
> -- 
> 2.30.0

-- 
viresh
