Return-Path: <linux-kernel+bounces-42664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C3D840490
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7AA71C21B8F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA465FB84;
	Mon, 29 Jan 2024 12:04:45 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF7B5EE62
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529885; cv=none; b=gr8PIeLZU9qgnZQkYH82rUuo9icM5aLVP3JIArde62f0St6Vy5NNnyxKzWPdMGvEwBtGs4MuwJLVIiWy/snhr9abs4LpCmj9Z9MVo2418t3wTJaDg/1h1rR99+azoj4TJzS/NVTVcgtgTzIOJGAzVOzwfMuLHPDP7XCVKPd62RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529885; c=relaxed/simple;
	bh=DdrItSI39RlJlKXaJ+PYOHtGgPOJz+tv1R3+NS6vEpo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BvX+FmPQua2GtxyXpii/sQXbJptkS6DV/E8K7QSpUA4gEN0XKuN1BcxBKDyhQf0N9iAxzdpA9k5+qvk3FeOIcaiD4KtXBFqEzKL4S54kerhUVM3rfpzg5NOynoKLzxtvsD+v9SoGRMDlDAVYA3iUDyZZMIMpx0jfz+hszcfNkSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TNn303gtPz6K5yj;
	Mon, 29 Jan 2024 20:01:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F1871400CD;
	Mon, 29 Jan 2024 20:04:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Jan
 2024 12:04:37 +0000
Date: Mon, 29 Jan 2024 12:04:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<sgoutham@marvell.com>, <bbhushan2@marvell.com>, <george.cherian@marvell.com>
Subject: Re: [PATCH v3 1/2] perf/marvell: Odyssey DDR Performance monitor
 support
Message-ID: <20240129120436.00000f18@Huawei.com>
In-Reply-To: <20240122124933.1311925-2-gthiagarajan@marvell.com>
References: <20240122124933.1311925-1-gthiagarajan@marvell.com>
	<20240122124933.1311925-2-gthiagarajan@marvell.com>
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

On Mon, 22 Jan 2024 18:19:32 +0530
Gowthami Thiagarajan <gthiagarajan@marvell.com> wrote:

> Odyssey DRAM Subsystem supports eight counters for monitoring performance
> and software can program those counters to monitor any of the defined
> performance events. Supported performance events include those counted
> at the interface between the DDR controller and the PHY, interface between
> the DDR Controller and the CHI interconnect, or within the DDR Controller.
> 
> Additionally DSS also supports two fixed performance event counters, one
> for ddr reads and the other for ddr writes.
> 
> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
Hi Gowthami,

A quick drive by review.
Questions like whether this patch should be split are down to the perf maintainers.
I would ask for it, but not my area of the kernel ;)

Jonathan


> +#define VERSION_V1				1
> +#define VERSION_V2				2

Prefix these defines + perhaps make them an enum?

> +
>  struct cn10k_ddr_pmu {
>  	struct pmu pmu;
>  	void __iomem *base;
> +	struct ddr_pmu_platform_data *p_data;

const both because it should be and to avoid casting away the const.


> +	int version;
>  	unsigned int cpu;
>  	struct	device *dev;
>  	int active_events;
> @@ -134,6 +160,54 @@ struct cn10k_ddr_pmu {
>  
>  #define to_cn10k_ddr_pmu(p)	container_of(p, struct cn10k_ddr_pmu, pmu)
>  
> +struct ddr_pmu_platform_data {
> +	u64 counter_overflow_val;
> +	u64 counter_max_val;
> +	u64 ddrc_perf_cnt_base;
> +	u64 ddrc_perf_cfg_base;
> +	u64 ddrc_perf_cnt_op_mode_ctrl;

Good to name these in a fashion that makes it clear what they are.
Some are values, some are register address offsets I think?

Shy is ddrc_perf prefix useful in here?


> +	u64 ddrc_perf_cnt_start_op_ctrl;
> +	u64 ddrc_perf_cnt_end_op_ctrl;
> +	u64 ddrc_perf_cnt_end_status;
> +	u64 ddrc_perf_cnt_freerun_en;
> +	u64 ddrc_perf_cnt_freerun_ctrl;
> +	u64 ddrc_perf_cnt_freerun_clr;
> +	u64 ddrc_perf_cnt_value_wr_op;
> +	u64 ddrc_perf_cnt_value_rd_op;
> +};
> +
> +static const struct ddr_pmu_platform_data cn10k_ddr_pmu_pdata = {
> +	.counter_overflow_val =  BIT_ULL(48),
> +	.counter_max_val = GENMASK_ULL(48, 0),
> +	.ddrc_perf_cnt_base = CN10K_DDRC_PERF_CNT_VALUE_BASE,
> +	.ddrc_perf_cfg_base = CN10K_DDRC_PERF_CFG_BASE,
> +	.ddrc_perf_cnt_op_mode_ctrl = CN10K_DDRC_PERF_CNT_OP_MODE_CTRL,
> +	.ddrc_perf_cnt_start_op_ctrl = CN10K_DDRC_PERF_CNT_START_OP_CTRL,
> +	.ddrc_perf_cnt_end_op_ctrl = CN10K_DDRC_PERF_CNT_END_OP_CTRL,
> +	.ddrc_perf_cnt_end_status = CN10K_DDRC_PERF_CNT_END_STATUS,
> +	.ddrc_perf_cnt_freerun_en = CN10K_DDRC_PERF_CNT_FREERUN_EN,
> +	.ddrc_perf_cnt_freerun_ctrl = CN10K_DDRC_PERF_CNT_FREERUN_CTRL,
> +	.ddrc_perf_cnt_freerun_clr = 0,
> +	.ddrc_perf_cnt_value_wr_op = CN10K_DDRC_PERF_CNT_VALUE_WR_OP,
> +	.ddrc_perf_cnt_value_rd_op = CN10K_DDRC_PERF_CNT_VALUE_RD_OP,
> +};
> +
> +static const struct ddr_pmu_platform_data odyssey_ddr_pmu_pdata = {
> +	.counter_overflow_val = 0,
> +	.counter_max_val = GENMASK_ULL(63, 0),
> +	.ddrc_perf_cnt_base = ODY_DDRC_PERF_CNT_VALUE_BASE,
> +	.ddrc_perf_cfg_base = ODY_DDRC_PERF_CFG_BASE,
> +	.ddrc_perf_cnt_op_mode_ctrl = ODY_DDRC_PERF_CNT_OP_MODE_CTRL,
> +	.ddrc_perf_cnt_start_op_ctrl = ODY_DDRC_PERF_CNT_START_OP_CTRL,
> +	.ddrc_perf_cnt_end_op_ctrl = ODY_DDRC_PERF_CNT_END_OP_CTRL,
> +	.ddrc_perf_cnt_end_status = ODY_DDRC_PERF_CNT_END_STATUS,
> +	.ddrc_perf_cnt_freerun_en = 0,
> +	.ddrc_perf_cnt_freerun_ctrl = ODY_DDRC_PERF_CNT_FREERUN_CTRL,
> +	.ddrc_perf_cnt_freerun_clr = ODY_DDRC_PERF_CNT_FREERUN_CLR,
> +	.ddrc_perf_cnt_value_wr_op = ODY_DDRC_PERF_CNT_VALUE_WR_OP,
> +	.ddrc_perf_cnt_value_rd_op = ODY_DDRC_PERF_CNT_VALUE_RD_OP,
> +};


..

> -static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap)
> +static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap,
> +				     struct cn10k_ddr_pmu *ddr_pmu)
>  {
> +	int ret = 0;
> +
>  	switch (eventid) {
>  	case EVENT_HIF_RD_OR_WR ... EVENT_WAW_HAZARD:
>  	case EVENT_OP_IS_REFRESH ... EVENT_OP_IS_ZQLATCH:
>  		*event_bitmap = (1ULL << (eventid - 1));
>  		break;
> +	case EVENT_DFI_PARITY_POISON ...EVENT_DFI_CMD_IS_RETRY:
> +		if (ddr_pmu->version == VERSION_V2) {
> +			*event_bitmap = (1ULL << (eventid - 1));
> +		} else {
> +			pr_err("%s Invalid eventid %d\n", __func__, eventid);
> +			ret = -EINVAL;
> +		}
> +		break;
>  	case EVENT_OP_IS_ENTER_SELFREF:
>  	case EVENT_OP_IS_ENTER_POWERDOWN:
>  	case EVENT_OP_IS_ENTER_MPSM:
> @@ -280,10 +451,10 @@ static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap)
>  		break;
>  	default:
>  		pr_err("%s Invalid eventid %d\n", __func__, eventid);
> -		return -EINVAL;
> +		ret = -EINVAL;
>  	}
>  
> -	return 0;
> +	return ret;
Why?  Just return in the various paths above. 

Direct returns make for easier to review code as you can follow a particular path through
more quickly.

>  }

>  static void cn10k_ddr_perf_pmu_disable(struct pmu *pmu)
>  {
>  	struct cn10k_ddr_pmu *ddr_pmu = to_cn10k_ddr_pmu(pmu);
> +	struct ddr_pmu_platform_data *p_data = ddr_pmu->p_data;
>  
>  	writeq_relaxed(END_OP_CTRL_VAL_END, ddr_pmu->base +
> -		       DDRC_PERF_CNT_END_OP_CTRL);
> +		       p_data->ddrc_perf_cnt_end_op_ctrl);
>  }
>  
>  static void cn10k_ddr_perf_event_update_all(struct cn10k_ddr_pmu *pmu)
> @@ -549,6 +778,7 @@ static void cn10k_ddr_perf_event_update_all(struct cn10k_ddr_pmu *pmu)
>  
>  static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
>  {
> +	struct ddr_pmu_platform_data *p_data = pmu->p_data;
>  	struct perf_event *event;
>  	struct hw_perf_event *hwc;
>  	u64 prev_count, new_count;
> @@ -561,7 +791,8 @@ static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
>  		prev_count = local64_read(&hwc->prev_count);
>  		new_count = cn10k_ddr_perf_read_counter(pmu, hwc->idx);
>  
> -		/* Overflow condition is when new count less than
> +		/*
> +		 * Overflow condition is when new count less than
>  		 * previous count
>  		 */
>  		if (new_count < prev_count)
> @@ -574,7 +805,8 @@ static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
>  		prev_count = local64_read(&hwc->prev_count);
>  		new_count = cn10k_ddr_perf_read_counter(pmu, hwc->idx);
>  
> -		/* Overflow condition is when new count less than
> +		/*
> +		 * Overflow condition is when new count less than

Good to fix this, but not in a patch doing anything meaningful. If you want
to make comment syntax changes - separate patch.

>  		 * previous count
>  		 */
>  		if (new_count < prev_count)
> @@ -586,11 +818,23 @@ static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
>  			continue;
>  
>  		value = cn10k_ddr_perf_read_counter(pmu, i);
> -		if (value == DDRC_PERF_CNT_MAX_VALUE) {
> +		if (value == p_data->counter_max_val) {
>  			pr_info("Counter-(%d) reached max value\n", i);
> -			cn10k_ddr_perf_event_update_all(pmu);
> -			cn10k_ddr_perf_pmu_disable(&pmu->pmu);
> -			cn10k_ddr_perf_pmu_enable(&pmu->pmu);
> +			/*
> +			 * As separate control register is added for each
> +			 * counter in odyssey, no need to update all
> +			 * the events
> +			 */
> +			if (pmu->version == VERSION_V2) {

This sort of version difference is often better handled via a callback
in the your pdata structure.  Makes it easy to add a new one for v3 :)

> +				cn10k_ddr_perf_event_update(pmu->events[i]);
> +				cn10k_ddr_perf_counter_stop(pmu, i);
> +				cn10k_ddr_perf_counter_start(pmu, i);
> +
> +			} else {
> +				cn10k_ddr_perf_event_update_all(pmu);
> +				cn10k_ddr_perf_pmu_disable(&pmu->pmu);
> +				cn10k_ddr_perf_pmu_enable(&pmu->pmu);
> +			}
>  		}
>  	}
>  
> @@ -631,7 +875,10 @@ static int cn10k_ddr_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>  
>  static int cn10k_ddr_perf_probe(struct platform_device *pdev)
>  {
> +	struct ddr_pmu_platform_data *pltfm_data;
> +	struct device *dev = &pdev->dev;
>  	struct cn10k_ddr_pmu *ddr_pmu;
> +	const char  *compatible;
>  	struct resource *res;
>  	void __iomem *base;
>  	char *name;
> @@ -642,6 +889,14 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	ddr_pmu->dev = &pdev->dev;
> +
> +	pltfm_data = (struct ddr_pmu_platform_data *)
> +		      device_get_match_data(&pdev->dev);

Shouldn't need the cast as it's a const void *
and you should not need to modify it in here (so make your
data types 
const struct ddr_pmu_platform * 



> +	if (!pltfm_data) {
> +		dev_err(&pdev->dev, "Error: No device match data found\n");
> +		return -ENODEV;
> +	}
> +	ddr_pmu->p_data = pltfm_data;
>  	platform_set_drvdata(pdev, ddr_pmu);
>  
>  	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> @@ -650,25 +905,59 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
>  
>  	ddr_pmu->base = base;
>  
> -	/* Setup the PMU counter to work in manual mode */
> -	writeq_relaxed(OP_MODE_CTRL_VAL_MANNUAL, ddr_pmu->base +
> -		       DDRC_PERF_CNT_OP_MODE_CTRL);
> -
> -	ddr_pmu->pmu = (struct pmu) {
> -		.module	      = THIS_MODULE,
> -		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
> -		.task_ctx_nr = perf_invalid_context,
> -		.attr_groups = cn10k_attr_groups,
> -		.event_init  = cn10k_ddr_perf_event_init,
> -		.add	     = cn10k_ddr_perf_event_add,
> -		.del	     = cn10k_ddr_perf_event_del,
> -		.start	     = cn10k_ddr_perf_event_start,
> -		.stop	     = cn10k_ddr_perf_event_stop,
> -		.read	     = cn10k_ddr_perf_event_update,
> -		.pmu_enable  = cn10k_ddr_perf_pmu_enable,
> -		.pmu_disable = cn10k_ddr_perf_pmu_disable,
> -	};
> +	ret = device_property_read_string(dev, "compatible", &compatible);
> +	if (ret) {
> +		pr_err("compatible property not found\n");
> +		return ret;
> +	}
>  
> +	if ((strncmp("marvell,cn10k-ddr-pmu", compatible,
> +		     strlen(compatible)) == 0))

Why not just embed this in your pdata structure?
Even better would be add data to reflect the actual differences
rather than relying on a 'version' number.  It tends to be more
extensible as new implementations surface to encode each difference
as data in such a structure.  Otherwise, in the long run you
end up with big switch statements for the many different versions
which just provide some per version constants.  That's messy.


> +		ddr_pmu->version = VERSION_V1;
> +	else
> +		ddr_pmu->version = VERSION_V2;
> +
> +	if (ddr_pmu->version == VERSION_V1) {
> +		ddr_pmu->pmu = (struct pmu) {
> +			.module	      = THIS_MODULE,
> +			.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
> +			.task_ctx_nr = perf_invalid_context,
> +			.attr_groups = cn10k_attr_groups,
> +			.event_init  = cn10k_ddr_perf_event_init,
> +			.add	     = cn10k_ddr_perf_event_add,
> +			.del	     = cn10k_ddr_perf_event_del,
> +			.start	     = cn10k_ddr_perf_event_start,
> +			.stop	     = cn10k_ddr_perf_event_stop,
> +			.read	     = cn10k_ddr_perf_event_update,
> +			.pmu_enable  = cn10k_ddr_perf_pmu_enable,
> +			.pmu_disable = cn10k_ddr_perf_pmu_disable,
> +		};
> +
> +	/*
> +	 * As we have separate control registers for each counter in Odyssey,
> +	 * setting up the mode will be done when we enable each counter
> +	 *

Trivial: Odd formatting. I'd drop the blank commented line and add a full stop.

> +	 */
> +
> +	/* Setup the PMU counter to work in manual mode */
> +		writeq(OP_MODE_CTRL_VAL_MANUAL, ddr_pmu->base +
> +		      (ddr_pmu->p_data->ddrc_perf_cnt_op_mode_ctrl));
> +	} else {
> +		ddr_pmu->pmu = (struct pmu) {
> +			.module       = THIS_MODULE,
> +			.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
> +			.task_ctx_nr = perf_invalid_context,
> +			.attr_groups = odyssey_attr_groups,
> +			.event_init  = cn10k_ddr_perf_event_init,
> +			.add         = cn10k_ddr_perf_event_add,
> +			.del         = cn10k_ddr_perf_event_del,
> +			.start       = cn10k_ddr_perf_event_start,
> +			.stop        = cn10k_ddr_perf_event_stop,
> +			.read        = cn10k_ddr_perf_event_update,
> +			.pmu_enable  = NULL,
> +			.pmu_disable = NULL,

No need to set these to NULL.  Not providing them has same result and
I don't think there is any particular value wrt to 'documentation' of
setting them explicitly.  If there is a reason this needs calling out
I'd expect a comment explaining why.

Ideal patch series structure for changes like this patch makes would be:
1) Refactor to pull out the pdata - no functional change.
2) Patch adding the support for the new device.

Result is easier to review than the combination of the two changes.


> +		};
> +	}

