Return-Path: <linux-kernel+bounces-15813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2878233AC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84923B21890
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8CA1C2AF;
	Wed,  3 Jan 2024 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kcEU1fhC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B727A1C687;
	Wed,  3 Jan 2024 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704303897; x=1735839897;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=FsxTGWvVPI/NoBF8Xammjod/CJ+T7B04tNBazndfAto=;
  b=kcEU1fhC/geX/kjl1fIHQ05wumPK2OM0TCNkuRnMkawWyJOQhMPEa9hi
   clDL5A2yKF+OWtLFyrCEwFyU11GBmi1mS4eXYniscrjiG/MlBMndjOc8J
   A6Je16CTh/IfjoNX7YtzxkbGQ4xEuown46qAVq7DWWeOMOdJgW6JxYCbw
   WrQZKOej8icQnV0qFraPG1LdzIuqQ7CbI26C8u+nCbqQgUCrKdYE55/tR
   dHzFLEk2JwSsRipMQyVvbvehNhi5xoREJo8wyOHPKRB2okkwEu2JZ/PJE
   uMpldA66Zq2/VCN+7zFvS/hLqQHHy5Cy+bWvxoyg571DWyRzAPbD0chah
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="394187368"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="394187368"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 09:44:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="780045017"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="780045017"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 09:44:56 -0800
Received: from [10.213.174.222] (kliang2-mobl1.ccr.corp.intel.com [10.213.174.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 14138580DC7;
	Wed,  3 Jan 2024 09:44:54 -0800 (PST)
Message-ID: <555f8096-619c-46cf-bff8-0e49f03eac2a@linux.intel.com>
Date: Wed, 3 Jan 2024 12:44:53 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf x86 test: Update hybrid expectations
Content-Language: en-US
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240103170159.1435753-1-irogers@google.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240103170159.1435753-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-01-03 12:01 p.m., Ian Rogers wrote:
> The legacy events cpu-cycles and instructions have sysfs event
> equivalents on x86 (see /sys/devices/cpu_core/events). As sysfs/JSON
> events are now higher in priority than legacy events this causes the
> hybrid test expectations not to be met. To fix this switch to legacy
> events that don't have sysfs versions, namely cpu-cycles becomes
> cycles and instructions becomes branches.
> 
> Fixes: a24d9d9dc096 ("perf parse-events: Make legacy events lower priority than sysfs/JSON")
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Closes: https://lore.kernel.org/lkml/ZYbm5L7tw7bdpDpE@kernel.org/
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---

Thanks Ian. For the series,

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
>  tools/perf/arch/x86/tests/hybrid.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/tests/hybrid.c b/tools/perf/arch/x86/tests/hybrid.c
> index eb152770f148..05a5f81e8167 100644
> --- a/tools/perf/arch/x86/tests/hybrid.c
> +++ b/tools/perf/arch/x86/tests/hybrid.c
> @@ -47,7 +47,7 @@ static int test__hybrid_hw_group_event(struct evlist *evlist)
>  	evsel = evsel__next(evsel);
>  	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong hybrid type", test_hybrid_type(evsel, PERF_TYPE_RAW));
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_INSTRUCTIONS));
>  	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
>  	return TEST_OK;
>  }
> @@ -102,7 +102,7 @@ static int test__hybrid_group_modifier1(struct evlist *evlist)
>  	evsel = evsel__next(evsel);
>  	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>  	TEST_ASSERT_VAL("wrong hybrid type", test_hybrid_type(evsel, PERF_TYPE_RAW));
> -	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
> +	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_INSTRUCTIONS));
>  	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
>  	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> @@ -171,27 +171,27 @@ struct evlist_test {
>  
>  static const struct evlist_test test__hybrid_events[] = {
>  	{
> -		.name  = "cpu_core/cpu-cycles/",
> +		.name  = "cpu_core/cycles/",
>  		.check = test__hybrid_hw_event_with_pmu,
>  		/* 0 */
>  	},
>  	{
> -		.name  = "{cpu_core/cpu-cycles/,cpu_core/instructions/}",
> +		.name  = "{cpu_core/cycles/,cpu_core/branches/}",
>  		.check = test__hybrid_hw_group_event,
>  		/* 1 */
>  	},
>  	{
> -		.name  = "{cpu-clock,cpu_core/cpu-cycles/}",
> +		.name  = "{cpu-clock,cpu_core/cycles/}",
>  		.check = test__hybrid_sw_hw_group_event,
>  		/* 2 */
>  	},
>  	{
> -		.name  = "{cpu_core/cpu-cycles/,cpu-clock}",
> +		.name  = "{cpu_core/cycles/,cpu-clock}",
>  		.check = test__hybrid_hw_sw_group_event,
>  		/* 3 */
>  	},
>  	{
> -		.name  = "{cpu_core/cpu-cycles/k,cpu_core/instructions/u}",
> +		.name  = "{cpu_core/cycles/k,cpu_core/branches/u}",
>  		.check = test__hybrid_group_modifier1,
>  		/* 4 */
>  	},

