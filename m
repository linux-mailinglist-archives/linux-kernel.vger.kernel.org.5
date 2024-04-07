Return-Path: <linux-kernel+bounces-134534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C4589B2A6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05FAF281B9D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F199839FDA;
	Sun,  7 Apr 2024 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKF1Qz+z"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBF329D02
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712502712; cv=none; b=ish7i0U512LsQhqMm0tAJjcS5CtjKVTLYhbnCnkSFThTipSRAOA4OhVyuhMDUUxpd40A8eb4oIRa+FBYUMkdOXmbNqizHp72tvSUV39G75OCewJnWK+5XBt81NRQ7tCyt9dW0u6vW4DDZwBECq4FDPXJFHIBTXN2kH3/Nuu0oro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712502712; c=relaxed/simple;
	bh=5uIImuGQ4ZEW/qy0KdAjTxqyOTexb/Nu/WZSM8f+Npc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAJCPSCxlPWqDlnYvQ+wVr7mC529b4tSwVQYcAnpuzJsD+XmmGXPNIOIxT72cF2uFhb2L1IBmAQNxe08sPp+u81Rs2kwCVEGCchG0M5j+tCKLWonQgtc2dR5ESKTz2EX1NLaLHYYGaYqqqODbtSMIklglDyYNDKVDmOCC8S2KmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bKF1Qz+z; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e509baddaso353122a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 08:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712502708; x=1713107508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1L6tj3Ykhqe3bT0DzwbvYek6Lx7l4bP1RVMn9TnkTIM=;
        b=bKF1Qz+zgp2MxWr1+JizRxJPENojA1N5ezIfmhDDxuXsBFr2M5LPWYKWWsvTI53D2g
         Xgzm+V9Z5LebbNFiGtUH0Y7TS4nUCy+22NdHO5YsQVJnhJQNskL6Djp31UruH1hDffez
         WWgzDRP6qJxRul/39bqBx/8kj8WKyfOevgw6Bt4L6PdQbjAZqsiryCpzeQ43WPj6Kmd4
         Sydzr5OpACIr7UaEdX0FIyhfzD9DqszkNJ3YAXOHDOm6Pzi5zCN9VQw86lMvqq+dGh97
         NzfHDtt7voVoneNKL4fp6Ct9XLB2F0ajfRWVvDi5rwrbqgPVRKZw3MePB8SDJMTDM6iV
         0Q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712502708; x=1713107508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1L6tj3Ykhqe3bT0DzwbvYek6Lx7l4bP1RVMn9TnkTIM=;
        b=WEnrwjLv2PBUVFdbkZy8oi8xv3n1hUWyxwzN0bcCk1pFkwEwdie7qfbToUneQMFytx
         lYF1lW36yCzDgX6EBAWiK/TcR09szRaqYuIst7u3+tYK5U82QO6odEZt5rsgDxtkmCAi
         fEuaZa+BfrI2KlcX6TShjspR2cyK47Wa/rMoNPdUuCnCzQFG5bZjCgk4uGdthOpSLVh0
         wV92fF0LS1b5EpTCNNfy+ncbn2CnRmDJND6y4VL8L97Px1ZkxdF6MfTaNviU8H/0f3Uu
         WMCnVEyWjGyClLRDTysu1gbiDL6i1XP9TaSfpWH8NSEy0NurbGCj14BSevMbExOXSwIu
         5JjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW48VZ/e/+oXR7VleAdK2cbg52I5CfjaIGFipptOIqGkbnhQKA9ZUPcr7d+F+u7XnOikI3pxsnOj1TrBabGGBZVMGe+/lSqfZJJ8kjn
X-Gm-Message-State: AOJu0Yw90/0gWBvFlE/AvtoNx1l1SdXv6kdUeW/Z0z1x9t9YNubHx8BR
	kys5JQBbnlz1A7tx1e5N9v23WMl0hjdxUBcUOkV6ROToP5Tcc7aNPVUVcT3jNEs=
X-Google-Smtp-Source: AGHT+IHElRvRYkTsvef4HJyWIpPMDFwQYWdafxiP3Xm2EkrU6lPRRRXxKLZTeoMyg+mwIL/wZIUWOQ==
X-Received: by 2002:a17:907:3daa:b0:a51:d4fa:cf92 with SMTP id he42-20020a1709073daa00b00a51d4facf92mr306861ejc.14.1712502707981;
        Sun, 07 Apr 2024 08:11:47 -0700 (PDT)
Received: from linaro.org ([79.114.172.194])
        by smtp.gmail.com with ESMTPSA id dr2-20020a170907720200b00a4ea1fbb323sm3239743ejc.98.2024.04.07.08.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 08:11:47 -0700 (PDT)
Date: Sun, 7 Apr 2024 18:11:46 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dp: Remove now unused connector_type from desc
Message-ID: <ZhK3sijUdGBSCMVz@linaro.org>
References: <20240405-dp-connector-type-cleanup-v2-1-0f47d5462ab9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-dp-connector-type-cleanup-v2-1-0f47d5462ab9@quicinc.com>

On 24-04-05 20:14:11, Bjorn Andersson wrote:
> Now that the connector_type is dynamically determined, the
> connector_type of the struct msm_dp_desc is unused. Clean it up.
> 
> Remaining duplicate entries are squashed.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
> This cleans up after, and hence depends on,
> https://lore.kernel.org/all/20240324-x1e80100-display-refactor-connector-v4-1-e0ebaea66a78@linaro.org/
> ---
> Changes in v2:
> - Squashed now duplicate entries
> - Link to v1: https://lore.kernel.org/r/20240328-dp-connector-type-cleanup-v1-1-9bf84c5a6082@quicinc.com
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 48 +++++++++++++------------------------
>  1 file changed, 17 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 521cba76d2a0..12c01625c551 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -119,55 +119,41 @@ struct dp_display_private {
>  struct msm_dp_desc {
>  	phys_addr_t io_start;
>  	unsigned int id;
> -	unsigned int connector_type;
>  	bool wide_bus_supported;
>  };
>  
>  static const struct msm_dp_desc sc7180_dp_descs[] = {
> -	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
> +	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0 },
>  	{}
>  };
>  
>  static const struct msm_dp_desc sc7280_dp_descs[] = {
> -	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
> -	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_1, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_supported = true },
> +	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
> +	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
>  	{}
>  };
>  
>  static const struct msm_dp_desc sc8180x_dp_descs[] = {
> -	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
> -	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
> -	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .connector_type = DRM_MODE_CONNECTOR_eDP },
> +	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0 },
> +	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1 },
> +	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2 },
>  	{}
>  };
>  
>  static const struct msm_dp_desc sc8280xp_dp_descs[] = {
> -	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
> -	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
> -	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
> -	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_3, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
> -	{ .io_start = 0x22090000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
> -	{ .io_start = 0x22098000, .id = MSM_DP_CONTROLLER_1, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
> -	{ .io_start = 0x2209a000, .id = MSM_DP_CONTROLLER_2, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
> -	{ .io_start = 0x220a0000, .id = MSM_DP_CONTROLLER_3, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_supported = true },
> -	{}
> -};
> -
> -static const struct msm_dp_desc sc8280xp_edp_descs[] = {
> -	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_supported = true },
> -	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_3, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_supported = true },
> -	{ .io_start = 0x2209a000, .id = MSM_DP_CONTROLLER_2, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_supported = true },
> -	{ .io_start = 0x220a0000, .id = MSM_DP_CONTROLLER_3, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_supported = true },
> -	{}
> -};
> -
> -static const struct msm_dp_desc sm8350_dp_descs[] = {
> -	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
> +	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
> +	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
> +	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
> +	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
> +	{ .io_start = 0x22090000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
> +	{ .io_start = 0x22098000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
> +	{ .io_start = 0x2209a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
> +	{ .io_start = 0x220a0000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
>  	{}
>  };
>  
>  static const struct msm_dp_desc sm8650_dp_descs[] = {
> -	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
> +	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0 },
>  	{}
>  };
>  
> @@ -186,9 +172,9 @@ static const struct of_device_id dp_dt_match[] = {
>  	{ .compatible = "qcom,sc8180x-dp", .data = &sc8180x_dp_descs },
>  	{ .compatible = "qcom,sc8180x-edp", .data = &sc8180x_dp_descs },
>  	{ .compatible = "qcom,sc8280xp-dp", .data = &sc8280xp_dp_descs },
> -	{ .compatible = "qcom,sc8280xp-edp", .data = &sc8280xp_edp_descs },
> +	{ .compatible = "qcom,sc8280xp-edp", .data = &sc8280xp_dp_descs },
>  	{ .compatible = "qcom,sdm845-dp", .data = &sc7180_dp_descs },
> -	{ .compatible = "qcom,sm8350-dp", .data = &sm8350_dp_descs },
> +	{ .compatible = "qcom,sm8350-dp", .data = &sc7180_dp_descs },
>  	{ .compatible = "qcom,sm8650-dp", .data = &sm8650_dp_descs },
>  	{ .compatible = "qcom,x1e80100-dp", .data = &x1e80100_dp_descs },
>  	{}
> 
> ---
> base-commit: a874b50929e2596deeeeaf21d09f1561a7c59537
> change-id: 20240328-dp-connector-type-cleanup-af6501e374b3
> 
> Best regards,
> -- 
> Bjorn Andersson <quic_bjorande@quicinc.com>
> 

