Return-Path: <linux-kernel+bounces-137107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B013489DD0F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293371F2396C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E26F12FF63;
	Tue,  9 Apr 2024 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWQxYpKc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54EF85652;
	Tue,  9 Apr 2024 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673662; cv=none; b=Di+cGhsPgk9INhKTkR1nKwX2/q8ohUQ3oi7r5rNojuU4tf7k4GVrHfS82JxH63Di9F+Ak4NUXx0JUtsvSdhZZE7KsEMKZZRxFA/h3ragYonVBNYZT+mKOyzNE5tLgdD9j9IRDyo3bDWkOnXl14DzNXazZO5bjVHPQHx0yS2qq5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673662; c=relaxed/simple;
	bh=lVfeLYsDXqt4AORSpzcaJWg4cGkOVOrdKxLkrYQ0oQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SmMGJ5xZThbNnPEUyPZwwRqOFgoNFtqaVrSEshH5U7osPS6abdmCPzUemP9R6SHo57Xd+R2r9Np7KsAAJwZEl4PX0iniMnq7nB9oPf6ICwjbUk1OVnUY1QfK4R1lyXug2Qxr3CUzeHD8llYyGJpNmF2vGLM8FCzdhlfsX+6bdRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWQxYpKc; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712673661; x=1744209661;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=lVfeLYsDXqt4AORSpzcaJWg4cGkOVOrdKxLkrYQ0oQQ=;
  b=CWQxYpKcTo5bpxBoprCPe8D/GsToF9bl6wEAwQ5tZyxBLEzP8HrXFnQ1
   dMqEyuMPJNHMQIMPATkWFewf8PCPDcCNm8rVYd3cw2nCUKI50QLuBrLRM
   Qah4wgxpzavjzS6lZVu2+0BrY/UAJgOaOwyo0rBHsjIOMetNnMZ29XNbm
   yR5iLkx09bD1WY/e8zRP5Ti4NbGrTOadzbc6mjtErY2Nmr0qPZ+WZullB
   JqrLzF4XLtQc+tL7CBZ693P+u9RAjdLB2dc0cIq0gnrjKXZiq6ME/PYUA
   Incub4EmThlZtmQU8uB4DLlqOpaR0JdHfuaC6biAgQv0UhM9zb/skLGR3
   w==;
X-CSE-ConnectionGUID: 8VCQrcj5S0ihsL08jatmtQ==
X-CSE-MsgGUID: 75YvVdyZToCOJBZFKWttJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19373567"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="19373567"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 07:41:00 -0700
X-CSE-ConnectionGUID: oV7wqeCrR5u+EAHgWE98kw==
X-CSE-MsgGUID: B8R0XN+OQzq+ED3QVICgaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="20331815"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 07:40:59 -0700
Received: from [10.213.177.168] (kliang2-mobl1.ccr.corp.intel.com [10.213.177.168])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id E81F120B573A;
	Tue,  9 Apr 2024 07:40:56 -0700 (PDT)
Message-ID: <0d498870-b235-4860-9563-befcddf0ec3e@linux.intel.com>
Date: Tue, 9 Apr 2024 10:40:55 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf stat: Remove evlist__add_default_attrs use
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
References: <20240406073804.1932415-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240406073804.1932415-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-04-06 3:38 a.m., Ian Rogers wrote:
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

But the current skip could leave unnecessary empty lines. It's better to
avoid the empty lines as well.

$perf stat sleep 1

 Performance counter stats for 'sleep 1':

              0.91 msec task-clock                       #    0.001 CPUs
utilized
                 1      context-switches                 #    1.096 K/sec
                 0      cpu-migrations                   #    0.000 /sec
                68      page-faults                      #   74.534 K/sec
         1,121,410      instructions                     #    1.04  insn
per cycle
         1,081,095      cycles                           #    1.185 GHz


           251,649      branches                         #  275.829 M/sec
             7,252      branch-misses                    #    2.88% of
all branches


> 
> Closes: https://lore.kernel.org/lkml/CAP-5=fVABSBZnsmtRn1uF-k-G1GWM-L5SgiinhPTfHbQsKXb_g@mail.gmail.com/
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/util/evlist.c |  74 +-------
>  tools/perf/builtin-stat.c         | 291 ++++++++++++------------------
>  tools/perf/util/evlist.c          |  43 -----
>  tools/perf/util/evlist.h          |  12 --
>  tools/perf/util/stat-display.c    |   3 +
>  5 files changed, 118 insertions(+), 305 deletions(-)
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

"cycles",
"instructions",

It's better to keep the original order.

Thanks,
Kan

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
> index bfc1d705f437..6631d03ad799 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -663,6 +663,9 @@ static void print_counter_value_std(struct perf_stat_config *config,
>  	const char *fmt;
>  	const char *bad_count = evsel->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED;
>  
> +	if (!evsel->supported && evsel->skippable)
> +		return;
> +
>  	if (config->big_num)
>  		fmt = floor(sc) != sc ? "%'*.2f " : "%'*.0f ";
>  	else

