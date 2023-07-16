Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B1A755112
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 21:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjGPThs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 15:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGPThq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 15:37:46 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F6E109
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 12:37:45 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36GJAKK9009387;
        Sun, 16 Jul 2023 19:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DpzU/xa7KYAVP3cPVJcvLRuCqeM1nALa4nrWECMCQWA=;
 b=JpId7mY1VDNq51unNlucfnKjttYC+6TZu3ibgiFkLyhcGM+hW1Q+LKql2PeNZtChx0xi
 3RO9ke/IKz2G1LhZueglXaQY5Wnt3xCKZfjJ6g0e+a+cORFpVhPU1qW0gUAGdrRqu8OQ
 vr26pDrmJTUfwaxsmlw959Y7Oe21wLE/kne/Q6br4e0uQ9iDFyDJFoNNy8UCPNQ7Moev
 QTsa3cBnk7BzFv7M2JJixv0RAqeAC1nMaYlQ4JiUOeY4+KIXwjNnITnjouDmzapO15IF
 KySfAyoIp2Z63L+SolzEANDCGIvcTrLFpqMMjMSG1a59c07wu0a272ffnaG+UFgnQsxB nA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rvntns6kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jul 2023 19:37:11 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36GJKEbV006002;
        Sun, 16 Jul 2023 19:37:11 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rvntns6k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jul 2023 19:37:10 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36GH6QW8005272;
        Sun, 16 Jul 2023 19:37:10 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv65x910b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jul 2023 19:37:10 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36GJb9jD32571922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Jul 2023 19:37:09 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 364375805A;
        Sun, 16 Jul 2023 19:37:09 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EBA55805C;
        Sun, 16 Jul 2023 19:37:01 +0000 (GMT)
Received: from [9.171.2.199] (unknown [9.171.2.199])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 16 Jul 2023 19:37:00 +0000 (GMT)
Message-ID: <05ed4537-e79b-0ff3-5be5-92cbffaab3ee@linux.vnet.ibm.com>
Date:   Mon, 17 Jul 2023 01:06:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Patch v3 1/6] sched/fair: Determine active load balance for SMT
 sched groups
Content-Language: en-US
To:     Tim Chen <tim.c.chen@linux.intel.com>
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
        Peter Zijlstra <peterz@infradead.org>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
 <e24f35d142308790f69be65930b82794ef6658a2.1688770494.git.tim.c.chen@linux.intel.com>
 <165778ce-7b8f-1966-af02-90ef481455b9@linux.vnet.ibm.com>
 <a399af19aa8e1291558724509a1de2f52b3bad0a.camel@linux.intel.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <a399af19aa8e1291558724509a1de2f52b3bad0a.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VjoyNEPyMCDIX8SbW_I2Fa2EU67DIt1z
X-Proofpoint-ORIG-GUID: sGt3MXflhWnwM5JAEHnv_kHdAXMyyZmX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-16_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307160187
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/23 4:35 AM, Tim Chen wrote:
> On Fri, 2023-07-14 at 18:36 +0530, Shrikanth Hegde wrote:
> 
>>
>>
>> If we consider symmetric platforms which have SMT4 such as power10. 
>> we have a topology like below. multiple such MC will form DIE(PKG)
>>
>>
>> [0 2 4 6][1 3 5 7][8 10 12 14][9 11 13 15]
>> [--SMT--][--SMT--][----SMT---][---SMT----]
>> [--sg1--][--sg1--][---sg1----][---sg1----]
>> [--------------MC------------------------]
>>
>> In case of SMT4, if there is any group which has 2 or more tasks, that 
>> group will be marked as group_smt_balance. previously, if that group had 2
>> or 3 tasks, it would have been marked as group_has_spare. Since all the groups have 
>> SMT that means behavior would be same fully busy right? That can cause some 
>> corner cases. No?
> 
> You raised a good point. I was looking from SMT2
> perspective so group_smt_balance implies group_fully_busy.
> That is no longer true for SMT4.
> 
> I am thinking of the following fix on the current patch
> to take care of SMT4. Do you think this addresses

Thanks Tim for taking a look at it again. 

Yes. I think this would address some of the corner cases. 
Any SMT4 group having 2,3,4 will have smt_balance as the group type, and busiest one 
is the one which has least number of idle cpu's. (same conditions as group_has_spare)




> concerns from you and Tobias?
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 294a662c9410..3fc8d3a3bd22 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9588,6 +9588,17 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>                 break;
>  
>         case group_smt_balance:
> +               /* no idle cpus on both groups handled by group_fully_busy below */
> +               if (sgs->idle_cpus != 0 || busiest->idle_cpus != 0) {
> +                       if (sgs->idle_cpus > busiest->idle_cpus)
> +                               return false;
> +                       if (sgs->idle_cpus < busiest->idle_cpus)
> +                               return true;
> +                       if (sgs->sum_nr_running <= busiest_sum_nr_running)
> +                               return false;
> +                       else
> +                               return true;
> +               }
> 
> 
> I will be on vacation next three weeks so my response will be slow.
> 
> Tim
> 
>>

Small suggestion to above code to avoid compiler warning of switch case falling
through and else case can be removed, since update_sd_pick_busiest by default returns true.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e5a75c76bcaa..ae364ac6f22e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9728,9 +9728,9 @@ static bool update_sd_pick_busiest(struct lb_env *env,
                                return true;
                        if (sgs->sum_nr_running <= busiest->sum_nr_running)
                                return false;
-                       else
-                               return true;
                }
+               break;
+
        case group_fully_busy:
                /*
                 * Select the fully busy group with highest avg_load. In



>> One example is Lets say sg1 has 4 tasks. and sg2 has 0 tasks and is trying to do 
>> load balance. Previously imbalance would have been 2, instead now imbalance would be 1.
>> But in subsequent lb it would be balanced.
>>
>>
>>
>>> +	return false;
>>> +}
>>> +
>>>  static inline bool
>>>  sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
>>>  {
>>> @@ -9425,6 +9464,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>>  		sgs->group_asym_packing = 1;
>>>  	}
>>>
>>> +	/* Check for loaded SMT group to be balanced to dst CPU */
>>> +	if (!local_group && smt_balance(env, sgs, group))
>>> +		sgs->group_smt_balance = 1;
>>> +
>>>  	sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
>>>
>>>  	/* Computing avg_load makes sense only when group is overloaded */
>>> @@ -9509,6 +9552,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>>>  			return false;
>>>  		break;
>>>
>>> +	case group_smt_balance:
>>>  	case group_fully_busy:
>>>  		/*
>>>  		 * Select the fully busy group with highest avg_load. In
>>> @@ -9537,6 +9581,18 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>>>  		break;
>>>
>>>  	case group_has_spare:
>>> +		/*
>>> +		 * Do not pick sg with SMT CPUs over sg with pure CPUs,
>>> +		 * as we do not want to pull task off SMT core with one task
>>> +		 * and make the core idle.
>>> +		 */
>>> +		if (smt_vs_nonsmt_groups(sds->busiest, sg)) {
>>> +			if (sg->flags & SD_SHARE_CPUCAPACITY && sgs->sum_h_nr_running <= 1)
>>> +				return false;
>>> +			else
>>> +				return true;> +		}
>>> +
>>>  		/*
>>>  		 * Select not overloaded group with lowest number of idle cpus
>>>  		 * and highest number of running tasks. We could also compare
>>> @@ -9733,6 +9789,7 @@ static bool update_pick_idlest(struct sched_group *idlest,
>>>
>>>  	case group_imbalanced:
>>>  	case group_asym_packing:
>>> +	case group_smt_balance:
>>>  		/* Those types are not used in the slow wakeup path */
>>>  		return false;
>>>
>>> @@ -9864,6 +9921,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>>>
>>>  	case group_imbalanced:
>>>  	case group_asym_packing:
>>> +	case group_smt_balance:
>>>  		/* Those type are not used in the slow wakeup path */
>>>  		return NULL;
>>>
>>> @@ -10118,6 +10176,13 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>>>  		return;
>>>  	}
>>>
>>> +	if (busiest->group_type == group_smt_balance) {
>>> +		/* Reduce number of tasks sharing CPU capacity */
>>> +		env->migration_type = migrate_task;
>>> +		env->imbalance = 1;
>>> +		return;
>>> +	}
>>> +
>>>  	if (busiest->group_type == group_imbalanced) {
>>>  		/*
>>>  		 * In the group_imb case we cannot rely on group-wide averages
>>> @@ -10363,16 +10428,23 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>>>  		goto force_balance;
>>>
>>>  	if (busiest->group_type != group_overloaded) {
>>> -		if (env->idle == CPU_NOT_IDLE)
>>> +		if (env->idle == CPU_NOT_IDLE) {
>>>  			/*
>>>  			 * If the busiest group is not overloaded (and as a
>>>  			 * result the local one too) but this CPU is already
>>>  			 * busy, let another idle CPU try to pull task.
>>>  			 */
>>>  			goto out_balanced;
>>> +		}
>>> +
>>> +		if (busiest->group_type == group_smt_balance &&
>>> +		    smt_vs_nonsmt_groups(sds.local, sds.busiest)) {
>>> +			/* Let non SMT CPU pull from SMT CPU sharing with sibling */
>>> +			goto force_balance;
>>> +		}
>>>
>>>  		if (busiest->group_weight > 1 &&
>>> -		    local->idle_cpus <= (busiest->idle_cpus + 1))
>>> +		    local->idle_cpus <= (busiest->idle_cpus + 1)) {
>>>  			/*
>>>  			 * If the busiest group is not overloaded
>>>  			 * and there is no imbalance between this and busiest
>>> @@ -10383,12 +10455,14 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>>>  			 * there is more than 1 CPU per group.
>>>  			 */
>>>  			goto out_balanced;
>>> +		}
>>>
>>> -		if (busiest->sum_h_nr_running == 1)
>>> +		if (busiest->sum_h_nr_running == 1) {
>>>  			/*
>>>  			 * busiest doesn't have any tasks waiting to run
>>>  			 */
>>>  			goto out_balanced;
>>> +		}
>>>  	}
>>>
>>>  force_balance:
> 
