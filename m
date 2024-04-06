Return-Path: <linux-kernel+bounces-133777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFB789A882
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 04:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5461F21E6C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8BD15EA2;
	Sat,  6 Apr 2024 02:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kd0FoFQ6"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4AE107B3
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 02:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712372202; cv=none; b=i59baPX60JzPD/yzJD2Sz2iWCIXe9HmPCJU+Y847Yh3tyPZgjMC7bUpFc8AevkqrpIR4MNuVulLd7fM2spoe9FnHTBRpPmBPT5Hf+ySeVFuJHpVNbXCyKpLIGppHJYcf6ZxA7m6YeIV9gJOFjxTPM6ZH3Lt642qVsjmykm9sn+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712372202; c=relaxed/simple;
	bh=/4vGjLhy5asNRBnYWaJSshGgBORPxL+tYufLDjKhMpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGMVk6Sb3M4FxTQb6NS8iS/lLalqfgb8IbptZYF35krAHUFl1xCePiBj2oVrF8S6vrldroHuFaKUm0k7ePD/cl3aPwluzK9cWy4BKB1fYoSUR2XtfO2P4mBwFAXzCstCJfoEbTvku7oig1x+7IswW4iXd/zEf2QAn3kZtjubwPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kd0FoFQ6; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d0161e13so2837020e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 19:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712372198; x=1712976998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XkuhIBlU9RYiWnHnizddy2d21zdQrAfJBlCZtmWWd30=;
        b=Kd0FoFQ6mOIaMoRgpofg4btZMFC7cLHOJtRa9xF7Y/SCgZKx2bZN2HuA5lW317ArAQ
         QdGey3EupJbBBjGUQ3WIyFqV02HPtYcNvk593DrR1pWTu9D39gJ/stV1AyB57ZHpgvv+
         wWg/ZLAtvUsOw+a6G5fZ1pFnZo3oC6PR1MnFfVgQo6FAMNqJg4iAELSjAHouaFKf/oFn
         bdK8zrfPf7dYwD/kwSD4SAX4JTJZNoayTGUFVNnbzSyCGV9hooZ+YE+OVd/bDCi7sqzP
         n8H/m+ui2v0X3Vrd4TVo9jerl9dyOLu64Cwn+5Zg7huU0f1wUT+rwTwQm7LsLsJzZB7M
         B33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712372198; x=1712976998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkuhIBlU9RYiWnHnizddy2d21zdQrAfJBlCZtmWWd30=;
        b=HGLvudgDQUkLV5BuOExBmTPsKXrWDzQO3hwQAzXUR8FPvSk3cmsxQZJCaoPw/1MYe5
         2pExDa6o1lul/jTgPmVYfevWGuob/rZwVeqXh/2mF0z6+x4Lx4lBheRhlqW1bq5o6Hg7
         /bOZkyWTa6I3vrGYlMkeXp68kcRHWKe+QVC4Xgmxz5UiHneMqfiKryPCQjrlS+yiO2Hl
         u5i7NpdZbExd40mqhbIDG8WtqriWStxKwPsTknSWgHA4+2mP21NGWphKlC6dsKWfshPA
         IIm49tDuHBk5ieeT22zZ2PodsXolmf2XF166rlYu94JJ9yIGAubE+YqThWcD6CXF5hpd
         ANIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9o4FbBcq7keAFpGMpk2Bxa9Y3BZY6X9A1a9NWrZyj77HZLSGvlp9bVEcAdt4zyIG1A14LK7fSur2frxC+2x3RhJADnwAYC5SgAr03
X-Gm-Message-State: AOJu0YylNU3H2uAS3s9idfW/cQ9i8HyUP1acYHDB6qJsIPv3Nct5KJJ3
	7PjUsoCyjssjtGSk6NDiaiuo1/C5/kDTJPfwLzKOoG5uFx+Dco9CBAuIl0TPqjY=
X-Google-Smtp-Source: AGHT+IEFyrUrT2ZntAekgJgSNMszFLZJgTqy/cn0YWgronRwNk9wRp1wJ9lXCAf/pLYAAOSg/cRiUg==
X-Received: by 2002:a05:6512:3d09:b0:513:c6ec:fa6c with SMTP id d9-20020a0565123d0900b00513c6ecfa6cmr3037333lfv.48.1712372197844;
        Fri, 05 Apr 2024 19:56:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id be37-20020a056512252500b00515af4b4878sm356263lfb.183.2024.04.05.19.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 19:56:37 -0700 (PDT)
Date: Sat, 6 Apr 2024 05:56:35 +0300
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
Subject: Re: [PATCH 3/6] drm/msm/adreno: Allow specifying default speedbin
 value
Message-ID: <pncr7ecf4eir36skul3iwt2nf5bpuwd5zjfzzfwwnxjwe4hoes@6z2xe54crijp>
References: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
 <20240405-topic-smem_speedbin-v1-3-ce2b864251b1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-topic-smem_speedbin-v1-3-ce2b864251b1@linaro.org>

On Fri, Apr 05, 2024 at 10:41:31AM +0200, Konrad Dybcio wrote:
> From: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Usually, speedbin 0 is the "super SKU", a.k.a the one which can clock
> the highest. Falling back to it when things go wrong is largely
> suboptimal, as more often than not, the top frequencies are not
> supposed to work on other bins.

Isn't it better to just return an error here instead of trying to guess
which speedbin to use?

If that's not the case, I think the commit should be expanded with
actually setting default_speedbin for the existing GPUs.

> 
> Let the developer specify the intended "lowest common denominator" bin
> in struct adreno_info. If not specified, partial struct initialization
> will ensure it's set to zero, retaining previous behavior.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> [Konrad: clean up, add commit message]
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 2 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 0674aca0f8a3..4cbdfabbcee5 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -2915,7 +2915,7 @@ static int a6xx_set_supported_hw(struct device *dev, const struct adreno_info *i
>  		DRM_DEV_ERROR(dev,
>  			"missing support for speed-bin: %u. Some OPPs may not be supported by hardware\n",
>  			speedbin);
> -		supp_hw = BIT(0); /* Default */
> +		supp_hw = BIT(info->default_speedbin); /* Default */
>  	}
>  
>  	ret = devm_pm_opp_set_supported_hw(dev, &supp_hw, 1);
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index 77526892eb8c..460b399be37b 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -110,6 +110,7 @@ struct adreno_info {
>  	 * {SHRT_MAX, 0} sentinal.
>  	 */
>  	struct adreno_speedbin *speedbins;
> +	unsigned int default_speedbin;
>  };
>  
>  #define ADRENO_CHIP_IDS(tbl...) (uint32_t[]) { tbl, 0 }
> 
> -- 
> 2.40.1
> 

-- 
With best wishes
Dmitry

