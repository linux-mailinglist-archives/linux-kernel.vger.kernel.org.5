Return-Path: <linux-kernel+bounces-160280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BCE8B3B52
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68281C2133B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B72E156F36;
	Fri, 26 Apr 2024 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mo097RvY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440341494A6;
	Fri, 26 Apr 2024 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145063; cv=none; b=bUPaPeOtLUj96z0t+A3qJ0vtV2ZX32d5vsxMGaQlbn2JNOMjLNVIDsUtvD3C0TQ/bOkfkF9XNcsKUA83S/9e3z7YQIRVOXdi/+re0ffYqW6pkId7GnQbCbEeW+fwDP88CfUna2/tEqHWmBVAxPuHak26xrLZhuE0ErLiCXg0VB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145063; c=relaxed/simple;
	bh=42Y1zaqOMNGtZMWNMkTmdYkjtCgbc79W1SrHaNbmoks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u7lnDgdWOBOrRkxpk4Dly/5e7QK5bp3oYznWlDj94KMicC1gFJmkYx9JYNiKSV36fxAOQH3WOl8wWZuyOZE7ZoZzWbyTiQHzA9ulDY5YP9RsVkmBsK6ZRjC1/WCwP5E5YLLE3RiEx8YxeOVZcRyUJF3gEuIbWpvudY+U4grLR7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mo097RvY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714145061; x=1745681061;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=42Y1zaqOMNGtZMWNMkTmdYkjtCgbc79W1SrHaNbmoks=;
  b=mo097RvYLxE4JZsm8ySELQW/Ezrh6rUPV4GKfnUktOf999IoPm2tACbn
   j6zaNmbX4Nch6Q2d6ewbUX42MYqMRj9dzuTHwag/ZEN3jP2JanyVVn6fv
   r2Y125jvffEJG0xkhapZyw0Oi6b/uDdRJPG6asl/gXY30W4WcgcK+GECt
   7H7KpL6zeIiS51+PhE5vUfXAYeTZIWo3NGkHiPg7EQhbucpNBBSuBWN62
   GtudZdWCMQy72Z/YXi/VHl24QFuzIaZCdR/ZuMa3qvSso0shu32oNRrMx
   hMr74xav9F4pLR6CS5sUd1jf2Poh28ho076dByueIyjy2qhvlZSwmRpap
   g==;
X-CSE-ConnectionGUID: LswWAKRtQAigzHqU3S+XHg==
X-CSE-MsgGUID: nAmUWhzERr+fy3TULGi3jA==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="9735025"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="9735025"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 08:24:20 -0700
X-CSE-ConnectionGUID: a7khFoWfRY2fnk3XswJp8A==
X-CSE-MsgGUID: sq3zv2njQhinJjnPwoTh3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="62927681"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.48.22])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 08:24:18 -0700
Message-ID: <1e2bee89-0a4a-42e3-9f81-bd7296cfb351@intel.com>
Date: Fri, 26 Apr 2024 18:24:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] perf scripts python: Add a script to run instances of
 perf script in parallel
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240423133248.10206-1-adrian.hunter@intel.com>
 <ZihFYbdrnarNFWOd@tassilo> <ZikT69GIsijZajoI@x1> <ZiuiiFdPhJIrjI7k@x1>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZiuiiFdPhJIrjI7k@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/04/24 15:48, Arnaldo Carvalho de Melo wrote:
> On Wed, Apr 24, 2024 at 11:15:11AM -0300, Arnaldo Carvalho de Melo wrote:
>> On Tue, Apr 23, 2024 at 04:33:53PM -0700, Andi Kleen wrote:
>>> On Tue, Apr 23, 2024 at 04:32:48PM +0300, Adrian Hunter wrote:
>>>> The script is useful for Intel PT traces, that can be efficiently
>>>> decoded by perf script when split by CPU and/or time ranges. Running
>>>> jobs in parallel can decrease the overall decoding time.
> 
>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
>>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> 
>> Thanks, applied, and added a note on testing it using:
> 
> Plus this, please check.
> 
> Committer testing:
> 
>   Ian reported that shellcheck found some issues, I installed it as there
>   are no warnings about it not being available, but when available it
>   fails the build with:
> 
>     TEST    /tmp/build/perf-tools-next/tests/shell/script.sh.shellcheck_log
>     CC      /tmp/build/perf-tools-next/util/header.o
> 
>   In tests/shell/script.sh line 20:
>                   rm -rf "${temp_dir}/"*
>                          ^-------------^ SC2115 (warning): Use "${var:?}" to ensure this never expands to /* .
> 
> 
>   In tests/shell/script.sh line 83:
>           output1_dir="${temp_dir}/output1"
>           ^---------^ SC2034 (warning): output1_dir appears unused. Verify use (or export if used externally).
> 
> 
>   In tests/shell/script.sh line 84:
>           output2_dir="${temp_dir}/output2"
>           ^---------^ SC2034 (warning): output2_dir appears unused. Verify use (or export if used externally).
> 
> 
>   In tests/shell/script.sh line 86:
>           python3 "${pp}" -o "${output_dir}" --jobs 4 --verbose -- perf script -i "${perf_data}"
>                               ^-----------^ SC2154 (warning): output_dir is referenced but not assigned (did you mean 'output1_dir'?).
> 
>   For more information:
>     https://www.shellcheck.net/wiki/SC2034 -- output1_dir appears unused. Verif...
>     https://www.shellcheck.net/wiki/SC2115 -- Use "${var:?}" to ensure this nev...
>     https://www.shellcheck.net/wiki/SC2154 -- output_dir is referenced but not ...
> 
> Did these fixes:
> 
>   -               rm -rf "${temp_dir}/"*
>   +               rm -rf "${temp_dir:?}/"*
> 
> And:
> 
>    @@ -83,8 +83,8 @@ test_parallel_perf()
>           output1_dir="${temp_dir}/output1"
>           output2_dir="${temp_dir}/output2"
>           perf record -o "${perf_data}" --sample-cpu uname
>   -       python3 "${pp}" -o "${output_dir}" --jobs 4 --verbose -- perf script -i "${perf_data}"
>   -       python3 "${pp}" -o "${output_dir}" --jobs 4 --verbose --per-cpu -- perf script -i "${perf_data}"
>   +       python3 "${pp}" -o "${output1_dir}" --jobs 4 --verbose -- perf script -i "${perf_data}"
>   +       python3 "${pp}" -o "${output2_dir}" --jobs 4 --verbose --per-cpu -- perf script -i "${perf_data}"
> 

Sorry, didn't have shellcheck installed!

Looks good. The shellcheck page refers to bash for "${var:?}"
but it is POSIX too.


