Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A527DC793
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343738AbjJaHrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbjJaHrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:47:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653D9C1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 00:47:13 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V77wEY013911;
        Tue, 31 Oct 2023 07:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hfBXpJfkLd9GWGa4lY1gF1b7caowjrve62VahYaWlew=;
 b=tiOBzRa6aWdEtVuDv3J3HZ8fiS80OnRIwV1JTOguR0MRXimriFvxSGXm28aCbug1Tkld
 aIHZZGBRngnJAUYTP05P7Dschh6z0KyAbhWIfKe8GyV2wtD9lNIQdaszfPxxxhBp8y74
 T+Gyp3pJHsb6cNJ9LBLmgoHujRT2Hwk0gJXk3ttFFZmA9jvKfgfYOgkhKyUDesfZXIwa
 T3DVWfWJTuDX+N+MlV+wIm9HZwiqLJqk9jjWL9wfuuDS4SUB2XpiFaZBBdrT52Fu44lj
 Uem4XW1cP+upnqRVfDF5D3kEl7CrA1FHO8Om4ex/GFANRlR5gsm/WZgeojXhIic3dHOz Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2vwt103d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 07:46:50 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39V7jtw5001937;
        Tue, 31 Oct 2023 07:46:49 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2vwt102j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 07:46:49 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39V55uBE007664;
        Tue, 31 Oct 2023 07:46:48 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1dmnetw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 07:46:47 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39V7klD145351510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 07:46:47 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC84F58052;
        Tue, 31 Oct 2023 07:46:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41DE458045;
        Tue, 31 Oct 2023 07:46:43 +0000 (GMT)
Received: from [9.171.80.230] (unknown [9.171.80.230])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Oct 2023 07:46:42 +0000 (GMT)
Message-ID: <46e8388e-8995-4733-88ff-daa160c81702@linux.vnet.ibm.com>
Date:   Tue, 31 Oct 2023 13:16:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: Fix the decision for load balance
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>,
        Keisuke Nishimura <keisuke.nishimura@inria.fr>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>
References: <20231030172945.1505532-1-keisuke.nishimura@inria.fr>
 <ZUCXwmzaoNbRbNpR@chenyu5-mobl2.ccr.corp.intel.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <ZUCXwmzaoNbRbNpR@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h9Hhdd_h7ENa3l7glaIfnGs-gQtEpNL-
X-Proofpoint-ORIG-GUID: sSvuAagbFZg94QBDzG7lgiU4_q0wGT7V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/23 11:29 AM, Chen Yu wrote:
> On 2023-10-30 at 18:29:46 +0100, Keisuke Nishimura wrote:
>> should_we_balance is called for the decision to do load-balancing.
>> When sched ticks invoke this function, only one CPU should return
>> true. However, in the current code, two CPUs can return true. The
>> following situation, where b means busy and i means idle, is an
>> example, because CPU 0 and CPU 2 return true.
>>
>>         [0, 1] [2, 3]
>>          b  b   i  b
>>
>> This fix checks if there exists an idle CPU with busy sibling(s)
>> after looking for a CPU on an idle core. If some idle CPUs with busy
>> siblings are found, just the first one should do load-balancing.
>>

As Chen indicated, it would be better to carry reviewed by tags.

>> Fixes: b1bfeab9b002 ("sched/fair: Consider the idle state of the whole core for load balance")
>> Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
>> ---
>>  kernel/sched/fair.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 2048138ce54b..69d63fae34f4 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -11079,12 +11079,16 @@ static int should_we_balance(struct lb_env *env)
>>  			continue;
>>  		}
>>  
>> -		/* Are we the first idle CPU? */
>> +		/*
>> +		 * Are we the first idle core in a MC or higher domain
> 
> It is possible that the Cluster domain is lower than a MC.
> cluser domain: CPUs share the same L2
> MC domain: CPUs share the same LLC
> 
>  grep . domain*/{name,flags}
> domain0/name:CLS
> domain1/name:MC
> domain2/name:NUMA
> domain0/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING 
> domain1/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING 
> domain2/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SERIALIZE SD_OVERLAP SD_NUMA 
> 
> So, maybe:
> Are we the first idle core in a non-SMT domain or higher,

Yes. That makes sense. Forgot about recent cluster addition.

> 
> thanks,
> Chenyu
> 
>> +		 * or the first idle CPU in a SMT domain?
>> +		 */
>>  		return cpu == env->dst_cpu;
>>  	}
>>  
>> -	if (idle_smt == env->dst_cpu)
>> -		return true;
>> +	/* Are we the first idle CPU with busy siblings? */
>> +	if (idle_smt != -1)
>> +		return idle_smt == env->dst_cpu;
>>  
>>  	/* Are we the first CPU of this group ? */
>>  	return group_balance_cpu(sg) == env->dst_cpu;
>> -- 
>> 2.34.1
>>
