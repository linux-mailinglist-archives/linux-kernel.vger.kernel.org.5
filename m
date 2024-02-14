Return-Path: <linux-kernel+bounces-65656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5362C855012
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7BA51F21C8A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026BA8593C;
	Wed, 14 Feb 2024 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZrPXNqt5"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70539839ED
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931269; cv=none; b=u5MXhktRHURsXSss/1qWKqY50AVZD9ht7S7cuxktsCjxdfwUU6IiQNb+QJlbpvi+J639a7krhfJtaKhyNT6rxcRbQG0bNqWZ3df1+rsi0WvXC6J+dZMUPR7PsCBLHWMaYq47kHRfAKfoumYc+xEU0nJ32By9JeclOGEzTdb5e4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931269; c=relaxed/simple;
	bh=S7N5Ad2Nqrbj49SUQEtcPGXzZDyRUyvs+feHRNMHcIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLjSg4dnjw5PvPHyjJ9GANV/uGwV1cIhDOefpxFydBdPWg3mDDrOd2mcluvqEhp3E7ILbmo3/SU3c7e/oScbWoqZxk9sZlO2C/bsQQQRlNrBduomEgaRjl9lYDKG/bxou7NY7zzQwczQtDDh8GGIKZAOnU18u7i0iwnvpJ2xsiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZrPXNqt5; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-296df89efd2so30019a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707931267; x=1708536067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y+GLw4edkO69eFBIaZa2fDtYB7rYenDCtOXaRNz8hT8=;
        b=ZrPXNqt5fbS8GDyoR347+DxOOl7sD2H6+IyP8DF4KSDhnfIcPSO+0O3MBiG45YdMBS
         ZlGrk8uMU6t7K97Fi2lzZEsKHizkqUzd+GeSROZ8I37XIfliazCg1Qc+jiNSpeBW6s9f
         4XFPgdt4bfT8VbWy2Lzdge7o/wdKhpJkuAE85TSw4ugsigD3oCQrCtZZ05Z9cXqVuXfh
         tKvuZ4n6/CHAPKaZUBlutAAE1atGifBPg2+gjbI4a0W2E63tFvl669KjaEmULp286Cev
         tYYOBIukcVbyQHfGs8PZLWfgnsmMDeZDJLbmu1JaYB/XBJ/VwwQoR7x1f4rdTu3TM7nx
         /QfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707931267; x=1708536067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+GLw4edkO69eFBIaZa2fDtYB7rYenDCtOXaRNz8hT8=;
        b=DG/RspQ6MOvzh3VoatHYgfgbejtkWkwejXruSDw4D9J1CUm2Ji+AEdCN3lnP07nb9x
         ouawxlu29oirXQV7Cd7qNP125/6SqNXS1yDjtm3gie2Hl6MxjE7UlECZNrSJZSiIxuN3
         u1JhHLblRHn9lEL/Qfc+pxk39M9t9uA0JIuh/HlScPnUzI+Hc8CRpwKZ8zVc6o3VPD+Y
         l4JB2wrMoJ1I75wd8Vy+tB4rqS89P2tBuTMM3X/YBu6u2jQK+iJZ+eb8OKw+MipdQvu5
         lL5EBwioPWbnrPQcNtWicFcPXdTtU4dW9QRQICvLbjailaMbkki1/a+Bdh2fV+/hT0aw
         rgJA==
X-Forwarded-Encrypted: i=1; AJvYcCWA1BfSHnUHS4V5Bx0C73kwgYWN4XINSOIgKWMVin5b4izhll4JbF/javuabWV5iYxbLc5r6yiMDzCSGWBSkU1J21EQtbo8dSGFNTrA
X-Gm-Message-State: AOJu0YyoHzlasv8XU3heqxcQSU49TwSK7pDx+y+t9g3TN/4TIzNE1TT1
	m5yyu5FDP84Lz0I1PyafzBpqu/ZEuJGx5nqXRoZni/uHDHM7bac6Lt41jfNnTWw=
X-Google-Smtp-Source: AGHT+IE9Pnjo6ou5luyV/r8s33nLYEdd+B7r13dw3T/QzHcEFLNf1/OVaVKnhjctOSPGTGrgO4qEYw==
X-Received: by 2002:a17:90a:9b8c:b0:298:c136:2ffc with SMTP id g12-20020a17090a9b8c00b00298c1362ffcmr2584760pjp.45.1707931266846;
        Wed, 14 Feb 2024 09:21:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWodR54OSPqGD9VrYyvs5GM3YIST40u2Cyby+MBVNL/KbwkBOEjGMst0gElgv3G0ZqBEpDHffJ6Hpf1DN4gmNnrmLLUCCDaD4+j7w9w7X5Kje/6b85htP6dil3TbA71I9c1YSh5Gzyk+CeHHC9ze5cQ7rD6mrpF2246hpzApVpZUv3YecIa7T1M1/1nsSrkCcV/6+YgFzSjx52coZzbD95XLCwXsrU3iaE0s1OSXf4cuiMxGu3JU4GG+8oKg/n2PWl+UOPDSOQu4rOaZ2NVvayNRMAumzkFWoxFxEmg1sdxm44ZQ50/lV3jB6bMIVdGAwtn/CZCqBr2qnQYynJ/ug8j+Pe2Flg6+iAJZNT8c3UPd+Jk9d7EXe2L0JTlfPLUqPIYa4KDPJoTw==
Received: from p14s ([2604:3d09:148c:c800:96ea:e45d:5361:78d0])
        by smtp.gmail.com with ESMTPSA id ev6-20020a17090aeac600b00298d203d359sm1696864pjb.24.2024.02.14.09.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 09:21:06 -0800 (PST)
Date: Wed, 14 Feb 2024 10:21:03 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	michal.simek@amd.com, ben.levinsky@amd.com,
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 4/4] remoteproc: zynqmp: parse TCM from device tree
Message-ID: <Zcz2f3eZrXrRAX6F@p14s>
References: <20240213175450.3097308-1-tanmay.shah@amd.com>
 <20240213175450.3097308-5-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213175450.3097308-5-tanmay.shah@amd.com>

Good morning,

On Tue, Feb 13, 2024 at 09:54:50AM -0800, Tanmay Shah wrote:
> ZynqMP TCM information was fixed in driver. Now ZynqMP TCM information
> is available in device-tree. Parse TCM information in driver
> as per new bindings.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v10:
>   - Remove redundant changes to handle TCM in lockstep mode
> 
> Changes in v9:
>   - Introduce new API to request and release core1 TCM power-domains in
>     lockstep mode. This will be used during prepare -> add_tcm_banks
>     callback to enable TCM in lockstep mode.
>   - Parse TCM from device-tree in lockstep mode and split mode in
>     uniform way.
>   - Fix TCM representation in device-tree in lockstep mode.
> 
> Changes in v8:
>   - Remove pm_domains framework
>   - Remove checking of pm_domain_id validation to power on/off tcm
>   - Remove spurious change
>   - parse power-domains property from device-tree and use EEMI calls
>     to power on/off TCM instead of using pm domains framework
> 
> Changes in v7:
>   - move checking of pm_domain_id from previous patch
>   - fix mem_bank_data memory allocation
> 
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 112 ++++++++++++++++++++++--
>  1 file changed, 107 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> index 42b0384d34f2..49e8eaf83fce 100644
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
> +	struct of_phandle_args out_args = {0};

Is this really needed?  As far as I can tell it isn't.  

Otherwise and if it wasn't for the modification on the DT side, I would apply
this patch.

Thanks,
Mathieu

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
> +			ret = -ENOMEM;
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

