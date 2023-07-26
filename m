Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9B6763DD6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjGZRk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGZRk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:40:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592DF2685
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 10:40:55 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QH8ZPV014113;
        Wed, 26 Jul 2023 17:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vcRZS3Tl1dAKT94mo83qn0Hs1M+8Yo+RBYj3OuLnTGM=;
 b=s6c6k7vEOo5cRxl3pE9SUMdZG3LyXCrOy2OW+YL+0ggfHig2Qw+v/Ehhj6tUHO2uwO1Z
 i8dEiRtE+4d0Gz4ILRDYYCu7RGs2hARrM7vXzJw9qrY7XugLvGUlw1CAZ1Xkv6JbnHzf
 E1Yc2bC7oZ+kCm7wB0idUZ+uXvh5ZaPfszZHzsiUZUq/qiffaVUcndFs2c42Her3ree3
 bWRNzAFqhjxp/OZp33V78r9NoMT5N9CQmM3Eh28WV1pGewskb2dfqCcNVTu1WaAPxpNJ
 WYx3dQBeMGU5d7ofStthc5dLgad/NxvpLhSSldpK0wf2q9LgED8t6ThMWl1foRrAwOef cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s37c59asj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 17:40:25 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36QH8qDj014554;
        Wed, 26 Jul 2023 17:40:22 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s37c59akj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 17:40:22 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36QFugPR001981;
        Wed, 26 Jul 2023 17:40:18 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0ten6qfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 17:40:18 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36QHeHbn38404388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 17:40:17 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EFB458062;
        Wed, 26 Jul 2023 17:40:17 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A182F5805E;
        Wed, 26 Jul 2023 17:40:11 +0000 (GMT)
Received: from [9.179.1.92] (unknown [9.179.1.92])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jul 2023 17:40:11 +0000 (GMT)
Message-ID: <cab82676-27fd-b4e1-2cd8-3d8d26b44aa0@linux.vnet.ibm.com>
Date:   Wed, 26 Jul 2023 23:10:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 1/1] sched: Extend cpu idle state for 1ms
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20230725193048.124796-1-mathieu.desnoyers@efficios.com>
 <69076f8e-191b-2e3e-d810-ea72d8ff18bb@linux.vnet.ibm.com>
 <79fa8a62-a74e-2623-9f03-1f1af85b6c07@efficios.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <79fa8a62-a74e-2623-9f03-1f1af85b6c07@efficios.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0XicqMeQW6wBLUmwoalwyWF6ec725XHq
X-Proofpoint-GUID: emIr2Q0e9FQXKvlJk_ifdlUoi0wMcoR_
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260157
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/23 7:37 PM, Mathieu Desnoyers wrote:
> On 7/26/23 04:04, Shrikanth Hegde wrote:
>>
>>
>> On 7/26/23 1:00 AM, Mathieu Desnoyers wrote:
>>> Allow select_task_rq to consider a cpu as idle for 1ms after that cpu
>>> has exited the idle loop.
>>>
>>> This speeds up the following hackbench workload on a 192 cores AMD EPYC
>>> 9654 96-Core Processor (over 2 sockets):
>>>
>>> hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100
>>>
>>> from 49s to 34s. (30% speedup)
>>>
>>> My working hypothesis for why this helps is: queuing more than a single
>>> task on the runqueue of a cpu which just exited idle rather than
>>> spreading work over other idle cpus helps power efficiency on systems
>>> with large number of cores.
>>>
>>> This was developed as part of the investigation into a weird regression
>>> reported by AMD where adding a raw spinlock in the scheduler context
>>> switch accelerated hackbench.

Do you have SMT here? What is the system utilization when you are running 
this workload?

>>>
>>> It turned out that changing this raw spinlock for a loop of 10000x
>>> cpu_relax within do_idle() had similar benefits.
>>>
>>> This patch achieve a similar effect without the busy-waiting by
>>> introducing a runqueue state sampling the sched_clock() when exiting
>>> idle, which allows select_task_rq to consider "as idle" a cpu which has
>>> recently exited idle.
>>>
>>> This patch should be considered "food for thoughts", and I would be glad
>>> to hear feedback on whether it causes regressions on _other_ workloads,
>>> and whether it helps with the hackbench workload on large Intel system
>>> as well.
>>>
>>> Link:
>>> https://lore.kernel.org/r/09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com
>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Valentin Schneider <vschneid@redhat.com>
>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>> Cc: Ben Segall <bsegall@google.com>
>>> Cc: Mel Gorman <mgorman@suse.de>
>>> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
>>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>>> Cc: Juri Lelli <juri.lelli@redhat.com>
>>> Cc: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
>>> Cc: Aaron Lu <aaron.lu@intel.com>
>>> Cc: x86@kernel.org
>>> ---
>>>   kernel/sched/core.c  | 4 ++++
>>>   kernel/sched/sched.h | 3 +++
>>>   2 files changed, 7 insertions(+)
>>>
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index a68d1276bab0..d40e3a0a5ced 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -6769,6 +6769,7 @@ void __sched schedule_idle(void)
>>>        * TASK_RUNNING state.
>>>        */
>>>       WARN_ON_ONCE(current->__state);
>>> +    WRITE_ONCE(this_rq()->idle_end_time, sched_clock());
>>>       do {
>>>           __schedule(SM_NONE);
>>>       } while (need_resched());
>>> @@ -7300,6 +7301,9 @@ int idle_cpu(int cpu)
>>>   {
>>>       struct rq *rq = cpu_rq(cpu);
>>>   +    if (sched_clock() < READ_ONCE(rq->idle_end_time) +
>>> IDLE_CPU_DELAY_NS)
>>
>>
>> Wouldn't this hurt the latency badly? Specially on a loaded system with
>> a workload that does a lot of wakeup.
> 
> Good point !
> 
> Can you try your benchmark replacing the if () statement above by:
> 
> +       if (sched_clock() < READ_ONCE(rq->idle_end_time) +
> IDLE_CPU_DELAY_NS &&
> +           READ_ONCE(rq->nr_running) <= 4)
> +               return 1;


Tried with this change. I think it does help in reducing latency compared to 
earlier specially till 95th percentile.  

                                                                                
                6.5-rc3      6.5-rc3+RFC_Patch     6.5-rc3_RFC_Patch            
                                                     + nr<4                     
4 Groups                                                                        
50.0th:          18.00                18.50           18.50                     
75.0th:          21.50                26.00           23.50                     
90.0th:          56.00                940.50          501.00                    
95.0th:          678.00               1896.00         1392.00                   
99.0th:          2484.00              3756.00         3708.00                   
99.5th:          3224.00              4616.00         5088.00                   
99.9th:          4960.00              6824.00         8068.00                   
8 Groups                                                                        
50.0th:          23.50                25.50           23.00                     
75.0th:          30.50                421.50          30.50                     
90.0th:          443.50               1722.00         741.00                    
95.0th:          1410.00              2736.00         1670.00                   
99.0th:          3942.00              5496.00         4032.00                   
99.5th:          5232.00              7016.00         5064.00                   
99.9th:          7996.00              8896.00         8012.00                   
16 Groups                                                                       
50.0th:          33.50                41.50           32.50                     
75.0th:          49.00                752.00          47.00                     
90.0th:          1067.50              2332.00         994.50                    
95.0th:          2093.00              3468.00         2117.00                   
99.0th:          5048.00              6728.00         5568.00                   
99.5th:          6760.00              7624.00         6960.00                   
99.9th:          8592.00              9504.00         11104.00                  
32 Groups                                                                       
50.0th:          60.00                79.00           53.00                     
75.0th:          456.50               1712.00         209.50                    
90.0th:          2788.00              3996.00         2752.00                   
95.0th:          4544.00              5768.00         5024.00                   
99.0th:          8444.00              9104.00         10352.00                  
99.5th:          9168.00              9808.00         12720.00                  
99.9th:          11984.00             12448.00        17624.00   

> 
> It speeds up the hackbench test-case even more here. It's now 30s, and
> it should
> improve tail latency.
> 
> Thanks,
> 
> Mathieu
> 
> 
>>
>> ran schbench on a 50% loaded system with stress-ng. (there could be a
>> better benchmark to measure latency)
>> I see that latency takes a hit. specially tail latencies.full log
>> below with different schbench groups.
>>
>>              6.5-rc3        6.5-rc3+this patch
>>
>> Groups: 1
>> 50.0th:                 14.0              13.0
>> 75.0th:                 16.0              16.0
>> 90.0th:                 19.5              20.0
>> 95.0th:                 53.0              226.0
>> 99.0th:                 1969.0            2165.0
>> 99.5th:                 2912.0            2648.0
>> 99.9th:                 4680.0            4142.0
>>
>> Groups: 2
>> 50.0th:                 15.5              15.5
>> 75.0th:                 18.0              19.5
>> 90.0th:                 25.5              497.0
>> 95.0th:                 323.0             1384.0
>> 99.0th:                 2055.0            3144.0
>> 99.5th:                 2972.0            4014.0
>> 99.9th:                 6026.0            6560.0
>>
>> Groups: 4
>> 50.0th:                 18.0              18.5
>> 75.0th:                 21.5              26.0
>> 90.0th:                 56.0              940.5
>> 95.0th:                 678.0             1896.0
>> 99.0th:                 2484.0            3756.0
>> 99.5th:                 3224.0            4616.0
>> 99.9th:                 4960.0            6824.0
>>
>> Groups: 8
>> 50.0th:                 23.5              25.5
>> 75.0th:                 30.5              421.5
>> 90.0th:                 443.5             1722.0
>> 95.0th:                 1410.0            2736.0
>> 99.0th:                 3942.0            5496.0
>> 99.5th:                 5232.0            7016.0
>> 99.9th:                 7996.0            8896.0
>>
>> Groups: 16
>> 50.0th:                 33.5              41.5
>> 75.0th:                 49.0              752.0
>> 90.0th:                 1067.5            2332.0
>> 95.0th:                 2093.0            3468.0
>> 99.0th:                 5048.0            6728.0
>> 99.5th:                 6760.0            7624.0
>> 99.9th:                 8592.0            9504.0
>>
>> Groups: 32
>> 50.0th:                 60.0              79.0
>> 75.0th:                 456.5             1712.0
>> 90.0th:                 2788.0            3996.0
>> 95.0th:                 4544.0            5768.0
>> 99.0th:                 8444.0            9104.0
>> 99.5th:                 9168.0            9808.0
>> 99.9th:                 11984.0           12448.0
>>
>>
>>> +        return 1;
>>> +
>>>       if (rq->curr != rq->idle)
>>>           return 0;
>>>   diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>>> index 81ac605b9cd5..8932e198a33a 100644
>>> --- a/kernel/sched/sched.h
>>> +++ b/kernel/sched/sched.h
>>> @@ -97,6 +97,8 @@
>>>   # define SCHED_WARN_ON(x)      ({ (void)(x), 0; })
>>>   #endif
>>>   +#define IDLE_CPU_DELAY_NS    1000000        /* 1ms */
>>> +
>>>   struct rq;
>>>   struct cpuidle_state;
>>>   @@ -1010,6 +1012,7 @@ struct rq {
>>>         struct task_struct __rcu    *curr;
>>>       struct task_struct    *idle;
>>> +    u64            idle_end_time;

There is clock_idle already in the rq. Can that be used for the same?

>>>       struct task_struct    *stop;
>>>       unsigned long        next_balance;
>>>       struct mm_struct    *prev_mm;
> 
