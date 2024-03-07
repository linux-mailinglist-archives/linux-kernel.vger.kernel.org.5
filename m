Return-Path: <linux-kernel+bounces-94900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADB4874678
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC4C1C21C52
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5A4D2FE;
	Thu,  7 Mar 2024 03:02:41 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507B01109;
	Thu,  7 Mar 2024 03:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709780561; cv=none; b=kjhbxevD5gehq2QOXBxT5YGEb/4tlfVBk8HSuthGXs76TndXrXakZYqT8zufQtvbWZDw+jBzy7U4DJREQdz0dmjN1O0o69H62JHsNSrHqyJAY2WDLvwlAmqML8TEz3Z+NPqdoWc4sC4/i3uGRQa/CDfIzwGKoikaBlxGple3GxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709780561; c=relaxed/simple;
	bh=HWjnA8HRBancgbepAZDpEdJiP7zrzkbNCdz1Sy6cZus=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=COqa0TCr57zKydhHetZ2+TSaz0niE+Wf7t+gQ1Ouhd1WCRpgorOObwwVBwnFroDV1LWc0DPIQTzKOY0uRgh93gKJuUW+k6+VYydmAyyQmtuSr91fpExO4Gik6PPnyCUrvSobRWTqYBvD/l/C2Bkbfw6sdE3N1/Hn9DzoikWLBVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TqvH63xtPz1FM0D;
	Thu,  7 Mar 2024 11:02:26 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 62C151A0172;
	Thu,  7 Mar 2024 11:02:35 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 11:02:34 +0800
Message-ID: <e3403070-2566-fa88-2d4d-84bae8205567@huawei.com>
Date: Thu, 7 Mar 2024 11:02:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 1/3] arm64: topology: Add arch_freq_get_on_cpu()
 support
To: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>, Beata Michalska
	<beata.michalska@arm.com>
CC: Ionela Voinescu <ionela.voinescu@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<rafael@kernel.org>, <sumitg@nvidia.com>, <zengheng4@huawei.com>,
	<yang@os.amperecomputing.com>, <will@kernel.org>, <sudeep.holla@arm.com>,
	<liuyonglong@huawei.com>, <zhanjie9@hisilicon.com>,
	<linux-acpi@vger.kernel.org>
References: <20240229162520.970986-1-vanshikonda@os.amperecomputing.com>
 <20240229162520.970986-2-vanshikonda@os.amperecomputing.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20240229162520.970986-2-vanshikonda@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600004.china.huawei.com (7.193.23.242)

Hi Vanshidhar,

在 2024/3/1 0:25, Vanshidhar Konda 写道:
> AMU counters are used by the Frequency Invariance Engine (FIE) to
> estimate the CPU utilization during each tick. The delta of the AMU
> counters between two ticks can also be used to estimate the average CPU
> frequency of each core over the tick duration. Measure the AMU counters
> during tick, compute the delta and store it. When the frequency of the
> core is queried, use the stored delta to determine the frequency.
>
> arch_freq_get_on_cpu() is used on x86 systems to estimate the frequency
> of each CPU. It can be wired up on arm64 for the same functionality.
>
> Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> ---
>   arch/arm64/kernel/topology.c | 114 +++++++++++++++++++++++++++++------
>   1 file changed, 96 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 1a2c72f3e7f8..db8d14525cf4 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -17,6 +17,8 @@
>   #include <linux/cpufreq.h>
>   #include <linux/init.h>
>   #include <linux/percpu.h>
> +#include <linux/sched/isolation.h>
> +#include <linux/seqlock_types.h>
>   
>   #include <asm/cpu.h>
>   #include <asm/cputype.h>
> @@ -82,20 +84,54 @@ int __init parse_acpi_topology(void)
>   #undef pr_fmt
>   #define pr_fmt(fmt) "AMU: " fmt
>   
> +struct amu_counters {
> +	seqcount_t	seq;
> +	unsigned long	last_update;
> +	u64		core_cnt;
> +	u64		const_cnt;
> +	u64		delta_core_cnt;
> +	u64		delta_const_cnt;
> +};
> +
>   /*
>    * Ensure that amu_scale_freq_tick() will return SCHED_CAPACITY_SCALE until
>    * the CPU capacity and its associated frequency have been correctly
>    * initialized.
>    */
> -static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =  1UL << (2 * SCHED_CAPACITY_SHIFT);
> -static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
> -static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
> +static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =
> +	1UL << (2 * SCHED_CAPACITY_SHIFT);
> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct amu_counters, cpu_samples) = {
> +	.seq = SEQCNT_ZERO(cpu_samples.seq)
> +};
>   static cpumask_var_t amu_fie_cpus;
>   
>   void update_freq_counters_refs(void)
>   {
> -	this_cpu_write(arch_core_cycles_prev, read_corecnt());
> -	this_cpu_write(arch_const_cycles_prev, read_constcnt());
> +	struct amu_counters *cpu_sample = this_cpu_ptr(&cpu_samples);
> +	u64 core_cnt, const_cnt, delta_core_cnt, delta_const_cnt;
> +
> +	const_cnt = read_constcnt();
> +	core_cnt = read_corecnt();
> +
> +	if (unlikely(core_cnt < cpu_sample->core_cnt) ||
> +	    unlikely(const_cnt < cpu_sample->const_cnt)) {

The two counter register might be wrap around. So here is not fully 
true, right?

If we don't consider this case, below warning should be removed.

> +		WARN(1, "AMU counter values should be monotonic.\n");
> +		cpu_sample->delta_const_cnt = 0;
> +		cpu_sample->delta_core_cnt = 0;
> +		return;
> +	}
> +
> +	delta_core_cnt = core_cnt - cpu_sample->core_cnt;
> +	delta_const_cnt = const_cnt - cpu_sample->const_cnt;
> +
> +	cpu_sample->core_cnt = core_cnt;
> +	cpu_sample->const_cnt = const_cnt;
> +
> +	raw_write_seqcount_begin(&cpu_sample->seq);
> +	cpu_sample->last_update = jiffies;
> +	cpu_sample->delta_const_cnt = delta_const_cnt;
> +	cpu_sample->delta_core_cnt = delta_core_cnt;
> +	raw_write_seqcount_end(&cpu_sample->seq);
>   }
<...>

