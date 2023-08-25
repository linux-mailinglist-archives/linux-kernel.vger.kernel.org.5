Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F18E787F7C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbjHYGAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240755AbjHYGAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:00:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7001BC7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:00:28 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P5cQO1010970;
        Fri, 25 Aug 2023 06:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=l3NPGiqpGDJw1FpbOTnDTFy6Bl4Pax3HVsXE2iygliw=;
 b=KYsPOURZTrnY0+oY1n/O9rop4LxjSuyjga69Svm9Bp+keV/Nl27earuLvUpH57uphVeT
 qzKWvzGhThTguEtk/Knl3f3n14R6Eys9A30InCn1wPdsSVT+C6FN+1i4+HuO5hjR4edn
 hRnPAHRqL6Xr/c36qXi6wwuOssl5ga8MqAcfPQwOSyQoAxKOAuRjfekNHholzAiyJbc3
 jfMVjJvAe4jvntt7QLmngcmgQ47Zv2NMsvETLvW5HvV8bewGBpM3Xxag8h5h0C+E+U4U
 20USUyPiIXWt9sRNnvJyU6vA3kYFKMs0QAu4eQvpcGBxDH0fvC/QpwunPHPcbK4BLqlm cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3spp0agu59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 06:00:14 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37P5cQSm010997;
        Fri, 25 Aug 2023 06:00:13 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3spp0agu3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 06:00:13 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37P52wQo018278;
        Fri, 25 Aug 2023 06:00:12 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sn21sw7pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 06:00:12 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37P60B4Y10551854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 06:00:11 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAED65805A;
        Fri, 25 Aug 2023 06:00:11 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F44958064;
        Fri, 25 Aug 2023 06:00:07 +0000 (GMT)
Received: from [9.171.40.203] (unknown [9.171.40.203])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 25 Aug 2023 06:00:06 +0000 (GMT)
Message-ID: <cca85edb-0c16-05d1-a734-5148054ba7a7@linux.vnet.ibm.com>
Date:   Fri, 25 Aug 2023 11:30:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 5/7] sched/fair: Adjust the busiest group scanning
 depth in idle load balance
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Aaron Lu <aaron.lu@intel.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <cover.1690273854.git.yu.c.chen@intel.com>
 <98e26a26832669b4293a50a701f9b3b8d44e4863.1690273854.git.yu.c.chen@intel.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <98e26a26832669b4293a50a701f9b3b8d44e4863.1690273854.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MwooMhlQg7MTbjbsrwWoJFmVTGN9RLH2
X-Proofpoint-ORIG-GUID: STAjEIkV6pvVYSTc3Hw04yrUsLENocz_
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_04,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250046
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/23 8:05 PM, Chen Yu wrote:
> Scanning the whole sched domain to find the busiest group is time costly
> during newidle_balance(). And if a CPU becomes idle, it would be good
> if this idle CPU pulls some tasks from other CPUs as quickly as possible.
> 
> Limit the scan depth of newidle_balance() to only scan for a limited number
> of sched groups to find a relatively busy group, and pull from it.
> In summary, the more spare time there is in the domain, the more time
> each newidle balance can spend on scanning for a busy group. Although
> the newidle balance has per domain max_newidle_lb_cost to decide
> whether to launch the balance or not, the ILB_UTIL provides a smaller
> granularity to decide how many groups each newidle balance can scan.
> 
> The scanning depth is calculated by the previous periodic load balance
> based on its overall utilization.
> 
> Tested on top of v6.5-rc2, Sapphire Rapids with 2 x 56C/112T = 224 CPUs.
> With cpufreq governor set to performance, and C6 disabled.
> 
> Firstly, tested on a extreme synthetic test[1], which launches 224
> process. Each process is a loop of nanosleep(1 us), which is supposed
> to trigger newidle balance as much as possible:
> 
> i=1;while [ $i -le "224" ]; do ./nano_sleep 1000 & i=$(($i+1)); done;
> 
> NO_ILB_UTIL + ILB_SNAPSHOT:
> 9.38%     0.45%  [kernel.kallsyms]   [k] newidle_balance
> 6.84%     5.32%  [kernel.kallsyms]   [k] update_sd_lb_stats.constprop.0
> 
> ILB_UTIL + ILB_SNAPSHOT:
> 3.35%     0.38%  [kernel.kallsyms]   [k] newidle_balance
> 2.30%     1.81%  [kernel.kallsyms]   [k] update_sd_lb_stats.constprop.0
> [...]

> Link: https://raw.githubusercontent.com/chen-yu-surf/tools/master/stress_nanosleep.c #1
> Suggested-by: Tim Chen <tim.c.chen@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/sched/fair.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6925813db59b..4e360ed16e14 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10195,7 +10195,13 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  	struct sg_lb_stats *local = &sds->local_stat;
>  	struct sg_lb_stats tmp_sgs;
>  	unsigned long sum_util = 0;
> -	int sg_status = 0;
> +	int sg_status = 0, nr_sg_scan;
> +	/* only newidle CPU can load the snapshot */
> +	bool ilb_can_load = env->idle == CPU_NEWLY_IDLE &&
> +			    sd_share && READ_ONCE(sd_share->total_capacity);
> +
> +	if (sched_feat(ILB_UTIL) && ilb_can_load)

Suggestion for small improvement:

it could be ? This could help save a few cycles of checking if the feature is enabled when its not newidle. 

	if ( ilb_can_load && sched_feat(ILB_UTIL)) 

Same comments below in this patch as well in PATCH 6/7.

> +		nr_sg_scan = sd_share->nr_sg_scan;
>  
>  	do {
>  		struct sg_lb_stats *sgs = &tmp_sgs;
> @@ -10222,6 +10228,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  			sds->busiest_stat = *sgs;
>  		}
>  
> +		if (sched_feat(ILB_UTIL) && ilb_can_load && --nr_sg_scan <= 0)
> +			goto load_snapshot;
> +

Same comment as above.

>  next_group:
>  		/* Now, start updating sd_lb_stats */
>  		sds->total_load += sgs->group_load;
> @@ -10231,6 +10240,15 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  		sg = sg->next;
>  	} while (sg != env->sd->groups);
>  
> +	ilb_can_load = false;
> +
> +load_snapshot:
> +	if (ilb_can_load) {
> +		/* borrow the statistic of previous periodic load balance */
> +		sds->total_load = READ_ONCE(sd_share->total_load);
> +		sds->total_capacity = READ_ONCE(sd_share->total_capacity);
> +	}
> +
>  	/*
>  	 * Indicate that the child domain of the busiest group prefers tasks
>  	 * go to a child's sibling domains first. NB the flags of a sched group
