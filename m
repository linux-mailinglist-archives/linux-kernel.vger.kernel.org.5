Return-Path: <linux-kernel+bounces-31119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342C4832946
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88C33B23F36
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7994F1EF;
	Fri, 19 Jan 2024 11:54:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418D04C600;
	Fri, 19 Jan 2024 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705665242; cv=none; b=grpn8djGlC7MvZVP63b97TLhbzlIQUKzIph/gWVqFsvRmSwzEHzR/1VIwf8dsxbNPq00b/v72Ex2+S/txLzA/aHmd3dUNC7dKmVDUExCvSCxKfbPWGlPlSRHL1qSv+82dasu21jQb6e21tRQy0LGJGcOGT1Sz/dqCKlC+RVzBT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705665242; c=relaxed/simple;
	bh=vXd4CS3Mkgr2/80T6FU3At1o3GqlfUnp+12tHmpsRdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RgSfXh63MLgXOqR4tB0MQ52gms9fBhitiGLRjPJDbZ/x2IWGWhhkfGzlLNdEgdUrI7HM1BAbUSci4Ohjt3fU1KXclWKVtYsX3D7FDqqWlplkgAm3kRz2EYx9/O7wu8+OegvX6uANixoPwPo/nx65YRPgVkDRnZg88d0n13A2dQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9084A1042;
	Fri, 19 Jan 2024 03:54:44 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C45443F73F;
	Fri, 19 Jan 2024 03:53:53 -0800 (PST)
Message-ID: <03e056cd-bdbc-4807-b86c-0f5b554aac73@arm.com>
Date: Fri, 19 Jan 2024 11:53:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] coresight-tpdm: Add support to configure CMB
Content-Language: en-US
To: Tao Zhang <quic_taozha@quicinc.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Konrad Dybcio <konradybcio@gmail.com>, Mike Leach <mike.leach@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Jinlong Mao <quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Trilok Soni <quic_tsoni@quicinc.com>, Song Chai <quic_songchai@quicinc.com>,
 linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1705634583-17631-1-git-send-email-quic_taozha@quicinc.com>
 <1705634583-17631-7-git-send-email-quic_taozha@quicinc.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1705634583-17631-7-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/01/2024 03:22, Tao Zhang wrote:
> TPDM CMB subunits support two forms of CMB data set element creation:
> continuous and trace-on-change collection mode. Continuous change
> creates CMB data set elements on every CMBCLK edge. Trace-on-change
> creates CMB data set elements only when a new data set element differs
> in value from the previous element in a CMB data set. Set CMB_CR.MODE
> to 0 for continuous CMB collection mode. Set CMB_CR.MODE to 1 for
> trace-on-change CMB collection mode.
> 
> Reviewed-by: James Clark <james.clark@arm.com>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Jinlong Mao <quic_jinlmao@quicinc.com>
> ---
>   .../testing/sysfs-bus-coresight-devices-tpdm  | 14 +++++
>   drivers/hwtracing/coresight/coresight-tpdm.c  | 61 +++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpdm.h  | 12 ++++
>   3 files changed, 87 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index 4dd49b159543..3ae21ccf3f29 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -170,3 +170,17 @@ Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_t
>   Description:
>   		(RW) Set/Get the MSR(mux select register) for the DSB subunit
>   		TPDM.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_mode
> +Date:		March 2023
> +KernelVersion	6.7
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:	(Write) Set the data collection mode of CMB tpdm. Continuous
> +		change creates CMB data set elements on every CMBCLK edge.
> +		Trace-on-change creates CMB data set elements only when a new
> +		data set element differs in value from the previous element
> +		in a CMB data set.
> +
> +		Accepts only one of the 2 values -  0 or 1.
> +		0 : Continuous CMB collection mode.
> +		1 : Trace-on-change CMB collection mode.
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 424a2f724d82..b55aee65a856 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -137,6 +137,18 @@ static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
>   	return 0;
>   }
>   
> +static umode_t tpdm_cmb_is_visible(struct kobject *kobj,
> +				   struct attribute *attr, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	if (drvdata && tpdm_has_cmb_dataset(drvdata))
> +		return attr->mode;
> +
> +	return 0;
> +}
> +
>   static umode_t tpdm_dsb_msr_is_visible(struct kobject *kobj,
>   				       struct attribute *attr, int n)
>   {
> @@ -161,6 +173,9 @@ static void tpdm_reset_datasets(struct tpdm_drvdata *drvdata)
>   		drvdata->dsb->trig_ts = true;
>   		drvdata->dsb->trig_type = false;
>   	}
> +
> +	if (tpdm_has_cmb_dataset(drvdata))

This could simply be gated on drvdata->cmb for extra safety ?

	if (drvdata->cmb)
		
> +		memset(drvdata->cmb, 0, sizeof(struct cmb_dataset));
>   }
>   
>   static void set_dsb_mode(struct tpdm_drvdata *drvdata, u32 *val)
> @@ -389,6 +404,12 @@ static int tpdm_datasets_setup(struct tpdm_drvdata *drvdata)
>   		if (!drvdata->dsb)
>   			return -ENOMEM;
>   	}
> +	if (tpdm_has_cmb_dataset(drvdata) && (!drvdata->cmb)) {
> +		drvdata->cmb = devm_kzalloc(drvdata->dev,
> +						sizeof(*drvdata->cmb), GFP_KERNEL);
> +		if (!drvdata->cmb)
> +			return -ENOMEM;
> +	}
>   	tpdm_reset_datasets(drvdata);
>   
>   	return 0;
> @@ -727,6 +748,35 @@ static ssize_t dsb_trig_ts_store(struct device *dev,
>   }
>   static DEVICE_ATTR_RW(dsb_trig_ts);
>   
> +static ssize_t cmb_mode_show(struct device *dev,
> +			     struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	return sysfs_emit(buf, "%x\n",
> +			  drvdata->cmb->trace_mode);

minor nit: Don't need to split the line here. Also, for completeness, 
you need to read it under spinlock, use guard() to unlock implicitly.

> +
> +}
> +
> +static ssize_t cmb_mode_store(struct device *dev,
> +			      struct device_attribute *attr,
> +			      const char *buf,
> +			      size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long trace_mode;
> +
> +	if ((kstrtoul(buf, 0, &trace_mode)) || (trace_mode & ~1UL))

minor nit: drop () around kstrtoul()

Rest looks fine.

Suzuki

> +		return -EINVAL;
> +
> +	spin_lock(&drvdata->spinlock);
> +	drvdata->cmb->trace_mode = trace_mode;
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(cmb_mode);
> +
>   static struct attribute *tpdm_dsb_edge_attrs[] = {
>   	&dev_attr_ctrl_idx.attr,
>   	&dev_attr_ctrl_val.attr,
> @@ -843,6 +893,11 @@ static struct attribute *tpdm_dsb_attrs[] = {
>   	NULL,
>   };
>   
> +static struct attribute *tpdm_cmb_attrs[] = {
> +	&dev_attr_cmb_mode.attr,
> +	NULL,
> +};
> +
>   static struct attribute_group tpdm_dsb_attr_grp = {
>   	.attrs = tpdm_dsb_attrs,
>   	.is_visible = tpdm_dsb_is_visible,
> @@ -872,6 +927,11 @@ static struct attribute_group tpdm_dsb_msr_grp = {
>   	.name = "dsb_msr",
>   };
>   
> +static struct attribute_group tpdm_cmb_attr_grp = {
> +	.attrs = tpdm_cmb_attrs,
> +	.is_visible = tpdm_cmb_is_visible,
> +};
> +
>   static const struct attribute_group *tpdm_attr_grps[] = {
>   	&tpdm_attr_grp,
>   	&tpdm_dsb_attr_grp,
> @@ -879,6 +939,7 @@ static const struct attribute_group *tpdm_attr_grps[] = {
>   	&tpdm_dsb_trig_patt_grp,
>   	&tpdm_dsb_patt_grp,
>   	&tpdm_dsb_msr_grp,
> +	&tpdm_cmb_attr_grp,
>   	NULL,
>   };
>   
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index a442d9c6e4ac..2af92c270ed1 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -14,6 +14,8 @@
>   
>   /* Enable bit for CMB subunit */
>   #define TPDM_CMB_CR_ENA		BIT(0)
> +/* Trace collection mode for CMB subunit */
> +#define TPDM_CMB_CR_MODE	BIT(1)
>   
>   /* DSB Subunit Registers */
>   #define TPDM_DSB_CR		(0x780)
> @@ -181,6 +183,14 @@ struct dsb_dataset {
>   	bool			trig_type;
>   };
>   
> +/**
> + * struct cmb_dataset
> + * @trace_mode:       Dataset collection mode
> + */
> +struct cmb_dataset {
> +	u32			trace_mode;
> +};
> +
>   /**
>    * struct tpdm_drvdata - specifics associated to an TPDM component
>    * @base:       memory mapped base address for this component.
> @@ -190,6 +200,7 @@ struct dsb_dataset {
>    * @enable:     enable status of the component.
>    * @datasets:   The datasets types present of the TPDM.
>    * @dsb         Specifics associated to TPDM DSB.
> + * @cmb         Specifics associated to TPDM CMB.
>    * @dsb_msr_num Number of MSR supported by DSB TPDM
>    */
>   
> @@ -201,6 +212,7 @@ struct tpdm_drvdata {
>   	bool			enable;
>   	unsigned long		datasets;
>   	struct dsb_dataset	*dsb;
> +	struct cmb_dataset	*cmb;
>   	u32			dsb_msr_num;
>   };
>   


