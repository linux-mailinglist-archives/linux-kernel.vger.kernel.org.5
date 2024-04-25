Return-Path: <linux-kernel+bounces-158859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEB08B25E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05147B2513D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1120514D293;
	Thu, 25 Apr 2024 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ERfGnea+"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2C114D281
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714060860; cv=none; b=Fp+gR8eAVaxSmxQR6qVK4JfWG/eRR+Z19aqjGwcDo7NrtkyfJ3V+btGG579zupEndSjNNFD6G7RZaPLa64TJWUFNpodfYS7P6MZjBhEtpcNMVmdz0WDFjZIYP+DHw8UjNxXdWuV8fKVaxIN0dP9s9CBXypXOa5CYnD3QIMGAmTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714060860; c=relaxed/simple;
	bh=8PCfEo2KK2UVaUY+Ayole38Aswik1Oux81xcKFrrKPM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=e04ieaZ7sQMEzDhiHO652Us6V+oOyKxW2ttL9NaOiEQyXEyxQg8qUJKyJpftioruAAeUXcveHe0qRSzhc2ZaB/3OA1H1+esIAcIpDLnTq2ZdIymm3tCHIe1+dqZk7FKXrHxtdkjkaiQz1XmIdd4Pd5z29o736giBbu2F5D/c9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ERfGnea+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34782453ffdso1072958f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714060857; x=1714665657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6Neky7t0BvIw+GAPumIRo6iZtSUrkY2VArNrVlw8a8=;
        b=ERfGnea+jcHnZZpCiSGAsMOKcCy/MSuEeaO36A6ujNTCvfTRqUfUtAtaB02ekvdUoH
         cHI38N2PSCiPpFx+I7THXHMj1jUeixTA93NiZqlwkw6ycgPgv2Ii5znUBO4YlolYT5ar
         47YBNqS0QTeb7lHBgs4hBaRPBJx1p4Tf3XnVWUmPH1cotLiyzoAAcsXh/TfRJH/MzOX/
         +mpJUCluRR7bTwoit6u2oX1+Vp0ztbX1HZOQTCTks72284GiSsXT5STk2aZeriOWHQXZ
         KNgj9TXupOwfgkMiYuzQVovRIOvK49AYVWfhF4y8wyv68Lfw4lineIvGES1iSfm2B00e
         frMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714060857; x=1714665657;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u6Neky7t0BvIw+GAPumIRo6iZtSUrkY2VArNrVlw8a8=;
        b=okEe3cjU6KKJPZHF41bTBXV8cPxbiusc3ThhTj28Nw9a+iV1GN3K23zjP1shKxrgWX
         FIabLruD7cITPvDUxFpLa3Gfdnffbc8wMS1n4YDIQl9qe+PzTrJKBY8n8bH6eb3CkA31
         OB89d8mBEumrjTZYXCV7vAysI0yAuAsjRmzIhNIxavO9rZkRoZ5ucbPDfuEz/L5cJ2Id
         4IeAuZUC/n8keR9R/7NgMGzDFmU2o8jJPVBm+wT2WI13Zy75M8mTuFm9JdQ3iYkK+TuK
         Xe+zPQ05TNp+mQaoClQxkCLCvVLu35FJlW4k7orXj7DSwi1qbR35rSr1mUM0fIAlAW8S
         EoxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeRO7CJgZyhwSD7P0t9aZ9F/pf7wpqC24F22rMKkU7KWfSA+q/ibeQ9wtGvMTkP4LVLZGmV7w2kgoXuR1298jHZV1etRq+cvjaZJK0
X-Gm-Message-State: AOJu0YxFeu/9Yx/vzHpKJcZ4Yrpb4reHg3NokGJPqRGKBv+M0oBL1VIv
	VW6EoaSM5820sh4piNutzo9mvyQy5JIr4eALcYGQSOTTT61cizQsKbHEt7vNXLQ=
X-Google-Smtp-Source: AGHT+IE9fVCCuEgVpNEE4pSSim5AaGzpLIdcLo7sJYC9xgdsbHFWPKB8Ek86XQoABul+Os7HULPq/w==
X-Received: by 2002:adf:ce87:0:b0:34a:e798:29fc with SMTP id r7-20020adfce87000000b0034ae79829fcmr5793315wrn.52.1714060856843;
        Thu, 25 Apr 2024 09:00:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:15c7:bd9c:c500:ed62? ([2a01:e0a:982:cbb0:15c7:bd9c:c500:ed62])
        by smtp.gmail.com with ESMTPSA id v4-20020adfa1c4000000b0034c32e9e2fdsm624252wrv.13.2024.04.25.09.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 09:00:56 -0700 (PDT)
Message-ID: <d435b6f6-2c67-4ec3-b346-08c6dd02ee38@linaro.org>
Date: Thu, 25 Apr 2024 18:00:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 3/3] drm/panel: ili9341: Use predefined error codes
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg
 <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20240425142706.2440113-1-andriy.shevchenko@linux.intel.com>
 <20240425142706.2440113-4-andriy.shevchenko@linux.intel.com>
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
In-Reply-To: <20240425142706.2440113-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/04/2024 16:26, Andy Shevchenko wrote:
> In one case the -1 is returned which is quite confusing code for
> the wrong device ID, in another the ret is returning instead of
> plain 0 that also confusing as readed may ask the possible meaning
> of positive codes, which are never the case there. Convert both
> to use explicit predefined error codes to make it clear what's going
> on there.
> 
> Fixes: 5a04227326b0 ("drm/panel: Add ilitek ili9341 panel driver")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/gpu/drm/panel/panel-ilitek-ili9341.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> index 24c74c56e564..b933380b7eb7 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
> @@ -422,7 +422,7 @@ static int ili9341_dpi_prepare(struct drm_panel *panel)
>   
>   	ili9341_dpi_init(ili);
>   
> -	return ret;
> +	return 0;
>   }
>   
>   static int ili9341_dpi_enable(struct drm_panel *panel)
> @@ -726,7 +726,7 @@ static int ili9341_probe(struct spi_device *spi)
>   	else if (!strcmp(id->name, "yx240qv29"))
>   		return ili9341_dbi_probe(spi, dc, reset);
>   
> -	return -1;
> +	return -ENODEV;
>   }
>   
>   static void ili9341_remove(struct spi_device *spi)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

