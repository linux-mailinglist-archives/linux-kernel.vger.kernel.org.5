Return-Path: <linux-kernel+bounces-142015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C818A2634
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6C4DB244A4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AB7200D4;
	Fri, 12 Apr 2024 06:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bBmf5UVE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18F11BF24;
	Fri, 12 Apr 2024 06:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902089; cv=none; b=QA/LylP6eVV8YC3NC1Q43PO0clHNKhBC4QH2gmBTs0qepKHdCchTZDcFoWTzZFWDoKiYAqCNhpwnZuCrzVK4blwRWoL+AqO2LPY3Sq2gltGDFyWNWt1cdZtUFtgR0nZ5tZy0CzMxkmy69R2LoXOoKuR9Bo4P9q2sP0EuovZINN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902089; c=relaxed/simple;
	bh=7AS0uyUckK9jdmWhs9kJ6BR0ykSnUy0WjuTyWl8/ohE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFZ19KvIBUzw1vwI565OPZMpl/KcY/ukg1b/6744cLVW0f28uAb+gn1CgAUBxY35CNfE6PkyhxyhW7DB30NH/VM+XQXtg2qb4rfZg5h22BnHUlvABGCr+XCEfcqs4IGNATI2K2DcHwirN3cjZzXfiAnorbxi7l3ju6zDUv/xiwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBmf5UVE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712902087; x=1744438087;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7AS0uyUckK9jdmWhs9kJ6BR0ykSnUy0WjuTyWl8/ohE=;
  b=bBmf5UVEXmQmSPM5Dcdj3dFQ0GSFPhSDXCh2cIrZ7tt+8LEz97qIXWv1
   MEAkXcMEdIQYHyhwjj0detXhtWUExCg813H3uWguXt0kH8UHl9nW1xX0p
   hmy8AkMEISgNVb2r4yplCPkO7Gs8gLJQ7AtS5lU6gjgop6ubwIVwQo3/8
   9WzApqmIE/5WHPY76u4WLjFJ2fqNMWhv/wdLyqUSTGmBb/QjjOWLdRugO
   g8dAJN40heq1LYTZWEM2yn7RfaeLAelm0VhJOD7+eLoQskFz5tycdqE9u
   kE9ulSVIOCrT9gRR/1Xgj5c8L2bu27BFq7YMR7ScB1EOezt6NZJSDgsok
   Q==;
X-CSE-ConnectionGUID: NvC5Sz5UQj6656row//eJA==
X-CSE-MsgGUID: sp62JpVTQ+yz/L6TmHnxFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="18901351"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="18901351"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 23:08:06 -0700
X-CSE-ConnectionGUID: HAilMb0TRpqlpVwKICv0Hw==
X-CSE-MsgGUID: KcPwHYKjR2uqnY1qYhP0uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21195572"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.215.136])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 23:07:55 -0700
Message-ID: <3a238616-1fd0-4755-b7b7-fdc9c412fb03@intel.com>
Date: Fri, 12 Apr 2024 09:07:50 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] perf scripts python: Add a script to run instances of
 perf script in parallel
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20240313123634.4353-1-adrian.hunter@intel.com>
 <CAP-5=fW1bH8qQkD7LrO6_3fJ3NsqoW1GrX8=s-sfaTbrvk58+A@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fW1bH8qQkD7LrO6_3fJ3NsqoW1GrX8=s-sfaTbrvk58+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/04/24 21:19, Ian Rogers wrote:
> On Wed, Mar 13, 2024 at 5:36 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> Add a Python script to run a perf script command multiple times in
>> parallel, using perf script options --cpu and --time so that each job
>> processes a different chunk of the data.
>>
>> The script supports the use of normal perf script options like
>>  --dlfilter and --script, so that the benefit of running parallel jobs
>> naturally extends to them also. In addition, a command can be provided
>> (refer --pipe-to option) to pipe standard output to a custom command.
>>
>> Refer to the script's own help text at the end of the patch for more
>> details.
>>
>> The script is useful for Intel PT traces, that can be efficiently
>> decoded by perf script when split by CPU and/or time ranges. Running
>> jobs in parallel can decrease the overall decoding time.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>
>>
>> Changes in V2:
>>
>>         Added option to pipe to a custom command
>>         Added option to set a minimum time interval
>>         Minor tidying
>>
>>
>>  tools/perf/scripts/python/parallel-perf.py | 989 +++++++++++++++++++++
>>  1 file changed, 989 insertions(+)
>>  create mode 100755 tools/perf/scripts/python/parallel-perf.py
>>
>> diff --git a/tools/perf/scripts/python/parallel-perf.py b/tools/perf/scripts/python/parallel-perf.py
>> new file mode 100755
>> index 000000000000..8fe398f81a42
>> --- /dev/null
>> +++ b/tools/perf/scripts/python/parallel-perf.py
>> @@ -0,0 +1,989 @@
>> +#!/usr/bin/env python3
>> +# SPDX-License-Identifier: GPL-2.0
> 
> With the python summer of code proposal, that no-one applied to, I
> wanted to package things like a perf.data IO library in some public
> package index. As GPL 2 isn't permissive then we may need to
> reimplement this code because of this. Fwiw, my preference is
> GPL-2.0-only or BSD.

GPL-2.0 is GPL-2.0-only


