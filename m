Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266EF7656E4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjG0PGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjG0PFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:05:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06751BD1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:05:32 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RF4XT6008682;
        Thu, 27 Jul 2023 15:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pS227uY4BbdSxySBAg72bwIzI+1gb9a3SYZsf0PplaI=;
 b=V89ccfcbILjNUk9eTdJYPmg8gKRFOQikAVNknmhk/+hOYYvsDDAJ4RMUx8szOWU2vt9s
 GlmXJHt8lvjCuMxdtJKp20/SsQ5fLnmVVs+9NMwNfnmdmRcu789BCN/b+pCZVGELKpqa
 /zaezZCmuMegCA1kfcDy6IBOGDAfr+c698V+sECfj0zbHgBVd+5nIgYQTPV85H1rw8xA
 5KSFSR+HVm+xrZtHn4AHKcCxmflhH6aGJu7SCT6zA+Fv1wl0CN5gpFX+W0i5Dx7cv+5F
 PvqoezVfNyAioxUvIRjQKpkIF0X74HWqll4Y9LrGoQ3gyL9hRKZ6dsQ6OeUGp+oL9s7S ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3t7shay2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 15:05:01 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36REbGp2009666;
        Thu, 27 Jul 2023 15:05:00 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3t7shawv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 15:05:00 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36RDttT7002079;
        Thu, 27 Jul 2023 15:04:59 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0teneddp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 15:04:59 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36RF4wBQ35586736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jul 2023 15:04:58 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6165F5805A;
        Thu, 27 Jul 2023 15:04:58 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04AFE58051;
        Thu, 27 Jul 2023 15:04:55 +0000 (GMT)
Received: from [9.179.9.200] (unknown [9.179.9.200])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jul 2023 15:04:54 +0000 (GMT)
Message-ID: <8ca8f35c-a3af-c663-e254-fd325a7d39ca@linux.vnet.ibm.com>
Date:   Thu, 27 Jul 2023 20:34:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] sched/fair: Skip idle CPU search on busy system
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     peterz@infradead.org, vincent.guittot@linaro.org,
        srikar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com, mgorman@suse.de,
        rui.zhang@intel.com, tim.c.chen@intel.com
References: <20230726093612.1882644-1-sshegde@linux.vnet.ibm.com>
 <ZMIb6TYMrtzLHSBb@chenyu5-mobl2>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <ZMIb6TYMrtzLHSBb@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HvsrsQXdJFbtEn1S-NlNXJpuQg6QIr41
X-Proofpoint-ORIG-GUID: GHUR5irjWScWo2vJ-st-gU9snuhiLfm6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/23 12:55 PM, Chen Yu wrote:
> On 2023-07-26 at 15:06:12 +0530, Shrikanth Hegde wrote:
>> When the system is fully busy, there will not be any idle CPU's.
>> In that case, load_balance will be called mainly with CPU_NOT_IDLE
>> type. In should_we_balance its currently checking for an idle CPU if
>> one exist. When system is 100% busy, there will not be an idle CPU and
>> these idle_cpu checks can be skipped. This would avoid fetching those rq
>> structures.
>>
> 
> Yes, I guess this could help reducing the cost if the sched group
> has many CPUs. 

Thank you for the review Chen Yu. 

> 
>> This is a minor optimization for a specific case of 100% utilization.
>>
>> .....
>> Coming to the current implementation. It is a very basic approach to the
>> issue. It may not be the best/perfect way to this.  It works only in
>> case of CONFIG_NO_HZ_COMMON. nohz.nr_cpus is a global info available which
>> tracks idle CPU's. AFAIU there isn't any other. If there is such info, we
>> can use that instead. nohz.nr_cpus is atomic, which might be costly too.
>>
>> Alternative way would be to add a new attribute to sched_domain and update
>> it in cpu idle entry/exit path per CPU. Advantage is, check can be per
>> env->sd instead of global. Slightly complicated, but maybe better. there
>> could other advantage at wake up to limit the scan etc.
>>
> 
> When checking the code, I found that there is per domain nr_busy_cpus.
> However that variable is only for LLC domain. Maybe extend the sd_share
> for domains under NUMA is applicable IMO.

True. I did see that. Doing at every level when there are large number 
of CPU's will likely need lock when updating the sd_share and that would 
be the bottleneck as well. Since sd_share never makes sense for NUMA, 
This would cause different code check for NUMA and non-NUMA. Though main benefit 
for this corner case would be in NUMA as there would be large number of CPU's there.

I will keep that thought and will try to work something along.

> 
> thanks,
> Chenyu
> 
>> Your feedback would really help. Does this optimization makes sense?
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
>> ---
>>  kernel/sched/fair.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 373ff5f55884..903d59b5290c 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -10713,6 +10713,12 @@ static int should_we_balance(struct lb_env *env)
>>  		return 1;
>>  	}
>>
>> +#ifdef CONFIG_NO_HZ_COMMON
>> +	/* If the system is fully busy, its better to skip the idle checks */
>> +	if (env->idle == CPU_NOT_IDLE && atomic_read(&nohz.nr_cpus) == 0)
>> +		return group_balance_cpu(sg) == env->dst_cpu;
>> +#endif
>> +
>>  	/* Try to find first idle CPU */
>>  	for_each_cpu_and(cpu, group_balance_mask(sg), env->cpus) {
>>  		if (!idle_cpu(cpu))
>> --
>> 2.31.1
>>
