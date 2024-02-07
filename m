Return-Path: <linux-kernel+bounces-56175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC7E84C6FE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1475A286D85
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9915220DC5;
	Wed,  7 Feb 2024 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CcEwJd41"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E301820B12
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297214; cv=none; b=q7E23psPI0/NiAzxISaONt6+DnW3LOzqn7zDh7JBq2vQIcdRFdhCo0QMEuRNsGzZEPfUAsLVsEwf05b/HuEfSb1kEAkM/49/2ychnWH6N/upm0tYc1NpdGHTH/xGXPVOdFFDqZHvbmT5w9z3ilNIe5K3HQEh/PPRDx07zLkgtY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297214; c=relaxed/simple;
	bh=ltC84Rm/vIiUlkpOo3LWjCuHw3JXzUtFSelaS6n7GO8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=R0/UPZfKN+AuhCCTY0P92wHjzyjZV2ZKQMK1JQ5HEwOEDMjDCqmThIfE/A6P4szCnRyflO2Qws15mvONF1jW5+AxV/uYX1SkJWwVYZ9QhV1TKafvLXTNgQRacrx9CTuf4bEVOqabvNdzt1+OUBqAliIDWH3e3C+W8IawUz6kb3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CcEwJd41; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5114b1e8819so557980e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707297211; x=1707902011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4boiLkEy1/DFsAyyQnQqltI77jo7vrHFr3VsLB2XPg=;
        b=CcEwJd413hpv0uNqy7kxX66LbWL/LFRHypigPJhNX9mtAfUWb5cUFBNpb40r91GVjU
         06vPfrnuDRpTkohtcnknX1CJ0FvJWs3qziIRCOptN+c6rEVmpnMNJNhDziK6UexMnyin
         wHuWhBUtYpi6ylH9ARrIh6f7HWOkWW/EdEwFR2P0Let+aAAYXYOXywu7/K9q2XuToKSI
         l6Il7plyQA69IzQeno24HKiFNovyYLCVrzy6cQby6Yq6A38ssUY42CFyc3mHHGsdqFqm
         UBf1pFpk5kNhKzyaR7wWsENQ8zFmaSWPEgC3F0pA22iPUZ2UqFsNXnFCJymJPniR25vN
         f0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707297211; x=1707902011;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N4boiLkEy1/DFsAyyQnQqltI77jo7vrHFr3VsLB2XPg=;
        b=cjXVtZDQjgek1x0Bc/fvqaVKdPf80Er+q3tvDWSgURRSsUmkoTr0pgeY9zdhV2iUvH
         GCOFPDbew/fzqC9TbCnXd8EfYcymD6X9FVi3eQrkI6dL//lHLcSMf2JrfmMSGJey2gCN
         yDvAKUQbEXJx/YWVHFfGQEY0OdfGUTaH4s0Ew+NxS4IUFgEddVnbZJlV20o9eripLzTh
         X/qBWZTXQvc6zSDs9/BriPPgzCRIPr+zQyLTBQrvZNihbN41s0moC1gT5LcW/5hySVWC
         fTTZ6gJOoo0+W6BD3DyJiJ2jWkf1Ekcow+Xk4qMeiBfZ/yFmhCme68XFhSU+r5Pv2xr/
         NCYQ==
X-Gm-Message-State: AOJu0Yw5DaAbIxTNjGFumg+7AnWEOGy/+2P/1bA/VpjZ2IlKQKGmqm2G
	TbxrtvKYzLUySjCLngL6DypTZQ3ZaSFRvUBzvFi78BIQ2YtzjbqwBdryte3SbQ4=
X-Google-Smtp-Source: AGHT+IEuKbF7eBlriHKPLcwyu5r6eScSFaoKyMjxw2EWKwCxQk1uz0UMi4uXx8ofme0Ll3/2mFimkQ==
X-Received: by 2002:a05:6512:31ce:b0:511:619b:7257 with SMTP id j14-20020a05651231ce00b00511619b7257mr3066369lfe.53.1707297210825;
        Wed, 07 Feb 2024 01:13:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1h55aFk4ssgTouARzpzOg8iRxKm8VcexMbk+pLi1qK7rx1tOgj4fNft8e5da46EZzV1Uvf5kXOTYY9B4XRhnM9Esc4NYJ/uJjaTcXpgrLQTiNGtwKq/oJAC/H4qqwPYNShN4fRv4Nmsqszbm+Ny+el+oX75fmR4oFqYvhQSJkxZ5BEpYGS07GnJPvBDtsEtXlVxH7Yqg8txxQ8A1NMWkyZ8XClfrk1La+R1bMUCLPN9hlbAKvsqiTNL/GnUPwOwEcKAs8kGXaFpp2e9u2r7YZImnZ0To9MMhFUcIuWVhFFF465lm014+Hd2/P+IzVNBL13cqrw1oHAvfK4U2VdbDOSYLQQBqiItVB5oSoAmL9HevxT8yu/FMhK5AAt/vrhDvnqtUpwYAfVyiZuJvAAfYG4MI/lqgSllmXOGNwIIg6EMqcYBQQgL7KUJ5hrmtUdwkAR/y3rzsuBPids6LyUqKYqHQOT7tUH6WVd2er09ol7sZLsHkbfj/a0GUtYCE2aMl/PCC7DZqLmzrC/G2BicoeNKJSFoR1z9IIIjKgzJxuTdFA+CvBNIOvdLCHNjvQQU9A5w+82UeLMDkyOu8KPS6UR+HGWTsEkDHzq+1kynIlBJTvrR/t0tRwHq54R3jXDuvxjGOzQec/w9YkxtfPOhLPARonyiBgD31uhNQXymwh/bSH5oXP6eoz6JWVh6Lvb6pyKSMgK4cHtER3yMiqdtV7uLIXs93iJEclefaJ2VJe0p+qSjZpwjtcl9nR7y0=
Received: from ?IPV6:2a01:e0a:982:cbb0:5ae7:7fdb:32ad:f6d7? ([2a01:e0a:982:cbb0:5ae7:7fdb:32ad:f6d7])
        by smtp.gmail.com with ESMTPSA id fc16-20020a05600c525000b0040feb8c71a0sm3809215wmb.13.2024.02.07.01.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 01:13:30 -0800 (PST)
Message-ID: <b56d11ce-869f-4183-bb26-f0261af356a6@linaro.org>
Date: Wed, 7 Feb 2024 10:13:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: imx8mp-hdmi-pvi: Fix build warnings
Content-Language: en-US, fr
To: Adam Ford <aford173@gmail.com>, dri-devel@lists.freedesktop.org
Cc: nathan@kernel.org, kernel test robot <lkp@intel.com>,
 Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Lucas Stach <l.stach@pengutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240207002305.618499-1-aford173@gmail.com>
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
In-Reply-To: <20240207002305.618499-1-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/02/2024 01:23, Adam Ford wrote:
> Two separate build warnings were reported.  One from an
> uninitialized variable, and the other from returning 0
> instead of NULL from a pointer.
> 
> Fixes: 059c53e877ca ("drm/bridge: imx: add driver for HDMI TX Parallel Video Interface")
> Reported-by: nathan@kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402062134.a6CqAt3s-lkp@intel.com/
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
> index a76b7669fe8a..f2a09c879e3d 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
> @@ -57,7 +57,7 @@ static void imx8mp_hdmi_pvi_bridge_enable(struct drm_bridge *bridge,
>   	const struct drm_display_mode *mode;
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_connector *connector;
> -	u32 bus_flags, val;
> +	u32 bus_flags = 0, val;
>   
>   	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
>   	conn_state = drm_atomic_get_new_connector_state(state, connector);
> @@ -110,7 +110,7 @@ imx8mp_hdmi_pvi_bridge_get_input_bus_fmts(struct drm_bridge *bridge,
>   	struct drm_bridge_state *next_state;
>   
>   	if (!next_bridge->funcs->atomic_get_input_bus_fmts)
> -		return 0;
> +		return NULL;
>   
>   	next_state = drm_atomic_get_new_bridge_state(crtc_state->state,
>   						     next_bridge);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

