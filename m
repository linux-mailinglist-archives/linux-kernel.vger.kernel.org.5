Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE937B31C8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 13:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjI2L4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 07:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2L4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 07:56:38 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2BE193
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 04:56:36 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c5bf7871dcso113900885ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 04:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1695988596; x=1696593396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KCDwTuOHUzfyy6M2ox7/ZjT3TpJHZ7cY4TTkfYkpO0=;
        b=Ezt/hSgmEh3GBuFMOpvES3UUfh+fw0L7kr/UJxOLXP5xwZpsaJG+L1/OYZX13tz6y8
         FASpAudhihMxcvme1jsHXqpocGvBN09/9pPUzoBkLNAvy2a3HP0a+e3MB5u/SGmtXhlm
         8D87s+FDp/JYaxvwbydcV6mqAO7oYr7nuMINoK0Io48uCULfdimAIGrIYECzeclmCUVv
         U21htIlgSmxApcCJNnjfys685u0ybOIGrWHEPAnAWKzacPqsNhVIYMle6WhlakVg9lsZ
         xvsOLV8/al06Fugjbm/swbsyT/8G6tD8UC/oKcw7/mszV6OCz+MaFTY/i/SssXrJ8ewA
         NSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695988596; x=1696593396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5KCDwTuOHUzfyy6M2ox7/ZjT3TpJHZ7cY4TTkfYkpO0=;
        b=LrE2ggcAGnMTjG/bHP+3A7WxJBd1P2/w/gC6/36DeEA0g+maFxi5DuCq3DRaotFmQP
         eGEJ+is+Ter/zJPlUFuDXTpE261BHNhg4DayRJf+D3ltxOYVKaNhCjinnbwx/JndiwIq
         8w3VOihlKw8fW3DxP0SN4PorUFtpwM8ooqhVyW1cMYaCZFcfE2fOp3GT/RbGQbKV1SVo
         zHWrky4417bDSiWBUWZkd/8Kmi2Qs7jWRnH6bTSq1Sf4ivoDKGgJNNDowpsXKZyTEd+J
         g1i3JYgTzZ68w9JSLkZGZ4Dxe9UmgGzbAtcZbNyfAjLwnRVDvIQrww146H+mzQEQ0SQK
         6emQ==
X-Gm-Message-State: AOJu0YwlLjJOIgZvMOo1NxZodjjFd2xuHzAG43VA//aEYTw0uRmlwJUP
        BnMNR2EH++3Z8y/pECwu173t5A==
X-Google-Smtp-Source: AGHT+IHBcvL4Au2r8yXLtDN7ubmqMPruA5wViEqFxazTOmZ91bDr06FMOQ3hCi8hnmZtHbuvTjZWUA==
X-Received: by 2002:a17:902:9b8e:b0:1c5:cc30:7329 with SMTP id y14-20020a1709029b8e00b001c5cc307329mr3397890plp.54.1695988596090;
        Fri, 29 Sep 2023 04:56:36 -0700 (PDT)
Received: from [10.12.164.14] ([103.114.192.135])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001a5fccab02dsm1103039plq.177.2023.09.29.04.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 04:56:35 -0700 (PDT)
Message-ID: <67d55d76-a619-7b05-0e6c-1a097f702bbb@shopee.com>
Date:   Fri, 29 Sep 2023 19:56:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] sched: Filter root_task_group at the beginning
To:     Ingo Molnar <mingo@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <20230922094336.394865-1-haifeng.xu@shopee.com>
 <ZRXqFScg/vORHoqw@gmail.com>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ZRXqFScg/vORHoqw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/29 05:03, Ingo Molnar wrote:
> 
> * Haifeng Xu <haifeng.xu@shopee.com> wrote:
> 
>> We can't change the weight of the root cgroup. Let's handle
>> root_task_group before doing any real work including acquiring
>> the shares_mutex.
>>
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> ---
>>  kernel/sched/fair.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index a80a73909dc2..1ac2df87e070 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -12594,6 +12594,9 @@ int sched_group_set_shares(struct task_group *tg, unsigned long shares)
>>  {
>>  	int ret;
>>  
>> +	if (tg == &root_task_group)
>> +		return -EINVAL;
>> +
>>  	mutex_lock(&shares_mutex);
>>  	if (tg_is_idle(tg))
>>  		ret = -EINVAL;
> 
> So what's the motivation, how common is this case? 

It's not common.

The users of __sched_group_set_shares() are sched_group_set_idle() and sched_group_set_shares().
So I want to follow the way in sched_group_set_idle(). If so, we can remove the redundant checks in
__sched_group_set_shares() because all users have filtered the root_task_group.

> 
> Normally this should be a -EINVAL error code path, which sane user-space
> presumably never conscisously tries to call in that fashion, right?

Yes.

> 
> It's not worth optimizing pathological cases, especially
> since we check for the root CG inside __sched_group_set_shares()
> already:
> 
>         /*
>          * We can't change the weight of the root cgroup.
>          */
>         if (!tg->se[0])
>                 return -EINVAL;
> 
> 
> Thanks,
> 
> 	Ingo
