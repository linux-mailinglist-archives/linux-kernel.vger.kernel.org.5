Return-Path: <linux-kernel+bounces-71229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFAE85A23B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0622F1F22611
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2AC2D022;
	Mon, 19 Feb 2024 11:40:47 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D532D042;
	Mon, 19 Feb 2024 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342846; cv=none; b=NH3yF/5CHLtvukGyBQSY3d82JKtSOr9YQ7N+g9U0XMxQO00DCtFKHvD4qF+mCuRxzBcMr34jENfyo4CSm3PkoUmaLGUkyW2A5TtgSpYNkw0UZHZySkmHRnwbgqwpUl179PE+trqcBQjL10/qehOW6y/RsfEpf9z/sUQMcSI34OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342846; c=relaxed/simple;
	bh=wtnUCMoy6Ba42qC7WybR773SJiEU7M1UPM3rydODRKA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lqz0I878u40vUJ3hJ5DWLlFUJkDuimuQXgKRUEePxXpUXwEx3UvqhxVRWTIKrolpOgqgdMUUx6QPxp5QuAc4GYFSQK4jLVuYRB4Dnji/eWuMmq/gI/utDmZSXycLChS1kRlV2vfAT/LQNy7a0XFet2oteMKNT25X0yhu+YNksmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TdgV25WX9z6JB5f;
	Mon, 19 Feb 2024 19:36:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id AF983140DEA;
	Mon, 19 Feb 2024 19:40:40 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 11:40:40 +0000
Date: Mon, 19 Feb 2024 11:40:39 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Samuel Holland <samuel.holland@sifive.com>
CC: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Eric
 Lin" <eric.lin@sifive.com>, Conor Dooley <conor@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	<linux-riscv@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 4/6] drivers/perf: Add SiFive Extensible Cache PMU
 driver
Message-ID: <20240219114039.00004a86@Huawei.com>
In-Reply-To: <20240216000837.1868917-5-samuel.holland@sifive.com>
References: <20240216000837.1868917-1-samuel.holland@sifive.com>
	<20240216000837.1868917-5-samuel.holland@sifive.com>
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

On Thu, 15 Feb 2024 16:08:16 -0800
Samuel Holland <samuel.holland@sifive.com> wrote:

> From: Eric Lin <eric.lin@sifive.com>
> 
> Add a driver for the PMU found in the SiFive Extensible Cache
> controller. This PMU provides a configurable number of counters and a
> variety of events. Events are grouped into sets. Each counter can count
> events from only one set at a time; however, it can count any number of
> events within that set simultaneously. The PMU hardware does not provide
> an overflow interrupt.
> 
> The counter inhibit register is used to atomically start/stop/read a
> group of counters so their values can be usefully compared.
> 
> Some events can be filtered further by client ID (e.g. CPU or external
> DMA master). That functionality is not supported by this driver.
> 
> This driver further assumes that a single Extensible Cache instance is
> shared by all CPUs in the system.
> 
> Example usage:
> 
> $ perf stat -e sifive_ecache_pmu/inner_rd_request/,
> 	       sifive_ecache_pmu/inner_wr_request/,
> 	       sifive_ecache_pmu/inner_rd_request_hit/,
> 	       sifive_ecache_pmu/inner_wr_request_hit/ ls
> 
>  Performance counter stats for 'system wide':
> 
>             148001      sifive_ecache_pmu/inner_rd_request/
>             121064      sifive_ecache_pmu/inner_wr_request/
>             113124      sifive_ecache_pmu/inner_rd_request_hit/
>             120860      sifive_ecache_pmu/inner_wr_request_hit/
> 
>        0.010643962 seconds time elapsed
> 
> Example combining the read/write events together within each counter:
> 
> $ perf stat -e sifive_ecache_pmu/event=0x601/,
> 	       sifive_ecache_pmu/event=0xc001/ ls
> 
>  Performance counter stats for 'system wide':
> 
>             262619      sifive_ecache_pmu/event=0x601/
>             224533      sifive_ecache_pmu/event=0xc001/
> 
>        0.009794808 seconds time elapsed
> 
> Signed-off-by: Eric Lin <eric.lin@sifive.com>
> Co-developed-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>


Hi Samuel,

Some comments inline. Note this is a driver by review so not very
thorough!

Jonathan

> +
> +static u64 read_counter(const struct sifive_ecache_pmu *ecache_pmu, const struct hw_perf_event *hwc)
> +{
> +	u64 value = 0;
> +
> +	for (int i = 0; i < ecache_pmu->n_slices; i++) {
> +		void __iomem *base = ecache_pmu->slice[i].base;
> +
> +		value += readq(base + hwc->event_base);
Feels like this summing should be a userspace problem.
Knowing about slice imbalance is often useful (depending on the
micro architecture obviously!)


> +	}
> +
> +	return value;
> +}



> +
> +static int sifive_ecache_pmu_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *ecache_node = dev_of_node(dev);
> +	struct sifive_ecache_pmu *ecache_pmu;
> +	struct device_node *slice_node;
> +	u32 slice_counters;
> +	int n_slices, ret;
> +	int i = 0;
> +
> +	n_slices = of_get_available_child_count(ecache_node);
fwnode_get_available_child_count(dev_fwnode(&pdev->dev));

Not sure why there isn't yet a device version of this (IIRC anyway).

> +	if (!n_slices)
> +		return -ENODEV;
> +
> +	ecache_pmu = devm_kzalloc(dev, struct_size(ecache_pmu, slice, n_slices), GFP_KERNEL);
> +	if (!ecache_pmu)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, ecache_pmu);
> +
> +	ecache_pmu->pmu = (struct pmu) {
> +		.parent		= dev,
> +		.attr_groups	= sifive_ecache_pmu_attr_grps,
> +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
> +		.task_ctx_nr	= perf_invalid_context,
> +		.event_init	= sifive_ecache_pmu_event_init,
> +		.add		= sifive_ecache_pmu_add,
> +		.del		= sifive_ecache_pmu_del,
> +		.start		= sifive_ecache_pmu_start,
> +		.stop		= sifive_ecache_pmu_stop,
> +		.read		= sifive_ecache_pmu_read,
> +		.start_txn	= sifive_ecache_pmu_start_txn,
> +		.commit_txn	= sifive_ecache_pmu_commit_txn,
> +		.cancel_txn	= sifive_ecache_pmu_cancel_txn,
> +	};
> +	ecache_pmu->cpu = nr_cpu_ids;
> +	ecache_pmu->n_counters = ECACHE_PMU_MAX_COUNTERS;
> +	ecache_pmu->n_slices = n_slices;
> +
> +	for_each_available_child_of_node(ecache_node, slice_node) {
device_for_each_child_node() (generic handlers only provide the available version btw
which is non obvious from naming)

> +		struct sifive_ecache_pmu_slice *slice = &ecache_pmu->slice[i++];
> +
> +		slice->base = devm_of_iomap(dev, slice_node, 0, NULL);
> +		if (IS_ERR(slice->base))
Leaked slice_node

FWIW https://lore.kernel.org/linux-iio/20240217164249.921878-1-jic23@kernel.org/
adds device_for_each_child_node_scoped() which deals with this stuff using
cleanup.h magic.


> +			return PTR_ERR(slice->base);
> +
> +		/* Get number of counters from slice node */
> +		ret = of_property_read_u32(slice_node, "sifive,perfmon-counters", &slice_counters);
Not sure on what perf maintainers want, but I'd go with
device_property_read etc as in the previous driver.

> +		if (ret)
leaked slice_node

> +			return dev_err_probe(dev, ret,
> +					     "Slice %pOF missing sifive,perfmon-counters property\n",
> +					     slice_node);
> +
> +		ecache_pmu->n_counters = min_t(u32, slice_counters, ecache_pmu->n_counters);
> +	}
> +
> +	sifive_ecache_pmu_hw_init(ecache_pmu);
> +
> +	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_SIFIVE_ECACHE_ONLINE, &ecache_pmu->node);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add CPU hotplug instance\n");
> +
> +	ret = perf_pmu_register(&ecache_pmu->pmu, "sifive_ecache_pmu", -1);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to register PMU\n");
> +		goto err_remove_instance;
Comments from other review apply here as well so if you agree apply them in both drivers.

> +	}
> +
> +	return 0;
> +
> +err_remove_instance:
> +	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_SIFIVE_ECACHE_ONLINE, &ecache_pmu->node);
> +
> +	return ret;
> +}

