Return-Path: <linux-kernel+bounces-130405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A03CF8977E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA44BB3F06B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A78153813;
	Wed,  3 Apr 2024 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hn+PeJVb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B9514AD0A;
	Wed,  3 Apr 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167174; cv=none; b=n+wZregErwjWDx6DXaaNWWdXz2X6WL/BjZKwBUf8+DCEz9hmxnWMH45HNIRJEPhuQx1uvP+LO8ZB2IUQEa7/7Dnrp4Dg8OU1qgvxcWJykC9S1GDECEjNoKzqbh73iNnAPOiD1+e3VPIPNf71XHkjCKGYfVvYVRarqgp48yysKrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167174; c=relaxed/simple;
	bh=YpPcVoU2i+8jYbMzFhpBpOEGsZ1d/CJK8vqqvOc9Jbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L3JcN5zCp/y2dVyAjATCAnRqikJzg3Ma+i6jrEogAmVOaPFj/PXguyNWid5l16UFbjnuHB1TnguLfH7vyHytZ04Ae12bUbYepmJgy+w0lyy2+oYW2g2Ce96iSahMxc25TnaeKaIs9aE5mx1XLuqgwZvOePh+iyUyuw+XcV85wcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hn+PeJVb; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712167173; x=1743703173;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=YpPcVoU2i+8jYbMzFhpBpOEGsZ1d/CJK8vqqvOc9Jbg=;
  b=hn+PeJVb3EX00+HkOZIKw7YXV1DMPdSMO5qb8B6Lubta6BURX5FOXUkr
   huJswxfXLqM9TUJE+kEvJ2SiSMJ8k+MlD3T2AAw76VS+uCEVb+o+hQnew
   BXkIckWKhdwHdsQYiu8GTp6mhU+lFHf2Qq9uO4lHS5DyiuQ1pbIV71g5U
   PFoeosfcr4+qEDYlzSMlbZwwYMBVyiuaDgSyMW91AF91DuTsgog4khedy
   vSE2NMifNS2dwIPaTdv4kYUgyQRaQkcjFSpuRx2RzY23KOXV8GYGDA2G5
   qDWOFcxY3lX0tFJSz++dWLpAYvlRgxNLRltVezx2/lznI0V3v/wc9+e7t
   g==;
X-CSE-ConnectionGUID: +fnq7bCIQZKxEBBs5Q1a0Q==
X-CSE-MsgGUID: N9zYZkqmSuigDqf50vsGuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="29896620"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="29896620"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 10:59:31 -0700
X-CSE-ConnectionGUID: IE8wHYLUTNGHTHLnQmcU2g==
X-CSE-MsgGUID: d3+gSpSRQ1O+Wwca2U+Idg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18937724"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 10:59:31 -0700
Received: from [10.212.3.167] (kliang2-mobl1.ccr.corp.intel.com [10.212.3.167])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 558EE206DF94;
	Wed,  3 Apr 2024 10:59:29 -0700 (PDT)
Message-ID: <dcb0121f-611d-4104-80b9-941d535c5fd2@linux.intel.com>
Date: Wed, 3 Apr 2024 13:59:28 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf metrics: Remove the "No_group" metric group
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>
References: <20240403164636.3429091-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240403164636.3429091-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-04-03 12:46 p.m., Ian Rogers wrote:
> Rather than place metrics without a metric group in "No_group" place
> them in a a metric group that is their name. Still allow such metrics
> to be selected if "No_group" is passed, this change just impacts perf
> list.

So it looks like the "No_group" is not completely removed.
They are just not seen in the perf list, but users can still use it via
perf stat -M No_group, right?

If so, why we want to remove it from perf list? Where can the end user
know which metrics are included in the No_group?

If the No_group is useless, why not completely remove it?

Thanks,
Kan

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/metricgroup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 79ef6095ab28..6ec083af14a1 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -455,7 +455,7 @@ static int metricgroup__add_to_mep_groups(const struct pmu_metric *pm,
>  	const char *g;
>  	char *omg, *mg;
>  
> -	mg = strdup(pm->metric_group ?: "No_group");
> +	mg = strdup(pm->metric_group ?: pm->metric_name);
>  	if (!mg)
>  		return -ENOMEM;
>  	omg = mg;
> @@ -466,7 +466,7 @@ static int metricgroup__add_to_mep_groups(const struct pmu_metric *pm,
>  		if (strlen(g))
>  			me = mep_lookup(groups, g, pm->metric_name);
>  		else
> -			me = mep_lookup(groups, "No_group", pm->metric_name);
> +			me = mep_lookup(groups, pm->metric_name, pm->metric_name);
>  
>  		if (me) {
>  			me->metric_desc = pm->desc;

