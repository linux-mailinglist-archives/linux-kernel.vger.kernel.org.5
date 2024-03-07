Return-Path: <linux-kernel+bounces-94913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6015F8746A4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62681F22F75
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9CCDF55;
	Thu,  7 Mar 2024 03:19:30 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4266A3D71
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 03:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709781569; cv=none; b=BDl4KefSHzFJnTQdEYzdAQtmmdPXmxgd3UeRCo8hvbrxFfHZL1xjzRstRKzNVPiFhvYnKHh7WnXuSqm7UvMOEkCJy8pUwqigrjxI4haZJD5+R3vLPxymVqgDm6mgg8ToS+KaoPwzuecWTYmRJw4zcKUzeqpMD/qLDx3GDrN0SYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709781569; c=relaxed/simple;
	bh=ZVqbas+1y6f0zcBPwDjaqRxR+PIBBUBSjcDr4o9cHeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SIoQ1ypxCqQkbKFc0jQRzqYelCfewftfTCk9LjmDEqCJKwdOnr3uK+zrOt/3XxMl4SZpNqos59iAK+tXw6PvHhopBYTCJsp1ETwQP5mCVU0K1SugyCgh5VqzvFyBadxgl3lCMnxZAjg9rDCL3LfaUusk0uf+blPHUdYN1Cq+n1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp72t1709781367toxgkw18
X-QQ-Originating-IP: KoZh+Po1jLVQC+oHcWtjmGtLtMf0+3W5LeETRJ5+ABg=
Received: from [127.0.0.1] ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 Mar 2024 11:16:05 +0800 (CST)
X-QQ-SSF: 00400000000000B0B000000A0000000
X-QQ-FEAT: Sm8l2YSuDymxf++w3HKzK4EdUwh7ZB6wZT8AOqyrvXP2/q3K7LZGwqh5TzK28
	SdWIMUsk5pBQ8DHE15nuOhKTFrzUH7gSWmMyxeURquSja7VhPfyqGwYROxzWI4jvIMqr+53
	qb2OH/2yPWLOVpukbO8ksWFq4eooIN/U4Au+lIUrU67EIQpu8zIyLUWydoota5poApC2Fw3
	OKx0eytuCw+WJeWZbeqEwY3n9ocN5vKtPQHPeYjPi6VMKEwa2d5dMR2TtJLAjmAq/w1HDMG
	amK7iofJexg8QIXDTF8yM9cMoFKj78WapSS4ujpx5fwHVfjkkeleOlFeasI3CC6t/txpDjC
	yUjHKS1dqfn+uLymyQc/DhOPgT6R+BVoTNiP+e32GRw/OGzYZznZqS0wZUbIFg01j8q/hUZ
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15119548749084099075
Message-ID: <39E57A3DFB5843A6+f56f2b52-445f-4205-a99f-bd6374985389@shingroup.cn>
Date: Thu, 7 Mar 2024 11:16:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/core: Handle generic events normally instead of
 trying all pmu
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240306151017.2114-1-jialong.yang@shingroup.cn>
 <Zeib-e1RYm2Dlk8c@FVFF77S0Q05N>
Content-Language: en-US
From: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>
In-Reply-To: <Zeib-e1RYm2Dlk8c@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1



在 2024/3/7 0:38, Mark Rutland 写道:
> On Wed, Mar 06, 2024 at 11:10:15PM +0800, JiaLong.Yang wrote:
>> We have pay more effort on handling generic events. We treat them
>> specially caused us paying more.
> 
> Are you seeing an actual problem in practice? ... or is this just intended as a
> cleanup/improvement? >
> What problem are you actually trying to solve here?
> 

Latter. I write a driver. But I have to do some checks which likes that 
they should be done in framework. And treating PERF_TYPE_HARDWARE and 
PERF_TYPE_HW_CACHE specially like introducing PERF_PMU_TYPE_SHIFT is not 
very beautiful.

>> Now time have told us that PMU type between 0 and PERF_TYPE_MAX only
>> corresponds to one PMU.
> 
> There can be at most one PMU registered for each type, but several PMUs may
> need to handle events for that type.
> 
> Trivially, there are a number of PMUs which share the PERF_TYPE_SOFTWARE type,
> e.g.
> 
> * perf_swevent, handled by perf_swevent_init()
> * perf_cpu_clock, handled by cpu_clock_event_init()
> * perf_task_clock, handled by task_clock_event_init()
> 
This is the current code for above example:
	perf_pmu_register(&perf_swevent, "software", PERF_TYPE_SOFTWARE);
         perf_pmu_register(&perf_cpu_clock, "cpu_clock", -1);
         perf_pmu_register(&perf_task_clock, "task_clock", -1);

But what I said still is wrong. At least the type PERF_TYPE_RAW is general.

PERF_TYPE_TRACEPOINT is also only one.

> ... which have non-overlapping events in the PERF_TYPE_SOFTWARE event
> namespace.
> 
> On systems with heterogeneous PMUs (e.g. ARM big.LITTLE systems), several PMUs
> can handle the PERF_TYPE_{HARDWARE,RAW,CACHE} event namespaces, and there's
> existing software that depends upon that working *without* the extended HW type
> IDs.
> 

The event framework mapping event to pmu is mainly according to type or 
pmu idr. The type PERF_TYPE_HARDWARE and HW_CACHE only is a feature. For 
the feature, we trying such events in all PMUs and drivers not handling 
them should reject it obviously. Now uncore PMU is so many. And core PMU 
only several.

Whatever, the tools calling perf_event_open should tell framework the 
PMU idr. Maybe by event->attr.type, or event->attr.config >> 
PERF_PMU_TYPE_SHIFT. We can save the latter and make idr number 
special(PERF_TYPE_HARDWARE, HW_CACHE) as a default choice.

Each special type([0, PERF_TYPE_RAW)) is not necessary to correspond 
more PMUs. Except hardware core PMUs, all other PMUs could be registered 
as type == -1.

We keeping the special types originally is to do some different logic 
and maybe also have a fixed idr number. But now in framework code, they 
are almost no difference. For example PERF_TYPE_TRACEPOINT scenes in 
core.c(only two):
static int perf_tp_event_init(struct perf_event *event)
{
	if(event->attr.type != PERF_TYPE_TRACEPOINT)
		return -ENOENT;

	...
}

static inline void perf_tp_register(void)
{
         perf_pmu_register(&perf_tracepoint, "tracepoint", 
PERF_TYPE_TRACEPOINT);
#ifdef CONFIG_KPROBE_EVENTS
         perf_pmu_register(&perf_kprobe, "kprobe", -1);
#endif
#ifdef CONFIG_UPROBE_EVENTS
         perf_pmu_register(&perf_uprobe, "uprobe", -1);
#endif
}

Why we need the check(event->attr.type != PERF_TYPE_TRACEPOINT)?
The trying event init.

And for the heterogeneous PMUs, they are distinguished according to 
event->attr.config >> PERF_PMU_TYPE_SHIFT. I will have to be compatible 
with it.

It is funny. Why there is only one PMU registered with each special 
type. OK, except PERF_TYPE_RAW.

>> So we can handle the special when registering PMU not in event opening. And
>> we can know which PMU is used to the generic event.
> 
> No we cannot. There may be several PMUs which need to handle a given generic
> event type.
> 
>> The added capabilities PERF_PMU_CAP_EVENT_HARDWARE and
>> PERF_PMU_CAP_EVENT_HW_CACHE will alloc idr for PERF_TYPE_HARDWARE and
>> PERF_TYPE_HW_CACHE with same PMU.
> 
> When I suggested using capabilities in:
> 
>    https://lore.kernel.org/lkml/ZecStMBA4YgQaBEZ@FVFF77S0Q05N/
> 
> ... I had meant that the core code could check just before calling the
> pmu::event_init() function, in order to simplify the implementation of the
> event_init() functions. I did not mean for this to change the way we
> manipulated the IDR.

Yes.I get some inspire from you.
But there is not flag telling me that the pmu is a extended one.

> 
>> We'd better handle uncore-task event before calling pmu->event_init().
> 
> This is a nice-to-have, but it's logically separate from the rest of this
> patch.

If we not use the trying, we can do more checks here. Because we have 
know more information.

> 
>>
>> The code is compatible with PERF_PMU_TYPE_SHIFT.
>> /*
>>   * attr.config layout for type PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
>>   * PERF_TYPE_HARDWARE:			0xEEEEEEEE000000AA
>>   *					AA: hardware event ID
>>   *					EEEEEEEE: PMU type ID
>>   * PERF_TYPE_HW_CACHE:			0xEEEEEEEE00DDCCBB
>>   *					BB: hardware cache ID
>>   *					CC: hardware cache op ID
>>   *					DD: hardware cache op result ID
>>   *					EEEEEEEE: PMU type ID
>>   * If the PMU type ID is 0, the PERF_TYPE_RAW will be applied.
>>   */
>>
>> But the drivers have to give the corresponding capabilities obviously.
>>
>> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
>> ---
>>   include/linux/perf_event.h |  4 +-
>>   kernel/events/core.c       | 83 +++++++++++++++++++++++---------------
>>   2 files changed, 54 insertions(+), 33 deletions(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index d2a15c0c6f8a..edf4365ab7cc 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -290,7 +290,9 @@ struct perf_event_pmu_context;
>>   #define PERF_PMU_CAP_ITRACE			0x0020
>>   #define PERF_PMU_CAP_NO_EXCLUDE			0x0040
>>   #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
>> -#define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
>> +#define PERF_PMU_CAP_EVENT_HARDWARE             0x0100
>> +#define PERF_PMU_CAP_EVENT_HW_CACHE             0x0200
>> +#define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0300
>>   
>>   struct perf_output_handle;
>>   
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index f0f0f71213a1..02f14ae09d09 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -11516,6 +11516,7 @@ static struct lock_class_key cpuctx_lock;
>>   int perf_pmu_register(struct pmu *pmu, const char *name, int type)
>>   {
>>   	int cpu, ret, max = PERF_TYPE_MAX;
>> +	int cap = pmu->capabilities;
>>   
>>   	mutex_lock(&pmus_lock);
>>   	ret = -ENOMEM;
>> @@ -11523,7 +11524,6 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
>>   	if (!pmu->pmu_disable_count)
>>   		goto unlock;
>>   
>> -	pmu->type = -1;
>>   	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n")) {
>>   		ret = -EINVAL;
>>   		goto free_pdc;
>> @@ -11538,15 +11538,34 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
>>   	if (ret < 0)
>>   		goto free_pdc;
>>   
>> +	/*
>> +	 * Ensure one type ([0, PERF_TYPE_MAX)) correspond to one PMU.
>> +	 */
>>   	WARN_ON(type >= 0 && ret != type);
>>   
>>   	type = ret;
>>   	pmu->type = type;
>>   
>> +	if ((type != PERF_TYPE_HARDWARE) &&
>> +	    (cap & PERF_PMU_CAP_EVENT_HARDWARE)) {
>> +		ret = idr_alloc(&pmu_idr, pmu, PERF_TYPE_HARDWARE,
>> +				PERF_TYPE_HARDWARE + 1, GFP_KERNEL);
>> +		if (ret < 0)
>> +			goto free_idr;
>> +	}
> 
> This means that if I try to register more than one PMU with
> PERF_PMU_CAP_EVENT_HARDWARE, the second will fail IDR allocation and fail to
> register.

We can make the first as default one. The latter will pass through 
without registering PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE.

> 
> ... so this is entirely useless for systems with heterogeneous PMUs, where each
> of those *should* be able to handle plain PERF_TYPE_HARDWARE events for legacy reasons.
> 
> I agree that the existing event initialization code is grotty, but that's
> largely an artifact of maintaining existing ABI. AFAICT this patch breaks that,
> and makes the code complex in a different way rather than actually simlifying anything.
> 
> Therefore, NAK to this patch.

The patch has many problems I known. It just is a thought.

> 
> As above, I think it does make sense to have the core code own some common
> checks (e.g. rejecting task-bound uncore events, filting generic events from
> PMUs that don't support those), so I'm open to patches doing that.
> 

Fine. It's useful.

> Mark.
> 
>> +
>> +	if ((type != PERF_TYPE_HW_CACHE) &&
>> +	    (cap & PERF_PMU_CAP_EVENT_HW_CACHE)) {
>> +		ret = idr_alloc(&pmu_idr, pmu, PERF_TYPE_HW_CACHE,
>> +				PERF_TYPE_HW_CACHE + 1, GFP_KERNEL);
>> +		if (ret < 0)
>> +			goto free_idr_hw;
>> +	}
>> +
>>   	if (pmu_bus_running && !pmu->dev) {
>>   		ret = pmu_dev_alloc(pmu);
>>   		if (ret)
>> -			goto free_idr;
>> +			goto free_idr_hw_cache;
>>   	}
>>   
>>   	ret = -ENOMEM;
>> @@ -11604,6 +11623,14 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
>>   		put_device(pmu->dev);
>>   	}
>>   
>> +free_idr_hw_cache:
>> +	if (cap & PERF_PMU_CAP_EVENT_HW_CACHE)
>> +		idr_remove(&pmu_idr, PERF_TYPE_HW_CACHE);
>> +
>> +free_idr_hw:
>> +	if (cap & PERF_PMU_CAP_EVENT_HARDWARE)
>> +		idr_remove(&pmu_idr, PERF_TYPE_HARDWARE);
>> +
>>   free_idr:
>>   	idr_remove(&pmu_idr, pmu->type);
>>   
>> @@ -11648,6 +11675,7 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
>>   {
>>   	struct perf_event_context *ctx = NULL;
>>   	int ret;
>> +	bool uncore_pmu = false, extded_pmu = false;
>>   
>>   	if (!try_module_get(pmu->module))
>>   		return -ENODEV;
>> @@ -11668,6 +11696,20 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
>>   		BUG_ON(!ctx);
>>   	}
>>   
>> +	if (perf_invalid_context == pmu->task_ctx_nr)
>> +		uncore_pmu = true;
>> +
>> +	if (pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE)
>> +		extded_pmu = true;
>> +
>> +	/* Disallow uncore-task events. */
>> +	if (uncore_pmu && (event->attach_state & PERF_ATTACH_TASK))
>> +		return -EINVAL;
>> +
>> +	/* Ensure pmu not supporting generic events will not be passed such event. */
>> +	if (!extded_pmu && (event->attr.type & PERF_PMU_CAP_EXTENDED_HW_TYPE))
>> +		return -EINVAL;
>> +
>>   	event->pmu = pmu;
>>   	ret = pmu->event_init(event);
>>   
>> @@ -11695,7 +11737,6 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
>>   
>>   static struct pmu *perf_init_event(struct perf_event *event)
>>   {
>> -	bool extended_type = false;
>>   	int idx, type, ret;
>>   	struct pmu *pmu;
>>   
>> @@ -11720,36 +11761,15 @@ static struct pmu *perf_init_event(struct perf_event *event)
>>   	 * are often aliases for PERF_TYPE_RAW.
>>   	 */
>>   	type = event->attr.type;
>> -	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) {
>> -		type = event->attr.config >> PERF_PMU_TYPE_SHIFT;
>> -		if (!type) {
>> -			type = PERF_TYPE_RAW;
>> -		} else {
>> -			extended_type = true;
>> -			event->attr.config &= PERF_HW_EVENT_MASK;
>> -		}
>> -	}
>> +	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE)
>> +		event->attr.config &= PERF_HW_EVENT_MASK;
>>   
>> -again:
>>   	rcu_read_lock();
>>   	pmu = idr_find(&pmu_idr, type);
>>   	rcu_read_unlock();
>> -	if (pmu) {
>> -		if (event->attr.type != type && type != PERF_TYPE_RAW &&
>> -		    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
>> -			goto fail;
>>   
>> -		ret = perf_try_init_event(pmu, event);
>> -		if (ret == -ENOENT && event->attr.type != type && !extended_type) {
>> -			type = event->attr.type;
>> -			goto again;
>> -		}
>> -
>> -		if (ret)
>> -			pmu = ERR_PTR(ret);
>> -
>> -		goto unlock;
>> -	}
>> +	if (!pmu || perf_try_init_event(pmu, event))
>> +		goto fail;
>>   
>>   	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
>>   		ret = perf_try_init_event(pmu, event);
>> @@ -12026,11 +12046,10 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>>   	}
>>   
>>   	/*
>> -	 * Disallow uncore-task events. Similarly, disallow uncore-cgroup
>> -	 * events (they don't make sense as the cgroup will be different
>> -	 * on other CPUs in the uncore mask).
>> +	 * Disallow uncore-cgroup events (they don't make sense
>> +	 * as the cgroup will be different on other CPUs in the uncore mask).
>>   	 */
>> -	if (pmu->task_ctx_nr == perf_invalid_context && (task || cgroup_fd != -1)) {
>> +	if (task || cgroup_fd != -1) {
>>   		err = -EINVAL;
>>   		goto err_pmu;
>>   	}
>> -- 
>> 2.25.1
>>
> 

