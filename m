Return-Path: <linux-kernel+bounces-27373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD4D82EEDC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70357B233D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4EF1BC47;
	Tue, 16 Jan 2024 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1oun1bk"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF52B1B97C;
	Tue, 16 Jan 2024 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705407753; x=1736943753;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LzEFqIDkEf+pL1vSvs+eYDMky2CkT9z1U+TPoNwWcj0=;
  b=h1oun1bkZ5uaQOirPhUVU93/8mQgFD08qJmGqnoIIt/5IngOtDCq9jO4
   iSH7XC0brURoOQHSYpB+XJeTZpl4xPw86GFVkHKBVmgXv/KprqOqBVcA1
   LEMc1bmkeslB27TSQJ7oYIQzLj6YxWbFTgNvLhdXgZj6ebm+DOBfwwKq0
   0g1pUaPPtbxwJZyu4wKOQ5Dd+hBARxXZf5yqHd24a4EOJjbnFV7dDb8s7
   i0gW67tHXoIsAz+cW7+YDUep+XCA4DbrTWNRcvzQC1I3qQeTC9l3xSO+G
   GQvNQnwycnmkFCfwvB7klBE8PpqtnvQ53v6wibY/FH+SezRVUI69BaXSh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="466227537"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="466227537"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 04:22:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="760164094"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="760164094"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.38.159])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 04:22:27 -0800
Message-ID: <60cc9fa8-e714-41d0-a82d-9c8a54dfde4e@intel.com>
Date: Tue, 16 Jan 2024 14:22:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 10/11] perf intel-pt: Add documentation for pause /
 resume
Content-Language: en-US
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
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
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240111081914.3123-1-adrian.hunter@intel.com>
 <20240111081914.3123-11-adrian.hunter@intel.com>
 <87ply1lebh.fsf@linux.intel.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <87ply1lebh.fsf@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/24 13:15, Andi Kleen wrote:
> Adrian Hunter <adrian.hunter@intel.com> writes:
>> +
>> +For example, to trace only the uname system call (sys_newuname) when running the
>> +command line utility uname:
>> +
>> + $ perf record --kcore -e
>> intel_pt/aux-action=start-paused/k,syscalls:sys_enter_newuname/aux-action=resume/,syscalls:sys_exit_newuname/aux-action=pause/
>> uname
> 
> It's unclear if the syntax works for hardware break points, kprobes, uprobes too?

Yes, the perf tool syntax requires only that the group leader is
an AUX area event like intel_pt.  Note that an attempt is made to
automatically group AUX area events with events with aux-action,
so grouping syntax like '{...}' is not always necessary.

Note the current kernel implementation is called from
__perf_event_output() which is used in nearly all cases for the
output of samples, the exceptions being Intel BTS (which we do not
support at the same time as Intel PT, but wouldn't make much sense
anyway) and S390 cpumsf_output_event_pid().

> That would be most useful. If it works would be good to add examples for it.

OK


