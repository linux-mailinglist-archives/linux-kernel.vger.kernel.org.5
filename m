Return-Path: <linux-kernel+bounces-156411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 623188B027D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823BD1C21CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAE9157A48;
	Wed, 24 Apr 2024 06:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H3IryjIc"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E15156F21
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941603; cv=none; b=ocSuWHmJDYmLrIxWtSKpli5MZjzYBAr4Q2exjgHO2arnJyTTgG6fce36smMj4jwnAlLb83Af4Pi3Zgskq4l5mxQyCHdh6tNeQuHGYcpONjweHgf5DNRYyog3335mq+bg3mBh8gsz4/ZCsDPtYS0FlB/dRyH3BvM6KwLOFjQxNxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941603; c=relaxed/simple;
	bh=x2gSCLg7uLZG7K8PeJ5O8h6s1WxNRtk+9+18X30B+Ic=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XcRg8HgQrWqMZAp9hDK5wIyuI69IVCUIAPtPQjGxXuZq6t+WUWqfhM14UcFCBwB3EMysSubJDgVD0LHFW+YWPOowJsNZlnnz50o2ae7TjEF5ybmoHsLWMtgb0Pqie4rM+DLq5CV2FV1NgIttuTYdB20NySu5sudWLYCeHxc29RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H3IryjIc; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-347c197a464so4896165f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713941600; x=1714546400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqU6fPwBtkCZTZvnM/ZJ76eoBIYTFy3ASfBRYXLlBBw=;
        b=H3IryjIcAzgFJuMwddFlHneKruBqrvenSdkAiB18j47TNNiePCnkN14Cgt31+Rf0DW
         NcC3JKSIzvM9c5wS/vhFVu0N+97VmsyY4ZGEjakgKoJwUVkKP7FILS2gjUPfiVzjzUI3
         rihEft/MS1tjRGSX+vpH8Zj2GEQUj9W7hMQp3hfq06VpnEwIkTGZK54CeXCvwm9WoXvQ
         w5D//uzA6yi8n6I40ck5QkWAZbd30GFpSOmsr0JnrMs4O/85vMf6Iffw7+XXWwBImiDp
         cqhuASo4aEBYr6uivNNNEgIZin7mOBPnSxJL4sXZ9LO+Bp5z3v3AJbJkcCmaIw622OL0
         Nr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713941600; x=1714546400;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eqU6fPwBtkCZTZvnM/ZJ76eoBIYTFy3ASfBRYXLlBBw=;
        b=lRhGQVd42eLtb4ZBA/14l6aNBQXOPUUZ7by5u2cnbbEQQEQ4PT/uaZB2Zyv7buMBOI
         LGDVeULcKAeVIWuMCPTyKdHLGl6zjEUZQ5Ajceb8J0LdjjtCjaMoF4Yo/O3zqeevw4YC
         lR9s0C15GmsRQ0/FC9/BiIw7nXFayygRpnHab67yfUY/5sZ0yjZ48bzCmIas9nB9r46a
         8lJz/UXglH1XETgru1b9Ei2qeamFw8dt/IQp8rxhjKcyAsqefrz7v8qCr4NkOrnOK6GE
         AVL90JKVGv7jTVqaCwrjqpUXbuh2nyXpCCP1rLoEyX6P/94jk9YQwW4ndmqGYNIbXzVr
         iZlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1Mik0dVwxjGgc6G1atGKRvWB1RZbUYNAKmpb0XAF1OPCZC1mFxmtHp3+7T2HmeGSrOf/MysBPIdydWZ/vOa9HIqhcSedXmJgViL28
X-Gm-Message-State: AOJu0Yy2xBs/xjn4vaFFc1Gy18UwsA4zQ1VmDYJn/40ekTAE9s5jtNB9
	8WMyz0/WXi0TJIvLQQu52QwyaWBqd8LT5GiGG+ITuVKQm0i+vpirct/dwOFcn8g=
X-Google-Smtp-Source: AGHT+IFNRZPm2LDELThFDdehPYka/qFCJmWDSy/dxL0Ndkbn2JxTZB/V+nr7S/iP9/hxS6SH0iNWCQ==
X-Received: by 2002:a05:6000:1970:b0:347:a81c:dadb with SMTP id da16-20020a056000197000b00347a81cdadbmr823946wrb.57.1713941599752;
        Tue, 23 Apr 2024 23:53:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ed3e:c90b:dd74:51a7? ([2a01:e0a:982:cbb0:ed3e:c90b:dd74:51a7])
        by smtp.gmail.com with ESMTPSA id d5-20020a5d6445000000b0034659d971a6sm16258046wrw.26.2024.04.23.23.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 23:53:19 -0700 (PDT)
Message-ID: <362383f6-6029-4fc5-8522-7b8fb131ea07@linaro.org>
Date: Wed, 24 Apr 2024 08:53:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 5/6] drm/panel: novatek-nt36672a: stop calling
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
 <20240404-drop-panel-unregister-v1-5-9f56953c5fb9@linaro.org>
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
In-Reply-To: <20240404-drop-panel-unregister-v1-5-9f56953c5fb9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/04/2024 12:08, Dmitry Baryshkov wrote:
> Use .init_load_uA part of the bulk regulator API instead of calling
> register_set_load() manually.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/panel/panel-novatek-nt36672a.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> index 33fb3d715e54..3886372415c2 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> @@ -605,21 +605,16 @@ static int nt36672a_panel_add(struct nt36672a_panel *pinfo)
>   	struct device *dev = &pinfo->link->dev;
>   	int i, ret;
>   
> -	for (i = 0; i < ARRAY_SIZE(pinfo->supplies); i++)
> +	for (i = 0; i < ARRAY_SIZE(pinfo->supplies); i++) {
>   		pinfo->supplies[i].supply = nt36672a_regulator_names[i];
> +		pinfo->supplies[i].init_load_uA = nt36672a_regulator_enable_loads[i];
> +	}
>   
>   	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(pinfo->supplies),
>   				      pinfo->supplies);
>   	if (ret < 0)
>   		return dev_err_probe(dev, ret, "failed to get regulators\n");
>   
> -	for (i = 0; i < ARRAY_SIZE(pinfo->supplies); i++) {
> -		ret = regulator_set_load(pinfo->supplies[i].consumer,
> -					 nt36672a_regulator_enable_loads[i]);
> -		if (ret)
> -			return dev_err_probe(dev, ret, "failed to set regulator enable loads\n");
> -	}
> -
>   	pinfo->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>   	if (IS_ERR(pinfo->reset_gpio))
>   		return dev_err_probe(dev, PTR_ERR(pinfo->reset_gpio),
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

