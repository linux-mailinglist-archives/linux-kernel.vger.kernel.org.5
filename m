Return-Path: <linux-kernel+bounces-158858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F358B25DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB761F227DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B2A14C5B8;
	Thu, 25 Apr 2024 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gB08OIcc"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F11414C59B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714060854; cv=none; b=O0+j0qXuhUNXzY8CGfFotzPbQ11RnujKtmDqXpSHdPg1WR4Gyb8WPWceEu0V0FNjKIy99fcYW5iZCxfWuwyOiDobR28pO26Pa9Zx5somsjCFPXIPDI1t/HhBOQS5ZFzW0TxvKwemaMWBCcclDwJcZCZ44q6VP5ExJjjBnp/hhz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714060854; c=relaxed/simple;
	bh=JBXvcCemZK7+GexmKhCeDPXQjou4mKuLIHvf0CFyybU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aqnw+MCPHKiZQTttX8q+DCpMal2C/o+pvcnzliQKOENy0BiMA0W4oi+7RDnd3Bl4+KC8oKrYmkEfqIRTaAeiN6tfAnL4YuqMS1BxbQqbUIXU7/SUOGawhX6u8ak+ZbhvUbg0OmCPSEanB+xV0MY35ta4wnTP7uKcH3yOkJrwAos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gB08OIcc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso9080085e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714060851; x=1714665651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kckeE+NEI4roa7Me46yLkkObGQIsPjSIT73YQTFPxCk=;
        b=gB08OIccV71zTTCV7uVsNzbyR03f4qDMTxOoja5oubEV+WPG1uK31GFBZuoV9TWwSh
         pRBynavLM4VZzLAqPfVFqEnbVlDmaqJ23ZCnGVlBHpeSgavpLHCe0h2b018kWSSwKrSm
         VPAgwB8OlU8hwcEtmFFutpqb51bdNu0DZz0Ts9Fb16Vl6MLstWVbzUnz7paGx61mykNJ
         VDExRWa6DCynzOawUHlsnDCjYF4Sedv1GcUK/Llg14vcwub4lYwh6wWmdqBjw8AlfHxO
         krnPPSh15NWdvNlSQJ/0W09CLShAotT9GxlwvZ+qv73vdA2wRZRQ+vN9/TX2vX8GexIV
         OYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714060851; x=1714665651;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kckeE+NEI4roa7Me46yLkkObGQIsPjSIT73YQTFPxCk=;
        b=RXItWteDNp6Z2n5G3qgMc+RdCmlPvV5oQqAEJGRPcqH1zuBJIEVvf5iepFrLsp1/SN
         sA+Hw3JvsQE+Il4am5zZVeXwxYshQjudmKPYKQcbruNtHPK6jkYorfNTnbk3m8nBSlB4
         eP0PFSNvC3AJDGIOPQDR4wirj77027dzSFKHFOHid+6/KBjeH7t5dsSRfrFrFb0/ZKVm
         KY0gY3QRx7rLgDJb0QMmUtcPkEryOb+nAajo/FRBO+273/8FOu/kPNBqt8PhZz3Ygnll
         agGVefUilTvAzafPX11ABqGGhYLdnRJ7gPuaD8uBvBzQT/aK/iN2ObwifRPU/SHbCNTJ
         t+9A==
X-Forwarded-Encrypted: i=1; AJvYcCUk0zuUN9629VP2kaNTuWKj9wQw4WSvbbYEvGEgc4HngqavVGnU9mlonIb//Rw0ZC+29rRc44asn9WAJ9/VKe8wcNZ2VX8y1Q/ivCcX
X-Gm-Message-State: AOJu0Yz2uiddKQon88XLVZUbrhxMOd7XQncWMdB7f7s28HuYVwZ0kuuQ
	owazkrA90yCKwYRT0BpsXUcpHZgKcTp71i5X3WaslF3MNfm3q/64tVQesk0KOJY=
X-Google-Smtp-Source: AGHT+IHrjKF3l4sThlKJ+RxAmHgEGNIe9JwcfNY91sPhFvLEeh9FjhlyUGA200aqY+kHV/MZSMGDfA==
X-Received: by 2002:a5d:5642:0:b0:34a:ed29:8d1d with SMTP id j2-20020a5d5642000000b0034aed298d1dmr4312102wrw.64.1714060850776;
        Thu, 25 Apr 2024 09:00:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:15c7:bd9c:c500:ed62? ([2a01:e0a:982:cbb0:15c7:bd9c:c500:ed62])
        by smtp.gmail.com with ESMTPSA id v4-20020adfa1c4000000b0034c32e9e2fdsm624252wrv.13.2024.04.25.09.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 09:00:50 -0700 (PDT)
Message-ID: <85be9e9d-887f-4138-8980-80385ff523fc@linaro.org>
Date: Thu, 25 Apr 2024 18:00:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 2/3] drm/panel: ili9341: Respect deferred probe
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg
 <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20240425142706.2440113-1-andriy.shevchenko@linux.intel.com>
 <20240425142706.2440113-3-andriy.shevchenko@linux.intel.com>
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
In-Reply-To: <20240425142706.2440113-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/04/2024 16:26, Andy Shevchenko wrote:
> GPIO controller might not be available when driver is being probed.
> There are plenty of reasons why, one of which is deferred probe.
> 
> Since GPIOs are optional, return any error code we got to the upper
> layer, including deferred probe. With that in mind, use dev_err_probe()
> in order to avoid spamming the logs.
> 
> Fixes: 5a04227326b0 ("drm/panel: Add ilitek ili9341 panel driver")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/gpu/drm/panel/panel-ilitek-ili9341.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> index 7584ddb0e441..24c74c56e564 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> @@ -715,11 +715,11 @@ static int ili9341_probe(struct spi_device *spi)
>   
>   	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>   	if (IS_ERR(reset))
> -		dev_err(dev, "Failed to get gpio 'reset'\n");
> +		return dev_err_probe(dev, PTR_ERR(reset), "Failed to get gpio 'reset'\n");
>   
>   	dc = devm_gpiod_get_optional(dev, "dc", GPIOD_OUT_LOW);
>   	if (IS_ERR(dc))
> -		dev_err(dev, "Failed to get gpio 'dc'\n");
> +		return dev_err_probe(dev, PTR_ERR(dc), "Failed to get gpio 'dc'\n");
>   
>   	if (!strcmp(id->name, "sf-tc240t-9370-t"))
>   		return ili9341_dpi_probe(spi, dc, reset);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

