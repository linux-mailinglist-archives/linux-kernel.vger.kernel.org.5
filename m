Return-Path: <linux-kernel+bounces-140397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B83A28A13E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40940B2208B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BA014BF87;
	Thu, 11 Apr 2024 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lB2H0fd0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832E214B088;
	Thu, 11 Apr 2024 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836984; cv=none; b=H0puaORP9B9eWzvDiyg6M8pBJzLiVH+UsYGFjRCfbgRxn4ZdtHas6kfJ76XDQEnuF/PGUsvo19NCj5yw/40i/JTPZoBTkEdchVL5BseWe4PsoaLJeDNyERjWfzs3lo/qSHVTG+En79o9J01+cKy3gYxRO/cUMV/qP1Pzz4beec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836984; c=relaxed/simple;
	bh=w/vOEbMmfPknPax0PCVBUtjsTjwIaGY1cFmOJIdMJig=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GtqUtQ6L4zGRRWukcZ96bXEQf+4Y4/77PHSHWx4DnEJ7XUwUU5YsKJZW4u4nnFh2LgZ74ZwVd9eUveVojsGjEeewHSbdP2uhwqPheCyVxpnyx+hx2onYGvSMWHO3xDgP1tY387xWxyk4DskowXyCbFn2Rvh0/a7vifQziaVBulE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lB2H0fd0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712836983; x=1744372983;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=w/vOEbMmfPknPax0PCVBUtjsTjwIaGY1cFmOJIdMJig=;
  b=lB2H0fd0xfdHlmV0NLV7XH01Tke5jMWno9MWv49bzoxeXsliRz9PgTaP
   JhVIWr0J1dnglHUGBEajg2suu7wO+dFINQY4XEi++NCLNA1ZKb8OGmocH
   ZntbpYHCb5v6Hz96QG1N3YebFeKNwpifxEfe+0Ia31L8DylG1D5fBj0kZ
   EleEHCjxMO2UxXUdxrrdaIQ6Ip44scGc/GghXl3/HRtxfCD9Qww86Dd8r
   TSPWlwKk/HyAbMrsrDo4Kdgr3uN1EOxqLmoxCLoxOyGXMy1kyeJGOeps3
   EWsGbz9obEu+IjdfHy7uF1hzrY4W8/UhWyGLCRWFnFk7dpsH1zdGfdDxu
   w==;
X-CSE-ConnectionGUID: BMYvkezJR2i+qUG3P/KwvQ==
X-CSE-MsgGUID: jeZepP/RQKWTyOPDbcOkAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8093759"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8093759"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 05:03:02 -0700
X-CSE-ConnectionGUID: rI/AsT8zTZuYByDVI7n3KQ==
X-CSE-MsgGUID: +C8GXXHYTSa0xyIVMWtoog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20954700"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.215.66])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 05:02:56 -0700
Message-ID: <52f3abd2-4f75-4147-bc7b-c98960d9494b@intel.com>
Date: Thu, 11 Apr 2024 15:02:52 +0300
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
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240208113127.22216-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/02/24 13:31, Adrian Hunter wrote:
> Hi
> 
> Hardware traces, such as instruction traces, can produce a vast amount of
> trace data, so being able to reduce tracing to more specific circumstances
> can be useful.
> 
> The ability to pause or resume tracing when another event happens, can do
> that.
> 
> These patches add such a facilty and show how it would work for Intel
> Processor Trace.
> 
> Maintainers of other AUX area tracing implementations are requested to
> consider if this is something they might employ and then whether or not
> the ABI would work for them.  Note, thank you to James Clark (ARM) for
> evaluating the API for Coresight.  Suzuki K Poulose (ARM) also responded
> positively to the RFC.
> 
> Changes to perf tools are now (since V4) fleshed out.
> 
> 
> Changes in V5:
> 
>     perf/core: Add aux_pause, aux_resume, aux_start_paused
> 	Added James' Ack
> 
>     perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
> 	New patch
> 
>     perf tools
> 	Added Ian's Ack
> 
> Changes in V4:
> 
>     perf/core: Add aux_pause, aux_resume, aux_start_paused
> 	Rename aux_output_cfg -> aux_action
> 	Reorder aux_action bits from:
> 		aux_pause, aux_resume, aux_start_paused
> 	to:
> 		aux_start_paused, aux_pause, aux_resume
> 	Fix aux_action bits __u64 -> __u32
> 
>     coresight: Have a stab at support for pause / resume
> 	Dropped
> 
>     perf tools
> 	All new patches
> 
> Changes in RFC V3:
> 
>     coresight: Have a stab at support for pause / resume
> 	'mode' -> 'flags' so it at least compiles
> 
> Changes in RFC V2:
> 
> 	Use ->stop() / ->start() instead of ->pause_resume()
> 	Move aux_start_paused bit into aux_output_cfg
> 	Tighten up when Intel PT pause / resume is allowed
> 	Add an example of how it might work for CoreSight

Any more comments?


