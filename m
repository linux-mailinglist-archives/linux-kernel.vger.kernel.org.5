Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C8876C34C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 05:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjHBDFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 23:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjHBDF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 23:05:27 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078F1AC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 20:05:02 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8b2b60731so38170275ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 20:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690945501; x=1691550301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrTeUZeBnkvhMs7Cn02BDSHXUnGPcEFPFubIShESgns=;
        b=leNicxnTVqX1Qt3ANTJRQh0ORZclfjfD+OfkL+oQKrrblOXJaWICkSxHdqwsraX57J
         FxQsab2MfmU+ySI6fRQnt9mU2rzCxo9lg6SHB9G+jOyQBkpeVcMUB5obNnmC3FlCH2aq
         WO2zZQYyxyZKnjLVQ30Rk92IlYarnpOjTiYZ4qVZExzefL4rn+3ebvqUtF46CFNZAlvJ
         cQutWYd3yhyipNrMIA7PY2HAv6TyIgY8LfKykGKAnQvenSJd0MyRws2zMqK+75YLabLS
         4X3zRzSmKybzAuWnkhFIHDSeSScqq0U5wjH6fN7KK/CcAjdeE4XiB1TqnylypjYXCIsM
         SIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690945501; x=1691550301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KrTeUZeBnkvhMs7Cn02BDSHXUnGPcEFPFubIShESgns=;
        b=VSc4xBcJwLThune12ZFUEiSdFONfFNtRhL5KNn/LukFQDA0OjU1eIPIUlnJGE5u2KQ
         gJStCShgzhtzoHUMhH5kGd19Nw5NhzvkcoaTPjA0kHpP/BARYjRdeTO/hY63fjRclfE2
         iJJunL3BaFtyPEI2h2fIXc52BV+DZSrRJdwM3PAvXCpsNG/gV1OdoHkUrz1fWQJ0oze7
         8Ots2bYWlB8wK6QlViLq3EgbGfj8gwnKA/k+UH5CDHD+g7rR/bA8yP/vv560aDR6fxll
         07bFmMrCifxWuUQWeqm5O+d5u7A0VXPn0dd6kykBe8xP/48YsgA7dX5Z6fwRSRdGAW3d
         D7Yw==
X-Gm-Message-State: ABy/qLYG7rJ7o2AiTtHGDSnAS13AAYe/OjHdFXS1ljzbd+j0EQtDkmH5
        ijg3A9jWFGOooJO8i3fHHVTjCg==
X-Google-Smtp-Source: APBJJlGkGlnRtGOhUYsWIGdfaYH8VzYo0xlGljESTIO4JXmf7uVp2EPhjsmNTWpYukrc+ecJ1k/A4w==
X-Received: by 2002:a17:902:f7c7:b0:1bc:afa:95a6 with SMTP id h7-20020a170902f7c700b001bc0afa95a6mr7510567plw.40.1690945501211;
        Tue, 01 Aug 2023 20:05:01 -0700 (PDT)
Received: from [10.85.117.81] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b001a5fccab02dsm11160846plh.177.2023.08.01.20.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 20:05:00 -0700 (PDT)
Message-ID: <979ff2ac-b634-46f9-2d75-e7774c164de6@bytedance.com>
Date:   Wed, 2 Aug 2023 11:04:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 0/5] mm: Select victim memcg using BPF_OOM_POLICY
To:     Michal Hocko <mhocko@suse.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com,
        robin.lu@bytedance.com, muchun.song@linux.dev,
        zhengqi.arch@bytedance.com
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
 <ZMInlGaW90Uw1hSo@dhcp22.suse.cz>
 <7347aad5-f25c-6b76-9db5-9f1be3a9f303@bytedance.com>
 <ZMKoAfGRgkl4rmtj@dhcp22.suse.cz>
 <eb764131-6d2f-c088-5481-99d605a67349@bytedance.com>
 <ZMe17kOoHr/eYnVT@dhcp22.suse.cz>
 <f8f44103-afba-10ee-b14b-a8e60a7f33d8@bytedance.com>
 <ZMi/7oWdrczvE8eU@dhcp22.suse.cz>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <ZMi/7oWdrczvE8eU@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,
在 2023/8/1 16:18, Michal Hocko 写道:
> On Tue 01-08-23 00:26:20, Chuyi Zhou wrote:
>>
>>
>> 在 2023/7/31 21:23, Michal Hocko 写道:
>>> On Mon 31-07-23 14:00:22, Chuyi Zhou wrote:
>>>> Hello, Michal
>>>>
>>>> 在 2023/7/28 01:23, Michal Hocko 写道:
>>> [...]
>>>>> This sounds like a very specific oom policy and that is fine. But the
>>>>> interface shouldn't be bound to any concepts like priorities let alone
>>>>> be bound to memcg based selection. Ideally the BPF program should get
>>>>> the oom_control as an input and either get a hook to kill process or if
>>>>> that is not possible then return an entity to kill (either process or
>>>>> set of processes).
>>>>
>>>> Here are two interfaces I can think of. I was wondering if you could give me
>>>> some feedback.
>>>>
>>>> 1. Add a new hook in select_bad_process(), we can attach it and return a set
>>>> of pids or cgroup_ids which are pre-selected by user-defined policy,
>>>> suggested by Roman. Then we could use oom_evaluate_task to find a final
>>>> victim among them. It's user-friendly and we can offload the OOM policy to
>>>> userspace.
>>>>
>>>> 2. Add a new hook in oom_evaluate_task() and return a point to override the
>>>> default oom_badness return-value. The simplest way to use this is to protect
>>>> certain processes by setting the minimum score.
>>>>
>>>> Of course if you have a better idea, please let me know.
>>>
>>> Hooking into oom_evaluate_task seems the least disruptive to the
>>> existing oom killer implementation. I would start by planing with that
>>> and see whether useful oom policies could be defined this way. I am not
>>> sure what is the best way to communicate user input so that a BPF prgram
>>> can consume it though. The interface should be generic enough that it
>>> doesn't really pre-define any specific class of policies. Maybe we can
>>> add something completely opaque to each memcg/task? Does BPF
>>> infrastructure allow anything like that already?
>>>
>>
>> “Maybe we can add something completely opaque to each memcg/task?”
>> Sorry, I don't understand what you mean.
> 
> What I meant to say is to add a very non-specific interface that would
> would a specific BPF program understand. Mostly an opaque value from the
> memcg POV.
> 
>> I think we probably don't need to expose too much to the user, the following
>> might be sufficient:
>>
>> noinline int bpf_get_score(struct oom_control *oc,
>> 		struct task_struct *task);
>>
>> static int oom_evaluate_task()
>> {
>> 	...
>> 	points = bpf_get_score(oc, task);
>> 	if (!check_points_valid(points))
>>           	points = oom_badness(task, oc->totalpages);
>> 	...
>> }
>>
>> There are several reasons:
>>
>> 1. The implementation of use-defined OOM policy, such as iteration, sorting
>> and other complex operations, is more suitable to be placed in the userspace
>> rather than in the bpf program. It is more convenient to implement these
>> operations in userspace in which the useful information (memory usage of
>> each task and memcg, memory allocation speed, etc.) can also be captured.
>> For example, oomd implements multiple policies[1] without kernel-space
>> input.
> 
> I do agree that userspace can handle a lot on its own and provide the
> input to the BPF program to make a decision.
> 
>> 2. Userspace apps, such as oomd, can import useful information into bpf
>> program, e.g., through bpf_map, and update it periodically. For example, we
>> can do the scoring directly in userspace and maintain a score hash, so that
>> in the bpf program, we only need to look for the corresponding score of the
>> process.
> 
> Sure, why not. But all that is an implementation detail. We are
> currently talkin about a proper abstraction and layering that would
> allow what you do currently but also much more.
> 
>> Userspace policy（oomd）
>>           bpf_map_update
>>           score_hash
>>        ------------------>  BPF program
>>                                look up score in
>>                                 score_hash
>>                              ---------------> kernel space
>> Just some thoughts.
> 
> I believe all the above should be possible if BPF program is hooked at
> the oom_evaluate_task layer and allow to bypass the default logic. BPF
> program can process whatever data it has available. The oom scope iteration
> will be implemented already in the kernel so all the BPF program has to
> do is to rank processes and/or memcgs if oom.group is enabled. Whould
> that work for your usecase?

Yes, I think the above interface can works well for our usecase.

In our scenario, we want to protect the application with higher priority 
and try to select lower priority as the victim.

Specifically, We can set priority for memcgs in userspace. In BPF 
program, we can find the memcg to which the given process belongs, and 
then rank according to the memcg's priority.

Thanks.
> 
>> Thanks!
>>
>> [1]https://github.com/facebookincubator/oomd/tree/main/src/oomd/plugins)
> 
