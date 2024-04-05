Return-Path: <linux-kernel+bounces-133185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2784389A011
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39BD1F2409E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE57816F29B;
	Fri,  5 Apr 2024 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ljmhc9b6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE56016EC00;
	Fri,  5 Apr 2024 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328364; cv=none; b=U8gQX8JueATAoOtTQEKfaBuMhBcT1Rbh/Y9WDXn0kF0Oa4WM1kIGdLO4DyqWBanE4SgkE6zz1pfiA/VbOOcSH79NiaMgT90dW7lnFS/g1+msl1AFE1nJGoWmgBtPJtNtjjCK2EgdRI76b7hHP2RU8vLVKcLVR25ut5u6vL2Z0qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328364; c=relaxed/simple;
	bh=ceEL4mAfzMOa2yjome0jtGAnEvqrf3nTfaQB4S9ZAtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lR0nZLLlSwVibLdlz7Mqdc1Smn0mIsZPedn330ZEMCWgMQMKgJUYonfEBarFN8rb3fhMpNq01SB0WY6IAPfecyRvkdciVZGVaCkiKYnnm7S6tMZ3FvGMJpRTHMzVV6BHJa6vANlwnD+jdKQKdGx9OI2p5LvS3RKM1MEr2Q7bslw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ljmhc9b6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712328363; x=1743864363;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ceEL4mAfzMOa2yjome0jtGAnEvqrf3nTfaQB4S9ZAtc=;
  b=Ljmhc9b68VPm53VF4BfMPZCUuqfo7H302tGqKZiyacRVP7eTbjlHN5X8
   B2Tf73KMc1hE9mIPRtP4JNO+gdI9lqfojprx49CrlqCDy2xk0WXQbr3nH
   i9m8ufjLwmZO5/jh+w96FcUK5ZKyXrB/NNqtK9pnmPWBGqN4QMS0lB+7d
   OSTK3C15f+CvxScZ+hP7MpnZBQd0Wb2y/8TbeDyvl11+XxJ+WKFkGYgCg
   V+UhpTc2bmjNuCC3b6kn0s5bjQzESk/vcdLWKTPHH2hLckzSXUTYd8Fyf
   YD9UxsT2WSNmZxehS4lyzBC7u4V+8mgfG7fZ354Kqs1ITkmOY+Vlh4XzI
   w==;
X-CSE-ConnectionGUID: 6e6E40moT9SzEDq7G2BsEQ==
X-CSE-MsgGUID: SONwuYOCQYOEXwWxO3v9rQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18392296"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="18392296"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 07:46:02 -0700
X-CSE-ConnectionGUID: 63p7/dcvQTibZOYuBBQiKA==
X-CSE-MsgGUID: T7E7nsViQaSPu6gnhrlNYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19209263"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 07:46:00 -0700
Received: from [10.213.182.74] (kliang2-mobl1.ccr.corp.intel.com [10.213.182.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 4033920C0655;
	Fri,  5 Apr 2024 07:46:00 -0700 (PDT)
Message-ID: <8e60ccd6-907e-445c-85e0-785b1426e98c@linux.intel.com>
Date: Fri, 5 Apr 2024 10:45:59 -0400
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
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

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

