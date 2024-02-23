Return-Path: <linux-kernel+bounces-78185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A77BF860FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FD51F2250D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF1676C83;
	Fri, 23 Feb 2024 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z3rtjLRL"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C250E22067
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708685795; cv=none; b=RqGVcTpf+0ME1sYwsG9IXESTEpoM8pk1yS5A299Fp00TL06YbnYAkN2T1fXzyzC85JKCctaZYDyROkHdwCBSAH9o15Fq60g+ArX5QwkUDzRjjlif7bmldfpcISd1RszPY6xKTBlScSu6HbW2h5Y7vzrNV+KrnSLsnUb48RkNJfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708685795; c=relaxed/simple;
	bh=JzvY7awSwq0q/UxG/6KHL0K/oyyz19vBqdVD90kYxB0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GWuxXlNyrBr3g8hcBijOcq9pvugpR5IxAHRF9YPtUP0prFqrnWra6kghhOaZEjy4CgVUSPam6qaNjAgHFH5HIhJ9PTRf2w26UIgn+HSePejUFXwGyVrX0/7S56kINxBc/XveHPSZlk73OMyk5fesjx0StcOj0BkSHwja/waNoas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z3rtjLRL; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512b29f82d1so258977e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 02:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708685792; x=1709290592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpP8FPur0ZRYYFc1Wrt+q/AzhU6BvtHVrmCY1eGQaCU=;
        b=z3rtjLRLFVR1Cso78NgeQ1UNMDO9Soszlh6FM02rnP9/Dl0jp6vyWHDYD4JIg1x4iL
         Hql6p/07uWznkOMeteHuhLVSHNhK20TGLKGSbNltELl1RbE/G3ihYem6GiDSbUb8hh4k
         wkwRmFcV6pDPqP8yjat//qzm6xKKJvFMLoRlDxzeOa9vqUyrU2ctpj9zqEJjna//nO++
         FRCBXmi/nIoQzPgyk0ruoyQJoSdi7lzA0bOCUY18ivrKhurkMNFo9Nky7Ay8GJOQvq4H
         4NxaHVYWQRXfKqiq3RHI37NhTafLPcAljzr30hIxBHfozG84W8l6Icph2gbPOfQd11HM
         0CXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708685792; x=1709290592;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MpP8FPur0ZRYYFc1Wrt+q/AzhU6BvtHVrmCY1eGQaCU=;
        b=tWns1GjmeN4GtCUA4P8GDvhNaN2OEDuwKk+SBWghLo9owrCQmfjq3sPlYA2X+mpiuI
         OUN5lVJ2GtrH88qCDMD/1HQR0iU9QXaWQJVmgMwPQ5sptttseCzwgoWvIydB+gePNK5y
         9lCgX7cd6sMCjJHFLt69YzbE91BYRQx2dhtFTGcoJ6KMctUVCfnJfTHDP230aAULBTB1
         LIGrFs4Fz/9pKjLeZPVM057aRExQlbZXSnMgHkQ00RKH607PJN58nX8iHQOO5bh99uXY
         TCxFOzv4OMujuUu/neupmVvX6w8iXmCem9fJJ3mvEocz2rgz/ijDVkyJe3pO2/H/nVaU
         dULA==
X-Forwarded-Encrypted: i=1; AJvYcCXgoSYZK448Ncx1QSeBlJDeRvGUpj/R1aL0Uq+DEFXb+QyxUDy/3yTXrAf49cLa3f7IqktXnaHHrkCBQ7yAwbeslOo3hhTcBoHkKEzT
X-Gm-Message-State: AOJu0YyRTlE6WnlQWVAyFoE7sTMe+KipjsJQbl91CGe8LyWnNaMenBJ5
	kVnznB7BQoHFbQe3QMe3K2SytLVw92L2jNC+SQBdvd8IxdndE05YAHi23TSR6RI=
X-Google-Smtp-Source: AGHT+IGoUt7Fo3cGKI6n2l0IfoZedwioQlERDLvrVf3nYieXsy+3t8VU1JTDqOx1HqGQ3XlKqCskYQ==
X-Received: by 2002:a05:6512:e83:b0:512:d877:df6f with SMTP id bi3-20020a0565120e8300b00512d877df6fmr1519283lfb.2.1708685791786;
        Fri, 23 Feb 2024 02:56:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:58e3:6b80:c446:11f4? ([2a01:e0a:982:cbb0:58e3:6b80:c446:11f4])
        by smtp.gmail.com with ESMTPSA id k22-20020a7bc416000000b0041061f094a2sm1883595wmi.11.2024.02.23.02.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 02:56:31 -0800 (PST)
Message-ID: <ed18e76b-dce4-4b80-be01-e5e4b4760a10@linaro.org>
Date: Fri, 23 Feb 2024 11:56:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/6] drm/bridge: aux-hpd: fix OF node leaks
Content-Language: en-US, fr
To: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org
References: <20240217150228.5788-1-johan+linaro@kernel.org>
 <20240217150228.5788-2-johan+linaro@kernel.org>
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
In-Reply-To: <20240217150228.5788-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/02/2024 16:02, Johan Hovold wrote:
> The two device node references taken during allocation need to be
> dropped when the auxiliary device is freed.
> 
> Fixes: 6914968a0b52 ("drm/bridge: properly refcount DT nodes in aux bridge drivers")
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/gpu/drm/bridge/aux-hpd-bridge.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/aux-hpd-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
> index bb55f697a181..9e71daf95bde 100644
> --- a/drivers/gpu/drm/bridge/aux-hpd-bridge.c
> +++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
> @@ -25,6 +25,7 @@ static void drm_aux_hpd_bridge_release(struct device *dev)
>   	ida_free(&drm_aux_hpd_bridge_ida, adev->id);
>   
>   	of_node_put(adev->dev.platform_data);
> +	of_node_put(adev->dev.of_node);
>   
>   	kfree(adev);
>   }
> @@ -74,6 +75,8 @@ struct device *drm_dp_hpd_bridge_register(struct device *parent,
>   
>   	ret = auxiliary_device_init(adev);
>   	if (ret) {
> +		of_node_put(adev->dev.platform_data);
> +		of_node_put(adev->dev.of_node);
>   		ida_free(&drm_aux_hpd_bridge_ida, adev->id);
>   		kfree(adev);
>   		return ERR_PTR(ret);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

