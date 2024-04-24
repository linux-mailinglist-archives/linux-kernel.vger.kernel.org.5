Return-Path: <linux-kernel+bounces-156414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B918B0289
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D10A1B23663
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB5D1586FE;
	Wed, 24 Apr 2024 06:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="egevWC8O"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95423158211
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941616; cv=none; b=mYmtTp7cwUqfUwMM8xSTXO1g5kWjd4zaomhqPuHPS3qFjOVRxoIndJiun370rGbdG+6hTelEguUn+xXW3x/z+KsbTqTodaMz8iEn8QN9iYChULT2glDEOo4bl6IRRp9HDsB2I3YUSmSSnDwVfUqx3ZCIrAkJXd3kQkhl8B2TN4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941616; c=relaxed/simple;
	bh=0LLeRvzlsK4EGU6eRl92IzWk9TrKfHRom8Ioq0H3ljQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hFFosooYVzUMhWnmSfS3pCeMTbFb4grcYGt1pMFesZvJKeB58cdItxsulC+JZEVT5tdanzF+pseAViJLE83xoDEEpxgHs+CiGq4NpNKVWSW79Nqif5ffQraCOKCHVCVzYGPG3IGSrHcCzQDt6qJTSIJTbK5C2Ec16JQy5mPOvKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=egevWC8O; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34a00533d08so3905539f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713941613; x=1714546413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ce4fgMOtZLBQ3aabDQJk5teub1RBOKX02c0UGJh5yuE=;
        b=egevWC8O8RR2dNt3eppA9XTnJD9+bTAmT8pLhWd2DRNQ6WUqefSEjmgXG3VAGdV7ir
         xfMmFGlN59BnUfWO8vbPA1RXFUG6fvNYcxHTkhwxcY+W67Fae9EgXGcVCh/cumSzN4Bn
         IeqG/rrw4O3yuocGFG0z6vt59EW0XmVlWXbV8TP5+L7aFhyo8/gw34onhjgRa6jQF3Gt
         dc+S6YjQs+FX2Ka2g7/fZUMYH10xKycvPwx+OxEkVCQ81GqUvCXCqxbnUwOfJDQLoCw5
         bgqwAevhLqSRFaz9P0WYR5wuYc5eCMdTpMlwwmqEIy0wmPWra89PtamNmUrFPM2oi+2C
         /Kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713941613; x=1714546413;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ce4fgMOtZLBQ3aabDQJk5teub1RBOKX02c0UGJh5yuE=;
        b=h6+zPg17p5j5i80E2TtEskpjhIMepdjpvCFsaKftv0hKOHmSy7OxOakknxfX7uwNOY
         6huJCt2tx5zMl86xaBdTD5cH3DMCUGTYPN9HWiGxvVene6DDyXjzoxeLMqCL0Tjx5ZHh
         0t8e2aFN2JzxXQXMcH4tpoXdrtzbEiCXEbiAMaS/bi/scYOpCAvD7FN5wngrGZ6u8i3z
         MuJ/0OYF/zMlhn0pLQG61+wXVPC5rrrFEuqFk86kMUcP/+u18tdjc8krIs3u3HrbmUmz
         IlGHUIked8/nG2/lrvHdLkstldEbMjdC4grpnaCe0/D7JaHju4EDAHSLhwaDsnQl5Xn1
         Ybbw==
X-Forwarded-Encrypted: i=1; AJvYcCV/aWyVve7D5/jFdDl3E1ZvX1iMZw4iD6kFdupbzIjLL23i8ipLyQBgFKPpXi84Fr5pY8fNBNuOltRDzpKlCNm2T1337cmAmjbUh45i
X-Gm-Message-State: AOJu0YyAYiJYouFg20Vb5psRKpAukdSK+tmHmks8eMOMcPtPex9xNoJI
	UxNO84Uvgbsp6FqNcPm+oxVk3G0ouaXK+f9ojrqZ2OBvhmMqCvyuVJtlH70vURY=
X-Google-Smtp-Source: AGHT+IEhAmr3KBsIwZ2SCPk2yHI1frtEebCy80S7p0GZujfF4lyzJOX7sKXVsG4ySRCv8SHabZaonw==
X-Received: by 2002:adf:eec9:0:b0:34a:4445:22d1 with SMTP id a9-20020adfeec9000000b0034a444522d1mr1405624wrp.63.1713941613033;
        Tue, 23 Apr 2024 23:53:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ed3e:c90b:dd74:51a7? ([2a01:e0a:982:cbb0:ed3e:c90b:dd74:51a7])
        by smtp.gmail.com with ESMTPSA id j13-20020a05600c190d00b00418a386c17bsm26479771wmq.12.2024.04.23.23.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 23:53:32 -0700 (PDT)
Message-ID: <94857285-7796-4615-84e7-295294844656@linaro.org>
Date: Wed, 24 Apr 2024 08:53:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 6/6] drm/panel: visionox-rm69299: stop calling
 regulator_set_load manually
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
 <20240404-drop-panel-unregister-v1-6-9f56953c5fb9@linaro.org>
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
In-Reply-To: <20240404-drop-panel-unregister-v1-6-9f56953c5fb9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/04/2024 12:08, Dmitry Baryshkov wrote:
> Use .init_load_uA part of the bulk regulator API instead of calling
> register_set_load() manually.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/panel/panel-visionox-rm69299.c | 16 ++--------------
>   1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> index b15ca56a09a7..272490b9565b 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> @@ -197,7 +197,9 @@ static int visionox_rm69299_probe(struct mipi_dsi_device *dsi)
>   	ctx->dsi = dsi;
>   
>   	ctx->supplies[0].supply = "vdda";
> +	ctx->supplies[0].init_load_uA = 32000;
>   	ctx->supplies[1].supply = "vdd3p3";
> +	ctx->supplies[1].init_load_uA = 13200;
>   
>   	ret = devm_regulator_bulk_get(ctx->panel.dev, ARRAY_SIZE(ctx->supplies),
>   				      ctx->supplies);
> @@ -227,22 +229,8 @@ static int visionox_rm69299_probe(struct mipi_dsi_device *dsi)
>   		goto err_dsi_attach;
>   	}
>   
> -	ret = regulator_set_load(ctx->supplies[0].consumer, 32000);
> -	if (ret) {
> -		dev_err(dev, "regulator set load failed for vdda supply ret = %d\n", ret);
> -		goto err_set_load;
> -	}
> -
> -	ret = regulator_set_load(ctx->supplies[1].consumer, 13200);
> -	if (ret) {
> -		dev_err(dev, "regulator set load failed for vdd3p3 supply ret = %d\n", ret);
> -		goto err_set_load;
> -	}
> -
>   	return 0;
>   
> -err_set_load:
> -	mipi_dsi_detach(dsi);
>   err_dsi_attach:
>   	drm_panel_remove(&ctx->panel);
>   	return ret;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

