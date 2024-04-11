Return-Path: <linux-kernel+bounces-140128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B05D58A0BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FD81C21AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B3514264F;
	Thu, 11 Apr 2024 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDNRm6y9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC9C13FD8E;
	Thu, 11 Apr 2024 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826117; cv=none; b=LoG4owra30ipdKxJvW+uFrM4LnAPSt1PLH9eM00Ee7HLtRYSbyQrOBy6cg7Q5tF0N6WUa+Z9F/jARPELDFy6wkE1qd93sPcNhYgLSm0GXLCETsCNdXxwezVRM0FlkGdxm2cVdTgKHpG/DKjl5jV8PXYpYoxQHqFS3VQ0kfGlHmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826117; c=relaxed/simple;
	bh=xVedsV4VfEGQGozEUtdTCCWXlxXgIeyFTHtRuT3EuY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQ7B2DKUFqoHer1+/gIvSLf/XG10ZwTIUf/sQloLReic7DEkdsSxvboLhIrw0971I713Bl1uaHV15JmgvgKQHg9hqRprR67tYnD6wyBcU8O/G/iD1Hcz4Vr1IuzNxIgUtx8X6HcNlRcratsEgkGevG4lQ8l8zVVdnJlaZ8vWbwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDNRm6y9; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712826115; x=1744362115;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xVedsV4VfEGQGozEUtdTCCWXlxXgIeyFTHtRuT3EuY8=;
  b=mDNRm6y9Q0AIhdmyI8HNXQB7TF/kxi/eMNb4KmkpPkW1CBbcoHD1U2l8
   JoxFkRG+fnA3weHYuNwSXz3rrLWLnn/hlNQ9EpcD9QsTihofqdjka+LUk
   +Lh/wLT6ipGyxYqkDGZN/dOdcoHsXbFjp95C3LCzaaH/IrWTkdhKCZyPO
   osLg/X+G26dAgdDXW9zXwwn8qY/UXUmVCcDQTVEwAaMAZEj2tv3720V3Q
   +h8QmavlY2lFr3yVNB5Bm/2EZG5itzbzKcfi7MRzHiodcz5UKbv9goCBi
   MKBQI8+mB5u75IF0Cq7w9p6gAuO6hlAQciZ6VIXbu7I0ReohhRHjK+LCV
   A==;
X-CSE-ConnectionGUID: JCKLWtmrQnu6q4LSSnb2Zw==
X-CSE-MsgGUID: rh+gDR0+SqKcSbADgvUOtg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8444815"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8444815"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 02:01:54 -0700
X-CSE-ConnectionGUID: koQlii8mRDy4cv4dCye4BQ==
X-CSE-MsgGUID: 5TFrG8/vT4GgcnntO57C4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="21436532"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.215.66])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 02:01:53 -0700
Message-ID: <7ef5951b-fab2-4364-99cd-3ad8fef2dd3f@intel.com>
Date: Thu, 11 Apr 2024 12:01:48 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools: Simplify is_event_supported()
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20240410104450.15602-1-adrian.hunter@intel.com>
 <CAP-5=fXw+HEnyiry=6LWhpPcexbNu=CzknNfcjr=MHa78ujkpw@mail.gmail.com>
 <CAM9d7cg54QYtyOO0986ffBFU2yV49RV7OgTmX5drRAqV84aKSQ@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7cg54QYtyOO0986ffBFU2yV49RV7OgTmX5drRAqV84aKSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/04/24 20:45, Namhyung Kim wrote:
> On Wed, Apr 10, 2024 at 9:08 AM Ian Rogers <irogers@google.com> wrote:
>>
>> On Wed, Apr 10, 2024 at 3:45 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>
>>> Simplify is_event_supported by using sys_perf_event_open() directly like
>>> other perf API probe functions and move it into perf_api_probe.c where
>>> other perf API probe functions reside.
>>>
>>> A side effect is that the probed events do not appear when debug prints
>>> are enabled, which is beneficial because otherwise they can be confused
>>> with selected events.
>>>
>>> This also affects "Test per-thread recording" in
>>> "Miscellaneous Intel PT testing" which expects the debug prints of
>>> only selected events to appear between the debug prints:
>>> "perf record opening and mmapping events" and
>>> "perf record done opening and mmapping events"
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>> nit:
>> Closes: https://lore.kernel.org/lkml/ZhVfc5jYLarnGzKa@x1/
>>
>>> ---
>>>  tools/perf/util/perf_api_probe.c | 40 +++++++++++++++++++++++++
>>>  tools/perf/util/perf_api_probe.h |  2 ++
>>>  tools/perf/util/pmus.c           |  1 +
>>>  tools/perf/util/print-events.c   | 50 +-------------------------------
>>>  tools/perf/util/print-events.h   |  1 -
>>>  5 files changed, 44 insertions(+), 50 deletions(-)
>>>
>>> diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
>>> index 1de3b69cdf4a..13acb34a4e1c 100644
>>> --- a/tools/perf/util/perf_api_probe.c
>>> +++ b/tools/perf/util/perf_api_probe.c
>>> @@ -195,3 +195,43 @@ bool perf_can_record_cgroup(void)
>>>  {
>>>         return perf_probe_api(perf_probe_cgroup);
>>>  }
>>> +
>>> +bool is_event_supported(u8 type, u64 config)
>>> +{
>>> +       struct perf_event_attr attr = {
>>> +               .type = type,
>>> +               .config = config,
>>> +               .disabled = 1,
>>> +       };
>>> +       int fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
>>
>> It looks like this is a change to the actual perf_event_open
>> arguments, I don't think it is an issue but wanted to flag it.
>>
>>> +
>>> +       if (fd < 0) {
>>> +               /*
>>> +                * The event may fail to open if the paranoid value
>>> +                * /proc/sys/kernel/perf_event_paranoid is set to 2
>>> +                * Re-run with exclude_kernel set; we don't do that by
>>> +                * default as some ARM machines do not support it.
>>> +                */
>>> +               attr.exclude_kernel = 1;
>>
>> I worry about the duplicated fallback logic getting out of sync,
>> perhaps we could have a quiet option for evsel__open option, or better
>> delineate the particular log entries.

That seemed like it would be messy, but upon closer inspection
was straight forward.  Patch here:

	https://lore.kernel.org/linux-perf-users/20240411075447.17306-1-adrian.hunter@intel.com/T/#u	

>>                                       I don't really have a good
>> alternative idea and kind of like that detecting an event is available
>> loses the evsel baggage. I would kind of like event parsing just to
>> give 1 or more perf_event_attr for similar reasons.
> 
> We have the missing feature check in the evsel open code,
> and I think we should check the exclude-bits first than others.
> Currently struct pmu has missing_features.exclude_guest only
> and it can have exclude_kernel or others too.
> 
> Anyway, I'm ok with this change.
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks,
> Namhyung


