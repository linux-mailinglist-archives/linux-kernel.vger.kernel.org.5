Return-Path: <linux-kernel+bounces-160323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4718B3BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC9F1F24E42
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343FF159905;
	Fri, 26 Apr 2024 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBA/Tvqu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6669B152511;
	Fri, 26 Apr 2024 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146174; cv=none; b=MuwE7Z0PWiM0xkERbOhmFjYdpCTLa8L1d7kGgu/YgN22uxt5SPdwLGrE/AEflKiphbly5RBB+kNGkv6Yasr+XsfHfTrQffYxFDqSxE8gmQMFklqYrlktMjqUVUfArkdOtJ2Meqllyz3V17V5jxqNDnscwIBq8hZfrrdfE4YTpvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146174; c=relaxed/simple;
	bh=ueeUrsIiAG14vTTLhDQ1O9R7Z7uj5nbKhdqR2+RXD98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2sFQxrmJgnc3vuumLn8lY7GgCkWetOsTjP+VEXr84qJljGj3I2/ql/mECGFYx0aLBWB5K0jGWWUx0j/RcOWwPZ4sB4OzOZkaSrZnh8yixbzvB1Rty900qXngz+aCDppc+p9uhKPwGcWRnPjEMU1sANmlIuG/o+pnY/aB8EFGQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBA/Tvqu; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714146172; x=1745682172;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ueeUrsIiAG14vTTLhDQ1O9R7Z7uj5nbKhdqR2+RXD98=;
  b=DBA/TvquccgGRDMzYst8CugXYbBCj1pURNAVzFS89QlQp29G/ph3ia5s
   HWZue20rWNhYXULkFM49QNtpiGw7LIsmqyN7AtUnt1A0lEc9YQOGxzIgU
   /aojzH83/MtRQg7NwbcyE7TqGhhh/SBACeu6y4RdksI9HBqZKlzn6wEug
   sIQ3Y8+VjxwPbeEMBvD/oWKqCkB3izLE/JVPGNfJBYQxTvHxikZXEGEPd
   +3UhlJ/lWD0QN7IVC+FOH+jUzJxmrd7cvo1e7GFd/Q6FnQ6apylyqu6d2
   9Z82o9ffRG43GjZKpNZKxihnhCykrZuKaPe26ftZk6wKuNE0dRYiYocp4
   g==;
X-CSE-ConnectionGUID: Jd7O79KaTa6niekOw/4ezA==
X-CSE-MsgGUID: LyOF454PQPO4iUykURwdEQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="20496907"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="20496907"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 08:42:51 -0700
X-CSE-ConnectionGUID: kHMK1tv9RcOh0Or3oQbuQQ==
X-CSE-MsgGUID: wBEdFSLiQmW3uQJOUb62fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="25533130"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.48.22])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 08:42:49 -0700
Message-ID: <88b460e5-ef2f-4b2f-a173-deac34c99788@intel.com>
Date: Fri, 26 Apr 2024 18:42:42 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf tests: Run tests in parallel by default
To: James Clark <james.clark@arm.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240301174711.2646944-1-irogers@google.com>
 <3e54fea7-2a37-4774-8a6a-85f75cc4a9ea@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <3e54fea7-2a37-4774-8a6a-85f75cc4a9ea@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/04/24 18:06, James Clark wrote:
> 
> 
> On 01/03/2024 17:47, Ian Rogers wrote:
>> Switch from running tests sequentially to running in parallel by
>> default. Change the opt-in '-p' or '--parallel' flag to '-S' or
>> '--sequential'.
>>
>> On an 8 core tigerlake an address sanitizer run time changes from:
>> 326.54user 622.73system 6:59.91elapsed 226%CPU
>> to:
>> 973.02user 583.98system 3:01.17elapsed 859%CPU
>>
>> So over twice as fast, saving 4 minutes.
>>
> 
> Apologies for not replying earlier before this was applied. But IMO this
> isn't a good default. Tests that use things like exclusive PMUs
> (Coresight for example) can never pass when run in parallel.

Yes, that is an issue for Intel PT also.

> 
> For CI it's arguable whether you'd want to trade stability for speed.
> And for interactive sessions there was already the --parallel option
> which was easy to add and have it in your bash history.
> 
> Now we've changed the default, any CI will need to be updated to add
> --sequential if it wants all the tests to pass.

Same here.

>                                                 Maybe we could do some
> hack and gate it on interactive vs non interactive sessions, but that
> might be getting too clever. (Or a "don't run in parallel" flag on
> certain tests)

Perhaps more attention is needed for the tests that take so long.
For example, maybe they could do things in parallel.

Also -F option doesn't seem to work.

$ tools/perf/perf test -F
Couldn't find a vmlinux that matches the kernel running on this machine, skipping test
  1: vmlinux symtab matches kallsyms                                 : Skip
  2: Detect openat syscall event                                     : Ok
  3: Detect openat syscall event on all cpus                         : Ok
  4.1: Read samples using the mmap interface                         : Ok
  4.2: User space counter reading of instructions                    : Ok
  4.3: User space counter reading of cycles                          : Ok
  5: Test data source output                                         : Ok
WARNING: event 'numpmu' not valid (bits 16-17,20,22 of config '6530160' not supported by kernel)!
  6.1: Test event parsing                                            : Ok
  6.2: Parsing of all PMU events from sysfs                          : Ok
WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not supported by kernel)!
  6.3: Parsing of given PMU events from sysfs                        : Ok
  6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
  6.5: Parsing of aliased events                                     : Ok
  6.6: Parsing of terms (event modifiers)                            : Ok
  7: Simple expression parser                                        : Ok
  8: PERF_RECORD_* events & perf_sample fields                       : Ok
  9: Parse perf pmu format                                           : Ok
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
failed: recursion detected for M1
failed: recursion detected for M2
failed: recursion detected for M3
Not grouping metric tma_memory_fence's events.
Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric constraint:
    echo 0 > /proc/sys/kernel/nmi_watchdog
    perf stat ...
    echo 1 > /proc/sys/kernel/nmi_watchdog
Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric constraint:
    echo 0 > /proc/sys/kernel/nmi_watchdog
    perf stat ...
    echo 1 > /proc/sys/kernel/nmi_watchdog
..
^C



