Return-Path: <linux-kernel+bounces-20939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE0E8287A0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A43128674F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3C939AE4;
	Tue,  9 Jan 2024 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="laJdzEYA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F344639FF9;
	Tue,  9 Jan 2024 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704808912; x=1736344912;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QRtm/mna3beZbvd3P0MsywkRDxcn22Ksxbb0Rs/W1hw=;
  b=laJdzEYA/Kws7iwVoY5jCZC7EPi5DDiIR7Cf02PhK4kIrqppI5WKraHv
   skeKcjliiRUCmenGhQswBuGJGuDNlViALWmLKnXlTc9AeyVZMpvRmmRyt
   eeaaDWtMTMHzuwg9nHLsJYrb0md+kxEbe1AyTBx23hVCIWY6KzdB0Exoo
   O/kueysFZy+cbUu4bWjIQcrhH8Stjm4Ft/XHx/OWDLqlvVjCo2MQnLUYo
   PLvFW5JG1nmwTWCGndLH+yU1eJNXPTiy3+c865Snkx5zY3KLv2zomm57y
   6LlsW2TaZ7mcN55k2IHm4zP9xvx2fCrTQNgww4+ATufsrMdyNploOEMvS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5570616"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="5570616"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 06:01:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="23577791"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 06:01:50 -0800
Received: from [10.212.123.48] (unknown [10.212.123.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id B6C84580D28;
	Tue,  9 Jan 2024 06:01:47 -0800 (PST)
Message-ID: <1417fcb1-4d16-481b-b043-acf022de07fd@linux.intel.com>
Date: Tue, 9 Jan 2024 09:01:46 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/7] Clean up perf mem
To: Leo Yan <leo.yan@linaro.org>
Cc: acme@kernel.org, irogers@google.com, peterz@infradead.org,
 mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
 adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
 james.clark@arm.com, mike.leach@linaro.org, yuhaixin.yhx@linux.alibaba.com,
 renyu.zj@linux.alibaba.com, tmricht@linux.ibm.com, ravi.bangoria@amd.com,
 atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231213195154.1085945-1-kan.liang@linux.intel.com>
 <20240107040740.GA888@debian-dev>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240107040740.GA888@debian-dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-01-06 11:08 p.m., Leo Yan wrote:
> On Wed, Dec 13, 2023 at 11:51:47AM -0800, kan.liang@linux.intel.com wrote:
> 
> [...]
> 
>> Introduce generic functions perf_mem_events__ptr(),
>> perf_mem_events__name() ,and is_mem_loads_aux_event() to replace the
>> ARCH specific ones.
>> Simplify the perf_mem_event__supported().
>>
>> Only keeps the ARCH-specific perf_mem_events array in the corresponding
>> mem-events.c for each ARCH.
>>
>> There is no functional change.
>>
>> The patch set touches almost all the ARCHs, Intel, AMD, ARM, Power and
>> etc. But I can only test it on two Intel platforms.
>> Please give it try, if you have machines with other ARCHs.
>>
>> Here are the test results:
>> Intel hybrid machine:
>>
>> $perf mem record -e list
>> ldlat-loads  : available
>> ldlat-stores : available
>>
>> $perf mem record -e ldlat-loads -v --ldlat 50
>> calling: record -e cpu_atom/mem-loads,ldlat=50/P -e cpu_core/mem-loads,ldlat=50/P
>>
>> $perf mem record -v
>> calling: record -e cpu_atom/mem-loads,ldlat=30/P -e cpu_atom/mem-stores/P -e cpu_core/mem-loads,ldlat=30/P -e cpu_core/mem-stores/P
>>
>> $perf mem record -t store -v
>> calling: record -e cpu_atom/mem-stores/P -e cpu_core/mem-stores/P
>>
>>
>> Intel SPR:
>> $perf mem record -e list
>> ldlat-loads  : available
>> ldlat-stores : available
>>
>> $perf mem record -e ldlat-loads -v --ldlat 50
>> calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=50/}:P
>>
>> $perf mem record -v
>> calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=30/}:P -e cpu/mem-stores/P
>>
>> $perf mem record -t store -v
>> calling: record -e cpu/mem-stores/P
> 
> After applying this series, below tests pass with Arm SPE:
> 
> # ./perf c2c record -- /home/leoy/false_sharing.exe 2
> # ./perf c2c report
> 
> # ./perf mem record -e list
> # ./perf mem record -e spe-load -v --ldlat 50
> # ./perf mem record -v
> # ./perf mem report
> # ./perf mem record -t store -v
> # ./perf mem report
> 
> Tested-by: Leo Yan <leo.yan@linaro.org>
>

Thanks Leo.

Kan


