Return-Path: <linux-kernel+bounces-130478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60648978B7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 202CFB2144A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F3B15445F;
	Wed,  3 Apr 2024 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXgdaxMO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8083F15443A;
	Wed,  3 Apr 2024 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712170658; cv=none; b=b4x5SXq8u6/Iy9nsl9EOvAIqinqnvgqQTTPwJsjVUwBGIAyNpXz9wOlE2mti6Ltzagy/amAdrgDuQTEMXdIaAToCTz/SSw17PCUFAvAurS86iR6LwOTTPRdnP/MICuSO5rTECc3pYBNkVipQMLINvXqTiHqVajsMRsSIsfppeZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712170658; c=relaxed/simple;
	bh=Vhjx7KPQnEG8AJd2dyNwYayiNAX+hSP6AO4U0tDlWfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nu7HY4WFO8AnsQAJgk2+ydJgCtWm5UkU1hR2yw50BEw2Akp0oVDYU8mUMJc6AwxjOfcCKBDIRmhTFOkydXgR4xE/PL+VSnYzFatYd3FHRWL1DE/0ziJfz/HKo7dD7SB0HgtkMJKPmLxuD+f9YTjwy/+pMdazfojlBfRmhhScIt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXgdaxMO; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712170657; x=1743706657;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Vhjx7KPQnEG8AJd2dyNwYayiNAX+hSP6AO4U0tDlWfc=;
  b=gXgdaxMOkZSVKlZ+TJfga02cT5MJ9B5DLlcTwDXBSallbolS4MV8a7GN
   QytmjE1q2nT0exjisHgj9WKHcZoSXPoV6NwSFJ5jy2Dl0i2U5Dnriw0EJ
   9xx/9NVi+tBn5CWmV6TnxZInGHUg8q0kGdusugQmINcM3NgPLB+iTvv66
   +AtD5bfs0sHNeFIqFvCzvAqrc7yh9ACFAcG3+xbquTmc2MT/CdTCO6xbQ
   cZUsi1SKPLve8XO083EIJjtlYa1UDpYJV07vuHR6I3/6I+owe1+krFbSq
   ytuhF8bqbAARqcYyI023ohLcA0msRzr0xgcONOBqKIvTN2gaYJGXZFMXT
   g==;
X-CSE-ConnectionGUID: 0XwNGbukTciX67zAbY6dYQ==
X-CSE-MsgGUID: TNSEIC/MQ7SQfRVZ24wGxw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7592974"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7592974"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 11:57:36 -0700
X-CSE-ConnectionGUID: fOhFYz28SPGDLFMOp8k+Mg==
X-CSE-MsgGUID: DOzYTKmdSJ2iRVhjRqGnjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="41691414"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 11:57:35 -0700
Received: from [10.212.3.167] (kliang2-mobl1.ccr.corp.intel.com [10.212.3.167])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9A5B6206DF9A;
	Wed,  3 Apr 2024 11:57:33 -0700 (PDT)
Message-ID: <b9868e97-e353-45e0-83b7-aa28bc35dd67@linux.intel.com>
Date: Wed, 3 Apr 2024 14:57:32 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf metrics: Remove the "No_group" metric group
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>
References: <20240403164636.3429091-1-irogers@google.com>
 <dcb0121f-611d-4104-80b9-941d535c5fd2@linux.intel.com>
 <CAP-5=fUgiafmLEKEUJ5r5_tK+jqv30P0TGFCMvR8DkW7J4qYsQ@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUgiafmLEKEUJ5r5_tK+jqv30P0TGFCMvR8DkW7J4qYsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-04-03 2:31 p.m., Ian Rogers wrote:
> On Wed, Apr 3, 2024 at 10:59 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-04-03 12:46 p.m., Ian Rogers wrote:
>>> Rather than place metrics without a metric group in "No_group" place
>>> them in a a metric group that is their name. Still allow such metrics
>>> to be selected if "No_group" is passed, this change just impacts perf
>>> list.
>>
>> So it looks like the "No_group" is not completely removed.
>> They are just not seen in the perf list, but users can still use it via
>> perf stat -M No_group, right?
>>
>> If so, why we want to remove it from perf list? Where can the end user
>> know which metrics are included in the No_group?
>>
>> If the No_group is useless, why not completely remove it?
> 
> Agreed. For command line argument deprecation we usually keep the
> option but hide it from help with PARSE_OPT_HIDDEN, so I was trying to
> follow that pattern albeit that a metric group isn't a command line
> option it's an option to an option.
>

Perf list has a deprecated option to show the deprecated events.
The "No_group" should be a deprecated metrics group.

If so, to follow the same pattern, I think perf list should still
display the "No_group" with the --deprecated option at least.

Thanks,
Kan

> Thanks,
> Ian
> 
>> Thanks,
>> Kan
>>
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/util/metricgroup.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>>> index 79ef6095ab28..6ec083af14a1 100644
>>> --- a/tools/perf/util/metricgroup.c
>>> +++ b/tools/perf/util/metricgroup.c
>>> @@ -455,7 +455,7 @@ static int metricgroup__add_to_mep_groups(const struct pmu_metric *pm,
>>>       const char *g;
>>>       char *omg, *mg;
>>>
>>> -     mg = strdup(pm->metric_group ?: "No_group");
>>> +     mg = strdup(pm->metric_group ?: pm->metric_name);
>>>       if (!mg)
>>>               return -ENOMEM;
>>>       omg = mg;
>>> @@ -466,7 +466,7 @@ static int metricgroup__add_to_mep_groups(const struct pmu_metric *pm,
>>>               if (strlen(g))
>>>                       me = mep_lookup(groups, g, pm->metric_name);
>>>               else
>>> -                     me = mep_lookup(groups, "No_group", pm->metric_name);
>>> +                     me = mep_lookup(groups, pm->metric_name, pm->metric_name);
>>>
>>>               if (me) {
>>>                       me->metric_desc = pm->desc;

