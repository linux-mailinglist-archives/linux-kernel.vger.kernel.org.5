Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBD579C441
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbjILDgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjILDgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:36:48 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD343AECE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:35:54 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1a1fa977667so4016877fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694486154; x=1695090954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6Wm4jZscKSrkPbEBPDnG/Psa1ZBN+p5zt/H0rAg1yI=;
        b=Vt7JDzzu1kmdiEOHUj64FUHSY61WARWhElHUqiZY3/vLqNDrzAZyuNRtCVuupy7clK
         X734nN3gwtHc13pYx3Fv+CRadDS2JFKB15DuMWt5HGk3PTqBckyMo5H2v8XcvVbXnM65
         W5mi0cPG9z1ZBpHDPLqJfuflKyODD6vFIO4ARXjaCi9cW4fi3FTADRQPob9d1S47cRWZ
         85CQD5Rql9go8aRiFl2Hsm6Fpg7iBhaMdz7MqQwFqMHGf9MyA6ynJxefGSUiaZSjflqc
         SqVq5Hn5g+VKZCcnoBQOEG5kF5+0BP+kC9UOCF8RRVJjVOi13zmQm4cDg/sv+hoyx0Sq
         cJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694486154; x=1695090954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x6Wm4jZscKSrkPbEBPDnG/Psa1ZBN+p5zt/H0rAg1yI=;
        b=aPlo3X3EWeLTHvVkasC/BFZAWnNhgBu568bI7FKlKBMY5RjnyxgzPli7LWjzdgE6pR
         AAD2yDdMVTTeVsaA4plsnItK7NwiCP06TCQcWYcfqrS0i6SjW8Nc1bmRQWuwtqjz/fBA
         f0VO3OAW5mxEIH2962dbOG8x4ss1ZXDKMtoVmfuei7lKQoj3SdTlh1x1ED9KD72qIbOi
         rWm8bhmgDdBk+Si7Z0+/o6iw2ay2tajFtMO7lKtCZUMqUMYW51h2f6ProNOaMnhXoRJC
         Mx1jxJRKKagb7Qk4M/+NCBBmC2xE85kqoyL5mx2yVxReO7P4aXxjC8cpQbBvbVugIiY3
         Wjyw==
X-Gm-Message-State: AOJu0YwwBzytsfZcfZYpNZM6IDbiw72Zq3txroNvAxpX+sTvAjiE2cch
        H7FH57n4zbZ2J7d8FyVPfHgscw==
X-Google-Smtp-Source: AGHT+IFjT4QqqBnyWwOMSpvEYIMDw0sfBrf906195GIquBYtGCVgI7duqwloX2XG/u8mGCntGBOJRQ==
X-Received: by 2002:a05:6870:75ca:b0:1d5:8fa5:e33e with SMTP id de10-20020a05687075ca00b001d58fa5e33emr9450989oab.32.1694486153855;
        Mon, 11 Sep 2023 19:35:53 -0700 (PDT)
Received: from [10.84.158.67] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id u1-20020a637901000000b005777a911342sm1945828pgc.59.2023.09.11.19.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 19:35:53 -0700 (PDT)
Message-ID: <9581428d-13ba-114c-7594-c2357a8ccf11@bytedance.com>
Date:   Tue, 12 Sep 2023 10:35:46 +0800
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
 <a353150b-1382-9e76-e14f-4170c956b8ce@bytedance.com>
 <20230911132535.GA24480@lorien.usersys.redhat.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20230911132535.GA24480@lorien.usersys.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/11 Phil Auld wrote:
> 
> Hi Hao,
> 
> On Mon, Sep 11, 2023 at 11:39:02AM +0800 Hao Jia wrote:
>> On 2023/9/8 Phil Auld wrote:
>>> On Fri, Sep 08, 2023 at 10:57:26AM +0800 Hao Jia wrote:
>>>> On 2023/9/7 Phil Auld wrote:
>>>>> Hi Hao,
> 
> ...
> 
>>>>>
>>>>> Are you actually hitting this in the real world?
>>>>>
>>>>> We, for example, no longer enable RT_GROUP_SCHED so this is a non-issue
>>>>> for our use cases.  I'd recommend considering that. (Does it even
>>>>> work with cgroup2?)
>>>>>
>>>>
>>>> Yes, it has always been there. Regardless of whether RT_GROUP_SCHED is
>>>> enabled or not, rt bandwidth is always enabled. If RT_GROUP_SCHED is not
>>>> enabled, all rt tasks in the system are a group, and rt_runtime is 950000,
>>>> and rt_period is 1000000.So rt bandwidth is always enabled by default.
>>>
>>> Sure, there is that. But I think Daniel is actively trying to remove it.
>>>
>>
>> Thank you for your reply. Maybe I'm missing something. Can you give me some
>> links to discussions about it?
>>
> 
> Sure, try this one:
>        https://lore.kernel.org/lkml/cover.1693510979.git.bristot@kernel.org/
> 

Thanks for the information you shared.

> 
>>> Also I'm not sure you answered my question. Are you actually hitting this
>>> in the real world?  I'd be tempted to think this is a mis-configuration or
>>> mis-use of RT.  Plus you can disable that throttling and use stalld to catch
>>> cases where the rt task goes out of control.
>>>
>>
>>> Are you actually hitting this in the real world?
>>
>> I tested on my machine using default settings (rt_runtime is 950000, and
>> rt_period is 1000000.). The rt task is supposed to be throttled after
>> running for 0.95 seconds, but due to the influence of NO_HZ_FULL, it may be
>> throttled after running for about 1.4 seconds. This will only cause the
>> rt_bandwidth throttle to be delayed, but no warning will be triggered.
> 
> Yes, you can hit this in testing.  I'm asking if it's causing your real-world
> applicaton issues or is this just a theoretical problem you can contrive a
> test for?  Are you actually hitting this when running your workload?
>  From what you are showing (a test setup) I'm guessing no.
> 

Yes, I don't see this issue in our production environment. The number of 
rt tasks is very small in our production environment, and their running 
time is very short, so the rt_bandwidth throttle will not be triggered 
unless the rt task goes out of control.

Thanks,
Hao

>>
>>
>>> Plus you can disable that throttling and use stalld to catch cases where
>> the rt task goes out of control.
>>
>> IIRC, if we disable rt_bandwidth. The rt task is always running, which may
>> cause cfs task starvation and hung_task warnning. This may be the reason why
>> rt_bandwidth is enabled by default (rt_runtime is 950000, and rt_period is
>> 1000000).
> 
> That's what stalld is for.  Some rt applications don't like giving up 5% of
> the cpu time when they don't really need to.
> 
> 
> Cheers,
> Phil
> 
> 
