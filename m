Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7987E7B8315
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243059AbjJDPAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242870AbjJDPAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:00:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460C4E5;
        Wed,  4 Oct 2023 08:00:07 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394Eki7Y026565;
        Wed, 4 Oct 2023 14:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qQgILTW2wTzA1iiqVeB/cfzJOWsEmS8TF5Uj8zbtSv4=;
 b=OWyqYP7vdJZEe5WoSP5FIV1mnGYHd/A6mj0IgDmJj5RD2XJzxMNnaSx2RG0/OFtRFOpX
 ffMwZ/+4wdlHlUlacNT8FJ6xEr12ZX9nfh3R2WP2PnHB0565aQWPv02T0Ce90FpZSk9I
 EzAOfKZ1DYef/El/OzhtlyRj87LVLzmTT7HayipYQb3De9YFkfjMCOWq1ckdQuk83znS
 6Fk0BaUEjordY9Uxn63jmenLBnCdmS8cecwJfwP95Xze3znNcJQM+RhJ/8dpxzPN114e
 1hfSj0RYvJHg+2+3Ef8psR5RBmciWe3JzpD86RpjO/62EgxhXHaaUFoNmk28fZg6EjXk wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th9ax237j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 14:59:46 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 394Em5xB031415;
        Wed, 4 Oct 2023 14:59:46 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th9ax236b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 14:59:45 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 394EfnRH017637;
        Wed, 4 Oct 2023 14:59:44 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tey0nebe4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 14:59:44 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 394ExhNV3146480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Oct 2023 14:59:43 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8047C58060;
        Wed,  4 Oct 2023 14:59:43 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E69BE5803F;
        Wed,  4 Oct 2023 14:59:35 +0000 (GMT)
Received: from [9.179.14.141] (unknown [9.179.14.141])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  4 Oct 2023 14:59:35 +0000 (GMT)
Message-ID: <03cfbe39-da81-408e-6e61-3a1af6fabcac@linux.vnet.ibm.com>
Date:   Wed, 4 Oct 2023 20:29:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 2/2] sched/topology: change behaviour of sysctl
 sched_energy_aware based on the platform
Content-Language: en-US
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, qperret@google.com,
        srikar@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, pierre.gondois@arm.com, yu.c.chen@intel.com,
        tim.c.chen@linux.intel.com, pauld@redhat.com, lukasz.luba@arm.com,
        linux-doc@vger.kernel.org, bsegall@google.com, linux-eng@arm.com,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org
References: <20230929155209.667764-1-sshegde@linux.vnet.ibm.com>
 <20230929155209.667764-3-sshegde@linux.vnet.ibm.com>
 <xhsmhttr6oceh.mognet@vschneid.remote.csb>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <xhsmhttr6oceh.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YpnK0TJkTEwoCjujP6_EQ1jbEFFaNC5j
X-Proofpoint-ORIG-GUID: RFke6C4QVFPZNT9PZqyM3qeDzzEr9Uq9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_07,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040105
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/23 4:57 PM, Valentin Schneider wrote:
> On 29/09/23 21:22, Shrikanth Hegde wrote:

Hi Valentin, Thanks for taking a look at this patchset.

>> +static bool sched_is_eas_possible(const struct cpumask *cpu_mask)
>> +{
>> +	bool any_asym_capacity = false;
>> +	struct cpufreq_policy *policy;
>> +	struct cpufreq_governor *gov;
>> +	int i;
>> +
>> +	/* EAS is enabled for asymmetric CPU capacity topologies. */
>> +	for_each_cpu(i, cpu_mask) {
>> +		if (per_cpu(sd_asym_cpucapacity, i)) {
> 
> Lockdep should complain here in the sysctl path - this is an RCU-protected
> pointer.
> 
> rcu_access_pointer() should do since you're not dereferencing the pointer.

Yes. I did miss to catch that since mostly copied the snippets from build_perf_domains.
 
> 
>> +			any_asym_capacity = true;
>> +			break;
>> +		}
>> +	}
> 
>> @@ -231,6 +295,15 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
>>               return -EPERM;
>>
>>       ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> 
> Shouldn't this happen after we check sched_is_eas_possible()? Otherwise
> AFAICT a write can actually happen despite !sched_is_eas_possible().

Yes. That's right. Will change that.

> 
>> +	if (!sched_is_eas_possible(cpu_active_mask)) {
>> +		if (write) {
>> +			return -EOPNOTSUPP;
>> +		} else {
>> +			*lenp = 0;
>> +			return 0;
>> +		}
>> +	}
> 
> But now this is making me wonder, why not bite the bullet and store
> somewhere whether we ever managed to enable EAS? Something like so?
> (I didn't bother making this yet another static key given this is not a hot
> path at all)

IIUC, Problem with this is, a platform which can do EAS now, may not be able to do EAS 
sometime later. 
for example, frequency governor is changed from performance to 
schedutil, EAS can be enabled and sched_energy_once will be set, but later it can be 
set to performance again. In that case saying it is EAS capable is wrong. 

> ---
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index e0b9920e7e3e4..abd950f434206 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -209,6 +209,7 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
>  #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
>  DEFINE_STATIC_KEY_FALSE(sched_energy_present);
>  static unsigned int sysctl_sched_energy_aware = 1;
> +static bool __read_mostly sched_energy_once;
>  static DEFINE_MUTEX(sched_energy_mutex);
>  static bool sched_energy_update;
> 
> @@ -230,6 +231,15 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
>  	if (write && !capable(CAP_SYS_ADMIN))
>  		return -EPERM;
> 
> +	if (!sched_energy_once) {
> +		if (write) {
> +			return -EOPNOTSUPP;
> +		} else {
> +			*lenp = 0;
> +			return 0;
> +		}
> +	}
> +
>  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>  	if (!ret && write) {
>  		state = static_branch_unlikely(&sched_energy_present);
> @@ -340,6 +350,8 @@ static void sched_energy_set(bool has_eas)
>  		if (sched_debug())
>  			pr_info("%s: starting EAS\n", __func__);
>  		static_branch_enable_cpuslocked(&sched_energy_present);
> +		// Record that we managed to enable EAS at least once
> +		sched_energy_once = true;
>  	}
>  }
> 
> 
