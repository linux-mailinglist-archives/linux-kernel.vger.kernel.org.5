Return-Path: <linux-kernel+bounces-24489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0058182BD56
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DCE286A45
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7F956B7A;
	Fri, 12 Jan 2024 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nOTwzNk2"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7532836D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e68ca8e21so165995e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705052127; x=1705656927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xuKXhOStQyK9dpMS9adBtqgfDhayEXns7siZHVfVaYs=;
        b=nOTwzNk2XM81U5atcZrseW0OCmMSfDaLgOQCI6xMyvkhBk2cxElWW53IhUDgSKpQlb
         AvYvI2mCEff1yqOD4cZB0Cb9kDh/jZ/r/bXnzMxfhk9l0s8MiNuTru22q2GKkca5y/jT
         dDsMvJZh8OucDUyAHSbdyLQHMiEFJa78KWWg5c2+DAj1PXwQsPz7tBMUOG6cZ2w4K9ne
         bmTUr7oZS9qNuaSy10mfLrgenQiBAp7jOPsgUuz5OZi7OfvUW2lthPMqkbNx11VbD2OJ
         9Cp4kPz3n4Q2hSXndx66NL7cVmfKTuG+UlqSK9skknm3/iSsrrHoomKS9PXQljryTw9Y
         uJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705052127; x=1705656927;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xuKXhOStQyK9dpMS9adBtqgfDhayEXns7siZHVfVaYs=;
        b=dVr6KpqT7cge2qgdnOSgUXvbT64Cc8hHiQeOFcWVIhKs9783GBIuRvFe2cg2zTRWzC
         TLwvGnYd8NpmKd8E4hBUESsM8Lt8zq8hJYsOt70B3HomdSEwnduStEwj8usWo5qKV4ad
         oecGGc+vj83oY701FNAQ173lkgjfjIaXQiwQQidy9c2P/TuNQvUV5WR4Scao1FdB/hpr
         fuPjk0ubeBjR9g4h8rwS0CTRekWmoKciFRXv56ZlKEDVLZZ51kjneCSBjHT/C2BfNE6N
         36+YY0YK1tfrM15KXrw/2ivzRJRrGVUCUgCh1RwKfSmYIV10jF017cdfz7sQ5T2OxJJK
         66rg==
X-Gm-Message-State: AOJu0Yz9xiR3NGaoPugassDgWqyEYF4ljf8cMT8JKaoa95lRvcyLUhFG
	gg7SV2QiYJmskPN8Nogplq8z3Ym7iXxY9D78p2+rGq4Fp/Q=
X-Google-Smtp-Source: AGHT+IEIUsFljOBhgViMV2rZfaH+HuPIoVtMnRKkHQ6Ft6px8h1iNrwtieNSYeHUgEPD1rUxc/CMXQ==
X-Received: by 2002:a05:600c:3515:b0:40e:465a:8b54 with SMTP id h21-20020a05600c351500b0040e465a8b54mr575654wmq.4.1705052126776;
        Fri, 12 Jan 2024 01:35:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:59d5:231:f1ee:77f? ([2a01:e0a:982:cbb0:59d5:231:f1ee:77f])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b0040e56830a35sm5050051wmo.18.2024.01.12.01.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 01:35:26 -0800 (PST)
Message-ID: <789bffea-cc4a-4752-8113-31101df951bf@linaro.org>
Date: Fri, 12 Jan 2024 10:35:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH linux-next] drm/panel: samsung: Simplify with
 dev_err_probe()
Content-Language: en-US, fr
To: chenguanxi11234@163.com
Cc: cgel.zte@gmail.com, yang.guang5@zte.com.cn, quic_jesszhan@quicinc.com,
 sam@ravnborg.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Chen Haonan <chen.haonan2@zte.com.cn>
References: <061ed94a003362bb7d7e9d3e4d38358c5b91c8a3.1704186827.git.chen.haonan2@zte.com.cn>
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
In-Reply-To: <061ed94a003362bb7d7e9d3e4d38358c5b91c8a3.1704186827.git.chen.haonan2@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/01/2024 15:17, chenguanxi11234@163.com wrote:
> From: Chen Haonan <chen.haonan2@zte.com.cn>
> 
> dev_err_probe() can check if the error code is -EPROBE_DEFER
> and can return the error code, replacing dev_err() with it
> simplifies the code.
> 
> Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
> ---
>   drivers/gpu/drm/panel/panel-samsung-s6d16d0.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> index 79f611963c61..f4103e762b53 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> @@ -194,10 +194,8 @@ static int s6d16d0_probe(struct mipi_dsi_device *dsi)
>   	s6->reset_gpio = devm_gpiod_get_optional(dev, "reset",
>   						GPIOD_OUT_HIGH);
>   	if (IS_ERR(s6->reset_gpio)) {
> -		ret = PTR_ERR(s6->reset_gpio);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(dev, "failed to request GPIO (%d)\n", ret);
> -		return ret;
> +		return dev_err_probe(dev, PTR_ERR(s6->reset_gpio),
> +							 "failed to request GPIO\n");
>   	}
>   
>   	drm_panel_init(&s6->panel, dev, &s6d16d0_drm_funcs,

This patch fails to apply on current drm-misc-next, please refresh.

Neil

