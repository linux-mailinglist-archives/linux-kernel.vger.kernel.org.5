Return-Path: <linux-kernel+bounces-158857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B61508B25DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2F21F2227B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B0014D2B1;
	Thu, 25 Apr 2024 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fnC32YMn"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C3D14D2A0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714060846; cv=none; b=cEyvOIeZYQWH3JyjqkqC+HfSYy2td8rFiIGJhvhv1WFvGzlVmk7/y2oD+NF2iOXoW7jd5oKjIlamsawEwonDf2Ir3SDYgV+o509S7jYa28fmu1Qo0chtRCVJVrZjl/w7OI0FIWA48SFfIQmRF6GPoD47AquSfdfhbRxG1dVICKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714060846; c=relaxed/simple;
	bh=fzI4MCRm+4/oXv+wNRCbGfB0i4ApNccDio/5m7s9FkQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P6sN5VQlJfhUeR+iWyQWE3kAXcxPj86lbmRR1JSw1K800qTxMN4p3VMMR7KeIio5/RUgOPus6BsuIjOZT8NNGizXrbTkOk2wsBppTZCxEap8EXexStOGumXA6ZNnApp4Px4M7orHRr0p7xeyj0hIIdTsY1fJXIhjeuzTNLLV42Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fnC32YMn; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34b029296f5so1189886f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714060843; x=1714665643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wGYFYnULTAAU0aFrjX7VVM7UZ6GIxaemoe8H8xCPZbQ=;
        b=fnC32YMnGZpSJNc8U1BzW09fmFOmvVGLwmmrtQeEDX3K7uvfKc6rrSzK3bCM4jtxLS
         N0arvcHnjFtP/dH75MIJiyL8C9yALwvvN2sWfKrc1RQEmBdtJh49/TOhCdFylz6n5Jjw
         17IVUcOwW32gcPq2mIkFyVcqNK4nZR5oBf84YNLzcMdnSW2cOGyt9TK1Yi5U7f4Ra6CU
         LVhYcBdD99TrbZuUNft4pA/BB0szxevh3e+AKAFyseb2akyjzH4FSqFQarL+C4JLFi18
         Q9+FBSFcg9+9og6oXuA4cPd/SMU369SO+VBNztDQJhZzDGCn3doxi5621mbQeXEGxPhM
         APEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714060843; x=1714665643;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wGYFYnULTAAU0aFrjX7VVM7UZ6GIxaemoe8H8xCPZbQ=;
        b=Hx2LDhgS5zUJXToKIOIqVdJzFRciognf+s+ezFn79jFsL974miuBs6fNg7SU3Qkvpg
         8iQRxW3rJTJjjWUJS56ZZlzU0ZJI+12ex7ol4C9HdyLKzWyqYMDImUf2+H5w0a5jsFy1
         S34nxoolF04rClVh2gL4X7tb/Gsxs2YJonvYo97oo7XBrB9syP+YF6TW07tc/vOkv/xO
         QkqbOC8n8sgGoQofHfEWwEeJQt58rn0i7fX6iHuHQ6pj+MpBH4DIgqevr4m7epyvoQvN
         5gqG868QnVDWLs0MhIm4lCBf3XSID4g1JgUQzcKAU37bLX6vbwGQlrozMUEDhiVZCTJ+
         RsCw==
X-Forwarded-Encrypted: i=1; AJvYcCXbbHp7ou/SKbT+MdZN7mUvvLwnp6YxIaDhGDU6Zq3brk/HDFXzt2CiwqkKZxp1YxSHLgidrws3q5qdRoqV6FDRJoEaZojoXRqUG/cy
X-Gm-Message-State: AOJu0YwhIdX7w42JODXgP9U80hO19B53q/KsCOfRs2MRlRneFtzZ46B2
	O5FjyqDBaPxVpq2CkYZ20yCqLJtaR8BH45AcvWFFDHFnxYpb25VW2zWsHTmOi+YDIc4GnlQNM8y
	QruI=
X-Google-Smtp-Source: AGHT+IHDrrx5zIevOrXHuv98ZaOQmOYkhPHMInLfyTpExcxkK+PVCMoBfbV/yH/h1aVwEACnI2JMDg==
X-Received: by 2002:a5d:4746:0:b0:349:f83f:9ebf with SMTP id o6-20020a5d4746000000b00349f83f9ebfmr5834974wrs.5.1714060842837;
        Thu, 25 Apr 2024 09:00:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:15c7:bd9c:c500:ed62? ([2a01:e0a:982:cbb0:15c7:bd9c:c500:ed62])
        by smtp.gmail.com with ESMTPSA id q12-20020adfcd8c000000b00343cad2a4d3sm20072228wrj.18.2024.04.25.09.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 09:00:42 -0700 (PDT)
Message-ID: <c47e814a-f609-450a-aa20-9342034475e2@linaro.org>
Date: Thu, 25 Apr 2024 18:00:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/3] drm/panel: ili9341: Correct use of device property
 APIs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg
 <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20240425142706.2440113-1-andriy.shevchenko@linux.intel.com>
 <20240425142706.2440113-2-andriy.shevchenko@linux.intel.com>
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
In-Reply-To: <20240425142706.2440113-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/04/2024 16:26, Andy Shevchenko wrote:
> It seems driver missed the point of proper use of device property APIs.
> Correct this by updating headers and calls respectively.
> 
> Fixes: 5a04227326b0 ("drm/panel: Add ilitek ili9341 panel driver")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/gpu/drm/panel/Kconfig                | 2 +-
>   drivers/gpu/drm/panel/panel-ilitek-ili9341.c | 5 +++--
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index e54f6f5604ed..2d4515555820 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -177,7 +177,7 @@ config DRM_PANEL_ILITEK_IL9322
>   
>   config DRM_PANEL_ILITEK_ILI9341
>   	tristate "Ilitek ILI9341 240x320 QVGA panels"
> -	depends on OF && SPI
> +	depends on SPI
>   	select DRM_KMS_HELPER
>   	select DRM_GEM_DMA_HELPER
>   	depends on BACKLIGHT_CLASS_DEVICE
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> index 3574681891e8..7584ddb0e441 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> @@ -22,8 +22,9 @@
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
>   #include <linux/gpio/consumer.h>
> +#include <linux/mod_devicetable.h>
>   #include <linux/module.h>
> -#include <linux/of.h>
> +#include <linux/property.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/spi/spi.h>
>   
> @@ -691,7 +692,7 @@ static int ili9341_dpi_probe(struct spi_device *spi, struct gpio_desc *dc,
>   	 * Every new incarnation of this display must have a unique
>   	 * data entry for the system in this driver.
>   	 */
> -	ili->conf = of_device_get_match_data(dev);
> +	ili->conf = device_get_match_data(dev);
>   	if (!ili->conf) {
>   		dev_err(dev, "missing device configuration\n");
>   		return -ENODEV;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

