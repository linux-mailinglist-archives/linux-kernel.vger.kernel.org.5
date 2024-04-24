Return-Path: <linux-kernel+bounces-156736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E878B0778
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51381C22844
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE72159570;
	Wed, 24 Apr 2024 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDDUF+at"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC64158200;
	Wed, 24 Apr 2024 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955154; cv=none; b=s6msQ5xRQX1nce5kL4NpYxV9P/vB3BObmTkW3X/2fX1XtyAkcZXTSebM1okrcnQbKeqCum+96Q4UoHV80iAMUEMEfiJU85ZhUtFFGh2EN0m2/njszfHIiuWWcA/bD7sUymGhS9lDIzeA2cgsO7z+SQZ1h4cWlbBGMkVm8ERcmsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955154; c=relaxed/simple;
	bh=ic4AO+Elm5/i8oez5wDqDP2r2b8pMbypBYplKYgzygI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SZA02+AaGquAo7W7fro//kWdMLLgmTA9SrBF7O3bQoTWdu89YVNhst/AHV0j+JuSAjuYMWUv8vNNTZZexeSM4WZg2Kq/I5CA+FNEM04D/7Qi8XpbnhgnqeGgnOAzRfa/WIu0O3iIoux2n84fLsA/L7uDlx7Tbb1uR3f4kNPachA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDDUF+at; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713955153; x=1745491153;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=ic4AO+Elm5/i8oez5wDqDP2r2b8pMbypBYplKYgzygI=;
  b=fDDUF+atF6wpWQKweEl1Ob2WMufZAAr5X2zxIX8d70x7SvSAInyZPC0l
   Lb8uPobnriQyrq+i130VtKkAyKq4c3BXbQlUXrcf/rB7svAv8++5KNFrA
   UWhHwXJX8nul6mcBVLGNrxzFqAdH81KI6B1zYYhA8HiYZd8/CouKP08Jq
   yHw+SHnDzXU/3aIrAwko9NUKl3UXq8ho19OjHzXKepZ2Inw89D17AjAx0
   3O0fcWO9RX0dkiDLNFtJK7ZaamaGs5CJcBqcUsQpGDZTlO7hESzRCaBwD
   9ZfaYOD8PofBvG6LoC4m+0o8XkkUpKAnrVBWVZ7cmWgYKoF38aX3AOtMU
   A==;
X-CSE-ConnectionGUID: b6YIO8cVSiu7FYMJFZr5Kg==
X-CSE-MsgGUID: mXAgrAz4Tgar1lcC4y2ejA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="13365908"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="13365908"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 03:39:13 -0700
X-CSE-ConnectionGUID: VPP0IJMPTwuF3lfMsOqIUQ==
X-CSE-MsgGUID: aNUltn0LQlGz7s8AbV4/RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24713014"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.54])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 03:39:07 -0700
Message-ID: <1cb114be-9585-4f85-af9f-4bafb2d15d2a@intel.com>
Date: Wed, 24 Apr 2024 13:39:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 00/12] perf/core: Add ability for an event to "pause"
 or "resume" AUX area tracing
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon
 <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20240208113127.22216-1-adrian.hunter@intel.com>
 <52f3abd2-4f75-4147-bc7b-c98960d9494b@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <52f3abd2-4f75-4147-bc7b-c98960d9494b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/04/24 15:02, Adrian Hunter wrote:
> On 8/02/24 13:31, Adrian Hunter wrote:
>> Hi
>>
>> Hardware traces, such as instruction traces, can produce a vast amount of
>> trace data, so being able to reduce tracing to more specific circumstances
>> can be useful.
>>
>> The ability to pause or resume tracing when another event happens, can do
>> that.
>>
>> These patches add such a facilty and show how it would work for Intel
>> Processor Trace.
>>
>> Maintainers of other AUX area tracing implementations are requested to
>> consider if this is something they might employ and then whether or not
>> the ABI would work for them.  Note, thank you to James Clark (ARM) for
>> evaluating the API for Coresight.  Suzuki K Poulose (ARM) also responded
>> positively to the RFC.
>>
>> Changes to perf tools are now (since V4) fleshed out.
>>
>>
>> Changes in V5:
>>
>>     perf/core: Add aux_pause, aux_resume, aux_start_paused
>> 	Added James' Ack
>>
>>     perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
>> 	New patch
>>
>>     perf tools
>> 	Added Ian's Ack
>>
>> Changes in V4:
>>
>>     perf/core: Add aux_pause, aux_resume, aux_start_paused
>> 	Rename aux_output_cfg -> aux_action
>> 	Reorder aux_action bits from:
>> 		aux_pause, aux_resume, aux_start_paused
>> 	to:
>> 		aux_start_paused, aux_pause, aux_resume
>> 	Fix aux_action bits __u64 -> __u32
>>
>>     coresight: Have a stab at support for pause / resume
>> 	Dropped
>>
>>     perf tools
>> 	All new patches
>>
>> Changes in RFC V3:
>>
>>     coresight: Have a stab at support for pause / resume
>> 	'mode' -> 'flags' so it at least compiles
>>
>> Changes in RFC V2:
>>
>> 	Use ->stop() / ->start() instead of ->pause_resume()
>> 	Move aux_start_paused bit into aux_output_cfg
>> 	Tighten up when Intel PT pause / resume is allowed
>> 	Add an example of how it might work for CoreSight
> 
> Any more comments?
> 

Ping


