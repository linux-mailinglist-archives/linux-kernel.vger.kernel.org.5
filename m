Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9AE7F4EBD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344342AbjKVRv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344333AbjKVRvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:51:21 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF514D7F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:51:11 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5be30d543c4so8039a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700675471; x=1701280271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XdeRY1HU0he8JLN2p85JAxLCvd0PpiNSQyQ1RY78xlk=;
        b=k4VsDdu7NaCOagay7fWGYDl9qOxbXd/CzIz9TKkZOEf7n9/29VG32oW66Dw76D2kle
         ffuZVuI2N9WYamVRGcVwMsXs7wRJRkppG4F+Tn4iJnkJPNpw44Nyr3LiBoKw+8DNjVmG
         J79eeJlQkKt4zDg811fYXQTUGe1Y6HOBdvkrWPUyzzGVG3CrEzZDPM8uS78ycM/1taZ9
         xJ5qBwHw90Ztw/w9bvi2ZpCEhp/mrme29XVk31agXY968vAI0Bv3Jguschh2BQ0HVp1I
         iKkgvYKj4oy1zAOPrtN+059V9UBZUxbfQTXBUI5avmEGoSAFwrFa6R9aKRKzgf6pQOKx
         qkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700675471; x=1701280271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdeRY1HU0he8JLN2p85JAxLCvd0PpiNSQyQ1RY78xlk=;
        b=EiGHTv0wgi7SSss+FgmHWslbQ4XfnyDgBxhcX2Zw4vjGvYYReiuAr6QuHLe1Essi1M
         B9kF91+MjQFpNy/FGFjq7AI7cClCshLKMb63if+0QFK21dikbanbHxMwr28F2ANPjzNs
         uC7FqAiLSw5e5WtVJPl9S5uogl71Jfs5Va0qxwisDjdccFdhMCuOzc42snSxoLASrkU9
         204zzLayko2dE2WQdNTy1tkJqdh6tal0LyFga071JhMwL9peE/9sbZYGhr6Yxvh1SooO
         rgzo8LG+Y8ewiCXGBYCiVpEU4kLXyHZFTIGS6hTJtQwjXMZEFTC7AnwEzboue4X5PZjJ
         nKaQ==
X-Gm-Message-State: AOJu0YxQiQ+VEg8lNXEGmKhosCZW+JIysfrsRidkAgIp7oDfUWpbNoPN
        lF3sN9p8UQyRc3Mle12XRh1N8g==
X-Google-Smtp-Source: AGHT+IGOmJsp+VE8pTPzpczASjV96jP35mDzV5h8Bhcp3N3HpagQEURI1z12+//kLHTcf3rIVdRWWA==
X-Received: by 2002:a05:6a20:440a:b0:186:de7:e803 with SMTP id ce10-20020a056a20440a00b001860de7e803mr3394379pzb.53.1700675471082;
        Wed, 22 Nov 2023 09:51:11 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:178e:e668:ba84:1eed])
        by smtp.gmail.com with ESMTPSA id g8-20020a056a00078800b006cb94e20014sm6684pfu.41.2023.11.22.09.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:51:10 -0800 (PST)
Date:   Wed, 22 Nov 2023 10:51:08 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        michal.simek@amd.com, ben.levinsky@amd.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/4] remoteproc: zynqmp: parse TCM from device tree
Message-ID: <ZV4/jFwULdH67JYC@p14s>
References: <20231117174238.1876655-1-tanmay.shah@amd.com>
 <20231117174238.1876655-5-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117174238.1876655-5-tanmay.shah@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 09:42:38AM -0800, Tanmay Shah wrote:
> ZynqMP TCM information is fixed in driver. Now ZynqMP TCM information
> is available in device-tree. Parse TCM information in driver
> as per new bindings.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v7:
>   - move checking of pm_domain_id from previous patch
>   - fix mem_bank_data memory allocation
> 
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 152 ++++++++++++++++++++----
>  1 file changed, 128 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> index 22bccc5075a0..270af73344ef 100644
> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> @@ -75,8 +75,8 @@ struct mbox_info {
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
> @@ -587,12 +587,21 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
>  		bank_size = r5_core->tcm_banks[i]->size;
>  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
>  
> -		ret = zynqmp_pm_request_node(pm_domain_id,
> -					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> -					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> -		if (ret < 0) {
> -			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> -			goto release_tcm_split;
> +		/*
> +		 * If TCM information is available in device-tree then
> +		 * in that case, pm domain framework will power on/off TCM.
> +		 * In that case pm_domain_id is set to 0. If hardcode
> +		 * bindings from driver is used, then only this driver will
> +		 * use pm_domain_id.
> +		 */
> +		if (pm_domain_id) {
> +			ret = zynqmp_pm_request_node(pm_domain_id,
> +						     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> +						     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> +			if (ret < 0) {
> +				dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> +				goto release_tcm_split;
> +			}
>  		}
>  
>  		dev_dbg(dev, "TCM carveout split mode %s addr=%llx, da=0x%x, size=0x%lx",
> @@ -604,7 +613,8 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
>  						 bank_name);
>  		if (!rproc_mem) {
>  			ret = -ENOMEM;
> -			zynqmp_pm_release_node(pm_domain_id);
> +			if (pm_domain_id)
> +				zynqmp_pm_release_node(pm_domain_id);
>  			goto release_tcm_split;
>  		}
>  
> @@ -617,7 +627,8 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
>  	/* If failed, Turn off all TCM banks turned on before */
>  	for (i--; i >= 0; i--) {
>  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> -		zynqmp_pm_release_node(pm_domain_id);
> +		if (pm_domain_id)
> +			zynqmp_pm_release_node(pm_domain_id);
>  	}
>  	return ret;
>  }
> @@ -659,13 +670,16 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
>  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
>  
>  		/* Turn on each TCM bank individually */
> -		ret = zynqmp_pm_request_node(pm_domain_id,
> -					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> -					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> -		if (ret < 0) {
> -			dev_err(dev, "failed to turn on TCM 0x%x",
> -				pm_domain_id);
> -			goto release_tcm_lockstep;
> +
> +		if (pm_domain_id) {
> +			ret = zynqmp_pm_request_node(pm_domain_id,
> +						     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> +						     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> +			if (ret < 0) {
> +				dev_err(dev, "failed to turn on TCM 0x%x",
> +					pm_domain_id);
> +				goto release_tcm_lockstep;
> +			}
>  		}
>  
>  		bank_size = r5_core->tcm_banks[i]->size;
> @@ -683,7 +697,8 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
>  						 bank_name);
>  		if (!rproc_mem) {
>  			ret = -ENOMEM;
> -			zynqmp_pm_release_node(pm_domain_id);
> +			if (pm_domain_id)
> +				zynqmp_pm_release_node(pm_domain_id);
>  			goto release_tcm_lockstep;
>  		}
>  
> @@ -700,7 +715,8 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
>  	/* If failed, Turn off all TCM banks turned on before */
>  	for (i--; i >= 0; i--) {
>  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> -		zynqmp_pm_release_node(pm_domain_id);
> +		if (pm_domain_id)
> +			zynqmp_pm_release_node(pm_domain_id);
>  	}
>  	return ret;
>  }
> @@ -931,6 +947,8 @@ static int zynqmp_r5_add_pm_domains(struct rproc *rproc)
>  		}
>  	}
>  
> +	return 0;
> +
>  fail_add_pm_domains_lockstep:
>  	while (--j >= 0) {
>  		device_link_del(r5_core->pm_dev_core1_link[j]);
> @@ -1012,7 +1030,7 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
>  
>  	for (i = 0; i < r5_core->tcm_bank_count; i++) {
>  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> -		if (zynqmp_pm_release_node(pm_domain_id))
> +		if (pm_domain_id && zynqmp_pm_release_node(pm_domain_id))
>  			dev_warn(r5_core->dev,
>  				 "can't turn off TCM bank 0x%x", pm_domain_id);
>  	}
> @@ -1087,6 +1105,83 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
>  	return ERR_PTR(ret);
>  }
>  
> +static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
> +{
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
> +		np = dev_of_node(dev);
> +
> +		/* we have address cell 2 and size cell as 2 */
> +		ret = of_property_count_elems_of_size(np, "reg",
> +		if (ret <= 0) {
> +			dev_err(dev, "can't get reg property err %d\n", ret);
> +			return -EINVAL;
> +		}
> +
> +		tcm_bank_count = ret;

This is useless - please use @tcm_bank_count instead of @ret above.

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
> +			/* get tcm address without translation */
> +			ret = of_property_read_reg(np, j, &abs_addr, &size);
> +			if (ret) {
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
> @@ -1165,10 +1260,19 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
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
