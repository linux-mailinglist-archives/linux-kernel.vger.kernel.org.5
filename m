Return-Path: <linux-kernel+bounces-85046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B3786AF90
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4312869DB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555EA14AD08;
	Wed, 28 Feb 2024 12:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mo309SyG"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E8414A4DD
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709124896; cv=none; b=JgprPmu3AqnfAc0sEVXRvvq5AdMK083wg03Hi2AMgMmmuP1TYT1UrCJpmFODjqKJ3Uv6rBi8t5eERXdHllMvVBasukkiUu486+RTSX7m3tZc0NYjHM83N2F74e2wPdElcCTzmORuEBFvy7dnETR8MX8YcfaAEepMR73H7cldkJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709124896; c=relaxed/simple;
	bh=UVxEoBHmzpATXPcL8VbnEOzbvudc03xBCeLNVlAoIuQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XVojCxnwKWg1P36hhMrNGyk5sM8h8USvkK/P3YEb5lzrQ2KQXacBKsRgnbyHC6Sw5QozcIYuvwVF438F2gp/8/BuL4i5BjGS56yrkgGCf/zENDVhXQVvRbB3OGn0YOARJWiCHAjPaRIcgdSiOvEsNNwkKNdcVh4V7jyvtaeCGhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mo309SyG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412ae087378so13022075e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 04:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709124893; x=1709729693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RAj/KK7dEjz8bgaOsKcLgi/tPAyQZi+gf3TKTy/NLU=;
        b=Mo309SyGCukRcyJOBvqkognUwp/nmGZgnJdpy8mVtVhzo+RPqpTMmZMKiVvxrmps4H
         IYE8FlBRt5VByezG76TNVYh8zlZPyGfJ/RCVXSXdhsM/yJWioHNtuj7VR9x0Sqw10bzZ
         6pjUN7EPPfUN5aX3jfL+5URJtGDz3QmbihxLCp83PZD5b2EmwZMYF8HYvCpSyDUn15TH
         BO6/HiltQMEoOL+vO8vbSAaPQNioDig2L8U1YThExDjc8BOH9B3cHS99rbt0GiAdWVl7
         wekZHfPodC1pg1nETcAAAWZQ03eYKyUnquV/Qco2NS5H/OG24v8ZAy2bPvO6lmor1TsN
         L24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709124893; x=1709729693;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+RAj/KK7dEjz8bgaOsKcLgi/tPAyQZi+gf3TKTy/NLU=;
        b=nw4JD1izVQJaJ//AC2BA16Vj0ZOpNRb8tKdXipDTzrHqUqihkiBCoIY55h5JytU1XD
         KPCEzEjDHiJP7PJGqXlLoqMprc31xjtZmYOS7IJyD8/a/4uhcKvJ+jlKwMVx0pYNvJ6/
         6kttU8okBv+sFUuNn+TXfxqIz/8UH1tF6VlW47Ky/Eyirr0rK7cn/HtrNpi53PBeJZl2
         9H8/tnM+ODkXyYZuC+UaJr7ccYChuAWZpFNa0kuWABv/7RozHmr2zj8OnUuiQls0pM3p
         JNx1jy3OOnUyXEaVmHn9lGU2hMnDn+JfBymACwR7P68bL7zLDS+bZ0YyxkN7yE3tWart
         eGPw==
X-Forwarded-Encrypted: i=1; AJvYcCVwu2KssY5b0E7+ITv0AQPGcglo8iSf1WVCfvjiCquElbR2UbHuGpY4FXZzY2COY28rDgCT8DbcYedQ9HrKRZR04ICJEFBH3xs6eGYz
X-Gm-Message-State: AOJu0Yzvh+6nYvz6i7wxtxDkdRQvXT3cwyvdkLbI9o+ZoyO1Db1dkULF
	nP5zh4zOMpuOQeWCNDXtI4HJhYbgUxKfCE6bN4/xiGqWDLo/aOoMPleMPwh00aI=
X-Google-Smtp-Source: AGHT+IFMzbMGgoH9g1ccJ1mdNl36iNZ8CY42LjZoxm5rOsW/s79QjgdnRVy5p4+++83bDeRlVc4JHQ==
X-Received: by 2002:a05:600c:4f86:b0:412:8814:9885 with SMTP id n6-20020a05600c4f8600b0041288149885mr9891784wmq.4.1709124892925;
        Wed, 28 Feb 2024 04:54:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8e80:16d6:ae57:b1cb? ([2a01:e0a:982:cbb0:8e80:16d6:ae57:b1cb])
        by smtp.gmail.com with ESMTPSA id p26-20020a05600c205a00b00412b62f6e35sm1260350wmg.15.2024.02.28.04.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 04:54:52 -0800 (PST)
Message-ID: <34f1f7ae-39bf-4a27-882e-bb972c4e958f@linaro.org>
Date: Wed, 28 Feb 2024 13:54:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: anx7625: Don't log an error when DSI host
 can't be found
Content-Language: en-US, fr
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Robert Foss <rfoss@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 owen <qwt9588@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@kernel.org>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240226-anx7625-defer-log-no-dsi-host-v1-1-242b1af31884@collabora.com>
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
In-Reply-To: <20240226-anx7625-defer-log-no-dsi-host-v1-1-242b1af31884@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/02/2024 22:20, Nícolas F. R. A. Prado wrote:
> Given that failing to find a DSI host causes the driver to defer probe,
> make use of dev_err_probe() to log the reason. This makes the defer
> probe reason available and avoids alerting userspace about something
> that is not necessarily an error.
> 
> Fixes: 269332997a16 ("drm/bridge: anx7625: Return -EPROBE_DEFER if the dsi host was not found")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   drivers/gpu/drm/bridge/analogix/anx7625.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 29d91493b101..4ee5614a2623 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -2076,10 +2076,8 @@ static int anx7625_setup_dsi_device(struct anx7625_data *ctx)
>   	};
>   
>   	host = of_find_mipi_dsi_host_by_node(ctx->pdata.mipi_host_node);
> -	if (!host) {
> -		DRM_DEV_ERROR(dev, "fail to find dsi host.\n");
> -		return -EPROBE_DEFER;
> -	}
> +	if (!host)
> +		return dev_err_probe(dev, -EPROBE_DEFER, "fail to find dsi host.\n");
>   
>   	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
>   	if (IS_ERR(dsi)) {
> 
> ---
> base-commit: 2ae0a045e6814c8c1d676d6153c605a65746aa29
> change-id: 20240226-anx7625-defer-log-no-dsi-host-c3f9ccbcb287
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

