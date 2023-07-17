Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5EE7562E1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGQMjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGQMjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:39:04 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A715691
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:39:03 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HCL1RV006352;
        Mon, 17 Jul 2023 12:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=KGqv5A8rRQ0oUgS8ZPaV3exF6jfMJqUVgyCkasWPeTE=;
 b=HHhU2ITSm9wzQFpbn2/C7mPUqOLjTfPTXjMueeZppKaCY4tUC+zRVE5IP4Yy/Xq5lNJn
 w/rpHdhBs4rR2OvAu9RAp1PcsLzCoVQMSJsZpBtoab1BuTCP7T6sCIbgj5g+7ReBWtmZ
 yiCI4mBOe8b3pYPufDYCv8W14m2Ool8tqSsDYER7pI9RbWD300h1MKSGETP6vn77qIdu
 0Og+67IMjSC/wbTsnecPSBzvmFpGZdvcWcf2/4FQQv6/hVAmOaAyO9oqM9be3vH9FbAI
 zH8zKm2qKdb2oe8JqP8u3GoUCHgA88/9DF1dikF05iZj82gFD1wg3heoCn9OnSgsqZi3 tA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rw5jergxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 12:38:12 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36HCc7Qq015135;
        Mon, 17 Jul 2023 12:38:11 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rw5jergx1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 12:38:11 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36HC38ng016693;
        Mon, 17 Jul 2023 12:18:13 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3ruk35jp43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 12:18:13 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36HCICoj66126264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 12:18:12 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 932F15805C;
        Mon, 17 Jul 2023 12:18:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EB4F58051;
        Mon, 17 Jul 2023 12:18:04 +0000 (GMT)
Received: from [9.171.2.235] (unknown [9.171.2.235])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jul 2023 12:18:04 +0000 (GMT)
Message-ID: <eba3aa23-99ca-ce72-4933-940b8dd6ff6b@linux.vnet.ibm.com>
Date:   Mon, 17 Jul 2023 17:48:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Patch v3 1/6] sched/fair: Determine active load balance for SMT
 sched groups
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
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
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
 <e24f35d142308790f69be65930b82794ef6658a2.1688770494.git.tim.c.chen@linux.intel.com>
 <165778ce-7b8f-1966-af02-90ef481455b9@linux.vnet.ibm.com>
 <a399af19aa8e1291558724509a1de2f52b3bad0a.camel@linux.intel.com>
 <05ed4537-e79b-0ff3-5be5-92cbffaab3ee@linux.vnet.ibm.com>
 <20230717111053.GI4253@hirez.programming.kicks-ass.net>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <20230717111053.GI4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3xjMFvp9un8-Odj6Kle5YPt5tc9h4SNO
X-Proofpoint-GUID: GOOrGPb0ZRxFJv7Kvk26MSSW-rS6VNa9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_09,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/23 4:40 PM, Peter Zijlstra wrote:
> On Mon, Jul 17, 2023 at 01:06:59AM +0530, Shrikanth Hegde wrote:
>>
>>
>> On 7/15/23 4:35 AM, Tim Chen wrote:
>>> On Fri, 2023-07-14 at 18:36 +0530, Shrikanth Hegde wrote:
>>>
>>>>
>>>>
>>>> If we consider symmetric platforms which have SMT4 such as power10. 
>>>> we have a topology like below. multiple such MC will form DIE(PKG)
>>>>
>>>>
>>>> [0 2 4 6][1 3 5 7][8 10 12 14][9 11 13 15]
>>>> [--SMT--][--SMT--][----SMT---][---SMT----]
>>>> [--sg1--][--sg1--][---sg1----][---sg1----]
>>>> [--------------MC------------------------]
>>>>
>>>> In case of SMT4, if there is any group which has 2 or more tasks, that 
>>>> group will be marked as group_smt_balance. previously, if that group had 2
>>>> or 3 tasks, it would have been marked as group_has_spare. Since all the groups have 
>>>> SMT that means behavior would be same fully busy right? That can cause some 
>>>> corner cases. No?
>>>
>>> You raised a good point. I was looking from SMT2
>>> perspective so group_smt_balance implies group_fully_busy.
>>> That is no longer true for SMT4.
>>>
>>> I am thinking of the following fix on the current patch
>>> to take care of SMT4. Do you think this addresses
>>
>> Thanks Tim for taking a look at it again. 
>>
>> Yes. I think this would address some of the corner cases. 
>> Any SMT4 group having 2,3,4 will have smt_balance as the group type, and busiest one 
>> is the one which has least number of idle cpu's. (same conditions as group_has_spare)
>>
>>
>>
>>
>>> concerns from you and Tobias?
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 294a662c9410..3fc8d3a3bd22 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -9588,6 +9588,17 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>>>                 break;
>>>  
>>>         case group_smt_balance:
>>> +               /* no idle cpus on both groups handled by group_fully_busy below */
>>> +               if (sgs->idle_cpus != 0 || busiest->idle_cpus != 0) {
>>> +                       if (sgs->idle_cpus > busiest->idle_cpus)
>>> +                               return false;
>>> +                       if (sgs->idle_cpus < busiest->idle_cpus)
>>> +                               return true;
>>> +                       if (sgs->sum_nr_running <= busiest_sum_nr_running)
>>> +                               return false;
>>> +                       else
>>> +                               return true;
>>> +               }
>>>
>>>
>>> I will be on vacation next three weeks so my response will be slow.
>>>
>>> Tim
>>>
>>>>
>>
>> Small suggestion to above code to avoid compiler warning of switch case falling
>> through and else case can be removed, since update_sd_pick_busiest by default returns true.
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index e5a75c76bcaa..ae364ac6f22e 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9728,9 +9728,9 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>>                                 return true;
>>                         if (sgs->sum_nr_running <= busiest->sum_nr_running)
>>                                 return false;
>> -                       else
>> -                               return true;
>>                 }
>> +               break;
>> +
>>         case group_fully_busy:
>>                 /*
>>                  * Select the fully busy group with highest avg_load. In
>>
>>
> 
> Can someone please send a full patch for this? I've already queued Tim's
> patches in tip/sched/core (tip-bot seems to have died somewhere last
> week, it's being worked on).

Hi Peter. 

Sending on behalf of tim. I have included my suggestion as well. Hope that's ok.
Please find below the patch as of now. it includes the couple of changes that are discussed. (in 1/6 and in 3/6)


---
 kernel/sched/fair.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 932e7b78894a..9502013abe33 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9532,7 +9532,7 @@ static inline long sibling_imbalance(struct lb_env *env,
 	imbalance /= ncores_local + ncores_busiest;
 
 	/* Take advantage of resource in an empty sched group */
-	if (imbalance == 0 && local->sum_nr_running == 0 &&
+	if (imbalance <= 1 && local->sum_nr_running == 0 &&
 	    busiest->sum_nr_running > 1)
 		imbalance = 2;
 
@@ -9720,6 +9720,17 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 		break;
 
 	case group_smt_balance:
+		/* no idle cpus on both groups handled by group_fully_busy below */
+		if (sgs->idle_cpus != 0 || busiest->idle_cpus != 0) {
+			if (sgs->idle_cpus > busiest->idle_cpus)
+				return false;
+			if (sgs->idle_cpus < busiest->idle_cpus)
+				return true;
+			if (sgs->sum_nr_running <= busiest->sum_nr_running)
+				return false;
+		}
+		break;
+
 	case group_fully_busy:
 		/*
 		 * Select the fully busy group with highest avg_load. In
-- 
2.31.1
