Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACCF7B0AD7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjI0RIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjI0RIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:08:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A35991
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 10:08:37 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RH6fPr001437;
        Wed, 27 Sep 2023 17:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rTcZE3xwrwmQe9KTxIjFsgkcxC1RVWF80okIOupE6Uk=;
 b=RhjOLvPA7/OAW5iOSaaCwmFCXgiwBvtoyShfDjJnH0/9L/oeQl52dwvAASOjK0Q0QS8N
 fj0PnKH81U/FvU92qr6sIzFZgJFdi65qggD9Ndkc+mRWGtaV8dzbuzh9J9DjkTEuab9t
 hhQL2lKUi/8nOFi6ofs1TRDHqvOkCcZXRDXtJqZkTROPqf0gSzO9HEHSUwk13jday/TB
 QXK+VISiC3l2JTJQjm+zg5SOoSq7duoYfQw0/X3ihy+9BD4dHF/JMgMrKGUyQVFjCFV3
 lbMH3XjREW1kbOrwD5o/o4I/3cx+3HuYRpSvzU4wfTxJH7/lRS7gBADayDsiNcgLqVME ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcnrep898-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 17:08:18 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38RH7B3m005327;
        Wed, 27 Sep 2023 17:08:18 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcnrep87r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 17:08:17 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38RGP2eN011007;
        Wed, 27 Sep 2023 17:08:16 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabukmx3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 17:08:16 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38RH8Fnk3867348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 17:08:15 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 548E458056;
        Wed, 27 Sep 2023 17:08:15 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03AEE5805D;
        Wed, 27 Sep 2023 17:08:10 +0000 (GMT)
Received: from [9.171.75.113] (unknown [9.171.75.113])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 27 Sep 2023 17:08:09 +0000 (GMT)
Message-ID: <46353945-fced-9b69-b334-3b7ae50c957c@linux.vnet.ibm.com>
Date:   Wed, 27 Sep 2023 22:38:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] sched/topology: change behaviour of sysctl
 sched_energy_aware based on the platform
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        srikar@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, pierre.gondois@arm.com, yu.c.chen@intel.com,
        tim.c.chen@linux.intel.com, pauld@redhat.com, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        vschneid@redhat.com, qperret@google.com
References: <20230926100046.405188-1-sshegde@linux.vnet.ibm.com>
 <caab4d10-3ed6-faa7-5435-3086f3878537@arm.com>
 <d054e362-4a11-ee36-ddb6-870d88278e78@linux.vnet.ibm.com>
 <8ac1576c-909b-ec6b-930d-0683ca288bf9@arm.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <8ac1576c-909b-ec6b-930d-0683ca288bf9@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8OzG-wytltYQ12jAdLXG-y84iEA_4kPS
X-Proofpoint-ORIG-GUID: D_lP35QuJPuYkyokUOeWmsD3uSH8ieO7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_12,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270145
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/23 6:44 PM, Dietmar Eggemann wrote:
> Ah, BTW s/quentin.perret@arm.com/qperret@google.com
> 
> On 27/09/2023 10:14, Shrikanth Hegde wrote:
>>
>>
>> On 9/27/23 2:59 AM, Dietmar Eggemann wrote:
>>> On 26/09/2023 12:00, Shrikanth Hegde wrote:
> 
> [...]
> 
>>>> At present, though platform doesn't support EAS, this sysctl returns 1
>>>> and it ends up calling rebuild of sched domain on write to 1 and
>>>
>>> sched domains are not rebuild in this case, i.e.
>>> partition_sched_domains_locked() does not call detach_destroy_domains()
>>> or build_sched_domains(). Only build_perf_domains() is called which
>>> bails out if !sysctl_sched_energy_aware or one of the EAS conditions is
>>> not true.
>>>
>>
>> ok. that's because it goes to match1 and match2 right?
> 
> yes.
> 
> [...]
> 
>>>> @@ -231,6 +289,14 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
>>>>  		return -EPERM;
>>>>
>>>>  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>>>> +	if (!sched_is_eas_possible(cpu_active_mask)) {
>>>
>>> This is using `cpu_active_mask` so EAS can only be disabled system-wide.
>>>
>>> So I experimented with an exclusive cpuset setup creating a symmetric
>>> (cs1) and an asymmetric (cs2) island on my Juno with its cpumask = [l B
>>> B l l l] (l - little CPU, B - Big CPU).
>>>
>>> root@juno:~# cd /sys/fs/cgroup/cpuset
>>> root@juno:/sys/fs/cgroup/cpuset# mkdir cs1
>>> root@juno:/sys/fs/cgroup/cpuset# echo 1 > cs1/cpuset.cpu_exclusive
>>> root@juno:/sys/fs/cgroup/cpuset# echo 0 > cs1/cpuset.mems
>>> root@juno:/sys/fs/cgroup/cpuset# echo 4,5 > cs1/cpuset.cpus
>>> root@juno:/sys/fs/cgroup/cpuset# mkdir cs2
>>> root@juno:/sys/fs/cgroup/cpuset# echo 1 > cs2/cpuset.cpu_exclusive
>>> root@juno:/sys/fs/cgroup/cpuset# echo 0 > cs2/cpuset.mems
>>> root@juno:/sys/fs/cgroup/cpuset# echo 0-3 > cs2/cpuset.cpus
>>> root@juno:/sys/fs/cgroup/cpuset# echo 0 > cpuset.sched_load_balance
>>>
>>> [ 3021.761278] root_domain 0-3: pd1:{ cpus=1-2 nr_pstate=5 } pd0:{
>>> cpus=0,3-5 nr_pstate=5 }
>>>
>>> root@juno:~# echo 0 > /proc/sys/kernel/sched_energy_aware
>>>
>>> log messages:
>>> ...
>>> [ 3143.538583] rd 4-5: Disabling EAS
>>> [ 3143.549569] rd 0-3: Disabling EAS
>>> [ 3143.560681] sched_energy_set: stopping EAS
>>> ...
>>>
>>> root@juno:~# echo 1 > /proc/sys/kernel/sched_energy_aware
>>>
>>> log messages:
>>> ...
>>> [ 3223.277521] root_domain 0-3: pd1:{ cpus=1-2 nr_pstate=5 } pd0:{
>>> cpus=0,3-5 nr_pstate=5 }
>>> [ 3223.293409] sched_energy_set: starting EAS
>>>
>>> Seems still to work correctly.
>>
>> I see that can be a issue. using first cpu here check to asymmetric cpu capacity. 
>> It would have worked here, since the first group had asymmetry. ( l B B l ). 
>> It wouldn't have worked if the first group had like ( l l ) and second group has ( l B B l )
> 
> Yeah, that's true.
> 
>   sched_is_eas_possible(const struct cpumask *cpu_mask)
> 
>     !per_cpu(sd_asym_cpucapacity, cpumask_first(cpu_mask));
> 
> cpusets cs1=[0,5] and cs2=[1-4] as such an example.
> 

right. 

> 
>> Instead of cpu_active_mask, I can make use of ndoms_cur and doms_cur[i] logic to 
>> traverse through possible doms, and if none of the domains have asymmetric cpu capacity
>> return false.  Does that look right?
> 
>   rebuild_sched_domains()
> 
>     rebuild_sched_domains_locked()
> 
>       ndoms = generate_sched_domains(&doms, &attr)
> 
> You would need generate_sched_domains() in sched_energy_aware_handler()?
> 

clearly I didnt think through this. ndoms_cur and doms_cur are updated at the end. 
So If EAS is possible at boot, this would fail. 


What  sched_is_eas_possible needs is if there is asymmetric cpu topology. 
Simpler loop of all CPU's and checking if there any of them have sd_asym_cpucapacity might do,
though it goes through all CPU's, Since these functions are not in hot path
So it should not affect any performance. Something like below would work?

	bool any_asym_capacity = false;

        /* EAS is enabled for asymmetric CPU capacity topologies. */
        for_each_cpu(i, cpu_mask) {
                if (per_cpu(sd_asym_cpucapacity, i)) {
                        any_asym_capacity = true;
                        break;
                }
        }
        if (!any_asym_capacity) {
                if (sched_debug()) {
                        pr_info("rd %*pbl: Checking EAS, CPUs do not have asymmetric capacities\n",
                                cpumask_pr_args(cpu_mask));
                }
                return false;
        }



>>> [...]
>>>
>>>> @@ -458,6 +487,8 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
>>>>  	return !!pd;
>>>>
>>>>  free:
>>>> +	if (sched_debug())
>>>> +		pr_warn("rd %*pbl: Disabling EAS", cpumask_pr_args(cpu_map));
>>>
>>> Shouldn't this be used in condition `if (!sysctl_sched_energy_aware)`?
>>> Otherwise we have 2 warnings when the other conditions which leads to
>>> `goto free` aren't met.
>> Since sched_energy_set has the info messages about start and stop of EAS, maybe 
>> this debug is not needed. Will remove it. Doing it only `if (!sysctl_sched_energy_aware)`
> 
> OK.
> 
>> also doesn't seem correct, as calling free in this function would free the perf_domains.  
> 
> But !sched_is_eas_possible() also does `goto free` and in there we we
> emit pr_info's indicating why EAS isn't possible right now.
> 
> When issuing a:
> 
> # echo 0 > /proc/sys/kernel/sched_energy_aware
> 
> we would see in the logs:
> 
> ...
> [  416.325324] rd 0-5: sysctl_sched_energy_aware is N   <-- (*)
> [  416.337844] sched_energy_set: stopping EAS
> ...
> 
> but maybe (*) is not necessary ...

ok. I think we can add similar info message in if(!sysctl_sched_energy_aware) like below?
Would that be enough? 

        if (!sysctl_sched_energy_aware) {
                if (sched_debug()) {
                        pr_info("rd %*pbl: Checking EAS, sysclt sched_energy_aware set to N\n",
                                cpumask_pr_args(cpu_map));
                }
                goto free;
        }

and remove the below one.
        if (sched_debug())
                pr_warn("rd %*pbl: Disabling EAS", cpumask_pr_args(cpu_map));


So there will be these "Checking EAS" and if possible, "starting EAS" or "stopping EAS" message. 
