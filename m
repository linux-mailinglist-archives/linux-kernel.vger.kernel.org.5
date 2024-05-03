Return-Path: <linux-kernel+bounces-167404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 843CD8BA915
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117301F219FD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C68E14F9F2;
	Fri,  3 May 2024 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBTX9sZz"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DAD14A4C4
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725764; cv=none; b=V8oJ3iyWiYVH3c9ScbmKhabEEXOMT4m6RQyvu1Cjc5XMw5Y2fkPeAen0wCnkM8plp8dOoctkl+jilrMu7kFnNYi/IKg4uNyxTwpdjJnKU67cvZHWu7eyLgcO/TMd4PguvlvbSXKGGEUnyIJK0ioa+7r4l1SRVg6Y0Oqtx5eNvxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725764; c=relaxed/simple;
	bh=JNcUw8MOjSlYXlUooTzde8EjE/c+ogbldSVJi4xWwZg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=X5c9fKi9kFjlwO3uiihrxA0y4x3kKt48zQwWGRcHeZZnPla9hwj7i8/6TV2TPtElGjujNSVg9fmJOnjGU6fGgbPJBHDtg5uDqRBhB2cL2Uldl983ASsBeBuqo3Q0tpsu5RQNadxmNf1Xxbgsrtha267s2rc590TQtHkj7O7lwdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MBTX9sZz; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51f2ebbd8a7so1834065e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 01:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714725760; x=1715330560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mYoRu527Djh8ZG1yR7a+brPHoHQwejy0Kxn14NxRy3M=;
        b=MBTX9sZzp0epYgU2W3oraFzgo4veYvAOlMGgQd+SfQRXb8zHT2+IxH+7a7+xwzc/2v
         8PAlW150ZaSjsGZXHKPF0LvvMpTuvKZWuLGMAJw3gqHX5g0duau9RiiUvowUjA7ncVNM
         y6n+erWImB+AEafDdkdXZaCqpaBngS0rZad+ZI9azThVxAwpWSyuLs+t3ceaHvNKjeRt
         fQEgsr/c3onVPm3OVZV2+AxBP3eNlDWlte99es27zrZORm5/kt1Gp8e0LQCx8pDr+bCj
         /mWGKr5YeFLc1rLjMuaZ3b0CUdg3U0XItXdjKTpvEzMqg9FSKHocyZV9E4Jb0kOk3uW2
         SV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714725760; x=1715330560;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mYoRu527Djh8ZG1yR7a+brPHoHQwejy0Kxn14NxRy3M=;
        b=DiXySJXlQ9aRXttoVqbCPwZMKcSrzavkgbkVJbBMLJnSaSCpGHlIw7wMgvu7FE7XYY
         7uokAFkNRZQoQA4RlnWMmWvMZpsh0xo1wl6xal8nMsMNrSVByrbsB86eeEVXKWr5zHlk
         0yTyU8aNrVq6ywH1QFL8QryuuEp8yFcWdaZ/rT5MkVAMI7gARPow85odUSoDqKirdksI
         5W5KzZYfK+Z8fwYkYJ2Ih6+Ac+5/Lyg9X8iwjBVHRnLvGz1U3aqUcLEV1F8oKwO7cKGa
         3X8zx8JPRURTph4CYcM0xDfa4xbyJH/SAenktAoAriz30PLnuwEe9zlp7hY0Wq+eYZXw
         E7IA==
X-Forwarded-Encrypted: i=1; AJvYcCVIt6eXhWtd7TMxodZr+PJo1bIkgYfDGUmXp95O4LhbPh8KDzQcJVVNEX4W+BccuLVtWcR0SuYqiGt39nQUqZu1iNdIQfEJT8BcUULB
X-Gm-Message-State: AOJu0YzVASk9osdRQtL52Z1pa7NAN5HRihkgapGaFAMg+4esmGVIIvgX
	TUGPaKqCUEO6cuutiyxR3RN612BHAPQ3lf2o0Nc/DBKh2NLqaNVXyxASPcuWB9g=
X-Google-Smtp-Source: AGHT+IFjj2VXVI4GYTa+9MVFooqDbutk3qTYh1g2xyD+WgAXrK00lZRLsFkT67EwWybHsADpYViXGg==
X-Received: by 2002:ac2:5e29:0:b0:51e:15d1:b2d6 with SMTP id o9-20020ac25e29000000b0051e15d1b2d6mr1100584lfg.50.1714725760440;
        Fri, 03 May 2024 01:42:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:e481:a79a:a1d8:3ad2? ([2a01:e0a:cad:2140:e481:a79a:a1d8:3ad2])
        by smtp.gmail.com with ESMTPSA id s3-20020adfe003000000b0034e8a10039esm177867wrh.10.2024.05.03.01.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 01:42:40 -0700 (PDT)
Message-ID: <bc8523bb-8d51-46c6-a011-7c46bb62acfa@linaro.org>
Date: Fri, 3 May 2024 10:42:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] drm/meson: dw-hdmi: power up phy on device init
To: Jerome Brunet <jbrunet@baylibre.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240426160256.3089978-1-jbrunet@baylibre.com>
 <20240426160256.3089978-2-jbrunet@baylibre.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20240426160256.3089978-2-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/04/2024 18:02, Jerome Brunet wrote:
> The phy is not in a useful state right after init. It will become useful,
> including for auxiliary function such as CEC or ARC, after the first mode
> is set. This is a problem on systems where the display is using another
> interface like DSI or CVBS.
> 
> This change refactor the init and mode change callback to power up the PHY
> on init and leave only what is necessary for mode changes in the related
> function. This is enough to fix CEC operation when HDMI display is not
> enabled.
> 
> Fixes: 3f68be7d8e96 ("drm/meson: Add support for HDMI encoder and DW-HDMI bridge + PHY")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   drivers/gpu/drm/meson/meson_dw_hdmi.c | 51 +++++++++------------------
>   1 file changed, 17 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index 5a9538bc0e26..a83d93078537 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -384,26 +384,6 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
>   	    dw_hdmi_bus_fmt_is_420(hdmi))
>   		mode_is_420 = true;
>   
> -	/* Enable clocks */
> -	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL, 0xffff, 0x100);
> -
> -	/* Bring HDMITX MEM output of power down */
> -	regmap_update_bits(priv->hhi, HHI_MEM_PD_REG0, 0xff << 8, 0);
> -
> -	/* Bring out of reset */
> -	dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_SW_RESET,  0);
> -
> -	/* Enable internal pixclk, tmds_clk, spdif_clk, i2s_clk, cecclk */
> -	dw_hdmi_top_write_bits(dw_hdmi, HDMITX_TOP_CLK_CNTL,
> -			       0x3, 0x3);
> -
> -	/* Enable cec_clk and hdcp22_tmdsclk_en */
> -	dw_hdmi_top_write_bits(dw_hdmi, HDMITX_TOP_CLK_CNTL,
> -			       0x3 << 4, 0x3 << 4);
> -
> -	/* Enable normal output to PHY */
> -	dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_BIST_CNTL, BIT(12));
> -
>   	/* TMDS pattern setup */
>   	if (mode->clock > 340000 && !mode_is_420) {
>   		dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_01,
> @@ -425,20 +405,6 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
>   	/* Setup PHY parameters */
>   	meson_hdmi_phy_setup_mode(dw_hdmi, mode, mode_is_420);
>   
> -	/* Setup PHY */
> -	regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1,
> -			   0xffff << 16, 0x0390 << 16);
> -
> -	/* BIT_INVERT */
> -	if (dw_hdmi_is_compatible(dw_hdmi, "amlogic,meson-gxl-dw-hdmi") ||
> -	    dw_hdmi_is_compatible(dw_hdmi, "amlogic,meson-gxm-dw-hdmi") ||
> -	    dw_hdmi_is_compatible(dw_hdmi, "amlogic,meson-g12a-dw-hdmi"))
> -		regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1,
> -				   BIT(17), 0);
> -	else
> -		regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1,
> -				   BIT(17), BIT(17));
> -
>   	/* Disable clock, fifo, fifo_wr */
>   	regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1, 0xf, 0);
>   
> @@ -656,6 +622,23 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
>   	meson_dw_hdmi->data->top_write(meson_dw_hdmi,
>   				       HDMITX_TOP_CLK_CNTL, 0xff);
>   
> +	/* Enable normal output to PHY */
> +	meson_dw_hdmi->data->top_write(meson_dw_hdmi, HDMITX_TOP_BIST_CNTL, BIT(12));
> +
> +	/* Setup PHY */
> +	regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1,
> +			   0xffff << 16, 0x0390 << 16);
> +
> +	/* BIT_INVERT */
> +	if (dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-gxl-dw-hdmi") ||
> +	    dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-gxm-dw-hdmi") ||
> +	    dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-g12a-dw-hdmi"))
> +		regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1,
> +				   BIT(17), 0);
> +	else
> +		regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1,
> +				   BIT(17), BIT(17));
> +
>   	/* Enable HDMI-TX Interrupt */
>   	meson_dw_hdmi->data->top_write(meson_dw_hdmi, HDMITX_TOP_INTR_STAT_CLR,
>   				       HDMITX_TOP_INTR_CORE);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

