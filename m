Return-Path: <linux-kernel+bounces-146611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6704F8A6823
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6B1BB21DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BD0127B57;
	Tue, 16 Apr 2024 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWNKnT4U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DF3127B40
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262720; cv=none; b=n46WIl4U6FjCM6hXOo2LHEJaPlKHb7hnCAqMbJbcrbckMZoMH2IdvVQ5CXyorLKIGjPhh9bnx9CYAFSoFhdGrX8aZEz3wazAC6PKTFSr0u5SOYNzUznpKDROYwiybfajE21RJrDgwvFRHhvF+QIORkn7GoA4Q0LgrYIlutH1TXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262720; c=relaxed/simple;
	bh=c/hdg7IFl6g4RMrt0XpNJXHqc9aOnGHqeabzKYf9G1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gj4ecPeXlyHaUuN8PSLMs3XsfAXsG/5BPP40GNxrdwdXqpZforHa5WRWPkDcrM3WNEOXO55ZTGw4mKU6OkprnvbTxF00aSTbUNevQp3CHobqGcXeDqUBDFytmweAk/3Qgu51X19sapoy7pyu+HZUFY+rZvPlJvC1lfGiW3vwQ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWNKnT4U; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713262719; x=1744798719;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c/hdg7IFl6g4RMrt0XpNJXHqc9aOnGHqeabzKYf9G1k=;
  b=dWNKnT4UpieEcVwD8J4xNbKgjdlKMm0ERgp283QKVytbqINRHxNZWO8R
   Wu7AZzTX1Az1s9X9FbMnmek60Y+JobDav+7GCoXtmw+b5LzhwIYBIXb55
   pLsmkkj9FlLatqay2TXw7Yzo6F7eNoCXV446OwIpm5U670YOTnvY4WTzh
   eBWiLyDkEThhqLV6CKz0gl3JeQCApuzvGYC6cWofIJa2zzGuSKivK0dKR
   jd63qbyQKiA46AQJX+fApdZoJTzHLxdNdcQSqRgPfl+xawioQy3QlsDbv
   PK4QuhYVWc5dsD3qRyekah18hW0ZU45XgqFtIj+DJwCYugYz9IbNohoso
   g==;
X-CSE-ConnectionGUID: NQHHDTOVRaCs2rNCUXz10g==
X-CSE-MsgGUID: fgrknaRQQf6c3oZJ9tnRVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8855469"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8855469"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:18:39 -0700
X-CSE-ConnectionGUID: DS7/gA9nTAOsgY5OLxPwnw==
X-CSE-MsgGUID: qBGWO/5DR7yzpSOtsh6aFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22114286"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.239])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:18:35 -0700
Message-ID: <cb8ae96c-12a6-4945-96ed-7f68f01d69aa@intel.com>
Date: Tue, 16 Apr 2024 13:18:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip:timers/core] [timekeeping] e84f43e34f:
 BUG:KCSAN:data-race_in_timekeeping_advance/timekeeping_debug_get_ns
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, elver@google.com,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
References: <202404161050.38f1c92e-lkp@intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <202404161050.38f1c92e-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/04/24 09:27, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:KCSAN:data-race_in_timekeeping_advance/timekeeping_debug_get_ns" on:
> 
> commit: e84f43e34faf85816587f80594541ec978449d6e ("timekeeping: Consolidate timekeeping helpers")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git timers/core
> 
> [test failed on linux-next/master 9ed46da14b9b9b2ad4edb3b0c545b6dbe5c00d39]
> 
> in testcase: boot
> 
> compiler: gcc-13
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> we noticed this issue doesn't always happen on this commit (63 times out of
> 111 runs as below), however, parent keeps clean for this issue, but has other
> KCSAN:data-race issues which does not happen on e84f43e34f.
> 
> e8e9d21a5df655a6 e84f43e34faf85816587f805945
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>          16:60         -27%            :111   dmesg.BUG:KCSAN:data-race_in_ktime_get/timekeeping_advance
>           7:60         -12%            :111   dmesg.BUG:KCSAN:data-race_in_ktime_get_update_offsets_now/timekeeping_advance
>            :60         105%          63:111   dmesg.BUG:KCSAN:data-race_in_timekeeping_advance/timekeeping_debug_get_ns
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202404161050.38f1c92e-lkp@intel.com
> 
> 
> [  108.068027][    C1] BUG: KCSAN: data-race in timekeeping_advance / timekeeping_debug_get_ns
> [  108.069188][    C1]
> [  108.069511][    C1] write to 0xffffffff95672dc0 of 296 bytes by interrupt on cpu 0:
> [ 108.070559][ C1] timekeeping_advance (kernel/time/timekeeping.c:2207 (discriminator 1)) 
> [ 108.071242][ C1] update_wall_time (kernel/time/timekeeping.c:2222 (discriminator 1)) 
> [ 108.071883][ C1] tick_do_update_jiffies64 (kernel/time/tick-sched.c:149) 
> [ 108.072638][ C1] tick_nohz_handler (kernel/time/tick-sched.c:229 kernel/time/tick-sched.c:287) 
> [ 108.073235][ C1] __hrtimer_run_queues (kernel/time/hrtimer.c:1692 kernel/time/hrtimer.c:1756) 
> [ 108.073840][ C1] hrtimer_interrupt (kernel/time/hrtimer.c:1821) 
> [ 108.074430][ C1] __sysvec_apic_timer_interrupt (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1050) 
> [ 108.075132][ C1] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 (discriminator 2) arch/x86/kernel/apic/apic.c:1043 (discriminator 2)) 
> [ 108.075821][ C1] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
> [  108.076657][    C1]
> [  108.076982][    C1] read to 0xffffffff95672de0 of 8 bytes by interrupt on cpu 1:
> [ 108.077994][ C1] timekeeping_debug_get_ns (kernel/time/timekeeping.c:373 kernel/time/timekeeping.c:383 kernel/time/timekeeping.c:280) 

Looks like the nested seqlock in timekeeping_debug_get_ns()
results in premature kcsan_atomic_next(0), so the subsequent
access via timekeeping_cycles_to_ns(), although still under
seqlock, does not look that way to KCSAN.

> [ 108.078766][ C1] ktime_get (kernel/time/timekeeping.c:394 kernel/time/timekeeping.c:838) 
> [ 108.079325][ C1] tick_nohz_handler (kernel/time/tick-sched.c:220 kernel/time/tick-sched.c:287) 
> [ 108.079995][ C1] __hrtimer_run_queues (kernel/time/hrtimer.c:1692 kernel/time/hrtimer.c:1756) 
> [ 108.080740][ C1] hrtimer_interrupt (kernel/time/hrtimer.c:1821) 
> [ 108.081423][ C1] __sysvec_apic_timer_interrupt (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1050) 
> [ 108.082241][ C1] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 (discriminator 2) arch/x86/kernel/apic/apic.c:1043 (discriminator 2)) 
> [ 108.083014][ C1] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
> [  108.083849][    C1]
> [  108.084183][    C1] value changed: 0x000e771a64000000 -> 0x000e959ee4000000
> [  108.085518][    C1]
> [  108.085775][    C1] Reported by Kernel Concurrency Sanitizer on:
> [  108.086563][    C1] CPU: 1 PID: 265 Comm: sed Tainted: G        W   E    N 6.9.0-rc3-00015-ge84f43e34faf #1 ddd7212d5d239f10e5f20ca1605d3d23d4ce80eb
> [  108.088374][    C1] ==================================================================
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240416/202404161050.38f1c92e-lkp@intel.com
> 
> 
> 


