Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605A978E030
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242185AbjH3TYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343707AbjH3Qjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:39:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9996F19A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:39:51 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UGajTb026678;
        Wed, 30 Aug 2023 16:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mU6wF75VjucnPt/J3fYBvOvFQxDB/PiT1sK53Cb5sy8=;
 b=IoN1NedKUJDaM/8t7TvqXa+1ji0001Ztond9lDkD14yj7ypPCCAtfndf1jvds3mVhGT2
 ipZ6uOp8YxWdUwWWaJcl0N4V92+CkDDp9JN34RsaYqPjYCuyKyRAeuf/vpaQ52k69c6M
 Gsc/aPhyb47phJmf6TBhl9RZQ2vu3Xr0iGLS+YL0K3Iy9s5G53aUSzE4qyW1VAKAnTcE
 vxDxeT/5zJt+QJUvK6d7iSLRwhpqxdoY8YWBvpqjNj8tqOzHHTe1H8xPYK9zm9m3JHk5
 e57FKnEo6j/21PFqIrXT46OdRmeSe9+6zP8PU5M1p1ZATwmZ8SWYPiKnXJIEtyZqmhFM zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3st7rqkbeh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 16:37:34 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37UGb9bV028981;
        Wed, 30 Aug 2023 16:37:34 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3st7rqkawa-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 16:37:34 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37UF0mmh019258;
        Wed, 30 Aug 2023 16:02:42 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqxe1vjp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 16:02:42 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37UG2fRS35848548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 16:02:41 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C73FE58054;
        Wed, 30 Aug 2023 16:02:41 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6EBA5805C;
        Wed, 30 Aug 2023 16:02:36 +0000 (GMT)
Received: from [9.171.58.201] (unknown [9.171.58.201])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 30 Aug 2023 16:02:36 +0000 (GMT)
Message-ID: <7acb0cd9-4b72-52fa-4097-72c06982410d@linux.vnet.ibm.com>
Date:   Wed, 30 Aug 2023 21:32:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        quentin.perret@arm.com, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org
References: <20230829065040.920629-1-sshegde@linux.vnet.ibm.com>
 <ZO9BSaGpF5lIAjzy@chenyu5-mobl2>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <ZO9BSaGpF5lIAjzy@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O0EjeQmx4rfpneGAtU58QJAuXF_QBrVB
X-Proofpoint-GUID: h4MN9B4tdTm0JoWw-yLzgxcCWfiHf57b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_13,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 adultscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300154
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/23 6:46 PM, Chen Yu wrote:
> Hi Shrikanth,
> 
> On 2023-08-29 at 12:20:40 +0530, Shrikanth Hegde wrote:
>> Currently sysctl_sched_energy_aware doesn't alter the said behaviour on
>> some of the architectures. IIUC its meant to either force rebuild the
>> perf domains or cleanup the perf domains by echoing 1 or 0 respectively.
>>
>> perf domains are not built when there is SMT, or when there is no
>> Asymmetric CPU topologies or when there is no frequency invariance.
>> Since such cases EAS is not set and perf domains are not built. By
>> changing the values of sysctl_sched_energy_aware, its not possible to
>> force build the perf domains. Hence remove this sysctl on such platforms
>> that dont support it at boot. Some of the settings can be changed later
>> such as smt_active by offlining the CPU's, In those cases
>> build_perf_domains returns true, in that case re-enable the sysctl.
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
>>
> 
> [snip...]
> 
>> @@ -380,15 +400,11 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
>>  	struct cpufreq_policy *policy;
>>  	struct cpufreq_governor *gov;
>>
>> -	if (!sysctl_sched_energy_aware)
>> -		goto free;
>> -
> 
> I tried to ramp up the EAS and maybe I overlooked it, why do we remove above
> check? If the system boots with EAS enabled and sysctl_sched_energy_aware
> set to 1, then the user wants to disable EAS then changing sysctl_sched_energy_aware
> to 0. Without above check, how could the perf domain be freed?
> 

Thank you very much Chen Yu, for taking a look. I had missed that case.

The reason for removing it was, conditions which are checked while doing
build_perf_domains can be changed after system boot. like by off-lining the SMT
siblings, sched_smt_active can be false, it is possible in future for the other
conditions to be false as well. In that case, having the sysctl check wouldn't
allow it to build the perf domains.

Since any change in this sysctl, will set sched_energy_update. That can be used
in combination to detect whether change is coming due to sysctl change or due
to system becoming capable of doing perf domains.


Something like below would work. 

+       if (!sysctl_sched_energy_aware && sched_energy_update)
+               goto free;

This will introduce another issue, that it will remove the sysctl after setting
it to 0. Have taken care of that with below code change.


@@ -349,7 +349,16 @@ static void sched_energy_set(bool has_eas)
                        pr_info("%s: stopping EAS\n", __func__);
                static_branch_disable_cpuslocked(&sched_energy_present);
 #ifdef CONFIG_PROC_SYSCTL
-               unregister_sysctl_table(sysctl_eas_header);
+               /*
+                * if the architecture supports EAS and forcefully
+                * perf domains are destroyed, there should be a sysctl
+                * to eanble it later. If this was due to dynamic system
+                * change such as SMT<->NON_SMT then remove sysctl.
+                */
+               if (sysctl_eas_header && !sched_energy_update) {
+                       unregister_sysctl_table(sysctl_eas_header);
+                       sysctl_eas_header = NULL;
+               }
 #endif
                sysctl_sched_energy_aware = 0;
        } else if (has_eas && !static_branch_unlikely(&sched_energy_present)) {
@@ -357,7 +366,8 @@ static void sched_energy_set(bool has_eas)
                        pr_info("%s: starting EAS\n", __func__);
                static_branch_enable_cpuslocked(&sched_energy_present);
 #ifdef CONFIG_PROC_SYSCTL
-               sysctl_eas_header = register_sysctl("kernel", sched_energy_aware_sysctls);
+               if (!sysctl_eas_header)
+                       sysctl_eas_header = register_sysctl("kernel", sched_energy_aware_sysctls);
 #endif
                sysctl_sched_energy_aware = 1;
        }



Different Cases:

Case1. system while booting has EAS capability, sysctl will be set 1. Hence
perf domains will be built On changing the sysctl to 0, above condition will be
true and hence it would be freed and sysctl will not be removed. later sysctl
is changed to 1, enabling the perf domains rebuilt again. Since sysctl is
already there, it will skip register.

Case2. System while booting doesn't have EAS Capability. Later after system
change it becomes capable of EAS. sched_energy_update is false. Hence though
sysctl is 0, will go ahead and try to enable eas. if has_eas  is true, then
sysctl will be registered. After that it any sysctl change is same as Case1.

Case3. System becomes not capable of EAS due to system change. Here since
sched_energy_update is false.  build_perf_domains return has_eas as false and
Since this is dynamic change remove the sysctl.


A bit convoluted because the design here, is considering dynamically system
becoming capable of EAS.  Will send out a V2 with the above change after some
testing (have to try with HACK since EAS is by default not enabled on power10)
