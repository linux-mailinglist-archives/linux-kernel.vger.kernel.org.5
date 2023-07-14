Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4FB753B9D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbjGNNQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjGNNQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:16:33 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F79134
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:16:32 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ECmrxO027335;
        Fri, 14 Jul 2023 13:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=txgMF0gEJj8nTuXNgzgs58RbRvCPR5mSZ42jV58B0p8=;
 b=mwPaLX8N2yODgcqDWpjCLTJeHkrTls8gIhxGY2m1rVbc9U5DwF59Te0D6rxQUfkQxdjq
 g5vJiVSJkmtglGYfA0REwOzr9b8gVDwv2wu/p8o1UJXElIzamJmtm2PKY6gwAIft6Wc1
 CoXEy6nfieDGf2ck3SI7OA/uoP6sk+jgECLWDLhvSvaF332JnpH7pdsjXoHK7AJXv1k6
 r+FvLsKXutE6R9CTH4t1Qr6/1JhQRcFT7M0LkEoO+gqf/OS2aRXvYo+sRGPMrRi1jyh7
 KrsFtsIIJSDU4Iwfaj3VK3njCvljGLiJauBRTJ+o80aI9aSsyjKORYl1+m8YLn7usnyA mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru6purnr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 13:16:06 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36ED6ttu014216;
        Fri, 14 Jul 2023 13:16:05 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru6purnpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 13:16:05 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36E4sFIG007313;
        Fri, 14 Jul 2023 13:15:10 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rtpvs1qug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 13:15:10 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36EDF9Vb54526390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 13:15:09 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24CD958061;
        Fri, 14 Jul 2023 13:15:09 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D2605803F;
        Fri, 14 Jul 2023 13:15:00 +0000 (GMT)
Received: from [9.171.88.96] (unknown [9.171.88.96])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jul 2023 13:14:59 +0000 (GMT)
Message-ID: <c5a49136-3549-badd-ec8f-3de4e7bb7b7d@linux.vnet.ibm.com>
Date:   Fri, 14 Jul 2023 18:44:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Patch v3 3/6] sched/fair: Implement prefer sibling imbalance
 calculation between asymmetric groups
Content-Language: en-US
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>,
        shrikanth hegde <sshegde@linux.vnet.ibm.com>,
        Tobias Huschle <huschle@linux.ibm.com>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
 <4eacbaa236e680687dae2958378a6173654113df.1688770494.git.tim.c.chen@linux.intel.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <4eacbaa236e680687dae2958378a6173654113df.1688770494.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lvU85WMMHILZmhWTPFPnhqEIZ4qS2487
X-Proofpoint-ORIG-GUID: 7tG6qKmxVa4-HGMsVHH95PC8xXMJw35S
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 phishscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/8/23 4:27 AM, Tim Chen wrote:
> From: Tim C Chen <tim.c.chen@linux.intel.com>
> 
> In the current prefer sibling load balancing code, there is an implicit
> assumption that the busiest sched group and local sched group are
> equivalent, hence the tasks to be moved is simply the difference in
> number of tasks between the two groups (i.e. imbalance) divided by two.
> 
> However, we may have different number of cores between the cluster groups,
> say when we take CPU offline or we have hybrid groups.  In that case,
> we should balance between the two groups such that #tasks/#cores ratio
> is the same between the same between both groups.  Hence the imbalance

nit: type here. the same between is repeated.

> computed will need to reflect this.
> 
> Adjust the sibling imbalance computation to take into account of the
> above considerations.
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c | 41 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f636d6c09dc6..f491b94908bf 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9372,6 +9372,41 @@ static inline bool smt_balance(struct lb_env *env, struct sg_lb_stats *sgs,
>  	return false;
>  }
> 
> +static inline long sibling_imbalance(struct lb_env *env,
> +				    struct sd_lb_stats *sds,
> +				    struct sg_lb_stats *busiest,
> +				    struct sg_lb_stats *local)
> +{
> +	int ncores_busiest, ncores_local;
> +	long imbalance;

can imbalance be unsigned int or unsigned long? as sum_nr_running is unsigned int.

> +
> +	if (env->idle == CPU_NOT_IDLE || !busiest->sum_nr_running)
> +		return 0;
> +
> +	ncores_busiest = sds->busiest->cores;
> +	ncores_local = sds->local->cores;
> +
> +	if (ncores_busiest == ncores_local) {
> +		imbalance = busiest->sum_nr_running;
> +		lsub_positive(&imbalance, local->sum_nr_running);
> +		return imbalance;
> +	}
> +
> +	/* Balance such that nr_running/ncores ratio are same on both groups */
> +	imbalance = ncores_local * busiest->sum_nr_running;
> +	lsub_positive(&imbalance, ncores_busiest * local->sum_nr_running);
> +	/* Normalize imbalance and do rounding on normalization */
> +	imbalance = 2 * imbalance + ncores_local + ncores_busiest;
> +	imbalance /= ncores_local + ncores_busiest;
> +

Could this work for case where number of CPU/cores would differ
between two sched groups in a sched domain? Such as problem pointed
by tobias on S390. It would be nice if this patch can work for that case 
as well. Ran numbers for a few cases. It looks to work.
https://lore.kernel.org/lkml/20230704134024.GV4253@hirez.programming.kicks-ass.net/T/#rb0a7dcd28532cafc24101e1d0aed79e6342e3901



> +	/* Take advantage of resource in an empty sched group */
> +	if (imbalance == 0 && local->sum_nr_running == 0 &&
> +	    busiest->sum_nr_running > 1)
> +		imbalance = 2;
> +

I don't see how this case would be true. When there are unequal number of cores and local->sum_nr_ruuning 
is 0, and busiest->sum_nr_running is atleast 2, imbalance will be atleast 1. 


Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>

> +	return imbalance;
> +}
> +
>  static inline bool
>  sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
>  {
> @@ -10230,14 +10265,12 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  		}
> 
>  		if (busiest->group_weight == 1 || sds->prefer_sibling) {
> -			unsigned int nr_diff = busiest->sum_nr_running;
>  			/*
>  			 * When prefer sibling, evenly spread running tasks on
>  			 * groups.
>  			 */
>  			env->migration_type = migrate_task;
> -			lsub_positive(&nr_diff, local->sum_nr_running);
> -			env->imbalance = nr_diff;
> +			env->imbalance = sibling_imbalance(env, sds, busiest, local);
>  		} else {
> 
>  			/*
> @@ -10424,7 +10457,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>  	 * group's child domain.
>  	 */
>  	if (sds.prefer_sibling && local->group_type == group_has_spare &&
> -	    busiest->sum_nr_running > local->sum_nr_running + 1)
> +	    sibling_imbalance(env, &sds, busiest, local) > 1)
>  		goto force_balance;
> 
>  	if (busiest->group_type != group_overloaded) {

