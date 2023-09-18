Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D2A7A511B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjIRRjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIRRjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:39:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE0DFA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:39:46 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IHc3je011071;
        Mon, 18 Sep 2023 17:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=bRtqGsMpzQD9i3r/eIni7BsyBbstHlbJlJyLqFd6lg0=;
 b=QkJBgbfl3f4sX7Gfw59hNsfid+MVM60EidHlgfrgZmeEoqJF9JiOXWs7v0kLP1c2RBt4
 2cYGS5gt9GvbaL+2j5SaqY/td8qRC/JyjPZjghsaL3T8iPU5AydPJj6rUO9raNKxd9+Y
 WlxbI4nV0j7IFwv3BvMqBaEIDEzDguGxCecgYmiABdngkoctAxH7szfWVf9Ek7bv3N5I
 phvx6SkgWZQLjbBcK8r1eHF/W6fAv+C7ERl+pc1oOas4IEVUs0AEAeWQRHWq0A2Y/Yit
 Q61DAXNMmXyEaCHjOUDtLIij3tVcNPuD7tEbALmkcgaXDP53yKIbFu+8yQZXExf06YXc Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t6rk7vv7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 17:39:24 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38IHdNqn018325;
        Mon, 18 Sep 2023 17:39:23 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t6rk7vv67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 17:39:23 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38IH7L9D018133;
        Mon, 18 Sep 2023 17:39:22 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5ppsdcfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 17:39:22 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38IHdLaK2556552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 17:39:21 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61C5D58054;
        Mon, 18 Sep 2023 17:39:21 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74DE35805D;
        Mon, 18 Sep 2023 17:39:15 +0000 (GMT)
Received: from [9.171.63.81] (unknown [9.171.63.81])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 18 Sep 2023 17:39:15 +0000 (GMT)
Message-ID: <5a2e835e-557b-f87c-b2f0-25670c70e9ad@linux.vnet.ibm.com>
Date:   Mon, 18 Sep 2023 23:09:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
Content-Language: en-US
To:     Valentin Schneider <vschneid@redhat.com>, pierre.gondois@arm.com,
        pauld@redhat.com
Cc:     dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, quentin.perret@arm.com,
        srikar@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, yu.c.chen@intel.com, tim.c.chen@linux.intel.com,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org
References: <20230913114807.665094-1-sshegde@linux.vnet.ibm.com>
 <xhsmhil8cvi7s.mognet@vschneid.remote.csb>
 <7c6dd2ec-b9a9-b364-5a29-05336127e519@linux.vnet.ibm.com>
 <xhsmhfs3fve7k.mognet@vschneid.remote.csb>
 <bd8a3c47-80f5-61f3-b884-85a7ee92767d@linux.vnet.ibm.com>
 <xhsmha5tjvfgm.mognet@vschneid.remote.csb>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <xhsmha5tjvfgm.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NXy51xejNI_ZO9fTuFpC1DB-2QLZd2SO
X-Proofpoint-GUID: H5gV-4cmryqEJruIJn0VFKzssbbBH8la
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_08,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309180155
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/23 5:52 PM, Valentin Schneider wrote:
> On 15/09/23 23:40, Shrikanth Hegde wrote:
>> On 9/15/23 5:30 PM, Valentin Schneider wrote:
>>> On 14/09/23 23:26, Shrikanth Hegde wrote:
>>>> On 9/14/23 9:51 PM, Valentin Schneider wrote:
>>>>> On 13/09/23 17:18, Shrikanth Hegde wrote:
>>>>>> sysctl_sched_energy_aware is available for the admin to disable/enable
>>>>>> energy aware scheduling(EAS). EAS is enabled only if few conditions are
>>>>>> met by the platform. They are, asymmetric CPU capacity, no SMT,
>>>>>> valid cpufreq policy, frequency invariant load tracking. It is possible
>>>>>> platform when booting may not have EAS capability, but can do that after.
>>>>>> For example, changing/registering the cpufreq policy.
>>>>>>
>>>>>> At present, though platform doesn't support EAS, this sysctl is still
>>>>>> present and it ends up calling rebuild of sched domain on write to 1 and
>>>>>> NOP when writing to 0. That is confusing and un-necessary.
>>>>>>
>>>>>
>>>>
>>>> Hi Valentin, Thanks for taking a look at this patch.
>>>>
>>>>> But why would you write to it in the first place? Or do you mean to use
>>>>> this as an indicator for userspace that EAS is supported?
>>>>>
>>>>
>>>> Since this sysctl is present and its value being 1, it gives the
>>>> impression to the user that EAS is supported when it is not.
>>>> So its an attempt to correct that part.
>>>>
>>>
>>> Ah, I see. Then how about just making the sysctl return 0 when EAS isn't
>>> supported? And on top of it, prevent all writes when EAS isn't supported
>>> (perf domains cannot be built, so there would be no point in forcing a
>>> rebuild that will do nothing).
>>
>> Yes. That's another way. Thats what I had as possible approach in 
>> https://lore.kernel.org/lkml/d2c945d6-c4f0-a096-0623-731b11484f51@linux.vnet.ibm.com/
>>
> 
> Thanks for the link; and apologies for bringing up topics that have been
> discussed already.
> 
>>
>>
>>>
>>> I can never remember how to properly use the sysctl API, so that's a very
>>> crude implementation, but something like so?
>>>
>>> ---
>>>
>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>> index 05a5bc678c089..dadfc5afc4121 100644
>>> --- a/kernel/sched/topology.c
>>> +++ b/kernel/sched/topology.c
>>> @@ -230,9 +230,28 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
>>>  	if (write && !capable(CAP_SYS_ADMIN))
>>>  		return -EPERM;
>>>
>>> +	if (!sched_energy_enabled()) {
>>
>> Use of sched_energy_enabled won't work as Pierre has indicated. 
>>
>> Instead this can be done by adding those checks in a helper function to
>> do similar checks as done build_perf_domains. 
>>
>> I can send v4 with this approach if it makes more sense. Please let me know.
>>
> 
> So what I'm thinking is the standard approach seems to be to keep the knobs
> visible, but change how reads/writes to them are handled.
> 
> For instance, SMT support has
> 
>   /sys/devices/system/cpu/smt
>     /control
>     /active
> 
> And a system with CONFIG_HOTPLUG_SMT=y but no actual hardware SMT will
> have:
> 
>     /control = notsupported
>     /active  = 0
> 
> So IMO it would make sense to keep sched_energy_aware around, but make it
> read 0 and prevent writes for systems that have the software support
> compiled but don't have the actual hardware support.

ok.

> 
> In a pinch it also helps to know if CONFIG_ENERGY_MODEL was selected,
> though that's obvious enough with CONFIG_SCHED_DEBUG=y.
> 
ok. This would be simpler to implement as well. Removing it would have 
few tricky corner case scenarios as pierre has indicated. 

Should be able to send out v4 sometime soon. I am on a holiday till Sep 19.

Pierre and Phil, thanks for the suggestions to commit message. I will 
incorporate the suggestions. 
