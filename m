Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1074677B78E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjHNL0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbjHNLZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:25:42 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCF5E5F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:25:16 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bc63ef9959so36416175ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692012315; x=1692617115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+PxAB7nNqvWknnvZYOJV/X5uhkKH6WqZ+oav9+cSU0=;
        b=WGrA1zvdW8CRTYCzo9xHqYL0THIN8mec5gpvSqW3mFFjXs3FmwE/tPA1ThzDS2QnDE
         B3nuXRIfGEHjmSC0BhQ0ClwA8eGCqTRf+/TJZTFVKicL7n4PEtH8AdIabTiHc2+4xdQv
         JS4/Ew3eyhxDs6vlEqDL/jzLwVEKoMCkxz6hhSw5ZrStJ8uOSDcIE1mfio1IvLeWxIUf
         /pFFJuqGIrFaTFca6zsxKifTPUF5LxXuM1waB/MKrHXBu0rHSl0DahvDD8sMkCjpbxOb
         BlxLx4GQW1f4PZWpeRubQvB3BljBJs7vwSjnyp/Pa5qf4KoO5UKfTnTiV3bHbdR/DyUF
         7Kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692012315; x=1692617115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s+PxAB7nNqvWknnvZYOJV/X5uhkKH6WqZ+oav9+cSU0=;
        b=XD3pF9cJaPD7p2MGlYvwxXFOJh7NsGTWgR6XNQladMD99C3A8k/Xr98DhSfALaFmOt
         D4/zg3oT1r5C0aDvCvMa2NShCQ2R8W8rz7Xcia1PgUzWn5iOKLrmxk1MBlMXtQ+foaJw
         ol9miTZqcsbSn1BEbmJ9QIP0F5lbC09vg1W5POjfuanbHWWYqz0ASDbtQEXFSaqiXT9+
         yo6N71mGsFPE3EtrimM/syW52lQ1X04Gu7+hdcxJeGPmWELsqZJ+bmtppTI4hMa2J+KS
         IcCrnDJvh23uO/quBViO2RTmCkNa/m6lP1tO7v3RLXIyBMYCK7YAWDT/d0jVkAzlFaWo
         H3DQ==
X-Gm-Message-State: AOJu0YwtmmsMSwbVzPNBZMjMVu/HSEhRK/1UxpVOroT/6tUyRzrXxGya
        S5VmTIYGF5jnJz3OBPQquH6QRg==
X-Google-Smtp-Source: AGHT+IHlMbxsbZDuxZkVdO2MLoTV8x4OcADIWydws9ZOXObYttjnge2NK+5+qZ6aQ6mfCUETTqYMmg==
X-Received: by 2002:a17:902:d507:b0:1bb:7996:b269 with SMTP id b7-20020a170902d50700b001bb7996b269mr12526390plg.19.1692012315486;
        Mon, 14 Aug 2023 04:25:15 -0700 (PDT)
Received: from [10.85.117.81] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b001b869410ed2sm9164925plf.72.2023.08.14.04.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 04:25:15 -0700 (PDT)
Message-ID: <78648d96-8899-6ac6-62d4-9e5b34ac004e@bytedance.com>
Date:   Mon, 14 Aug 2023 19:25:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 1/2] mm, oom: Introduce bpf_select_task
To:     Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     hannes@cmpxchg.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, muchun.song@linux.dev, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com,
        robin.lu@bytedance.com
References: <20230804093804.47039-1-zhouchuyi@bytedance.com>
 <20230804093804.47039-2-zhouchuyi@bytedance.com>
 <ZMzhDFhvol2VQBE4@dhcp22.suse.cz>
 <dfbf05d1-daff-e855-f4fd-e802614b79c4@bytedance.com>
 <ZMz+aBHFvfcr0oIe@dhcp22.suse.cz>
 <866462cf-6045-6239-6e27-45a733aa7daa@bytedance.com>
 <ZNCXgsZL7bKsCEBM@dhcp22.suse.cz> <ZNEpsUFgKFIAAgrp@P9FQF9L96D.lan>
 <ZNH6X/2ZZ0quKSI6@dhcp22.suse.cz> <ZNK2fUmIfawlhuEY@P9FQF9L96D>
 <ZNNGFzwlv1dC866j@dhcp22.suse.cz>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <ZNNGFzwlv1dC866j@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

在 2023/8/9 15:53, Michal Hocko 写道:
> On Tue 08-08-23 14:41:17, Roman Gushchin wrote:
>> On Tue, Aug 08, 2023 at 10:18:39AM +0200, Michal Hocko wrote:
>>> On Mon 07-08-23 10:28:17, Roman Gushchin wrote:
>>>> On Mon, Aug 07, 2023 at 09:04:34AM +0200, Michal Hocko wrote:
>>>>> On Mon 07-08-23 10:21:09, Chuyi Zhou wrote:
>>>>>>
>>>>>>
>>>>>> 在 2023/8/4 21:34, Michal Hocko 写道:
>>>>>>> On Fri 04-08-23 21:15:57, Chuyi Zhou wrote:
>>>>>>> [...]
>>>>>>>>> +	switch (bpf_oom_evaluate_task(task, oc, &points)) {
>>>>>>>>> +		case -EOPNOTSUPP: break; /* No BPF policy */
>>>>>>>>> +		case -EBUSY: goto abort; /* abort search process */
>>>>>>>>> +		case 0: goto next; /* ignore process */
>>>>>>>>> +		default: goto select; /* note the task */
>>>>>>>>> +	}
>>>>
>>>> To be honest, I can't say I like it. IMO it's not really using the full bpf
>>>> potential and is too attached to the current oom implementation.
>>>
>>> TBH I am not sure we are able to come up with an interface that would
>>> ise the full BPF potential at this stage and I strongly believe that we
>>> should start by something that is good enough.
>>>
>>>> First, I'm a bit concerned about implicit restrictions we apply to bpf programs
>>>> which will be executed potentially thousands times under a very heavy memory
>>>> pressure. We will need to make sure that they don't allocate (much) memory, don't
>>>> take any locks which might deadlock with other memory allocations etc.
>>>> It will potentially require hard restrictions on what these programs can and can't
>>>> do and this is something that the bpf community will have to maintain long-term.
>>>
>>> Right, BPF callbacks operating under OOM situations will be really
>>> constrained but this is more or less by definition. Isn't it?
>>
>> What do you mean?
> 
> Callbacks cannot depend on any direct or indirect memory allocations.
> Dependencies on any sleeping locks (again directly or indirectly) is not
> allowed just to name the most important ones.
> 
>> In general, the bpf community is trying to make it as generic as possible and
>> adding new and new features. Bpf programs are not as constrained as they were
>> when it's all started.
> 
> Are the above ones somehow carved into BPF in general?
>   
>>>> Second, if we're introducing bpf here (which I'm not yet convinced),
>>>> IMO we should use it in a more generic and expressive way.
>>>> Instead of adding hooks into the existing oom killer implementation, we can call
>>>> a bpf program before invoking the in-kernel oom killer and let it do whatever
>>>> it takes to free some memory. E.g. we can provide it with an API to kill individual
>>>> tasks as well as all tasks in a cgroup.
>>>> This approach is more generic and will allow to solve certain problems which
>>>> can't be solved by the current oom killer, e.g. deleting files from a tmpfs
>>>> instead of killing tasks.
>>>
>>> The aim of this proposal is to lift any heavy lifting steming from
>>> iterating tasks or cgroups which those BPF might need to make a
>>> decision. There are other ways of course and provide this iteration
>>> functionality as library functions but my BPF experience is very limited
>>> to say how easy is that.
>>>
>>>> So I think the alternative approach is to provide some sort of an interface to
>>>> pre-select oom victims in advance. E.g. on memcg level it can look like:
>>>>
>>>> echo PID >> memory.oom.victim_proc
>>>
>>> this is just a terrible interface TBH. Pids are very volatile objects.
>>> At the time oom killer reads this pid it might be a completely different
>>> process.
>>
>> Well, we already have cgroup.procs interface, which works ok.
>> Obviously if the task is dead (or is actually killed in a result of oom),
>> it's pid is removed from the list.
> 
> Right, but writing the pid into the file has an immediate effect and
> recycle pid issues would be rare unless the pid space is mostly
> depleted. You are proposing an interface where the pid would be consumed
> in potentially very distant future. Such an approach would only work if
> the pid is auto-removed and then you need a notification mechanism to
> replace it by something else.
>   
>>>> If the list is empty, the default oom killer is invoked.
>>>> If there are tasks, the first one is killed on OOM.
>>>> A similar interface can exist to choose between sibling cgroups:
>>>>
>>>> echo CGROUP_NAME >> memory.oom.victim_cgroup
>>>
>>> Slightly less volatile but not much better either.
>>>
>>>> This is just a rough idea.
>>>
>>> I am pretty sure that both policies could be implemetd by the proposed
>>> BPF interface though if you want something like that.
>>
>> As I said, I'm pretty concerned about how reliable (and effective) it will be.
>> I'm not convinced that executing a generic bpf program from the oom context
>> is safe (and we're talking about executing it potentially thousands of times).
>> If we're going this way, we need an explicit acknowledge from the bpf
>> community and a long-term agreement on how we'll keep thing safe.
> 
> I do agree with that.
> 
>> It would be also nice to come up with some practical examples of bpf programs.
>> What are meaningful scenarios which can be covered with the proposed approach
>> and are not covered now with oom_score_adj.
> 
Just like Abel said, the oom_score_adj only adjusts the memory 
usage-based decisions, and it's hard to be translated into other 
semantics. We see that some userspace oom-killer like oomd has 
implemented policies based on other semantics(e.g., memory growth, 
priority, psi pressure, ect.) which can be useful in some specific scenario.

> Agreed here as well. This RFC serves purpose of brainstorming on all of
> this.
> 
> There is a fundamental question whether we need BPF for this task in the
> first place. Are there any huge advantages to export the callback and
> allow a kernel module to hook into it?

If we export the callback to a kernel module and hook into it,
We still have the same problems (e.g., allocating much memory). Just 
like Martin saied, at least BPF supports some basic running context and 
some unsafe behavior is restricted.
