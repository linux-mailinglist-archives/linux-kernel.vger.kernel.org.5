Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA8175DC93
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 14:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjGVMiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 08:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVMiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 08:38:07 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B493810F5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 05:38:05 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7683cdabd8fso218585085a.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 05:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690029485; x=1690634285;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V2juWSz6t/8p6tXecBiY3aft3meJRr24apRAI1wBlKc=;
        b=Yjk/R9WVmfNIOu8DkRnngunjRPklAjUbjQmeDP2I6x//lXl4qY/pnBfyoNCbI74tLY
         vEx5ntjMj2WNLlNuOfOiZEiGLUagbRHgsCPcMUaZbKs0xtAxF2HD+JLu3eV7xL5Smcln
         elWKVrw5bpd7HYE/tvQz8PmvvaVCMlMAfWbLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690029485; x=1690634285;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2juWSz6t/8p6tXecBiY3aft3meJRr24apRAI1wBlKc=;
        b=HILo2iy416r7IjmMgWMzSa6Px4KQr1Bxk2L5LZIpi52NEaMXVHkFXMCMWmG+nklcmV
         b7jPdMNglbruHTzduF/EtLgqZwOmzBBtXdpweP9YCa2WeJbZ+3JfwhfHm1XJVvkeTbTc
         JjiS1y3NoG/JuNMBODhHSTZJ+0ihnajxCCd+A/A2VJznq9eq1YYSrksPm/+E/55sc0Pr
         qsjwQ9gBWv2vOOEdumh3AmJArpwHPOXs/5hc7aP5nB5hSm7hgs3Nci25o4dHO/c8pGwb
         cBZih8u1Y/IAtyzE2xG1ZnkLEyz0f9RO9rJ2/Q2CKj/3rXfPQaSeUeCsA9BSgnviBj7L
         Wq8w==
X-Gm-Message-State: ABy/qLYPn1D5VoMZXVNWU5dX4RGLP1VrYvNlrzajA0EgHvx1uCHCEFZ2
        XmPKnpYMS5VI57mwUs03+vRiSw==
X-Google-Smtp-Source: APBJJlGw2/IwLcoVXjm4BA02re31AQ+ZWXJzV3EcwA5Je+mXcfKPUhBVSEFg2k2Cjl00OIeC52Iiyw==
X-Received: by 2002:a05:620a:e9b:b0:767:100e:4cbd with SMTP id w27-20020a05620a0e9b00b00767100e4cbdmr2407817qkm.0.1690029484629;
        Sat, 22 Jul 2023 05:38:04 -0700 (PDT)
Received: from [192.168.0.198] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id s17-20020a05620a031100b00767f5c70b3dsm1789432qkm.96.2023.07.22.05.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 05:38:03 -0700 (PDT)
Message-ID: <7bfde9f4-2bd6-7337-b9ca-94a9253d847f@joelfernandes.org>
Date:   Sat, 22 Jul 2023 08:38:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [BUG] Re: Linux 6.4.4
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        rcu@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
References: <2023071940-suspect-ominous-4a6a@gregkh>
 <20230720132714.GA3726096@google.com>
 <2b8fc10b-785e-48b9-9a38-5c1af81f9578@paulmck-laptop>
 <CAEXW_YQO7OCdkXm_SBcPhAm8V8vMaF_5DQq7PbG9PZb7RFgA_g@mail.gmail.com>
 <f18e165c-9196-4b41-a202-82cfd5ac7f8b@paulmck-laptop>
 <8682b08c-347b-5547-60e0-013dcf1f8c93@joelfernandes.org>
 <eb04b7d0-2f49-4e01-be09-9062d9f08404@paulmck-laptop>
 <32aec6d1-bf25-7b47-8f31-7b6318d5238d@joelfernandes.org>
 <9b42cb38-8375-fc41-475a-2bd26c60a7b9@joelfernandes.org>
 <5dcf7117-cec7-4772-8aad-e100484a84dc@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <5dcf7117-cec7-4772-8aad-e100484a84dc@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/23 18:08, Paul E. McKenney wrote:
> On Fri, Jul 21, 2023 at 03:20:48PM -0400, Joel Fernandes wrote:
>> (Trimming the CC list a bit)
>> On 7/21/23 08:13, Joel Fernandes wrote:
>>> On 7/20/23 15:47, Paul E. McKenney wrote:
>>>> On Thu, Jul 20, 2023 at 03:32:35PM -0400, Joel Fernandes wrote:
>>>>> On 7/20/23 15:04, Paul E. McKenney wrote:
>>>>>> On Thu, Jul 20, 2023 at 12:31:13PM -0400, Joel Fernandes wrote:
>>>>>>> Hi Paul,
>>>>>>>
>>>>>>> On Thu, Jul 20, 2023 at 11:55 AM Paul E. McKenney
>>>>>>> <paulmck@kernel.org> wrote:
>>>>>>>>
>>>>>>>> On Thu, Jul 20, 2023 at 01:27:14PM +0000, Joel Fernandes wrote:
>>>>> [...]
>>>>>>>>>
>>>>>>>>> So likely RCU boosting is failing:
>>>>>>>>>
>>>>>>>>> The full TREE03 splat:
>>>>>>>>> [   54.243588] ------------[ cut here ]------------
>>>>>>>>> [   54.244547] rcu-torture: rcu_torture_boost started
>>>>> [...]
>>>>>>>>> [   54.300499] RIP: 0010:rcu_torture_stats_print+0x5b2/0x620
>>>>> [...]
>>>>>>>>> [ 2169.481783] rcu_torture_writer: rtort_pipe_count: 9
>>>>>>>>>
>>>>>>>>> However, if we are to believe the '9', it appears the object did
>>>>>>>>> made it
>>>>>>>>> quite some till the end of the pipe array but not until the free
>>>>>>>>> pool.
>>>>>>>>
>>>>>>>> This is from this if/for statement, correct?
>>>>>>>>
>>>>>>>>                   stutter_waited =
>>>>>>>> stutter_wait("rcu_torture_writer");
>>>>>>>>                   if (stutter_waited &&
>>>>>>>>                       !atomic_read(&rcu_fwd_cb_nodelay) &&
>>>>>>>>                       !cur_ops->slow_gps &&
>>>>>>>>                       !torture_must_stop() &&
>>>>>>>>                       boot_ended)
>>>>>>>>                           for (i = 0; i <
>>>>>>>> ARRAY_SIZE(rcu_tortures); i++)
>>>>>>>>                                   if
>>>>>>>> (list_empty(&rcu_tortures[i].rtort_free) &&
>>>>>>>>                                      
>>>>>>>> rcu_access_pointer(rcu_torture_current) !=
>>>>>>>>                                       &rcu_tortures[i]) {
>>>>>>>>                                           tracing_off();
>>>>>>>>                                           show_rcu_gp_kthreads();
>>>>>>>>                                           WARN(1, "%s:
>>>>>>>> rtort_pipe_count:
>>>>>>>>                                           rcu_ftrace_dump(DUMP_ALL);
>>>>>>>>                                   }
>>>>>>>
>>>>>>> Yes, that's right.
>>>>>>>
>>>>>>>> If so, this happens when there was a stutter wait, but RCU grace
>>>>>>>> periods failed to clear out the backlog during the several seconds
>>>>>>>> that
>>>>>>>> rcutorture was forced idle.  This might be related to the RCU
>>>>>>>> priority
>>>>>>>> boosting failure, in which a preempted reader persisted across the
>>>>>>>> stutter interval.
>>>>>>>
>>>>>>> When RCU is operating normally, shouldn't the check
>>>>>>> "(list_empty(&rcu_tortures[i].rtort_free)" not run until the preempted
>>>>>>> reader unblocks and exits its RCU read-side critical section?
>>>>>>
>>>>>> Yes, but not just "until", but rather "long after".  If RCU is doing
>>>>>> grace periods correctly, an active reader on a given rcu_tortures[]
>>>>>> element will prevent .rtort_pipe_count from exceeding the value 2.
>>>>>
>>>>> Ah ok, so the rtort_pipe_count being 9 is a sign RCU isn't making
>>>>> progress
>>>>> thus making it absent from the free list.
>>>>
>>>> Yes, though RCU is -just- -barely- too slow, as one more grace period
>>>> would have done it.
>>>>
>>>>>> The element will not be put on a list until .rtort_pipe_count is equal
>>>>>> to RCU_TORTURE_PIPE_LEN, which is 10.
>>>>>>
>>>>>> This warning usually appears when something is holding up the
>>>>>> grace-period
>>>>>> kthread.  Historically, this has included deadlocks, missed timers,
>>>>>> and whatever else can prevent the grace-period kthread from running.
>>>>>
>>>>> Makes sense.
>>>>>
>>>>>>> One thing that confuses me, in the case of
>>>>>>> "cur_ops->deferred_free(old_rp);" , the earlier do-while loop may exit
>>>>>>> before the async callbacks can finish. So what prevents the
>>>>>>> "(list_empty(&rcu_tortures[i].rtort_free)" check from happening before
>>>>>>> grace periods happen? Thanks for any clarification.
>>>>>>
>>>>>> We only enter this code if the stutter_wait() actually waited, and by
>>>>>> default this function will wait about five seconds.  Since the
>>>>>> rcutorture
>>>>>> testing goes idle during this time period (or is supposed to!), if
>>>>>> things
>>>>>> are working properly, knocking off ten grace periods during that time
>>>>>> should be pretty much a given.
>>>>>
>>>>> Sure, makes sense. And this is not Lazy-RCU so 5 seconds should be
>>>>> plenty
>>>>> ;). I think I was subconsciously expecting an rcu_barrier() somewhere
>>>>> in the
>>>>> code before those checks, but that's not needed as you pointed that the
>>>>> stutter should be giving enough time for RCU to make progress.
>>>>
>>>> And there might need to be a call_rcu_hurry() in there somewhere,
>>>> now that you mention it.  Which would pretty much defeat any sort of
>>>> lazy-RCU-callback testing in rcutorture, but testing of laziness might
>>>> need to be separate anyway.
>>>>
>>>>> So hmm, the count being 9 means that not enough RCU grace periods have
>>>>> passed for the rcu_torture object in question thus keeping it always
>>>>> allocated. The GP thread not getting CPU can do that indeed, or perhaps
>>>>> something else stalling RCU like a preempted reader, length preemption
>>>>> disabling on a CPU and so forth..  I'll try to collect a trace when it
>>>>> happens.
>>>>
>>>> Looking forward to seeing what you come up with!
>>>
>>> So far I found this. Before the crash, GPs took about 50ms, during the
>>> crash it took 5 seconds before the warning which aligns with what you
>>> mentioned about stutter.
>>>
>>>
>>> The GP that never completed is at this line:
>>>
>>> [ 2816.041082]    <...>-13       13d.... 1237016139us :
>>> rcu_grace_period: rcu_sched 144681 start
>>>
>>> And fqs loop got a "dti" for CPUs:
>>> 1
>>> 2
>>> 12
>>>
>>> And I see cpuqs for:
>>> 13
>>> 6
>>> 10
>>> 5
>>> 4
>>> 11
>>>
>>> No idea what happened to 3, 8, 9, 14, 15. Maybe the "dti" for those did
>>> not show in the trace?
>>>
>>> However, I see that CPU 7 did this:
>>> [ 2816.205277]   <idle>-0         7d.... 1237016284us : sched_switch:
>>> prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==>
>>> next_comm=rcu_torture_rea next_pid=149 next_prio=139
>>>
>>>
>>> and then did this about 3 seconds later:
>>> [ 2819.394111] rcu_tort-149       7dNs.. 1237025699us :
>>> rcu_grace_period: rcu_sched 144677 cpuend
>>> [ 2819.412745] rcu_tort-149       7dNs.. 1237025699us :
>>> rcu_grace_period: rcu_sched 144681 cpustart
>>>
>>>
>>> Which means it never switched out from the CPU all this while. Neither
>>> did it report cpuqs. Ok it did notice the new GP started, welcome to the
>>> party mate ;)
>>>
>>> That points the issue I think. I wonder if the emergency provisions for
>>> forcing quiescent states on NOHZ_FULL CPUs kicked in. ISTR, we had
>>> issues with that in the past where we had to fix the tick path to report
>>> a QS.
>>>
>>> I'll add some more traces. Especially around preempted readers, the
>>> emergency provisions for forcing a QS and so forth and see if I can dig
>>> more information.
>>
>> In another instance, I caught a stack trace of CPU5 when it did not
>> check-in with RCU for 3 seconds or so:
>>
>> [ 1127.067889]  kmalloc_trace+0x25/0x90
>> [ 1127.072823]  rcu_torture_fwd_prog+0x3d8/0xa60
>> [ 1127.078749]  ? __pfx_rcu_torture_fwd_prog+0x10/0x10
>> [ 1127.085468]  ? kthread+0xcb/0xf0
>> [ 1127.090040]  ? __pfx_rcu_torture_fwd_prog+0x10/0x10
>> [ 1127.096626]  kthread+0xcb/0xf0
>> [ 1127.100803]  ? __pfx_kthread+0x10/0x10
>> [ 1127.107207]  ret_from_fork+0x2c/0x50
>> [ 1127.113662]  </TASK>
>> [ 1127.117818] Kernel panic - not syncing: kernel: panic_on_warn set ...
>>
>> It appears it was in "rcu_torture_fwd_prog" at the time. It got stuck
>> there for 2 seconds.
>>
>> Interestingly, I did find the scheduler tick was trying to get in touch
>> with the CPU and it was running code on it even:
>> [ 5858.463102] rcu_tort-174       5d.h.. 1131149320us : rcu_utilization:
>> Start scheduler-tick
>> [ 5858.472903] rcu_tort-174       5d.h.. 1131149320us : rcu_utilization:
>> End scheduler-tick
>>
>> So I could add some traces there to figure out what is it upto. ISTR, we
>> also send IPIs to these CPUs? So maybe adding some traces there too is
>> in order.
>>
>> Also earlier in dmesg it did this:
>> [ 1124.825504] rcu_torture_fwd_prog n_max_cbs: 44181
>> [ 1124.832158] rcu_torture_fwd_prog: Starting forward-progress test 0
>> [ 1124.840977] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
>> [ 1126.726621] ------------[ cut here ]------------
>> [ 1126.733296] rcutorture_oom_notify invoked upon OOM during
>> forward-progress testing.
>>
>> Before that "cut here", there is a 2 second gap which tells me it got
>> stuck there.
>>
>> So this function rcu_torture_fwd_prog() is keeping the CPU unresponsive
>> from an RCU perspective for some reason? Because I never saw the
>> "rcu_torture_fwd_prog_cr: Waiting for CBs" message before it panicked.
> 
> Thank you for digging into this!
> 
> Yes, rcu_torture_fwd_prog() is supposed to monopolize CPUs.  But it
> is supposed to respect stuttering.  It is quite possible that the
> synchronization is insufficient.  Or that the "supposed to" never
> made it into the code.
> 
>> Collecting traces again.. ;) thanks,
> 
> ;-) ;-) ;-)

I narrowed it down to the timer softirq taking too long and doing this
for 4 seconds:

[ 6781.411834] ksoftirq-12        0dNs.. 206231531us : sched_wakeup:
comm=rcu_torture_rea pid=153 prio=139 target_cpu=000
[ 6781.424854] ksoftirq-12        0dNs.. 206231531us : sched_waking:
comm=rcu_torture_rea pid=164 prio=139 target_cpu=006
[ 6781.437650] ksoftirq-12        0dNs.. 206231533us : sched_wakeup:
comm=rcu_torture_rea pid=164 prio=139 target_cpu=000
[ 6781.451019] ksoftirq-12        0dNs.. 206231533us : sched_waking:
comm=rcu_torture_rea pid=162 prio=139 target_cpu=002
[ 6781.463825] ksoftirq-12        0dNs.. 206231535us : sched_wakeup:
comm=rcu_torture_rea pid=162 prio=139 target_cpu=000
[ 6781.476290] ksoftirq-12        0dNs.. 206231535us : sched_waking:
comm=rcu_torture_wri pid=143 prio=139 target_cpu=004
[ 6781.489257] ksoftirq-12        0dNs.. 206231537us : sched_wakeup:
comm=rcu_torture_wri pid=143 prio=139 target_cpu=000
[ 6781.502559] ksoftirq-12        0dNs.. 206231538us : sched_waking:
comm=rcu_torture_rea pid=154 prio=139 target_cpu=006
[ 6781.515093] ksoftirq-12        0dNs.. 206231539us : sched_wakeup:
comm=rcu_torture_rea pid=154 prio=139 target_cpu=000
[ 6781.527622] ksoftirq-12        0dNs.. 206231539us : sched_waking:
comm=rcu_torture_fak pid=149 prio=139 target_cpu=003
[ 6781.539979] ksoftirq-12        0dNs.. 206231541us : sched_wakeup:
comm=rcu_torture_fak pid=149 prio=139 target_cpu=000
[ 6781.552717] ksoftirq-12        0dNs.. 206231541us : sched_waking:
comm=rcu_torture_fak pid=145 prio=139 target_cpu=005
[ 6781.565074] ksoftirq-12        0dNs.. 206231543us : sched_wakeup:
comm=rcu_torture_fak pid=145 prio=139 target_cpu=000
[ 6781.577580] ksoftirq-12        0dNs.. 206231543us : sched_waking:
comm=rcu_torture_rea pid=166 prio=139 target_cpu=003
[ 6781.590211] ksoftirq-12        0dNs.. 206231547us : sched_wakeup:
comm=rcu_torture_rea pid=166 prio=139 target_cpu=000

And I caught the softirq exit which told me it is coming from timer softirq:
[ 6781.603150] ksoftirq-12        0.Ns.. 206231552us : __do_softirq:
softirq exit: name: TIMER, action handler: run_timer_softirq

Maybe something to do with calls to stuttering or lack of cond_resched()
in the torture code somewhere? Unfortunately I was not able to get a
stack trace and what is doing the wake ups.

This is at least one of the issues. I do believe the fwd prog functions
taking too long in the kernel without doing a cond_resched() is another
issue but I need to reduce the RCU stall timeout to 2 seconds to see
those happen otherwise I think those just get "hidden".

Both these issues appear to be threads spending too much time in kernel
mode in non-preemptible kernels. The RCU GP thread was able to get CPU
so that wasn't the issue in these instances.

Thoughts?

Next plan of action is to get sched_waking stack traces since I have a
very reliable repro of this now.

thanks,

 - Joel
