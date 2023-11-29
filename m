Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F0E7FDE63
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjK2R27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjK2R26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:28:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048C6C1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:29:05 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATHHUid014981;
        Wed, 29 Nov 2023 17:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : reply-to : from :
 in-reply-to : content-type : content-transfer-encoding; s=pp1;
 bh=OQQXy1FF9NbEEixWFK1PRCwSc5ol25i6tGUGr1EkRds=;
 b=meZYoJAXLsJZ4C9ryjx8b6qADDxozw7NLvjWGtuUdNxKOZqoOzczJj0AkkpSKqciha+2
 6Np25wrIRjw210XZC2EZY1vrclB9c0egdusFpCBTbTPQIHDlhL3PIostUW4X7m1yFoGp
 I3UGpMVUq1GQvfG91tpQCPD5ivaytP+KZxlu5Oop4bCxiq62vAItiv7wgTj5q5kdlhGe
 rfxfK4g1iWBgqPVvwFx04yBhFPiVTpiF+XxD72igB/rCImWvDj7DbSXDO2LIE+lCRJxS
 qCUz0wQlLYygsKn4Uv0TKO+M2vvUXJGpxzuh4KwWyE/JADSbK8bGDKmyzzc1Q/abb58+ QA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up9jpgbb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 17:26:42 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ATHHo32016466;
        Wed, 29 Nov 2023 17:26:42 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up9jpgb9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 17:26:42 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATGnOrp009736;
        Wed, 29 Nov 2023 17:26:40 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukvrkrk9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 17:26:40 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ATHQdu353936526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Nov 2023 17:26:40 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF26D5803F;
        Wed, 29 Nov 2023 17:26:39 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD23E58054;
        Wed, 29 Nov 2023 17:26:32 +0000 (GMT)
Received: from [9.171.27.200] (unknown [9.171.27.200])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 29 Nov 2023 17:26:32 +0000 (GMT)
Message-ID: <3dd5ae53-a914-bfd1-285e-e206ba0c58bd@linux.ibm.com>
Date:   Wed, 29 Nov 2023 22:56:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/3] sched/fair: do not scribble cache-hot CPU in
 select_idle_cpu()
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <cover.1700548379.git.yu.c.chen@intel.com>
 <35e612eb2851693a52f7ed1ff9be5bc24011136f.1700548379.git.yu.c.chen@intel.com>
Content-Language: en-US
Reply-To: 35e612eb2851693a52f7ed1ff9be5bc24011136f.1700548379.git.yu.c.chen@intel.com
From:   Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <35e612eb2851693a52f7ed1ff9be5bc24011136f.1700548379.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7WRiIP5b83XD0UPEXTsililRd0DF8SGD
X-Proofpoint-ORIG-GUID: PxGm4-9wa638wfxvsLADCepY-9o7ertw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_15,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290133
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen Yu,

On 21/11/23 13:10, Chen Yu wrote:
> Problem statement:
> When task p is woken up, the scheduler leverages select_idle_sibling()
> to find an idle CPU for it. p's previous CPU is usually a preference
> because it can improve cache locality. However in many cases, the
> previous CPU has already been taken by other wakees, thus p has to
> find another idle CPU.
> 
> Proposal:
> Introduce the SIS_CACHE. It considers the sleep time of the task for
> better task placement. Based on the task's short sleeping history,
> tag p's previous CPU as cache-hot. Later when p is woken up, it can
> choose its previous CPU in select_idle_sibling(). When other task is
> woken up, skip this cache-hot idle CPU when possible.
> 
> SIS_CACHE still prefers to choose an idle CPU during task wakeup,
> the idea is to optimize the idle CPU scan sequence.
> 
> As pointed out by Prateek, this has the potential that all idle CPUs
> are cache-hot and skipped. Mitigate this by returning the first
> cache-hot idle CPU. Meanwhile, to reduce the time spend on scanning,
> limit the max number of cache-hot CPU search depth to half of the number
> suggested by SIS_UTIL.
> 
> Tested on Xeon 2 x 60C/120T platforms:
> 
> netperf
> =======
> case            	load    	baseline(std%)	compare%( std%)
> TCP_RR          	60-threads	 1.00 (  1.37)	 +0.04 (  1.47)
> TCP_RR          	120-threads	 1.00 (  1.77)	 -1.03 (  1.31)
> TCP_RR          	180-threads	 1.00 (  2.03)	 +1.25 (  1.66)
> TCP_RR          	240-threads	 1.00 ( 41.31)	+73.71 ( 22.02)
> TCP_RR          	300-threads	 1.00 ( 12.79)	 -0.11 ( 15.84)
> 
> tbench
> ======
> case            	load    	baseline(std%)	compare%( std%)
> loopback        	60-threads	 1.00 (  0.35)	 +0.40 (  0.31)
> loopback        	120-threads	 1.00 (  1.94)	 -1.89 (  1.17)
> loopback        	180-threads	 1.00 ( 13.59)	 +9.97 (  0.93)
> loopback        	240-threads	 1.00 ( 11.68)	+42.85 (  7.28)
> loopback        	300-threads	 1.00 (  4.47)	+15.12 (  1.40)
> 
> hackbench
> =========
> case            	load    	baseline(std%)	compare%( std%)
> process-pipe    	1-groups	 1.00 (  9.21)	 -7.88 (  2.03)
> process-pipe    	2-groups	 1.00 (  7.09)	 +5.47 (  9.02)
> process-pipe    	4-groups	 1.00 (  1.60)	 +1.53 (  1.70)
> 
> schbench
> ========
> case            	load    	baseline(std%)	compare%( std%)
> normal          	1-mthreads	 1.00 (  0.98)	 +0.26 (  0.37)
> normal          	2-mthreads	 1.00 (  3.99)	 -7.97 (  7.33)
> normal          	4-mthreads	 1.00 (  3.07)	 -1.55 (  3.27)
> 
> Also did some experiments on the OLTP workload on a 112 core 2 socket
> SPR machine. The OLTP workload have a mixture of threads handling
> database updates on disks and handling transaction queries over network.
> Around 0.7% improvement is observed with less than 0.2% run-to-run
> variation.
> 
> Thanks Madadi for testing the SIS_CACHE on a power system with 96 CPUs.
> The results showed a max of 29% improvements in hackbench, 13% improvements
> in producer_consumer workload, and 2% improvements in real life workload
> named Daytrader.
> 
> Thanks Prateek for running microbenchmarks on top of the latest patch on
> a 3rd Generation EPYC System:
> - 2 sockets each with 64C/128T
> - NPS1 (Each socket is a NUMA node)
> - C2 Disabled (POLL and C1(MWAIT) remained enabled)
> No consistent regression was observed in v2 version.
> 
> Analysis:
> The reason why waking up the task on its previous CPU brings benefits
> is due to less task migration and higher local resource locality.
> 
> Take netperf 240 case as an example, run the following script
> to track the migration number within 10 seconds. Use perf topdown
> to track the PMU events. The task migration and stall cycles
> have been reduced a lot with SIS_CACHE:
> 
> kretfunc:select_task_rq_fair
> {
>         $p = (struct task_struct *)args->p;
>         if ($p->comm == "netperf") {
>                 if ($p->thread_info.cpu != retval) {
>                         @wakeup_migrate_netperf = count();
>                 } else {
>                         @wakeup_prev_netperf = count();
>                 }
>         }
> }
> 
> NO_SIS_CACHE:
> @wakeup_migrate_netperf: 57473509
> @wakeup_prev_netperf: 14935964
> RESOURCE_STALLS: 19.1% * 7.1% * 35.0%
> 
> SIS_CACHE:
> @wakeup_migrate_netperf: 799
> @wakeup_prev_netperf: 132937436
> RESOURCE_STALLS: 5.4% * 7.5% * 39.8%
> 
> Suggested-by: Tim Chen <tim.c.chen@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/sched/fair.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c309b3d203c0..d149eca74fca 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7360,7 +7360,7 @@ static inline int select_idle_smt(struct task_struct *p, int target)
>   * Return true if the idle CPU is cache-hot for someone,
>   * return false otherwise.
>   */
> -static __maybe_unused bool cache_hot_cpu(int cpu, int *hot_cpu)
> +static bool cache_hot_cpu(int cpu, int *hot_cpu)
>  {
>  	if (!sched_feat(SIS_CACHE))
>  		return false;
> @@ -7383,7 +7383,7 @@ static __maybe_unused bool cache_hot_cpu(int cpu, int *hot_cpu)
>  static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
>  {
>  	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
> -	int i, cpu, idle_cpu = -1, nr = INT_MAX;
> +	int i, cpu, idle_cpu = -1, nr = INT_MAX, nr_hot = 0, hot_cpu = -1;
>  	struct sched_domain_shared *sd_share;
>  
>  	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> @@ -7396,6 +7396,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  			/* overloaded LLC is unlikely to have idle cpu/core */
>  			if (nr == 1)
>  				return -1;
> +
> +			/* max number of cache-hot idle cpu check */
> +			nr_hot = nr >> 1;
>  		}
>  	}
>  
> @@ -7426,18 +7429,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  	for_each_cpu_wrap(cpu, cpus, target + 1) {
>  		if (has_idle_core) {
>  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> -			if ((unsigned int)i < nr_cpumask_bits)
> +			if ((unsigned int)i < nr_cpumask_bits) {
> +				if (--nr_hot >= 0 && cache_hot_cpu(i, &hot_cpu))
> +					continue;
> +
>  				return i;
> +			}
>  
>  		} else {
>  			if (--nr <= 0)
>  				return -1;
>  			idle_cpu = __select_idle_cpu(cpu, p);
> -			if ((unsigned int)idle_cpu < nr_cpumask_bits)
> +			if ((unsigned int)idle_cpu < nr_cpumask_bits) {
> +				if (--nr_hot >= 0 && cache_hot_cpu(idle_cpu, &hot_cpu))
> +					continue;
> +
>  				break;
> +			}
>  		}
>  	}
>  
> +	/* pick the first cache-hot CPU as the last resort */
> +	if (idle_cpu == -1 && hot_cpu != -1)
> +		idle_cpu = hot_cpu;
> +
>  	if (has_idle_core)
>  		set_idle_cores(target, false);
>  

As per my understanding, if the task which tagged a particular CPU as cache hot has woken up before
the cache_hot_timeout, we still don't allow that task to run on that particular CPU. Is this correct?

If correct, then why don't we let the task to select the CPU if it's the one that tagged it?

Thanks and Regards
Madadi Vineeth Reddy
