Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAC6758029
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjGROx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjGROx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:53:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FACE0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:53:55 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IEgkqE008484;
        Tue, 18 Jul 2023 14:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XIp8z3jIIhYauQFOu/3oRBToWVML3unFqe8noI1eh5o=;
 b=f2fi0BMFQsTarky5CoraRa3WOgPZH5CL7Ew7txUatdepcnj0Tm/bLxpdaZFz7d3NpfEX
 oWRmeaFGvU3kiYdY8mvu0Wj+CBOYCqigoT+aLlg66E3m9voqBl77iuGbZqieTbg0VrG9
 1wOAzIfe2WIh1tous9UOihWRKACj0yDZZg6CgXfhXfW1EOxZ8NvMsiPVNIh3GUpS4Qeq
 5JzGeDyB5PY5E9JwPNj+e+dzpCGX8CEYkDfq85KQfQln6lp3TIY/Kyo5MbbZUdKtHmga
 KCfWJIYA6ADlWuCOpjwodquz8Rl8xUBIoy2PtL6/nm/+XmM5jEE7CmKUXJjGPSvJRvDs fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwvr6gfvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 14:52:37 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36IEhMCf013057;
        Tue, 18 Jul 2023 14:52:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwvr6gfur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 14:52:36 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36ICYvo0030570;
        Tue, 18 Jul 2023 14:52:35 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv79jk187-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 14:52:35 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36IEqYA08127026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 14:52:34 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 726D358059;
        Tue, 18 Jul 2023 14:52:34 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA1845805D;
        Tue, 18 Jul 2023 14:52:25 +0000 (GMT)
Received: from [9.171.75.34] (unknown [9.171.75.34])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 18 Jul 2023 14:52:25 +0000 (GMT)
Message-ID: <c15b1322-074d-b400-bc7b-2a0031862fdd@linux.vnet.ibm.com>
Date:   Tue, 18 Jul 2023 20:22:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Patch v3 1/6] sched/fair: Determine active load balance for SMT
 sched groups
Content-Language: en-US
To:     Tobias Huschle <huschle@linux.ibm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
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
 <1109f49642faf60438717eb7716b324f@linux.ibm.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <1109f49642faf60438717eb7716b324f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jlfqGZBeOjL8ZVQCs7DPu7wvcO5ejEOP
X-Proofpoint-ORIG-GUID: wER6iIST69DshWpcHJBKJf2FaUW5W_cq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_11,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180134
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/23 11:37 AM, Tobias Huschle wrote:
> On 2023-07-15 01:05, Tim Chen wrote:
>> On Fri, 2023-07-14 at 18:36 +0530, Shrikanth Hegde wrote:
>>
>>>
>>>
>>> If we consider symmetric platforms which have SMT4 such as power10.
>>> we have a topology like below. multiple such MC will form DIE(PKG)
>>>
>>>
>>> [0 2 4 6][1 3 5 7][8 10 12 14][9 11 13 15]
>>> [--SMT--][--SMT--][----SMT---][---SMT----]
>>> [--sg1--][--sg1--][---sg1----][---sg1----]
>>> [--------------MC------------------------]
>>>
>>> In case of SMT4, if there is any group which has 2 or more tasks, that
>>> group will be marked as group_smt_balance. previously, if that group
>>> had 2
>>> or 3 tasks, it would have been marked as group_has_spare. Since all
>>> the groups have
>>> SMT that means behavior would be same fully busy right? That can
>>> cause some
>>> corner cases. No?
>>
>> You raised a good point. I was looking from SMT2
>> perspective so group_smt_balance implies group_fully_busy.
>> That is no longer true for SMT4.
>>
>> I am thinking of the following fix on the current patch
>> to take care of SMT4. Do you think this addresses
>> concerns from you and Tobias?
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 294a662c9410..3fc8d3a3bd22 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9588,6 +9588,17 @@ static bool update_sd_pick_busiest(struct
>> lb_env *env,
>>                 break;
>>
>>         case group_smt_balance:
>> +               /* no idle cpus on both groups handled by
>> group_fully_busy below */
>> +               if (sgs->idle_cpus != 0 || busiest->idle_cpus != 0) {
>> +                       if (sgs->idle_cpus > busiest->idle_cpus)
>> +                               return false;
>> +                       if (sgs->idle_cpus < busiest->idle_cpus)
>> +                               return true;
>> +                       if (sgs->sum_nr_running <=
>> busiest_sum_nr_running)
>> +                               return false;
>> +                       else
>> +                               return true;
>> +               }
>>
>>
>> I will be on vacation next three weeks so my response will be slow.
>>
>> Tim
>>
> 
> What if the setup is asymmetric, where SMT2 and SMT4 would mix, e.g.
> 
> [0 1][2 3 4 5]
> [SMT][--SMT--]
> 
> If now CPUs 0,2,3 have a running task, both groups would be classified as
> smt_balance. But if it comes to the selection of the busiest group, the
> smaller
> group would be selected, as it has less idle CPUs, right? Which could lead
> to the smaller group being left with no tasks.
> Using the absolute numbers of task is what made the prefer_sibling path
> problematic,


Yes. But Not sure how realistic is that configuration. on power10, we typically
have all cores in either SMT1, SMT2 or SMT4. But not mixed configs.
One can offline a CPUs to get into that cases in SMT4. 

> I would assume that the same holds true here. Therefore, I would prefer
> avg_load,
> or, similar to prefer_siblings, a ratio over the number of cores.
> 
> I can't really test that on s390 as we always have SMT2. But, we can
> have these
> asymmetries on higher levels, e.g


IIUC, on higher levels, group will not have SD_SHARE_CPUCAPACITY, so it shouldn't 
run into group_smt_balance. 

> 
> [0 1][2 3][4 5][6 7][8 9]
> [SMT][SMT][SMT][SMT][SMT]
> [-----core----][--core--]
> 
> For large configurations this can be true for even higher levels.
> Therefore, the idea was to move the smt_balance state around and adapt its
> conditions to something like this (which would require to reorder the
> commits):
> 
> @@ -8330,6 +8330,11 @@ enum fbq_type { regular, remote, all };
>  enum group_type {
>         /* The group has spare capacity that can be used to run more
> tasks.  */
>         group_has_spare = 0,
> +       /*
> +        * Balance SMT group that's fully busy. Can benefit from migration
> +        * a task on SMT with busy sibling to another CPU on idle core.
> +        */
> +       group_smt_balance,
>         /*
>          * The group is fully used and the tasks don't compete for more CPU
>          * cycles. Nevertheless, some tasks might wait before running.
> @@ -8340,11 +8345,6 @@ enum group_type {
>          * more powerful CPU.
>          */
>         group_misfit_task,
> -       /*
> -        * Balance SMT group that's fully busy. Can benefit from migration
> -        * a task on SMT with busy sibling to another CPU on idle core.
> -        */
> -       group_smt_balance,
>         /*
>          * SD_ASYM_PACKING only: One local CPU with higher capacity is
> available,


IIUC, for cluster topology of this patch, busiest group should be a SMT if it has 2 
threads compared to an Atom cluster having 4 threads. Atom cluster will be group_fully_busy, 
whereas SMT group will be group_smt_balance. For that to happen group_smt_balance should have 
higher group_type. 

>          * and the task should be migrated to it instead of running on the
> @@ -9327,15 +9327,15 @@ group_type group_classify(unsigned int
> imbalance_pct,
>         if (sgs->group_asym_packing)
>                 return group_asym_packing;
> 
> -       if (sgs->group_smt_balance)
> -               return group_smt_balance;
> -
>         if (sgs->group_misfit_task_load)
>                 return group_misfit_task;
> 
>         if (!group_has_capacity(imbalance_pct, sgs))
>                 return group_fully_busy;
> 
> +       if (sgs->group_smt_balance)
> +               return group_smt_balance;
> +
>         return group_has_spare;
>  }
> 
> @@ -9457,8 +9457,7 @@ static inline bool smt_balance(struct lb_env *env,
> struct sg_lb_stats *sgs,
>          * Note that if a group has a single SMT, SD_SHARE_CPUCAPACITY
>          * will not be on.
>          */
> -       if (group->flags & SD_SHARE_CPUCAPACITY &&
> -           sgs->sum_h_nr_running > 1)
> +       if (sgs->sum_h_nr_running > group->cores)

In case of Power10, where we have SMT4, group->cores will be 1. I dont see 
a difference here.

>                 return true;
> 
>         return false;
> 
> The s390 problem is currently solved by changing the prefer_sibling
> path. When
> disabling that flag, we might have an issue, will have to verify that
> though.
> 
>>>
>>> One example is Lets say sg1 has 4 tasks. and sg2 has 0 tasks and is
>>> trying to do
>>> load balance. Previously imbalance would have been 2, instead now
>>> imbalance would be 1.
>>> But in subsequent lb it would be balanced.
>>>
>>>
>>>
>>> > +    return false;
>>> > +}
>>> > +
>>> >  static inline bool
>>> >  sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
>>> >  {
>>> > @@ -9425,6 +9464,10 @@ static inline void update_sg_lb_stats(struct
>>> lb_env *env,
>>> >          sgs->group_asym_packing = 1;
>>> >      }
>>> >
>>> > +    /* Check for loaded SMT group to be balanced to dst CPU */
>>> > +    if (!local_group && smt_balance(env, sgs, group))
>>> > +        sgs->group_smt_balance = 1;
>>> > +
>>> >      sgs->group_type = group_classify(env->sd->imbalance_pct,
>>> group, sgs);
>>> >
>>> >      /* Computing avg_load makes sense only when group is
>>> overloaded */
>>> > @@ -9509,6 +9552,7 @@ static bool update_sd_pick_busiest(struct
>>> lb_env *env,
>>> >              return false;
>>> >          break;
>>> >
>>> > +    case group_smt_balance:
>>> >      case group_fully_busy:
>>> >          /*
>>> >           * Select the fully busy group with highest avg_load. In
>>> > @@ -9537,6 +9581,18 @@ static bool update_sd_pick_busiest(struct
>>> lb_env *env,
>>> >          break;
>>> >
>>> >      case group_has_spare:
>>> > +        /*
>>> > +         * Do not pick sg with SMT CPUs over sg with pure CPUs,
>>> > +         * as we do not want to pull task off SMT core with one task
>>> > +         * and make the core idle.
>>> > +         */
>>> > +        if (smt_vs_nonsmt_groups(sds->busiest, sg)) {
>>> > +            if (sg->flags & SD_SHARE_CPUCAPACITY &&
>>> sgs->sum_h_nr_running <= 1)
>>> > +                return false;
>>> > +            else
>>> > +                return true;> +        }
>>> > +
>>> >          /*
>>> >           * Select not overloaded group with lowest number of idle
>>> cpus
>>> >           * and highest number of running tasks. We could also compare
>>> > @@ -9733,6 +9789,7 @@ static bool update_pick_idlest(struct
>>> sched_group *idlest,
>>> >
>>> >      case group_imbalanced:
>>> >      case group_asym_packing:
>>> > +    case group_smt_balance:
>>> >          /* Those types are not used in the slow wakeup path */
>>> >          return false;
>>> >
>>> > @@ -9864,6 +9921,7 @@ find_idlest_group(struct sched_domain *sd,
>>> struct task_struct *p, int this_cpu)
>>> >
>>> >      case group_imbalanced:
>>> >      case group_asym_packing:
>>> > +    case group_smt_balance:
>>> >          /* Those type are not used in the slow wakeup path */
>>> >          return NULL;
>>> >
>>> > @@ -10118,6 +10176,13 @@ static inline void
>>> calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>>> >          return;
>>> >      }
>>> >
>>> > +    if (busiest->group_type == group_smt_balance) {
>>> > +        /* Reduce number of tasks sharing CPU capacity */
>>> > +        env->migration_type = migrate_task;
>>> > +        env->imbalance = 1;
>>> > +        return;
>>> > +    }
>>> > +
>>> >      if (busiest->group_type == group_imbalanced) {
>>> >          /*
>>> >           * In the group_imb case we cannot rely on group-wide
>>> averages
>>> > @@ -10363,16 +10428,23 @@ static struct sched_group
>>> *find_busiest_group(struct lb_env *env)
>>> >          goto force_balance;
>>> >
>>> >      if (busiest->group_type != group_overloaded) {
>>> > -        if (env->idle == CPU_NOT_IDLE)
>>> > +        if (env->idle == CPU_NOT_IDLE) {
>>> >              /*
>>> >               * If the busiest group is not overloaded (and as a
>>> >               * result the local one too) but this CPU is already
>>> >               * busy, let another idle CPU try to pull task.
>>> >               */
>>> >              goto out_balanced;
>>> > +        }
>>> > +
>>> > +        if (busiest->group_type == group_smt_balance &&
>>> > +            smt_vs_nonsmt_groups(sds.local, sds.busiest)) {
>>> > +            /* Let non SMT CPU pull from SMT CPU sharing with
>>> sibling */
>>> > +            goto force_balance;
>>> > +        }
>>> >
>>> >          if (busiest->group_weight > 1 &&
>>> > -            local->idle_cpus <= (busiest->idle_cpus + 1))
>>> > +            local->idle_cpus <= (busiest->idle_cpus + 1)) {
>>> >              /*
>>> >               * If the busiest group is not overloaded
>>> >               * and there is no imbalance between this and busiest
>>> > @@ -10383,12 +10455,14 @@ static struct sched_group
>>> *find_busiest_group(struct lb_env *env)
>>> >               * there is more than 1 CPU per group.
>>> >               */
>>> >              goto out_balanced;
>>> > +        }
>>> >
>>> > -        if (busiest->sum_h_nr_running == 1)
>>> > +        if (busiest->sum_h_nr_running == 1) {
>>> >              /*
>>> >               * busiest doesn't have any tasks waiting to run
>>> >               */
>>> >              goto out_balanced;
>>> > +        }
>>> >      }
>>> >
>>> >  force_balance:
