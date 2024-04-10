Return-Path: <linux-kernel+bounces-138363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D8189F022
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF71281967
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1C1159560;
	Wed, 10 Apr 2024 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VZrF18Tt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C185D2747B;
	Wed, 10 Apr 2024 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712746053; cv=none; b=FyHRqud7j5Z2yrARI3J3LnVKGOJtWHNQmG91KxLapL0snu7oV37vPY9UUVtfT4++rUDGvs23lYa5APufXbiuQ0xH5iF74RHfeUY+3GAAm/DX5MBr25fDfxHcjO9sJXX23Vi7ggM8+THQd4SRtJfw7XVEoUtqDOzGwnvOqzNgqEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712746053; c=relaxed/simple;
	bh=bsQg0enSfShnN99/U/ckzFwZ367KWtErZDdZysJdEkE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EsJCMxDicUVFp6RQLS6N9VvsvXLxmsIjUxnBngUBVR1LjdvRap+k/gPwLisiMgZ3YQr+k2Gxzf0MeqWf5nczR1DNu7GJoRUy0F4u0NgfBgQm5VKX/xeKCJ7wh/5XkuMtpfHtOnDbLVDDwXYc4YFvdDuDoE/Iva75+bNZd3tx1pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VZrF18Tt; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712746052; x=1744282052;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=bsQg0enSfShnN99/U/ckzFwZ367KWtErZDdZysJdEkE=;
  b=VZrF18TttVPLrfwOEr9CP5BZJ/jnbK2oWhxhm+iWF+U0pBp/FPXeFWa8
   oRjTIM041kw+1aMYKlWiXJQx5F1nX939b58zI6nKTwlOrkv4X5ataZR+s
   E+Whjv9QxWD18P/vT22Oa2vGh781sjTY39FPHlw8PLgzZfesTpD98fBCg
   BHxIWvUHP5gIfHngbh3oO+uxQHxRuvvq4uRVXkzvTlxwWenPJu7krRjsc
   uEcSqfBPWHIU+FxrWr3+uDSMENceBNPtuSPUuAzwr4TEa/d7GestOXgAQ
   QTd8ZhkoYeHhFvZZFVdg5yLPWYp29hOGi6ckAdtP9t6WVJzB2V6Kbbmp3
   g==;
X-CSE-ConnectionGUID: pvmAyBlUT+KeQiYjs93EOg==
X-CSE-MsgGUID: LmQ/IfteTaKTYEOUQG8NKA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7972543"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7972543"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 03:47:30 -0700
X-CSE-ConnectionGUID: 7dhDx613R6GIrIfGgmUK/Q==
X-CSE-MsgGUID: vWPJwsZfQ1CvruV1CBmD9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="51742778"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.214.234])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 03:47:27 -0700
Message-ID: <03b3c4a5-d3cc-4540-bbf3-3164f15285df@intel.com>
Date: Wed, 10 Apr 2024 13:47:23 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BISECTED: perf test 'Miscellaneous Intel PT' failing on Intel
 hybrid machines
From: Adrian Hunter <adrian.hunter@intel.com>
To: Ian Rogers <irogers@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 linux-perf-users@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ZhVfc5jYLarnGzKa@x1> <ZhVf9rO-b3xTqZEK@x1>
 <CAP-5=fVbkj74K3w0cOfpbKe2=9wK1AJYkGQmbHLD4SKzc=dVBw@mail.gmail.com>
 <3a816064-ed40-496c-95ab-79753c64b5b6@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <3a816064-ed40-496c-95ab-79753c64b5b6@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/04/24 22:05, Adrian Hunter wrote:
> On 9/04/24 18:46, Ian Rogers wrote:
>> On Tue, Apr 9, 2024 at 8:34 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>>
>>> On Tue, Apr 09, 2024 at 12:32:06PM -0300, Arnaldo Carvalho de Melo wrote:
>>>> root@x1:~# perf test "Miscellaneous Intel PT testing"
>>>> 112: Miscellaneous Intel PT testing                                  : FAILED!
>>>> root@x1:~#
>>>>
>>>> then I revert:
>>>>
>>>> commit 642e1ac96aaa12aeb41402e68eac7faf5917a67a (HEAD -> perf-tools-next)
>>>> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>> Date:   Tue Apr 9 12:28:49 2024 -0300
>>>>
>>>>     Revert "perf pmus: Check if we can encode the PMU number in perf_event_attr.type"
>>>>
>>>>     This reverts commit 82fe2e45cdb00de4fa648050ae33bdadf9b3294a.
>>>> ⬢[acme@toolbox perf-tools-next]$
>>>>
>>>> It works now:
>>>>
>>>> root@x1:~# perf -v
>>>> perf version 6.8.g642e1ac96aaa
>>>> root@x1:~# perf test "Miscellaneous Intel PT testing"
>>>> 117: Miscellaneous Intel PT testing                                  : Ok
>>>> root@x1:~#
>>>>
>>>> Investigating, if you come up with ideas, lemme know.
>>>
>>> Some more context:
>>>
>>> When this patch was implemented/tested I had access only to an ARM64
>>> hybrid machine, now my notebook is a Rocket Lake lenovo (13th gen), that
>>> is hybrid and the test is failing with:
>>>
>>> root@x1:~# perf test -v "Miscellaneous Intel PT testing"
>>> 112: Miscellaneous Intel PT testing                                  :
>>> --- start ---
>>> test child forked, pid 304355
>>> --- Test system-wide sideband ---
>>> Checking for CPU-wide recording on CPU 0
>>> OK
>>> Checking for CPU-wide recording on CPU 1
>>> OK
>>> Linux
>>> [ perf record: Woken up 1 times to write data ]
>>> [ perf record: Captured and wrote 1.934 MB /tmp/perf-test-intel-pt-sh.xACV6V7Hn4/test-perf.data ]
>>> OK
>>> --- Test per-thread recording ---
>>> Workload PIDs are 304377 and 304378
>>> perf PID is 304389
>>> Waiting for "perf record has started" message
>>> OK
>>> pid 0 cpu -1 fd 5 : sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 5
>>> pid 0 cpu -1 fd 6 : sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 6
>>> pid 304377 cpu -1 fd 7 : sys_perf_event_open: pid 304377  cpu -1  group_fd -1  flags 0x8 = 7
>>> pid 304380 cpu -1 fd 8 : sys_perf_event_open: pid 304380  cpu -1  group_fd -1  flags 0x8 = 8
>>> pid 304378 cpu -1 fd 9 : sys_perf_event_open: pid 304378  cpu -1  group_fd -1  flags 0x8 = 9
>>> pid 304381 cpu -1 fd 10 : sys_perf_event_open: pid 304381  cpu -1  group_fd -1  flags 0x8 = 10
>>> pid 304377 cpu -1 fd 11 : sys_perf_event_open: pid 304377  cpu -1  group_fd -1  flags 0x8 = 11
>>> pid 304380 cpu -1 fd 12 : sys_perf_event_open: pid 304380  cpu -1  group_fd -1  flags 0x8 = 12
>>> pid 304378 cpu -1 fd 13 : sys_perf_event_open: pid 304378  cpu -1  group_fd -1  flags 0x8 = 13
>>> pid 304381 cpu -1 fd 14 : sys_perf_event_open: pid 304381  cpu -1  group_fd -1  flags 0x8 = 14
>>> fd 7 : idx 0: mmapping fd 7
>>> fd 11 fd_to 7 : idx 0: set output fd 11 -> 7
>>> fd 8 : idx 1: mmapping fd 8
>>> fd 12 fd_to 8 : idx 1: set output fd 12 -> 8
>>> fd 9 : idx 2: mmapping fd 9
>>> fd 13 fd_to 9 : idx 2: set output fd 13 -> 9
>>> fd 10 : idx 3: mmapping fd 10
>>> fd 14 fd_to 10 : idx 3: set output fd 14 -> 10
>>> Checking 10 fds
>>> No mmap for fd 5
>>
>> Thanks Arnaldo, so the reverted change is:
>> ```
>> --- a/tools/perf/util/pmus.c
>> +++ b/tools/perf/util/pmus.c
>> @@ -4,6 +4,7 @@
>> #include <subcmd/pager.h>
>> #include <sys/types.h>
>> #include <dirent.h>
>> +#include <pthread.h>
>> #include <string.h>
>> #include <unistd.h>
>> #include "debug.h"
>> @@ -492,9 +493,35 @@ int perf_pmus__num_core_pmus(void)
>>        return count;
>> }
>>
>> +static bool __perf_pmus__supports_extended_type(void)
>> +{
>> +       struct perf_pmu *pmu = NULL;
>> +
>> +       if (perf_pmus__num_core_pmus() <= 1)
>> +               return false;
>> +
>> +       while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
>> +               if (!is_event_supported(PERF_TYPE_HARDWARE,
>> PERF_COUNT_HW_CPU_CYCLES | ((__u64)pmu->
>> type << PERF_PMU_TYPE_SHIFT)))
>> +                       return false;
>> +       }
>> +
>> +       return true;
>> +}
>> +
>> +static bool perf_pmus__do_support_extended_type;
>> +
>> +static void perf_pmus__init_supports_extended_type(void)
>> +{
>> +       perf_pmus__do_support_extended_type =
>> __perf_pmus__supports_extended_type();
>> +}
>> +
>> bool perf_pmus__supports_extended_type(void)
>> {
>> -       return perf_pmus__num_core_pmus() > 1;
>> +       static pthread_once_t extended_type_once = PTHREAD_ONCE_INIT;
>> +
>> +       pthread_once(&extended_type_once,
>> perf_pmus__init_supports_extended_type);
>> +
>> +       return perf_pmus__do_support_extended_type;
>> }
>>
>> struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
>> ```
>> On your Intel this should have previously returned true as
>> "perf_pmus__num_core_pmus() > 1", and with the new code presumably
>> is_event_supported is returning false. Could you dump the PMU's name
>> at that point? Is cpu_core or cpu_atom looking like it doesn't support
>> the event? Is the test failing when run as root (ie is
>> is_event_supported failing to have expected fallback paths)?
> 
> Problem is the test scrapes debug output and is_event_supported()
> prints out debug that confuses the test.  Other probe functions
> like in perf_api_probe.c use sys_perf_event_open() so the issue
> has not arisen before.

Patch here:

	https://lore.kernel.org/all/20240410104450.15602-1-adrian.hunter@intel.com/


