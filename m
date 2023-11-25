Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3127F88C4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 08:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjKYHN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 02:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKYHN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 02:13:27 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C8219E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 23:13:32 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AP5N1FD020392;
        Sat, 25 Nov 2023 07:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rjGayuxOVug7bDGutDDASWq95H6wdbUqoQLJ+Xj2q10=;
 b=GyFi+oz12u5wU2Uj3fnzkOEHPnpZZkxOefahPIg5gmGIZvrzFg4Ld9wVocLzfAtbNjup
 xW3ywPm3u0uzxJHgveSGuitou5O7TFgOXkWGu0RRB99WPuYlLBIC+pXdr7IeD/9+7Myu
 Wg32YCbO3SSYurPxNXIcyyoPRidefHlFhaEC+YcuqaLymY3niNhngBSMh/i+NJ/2DTd/
 odLrf52TNfXklewqia8Ps5gfnVGJkHb0ba8QSMCCShrGXCiTT8fxd6v9tYMGtGfv9xD9
 Z8uqR4u4FBAa8j005rcr1hgU+orb7O07RFj80ngs8DRyF9gOVKSqOZxIY0c8QtvNxQbf Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ukaqkhq7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Nov 2023 07:10:31 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AP799nK020889;
        Sat, 25 Nov 2023 07:10:30 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ukaqkhq7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Nov 2023 07:10:30 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AP745N5011003;
        Sat, 25 Nov 2023 07:10:29 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf93mjh85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Nov 2023 07:10:29 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AP7ASRG41681460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Nov 2023 07:10:28 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 542F458059;
        Sat, 25 Nov 2023 07:10:28 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B473058043;
        Sat, 25 Nov 2023 07:10:20 +0000 (GMT)
Received: from [9.179.1.106] (unknown [9.179.1.106])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 25 Nov 2023 07:10:20 +0000 (GMT)
Message-ID: <29f5225a-e0fb-2381-4f19-49334a0dbbc8@linux.ibm.com>
Date:   Sat, 25 Nov 2023 12:40:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/3] sched/fair: Calculate the cache-hot time of the
 idle CPU
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        6dccbf0f54cc4ee068a157b9eebfb4b5fa3cc4af.1700548379.git.yu.c.chen@intel.com
Cc:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <cover.1700548379.git.yu.c.chen@intel.com>
 <6dccbf0f54cc4ee068a157b9eebfb4b5fa3cc4af.1700548379.git.yu.c.chen@intel.com>
From:   Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <6dccbf0f54cc4ee068a157b9eebfb4b5fa3cc4af.1700548379.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OP094ieJe62wbdhLp3PJV68N7ktI5Mbn
X-Proofpoint-GUID: Wz26uXQYexn8Y2JhATohVq51l3_gy9cN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-25_05,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311250049
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen Yu,

On 21/11/23 13:09, Chen Yu wrote:
> When a CPU is about to become idle due to task dequeue, uses
> the dequeued task's average sleep time to set the cache
> hot timeout of this idle CPU. This information can facilitate
> SIS to skip the cache-hot idle CPU and scan for the next
> cache-cold one. When that task is woken up again, it can choose
> its previous CPU and reuses its hot-cache.
> 
> This is a preparation for the next patch to introduce SIS_CACHE
> based task wakeup.
> 
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/sched/fair.c     | 30 +++++++++++++++++++++++++++++-
>  kernel/sched/features.h |  1 +
>  kernel/sched/sched.h    |  1 +
>  3 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 672616503e35..c309b3d203c0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6853,8 +6853,17 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	util_est_update(&rq->cfs, p, task_sleep);
>  
>  	if (task_sleep) {
> -		p->last_dequeue_time = sched_clock_cpu(cpu_of(rq));
> +		u64 now = sched_clock_cpu(cpu_of(rq));
> +
> +		p->last_dequeue_time = now;
>  		p->last_dequeue_cpu = cpu_of(rq);
> +
> +#ifdef CONFIG_SMP
> +		/* this rq becomes idle, update its cache hot timeout */
> +		if (sched_feat(SIS_CACHE) && !rq->nr_running &&
> +		    p->avg_hot_dur)
> +			rq->cache_hot_timeout = max(rq->cache_hot_timeout, now + p->avg_hot_dur);

As per the discussion in the rfc patch, you mentioned that SIS_CACHE only honors the average sleep time
of the latest dequeued task and that we don't know how much of the cache is polluted by the latest task.

So I was wondering what made you to put max here.

Thanks and Regards 
Madadi Vineeth Reddy

