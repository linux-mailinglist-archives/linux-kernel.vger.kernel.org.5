Return-Path: <linux-kernel+bounces-71204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B8D85A1F3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BA71C2177F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAEC2C1B9;
	Mon, 19 Feb 2024 11:29:46 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AB628DD2;
	Mon, 19 Feb 2024 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342186; cv=none; b=kn7E8LmHBoyjPDocDZTNSvC3eK+VrAcLeKxI8pKcCiVK9aURdFYyCvLoP+HjPBZtF6gzcUJRTNZYxmIyKxLsIHZB0z4Zr2aRJWa7knoNfR+4Ricl7AqU/oW/5UunV2rcPXo+C+BaoUEyebOUqEucMP7Wun5q9/vgohuMj1cmrds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342186; c=relaxed/simple;
	bh=HtptTPvpVJO8kxtozUPX1/krZ7r9liSkZp3ztBArrxY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBzSjQhpuscHsZwAsTNrQjSS/wglbX5XDRDRknY4wDtd3VPX26gc4WRhwVogk20JvfvLXMK0csNdmuao18iCTsbJt819ve+ubG0IZ/cojKP67/MJ/JmxG7r9UO1naIp70frooqCa4yIIDi5Jq7PU8LBEaH0VLcicec4JE8vcCO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TdgFL3jr9z6JB6R;
	Mon, 19 Feb 2024 19:25:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7131C14138F;
	Mon, 19 Feb 2024 19:29:40 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 11:29:39 +0000
Date: Mon, 19 Feb 2024 11:29:38 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Samuel Holland <samuel.holland@sifive.com>
CC: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Eric
 Lin" <eric.lin@sifive.com>, Conor Dooley <conor@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	<linux-riscv@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 2/6] drivers/perf: Add SiFive Composable Cache PMU
 driver
Message-ID: <20240219112938.00002654@Huawei.com>
In-Reply-To: <20240216000837.1868917-3-samuel.holland@sifive.com>
References: <20240216000837.1868917-1-samuel.holland@sifive.com>
	<20240216000837.1868917-3-samuel.holland@sifive.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 15 Feb 2024 16:08:14 -0800
Samuel Holland <samuel.holland@sifive.com> wrote:

> From: Eric Lin <eric.lin@sifive.com>
> 
> Add a driver for the PMU found in the SiFive Composable Cache
> controller. This PMU provides a configurable number of counters and a
> variety of events. Events are grouped into sets. Each counter can count
> events from only one set at a time; however, it can count any number of
> events within that set simultaneously. The PMU hardware does not provide
> an overflow interrupt or a way to atomically control groups of counters.
> 
> Some events can be filtered further by client ID (e.g. CPU or external
> DMA master). That functionality is not supported by this driver.
> 
> This driver further assumes that a single Composable Cache instance is
> shared by all CPUs in the system.
> 
> Example usage:
> 
> $ perf stat -a -e sifive_ccache_pmu/inner_acquire_block_btot/,
> 		  sifive_ccache_pmu/inner_acquire_block_hit/,
> 		  sifive_ccache_pmu/inner_acquire_block_ntob/ ls
> 
>  Performance counter stats for 'system wide':
> 
>                542      sifive_ccache_pmu/inner_acquire_block_btot/
>              22081      sifive_ccache_pmu/inner_acquire_block_hit/
>              22006      sifive_ccache_pmu/inner_acquire_block_ntob/
> 
>        0.064672432 seconds time elapsed
> 
> Example using numeric event selectors:
> 
> $ perf stat -a -e sifive_ccache_pmu/event=0x10001/,
> 		  sifive_ccache_pmu/event=0x2002/,
> 		  sifive_ccache_pmu/event=0x4001/ ls
> 
>  Performance counter stats for 'system wide':
> 
>                478      sifive_ccache_pmu/event=0x10001/
>               4717      sifive_ccache_pmu/event=0x2002/
>              44966      sifive_ccache_pmu/event=0x4001/
> 
>        0.111027326 seconds time elapsed
> 
> Signed-off-by: Eric Lin <eric.lin@sifive.com>
> Co-developed-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>


Hi Samuel,

A few comments inline.

> diff --git a/drivers/perf/sifive_ccache_pmu.c b/drivers/perf/sifive_ccache_pmu.c
> new file mode 100644
> index 000000000000..8c9ef0d09f48
> --- /dev/null
> +++ b/drivers/perf/sifive_ccache_pmu.c


> +
> +#define to_ccache_pmu(p) (container_of(p, struct sifive_ccache_pmu, pmu))
> +
> +#ifndef readq
> +static inline u64 readq(void __iomem *addr)
> +{
> +	return readl(addr) | (((u64)readl(addr + 4)) << 32);
> +}
> +#endif
> +
> +#ifndef writeq
> +static inline void writeq(u64 v, void __iomem *addr)
> +{
> +	writel(lower_32_bits(v), addr);
> +	writel(upper_32_bits(v), addr + 4);

Include io-64-nonatomic-lo-hi.h 
and you shouldn't need these.

> +}
> +#endif


> +
> +/*
> + * pmu->stop: stop the counter
> + */
> +static void sifive_ccache_pmu_stop(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	if (hwc->state & PERF_HES_STOPPED)
> +		return;
> +
> +	/* Disable this counter to count events */
> +	writeq(0, (void *)hwc->config_base);

Not going to give address space warnings as writeq expects
__iomem?

> +	sifive_ccache_pmu_read(event);
> +
> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +}



> +/*
> + * pmu->del: delete the event from the PMU
Why use multi line comments?
> + */
> +static void sifive_ccache_pmu_del(struct perf_event *event, int flags)
> +{
> +	struct sifive_ccache_pmu *ccache_pmu = to_ccache_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = hwc->idx;
> +
> +	/* Stop and release this counter */
> +	sifive_ccache_pmu_stop(event, PERF_EF_UPDATE);
> +
> +	ccache_pmu->events[idx] = NULL;
> +	clear_bit(idx, ccache_pmu->used_mask);
> +
> +	perf_event_update_userpage(event);
> +}
> +
> +/*
> + * Driver initialization

Probably drop generic code organization comments like this.
They just rot over time and provide little benefit.

> + */

..

> +
> +static int sifive_ccache_pmu_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sifive_ccache_pmu *ccache_pmu;
> +	u32 n_counters;
> +	int ret;
> +
> +	/* Instances without a sifive,perfmon-counters property do not contain a PMU */
> +	ret = device_property_read_u32(dev, "sifive,perfmon-counters", &n_counters);
> +	if (ret || !n_counters)
> +		return -ENODEV;
if (ret)
	return ret;

	if (!n_counters)
		return -ENODEV;

In general don't eat potentially useful return codes.

> +
> +	ccache_pmu = devm_kzalloc(dev, struct_size(ccache_pmu, events, n_counters), GFP_KERNEL);
> +	if (!ccache_pmu)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, ccache_pmu);
> +
> +	ccache_pmu->pmu = (struct pmu) {
> +		.parent		= dev,
> +		.attr_groups	= sifive_ccache_pmu_attr_grps,
> +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
> +		.task_ctx_nr	= perf_invalid_context,
> +		.event_init	= sifive_ccache_pmu_event_init,
> +		.add		= sifive_ccache_pmu_add,
> +		.del		= sifive_ccache_pmu_del,
> +		.start		= sifive_ccache_pmu_start,
> +		.stop		= sifive_ccache_pmu_stop,
> +		.read		= sifive_ccache_pmu_read,
> +	};
> +	ccache_pmu->cpu = nr_cpu_ids;
> +	ccache_pmu->n_counters = n_counters;
> +
> +	ccache_pmu->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ccache_pmu->base))
> +		return PTR_ERR(ccache_pmu->base);
> +
> +	sifive_ccache_pmu_hw_init(ccache_pmu);
> +
> +	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_SIFIVE_CCACHE_ONLINE, &ccache_pmu->node);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add CPU hotplug instance\n");

you could use devm_add_action_or_reset() and trivial callback to unwind this in remove + error
paths automatically.  Slight simplification of code, though may end up a line or two longer.

Do the same for perf_pmu_unregister() and you can get rid of remove entirely.

> +
> +	ret = perf_pmu_register(&ccache_pmu->pmu, "sifive_ccache_pmu", -1);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to register PMU\n");
> +		goto err_remove_instance;
> +	}
> +
> +	return 0;
> +
> +err_remove_instance:
> +	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_SIFIVE_CCACHE_ONLINE, &ccache_pmu->node);
> +
> +	return ret;
> +}
> +
> +static void sifive_ccache_pmu_remove(struct platform_device *pdev)
> +{
> +	struct sifive_ccache_pmu *ccache_pmu = platform_get_drvdata(pdev);
> +
> +	perf_pmu_unregister(&ccache_pmu->pmu);
> +	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_SIFIVE_CCACHE_ONLINE, &ccache_pmu->node);
> +}
> +
> +static const struct of_device_id sifive_ccache_pmu_of_match[] = {
> +	{ .compatible = "sifive,ccache0" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sifive_ccache_pmu_of_match);
> +
> +static struct platform_driver sifive_ccache_pmu_driver = {
> +	.probe	= sifive_ccache_pmu_probe,
> +	.remove_new	= sifive_ccache_pmu_remove,

Is this actually aligning anything in a useful fashion?
I'd just use a single space instead and not bother. The alignment tends to
just end up broken and provides little readability advantage.


> +	.driver	= {
> +		.name		= "sifive_ccache_pmu",
> +		.of_match_table	= sifive_ccache_pmu_of_match,
> +	},
> +};

> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 172d0a743e5d..be6361fdc8ba 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -230,6 +230,7 @@ enum cpuhp_state {
>  	CPUHP_AP_PERF_POWERPC_TRACE_IMC_ONLINE,
>  	CPUHP_AP_PERF_POWERPC_HV_24x7_ONLINE,
>  	CPUHP_AP_PERF_POWERPC_HV_GPCI_ONLINE,
> +	CPUHP_AP_PERF_RISCV_SIFIVE_CCACHE_ONLINE,

Not sure, but can you get away with CPUHP_AP_ONLINE_DYN ?
Nicer to avoid adding more entries to this list if that is suitable here.

>  	CPUHP_AP_PERF_CSKY_ONLINE,
>  	CPUHP_AP_WATCHDOG_ONLINE,
>  	CPUHP_AP_WORKQUEUE_ONLINE,


