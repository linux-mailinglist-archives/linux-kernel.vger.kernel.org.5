Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458A375C6AE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjGUMNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjGUMNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:13:53 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48576172D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 05:13:50 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a44fae863fso1307761b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 05:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689941629; x=1690546429;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O6lZzBZR0nESZsW3RT6Hs6Z+8TjG0GqQroIcim/hPmY=;
        b=W7Ja06trKh+i6ZZKp9VV2ujf4Penm0uPyVgdQOJSb6bbvAYCxhpitgMCv8h5J/9awU
         oZGTsyBwA27001d5zvh2O1TrhfD9XLibgSNlx+FRrw3gFfbKKIKJk8bN1NMTaCKOfJK/
         S18hCza4MBUVDXNixmJnWWHFB5hTyhXLcmr8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689941629; x=1690546429;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O6lZzBZR0nESZsW3RT6Hs6Z+8TjG0GqQroIcim/hPmY=;
        b=lIb7pB0IXIPvtnkp7n+KwetoadN70LVtJefVHQVMPv7YA9dysgW0I7RUO4k3itLd3y
         SvTasSXaBcGchTmepVn0ZsrYw2X5PmQDHklJ3WOzkEKGVBllhxh51Ue/tFaf7bypjDER
         AT28RvTi9FNhrlJ1gCEXcw87FCnKiNZ+xFf5B4RKqhY3lSgFqWfgH/hhsDYYsIyoG1nu
         oYMBatIbfaI0dBgY0mB3Uiv8vg75kLQI61BFoXru/4/Yln/Gciu0Ijv1u/ZZWdbts6U3
         JZTgv8BDlUJcIx2MxoCsbk/e0R1Ky7QYPTK1pzYSwc8/vh7EeCyRwZfvP74tFWFr4I15
         aDYQ==
X-Gm-Message-State: ABy/qLa85de5ArEJQ7VPaIat7zPAobv6a4KKIw5Yu+SVamwyLI8eTZ1S
        ssv8NnNmqncUoUuYR4RhZjAuJQ==
X-Google-Smtp-Source: APBJJlGeMay14JuLLcAvgkwPE7mBmDQoDAGT5z7uJAL57avpO+0flaolpxfCZJq3c4+s0hEEZ4KvUg==
X-Received: by 2002:aca:f10:0:b0:3a1:d3f0:32ed with SMTP id 16-20020aca0f10000000b003a1d3f032edmr1824115oip.23.1689941629432;
        Fri, 21 Jul 2023 05:13:49 -0700 (PDT)
Received: from [192.168.0.140] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id s13-20020a0ce30d000000b0063601efba01sm1220517qvl.111.2023.07.21.05.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 05:13:47 -0700 (PDT)
Message-ID: <32aec6d1-bf25-7b47-8f31-7b6318d5238d@joelfernandes.org>
Date:   Fri, 21 Jul 2023 08:13:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [BUG] Re: Linux 6.4.4
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz, rcu@vger.kernel.org
References: <2023071940-suspect-ominous-4a6a@gregkh>
 <20230720132714.GA3726096@google.com>
 <2b8fc10b-785e-48b9-9a38-5c1af81f9578@paulmck-laptop>
 <CAEXW_YQO7OCdkXm_SBcPhAm8V8vMaF_5DQq7PbG9PZb7RFgA_g@mail.gmail.com>
 <f18e165c-9196-4b41-a202-82cfd5ac7f8b@paulmck-laptop>
 <8682b08c-347b-5547-60e0-013dcf1f8c93@joelfernandes.org>
 <eb04b7d0-2f49-4e01-be09-9062d9f08404@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <eb04b7d0-2f49-4e01-be09-9062d9f08404@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 15:47, Paul E. McKenney wrote:
> On Thu, Jul 20, 2023 at 03:32:35PM -0400, Joel Fernandes wrote:
>> On 7/20/23 15:04, Paul E. McKenney wrote:
>>> On Thu, Jul 20, 2023 at 12:31:13PM -0400, Joel Fernandes wrote:
>>>> Hi Paul,
>>>>
>>>> On Thu, Jul 20, 2023 at 11:55 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>>>>>
>>>>> On Thu, Jul 20, 2023 at 01:27:14PM +0000, Joel Fernandes wrote:
>> [...]
>>>>>>
>>>>>> So likely RCU boosting is failing:
>>>>>>
>>>>>> The full TREE03 splat:
>>>>>> [   54.243588] ------------[ cut here ]------------
>>>>>> [   54.244547] rcu-torture: rcu_torture_boost started
>> [...]
>>>>>> [   54.300499] RIP: 0010:rcu_torture_stats_print+0x5b2/0x620
>> [...]
>>>>>> [ 2169.481783] rcu_torture_writer: rtort_pipe_count: 9
>>>>>>
>>>>>> However, if we are to believe the '9', it appears the object did made it
>>>>>> quite some till the end of the pipe array but not until the free pool.
>>>>>
>>>>> This is from this if/for statement, correct?
>>>>>
>>>>>                   stutter_waited = stutter_wait("rcu_torture_writer");
>>>>>                   if (stutter_waited &&
>>>>>                       !atomic_read(&rcu_fwd_cb_nodelay) &&
>>>>>                       !cur_ops->slow_gps &&
>>>>>                       !torture_must_stop() &&
>>>>>                       boot_ended)
>>>>>                           for (i = 0; i < ARRAY_SIZE(rcu_tortures); i++)
>>>>>                                   if (list_empty(&rcu_tortures[i].rtort_free) &&
>>>>>                                       rcu_access_pointer(rcu_torture_current) !=
>>>>>                                       &rcu_tortures[i]) {
>>>>>                                           tracing_off();
>>>>>                                           show_rcu_gp_kthreads();
>>>>>                                           WARN(1, "%s: rtort_pipe_count:
>>>>>                                           rcu_ftrace_dump(DUMP_ALL);
>>>>>                                   }
>>>>
>>>> Yes, that's right.
>>>>
>>>>> If so, this happens when there was a stutter wait, but RCU grace
>>>>> periods failed to clear out the backlog during the several seconds that
>>>>> rcutorture was forced idle.  This might be related to the RCU priority
>>>>> boosting failure, in which a preempted reader persisted across the
>>>>> stutter interval.
>>>>
>>>> When RCU is operating normally, shouldn't the check
>>>> "(list_empty(&rcu_tortures[i].rtort_free)" not run until the preempted
>>>> reader unblocks and exits its RCU read-side critical section?
>>>
>>> Yes, but not just "until", but rather "long after".  If RCU is doing
>>> grace periods correctly, an active reader on a given rcu_tortures[]
>>> element will prevent .rtort_pipe_count from exceeding the value 2.
>>
>> Ah ok, so the rtort_pipe_count being 9 is a sign RCU isn't making progress
>> thus making it absent from the free list.
> 
> Yes, though RCU is -just- -barely- too slow, as one more grace period
> would have done it.
> 
>>> The element will not be put on a list until .rtort_pipe_count is equal
>>> to RCU_TORTURE_PIPE_LEN, which is 10.
>>>
>>> This warning usually appears when something is holding up the grace-period
>>> kthread.  Historically, this has included deadlocks, missed timers,
>>> and whatever else can prevent the grace-period kthread from running.
>>
>> Makes sense.
>>
>>>> One thing that confuses me, in the case of
>>>> "cur_ops->deferred_free(old_rp);" , the earlier do-while loop may exit
>>>> before the async callbacks can finish. So what prevents the
>>>> "(list_empty(&rcu_tortures[i].rtort_free)" check from happening before
>>>> grace periods happen? Thanks for any clarification.
>>>
>>> We only enter this code if the stutter_wait() actually waited, and by
>>> default this function will wait about five seconds.  Since the rcutorture
>>> testing goes idle during this time period (or is supposed to!), if things
>>> are working properly, knocking off ten grace periods during that time
>>> should be pretty much a given.
>>
>> Sure, makes sense. And this is not Lazy-RCU so 5 seconds should be plenty
>> ;). I think I was subconsciously expecting an rcu_barrier() somewhere in the
>> code before those checks, but that's not needed as you pointed that the
>> stutter should be giving enough time for RCU to make progress.
> 
> And there might need to be a call_rcu_hurry() in there somewhere,
> now that you mention it.  Which would pretty much defeat any sort of
> lazy-RCU-callback testing in rcutorture, but testing of laziness might
> need to be separate anyway.
> 
>> So hmm, the count being 9 means that not enough RCU grace periods have
>> passed for the rcu_torture object in question thus keeping it always
>> allocated. The GP thread not getting CPU can do that indeed, or perhaps
>> something else stalling RCU like a preempted reader, length preemption
>> disabling on a CPU and so forth..  I'll try to collect a trace when it
>> happens.
> 
> Looking forward to seeing what you come up with!

So far I found this. Before the crash, GPs took about 50ms, during the crash it 
took 5 seconds before the warning which aligns with what you mentioned about 
stutter.


The GP that never completed is at this line:

[ 2816.041082]    <...>-13       13d.... 1237016139us : rcu_grace_period: 
rcu_sched 144681 start

And fqs loop got a "dti" for CPUs:
1
2
12

And I see cpuqs for:
13
6
10
5
4
11

No idea what happened to 3, 8, 9, 14, 15. Maybe the "dti" for those did not show 
in the trace?

However, I see that CPU 7 did this:
[ 2816.205277]   <idle>-0         7d.... 1237016284us : sched_switch: 
prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==> 
next_comm=rcu_torture_rea next_pid=149 next_prio=139


and then did this about 3 seconds later:
[ 2819.394111] rcu_tort-149       7dNs.. 1237025699us : rcu_grace_period: 
rcu_sched 144677 cpuend
[ 2819.412745] rcu_tort-149       7dNs.. 1237025699us : rcu_grace_period: 
rcu_sched 144681 cpustart


Which means it never switched out from the CPU all this while. Neither did it 
report cpuqs. Ok it did notice the new GP started, welcome to the party mate ;)

That points the issue I think. I wonder if the emergency provisions for forcing 
quiescent states on NOHZ_FULL CPUs kicked in. ISTR, we had issues with that in 
the past where we had to fix the tick path to report a QS.

I'll add some more traces. Especially around preempted readers, the emergency 
provisions for forcing a QS and so forth and see if I can dig more information.

thanks,

  - Joel







