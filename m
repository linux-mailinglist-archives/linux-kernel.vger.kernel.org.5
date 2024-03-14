Return-Path: <linux-kernel+bounces-102960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A25BA87B91E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425701F22BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49985D73B;
	Thu, 14 Mar 2024 08:10:59 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04E13FEE;
	Thu, 14 Mar 2024 08:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.62.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710403859; cv=none; b=pT/VpiRgWY3JwMqzJjKbegQNs3UT1ur8lQdNl14OhQ7fzT7wWkVryM4RqYRfzmsf/1NW3wdrEFkV6Y8GewJ581Hz2DM4js4+/5YFmHjxgmTK6kFH6HdBqHSLQkP9M/XY2ot+EQFG3yveLp71VSNvy1qHcoZWQ9RnYOY/QFyMcOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710403859; c=relaxed/simple;
	bh=bj94yDjLmPYOA+0eTpRudTLbhG6XPhmenWzv6F9cStY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDhkTNmiBRCtuHCSVNOKBbNIQURiQ5xw5SXw8BOYTadL4f6eXU38bmBC1lW04TKcuJXwlI4FHa+XUJFeAjO0k8yBfnGmLHYN4HYPNkh58PF7Djv5DpA0aQWeDAy3wRpCBien0tbM49nD2Os82sDLgZku0yU58CuqRPCA4L78GNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp77t1710403784t1pjbe75
X-QQ-Originating-IP: WJEFhGQswlmNp9YGR/xWQ89G4CXtgKJpagGX+Ce8iew=
Received: from [127.0.0.1] ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Mar 2024 16:09:42 +0800 (CST)
X-QQ-SSF: 00400000000000B0B000000A0000000
X-QQ-FEAT: 30t4+KEGo2kq6v309Md1M12EuDrEvJ6i7jIlo5yvBPHBEklZUJUHMza9816dM
	bZ8X7LirP0f5I4NXxdkiEcqMKk9e5CcDNMEEJ+VBuzccx479+GW5yCZF2TfX6+l7mi2UfLG
	lX0vTWwPpjbfUAekmPxMt8gATh7X/FDdspiZ16FVuI/N+/c7Cg/LmwvA26KBGQwK6pXFFfk
	2bWw6RvEDv07XFMzfw+gdoTWnRLvaeqRMm3I3oRmViicHkZEhWXY4ayXCrtxl1iWOXetJAB
	nPLrXaYCNu9bYYwMmXv005uuZYmqCG9GgEpVI50fg/BAwFtIzkqFjPIg3Htt3YhvJ25I477
	v3GGIgrgLLCwrJ/vGcVj6v0EQUSYogufIxt2jl9GSBW9DkJ61UNsiomcQN/lbCB6TW5gVVR
	vP/ZbUQTsWI=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7111722576666211980
Message-ID: <94DB0209EA3D1C5F+b646f31e-15a1-4753-8309-687b5860863e@shingroup.cn>
Date: Thu, 14 Mar 2024 16:09:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] perf: Add capability for common event support
To: Robin Murphy <robin.murphy@arm.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-perf-users@vger.kernel.org
References: <cover.1710257512.git.robin.murphy@arm.com>
 <feb10873fe9e4e10b5ffbbe8e296c8a45632e3c2.1710257512.git.robin.murphy@arm.com>
Content-Language: en-US
From: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>
In-Reply-To: <feb10873fe9e4e10b5ffbbe8e296c8a45632e3c2.1710257512.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1



在 2024/3/13 1:34, Robin Murphy 写道:
> Many PMUs do not support common hardware/cache/etc. events and only
> handle their own PMU-specific events. Since this only depends on
> matching the event and PMU types, it's a prime candidate for a core
> capability to save more event_init boilerplate in drivers.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   include/linux/perf_event.h | 1 +
>   kernel/events/core.c       | 5 +++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index d2a15c0c6f8a..983201f21dd2 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -291,6 +291,7 @@ struct perf_event_pmu_context;
>   #define PERF_PMU_CAP_NO_EXCLUDE			0x0040
>   #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
>   #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
> +#define PERF_PMU_CAP_NO_COMMON_EVENTS		0x0200
>   
>   struct perf_output_handle;
>   
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f0f0f71213a1..7ad80826c218 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11649,6 +11649,11 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
>   	struct perf_event_context *ctx = NULL;
>   	int ret;
>   
> +	/* Short-circuit if we know the PMU won't want this event */
> +	if (pmu->capabilities & PERF_PMU_CAP_NO_COMMON_EVENTS &&
> +	    event->attr.type != pmu->type)
> +		return -ENOENT;
> +

         /*
          * PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
          * are often aliases for PERF_TYPE_RAW.
          */
         type = event->attr.type;
         if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) {
                 type = event->attr.config >> PERF_PMU_TYPE_SHIFT;
                 if (!type) {
                         type = PERF_TYPE_RAW;
                 } else {
                         extended_type = true;
                         event->attr.config &= PERF_HW_EVENT_MASK;
                 }
         }

again:
         rcu_read_lock();
         pmu = idr_find(&pmu_idr, type);
         rcu_read_unlock();
         if (pmu) {
Above code tells me it's possible that 'pmu->type != event->attr.type' 
is true when event->attr.type equals to PERF_TYPE_HARDWARE or 
PERF_TYPE_HW_CACHE, and pmu->type should equal to event->attr.config >> 
PERF_PMU_TYPE_SHIFT.

We find the target pmu by event->attr.config >> PERF_PMU_TYPE_SHIFT.

Code added discard this option.

And code tells me that no try. Target PMU is doubtless.




>   	if (!try_module_get(pmu->module))
>   		return -ENODEV;
>   


