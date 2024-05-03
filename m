Return-Path: <linux-kernel+bounces-167210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6A78BA5BA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E462D1F248CE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB5C1CD2A;
	Fri,  3 May 2024 03:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0lqf6cr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF8F1C2BD;
	Fri,  3 May 2024 03:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714706757; cv=none; b=NFk2LiKesTzk5Hdli2o9d2qNm4fkSPgbIAwVBenfGsjnwJ0qSwE6p8QzRwb4yfAEOphFXXoLIzjVHMIN4dZgpSZhm0mi/eTPFPoDYC85Vd7ejYniKz0iCC5W/PxSDtsW5xzyU0nhesBROHPG7R6g3YAI4MY6EkcSCTznDCXyYNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714706757; c=relaxed/simple;
	bh=k6rGqO8hErCKlEn63vnYpMs6dLzH+1S9CMpJjd1bTgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tn9+rnd/XR8FdC5XEJVLFrMzUVdGbYli8zDDKl7ifOXjL8onJ/baLYxDB/zmAwZJs40RGXz07RijKL/ExK0e1Yol/CTig/OU6bnTCN2YxNy9cYcfnBSnwp5oHdgH7TRsLddQyo/8aroyHYwEKnhWbyjtOolR86KI62nqwXnwOms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0lqf6cr; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714706755; x=1746242755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k6rGqO8hErCKlEn63vnYpMs6dLzH+1S9CMpJjd1bTgs=;
  b=N0lqf6crMMFXpjMWAtyqyBCeuaj5USqUX00tZWZN5ZVYD167R+euH1Tr
   T6Ez1qtbbkeSANMtXIJxoSH9ep0vpl0UknTnRRAcwwwocz18eovKpPIgP
   3TTcKrBpoZT1QWhuYKMkjVOpJBfY6JAkX9rObykfF2dGvt3pG0fBP1/2W
   2EGIvS5JjMr5jFD/PAygMY3RIMT8UHiacANBspLSAL7OKKLr+BIrI7vk8
   NDHfWqitIqSJ6v0X1BhUGenzapjFP+L8rj7Ds4njHZU7BqW1WJ+iLTAo1
   ZGJAzfplyCd4N5A41rOy1mqc3SjgEkTN+grOfKzLVsbFRofT4m4TW5Kjt
   w==;
X-CSE-ConnectionGUID: jy2ewFqqQ3SfmAcgv2/tcg==
X-CSE-MsgGUID: 8snQUtUXRyuS9JkL3O/x6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10383868"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10383868"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 20:25:54 -0700
X-CSE-ConnectionGUID: 6X2Nkj1oRp+JLjyYvjlzBA==
X-CSE-MsgGUID: 1XkQSnV5T7234hIvsb7nYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27738076"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 20:25:54 -0700
Date: Thu, 2 May 2024 20:32:42 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	x86 Maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri@intel.com>,
	Tim Chen <tim.c.chen@intel.com>
Subject: Re: [RFC][PATCH v1 3/3] cpufreq: intel_pstate: Set asymmetric CPU
 capacity on hybrid systems
Message-ID: <20240503033242.GA14835@ranerica-svr.sc.intel.com>
References: <7663799.EvYhyI6sBW@kreacher>
 <1799046.VLH7GnMWUR@kreacher>
 <050c561c-487e-4e89-a7b2-9752cebc9f46@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <050c561c-487e-4e89-a7b2-9752cebc9f46@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, May 02, 2024 at 12:42:54PM +0200, Dietmar Eggemann wrote:
> On 25/04/2024 21:06, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Make intel_pstate use the HWP_HIGHEST_PERF values from
> > MSR_HWP_CAPABILITIES to set asymmetric CPU capacity information
> > via the previously introduced arch_set_cpu_capacity() on hybrid
> > systems without SMT.
> 
> Are there such systems around? My i7-13700K has P-cores (CPU0..CPU15)
> with SMT.

We have been experimenting with nosmt in the kernel command line.

> 
> > Setting asymmetric CPU capacity is generally necessary to allow the
> > scheduler to compute task sizes in a consistent way across all CPUs
> > in a system where they differ by capacity.  That, in turn, should help
> > to improve task placement and load balancing decisions.  It is also
> > necessary for the schedutil cpufreq governor to operate as expected
> > on hybrid systems where tasks migrate between CPUs of different
> > capacities.
> > 
> > The underlying observation is that intel_pstate already uses
> > MSR_HWP_CAPABILITIES to get CPU performance information which is
> > exposed by it via sysfs and CPU performance scaling is based on it.
> > Thus using this information for setting asymmetric CPU capacity is
> > consistent with what the driver has been doing already.  Moreover,
> > HWP_HIGHEST_PERF reflects the maximum capacity of a given CPU including
> > both the instructions-per-cycle (IPC) factor and the maximum turbo
> > frequency and the units in which that value is expressed are the same
> > for all CPUs in the system, so the maximum capacity ratio between two
> > CPUs can be obtained by computing the ratio of their HWP_HIGHEST_PERF
> > values.  Of course, in principle that capacity ratio need not be
> > directly applicable at lower frequencies, so using it for providing the
> > asymmetric CPU capacity information to the scheduler is a rough
> > approximation, but it is as good as it gets.  Also, measurements
> > indicate that this approximation is not too bad in practice.
> 
> So cpu_capacity has a direct mapping to itmt prio. cpu_capacity is itmt
> prio with max itmt prio scaled to 1024.

ITMT enables asym_packing in the load balancer. Since it only cares about
which CPU has higher priority, scaling to 1024 is not necessary.

> 
> Running it on i7-13700K (while allowing SMT) gives:
> 
> root@gulliver:~# dmesg | grep sched_set_itmt_core_prio
> [    3.957826] sched_set_itmt_core_prio() cpu=0 prio=68
> [    3.990401] sched_set_itmt_core_prio() cpu=1 prio=68
> [    4.015551] sched_set_itmt_core_prio() cpu=2 prio=68
> [    4.040720] sched_set_itmt_core_prio() cpu=3 prio=68
> [    4.065871] sched_set_itmt_core_prio() cpu=4 prio=68
> [    4.091018] sched_set_itmt_core_prio() cpu=5 prio=68
> [    4.116175] sched_set_itmt_core_prio() cpu=6 prio=68
> [    4.141374] sched_set_itmt_core_prio() cpu=7 prio=68
> [    4.166543] sched_set_itmt_core_prio() cpu=8 prio=69
> [    4.196289] sched_set_itmt_core_prio() cpu=9 prio=69
> [    4.214964] sched_set_itmt_core_prio() cpu=10 prio=69
> [    4.239281] sched_set_itmt_core_prio() cpu=11 prio=69
> [    4.263438] sched_set_itmt_core_prio() cpu=12 prio=68
> [    4.283790] sched_set_itmt_core_prio() cpu=13 prio=68
> [    4.308905] sched_set_itmt_core_prio() cpu=14 prio=68
> [    4.331751] sched_set_itmt_core_prio() cpu=15 prio=68
> [    4.356002] sched_set_itmt_core_prio() cpu=16 prio=42
> [    4.381639] sched_set_itmt_core_prio() cpu=17 prio=42
> [    4.395175] sched_set_itmt_core_prio() cpu=18 prio=42
> [    4.425625] sched_set_itmt_core_prio() cpu=19 prio=42
> [    4.449670] sched_set_itmt_core_prio() cpu=20 prio=42
> [    4.479681] sched_set_itmt_core_prio() cpu=21 prio=42
> [    4.506319] sched_set_itmt_core_prio() cpu=22 prio=42
> [    4.523774] sched_set_itmt_core_prio() cpu=23 prio=42
> 
> root@gulliver:~# dmesg | grep hybrid_set_cpu_capacity
> [    4.450883] hybrid_set_cpu_capacity() cpu=0 cap=1009
> [    4.455846] hybrid_set_cpu_capacity() cpu=1 cap=1009
> [    4.460806] hybrid_set_cpu_capacity() cpu=2 cap=1009
> [    4.465766] hybrid_set_cpu_capacity() cpu=3 cap=1009
> [    4.470730] hybrid_set_cpu_capacity() cpu=4 cap=1009
> [    4.475699] hybrid_set_cpu_capacity() cpu=5 cap=1009
> [    4.480664] hybrid_set_cpu_capacity() cpu=6 cap=1009
> [    4.485626] hybrid_set_cpu_capacity() cpu=7 cap=1009
> [    4.490588] hybrid_set_cpu_capacity() cpu=9 cap=1024
> [    4.495550] hybrid_set_cpu_capacity() cpu=10 cap=1024
> [    4.500598] hybrid_set_cpu_capacity() cpu=11 cap=1024
> [    4.505649] hybrid_set_cpu_capacity() cpu=12 cap=1009
> [    4.510701] hybrid_set_cpu_capacity() cpu=13 cap=1009
> [    4.515749] hybrid_set_cpu_capacity() cpu=14 cap=1009
> [    4.520802] hybrid_set_cpu_capacity() cpu=15 cap=1009
> [    4.525846] hybrid_set_cpu_capacity() cpu=16 cap=623
> [    4.530810] hybrid_set_cpu_capacity() cpu=17 cap=623
> [    4.535772] hybrid_set_cpu_capacity() cpu=18 cap=623
> [    4.540732] hybrid_set_cpu_capacity() cpu=19 cap=623
> [    4.545690] hybrid_set_cpu_capacity() cpu=20 cap=623
> [    4.550651] hybrid_set_cpu_capacity() cpu=21 cap=623
> [    4.555612] hybrid_set_cpu_capacity() cpu=22 cap=623
> [    4.560571] hybrid_set_cpu_capacity() cpu=23 cap=623
> 
> > If the given system is hybrid and non-SMT, the new code disables ITMT
> > support in the scheduler (because it may get in the way of asymmetric CPU
> > capacity code in the scheduler that automatically gets enabled by setting
> > asymmetric CPU capacity) after initializing all online CPUs and finds
> > the one with the maximum HWP_HIGHEST_PERF value.  Next, it computes the
> > capacity number for each (online) CPU by dividing the product of its
> > HWP_HIGHEST_PERF and SCHED_CAPACITY_SCALE by the maximum HWP_HIGHEST_PERF.
> 
> SO either CAS at wakeup and in load_balance or SIS at wakeup and ITMT in
> load balance.

May I know what CAS and SIS stand for?

Thanks and BR,
Ricardo

