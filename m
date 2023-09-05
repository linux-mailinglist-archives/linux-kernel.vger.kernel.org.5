Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D6C792BC0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242661AbjIEQ7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353773AbjIEIFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:05:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F828C4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 01:05:07 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3857dDmK031114;
        Tue, 5 Sep 2023 08:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bD6c/ia7cccQGCZlt0f6APoXVVKJEANlEFq0Uwbv8Ps=;
 b=aCuSVHzZANVnUX8DyYHr/C8eKMeO0Ac2rEtf5JdkhRm/1e1MKe/l30Cgwcc70aDC9gH+
 CKf4PH9LIcHqfjqQbzenlXhQtVyT6V5evH5Xda9bIMp91XhlPF8WF3ET0qRD6NZxEtAX
 OV3g0qkBwHNqZ4P5whP+axmZEpvMhaibaovkceiws29BseNrSoYiT4COdVynqLMJZsaA
 j33vfUFJDlATiP3AcKl/8c5V9LVLrbc7gXhcnLr9z6nr6IZCINNBdHrmj9SKaNeCe7vm
 mFr2CbT4YkIFh8RMF+MYx12jFB+FRDefbHl6gMGgGjRBjbDJGk8iNCsOwl4q2ts9KW4V XA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3swwa449qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 08:04:07 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3857uCuK021221;
        Tue, 5 Sep 2023 08:04:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3swwa449px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 08:04:06 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3856erd9021441;
        Tue, 5 Sep 2023 08:04:06 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svfry94c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 08:04:06 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385845OT7930370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 08:04:05 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F2D358052;
        Tue,  5 Sep 2023 08:04:05 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DFA358056;
        Tue,  5 Sep 2023 08:03:58 +0000 (GMT)
Received: from [9.109.201.126] (unknown [9.109.201.126])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  5 Sep 2023 08:03:58 +0000 (GMT)
Message-ID: <2428a381-1587-2beb-711f-3fab6d773975@linux.vnet.ibm.com>
Date:   Tue, 5 Sep 2023 13:33:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] sched/fair: Add SMT4 group_smt_balance handling
To:     Tim Chen <tim.c.chen@linux.intel.com>, peterz@infradead.org
Cc:     bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        hdanton@sina.com, ionela.voinescu@arm.com, juri.lelli@redhat.com,
        len.brown@intel.com, linux-kernel@vger.kernel.org, mgorman@suse.de,
        naveen.n.rao@linux.vnet.ibm.com, rafael.j.wysocki@intel.com,
        ravi.v.shankar@intel.com, ricardo.neri@intel.com,
        rostedt@goodmis.org, srikar@linux.vnet.ibm.com,
        srinivas.pandruvada@linux.intel.com, v-songbaohua@oppo.com,
        vincent.guittot@linaro.org, vschneid@redhat.com, x86@kernel.org,
        yangyicong@hisilicon.com, yu.c.chen@intel.com
References: <20230717133718.GJ4253@hirez.programming.kicks-ass.net>
 <20230717145823.1531759-1-sshegde@linux.vnet.ibm.com>
 <804548a12363479d41dee19bb843002d9e105afd.camel@linux.intel.com>
 <6b20e0c0cd82d0d1aafc2a7fb14d9456e19c2c85.camel@linux.intel.com>
 <4118c2e3-fd34-2ebe-3faa-1c6ac9cbbac2@linux.vnet.ibm.com>
 <61cb0511b15612f43f390c750d2e9325bd7af4dd.camel@linux.intel.com>
Content-Language: en-US
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <61cb0511b15612f43f390c750d2e9325bd7af4dd.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JpBfFJvZ4-Q6vAHn4rgo_HJMWKXI988Z
X-Proofpoint-ORIG-GUID: Wxgv96FkO1AyeiNaxx8S0wXKFCcfXoeC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_06,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050067
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/23 12:49 AM, Tim Chen wrote:
> On Mon, 2023-08-07 at 15:06 +0530, Shrikanth Hegde wrote:
>>>
>>> From: Tim Chen <tim.c.chen@linux.intel.com>
>>> Date: Fri, 14 Jul 2023 16:09:30 -0700
>>> Subject: [PATCH] sched/fair: Add SMT4 group_smt_balance handling
>>>
>>> For SMT4, any group with more than 2 tasks will be marked as
>>> group_smt_balance. Retain the behaviour of group_has_spare by marking
>>> the busiest group as the group which has the least number of idle_cpus.
>>>
>>> Also, handle rounding effect of adding (ncores_local + ncores_busy)
>>> when the local is fully idle and busy group has more than 2 tasks.
>>> Local group should try to pull at least 1 task in this case.
>>>
>>> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>>> ---
>>>  kernel/sched/fair.c | 18 ++++++++++++++++--
>>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index a87988327f88..566686c5f2bd 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -9563,7 +9563,7 @@ static inline long sibling_imbalance(struct lb_env *env,
>>>  	imbalance /= ncores_local + ncores_busiest;
>>>  
>>>  	/* Take advantage of resource in an empty sched group */
>>> -	if (imbalance == 0 && local->sum_nr_running == 0 &&
>>> +	if (imbalance <= 1 && local->sum_nr_running == 0 &&
>>>  	    busiest->sum_nr_running > 1)
>>>  		imbalance = 2;
>>>  
>>> @@ -9751,6 +9751,20 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>>>  		break;
>>>  
>>>  	case group_smt_balance:
>>> +		/* no idle cpus on both groups handled by group_fully_busy below */
>>> +		if (sgs->idle_cpus != 0 || busiest->idle_cpus != 0) {
>>> +			if (sgs->idle_cpus > busiest->idle_cpus)
>>> +				return false;
>>> +			if (sgs->idle_cpus < busiest->idle_cpus)
>>> +				return true;
>>> +			if (sgs->sum_nr_running <= busiest->sum_nr_running)
>>> +				return false;
>>> +			else
>>> +				return true;
>>> +		}
>>> +		goto fully_busy;
>>> +		break;
>>> +
>>>  	case group_fully_busy:
>>>  		/*
>>>  		 * Select the fully busy group with highest avg_load. In
>>> @@ -9763,7 +9777,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>>>  		 * select the 1st one, except if @sg is composed of SMT
>>>  		 * siblings.
>>>  		 */
>>> -
>>> +fully_busy:
>>>  		if (sgs->avg_load < busiest->avg_load)
>>>  			return false;
>>>  
>>
>> Hi Tim, Peter. 
>>
>> group_smt_balance(cluster scheduling), patches are in tip/sched/core. I dont 
>> see this above patch there yet. Currently as is, this can cause function difference 
>> in SMT4 systems( such as Power10). 
>>
>> Can we please have the above patch as well in tip/sched/core?
>>
>> Acked-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> 
> Hi Peter,
> 
> Just back from my long vacation.  Wonder if you have any comments on the above patch
> for fixing the SMT4 case?
> 
> Tim

Hi Tim, Peter. 

are there any concerns with the above patch for fixing the SMT4 case. 
Currently the behavior is group_smt_balance is set for having even 2 tasks in 
SMT4, ideally it should be same as the group_has_spare. 

The above patch copies the same behavior to group_smt_balance. 
> 
