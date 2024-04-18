Return-Path: <linux-kernel+bounces-150141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648C68A9AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E77EB22101
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE1A15E7F5;
	Thu, 18 Apr 2024 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YRlq9ezD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEAF13247D;
	Thu, 18 Apr 2024 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446003; cv=none; b=s4TL4zN4LYSOQzp8exmelaW40btuuxaca9uzPqMReZ8xTJZ9St/DxZgQRgnY1FqN5ikImljAiUNwGG2RHPm0gopgzMA5JVDt5gEMegqHz1/pSOG97Td6vNkOl22V4wfSofoFIDyx7NG7PUs7Nw8n7mwelPH489WI9xYfzc9GxLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446003; c=relaxed/simple;
	bh=uN7G+72QMM8BmZjjNdDG1zp8ijMrd3RQ/E9M8LQxJmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KSdwXARUJ6ostPunW3apjZZhklHmTNdFw7uirVzIi1iTrMJu3k+xLOYLC5dY2fpzUUE54JqyHZJxICUtglwudSu1YVKzBkvH9Jhrn39RHkIhh0C0BAkb1EhID6GHQKfz/a2wmR2QOdBcA4raEYr15PGvNh7WeIHcqjPvKFu8K8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YRlq9ezD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713446000; x=1744982000;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=uN7G+72QMM8BmZjjNdDG1zp8ijMrd3RQ/E9M8LQxJmk=;
  b=YRlq9ezDe4K+BTqAWDg8ai4FLG+kNqmENxPP0bD7QL6S4J0muVLFbbMp
   H8UQd+Wz03oHbTyjg/IIMXJrKV+AePpE3pZ2/CWGSIE1XJrojnKpXkAd2
   fcAKc2BbiWJN4Ee2VtXMzkDLQo9Wx1J3ptvy/JQ64U2ekDEEV0bMlEK5w
   1Zbe41q3RgAjw7NhOvyFSVTIcKJvWxHgruzs5liSUJdAk4hHf9oVPfEfb
   FdWx5YWec0itS6b5xwNsKj5uTvjX7yhRBSDhBQsDhd3jGW6y7hNysV7ZZ
   WqJvuZwcQz3pZ5XQMGJPpUBnelcokHLiXQqwkDxapW5gHmunJN1jdTvf1
   Q==;
X-CSE-ConnectionGUID: 04iXY2EVS6yKSuKAAUXDxA==
X-CSE-MsgGUID: QMl7x9V0Tr2eLWELQMop3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9160878"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="9160878"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 06:13:19 -0700
X-CSE-ConnectionGUID: grRdE1xdTE6R9+C4Fz1nIw==
X-CSE-MsgGUID: TiuXSs4eRqGh0QuGee+Yjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23036256"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 06:13:20 -0700
Received: from [10.213.167.231] (kliang2-mobl1.ccr.corp.intel.com [10.213.167.231])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 7F5DF206DFDC;
	Thu, 18 Apr 2024 06:13:16 -0700 (PDT)
Message-ID: <ebffeac3-8758-4674-bad7-8a8d24c14b6f@linux.intel.com>
Date: Thu, 18 Apr 2024 09:13:15 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf stat: Remove evlist__add_default_attrs use
 strings
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@arm.com>, Yang Jihong <yangjihong1@huawei.com>,
 Kaige Ye <ye@kaige.org>, Yicong Yang <yangyicong@hisilicon.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240409162746.2388013-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240409162746.2388013-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-04-09 12:27 p.m., Ian Rogers wrote:
> add_default_atttributes would add evsels by having pre-created
> perf_event_attr, however, this needed fixing for hybrid as the
> extended PMU type was necessary for each core PMU. The logic for this
> was in an arch specific x86 function and wasn't present for ARM,
> meaning that default events weren't being opened on all PMUs on
> ARM. Change the creation of the default events to use parse_events and
> strings as that will open the events on all PMUs.
> 
> Rather than try to detect events on PMUs before parsing, parse the
> event but skip its output in stat-display.
> 
> The previous order of hardware events was: cycles,
> stalled-cycles-frontend, stalled-cycles-backend, instructions. As
> instructions is a more fundamental concept the order is changed to:
> instructions, cycles, stalled-cycles-frontend, stalled-cycles-backend.
> 
> Closes: https://lore.kernel.org/lkml/CAP-5=fVABSBZnsmtRn1uF-k-G1GWM-L5SgiinhPTfHbQsKXb_g@mail.gmail.com/
> Signed-off-by: Ian Rogers <irogers@google.com>

I got the confirmation that the re-order is ok for their tools.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
> v2. Avoid unnecessary newlines for skipped events. Add commit message
>     comment wrt hardware events being reordered.
> ---
>  tools/perf/arch/x86/util/evlist.c |  74 +-------
>  tools/perf/builtin-stat.c         | 291 ++++++++++++------------------
>  tools/perf/util/evlist.c          |  43 -----
>  tools/perf/util/evlist.h          |  12 --
>  tools/perf/util/stat-display.c    |   4 +
>  5 files changed, 119 insertions(+), 305 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> index b1ce0c52d88d..fb8e314aa364 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -1,78 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <stdio.h>
> -#include "util/pmu.h"
> -#include "util/pmus.h"
> -#include "util/evlist.h"
> -#include "util/parse-events.h"
> -#include "util/event.h"
> +#include <string.h>
> +#include "../../../util/evlist.h"
> +#include "../../../util/evsel.h"
>  #include "topdown.h"
>  #include "evsel.h"
>  
> -static int ___evlist__add_default_attrs(struct evlist *evlist,
> -					struct perf_event_attr *attrs,
> -					size_t nr_attrs)
> -{
> -	LIST_HEAD(head);
> -	size_t i = 0;
> -
> -	for (i = 0; i < nr_attrs; i++)
> -		event_attr_init(attrs + i);
> -
> -	if (perf_pmus__num_core_pmus() == 1)
> -		return evlist__add_attrs(evlist, attrs, nr_attrs);
> -
> -	for (i = 0; i < nr_attrs; i++) {
> -		struct perf_pmu *pmu = NULL;
> -
> -		if (attrs[i].type == PERF_TYPE_SOFTWARE) {
> -			struct evsel *evsel = evsel__new(attrs + i);
> -
> -			if (evsel == NULL)
> -				goto out_delete_partial_list;
> -			list_add_tail(&evsel->core.node, &head);
> -			continue;
> -		}
> -
> -		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
> -			struct perf_cpu_map *cpus;
> -			struct evsel *evsel;
> -
> -			evsel = evsel__new(attrs + i);
> -			if (evsel == NULL)
> -				goto out_delete_partial_list;
> -			evsel->core.attr.config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
> -			cpus = perf_cpu_map__get(pmu->cpus);
> -			evsel->core.cpus = cpus;
> -			evsel->core.own_cpus = perf_cpu_map__get(cpus);
> -			evsel->pmu_name = strdup(pmu->name);
> -			list_add_tail(&evsel->core.node, &head);
> -		}
> -	}
> -
> -	evlist__splice_list_tail(evlist, &head);
> -
> -	return 0;
> -
> -out_delete_partial_list:
> -	{
> -		struct evsel *evsel, *n;
> -
> -		__evlist__for_each_entry_safe(&head, n, evsel)
> -			evsel__delete(evsel);
> -	}
> -	return -1;
> -}
> -
> -int arch_evlist__add_default_attrs(struct evlist *evlist,
> -				   struct perf_event_attr *attrs,
> -				   size_t nr_attrs)
> -{
> -	if (!nr_attrs)
> -		return 0;
> -
> -	return ___evlist__add_default_attrs(evlist, attrs, nr_attrs);
> -}
> -
>  int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
>  {
>  	if (topdown_sys_has_perf_metrics() &&
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 65388c57bb5d..e7de32a8c10c 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1944,130 +1944,25 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
>  }
>  
>  /*
> - * Add default attributes, if there were no attributes specified or
> + * Add default events, if there were no attributes specified or
>   * if -d/--detailed, -d -d or -d -d -d is used:
>   */
> -static int add_default_attributes(void)
> +static int add_default_events(void)
>  {
> -	struct perf_event_attr default_attrs0[] = {
> -
> -  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_TASK_CLOCK		},
> -  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_CONTEXT_SWITCHES	},
> -  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_CPU_MIGRATIONS		},
> -  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_PAGE_FAULTS		},
> -
> -  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_CPU_CYCLES		},
> -};
> -	struct perf_event_attr frontend_attrs[] = {
> -  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_STALLED_CYCLES_FRONTEND	},
> -};
> -	struct perf_event_attr backend_attrs[] = {
> -  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_STALLED_CYCLES_BACKEND	},
> -};
> -	struct perf_event_attr default_attrs1[] = {
> -  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_INSTRUCTIONS		},
> -  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_BRANCH_INSTRUCTIONS	},
> -  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_BRANCH_MISSES		},
> -
> -};
> -
> -/*
> - * Detailed stats (-d), covering the L1 and last level data caches:
> - */
> -	struct perf_event_attr detailed_attrs[] = {
> -
> -  { .type = PERF_TYPE_HW_CACHE,
> -    .config =
> -	 PERF_COUNT_HW_CACHE_L1D		<<  0  |
> -	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
> -	(PERF_COUNT_HW_CACHE_RESULT_ACCESS	<< 16)				},
> -
> -  { .type = PERF_TYPE_HW_CACHE,
> -    .config =
> -	 PERF_COUNT_HW_CACHE_L1D		<<  0  |
> -	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
> -	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
> -
> -  { .type = PERF_TYPE_HW_CACHE,
> -    .config =
> -	 PERF_COUNT_HW_CACHE_LL			<<  0  |
> -	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
> -	(PERF_COUNT_HW_CACHE_RESULT_ACCESS	<< 16)				},
> -
> -  { .type = PERF_TYPE_HW_CACHE,
> -    .config =
> -	 PERF_COUNT_HW_CACHE_LL			<<  0  |
> -	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
> -	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
> -};
> -
> -/*
> - * Very detailed stats (-d -d), covering the instruction cache and the TLB caches:
> - */
> -	struct perf_event_attr very_detailed_attrs[] = {
> -
> -  { .type = PERF_TYPE_HW_CACHE,
> -    .config =
> -	 PERF_COUNT_HW_CACHE_L1I		<<  0  |
> -	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
> -	(PERF_COUNT_HW_CACHE_RESULT_ACCESS	<< 16)				},
> -
> -  { .type = PERF_TYPE_HW_CACHE,
> -    .config =
> -	 PERF_COUNT_HW_CACHE_L1I		<<  0  |
> -	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
> -	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
> -
> -  { .type = PERF_TYPE_HW_CACHE,
> -    .config =
> -	 PERF_COUNT_HW_CACHE_DTLB		<<  0  |
> -	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
> -	(PERF_COUNT_HW_CACHE_RESULT_ACCESS	<< 16)				},
> -
> -  { .type = PERF_TYPE_HW_CACHE,
> -    .config =
> -	 PERF_COUNT_HW_CACHE_DTLB		<<  0  |
> -	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
> -	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
> -
> -  { .type = PERF_TYPE_HW_CACHE,
> -    .config =
> -	 PERF_COUNT_HW_CACHE_ITLB		<<  0  |
> -	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
> -	(PERF_COUNT_HW_CACHE_RESULT_ACCESS	<< 16)				},
> -
> -  { .type = PERF_TYPE_HW_CACHE,
> -    .config =
> -	 PERF_COUNT_HW_CACHE_ITLB		<<  0  |
> -	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
> -	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
> -
> -};
> +	const char *pmu = parse_events_option_args.pmu_filter ?: "all";
> +	struct parse_events_error err;
> +	struct evlist *evlist = evlist__new();
> +	struct evsel *evsel;
> +	int ret = 0;
>  
> -/*
> - * Very, very detailed stats (-d -d -d), adding prefetch events:
> - */
> -	struct perf_event_attr very_very_detailed_attrs[] = {
> -
> -  { .type = PERF_TYPE_HW_CACHE,
> -    .config =
> -	 PERF_COUNT_HW_CACHE_L1D		<<  0  |
> -	(PERF_COUNT_HW_CACHE_OP_PREFETCH	<<  8) |
> -	(PERF_COUNT_HW_CACHE_RESULT_ACCESS	<< 16)				},
> -
> -  { .type = PERF_TYPE_HW_CACHE,
> -    .config =
> -	 PERF_COUNT_HW_CACHE_L1D		<<  0  |
> -	(PERF_COUNT_HW_CACHE_OP_PREFETCH	<<  8) |
> -	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
> -};
> +	if (!evlist)
> +		return -ENOMEM;
>  
> -	struct perf_event_attr default_null_attrs[] = {};
> -	const char *pmu = parse_events_option_args.pmu_filter ?: "all";
> +	parse_events_error__init(&err);
>  
>  	/* Set attrs if no event is selected and !null_run: */
>  	if (stat_config.null_run)
> -		return 0;
> +		goto out;
>  
>  	if (transaction_run) {
>  		/* Handle -T as -M transaction. Once platform specific metrics
> @@ -2077,15 +1972,17 @@ static int add_default_attributes(void)
>  		 */
>  		if (!metricgroup__has_metric(pmu, "transaction")) {
>  			pr_err("Missing transaction metrics\n");
> -			return -1;
> +			ret = -1;
> +			goto out;
>  		}
> -		return metricgroup__parse_groups(evsel_list, pmu, "transaction",
> +		ret = metricgroup__parse_groups(evlist, pmu, "transaction",
>  						stat_config.metric_no_group,
>  						stat_config.metric_no_merge,
>  						stat_config.metric_no_threshold,
>  						stat_config.user_requested_cpu_list,
>  						stat_config.system_wide,
>  						&stat_config.metric_events);
> +		goto out;
>  	}
>  
>  	if (smi_cost) {
> @@ -2093,32 +1990,36 @@ static int add_default_attributes(void)
>  
>  		if (sysfs__read_int(FREEZE_ON_SMI_PATH, &smi) < 0) {
>  			pr_err("freeze_on_smi is not supported.\n");
> -			return -1;
> +			ret = -1;
> +			goto out;
>  		}
>  
>  		if (!smi) {
>  			if (sysfs__write_int(FREEZE_ON_SMI_PATH, 1) < 0) {
> -				fprintf(stderr, "Failed to set freeze_on_smi.\n");
> -				return -1;
> +				pr_err("Failed to set freeze_on_smi.\n");
> +				ret = -1;
> +				goto out;
>  			}
>  			smi_reset = true;
>  		}
>  
>  		if (!metricgroup__has_metric(pmu, "smi")) {
>  			pr_err("Missing smi metrics\n");
> -			return -1;
> +			ret = -1;
> +			goto out;
>  		}
>  
>  		if (!force_metric_only)
>  			stat_config.metric_only = true;
>  
> -		return metricgroup__parse_groups(evsel_list, pmu, "smi",
> +		ret = metricgroup__parse_groups(evlist, pmu, "smi",
>  						stat_config.metric_no_group,
>  						stat_config.metric_no_merge,
>  						stat_config.metric_no_threshold,
>  						stat_config.user_requested_cpu_list,
>  						stat_config.system_wide,
>  						&stat_config.metric_events);
> +		goto out;
>  	}
>  
>  	if (topdown_run) {
> @@ -2131,105 +2032,137 @@ static int add_default_attributes(void)
>  		if (!max_level) {
>  			pr_err("Topdown requested but the topdown metric groups aren't present.\n"
>  				"(See perf list the metric groups have names like TopdownL1)\n");
> -			return -1;
> +			ret = -1;
> +			goto out;
>  		}
>  		if (stat_config.topdown_level > max_level) {
>  			pr_err("Invalid top-down metrics level. The max level is %u.\n", max_level);
> -			return -1;
> -		} else if (!stat_config.topdown_level)
> +			ret = -1;
> +			goto out;
> +		} else if (!stat_config.topdown_level) {
>  			stat_config.topdown_level = 1;
> -
> +		}
>  		if (!stat_config.interval && !stat_config.metric_only) {
>  			fprintf(stat_config.output,
>  				"Topdown accuracy may decrease when measuring long periods.\n"
>  				"Please print the result regularly, e.g. -I1000\n");
>  		}
>  		str[8] = stat_config.topdown_level + '0';
> -		if (metricgroup__parse_groups(evsel_list,
> +		if (metricgroup__parse_groups(evlist,
>  						pmu, str,
>  						/*metric_no_group=*/false,
>  						/*metric_no_merge=*/false,
>  						/*metric_no_threshold=*/true,
>  						stat_config.user_requested_cpu_list,
>  						stat_config.system_wide,
> -						&stat_config.metric_events) < 0)
> -			return -1;
> +						&stat_config.metric_events) < 0) {
> +			ret = -1;
> +			goto out;
> +		}
>  	}
>  
>  	if (!stat_config.topdown_level)
>  		stat_config.topdown_level = 1;
>  
> -	if (!evsel_list->core.nr_entries) {
> +	if (!evlist->core.nr_entries) {
>  		/* No events so add defaults. */
>  		if (target__has_cpu(&target))
> -			default_attrs0[0].config = PERF_COUNT_SW_CPU_CLOCK;
> +			ret = parse_events(evlist, "cpu-clock", &err);
> +		else
> +			ret = parse_events(evlist, "task-clock", &err);
> +		if (ret)
> +			goto out;
> +
> +		ret = parse_events(evlist,
> +				"context-switches,"
> +				"cpu-migrations,"
> +				"page-faults,"
> +				"instructions,"
> +				"cycles,"
> +				"stalled-cycles-frontend,"
> +				"stalled-cycles-backend,"
> +				"branches,"
> +				"branch-misses",
> +				&err);
> +		if (ret)
> +			goto out;
>  
> -		if (evlist__add_default_attrs(evsel_list, default_attrs0) < 0)
> -			return -1;
> -		if (perf_pmus__have_event("cpu", "stalled-cycles-frontend")) {
> -			if (evlist__add_default_attrs(evsel_list, frontend_attrs) < 0)
> -				return -1;
> -		}
> -		if (perf_pmus__have_event("cpu", "stalled-cycles-backend")) {
> -			if (evlist__add_default_attrs(evsel_list, backend_attrs) < 0)
> -				return -1;
> -		}
> -		if (evlist__add_default_attrs(evsel_list, default_attrs1) < 0)
> -			return -1;
>  		/*
>  		 * Add TopdownL1 metrics if they exist. To minimize
>  		 * multiplexing, don't request threshold computation.
>  		 */
>  		if (metricgroup__has_metric(pmu, "Default")) {
>  			struct evlist *metric_evlist = evlist__new();
> -			struct evsel *metric_evsel;
> -
> -			if (!metric_evlist)
> -				return -1;
>  
> +			if (!metric_evlist) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
>  			if (metricgroup__parse_groups(metric_evlist, pmu, "Default",
>  							/*metric_no_group=*/false,
>  							/*metric_no_merge=*/false,
>  							/*metric_no_threshold=*/true,
>  							stat_config.user_requested_cpu_list,
>  							stat_config.system_wide,
> -							&stat_config.metric_events) < 0)
> -				return -1;
> -
> -			evlist__for_each_entry(metric_evlist, metric_evsel) {
> -				metric_evsel->skippable = true;
> -				metric_evsel->default_metricgroup = true;
> +							&stat_config.metric_events) < 0) {
> +				ret = -1;
> +				goto out;
>  			}
> -			evlist__splice_list_tail(evsel_list, &metric_evlist->core.entries);
> +
> +			evlist__for_each_entry(metric_evlist, evsel)
> +				evsel->default_metricgroup = true;
> +
> +			evlist__splice_list_tail(evlist, &metric_evlist->core.entries);
>  			evlist__delete(metric_evlist);
>  		}
> -
> -		/* Platform specific attrs */
> -		if (evlist__add_default_attrs(evsel_list, default_null_attrs) < 0)
> -			return -1;
>  	}
>  
>  	/* Detailed events get appended to the event list: */
>  
> -	if (detailed_run <  1)
> -		return 0;
> -
> -	/* Append detailed run extra attributes: */
> -	if (evlist__add_default_attrs(evsel_list, detailed_attrs) < 0)
> -		return -1;
> -
> -	if (detailed_run < 2)
> -		return 0;
> -
> -	/* Append very detailed run extra attributes: */
> -	if (evlist__add_default_attrs(evsel_list, very_detailed_attrs) < 0)
> -		return -1;
> -
> -	if (detailed_run < 3)
> -		return 0;
> -
> -	/* Append very, very detailed run extra attributes: */
> -	return evlist__add_default_attrs(evsel_list, very_very_detailed_attrs);
> +	if (!ret && detailed_run >=  1) {
> +		/*
> +		 * Detailed stats (-d), covering the L1 and last level data
> +		 * caches:
> +		 */
> +		ret = parse_events(evlist,
> +				"L1-dcache-loads,"
> +				"L1-dcache-load-misses,"
> +				"LLC-loads,"
> +				"LLC-load-misses",
> +				&err);
> +	}
> +	if (!ret && detailed_run >=  2) {
> +		/*
> +		 * Very detailed stats (-d -d), covering the instruction cache
> +		 * and the TLB caches:
> +		 */
> +		ret = parse_events(evlist,
> +				"L1-icache-loads,"
> +				"L1-icache-load-misses,"
> +				"dTLB-loads,"
> +				"dTLB-load-misses,"
> +				"iTLB-loads,"
> +				"iTLB-load-misses",
> +				&err);
> +	}
> +	if (!ret && detailed_run >=  3) {
> +		/*
> +		 * Very, very detailed stats (-d -d -d), adding prefetch events:
> +		 */
> +		ret = parse_events(evlist,
> +				"L1-dcache-prefetches,"
> +				"L1-dcache-prefetch-misses",
> +				&err);
> +	}
> +out:
> +	if (!ret) {
> +		evlist__for_each_entry(evlist, evsel)
> +			evsel->skippable = true;
> +	}
> +	parse_events_error__exit(&err);
> +	evlist__splice_list_tail(evsel_list, &evlist->core.entries);
> +	evlist__delete(evlist);
> +	return ret;
>  }
>  
>  static const char * const stat_record_usage[] = {
> @@ -2736,7 +2669,7 @@ int cmd_stat(int argc, const char **argv)
>  		}
>  	}
>  
> -	if (add_default_attributes())
> +	if (add_default_events())
>  		goto out;
>  
>  	if (stat_config.cgroup_list) {
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 55a300a0977b..de498ba5ac1c 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -314,49 +314,6 @@ struct evsel *evlist__add_sched_switch(struct evlist *evlist, bool system_wide)
>  }
>  #endif
>  
> -int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
> -{
> -	struct evsel *evsel, *n;
> -	LIST_HEAD(head);
> -	size_t i;
> -
> -	for (i = 0; i < nr_attrs; i++) {
> -		evsel = evsel__new_idx(attrs + i, evlist->core.nr_entries + i);
> -		if (evsel == NULL)
> -			goto out_delete_partial_list;
> -		list_add_tail(&evsel->core.node, &head);
> -	}
> -
> -	evlist__splice_list_tail(evlist, &head);
> -
> -	return 0;
> -
> -out_delete_partial_list:
> -	__evlist__for_each_entry_safe(&head, n, evsel)
> -		evsel__delete(evsel);
> -	return -1;
> -}
> -
> -int __evlist__add_default_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
> -{
> -	size_t i;
> -
> -	for (i = 0; i < nr_attrs; i++)
> -		event_attr_init(attrs + i);
> -
> -	return evlist__add_attrs(evlist, attrs, nr_attrs);
> -}
> -
> -__weak int arch_evlist__add_default_attrs(struct evlist *evlist,
> -					  struct perf_event_attr *attrs,
> -					  size_t nr_attrs)
> -{
> -	if (!nr_attrs)
> -		return 0;
> -
> -	return __evlist__add_default_attrs(evlist, attrs, nr_attrs);
> -}
> -
>  struct evsel *evlist__find_tracepoint_by_id(struct evlist *evlist, int id)
>  {
>  	struct evsel *evsel;
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index cb91dc9117a2..947a78cbd7f0 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -100,18 +100,6 @@ void evlist__delete(struct evlist *evlist);
>  void evlist__add(struct evlist *evlist, struct evsel *entry);
>  void evlist__remove(struct evlist *evlist, struct evsel *evsel);
>  
> -int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs);
> -
> -int __evlist__add_default_attrs(struct evlist *evlist,
> -				     struct perf_event_attr *attrs, size_t nr_attrs);
> -
> -int arch_evlist__add_default_attrs(struct evlist *evlist,
> -				   struct perf_event_attr *attrs,
> -				   size_t nr_attrs);
> -
> -#define evlist__add_default_attrs(evlist, array) \
> -	arch_evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
> -
>  int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs);
>  
>  int evlist__add_dummy(struct evlist *evlist);
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index bfc1d705f437..b117a2716306 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -936,6 +936,10 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
>  	struct perf_cpu cpu;
>  	int idx;
>  
> +	/* Skip events added by default that may not be supported. */
> +	if (!counter->supported && counter->skippable)
> +		return true;
> +
>  	/*
>  	 * Skip value 0 when enabling --per-thread globally,
>  	 * otherwise it will have too many 0 output.

