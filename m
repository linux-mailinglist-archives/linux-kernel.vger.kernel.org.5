Return-Path: <linux-kernel+bounces-81003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38A8866EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6929DB20BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F30979DA0;
	Mon, 26 Feb 2024 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lg53u2nu"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B5E79935
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938274; cv=none; b=r1Vq1S6lcLgXQqtwnNYt15CSHN+kqq7/rPx5nrl58omW9zNcvDC3KkY55TcnTnAsRYQ04i3xx4wrVu5aFZ4MB4bQXXczfeexxV9bSxy/+zIsI2iQlTcUW5FNUP7nRevvgdJyPMCIkUFtARfiQNBge2FLeTWnDEoEif1fhh4s43Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938274; c=relaxed/simple;
	bh=Jm7acJD9o2mBJ7G+eOxNpeNfksyPwS+AXcvG2TmDrwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVaIZJXXDZ5mH5g3pA1qLStWVEyVUFe2Wi/+w6aLc5V4JESVMR0FP0XOU7fpDNemnwMAQGOSViJy0B5A98o7SblMgb+w/GpSgTzFkhV46QZYYieMiTl6x37I7T9jz5iwRw4jCe7zPWXEzuvZSRS7ABr3QLmA7/CqHj0xjpGR970=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lg53u2nu; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3e6f79e83dso290782366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708938271; x=1709543071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XK97/Ais5pPf/X1///jyXhhD+o5dKRJYFfX0RVnBU80=;
        b=Lg53u2nuGkywoA58JgAtYB6JuoZZaUhNyaJVG1KTw0PBjK4goxNg01uM3Zc+h+6dId
         DBlHTfnKCt+XSg71HoUoZoCt3irpmeYzmHIaSf9pYIAeotbSf9xxO3LvcnDdIIM9FZ1Q
         ujSpeU/tj5UG4Kjr+DZxrJ5auWQfhIwsK5O2ukIKNXcI9OxAcI244d5L0iowMEOPGKf9
         HTuUYZyvsKoHKsXHwNq7woDDI+FjrxLLO8P9km35uBX0yNupA0aKkAdVBw39wssyCsfM
         9+5k6EprHbw3fwWVF/EsaHRF3vl5P0VWOAreddCWPi0eSMe5yf+hiKQ4aRYDdz5wrs5h
         mFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708938271; x=1709543071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XK97/Ais5pPf/X1///jyXhhD+o5dKRJYFfX0RVnBU80=;
        b=tXS3LBj3A2dZKwt8ZTWVeiBGxq7UPAUDCXD4rKkslUT4B7KtZ005IKA7pOMEXG8lUo
         /xtNF7/fK1tVlP2mrw9tjJ6MbnEWrFjAzQaU3a9MfIVAhJKJRmMEGN5P+5xNA1Q9sIQk
         3SAUIHXm1MPcyV4feLXhd7AYHS7vpVjS/bW1yldp/hxW8xCjClCLIeugzrZeOi2mn2Br
         Q03xpCp9C1kLUnSbMeWx5KGeEena/mR+REU2FKtjzoHAl4vaGn3JY1PLCg6do1fEJBBN
         O6WzMWvhOwa9PZgiAIdhgGMJC/CjL7YJHyWnszYE+Xi5eKz+V6LNlL5LGUlMR9HbhVoN
         MeAg==
X-Forwarded-Encrypted: i=1; AJvYcCWzkqWURvq3AqGmKyj3wRHyC3WDDMXLn+ScWVSMzVRHfJplrpkaEUaU6PVHxoWoWyAR2yuAQFdObnRtBfBhe4lzNyMcC1X0EkpmGWQW
X-Gm-Message-State: AOJu0Yyr4eEqNhWRVkD74kUbA3xNIHJpwv6tLpXpBRqoD2Adug33ZJjY
	xkG6QDGZbp3oJlfhtq0D8FDSjSEmR7R1YTEGruQfiBHUxdiaJ8FLdimYpiw6XJI=
X-Google-Smtp-Source: AGHT+IEP31lrkAYgXHTXfaTNGbJ5RbfHTcM0xJ2Z+InoGeeBiYd/7OfA29vMJCRwdLnHEOFQNbp6Rw==
X-Received: by 2002:a17:906:c2d8:b0:a43:2fa9:c05b with SMTP id ch24-20020a170906c2d800b00a432fa9c05bmr1842731ejb.41.1708938270828;
        Mon, 26 Feb 2024 01:04:30 -0800 (PST)
Received: from linaro.org ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id i20-20020a1709061cd400b00a3f2bf468b9sm2244445ejh.173.2024.02.26.01.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:04:30 -0800 (PST)
Date: Mon, 26 Feb 2024 11:04:28 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
	sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	shengjiu.wang@gmail.com, marex@denx.de, m.felsch@pengutronix.de,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: imx8mp: Fix SAI_MCLK_SEL definition
Message-ID: <ZdxUHAg2UZOU/s4h@linaro.org>
References: <1708683351-8504-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708683351-8504-1-git-send-email-shengjiu.wang@nxp.com>

On 24-02-23 18:15:51, Shengjiu Wang wrote:
> There is SAI1, SAI2, SAI3, SAI5, SAI6, SAI7 existing in this block
> control, the order is discontinuous. The definition of SAI_MCLK_SEL(n)
> is not match with the usage of CLK_SAIn(n).
> 
> So define SAI##n##_MCLK_SEL separately to fix the issue.
> 
> Fixes: 6cd95f7b151c ("clk: imx: imx8mp: Add audiomix block control")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/clk/imx/clk-imx8mp-audiomix.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
> index e4300df88f1a..55ed211a5e0b 100644
> --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> @@ -18,7 +18,12 @@
>  
>  #define CLKEN0			0x000
>  #define CLKEN1			0x004
> -#define SAI_MCLK_SEL(n)		(0x300 + 4 * (n))	/* n in 0..5 */
> +#define SAI1_MCLK_SEL		0x300
> +#define SAI2_MCLK_SEL		0x304
> +#define SAI3_MCLK_SEL		0x308
> +#define SAI5_MCLK_SEL		0x30C
> +#define SAI6_MCLK_SEL		0x310
> +#define SAI7_MCLK_SEL		0x314
>  #define PDM_SEL			0x318
>  #define SAI_PLL_GNRL_CTL	0x400
>  
> @@ -95,13 +100,13 @@ static const struct clk_parent_data clk_imx8mp_audiomix_pll_bypass_sels[] = {
>  		IMX8MP_CLK_AUDIOMIX_SAI##n##_MCLK1_SEL, {},		\
>  		clk_imx8mp_audiomix_sai##n##_mclk1_parents,		\
>  		ARRAY_SIZE(clk_imx8mp_audiomix_sai##n##_mclk1_parents), \
> -		SAI_MCLK_SEL(n), 1, 0					\
> +		SAI##n##_MCLK_SEL, 1, 0					\
>  	}, {								\
>  		"sai"__stringify(n)"_mclk2_sel",			\
>  		IMX8MP_CLK_AUDIOMIX_SAI##n##_MCLK2_SEL, {},		\
>  		clk_imx8mp_audiomix_sai_mclk2_parents,			\
>  		ARRAY_SIZE(clk_imx8mp_audiomix_sai_mclk2_parents),	\
> -		SAI_MCLK_SEL(n), 4, 1					\
> +		SAI##n##_MCLK_SEL, 4, 1					\
>  	}, {								\
>  		"sai"__stringify(n)"_ipg_cg",				\
>  		IMX8MP_CLK_AUDIOMIX_SAI##n##_IPG,			\
> -- 
> 2.34.1
> 

