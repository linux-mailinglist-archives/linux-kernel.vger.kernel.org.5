Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90909769CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjGaQeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGaQee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:34:34 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2B5C6;
        Mon, 31 Jul 2023 09:34:33 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-785d738d3feso110332239f.0;
        Mon, 31 Jul 2023 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690821273; x=1691426073;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dAEMBSQfh0Wj3GHX9rkxyOMoPLFpw2ZLVzN+GGjXmgk=;
        b=lfM7TrHRVU9hMIwZOguF6zTId6bXcfJKxM5pfaxTcZ5vEpBDh3icVdPm4jPtkCz6FE
         Zv5GKn8ZpLU1uGyCdVXwclmSvOe7cptLq2m0oQfI6doOoLTS+nThcukV3+1AutX280N7
         nd/5+Z99yPz5WZUe0w0j9CIsCwpMlW5JBLFVq5eIL0Nr+nXUZm4AS4/4AKRP4eUfOpPD
         uAjIKM2s5qSdFnNRszqd5AD1RpjSFXjKbcxknJ7+wulwcteUqRSS89Zrbgem0RxacQu2
         +M+DWhAJrF9w4jcp3c+qlg6EFZsaz6Y4m0SLBfuZO4jDZEUzpF4aLhnGIuTtPhaRbF7+
         LUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690821273; x=1691426073;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAEMBSQfh0Wj3GHX9rkxyOMoPLFpw2ZLVzN+GGjXmgk=;
        b=T3BxKOckZUSqLHSTBrHd4GBhsKCraDjSOes/psZ45TItPeJVElizqVtXmFTg5o9d66
         ktE77BvhThdkZRNZYQk8rgUnmfnRtPyAzpWzzcHPVu+mxiE+Nbo5QqSuSjg34nUTy/8c
         GylL1wXU9zo5qqmbePl4PGWRQ9ZzJk/3LmlRrJqrI+K4sNxBhFlVhiS2s/Y21BbSdxZO
         V5AzY8Uvpde+gAMPJdz4DTudTbeWzMF0xdvf/OVJ2VDDAWGpp1v5D4jMQZIrUA5yQSIA
         F3xD3E/80DAS23qJDH6AAovCnImOME6po1md+1zDy3BrbiSCOtQkRvxYAXZN+CEiJqyB
         gG7Q==
X-Gm-Message-State: ABy/qLbiYcwGgkBW1l4jLcKWMmqz6lJHZOZyZEz8yRkKLh856TtRNFTf
        Md03fEoE3a5L7l8PUD79uNc=
X-Google-Smtp-Source: APBJJlFuPPAidsaiPDhLjwSLJp6YGl+iUYJPwg3g/mNyK6XgDn+08pir013z1AHZyJ2/8Bj36bQvsw==
X-Received: by 2002:a05:6602:4891:b0:783:42bc:cc5f with SMTP id ee17-20020a056602489100b0078342bccc5fmr8824943iob.8.1690821273008;
        Mon, 31 Jul 2023 09:34:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h3-20020a02c723000000b0041fb2506011sm3107838jao.172.2023.07.31.09.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 09:34:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <baa58a8e-54f0-2309-b34e-d62999a452a1@roeck-us.net>
Date:   Mon, 31 Jul 2023 09:34:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: scheduler problems in -next (was: Re: [PATCH 6.4 000/227]
 6.4.7-rc1 review)
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Roy Hopkins <rhopkins@suse.de>
Cc:     Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
References: <2cfc68cc-3a2f-4350-a711-ef0c0d8385fd@paulmck-laptop>
 <D56D0318-A2EA-4448-8F4D-BE84706E26A5@joelfernandes.org>
 <3da81a5c-700b-8e21-1bde-27dd3a0b8945@roeck-us.net>
 <20230731141934.GK29590@hirez.programming.kicks-ass.net>
 <20230731143954.GB37820@hirez.programming.kicks-ass.net>
 <f5a18aa3-9db7-6ad2-33d5-3335a18e4e2f@roeck-us.net>
 <20230731145232.GM29590@hirez.programming.kicks-ass.net>
 <7ff2a2393d78275b14ff867f3af902b5d4b93ea2.camel@suse.de>
 <20230731161452.GA40850@hirez.programming.kicks-ass.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230731161452.GA40850@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/23 09:14, Peter Zijlstra wrote:
> On Mon, Jul 31, 2023 at 05:08:29PM +0100, Roy Hopkins wrote:
>> On Mon, 2023-07-31 at 16:52 +0200, Peter Zijlstra wrote:
>>> On Mon, Jul 31, 2023 at 07:48:19AM -0700, Guenter Roeck wrote:
>>>
>>>>> I've taken your config above, and the rootfs.ext2 and run-sh from x86/.
>>>>> I've then modified run-sh to use:
>>>>>
>>>>>     qemu-system-x86_64 -enable-kvm -cpu host
>>>>>
>>>>> What I'm seeing is that some boots get stuck at:
>>>>>
>>>>> [    0.608230] Running RCU-tasks wait API self tests
>>>>>
>>>>> Is this the right 'problem' ?
>>>>>
>>>>
>>>>
>>>> Yes, exactly.
>>>
>>> Excellent! Let me prod that with something sharp, see what comes
>>> creeping out.
>>
>> In an effort to get up to speed with this area of the kernel, I've been playing
>> around with this too today and managed to reproduce the problem using the same
>> configuration. I'm completely new to this code but I think I may have found the
>> root of the problem.
>>
>> What I've found is that there is a race condition between starting the RCU tasks
>> grace-period thread in rcu_spawn_tasks_kthread_generic() and a subsequent call
>> to synchronize_rcu_tasks_generic(). This results in rtp->tasks_gp_mutex being
>> locked in the initial thread which subsequently blocks the newly started grace-
>> period thread.
>>
>> The problem is that although synchronize_rcu_tasks_generic() checks to see if
>> the grace-period kthread is running, it uses rtp->kthread_ptr to achieve this.
>> This is only set in the thread entry point and not when the thread is created,
>> meaning that it is set only after the creating thread yields or is preempted. If
>> this has not happened before the next call to synchronize_rcu_tasks_generic()
>> then a deadlock occurs.
>>
>> I've created a debug patch that introduces a new flag in rcu_tasks that is set
>> when the kthread is created and used this in synchronize_rcu_tasks_generic() in
>> place of READ_ONCE(rtp->kthread_ptr). This fixes the issue in my test
>> environment.
>>
>> I'm happy to have a go at submitting a patch for this if it helps.
> 
> Ha!, I was poking around the same thing. My hack below seems to (so far,
> <20 boots) help things.
> 

So, dumb question:
How comes this bisects to "sched/fair: Remove sched_feat(START_DEBIT)" ?

Thanks,
Guenter

> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 56c470a489c8..b083b5a30025 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -652,7 +658,11 @@ static void __init rcu_spawn_tasks_kthread_generic(struct rcu_tasks *rtp)
>   	t = kthread_run(rcu_tasks_kthread, rtp, "%s_kthread", rtp->kname);
>   	if (WARN_ONCE(IS_ERR(t), "%s: Could not start %s grace-period kthread, OOM is now expected behavior\n", __func__, rtp->name))
>   		return;
> -	smp_mb(); /* Ensure others see full kthread. */
> +	for (;;) {
> +		cond_resched();
> +		if (smp_load_acquire(&rtp->kthread_ptr))
> +			break;
> +	}
>   }
>   
>   #ifndef CONFIG_TINY_RCU

