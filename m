Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1952278BF18
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjH2HUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjH2HUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:20:31 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9C91A2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:20:27 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68a3e271491so2556741b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693293627; x=1693898427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oKss5vYWl1HttQGuCSa9y27tRx/GNreRvOPpOqQ7XGo=;
        b=w3pu0+ON2PrWEA/bfIM7apQ50NbnfmwNwy5u4c+pxmBUG3pGyBs+AcKcB2y+LIqaSj
         Ik9HOeMEl1qjqAdhwPuAbG6J3E/SRGkFqDK2O4C32oBWqKuH7c3ZR3yO4jNvUU0soKsD
         jndiHVVFK6NNoi3hyZhZ7AcDhTnU/FxNJwWUhALATSlUHByBGQKur0nf28geaTquFeQf
         uL6WpFC4joGokOe48M6qmNto7Cm9UhaRwhzd8NYrAirsd5H7Eby7sHOnOpvbPTPx0gzs
         HibFZTGjdyEZxgEHwOD/5gUw8J4DAFj3gz+dJA5NaIss4tfZzn/oBBWTEwxJxEinfOgd
         tLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693293627; x=1693898427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKss5vYWl1HttQGuCSa9y27tRx/GNreRvOPpOqQ7XGo=;
        b=UW6A2AjCEhfv+rucWIphMP+KgTzzqfL3tciZqRXlKxV3Mx/iHtuar66FBi7P/Jqi1p
         s0FM9BG2ZO/QhjoESQG3RPXnWSl6cpNRu5g4MPpHnYzTy/RwvNZlDkv0sW0dOhTO0V6V
         nC8GrvN8F2aoCq5qAgR+Mev2FnWG38jCV8p1ub+WgOCstx+excA+hsdts3LLG0J/yITN
         XHpXsj5JUSqj45qwKYrUSqJE0DV3KW/KmnN/P+2CcxQap9C/qzEtHJoENEVfpyg8OIKU
         +0AeSFb0wUxB7EVLJnwIKYiWpS+obdhbo5EeQkU5IY5/gKRn82SlRqrGI+DyDpoRgvUm
         xAZQ==
X-Gm-Message-State: AOJu0YxXG213qmTH2XdInH1Ngb1Yd3DouCEX/XjOiC3Ig1FohKhoRiqX
        gFVvEt4iQeMVvmpOM9zQIj3EBA==
X-Google-Smtp-Source: AGHT+IGdQJol9aKyrONBIIOXfEYwyZ23h77sYIBdXjSB7SIgxbohDNArzBUe43YvFGV9h9izlAT1xQ==
X-Received: by 2002:a05:6a21:3b4a:b0:14d:4673:4300 with SMTP id zy10-20020a056a213b4a00b0014d46734300mr5013582pzb.56.1693293627115;
        Tue, 29 Aug 2023 00:20:27 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id fk22-20020a056a003a9600b006887037cde6sm7848753pfb.60.2023.08.29.00.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 00:20:26 -0700 (PDT)
Date:   Tue, 29 Aug 2023 12:50:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, srivatsa.bhat@linux.vnet.ibm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: Fix the race condition while updating the
 transition_task of policy
Message-ID: <20230829072024.nxsm6bgu5mx4yxyg@vireshk-i7>
References: <20230829070318.1217668-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829070318.1217668-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-08-23, 07:03, Liao Chang wrote:
> The field 'transition_task' of policy structure is used to track the
> task which is performing the frequency transition. Using this field to
> print a warning once detect a case where the same task is calling
> _begin() again before completing the preivous frequency transition via
> the _end().
> 
> However, there is a potential race condition in _end() and _begin() APIs
> while updating the field 'transition_task' of policy, the scenario is
> depicted below:
> 
>              Task A                            Task B
> 
>         /* 1st freq transition */
>         Invoke _begin() {
>                 ...
>                 ...
>         }
>                                         /* 2nd freq transition */
>                                         Invoke _begin() {
>                                                 ... //waiting for A to
>                                                 ... //clear
>                                                 ... //transition_ongoing
>                                                 ... //in _end() for
>                                                 ... //the 1st transition
>                                                         |
>         Change the frequency                            |
>                                                         |
>         Invoke _end() {                                 |
>                 ...                                     |
>                 ...                                     |
>                 transition_ongoing = false;             V
>                                                 transition_ongoing = true;
>                                                 transition_task = current;
>                 transition_task = NULL;
>                 ... //A overwrites the task
>                 ... //performing the transition
>                 ... //result in error warning.
>         }
> 
> To fix this race condition, the transition_lock of policy structure is
> now acquired before updating policy structure in _end() API. Which ensure
> that only one task can update the 'transition_task' field at a time.
> 
> Link: https://lore.kernel.org/all/b3c61d8a-d52d-3136-fbf0-d1de9f1ba411@huawei.com/
> Fixes: ca654dc3a93d ("cpufreq: Catch double invocations of cpufreq_freq_transition_begin/end")
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 26fa99d46684..5c09a4936699 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -455,8 +455,10 @@ void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
>  			    policy->cur,
>  			    policy->cpuinfo.max_freq);
>  
> +	spin_lock(&policy->transition_lock);
>  	policy->transition_ongoing = false;
>  	policy->transition_task = NULL;
> +	spin_unlock(&policy->transition_lock);
>  
>  	wake_up(&policy->transition_wait);
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
