Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D40C77014E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjHDNTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjHDNTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:19:23 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D9F4EF4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:16:26 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686f38692b3so1963406b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 06:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691154966; x=1691759766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v49lw5rFTy81+BU2fN2JGG/U10YgW4mNtzXjfOhTQIo=;
        b=jzfNEbGXSnlLU2pWsazI0v7g7wM98HRROWfbjTjXAr1j4TJXYLEZj2j2aEtQZhgfiU
         qXDD3P9ptMBogszr8o+zSTaRolej/ai8mAxA/Kg5o3Rawx+1QxIt7C9GOINwAavOY+cF
         RMeFEXXSWX0W+Doiv5/Y40XYE7IQUCJT4dHfX8mu8v4KSaW99rVShxttXOwoz2XGJzso
         ZMC7Tu62EB7+vwtnspoiQKbtHJnu33nI9vt+iMTTlK1ZlGmN08RcFJDXkglqVe+4Ox3J
         5Yeh6kR6vVmNyFS5QVXde6zSzU4a2SvhP0dJDvYgUeu3p3yq8JEaWwDEw/ac/n/5g4UJ
         53eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691154966; x=1691759766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v49lw5rFTy81+BU2fN2JGG/U10YgW4mNtzXjfOhTQIo=;
        b=U75+YpjfbJzCNvfeG79j1csnhq1WUPKAqKyYFRf5A6dClkOjDSXzhh61iEie/9je/f
         sEakLHBS0iNUE+QsPZRFHEahpTUYkIC8zBj/vpIajNchl4Ok1ATVyh85HYJLJW9lGBFB
         GfrL+Hv54qRAku+nabPHSZpKEHOhKHYd4t1tghOZpjvEwX3shl28byIG/QXD6e7Gc3q7
         n+Up6FvWqfguJBeQA0+hsU9SC/v5dfkTmilaVRJ9MeoOYQNCGOLG9+RFu/wW7oZDPAl5
         l/0+eIOkl7Qc1pBEHXmfClLpTpW2v12+NQPYJP8jr3yYACojNnNuSLOTxNIJ5LmfqYBm
         vuQg==
X-Gm-Message-State: AOJu0YxHzUqpDs4x570C/LaRUoQLQ564DlxDQnFIeNlSp0MUcZE0xY9W
        2HqoeoWDaOzUXN1qk+AfofiU9w==
X-Google-Smtp-Source: AGHT+IHqyFCbsgCK+gjlrPWCeG4ftJMJcUdPC/Hqi6tNWGTgSrEaKxE7ZICTZMit6gIiunvHvVkrhQ==
X-Received: by 2002:a05:6a00:150e:b0:66c:a45:f00b with SMTP id q14-20020a056a00150e00b0066c0a45f00bmr2344827pfu.23.1691154965810;
        Fri, 04 Aug 2023 06:16:05 -0700 (PDT)
Received: from [10.254.69.31] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id p18-20020aa78612000000b006871dad3e74sm1585976pfn.65.2023.08.04.06.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 06:16:04 -0700 (PDT)
Message-ID: <dfbf05d1-daff-e855-f4fd-e802614b79c4@bytedance.com>
Date:   Fri, 4 Aug 2023 21:15:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 1/2] mm, oom: Introduce bpf_select_task
To:     Michal Hocko <mhocko@suse.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, muchun.song@linux.dev,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230804093804.47039-1-zhouchuyi@bytedance.com>
 <20230804093804.47039-2-zhouchuyi@bytedance.com>
 <ZMzhDFhvol2VQBE4@dhcp22.suse.cz>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <ZMzhDFhvol2VQBE4@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

在 2023/8/4 19:29, Michal Hocko 写道:
> On Fri 04-08-23 17:38:03, Chuyi Zhou wrote:
>> This patch adds a new hook bpf_select_task in oom_evaluate_task. It
>> takes oc and current iterating task as parameters and returns a result
>> indicating which one is selected by bpf program.
>>
>> Although bpf_select_task is used to bypass the default method, there are
>> some existing rules should be obeyed. Specifically, we skip these
>> "unkillable" tasks(e.g., kthread, MMF_OOM_SKIP, in_vfork()).So we do not
>> consider tasks with lowest score returned by oom_badness except it was
>> caused by OOM_SCORE_ADJ_MIN.
> 
> Is this really necessary? I do get why we need to preserve
> OOM_SCORE_ADJ_* semantic for in-kernel oom selection logic but why
> should an arbitrary oom policy care. Look at it from an arbitrary user
> space based policy. It just picks a task or memcg and kills taks by
> sending SIG_KILL (or maybe SIG_TERM first) signal. oom_score constrains
> will not prevent anybody from doing that.

Sorry, some of my expressions may have misled you.

I do agree bpf interface should bypass the current OOM_SCORE_ADJ_* 
logic. What I meant to say is that bpf can select a task even it was
setted OOM_SCORE_ADJ_MIN.

> 
> tsk_is_oom_victim (and MMF_OOM_SKIP) is a slightly different case but
> not too much. The primary motivation is to prevent new oom victims
> while there is one already being killed. This is a reasonable heuristic
> especially with the async oom reclaim (oom_reaper). It also reduces
> amount of oom emergency memory reserves to some degree but since those
> are not absolute this is no longer the primary motivation. _But_ I can
> imagine that some policies might be much more aggresive and allow to
> select new victims if preexisting are not being killed in time.
> 
> oom_unkillable_task is a general sanity check so it should remain in
> place.
> 
> I am not really sure about oom_task_origin. That is just a very weird
> case and I guess it wouldn't hurt to keep it in generic path.
> 
> All that being said I think we want something like the following (very
> pseudo-code). I have no idea what is the proper way how to define BPF
> hooks though so a help from BPF maintainers would be more then handy
> ---
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index 00982b133dc1..9f1743ee2b28 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -190,10 +190,6 @@ static inline bool trigger_all_cpu_backtrace(void)
>   {
>   	return false;
>   }
> -static inline bool trigger_allbutself_cpu_backtrace(void)
> -{
> -	return false;
> -}
>   static inline bool trigger_cpumask_backtrace(struct cpumask *mask)
>   {
>   	return false;
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 612b5597d3af..c9e04be52700 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -317,6 +317,22 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
>   	if (!is_memcg_oom(oc) && !oom_cpuset_eligible(task, oc))
>   		goto next;
>   
> +	/*
> +	 * If task is allocating a lot of memory and has been marked to be
> +	 * killed first if it triggers an oom, then select it.
> +	 */
> +	if (oom_task_origin(task)) {
> +		points = LONG_MAX;
> +		goto select;
> +	}
> +
> +	switch (bpf_oom_evaluate_task(task, oc, &points)) {
> +		case -EOPNOTSUPP: break; /* No BPF policy */
> +		case -EBUSY: goto abort; /* abort search process */
> +		case 0: goto next; /* ignore process */
> +		default: goto select; /* note the task */
> +	}

Why we need to change the *points* value if we do not care about 
oom_badness ? Is it used to record some state? If so, we could record it 
through bpf map.

> +
>   	/*
>   	 * This task already has access to memory reserves and is being killed.
>   	 * Don't allow any other task to have access to the reserves unless
> @@ -329,15 +345,6 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
>   		goto abort;
>   	}
>   
> -	/*
> -	 * If task is allocating a lot of memory and has been marked to be
> -	 * killed first if it triggers an oom, then select it.
> -	 */
> -	if (oom_task_origin(task)) {
> -		points = LONG_MAX;
> -		goto select;
> -	}
> -
>   	points = oom_badness(task, oc->totalpages);
>   	if (points == LONG_MIN || points < oc->chosen_points)
>   		goto next;
Thanks for your advice, I'm very glad to follow your suggestions for the 
next version of development.
