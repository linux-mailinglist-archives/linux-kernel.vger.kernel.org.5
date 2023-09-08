Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9A67980BD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 04:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjIHC6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 22:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjIHC6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 22:58:01 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3BF1BD9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 19:57:35 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c0c6d4d650so13393225ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 19:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694141855; x=1694746655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGXYOd+4VD7/VKRfHhJIqfEKHTSYIxZ3jQ6n0FGWK/M=;
        b=E5GTmOfzA1g0NK7vgD79RjnfiZJvVUnqh7dhHMmk8oC8GoNRtG/nqWzPw/WRgYfSw9
         Iwrz53+KFUDtzjBNIr1oxJU1V3MP8oqdSfi3cUa3J2CXCpye09MxGRyiXq00n3/Sk5c2
         d4wRHyK936HYnjfxZvSPG0E/0xaCvn19YOSQxIzR/C98U+4fR7LDkAqlD1HBnjuQZn+X
         GiRKYQidt6ZIXT2hyM0HbOZSG4pttks3Pc6fmO8pINwkAoJFUaV4BhSPgkQomHHOgKAy
         KVzGUbmlQYr9fIyTl15onljsIDDqI9Hv24pfmlN9wc7h/GHML3oseIm/v5iTDEy/IFdF
         qQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694141855; x=1694746655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nGXYOd+4VD7/VKRfHhJIqfEKHTSYIxZ3jQ6n0FGWK/M=;
        b=TjtOpTLyYCewjIXgvkYmLYaptyiUBc1CAhnDk9HzryM/t+VMKl/1p+/kuv6M5JwXR4
         mS6wQJxRGnXga1p53BZXgM3fpQbdWz4li3wtblIP7yT5XcRFL1mgmUC4PtQEQirV51kt
         Xdq6N8tGymYFjJyyKkE9rmEKCWRJ03emdtT0UcEdLP+LvdjqQSLL1jNv8xl1Wn2suIKS
         yLWxbB0rADw5x3spAzxZYer+2VpD2AqgNX40vWPUnEaiLLoUBtd5YOKYfg5zS8zRihZC
         LyprsXQd62z2JfEXIgA3+CyX0/cdJyKCqjZGzli4albLSzaDojTEzJiCpEh7CgDAAeYV
         RS+w==
X-Gm-Message-State: AOJu0Yzb2oye60bRnwfg2TWaCC5yoKUWxkpvlh7OWxgoWpVgtT0lJXR5
        IfxmPKAtrhiHZAJ31AqZcqG92w==
X-Google-Smtp-Source: AGHT+IF123epk4rTElmjn2HM6EuL8epwN9ATbzO9Fjvt8YuVV4g0MooJFsbeETrQ8AaTTcvbxkWHbg==
X-Received: by 2002:a17:902:c1c5:b0:1bd:c931:8c47 with SMTP id c5-20020a170902c1c500b001bdc9318c47mr1170738plc.68.1694141854780;
        Thu, 07 Sep 2023 19:57:34 -0700 (PDT)
Received: from [10.84.158.67] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id c3-20020a170903234300b001bb28b9a40dsm445051plh.11.2023.09.07.19.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 19:57:34 -0700 (PDT)
Message-ID: <bd786914-4718-7a35-fcc1-9cdee58d2f06@bytedance.com>
Date:   Fri, 8 Sep 2023 10:57:26 +0800
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
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20230907141703.GA441901@lorien.usersys.redhat.com>
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



On 2023/9/7 Phil Auld wrote:
> Hi Hao,
> 
> On Wed, Sep 06, 2023 at 02:45:39PM +0800 Hao Jia wrote:
>>
>> Friendly ping...
>>
>> On 2023/8/21 Hao Jia wrote:
>>> Since the commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop
>>> when cfs bandwidth in use") was merged, it handles conflicts between
>>> NOHZ full and cfs_bandwidth well, and the scheduler feature HZ_BW
>>> allows us to choose which one to prefer.
>>>
>>> This conflict also exists between NOHZ full and rt_bandwidth,
>>> these two patches try to handle it in a similar way.
>>>
> 
> Are you actually hitting this in the real world?
> 
> We, for example, no longer enable RT_GROUP_SCHED so this is a non-issue
> for our use cases.  I'd recommend considering that. (Does it even
> work with cgroup2?)
> 

Yes, it has always been there. Regardless of whether RT_GROUP_SCHED is 
enabled or not, rt bandwidth is always enabled. If RT_GROUP_SCHED is not 
enabled, all rt tasks in the system are a group, and rt_runtime is 
950000, and rt_period is 1000000.So rt bandwidth is always enabled by 
default.


Thanks,
Hao

> In some ways what you have is a simplification of code, but it also
> obfuscates the stop_tick conditions by hiding them all in the class
> specific functions.  It was easier to see why the tick didn't stop
> looking at the original code.
> 
> It would be better to do this only if it is really needed, in my opinion.
> 
> 
> Cheers,
> Phil
> 
>>> patch1: Extracts a can_stop_tick() callback function for each
>>> sched_class from sched_can_stop_tick(), it will make things clearer
>>> and also convenient to handle the conflict between NOHZ full
>>> and rt_bandwidth.
>>>
>>> patch2: If the HZ_BW scheduler feature is enabled, and the RT task
>>> to be run is constrained by rt_bandwidth runtime. Then it will
>>> prevent NO_HZ full from stopping tick.
>>>
>>> Hao Jia (2):
>>>     sched/core: Introduce sched_class::can_stop_tick()
>>>     sched/rt: Block nohz tick_stop when rt bandwidth in use
>>>
>>>    kernel/sched/core.c     | 67 +++++--------------------------
>>>    kernel/sched/deadline.c | 16 ++++++++
>>>    kernel/sched/fair.c     | 56 +++++++++++++++++++++++---
>>>    kernel/sched/rt.c       | 89 ++++++++++++++++++++++++++++++++++++++++-
>>>    kernel/sched/sched.h    |  5 ++-
>>>    5 files changed, 168 insertions(+), 65 deletions(-)
>>>
>>
> 
