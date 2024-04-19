Return-Path: <linux-kernel+bounces-151632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B5C8AB15D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC28D28301A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD4A12FB36;
	Fri, 19 Apr 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RToVLT56"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FD712F581;
	Fri, 19 Apr 2024 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539381; cv=none; b=nZKsCV1j/y2zupJLOgbgGq4MEGua2SUm7jihvPnuux8bnZctIs+cQpc6meLcY1IgwSx2x5LKR4RZHYxDO6MeoA0hfc9TsN0kOh4qkwgNDPJ6C9lzqahmYGAacNqQpIIbZ7R+l7c5V2EU1qaIC8JP/xJppI4w9YCDjXd16sZxZn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539381; c=relaxed/simple;
	bh=6XJk3rY1qJPoYVECXyqmHyYKd9afGqEIIO3a1qlmLb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEpJ8HjbUNu9LMuPL8pVoHeCR/996R90Ml09SFb+F9w5f1dm5v+90rS4dYjfs2/H2OUKABPeweYF5/OSs6+SACnGCQFfO9V4tSdgwYAXpTsprJGRq2pISZYiaCXaJYK0JiMxlb6NTneLYMH2r7imsMHFfQnWD1kezhBjDS+/pKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RToVLT56; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713539379; x=1745075379;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6XJk3rY1qJPoYVECXyqmHyYKd9afGqEIIO3a1qlmLb0=;
  b=RToVLT56jA7pGBEf/PXAN+EZn1oviNJUVFTraSDCz8DaoZ0LAtkDkMwD
   FyunP+am+TsxzYGmx0QI4GHhP9F9dHQ8NsMdkNvcG1jN0Xwp7L1iEKTey
   cpIK8csYdw+LJ6tYOZu4qtbJiA3z9om9QnxGPVNBFl56Eqedoj0IBmA6p
   M7X3C2jw8v5Ij7esgah7o/WSWhvNo++0S16QQf2bwrnxMmtGGNnLRRbSX
   PEgJRRBH38twwxFPXmP3Ne5tjbofXZXtqoSUpt/iF3QoqAJuIKAl5vNjE
   eOAKOLFwbt0fs+K2QxinRLLnEU2fnhOCkZ1MdZG5eIoh2OnBOr9uAXHUk
   g==;
X-CSE-ConnectionGUID: 5augMNOoS76gvXVFywGmyA==
X-CSE-MsgGUID: ptomYrMDR4WUs3Snpk486A==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="20535966"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="20535966"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 08:09:38 -0700
X-CSE-ConnectionGUID: sbqfLeqBQ4yTveVA/vBecw==
X-CSE-MsgGUID: E2HlNsXSQJKu6lxl3xCjhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="46639192"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 08:09:38 -0700
Received: from [10.212.13.6] (kliang2-mobl1.ccr.corp.intel.com [10.212.13.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id C3D10206DFDC;
	Fri, 19 Apr 2024 08:09:35 -0700 (PDT)
Message-ID: <b48c2040-7ee9-40a4-a97e-54bcb82cfc3e@linux.intel.com>
Date: Fri, 19 Apr 2024 11:09:34 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test: Avoid hard coded metrics in stat std output
 test
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240417183219.1208493-1-irogers@google.com>
 <c68bf005-af20-4995-86d5-a62e171763e3@linux.intel.com>
 <CAP-5=fUG_b6e9Q=qMFMtuKpzvz7D1xoLXNxeyfqwyX8qSsBwsg@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUG_b6e9Q=qMFMtuKpzvz7D1xoLXNxeyfqwyX8qSsBwsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-04-19 10:40 a.m., Ian Rogers wrote:
> On Fri, Apr 19, 2024 at 6:54 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-04-17 2:32 p.m., Ian Rogers wrote:
>>> Hard coded metric names fail on ARM testing.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/tests/shell/stat+std_output.sh | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
>>> index cbf2894b2c84..845f83213855 100755
>>> --- a/tools/perf/tests/shell/stat+std_output.sh
>>> +++ b/tools/perf/tests/shell/stat+std_output.sh
>>> @@ -13,7 +13,7 @@ stat_output=$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
>>>
>>>  event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions branches branch-misses)
>>>  event_metric=("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "frontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "of all branches")
>>> -skip_metric=("stalled cycles per insn" "tma_" "retiring" "frontend_bound" "bad_speculation" "backend_bound")
>>> +skip_metric=($(perf list --raw Default 2> /dev/null))
>>
>>
>> The "perf list --raw Default" only gives the topdown metrics.
>> The "stalled cycles per insn" is not covered.
>> The check should skip the line of "stalled cycles per insn" as well.
>>
>>      3,856,436,920 stalled-cycles-frontend   #   74.09% frontend cycles idle
>>      1,600,790,871 stalled-cycles-backend    #   30.75% backend  cycles idle
>>      2,603,501,247 instructions              #    0.50  insns per cycle
>>                                              #    1.48  stalled cycles
>> per insn
>>        484,357,498 branches                  #  283.455 M/sec
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/builtin-stat.c#n24
>>
>> The newer Intel CPU doesn't have the stalled-cycles-* events. But it
>> seems power and older x86 CPU have the events.
> 
> Oh, sigh. This test should really ignore lines like that. How much do
> we care about these metrics? The RISC-V event parsing change:
> https://lore.kernel.org/lkml/20240416061533.921723-1-irogers@google.com/
> means that legacy hardware events will be uncommon and we need to
> adapt the hard coded metrics in stat-shadow.c to json ones. Once they
> are json metrics they will be in Default.

It seems except the newer Intel CPU, all the other ARCHs support the two
stalled-cycles-* events and the metric. For Intel, there are Topdown
metrics. But it seems an important metrics for the other ARCHs.

RISC-V
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/riscv_pmu_sbi.c#n134
Power
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/perf/power9-pmu.c#n279
Arm
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/arm_pmuv3.c#n53

So almost all json files have to be updated. I'm not sure if it's a
practical way to fix the issue.

Thanks,
Kan
> 
> Thanks,
> Ian
> 
>> Thanks,
>> Kan
>>
>>>
>>>  cleanup() {
>>>    rm -f "${stat_output}"
> 

