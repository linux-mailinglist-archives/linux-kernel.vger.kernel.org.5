Return-Path: <linux-kernel+bounces-15843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9B8823434
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01471F24796
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096BF1C696;
	Wed,  3 Jan 2024 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5Y15G8y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05711CA8B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d4ba539f6cso19899725ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 10:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704305836; x=1704910636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D3rgTpCUDgPB4Cy8NgFDhEAQ1mbTQkJOhdsy502inPg=;
        b=Q5Y15G8ycRY6YZebI5IuGrGRPUFo9/auy3QwDvuYJ8CpHTs7TnHs/ve/XdBfH6Bdjm
         Bk8D/ikmfCkCbu7K1rnatg4nj9Aha9JDnnfHCD8sIdxAFYwBdPn1nFXeJRV2yI4kSiTX
         TzW52ZfrdeVc9gOSLnsiYTX8zPM12eS6Beo3tgH51fOHIH0cCVDzYNH/Qtjjgj3DOlyN
         Y7O1BO8O47vk4KgE1ubHDV9WzqbU5Mb7DwHJVYYS7zSBzX9ENa34veT03Kuc5Um5k/X0
         QzepGlpd/whRCRmEuWnFHKRZxrHdXnGjd2Aogayd1/fAnhqgu3lwOgeqjlK/lk0x3jUM
         +gRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704305836; x=1704910636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3rgTpCUDgPB4Cy8NgFDhEAQ1mbTQkJOhdsy502inPg=;
        b=HXVZD+zdgjY+6lb/DBXaY/97OZcZ/kOtcfTSxpFmlpwOBOLy2Q5b6OucriJLuhj54q
         x4KYpMwfnExFRwrTRt+3gDVcdecn+pjdctgHYsK3EbD0bMhGGMTIchmTd1L+0vOUT92z
         JOMooLa8tNZapBe5m572wTSrnXedyMsvb07NMMrjDzeIouOYXlBgV65zcLZ51tsfhCzW
         wpy5t3//WiGtsgDI2ELXD9tXl0EO7ZRiAed17RY2aBeoEQVH2NJE1eob0g8MPGOS3VZf
         P79CZNodr99/dxrsfAl2F/XILhXCSgPqnje95ggw5QY9OJ89X6puGtArjikWe+OtJ/Ds
         zp9A==
X-Gm-Message-State: AOJu0Yy7uHcpk9OYBrPp4Qi/GSEUWw1hqgkSo3ouGpx569tmgCKCxRDG
	nxsQSejwPFM1H2u8ZJLdbiYBNWhTP2L1DkPY0KuXnke7CdA=
X-Google-Smtp-Source: AGHT+IGHjadNPXX/3iWAkEBIfSUYeUkR/7ZVvVSS9grXrqNieaHIK1/VviWokcynSptX8yu47Qd4sw==
X-Received: by 2002:a17:902:ecc8:b0:1d4:152b:dd8e with SMTP id a8-20020a170902ecc800b001d4152bdd8emr22976430plh.108.1704305836138;
        Wed, 03 Jan 2024 10:17:16 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:d745:ffcc:b786:a182])
        by smtp.gmail.com with ESMTPSA id f10-20020a170902ce8a00b001d347a98e7asm23991924plg.260.2024.01.03.10.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 10:17:15 -0800 (PST)
Date: Wed, 3 Jan 2024 11:17:13 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	michal.simek@amd.com, ben.levinsky@amd.com,
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/3] remoteproc: zynqmp: parse TCM from device tree
Message-ID: <ZZWkqYNqR2/Qq54m@p14s>
References: <20231215235725.1247350-1-tanmay.shah@amd.com>
 <20231215235725.1247350-4-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215235725.1247350-4-tanmay.shah@amd.com>

On Fri, Dec 15, 2023 at 03:57:25PM -0800, Tanmay Shah wrote:
> ZynqMP TCM information is fixed in driver. Now ZynqMP TCM information

s/"is fixed in driver"/"was fixed in driver"

> is available in device-tree. Parse TCM information in driver
> as per new bindings.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v8:
>   - parse power-domains property from device-tree and use EEMI calls
>     to power on/off TCM instead of using pm domains framework
>   - Remove checking of pm_domain_id validation to power on/off tcm
>   - Remove spurious change
> 
> Changes in v7:
>   - move checking of pm_domain_id from previous patch
>   - fix mem_bank_data memory allocation
> 
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 154 +++++++++++++++++++++++-
>  1 file changed, 148 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> index 4395edea9a64..36d73dcd93f0 100644
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
> @@ -878,6 +878,139 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
>  	return ERR_PTR(ret);
>  }
>  
> +static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
> +{
> +	struct of_phandle_args out_args;
> +	int tcm_reg_per_r5, tcm_pd_idx;
> +	struct zynqmp_r5_core *r5_core;
> +	int i, j, tcm_bank_count, ret;
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
> +		np = of_node_get(dev_of_node(dev));
> +		tcm_pd_idx = 1;
> +
> +		/* we have address cell 2 and size cell as 2 */
> +		tcm_reg_per_r5 = of_property_count_elems_of_size(np, "reg",
> +								 4 * sizeof(u32));
> +		if (tcm_reg_per_r5 <= 0) {
> +			dev_err(dev, "can't get reg property err %d\n", tcm_reg_per_r5);
> +			return -EINVAL;
> +		}
> +
> +		/*
> +		 * In lockstep mode, r5 core 0 will use r5 core 1 TCM
> +		 * power domains as well. so allocate twice of per core TCM

Twice of what?  Please use proper english in your multi line comments, i.e a
capital letter for the first word and a dot at the end.  

> +		 */
> +		if (cluster->mode == LOCKSTEP_MODE)
> +			tcm_bank_count = tcm_reg_per_r5 * 2;
> +		else
> +			tcm_bank_count = tcm_reg_per_r5;
> +
> +		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
> +						  sizeof(struct mem_bank_data *),
> +						  GFP_KERNEL);
> +		if (!r5_core->tcm_banks)
> +			ret = -ENOMEM;
> +
> +		r5_core->tcm_bank_count = tcm_bank_count;
> +		for (j = 0; j < tcm_bank_count; j++) {
> +			tcm = devm_kzalloc(dev, sizeof(struct mem_bank_data),
> +					   GFP_KERNEL);
> +			if (!tcm)
> +				return -ENOMEM;
> +
> +			r5_core->tcm_banks[j] = tcm;
> +
> +			/*
> +			 * In lockstep mode, get second core's TCM power domains id
> +			 * after first core TCM parsing is done as

There seems to be words missing at the end of the sentence, and there is no dot.

> +			 */
> +			if (j == tcm_reg_per_r5) {
> +				/* dec first core node */
> +				of_node_put(np);
> +
> +				/* get second core node */
> +				np = of_get_next_child(cluster->dev->of_node, np);
> +
> +				/*
> +				 * reset index of power-domains property list
> +				 * for second core
> +				 */
> +				tcm_pd_idx = 1;
> +			}
> +
> +			/* get power-domains id of tcm */
> +			ret = of_parse_phandle_with_args(np, "power-domains",
> +							 "#power-domain-cells",
> +							 tcm_pd_idx,
> +							 &out_args);
> +			if (ret) {
> +				dev_err(r5_core->dev,
> +					"failed to get tcm %d pm domain, ret %d\n",
> +					j, ret);
> +				of_node_put(out_args.np);

I'm pretty sure this isn't needed in error conditions since @out_args would not
have been assigned.

> +				return ret;
> +			}
> +			tcm->pm_domain_id = out_args.args[0];
> +			of_node_put(out_args.np);
> +			tcm_pd_idx++;
> +
> +			/*
> +			 * In lockstep mode, we only need second core's power domain
> +			 * ids. Other information from second core isn't needed so
> +			 * ignore it. This forms table as zynqmp_tcm_banks_lockstep

I don't understand the last sentence of this comment and it is missing a dot at
the end.  Comments should be enlightening, the ones I found in this patch are
sowing confusion.  

> +			 */
> +			if (j >= tcm_reg_per_r5)
> +				contiue;
> +

This condition and the one above (j == tcm_reg_per_r5) is brittle and almost
guaranteed to cause maintenance problems in the future.

I understand your will to reuse as much code as possible but this is one of the
rare cases where duplicating code is probably better.  Please introduce two new
functions, i.e zynqmp_r5_get_tcm_node_from_dt_split() and
zynqmp_r5_get_tcm_node_from_dt_lockstep(), and do all the necessary processing
based on the use case.

Thanks,
Mathieu

> +			/* get tcm address without translation */
> +			ret = of_property_read_reg(np, j, &abs_addr, &size);
> +			if (ret) {
> +				of_node_put(np);
> +				dev_err(dev, "failed to get reg property\n");
> +				return ret;
> +			}
> +
> +			/*
> +			 * remote processor can address only 32 bits
> +			 * so convert 64-bits into 32-bits. This will discard
> +			 * any unwanted upper 32-bits.
> +			 */
> +			tcm->da = (u32)abs_addr;
> +			tcm->size = (u32)size;
> +
> +			cpdev = to_platform_device(dev);
> +			res = platform_get_resource(cpdev, IORESOURCE_MEM, j);
> +			if (!res) {
> +				of_node_put(np);
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
> +				of_node_put(np);
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
> +	of_node_put(np);
> +	return 0;
> +}
> +
>  /**
>   * zynqmp_r5_get_tcm_node()
>   * Ideally this function should parse tcm node and store information
> @@ -956,10 +1089,19 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>  	struct zynqmp_r5_core *r5_core;
>  	int ret, i;
>  
> -	ret = zynqmp_r5_get_tcm_node(cluster);
> -	if (ret < 0) {
> -		dev_err(dev, "can't get tcm node, err %d\n", ret);
> -		return ret;
> +	r5_core = cluster->r5_cores[0];
> +	if (of_find_property(r5_core->np, "reg", NULL)) {
> +		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
> +		if (ret) {
> +			dev_err(dev, "can't get tcm node from dt, err %d\n", ret);
> +			return ret;
> +		}
> +	} else {
> +		ret = zynqmp_r5_get_tcm_node(cluster);
> +		if (ret < 0) {
> +			dev_err(dev, "can't get tcm node, err %d\n", ret);
> +			return ret;
> +		}
>  	}
>  
>  	for (i = 0; i < cluster->core_count; i++) {
> -- 
> 2.25.1
> 

