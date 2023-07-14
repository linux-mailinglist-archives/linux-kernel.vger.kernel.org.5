Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48C4753D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbjGNOXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjGNOXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:23:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A509E1989
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:23:35 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EEFmMo004203;
        Fri, 14 Jul 2023 14:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : in-reply-to : references : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=qDUC/BWDvdnxDGxf/kA3D9poCce32j4DyQ9kk0eF81I=;
 b=g5GHfmfKX8in0UV980DT0nbAqzoFB+QFSdvsGLYmilXLzsDmmaS4zi8WnzRl3oqq1AOC
 hvOvSHtB/g3yLV5Jg+YRUunxoCu04TlYoMoYiiwnaOm8nP8mHBMmSNZkHAJeQ8mEd+++
 99MYLtLztX3feSRdxo+ePySu34s5yL8KTjljS8mtJvqNq4NfyRNjBKz03TMbLGRVSMJc
 q3pgevbsH9TNi+KKoW4OGow5tfxTSfMMWwpOd8rRV+78wQj5882KUt6jhL7im+hXuBMB
 +j41jHc9mVfhm3tf/4Ja0Ix2yTfbHdr9e1M3lhEqYxV415HgyCPA6rA7dMCgyfILDb6C CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru76d1ve5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 14:23:01 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36EEF8SA001855;
        Fri, 14 Jul 2023 14:23:00 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru76d1vd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 14:23:00 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36EDwTnv008407;
        Fri, 14 Jul 2023 14:22:59 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3rtq33pa4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 14:22:59 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36EEMvqA64618852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 14:22:57 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73F6D58056;
        Fri, 14 Jul 2023 14:22:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 608EF58052;
        Fri, 14 Jul 2023 14:22:56 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jul 2023 14:22:56 +0000 (GMT)
Date:   Fri, 14 Jul 2023 16:22:56 +0200
From:   Tobias Huschle <huschle@linux.ibm.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>
Subject: Re: [Patch v3 3/6] sched/fair: Implement prefer sibling imbalance
 calculation between asymmetric groups
In-Reply-To: <c5a49136-3549-badd-ec8f-3de4e7bb7b7d@linux.vnet.ibm.com>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
 <4eacbaa236e680687dae2958378a6173654113df.1688770494.git.tim.c.chen@linux.intel.com>
 <c5a49136-3549-badd-ec8f-3de4e7bb7b7d@linux.vnet.ibm.com>
Message-ID: <b119d88384584e603056cec942c47e14@linux.ibm.com>
X-Sender: huschle@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x4fP2Kbm7SmaVyZtr8AWSdnategrfnV9
X-Proofpoint-ORIG-GUID: PrBxZ7kOq7lnNk58PuxeO1m-HPFztuda
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 clxscore=1011
 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-14 15:14, Shrikanth Hegde wrote:
> On 7/8/23 4:27 AM, Tim Chen wrote:
>> From: Tim C Chen <tim.c.chen@linux.intel.com>
>> 
>> In the current prefer sibling load balancing code, there is an 
>> implicit
>> assumption that the busiest sched group and local sched group are
>> equivalent, hence the tasks to be moved is simply the difference in
>> number of tasks between the two groups (i.e. imbalance) divided by 
>> two.
>> 
>> However, we may have different number of cores between the cluster 
>> groups,
>> say when we take CPU offline or we have hybrid groups.  In that case,
>> we should balance between the two groups such that #tasks/#cores ratio
>> is the same between the same between both groups.  Hence the imbalance
> 
> nit: type here. the same between is repeated.
> 
>> computed will need to reflect this.
>> 
>> Adjust the sibling imbalance computation to take into account of the
>> above considerations.
>> 
>> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>> ---
>>  kernel/sched/fair.c | 41 +++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 37 insertions(+), 4 deletions(-)
>> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index f636d6c09dc6..f491b94908bf 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9372,6 +9372,41 @@ static inline bool smt_balance(struct lb_env 
>> *env, struct sg_lb_stats *sgs,
>>  	return false;
>>  }
>> 
>> +static inline long sibling_imbalance(struct lb_env *env,
>> +				    struct sd_lb_stats *sds,
>> +				    struct sg_lb_stats *busiest,
>> +				    struct sg_lb_stats *local)
>> +{
>> +	int ncores_busiest, ncores_local;
>> +	long imbalance;
> 
> can imbalance be unsigned int or unsigned long? as sum_nr_running is
> unsigned int.
> 
>> +
>> +	if (env->idle == CPU_NOT_IDLE || !busiest->sum_nr_running)
>> +		return 0;
>> +
>> +	ncores_busiest = sds->busiest->cores;
>> +	ncores_local = sds->local->cores;
>> +
>> +	if (ncores_busiest == ncores_local) {
>> +		imbalance = busiest->sum_nr_running;
>> +		lsub_positive(&imbalance, local->sum_nr_running);
>> +		return imbalance;
>> +	}
>> +
>> +	/* Balance such that nr_running/ncores ratio are same on both groups 
>> */
>> +	imbalance = ncores_local * busiest->sum_nr_running;
>> +	lsub_positive(&imbalance, ncores_busiest * local->sum_nr_running);
>> +	/* Normalize imbalance and do rounding on normalization */
>> +	imbalance = 2 * imbalance + ncores_local + ncores_busiest;
>> +	imbalance /= ncores_local + ncores_busiest;
>> +
> 
> Could this work for case where number of CPU/cores would differ
> between two sched groups in a sched domain? Such as problem pointed
> by tobias on S390. It would be nice if this patch can work for that 
> case
> as well. Ran numbers for a few cases. It looks to work.
> https://lore.kernel.org/lkml/20230704134024.GV4253@hirez.programming.kicks-ass.net/T/#rb0a7dcd28532cafc24101e1d0aed79e6342e3901
> 


Just stumbled upon this patch series as well. In this version it looks
similar to the prototypes I played around with, but more complete.
So I'm happy that my understanding of the load balancer was kinda 
correct :)

 From a functional perspective this appears to address the issues we saw 
on s390.

> 
> 
>> +	/* Take advantage of resource in an empty sched group */
>> +	if (imbalance == 0 && local->sum_nr_running == 0 &&
>> +	    busiest->sum_nr_running > 1)
>> +		imbalance = 2;
>> +
> 
> I don't see how this case would be true. When there are unequal number
> of cores and local->sum_nr_ruuning
> is 0, and busiest->sum_nr_running is atleast 2, imbalance will be 
> atleast 1.
> 
> 
> Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> 
>> +	return imbalance;
>> +}
>> +
>>  static inline bool
>>  sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
>>  {
>> @@ -10230,14 +10265,12 @@ static inline void 
>> calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>>  		}
>> 
>>  		if (busiest->group_weight == 1 || sds->prefer_sibling) {
>> -			unsigned int nr_diff = busiest->sum_nr_running;
>>  			/*
>>  			 * When prefer sibling, evenly spread running tasks on
>>  			 * groups.
>>  			 */
>>  			env->migration_type = migrate_task;
>> -			lsub_positive(&nr_diff, local->sum_nr_running);
>> -			env->imbalance = nr_diff;
>> +			env->imbalance = sibling_imbalance(env, sds, busiest, local);
>>  		} else {
>> 
>>  			/*
>> @@ -10424,7 +10457,7 @@ static struct sched_group 
>> *find_busiest_group(struct lb_env *env)
>>  	 * group's child domain.
>>  	 */
>>  	if (sds.prefer_sibling && local->group_type == group_has_spare &&
>> -	    busiest->sum_nr_running > local->sum_nr_running + 1)
>> +	    sibling_imbalance(env, &sds, busiest, local) > 1)
>>  		goto force_balance;
>> 
>>  	if (busiest->group_type != group_overloaded) {
