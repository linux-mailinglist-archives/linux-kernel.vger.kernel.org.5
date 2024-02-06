Return-Path: <linux-kernel+bounces-54483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0F884AFD1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C941F24732
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D3112B156;
	Tue,  6 Feb 2024 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oAmdNyXc"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4E412B141
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 08:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207509; cv=none; b=Z+G/vJKvfIfO64PsmTSWC+MBI0Gxv03y6TOe1BEZyWHjKi1hNsPyyzoXPinfOw2Td9gyobIrnxZsHDMo1dvclxQnt8Js+UMfshCd+mN8OrD5bkXQrkSQafxGae9kv4UOuhIHoQO/1u9B8tzK67jILp2bWkWkfU/kqvD9b4ykh9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207509; c=relaxed/simple;
	bh=v0qAQzKCYiK16KuYacg7ZfnO7Llc9RpQykKW18aVyEI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iM0ebQvJEBsSKGXszcM/mmPrSXBbYje22RlYMXqV4D7R9nR9rs1CTbPpl4pkVx/9swuIcy59zmrmMCRQohOaO8n5YKz1OzAxHOQskR53HFrGQKRbNgJVimIQ2pWHDr5DIzm8gTLBOSjgqN6ie3N9GWjrduNkHEutd6nAi0PnS18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oAmdNyXc; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d09b21a8bbso6413641fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 00:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707207505; x=1707812305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0NbGjmBXOr3ajqGRcxf6QpNhQ6ZKM1Dxc1E0/xzNWzQ=;
        b=oAmdNyXcI0+6E6N6LHUZZFdNs8h4z6kY6g6ijeg9DcMpjGgIOHKVfOY/JdF4MOXPlq
         6lwXe3qSm3iH8rrjVxl5zKB58cwPk+QAkZWbNz4Q1Ke17ZVkigEYXPIQxdzWeuOWM35e
         iprayK7irsCG8617/rhmbyDG6Frjm2aFZKDiWyRnVXniYlpsenkhsxALXsRQT+Bq3l9m
         rYLs2aGpgKoelj8iaHZ4+XB4vWhWk7nRBn6OZ2DO1tr3AvBzW9gB28WFJGoAUIT1MkyL
         I3CRSB6dsBU2OpaVud+EluloBG46J69jvFVNax5/SqsxphPczU5ALtg9vPE6PH4NwdEy
         xROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707207505; x=1707812305;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0NbGjmBXOr3ajqGRcxf6QpNhQ6ZKM1Dxc1E0/xzNWzQ=;
        b=O7DSKZtz6S0Rnf0qCpgFIRBVZNMCySXRgiAdXY7viDh91Y8OACBSfo9QWon1uAMcR/
         1XDVsLwECpVVSxZQrcJ5HW6Lu9p57rHdrpAj47G6CRZCs9j44AN+LUpIH/qOQcaCc+Rd
         AB+xH2gM1jAL2TkxwL5wMFyxI6ILi+9yuDkW9DadyxVVAYFl9DXRKzN7GGacYzCjh/my
         +I0EUeXwKTCUCqVdeB1jVzefqNXhYNnqSeyOwjZnLTeIB2gVH55r8ycsaUT7+wt4Tiqy
         PBYSDelzaB0rQ1cJQNFlivHO7UjQK7LNRbY98LV3DDYyGo4BrNiJf2SIkgL9m0CVaUWO
         wgKA==
X-Gm-Message-State: AOJu0YwpMIHorZjyuzli2J9RCLg4rBVksZ3Fl5hc6hlCMl1keTAzLgib
	8jVJvmcs4Iqj27Jbd54uvprTNEdrDJvy5WKi52nc33v0CUPZMJczms4c/H/EnDc=
X-Google-Smtp-Source: AGHT+IHPNkEtW7r21UxRZAk+trReCW8z0LncEllZkLmnlhYb594dP8soanm0ywzv0rr0JUXsHe0xAA==
X-Received: by 2002:a2e:921a:0:b0:2d0:aa28:6f77 with SMTP id k26-20020a2e921a000000b002d0aa286f77mr1349200ljg.45.1707207505441;
        Tue, 06 Feb 2024 00:18:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWK5ffB5C8uuh8Ip1vs26kwAqeX2afdD/UYpQFXlGPS6AyTgawfdAqCa0JDrDoAcyg0ThorFhtOYRgrexrpRe5BtMXKtE92zRguEVl9wISnYLeb4hlllaPocGL1xN+TLeFrGN+SRPdxHROi6ddBx9TV/9rEFx3EKRg7xmQeadY3SIU6LwH+IuQIV9ZanVeKTsZXNz8oaUptoy8Uh76M5PLpTkMQ76BifLJBlp7Mf8iQdn1kLK83UiujuCw7cx/KHIdwcrz4bhiqRlLCW13BI4Cu58eIqBB5KQsJehYd9q2l1fiTjBCdQyRWRLSUvGSJQexrw2brUhJOl6rGl3HxvRMD7g==
Received: from ?IPV6:2a01:e0a:982:cbb0:ba23:8574:fa8:28dd? ([2a01:e0a:982:cbb0:ba23:8574:fa8:28dd])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d67c2000000b0033b4335dce5sm1418976wrw.85.2024.02.06.00.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 00:18:24 -0800 (PST)
Message-ID: <760f15d7-897f-48b2-b4b8-d64f70f47dd6@linaro.org>
Date: Tue, 6 Feb 2024 09:18:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] drm/panel: re-alphabetize the menu list
Content-Language: en-US, fr
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg
 <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, Aradhya Bhatia <a-bhatia1@ti.com>
References: <20240205062711.3513-1-rdunlap@infradead.org>
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
Organization: Linaro Developer Services
In-Reply-To: <20240205062711.3513-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/02/2024 07:27, Randy Dunlap wrote:
> A few of the DRM_PANEL entries have become out of alphabetical order,
> so move them around a bit to restore alpha order.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Jessica Zhang <quic_jesszhan@quicinc.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
> v2: rebase, move more driver entries around
> 
> Aradhya Bhatia <a-bhatia1@ti.com> had responded with Reviewed-by:
> for v1, but I mode quite a few additions in v2 so I didn't include
> that R-B: here.
> 
>   drivers/gpu/drm/panel/Kconfig |  202 ++++++++++++++++----------------
>   1 file changed, 101 insertions(+), 101 deletions(-)
> 
> diff -- a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -76,53 +76,6 @@ config DRM_PANEL_BOE_TV101WUM_NL6
>   	  Say Y here if you want to support for BOE TV101WUM and AUO KD101N80
>   	  45NA WUXGA PANEL DSI Video Mode panel
>   
> -config DRM_PANEL_DSI_CM
> -	tristate "Generic DSI command mode panels"
> -	depends on OF
> -	depends on DRM_MIPI_DSI
> -	depends on BACKLIGHT_CLASS_DEVICE
> -	help
> -	  DRM panel driver for DSI command mode panels with support for
> -	  embedded and external backlights.
> -
> -config DRM_PANEL_LVDS
> -	tristate "Generic LVDS panel driver"
> -	depends on OF
> -	depends on BACKLIGHT_CLASS_DEVICE
> -	select VIDEOMODE_HELPERS
> -	help
> -	  This driver supports LVDS panels that don't require device-specific
> -	  handling of power supplies or control signals. It implements automatic
> -	  backlight handling if the panel is attached to a backlight controller.
> -
> -config DRM_PANEL_SIMPLE
> -	tristate "support for simple panels (other than eDP ones)"
> -	depends on OF
> -	depends on BACKLIGHT_CLASS_DEVICE
> -	depends on PM
> -	select VIDEOMODE_HELPERS
> -	help
> -	  DRM panel driver for dumb non-eDP panels that need at most a regulator
> -	  and a GPIO to be powered up. Optionally a backlight can be attached so
> -	  that it can be automatically turned off when the panel goes into a
> -	  low power state.
> -
> -config DRM_PANEL_EDP
> -	tristate "support for simple Embedded DisplayPort panels"
> -	depends on OF
> -	depends on BACKLIGHT_CLASS_DEVICE
> -	depends on PM
> -	select VIDEOMODE_HELPERS
> -	select DRM_DISPLAY_DP_HELPER
> -	select DRM_DISPLAY_HELPER
> -	select DRM_DP_AUX_BUS
> -	select DRM_KMS_HELPER
> -	help
> -	  DRM panel driver for dumb eDP panels that need at most a regulator and
> -	  a GPIO to be powered up. Optionally a backlight can be attached so
> -	  that it can be automatically turned off when the panel goes into a
> -	  low power state.
> -
>   config DRM_PANEL_EBBG_FT8719
>   	tristate "EBBG FT8719 panel driver"
>   	depends on OF
> @@ -162,6 +115,25 @@ config DRM_PANEL_FEIYANG_FY07024DI26A30D
>   	  Say Y if you want to enable support for panels based on the
>   	  Feiyang FY07024DI26A30-D MIPI-DSI interface.
>   
> +config DRM_PANEL_DSI_CM
> +	tristate "Generic DSI command mode panels"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  DRM panel driver for DSI command mode panels with support for
> +	  embedded and external backlights.
> +
> +config DRM_PANEL_LVDS
> +	tristate "Generic LVDS panel driver"
> +	depends on OF
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	select VIDEOMODE_HELPERS
> +	help
> +	  This driver supports LVDS panels that don't require device-specific
> +	  handling of power supplies or control signals. It implements automatic
> +	  backlight handling if the panel is attached to a backlight controller.
> +
>   config DRM_PANEL_HIMAX_HX8394
>   	tristate "HIMAX HX8394 MIPI-DSI LCD panels"
>   	depends on OF
> @@ -251,17 +223,6 @@ config DRM_PANEL_JADARD_JD9365DA_H3
>   	  WXGA MIPI DSI panel. The panel support TFT dot matrix LCD with
>   	  800RGBx1280 dots at maximum.
>   
> -config DRM_PANEL_JDI_LT070ME05000
> -	tristate "JDI LT070ME05000 WUXGA DSI panel"
> -	depends on OF
> -	depends on DRM_MIPI_DSI
> -	depends on BACKLIGHT_CLASS_DEVICE
> -	help
> -	  Say Y here if you want to enable support for JDI DSI video mode
> -	  panel as found in Google Nexus 7 (2013) devices.
> -	  The panel has a 1200(RGB)×1920 (WUXGA) resolution and uses
> -	  24 bit per pixel.
> -
>   config DRM_PANEL_JDI_LPM102A188A
>   	tristate "JDI LPM102A188A DSI panel"
>   	depends on OF && GPIOLIB
> @@ -273,6 +234,17 @@ config DRM_PANEL_JDI_LPM102A188A
>   	  The panel has a 2560×1800 resolution. It provides a MIPI DSI interface
>   	  to the host.
>   
> +config DRM_PANEL_JDI_LT070ME05000
> +	tristate "JDI LT070ME05000 WUXGA DSI panel"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Say Y here if you want to enable support for JDI DSI video mode
> +	  panel as found in Google Nexus 7 (2013) devices.
> +	  The panel has a 1200(RGB)×1920 (WUXGA) resolution and uses
> +	  24 bit per pixel.
> +
>   config DRM_PANEL_JDI_R63452
>   	tristate "JDI R63452 Full HD DSI panel"
>   	depends on OF
> @@ -326,12 +298,6 @@ config DRM_PANEL_LEADTEK_LTK500HD1829
>   	  24 bit RGB per pixel. It provides a MIPI DSI interface to
>   	  the host and has a built-in LED backlight.
>   
> -config DRM_PANEL_SAMSUNG_LD9040
> -	tristate "Samsung LD9040 RGB/SPI panel"
> -	depends on OF && SPI
> -	depends on BACKLIGHT_CLASS_DEVICE
> -	select VIDEOMODE_HELPERS
> -
>   config DRM_PANEL_LG_LB035Q02
>   	tristate "LG LB035Q024573 RGB panel"
>   	depends on GPIOLIB && OF && SPI
> @@ -359,6 +325,17 @@ config DRM_PANEL_MAGNACHIP_D53E6EA8966
>   	  with the Magnachip D53E6EA8966 panel IC. This panel receives
>   	  video data via DSI but commands via 9-bit SPI using DBI.
>   
> +config DRM_PANEL_MANTIX_MLAF057WE51
> +	tristate "Mantix MLAF057WE51-X MIPI-DSI LCD panel"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Say Y here if you want to enable support for the Mantix
> +	  MLAF057WE51-X MIPI DSI panel as e.g. used in the Librem 5. It
> +	  has a resolution of 720x1440 pixels, a built in backlight and touch
> +	  controller.
> +
>   config DRM_PANEL_NEC_NL8048HL11
>   	tristate "NEC NL8048HL11 RGB panel"
>   	depends on GPIOLIB && OF && SPI
> @@ -447,17 +424,6 @@ config DRM_PANEL_NOVATEK_NT39016
>   	  Say Y here if you want to enable support for the panels built
>   	  around the Novatek NT39016 display controller.
>   
> -config DRM_PANEL_MANTIX_MLAF057WE51
> -	tristate "Mantix MLAF057WE51-X MIPI-DSI LCD panel"
> -	depends on OF
> -	depends on DRM_MIPI_DSI
> -	depends on BACKLIGHT_CLASS_DEVICE
> -	help
> -	  Say Y here if you want to enable support for the Mantix
> -	  MLAF057WE51-X MIPI DSI panel as e.g. used in the Librem 5. It
> -	  has a resolution of 720x1440 pixels, a built in backlight and touch
> -	  controller.
> -
>   config DRM_PANEL_OLIMEX_LCD_OLINUXINO
>   	tristate "Olimex LCD-OLinuXino panel"
>   	depends on OF
> @@ -554,6 +520,12 @@ config DRM_PANEL_RONBO_RB070D30
>   	  Say Y here if you want to enable support for Ronbo Electronics
>   	  RB070D30 1024x600 DSI panel.
>   
> +config DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01
> +	tristate "Samsung AMS452EF01 panel with S6E88A0 DSI video mode controller"
> +	depends on OF
> +	select DRM_MIPI_DSI
> +	select VIDEOMODE_HELPERS
> +
>   config DRM_PANEL_SAMSUNG_ATNA33XC20
>   	tristate "Samsung ATNA33XC20 eDP panel"
>   	depends on OF
> @@ -577,6 +549,12 @@ config DRM_PANEL_SAMSUNG_DB7430
>   	  DB7430 DPI display controller used in such devices as the
>   	  LMS397KF04 480x800 DPI panel.
>   
> +config DRM_PANEL_SAMSUNG_LD9040
> +	tristate "Samsung LD9040 RGB/SPI panel"
> +	depends on OF && SPI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	select VIDEOMODE_HELPERS
> +
>   config DRM_PANEL_SAMSUNG_S6D16D0
>   	tristate "Samsung S6D16D0 DSI video mode panel"
>   	depends on OF
> @@ -642,12 +620,6 @@ config DRM_PANEL_SAMSUNG_S6E63M0_DSI
>   	  Say Y here if you want to be able to access the Samsung
>   	  S6E63M0 panel using DSI.
>   
> -config DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01
> -	tristate "Samsung AMS452EF01 panel with S6E88A0 DSI video mode controller"
> -	depends on OF
> -	select DRM_MIPI_DSI
> -	select VIDEOMODE_HELPERS
> -
>   config DRM_PANEL_SAMSUNG_S6E8AA0
>   	tristate "Samsung S6E8AA0 DSI video mode panel"
>   	depends on OF
> @@ -746,15 +718,6 @@ config DRM_PANEL_SITRONIX_ST7789V
>   	  Say Y here if you want to enable support for the Sitronix
>   	  ST7789V controller for 240x320 LCD panels
>   
> -config DRM_PANEL_SYNAPTICS_R63353
> -	tristate "Synaptics R63353-based panels"
> -	depends on OF
> -	depends on DRM_MIPI_DSI
> -	depends on BACKLIGHT_CLASS_DEVICE
> -	help
> -	  Say Y if you want to enable support for panels based on the
> -	  Synaptics R63353 controller.
> -
>   config DRM_PANEL_SONY_ACX565AKM
>   	tristate "Sony ACX565AKM panel"
>   	depends on GPIOLIB && OF && SPI
> @@ -794,6 +757,43 @@ config DRM_PANEL_STARTEK_KD070FHFID015
>   	  with a resolution of 1024 x 600 pixels. It provides a MIPI DSI interface to
>   	  the host, a built-in LED backlight and touch controller.
>   
> +config DRM_PANEL_EDP
> +	tristate "support for simple Embedded DisplayPort panels"
> +	depends on OF
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	depends on PM
> +	select VIDEOMODE_HELPERS
> +	select DRM_DISPLAY_DP_HELPER
> +	select DRM_DISPLAY_HELPER
> +	select DRM_DP_AUX_BUS
> +	select DRM_KMS_HELPER
> +	help
> +	  DRM panel driver for dumb eDP panels that need at most a regulator and
> +	  a GPIO to be powered up. Optionally a backlight can be attached so
> +	  that it can be automatically turned off when the panel goes into a
> +	  low power state.
> +
> +config DRM_PANEL_SIMPLE
> +	tristate "support for simple panels (other than eDP ones)"
> +	depends on OF
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	depends on PM
> +	select VIDEOMODE_HELPERS
> +	help
> +	  DRM panel driver for dumb non-eDP panels that need at most a regulator
> +	  and a GPIO to be powered up. Optionally a backlight can be attached so
> +	  that it can be automatically turned off when the panel goes into a
> +	  low power state.
> +
> +config DRM_PANEL_SYNAPTICS_R63353
> +	tristate "Synaptics R63353-based panels"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Say Y if you want to enable support for panels based on the
> +	  Synaptics R63353 controller.
> +
>   config DRM_PANEL_TDO_TL070WSH30
>   	tristate "TDO TL070WSH30 DSI panel"
>   	depends on OF
> @@ -837,6 +837,17 @@ config DRM_PANEL_TRULY_NT35597_WQXGA
>   	  Say Y here if you want to enable support for Truly NT35597 WQXGA Dual DSI
>   	  Video Mode panel
>   
> +config DRM_PANEL_VISIONOX_R66451
> +	tristate "Visionox R66451"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_DISPLAY_DP_HELPER
> +	select DRM_DISPLAY_HELPER
> +	help
> +	  Say Y here if you want to enable support for Visionox
> +	  R66451 1080x2340 AMOLED DSI panel.
> +
>   config DRM_PANEL_VISIONOX_RM69299
>   	tristate "Visionox RM69299"
>   	depends on OF
> @@ -854,17 +865,6 @@ config DRM_PANEL_VISIONOX_VTDR6130
>   	  Say Y here if you want to enable support for Visionox
>   	  VTDR6130 1080x2400 AMOLED DSI panel.
>   
> -config DRM_PANEL_VISIONOX_R66451
> -	tristate "Visionox R66451"
> -	depends on OF
> -	depends on DRM_MIPI_DSI
> -	depends on BACKLIGHT_CLASS_DEVICE
> -	select DRM_DISPLAY_DP_HELPER
> -	select DRM_DISPLAY_HELPER
> -	help
> -	  Say Y here if you want to enable support for Visionox
> -	  R66451 1080x2340 AMOLED DSI panel.
> -
>   config DRM_PANEL_WIDECHIPS_WS2401
>   	tristate "Widechips WS2401 DPI panel driver"
>   	depends on SPI && GPIOLIB

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

