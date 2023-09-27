Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1667AFE03
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjI0IR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjI0IQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:16:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3B8CCE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:14:49 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R8BadB000954;
        Wed, 27 Sep 2023 08:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=yoPkIMKw3N0GKZQjOp/gmSTxeMKq5zpDx5zWqLC2irE=;
 b=XzkSwMaSfQgPCJcTplVckar+049A6ANzsdpApRANdgXIWoDj9RAo4Syvug4IeFbMulrp
 fv3PIotFrTWu/eAkq5s/ER4IdUQZNdeqzubAjrexqLCkbIbXxc4z2rti+HOn/Tqt5NTE
 Ve7ebAb+IeGHHyzJRDRYQFJdyqRt8JZoAvXn0cYv5wQVc9FMpRrIJsozC5FgWGIw0Ddu
 GDG+DELWdmW0qgq6Cna5rraGKZ3W0QSovNlwSetIJu/EHkrK3Ozq/snsUpAxB5oUMBRu
 aqPTwGTfm+nVmyKFLeA+C1wcjhhYFs07TlJQ/92JRrAy/gB0Q7n720qI8K4//zppEXy5 Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcgf4rjc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 08:14:31 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38R7wdZ5024530;
        Wed, 27 Sep 2023 08:14:30 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcgf4rjbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 08:14:30 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38R795gW030753;
        Wed, 27 Sep 2023 08:14:29 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tacjk1j0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 08:14:29 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38R8ESe337945670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 08:14:29 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4C4858056;
        Wed, 27 Sep 2023 08:14:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B90358054;
        Wed, 27 Sep 2023 08:14:24 +0000 (GMT)
Received: from [9.109.201.126] (unknown [9.109.201.126])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 27 Sep 2023 08:14:23 +0000 (GMT)
Message-ID: <d054e362-4a11-ee36-ddb6-870d88278e78@linux.vnet.ibm.com>
Date:   Wed, 27 Sep 2023 13:44:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] sched/topology: change behaviour of sysctl
 sched_energy_aware based on the platform
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        quentin.perret@arm.com, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org,
        pierre.gondois@arm.com, yu.c.chen@intel.com,
        tim.c.chen@linux.intel.com, pauld@redhat.com
References: <20230926100046.405188-1-sshegde@linux.vnet.ibm.com>
 <caab4d10-3ed6-faa7-5435-3086f3878537@arm.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <caab4d10-3ed6-faa7-5435-3086f3878537@arm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5PsZOvjHwWu9IWfx2hlQJO_Trohfp5CH
X-Proofpoint-ORIG-GUID: wdfbbBvuFKQR-yb8GR47Ki8OdoWeXsJe
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_03,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270065
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/23 2:59 AM, Dietmar Eggemann wrote:
> On 26/09/2023 12:00, Shrikanth Hegde wrote:
Thank you very much Dietmar, for taking a look at this and trying this patch.

>> sysctl sched_energy_aware is available for the admin to disable/enable
>> energy aware scheduling(EAS). EAS is enabled only if few conditions are
>> met by the platform. They are, asymmetric CPU capacity, no SMT,
>> valid cpufreq policy, frequency invariant load tracking etc. A platform may
> 
> s/valid cpufreq policy/Schedutil CPUfreq governor
> 
> + EM complexity < EM_MAX_COMPLEXITY

ok. will add. 
> 
>> boot without EAS capability, but could gain such capability at runtime
>> For example, changing/registering the cpufreq policy.
> 
> s/cpufreq policy/CPUfreq governor to Schedutil

ok will change.

> 
>> At present, though platform doesn't support EAS, this sysctl returns 1
>> and it ends up calling rebuild of sched domain on write to 1 and
> 
> sched domains are not rebuild in this case, i.e.
> partition_sched_domains_locked() does not call detach_destroy_domains()
> or build_sched_domains(). Only build_perf_domains() is called which
> bails out if !sysctl_sched_energy_aware or one of the EAS conditions is
> not true.
> 

ok. that's because it goes to match1 and match2 right?

>> NOP when writing to 0. That is confusing and un-necessary.
>>
>> Desired behavior would be to, have this sysctl to enable/disable the EAS
>> on supported platform. On Non supported platform write to the sysctl
>> would return not supported error and read of the sysctl would return
>> empty. So
>> sched_energy_aware returns empty - EAS is not possible at this moment
>> sched_energy_aware returns 0 - EAS is supported but disabled by admin.
>> sched_energy_aware returns 1 - EAS is supported and enabled.
>> User can find out the reason why EAS is not possible by checking
>> info messages.
> 
> This will include EAS capable platforms which have at least one EAS
> condition false during startup, e.g. using a Performance CPUfreq governor:
> 

ok. will include that in the changelog.

> root@juno:~# cat /proc/sys/kernel/sched_energy_aware
> 
> root@juno:~# echo 1 > /proc/sys/kernel/sched_energy_aware
> echo: write error: Operation not supported
> 
> log messages:
> ...
> [  160.902138] rd 0-5: Checking EAS, schedutil is mandatory
> ...
> [  324.467341] rd 0-5: Checking EAS, schedutil is mandatory
> ...
> 
> root@juno:~# echo schedutil >
> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
> root@juno:~# echo schedutil >
> /sys/devices/system/cpu/cpufreq/policy1/scaling_governor
> 
> log messages:
> ...
> [  414.195073] root_domain 0-5: pd1:{ cpus=1-2 nr_pstate=5 } pd0:{
> cpus=0,3-5 nr_pstate=5 }
> [  414.210877] sched_energy_set: starting EAS
> ...
> 
> root@juno:~# cat /proc/sys/kernel/sched_energy_aware
> 1
> 
> root@juno:~# echo 0 > /proc/sys/kernel/sched_energy_aware
> 
> log messages:
> ...
> [  414.195073] root_domain 0-5: pd1:{ cpus=1-2 nr_pstate=5 } pd0:{
> cpus=0,3-5 nr_pstate=5 }
> [  414.210877] sched_energy_set: starting EAS
> ...
> [  544.482690] rd 0-5: Disabling EAS
> [  544.493729] sched_energy_set: stopping EAS
> 

Thanks for testing.  Glad to see it works.

>> sched_is_eas_possible return if the platform can do EAS at this moment.
> 
> sched_is_eas_possible() returns
> 
>> It takes most of the cases into account except one where EM complexity is
>> too high as the code was bit tricky to separate that.
> 
> I remember that there was a patch from Pierre to get rid of the EM
> complexity check:
> 
> https://lkml.kernel.org/r/20221121094336.3250917-1-pierre.gondois@arm.com
> 
> If this makes this patch easier, maybe both patches can go in as a
> patch-set together?
> 
> Although I don't see that not checking EM complexity in
> sched_energy_aware_handler() -> sched_is_eas_possible() is an issue.
> 

ok. I can combine it with this patch and send it as patchset. 

>>
>> v3->v4:
>> valentin suggested it would be better to consider simpler approach that
>> was mentioned in v2. It is a standard approach to keep the knob visible
>> but change how read and write are handled. Did that and Refactored the
>> code to use a common function in build_perf_domains and in sysctl handler.
>> v2->v3:
>> Chen Yu and Pierre Gondois both pointed out that if platform becomes
>> capable of EAS later, this patch was not allowing that to happen.
>> Addressed that by using a variable to indicate the sysctl change
>> and re-worded the commit message with desired behaviour,
>> v1->v2:
>> Chen Yu had pointed out that this will not destroy the perf domains on
>> architectures where EAS is supported by changing the sysctl.
>> [v1] Link: https://lore.kernel.org/lkml/20230829065040.920629-1-sshegde@linux.vnet.ibm.com/
>> [v2] Link: https://lore.kernel.org/lkml/20230901065249.137242-1-sshegde@linux.vnet.ibm.com/
>> [v3] Link: https://lore.kernel.org/lkml/20230913114807.665094-1-sshegde@linux.vnet.ibm.com/
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> 
> [...]
> 
>> @@ -231,6 +289,14 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
>>  		return -EPERM;
>>
>>  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>> +	if (!sched_is_eas_possible(cpu_active_mask)) {
> 
> This is using `cpu_active_mask` so EAS can only be disabled system-wide.
> 
> So I experimented with an exclusive cpuset setup creating a symmetric
> (cs1) and an asymmetric (cs2) island on my Juno with its cpumask = [l B
> B l l l] (l - little CPU, B - Big CPU).
> 
> root@juno:~# cd /sys/fs/cgroup/cpuset
> root@juno:/sys/fs/cgroup/cpuset# mkdir cs1
> root@juno:/sys/fs/cgroup/cpuset# echo 1 > cs1/cpuset.cpu_exclusive
> root@juno:/sys/fs/cgroup/cpuset# echo 0 > cs1/cpuset.mems
> root@juno:/sys/fs/cgroup/cpuset# echo 4,5 > cs1/cpuset.cpus
> root@juno:/sys/fs/cgroup/cpuset# mkdir cs2
> root@juno:/sys/fs/cgroup/cpuset# echo 1 > cs2/cpuset.cpu_exclusive
> root@juno:/sys/fs/cgroup/cpuset# echo 0 > cs2/cpuset.mems
> root@juno:/sys/fs/cgroup/cpuset# echo 0-3 > cs2/cpuset.cpus
> root@juno:/sys/fs/cgroup/cpuset# echo 0 > cpuset.sched_load_balance
> 
> [ 3021.761278] root_domain 0-3: pd1:{ cpus=1-2 nr_pstate=5 } pd0:{
> cpus=0,3-5 nr_pstate=5 }
> 
> root@juno:~# echo 0 > /proc/sys/kernel/sched_energy_aware
> 
> log messages:
> ...
> [ 3143.538583] rd 4-5: Disabling EAS
> [ 3143.549569] rd 0-3: Disabling EAS
> [ 3143.560681] sched_energy_set: stopping EAS
> ...
> 
> root@juno:~# echo 1 > /proc/sys/kernel/sched_energy_aware
> 
> log messages:
> ...
> [ 3223.277521] root_domain 0-3: pd1:{ cpus=1-2 nr_pstate=5 } pd0:{
> cpus=0,3-5 nr_pstate=5 }
> [ 3223.293409] sched_energy_set: starting EAS
> 
> Seems still to work correctly.

I see that can be a issue. using first cpu here check to asymmetric cpu capacity. 
It would have worked here, since the first group had asymmetry. ( l B B l ). 
It wouldn't have worked if the first group had like ( l l ) and second group has ( l B B l )


Instead of cpu_active_mask, I can make use of ndoms_cur and doms_cur[i] logic to 
traverse through possible doms, and if none of the domains have asymmetric cpu capacity
return false.  Does that look right?

> 
> [...]
> 
>> @@ -458,6 +487,8 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
>>  	return !!pd;
>>
>>  free:
>> +	if (sched_debug())
>> +		pr_warn("rd %*pbl: Disabling EAS", cpumask_pr_args(cpu_map));
> 
> Shouldn't this be used in condition `if (!sysctl_sched_energy_aware)`?
> Otherwise we have 2 warnings when the other conditions which leads to
> `goto free` aren't met.
Since sched_energy_set has the info messages about start and stop of EAS, maybe 
this debug is not needed. Will remove it. Doing it only `if (!sysctl_sched_energy_aware)`
also doesn't seem correct, as calling free in this function would free the perf_domains.  

> 
> [...]
