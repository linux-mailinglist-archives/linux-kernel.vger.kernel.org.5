Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E383D7ABAD8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjIVVFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjIVVFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:05:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2CDCA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 14:05:15 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38ML0S4f002584;
        Fri, 22 Sep 2023 21:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=XoVnJqCiDXfCyFa6A71l7okrjgKMv7RaEftKZwNmqh0=;
 b=RM81g76U0z0lc3r5nJItUI3S0itGBuAn10nbCoj16AHPxZf44nTl4qbREalJsYQko47i
 FwGQ1SSnSiC8msq/0kEDC9wBvk5OtkRhL9NOnoY8F5hfzRiGc6BH1g+OHOAm/neWtmMt
 YOcqnMGcdSXSGX02U6bG39GmdCMTxW3NQuM8gC4ICp30fQQylXqrDneLcEhy3fuA0VS/
 KRzW93F7pMG9x8IP+cWB5eSPsDOyIAz8Ei0jqKp+hNzZ2CB9wSu8iwGnCku2enjWR0cd
 cy9E9FQ5bd7302GZPNPsyXUMP48Dj/FIEfkniLS6rAeS5q7/0Ohf3JicTncXAPez0Loe Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t9jf102ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 21:02:40 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38ML0RER002571;
        Fri, 22 Sep 2023 21:02:39 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t9jf102d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 21:02:39 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38MKDB3M018819;
        Fri, 22 Sep 2023 21:02:38 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t8tsp87b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 21:02:38 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38ML2bTo1114704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 21:02:37 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A812D58051;
        Fri, 22 Sep 2023 21:02:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46DEC5805A;
        Fri, 22 Sep 2023 21:02:29 +0000 (GMT)
Received: from [9.179.11.13] (unknown [9.179.11.13])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 22 Sep 2023 21:02:28 +0000 (GMT)
Message-ID: <7d78be0c-0e1e-c81e-37b6-727e4f7fe2fc@linux.vnet.ibm.com>
Date:   Sat, 23 Sep 2023 02:32:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        Valentin Schneider <vschneid@redhat.com>
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
 <63713cac-605a-c647-baf7-b172c02f8336@arm.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <63713cac-605a-c647-baf7-b172c02f8336@arm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ocs7rAxWQA9VQhm8-uJEbx-Ls4XnKjwF
X-Proofpoint-GUID: QpPiR_sYdkCi8C6Ts-NIta0sqRaCkMe5
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220180
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 8:14 PM, Pierre Gondois wrote:
> 
> 
> On 9/18/23 14:22, Valentin Schneider wrote:
>> On 15/09/23 23:40, Shrikanth Hegde wrote:
>>> On 9/15/23 5:30 PM, Valentin Schneider wrote:
>>>> On 14/09/23 23:26, Shrikanth Hegde wrote:
>>>>> On 9/14/23 9:51 PM, Valentin Schneider wrote:
>>>>>> On 13/09/23 17:18, Shrikanth Hegde wrote:
>>>>>>> sysctl_sched_energy_aware is available for the admin to
>>>>>>> disable/enable
>>>>>>> energy aware scheduling(EAS). EAS is enabled only if few
>>>>>>> conditions are
>>>>>>> met by the platform. They are, asymmetric CPU capacity, no SMT,
>>>>>>> valid cpufreq policy, frequency invariant load tracking. It is
>>>>>>> possible
>>>>>>> platform when booting may not have EAS capability, but can do
>>>>>>> that after.
>>>>>>> For example, changing/registering the cpufreq policy.
>>>>>>>
>>>>>>> At present, though platform doesn't support EAS, this sysctl is
>>>>>>> still
>>>>>>> present and it ends up calling rebuild of sched domain on write
>>>>>>> to 1 and
>>>>>>> NOP when writing to 0. That is confusing and un-necessary.
>>>>>>>
>>>>>>
>>>>>
>>>>> Hi Valentin, Thanks for taking a look at this patch.
>>>>>
>>>>>> But why would you write to it in the first place? Or do you mean
>>>>>> to use
>>>>>> this as an indicator for userspace that EAS is supported?
>>>>>>
>>>>>
>>>>> Since this sysctl is present and its value being 1, it gives the
>>>>> impression to the user that EAS is supported when it is not.
>>>>> So its an attempt to correct that part.
>>>>>
>>>>
>>>> Ah, I see. Then how about just making the sysctl return 0 when EAS
>>>> isn't
>>>> supported? And on top of it, prevent all writes when EAS isn't
>>>> supported
>>>> (perf domains cannot be built, so there would be no point in forcing a
>>>> rebuild that will do nothing).
>>>
>>> Yes. That's another way. Thats what I had as possible approach in
>>> https://lore.kernel.org/lkml/d2c945d6-c4f0-a096-0623-731b11484f51@linux.vnet.ibm.com/
>>>
>>
>> Thanks for the link; and apologies for bringing up topics that have been
>> discussed already.
>>
>>>
>>>
>>>>
>>>> I can never remember how to properly use the sysctl API, so that's a
>>>> very
>>>> crude implementation, but something like so?
>>>>
>>>> ---
>>>>
>>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>>> index 05a5bc678c089..dadfc5afc4121 100644
>>>> --- a/kernel/sched/topology.c
>>>> +++ b/kernel/sched/topology.c
>>>> @@ -230,9 +230,28 @@ static int sched_energy_aware_handler(struct
>>>> ctl_table *table, int write,
>>>>       if (write && !capable(CAP_SYS_ADMIN))
>>>>           return -EPERM;
>>>>
>>>> +    if (!sched_energy_enabled()) {
>>>
>>> Use of sched_energy_enabled won't work as Pierre has indicated.
>>>
>>> Instead this can be done by adding those checks in a helper function to
>>> do similar checks as done build_perf_domains.
>>>
>>> I can send v4 with this approach if it makes more sense. Please let
>>> me know.
>>>
>>
>> So what I'm thinking is the standard approach seems to be to keep the
>> knobs
>> visible, but change how reads/writes to them are handled.
>>
>> For instance, SMT support has
>>
>>    /sys/devices/system/cpu/smt
>>      /control
>>      /active
>>
>> And a system with CONFIG_HOTPLUG_SMT=y but no actual hardware SMT will
>> have:
>>
>>      /control = notsupported
>>      /active  = 0
> 
> 
> Having such interface for EAS would be ideal no > /active:
> would be the equivalent of the current sysctl_sched_energy_aware
> 
> /control:
> would show whether CONFIG_SCHED_DEBUG was set and all the conditions
> to have EAS enabled are satisfied.
> 
> Possible states for SMT:
> ---
> static const char *smt_states[] = {
>     [CPU_SMT_ENABLED]        = "on",             // EAS possible and
> running
>     [CPU_SMT_DISABLED]        = "off",            // EAS possible and
> not running
>     [CPU_SMT_FORCE_DISABLED]    = "forceoff",       // not applicable
> for EAS
>     [CPU_SMT_NOT_SUPPORTED]        = "notsupported",   // system with
> smt or not asymmetric or no freq invariance
>     [CPU_SMT_NOT_IMPLEMENTED]    = "notimplemented", //
> CONFIG_SCHED_DEBUG=n
> };
> ---
> 

Likely the current simpler approach more or less achieves the same i think.

With V4 (not yet sent).  Didnt send it out yet, as i am not
sure of proc handler's internal way of handling buffers and corner cases. I am
thinking to make *lenp=0 unconditionally and return if EAS is not possible. With 
that I have these possibilities.

If sysctl is not there at all, that mean CONFIG_ENERGY_MODEL was not selected 
If sysctl return empty string, that mean EAS is not possible at the moment. 
One can figure out whats the reason from dmesg. 
If sysctl return 1 or 0 - EAS is possible and its either enabled or disabled.

> 
>>
>> So IMO it would make sense to keep sched_energy_aware around, but make it
>> read 0 and prevent writes for systems that have the software support
>> compiled but don't have the actual hardware support.
>>
>> In a pinch it also helps to know if CONFIG_ENERGY_MODEL was selected,
>> though that's obvious enough with CONFIG_SCHED_DEBUG=y.
>>
