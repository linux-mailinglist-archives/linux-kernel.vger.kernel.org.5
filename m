Return-Path: <linux-kernel+bounces-80750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9E5866C07
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A4A1C213A3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E2F1CA97;
	Mon, 26 Feb 2024 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vv43oWry"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B21BF3F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935747; cv=none; b=KDtk7e89/2NsdcQmT2+wJGJo2a4Q5AolzmgGA8b8xifJqRQbE8+6LWNSjYtwNhqB86Jnlgn3ocXlZyYZeWRNXY4lsXuXMS4GqK3WNxJPFgHNn9tZ0cK/StgAt7m3iWLIGv9sOj0WOawm+QEVmPgZ7lsaZ7CzTp9vtqmOrsl43DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935747; c=relaxed/simple;
	bh=BvBWMKwRTrQ7dFC+IvxV5WxyS6soTP9Il+To1EGI5FU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Uy8NnS8j5b84B3FLXRjKaV0Hi0lbThr196MbpZHiymRxPPiqqgxPMoW8j2tHCR3F8sdQu5OxJCbAuvhq/nWiRtSEWQ2nsjleUOZd9FVp3jeA0IQrBG15rq2O4V6zvhyzyXuQ3nOgS419mUlZE9++/48l3pazskhrcgQqXmEi0mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vv43oWry; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412a51754c9so3128595e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 00:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708935744; x=1709540544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0IEzXQ/hHU3BKY4OyByeyO401CW6mzN8A+jxoD/xKg8=;
        b=Vv43oWryZJ1IYUZKttDhuy9Y6D6N2CYB2AEUtG4Nu85K5UZlr405B87HPbA5fOgFxn
         sh3rvYDkUu+8GrYYKMsohHa3AwC8+eL09s8gaZYq5bqouhyCRUVed0/lseMUMcXSv47t
         Gj13f9I3sIecZCbJ1gUH+a08YNeWVyN2ewJ376OuhH6dyaaYJYsAG1z1/otBk1cJ+N+D
         UPVCWQJvWy13XEsoYYeR2ZiEqhnd7eE/eUFBDSEw2UY3TCNwXWKM4+gj7RhlE63IKp7X
         6HgqWjngiBnSKkKEIx0vUZroSgZLGURt8BWVXzgKykPRrG3+zbrnX2uhzwmQpDIAj2wg
         7BMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708935744; x=1709540544;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0IEzXQ/hHU3BKY4OyByeyO401CW6mzN8A+jxoD/xKg8=;
        b=jepmmnVvbM4RxYLCNsmT6AUx+wg4Wmsy1lpfuaPO+Oe6XI2qOlisnDS+YQTdEy6T4I
         YWnbKxVBxIHOqRtlsnVkhzIkBUL5eatNe0fcdmCaH8MkRZsNP3OiEflCJUfMQe/DRTlt
         xMDDZZoGraCUa7Uq8r4Rr0N8Pf3ZnEwSQ/0ct0XiEFrJe4MQIfR5RamjF+sMrw1SPpBK
         kTEUtFhAJOBYTos0OSdxneWdLMvxIaET2Spf75EdP2zE1dWPuanIFmx0+V/nI2yJvWUv
         KIulWpCAgh+WH4/s3pakXHBnGTZGt5CkdogkkB3uF6wT8Jyu++ZWCJVFq5G90dh+uGjL
         sz+A==
X-Forwarded-Encrypted: i=1; AJvYcCViuC0l4XzHYH30csNCM3+ikcsif+J48PusVYOjrGNm3ndkwsyJeIBX62EMolGinN1bO2/MgRBGRw6VJnNjz7htSR63BqKY3iamZ988
X-Gm-Message-State: AOJu0YxMaGVdfEkcjpY8wpDH2+WlOUv8UyhFsojckxNhTSKy9/76dMZZ
	e6Fy+uyGn/fvzpZ1DtyOpBwya5QhxmQOhQclLxtDuEQ8g9pUEto+ijXELfXJPpc=
X-Google-Smtp-Source: AGHT+IFRVFnL6GzUdLkAbp9WJAobrTEiAFwBC8dfGODSRUOoc8vdBhwELS9PJcHVhrwAZOFHzcytUA==
X-Received: by 2002:a05:600c:5195:b0:412:a81a:cf9f with SMTP id fa21-20020a05600c519500b00412a81acf9fmr294589wmb.30.1708935744059;
        Mon, 26 Feb 2024 00:22:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:6109:4c61:11d9:ed64? ([2a01:e0a:982:cbb0:6109:4c61:11d9:ed64])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c249300b00411e1574f7fsm10999475wms.44.2024.02.26.00.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 00:22:23 -0800 (PST)
Message-ID: <9f312920-92d1-4b83-9fd4-d9c70bcbde97@linaro.org>
Date: Mon, 26 Feb 2024 09:22:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/3] drm/panel: simple: add CMT430B19N00 LCD panel support
Content-Language: en-US, fr
To: =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?=
 <jeremie.dautheribes@bootlin.com>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Yen-Mei Goh <yen-mei.goh@keysight.com>
References: <20240223134517.728568-1-jeremie.dautheribes@bootlin.com>
 <20240223134517.728568-4-jeremie.dautheribes@bootlin.com>
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
In-Reply-To: <20240223134517.728568-4-jeremie.dautheribes@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/02/2024 14:45, Jérémie Dautheribes wrote:
> Add support for Crystal Clear Technology CMT430B19N00 4.3" 480x272
> TFT-LCD panel.
> 
> Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 20e3df1c59d4..b940220f56e2 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1457,6 +1457,32 @@ static const struct panel_desc boe_hv070wsa = {
>   	.connector_type = DRM_MODE_CONNECTOR_LVDS,
>   };
>   
> +static const struct drm_display_mode cct_cmt430b19n00_mode = {
> +	.clock = 9000,
> +	.hdisplay = 480,
> +	.hsync_start = 480 + 43,
> +	.hsync_end = 480 + 43 + 8,
> +	.htotal = 480 + 43 + 8 + 4,
> +	.vdisplay = 272,
> +	.vsync_start = 272 + 12,
> +	.vsync_end = 272 + 12 + 8,
> +	.vtotal = 272 + 12 + 8 + 4,
> +	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> +};
> +
> +static const struct panel_desc cct_cmt430b19n00 = {
> +	.modes = &cct_cmt430b19n00_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 95,
> +		.height = 53,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
> +	.connector_type = DRM_MODE_CONNECTOR_DPI,
> +};
> +
>   static const struct drm_display_mode cdtech_s043wq26h_ct7_mode = {
>   	.clock = 9000,
>   	.hdisplay = 480,
> @@ -4402,6 +4428,9 @@ static const struct of_device_id platform_of_match[] = {
>   	}, {
>   		.compatible = "boe,hv070wsa-100",
>   		.data = &boe_hv070wsa
> +	}, {
> +		.compatible = "cct,cmt430b19n00",
> +		.data = &cct_cmt430b19n00,
>   	}, {
>   		.compatible = "cdtech,s043wq26h-ct7",
>   		.data = &cdtech_s043wq26h_ct7,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

