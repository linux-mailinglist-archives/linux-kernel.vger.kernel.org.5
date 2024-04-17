Return-Path: <linux-kernel+bounces-149312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419708A8F67
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38182835A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B74147C89;
	Wed, 17 Apr 2024 23:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GmQQJJfv"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FF286260
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713396789; cv=none; b=YQEDy4svDBzfuI9wHBIG7R1jQJnAej/ysq6Drdq4gyg6By09hLjFx3NIXR9hGC1DlCG5yLNWbT5tZXhl9U/5WWSJuxoVGqi2JKcKO8B0JpUYsulZXteEOa96jmBxHXq995WEaLsr8XzxHX6SjBWeuXkINbljLbHlmmUtNPH8YqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713396789; c=relaxed/simple;
	bh=F0mBqWZiiOdCg3f4DoGJPTXC8lMSKQdH2gEVKgPiLGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGJUbE+Tl5gVm9G1KuKz+ACGTtQ4hhk+JqGsP33Znpfjof9jnrLz/SqfUwVClGLfu8MdApF65Mi0i2OMIrrczm4mkveDTbRSEVJBVbr7NW7nX6NC6x77DKwjsdouGGRb+xLMGhMxAcMkfrBYVxZuX3+NQ8xKvFTyPP2hixHcUds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GmQQJJfv; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d68d7a8bso300977e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713396786; x=1714001586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GytF7V18qJIXql1WNL67e4Efwso8d/2I3bcLgaa+9g4=;
        b=GmQQJJfvx+3SBOD3c5Er7SGomMRhe7dbKTPSUgeAoDGFS5xxtETza4Y2AimRuYVBOS
         9ONaRoHHhaQi4WodlVS2dnX+e8F3FdikApQ5qiZeOW9HhdClIuV4RUkC+EpEaq5oitpe
         gUZuw8Op2Eht+JzzGUi1FBEFeiHGXvC0ulRHLXe5VXGuoPosbnnD2AypMd4t04j5dFHt
         +cGYpGn1OTwdgwd74uy3V1hXvPLyg6gtERLiJwZkbNGDKGlmC1DjVTXwv1nLJipnDdyw
         w5s2GmY6d4Xcjvma3KZ1sbJ97jOZVXcYyyU9ZjI90c+m+NsPQZ4GW8VNOsi1KlrK469Q
         72zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713396786; x=1714001586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GytF7V18qJIXql1WNL67e4Efwso8d/2I3bcLgaa+9g4=;
        b=gp4kj7MNZzKUuHyKRDYkEJnSJV0rumZlyZVrEJgwev79nmaQUiFrT1hFfy/j6AZbD4
         K8HgQDNN/pE2K03/ZIYP34yXDhKG062vSp7CCrXFpfkfjrPm0yI+XU/gaSzND9zqrXZ9
         LNcsXgLh7I1mYWJZArr/5ybizb//zcFYqG6ry4SzVxOenhSwAC+pJqv1RdZ5yBAGnzp9
         O+YH0p7zM1j5gSl0cx64HMdsuyb3xsbg+eyFYIBPYUqY2mJRjWjIzMkM3JqlDiX2Vv+6
         K6O5g+xnu11uFhlapjGSaSKPldWHRZsBmKeqs/nNKXBAvybKDexll7KvlOmvDgKb3Yrd
         O3QA==
X-Forwarded-Encrypted: i=1; AJvYcCVudRn95dhoyUjfJQ+xULItrVq6nan5up7Xol0/wBJdtWqrSvuA8spIRmbL0at9CLGqd8MJzcq09U/hfFZcDYrHKZ6mHUPrRDjvTO+h
X-Gm-Message-State: AOJu0YwTgKPZJFOEXhzSJ35Yx2K6FUNVc+iIiUEuKX7nhjLpNmmgQNuF
	1Zh1VPJM9+2ehQsEJODVzBxfsDSCH5GFhQ49+ObY+D+0OKD2vuLLQBZkO9FkboE=
X-Google-Smtp-Source: AGHT+IHb+xsUm4VWJnMlwMtid9HXu7fUVpDqeCABMYuWcpnukoEv8gokW3GsekdP+AHyE8ovJem9iw==
X-Received: by 2002:a19:914c:0:b0:519:5fb9:832b with SMTP id y12-20020a19914c000000b005195fb9832bmr122358lfj.12.1713396786144;
        Wed, 17 Apr 2024 16:33:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id e4-20020ac25464000000b00515d1c97053sm33367lfn.223.2024.04.17.16.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 16:33:05 -0700 (PDT)
Date: Thu, 18 Apr 2024 02:33:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Archit Taneja <architt@codeaurora.org>, 
	Chandan Uddaraju <chandanu@codeaurora.org>, Vinod Koul <vkoul@kernel.org>, 
	Sravanthi Kollukuduru <skolluku@codeaurora.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jordan Crouse <jordan@cosmicpenguin.net>, Rajesh Yadav <ryadav@codeaurora.org>, 
	Jeykumar Sankaran <jsanka@codeaurora.org>, ~postmarketos/upstreaming@lists.sr.ht, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Martin Botka <martin.botka@somainline.org>, Jami Kettunen <jami.kettunen@somainline.org>
Subject: Re: [PATCH 7/7] drm/msm/dpu: Rename `ctx` parameter to `intf` to
 match other functions
Message-ID: <er2p6zazlvc2okzbbqjkzy4mif3ukjes56nfow6kwybmkjxvtr@4ihyqymqzvit>
References: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-0-78ae3ee9a697@somainline.org>
 <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-7-78ae3ee9a697@somainline.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-7-78ae3ee9a697@somainline.org>

On Wed, Apr 17, 2024 at 01:57:47AM +0200, Marijn Suijten wrote:
> All other functions in dpu_hw_intf name the "self" parameter `intf`,
> except dpu_hw_intf_setup_timing_engine() and the recently added
> dpu_hw_intf_program_intf_cmd_cfg().  Clean that up for consistency.

I really have mixed feelings towards such patches. On one hand it
improves readability, on the other hand, it's just a name, it has no
specific value.

Still:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> index 965692ef7892..34d0c4e04d27 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> @@ -96,11 +96,11 @@
>  #define INTF_CFG2_DCE_DATA_COMPRESS     BIT(12)
>  
>  
> -static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
> +static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *intf,
>  		const struct dpu_hw_intf_timing_params *p,
>  		const struct dpu_format *fmt)
>  {
> -	struct dpu_hw_blk_reg_map *c = &ctx->hw;
> +	struct dpu_hw_blk_reg_map *c = &intf->hw;
>  	u32 hsync_period, vsync_period;
>  	u32 display_v_start, display_v_end;
>  	u32 hsync_start_x, hsync_end_x;
> @@ -118,7 +118,7 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>  	/* read interface_cfg */
>  	intf_cfg = DPU_REG_READ(c, INTF_CONFIG);
>  
> -	if (ctx->cap->type == INTF_DP)
> +	if (intf->cap->type == INTF_DP)
>  		dp_intf = true;
>  
>  	hsync_period = p->hsync_pulse_width + p->h_back_porch + p->width +
> @@ -223,7 +223,7 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>  	DPU_REG_WRITE(c, INTF_FRAME_LINE_COUNT_EN, 0x3);
>  	DPU_REG_WRITE(c, INTF_CONFIG, intf_cfg);
>  	DPU_REG_WRITE(c, INTF_PANEL_FORMAT, panel_format);
> -	if (ctx->cap->features & BIT(DPU_DATA_HCTL_EN)) {
> +	if (intf->cap->features & BIT(DPU_DATA_HCTL_EN)) {
>  		/*
>  		 * DATA_HCTL_EN controls data timing which can be different from
>  		 * video timing. It is recommended to enable it for all cases, except
> @@ -518,10 +518,10 @@ static void dpu_hw_intf_disable_autorefresh(struct dpu_hw_intf *intf,
>  
>  }
>  
> -static void dpu_hw_intf_program_intf_cmd_cfg(struct dpu_hw_intf *ctx,
> +static void dpu_hw_intf_program_intf_cmd_cfg(struct dpu_hw_intf *intf,
>  					     struct dpu_hw_intf_cmd_mode_cfg *cmd_mode_cfg)
>  {
> -	u32 intf_cfg2 = DPU_REG_READ(&ctx->hw, INTF_CONFIG2);
> +	u32 intf_cfg2 = DPU_REG_READ(&intf->hw, INTF_CONFIG2);
>  
>  	if (cmd_mode_cfg->data_compress)
>  		intf_cfg2 |= INTF_CFG2_DCE_DATA_COMPRESS;
> @@ -529,7 +529,7 @@ static void dpu_hw_intf_program_intf_cmd_cfg(struct dpu_hw_intf *ctx,
>  	if (cmd_mode_cfg->wide_bus_en)
>  		intf_cfg2 |= INTF_CFG2_DATABUS_WIDEN;
>  
> -	DPU_REG_WRITE(&ctx->hw, INTF_CONFIG2, intf_cfg2);
> +	DPU_REG_WRITE(&intf->hw, INTF_CONFIG2, intf_cfg2);
>  }
>  
>  struct dpu_hw_intf *dpu_hw_intf_init(struct drm_device *dev,
> 
> -- 
> 2.44.0
> 

-- 
With best wishes
Dmitry

