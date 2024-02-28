Return-Path: <linux-kernel+bounces-85415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED3A86B597
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B860D28127F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70E83FBA5;
	Wed, 28 Feb 2024 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NuRMSbwR"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FF66EF02
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140125; cv=none; b=qXSJ2ZWufzxDeEp0A5nmD0fX/FkueRpFXQ/Zef1J4xwGCieJnJWHNpOiiRLpGA5H8vaYAlK/jy12kkYBJ5KP9LFmD0ejmxSR/76rKsvywugml/dVJGDJGHVTbF/ZB0aDjJJIka0QnOFA/83D3LslwhBdrIyBYvB4o37R64lugDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140125; c=relaxed/simple;
	bh=WDG9Q9QTlwo8o9t2dFs0iLjixFml3snAHpPaD3gakW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8fTNnSnrn08XdCmwVA98qzE2qx8JENcLA2wGxfZG6cAN1ZwelSoGACYopKhbSbff9AOjDUIfCTIXxkjIAoUAYYrDAahxIYCrMdvGq4sjrtyGtEe4G0aVxiq8UJNPsGF638koLZZCQv6pqG3bSWwbxOiITjvBNAJeSUVABG1OXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NuRMSbwR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e332bc65b3so3270946b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709140123; x=1709744923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vZ7yX46ZRthWSl8mAmdFHCANI4NXz4hftEaGGdUSpkA=;
        b=NuRMSbwRTdLYHY29N4tZRwl/St69DrSRkRyUlYBet0qYAKwhbIs0EK9Nbh1984vcHY
         voo/WuNwXjDUvKpTfhRiTGYT4+8yZpiK8eOrXptbN/0L2jlBbgFHtqeHTBQK7Y78bGNW
         OsoQXsLcBJ3GERh1y8dRvgh7X/3HKtIB64vVjr+jhkt3aUHDF/AP2iVKWdKvt222Eg6D
         nvQyUt4FR+TmpvqOiNS2gKX6ZwRrqqJde7UztfjFA/jlAiAGNxtJUvEmNKgT5V60LmQG
         XUG4ZO2OETP3Ef2MlCvHDU++AMx6apB4oBMnqlXbCQOL2gXoisWPQBl+mnc7n03/Ph2F
         XF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709140123; x=1709744923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZ7yX46ZRthWSl8mAmdFHCANI4NXz4hftEaGGdUSpkA=;
        b=rWz4/GfWRZ9WF1hq9xZ2xKIqKzqxfzNmuy5mFTk2yeYPpzBB87MHsUEvj+rxzPrqaJ
         BSZmTgipKsc6yvq+F8hAcfhuAm/saAaVE4nJhMc3uIey4lbNO+A+4nClvp1k0lrOoHIh
         on89R0MYIEG3T7jcOO+NEc03cr8ux7wDXoqItYcdJ1sR39eA+CDlfdf9mYoS9/bvRrUp
         Vi9JGWk7jrOiluLypExNDf8Hr217fPnTfxtY3kRFgKEZVR851m0/f+MWkD+7Kjb5qtGL
         KpQqRClAc3ynU4cXqZfSPmNdh8YJ7etUZcLYcEsXQ6HgBs5XCVvMobJ3CKOuXgZXglJ4
         eYBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnMRiCeP3qJVrjM3/Ht5psG1ucRP1tmMBGbjPTb2mqlkoylXXUKwm7X5RqHbHLBHKgvSHVjYKNVePdZWwd/CUB3vIpXcI8UZ8kcKwh
X-Gm-Message-State: AOJu0YwW+c5mjAzp++O7Oz6Ptn4dGxnLtJ3yEzDYKGa4Vj7kGgENnqCH
	mORjMjniCwDiCs+HxsUSipwXCLObeN9j5cd/ZMXwWpKxVpcy1iQV7bwJBLZxeMRHDqnjqCugimw
	C
X-Google-Smtp-Source: AGHT+IH+K0cPBkC1fHRGR/g4p5u9bQgkIr3UPw3K8hhP2snwADjcStTQwKq4T9ECeiZWCeuaYPvZQQ==
X-Received: by 2002:a05:6a00:80d9:b0:6e5:31f5:94cd with SMTP id ei25-20020a056a0080d900b006e531f594cdmr234150pfb.0.1709140123424;
        Wed, 28 Feb 2024 09:08:43 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:96d9:3aed:533c:8c94])
        by smtp.gmail.com with ESMTPSA id p54-20020a056a0026f600b006e5360f1cffsm5303122pfw.180.2024.02.28.09.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:08:43 -0800 (PST)
Date: Wed, 28 Feb 2024 10:08:40 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	michal.simek@amd.com, ben.levinsky@amd.com,
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/4] remoteproc: zynqmp: fix lockstep mode memory
 region
Message-ID: <Zd9omCbc3UqjT7Lr@p14s>
References: <20240219174437.3722620-1-tanmay.shah@amd.com>
 <20240219174437.3722620-7-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219174437.3722620-7-tanmay.shah@amd.com>

On Mon, Feb 19, 2024 at 09:44:34AM -0800, Tanmay Shah wrote:
> In lockstep mode, r5 core0 uses TCM of R5 core1. Following is lockstep
> mode memory region as per hardware reference manual.
> 
>     |      *TCM*         |   *R5 View* | *Linux view* |
>     | R5_0 ATCM (128 KB) | 0x0000_0000 | 0xFFE0_0000  |
>     | R5_0 BTCM (128 KB) | 0x0002_0000 | 0xFFE2_0000  |
> 
> However, driver shouldn't model it as above because R5 core0 TCM and core1
> TCM has different power-domains mapped to it.
> Hence, TCM address space in lockstep mode should be modeled as 64KB
> regions only where each region has its own power-domain as following:
> 
>     |      *TCM*         |   *R5 View* | *Linux view* |
>     | R5_0 ATCM0 (64 KB) | 0x0000_0000 | 0xFFE0_0000  |
>     | R5_0 BTCM0 (64 KB) | 0x0002_0000 | 0xFFE2_0000  |
>     | R5_0 ATCM1 (64 KB) | 0x0001_0000 | 0xFFE1_0000  |
>     | R5_0 BTCM1 (64 KB) | 0x0003_0000 | 0xFFE3_0000  |
> 
> This makes driver maintanance easy and makes design robust for future
> platorms as well.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>

Now that I have a clearer picture of where things are going, I am adding this
patch to rproc-next.

I'll wait for the DT crew for the rest of this set.

Thanks,
Mathieu

> ---
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 145 ++----------------------
>  1 file changed, 12 insertions(+), 133 deletions(-)
> 
> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> index 4395edea9a64..42b0384d34f2 100644
> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> @@ -84,12 +84,12 @@ static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
>  	{0xffeb0000UL, 0x20000, 0x10000UL, PD_R5_1_BTCM, "btcm1"},
>  };
>  
> -/* In lockstep mode cluster combines each 64KB TCM and makes 128KB TCM */
> +/* In lockstep mode cluster uses each 64KB TCM from second core as well */
>  static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
> -	{0xffe00000UL, 0x0, 0x20000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 128KB each */
> -	{0xffe20000UL, 0x20000, 0x20000UL, PD_R5_0_BTCM, "btcm0"},
> -	{0, 0, 0, PD_R5_1_ATCM, ""},
> -	{0, 0, 0, PD_R5_1_BTCM, ""},
> +	{0xffe00000UL, 0x0, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
> +	{0xffe20000UL, 0x20000, 0x10000UL, PD_R5_0_BTCM, "btcm0"},
> +	{0xffe10000UL, 0x10000, 0x10000UL, PD_R5_1_ATCM, "atcm1"},
> +	{0xffe30000UL, 0x30000, 0x10000UL, PD_R5_1_BTCM, "btcm1"},
>  };
>  
>  /**
> @@ -540,14 +540,14 @@ static int tcm_mem_map(struct rproc *rproc,
>  }
>  
>  /*
> - * add_tcm_carveout_split_mode()
> + * add_tcm_banks()
>   * @rproc: single R5 core's corresponding rproc instance
>   *
> - * allocate and add remoteproc carveout for TCM memory in split mode
> + * allocate and add remoteproc carveout for TCM memory
>   *
>   * return 0 on success, otherwise non-zero value on failure
>   */
> -static int add_tcm_carveout_split_mode(struct rproc *rproc)
> +static int add_tcm_banks(struct rproc *rproc)
>  {
>  	struct rproc_mem_entry *rproc_mem;
>  	struct zynqmp_r5_core *r5_core;
> @@ -580,10 +580,10 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
>  					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
>  		if (ret < 0) {
>  			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> -			goto release_tcm_split;
> +			goto release_tcm;
>  		}
>  
> -		dev_dbg(dev, "TCM carveout split mode %s addr=%llx, da=0x%x, size=0x%lx",
> +		dev_dbg(dev, "TCM carveout %s addr=%llx, da=0x%x, size=0x%lx",
>  			bank_name, bank_addr, da, bank_size);
>  
>  		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> @@ -593,7 +593,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
>  		if (!rproc_mem) {
>  			ret = -ENOMEM;
>  			zynqmp_pm_release_node(pm_domain_id);
> -			goto release_tcm_split;
> +			goto release_tcm;
>  		}
>  
>  		rproc_add_carveout(rproc, rproc_mem);
> @@ -601,7 +601,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
>  
>  	return 0;
>  
> -release_tcm_split:
> +release_tcm:
>  	/* If failed, Turn off all TCM banks turned on before */
>  	for (i--; i >= 0; i--) {
>  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> @@ -610,127 +610,6 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
>  	return ret;
>  }
>  
> -/*
> - * add_tcm_carveout_lockstep_mode()
> - * @rproc: single R5 core's corresponding rproc instance
> - *
> - * allocate and add remoteproc carveout for TCM memory in lockstep mode
> - *
> - * return 0 on success, otherwise non-zero value on failure
> - */
> -static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> -{
> -	struct rproc_mem_entry *rproc_mem;
> -	struct zynqmp_r5_core *r5_core;
> -	int i, num_banks, ret;
> -	phys_addr_t bank_addr;
> -	size_t bank_size = 0;
> -	struct device *dev;
> -	u32 pm_domain_id;
> -	char *bank_name;
> -	u32 da;
> -
> -	r5_core = rproc->priv;
> -	dev = r5_core->dev;
> -
> -	/* Go through zynqmp banks for r5 node */
> -	num_banks = r5_core->tcm_bank_count;
> -
> -	/*
> -	 * In lockstep mode, TCM is contiguous memory block
> -	 * However, each TCM block still needs to be enabled individually.
> -	 * So, Enable each TCM block individually.
> -	 * Although ATCM and BTCM is contiguous memory block, add two separate
> -	 * carveouts for both.
> -	 */
> -	for (i = 0; i < num_banks; i++) {
> -		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> -
> -		/* Turn on each TCM bank individually */
> -		ret = zynqmp_pm_request_node(pm_domain_id,
> -					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> -					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> -		if (ret < 0) {
> -			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> -			goto release_tcm_lockstep;
> -		}
> -
> -		bank_size = r5_core->tcm_banks[i]->size;
> -		if (bank_size == 0)
> -			continue;
> -
> -		bank_addr = r5_core->tcm_banks[i]->addr;
> -		da = r5_core->tcm_banks[i]->da;
> -		bank_name = r5_core->tcm_banks[i]->bank_name;
> -
> -		/* Register TCM address range, TCM map and unmap functions */
> -		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> -						 bank_size, da,
> -						 tcm_mem_map, tcm_mem_unmap,
> -						 bank_name);
> -		if (!rproc_mem) {
> -			ret = -ENOMEM;
> -			zynqmp_pm_release_node(pm_domain_id);
> -			goto release_tcm_lockstep;
> -		}
> -
> -		/* If registration is success, add carveouts */
> -		rproc_add_carveout(rproc, rproc_mem);
> -
> -		dev_dbg(dev, "TCM carveout lockstep mode %s addr=0x%llx, da=0x%x, size=0x%lx",
> -			bank_name, bank_addr, da, bank_size);
> -	}
> -
> -	return 0;
> -
> -release_tcm_lockstep:
> -	/* If failed, Turn off all TCM banks turned on before */
> -	for (i--; i >= 0; i--) {
> -		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> -		zynqmp_pm_release_node(pm_domain_id);
> -	}
> -	return ret;
> -}
> -
> -/*
> - * add_tcm_banks()
> - * @rproc: single R5 core's corresponding rproc instance
> - *
> - * allocate and add remoteproc carveouts for TCM memory based on cluster mode
> - *
> - * return 0 on success, otherwise non-zero value on failure
> - */
> -static int add_tcm_banks(struct rproc *rproc)
> -{
> -	struct zynqmp_r5_cluster *cluster;
> -	struct zynqmp_r5_core *r5_core;
> -	struct device *dev;
> -
> -	r5_core = rproc->priv;
> -	if (!r5_core)
> -		return -EINVAL;
> -
> -	dev = r5_core->dev;
> -
> -	cluster = dev_get_drvdata(dev->parent);
> -	if (!cluster) {
> -		dev_err(dev->parent, "Invalid driver data\n");
> -		return -EINVAL;
> -	}
> -
> -	/*
> -	 * In lockstep mode TCM banks are one contiguous memory region of 256Kb
> -	 * In split mode, each TCM bank is 64Kb and not contiguous.
> -	 * We add memory carveouts accordingly.
> -	 */
> -	if (cluster->mode == SPLIT_MODE)
> -		return add_tcm_carveout_split_mode(rproc);
> -	else if (cluster->mode == LOCKSTEP_MODE)
> -		return add_tcm_carveout_lockstep_mode(rproc);
> -
> -	return -EINVAL;
> -}
> -
>  /*
>   * zynqmp_r5_parse_fw()
>   * @rproc: single R5 core's corresponding rproc instance
> -- 
> 2.25.1
> 

