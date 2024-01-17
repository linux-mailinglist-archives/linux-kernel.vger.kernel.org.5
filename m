Return-Path: <linux-kernel+bounces-29517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9EB830F87
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23766B248AC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F6C24B36;
	Wed, 17 Jan 2024 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9k2luvt"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094B51E883;
	Wed, 17 Jan 2024 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531833; cv=none; b=j1NSzEyb8mZykK+2F0jpKSrl+Lwz5TIELYURJBZUHUmEfwUlIFV6L+OAVkjIHqfl04yZKcQZ1wsqygo+N94YC5wZ9iRovW20GisD+0JccDwlj/pizATg4mWRxlVU4HPfaltxslh/h7P6yCVqtF6HQQFbj5OoLNLq8VMLl7qym3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531833; c=relaxed/simple;
	bh=qguSOaKqDdDjb3/S9QpBOL7t0uNMFAuzVBe0jQZrzWk=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent; b=sCCiAdYxbDJSpynN0Wxknc9b/BkIe2BR+l1eyhRebxYru4EQ1AGgyQWYlPH92MiIdB9OI5gV+CXOM23mciRo6unig3oYOLQYMCJG8xS4/4QECPY7zXQbbJI8J6kX/6/wTwH0RPjPzAUSseFYP3x2XkUx0LLMhoMLmjWVaqydcCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W9k2luvt; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705531832; x=1737067832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qguSOaKqDdDjb3/S9QpBOL7t0uNMFAuzVBe0jQZrzWk=;
  b=W9k2luvt3WV1+LyCaW1k9sXa82I/Z9gY8kQHb2ipvlgVz559+5x8J6WG
   BQevgEhXKWI9DX8kRxR8VshVqfM6x4SGoluwyJzLokaKiCUI502JyQa6/
   luZXAP6FJ8K03lEJCx5zP+27YWQui+Q2fs+VYxkabOicBiEixd3LxaQay
   r+GKDprHPj96OK1ZiD2QJYUsviEzBUth4axF0ypdVCcrrp6mqH3I9xoOu
   d+4WBIDPhH8rIGGSa1vxAwSvB47kCJILeP0jOkJrKhT2wQNybcrCDY7gn
   4iWO1aVXaZlb1mseNA9/sfnLxrKVeeKlfV7u6pmtVjZlzgOnxR9JRDSMR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="399955665"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="399955665"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:50:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="760708067"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="760708067"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:50:28 -0800
Date: Wed, 17 Jan 2024 14:51:58 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, mcgrof@kernel.org, peterz@infradead.org,
	j.granados@samsung.com, viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org, CobeChen@zhaoxin.com, TimGuo@zhaoxin.com,
	LeoLiu-oc@zhaoxin.com, LindaChai@zhaoxin.com
Subject: Re: [PATCH 3/3] ACPI: cpufreq: Add ITMT support when CPPC enabled
 for Zhaoxin CPUs
Message-ID: <20240117225158.GD13777@ranerica-svr.sc.intel.com>
References: <20231228075705.26652-1-TonyWWang-oc@zhaoxin.com>
 <20231228075705.26652-4-TonyWWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228075705.26652-4-TonyWWang-oc@zhaoxin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Dec 28, 2023 at 03:57:05PM +0800, Tony W Wang-oc wrote:
> For Zhaoxin CPUs, the cores' highest frequencies may be different, which
> means that cores may run at different max frequencies,
> 
> According to ACPI-spec6 chapter 8.4.7, the per-core highest frequency
> value can be obtained via cppc.
> 
> The core with the higher frequency have better performance, which can be
> called as preferred core. And better performance can be achieved by
> making the scheduler to run tasks on these preferred cores.
> 
> The cpufreq driver can use the highest frequency value as the prioriy of
> core to make the scheduler try to get better performace. More specifically,
> in the acpi-cpufreq driver use cppc_get_highest_perf() to get highest
> frequency value of each core, use sched_set_itmt_core_prio() to set
> highest frequency value as core priority, and use sched_set_itmt_support()
> provided by ITMT to tell the scheduler to favor on the preferred cores.
> 
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 56 +++++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 37f1cdf46d29..f4c1ff9e4bb0 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -663,8 +663,56 @@ static u64 get_max_boost_ratio(unsigned int cpu)
>  
>  	return div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
>  }
> +
> +/* The work item is needed to avoid CPU hotplug locking issues */
> +static void sched_itmt_work_fn(struct work_struct *work)
> +{
> +	sched_set_itmt_support();
> +}
> +
> +static DECLARE_WORK(sched_itmt_work, sched_itmt_work_fn);
> +
> +static void set_itmt_prio(int cpu)
> +{
> +	static bool cppc_highest_perf_diff;
> +	static struct cpumask core_prior_mask;
> +	u64 highest_perf;
> +	static u64 max_highest_perf = 0, min_highest_perf = U64_MAX;
> +	int ret;
> +
> +	ret = cppc_get_highest_perf(cpu, &highest_perf);
> +	if (ret)
> +		return;
> +
> +	sched_set_itmt_core_prio(highest_perf, cpu);
> +	cpumask_set_cpu(cpu, &core_prior_mask);
> +
> +	if (max_highest_perf <= min_highest_perf) {
> +		if (highest_perf > max_highest_perf)
> +			max_highest_perf = highest_perf;
> +
> +		if (highest_perf < min_highest_perf)
> +			min_highest_perf = highest_perf;
> +
> +		if (max_highest_perf > min_highest_perf) {
> +			/*
> +			 * This code can be run during CPU online under the
> +			 * CPU hotplug locks, so sched_set_itmt_support()
> +			 * cannot be called from here.  Queue up a work item
> +			 * to invoke it.
> +			 */
> +			cppc_highest_perf_diff = true;
> +		}
> +	}
> +
> +	if (cppc_highest_perf_diff && cpumask_equal(&core_prior_mask, cpu_online_mask)) {
> +		pr_debug("queue a work to set itmt enabled\n");
> +		schedule_work(&sched_itmt_work);
> +	}
> +}

sched_itmt_work and this function is a duplicate of what the intel_pstate
driver already does. It might be good if consolidate in a single place
if you are going to pursue this approach.

