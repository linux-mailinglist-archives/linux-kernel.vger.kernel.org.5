Return-Path: <linux-kernel+bounces-139020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 343C689FD9E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43130B2A2EF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E3617BB00;
	Wed, 10 Apr 2024 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWgCgCq8"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900AC37168
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768386; cv=none; b=XrXrn4eA2auFzGUYJWrHsaxoObE9sqU40ibuCa75Xw4TsOi07quQWZTyCBUQ75tFdzvbVpgEyeBaJfx816fqQxiqQbJ02DRvLGEBj3NbH0AnXRvXxJbOiXLYYXfXl52OGNIFveUpxlRrZJyuVwd2wMGxfEqn9qgH7JetUa3qNSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768386; c=relaxed/simple;
	bh=d9+0Flu3Z9XIbbu/++/vLCRyr+xe7f6CAwqFe4WYhD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOjqVqk23Ne9zT4YTwY26PrEGmfW7nZLO5ggbcyyw315NXkwLcgSHTNuWax0SfQqj6vmO6mx8jrzpXW+DxPQajaGFkZxy88/xc4g0Xj69d/oeAwZDq0E78LwleP1GTwJ7lyXSiA/Vzc3K31TnUUQFqupEuRRc+iac+/M4V24sMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DWgCgCq8; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ecfeefe94cso31933b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712768384; x=1713373184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h3gItgeLsk2aRGs3t/MREgHfzrOkwTRstIedEsXUwnU=;
        b=DWgCgCq8T/5AZy+QZHiId2nwgRibbI1FF/x23zKjpF2lgP2gUsSDRb1Hai3utzQWif
         l19Z20bXe2DgtWijfxnQ8s1iw0IslUClNsFK/9rVmDCpK0ThTPD+Hr+gMubJJf56XoSW
         B2TFNgpqJnFAbRjCIEl2pe1Iey42oA0+XbaqSS9faOgPqcFTdAdNZJ3jpi7aF3+X1BEJ
         btqPbSkZexi0lC26kQrTahVeeYYIRULhoNfIm67EenAVcV5YZEGVxSytagDb0SHfyUqb
         aj/1Fypvx3E7pkhwJVLQW7gAx8f0fCoy8rnWRCCXpRBlK5LAgX0GBGPhaNt6vjWqJKLB
         QocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712768384; x=1713373184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3gItgeLsk2aRGs3t/MREgHfzrOkwTRstIedEsXUwnU=;
        b=Ejf6DGrxgUJXx97ragFUSdaLvOtFBkNkT7qlRpadCvvp2B73rAk8I4tlZAVohNysdM
         BG7pUCt+7Ou9I397KBQEOVJz2dzQ+YxrjXnK6Tl7cwt4y04PcHvvjlJvA7N2FmAYTzYi
         Wm2ZfDQf0JNu73crKKBBvOAOEkmIdexIZMyQBtf7xbot7Te0bL6tFmijVSibUr/OhBnj
         LWxaH0633Eau2ohesOHZzGZyJgDo1Gx46MDIvT8Dygs/wmIKgB7Q3rHgFeRMV9nBRjpi
         3o1t9xzsprHFu1GSQaUyKerb2+jMMlL+u48pgGPvEuLYC3jmGkEFD73wWrbAyhy2OctH
         N2qw==
X-Forwarded-Encrypted: i=1; AJvYcCX7phzGhXBZN2StnVOE9GT4M6+10EW0pZGzc3KSWTh2HVOb5k7/brZdaJl9Qxi6yUiKBZM4/RImvhJhDbF4gZUWWHJZwCruCqkHkrhQ
X-Gm-Message-State: AOJu0Yyc0vEKV+iUUc/YX22AH+uuh41o3I2Df0qAv1jxYB/ezTb4PSgV
	Lf7C9pNrEXTNgeoK33BJyScikv+uDlulNjSgf/aXeD7FluAR3RKO5QMKxE3B+cg=
X-Google-Smtp-Source: AGHT+IE5o+gUZozO1h4woiYku5yj5y3nVSzJGKLeMDoZ2AlzdCShO3rGN6p/XCqyq50JVOiZlFJY7w==
X-Received: by 2002:a05:6a21:788d:b0:1a3:a821:f297 with SMTP id bf13-20020a056a21788d00b001a3a821f297mr300212pzc.2.1712768383787;
        Wed, 10 Apr 2024 09:59:43 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:2912:b981:fe1d:e9ef])
        by smtp.gmail.com with ESMTPSA id q22-20020aa79836000000b006ea6f189976sm10343619pfl.163.2024.04.10.09.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 09:59:43 -0700 (PDT)
Date: Wed, 10 Apr 2024 10:59:40 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	michal.simek@amd.com, ben.levinsky@amd.com,
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 4/4] remoteproc: zynqmp: parse TCM from device tree
Message-ID: <ZhbFfA7toAkUATfg@p14s>
References: <20240408205313.3552165-1-tanmay.shah@amd.com>
 <20240408205313.3552165-5-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408205313.3552165-5-tanmay.shah@amd.com>

On Mon, Apr 08, 2024 at 01:53:14PM -0700, Tanmay Shah wrote:
> ZynqMP TCM information was fixed in driver. Now ZynqMP TCM information
> is available in device-tree. Parse TCM information in driver
> as per new bindings.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v14:
>   - Add Versal platform support
>   - Add Versal-NET platform support
>   - Maintain backward compatibility for ZynqMP platform and use hardcode
>     TCM addresses
>   - Configure TCM based on xlnx,tcm-mode property for Versal
>   - Avoid TCM configuration if that property isn't available in DT 
> 
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 173 ++++++++++++++++++------
>  1 file changed, 132 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> index 0f942440b4e2..504492f930ac 100644
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
> @@ -300,36 +300,6 @@ static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid)
>  		dev_warn(dev, "failed to send message\n");
>  }
>  
> -/*
> - * zynqmp_r5_set_mode()
> - *
> - * set RPU cluster and TCM operation mode
> - *
> - * @r5_core: pointer to zynqmp_r5_core type object
> - * @fw_reg_val: value expected by firmware to configure RPU cluster mode
> - * @tcm_mode: value expected by fw to configure TCM mode (lockstep or split)
> - *
> - * Return: 0 for success and < 0 for failure
> - */
> -static int zynqmp_r5_set_mode(struct zynqmp_r5_core *r5_core,
> -			      enum rpu_oper_mode fw_reg_val,
> -			      enum rpu_tcm_comb tcm_mode)
> -{
> -	int ret;
> -
> -	ret = zynqmp_pm_set_rpu_mode(r5_core->pm_domain_id, fw_reg_val);
> -	if (ret < 0) {
> -		dev_err(r5_core->dev, "failed to set RPU mode\n");
> -		return ret;
> -	}
> -
> -	ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
> -	if (ret < 0)
> -		dev_err(r5_core->dev, "failed to configure TCM\n");
> -
> -	return ret;
> -}
> -
>  /*
>   * zynqmp_r5_rproc_start()
>   * @rproc: single R5 core's corresponding rproc instance
> @@ -761,6 +731,103 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
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
> @@ -839,9 +906,16 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>  	struct zynqmp_r5_core *r5_core;
>  	int ret, i;
>  
> -	ret = zynqmp_r5_get_tcm_node(cluster);
> -	if (ret < 0) {
> -		dev_err(dev, "can't get tcm node, err %d\n", ret);
> +	r5_core = cluster->r5_cores[0];
> +
> +	/* Maintain backward compatibility for zynqmp by using hardcode TCM address. */
> +	if (device_is_compatible(dev, "xlnx,zynqmp-r5fss"))

The previous patch moved the definition of the R5FSS to the new bindings but
this is forcing to use the old bindings - did I something?

> +		ret = zynqmp_r5_get_tcm_node(cluster);
> +	else
> +		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
> +
> +	if (ret) {
> +		dev_err(dev, "can't get tcm, err %d\n", ret);
>  		return ret;
>  	}
>  
> @@ -856,12 +930,18 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>  			return ret;
>  		}
>  
> -		ret = zynqmp_r5_set_mode(r5_core, fw_reg_val, tcm_mode);
> -		if (ret) {
> -			dev_err(dev, "failed to set r5 cluster mode %d, err %d\n",
> -				cluster->mode, ret);
> +		ret = zynqmp_pm_set_rpu_mode(r5_core->pm_domain_id, fw_reg_val);
> +		if (ret < 0) {
> +			dev_err(r5_core->dev, "failed to set RPU mode\n");
>  			return ret;
>  		}
> +
> +		if (device_is_compatible(dev, "xlnx,zynqmp-r5fss") ||
> +		    of_find_property(dev_of_node(dev), "xlnx,tcm-mode", NULL)) {
> +			ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
> +			if (ret < 0)
> +				dev_err(r5_core->dev, "failed to configure TCM\n");
> +		}
>  	}
>  
>  	return 0;
> @@ -906,16 +986,25 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>  	 * fail driver probe if either of that is not set in dts.
>  	 */
>  	if (cluster_mode == LOCKSTEP_MODE) {
> -		tcm_mode = PM_RPU_TCM_COMB;
>  		fw_reg_val = PM_RPU_MODE_LOCKSTEP;
>  	} else if (cluster_mode == SPLIT_MODE) {
> -		tcm_mode = PM_RPU_TCM_SPLIT;
>  		fw_reg_val = PM_RPU_MODE_SPLIT;
>  	} else {
>  		dev_err(dev, "driver does not support cluster mode %d\n", cluster_mode);
>  		return -EINVAL;
>  	}
>  
> +	if (device_is_compatible(dev, "xlnx,zynqmp-r5fss")) {
> +		if (cluster_mode == LOCKSTEP_MODE)
> +			tcm_mode = PM_RPU_TCM_COMB;
> +		else
> +			tcm_mode = PM_RPU_TCM_SPLIT;
> +	} else if (of_find_property(dev_node, "xlnx,tcm-mode", NULL)) {
> +		ret = of_property_read_u32(dev_node, "xlnx,tcm-mode", (u32 *)&tcm_mode);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	/*
>  	 * Number of cores is decided by number of child nodes of
>  	 * r5f subsystem node in dts. If Split mode is used in dts
> @@ -1100,6 +1189,8 @@ static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
>  /* Match table for OF platform binding */
>  static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
>  	{ .compatible = "xlnx,zynqmp-r5fss", },
> +	{ .compatible = "xlnx,versal-r5fss", },
> +	{ .compatible = "xlnx,versal-net-r52fss", },
>  	{ /* end of list */ },
>  };
>  MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
> -- 
> 2.25.1
> 

