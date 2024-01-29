Return-Path: <linux-kernel+bounces-42667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 751DA840499
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA94282D40
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17989604B9;
	Mon, 29 Jan 2024 12:07:56 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C3B604A4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530075; cv=none; b=oHxuT7oKoP/cnEKDXhQFMvXMDNMcHeFh+kQvckA8ZsfdgUt2RAA7aeKgJen0MhYwCB9zklnB/wzj4beLm3FRnIqzpAW+GYTE23TbDDtvmsOWZwVMlmblLf35+6ENjwOoHc4vY8S++3L8G7myJGY7a1tiYsWSi3IEWQSw5RMpJ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530075; c=relaxed/simple;
	bh=RIIkdrX22p+Icw1d29ZJ8nqI7L3u/afIDvRVKhBvrwg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYlLxQAuVAMWrLJh/Q+X1pq1g66QKGkK82oqI5WaLHqlZjtJ0sTSw20SIczTbwFfubLv59h5foIdFSmXey99xOmtysP0IuQTUe4Q5pJt5hE3fcOCG91WmgU5TlATZQoYM8WLL0g877rkZ+VR018nTwevKCu0WftT4byxEN7GA9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TNn6D4rrwz6J9b9;
	Mon, 29 Jan 2024 20:04:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A3FBF1400D7;
	Mon, 29 Jan 2024 20:07:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Jan
 2024 12:07:50 +0000
Date: Mon, 29 Jan 2024 12:07:49 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<sgoutham@marvell.com>, <bbhushan2@marvell.com>, <george.cherian@marvell.com>
Subject: Re: [PATCH v3 2/2] perf/marvell : Odyssey LLC-TAD performance
 monitor support
Message-ID: <20240129120749.00002538@Huawei.com>
In-Reply-To: <20240122124933.1311925-3-gthiagarajan@marvell.com>
References: <20240122124933.1311925-1-gthiagarajan@marvell.com>
	<20240122124933.1311925-3-gthiagarajan@marvell.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 22 Jan 2024 18:19:33 +0530
Gowthami Thiagarajan <gthiagarajan@marvell.com> wrote:

> Each TAD provides eight 64-bit counters for monitoring
> cache behavior.The driver always configures the same counter for
> all the TADs. The user would end up effectively reserving one of
> eight counters in every TAD to look across all TADs.
> The occurrences of events are aggregated and presented to the user
> at the end of running the workload. The driver does not provide a
> way for the user to partition TADs so that different TADs are used for
> different applications.
> 
> The performance events reflect various internal or interface activities.
> By combining the values from multiple performance counters, cache
> performance can be measured in terms such as: cache miss rate, cache
> allocations, interface retry rate, internal resource occupancy, etc.
> 
> Each supported counter's event and formatting information is exposed
> to sysfs at /sys/devices/tad/. Use perf tool stat command to measure
> the pmu events. For instance:
> 
> perf stat -e tad_hit_ltg,tad_hit_dtg <workload>
> 
> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
Hi Gowthami,

A few quick comments inline

Jonathan

> ---
>  drivers/perf/marvell_cn10k_tad_pmu.c | 41 +++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
> index fec8e82edb95..b5786fcec0ec 100644
> --- a/drivers/perf/marvell_cn10k_tad_pmu.c
> +++ b/drivers/perf/marvell_cn10k_tad_pmu.c
> @@ -214,6 +214,24 @@ static const struct attribute_group tad_pmu_events_attr_group = {
>  	.attrs = tad_pmu_event_attrs,
>  };
>  
> +static struct attribute *ody_tad_pmu_event_attrs[] = {
> +	TAD_PMU_EVENT_ATTR(tad_req_msh_in_exlmn, 0x3),
> +	TAD_PMU_EVENT_ATTR(tad_alloc_dtg, 0x1a),
> +	TAD_PMU_EVENT_ATTR(tad_alloc_ltg, 0x1b),
> +	TAD_PMU_EVENT_ATTR(tad_alloc_any, 0x1c),
> +	TAD_PMU_EVENT_ATTR(tad_hit_dtg, 0x1d),
> +	TAD_PMU_EVENT_ATTR(tad_hit_ltg, 0x1e),
> +	TAD_PMU_EVENT_ATTR(tad_hit_any, 0x1f),
> +	TAD_PMU_EVENT_ATTR(tad_tag_rd, 0x20),
> +	TAD_PMU_EVENT_ATTR(tad_tot_cycle, 0xFF),
> +	NULL
> +};
> +
> +static const struct attribute_group ody_tad_pmu_events_attr_group = {
> +	.name = "events",
> +	.attrs = ody_tad_pmu_event_attrs,
> +};
> +
>  PMU_FORMAT_ATTR(event, "config:0-7");
>  
>  static struct attribute *tad_pmu_format_attrs[] = {
> @@ -252,11 +270,19 @@ static const struct attribute_group *tad_pmu_attr_groups[] = {
>  	NULL
>  };
>  
> +static const struct attribute_group *ody_tad_pmu_attr_groups[] = {
> +	&ody_tad_pmu_events_attr_group,
> +	&tad_pmu_format_attr_group,
> +	&tad_pmu_cpumask_attr_group,
> +	NULL
> +};
> +
>  static int tad_pmu_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct tad_region *regions;
>  	struct tad_pmu *tad_pmu;
> +	const char *compatible;
>  	struct resource *res;
>  	u32 tad_pmu_page_size;
>  	u32 tad_page_size;
> @@ -276,6 +302,12 @@ static int tad_pmu_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	ret = device_property_read_string(dev, "compatible", &compatible);
Unusual to find a compatible in an ACPI DSDT table unless PRP0001 is being used
and if that is being used, I'd not expect ACPI ID as below.

Maybe give a DSDT blob (disassembled) in the patch intro?

> +	if (ret) {
> +		dev_err(&pdev->dev, "compatible property not found\n");
> +		return ret;
> +	}
> +
>  	ret = device_property_read_u32(dev, "marvell,tad-page-size",
>  				       &tad_page_size);
>  	if (ret) {
> @@ -319,7 +351,6 @@ static int tad_pmu_probe(struct platform_device *pdev)
>  	tad_pmu->pmu = (struct pmu) {
>  
>  		.module		= THIS_MODULE,
> -		.attr_groups	= tad_pmu_attr_groups,
>  		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
>  				  PERF_PMU_CAP_NO_INTERRUPT,
>  		.task_ctx_nr	= perf_invalid_context,
> @@ -332,6 +363,13 @@ static int tad_pmu_probe(struct platform_device *pdev)
>  		.read		= tad_pmu_event_counter_read,
>  	};
>  
> +	if ((strncmp("marvell,cn10k-ddr-pmu", compatible,
> +		     strlen(compatible)) == 0)) {

How does this work with the ACPI ID added below?  Also, just
put this in the tables so device_get_match_data() can retrieve it
instead of string matching in here.


> +		tad_pmu->pmu.attr_groups = tad_pmu_attr_groups;
> +	} else {
> +		tad_pmu->pmu.attr_groups = ody_tad_pmu_attr_groups;
> +	}
> +
>  	tad_pmu->cpu = raw_smp_processor_id();
>  
>  	/* Register pmu instance for cpu hotplug */
> @@ -372,6 +410,7 @@ static const struct of_device_id tad_pmu_of_match[] = {
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id tad_pmu_acpi_match[] = {
>  	{"MRVL000B", 0},
> +	{"MRVL000D", 0},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(acpi, tad_pmu_acpi_match);


