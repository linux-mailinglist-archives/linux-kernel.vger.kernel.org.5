Return-Path: <linux-kernel+bounces-133785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF5A89A8A8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 05:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3221F22BF8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 03:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021B914273;
	Sat,  6 Apr 2024 03:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mKF03xIF"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BC7EAD5
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 03:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712373934; cv=none; b=qTguyT+yAYw5xbzPPSFpAOvF9oOnky8bhXxL7y/175pma1k6V7Qs70VmTnWOPKkxcDSzGZYFUqmFilM6FoOMcne+Zcd8noHK4Lhy/M+xI6400+tR0pmMjXD5ABbQs4MailRe/6odw643Y73iC7Zu5MQEwOJ2aHIcDsAE77kTJZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712373934; c=relaxed/simple;
	bh=Zp4GKcLxMAVcZIrlPWTHostZnl24f29p5bF7AyQbWfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4xukIQRa2QN9Mft74+SZbHtGBWnvJzR9EE7K2elewMQ/uxpa+bvwraOEgPcX9wGhIIcUF/mmB1DqEuS8kYDSZ9z26InAAfEuKF6fMwnNGsXErF0RtPCuC2CbIS5o6cPs0EMmCHIHbELow1yfY2JQVG1ttZt3Q4c2hhqJ7QoBcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mKF03xIF; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d68d7a8bso948407e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 20:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712373931; x=1712978731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9LciZ4M+VANz8QCgE6eASTV8GxrZiI5bh38iNvVv6oo=;
        b=mKF03xIFDJCnmpV/a00KeGlHcJg4pRCE5ev5lVg32X9Y1GTCBOOKELc6HLb4aDsov+
         TI9h4ye7ydb/TWEHlfS3qe/QhZsbl61yktL8lyBF90j4uyMHxlAxEWjtr6Z8M5chAD1g
         Wkq3W6G+0Zs66BVnlQsMrd+4KbGwNe7nQLIrdxlytNE99K168bVl3x+cosGTxw0V3tpQ
         Xt10lg9lQVLbjl1IvGge8+/3dCUl/COvDIN7VrGG5Zy+3MF//dfcbTJB/ejX367TDn9t
         TH5m+jn2Zhpx9PHXTkXf9F36Q1PpiAmB8mtkS0LTN64VTNfjBYDlsLhyA5B9XYBuoiKC
         wGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712373931; x=1712978731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LciZ4M+VANz8QCgE6eASTV8GxrZiI5bh38iNvVv6oo=;
        b=vqCH8pixrvTaiQJaegarOEsKn/KyHM10gNR0BzYNiGGiPOBXB2l4CMFU5zzSdJZwgT
         N0uhmVVh0vsU/82rkgiBPzqU+4w/bWeJm6WHczbguIUCkXW4W0SA0lk5Mv/VfvnY7onF
         bB9CeK0luFy5Bv1O0vW6UIeNtVdUfsxiGUy/Pga1fUY1EdTs2cuJBDsL6CRg97z37PPy
         kBBtVlnOxjquF1LiMRwvshVzi5k6gIq88hyNuuc/HsAB9NkrwXtKaQAUGr5LXbfkqpfk
         Sbo8MwUckeeEG7QZjI0IlueTWH5Dw2yWXudHVVAV8DnWA+TeIzr+iW6oCL1MZCT6Mpsv
         2iwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV4XIjI1vGxyqWVvVDybCe2m8dQwmvtQyB/gFVBvcasErPQ4c93YcVWTXem2Dd2HnhaF8Uy6f9dLAK9LGFDQMDdupwkHJws6jR8EF2
X-Gm-Message-State: AOJu0Yzeel6KPCJt9nMezaIWVHABBOs5IZ5gYKAm3+GfAmdGw+mjCFon
	lORTGdobYGsKLDnKhxxuhwvRfiDDsio4voOckXQ3Yqq5cR2qeyzgtc0TQNXR7Y8=
X-Google-Smtp-Source: AGHT+IGrOU69waftjh0A7Nz5z2x9mrFhq3iGFQehyEz3srd6rEvrnruaA7pMOhjxQkC8Bwvyg1Nrsw==
X-Received: by 2002:a05:6512:548:b0:513:d167:f245 with SMTP id h8-20020a056512054800b00513d167f245mr1201499lfl.27.1712373930833;
        Fri, 05 Apr 2024 20:25:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id v12-20020a19740c000000b00516c2413c55sm357348lfe.49.2024.04.05.20.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 20:25:30 -0700 (PDT)
Date: Sat, 6 Apr 2024 06:25:28 +0300
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
Subject: Re: [PATCH 5/6] drm/msm/adreno: Add speedbin data for SM8550 / A740
Message-ID: <nek4paofg3hturvjwpa2bnsvmicwmvwixzr6e6iuqstemgrqyo@cagcrnzjsne2>
References: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
 <20240405-topic-smem_speedbin-v1-5-ce2b864251b1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-topic-smem_speedbin-v1-5-ce2b864251b1@linaro.org>

On Fri, Apr 05, 2024 at 10:41:33AM +0200, Konrad Dybcio wrote:
> Add speebin data for A740, as found on SM8550 and derivative SoCs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 901ef767e491..c976a485aef2 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -570,6 +570,20 @@ static const struct adreno_info gpulist[] = {
>  		.zapfw = "a740_zap.mdt",
>  		.hwcg = a740_hwcg,
>  		.address_space_size = SZ_16G,
> +		.speedbins = ADRENO_SPEEDBINS(

I think this deserves either a comment or some info in the commit
message.

> +			{ ADRENO_SKU_ID(SOCINFO_PC_UNKNOWN, SOCINFO_FC_AC), 0 },
> +			{ ADRENO_SKU_ID(SOCINFO_PC_UNKNOWN, SOCINFO_FC_AF), 0 },
> +			{ ADRENO_SKU_ID(SOCINFO_PCn(1), SOCINFO_FC_UNKNOWN), 1 },
> +			{ ADRENO_SKU_ID(SOCINFO_PCn(2), SOCINFO_FC_Yn(0x0)), 0 },
> +			{ ADRENO_SKU_ID(SOCINFO_PCn(2), SOCINFO_FC_Yn(0x2)), 0 },
> +			{ ADRENO_SKU_ID(SOCINFO_PCn(4), SOCINFO_FC_Yn(0x0)), 0 },
> +			{ ADRENO_SKU_ID(SOCINFO_PCn(4), SOCINFO_FC_Yn(0x2)), 0 },
> +			{ ADRENO_SKU_ID(SOCINFO_PCn(6), SOCINFO_FC_Yn(0x0)), 0 },
> +			{ ADRENO_SKU_ID(SOCINFO_PCn(6), SOCINFO_FC_Yn(0x1)), 0 },
> +			{ ADRENO_SKU_ID(SOCINFO_PCn(6), SOCINFO_FC_Yn(0xd)), 0 },
> +			{ ADRENO_SKU_ID(SOCINFO_PCn(6), SOCINFO_FC_Yn(0xe)), 0 },
> +		),
> +		.default_speedbin = 1,
>  	}, {
>  		.chip_ids = ADRENO_CHIP_IDS(0x43051401), /* "C520v2" */
>  		.family = ADRENO_7XX_GEN3,
> 
> -- 
> 2.40.1
> 

-- 
With best wishes
Dmitry

