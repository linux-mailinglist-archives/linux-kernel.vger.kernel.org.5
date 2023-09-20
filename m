Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15287A8AD0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjITRsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjITRsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:48:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8206294
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 10:48:17 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KHRvbh029309;
        Wed, 20 Sep 2023 17:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/tuo9nJhnYRg0A6HWbPP8DHT5sYp6S186uq+lFipixw=;
 b=THiECu50Hed25HVvXxBFbAdXNadjebQmQ2avzLBuy4TPiuZcxBeviJZoKOOXaVWE5xmJ
 +PMX2JIXl/MCfawcOlQ1lA24n8GIMNvX86P7AXoLjZds+9BdIuaHHEsBW6OZbRO+BchB
 DoQbKSdkXaLi4ZtllnH0r8yWS/9QQiD5P7HSPxMoVxFilJR8weWFdSpRFYqJ+9zMAuH7
 AStadcy7wsy+N7eJSquifY0nh7OauBwCRecVkNbkbmP5JPjJhTzQXh1IXbVDjnu50KQm
 3nOJrihSKPqj4ReGQLjLOqLBDi0umm8DkQkQ39EXC73HnwWB3Zqeg17J4D0789HVK4rK yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t855e8fph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 17:47:42 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38KHiZXV011817;
        Wed, 20 Sep 2023 17:47:42 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t855e8fp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 17:47:41 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38KHkeVj010124;
        Wed, 20 Sep 2023 17:47:41 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5rwkfqt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 17:47:41 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38KHlevR23790144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 17:47:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32B8B5805F;
        Wed, 20 Sep 2023 17:47:40 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72CFA58043;
        Wed, 20 Sep 2023 17:47:34 +0000 (GMT)
Received: from [9.171.59.186] (unknown [9.171.59.186])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 20 Sep 2023 17:47:34 +0000 (GMT)
Message-ID: <3f8610b1-ef65-508b-4499-d8d3e34779c6@linux.vnet.ibm.com>
Date:   Wed, 20 Sep 2023 23:17:32 +0530
MIME-Version: 1.0
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
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PFDa0bvzFJgVyu9kgK3KDjDAJ9EQsnx2
X-Proofpoint-GUID: 7fD09poa9i7Hxp022KvTcaG7d96wu-Cs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_08,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309200145
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
> 
> I can never remember how to properly use the sysctl API, so that's a very
> crude implementation, but something like so?
> 
> ---
> 

I tried the below method, instead of sched_energy_enabled, using a helper
function which does similar checks as in build_perf_domains and use the 
same helper function in build_perf_domains as well.

# cat sched_energy_aware
# echo 0 > sched_energy_aware
-bash: echo: write error: Operation not supported
# echo 1 > sched_energy_aware
-bash: echo: write error: Operation not supported
# 



> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 05a5bc678c089..dadfc5afc4121 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -230,9 +230,28 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
>  	if (write && !capable(CAP_SYS_ADMIN))
>  		return -EPERM;
> 
> +	if (!sched_energy_enabled()) {
> +		if (write)
> +			return -EOPNOTSUPP;
> +		else {
> +			size_t len;
> +
> +			if (*ppos) {
> +				*lenp = 0;
> +				return 0;

Is it possible for *ppos to be 0? if so in which scenario? 
and 
Does it make sense to make length as 0 unconditionally if eas 
is not possible? 

> +			}
> +
> +			len = snprintf((char *)buffer, 3, "0\n");
> +
> +			*lenp = len;
> +			*ppos += len;
> +			return 0;
> +		}
> +>  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);

