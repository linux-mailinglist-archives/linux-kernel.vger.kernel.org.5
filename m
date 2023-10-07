Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765BA7BC635
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 10:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbjJGIpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 04:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjJGIpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 04:45:38 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3B2C2
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 01:45:17 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68bed2c786eso2430534b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 01:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696668316; x=1697273116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjEIdcMd2bwl56wpPfCDxf7bRtsXXq4LqtFmktrOmpw=;
        b=Oh4MAwuVRcECyfW9/cVwDrpEK7YscOiaj+j9MSMJpCpKAYA2T7BUttUtcbFtF3Qs1r
         U5pWRyB1RWYnI7MWw419iuJgj4PaOoKFm5E0dCYTsOIBG8wilboPF3Ac5jmxdOh5c5ZD
         31ERW4xFixzbrmvYg9IlP/sWcFAY36/dktAG8ETZFSzBCtD8dOAghxDyMTEiffJS1Upc
         uB6MusSKUS+3NuVA54fkNaNbZdn6OnMBFxIWZnyT44FWS8Ks2/01CUc4RzhRzCdQj3mA
         QN7L5A4WdvYa3i8rjlcbtCyOvfJXjF07o/mhzySOS2c7C7Fz3AuwRt6GlTuXuQGDHhMh
         cGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696668316; x=1697273116;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HjEIdcMd2bwl56wpPfCDxf7bRtsXXq4LqtFmktrOmpw=;
        b=jwZ2NPZ6cu7gGEW/SP6l7Mx21cLhm/ihXQy39XDuaiJ8szcUMule+IybIwRFFHmG4C
         M0R9a5JnTIIkX/JLrl0GazzghQPVkN4d5ilAugvyX/EmAan29/1kha+Si0STvUN10K+x
         yhht529xCiD0cDmq+tIwRBd4lv8KAWB7XMrBxOZ4xuecA10VXf0KBMLb7fp1oFN83WRh
         3boU0RY7ViE0VEqonV9vB7WmMqT4YNF8OGQUa6yDHxH/1dDbo/9lGMegvBpxu+YA6ycy
         vmBCk4YLUDLCBktc7uviPGcJVqBWumzQp4GcZlTxW9Ut1H2q5UBlwTBi8tVQ4EPXK6mC
         ejTA==
X-Gm-Message-State: AOJu0Yx/0JuTwJ/qBJ54fguICpxLkICEW46p4eCKZvn/sfWahgFrbhmW
        W5BLDlcfk4zjFS801zrCvYDWKA==
X-Google-Smtp-Source: AGHT+IELzFD80MsCdpoPd4xNLtr4RYWUMXqM/l0IsIVJDwE0h9Sl3ZFnlxqmi2wtK3JlaClwb4HoCA==
X-Received: by 2002:a05:6a20:32aa:b0:15e:10e:2cc3 with SMTP id g42-20020a056a2032aa00b0015e010e2cc3mr7923625pzd.60.1696668316539;
        Sat, 07 Oct 2023 01:45:16 -0700 (PDT)
Received: from [10.84.141.140] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id iz2-20020a170902ef8200b001c71ec1866fsm5330326plb.258.2023.10.07.01.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Oct 2023 01:45:16 -0700 (PDT)
Message-ID: <979f948c-7611-b137-a06a-ca09ff63f919@bytedance.com>
Date:   Sat, 7 Oct 2023 16:44:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [External] Re: [PATCH] sched/core: Fix wrong warning check in
 rq_clock_start_loop_update()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Igor Raits <igor.raits@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <20230913082424.73252-1-jiahao.os@bytedance.com>
 <20230928114159.GJ9829@noisy.programming.kicks-ass.net>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20230928114159.GJ9829@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/28 Peter Zijlstra wrote:
> On Wed, Sep 13, 2023 at 04:24:24PM +0800, Hao Jia wrote:
>> Igor Raits and Bagas Sanjaya report a RQCF_ACT_SKIP leak warning.
>> Link: https://lore.kernel.org/all/a5dd536d-041a-2ce9-f4b7-64d8d85c86dc@gmail.com
>>
>> Commit ebb83d84e49b54 ("sched/core: Avoid multiple
>> calling update_rq_clock() in __cfsb_csd_unthrottle()")
>> add RQCF_ACT_SKIP leak warning in rq_clock_start_loop_update().
>> But this warning is inaccurate and may be triggered
>> incorrectly in the following situations:
>>
>>      CPU0                                      CPU1
>>
>> __schedule()
>>    *rq->clock_update_flags <<= 1;*   unregister_fair_sched_group()
>>    pick_next_task_fair+0x4a/0x410      destroy_cfs_bandwidth()
>>      newidle_balance+0x115/0x3e0       for_each_possible_cpu(i) *i=0*
>>        rq_unpin_lock(this_rq, rf)      __cfsb_csd_unthrottle()
> 	  if (rq->clock_update_flags > RQCF_ACT_SKIP)
> 	    rf->clock_update_flags = RQCF_UPDATED;
> 
> so that preserves all flags, but only stores UPDATED.
> 
>>        raw_spin_rq_unlock(this_rq)
>>                                        rq_lock(*CPU0_rq*, &rf)
> 					  rq_pin_lock()
> 					    rq->clock_update_flags &= (REQ_SKIP|ACT_SKIP);
> 					    rf->clock_update_flags = 0;
> 
> 				IOW, we preserve ACT_SKIP from CPU0
> 
>>                                        rq_clock_start_loop_update()
>>                                        rq->clock_update_flags & RQCF_ACT_SKIP <--
> 
> 				And go SPLAT
> 
>>
>>        raw_spin_rq_lock(this_rq)
> 	rq_repin_lock()
> 	  rq->clock_update_flags |= rf->clock_update_flags;
> 
> which restores UPDATED, even though in reality time could have moved on
> quite significantly.
> 
> 
> Anyway....
> 
> the purpose of ACT_SKIP is to skip the update (clue in name etc), but
> the update is very early in __schedule(), but we clear *_SKIP very late,
> causing it to span that gap above.
> 
> Going by the commits that put it there, the thinking was to clear
> clock_skip_update before unlock, but AFAICT we can clear SKIP flags
> right after the update_rq_clock() we're wanting to skip, no?
>

Thanks for your review, and I am very sorry to reply to you so late. I 
just came back from a long vacation.


> That is, would not something like the below make more sense?

If we understand correctly, this may not work.

After applying this patch, the following situation will trigger the 
rq->clock_update_flags < RQCF_ACT_SKIP warning.

If rq_clock_skip_update() is called before __schedule(), so 
RQCF_REQ_SKIP of rq->clock_update_flags is set.




__schedule() {
	rq_lock(rq, &rf); [rq->clock_update_flags is RQCF_REQ_SKIP]
	rq->clock_update_flags <<= 1;
	update_rq_clock(rq); [rq->clock_update_flags is RQCF_ACT_SKIP]
+ 	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
	* At this time, rq->clock_update_flags = 0; *

          pick_next_task_fair
          set_next_entity
          update_load_avg
          	assert_clock_updated() <---
}


assert_clock_updated() will determine whether rq->clock_update_flags is 
less than RQCF_ACT_SKIP. If we clear RQCF_ACT_SKIP prematurely, this 
assert may be triggered later.

> 
> ---
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d8fd29d66b24..bfd2ab4b95da 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5357,8 +5357,6 @@ context_switch(struct rq *rq, struct task_struct *prev,
>   	/* switch_mm_cid() requires the memory barriers above. */
>   	switch_mm_cid(rq, prev, next);
>   
> -	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
> -
>   	prepare_lock_switch(rq, next, rf);
>   
>   	/* Here we just switch the register state and the stack. */
> @@ -6596,6 +6594,8 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>   	/* Promote REQ to ACT */
>   	rq->clock_update_flags <<= 1;
>   	update_rq_clock(rq);
> +	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
> +
>   
>   	switch_count = &prev->nivcsw;
>   
> @@ -6675,8 +6675,6 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>   		/* Also unlocks the rq: */
>   		rq = context_switch(rq, prev, next, &rf);
>   	} else {
> -		rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
> -
>   		rq_unpin_lock(rq, &rf);
>   		__balance_callbacks(rq);
>   		raw_spin_rq_unlock_irq(rq);
