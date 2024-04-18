Return-Path: <linux-kernel+bounces-150207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0A68A9BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E587FB232A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B54D161933;
	Thu, 18 Apr 2024 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qckfZu1D"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD001607B2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448374; cv=none; b=VH0967zbWbVhHad+J6S78spAsE1XHUiOdFpFk/KAu7kVw2YW4hGdkWD/MNpzYd++SUUmPe8MBohiwpY72t5QHIyVKzZwpo/S3Mpm2l+Obl3DUBAh+MerXjhv9grXO7PxfsFPjocy1fHM1vbfTKECy9HqcTlbJjW8Z8yNZvXmB7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448374; c=relaxed/simple;
	bh=rrJLEic6b430M5d1gdVy4F5Gjj2IiF/kZAlAhOoSm+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i95GH/Hc3BRFIzMI7/2NzCqzli1vtgibgTcFfxhZ4MtL31x/hBrOvfM+TMkr1rze0dHc61n+Y42853Te+mdrAuAaXwmrYpnPT5xphTWWykAu1jqV5TvmzcxXVk23zLhTRjgyNOKBuePSImQ1G8o2KjyM+D9y7n6FDBt9i/puQSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qckfZu1D; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-418effbc70cso3554915e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713448370; x=1714053170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RWbG4sKC6MWj6GtrMOZNqb19mu2ielKzyJ3R5+Nz7mI=;
        b=qckfZu1DXtbJ8whmn9PW11MBPw0iD6mpnnjyx2sbpzqS4CgWY+LFbA6x/2HJBIzfEx
         MqJNwRT9t5WM8+DDjD//TNcnPRovgn8ZE39TNyU7KqSTmYAxPIB8k5Az26s0A/+Q5EXH
         /2Z5DGAR3OIMI2mdHfihU16F5HYH6jiIdb9ps9hPP4a8IlxCZwCmTG0jMC/5C4oxxpke
         asIPPVNDx7gJAW29i+qPlmMzGjZjtsEVfU0n5Fzrk/vfDL8+xG6xgs6rom27MH440jzr
         20KHWu8VkjcFOB9IwEoPXRKRoxKFgzxXRXsNsc1tTwykDumjz7WwTWSfjIBgfpbiLJwz
         /C8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713448370; x=1714053170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWbG4sKC6MWj6GtrMOZNqb19mu2ielKzyJ3R5+Nz7mI=;
        b=YkYYuAbNF9vps1ChQzvCR2v8aXqWkpOl1GLRkWw1lnvnnmI3PJcqPEreBGUbpFb2eY
         u49T54/BlqJSUoDKUvuuwsMI2ggE/7oD48Pb4oiYxgbNZkgnv0C2pz0cAJQv6/DtxRH/
         yq9t/73MyEv3i89DUGx5ceMJmPzMDnZK+DtICD5fQBngOGz9i4rXVHIMFeYM3XURvISq
         dkEdoyFeSteyBJC5m7jeSdI3OqLRHSL0f+WkmLwHiEpHHmqJLfSr1H5GlO7tStBZvy/V
         S/bsMTaYoWDJlYn3D0ceHEcFZYMy7secYWjxi3Sw3/LFUAqQUu2eYAGixXTUdZ9gXeGn
         qCPA==
X-Forwarded-Encrypted: i=1; AJvYcCUKGSoHTRNRdPA07R/EXPmdRQhwqpHjmCVR2qkzsDy/jXnjvYGJkNYItiH1Q8CmY2VUqHPG8PNO4roXDgEj/DYDm2jMnTMrmzPBv1RU
X-Gm-Message-State: AOJu0Yww/jiJMGfB9DJ0ZtNxrXUuAeF/6I356BoXWykVfufsO4YtDWvw
	DSOzPN00WBwPt+t3w3923pm50b4jD+io/bOMWuYcnaL+lblwYwM52t6MDTiWhc4=
X-Google-Smtp-Source: AGHT+IHftEyUpBzc5z2d24qG1D0jDGSYD+HoX1PiiOfhTW9sfi19sqqjij+wzfohFDIByM5q6oSYtA==
X-Received: by 2002:a05:600c:548b:b0:417:d44f:5c50 with SMTP id iv11-20020a05600c548b00b00417d44f5c50mr1996191wmb.41.1713448370076;
        Thu, 18 Apr 2024 06:52:50 -0700 (PDT)
Received: from linaro.org ([62.231.100.236])
        by smtp.gmail.com with ESMTPSA id fj3-20020a05600c0c8300b00416b2cbad06sm6660102wmb.41.2024.04.18.06.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:52:49 -0700 (PDT)
Date: Thu, 18 Apr 2024 16:52:48 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: dispcc-x1e80100: Drop the reconfiguring of
 PLL0 on probe
Message-ID: <ZiElsMSXImj49Qle@linaro.org>
References: <20240418-x1e80100-dispcc-drop-pll0-reconfigure-v1-1-453e4e70e940@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-x1e80100-dispcc-drop-pll0-reconfigure-v1-1-453e4e70e940@linaro.org>

On 24-04-18 13:51:22, Abel Vesa wrote:
> Currently, PLL0 is configured by the bootloader is the parent of the
> mdp_clk_src. Reconfiguring it on probe leaves the PLL0 in "stand-by"
> state (unlocked), which will trigger RCG child clocks to not update
> their config, which then breaks eDP on all x1e80100 boards. So rely
> on the bootloader for now. Drop the config values as well. Also add
> a comment to explain why the PLL0 is not configured alongside PLL1.
> 
> Fixes: ee3f0739035f ("clk: qcom: Add dispcc clock driver for x1e80100")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Ignore this one. Sent a separate patch that handles this in another way:
https://lore.kernel.org/all/20240418-clk-qcom-lucid-evo-skip-configuring-enabled-v1-1-caede5f1c7a3@linaro.org/

>  drivers/clk/qcom/dispcc-x1e80100.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/clk/qcom/dispcc-x1e80100.c b/drivers/clk/qcom/dispcc-x1e80100.c
> index 0b2ee6456762..525f645094a8 100644
> --- a/drivers/clk/qcom/dispcc-x1e80100.c
> +++ b/drivers/clk/qcom/dispcc-x1e80100.c
> @@ -73,20 +73,6 @@ static const struct pll_vco lucid_ole_vco[] = {
>  	{ 249600000, 2300000000, 0 },
>  };
>  
> -static const struct alpha_pll_config disp_cc_pll0_config = {
> -	.l = 0xd,
> -	.alpha = 0x6492,
> -	.config_ctl_val = 0x20485699,
> -	.config_ctl_hi_val = 0x00182261,
> -	.config_ctl_hi1_val = 0x82aa299c,
> -	.test_ctl_val = 0x00000000,
> -	.test_ctl_hi_val = 0x00000003,
> -	.test_ctl_hi1_val = 0x00009000,
> -	.test_ctl_hi2_val = 0x00000034,
> -	.user_ctl_val = 0x00000000,
> -	.user_ctl_hi_val = 0x00000005,
> -};
> -
>  static struct clk_alpha_pll disp_cc_pll0 = {
>  	.offset = 0x0,
>  	.vco_table = lucid_ole_vco,
> @@ -1670,7 +1656,7 @@ static int disp_cc_x1e80100_probe(struct platform_device *pdev)
>  		goto err_put_rpm;
>  	}
>  
> -	clk_lucid_evo_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
> +	/* Configure only PLL1. PLL0 is already configured by bootloader */
>  	clk_lucid_evo_pll_configure(&disp_cc_pll1, regmap, &disp_cc_pll1_config);
>  
>  	/* Enable clock gating for MDP clocks */
> 
> ---
> base-commit: 4eab358930711bbeb85bf5ee267d0d42d3394c2c
> change-id: 20240418-x1e80100-dispcc-drop-pll0-reconfigure-0111b338c838
> 
> Best regards,
> -- 
> Abel Vesa <abel.vesa@linaro.org>
> 

