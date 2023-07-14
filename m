Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14888753E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbjGNOzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236206AbjGNOzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:55:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E3830C0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:55:03 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EEqRAC015134;
        Fri, 14 Jul 2023 14:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=7RgpVV4oKz7+K3/9Q7NdrPoztMllv/h/YRCGqrdSnSo=;
 b=JoKwgU9fz+EDJaXLKfj6I0zQE1Pg3E/B/FONXtvCczTChQo5HWJEHzXBDqltS98NWCTb
 Z4uk7v5pRpHMod+SE46rdHT7dLHRyf6ldxSHSaWDtH1dE+wVvh3LCwxTM1hYKod38svY
 2AQHvSjdFdWfCDPGHiatPDTJXRktnYsDLWjANleE7SWpkz8Aqo0GHMNxNUUuXD/G263N
 IAgWgsAWqX+QNJDyuyy/6SRFZgCDaIBUUb928UST4xUSpea2Mo9RuXBDPpf6WITbr1vQ
 6wd/R1tz+th9cCSwAa+bOzMmhRY3BGUTwbusZqhE/+i6XZPyx3WriarebY6ouqama90j eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru8gh80w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 14:53:54 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36EEqZ5U015914;
        Fri, 14 Jul 2023 14:53:53 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru8gh80vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 14:53:53 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36ECjUcY002932;
        Fri, 14 Jul 2023 14:53:52 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3rtqjkm2dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 14:53:52 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36EErpmg30147252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 14:53:51 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 345EC58043;
        Fri, 14 Jul 2023 14:53:51 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68FAA58059;
        Fri, 14 Jul 2023 14:53:49 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jul 2023 14:53:49 +0000 (GMT)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 16:53:49 +0200
From:   Tobias Huschle <huschle@linux.ibm.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
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
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>
Subject: Re: [Patch v3 1/6] sched/fair: Determine active load balance for SMT
 sched groups
In-Reply-To: <e24f35d142308790f69be65930b82794ef6658a2.1688770494.git.tim.c.chen@linux.intel.com>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
 <e24f35d142308790f69be65930b82794ef6658a2.1688770494.git.tim.c.chen@linux.intel.com>
Message-ID: <d3a1621eae04f7671b2b430352b42a27@linux.ibm.com>
X-Sender: huschle@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KC9gT-VEjx8tOGlUmSZo3ZNZkRWiioWh
X-Proofpoint-GUID: UDoI0HPAFvTO8ZICXf2YxGP8dFIKJn86
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 phishscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140132
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-08 00:57, Tim Chen wrote:
> From: Tim C Chen <tim.c.chen@linux.intel.com>
> 
> On hybrid CPUs with scheduling cluster enabled, we will need to
> consider balancing between SMT CPU cluster, and Atom core cluster.
> 
> Below shows such a hybrid x86 CPU with 4 big cores and 8 atom cores.
> Each scheduling cluster span a L2 cache.
> 
>           --L2-- --L2-- --L2-- --L2-- ----L2---- -----L2------
>           [0, 1] [2, 3] [4, 5] [5, 6] [7 8 9 10] [11 12 13 14]
>           Big    Big    Big    Big    Atom       Atom
>           core   core   core   core   Module     Module
> 
> If the busiest group is a big core with both SMT CPUs busy, we should
> active load balance if destination group has idle CPU cores.  Such
> condition is considered by asym_active_balance() in load balancing but 
> not
> considered when looking for busiest group and computing load imbalance.
> Add this consideration in find_busiest_group() and 
> calculate_imbalance().
> 
> In addition, update the logic determining the busier group when one 
> group
> is SMT and the other group is non SMT but both groups are partially 
> busy
> with idle CPU. The busier group should be the group with idle cores 
> rather
> than the group with one busy SMT CPU.  We do not want to make the SMT 
> group
> the busiest one to pull the only task off SMT CPU and causing the whole 
> core to
> go empty.
> 
> Otherwise suppose in the search for the busiest group, we first 
> encounter
> an SMT group with 1 task and set it as the busiest.  The destination
> group is an atom cluster with 1 task and we next encounter an atom
> cluster group with 3 tasks, we will not pick this atom cluster over the
> SMT group, even though we should.  As a result, we do not load balance
> the busier Atom cluster (with 3 tasks) towards the local atom cluster
> (with 1 task).  And it doesn't make sense to pick the 1 task SMT group
> as the busier group as we also should not pull task off the SMT towards
> the 1 task atom cluster and make the SMT core completely empty.
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c | 80 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 77 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 87317634fab2..f636d6c09dc6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8279,6 +8279,11 @@ enum group_type {
>  	 * more powerful CPU.
>  	 */
>  	group_misfit_task,
> +	/*
> +	 * Balance SMT group that's fully busy. Can benefit from migration
> +	 * a task on SMT with busy sibling to another CPU on idle core.
> +	 */
> +	group_smt_balance,

Would it make sense to move smt_balance?, s.t. we get:

group_has_spare < group_smt_balance < group_fully_busy

Conceptually I would be more intuitive to me like this as the
smt_balance groups are more busy than has_spare ones, but less busy
then fully_busy ones.

 From a functional perspective I could also see some impact when
update_sd_pick_busiest compares the group types. In that case we
would remove tasks from fully busy groups before moving them
from smt_balance groups. Not sure which way would be to prefer
to increase overall throughput.

Since smt_balance is only selected if the group has SMT, this
should still not pull the last task off of a non-SMT CPU.

>  	/*
>  	 * SD_ASYM_PACKING only: One local CPU with higher capacity is 
> available,
>  	 * and the task should be migrated to it instead of running on the
> @@ -8987,6 +8992,7 @@ struct sg_lb_stats {
>  	unsigned int group_weight;
>  	enum group_type group_type;
>  	unsigned int group_asym_packing; /* Tasks should be moved to 
> preferred CPU */
> +	unsigned int group_smt_balance;  /* Task on busy SMT be moved */
>  	unsigned long group_misfit_task_load; /* A CPU has a task too big
> for its capacity */
>  #ifdef CONFIG_NUMA_BALANCING
>  	unsigned int nr_numa_running;
> @@ -9260,6 +9266,9 @@ group_type group_classify(unsigned int 
> imbalance_pct,
>  	if (sgs->group_asym_packing)
>  		return group_asym_packing;
> 
> +	if (sgs->group_smt_balance)
> +		return group_smt_balance;
> +
>  	if (sgs->group_misfit_task_load)
>  		return group_misfit_task;
> 
> @@ -9333,6 +9342,36 @@ sched_asym(struct lb_env *env, struct
> sd_lb_stats *sds,  struct sg_lb_stats *sgs
>  	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
>  }
> 
> +/* One group has more than one SMT CPU while the other group does not 
> */
> +static inline bool smt_vs_nonsmt_groups(struct sched_group *sg1,
> +				    struct sched_group *sg2)
> +{
> +	if (!sg1 || !sg2)
> +		return false;
> +
> +	return (sg1->flags & SD_SHARE_CPUCAPACITY) !=
> +		(sg2->flags & SD_SHARE_CPUCAPACITY);
> +}
> +
> +static inline bool smt_balance(struct lb_env *env, struct sg_lb_stats 
> *sgs,
> +			       struct sched_group *group)
> +{
> +	if (env->idle == CPU_NOT_IDLE)
> +		return false;
> +
> +	/*
> +	 * For SMT source group, it is better to move a task
> +	 * to a CPU that doesn't have multiple tasks sharing its CPU 
> capacity.
> +	 * Note that if a group has a single SMT, SD_SHARE_CPUCAPACITY
> +	 * will not be on.
> +	 */
> +	if (group->flags & SD_SHARE_CPUCAPACITY &&
> +	    sgs->sum_h_nr_running > 1)
> +		return true;
> +
> +	return false;
> +}
> +
>  static inline bool
>  sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
>  {
> @@ -9425,6 +9464,10 @@ static inline void update_sg_lb_stats(struct 
> lb_env *env,
>  		sgs->group_asym_packing = 1;
>  	}
> 
> +	/* Check for loaded SMT group to be balanced to dst CPU */
> +	if (!local_group && smt_balance(env, sgs, group))
> +		sgs->group_smt_balance = 1;
> +
>  	sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
> 
>  	/* Computing avg_load makes sense only when group is overloaded */
> @@ -9509,6 +9552,7 @@ static bool update_sd_pick_busiest(struct lb_env 
> *env,
>  			return false;
>  		break;
> 
> +	case group_smt_balance:
>  	case group_fully_busy:
>  		/*
>  		 * Select the fully busy group with highest avg_load. In
> @@ -9537,6 +9581,18 @@ static bool update_sd_pick_busiest(struct lb_env 
> *env,
>  		break;
> 
>  	case group_has_spare:
> +		/*
> +		 * Do not pick sg with SMT CPUs over sg with pure CPUs,
> +		 * as we do not want to pull task off SMT core with one task
> +		 * and make the core idle.
> +		 */
> +		if (smt_vs_nonsmt_groups(sds->busiest, sg)) {
> +			if (sg->flags & SD_SHARE_CPUCAPACITY && sgs->sum_h_nr_running <= 1)
> +				return false;
> +			else
> +				return true;
> +		}
> +
>  		/*
>  		 * Select not overloaded group with lowest number of idle cpus
>  		 * and highest number of running tasks. We could also compare
> @@ -9733,6 +9789,7 @@ static bool update_pick_idlest(struct sched_group 
> *idlest,
> 
>  	case group_imbalanced:
>  	case group_asym_packing:
> +	case group_smt_balance:
>  		/* Those types are not used in the slow wakeup path */
>  		return false;
> 
> @@ -9864,6 +9921,7 @@ find_idlest_group(struct sched_domain *sd,
> struct task_struct *p, int this_cpu)
> 
>  	case group_imbalanced:
>  	case group_asym_packing:
> +	case group_smt_balance:
>  		/* Those type are not used in the slow wakeup path */
>  		return NULL;
> 
> @@ -10118,6 +10176,13 @@ static inline void calculate_imbalance(struct
> lb_env *env, struct sd_lb_stats *s
>  		return;
>  	}
> 
> +	if (busiest->group_type == group_smt_balance) {
> +		/* Reduce number of tasks sharing CPU capacity */
> +		env->migration_type = migrate_task;
> +		env->imbalance = 1;
> +		return;
> +	}
> +
>  	if (busiest->group_type == group_imbalanced) {
>  		/*
>  		 * In the group_imb case we cannot rely on group-wide averages
> @@ -10363,16 +10428,23 @@ static struct sched_group
> *find_busiest_group(struct lb_env *env)
>  		goto force_balance;
> 
>  	if (busiest->group_type != group_overloaded) {
> -		if (env->idle == CPU_NOT_IDLE)
> +		if (env->idle == CPU_NOT_IDLE) {
>  			/*
>  			 * If the busiest group is not overloaded (and as a
>  			 * result the local one too) but this CPU is already
>  			 * busy, let another idle CPU try to pull task.
>  			 */
>  			goto out_balanced;
> +		}
> +
> +		if (busiest->group_type == group_smt_balance &&
> +		    smt_vs_nonsmt_groups(sds.local, sds.busiest)) {
> +			/* Let non SMT CPU pull from SMT CPU sharing with sibling */
> +			goto force_balance;
> +		}
> 
>  		if (busiest->group_weight > 1 &&
> -		    local->idle_cpus <= (busiest->idle_cpus + 1))
> +		    local->idle_cpus <= (busiest->idle_cpus + 1)) {
>  			/*
>  			 * If the busiest group is not overloaded
>  			 * and there is no imbalance between this and busiest
> @@ -10383,12 +10455,14 @@ static struct sched_group
> *find_busiest_group(struct lb_env *env)
>  			 * there is more than 1 CPU per group.
>  			 */
>  			goto out_balanced;
> +		}
> 
> -		if (busiest->sum_h_nr_running == 1)
> +		if (busiest->sum_h_nr_running == 1) {
>  			/*
>  			 * busiest doesn't have any tasks waiting to run
>  			 */
>  			goto out_balanced;
> +		}
>  	}
> 
>  force_balance:
