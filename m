Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74569793406
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 05:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbjIFDVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 23:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjIFDVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 23:21:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D663CE8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 20:21:33 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3863J1NX017947;
        Wed, 6 Sep 2023 03:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Gx1Ygurdq4IvbYVYkhgMgcUaLS8j1ahO62sMWAKUqp4=;
 b=tuCg6c29Us16vHHGe7qw4OqLYnZ9waESdhBBizlTbejbDD0qCAimJwNwki+s0vrWq5uV
 DHLGgBPU+jbnLAhkiXJ3wLTo89+MCe2687Gm+rjqk73jAa1+24UHghjxr+iEvv0cGt9C
 v/1Eh+g4gtkPHGQD9O5PzX0OYa0mZIE0vllcVV50ks3HjjR6dOrcoBymTZ7DDlE8BFmZ
 EvKUVij5YZxiiMZXRt0y6DRxh/5Brv16lhf0gtId2beJvmZ7j6XjVQ7104VFPGUXNRAM
 xfCN8gU9/q3NXCivsj+Eq0SdkVC4gzlJ5lOVn5Klu5NRpWOiz8TWoxXPv/84fhnFAgtH xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxhdrg0tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 03:21:17 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3863LGrb024424;
        Wed, 6 Sep 2023 03:21:16 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxhdrg0t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 03:21:16 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3861YfPx012212;
        Wed, 6 Sep 2023 03:21:15 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svhkjyfp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 03:21:15 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3863LEGr4260356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Sep 2023 03:21:15 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4D8758052;
        Wed,  6 Sep 2023 03:21:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25EC158056;
        Wed,  6 Sep 2023 03:21:10 +0000 (GMT)
Received: from [9.171.19.125] (unknown [9.171.19.125])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  6 Sep 2023 03:21:09 +0000 (GMT)
Message-ID: <a3eb29cd-e87e-49f4-1745-b7b9518dfb08@linux.vnet.ibm.com>
Date:   Wed, 6 Sep 2023 08:51:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        peterz@infradead.org, mingo@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        quentin.perret@arm.com, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org, yu.c.chen@intel.com
References: <20230901065249.137242-1-sshegde@linux.vnet.ibm.com>
 <b81e3d8f-88e3-e7b5-0dbc-78268193db7e@arm.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <b81e3d8f-88e3-e7b5-0dbc-78268193db7e@arm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lB7qk32FoJL7XJOcH4njY3Tdk5oQDwnU
X-Proofpoint-GUID: 8MQExDS1kTwrtDxdjllHobhKfgzoOD73
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060026
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/23 7:33 PM, Pierre Gondois wrote:
> Hello Shrikanth,

Hi Pierre. Thanks for the review. 

> I tried the patch (on a platform using the cppc_cpufreq driver). The
> platform
> normally has EAS enabled, but the patch removed the sched_energy_aware
> sysctl.
> It seemed the following happened (in the below order):
> 
> 1. sched_energy_aware_sysctl_init()
> Doesn't set sysctl_sched_energy_aware as cpufreq_freq_invariance isn't set
> and arch_scale_freq_invariant() returns false
> 
> 2. cpufreq_register_driver()
> Sets cpufreq_freq_invariance during cpufreq initialization
> sched_energy_set()
> 
> 3. sched_energy_set()
> Is called with has_eas=0 since build_perf_domains() doesn't see the
> platform
> as EAS compatible. Indeed sysctl_sched_energy_aware=0.
> So with sysctl_sched_energy_aware=0 and has_eas=0, sched_energy_aware
> sysctl
> is not enabled even though EAS should be possible.
> 
> 

Yes. That is the case mentioned by Chen Yu. this patch missed that case. 

> On 9/1/23 08:52, Shrikanth Hegde wrote:
>> Currently sysctl_sched_energy_aware doesn't alter the said behaviour on
>> some of the architectures. IIUC its meant to either force rebuild the
>> perf domains or cleanup the perf domains by echoing 1 or 0 respectively.
> 
> There is a definition of the sysctl at:
> Documentation/admin-guide/sysctl/kernel.rst::sched_energy_aware
> 

Sorry my bad, i didnt read it, It is as below.
"Enables/disables Energy Aware Scheduling (EAS). EAS starts                      
automatically on platforms where it can run (that is,                           
platforms with asymmetric CPU topologies and having an Energy                   
Model available). If your platform happens to meet the                          
requirements for EAS but you do not want to use it, change                      
this value to 0.   "


It doesn't define whats the expected behavior on platforms 
which doesn't support EAS.




> Also a personal comment about the commit message (FWIW), I think it should
> be a bit more impersonal and factual. The commit message seems to describe
> the code rather than the desired behaviour.
> 
>>
>> perf domains are not built when there is SMT, or when there is no
>> Asymmetric CPU topologies or when there is no frequency invariance.
>> Since such cases EAS is not set and perf domains are not built. By
>> changing the values of sysctl_sched_energy_aware, its not possible to
>> force build the perf domains. Hence remove this sysctl on such platforms
>> that dont support it. Some of the settings can be changed later
>> such as smt_active by offlining the CPU's, In those cases if
>> build_perf_domains returns true, re-enable the sysctl.
>>
>> Anytime, when sysctl_sched_energy_aware is changed sched_energy_update
>> is set when building the perf domains. Making use of that to find out if
>> the change is happening by sysctl or dynamic system change.
>>
>> Taking different cases:
>> Case1. system while booting has EAS capability, sysctl will be set 1.
>> Hence
>> perf domains will be built if needed. On changing the sysctl to 0, since
>> sched_energy_update is true, perf domains would be freed and sysctl will
>> not be removed. later sysctl is changed to 1, enabling the perf domains
>> rebuild again. Since sysctl is already there, it will skip register.
>>
>> Case2. System while booting doesn't have EAS Capability. Later after
>> system
>> change it becomes capable of EAS. sched_energy_update is false. Though
>> sysctl is 0, will go ahead and try to enable eas. This is the current
>> behaviour. if has_eas  is true, then sysctl will be registered. After
>> that any sysctl change is same as Case1.
>>
>> Case3. System becomes not capable of EAS due to system change. Here since
>> sched_energy_update is false, build_perf_domains return has_eas as false
>> due to one of the checks and Since this is dynamic change remove the
>> sysctl.
>> Any further change which enables EAS is Case2
>>
>> Note: This hasn't been tested on platform which supports EAS. If the
>> change can be verified on that it would really help. This has been
>> tested on power10 which doesn't support EAS. sysctl_sched_energy_aware
>> is removed with patch.
>>
>> changes since v1:
>> Chen Yu had pointed out that this will not destroy the perf domains on
>> architectures where EAS is supported by changing the sysctl. This patch
>> addresses that.
>> [v1] Link:
>> https://lore.kernel.org/lkml/20230829065040.920629-1-sshegde@linux.vnet.ibm.com/#t
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
>> ---
>>   kernel/sched/topology.c | 45 +++++++++++++++++++++++++++++++++--------
>>   1 file changed, 37 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 05a5bc678c08..4d16269ac21a 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -208,7 +208,8 @@ sd_parent_degenerate(struct sched_domain *sd,
>> struct sched_domain *parent)
>>
>>   #if defined(CONFIG_ENERGY_MODEL) &&
>> defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
>>   DEFINE_STATIC_KEY_FALSE(sched_energy_present);
>> -static unsigned int sysctl_sched_energy_aware = 1;
>> +static unsigned int sysctl_sched_energy_aware;
>> +static struct ctl_table_header *sysctl_eas_header;
> 
> The variables around the presence/absence of EAS are:
> - sched_energy_present:
> EAS is up and running
> 
> - sysctl_sched_energy_aware:
> The user wants to use EAS (or not). Doesn't mean EAS can run on the
> platform.
> 
> - sched_energy_set/partition_sched_domains_locked's "has_eas":
> Local variable. Represent whether EAS can run on the platform.
> 
> IMO it would be simpler to (un)register sched_energy_aware sysctl
> in partition_sched_domains_locked(), based on the value of "has_eas".
> This would allow to let all the logic as it is right now, inside
> build_perf_domains(), and then advertise sched_energy_aware sysctl
> if EAS can run on the platform.
> sched_energy_aware_sysctl_init() would be deleted then.
> 
> 

problem with that is for systems that have EAS capability. 
i.e system has EAS, but admin wanted to to disable the EAS. hence 
has_eas will return false. But sysctl cannot be removed in this case. 

>>   static DEFINE_MUTEX(sched_energy_mutex);
>>   static bool sched_energy_update;
>>
>> @@ -226,6 +227,7 @@ static int sched_energy_aware_handler(struct
>> ctl_table *table, int write,
>>           void *buffer, size_t *lenp, loff_t *ppos)
>>   {
>>       int ret, state;
>> +    int prev_val = sysctl_sched_energy_aware;
>>
>>       if (write && !capable(CAP_SYS_ADMIN))
>>           return -EPERM;
>> @@ -233,8 +235,11 @@ static int sched_energy_aware_handler(struct
>> ctl_table *table, int write,
>>       ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>>       if (!ret && write) {
>>           state = static_branch_unlikely(&sched_energy_present);
>> -        if (state != sysctl_sched_energy_aware)
>> +        if (state != sysctl_sched_energy_aware && prev_val !=
>> sysctl_sched_energy_aware) {
>> +            if (sysctl_sched_energy_aware && !state)
>> +                pr_warn("Attempt to build energy domains when EAS is
>> disabled\n");
>>               rebuild_sched_domains_energy();
>> +        }
>>       }
>>
>>       return ret;
>> @@ -255,7 +260,14 @@ static struct ctl_table
>> sched_energy_aware_sysctls[] = {
>>
>>   static int __init sched_energy_aware_sysctl_init(void)
>>   {
>> -    register_sysctl_init("kernel", sched_energy_aware_sysctls);
>> +    int cpu = cpumask_first(cpu_active_mask);
>> +
>> +    if (sched_smt_active() || !per_cpu(sd_asym_cpucapacity, cpu) ||
>> +        !arch_scale_freq_invariant())
>> +        return 0;
>> +
>> +    sysctl_eas_header = register_sysctl("kernel",
>> sched_energy_aware_sysctls);
>> +    sysctl_sched_energy_aware = 1;
>>       return 0;
>>   }
>>
>> @@ -336,10 +348,28 @@ static void sched_energy_set(bool has_eas)
>>           if (sched_debug())
>>               pr_info("%s: stopping EAS\n", __func__);
>>           static_branch_disable_cpuslocked(&sched_energy_present);
>> +#ifdef CONFIG_PROC_SYSCTL
>> +        /*
>> +         * if the architecture supports EAS and forcefully
>> +         * perf domains are destroyed, there should be a sysctl
>> +         * to enable it later. If this was due to dynamic system
>> +         * change such as SMT<->NON_SMT then remove sysctl.
>> +         */
>> +        if (sysctl_eas_header && !sched_energy_update) {
>> +            unregister_sysctl_table(sysctl_eas_header);
>> +            sysctl_eas_header = NULL;
>> +        }
>> +#endif
>> +        sysctl_sched_energy_aware = 0;
>>       } else if (has_eas &&
>> !static_branch_unlikely(&sched_energy_present)) {
>>           if (sched_debug())
>>               pr_info("%s: starting EAS\n", __func__);
>>           static_branch_enable_cpuslocked(&sched_energy_present);
>> +#ifdef CONFIG_PROC_SYSCTL
>> +        if (!sysctl_eas_header)
>> +            sysctl_eas_header = register_sysctl("kernel",
>> sched_energy_aware_sysctls);
>> +#endif
>> +        sysctl_sched_energy_aware = 1;
>>       }
>>   }
>>
>> @@ -380,15 +410,14 @@ static bool build_perf_domains(const struct
>> cpumask *cpu_map)
>>       struct cpufreq_policy *policy;
>>       struct cpufreq_governor *gov;
>>
>> -    if (!sysctl_sched_energy_aware)
>> +    if (!sysctl_sched_energy_aware && sched_energy_update)
>>           goto free;
>>
>>       /* EAS is enabled for asymmetric CPU capacity topologies. */
>>       if (!per_cpu(sd_asym_cpucapacity, cpu)) {
>> -        if (sched_debug()) {
>> -            pr_info("rd %*pbl: CPUs do not have asymmetric
>> capacities\n",
>> -                    cpumask_pr_args(cpu_map));
>> -        }
>> +        if (sched_debug())
>> +            pr_info("rd %*pbl: Disabling EAS,  CPUs do not have
>> asymmetric capacities\n",
>> +                cpumask_pr_args(cpu_map));
>>           goto free;
>>       }
>>
>> -- 
>> 2.31.1
>>
>>
> 
> Regards,
> Pierre
