Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E5079E74A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbjIMLzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjIMLze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:55:34 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D401996
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:55:30 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DBrcAH021355;
        Wed, 13 Sep 2023 11:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=yOTFMpdLBjG3KdGU2YoRK7ZhCYbCcO1Zs94cnlyiyYo=;
 b=eTtvemVB/NtvBFsqXJ+Pd6mmJUHaMy4h91MTvQkntlspAl0DqzpBThFG+zGu05VN4Whg
 Hg4lSLMhELKsuid/5BrL3eBZ08+jW3COpmuW1ZHGJedPMxyDuGlpax7eeNgfem4t9/xb
 Ej/ExiHBLKMA7103n20t3wdvQhznVh7nV0/cC8KVeBDP382fqcdEXAC9nVaLGigcqYIU
 FLO71zfIRM+NaTnVWW9KNHLnB4qTSVvabUw+2USIjJ3+PrWcDWgZi7yP71QQCKXKCfP/
 29YXxsYg7hLvGK5diJ4DrvnzEBnJUZDDe7G4q5DH9F86IhNE42QOrkW49YMbs6RScv/n aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t3ckyg186-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 11:55:10 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38DBrj7A021623;
        Wed, 13 Sep 2023 11:55:10 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t3ckyg17j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 11:55:10 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38DBbT83002362;
        Wed, 13 Sep 2023 11:55:09 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t158kaeya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 11:55:09 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38DBt8Vn43909430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 11:55:09 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B46555803F;
        Wed, 13 Sep 2023 11:55:08 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7D5D5804E;
        Wed, 13 Sep 2023 11:55:02 +0000 (GMT)
Received: from [9.171.0.21] (unknown [9.171.0.21])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 13 Sep 2023 11:55:02 +0000 (GMT)
Message-ID: <e5a7d048-3eff-f204-1698-e7298cc8d94c@linux.vnet.ibm.com>
Date:   Wed, 13 Sep 2023 17:25:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        peterz@infradead.org, mingo@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        quentin.perret@arm.com, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org, yu.c.chen@intel.com
References: <20230901065249.137242-1-sshegde@linux.vnet.ibm.com>
 <b81e3d8f-88e3-e7b5-0dbc-78268193db7e@arm.com>
 <d2c945d6-c4f0-a096-0623-731b11484f51@linux.vnet.ibm.com>
 <08e39be6-2815-4385-7703-7acc93f85c7f@arm.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <08e39be6-2815-4385-7703-7acc93f85c7f@arm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NLDSZJhRIsMX8msBcADOSAdl1_dET5GC
X-Proofpoint-GUID: pO97cQPTtZIijPcmv0JH0xDnI8ns52nD
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_04,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309130092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/23 4:04 PM, Pierre Gondois wrote:
> Hello Shrikanth,
> 
> On 9/6/23 13:35, Shrikanth Hegde wrote:
>>
>>
>> On 9/5/23 7:33 PM, Pierre Gondois wrote:
>>> Hello Shrikanth,
>>> I tried the patch (on a platform using the cppc_cpufreq driver). The
>>> platform
>>> normally has EAS enabled, but the patch removed the sched_energy_aware
>>> sysctl.
>>> It seemed the following happened (in the below order):
>>>
>>> 1. sched_energy_aware_sysctl_init()
>>> Doesn't set sysctl_sched_energy_aware as cpufreq_freq_invariance
>>> isn't set
>>> and arch_scale_freq_invariant() returns false
>>>
>>> 2. cpufreq_register_driver()
>>> Sets cpufreq_freq_invariance during cpufreq initialization
>>> sched_energy_set()
>>>
>>> 3. sched_energy_set()
>>> Is called with has_eas=0 since build_perf_domains() doesn't see the
>>> platform
>>> as EAS compatible. Indeed sysctl_sched_energy_aware=0.
>>> So with sysctl_sched_energy_aware=0 and has_eas=0, sched_energy_aware
>>> sysctl
>>> is not enabled even though EAS should be possible.
>>>
>>>
>>> On 9/1/23 08:52, Shrikanth Hegde wrote:
>>>> Currently sysctl_sched_energy_aware doesn't alter the said behaviour on
>>>> some of the architectures. IIUC its meant to either force rebuild the
>>>> perf domains or cleanup the perf domains by echoing 1 or 0
>>>> respectively.
>>>
>>> There is a definition of the sysctl at:
>>> Documentation/admin-guide/sysctl/kernel.rst::sched_energy_aware
>> [...]
>>>>
>>>>
>>>> +static unsigned int sysctl_sched_energy_aware;
>>>> +static struct ctl_table_header *sysctl_eas_header;
>>>
>>> The variables around the presence/absence of EAS are:
>>> - sched_energy_present:
>>> EAS is up and running
>>>
>>> - sysctl_sched_energy_aware:
>>> The user wants to use EAS (or not). Doesn't mean EAS can run on the
>>> platform.
>>>
>>> - sched_energy_set/partition_sched_domains_locked's "has_eas":
>>> Local variable. Represent whether EAS can run on the platform.
>>>
>>> IMO it would be simpler to (un)register sched_energy_aware sysctl
>>> in partition_sched_domains_locked(), based on the value of "has_eas".
>>> This would allow to let all the logic as it is right now, inside
>>> build_perf_domains(), and then advertise sched_energy_aware sysctl
>>> if EAS can run on the platform.
>>> sched_energy_aware_sysctl_init() would be deleted then.
>>>
>>>
>> yes. that is true. and there is no variable which holds the info if
>> the system
>> is capable of EAS.
>>
>> Retrospecting, the reason for starting this patch series was this,
>> sysctl_sched_energy_aware didnt make sense on power10 platform since it
>> has SMT and symmetric CPU capacities.  with current code writing 1 to
>> it cause rebuild of sched domains but EAS wouldn't be possible.
>>
>>
>> Possible Approaches:
>>
>> 1.
>> Make this sysctl write as NOP if the platform doesn't has EAS
>> capabilities at
>> the moment.  Do those checks in sched_energy_aware_handler before
>> handling  the
>> change in value. Return EINVAL.  And Update sysctl description that on
>> such
>> platforms value change is NOP. Relatively simpler change.
>>
>> 2.
>> Current patch approach, remove the sysctl completely on non supported
>> architectures and re-enable it if the system becomes capable of doing
>> EAS.
>> With the current patch, instead of using sched_energy_update, use another
>> variable called sched_energy_change_in_sysctl(maybe different name). 
>> I think
>> that would handle all the cases. Another variable can be avoided by
>> encoding
>> the info in sysctl_sched_energy_aware itself in the handler call,
>> since it
>> takes only 1 or 0 as the value. upper bits are free to use. update the
>> sysctl
>> as well with this behavior. plus minor cleanup to remove the init of
>> sysctl.
>>
> 
> FWIW I think it makes more sense to remove the sysctl if EAS isn't
> possible on
> the platform, as this patch intends to do.
> From a code perspective I m not sure I follow exactly your intend. I can
> test
> your v3 if necessary,
> 

Hi Pierre,

Just sent out v3 of the series. 
https://lore.kernel.org/lkml/20230913114807.665094-1-sshegde@linux.vnet.ibm.com/

It would really help if you can test this out. I don't have system where EAS can be 
enabled at the moment. 

> Regards,
> Pierre
> 
