Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC177933CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 04:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbjIFClZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 22:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjIFClY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:41:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C6ACEF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 19:41:21 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3862ccGU032388;
        Wed, 6 Sep 2023 02:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9bujf54NCHf3KSBcNaET4otaeiaDjlFfk9Ei2fJjjzM=;
 b=WG1QlHOQlDIj6uvX6FBLyQ00j8jR7EV7xIw5qnMWXIFCMsjhQajWvApkDhHbQpCEWAUZ
 ocQCT8EwRgakT9ccsRMGTCaAGZAjof5JqyRf1da1jNAIaCSW3x8Vl+bH7OCp0Kl77M0E
 DL2hAqynvkKbFyvSu54AMoMfOuMSCtHx69wOcpWTYl7nBGcS06Zi3fejMVR4hBefiGw8
 JfSk15dey+quun3bj1kTkdrgTAS7AORYEWlVIBTjxrV3gtjixmJvGiwmhT4b25Rxne+E
 +Vek1eIPJCkDD4+Do6DaY6GArHBESTOlSsCGkMiZ4dUbEn1nnKeyD5bgH85cCZ0ogfFi uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxgg0rbnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 02:41:01 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3862emRK008154;
        Wed, 6 Sep 2023 02:41:00 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxgg0rbmc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 02:41:00 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3861wiaE021412;
        Wed, 6 Sep 2023 02:06:40 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svfryfpbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 02:06:40 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38626dvu3998344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Sep 2023 02:06:39 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 369275805D;
        Wed,  6 Sep 2023 02:06:39 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0012E58052;
        Wed,  6 Sep 2023 02:06:33 +0000 (GMT)
Received: from [9.171.19.125] (unknown [9.171.19.125])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  6 Sep 2023 02:06:33 +0000 (GMT)
Message-ID: <6d958bf0-d0e9-ab6f-944f-62a123adf98d@linux.vnet.ibm.com>
Date:   Wed, 6 Sep 2023 07:36:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] sched/fair: optimize should_we_balance for higher SMT
 systems
Content-Language: en-US
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     dietmar.eggemann@arm.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org, yu.c.chen@intel.com,
        ricardo.neri-calderon@linux.intel.com, iamjoonsoo.kim@lge.com,
        juri.lelli@redhat.com, rocking@linux.alibaba.com,
        joshdon@google.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org
References: <20230902081204.232218-1-sshegde@linux.vnet.ibm.com>
 <925bbda25461035fdec1bebf8487f84f9a3852a7.camel@linux.intel.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <925bbda25461035fdec1bebf8487f84f9a3852a7.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gzCi4e1wHo6xdz1fAujZdC0loZjjNFiC
X-Proofpoint-ORIG-GUID: a8QBJiAcwcF3aBfaclXWY86SgHbArO92
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060021
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/23 1:00 AM, Tim Chen wrote:
> On Sat, 2023-09-02 at 13:42 +0530, Shrikanth Hegde wrote:
>>
>>
>> Fixes: b1bfeab9b002 ("sched/fair: Consider the idle state of the whole core for load balance")
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
>> ---
>>  kernel/sched/fair.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 0b7445cd5af9..6e31923293bb 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6619,6 +6619,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>  /* Working cpumask for: load_balance, load_balance_newidle. */
>>  static DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
>>  static DEFINE_PER_CPU(cpumask_var_t, select_rq_mask);
>> +static DEFINE_PER_CPU(cpumask_var_t, should_we_balance_tmpmask);
>>
>>  #ifdef CONFIG_NO_HZ_COMMON
>>
>> @@ -10913,6 +10914,7 @@ static int active_load_balance_cpu_stop(void *data);
>>
>>  static int should_we_balance(struct lb_env *env)
>>  {
>> +	struct cpumask *swb_cpus = this_cpu_cpumask_var_ptr(should_we_balance_tmpmask);
>>  	struct sched_group *sg = env->sd->groups;
>>  	int cpu, idle_smt = -1;
>>
>> @@ -10936,8 +10938,9 @@ static int should_we_balance(struct lb_env *env)
>>  		return 1;
>>  	}
>>
>> +	cpumask_copy(swb_cpus, group_balance_mask(sg));
>>  	/* Try to find first idle CPU */
>> -	for_each_cpu_and(cpu, group_balance_mask(sg), env->cpus) {
>> +	for_each_cpu_and(cpu, swb_cpus, env->cpus) {
>>  		if (!idle_cpu(cpu))
>>  			continue;
>>
>> @@ -10949,6 +10952,14 @@ static int should_we_balance(struct lb_env *env)
>>  		if (!(env->sd->flags & SD_SHARE_CPUCAPACITY) && !is_core_idle(cpu)) {
>>  			if (idle_smt == -1)
>>  				idle_smt = cpu;
>> +			/*
>> +			 * If the core is not idle, and first SMT sibling which is
>> +			 * idle has been found, then its not needed to check other
>> +			 * SMT siblings for idleness
>> +			 */
>> +#ifdef CONFIG_SCHED_SMT
>> +			cpumask_andnot(swb_cpus, swb_cpus, cpu_smt_mask(cpu));
>> +#endif
>>  			continue;
>>  		}
>>
>> @@ -12914,6 +12925,8 @@ __init void init_sched_fair_class(void)
>>  	for_each_possible_cpu(i) {
>>  		zalloc_cpumask_var_node(&per_cpu(load_balance_mask, i), GFP_KERNEL, cpu_to_node(i));
>>  		zalloc_cpumask_var_node(&per_cpu(select_rq_mask,    i), GFP_KERNEL, cpu_to_node(i));
>> +		zalloc_cpumask_var_node(&per_cpu(should_we_balance_tmpmask, i),
>> +					GFP_KERNEL, cpu_to_node(i));
> 
> Shrianth,
> 

Hi Tim,

Thanks for taking a look at this patch.

> Wonder if we can avoid allocating the 
> should_we_balance_tmpmask for SMT2 case to save memory
> for system with large number of cores.
> 
> The new mask and logic I think is only needed for more than 2 threads in a core.

Code would have to be refactored quite a bit if one needs to take
different approach for specific SMT setting. 

I think there would some cases in SMT2 that will benefit as well. 
Lets say 1 cpu in each core is busy. the busy CPU happens to be second 
CPU in the core. In that case, this approach would skip that instead of 
checking if that is idle or not. 

> 
> Tim
>>
>>  #ifdef CONFIG_CFS_BANDWIDTH
>>  		INIT_CSD(&cpu_rq(i)->cfsb_csd, __cfsb_csd_unthrottle, cpu_rq(i));
>> --
>> 2.31.1
>>
> 
