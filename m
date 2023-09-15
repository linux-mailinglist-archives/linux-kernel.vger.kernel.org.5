Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C40A7A255F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbjIOSL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjIOSK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:10:57 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9A41FCC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:10:52 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FI7KnE014381;
        Fri, 15 Sep 2023 18:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Xl6QxNxh6UG2lv6i3UYJr6tBAW4v7WrM4aye6DYatvc=;
 b=Ncg5YQzQBmV7/kRHkrTKLV9U2foKfHNwD0D2ppfDz3HA2iMvIVK6a7Dd09J/vv/W80by
 QQZrnnQQxUCblVKJmtWaVqmOCEn+z/8SdzAjMz2ba/WmAn5w8JeLoM435FNhjeZE5kM8
 9ULM4UetPj96AT9SxPF8Iq3Kos9swjrFNaj0M1+Uxyvp3FpN6EYAev8rgLql9knTyaKH
 mpQQFtGagIB5oriuxaRqnRR5g0bW4Re+JbCTCc5n16A0/E5H/h+Wxj0qBDz94HNfEMqz
 Uw8k2AUCtrPu9mdRDQn7TMxkEIdIVddMT/Lc6QNSn6qdqHjjQfqT5mg3vzDVYwBDsNHR cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4u5khtkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 18:10:31 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38FI7bP2016977;
        Fri, 15 Sep 2023 18:10:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4u5khtjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 18:10:31 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38FHBRQG002932;
        Fri, 15 Sep 2023 18:10:30 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t14hmp1w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 18:10:30 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38FIATbA59703658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 18:10:30 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8560558067;
        Fri, 15 Sep 2023 18:10:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B81F158052;
        Fri, 15 Sep 2023 18:10:24 +0000 (GMT)
Received: from [9.179.25.49] (unknown [9.179.25.49])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 15 Sep 2023 18:10:24 +0000 (GMT)
Message-ID: <bd8a3c47-80f5-61f3-b884-85a7ee92767d@linux.vnet.ibm.com>
Date:   Fri, 15 Sep 2023 23:40:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
Content-Language: en-US
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, quentin.perret@arm.com,
        srikar@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, pierre.gondois@arm.com, yu.c.chen@intel.com,
        tim.c.chen@linux.intel.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org
References: <20230913114807.665094-1-sshegde@linux.vnet.ibm.com>
 <xhsmhil8cvi7s.mognet@vschneid.remote.csb>
 <7c6dd2ec-b9a9-b364-5a29-05336127e519@linux.vnet.ibm.com>
 <xhsmhfs3fve7k.mognet@vschneid.remote.csb>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <xhsmhfs3fve7k.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hrFofkiGLhKYZwd9-AOKkNVZF4Si72ND
X-Proofpoint-GUID: od3rc8zXu6N_w7MXHXaMvrAhCfFx2Obd
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_14,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309150162
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/23 5:30 PM, Valentin Schneider wrote:
> On 14/09/23 23:26, Shrikanth Hegde wrote:
>> On 9/14/23 9:51 PM, Valentin Schneider wrote:
>>> On 13/09/23 17:18, Shrikanth Hegde wrote:
>>>> sysctl_sched_energy_aware is available for the admin to disable/enable
>>>> energy aware scheduling(EAS). EAS is enabled only if few conditions are
>>>> met by the platform. They are, asymmetric CPU capacity, no SMT,
>>>> valid cpufreq policy, frequency invariant load tracking. It is possible
>>>> platform when booting may not have EAS capability, but can do that after.
>>>> For example, changing/registering the cpufreq policy.
>>>>
>>>> At present, though platform doesn't support EAS, this sysctl is still
>>>> present and it ends up calling rebuild of sched domain on write to 1 and
>>>> NOP when writing to 0. That is confusing and un-necessary.
>>>>
>>>
>>
>> Hi Valentin, Thanks for taking a look at this patch.
>>
>>> But why would you write to it in the first place? Or do you mean to use
>>> this as an indicator for userspace that EAS is supported?
>>>
>>
>> Since this sysctl is present and its value being 1, it gives the
>> impression to the user that EAS is supported when it is not.
>> So its an attempt to correct that part.
>>
> 
> Ah, I see. Then how about just making the sysctl return 0 when EAS isn't
> supported? And on top of it, prevent all writes when EAS isn't supported
> (perf domains cannot be built, so there would be no point in forcing a
> rebuild that will do nothing).

Yes. That's another way. Thats what I had as possible approach in 
https://lore.kernel.org/lkml/d2c945d6-c4f0-a096-0623-731b11484f51@linux.vnet.ibm.com/



> 
> I can never remember how to properly use the sysctl API, so that's a very
> crude implementation, but something like so?
> 
> ---
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 05a5bc678c089..dadfc5afc4121 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -230,9 +230,28 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
>  	if (write && !capable(CAP_SYS_ADMIN))
>  		return -EPERM;
> 
> +	if (!sched_energy_enabled()) {

Use of sched_energy_enabled won't work as Pierre has indicated. 

Instead this can be done by adding those checks in a helper function to
do similar checks as done build_perf_domains. 

I can send v4 with this approach if it makes more sense. Please let me know.

> +		if (write)
> +			return -EOPNOTSUPP;
> +		else {
> +			size_t len;
> +
> +			if (*ppos) {
> +				*lenp = 0;
> +				return 0;
> +			}
> +
> +			len = snprintf((char *)buffer, 3, "0\n");
> +
> +			*lenp = len;
> +			*ppos += len;
> +			return 0;
> +		}
> +	}
> +
>  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>  	if (!ret && write) {
> -		state = static_branch_unlikely(&sched_energy_present);
> +		state = sched_energy_enabled();
>  		if (state != sysctl_sched_energy_aware)
>  			rebuild_sched_domains_energy();
>  	}
> 
