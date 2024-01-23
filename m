Return-Path: <linux-kernel+bounces-35067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43601838B6A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991C928B539
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B1A5A10B;
	Tue, 23 Jan 2024 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hcWoL8am"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA26F57311;
	Tue, 23 Jan 2024 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706004566; cv=none; b=ITrHGs3cLEQyKfReS0JV02kyRTsX/AiVp93W/BMjjyJugxsuGsvf9W7dWRby8eApbdW2pw3Hrr3kBSXAeaGLNshgnk0DVJ9pcYdDbe1qqQjGcyE6AsMm4yVgh/Tc9UjC5YSOowPVP2vhRXo0d2r2jQymXW62H3aATbGcz7+Z1jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706004566; c=relaxed/simple;
	bh=TCFdDzZ1US12cf3hVKANXZoZ8oTrIUTJBaYWeEq0Gbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQWGKhK3QMjyfiYJa3qSCnkHmNkmyUWYbluYxwgdKlWFJq8oG1zMPEHQPyqJoVg6sjhLYaag4oPDwjw/896EZOJih3o2fsYn22mAMK5ddZs0FfamRJ/o1/m23Fg/lOWjuEBPkY8sH5DOJZ4r5Q0LUkcrYl8/S6bpwUE7V/CYSaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hcWoL8am; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706004565; x=1737540565;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TCFdDzZ1US12cf3hVKANXZoZ8oTrIUTJBaYWeEq0Gbk=;
  b=hcWoL8am29p3l0UI27UMbBywRYReLzkqokuV8go2hVXLwr1VlQo4iYCC
   DXBasNiHtQKCzWChoGxEFOq1dpB7p/17HYrg3geIvvHN1pxA5wBQcPamc
   00LyGlc/rSkUsukmZj7vC/AsQQMwGhgRH7mXG8kzkWCnb/telDpMTyPhg
   FcULmZW1M02GQFzn+SoMKL+K3sSNuC7u6Z2pgH7gJFf3pmlW7FQPkVd7J
   ukVVv8tIZih7qBPp9Lxfs/D9g6R+FqQELZpvlj48CQAPoRLQX/DkEjjyB
   k5pEQctmRmepFEWAw6pLJCWn4FE0U8JcUCatFGWe508fXFPbQKGe/vgpL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8588455"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="8588455"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 02:09:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="929291718"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="929291718"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.57.4])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 02:09:18 -0800
Message-ID: <1d0e2e26-723f-42bf-b4a5-8a56843d8dda@intel.com>
Date: Tue, 23 Jan 2024 12:09:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 01/11] perf/core: Add aux_pause, aux_resume,
 aux_start_paused
Content-Language: en-US
To: Namhyung Kim <namhyung@kernel.org>
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
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20240111081914.3123-1-adrian.hunter@intel.com>
 <20240111081914.3123-2-adrian.hunter@intel.com>
 <CAM9d7cjOVuMdBjLBV0cKXAOMmp_6xQYBG7h2ecE=djEKZm8aNQ@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7cjOVuMdBjLBV0cKXAOMmp_6xQYBG7h2ecE=djEKZm8aNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/01/24 23:40, Namhyung Kim wrote:
> On Thu, Jan 11, 2024 at 12:19 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> Hardware traces, such as instruction traces, can produce a vast amount of
>> trace data, so being able to reduce tracing to more specific circumstances
>> can be useful.
>>
>> The ability to pause or resume tracing when another event happens, can do
>> that.
>>
>> Add ability for an event to "pause" or "resume" AUX area tracing.
>>
>> Add aux_pause bit to perf_event_attr to indicate that, if the event
>> happens, the associated AUX area tracing should be paused. Ditto
>> aux_resume. Do not allow aux_pause and aux_resume to be set together.
>>
>> Add aux_start_paused bit to perf_event_attr to indicate to an AUX area
>> event that it should start in a "paused" state.
>>
>> Add aux_paused to struct perf_event for AUX area events to keep track of
>> the "paused" state. aux_paused is initialized to aux_start_paused.
>>
>> Add PERF_EF_PAUSE and PERF_EF_RESUME modes for ->stop() and ->start()
>> callbacks. Call as needed, during __perf_event_output(). Add
>> aux_in_pause_resume to struct perf_buffer to prevent races with the NMI
>> handler. Pause/resume in NMI context will miss out if it coincides with
>> another pause/resume.
>>
>> To use aux_pause or aux_resume, an event must be in a group with the AUX
>> area event as the group leader.
>>
>> Example (requires Intel PT and tools patches also):
>>
>>  $ perf record --kcore -e intel_pt/aux-action=start-paused/k,syscalls:sys_enter_newuname/aux-action=resume/,syscalls:sys_exit_newuname/aux-action=pause/ uname
>>  Linux
>>  [ perf record: Woken up 1 times to write data ]
>>  [ perf record: Captured and wrote 0.043 MB perf.data ]
>>  $ perf script --call-trace
>>  uname   30805 [000] 24001.058782799: name: 0x7ffc9c1865b0
>>  uname   30805 [000] 24001.058784424:  psb offs: 0
>>  uname   30805 [000] 24001.058784424:  cbr: 39 freq: 3904 MHz (139%)
>>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])        debug_smp_processor_id
>>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])        __x64_sys_newuname
>>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])            down_read
>>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                __cond_resched
>>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                preempt_count_add
>>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                    in_lock_functions
>>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                preempt_count_sub
>>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])            up_read
>>  uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                preempt_count_add
>>  uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                    in_lock_functions
>>  uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                preempt_count_sub
>>  uname   30805 [000] 24001.058784838: ([kernel.kallsyms])            _copy_to_user
>>  uname   30805 [000] 24001.058784838: ([kernel.kallsyms])        syscall_exit_to_user_mode
>>  uname   30805 [000] 24001.058784838: ([kernel.kallsyms])            syscall_exit_work
>>  uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                perf_syscall_exit
>>  uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                    debug_smp_processor_id
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                    perf_trace_buf_alloc
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        perf_swevent_get_recursion_context
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            debug_smp_processor_id
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        debug_smp_processor_id
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                    perf_tp_event
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        perf_trace_buf_update
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            tracing_gen_ctx_irq_test
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        perf_swevent_event
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            __perf_event_account_interrupt
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                __this_cpu_preempt_check
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            perf_event_output_forward
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                perf_event_aux_pause
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                    ring_buffer_get
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                        __rcu_read_lock
>>  uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                        __rcu_read_unlock
>>  uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                    pt_event_stop
>>  uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                        debug_smp_processor_id
>>  uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                        debug_smp_processor_id
>>  uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                        native_write_msr
>>  uname   30805 [000] 24001.058785463: ([kernel.kallsyms])                                        native_write_msr
>>  uname   30805 [000] 24001.058785639: 0x0
> 
> Looks great!  I think this is very similar to what Kees asked in
> 
>   https://lore.kernel.org/linux-perf-users/202401091452.B73E21B6C@keescook/

Sometimes a precisely-defined workload is needed, just so that
running it repeatedly does not produce results that vary too much
to tell whether one software version is better than another.

> 
> I have a couple of basic questions:
>  * Can we do that for regular events too?

That would be much more complicated.  The current implementation
can only pause / resume 1 event, the group leader, and it has to
be supported by the PMU callbacks.

>  * What's the difference between start/stop and pause/resume?
>    (IOW can we do that just using start/stop callbacks?)

It is using start / stop callbacks, albeit with a different mode
parameter.  However pause / resume is not allowed unless the event
has been started and not stopped, so it is a different state.

> 
> Actually I was thinking about dropping samples using a BPF filter
> outside the target scope (e.g. a syscall) but it'd be nice if we can
> have builtin support for that.

In general, I would have thought that capturing samples does not
produce so much data that it cannot be filtered in post-processing.
Looking at the email thread from above, that seems to be what
Arnaldo has proposed.

AUX area tracing is different in this regard.  Intel PT can produce
more trace data than can be written out in time, so data will be
lost for large traces.  Also post-processing takes a long time, so
less data captured helps a lot there also.


