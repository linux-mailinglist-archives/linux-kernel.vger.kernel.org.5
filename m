Return-Path: <linux-kernel+bounces-54524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D778F84B04A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0A02831D9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551CC12BE8E;
	Tue,  6 Feb 2024 08:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tGkw3ZSw"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22AC405DE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209275; cv=none; b=UBlIoG0jtDDhVfEeDihuFLcFNT9iAFf8W10/ilhYyzn7Jfb1NApx67abU5MPw940GnyYvmL/jNdcZn0DyDfphrt72rKtJ4WR7zF+rY7b7qrbxUFuTTh+V0zEHZ/E8Rs6Z5bc33h1niaISbmE4d6F3sZYgtC2xc8F+4a8MNs9Ddw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209275; c=relaxed/simple;
	bh=EsUbLCPxJMLTFoNAM1YzIwDW0MB37aZp3I+uJnzPFJw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=B0OYgLIKyr+m7Knlv7mrZLvYL8ub7/fTpeHxCFY8zCZUb7+RzDfrJJ00R9/1l2xajenMxTMI/cEQ82sURP3c5zFME9X7MYrA6fVx17YZBkz52tYvZ1yFzwfyeJiKvLwgwp5MbXqZ7nOepRW7kkBYSMzV/Qhr/Yr/ab1Vavjw6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tGkw3ZSw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fd55c7f93so5097755e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 00:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707209272; x=1707814072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cgswh97JThtSZc+MWkKLL/sOqrjScM78TS+JiOIKCEY=;
        b=tGkw3ZSw3dUjfD8rX10QZYPVcfZ54vxW3M6UC4z+ILSSAySg/6GrE7ivEzZzewHoGL
         a5ES3AqMbWLwFWnsOn6PWgUzqJ++3ukJh+9hwUjoB2ENTnS2EUiz2QqRECmyUBMPGJv5
         W3S26iowVwHRBbkZkT4Ln8MWrQJYMFVqGVhZcO5eAO8NOzsgTYILSiKRek/tkFv9/wov
         nRr7x0W0/2NeNmXnxuWm0o6C4Ot6dKpK4XdxOU+tLypV7WF2ncVLeHAiW1B6NcgMEP3b
         8hi+D/m6wpuRTCyIp3E7JiNNTmAfNJcJ0IxmFlAENGnoSQZ9+NH8iYUZoOo/tZLO5UHS
         LBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707209272; x=1707814072;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cgswh97JThtSZc+MWkKLL/sOqrjScM78TS+JiOIKCEY=;
        b=H+yigpc4wi/wMD1oKI+dao8y7NSsyYHVNJWPTyoOAdZzxg0G864oN9upAQVTt2AhFS
         Z0atpEpLYkgQ94IWib7WopwUayBChiBbr2Q1mfzvfxD71RRxKE5ZkvyiNXGlOxUH79Wf
         Q1L20XTBLg/SiyCoHrb738bvZYzvzuTfTaeT3+boZ7n7LsgFIWlBGFNfw1z0KREGw5sx
         5PmBFIG9zwVIjLkZhcp5aKGpRBsGPPwNJKoJi7rmQ+C3+O7feHz8yJiD4W43C+JI/SX2
         U8AK3buxpJx8BGxWq21oCKqG38N5nmPH8WyvUPwuwYk1GCq17eAsjtkS7OpDXSd/m2rI
         M5EA==
X-Gm-Message-State: AOJu0YyY5LFx0rmtepEpY7ZBgxeSs7gm7pZ9FBozE3YMGTTTU/6psk+G
	y04FxMRuqPS5AEC7MGPDVXTko/E/EwwcIAXjFvQPyXxaY/LuDQV7nxZ7at/8Pbg=
X-Google-Smtp-Source: AGHT+IGhYB7S/j7lcNzeBzGO6RKkAL5j0F4BGe7lMnfxVZSyyt0yaNgwR3CzP3SL1KkRGHmCS6IleQ==
X-Received: by 2002:a05:600c:5204:b0:40f:bdf3:3426 with SMTP id fb4-20020a05600c520400b0040fbdf33426mr2050471wmb.31.1707209271941;
        Tue, 06 Feb 2024 00:47:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX161gOqgvdRv10X26uunEqBIdx6lmer6jebnO8ie7WB84hoaVNdkmlbFSJ5LjujcMzuSzR/xphCn25giI+Q9UXCOpzU0SYElVmWIQHgdF1py1U6L8WklwZZ3QCMEX5nHAOzbJ9xizUKNmRG7qouRrbJUW2H0ChFld4lhcQ1KE9rJ+70wxfDZBjS2Kc0VxqLZOAGYnfch42/wyj5QYcH8ntahvUVFDmk41fpL5rXhGVE0BbfZWgTNwPSj9wZMcSWF77C2AruITJSKqyiP1Go4J5m1tT1or2ugXqOOxrXzTQ7YDRBGl1iKaBRVIiXD6ZaV+DyjcjKv5cvRVdxCt+od9xKcOV6F3/VQr3bdL2enneL+g0fOryGLlMbyAjDVZkC9jBg3EDHyoUXjj03kT0z561HwcXCTD6FBYlDJfH5VxhCQ7lVPLqsGVNUuEXexKOKhaEBxfYQHceEq7+1Ca4rKDHI5JfApLifcobxpRZNIZRb47N+wmvsTtdfZg4sc9kWkJD3GZshjCLZt+YeEjY/a3k8X4emne7fSNi6nAfvkxYgs12WG8iNGcsJjCA3i0mkA7UCH+6Wp8IcF80TAwq9ZrMZVn8Lmo9ggVYYDUb6g==
Received: from ?IPV6:2a01:e0a:982:cbb0:ba23:8574:fa8:28dd? ([2a01:e0a:982:cbb0:ba23:8574:fa8:28dd])
        by smtp.gmail.com with ESMTPSA id l16-20020a5d5610000000b0033b3ca3a255sm1511899wrv.19.2024.02.06.00.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 00:47:51 -0800 (PST)
Message-ID: <0e47aa27-b28d-4672-a2eb-f906e0e6a5ac@linaro.org>
Date: Tue, 6 Feb 2024 09:47:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 08/18] mfd: khadas-mcu: convert to use maple tree register
 cache
Content-Language: en-US, fr
To: Bo Liu <liubo03@inspur.com>, lee@kernel.org, wens@csie.org,
 marek.vasut+renesas@gmail.com, support.opensource@diasemi.com,
 ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com,
 mazziesaccount@gmail.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-amlogic@lists.infradead.org, patches@opensource.cirrus.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20240206071314.8721-1-liubo03@inspur.com>
 <20240206071314.8721-9-liubo03@inspur.com>
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
In-Reply-To: <20240206071314.8721-9-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/02/2024 08:13, Bo Liu wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>   drivers/mfd/khadas-mcu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
> index 61396d824f16..ba981a788692 100644
> --- a/drivers/mfd/khadas-mcu.c
> +++ b/drivers/mfd/khadas-mcu.c
> @@ -72,7 +72,7 @@ static const struct regmap_config khadas_mcu_regmap_config = {
>   	.max_register	= KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
>   	.volatile_reg	= khadas_mcu_reg_volatile,
>   	.writeable_reg	= khadas_mcu_reg_writeable,
> -	.cache_type	= REGCACHE_RBTREE,
> +	.cache_type	= REGCACHE_MAPLE,
>   };
>   
>   static struct mfd_cell khadas_mcu_fan_cells[] = {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

