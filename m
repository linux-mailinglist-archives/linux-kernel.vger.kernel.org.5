Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878597B68F2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjJCM1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjJCM1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:27:41 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47FFA6;
        Tue,  3 Oct 2023 05:27:37 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393CL64l007128;
        Tue, 3 Oct 2023 12:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MGsWi8Ih8paVpkodWIePt00I3slQOI/Ow4EltZmwhEA=;
 b=PvoFO8N/zRcNJpMboX6K9CEYi90CkM3IjIWvopdThzGZEqV3Fw9ktS2rTZcEFXeQK49V
 AlEW5GMfWfaYTofxpSBbd6LyelUswZC7SXApoXQ+dutvkPWsGbF4eT3mlHa2D4o6QZHf
 /xqK8aCZ4ec7iHcVOpyl16QO1SJ1IvGGgC4rE+QxscM0Anc/qvRAEIqfddU5ga+QQA+2
 X9/+XsC5ucKRhEhSrWUcPjye6fZ6gl2ZaDr5aQNE78egYxUgWkJWFpVNfjoKU2lTbFCY
 0LXyYMjAc0sr33YzshDBZlcaK3U+G27WhMVp7JR57rO28ptCZ9itg2KYPLhomruww2Im 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tgjvu06b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 12:27:18 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 393CL7IP007183;
        Tue, 3 Oct 2023 12:27:17 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tgjvu068b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 12:27:17 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 393B3Rv4005870;
        Tue, 3 Oct 2023 12:27:13 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tex0sj0ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 12:27:13 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 393CRDaf17629790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Oct 2023 12:27:13 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F289158077;
        Tue,  3 Oct 2023 12:27:12 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 076AD5805C;
        Tue,  3 Oct 2023 12:27:06 +0000 (GMT)
Received: from [9.179.8.25] (unknown [9.179.8.25])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  3 Oct 2023 12:27:05 +0000 (GMT)
Message-ID: <c6dcab69-b398-7bb8-03df-37688864de47@linux.vnet.ibm.com>
Date:   Tue, 3 Oct 2023 17:57:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 2/2] sched/topology: change behaviour of sysctl
 sched_energy_aware based on the platform
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        qperret@google.com, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org, yu.c.chen@intel.com,
        tim.c.chen@linux.intel.com, pauld@redhat.com, lukasz.luba@arm.com,
        linux-doc@vger.kernel.org, bsegall@google.com, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        vschneid@redhat.com, dietmar.eggemann@arm.com
References: <20230929155209.667764-1-sshegde@linux.vnet.ibm.com>
 <20230929155209.667764-3-sshegde@linux.vnet.ibm.com>
 <69092c13-604c-74ec-b325-658527d069f4@arm.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <69092c13-604c-74ec-b325-658527d069f4@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: C6kGPOuSx4Tkv8_XWPC65jlKcG8OM-By
X-Proofpoint-GUID: 4Q6mOHKHA4UTxj7mvzMCqU53MRjXFZgB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_08,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030087
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/3/23 2:50 PM, Pierre Gondois wrote:
> Hello Shrikanth,
> Some NITs about the commit message:
> 

Hi Pierre. 


> On 9/29/23 17:52, Shrikanth Hegde wrote:
>> sysctl sched_energy_aware is available for the admin to disable/enable
>> energy aware scheduling(EAS). EAS is enabled only if few conditions are
>> met by the platform. They are, asymmetric CPU capacity, no SMT,
>> schedutil CPUfreq governor, frequency invariant load tracking etc.
>> A platform may boot without EAS capability, but could gain such
>> capability at runtime For example, changing/registering the CPUfreq
> 
> Missing dot I think: 'runtime. For example,'

ok.

> 
>> governor to schedutil.
>>
>> At present, though platform doesn't support EAS, this sysctl returns 1
>> and it ends up calling build_perf_domains on write to 1 and
>> NOP when writing to 0. That is confusing and un-necessary.
>
This is current problematic behavior that patch 2/2 tries to address.

> I'm not sure I fully understand the sentence:
> - it sounds that the user is writing a value to either 1/0
>   (I think the user is writing 1/0 to the sysctl)

Yes, any user with root
privileges can edit this file and perform read and write. 

> - aren't the sched domain rebuilt even when writing 0 to the sysctl ?
>   I'm not sure I understand to what the NOP is referring to exactly.
> 

Complete sched domains aren't built as this case goes to match1 and match2 statements. 

> What about:
> Platforms without EAS capability currently advertise this sysctl.
> Its effects (i.e. rebuilding sched-domains) is unnecessary on
> such platforms and its presence can be confusing.
> 
look ok. the changelog had described in detail IMHO


>>
>> Desired behavior would be to, have this sysctl to enable/disable the EAS
> 
> Unnecessary comma I think
> 
>> on supported platform. On Non supported platform write to the sysctl
> 
> Non supported  -> non-supported

ok for the above two nits.

> 
>> would return not supported error and read of the sysctl would return
>> empty. So> sched_energy_aware returns empty - EAS is not possible at
>> this moment
>> This will include EAS capable platforms which have at least one EAS
>> condition false during startup, e.g. using a Performance CPUfreq governor
> 
> Just a remark, using the performance governor is not exactly a condition
> disabling EAS, it is more 'not using the schedutil CPUfreq governor'
> 

ok.

>> sched_energy_aware returns 0 - EAS is supported but disabled by admin.
>> sched_energy_aware returns 1 - EAS is supported and enabled.
>>
>> User can find out the reason why EAS is not possible by checking
>> info messages. sched_is_eas_possible returns true if the platform
>> can do EAS at this moment.
>>
>> Depends on [PATCH v5 1/2] sched/topology: Remove EM_MAX_COMPLEXITY limit
>> to be applied first.
> 
> I think it's implied as the 2 patches are sent together.
> 

yes. Did mention it explicitly since b4 mbox can try apply 2/2 first. 
had run into similar issues recently.

> Otherwise:
> Tested-by: Pierre Gondois <pierre.gondois@arm.com>
> 
>>

Thank you very much for the testing it and providing the tag.

>> Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
>> ---
>>   Documentation/admin-guide/sysctl/kernel.rst |   3 +-
>>   kernel/sched/topology.c                     | 112 +++++++++++++-------
>>   2 files changed, 76 insertions(+), 39 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/sysctl/kernel.rst
>> b/Documentation/admin-guide/sysctl/kernel.rst
>> index cf33de56da27..d89ac2bd8dc4 100644
>> --- a/Documentation/admin-guide/sysctl/kernel.rst
>> +++ b/Documentation/admin-guide/sysctl/kernel.rst
>> @@ -1182,7 +1182,8 @@ automatically on platforms where it can run
>> (that is,
>>   platforms with asymmetric CPU topologies and having an Energy
>>   Model available). If your platform happens to meet the
>>   requirements for EAS but you do not want to use it, change
>> -this value to 0.
>> +this value to 0. On Non-EAS platforms, write operation fails and
>> +read doesn't return anything.
>>
>>   task_delayacct
>>   ===============
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index e0b9920e7e3e..a654d0186ac0 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -212,6 +212,70 @@ static unsigned int sysctl_sched_energy_aware = 1;
>>   static DEFINE_MUTEX(sched_energy_mutex);
>>   static bool sched_energy_update;
>>
>> +extern struct cpufreq_governor schedutil_gov;
>> +static bool sched_is_eas_possible(const struct cpumask *cpu_mask)
>> +{
>> +    bool any_asym_capacity = false;
>> +    struct cpufreq_policy *policy;
>> +    struct cpufreq_governor *gov;
>> +    int i;
>> +
>> +    /* EAS is enabled for asymmetric CPU capacity topologies. */
>> +    for_each_cpu(i, cpu_mask) {
>> +        if (per_cpu(sd_asym_cpucapacity, i)) {
>> +            any_asym_capacity = true;
>> +            break;
>> +        }
>> +    }
>> +    if (!any_asym_capacity) {
>> +        if (sched_debug()) {
>> +            pr_info("rd %*pbl: Checking EAS, CPUs do not have
>> asymmetric capacities\n",
>> +                cpumask_pr_args(cpu_mask));
>> +        }
>> +        return false;
>> +    }
>> +
>> +    /* EAS definitely does *not* handle SMT */
>> +    if (sched_smt_active()) {
>> +        if (sched_debug()) {
>> +            pr_info("rd %*pbl: Checking EAS, SMT is not supported\n",
>> +                cpumask_pr_args(cpu_mask));
>> +        }
>> +        return false;
>> +    }
>> +
>> +    if (!arch_scale_freq_invariant()) {
>> +        if (sched_debug()) {
>> +            pr_info("rd %*pbl: Checking EAS: frequency-invariant load
>> tracking not yet supported",
>> +                cpumask_pr_args(cpu_mask));
>> +        }
>> +        return false;
>> +    }
>> +
>> +    /* Do not attempt EAS if schedutil is not being used. */
>> +    for_each_cpu(i, cpu_mask) {
>> +        policy = cpufreq_cpu_get(i);
>> +        if (!policy) {
>> +            if (sched_debug()) {
>> +                pr_info("rd %*pbl: Checking EAS, cpufreq policy not
>> set for CPU: %d",
>> +                    cpumask_pr_args(cpu_mask), i);
>> +            }
>> +            return false;
>> +        }
>> +        gov = policy->governor;
>> +        cpufreq_cpu_put(policy);
>> +        if (gov != &schedutil_gov) {
>> +            if (sched_debug()) {
>> +                pr_info("rd %*pbl: Checking EAS, schedutil is
>> mandatory\n",
>> +                    cpumask_pr_args(cpu_mask));
>> +            }
>> +            return false;
>> +        }
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>   void rebuild_sched_domains_energy(void)
>>   {
>>       mutex_lock(&sched_energy_mutex);
>> @@ -231,6 +295,15 @@ static int sched_energy_aware_handler(struct
>> ctl_table *table, int write,
>>           return -EPERM;
>>
>>       ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>> +    if (!sched_is_eas_possible(cpu_active_mask)) {
>> +        if (write) {
>> +            return -EOPNOTSUPP;
>> +        } else {
>> +            *lenp = 0;
>> +            return 0;
>> +        }
>> +    }
>> +
>>       if (!ret && write) {
>>           state = static_branch_unlikely(&sched_energy_present);
>>           if (state != sysctl_sched_energy_aware)
>> @@ -351,61 +424,24 @@ static void sched_energy_set(bool has_eas)
>>    *    4. schedutil is driving the frequency of all CPUs of the rd;
>>    *    5. frequency invariance support is present;
>>    */
>> -extern struct cpufreq_governor schedutil_gov;
>>   static bool build_perf_domains(const struct cpumask *cpu_map)
>>   {
>>       int i;
>>       struct perf_domain *pd = NULL, *tmp;
>>       int cpu = cpumask_first(cpu_map);
>>       struct root_domain *rd = cpu_rq(cpu)->rd;
>> -    struct cpufreq_policy *policy;
>> -    struct cpufreq_governor *gov;
>>
>>       if (!sysctl_sched_energy_aware)
>>           goto free;
>>
>> -    /* EAS is enabled for asymmetric CPU capacity topologies. */
>> -    if (!per_cpu(sd_asym_cpucapacity, cpu)) {
>> -        if (sched_debug()) {
>> -            pr_info("rd %*pbl: CPUs do not have asymmetric
>> capacities\n",
>> -                    cpumask_pr_args(cpu_map));
>> -        }
>> -        goto free;
>> -    }
>> -
>> -    /* EAS definitely does *not* handle SMT */
>> -    if (sched_smt_active()) {
>> -        pr_warn("rd %*pbl: Disabling EAS, SMT is not supported\n",
>> -            cpumask_pr_args(cpu_map));
>> -        goto free;
>> -    }
>> -
>> -    if (!arch_scale_freq_invariant()) {
>> -        if (sched_debug()) {
>> -            pr_warn("rd %*pbl: Disabling EAS: frequency-invariant
>> load tracking not yet supported",
>> -                cpumask_pr_args(cpu_map));
>> -        }
>> +    if (!sched_is_eas_possible(cpu_map))
>>           goto free;
>> -    }
>>
>>       for_each_cpu(i, cpu_map) {
>>           /* Skip already covered CPUs. */
>>           if (find_pd(pd, i))
>>               continue;
>>
>> -        /* Do not attempt EAS if schedutil is not being used. */
>> -        policy = cpufreq_cpu_get(i);
>> -        if (!policy)
>> -            goto free;
>> -        gov = policy->governor;
>> -        cpufreq_cpu_put(policy);
>> -        if (gov != &schedutil_gov) {
>> -            if (rd->pd)
>> -                pr_warn("rd %*pbl: Disabling EAS, schedutil is
>> mandatory\n",
>> -                        cpumask_pr_args(cpu_map));
>> -            goto free;
>> -        }
>> -
>>           /* Create the new pd and add it to the local list. */
>>           tmp = pd_init(i);
>>           if (!tmp)
>> -- 
>> 2.39.3
>>

will send out v6 with these changes to changelog and Tested-by tag. 
will wait for a while to see if there are any concerns or comments. 
