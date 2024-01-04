Return-Path: <linux-kernel+bounces-16782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9BA8243B1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDF5284F4F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CC322EF9;
	Thu,  4 Jan 2024 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NOwET88z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C38B22EE6;
	Thu,  4 Jan 2024 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704378225; x=1735914225;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=kbyW7cxpuIZDLuW3Os9I8ZKDILbXz5KCKp00rYx8VTA=;
  b=NOwET88z+51QWrf35FMQGfoHlPBGI65N7rpbcDLWBlxtdW8K3ZnqqCny
   g3wIMHDKjCVQZjjNjrQr6PIh7ukvdHY4Rr9i5R1uWMPiBns9ZhayKXqvL
   FYwqtA+4S0QtELJnuLCKQyc9Gb2oaaOqD5EvZqwYhLCIQZ/D2hS6WuvAf
   1chfCJOpY7jUMSMX3O2cAEz7xkG69wQLhnVeSZs4M7AsMwEnuhnEx9Naw
   yaisNk5Liif3LSd6MxR6l0vjBgp8s+QYJj3glDTcve6sf0lffkniepFwp
   SRN2iyUEjBD5dQB0Z2/M6Lllw3uJlrLGsGlagFOf+KpgSckk6tCYUHGTE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="382230328"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="382230328"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 06:23:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="783886663"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="783886663"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 06:23:43 -0800
Received: from [10.209.154.172] (kliang2-mobl1.ccr.corp.intel.com [10.209.154.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id DDE79580D4E;
	Thu,  4 Jan 2024 06:23:41 -0800 (PST)
Message-ID: <59bbc646-b1ef-4ef0-9880-79856849a760@linux.intel.com>
Date: Thu, 4 Jan 2024 09:23:40 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] perf vendor events intel: Alderlake/rocketlake
 metric fixes
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Edward Baker <edward.baker@intel.com>
References: <20240104074259.653219-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240104074259.653219-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-01-04 2:42 a.m., Ian Rogers wrote:
> Fix that the core PMU is being specified for 2 uncore events. Specify
> a PMU for the alderlake UNCORE_FREQ metric.
> 
> Conversion script updated in:
> https://github.com/intel/perfmon/pull/126
> 
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Closes: https://lore.kernel.org/lkml/ZZWOdHXJJ_oecWwm@kernel.org/
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks Ian. For the series,

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  .../arch/x86/alderlake/adl-metrics.json           | 15 ++++++++-------
>  .../arch/x86/rocketlake/rkl-metrics.json          |  2 +-
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> index 3388b58b8f1a..35124a4ddcb2 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> @@ -69,12 +69,6 @@
>          "MetricName": "C9_Pkg_Residency",
>          "ScaleUnit": "100%"
>      },
> -    {
> -        "BriefDescription": "Uncore frequency per die [GHZ]",
> -        "MetricExpr": "tma_info_system_socket_clks / #num_dies / duration_time / 1e9",
> -        "MetricGroup": "SoC",
> -        "MetricName": "UNCORE_FREQ"
> -    },
>      {
>          "BriefDescription": "Percentage of cycles spent in System Management Interrupts.",
>          "MetricExpr": "((msr@aperf@ - cycles) / msr@aperf@ if msr@smi@ > 0 else 0)",
> @@ -809,6 +803,13 @@
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
> +    {
> +        "BriefDescription": "Uncore frequency per die [GHZ]",
> +        "MetricExpr": "tma_info_system_socket_clks / #num_dies / duration_time / 1e9",
> +        "MetricGroup": "SoC",
> +        "MetricName": "UNCORE_FREQ",
> +        "Unit": "cpu_core"
> +    },
>      {
>          "BriefDescription": "This metric represents Core fraction of cycles CPU dispatched uops on execution ports for ALU operations.",
>          "MetricExpr": "(cpu_core@UOPS_DISPATCHED.PORT_0@ + cpu_core@UOPS_DISPATCHED.PORT_1@ + cpu_core@UOPS_DISPATCHED.PORT_5_11@ + cpu_core@UOPS_DISPATCHED.PORT_6@) / (5 * tma_info_core_core_clks)",
> @@ -1838,7 +1839,7 @@
>      },
>      {
>          "BriefDescription": "Average number of parallel data read requests to external memory",
> -        "MetricExpr": "UNC_ARB_DAT_OCCUPANCY.RD / cpu_core@UNC_ARB_DAT_OCCUPANCY.RD\\,cmask\\=1@",
> +        "MetricExpr": "UNC_ARB_DAT_OCCUPANCY.RD / UNC_ARB_DAT_OCCUPANCY.RD@cmask\\=1@",
>          "MetricGroup": "Mem;MemoryBW;SoC",
>          "MetricName": "tma_info_system_mem_parallel_reads",
>          "PublicDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
> diff --git a/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json b/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json
> index 0c880e415669..27433fc15ede 100644
> --- a/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json
> @@ -985,7 +985,7 @@
>      },
>      {
>          "BriefDescription": "Average number of parallel data read requests to external memory",
> -        "MetricExpr": "UNC_ARB_DAT_OCCUPANCY.RD / cpu@UNC_ARB_DAT_OCCUPANCY.RD\\,cmask\\=1@",
> +        "MetricExpr": "UNC_ARB_DAT_OCCUPANCY.RD / UNC_ARB_DAT_OCCUPANCY.RD@cmask\\=1@",
>          "MetricGroup": "Mem;MemoryBW;SoC",
>          "MetricName": "tma_info_system_mem_parallel_reads",
>          "PublicDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches"

