Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A86D797481
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbjIGPjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345339AbjIGPf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:35:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DE1171F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:35:04 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3878pHj9027889;
        Thu, 7 Sep 2023 08:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=0Dr7Wv8CzljgZR/li9i58jhN7nkO6uYqGT/YUKfRNBg=;
 b=W88iQyyfeeCRFCMjiKzg8Bmm1yLraHNNkcjDP9fRO9Vp0t+yA+ncZUY2fBsuhinPNTS7
 4khMQU9aCDHbCb1zjElflbMkP8RvqGbvsN7oMfjqMfXL9NYzBBKvr7yqKbxCEcfX/2KW
 bT6SV0II6m7aWYFfzRyrtrYDH70FkdfSCWfvIg3f7R2URyhQumUzGNVn0GwYJ+/rRkhP
 ej6MhI2evgrX1z3xsHXoWfgQnmFZBClBaVY7nMfzfP4X1BlZFs55vIWW8Ol1gsDdb7ar
 ZIqQGhNhzpRMKc8uUq3PfVxibmTNuqbJ0m67YuihUa8vZqfc2DYEM6n2MES9CcE+phNO IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sybcfg5he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 08:58:19 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3878rAjP001502;
        Thu, 7 Sep 2023 08:58:18 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sybcfg5h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 08:58:18 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38778LUB011145;
        Thu, 7 Sep 2023 08:58:17 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svj321u4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 08:58:17 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3878wG2R56558026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Sep 2023 08:58:16 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 702B158056;
        Thu,  7 Sep 2023 08:58:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7997D58052;
        Thu,  7 Sep 2023 08:58:09 +0000 (GMT)
Received: from [9.109.201.126] (unknown [9.109.201.126])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  7 Sep 2023 08:58:09 +0000 (GMT)
Message-ID: <882ed331-4345-014b-d06f-9b3a3a6f688f@linux.vnet.ibm.com>
Date:   Thu, 7 Sep 2023 14:28:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] sched/fair: Add SMT4 group_smt_balance handling
Content-Language: en-US
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        hdanton@sina.com, ionela.voinescu@arm.com, juri.lelli@redhat.com,
        len.brown@intel.com, linux-kernel@vger.kernel.org, mgorman@suse.de,
        naveen.n.rao@linux.vnet.ibm.com, rafael.j.wysocki@intel.com,
        ravi.v.shankar@intel.com, ricardo.neri@intel.com,
        rostedt@goodmis.org, srikar@linux.vnet.ibm.com,
        srinivas.pandruvada@linux.intel.com, v-songbaohua@oppo.com,
        vincent.guittot@linaro.org, vschneid@redhat.com, x86@kernel.org,
        yangyicong@hisilicon.com, yu.c.chen@intel.com,
        Peter Zijlstra <peterz@infradead.org>
References: <20230717133718.GJ4253@hirez.programming.kicks-ass.net>
 <20230717145823.1531759-1-sshegde@linux.vnet.ibm.com>
 <804548a12363479d41dee19bb843002d9e105afd.camel@linux.intel.com>
 <6b20e0c0cd82d0d1aafc2a7fb14d9456e19c2c85.camel@linux.intel.com>
 <4118c2e3-fd34-2ebe-3faa-1c6ac9cbbac2@linux.vnet.ibm.com>
 <61cb0511b15612f43f390c750d2e9325bd7af4dd.camel@linux.intel.com>
 <2428a381-1587-2beb-711f-3fab6d773975@linux.vnet.ibm.com>
 <dee7575cc9d3c42c9705348151a1453ff084d4f3.camel@linux.intel.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <dee7575cc9d3c42c9705348151a1453ff084d4f3.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IwV-wAWyf4ldC7A8jLHpKaLkwv_LL7eb
X-Proofpoint-GUID: vruC597RC81VWR_iyCVVjO3GmyQ1ljlV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070074
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/23 12:07 AM, Tim Chen wrote:
> On Tue, 2023-09-05 at 13:33 +0530, Shrikanth Hegde wrote:
>>
>> On 8/22/23 12:49 AM, Tim Chen wrote:
>>> On Mon, 2023-08-07 at 15:06 +0530, Shrikanth Hegde wrote:
>>>>>
>>>>> From: Tim Chen <tim.c.chen@linux.intel.com>
>>>>> Date: Fri, 14 Jul 2023 16:09:30 -0700
>>>>> Subject: [PATCH] sched/fair: Add SMT4 group_smt_balance handling
>>>>>
>>>>> For SMT4, any group with more than 2 tasks will be marked as
>>>>> group_smt_balance. Retain the behaviour of group_has_spare by marking
>>>>> the busiest group as the group which has the least number of idle_cpus.
>>>>>
>>>>> Also, handle rounding effect of adding (ncores_local + ncores_busy)
>>>>> when the local is fully idle and busy group has more than 2 tasks.
>>>>> Local group should try to pull at least 1 task in this case.
>>>>>
>>>>> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>>>>> ---
>>>>>  kernel/sched/fair.c | 18 ++++++++++++++++--
>>>>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>> index a87988327f88..566686c5f2bd 100644
>>>>> --- a/kernel/sched/fair.c
>>>>> +++ b/kernel/sched/fair.c
>>>>> @@ -9563,7 +9563,7 @@ static inline long sibling_imbalance(struct lb_env *env,
>>>>>  	imbalance /= ncores_local + ncores_busiest;
>>>>>  
>>>>>  	/* Take advantage of resource in an empty sched group */
>>>>> -	if (imbalance == 0 && local->sum_nr_running == 0 &&
>>>>> +	if (imbalance <= 1 && local->sum_nr_running == 0 &&
>>>>>  	    busiest->sum_nr_running > 1)
>>>>>  		imbalance = 2;
>>>>>  
>>>>> @@ -9751,6 +9751,20 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>>>>>  		break;
>>>>>  
>>>>>  	case group_smt_balance:
>>>>> +		/* no idle cpus on both groups handled by group_fully_busy below */
>>>>> +		if (sgs->idle_cpus != 0 || busiest->idle_cpus != 0) {
>>>>> +			if (sgs->idle_cpus > busiest->idle_cpus)
>>>>> +				return false;
>>>>> +			if (sgs->idle_cpus < busiest->idle_cpus)
>>>>> +				return true;
>>>>> +			if (sgs->sum_nr_running <= busiest->sum_nr_running)
>>>>> +				return false;
>>>>> +			else
>>>>> +				return true;
>>>>> +		}
>>>>> +		goto fully_busy;
>>>>> +		break;
>>>>> +
>>>>>  	case group_fully_busy:
>>>>>  		/*
>>>>>  		 * Select the fully busy group with highest avg_load. In
>>>>> @@ -9763,7 +9777,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>>>>>  		 * select the 1st one, except if @sg is composed of SMT
>>>>>  		 * siblings.
>>>>>  		 */
>>>>> -
>>>>> +fully_busy:
>>>>>  		if (sgs->avg_load < busiest->avg_load)
>>>>>  			return false;
>>>>>  
>>>>
>>>> Hi Tim, Peter. 
>>>>
>>>> group_smt_balance(cluster scheduling), patches are in tip/sched/core. I dont 
>>>> see this above patch there yet. Currently as is, this can cause function difference 
>>>> in SMT4 systems( such as Power10). 
>>>>
>>>> Can we please have the above patch as well in tip/sched/core?
>>>>
>>>> Acked-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
>>>
>>> Hi Peter,
>>>
>>> Just back from my long vacation.  Wonder if you have any comments on the above patch
>>> for fixing the SMT4 case?
>>>
>>> Tim
>>
>> Hi Tim, Peter. 
>>
>> are there any concerns with the above patch for fixing the SMT4 case. 
>> Currently the behavior is group_smt_balance is set for having even 2 tasks in 
>> SMT4, ideally it should be same as the group_has_spare. 
>>
>> The above patch copies the same behavior to group_smt_balance. 
>>>
> 
> You mean simplify the patch as below?  I think that should be fine.  Can you
> make sure it works for SMT4?  And I can update the patch once you confirm it
> works properly.
> 
> Tim
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6e7ee2efc1ba..48e9ab7f8a87 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9764,16 +9764,9 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  
>         case group_smt_balance:
>                 /* no idle cpus on both groups handled by group_fully_busy below */
> -               if (sgs->idle_cpus != 0 || busiest->idle_cpus != 0) {
> -                       if (sgs->idle_cpus > busiest->idle_cpus)
> -                               return false;
> -                       if (sgs->idle_cpus < busiest->idle_cpus)
> -                               return true;
> -                       if (sgs->sum_nr_running <= busiest->sum_nr_running)
> -                               return false;
> -                       else
> -                               return true;
> -               }
> +               if (sgs->idle_cpus != 0 || busiest->idle_cpus != 0)
> +                       goto has_spare;
> +
>                 goto fully_busy;
>  
>         case group_fully_busy:
> @@ -9809,6 +9802,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>                  * as we do not want to pull task off SMT core with one task
>                  * and make the core idle.
>                  */
> +has_spare:
>                 if (smt_vs_nonsmt_groups(sds->busiest, sg)) {
>                         if (sg->flags & SD_SHARE_CPUCAPACITY && sgs->sum_h_nr_running <= 1)
>                                 return false;
> 
> 
> 

Hi Tim,

In case you were waiting for my reply as inferred from other email. 
The above change looks fine as well. This would avoid duplication of
code for group_smt_balance. 

Acked-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
