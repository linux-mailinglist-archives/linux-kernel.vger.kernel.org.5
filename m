Return-Path: <linux-kernel+bounces-156408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C005C8B0275
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F700285173
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5563F15748B;
	Wed, 24 Apr 2024 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YvT62r++"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8705182AE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941557; cv=none; b=CaK6E/hCgt8vRqI5d8XZ1/2LKEzfIjySMM/wkSH3vXHolEWHQKvd/BoC47R/dHZ2TF4CEfIA8OujAGBQ1uqupyfgHhsRaY31xcta8erG5QsI8hMsTnPPs3PkMJRa9ZQlDOlkcOBzyDwjxfxsYau1v1rOeFW9u65WzxFFZEL8UYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941557; c=relaxed/simple;
	bh=wPIQdMoTKZR6pu/TX/SJZKRKnEofue52kci185nLmYM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cCQKpQ5lk7W6ZDOZN3gHxbTyY7O2APiU93DxYF65W2KPm3E5Glg1lPaQwiOy4Uo7H0J3ZqN5qfLkbWGFrznfYoVCjAU5X+jVfjJVVVVPA5C4sDRUyodsove+q5+4cpdjdO1+BggQaPMmPmSkdCAmybfTUVRt5AWNY5kOzOMur8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YvT62r++; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-343e46ec237so5497757f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713941554; x=1714546354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+kkCAVJxss4CPk4KOwYcVQMSZDA+8r/AwQ6dh68tMs=;
        b=YvT62r++6PBAa7gqV+HkrhX/F7ANXaJLAc/Y6dpWqVnNNs+5fjWorl2Iigtbg6Oqgh
         SMO9nLZ+62xVD36PcGDG94U2nwyCfV0xzcBVInQoq3Pki2ri8rMfjWprfJ/m+yBqpavd
         PdNPVmtqoA0J1wmNf5H3v49ZD8PntfroJvE64uguMA/mqC7N4UcWFDak0xuaP+tPj0IT
         A2ejn54kd/M93BfYw6vRlD2/qx7us0NsHn7vcyor6nh8smPRNd1MaybaG5QYg4tH+sPt
         Wy/zgw9NMeX8QaaWogPQhH9yaWvuJ+cBWUyw5qZsghD6ynn+4gTa2pqXzKdajopCAcpz
         4+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713941554; x=1714546354;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z+kkCAVJxss4CPk4KOwYcVQMSZDA+8r/AwQ6dh68tMs=;
        b=GAntZ9c6mfB4fw3GisFfzqu9ab9e+siuRozGJC2DdchcwH/aeCwFzEAMW/r9G2oxss
         QRp04thYA0V44t6Wn/iEyaBpDlALVlTubRSXXy2FFvRHSdmpPoaLoiIWrbcltCogWgpT
         AxuI4MSucVUWQkPFh6Vsk3TKitLMur2Pl+drxQgjwzRy6n7vJ5yEFxFs8E3cvwejT5vn
         99zP4TUcq8sXTmNVzq1IzphSAGEPpieUyPlXevl08SmqzgeM9FuzvKJvg06KjR4oW2oG
         RrA0Ir1Knz0trKNSLwoWPkNnRi2UWd48t/ayWC5nbACrdYJOlm8+7X+Q8mVXh8U/DS8a
         Y4Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVt11bMUPZnTLOc3r2O22XF9dBpxmsk6+m/yigTdH92mlMHl/awWPQePmhpOR4ENiAYLKTjqyapLzSlRWp0qxPodzT4V7Qe+jcIQmI0
X-Gm-Message-State: AOJu0YyZ3AW6Wu8f8+nur64DdP5FFhT+4rss1o4EE/dfPvjw1iS3zFOF
	VTRM2mCfD1eZtNxi1AWF2f3ea0arNa+ziOmH3zaAfxJOM9OzgeB/D1cq3IPH8l4=
X-Google-Smtp-Source: AGHT+IEVWgpM+FkCadzRn9I6amzbQMsnZKpbQYUhVluMjNrwR1wMJqnIGERLUVZnQUC66EUNm7zrKQ==
X-Received: by 2002:adf:cd11:0:b0:349:8ae9:b030 with SMTP id w17-20020adfcd11000000b003498ae9b030mr952155wrm.10.1713941553966;
        Tue, 23 Apr 2024 23:52:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ed3e:c90b:dd74:51a7? ([2a01:e0a:982:cbb0:ed3e:c90b:dd74:51a7])
        by smtp.gmail.com with ESMTPSA id j13-20020a056000124d00b0034b7906c716sm3146747wrx.106.2024.04.23.23.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 23:52:33 -0700 (PDT)
Message-ID: <c0f90e91-25dc-4912-906b-154c555fa25c@linaro.org>
Date: Wed, 24 Apr 2024 08:52:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/6] drm/panel: novatek-nt36672e: stop setting register
 load before disable
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Matthias Kaehlcke <mka@chromium.org>,
 Harigovindan P <harigovi@codeaurora.org>,
 Ritesh Kumar <quic_riteshk@quicinc.com>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240404-drop-panel-unregister-v1-0-9f56953c5fb9@linaro.org>
 <20240404-drop-panel-unregister-v1-3-9f56953c5fb9@linaro.org>
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
In-Reply-To: <20240404-drop-panel-unregister-v1-3-9f56953c5fb9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/04/2024 12:08, Dmitry Baryshkov wrote:
> It is pointless to set register load before disabling the register. This
> vote is going to be dropped as soon as the register is disabled. Drop
> these register_set_load calls.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/panel/panel-novatek-nt36672e.c | 17 -----------------
>   1 file changed, 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
> index c39fe0fc5d69..9a870b9b6765 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
> @@ -25,12 +25,6 @@ static const unsigned long regulator_enable_loads[] = {
>   	100000,
>   };
>   
> -static const unsigned long regulator_disable_loads[] = {
> -	80,
> -	100,
> -	100,
> -};
> -
>   struct panel_desc {
>   	const struct drm_display_mode *display_mode;
>   	u32 width_mm;
> @@ -385,20 +379,9 @@ static int nt36672e_power_off(struct nt36672e_panel *ctx)
>   {
>   	struct mipi_dsi_device *dsi = ctx->dsi;
>   	int ret = 0;
> -	int i;
>   
>   	gpiod_set_value(ctx->reset_gpio, 0);
>   
> -	for (i = 0; i < ARRAY_SIZE(ctx->supplies); i++) {
> -		ret = regulator_set_load(ctx->supplies[i].consumer,
> -				regulator_disable_loads[i]);
> -		if (ret) {
> -			dev_err(&dsi->dev, "regulator set load failed for supply %s: %d\n",
> -				ctx->supplies[i].supply, ret);
> -			return ret;
> -		}
> -	}
> -
>   	ret = regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>   	if (ret)
>   		dev_err(&dsi->dev, "regulator bulk disable failed: %d\n", ret);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

