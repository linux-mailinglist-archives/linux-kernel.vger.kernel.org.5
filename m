Return-Path: <linux-kernel+bounces-85412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF01186B58E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC81283A18
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21493FBA4;
	Wed, 28 Feb 2024 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iBqh9oS8"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624FB3FB80
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140015; cv=none; b=Ee+xGim5fNG8lpwdU3PYM4FdWRQkxV7LXNO7GxzWKwNvTEmKGZRBTNtrP4ErsBXjJYeQoRD2mYBxgrB2Ex+c25A7eDLFyL8p7/j5E6LyFkcrWtk4TVL3RJjl0iHY4bivfUOFn5CUlSjCAX4A5qKrPcHX8kgOMdBgNeS19pn1rJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140015; c=relaxed/simple;
	bh=UVR4EaMABM/htDkI/YWpKQyt6BMrH6EoY3lZhCa5nyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bh8tAZ4atFA5HfaElSJPtrdUcqDcfd750ElvMQP20owJPawQoI47cNHcHy9+poVjc7FcmPyXkWxDO31h49vS22s5ejUVtlAtYPb6alILTOKuotE/p91WBf1qaph9qJQwqXIr0xNBOWjKW+7QfQs6lXUqZdarzGIZe/aXnm5PDmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iBqh9oS8; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e332bc65b3so3268889b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709140013; x=1709744813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WFHtXFDlDHWgb7x7MqqruvZua5+x537Mh1k3qADbpRw=;
        b=iBqh9oS8g6uIGO0VkioGAP4SYIH/wMp4Z3KEJFA5KtR6rLKwPB53dEzLpXpZQhbmi8
         AgikK6RXoGlQSKXnRRNX7aV31WIuQAVbAMywuJolOX0Z0429FiX+NMtWxKZCNN0G1c3o
         MM/nBegclqmyLxGbLk7QaF9Osi8F2B4EIoTQinom11C15pZiUMAp3KvagEJAQZ738dw/
         LnXRQGu2Trz+AHoeotr/HUsn42Mk0Tt6Pr8tq00AGuHScuD9KPuc/7GxTqXM7rx7pcRR
         MICEMTvYzlXkTR5O9az5Rcx+UBSCp/UWXU6NyZssnfLVpTXBPqKdozQK8YTzQSgCZIkG
         QiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709140013; x=1709744813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFHtXFDlDHWgb7x7MqqruvZua5+x537Mh1k3qADbpRw=;
        b=JTbsK8hbSKufAp344GQblUIQ8gnr83Q7WJP+X/uQAxcTMY0Zt0EGa3czLQV8TgQKF5
         41SG1QUKifChJETeUSbTlCpvVcUOgcrxUHds584xIX/qY1HxCD/dw21yOPpwAzIkH+++
         te6C4zauCEq2ntp8gEXE0SdVfp+d9BvJvQ3mcOQPqzKaohSnyODcHs+jwIgEYQ6o6Kow
         veC4zA+YPToq7GSal6u9yG3T5YP686xxZwMAqbZWVIDk/T6+n4+5aL73IOciz8Mhb9D7
         2RdoykpgrmXyVwqXCaaFLJjyOdgD0rEnAj9RBbAfA2eerwWn4qWf2jPqbAb5J8HdqXiS
         9t7Q==
X-Forwarded-Encrypted: i=1; AJvYcCULnBsXlRrvjZ8cWi9pAqcKY4OhJxa2OfNw7xJQeNzOnZxEq8NOkZylmCeYckAJDPW1Zmguw1ioR90gsVyhzAn1x/Tgu1w1dwKMw7fH
X-Gm-Message-State: AOJu0Yx8IQbP0UsodMBINT/V5hmFSPDUKMmx4btyp5je3OpXpFUvoNY6
	dGsSokAazDhMeRNITtyEicfp4nKJ4z5WS6hoOXzENtf2ltdmKJntkYYy1GnRJ9Y=
X-Google-Smtp-Source: AGHT+IGUTrBosSI6pOEiV0utU/zlSRWcLnNKLdB5bs5Ix02glwI99H7F4D1FM8jhoLoO8E3LE4syxA==
X-Received: by 2002:aa7:93a1:0:b0:6e4:b4ca:992b with SMTP id x1-20020aa793a1000000b006e4b4ca992bmr187287pff.21.1709140012679;
        Wed, 28 Feb 2024 09:06:52 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:96d9:3aed:533c:8c94])
        by smtp.gmail.com with ESMTPSA id x125-20020a626383000000b006e4d8687f44sm8422772pfb.102.2024.02.28.09.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:06:52 -0800 (PST)
Date: Wed, 28 Feb 2024 10:06:49 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	michal.simek@amd.com, ben.levinsky@amd.com,
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 4/4] remoteproc: zynqmp: parse TCM from device tree
Message-ID: <Zd9oKWz073OJxKwp@p14s>
References: <20240219174437.3722620-1-tanmay.shah@amd.com>
 <20240219174437.3722620-10-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219174437.3722620-10-tanmay.shah@amd.com>

On Mon, Feb 19, 2024 at 09:44:37AM -0800, Tanmay Shah wrote:
> ZynqMP TCM information was fixed in driver. Now ZynqMP TCM information
> is available in device-tree. Parse TCM information in driver
> as per new bindings.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v11:
>   - Remove redundant initialization of the variable
>   - return correct error code if memory allocation failed

Where is that?  I looked really hard but couldn't find it.

> 
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 112 ++++++++++++++++++++++--
>  1 file changed, 107 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> index 42b0384d34f2..d4a22caebaad 100644
> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> @@ -74,8 +74,8 @@ struct mbox_info {
>  };
>  
>  /*
> - * Hardcoded TCM bank values. This will be removed once TCM bindings are
> - * accepted for system-dt specifications and upstreamed in linux kernel
> + * Hardcoded TCM bank values. This will stay in driver to maintain backward
> + * compatibility with device-tree that does not have TCM information.
>   */
>  static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
>  	{0xffe00000UL, 0x0, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
> @@ -757,6 +757,103 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
>  	return ERR_PTR(ret);
>  }
>  
> +static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
> +{
> +	int i, j, tcm_bank_count, ret, tcm_pd_idx, pd_count;
> +	struct of_phandle_args out_args;
> +	struct zynqmp_r5_core *r5_core;
> +	struct platform_device *cpdev;
> +	struct mem_bank_data *tcm;
> +	struct device_node *np;
> +	struct resource *res;
> +	u64 abs_addr, size;
> +	struct device *dev;
> +
> +	for (i = 0; i < cluster->core_count; i++) {
> +		r5_core = cluster->r5_cores[i];
> +		dev = r5_core->dev;
> +		np = r5_core->np;
> +
> +		pd_count = of_count_phandle_with_args(np, "power-domains",
> +						      "#power-domain-cells");
> +
> +		if (pd_count <= 0) {
> +			dev_err(dev, "invalid power-domains property, %d\n", pd_count);
> +			return -EINVAL;
> +		}
> +
> +		/* First entry in power-domains list is for r5 core, rest for TCM. */
> +		tcm_bank_count = pd_count - 1;
> +
> +		if (tcm_bank_count <= 0) {
> +			dev_err(dev, "invalid TCM count %d\n", tcm_bank_count);
> +			return -EINVAL;
> +		}
> +
> +		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
> +						  sizeof(struct mem_bank_data *),
> +						  GFP_KERNEL);
> +		if (!r5_core->tcm_banks)
> +			return -ENOMEM;
> +
> +		r5_core->tcm_bank_count = tcm_bank_count;
> +		for (j = 0, tcm_pd_idx = 1; j < tcm_bank_count; j++, tcm_pd_idx++) {
> +			tcm = devm_kzalloc(dev, sizeof(struct mem_bank_data),
> +					   GFP_KERNEL);
> +			if (!tcm)
> +				return -ENOMEM;
> +
> +			r5_core->tcm_banks[j] = tcm;
> +
> +			/* Get power-domains id of TCM. */
> +			ret = of_parse_phandle_with_args(np, "power-domains",
> +							 "#power-domain-cells",
> +							 tcm_pd_idx, &out_args);
> +			if (ret) {
> +				dev_err(r5_core->dev,
> +					"failed to get tcm %d pm domain, ret %d\n",
> +					tcm_pd_idx, ret);
> +				return ret;
> +			}
> +			tcm->pm_domain_id = out_args.args[0];
> +			of_node_put(out_args.np);
> +
> +			/* Get TCM address without translation. */
> +			ret = of_property_read_reg(np, j, &abs_addr, &size);
> +			if (ret) {
> +				dev_err(dev, "failed to get reg property\n");
> +				return ret;
> +			}
> +
> +			/*
> +			 * Remote processor can address only 32 bits
> +			 * so convert 64-bits into 32-bits. This will discard
> +			 * any unwanted upper 32-bits.
> +			 */
> +			tcm->da = (u32)abs_addr;
> +			tcm->size = (u32)size;
> +
> +			cpdev = to_platform_device(dev);
> +			res = platform_get_resource(cpdev, IORESOURCE_MEM, j);
> +			if (!res) {
> +				dev_err(dev, "failed to get tcm resource\n");
> +				return -EINVAL;
> +			}
> +
> +			tcm->addr = (u32)res->start;
> +			tcm->bank_name = (char *)res->name;
> +			res = devm_request_mem_region(dev, tcm->addr, tcm->size,
> +						      tcm->bank_name);
> +			if (!res) {
> +				dev_err(dev, "failed to request tcm resource\n");
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * zynqmp_r5_get_tcm_node()
>   * Ideally this function should parse tcm node and store information
> @@ -835,9 +932,14 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>  	struct zynqmp_r5_core *r5_core;
>  	int ret, i;
>  
> -	ret = zynqmp_r5_get_tcm_node(cluster);
> -	if (ret < 0) {
> -		dev_err(dev, "can't get tcm node, err %d\n", ret);
> +	r5_core = cluster->r5_cores[0];
> +	if (of_find_property(r5_core->np, "reg", NULL))
> +		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
> +	else
> +		ret = zynqmp_r5_get_tcm_node(cluster);
> +
> +	if (ret) {
> +		dev_err(dev, "can't get tcm, err %d\n", ret);
>  		return ret;
>  	}
>  
> -- 
> 2.25.1
> 

