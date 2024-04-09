Return-Path: <linux-kernel+bounces-137334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B56D89E09E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A3A283B55
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E5D15358F;
	Tue,  9 Apr 2024 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/VYgIUQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2C1153589;
	Tue,  9 Apr 2024 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680671; cv=none; b=IN91EPCj1qSVWqi5xK/AiaRAkZy9c5PbtMCyDLZOTud0zIMHT8gX4L/IUEmJuWI5zAMqnq2Xql/R+1hG2ZxtC1jaiaPpl5a1leJzmuw2ov0X/wQrLD0vYCrNE8bmP+wEEWjJuts0earceSXwkl8Ah1vb8MouQFLR9/XThQqPa8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680671; c=relaxed/simple;
	bh=xqJbZq19c7Cj0t3/d57q11TGDguY/MaLz4PEjTRUxaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjH8a8aAUnsoaxNYbWLdyRQ7YLclKn3K+saDXh1wHIHQqK2vTcnhoomRayFsfAnz5Iy2kJdd69O02mV473BQdCFHAH2Az2ifi5w6egqN76J1brZJNwWwMLtjmwXjQlN4IAOGpsXUs+YodXLfRSYLgqxB9mNlGl3igoW4zQrO1JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/VYgIUQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712680669; x=1744216669;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xqJbZq19c7Cj0t3/d57q11TGDguY/MaLz4PEjTRUxaE=;
  b=H/VYgIUQ+fiWpUw1mFnqJn3rYKP0euLVKxo2/vWGYlTl6/Ys1eFc8XRp
   lx17m7S2Oi/Q7V71NGK8vufF3HEILUwRUxWUur8/0HAmjeq/OxKsj9YRM
   UW2id7+SqSI6ryfhsl31M2q6ky0SbfcCnsUukPiYiOPG/JN92uHtlE2yN
   tsF/0lpworkHlfTPOYsZEmk9H3JXWcjYjVUIYQe54p3pleiKL5EHpD8XM
   pwVBvs5DAbF+G5z7FBJ5UceaZpGDIKH2ZvW2Lyz7MtJW45bQ0XDSDMyw2
   qsYOH0sWz/6cKmzZTWM7ZiYKT+Jxj1M5O0H4aibk5ZDLMeUAZo7GvQZvi
   w==;
X-CSE-ConnectionGUID: Hkacrk/yS8aGzBix7Z24Nw==
X-CSE-MsgGUID: c6iRL3e5Q2q8NwwcZcVreg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7860743"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="7860743"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 09:37:48 -0700
X-CSE-ConnectionGUID: TBpibqFQTqC2zSgJCEAwxw==
X-CSE-MsgGUID: yMOCvQN0TwO3alMQFooIYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="43500679"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 09:37:48 -0700
Received: from [10.213.177.168] (kliang2-mobl1.ccr.corp.intel.com [10.213.177.168])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 23B7820B56EB;
	Tue,  9 Apr 2024 09:37:46 -0700 (PDT)
Message-ID: <0ec1328a-0731-42a6-b953-163ac5a56deb@linux.intel.com>
Date: Tue, 9 Apr 2024 12:37:44 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] perf report: Add weight[123] output fields
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, Andi Kleen <ak@linux.intel.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>
References: <20240409000659.1727785-1-namhyung@kernel.org>
 <20240409000659.1727785-3-namhyung@kernel.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240409000659.1727785-3-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-04-08 8:06 p.m., Namhyung Kim wrote:
> Add weight1, weight2 and weight3 fields to -F/--fields and their aliases
> like 'ins_lat', 'p_stage_cyc' and 'retire_lat'.  Note that they are in
> the sort keys too but the difference is that output fields will sum up
> the weight values and display the average.
> 
> In the sort key, users can see the distribution of weight value and I
> think it's confusing we have local vs. global weight for the same weight.
> 
> For example, I experiment with mem-loads events to get the weights.  On
> my laptop, it seems only weight1 field is supported.
> 
>   $ perf mem record -- perf test -w noploop
> 
> Let's look at the noploop function only.  It has 7 samples.
> 
>   $ perf script -F event,ip,sym,weight | grep noploop
>   # event                         weight     ip           sym
>   cpu/mem-loads,ldlat=30/P:           43     55b3c122bffc noploop
>   cpu/mem-loads,ldlat=30/P:           48     55b3c122bffc noploop
>   cpu/mem-loads,ldlat=30/P:           38     55b3c122bffc noploop    <--- same weight
>   cpu/mem-loads,ldlat=30/P:           38     55b3c122bffc noploop    <--- same weight
>   cpu/mem-loads,ldlat=30/P:           59     55b3c122bffc noploop
>   cpu/mem-loads,ldlat=30/P:           33     55b3c122bffc noploop
>   cpu/mem-loads,ldlat=30/P:           38     55b3c122bffc noploop    <--- same weight
> 
> When you use the 'weight' sort key, it'd show entries with a separate
> weight value separately.  Also note that the first entry has 3 samples
> with weight value 38, so they are displayed together and the weight
> value is the sum of 3 samples (114 = 38 * 3).
> 
>   $ perf report -n -s +weight | grep -e Weight -e noploop
>   # Overhead  Samples  Command   Shared Object   Symbol         Weight
>        0.53%        3     perf   perf            [.] noploop    114
>        0.18%        1     perf   perf            [.] noploop    59
>        0.18%        1     perf   perf            [.] noploop    48
>        0.18%        1     perf   perf            [.] noploop    43
>        0.18%        1     perf   perf            [.] noploop    33
> 
> If you use 'local_weight' sort key, you can see the actualy weight.
> 
>   $ perf report -n -s +local_weight | grep -e Weight -e noploop
>   # Overhead  Samples  Command   Shared Object   Symbol         Local Weight
>        0.53%        3     perf   perf            [.] noploop    38
>        0.18%        1     perf   perf            [.] noploop    59
>        0.18%        1     perf   perf            [.] noploop    48
>        0.18%        1     perf   perf            [.] noploop    43
>        0.18%        1     perf   perf            [.] noploop    33
> 
> But when you use the -F/--field option instead, you can see the average
> weight for the while noploop funciton (as it won't group samples by

%s/funciton/function/

> weight value and use the default 'comm,dso,sym' sort keys).
> 
>   $ perf report -n -F +weight | grep -e Weight -e noploop
>   # Overhead  Samples  Weight1  Command  Shared Object  Symbol
>        1.23%        7     42.4  perf     perf           [.] noploop

I think the current +weight shows the sum of weight1 of all samples,
(global weight). With this patch, it becomes an average (local_weight).
The definition change may break the existing user script.

Ideally, I think we should keep the meaning of the weight and
local_weight as is.

Thanks,
Kan

> 
> The weight1 field shows the average value:
>   (38 * 3 + 59 + 48 + 43 + 33) / 7 = 42.4
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-report.txt |  9 ++-
>  tools/perf/ui/hist.c                     | 92 +++++++++++++++++++-----
>  tools/perf/util/hist.h                   | 15 +++-
>  tools/perf/util/sort.c                   | 25 ++++---
>  tools/perf/util/sort.h                   |  2 +-
>  5 files changed, 112 insertions(+), 31 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index d8b863e01fe0..d2b1593ef700 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -121,6 +121,9 @@ OPTIONS
>  	- type: Data type of sample memory access.
>  	- typeoff: Offset in the data type of sample memory access.
>  	- symoff: Offset in the symbol.
> +	- weight1: Average value of event specific weight (1st field of weight_struct).
> +	- weight2: Average value of event specific weight (2nd field of weight_struct).
> +	- weight3: Average value of event specific weight (3rd field of weight_struct).
>  
>  	By default, comm, dso and symbol keys are used.
>  	(i.e. --sort comm,dso,symbol)
> @@ -198,7 +201,11 @@ OPTIONS
>  --fields=::
>  	Specify output field - multiple keys can be specified in CSV format.
>  	Following fields are available:
> -	overhead, overhead_sys, overhead_us, overhead_children, sample and period.
> +	overhead, overhead_sys, overhead_us, overhead_children, sample, period,
> +	weight1, weight2, weight3, ins_lat, p_stage_cyc and retire_lat.  The
> +	last 3 names are alias for the corresponding weights.  When the weight
> +	fields are used, they will show the average value of the weight.
> +
>  	Also it can contain any sort key(s).
>  
>  	By default, every sort keys not specified in -F will be appended
> diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> index 2bf959d08354..685ba2a54fd8 100644
> --- a/tools/perf/ui/hist.c
> +++ b/tools/perf/ui/hist.c
> @@ -25,7 +25,7 @@
>  
>  static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
>  		      hpp_field_fn get_field, const char *fmt, int len,
> -		      hpp_snprint_fn print_fn, bool fmt_percent)
> +		      hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype)
>  {
>  	int ret;
>  	struct hists *hists = he->hists;
> @@ -33,7 +33,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
>  	char *buf = hpp->buf;
>  	size_t size = hpp->size;
>  
> -	if (fmt_percent) {
> +	if (fmtype == PERF_HPP_FMT_TYPE__PERCENT) {
>  		double percent = 0.0;
>  		u64 total = hists__total_period(hists);
>  
> @@ -41,8 +41,16 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
>  			percent = 100.0 * get_field(he) / total;
>  
>  		ret = hpp__call_print_fn(hpp, print_fn, fmt, len, percent);
> -	} else
> +	} else if (fmtype == PERF_HPP_FMT_TYPE__AVERAGE) {
> +		double average = 0;
> +
> +		if (he->stat.nr_events)
> +			average = 1.0 * get_field(he) / he->stat.nr_events;
> +
> +		ret = hpp__call_print_fn(hpp, print_fn, fmt, len, average);
> +	} else {
>  		ret = hpp__call_print_fn(hpp, print_fn, fmt, len, get_field(he));
> +	}
>  
>  	if (evsel__is_group_event(evsel)) {
>  		int prev_idx, idx_delta;
> @@ -54,6 +62,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
>  		list_for_each_entry(pair, &he->pairs.head, pairs.node) {
>  			u64 period = get_field(pair);
>  			u64 total = hists__total_period(pair->hists);
> +			int nr_samples = pair->stat.nr_events;
>  
>  			if (!total)
>  				continue;
> @@ -66,7 +75,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
>  				 * zero-fill group members in the middle which
>  				 * have no sample
>  				 */
> -				if (fmt_percent) {
> +				if (fmtype != PERF_HPP_FMT_TYPE__RAW) {
>  					ret += hpp__call_print_fn(hpp, print_fn,
>  								  fmt, len, 0.0);
>  				} else {
> @@ -75,9 +84,14 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
>  				}
>  			}
>  
> -			if (fmt_percent) {
> +			if (fmtype == PERF_HPP_FMT_TYPE__PERCENT) {
>  				ret += hpp__call_print_fn(hpp, print_fn, fmt, len,
>  							  100.0 * period / total);
> +			} else if (fmtype == PERF_HPP_FMT_TYPE__AVERAGE) {
> +				double avg = nr_samples ? (period / nr_samples) : 0;
> +
> +				ret += hpp__call_print_fn(hpp, print_fn, fmt,
> +							  len, avg);
>  			} else {
>  				ret += hpp__call_print_fn(hpp, print_fn, fmt,
>  							  len, period);
> @@ -92,7 +106,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
>  			/*
>  			 * zero-fill group members at last which have no sample
>  			 */
> -			if (fmt_percent) {
> +			if (fmtype != PERF_HPP_FMT_TYPE__RAW) {
>  				ret += hpp__call_print_fn(hpp, print_fn,
>  							  fmt, len, 0.0);
>  			} else {
> @@ -114,33 +128,35 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
>  
>  int hpp__fmt(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>  	     struct hist_entry *he, hpp_field_fn get_field,
> -	     const char *fmtstr, hpp_snprint_fn print_fn, bool fmt_percent)
> +	     const char *fmtstr, hpp_snprint_fn print_fn,
> +	     enum perf_hpp_fmt_type fmtype)
>  {
>  	int len = fmt->user_len ?: fmt->len;
>  
>  	if (symbol_conf.field_sep) {
>  		return __hpp__fmt(hpp, he, get_field, fmtstr, 1,
> -				  print_fn, fmt_percent);
> +				  print_fn, fmtype);
>  	}
>  
> -	if (fmt_percent)
> +	if (fmtype == PERF_HPP_FMT_TYPE__PERCENT)
>  		len -= 2; /* 2 for a space and a % sign */
>  	else
>  		len -= 1;
>  
> -	return  __hpp__fmt(hpp, he, get_field, fmtstr, len, print_fn, fmt_percent);
> +	return  __hpp__fmt(hpp, he, get_field, fmtstr, len, print_fn, fmtype);
>  }
>  
>  int hpp__fmt_acc(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>  		 struct hist_entry *he, hpp_field_fn get_field,
> -		 const char *fmtstr, hpp_snprint_fn print_fn, bool fmt_percent)
> +		 const char *fmtstr, hpp_snprint_fn print_fn,
> +		 enum perf_hpp_fmt_type fmtype)
>  {
>  	if (!symbol_conf.cumulate_callchain) {
>  		int len = fmt->user_len ?: fmt->len;
>  		return snprintf(hpp->buf, hpp->size, " %*s", len - 1, "N/A");
>  	}
>  
> -	return hpp__fmt(fmt, hpp, he, get_field, fmtstr, print_fn, fmt_percent);
> +	return hpp__fmt(fmt, hpp, he, get_field, fmtstr, print_fn, fmtype);
>  }
>  
>  static int field_cmp(u64 field_a, u64 field_b)
> @@ -350,7 +366,7 @@ static int hpp__color_##_type(struct perf_hpp_fmt *fmt,				\
>  			      struct perf_hpp *hpp, struct hist_entry *he) 	\
>  {										\
>  	return hpp__fmt(fmt, hpp, he, he_get_##_field, " %*.2f%%",		\
> -			hpp_color_scnprintf, true);				\
> +			hpp_color_scnprintf, PERF_HPP_FMT_TYPE__PERCENT);	\
>  }
>  
>  #define __HPP_ENTRY_PERCENT_FN(_type, _field)					\
> @@ -358,7 +374,7 @@ static int hpp__entry_##_type(struct perf_hpp_fmt *fmt,				\
>  			      struct perf_hpp *hpp, struct hist_entry *he) 	\
>  {										\
>  	return hpp__fmt(fmt, hpp, he, he_get_##_field, " %*.2f%%",		\
> -			hpp_entry_scnprintf, true);				\
> +			hpp_entry_scnprintf, PERF_HPP_FMT_TYPE__PERCENT);	\
>  }
>  
>  #define __HPP_SORT_FN(_type, _field)						\
> @@ -378,7 +394,7 @@ static int hpp__color_##_type(struct perf_hpp_fmt *fmt,				\
>  			      struct perf_hpp *hpp, struct hist_entry *he) 	\
>  {										\
>  	return hpp__fmt_acc(fmt, hpp, he, he_get_acc_##_field, " %*.2f%%", 	\
> -			    hpp_color_scnprintf, true);				\
> +			    hpp_color_scnprintf, PERF_HPP_FMT_TYPE__PERCENT);	\
>  }
>  
>  #define __HPP_ENTRY_ACC_PERCENT_FN(_type, _field)				\
> @@ -386,7 +402,7 @@ static int hpp__entry_##_type(struct perf_hpp_fmt *fmt,				\
>  			      struct perf_hpp *hpp, struct hist_entry *he) 	\
>  {										\
>  	return hpp__fmt_acc(fmt, hpp, he, he_get_acc_##_field, " %*.2f%%",	\
> -			    hpp_entry_scnprintf, true);				\
> +			    hpp_entry_scnprintf, PERF_HPP_FMT_TYPE__PERCENT);	\
>  }
>  
>  #define __HPP_SORT_ACC_FN(_type, _field)					\
> @@ -406,7 +422,7 @@ static int hpp__entry_##_type(struct perf_hpp_fmt *fmt,				\
>  			      struct perf_hpp *hpp, struct hist_entry *he) 	\
>  {										\
>  	return hpp__fmt(fmt, hpp, he, he_get_raw_##_field, " %*"PRIu64, 	\
> -			hpp_entry_scnprintf, false);				\
> +			hpp_entry_scnprintf, PERF_HPP_FMT_TYPE__RAW);		\
>  }
>  
>  #define __HPP_SORT_RAW_FN(_type, _field)					\
> @@ -416,6 +432,26 @@ static int64_t hpp__sort_##_type(struct perf_hpp_fmt *fmt __maybe_unused, 	\
>  	return __hpp__sort(a, b, he_get_raw_##_field);				\
>  }
>  
> +#define __HPP_ENTRY_AVERAGE_FN(_type, _field)					\
> +static u64 he_get_##_field(struct hist_entry *he)				\
> +{										\
> +	return he->stat._field;							\
> +}										\
> +										\
> +static int hpp__entry_##_type(struct perf_hpp_fmt *fmt,				\
> +			      struct perf_hpp *hpp, struct hist_entry *he) 	\
> +{										\
> +	return hpp__fmt(fmt, hpp, he, he_get_##_field, " %*.1f",		\
> +			hpp_entry_scnprintf, PERF_HPP_FMT_TYPE__AVERAGE);	\
> +}
> +
> +#define __HPP_SORT_AVERAGE_FN(_type, _field)					\
> +static int64_t hpp__sort_##_type(struct perf_hpp_fmt *fmt __maybe_unused, 	\
> +				 struct hist_entry *a, struct hist_entry *b) 	\
> +{										\
> +	return __hpp__sort(a, b, he_get_##_field);				\
> +}
> +
>  
>  #define HPP_PERCENT_FNS(_type, _field)					\
>  __HPP_COLOR_PERCENT_FN(_type, _field)					\
> @@ -431,6 +467,10 @@ __HPP_SORT_ACC_FN(_type, _field)
>  __HPP_ENTRY_RAW_FN(_type, _field)					\
>  __HPP_SORT_RAW_FN(_type, _field)
>  
> +#define HPP_AVERAGE_FNS(_type, _field)					\
> +__HPP_ENTRY_AVERAGE_FN(_type, _field)					\
> +__HPP_SORT_AVERAGE_FN(_type, _field)
> +
>  HPP_PERCENT_FNS(overhead, period)
>  HPP_PERCENT_FNS(overhead_sys, period_sys)
>  HPP_PERCENT_FNS(overhead_us, period_us)
> @@ -441,6 +481,10 @@ HPP_PERCENT_ACC_FNS(overhead_acc, period)
>  HPP_RAW_FNS(samples, nr_events)
>  HPP_RAW_FNS(period, period)
>  
> +HPP_AVERAGE_FNS(weight1, weight1)
> +HPP_AVERAGE_FNS(weight2, weight2)
> +HPP_AVERAGE_FNS(weight3, weight3)
> +
>  static int64_t hpp__nop_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
>  			    struct hist_entry *a __maybe_unused,
>  			    struct hist_entry *b __maybe_unused)
> @@ -510,7 +554,10 @@ struct perf_hpp_fmt perf_hpp__format[] = {
>  	HPP__COLOR_PRINT_FNS("guest usr", overhead_guest_us, OVERHEAD_GUEST_US),
>  	HPP__COLOR_ACC_PRINT_FNS("Children", overhead_acc, OVERHEAD_ACC),
>  	HPP__PRINT_FNS("Samples", samples, SAMPLES),
> -	HPP__PRINT_FNS("Period", period, PERIOD)
> +	HPP__PRINT_FNS("Period", period, PERIOD),
> +	HPP__PRINT_FNS("Weight1", weight1, WEIGHT1),
> +	HPP__PRINT_FNS("Weight2", weight2, WEIGHT2),
> +	HPP__PRINT_FNS("Weight3", weight3, WEIGHT3),
>  };
>  
>  struct perf_hpp_list perf_hpp_list = {
> @@ -526,6 +573,7 @@ struct perf_hpp_list perf_hpp_list = {
>  #undef HPP_PERCENT_FNS
>  #undef HPP_PERCENT_ACC_FNS
>  #undef HPP_RAW_FNS
> +#undef HPP_AVERAGE_FNS
>  
>  #undef __HPP_HEADER_FN
>  #undef __HPP_WIDTH_FN
> @@ -534,9 +582,11 @@ struct perf_hpp_list perf_hpp_list = {
>  #undef __HPP_COLOR_ACC_PERCENT_FN
>  #undef __HPP_ENTRY_ACC_PERCENT_FN
>  #undef __HPP_ENTRY_RAW_FN
> +#undef __HPP_ENTRY_AVERAGE_FN
>  #undef __HPP_SORT_FN
>  #undef __HPP_SORT_ACC_FN
>  #undef __HPP_SORT_RAW_FN
> +#undef __HPP_SORT_AVERAGE_FN
>  
>  static void fmt_free(struct perf_hpp_fmt *fmt)
>  {
> @@ -785,6 +835,12 @@ void perf_hpp__reset_width(struct perf_hpp_fmt *fmt, struct hists *hists)
>  		fmt->len = 12;
>  		break;
>  
> +	case PERF_HPP__WEIGHT1:
> +	case PERF_HPP__WEIGHT2:
> +	case PERF_HPP__WEIGHT3:
> +		fmt->len = 8;
> +		break;
> +
>  	default:
>  		break;
>  	}
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index f34f101c36c2..5260822b9773 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -550,6 +550,9 @@ enum {
>  	PERF_HPP__OVERHEAD_ACC,
>  	PERF_HPP__SAMPLES,
>  	PERF_HPP__PERIOD,
> +	PERF_HPP__WEIGHT1,
> +	PERF_HPP__WEIGHT2,
> +	PERF_HPP__WEIGHT3,
>  
>  	PERF_HPP__MAX_INDEX
>  };
> @@ -596,16 +599,24 @@ void perf_hpp__reset_sort_width(struct perf_hpp_fmt *fmt, struct hists *hists);
>  void perf_hpp__set_user_width(const char *width_list_str);
>  void hists__reset_column_width(struct hists *hists);
>  
> +enum perf_hpp_fmt_type {
> +	PERF_HPP_FMT_TYPE__RAW,
> +	PERF_HPP_FMT_TYPE__PERCENT,
> +	PERF_HPP_FMT_TYPE__AVERAGE,
> +};
> +
>  typedef u64 (*hpp_field_fn)(struct hist_entry *he);
>  typedef int (*hpp_callback_fn)(struct perf_hpp *hpp, bool front);
>  typedef int (*hpp_snprint_fn)(struct perf_hpp *hpp, const char *fmt, ...);
>  
>  int hpp__fmt(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>  	     struct hist_entry *he, hpp_field_fn get_field,
> -	     const char *fmtstr, hpp_snprint_fn print_fn, bool fmt_percent);
> +	     const char *fmtstr, hpp_snprint_fn print_fn,
> +	     enum perf_hpp_fmt_type fmtype);
>  int hpp__fmt_acc(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>  		 struct hist_entry *he, hpp_field_fn get_field,
> -		 const char *fmtstr, hpp_snprint_fn print_fn, bool fmt_percent);
> +		 const char *fmtstr, hpp_snprint_fn print_fn,
> +		 enum perf_hpp_fmt_type fmtype);
>  
>  static inline void advance_hpp(struct perf_hpp *hpp, int inc)
>  {
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 92a1bd695e8a..e43558bbca38 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -2441,6 +2441,13 @@ static struct hpp_dimension hpp_sort_dimensions[] = {
>  	DIM(PERF_HPP__OVERHEAD_ACC, "overhead_children"),
>  	DIM(PERF_HPP__SAMPLES, "sample"),
>  	DIM(PERF_HPP__PERIOD, "period"),
> +	DIM(PERF_HPP__WEIGHT1, "weight1"),
> +	DIM(PERF_HPP__WEIGHT2, "weight2"),
> +	DIM(PERF_HPP__WEIGHT3, "weight3"),
> +	/* aliases for weight_struct */
> +	DIM(PERF_HPP__WEIGHT2, "ins_lat"),
> +	DIM(PERF_HPP__WEIGHT3, "retire_lat"),
> +	DIM(PERF_HPP__WEIGHT3, "p_stage_cyc"),
>  };
>  
>  #undef DIM
> @@ -3743,26 +3750,26 @@ void sort__setup_elide(FILE *output)
>  	}
>  }
>  
> -int output_field_add(struct perf_hpp_list *list, char *tok)
> +int output_field_add(struct perf_hpp_list *list, const char *tok)
>  {
>  	unsigned int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(common_sort_dimensions); i++) {
> -		struct sort_dimension *sd = &common_sort_dimensions[i];
> +	for (i = 0; i < ARRAY_SIZE(hpp_sort_dimensions); i++) {
> +		struct hpp_dimension *hd = &hpp_sort_dimensions[i];
>  
> -		if (!sd->name || strncasecmp(tok, sd->name, strlen(tok)))
> +		if (strncasecmp(tok, hd->name, strlen(tok)))
>  			continue;
>  
> -		return __sort_dimension__add_output(list, sd);
> +		return __hpp_dimension__add_output(list, hd);
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(hpp_sort_dimensions); i++) {
> -		struct hpp_dimension *hd = &hpp_sort_dimensions[i];
> +	for (i = 0; i < ARRAY_SIZE(common_sort_dimensions); i++) {
> +		struct sort_dimension *sd = &common_sort_dimensions[i];
>  
> -		if (strncasecmp(tok, hd->name, strlen(tok)))
> +		if (!sd->name || strncasecmp(tok, sd->name, strlen(tok)))
>  			continue;
>  
> -		return __hpp_dimension__add_output(list, hd);
> +		return __sort_dimension__add_output(list, sd);
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(bstack_sort_dimensions); i++) {
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index 690892a92cf3..0bd0ee3ae76b 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -141,7 +141,7 @@ void reset_dimensions(void);
>  int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
>  			struct evlist *evlist,
>  			int level);
> -int output_field_add(struct perf_hpp_list *list, char *tok);
> +int output_field_add(struct perf_hpp_list *list, const char *tok);
>  int64_t
>  sort__iaddr_cmp(struct hist_entry *left, struct hist_entry *right);
>  int64_t

