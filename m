Return-Path: <linux-kernel+bounces-149325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4220B8A8F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C331C20E50
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EB3126F11;
	Wed, 17 Apr 2024 23:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZ4Z2g1/"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633391C3E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713397390; cv=none; b=okBbTpd07c9kLjWiXdDl4UZKS3JatM58VIbsYS6fdngQM6Vc3vA2rQCLhAc1ROhFCNdy0rdpKvBnBa2dpyq8kz89IcxsK4dHIsncuymsryADdVLHCkYC+mjQY+oqQFL5LMRUX+b//+T2RFkjT+J4AW6nLJuDNDLM5YDho+N21LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713397390; c=relaxed/simple;
	bh=NBzj+erYFX0uj1VyOeMr+BZ1UuhXzSFJxjrqIXu64ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0kVaqq50BgpEoRWJLI8WT5TirK4eAYCKrJCX8oZgpVVBN8fs++pAFIOSsNJ+kUOgD/mGyu8XPfv5MHe5qxipz96N95IMin++0FGgqdtjJBAO6ZGAfqHM79av3eP/BgDqDGnIcozHHw19J0jQowpCLfjkwPsihGf294uJZR8z28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aZ4Z2g1/; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516d6e23253so263130e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713397387; x=1714002187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nqgl0cJ22faq0OLfGdwsUXUHBSiO8IFgnMRlpAUtFnY=;
        b=aZ4Z2g1/9K3jXN0onwgGXTwD818Abf393SVjPA04He1IRl86yqMW/aA1hi5QB4KpY9
         IQF7doKD+986RLE15HsViytMZijSUqZIxWsWkMt2ltaI0rnWXF+6MbH5cMEHnCNq10e4
         QcGCKcbLeAYMcQ7NQHml1j/SZsXfJKKcS6m/uV+ymxSwfpvspLy+lMvulRUPfxtAqAW3
         kJJEekbHYoTsxCpngkAgxHcs8hJ2drbPVGg3pUhj7855BR1MXHevfepGejBP4ihY5kCd
         MMy4//dZp8nGmFuBTqIyMjqdY829d59d/pEzJevOXnJOBVoTbr3rkcMh3PMdlkXa1/BU
         IE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713397387; x=1714002187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nqgl0cJ22faq0OLfGdwsUXUHBSiO8IFgnMRlpAUtFnY=;
        b=EM56o7X5mkoMLsBtH04Z9okW8+oNigmwuLAfFSGkgS0Amn4/PZUYzM3mvcS4cIqRCu
         KwWuSKdD8goco091Yjw7bN/WOWsQa06u6l05IrLCYjpeZHnpn8UZcHqKc3WovZD1ByJ0
         v0VBJvZZMnAqxiukqMkCIS72OPkv/W82pCTVbpS2J1jWwxGyGqq/kp1IfFgf5cVA8Xyu
         QUBVBfOufUft3rSy5qwP7hHtOCvPFdn7gNAgeByMPSL0gVKTZIV/Dohmmy44VBmDoBoI
         QATD2RjBB/tQWJVG4lHwMX3OiP+gRZ0bpb+DQc4yw0Bc4n9wfYGMm9mY9obuqPsU8sk1
         GQgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1p+ATO6pTNydUoqkzZHw7b6ZDxqKJ4yL72LvsVu3klgCdNYVBt0pbflbOq4CKZmN4iZ+cjhVC/aZ0ACkbQNaCdg5dmlJaLX/O+huU
X-Gm-Message-State: AOJu0YwRBV0cn4wegMt7pucckV6KkKQaLBFZ9ztfKZrhtBURDvCsKcfQ
	nEU9pN+whhzqqkJEeRhVbROW/FLIqAhYsx8ObsWm1CU9RteLNjEQpcgXFkV8Pyc=
X-Google-Smtp-Source: AGHT+IF9i4Z68hDQSut7wIF9JggheG5n5zLw3Jk7ObfMTXNDdwdfqQA4zyvf70wg2xXSQWrGdof4LQ==
X-Received: by 2002:ac2:4859:0:b0:516:c8e5:db35 with SMTP id 25-20020ac24859000000b00516c8e5db35mr522976lfy.18.1713397386612;
        Wed, 17 Apr 2024 16:43:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id w1-20020ac254a1000000b00516d264366fsm35066lfk.245.2024.04.17.16.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 16:43:06 -0700 (PDT)
Date: Thu, 18 Apr 2024 02:43:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 3/7] drm/msm/adreno: Implement SMEM-based speed bin
Message-ID: <hi7vzqm5ebypzs6m6bw64ghgfwsdzuaxy65jpah37iw5ww7fku@n3c5sucic27i>
References: <20240404-topic-smem_speedbin-v2-0-c84f820b7e5b@linaro.org>
 <20240404-topic-smem_speedbin-v2-3-c84f820b7e5b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404-topic-smem_speedbin-v2-3-c84f820b7e5b@linaro.org>

On Wed, Apr 17, 2024 at 10:02:55PM +0200, Konrad Dybcio wrote:
> On recent (SM8550+) Snapdragon platforms, the GPU speed bin data is
> abstracted through SMEM, instead of being directly available in a fuse.
> 
> Add support for SMEM-based speed binning, which includes getting
> "feature code" and "product code" from said source and parsing them
> to form something that lets us match OPPs against.
> 
> Due to the product code being ignored in the context of Adreno on
> production parts (as of SM8650), hardcode it to SOCINFO_PC_UNKNOWN.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  8 +++---
>  drivers/gpu/drm/msm/adreno/adreno_device.c |  2 ++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 41 +++++++++++++++++++++++++++---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    | 12 ++++++---
>  4 files changed, 53 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index d10323f15d40..60708c23ae4c 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -2890,13 +2890,15 @@ static u32 fuse_to_supp_hw(const struct adreno_info *info, u32 fuse)
>  	return UINT_MAX;
>  }
>  
> -static int a6xx_set_supported_hw(struct device *dev, const struct adreno_info *info)
> +static int a6xx_set_supported_hw(struct adreno_gpu *adreno_gpu,
> +				 struct device *dev,
> +				 const struct adreno_info *info)
>  {
>  	u32 supp_hw;
>  	u32 speedbin;
>  	int ret;
>  
> -	ret = adreno_read_speedbin(dev, &speedbin);
> +	ret = adreno_read_speedbin(adreno_gpu, dev, &speedbin);
>  	/*
>  	 * -ENOENT means that the platform doesn't support speedbin which is
>  	 * fine
> @@ -3056,7 +3058,7 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>  
>  	a6xx_llc_slices_init(pdev, a6xx_gpu, is_a7xx);
>  
> -	ret = a6xx_set_supported_hw(&pdev->dev, config->info);
> +	ret = a6xx_set_supported_hw(adreno_gpu, &pdev->dev, config->info);
>  	if (ret) {
>  		a6xx_llc_slices_destroy(a6xx_gpu);
>  		kfree(a6xx_gpu);
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index c3703a51287b..901ef767e491 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -6,6 +6,8 @@
>   * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
>   */
>  
> +#include <linux/soc/qcom/socinfo.h>
> +

Stray leftover?

>  #include "adreno_gpu.h"
>  
>  bool hang_debug = false;
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 074fb498706f..58fd70140685 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -21,6 +21,9 @@
>  #include "msm_gem.h"
>  #include "msm_mmu.h"
>  
> +#include <linux/soc/qcom/smem.h>
> +#include <linux/soc/qcom/socinfo.h>
> +
>  static u64 address_space_size = 0;
>  MODULE_PARM_DESC(address_space_size, "Override for size of processes private GPU address space");
>  module_param(address_space_size, ullong, 0600);
> @@ -1057,9 +1060,39 @@ void adreno_gpu_ocmem_cleanup(struct adreno_ocmem *adreno_ocmem)
>  			   adreno_ocmem->hdl);
>  }
>  
> -int adreno_read_speedbin(struct device *dev, u32 *speedbin)
> +int adreno_read_speedbin(struct adreno_gpu *adreno_gpu,
> +			 struct device *dev, u32 *fuse)
>  {
> -	return nvmem_cell_read_variable_le_u32(dev, "speed_bin", speedbin);
> +	u32 fcode;
> +	int ret;
> +
> +	/*
> +	 * Try reading the speedbin via a nvmem cell first
> +	 * -ENOENT means "no nvmem-cells" and essentially means "old DT" or
> +	 * "nvmem fuse is irrelevant", simply assume it's fine.
> +	 */
> +	ret = nvmem_cell_read_variable_le_u32(dev, "speed_bin", fuse);
> +	if (!ret)
> +		return 0;
> +	else if (ret != -ENOENT)
> +		return dev_err_probe(dev, ret, "Couldn't read the speed bin fuse value\n");
> +
> +#ifdef CONFIG_QCOM_SMEM

Please extract to a separate function and put the function under ifdef
(providing a stub otherwise). Having #ifndefs inside funciton body is
frowned upon.

> +	/*
> +	 * Only check the feature code - the product code only matters for
> +	 * proto SoCs unavailable outside Qualcomm labs, as far as GPU bin
> +	 * matching is concerned.
> +	 *
> +	 * Ignore EOPNOTSUPP, as not all SoCs expose this info through SMEM.
> +	 */
> +	ret = qcom_smem_get_feature_code(&fcode);
> +	if (!ret)
> +		*fuse = ADRENO_SKU_ID(fcode);
> +	else if (ret != -EOPNOTSUPP)
> +		return dev_err_probe(dev, ret, "Couldn't get feature code from SMEM\n");
> +#endif
> +
> +	return 0;
>  }
>  
>  int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
> @@ -1098,9 +1131,9 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>  			devm_pm_opp_set_clkname(dev, "core");
>  	}
>  
> -	if (adreno_read_speedbin(dev, &speedbin) || !speedbin)
> +	if (adreno_read_speedbin(adreno_gpu, dev, &speedbin) || !speedbin)
>  		speedbin = 0xffff;
> -	adreno_gpu->speedbin = (uint16_t) (0xffff & speedbin);
> +	adreno_gpu->speedbin = speedbin;
>  
>  	gpu_name = devm_kasprintf(dev, GFP_KERNEL, "%"ADRENO_CHIPID_FMT,
>  			ADRENO_CHIPID_ARGS(config->chip_id));
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index 77526892eb8c..8f2b70eaf6ad 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -81,7 +81,12 @@ extern const struct adreno_reglist a612_hwcg[], a615_hwcg[], a630_hwcg[], a640_h
>  extern const struct adreno_reglist a660_hwcg[], a690_hwcg[], a702_hwcg[], a730_hwcg[], a740_hwcg[];
>  
>  struct adreno_speedbin {
> -	uint16_t fuse;
> +	/* <= 16-bit for NVMEM fuses, 32b for SOCID values */
> +	uint32_t fuse;
> +/* As of SM8650, PCODE on production SoCs is meaningless wrt the GPU bin */
> +#define ADRENO_SKU_ID_FCODE		GENMASK(15, 0)
> +#define ADRENO_SKU_ID(fcode)	(SOCINFO_PC_UNKNOWN << 16 | fcode)

If we got rid of PCode matching, is there a need to actually use
SOCINFO_PC_UNKNOWN here? Or just 0 would be fine?

> +
>  	uint16_t speedbin;
>  };
>  
> @@ -136,7 +141,7 @@ struct adreno_gpu {
>  	struct msm_gpu base;
>  	const struct adreno_info *info;
>  	uint32_t chip_id;
> -	uint16_t speedbin;
> +	uint32_t speedbin;
>  	const struct adreno_gpu_funcs *funcs;
>  
>  	/* interesting register offsets to dump: */
> @@ -519,7 +524,8 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int flags,
>  			 struct adreno_smmu_fault_info *info, const char *block,
>  			 u32 scratch[4]);
>  
> -int adreno_read_speedbin(struct device *dev, u32 *speedbin);
> +int adreno_read_speedbin(struct adreno_gpu *adreno_gpu,
> +			 struct device *dev, u32 *speedbin);
>  
>  /*
>   * For a5xx and a6xx targets load the zap shader that is used to pull the GPU
> 
> -- 
> 2.44.0
> 

-- 
With best wishes
Dmitry

