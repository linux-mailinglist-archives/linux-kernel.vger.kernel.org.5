Return-Path: <linux-kernel+bounces-149329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 227DD8A8FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C663C2838FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB5D1272DC;
	Wed, 17 Apr 2024 23:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgAGRV+p"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822E8612C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713397751; cv=none; b=hFsoGVU8aFcWEQ7It87x5N//KBmBJjh1IFWoyvb7f7A4EPW6oXyhOUoi1hpOlA2HQyIqOflZ4eyCj7pIJYCRVoJwZusWbjXQ+uWiiwgunGJf1qa5MTPhOfRpuyhTLzkHTlOzc8w9K/zqa52jhtc8RIVIV6uJ6BoK1ZpLhxZfEas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713397751; c=relaxed/simple;
	bh=ydQPZYMDXL0bz5VR7PqTzu60zL5JIyJlMrNtwV3g1IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWb8XWazBEIqI6whq+tAkD2VSe5v5hLm0tvA9vvjj11wPiVc8miES87sOfB3wrem0WARbB2PsBenU2c8dQ524tq5zYY5PaDyv0qzK/37VBdupBuKqzLL6PxdCRqfcJHqUTnBlT6EX7wMviKV880CcDy1s6wbpNwIebNWUYcm2wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fgAGRV+p; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5194a2cf7c2so228802e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713397748; x=1714002548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nngiFYr9mRUHRzMmWgZIeUxNkr5PQUTrbaNg5/mFBkM=;
        b=fgAGRV+p6NDxqxSjv1pxEbce6oxIEvm23bjxiihkQEqMMMxMqJGnnshe3/mN9Tx8ad
         6mZEJD4FM2QZMkPH10qfVh4x6Bw+aadqPCYfRnaJWnVyxOwZjOfkq0SjFeU7adamgfM2
         bujAYZWQc9qHYOsqq8jwhrD9F5jYqois6qxIEd04X42dS7UCYCCiNeL7F4DyIuPboant
         cqB5sWBVu3ryuuv9JI2SB76Q3GTxkxYV5dbY00H3jtM40NbcC33+H9mS5pPHoHuVsDTG
         XbSn0A90a8Z5jUcBSLytkEHZwRuTjzEw046oGsSE5unkN7NnrCJ8dgLbNTfccSTpJD2s
         cGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713397748; x=1714002548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nngiFYr9mRUHRzMmWgZIeUxNkr5PQUTrbaNg5/mFBkM=;
        b=c2EfFHM1+nbfrkAiKMZ9cXC7/jU0G5RJcwhFvGSPwCVzcHYahzHadclPlxnSUVSDXm
         A6hjQYxhAlESozbEaQGT35bolJ4fzcrC3061nbntrmR0thJ55NMjqMOGEciYQRfHx6Sj
         uWZJzTjlGUqKTD7njDfQD25Nh2PsUiLosTnY4sDjJonob54HBqL55NjAtyDWvz7EGCZG
         Ka1d2iozJVdN1mtUMkzqXeAjQqqkLc5HMzAfHGLOFrIC5fSDHpxiO0vnJNFZWTn+DZlr
         70pYgUHVR7FhdBWtEzsyCk+QAaAKDcdurr9O4sqvVZGyLxZ0nPbhZIm7l3sQJviY1A75
         E5GA==
X-Forwarded-Encrypted: i=1; AJvYcCUDz/1SVQurpTk5YHwwfcP9Q0O6+D6EN3olHxAsWukKFYd17aTKkI74lGevex+NC1NgKHaAzKbC610wqWigmUS0Im8n+u4AB/6hqppg
X-Gm-Message-State: AOJu0Yz/eIo9V4E1gJAYL0peaeyCqpcIFjrlTIE2F+A40WqUN2qSi8Pn
	67HEHKRS87NBZAmOlDVqFkDo8exWPad5d9OlRjavIicQm3dsIPppvLxEQfJgAaQ=
X-Google-Smtp-Source: AGHT+IGK7phArybsknZoDpDHCYydFOpwa3P+8qYsmkA9dt5Nu7XPtd2Ekg0jJGshih+vocBURUnfZw==
X-Received: by 2002:a19:8c0f:0:b0:515:c0ca:d9e6 with SMTP id o15-20020a198c0f000000b00515c0cad9e6mr366108lfd.38.1713397748020;
        Wed, 17 Apr 2024 16:49:08 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id n22-20020a05651203f600b005190317b9d2sm36628lfq.225.2024.04.17.16.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 16:49:07 -0700 (PDT)
Date: Thu, 18 Apr 2024 02:49:06 +0300
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
Subject: Re: [PATCH v2 6/7] drm/msm/adreno: Redo the speedbin assignment
Message-ID: <rilfqdvei26bjyz76hdsh5wlh4s2lcn235up2vxbs65pnolyty@rs77jbxxqzye>
References: <20240404-topic-smem_speedbin-v2-0-c84f820b7e5b@linaro.org>
 <20240404-topic-smem_speedbin-v2-6-c84f820b7e5b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404-topic-smem_speedbin-v2-6-c84f820b7e5b@linaro.org>

On Wed, Apr 17, 2024 at 10:02:58PM +0200, Konrad Dybcio wrote:
> There is no need to reinvent the wheel for simple read-match-set logic.
> 
> Make speedbin discovery and assignment generation independent.
> 
> This implicitly removes the bogus 0x80 / BIT(7) speed bin on A5xx,
> which has no representation in hardware whatshowever.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   | 34 ----------------
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 56 --------------------------
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 70 +++++++++++++++++++++++++++------
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h |  3 --
>  drivers/gpu/drm/msm/msm_gpu.c           |  3 --
>  5 files changed, 57 insertions(+), 109 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index c003f970189b..eed6a2eb1731 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -1704,38 +1704,6 @@ static const struct adreno_gpu_funcs funcs = {
>  	.get_timestamp = a5xx_get_timestamp,
>  };
>  
> -static void check_speed_bin(struct device *dev)
> -{
> -	struct nvmem_cell *cell;
> -	u32 val;
> -
> -	/*
> -	 * If the OPP table specifies a opp-supported-hw property then we have
> -	 * to set something with dev_pm_opp_set_supported_hw() or the table
> -	 * doesn't get populated so pick an arbitrary value that should
> -	 * ensure the default frequencies are selected but not conflict with any
> -	 * actual bins
> -	 */
> -	val = 0x80;
> -
> -	cell = nvmem_cell_get(dev, "speed_bin");
> -
> -	if (!IS_ERR(cell)) {
> -		void *buf = nvmem_cell_read(cell, NULL);
> -
> -		if (!IS_ERR(buf)) {
> -			u8 bin = *((u8 *) buf);
> -
> -			val = (1 << bin);
> -			kfree(buf);
> -		}
> -
> -		nvmem_cell_put(cell);
> -	}
> -
> -	devm_pm_opp_set_supported_hw(dev, &val, 1);
> -}
> -
>  struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
>  {
>  	struct msm_drm_private *priv = dev->dev_private;
> @@ -1763,8 +1731,6 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
>  
>  	a5xx_gpu->lm_leakage = 0x4E001A;
>  
> -	check_speed_bin(&pdev->dev);
> -
>  	nr_rings = 4;
>  
>  	if (config->info->revn == 510)
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 60708c23ae4c..1242697d64a7 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -2878,55 +2878,6 @@ static bool a6xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
>  	return progress;
>  }
>  
> -static u32 fuse_to_supp_hw(const struct adreno_info *info, u32 fuse)
> -{
> -	if (!info->speedbins)
> -		return UINT_MAX;
> -
> -	for (int i = 0; info->speedbins[i].fuse != SHRT_MAX; i++)
> -		if (info->speedbins[i].fuse == fuse)
> -			return BIT(info->speedbins[i].speedbin);
> -
> -	return UINT_MAX;
> -}
> -
> -static int a6xx_set_supported_hw(struct adreno_gpu *adreno_gpu,
> -				 struct device *dev,
> -				 const struct adreno_info *info)
> -{
> -	u32 supp_hw;
> -	u32 speedbin;
> -	int ret;
> -
> -	ret = adreno_read_speedbin(adreno_gpu, dev, &speedbin);
> -	/*
> -	 * -ENOENT means that the platform doesn't support speedbin which is
> -	 * fine
> -	 */
> -	if (ret == -ENOENT) {
> -		return 0;
> -	} else if (ret) {
> -		dev_err_probe(dev, ret,
> -			      "failed to read speed-bin. Some OPPs may not be supported by hardware\n");
> -		return ret;
> -	}
> -
> -	supp_hw = fuse_to_supp_hw(info, speedbin);
> -
> -	if (supp_hw == UINT_MAX) {
> -		DRM_DEV_ERROR(dev,
> -			"missing support for speed-bin: %u. Some OPPs may not be supported by hardware\n",
> -			speedbin);
> -		supp_hw = BIT(0); /* Default */
> -	}
> -
> -	ret = devm_pm_opp_set_supported_hw(dev, &supp_hw, 1);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> -}
> -
>  static const struct adreno_gpu_funcs funcs = {
>  	.base = {
>  		.get_param = adreno_get_param,
> @@ -3058,13 +3009,6 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>  
>  	a6xx_llc_slices_init(pdev, a6xx_gpu, is_a7xx);
>  
> -	ret = a6xx_set_supported_hw(adreno_gpu, &pdev->dev, config->info);
> -	if (ret) {
> -		a6xx_llc_slices_destroy(a6xx_gpu);
> -		kfree(a6xx_gpu);
> -		return ERR_PTR(ret);
> -	}
> -
>  	if (is_a7xx)
>  		ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs_a7xx, 1);
>  	else if (adreno_has_gmu_wrapper(adreno_gpu))
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 58fd70140685..08b2f08e2a14 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -1060,8 +1060,8 @@ void adreno_gpu_ocmem_cleanup(struct adreno_ocmem *adreno_ocmem)
>  			   adreno_ocmem->hdl);
>  }
>  
> -int adreno_read_speedbin(struct adreno_gpu *adreno_gpu,
> -			 struct device *dev, u32 *fuse)
> +static int adreno_read_speedbin(struct adreno_gpu *adreno_gpu,
> +				struct device *dev, u32 *fuse)
>  {
>  	u32 fcode;
>  	int ret;
> @@ -1095,6 +1095,46 @@ int adreno_read_speedbin(struct adreno_gpu *adreno_gpu,
>  	return 0;
>  }
>  
> +#define ADRENO_SPEEDBIN_FUSE_NODATA	0xFFFF /* Made-up large value, expected by mesa */
> +static int adreno_set_speedbin(struct adreno_gpu *adreno_gpu, struct device *dev)
> +{
> +	const struct adreno_info *info = adreno_gpu->info;
> +	u32 fuse = ADRENO_SPEEDBIN_FUSE_NODATA;
> +	u32 supp_hw = UINT_MAX;
> +	int ret;
> +
> +	/* No speedbins defined for this GPU SKU => allow all defined OPPs */
> +	if (!info->speedbins) {
> +		adreno_gpu->speedbin = ADRENO_SPEEDBIN_FUSE_NODATA;
> +		return devm_pm_opp_set_supported_hw(dev, &supp_hw, 1);

BIT(0)

> +	}
> +
> +	/*
> +	 * If a real error (not counting older devicetrees having no nvmem references)
> +	 * occurs when trying to get the fuse value, bail out.
> +	 */
> +	ret = adreno_read_speedbin(adreno_gpu, dev, &fuse);
> +	if (ret) {
> +		return ret;
> +	} else if (fuse == ADRENO_SPEEDBIN_FUSE_NODATA) {
> +		/* The info struct has speedbin data, but the DT is too old => allow all OPPs */

Missing assignment to adeno_gpu->speedbin ? Or is it fine?

> +		DRM_DEV_INFO(dev, "No GPU speed bin fuse, please update your device tree\n");
> +		return devm_pm_opp_set_supported_hw(dev, &supp_hw, 1);

BIT(0)
maybe #define it?

> +	}
> +
> +	adreno_gpu->speedbin = fuse;
> +
> +	/* Traverse the known speedbins */
> +	for (int i = 0; info->speedbins[i].fuse != SHRT_MAX; i++) {
> +		if (info->speedbins[i].fuse == fuse) {
> +			supp_hw = BIT(info->speedbins[i].speedbin);
> +			return devm_pm_opp_set_supported_hw(dev, &supp_hw, 1);
> +		}
> +	}
> +
> +	return dev_err_probe(dev, -EINVAL, "Unknown speed bin fuse value: 0x%x\n", fuse);
> +}
> +
>  int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>  		struct adreno_gpu *adreno_gpu,
>  		const struct adreno_gpu_funcs *funcs, int nr_rings)
> @@ -1104,7 +1144,6 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>  	struct msm_gpu_config adreno_gpu_config  = { 0 };
>  	struct msm_gpu *gpu = &adreno_gpu->base;
>  	const char *gpu_name;
> -	u32 speedbin;
>  	int ret;
>  
>  	adreno_gpu->funcs = funcs;
> @@ -1131,29 +1170,34 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>  			devm_pm_opp_set_clkname(dev, "core");
>  	}
>  
> -	if (adreno_read_speedbin(adreno_gpu, dev, &speedbin) || !speedbin)
> -		speedbin = 0xffff;
> -	adreno_gpu->speedbin = speedbin;
> -
>  	gpu_name = devm_kasprintf(dev, GFP_KERNEL, "%"ADRENO_CHIPID_FMT,
>  			ADRENO_CHIPID_ARGS(config->chip_id));
>  	if (!gpu_name)
>  		return -ENOMEM;
>  
>  	adreno_gpu_config.ioname = "kgsl_3d0_reg_memory";
> -
>  	adreno_gpu_config.nr_rings = nr_rings;
>  
> +	pm_runtime_set_autosuspend_delay(dev, adreno_gpu->info->inactive_period);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	ret = msm_gpu_init(drm, pdev, &adreno_gpu->base, &funcs->base,
> +			   gpu_name, &adreno_gpu_config);
> +	if (ret)
> +		return ret;
> +
> +	ret = adreno_set_speedbin(adreno_gpu, dev);
> +	if (ret)
> +		return ret;
> +
>  	ret = adreno_get_pwrlevels(dev, gpu);
>  	if (ret)
>  		return ret;
>  
> -	pm_runtime_set_autosuspend_delay(dev,
> -		adreno_gpu->info->inactive_period);
> -	pm_runtime_use_autosuspend(dev);
> +	/* Devfreq can only be initialized after OPP */
> +	msm_devfreq_init(gpu);
>  
> -	return msm_gpu_init(drm, pdev, &adreno_gpu->base, &funcs->base,
> -			gpu_name, &adreno_gpu_config);
> +	return 0;
>  }
>  
>  void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index 8f2b70eaf6ad..30e8b9919adb 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -524,9 +524,6 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int flags,
>  			 struct adreno_smmu_fault_info *info, const char *block,
>  			 u32 scratch[4]);
>  
> -int adreno_read_speedbin(struct adreno_gpu *adreno_gpu,
> -			 struct device *dev, u32 *speedbin);
> -
>  /*
>   * For a5xx and a6xx targets load the zap shader that is used to pull the GPU
>   * out of secure mode
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 655002b21b0d..8504eaab8ef6 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -932,9 +932,6 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>  	gpu->pdev = pdev;
>  	platform_set_drvdata(pdev, &gpu->adreno_smmu);
>  
> -	msm_devfreq_init(gpu);
> -
> -
>  	gpu->aspace = gpu->funcs->create_address_space(gpu, pdev);
>  
>  	if (gpu->aspace == NULL)
> 
> -- 
> 2.44.0
> 

-- 
With best wishes
Dmitry

