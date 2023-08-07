Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF2F771D32
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjHGJgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGJgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:36:45 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B826E10C0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:36:44 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3779Ukco012472;
        Mon, 7 Aug 2023 09:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=S8JaB/vJWjmlBH/fjXcCdlcv+yR7eJvBPZozqXMRwrU=;
 b=YyF83nRZ4ZIwlBRXkkba0k8OPf8Q11EMdk5gFWlx7e/CnaY2sebbVAWMyhD3osDLwez7
 G5KffrqKneK08iM2z33k3ZpG2w+8VBaN36bcKCYhe/SJ1iMqIlXCprqoKqTCInwlUrPM
 SLmwTHM2zJI2y5u0qAaxaLyqiKpx7SyrIPIV+erU8Isgaz8Asx/l0yEHgx0DCKHHdKbq
 2rA+uEGgw5vzCzU4CSZE8u+ij56Kvc5M5v+XWu0LYUjdN8fKNIPlYg6xKVtXfqDZ7tET
 I1spYL1TTXRQkmhbd05PhfQHn4RGOSp/0fW1x5Z0AoJONk7UVhcR/PMAa2h3wreitLfx zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sax1r8761-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 09:36:15 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3779WiFs019817;
        Mon, 7 Aug 2023 09:36:14 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sax1r873q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 09:36:14 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3778fPWY000373;
        Mon, 7 Aug 2023 09:36:12 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa28k3qbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 09:36:12 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3779aCjK6816426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Aug 2023 09:36:12 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1729D5805E;
        Mon,  7 Aug 2023 09:36:12 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13FA058055;
        Mon,  7 Aug 2023 09:36:04 +0000 (GMT)
Received: from [9.171.50.251] (unknown [9.171.50.251])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  7 Aug 2023 09:36:03 +0000 (GMT)
Message-ID: <4118c2e3-fd34-2ebe-3faa-1c6ac9cbbac2@linux.vnet.ibm.com>
Date:   Mon, 7 Aug 2023 15:06:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
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
Content-Language: en-US
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <6b20e0c0cd82d0d1aafc2a7fb14d9456e19c2c85.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KINogrnH4GTzkfA05HQzi50idPPGSgEy
X-Proofpoint-GUID: -C03-iJ9So3KFkSN-UUhTaerv1MZmkBr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_08,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 phishscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070088
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/23 7:02 PM, Tim Chen wrote:
> On Wed, 2023-07-26 at 20:11 -0700, Tim Chen wrote:
>> On Mon, 2023-07-17 at 20:28 +0530, Shrikanth Hegde wrote:
>>> From: Tim Chen <tim.c.chen@linux.intel.com>
>>>
>>> For SMT4, any group with more than 2 tasks will be marked as
>>> group_smt_balance. Retain the behaviour of group_has_spare by marking
>>> the busiest group as the group which has the least number of idle_cpus.
>>>
>>> Also, handle rounding effect of adding (ncores_local + ncores_busy)
>>> when the local is fully idle and busy group has more than 2 tasks.
>>> Local group should try to pull at least 1 task in this case.
>>>
>>> Originally-by: Tim Chen <tim.c.chen@linux.intel.com>
>>> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>>> Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
>>> ---
>>>  kernel/sched/fair.c | 13 ++++++++++++-
>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 932e7b78894a..9502013abe33 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -9532,7 +9532,7 @@ static inline long sibling_imbalance(struct lb_env *env,
>>>  	imbalance /= ncores_local + ncores_busiest;
>>>
>>>  	/* Take advantage of resource in an empty sched group */
>>> -	if (imbalance == 0 && local->sum_nr_running == 0 &&
>>> +	if (imbalance <= 1 && local->sum_nr_running == 0 &&
>>>  	    busiest->sum_nr_running > 1)
>>>  		imbalance = 2;
>>>
>>> @@ -9720,6 +9720,17 @@ static bool update_sd_pick_busiest(struct lb_env *env,
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
>>> +		}
>>> +		break;
> 
> Shrikanth and Peter,
> 
> Sorry, I acked Shrikanth's fixup patch too quickly without seeing that Shrikanth added
> a "break" in the patch above.  My original code did not have that break statement as
> I did intend the code to fall through to the "group_fully_busy" code path when
> there are no idle cpus in both groups.  To make the compiler happy and putting
> in the correct logic, I refresh the patch as below.
> 
> Thanks.
> 
> Tim
> 
> From: Tim Chen <tim.c.chen@linux.intel.com>
> Date: Fri, 14 Jul 2023 16:09:30 -0700
> Subject: [PATCH] sched/fair: Add SMT4 group_smt_balance handling
> 
> For SMT4, any group with more than 2 tasks will be marked as
> group_smt_balance. Retain the behaviour of group_has_spare by marking
> the busiest group as the group which has the least number of idle_cpus.
> 
> Also, handle rounding effect of adding (ncores_local + ncores_busy)
> when the local is fully idle and busy group has more than 2 tasks.
> Local group should try to pull at least 1 task in this case.
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a87988327f88..566686c5f2bd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9563,7 +9563,7 @@ static inline long sibling_imbalance(struct lb_env *env,
>  	imbalance /= ncores_local + ncores_busiest;
>  
>  	/* Take advantage of resource in an empty sched group */
> -	if (imbalance == 0 && local->sum_nr_running == 0 &&
> +	if (imbalance <= 1 && local->sum_nr_running == 0 &&
>  	    busiest->sum_nr_running > 1)
>  		imbalance = 2;
>  
> @@ -9751,6 +9751,20 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  		break;
>  
>  	case group_smt_balance:
> +		/* no idle cpus on both groups handled by group_fully_busy below */
> +		if (sgs->idle_cpus != 0 || busiest->idle_cpus != 0) {
> +			if (sgs->idle_cpus > busiest->idle_cpus)
> +				return false;
> +			if (sgs->idle_cpus < busiest->idle_cpus)
> +				return true;
> +			if (sgs->sum_nr_running <= busiest->sum_nr_running)
> +				return false;
> +			else
> +				return true;
> +		}
> +		goto fully_busy;
> +		break;
> +
>  	case group_fully_busy:
>  		/*
>  		 * Select the fully busy group with highest avg_load. In
> @@ -9763,7 +9777,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  		 * select the 1st one, except if @sg is composed of SMT
>  		 * siblings.
>  		 */
> -
> +fully_busy:
>  		if (sgs->avg_load < busiest->avg_load)
>  			return false;
>  

Hi Tim, Peter. 

group_smt_balance(cluster scheduling), patches are in tip/sched/core. I dont 
see this above patch there yet. Currently as is, this can cause function difference 
in SMT4 systems( such as Power10). 

Can we please have the above patch as well in tip/sched/core?

Acked-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
