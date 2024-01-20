Return-Path: <linux-kernel+bounces-31739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C6883332B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 08:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D01283737
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 07:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09CD2578;
	Sat, 20 Jan 2024 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AU7AioZQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF3E20F8;
	Sat, 20 Jan 2024 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705737217; cv=none; b=QNIZDAG4ieHLHVG3MzhxYcoELOFl19WNhAiQRI98NLAcdb9no+QCpn9A8HKRa3cf6DpJHhYw0SCwQ4RQcoWNtvNjQ6vQGQiS4lo9mvN7fUR8Nk6BjxJYzwZtGheue+7ZoNZI33uproej9h9wLfMHxmsvBCLIqqZMbpZxyTPP9jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705737217; c=relaxed/simple;
	bh=ldAcGu1CNvY1Kpmb+oWFg8J45USvtDkHVzgNR763SJQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=Di92zHLmori7yU49Iwc/ETJi3deoEVS04oHhBLdBPfxczDMWlREA0LManBtNd3+vMWiybS8EGybuTwzv5J7A9vWtv0U96jPKuUHSvSdqMJQ5wIEPze6UQBjjTMDNIPg8pP6RWgqIyqWgyIBPccWXD9HZ6U+PbllJoM05u1m6oeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AU7AioZQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40K7pMmb020319;
	Sat, 20 Jan 2024 07:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:subject:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=sIaIgRS2S0r8DY17J8KDZU9+JrNZK7yaVQcDToEpUDo=; b=AU
	7AioZQiwkYDhwUtOy5ImdNve6ftwg8MTl3Y66A+FC9fxWi3rFeTicDVbURW2qi4z
	ZYQfGFixJ4B/y8p8JA6jwBloJQnVf0AarcpWj2uJUkiMNbk4wd2MKfBEs5+S15P/
	fR0BvAw6uPVIhSGA1syQAt0XkuYZZR1L5Uzq+opDZ8ZrEd0Suc/rrfeylcA0/mRr
	u9Dd0Zyvc0pxy0OzEF043XCBN9+vCJDcqSMBn8gjAtdaBYxOLgt/4axRNfVOxy/Y
	zSM5/Yl8FYNKi/uqqR+/ko7n9VHD/hZwKDmuR0b5Wf8aSpPUwMiX0GwjxHNnGm6z
	G6cOG6Py/p3hH8xqdI6g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr7fd05cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jan 2024 07:52:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40K7qtk1016620
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jan 2024 07:52:55 GMT
Received: from [10.216.19.184] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 19 Jan
 2024 23:52:49 -0800
Message-ID: <a561029e-993d-726d-18ce-0bc014e6533c@quicinc.com>
Date: Sat, 20 Jan 2024 13:22:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ashay Jaiswal <quic_ashayj@quicinc.com>
Subject: Re: [PATCH v2 8/8] sched/pelt: Introduce PELT multiplier
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
        "Peter
 Zijlstra" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot
	<vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Lukasz Luba
	<lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Rick Yiu
	<rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>,
        <quic_anshar@quicinc.com>, <quic_atulpant@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_rgottimu@quicinc.com>,
        <quic_adharmap@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <quic_pkondeti@quicinc.com>
References: <20231208002342.367117-1-qyousef@layalina.io>
 <20231208002342.367117-9-qyousef@layalina.io>
Content-Language: en-US
In-Reply-To: <20231208002342.367117-9-qyousef@layalina.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Qxc4y1Qovd36AthJzzU4Rj0zSwYdjSx7
X-Proofpoint-ORIG-GUID: Qxc4y1Qovd36AthJzzU4Rj0zSwYdjSx7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-20_03,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401200063

Hello Qais Yousef,

We ran few benchmarks with PELT multiplier patch on a Snapdragon 8Gen2
based internal Android device and we are observing significant
improvements with PELT8 configuration compared to PELT32.

Following are some of the benchmark results with PELT32 and PELT8
configuration:

+-----------------+---------------+----------------+----------------+
| Test case                       |     PELT32     |     PELT8      |
+-----------------+---------------+----------------+----------------+
|                 |    Overall    |     711543     |     971275     |
|                 +---------------+----------------+----------------+
|                 |    CPU        |     193704     |     224378     |
|                 +---------------+----------------+----------------+
|ANTUTU V9.3.9    |    GPU        |     284650     |     424774     |
|                 +---------------+----------------+----------------+
|                 |    MEM        |     125207     |     160548     |
|                 +---------------+----------------+----------------+
|                 |    UX         |     107982     |     161575     |
+-----------------+---------------+----------------+----------------+
|                 |   Single core |     1170       |     1268       |
|GeekBench V5.4.4 +---------------+----------------+----------------+
|                 |   Multi core  |     2530       |     3797       |
+-----------------+---------------+----------------+----------------+
|                 |    Twitter    |     >50 Janks  |     0          |
|     SCROLL      +---------------+----------------+----------------+
|                 |    Contacts   |     >30 Janks  |     0          |
+-----------------+---------------+----------------+----------------+

Please let us know if you need any support with running any further
workloads for PELT32/PELT8 experiments, we can help with running the
experiments.

Thank you,
Ashay Jaiswal

On 12/8/2023 5:53 AM, Qais Yousef wrote:
> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> The new sched_pelt_multiplier boot param allows a user to set a clock
> multiplier to x2 or x4 (x1 being the default). This clock multiplier
> artificially speeds up PELT ramp up/down similarly to use a faster
> half-life than the default 32ms.
> 
>   - x1: 32ms half-life
>   - x2: 16ms half-life
>   - x4: 8ms  half-life
> 
> Internally, a new clock is created: rq->clock_task_mult. It sits in the
> clock hierarchy between rq->clock_task and rq->clock_pelt.
> 
> The param is set as read only and can only be changed at boot time via
> 
> 	kernel.sched_pelt_multiplier=[1, 2, 4]
> 
> PELT has a big impact on the overall system response and reactiveness to
> change. Smaller PELT HF means it'll require less time to reach the
> maximum performance point of the system when the system become fully
> busy; and equally shorter time to go back to lowest performance point
> when the system goes back to idle.
> 
> This faster reaction impacts both dvfs response and migration time
> between clusters in HMP system.
> 
> Smaller PELT values are expected to give better performance at the cost
> of more power. Under powered systems can particularly benefit from
> smaller values. Powerful systems can still benefit from smaller values
> if they want to be tuned towards perf more and power is not the major
> concern for them.
> 
> This combined with respone_time_ms from schedutil should give the user
> and sysadmin a deterministic way to control the triangular power, perf
> and thermals for their system. The default response_time_ms will half
> as PELT HF halves.
> 
> Update approximate_{util_avg, runtime}() to take into account the PELT
> HALFLIFE multiplier.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> [Converted from sysctl to boot param and updated commit message]
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  kernel/sched/core.c  |  2 +-
>  kernel/sched/pelt.c  | 52 ++++++++++++++++++++++++++++++++++++++++++--
>  kernel/sched/pelt.h  | 42 +++++++++++++++++++++++++++++++----
>  kernel/sched/sched.h |  1 +
>  4 files changed, 90 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b4a1c8ea9e12..9c8626b4ddff 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -745,7 +745,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
>  	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
>  		update_irq_load_avg(rq, irq_delta + steal);
>  #endif
> -	update_rq_clock_pelt(rq, delta);
> +	update_rq_clock_task_mult(rq, delta);
>  }
>  
>  void update_rq_clock(struct rq *rq)
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index 00a1b9c1bf16..0a10e56f76c7 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -468,6 +468,54 @@ int update_irq_load_avg(struct rq *rq, u64 running)
>  }
>  #endif /* CONFIG_HAVE_SCHED_AVG_IRQ */
>  
> +__read_mostly unsigned int sched_pelt_lshift;
> +static unsigned int sched_pelt_multiplier = 1;
> +
> +static int set_sched_pelt_multiplier(const char *val, const struct kernel_param *kp)
> +{
> +	int ret;
> +
> +	ret = param_set_int(val, kp);
> +	if (ret)
> +		goto error;
> +
> +	switch (sched_pelt_multiplier)  {
> +	case 1:
> +		fallthrough;
> +	case 2:
> +		fallthrough;
> +	case 4:
> +		WRITE_ONCE(sched_pelt_lshift,
> +			   sched_pelt_multiplier >> 1);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
> +	return 0;
> +
> +error:
> +	sched_pelt_multiplier = 1;
> +	return ret;
> +}
> +
> +static const struct kernel_param_ops sched_pelt_multiplier_ops = {
> +	.set = set_sched_pelt_multiplier,
> +	.get = param_get_int,
> +};
> +
> +#ifdef MODULE_PARAM_PREFIX
> +#undef MODULE_PARAM_PREFIX
> +#endif
> +/* XXX: should we use sched as prefix? */
> +#define MODULE_PARAM_PREFIX "kernel."
> +module_param_cb(sched_pelt_multiplier, &sched_pelt_multiplier_ops, &sched_pelt_multiplier, 0444);
> +MODULE_PARM_DESC(sched_pelt_multiplier, "PELT HALFLIFE helps control the responsiveness of the system.");
> +MODULE_PARM_DESC(sched_pelt_multiplier, "Accepted value: 1 32ms PELT HALIFE - roughly 200ms to go from 0 to max performance point (default).");
> +MODULE_PARM_DESC(sched_pelt_multiplier, "                2 16ms PELT HALIFE - roughly 100ms to go from 0 to max performance point.");
> +MODULE_PARM_DESC(sched_pelt_multiplier, "                4  8ms PELT HALIFE - roughly  50ms to go from 0 to max performance point.");
> +
>  /*
>   * Approximate the new util_avg value assuming an entity has continued to run
>   * for @delta us.
> @@ -482,7 +530,7 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
>  	if (unlikely(!delta))
>  		return util;
>  
> -	accumulate_sum(delta, &sa, 1, 0, 1);
> +	accumulate_sum(delta << sched_pelt_lshift, &sa, 1, 0, 1);
>  	___update_load_avg(&sa, 0);
>  
>  	return sa.util_avg;
> @@ -494,7 +542,7 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
>  u64 approximate_runtime(unsigned long util)
>  {
>  	struct sched_avg sa = {};
> -	u64 delta = 1024; // period = 1024 = ~1ms
> +	u64 delta = 1024 << sched_pelt_lshift; // period = 1024 = ~1ms
>  	u64 runtime = 0;
>  
>  	if (unlikely(!util))
> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> index 3a0e0dc28721..9b35b5072bae 100644
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -61,6 +61,14 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
>  	WRITE_ONCE(avg->util_est.enqueued, enqueued);
>  }
>  
> +static inline u64 rq_clock_task_mult(struct rq *rq)
> +{
> +	lockdep_assert_rq_held(rq);
> +	assert_clock_updated(rq);
> +
> +	return rq->clock_task_mult;
> +}
> +
>  static inline u64 rq_clock_pelt(struct rq *rq)
>  {
>  	lockdep_assert_rq_held(rq);
> @@ -72,7 +80,7 @@ static inline u64 rq_clock_pelt(struct rq *rq)
>  /* The rq is idle, we can sync to clock_task */
>  static inline void _update_idle_rq_clock_pelt(struct rq *rq)
>  {
> -	rq->clock_pelt  = rq_clock_task(rq);
> +	rq->clock_pelt = rq_clock_task_mult(rq);
>  
>  	u64_u32_store(rq->clock_idle, rq_clock(rq));
>  	/* Paired with smp_rmb in migrate_se_pelt_lag() */
> @@ -121,6 +129,27 @@ static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
>  	rq->clock_pelt += delta;
>  }
>  
> +extern unsigned int sched_pelt_lshift;
> +
> +/*
> + * absolute time   |1      |2      |3      |4      |5      |6      |
> + * @ mult = 1      --------****************--------****************-
> + * @ mult = 2      --------********----------------********---------
> + * @ mult = 4      --------****--------------------****-------------
> + * clock task mult
> + * @ mult = 2      |   |   |2  |3  |   |   |   |   |5  |6  |   |   |
> + * @ mult = 4      | | | | |2|3| | | | | | | | | | |5|6| | | | | | |
> + *
> + */
> +static inline void update_rq_clock_task_mult(struct rq *rq, s64 delta)
> +{
> +	delta <<= READ_ONCE(sched_pelt_lshift);
> +
> +	rq->clock_task_mult += delta;
> +
> +	update_rq_clock_pelt(rq, delta);
> +}
> +
>  /*
>   * When rq becomes idle, we have to check if it has lost idle time
>   * because it was fully busy. A rq is fully used when the /Sum util_sum
> @@ -147,7 +176,7 @@ static inline void update_idle_rq_clock_pelt(struct rq *rq)
>  	 * rq's clock_task.
>  	 */
>  	if (util_sum >= divider)
> -		rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt;
> +		rq->lost_idle_time += rq_clock_task_mult(rq) - rq->clock_pelt;
>  
>  	_update_idle_rq_clock_pelt(rq);
>  }
> @@ -218,13 +247,18 @@ update_irq_load_avg(struct rq *rq, u64 running)
>  	return 0;
>  }
>  
> -static inline u64 rq_clock_pelt(struct rq *rq)
> +static inline u64 rq_clock_task_mult(struct rq *rq)
>  {
>  	return rq_clock_task(rq);
>  }
>  
> +static inline u64 rq_clock_pelt(struct rq *rq)
> +{
> +	return rq_clock_task_mult(rq);
> +}
> +
>  static inline void
> -update_rq_clock_pelt(struct rq *rq, s64 delta) { }
> +update_rq_clock_task_mult(struct rq *rq, s64 delta) { }
>  
>  static inline void
>  update_idle_rq_clock_pelt(struct rq *rq) { }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index bbece0eb053a..a7c89c623250 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1029,6 +1029,7 @@ struct rq {
>  	u64			clock;
>  	/* Ensure that all clocks are in the same cache line */
>  	u64			clock_task ____cacheline_aligned;
> +	u64			clock_task_mult;
>  	u64			clock_pelt;
>  	unsigned long		lost_idle_time;
>  	u64			clock_pelt_idle;

