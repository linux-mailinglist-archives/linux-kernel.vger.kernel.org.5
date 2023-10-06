Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405517BC012
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjJFUL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbjJFUL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:11:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F5AF1
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:11:23 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396K7vYc026154;
        Fri, 6 Oct 2023 20:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+EJ7WW20UevSPCmPe/DOe8cb6G/VGjZFecsdNOHKnGY=;
 b=TH8uBH5hTFJaJtXmgQCwjTd8a2ESOZQJlIWE7s/e2aZVEdU15QJq+TVMWpuK52LsITcs
 Lc3NjgwHm9tt1w2x5g6pVsxtPkzPD3172PY0vbpMoM7WFN9as0ZeANNXcQRNHKrPNNtv
 AjWQTvIIS0YgQcLAyvca8TpBg8x/X9eclpS2oaARh3bXMkwAJGDv5t+MId6x68wdZN6t
 in7vn/uE7fatfawQOytqXMUxWiyAR48U/I5YbFWHdQxUAuZD6NjsaQwqkkchjBzmAC/b
 ydtzq1/ux4fpjOxj4hat+d4P1iXlrrqb1t9x93yiiHa41bPJZ6MKixtce7FpbG6NWt8p YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tjs0dr328-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 20:11:04 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 396K9Du0000370;
        Fri, 6 Oct 2023 20:11:03 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tjs0dr31m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 20:11:03 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 396Jr9ur007467;
        Fri, 6 Oct 2023 20:11:02 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3teygn5yt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 20:11:02 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 396KB1YZ58524082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Oct 2023 20:11:01 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9093A58056;
        Fri,  6 Oct 2023 20:11:01 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EE2D5806C;
        Fri,  6 Oct 2023 20:10:55 +0000 (GMT)
Received: from [9.179.25.10] (unknown [9.179.25.10])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  6 Oct 2023 20:10:55 +0000 (GMT)
Message-ID: <7e4cb3ee-50e3-b17e-62ee-c5fd4d438271@linux.vnet.ibm.com>
Date:   Sat, 7 Oct 2023 01:40:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC] sched/fair: Avoid unnecessary IPIs for ILB
Content-Language: en-US
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Hsin Yi <hsinyi@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        shrikanth hegde <sshegde@linux.vnet.ibm.com>
References: <20231005161727.1855004-1-joel@joelfernandes.org>
 <98d06022-accd-a1df-7608-dcd6689b44ec@linux.vnet.ibm.com>
In-Reply-To: <98d06022-accd-a1df-7608-dcd6689b44ec@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iU8QBgd-3J2Uhhp09uBPX8huLe7nofq2
X-Proofpoint-GUID: VgUp78v6xQvK7IaowEvCE9Jx8yVFOSjq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_15,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060154
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/7/23 12:48 AM, Shrikanth Hegde wrote:
> 
> 
> On 10/5/23 9:47 PM, Joel Fernandes (Google) wrote:
>> From: Vineeth Pillai <vineethrp@google.com>
>>
>> Whenever a CPU stops its tick, it now requires another idle CPU to handle the
>> balancing for it because it can't perform its own periodic load balancing.
>> This means it might need to update 'nohz.next_balance' to 'rq->next_balance' if
>> the upcoming nohz-idle load balancing is too distant in the future. This update
>> process is done by triggering an ILB, as the general ILB handler
>> (_nohz_idle_balance) that manages regular nohz balancing also refreshes
>> 'nohz.next_balance' by looking at the 'rq->next_balance' of all other idle CPUs
>> and selecting the smallest value.
>>
>> Triggering this ILB can be achieved by setting the NOHZ_NEXT_KICK flag. This
>> primarily results in the ILB handler updating 'nohz.next_balance' while
>> possibly not doing any load balancing at all. However, sending an IPI merely to
>> refresh 'nohz.next_balance' seems excessive, and there ought to be a more
>> efficient method to update 'nohz.next_balance' from the local CPU.
>>
>> Fortunately, there already exists a mechanism to directly invoke the ILB
>> handler (_nohz_idle_balance) without initiating an IPI. It's accomplished by
>> setting the NOHZ_NEWILB_KICK flag. This flag is set during regular "newly idle"
>> balancing and solely exists to update a CPU's blocked load if it couldn't pull
>> more tasks during regular "newly idle balancing" - and it does so without
>> having to send any IPIs. Once the flag is set, the ILB handler is called
>> directly from do_idle()-> nohz_run_idle_balance(). While its goal is to update
>> the blocked load without an IPI, in our situation, we aim to refresh
>> 'nohz.next_balance' without an IPI but we can piggy back on this.
>>
>> So in this patch, we reuse this mechanism by also setting the NOHZ_NEXT_KICK to
>> indicate nohz.next_balance needs an update via this direct call shortcut. Note
>> that we set this flag without knowledge that the tick is about to be stopped,
>> because at the point we do it, we have no way of knowing that. However we do
>> know that the CPU is about to enter idle. In our testing, the reduction in IPIs
>> is well worth updating nohz.next_balance a few more times.
>>
>> Also just to note, without this patch we observe the following pattern:
>>
>> 1. A CPU is about to stop its tick.
>> 2. It sets nohz.needs_update to 1.
>> 3. It then stops its tick and goes idle.
>> 4. The scheduler tick on another CPU checks this flag and decides an ILB kick is needed.
>> 5. The ILB CPU ends up being the one that just stopped its tick!
>> 6. This results in an IPI to the tick-stopped CPU which ends up waking it up
>>    and disturbing it!
>>
>> Testing shows a considerable reduction in IPIs when doing this:
>>
>> Running "cyclictest -i 100 -d 100 --latency=1000 -t -m" on a 4vcpu VM
>> the IPI call count profiled over 10s period is as follows:
>> without fix: ~10500
>> with fix: ~1000
>>
>> Fixes: 7fd7a9e0caba ("sched/fair: Trigger nohz.next_balance updates when a CPU goes NOHZ-idle")
>>
>> [ Joel: wrote commit messages, collaborated on fix, helped reproduce issue etc. ]
> 
> Hi Joel/Vineeth. 
> 
> Its an interesting patch. 
> 
> Gave this patch a try on powerpc system with 96 CPU. (12 cores SMT8)
> Was debugging an issue where ILB count goes up significantly at a specific 
> busy CPU count. Haven't yet found out why. Its WIP. Was curious if this patch 
> would address that issue. 
> 
> cloned rt-test repo and ran same cyclictest command and collected 
> softirq's count using bcc tool. That count remains same more or less with patch. 
> Is what I am checking incorrect? Any other way to check IPI count?
> 
>         base 6.6_rc4    +patch
> 
> block       31.00        48.86
> net_rx     475.90       348.90
> timer     2213.20      2405.00
> rcu      33057.30     34738.10
> sched   175904.70    169695.60
> 

Ah, there is hardirq which shows IPI count. Didnt think of it. 
This is average of 10 runs where hardirq was collected at 10s while running cyclictest.
This shows nice improvement. in base6.6 there were few instance where
number of IPI was much high.

	base 6.6_rc4    +patch
IPI-1        2741.1       1382.3


> 
>>
>> Cc: Suleiman Souhlal <suleiman@google.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Hsin Yi <hsinyi@google.com>
>> Cc: Frederic Weisbecker <frederic@kernel.org>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Signed-off-by: Vineeth Pillai <vineethrp@google.com>
>> Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> ---
>>  kernel/sched/fair.c | 21 ++++++++++++++-------
>>  1 file changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index cb225921bbca..2ece55f32782 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -11786,13 +11786,12 @@ void nohz_balance_enter_idle(int cpu)
>>  	/*
>>  	 * Ensures that if nohz_idle_balance() fails to observe our
>>  	 * @idle_cpus_mask store, it must observe the @has_blocked
>> -	 * and @needs_update stores.
>> +	 * stores.
>>  	 */
>>  	smp_mb__after_atomic();
>>  
>>  	set_cpu_sd_state_idle(cpu);
>>  
>> -	WRITE_ONCE(nohz.needs_update, 1);
>>  out:
>>  	/*
>>  	 * Each time a cpu enter idle, we assume that it has blocked load and
>> @@ -11945,21 +11944,25 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>>  }
>>  
>>  /*
>> - * Check if we need to run the ILB for updating blocked load before entering
>> - * idle state.
>> + * Check if we need to run the ILB for updating blocked load and/or updating
>> + * nohz.next_balance before entering idle state.
>>   */
>>  void nohz_run_idle_balance(int cpu)
>>  {
>>  	unsigned int flags;
>>  
>> -	flags = atomic_fetch_andnot(NOHZ_NEWILB_KICK, nohz_flags(cpu));
>> +	flags = atomic_fetch_andnot(NOHZ_NEWILB_KICK | NOHZ_NEXT_KICK, nohz_flags(cpu));
>> +
>> +	if (!flags)
>> +		return;
>>  
>>  	/*
>>  	 * Update the blocked load only if no SCHED_SOFTIRQ is about to happen
>>  	 * (ie NOHZ_STATS_KICK set) and will do the same.
>>  	 */
>> -	if ((flags == NOHZ_NEWILB_KICK) && !need_resched())
>> -		_nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK);
>> +	if ((flags == (flags & (NOHZ_NEXT_KICK | NOHZ_NEWILB_KICK))) &&
>> +	    !need_resched())
>> +		_nohz_idle_balance(cpu_rq(cpu), flags);
>>  }
>>  
>>  static void nohz_newidle_balance(struct rq *this_rq)
>> @@ -11977,6 +11980,10 @@ static void nohz_newidle_balance(struct rq *this_rq)
>>  	if (this_rq->avg_idle < sysctl_sched_migration_cost)
>>  		return;
>>  
>> +	/* If rq->next_balance before nohz.next_balance, trigger ILB */
>> +	if (time_before(this_rq->next_balance, READ_ONCE(nohz.next_balance)))
>> +		atomic_or(NOHZ_NEXT_KICK, nohz_flags(this_cpu));
>> +
>>  	/* Don't need to update blocked load of idle CPUs*/
>>  	if (!READ_ONCE(nohz.has_blocked) ||
>>  	    time_before(jiffies, READ_ONCE(nohz.next_blocked)))
