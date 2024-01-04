Return-Path: <linux-kernel+bounces-16791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF678243D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7BB285928
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0C122EF5;
	Thu,  4 Jan 2024 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NO05R/69"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE62225CA;
	Thu,  4 Jan 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704378627; x=1735914627;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qx+BndH/usws2a2ca7Hh6V4vOx+5kTp8i9e8jSCqEcM=;
  b=NO05R/69sV5/Jxp0cnN7i7bm/ngDzEOrjWlq0h9V4dkNiDwP36mei+02
   HejFbtuIjzelm7fz6E1+5gUT+kytMgsYD/qppYg+2IVKU1Q07VUA2J16f
   towwQmNMfdP3WmiNvb7y3y09FvSqZmxCEdNzG2JSHL3Qk0KC13Lfs2dky
   +bPYPVg1/sPhBZwQFvxpa2kIz0Y+POiSwLIjkblRFTP34WVfpY+wzAlUF
   mT8sU6THh0kCakR+n9TDDfw/8SpJqHS9qyNIh7Kh4EHFr2eC6vBozbqaF
   u16Jhe1bhqnbqlC8bSd2o0PjX2axMYK4FKUKNAaPP/IbzPQ78Tb0PI95W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="18775046"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="18775046"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 06:30:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="903834477"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="903834477"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 06:30:25 -0800
Received: from [10.209.154.172] (carsonde-mobl1.amr.corp.intel.com [10.209.154.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id D9B35580BF8;
	Thu,  4 Jan 2024 06:30:23 -0800 (PST)
Message-ID: <8af821dc-d173-483d-8b69-b8e041538561@linux.intel.com>
Date: Thu, 4 Jan 2024 09:30:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] perf vendor events intel: Alderlake/rocketlake
 metric fixes
Content-Language: en-US
To: Ian Rogers <irogers@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Edward Baker <edward.baker@intel.com>
References: <20240104074259.653219-1-irogers@google.com>
 <ZZam-EG-UepcXtWw@kernel.org>
 <CAP-5=fV+U4qSwU8nqHJMgAZTwtWs9jEm3i9yDQSVtq9Fbos5HA@mail.gmail.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fV+U4qSwU8nqHJMgAZTwtWs9jEm3i9yDQSVtq9Fbos5HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-01-04 8:56 a.m., Ian Rogers wrote:
>> Testing tma_slow_pause
>> Metric 'tma_slow_pause' not printed in:
>> # Running 'internals/synthesize' benchmark:
>> Computing performance of single threaded perf event synthesis by
>> synthesizing events on the perf process itself:
>>   Average synthesis took: 49.987 usec (+- 0.049 usec)
>>   Average num. events: 47.000 (+- 0.000)
>>   Average time per event 1.064 usec
>>   Average data synthesis took: 53.490 usec (+- 0.033 usec)
>>   Average num. events: 245.000 (+- 0.000)
>>   Average time per event 0.218 usec
>>
>>  Performance counter stats for 'perf bench internals synthesize':
>>
>>      <not counted>      cpu_core/TOPDOWN.SLOTS/                                                 (0.00%)
>>      <not counted>      cpu_core/topdown-retiring/                                              (0.00%)
>>      <not counted>      cpu_core/topdown-mem-bound/                                             (0.00%)
>>      <not counted>      cpu_core/topdown-bad-spec/                                              (0.00%)
>>      <not counted>      cpu_core/topdown-fe-bound/                                              (0.00%)
>>      <not counted>      cpu_core/topdown-be-bound/                                              (0.00%)
>>      <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/                                        (0.00%)
>>      <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/                                        (0.00%)
>>      <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/                                        (0.00%)
>>      <not counted>      cpu_core/CPU_CLK_UNHALTED.PAUSE/                                        (0.00%)
>>      <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/                                        (0.00%)
>>      <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/                                        (0.00%)
>>      <not counted>      cpu_core/ARITH.DIV_ACTIVE/                                              (0.00%)
>>      <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=0xc/                                        (0.00%)
>>      <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=0x80/                                        (0.00%)
>>
>>        1.186254766 seconds time elapsed
>>
>>        0.427220000 seconds user
>>        0.752217000 seconds sys
>> Testing smi_cycles
>> Testing smi_num
>> Testing tsx_aborted_cycles
>> Testing tsx_cycles_per_elision
>> Testing tsx_cycles_per_transaction
>> Testing tsx_transactional_cycles
>> test child finished with -1
>> ---- end ----
>> perf all metrics test: FAILED!
>> root@number:~#
> Have a try disabling the NMI watchdog. Agreed that there is more to
> fix here but I think the PMU driver is in part to blame because
> manually breaking the weak group of events is a fix. 

I think we have a NO_GROUP_EVENTS_NMI metric constraint to mark a group
which require disabling of the NMI watchdog.
Maybe we should mark the group a NO_GROUP_EVENTS_NMI metric.

Thanks,
Kan

> Fwiw, if we
> switch to the buddy watchdog mechanism then we'll no longer need to
> disable the NMI watchdog:
> https://lore.kernel.org/lkml/20230421155255.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid/

