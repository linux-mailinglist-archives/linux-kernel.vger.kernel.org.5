Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E44F787F8E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240705AbjHYGIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbjHYGHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:07:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5DC1BCC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:07:34 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P66xYI003899;
        Fri, 25 Aug 2023 06:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6sJh0koK4zVQEuVvThXOR9jZ7+gsTEc/n56GLg6EF0c=;
 b=kanRf1dqfIJrJZc4d6zOh7zoDRpbngB8VpDWBbHgANnXiNVnrkdj5f7C+Nv4u4nPlOSc
 IgWNWm419zzbL1n56jjzih1uzHkRvBNfGkRBZ+DCUpWNKRvd5ekvPSL/xZa41oFszk6o
 FyVOXGh3ZR2gJFHzQ1wieO8s4kgH9Afe4znHCauC+zUGSy3c16MDmqBqZ1dPEEnDEn8T
 DP2fNDK5+Iwb/WFY2UgtSz2CuUwPjBpDNH9gwxw0uw5YkMREfWbw0mhZbOvDwSAMKZis
 HB24l5slP71nFJML1jxabuwf8McuIys803/UCZ5U7h5izz77s8nmBlw0MD+0ZRF6JPf1 dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3spp5v8nra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 06:07:20 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37P67J8Z006328;
        Fri, 25 Aug 2023 06:07:19 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3spp5v8mjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 06:07:19 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37P5P25s004085;
        Fri, 25 Aug 2023 06:02:08 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sn21rw5xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 06:02:08 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37P628RQ12059180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 06:02:08 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0358B58056;
        Fri, 25 Aug 2023 06:02:08 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3222558052;
        Fri, 25 Aug 2023 06:02:03 +0000 (GMT)
Received: from [9.171.40.203] (unknown [9.171.40.203])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 25 Aug 2023 06:02:02 +0000 (GMT)
Message-ID: <932734b0-0a0c-c906-5e0a-a560a9d93ebc@linux.vnet.ibm.com>
Date:   Fri, 25 Aug 2023 11:32:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 4/7] sched/fair: Calculate the scan depth for idle
 balance based on system utilization
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Aaron Lu <aaron.lu@intel.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <cover.1690273854.git.yu.c.chen@intel.com>
 <61e6fce60ca738215b6e5ad9033fb692c3a8fbb1.1690273854.git.yu.c.chen@intel.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <61e6fce60ca738215b6e5ad9033fb692c3a8fbb1.1690273854.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ySHR_sSvVKgLtAWZpYMNxkhIM3mZx_dF
X-Proofpoint-ORIG-GUID: niSlYZO-s8e2zRN-uc-4ajC6Qb0duZjj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_04,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250051
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/23 8:05 PM, Chen Yu wrote:
> When the CPU is about to enter idle, it invokes newidle_balance()
> to pull some tasks from other runqueues. Although there is per
> domain max_newidle_lb_cost to throttle the newidle_balance(), it
> would be good to further limit the scan based on overall system
> utilization. The reason is that there is no limitation for
> newidle_balance() to launch this balance simultaneously on
> multiple CPUs. Since each newidle_balance() has to traverse all
> the groups to calculate the statistics one by one, this total
> time cost on newidle_balance() could be O(n^2). n is the number
> of groups. This issue is more severe if there are many groups
> within 1 domain, for example, a system with a large number of
> Cores in a LLC domain. This is not good for performance or
> power saving.
> 
> sqlite has spent quite some time on newidle balance() on Intel
> Sapphire Rapids, which has 2 x 56C/112T = 224 CPUs:
> 6.69%    0.09%  sqlite3     [kernel.kallsyms]   [k] newidle_balance
> 5.39%    4.71%  sqlite3     [kernel.kallsyms]   [k] update_sd_lb_stats
> 
> Based on this observation, limit the scan depth of newidle_balance()
> by considering the utilization of the sched domain. Let the number of
> scanned groups be a linear function of the utilization ratio:
> 
> nr_groups_to_scan = nr_groups * (1 - util_ratio)
> 
> Suggested-by: Tim Chen <tim.c.chen@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  include/linux/sched/topology.h |  1 +
>  kernel/sched/fair.c            | 30 ++++++++++++++++++++++++++++++
>  kernel/sched/features.h        |  1 +
>  3 files changed, 32 insertions(+)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index d6a64a2c92aa..af2261308529 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -84,6 +84,7 @@ struct sched_domain_shared {
>  	int		nr_idle_scan;
>  	unsigned long	total_load;
>  	unsigned long	total_capacity;
> +	int		nr_sg_scan;
>  };
>  
>  struct sched_domain {
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index edcfee9965cd..6925813db59b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10153,6 +10153,35 @@ static void ilb_save_stats(struct lb_env *env,
>  		WRITE_ONCE(sd_share->total_capacity, sds->total_capacity);
>  }
>  
> +static void update_ilb_group_scan(struct lb_env *env,
> +				  unsigned long sum_util,
> +				  struct sched_domain_shared *sd_share)
> +{
> +	u64 tmp, nr_scan;
> +
> +	if (!sched_feat(ILB_UTIL))
> +		return;
> +
> +	if (!sd_share)
> +		return;
> +
> +	if (env->idle == CPU_NEWLY_IDLE)
> +		return;


Suggestion for small improvement:

First if condition here could be check for newidle. As it often very often we could save a few cycles of checking
sched feature.

> +	if (env->idle == CPU_NEWLY_IDLE)
> +		return;


> +
> +	/*
> +	 * Limit the newidle balance scan depth based on overall system
> +	 * utilization:
> +	 * nr_groups_scan = nr_groups * (1 - util_ratio)
> +	 * and util_ratio = sum_util / (sd_weight * SCHED_CAPACITY_SCALE)
> +	 */
> +	nr_scan = env->sd->nr_groups * sum_util;
> +	tmp = env->sd->span_weight * SCHED_CAPACITY_SCALE;
> +	do_div(nr_scan, tmp);
> +	nr_scan = env->sd->nr_groups - nr_scan;
> +	if ((int)nr_scan != sd_share->nr_sg_scan)
> +		WRITE_ONCE(sd_share->nr_sg_scan, (int)nr_scan);
> +}
> +
>  /**
>   * update_sd_lb_stats - Update sched_domain's statistics for load balancing.
>   * @env: The load balancing environment.
> @@ -10231,6 +10260,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  	}
>  
>  	update_idle_cpu_scan(env, sum_util);
> +	update_ilb_group_scan(env, sum_util, sd_share);
>  
>  	/* save a snapshot of stats during periodic load balance */
>  	ilb_save_stats(env, sd_share, sds);
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 3cb71c8cddc0..30f6d1a2f235 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -103,3 +103,4 @@ SCHED_FEAT(ALT_PERIOD, true)
>  SCHED_FEAT(BASE_SLICE, true)
>  
>  SCHED_FEAT(ILB_SNAPSHOT, true)
> +SCHED_FEAT(ILB_UTIL, true)
