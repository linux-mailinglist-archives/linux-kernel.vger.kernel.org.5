Return-Path: <linux-kernel+bounces-9470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BFC81C621
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3121C22262
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C066DC147;
	Fri, 22 Dec 2023 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5Yw4m/I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6B29449
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-336990fb8fbso42247f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 00:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703232129; x=1703836929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6l7PqFYjCtepvXE0Gj1HI9GmgWPHL+JynlGGhARAcRk=;
        b=F5Yw4m/I/Y9dMJqs+k7QID6oRwMKpj/E7KAjBUHhL4v2kU6Wy1yNxqnYqiHHa113o5
         PWhbVwTGLuUl0Eq8cKOxIVZfs1ecCZG3+djr8CbqGT1AKg3QIHOA6/6o3GpROF07DQnC
         kWbViXT7WHNLeatIrrReNJ813Onau7p+Qs8mN12TR/yusArERHmoXuZgy6iLWcEWooel
         M9rDwtZGQDql2Y3qTunwVvtdGcl+Flp8wKBEu31SgRe92LkJW03Z+d53ilx8478HmMD3
         Ueh/rMjTEYfhxTgr+6HKkKwkpx1/p6OogCtjvVq3LjazHAJ4X0Kf0Sf91AOYT4Pev+dx
         Amfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703232129; x=1703836929;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6l7PqFYjCtepvXE0Gj1HI9GmgWPHL+JynlGGhARAcRk=;
        b=q0Dfd+wfgD7hiRcNN6uNM2rxBF8obKz4hTBRYwxzryXz++tZ3N2rRzoz2FZLcA4E8i
         FjO3GrOiywvTxHDEcjcHh2aEpJ/n1B0rX0XQZoLGImY+ER9vzuBykcYVNrsIMfIJbnjt
         if5dJSXCeg1RlSb2gXpOMyGQMGbb1wvsjm7ilW/Iy2gLLv/LllkpMD9TmhklMQmRuC0O
         SzUqV/cgeRyEYojINn2oI1Gy9NTuB+cLbU/oiI+iioUsk7p0C9q0JMaN7bBISDVWjy/x
         qR2kGbH2oDlTCoxqcd+BV8UCLRkUxuM5Ra35r8VoBDYiFpOBvlWmt4g2vYzF9GCdsCrg
         7Czw==
X-Gm-Message-State: AOJu0Yya1xakZiOHkURIZAtsJAZQF4ejBGXk66CWa8pDrfkvZtOAA04t
	D/sGPmi2tSEZXhZUekUpq4/G8sZkBgcw2A==
X-Google-Smtp-Source: AGHT+IG2Uwav0FGOVhKVAxjBPwyl2olfKJQY9m5tA3Inmu3WeCTCkaoYyT396Pi2DMCK54+dNomilg==
X-Received: by 2002:adf:f8cf:0:b0:336:4ed5:56bf with SMTP id f15-20020adff8cf000000b003364ed556bfmr467046wrq.64.1703232129263;
        Fri, 22 Dec 2023 00:02:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:6d8d:fe46:4f99:9799? ([2a01:e0a:982:cbb0:6d8d:fe46:4f99:9799])
        by smtp.gmail.com with ESMTPSA id f5-20020adff8c5000000b003367dad4a58sm3694002wrq.70.2023.12.22.00.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 00:02:08 -0800 (PST)
Message-ID: <e41db6d2-2c3c-4dbe-a01c-6587fc762e68@linaro.org>
Date: Fri, 22 Dec 2023 09:02:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH linux-next] drm/panel: Simplify with dev_err_probe()
Content-Language: en-US, fr
To: yang.guang5@zte.com.cn, hanxu5@huaqin.corp-partner.google.com
Cc: jiang.xuexin@zte.com.cn, chen.haonan2@zte.com.cn, cgel.zte@gmail.com,
 quic_jesszhan@quicinc.com, sam@ravnborg.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <202312201048538333616@zte.com.cn>
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
In-Reply-To: <202312201048538333616@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/12/2023 03:48, yang.guang5@zte.com.cn wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> dev_err_probe() can check if the error code is -EPROBE_DEFER
> and can return the error code, replacing dev_err() with it
> simplifies the code.
> 
> Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>

Got the following checkpatch error:
ERROR:NO_AUTHOR_SIGN_OFF: Missing Signed-off-by: line by nominal patch author 'Yang Guang <yang.guang5@zte.com.cn>'

Thanks,
Neil

> ---
>   drivers/gpu/drm/panel/panel-boe-himax8279d.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-himax8279d.c b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
> index 11b64acbe8a9..e225840b0d67 100644
> --- a/drivers/gpu/drm/panel/panel-boe-himax8279d.c
> +++ b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
> @@ -854,26 +854,20 @@ static int panel_add(struct panel_info *pinfo)
> 
>   	pinfo->pp18_gpio = devm_gpiod_get(dev, "pp18", GPIOD_OUT_HIGH);
>   	if (IS_ERR(pinfo->pp18_gpio)) {
> -		ret = PTR_ERR(pinfo->pp18_gpio);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(dev, "failed to get pp18 gpio: %d\n", ret);
> -		return ret;
> +		return dev_err_probe(dev, PTR_ERR(pinfo->pp18_gpio),
> +							 "failed to get pp18 gpio\n");
>   	}
> 
>   	pinfo->pp33_gpio = devm_gpiod_get(dev, "pp33", GPIOD_OUT_HIGH);
>   	if (IS_ERR(pinfo->pp33_gpio)) {
> -		ret = PTR_ERR(pinfo->pp33_gpio);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(dev, "failed to get pp33 gpio: %d\n", ret);
> -		return ret;
> +		return	dev_err_probe(dev, PTR_ERR(pinfo->pp33_gpio),
> +							 "failed to get pp33 gpio\n");
>   	}
> 
>   	pinfo->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
>   	if (IS_ERR(pinfo->enable_gpio)) {
> -		ret = PTR_ERR(pinfo->enable_gpio);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(dev, "failed to get enable gpio: %d\n", ret);
> -		return ret;
> +		return	dev_err_probe(dev, PTR_ERR(pinfo->enable_gpio),
> +						 "failed to get enable gpio\n");
>   	}
> 
>   	drm_panel_init(&pinfo->base, dev, &panel_funcs,


