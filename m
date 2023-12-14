Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A175881270D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 06:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443203AbjLNFnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 00:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443207AbjLNFnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:43:04 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97F4111
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 21:43:10 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3ba14203a34so2968115b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 21:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702532590; x=1703137390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2zJEKJBJdRMRCgJFJEeFLk/7+B+l3ptfOOAh8xQH8eM=;
        b=WrqT+Jqi05FHIN9RA9jJYU6rmRrrb9c2uYCg7CqClmZEKbuxij6nuCEwuCEzZisDA9
         rjIwi3NguPfra4YUpb+J/ermcBAh6DSe2ciLhrVr9TgF/KVVvcNm1O1EEQor5QScpIsR
         bXNbRtAqBLLvN+Ukx2LjpYKFdoXiwDJM58Yjyj4JT0OwYIJ5lYw6WJdSgA9W+2m6oDuM
         t8PPjoXKPl2KDzXeNnI6KXRzA4xpOBjeAWFbTNKR+e1XAtmgfRTTPL6UWe/S8/+8zJQf
         kvUf7HH11AgZgfTZFSMMUtAxuf6pp2YUpzgaZEvtyHBFZUCvchX4NnRgPxYQzda1LGy6
         01dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702532590; x=1703137390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zJEKJBJdRMRCgJFJEeFLk/7+B+l3ptfOOAh8xQH8eM=;
        b=LEZvql7AljaeS+JqqzutnV1Slj4oeK+3qHw2or5fYftqU5z+LmDRNAbg8l5VBxiZ9P
         k3PaUwDEEIsR+W6VkNsuLqgZ4WVMLKXGHL79wGP/BmpZ4nA0NuDndQldBHTjqCIkT2bZ
         U3LuZz3bk/2W7Ax7JUFYWQbV6Q5jUFsgScb9tNlV+0D60EnitqVkqfZBItV5VvTtSPs5
         8X7HoEDHYQixfdXVFikw/Rq2XXYblcpAXmUFqRK7kBDTPLSPf6As985MPM4i58v+FC7e
         SOejCY/gjoTl9M65MlBUb+R+2MBXv9onndF8bFtgQSFCUodVdyNJ+a38YxpYLm6lcBcS
         KLRg==
X-Gm-Message-State: AOJu0YwMJnymKAuN5GDNOpWshKvPVV2jP3UOgA9sikvK06JmnsabKWcc
        qvyV9UUQtVqRf2FZ3QuLfI3yzg==
X-Google-Smtp-Source: AGHT+IGYWNbaFlApZ1lFvqRaU1qt9FMGrCRJVZt4T9E+6r/Apb1PpoPAXMGsw6TNwwldN5dhTrbFiw==
X-Received: by 2002:a05:6808:11c8:b0:3ba:2af:c7da with SMTP id p8-20020a05680811c800b003ba02afc7damr9445649oiv.110.1702532590040;
        Wed, 13 Dec 2023 21:43:10 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id x20-20020aa793b4000000b006ce4c7ba448sm10887964pff.25.2023.12.13.21.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 21:43:09 -0800 (PST)
Date:   Thu, 14 Dec 2023 11:13:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
        rafael@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, lukasz.luba@arm.com,
        rui.zhang@intel.com, mhiramat@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq pressure feedback for the
 scheduler
Message-ID: <20231214054307.axl33gagxacidjbn@vireshk-i7>
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
 <20231212142730.998913-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212142730.998913-2-vincent.guittot@linaro.org>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-12-23, 15:27, Vincent Guittot wrote:
> @@ -2618,6 +2663,9 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  	policy->max = __resolve_freq(policy, policy->max, CPUFREQ_RELATION_H);
>  	trace_cpu_frequency_limits(policy);
>  
> +	cpus = policy->related_cpus;
> +	cpufreq_update_pressure(cpus, policy->max);
> +
>  	policy->cached_target_freq = UINT_MAX;

One more question, why are you doing this from cpufreq_set_policy ? If
due to cpufreq cooling or from userspace, we end up limiting the
maximum possible frequency, will this routine always get called ?

-- 
viresh
