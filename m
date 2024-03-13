Return-Path: <linux-kernel+bounces-102267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 109A987B000
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B256028C05F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FE285289;
	Wed, 13 Mar 2024 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NpHmzg+a"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2486C634FF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351056; cv=none; b=knDjv18ZjsF5O6lpzsXjGrXxRhFYkggPyIhZ6cvAw/vzlStOFB+DTMESvcTbF6GhKMCTO5AzCkpuS+o8As9JOwJWzfSAynV0AnwwWt89VHKGtDMDEuA3GhjhztTGbPsGNrtCHuoBJ5/QlBiqwnFSo5z7KmlkllWK6sHgwxxcWX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351056; c=relaxed/simple;
	bh=nWQimufB7QxLE0zvx0a0J1BIOGZtKvCDLCS4/1vS8PQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=h6M4bwIJBA4QxnMDSIzZsh0a6FsOHYRnLySJb1jQcX10tCqZ5WiZWRwHrinS8rFLxwzFkJvJyUgJ39zOJYFUvEtNl95mD/fTTLUeXBNI1Au89AAXwYOTfolaf9sr9Y7V2L24E3T4ElZykrM1E+B6PVnfkWkjn8y9+U/ZcnQvw/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NpHmzg+a; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e92b3b5c9so18579f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710351053; x=1710955853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AoJBLvGLSO1Au71tnmkkcC/uvFLxr7hz04I6Ua/2Z9M=;
        b=NpHmzg+auK50FAWD6o3qFz60e1vehQ6LhRQwsXYS4lEJo1DIOlyU1xN02cWBwIbbsJ
         s8nRSgsBktMTSWZn6ZlbmTQ2PO6p/EEc9iff3zY0N5CtJPXfSuZ0l9FlDBiOYPjdsNwO
         /0kUNYgVqV6U4XK5INRkox0IIu+Ak7Vy9nrRBu9KOkSSJrqLPwHfnkL7N84/rw/+Y7TA
         D5HFDVslUm+Ve9QNFNilzvs0irwnaOChmqnXzjQiOiZ4ddhlD+48DaAfDFR6Q96sa1UO
         zkaVDtzQyThOJZhVo2HDdat9/a6v9moUpYM1g6Tbgn1NWofwNGWkcv1brirkgN+cbWvV
         AJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710351053; x=1710955853;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AoJBLvGLSO1Au71tnmkkcC/uvFLxr7hz04I6Ua/2Z9M=;
        b=GIf5DK2ox7nBrXG23gblA1JH+FOVY1qsI1VEnrfxt7DunKU9yVoPNs3x9EvO9oxpR+
         I1QB3UbtNPjPMas5ghqnMXI0ai7lWZh19p8cO1oUSp4rX34jAcXZ+Yg8/L2Yk1472K5s
         JTMFxzYck4oC9TmEsAVOSdbxKUeLnCL8W25+OixgY7S0QNtI7dju5eOmxlSrRMMLbi2P
         2GRI751bYtzE4yKzILKr5ZHK1tbqdTxcZl5SogMHWGv+lAKAYjbh/1M27iVaB3Tb1xhh
         1vIxgkqA3zuEgC2TsEGdV8EXzr4zbszC9pqU3v8eOo5otObhylQt5Y9KRv9jQ9+cJ6Yq
         ImOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDRazC4yraVoq+LiYcLdfDg30GZon3IDcineeBM7uFC4XQqn4qVRaM0sunohvdW4Eb72JJ/quOkPmw+0I8JX5grwCDv4jeYAOMnnOX
X-Gm-Message-State: AOJu0Yx06V1jvW5BouEwnCpBGXchp5OcL6nde0pnHIXKhUm0mRCMb2B3
	MeQnPdFykvRBn9w6uNwBx5dW/zjUPstQ3mb5bURlMueelhwHzviKoTJwlLIvQJA=
X-Google-Smtp-Source: AGHT+IFpt3nKpb6yZp4WeSJe1NcrqDMP7HGMmEVeZpWD8HEqgofCrKHYpfbd5ftktIToiD8wlHn5zA==
X-Received: by 2002:adf:e482:0:b0:33e:9113:a228 with SMTP id i2-20020adfe482000000b0033e9113a228mr2042063wrm.35.1710351053336;
        Wed, 13 Mar 2024 10:30:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c945:fed:36d6:130? ([2a01:e0a:982:cbb0:c945:fed:36d6:130])
        by smtp.gmail.com with ESMTPSA id ba1-20020a0560001c0100b0033e712b1d9bsm1934600wrb.77.2024.03.13.10.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 10:30:52 -0700 (PDT)
Message-ID: <571aceaf-fe32-4bce-ba79-8a5718f1aeac@linaro.org>
Date: Wed, 13 Mar 2024 18:30:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 3/3] drm/panel: simple: add CMT430B19N00 LCD panel
 support
To: =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?=
 <jeremie.dautheribes@bootlin.com>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Yen-Mei Goh <yen-mei.goh@keysight.com>
References: <20240313172016.387277-1-jeremie.dautheribes@bootlin.com>
 <20240313172016.387277-4-jeremie.dautheribes@bootlin.com>
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
Organization: Linaro Developer Services
In-Reply-To: <20240313172016.387277-4-jeremie.dautheribes@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/03/2024 18:20, Jérémie Dautheribes wrote:
> Add support for Crystal Clear Technology CMT430B19N00 4.3" 480x272
> TFT-LCD panel.
> 
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 20e3df1c59d4..d13c42d0f57b 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1457,6 +1457,32 @@ static const struct panel_desc boe_hv070wsa = {
>   	.connector_type = DRM_MODE_CONNECTOR_LVDS,
>   };
>   
> +static const struct display_timing cct_cmt430b19n00_timing = {
> +	.pixelclock = { 8000000, 9000000, 12000000 },
> +	.hactive = { 480, 480, 480 },
> +	.hfront_porch = { 2, 8, 75 },
> +	.hback_porch = { 3, 43, 43 },
> +	.hsync_len = { 2, 4, 75 },
> +	.vactive = { 272, 272, 272 },
> +	.vfront_porch = { 2, 8, 37 },
> +	.vback_porch = { 2, 12, 12 },
> +	.vsync_len = { 2, 4, 37 },
> +	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW
> +};
> +
> +static const struct panel_desc cct_cmt430b19n00 = {
> +	.timings = &cct_cmt430b19n00_timing,
> +	.num_timings = 1,
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

