Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E1079A1E4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 05:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjIKDjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 23:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjIKDjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 23:39:15 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768BE11A
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 20:39:10 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-56b0c5a140dso3418717a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 20:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694403550; x=1695008350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSDiuoEyf4H9wlcY1A7sW5h4OjRoHXCgcFuntYkAxQo=;
        b=VY9gXSjf3XfgJPtVbZEHlvtAK2MRDLUyVyKlFTPbMnas9A2zA6cj1LvSsEQfyhiuz5
         ufeHvN5zDXoMSEJHFVdtxo7C3OywCZDs+RmSc0hP8UX7NqHmRnwW40tiru0b9V5ce1Sa
         0Tcr60sBuFR8SsiZEQh6pjfvPV2O8R0+F/nUWDdHJK083wkcIHZuFK8O6SQquF7JIC2P
         eJUY+TULuOHt5Ltka5wXRSFhOBr7rHCHlEI/UUENo+WuCIVmmW8doHzaRHtFeXahNaA7
         fymIBwm6IRPnUTJybJV4pTY1rg2DXs2mIf2aTqIV8qD30NGJsbJ4w1u4AW9F6Mug3O/U
         BK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694403550; x=1695008350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VSDiuoEyf4H9wlcY1A7sW5h4OjRoHXCgcFuntYkAxQo=;
        b=hkJAdYA3fgkzVCxPBARQmJVPF6Gghnbo+0Sy53bTCeXP4G3n4i5SKvToCM5Lc7xQfW
         xCJIccGMZUl/ZjpA62vO1CR5BOkK6BuofL+19tAiGOIZebRzLtIohYQ8lINeUAbe3zW2
         vP/gceKo4kSTa6yBHl2TzRVgq9UNWL2HB33wdu9Yg8uJAFMHTR1OPVR4dJZbbs2O29N6
         KKsFDMZDdza7nVnTBZz2O9hepiF18/4VI34EbFBsOe6nLAkzqaxIkkKeZ6yL67KH8lfO
         AKB53ClSQiSY2oa6QzlFshhMD0WuOZfYKY8Hb2HVvXCltda+mkJ/4DbN3qiTB8MqBtkD
         SWtg==
X-Gm-Message-State: AOJu0YxGaaFXZmTPr6FFsbZUkiq91REnCHwaK5hHluD2HLZGxNrQw7Fb
        ZGfhpNrxJpNMcNeY92G3CmQHlg==
X-Google-Smtp-Source: AGHT+IEPHu1RQPd+AzJSzc0vjmnap8kLG6UshpKDaQfgp3jlWDRvG1m+Z664/5om16e0Q9Qjy+ZwxQ==
X-Received: by 2002:a05:6a21:99a0:b0:152:efa4:21b with SMTP id ve32-20020a056a2199a000b00152efa4021bmr11453169pzb.5.1694403549942;
        Sun, 10 Sep 2023 20:39:09 -0700 (PDT)
Received: from [10.84.158.67] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902c11100b001b8a1a25e6asm5260158pli.128.2023.09.10.20.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 20:39:09 -0700 (PDT)
Message-ID: <a353150b-1382-9e76-e14f-4170c956b8ce@bytedance.com>
Date:   Mon, 11 Sep 2023 11:39:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [External] Re: [PATCH 0/2] Fix nohz_full vs rt bandwidth
To:     Phil Auld <pauld@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <20230821094927.51079-1-jiahao.os@bytedance.com>
 <1823b6fd-037f-38dc-2d33-0879d77768c3@bytedance.com>
 <20230907141703.GA441901@lorien.usersys.redhat.com>
 <bd786914-4718-7a35-fcc1-9cdee58d2f06@bytedance.com>
 <20230908124501.GA471894@lorien.usersys.redhat.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20230908124501.GA471894@lorien.usersys.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URI_HEX autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/8 Phil Auld wrote:
> On Fri, Sep 08, 2023 at 10:57:26AM +0800 Hao Jia wrote:
>>
>>
>> On 2023/9/7 Phil Auld wrote:
>>> Hi Hao,
>>>
>>> On Wed, Sep 06, 2023 at 02:45:39PM +0800 Hao Jia wrote:
>>>>
>>>> Friendly ping...
>>>>
>>>> On 2023/8/21 Hao Jia wrote:
>>>>> Since the commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop
>>>>> when cfs bandwidth in use") was merged, it handles conflicts between
>>>>> NOHZ full and cfs_bandwidth well, and the scheduler feature HZ_BW
>>>>> allows us to choose which one to prefer.
>>>>>
>>>>> This conflict also exists between NOHZ full and rt_bandwidth,
>>>>> these two patches try to handle it in a similar way.
>>>>>
>>>
>>> Are you actually hitting this in the real world?
>>>
>>> We, for example, no longer enable RT_GROUP_SCHED so this is a non-issue
>>> for our use cases.  I'd recommend considering that. (Does it even
>>> work with cgroup2?)
>>>
>>
>> Yes, it has always been there. Regardless of whether RT_GROUP_SCHED is
>> enabled or not, rt bandwidth is always enabled. If RT_GROUP_SCHED is not
>> enabled, all rt tasks in the system are a group, and rt_runtime is 950000,
>> and rt_period is 1000000.So rt bandwidth is always enabled by default.
> 
> Sure, there is that. But I think Daniel is actively trying to remove it.
> 

Thank you for your reply. Maybe I'm missing something. Can you give me 
some links to discussions about it?

> Also I'm not sure you answered my question. Are you actually hitting this
> in the real world?  I'd be tempted to think this is a mis-configuration or
> mis-use of RT.  Plus you can disable that throttling and use stalld to catch
> cases where the rt task goes out of control.
> 

 > Are you actually hitting this in the real world?

I tested on my machine using default settings (rt_runtime is 950000, and 
rt_period is 1000000.). The rt task is supposed to be throttled after 
running for 0.95 seconds, but due to the influence of NO_HZ_FULL, it may 
be throttled after running for about 1.4 seconds. This will only cause 
the rt_bandwidth throttle to be delayed, but no warning will be triggered.


 > Plus you can disable that throttling and use stalld to catch cases 
where the rt task goes out of control.

IIRC, if we disable rt_bandwidth. The rt task is always running, which 
may cause cfs task starvation and hung_task warnning. This may be the 
reason why rt_bandwidth is enabled by default (rt_runtime is 950000, and 
rt_period is 1000000).


Thanks,
Hao

> I'm not totally against doing this (for what my vote counts...), I just
> wonder if it's really needed. It seem it may be over-engineering something
> that is soon to be a non-problem.
> 
> 
> Cheers,
> Phil
> 
>>
>>
>> Thanks,
>> Hao
>>
>>> In some ways what you have is a simplification of code, but it also
>>> obfuscates the stop_tick conditions by hiding them all in the class
>>> specific functions.  It was easier to see why the tick didn't stop
>>> looking at the original code.
>>>
>>> It would be better to do this only if it is really needed, in my opinion.
>>>
>>>
>>> Cheers,
>>> Phil
>>>
>>>>> patch1: Extracts a can_stop_tick() callback function for each
>>>>> sched_class from sched_can_stop_tick(), it will make things clearer
>>>>> and also convenient to handle the conflict between NOHZ full
>>>>> and rt_bandwidth.
>>>>>
>>>>> patch2: If the HZ_BW scheduler feature is enabled, and the RT task
>>>>> to be run is constrained by rt_bandwidth runtime. Then it will
>>>>> prevent NO_HZ full from stopping tick.
>>>>>
>>>>> Hao Jia (2):
>>>>>      sched/core: Introduce sched_class::can_stop_tick()
>>>>>      sched/rt: Block nohz tick_stop when rt bandwidth in use
>>>>>
>>>>>     kernel/sched/core.c     | 67 +++++--------------------------
>>>>>     kernel/sched/deadline.c | 16 ++++++++
>>>>>     kernel/sched/fair.c     | 56 +++++++++++++++++++++++---
>>>>>     kernel/sched/rt.c       | 89 ++++++++++++++++++++++++++++++++++++++++-
>>>>>     kernel/sched/sched.h    |  5 ++-
>>>>>     5 files changed, 168 insertions(+), 65 deletions(-)
>>>>>
>>>>
>>>
>>
> 
