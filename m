Return-Path: <linux-kernel+bounces-141294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8517A8A1C3B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111731F26482
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C74115B14C;
	Thu, 11 Apr 2024 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gb8f/zLW"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EBA15B129
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851962; cv=none; b=mO+5oLdbi0/B1P8J2QJIL0iPCp1BYR50WId1U20SK7dN+i+AnJlkMmGlmqb2p0mnI8X2EAJQo8cwixfi6OYXPjw8VzsSHnDoxDmy7/VjzERP6rKIuk5iec91bDYdO8EOmy7SzsH008mhYFpk7CQWQ4hY0Lk3lK+EkpPKShC84P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851962; c=relaxed/simple;
	bh=kKbZ5J7jKEfpEMov+rNKDGVboP+YeG1NwPnMpkDCLnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFoE1ldiS7DZHXBmYVA+ea2B8vLCdfEzBDzrwbpFascrToF76ww5KJ3f1H1LUAzrR0CPhGhn7HY85r5nHXuuTJ1bCzMzh4Nhuk7TSF6zsB5w+zZGYwcoYsKW2hSV5+eg14Tp/XOiz4AbqDu5E1ehZAS+S3R/cptCv2qsC+EvsjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gb8f/zLW; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a475bdd4a6so4334990a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712851959; x=1713456759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HmRrZJnguJ+gxDES/4SwEbz5PEezPjqR1g3BjbuHjpI=;
        b=Gb8f/zLW++lKMKlHBXXWe+LZdhUXagd3oG1NizZhnZ5Btf4suVdckg1wEjnc0WzpS4
         3DrFNwRkVqlUrTh6BTVdxkLwqt1NGp2dzY2F8wqK3jB7xrFSMTNFfCkgxefLs07wH/fa
         UETbDOBaJulH9srJPlS6c8Ne4CW6YDqE348CvVvcL/9kpUuPfHHjOysPcb6Mu04eVseF
         6gVsuqfF3VqHR2YKLrMn1kk4shkzyQj3Iu3h6wqYJQzMrREyJDF4UiUXMkDO4ITZeOmK
         9f+oh/JT73dTmvYQzJt2Z2h/ZRtr5Ben8qcW60BVds5vKUfxQ4x5AaiVAyggm+e/z79N
         9YSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712851959; x=1713456759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmRrZJnguJ+gxDES/4SwEbz5PEezPjqR1g3BjbuHjpI=;
        b=UC5F/y2mjSgEyeE3Nes+Cbj8WO3jmJONLARyFr2J2Uu5r8Ffwtr5uElLqnHm3a8Egt
         QG04BTAuFfIIjmpqOTn0lhCRRyYCv2CkX/c5HM6++M75VZ/QMsPoOXSsbSVCE23rgSNs
         R0j8wJtK1cO+0B2TOMWwVMwjeUdm3PPBkYuBXs39uHs2VpQiHVHgsQVvPzAXJw9HIsPS
         mYhHgPaEc1EfjIOzmDCg3Z4ArOGE5ASyMazwfdzZIMByr02wBB70KLhRnIqqjxXnbNg4
         AVb/quP68b8UquX9iA5EayEeZItw9ReKgeN9Cu9N8LM51doCOvIYpa5edLitJs0gRo9D
         +Fjw==
X-Forwarded-Encrypted: i=1; AJvYcCUTogwhcoJqeQS77az+9ktIikBTzMaYAMGIzhXSk3hMCGD4+SDtU1djU+dyqTUbrtnteEXodGLbUgzOxYi4dcjAbr3ZyRaspbw6w71R
X-Gm-Message-State: AOJu0Yw2SB6G8CyqnPTKklknRKFCnrh56qEswR4M0PHVzROr1XBZHZXo
	mFVK165tluSDu16upjTX5xABnlkYup2ql73zEi/m56x/Ow4ZyXFZLSw0u9URdz4=
X-Google-Smtp-Source: AGHT+IEJwbbpJmr8dWIDI56JBWT8u7+E+cZxOalndjf4t0KJjKAXmfM28qwDdGHfA4+7xuf8zlgfuQ==
X-Received: by 2002:a17:90b:249:b0:2a0:4495:1f3d with SMTP id fz9-20020a17090b024900b002a044951f3dmr72508pjb.0.1712851959206;
        Thu, 11 Apr 2024 09:12:39 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:efff:a39b:6ec6:a2f3])
        by smtp.gmail.com with ESMTPSA id v7-20020a17090a778700b002a51a01f447sm2973531pjk.49.2024.04.11.09.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 09:12:38 -0700 (PDT)
Date: Thu, 11 Apr 2024 10:12:35 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	michal.simek@amd.com, ben.levinsky@amd.com,
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 4/4] remoteproc: zynqmp: parse TCM from device tree
Message-ID: <ZhgL8/hJZTJnDYuN@p14s>
References: <20240408205313.3552165-1-tanmay.shah@amd.com>
 <20240408205313.3552165-5-tanmay.shah@amd.com>
 <ZhbFfA7toAkUATfg@p14s>
 <0f62cb47-23bd-41bd-a713-ac9f37a1ec7b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f62cb47-23bd-41bd-a713-ac9f37a1ec7b@amd.com>

On Wed, Apr 10, 2024 at 05:36:30PM -0500, Tanmay Shah wrote:
> 
> 
> On 4/10/24 11:59 AM, Mathieu Poirier wrote:
> > On Mon, Apr 08, 2024 at 01:53:14PM -0700, Tanmay Shah wrote:
> >> ZynqMP TCM information was fixed in driver. Now ZynqMP TCM information
> >> is available in device-tree. Parse TCM information in driver
> >> as per new bindings.
> >> 
> >> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> >> ---
> >> 
> >> Changes in v14:
> >>   - Add Versal platform support
> >>   - Add Versal-NET platform support
> >>   - Maintain backward compatibility for ZynqMP platform and use hardcode
> >>     TCM addresses
> >>   - Configure TCM based on xlnx,tcm-mode property for Versal
> >>   - Avoid TCM configuration if that property isn't available in DT 
> >> 
> >>  drivers/remoteproc/xlnx_r5_remoteproc.c | 173 ++++++++++++++++++------
> >>  1 file changed, 132 insertions(+), 41 deletions(-)
> >> 
> >> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> >> index 0f942440b4e2..504492f930ac 100644
> >> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> >> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> >> @@ -74,8 +74,8 @@ struct mbox_info {
> >>  };
> >>  
> >>  /*
> >> - * Hardcoded TCM bank values. This will be removed once TCM bindings are
> >> - * accepted for system-dt specifications and upstreamed in linux kernel
> >> + * Hardcoded TCM bank values. This will stay in driver to maintain backward
> >> + * compatibility with device-tree that does not have TCM information.
> >>   */
> >>  static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
> >>  	{0xffe00000UL, 0x0, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
> >> @@ -300,36 +300,6 @@ static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid)
> >>  		dev_warn(dev, "failed to send message\n");
> >>  }
> >>  
> >> -/*
> >> - * zynqmp_r5_set_mode()
> >> - *
> >> - * set RPU cluster and TCM operation mode
> >> - *
> >> - * @r5_core: pointer to zynqmp_r5_core type object
> >> - * @fw_reg_val: value expected by firmware to configure RPU cluster mode
> >> - * @tcm_mode: value expected by fw to configure TCM mode (lockstep or split)
> >> - *
> >> - * Return: 0 for success and < 0 for failure
> >> - */
> >> -static int zynqmp_r5_set_mode(struct zynqmp_r5_core *r5_core,
> >> -			      enum rpu_oper_mode fw_reg_val,
> >> -			      enum rpu_tcm_comb tcm_mode)
> >> -{
> >> -	int ret;
> >> -
> >> -	ret = zynqmp_pm_set_rpu_mode(r5_core->pm_domain_id, fw_reg_val);
> >> -	if (ret < 0) {
> >> -		dev_err(r5_core->dev, "failed to set RPU mode\n");
> >> -		return ret;
> >> -	}
> >> -
> >> -	ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
> >> -	if (ret < 0)
> >> -		dev_err(r5_core->dev, "failed to configure TCM\n");
> >> -
> >> -	return ret;
> >> -}
> >> -
> >>  /*
> >>   * zynqmp_r5_rproc_start()
> >>   * @rproc: single R5 core's corresponding rproc instance
> >> @@ -761,6 +731,103 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
> >>  	return ERR_PTR(ret);
> >>  }
> >>  
> >> +static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
> >> +{
> >> +	int i, j, tcm_bank_count, ret, tcm_pd_idx, pd_count;
> >> +	struct of_phandle_args out_args;
> >> +	struct zynqmp_r5_core *r5_core;
> >> +	struct platform_device *cpdev;
> >> +	struct mem_bank_data *tcm;
> >> +	struct device_node *np;
> >> +	struct resource *res;
> >> +	u64 abs_addr, size;
> >> +	struct device *dev;
> >> +
> >> +	for (i = 0; i < cluster->core_count; i++) {
> >> +		r5_core = cluster->r5_cores[i];
> >> +		dev = r5_core->dev;
> >> +		np = r5_core->np;
> >> +
> >> +		pd_count = of_count_phandle_with_args(np, "power-domains",
> >> +						      "#power-domain-cells");
> >> +
> >> +		if (pd_count <= 0) {
> >> +			dev_err(dev, "invalid power-domains property, %d\n", pd_count);
> >> +			return -EINVAL;
> >> +		}
> >> +
> >> +		/* First entry in power-domains list is for r5 core, rest for TCM. */
> >> +		tcm_bank_count = pd_count - 1;
> >> +
> >> +		if (tcm_bank_count <= 0) {
> >> +			dev_err(dev, "invalid TCM count %d\n", tcm_bank_count);
> >> +			return -EINVAL;
> >> +		}
> >> +
> >> +		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
> >> +						  sizeof(struct mem_bank_data *),
> >> +						  GFP_KERNEL);
> >> +		if (!r5_core->tcm_banks)
> >> +			return -ENOMEM;
> >> +
> >> +		r5_core->tcm_bank_count = tcm_bank_count;
> >> +		for (j = 0, tcm_pd_idx = 1; j < tcm_bank_count; j++, tcm_pd_idx++) {
> >> +			tcm = devm_kzalloc(dev, sizeof(struct mem_bank_data),
> >> +					   GFP_KERNEL);
> >> +			if (!tcm)
> >> +				return -ENOMEM;
> >> +
> >> +			r5_core->tcm_banks[j] = tcm;
> >> +
> >> +			/* Get power-domains id of TCM. */
> >> +			ret = of_parse_phandle_with_args(np, "power-domains",
> >> +							 "#power-domain-cells",
> >> +							 tcm_pd_idx, &out_args);
> >> +			if (ret) {
> >> +				dev_err(r5_core->dev,
> >> +					"failed to get tcm %d pm domain, ret %d\n",
> >> +					tcm_pd_idx, ret);
> >> +				return ret;
> >> +			}
> >> +			tcm->pm_domain_id = out_args.args[0];
> >> +			of_node_put(out_args.np);
> >> +
> >> +			/* Get TCM address without translation. */
> >> +			ret = of_property_read_reg(np, j, &abs_addr, &size);
> >> +			if (ret) {
> >> +				dev_err(dev, "failed to get reg property\n");
> >> +				return ret;
> >> +			}
> >> +
> >> +			/*
> >> +			 * Remote processor can address only 32 bits
> >> +			 * so convert 64-bits into 32-bits. This will discard
> >> +			 * any unwanted upper 32-bits.
> >> +			 */
> >> +			tcm->da = (u32)abs_addr;
> >> +			tcm->size = (u32)size;
> >> +
> >> +			cpdev = to_platform_device(dev);
> >> +			res = platform_get_resource(cpdev, IORESOURCE_MEM, j);
> >> +			if (!res) {
> >> +				dev_err(dev, "failed to get tcm resource\n");
> >> +				return -EINVAL;
> >> +			}
> >> +
> >> +			tcm->addr = (u32)res->start;
> >> +			tcm->bank_name = (char *)res->name;
> >> +			res = devm_request_mem_region(dev, tcm->addr, tcm->size,
> >> +						      tcm->bank_name);
> >> +			if (!res) {
> >> +				dev_err(dev, "failed to request tcm resource\n");
> >> +				return -EINVAL;
> >> +			}
> >> +		}
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  /**
> >>   * zynqmp_r5_get_tcm_node()
> >>   * Ideally this function should parse tcm node and store information
> >> @@ -839,9 +906,16 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
> >>  	struct zynqmp_r5_core *r5_core;
> >>  	int ret, i;
> >>  
> >> -	ret = zynqmp_r5_get_tcm_node(cluster);
> >> -	if (ret < 0) {
> >> -		dev_err(dev, "can't get tcm node, err %d\n", ret);
> >> +	r5_core = cluster->r5_cores[0];
> >> +
> >> +	/* Maintain backward compatibility for zynqmp by using hardcode TCM address. */
> >> +	if (device_is_compatible(dev, "xlnx,zynqmp-r5fss"))
> > 
> > The previous patch moved the definition of the R5FSS to the new bindings but
> > this is forcing to use the old bindings - did I something?
> 
> Hi Mathieu,
> 
> We need to maintain backward compatibility for zynqmp device. So, using old bindings
> for zynqmp. For new devices (Versal and Versal-NET) new bindings are enforced in driver.
> It's not recommended to map two programming sequences to same device. So for
> "xlnx,zynqmp-r5fss" device old bindings are used.
>

You are not using two programming sequences for the same device, you are simply
ensuring backward compatibility for older device tree.  The bindings for r5fss
have been updated so the driver should be using the new method.  You have used
"xlnx,tcm-mode" to switch between new and old bindings, do that here too.

I'm also not sure why Versal and Versal-NET are being added to this patchset...
It should be in another patchset of its own.

> Device tree is matching with new bindings. But that's hardware description. I believe,
> driver can still choose to use hardcode addresses to maintain backward compatibility.
> 
> The end result will be same.
> 
> Thanks,
> Tanmay
> 
> > 
> >> +		ret = zynqmp_r5_get_tcm_node(cluster);
> >> +	else
> >> +		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
> >> +
> >> +	if (ret) {
> >> +		dev_err(dev, "can't get tcm, err %d\n", ret);
> >>  		return ret;
> >>  	}
> >>  
> >> @@ -856,12 +930,18 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
> >>  			return ret;
> >>  		}
> >>  
> >> -		ret = zynqmp_r5_set_mode(r5_core, fw_reg_val, tcm_mode);
> >> -		if (ret) {
> >> -			dev_err(dev, "failed to set r5 cluster mode %d, err %d\n",
> >> -				cluster->mode, ret);
> >> +		ret = zynqmp_pm_set_rpu_mode(r5_core->pm_domain_id, fw_reg_val);
> >> +		if (ret < 0) {
> >> +			dev_err(r5_core->dev, "failed to set RPU mode\n");
> >>  			return ret;
> >>  		}
> >> +
> >> +		if (device_is_compatible(dev, "xlnx,zynqmp-r5fss") ||
> >> +		    of_find_property(dev_of_node(dev), "xlnx,tcm-mode", NULL)) {
> >> +			ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
> >> +			if (ret < 0)
> >> +				dev_err(r5_core->dev, "failed to configure TCM\n");
> >> +		}
> >>  	}
> >>  
> >>  	return 0;
> >> @@ -906,16 +986,25 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
> >>  	 * fail driver probe if either of that is not set in dts.
> >>  	 */
> >>  	if (cluster_mode == LOCKSTEP_MODE) {
> >> -		tcm_mode = PM_RPU_TCM_COMB;
> >>  		fw_reg_val = PM_RPU_MODE_LOCKSTEP;
> >>  	} else if (cluster_mode == SPLIT_MODE) {
> >> -		tcm_mode = PM_RPU_TCM_SPLIT;
> >>  		fw_reg_val = PM_RPU_MODE_SPLIT;
> >>  	} else {
> >>  		dev_err(dev, "driver does not support cluster mode %d\n", cluster_mode);
> >>  		return -EINVAL;
> >>  	}
> >>  
> >> +	if (device_is_compatible(dev, "xlnx,zynqmp-r5fss")) {
> >> +		if (cluster_mode == LOCKSTEP_MODE)
> >> +			tcm_mode = PM_RPU_TCM_COMB;
> >> +		else
> >> +			tcm_mode = PM_RPU_TCM_SPLIT;
> >> +	} else if (of_find_property(dev_node, "xlnx,tcm-mode", NULL)) {
> >> +		ret = of_property_read_u32(dev_node, "xlnx,tcm-mode", (u32 *)&tcm_mode);
> >> +		if (ret)
> >> +			return ret;
> >> +	}
> >> +
> >>  	/*
> >>  	 * Number of cores is decided by number of child nodes of
> >>  	 * r5f subsystem node in dts. If Split mode is used in dts
> >> @@ -1100,6 +1189,8 @@ static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
> >>  /* Match table for OF platform binding */
> >>  static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
> >>  	{ .compatible = "xlnx,zynqmp-r5fss", },
> >> +	{ .compatible = "xlnx,versal-r5fss", },
> >> +	{ .compatible = "xlnx,versal-net-r52fss", },
> >>  	{ /* end of list */ },
> >>  };
> >>  MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
> >> -- 
> >> 2.25.1
> >> 
> 

