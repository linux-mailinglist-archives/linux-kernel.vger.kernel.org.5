Return-Path: <linux-kernel+bounces-70945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC34859E87
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC93F1F2188D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5BD2135A;
	Mon, 19 Feb 2024 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YsqmKXjS"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D93208B9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708331906; cv=none; b=OudBg7ek/pzmgEjgu+pikbFnTSaOZ4SNISckPp7nfrrl2wkZ/I8N8+hhsEmz7bpxPmkq/HvXoigoKl2eXKUur8kYs6QncBO27d6Y8Xr+YxLaUrBLOMVlIsSCqJUcmgmHQ/UgAqcBpD0cOA/+p/6RXBfS+ENImfNWxfZlJFf06XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708331906; c=relaxed/simple;
	bh=83/qBAa+AVOwVygjaRfvYqOxBbxx4lJLiIyTY+Kdpl0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LC3FxDWdOSrxLAoPnfK9vo8VkiGEBUnhExBWmarPSxZNYfWAYKKotwg15oCchQb9SKYtuIKVTWSFTel5BPwYVVHwi6FN6jrjLlQzFFaV+u8grYeRrZ5anKIePoZmQZ0RPp/OR1brsmUfzvG4a2LBwadJpp2k/MAwfw1IluZjGUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YsqmKXjS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412641511beso5801055e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 00:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708331902; x=1708936702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/gqg7nuIRKFnzJZlko92QpBtCQ0yUQMkBiOuejqskw=;
        b=YsqmKXjSSGUJhAaUI2okBCVWDEqLMM4uFLGDXUjn2BihMXh+s705z6mQbT+ig08/SK
         gUVzmt6ISz51yeDKE1BN+5Op9n0UxHDKiOOH780tkumfKpfzDQNFGjUOP3ZMERFPz1xn
         8lgTByj0Gktpyj5YRis2I+pymBHn6sMvnjtpYl6JdAI1cwud+xXkBDEEmoZnbVy7bKQ4
         hc1h+fr+69+JJsqVphDOmvsSTCTdI6AJYPVtW6ptTmPh6vyWMD0Qz442lLMmtsBme5bJ
         jEuekf+Ay8H1/r12hmBBXEoVEuMkYmTBfxQmXKD1xBZjo/5ibaYQzKZ4jhd+NUF7fXOD
         q4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708331902; x=1708936702;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j/gqg7nuIRKFnzJZlko92QpBtCQ0yUQMkBiOuejqskw=;
        b=itAQLKGufzIHPjH1XbAHSbvDYVQi9dhjtDkV2dmgr7dKeHzc8m0dqf6DqyN/wa5ouI
         7AVecpgIau2zHBAIDvcX9xQ6+KQOpD8eIGr2QQWJ9PhMici+y+6nSH/DAt2nYCJOzZHf
         ZdTMK25pvovYJLPASr9rXoCudscw9g9SpqTxbv/AD2lbAtJr5RvzzVhA24US2zyKj7ka
         C1CbjgvNzGQPWNhAka3FY2f2o5R7LVWM2qZMKw6NTps7/4EHFfQsL+4FCOq67f/kv+V2
         2iaOXRMopBEpo2pICNXmhukflSee4h33L7s1egZ3yO5weXsV9mjl1F1e2sjhv965j3AL
         sEiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0MO/4LmK1oCO5WI021QLUEaAMjiHngjixGpfVWEHHAz78sdm/Xwt207tg4sHz8qH2BJPSnsN6ADGIXEzh6v9uYXDpH76eZnOtiUPY
X-Gm-Message-State: AOJu0YxyBI+GbUV3CKB8cG0eLYjM48OL6qSsPc6Gh9tOEYerSct9Fx8B
	dJDDTLCgtY53GK+xd9AeFT7qzLUUxBRlCyouZAQYuw9cXtmDn64BpBGP3aYJJYY=
X-Google-Smtp-Source: AGHT+IEmvmfGnvNyZqQ5o1pPesUs/3Yee3WGXYqu8K0vph/uPsQUfTBZt6lBufosP4qiB2mUH+FyUw==
X-Received: by 2002:a05:600c:4a29:b0:412:f24:5732 with SMTP id c41-20020a05600c4a2900b004120f245732mr9022333wmp.37.1708331902490;
        Mon, 19 Feb 2024 00:38:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f? ([2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f])
        by smtp.gmail.com with ESMTPSA id g19-20020a7bc4d3000000b004126101915esm4868608wmk.4.2024.02.19.00.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 00:38:22 -0800 (PST)
Message-ID: <f2cde221-a779-486a-9073-44228c320d8a@linaro.org>
Date: Mon, 19 Feb 2024 09:38:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/meson: Don't remove bridges which are created by
 other drivers
Content-Language: en-US, fr
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 khilman@baylibre.com, jbrunet@baylibre.com, adrian.larumbe@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Steve Morvai <stevemorvai@hotmail.com>
References: <20240215220442.1343152-1-martin.blumenstingl@googlemail.com>
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
In-Reply-To: <20240215220442.1343152-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/02/2024 23:04, Martin Blumenstingl wrote:
> Stop calling drm_bridge_remove() for bridges allocated/managed by other
> drivers in the remove paths of meson_encoder_{cvbs,dsi,hdmi}.
> drm_bridge_remove() unregisters the bridge so it cannot be used
> anymore. Doing so for bridges we don't own can lead to the video
> pipeline not being able to come up after -EPROBE_DEFER of the VPU
> because we're unregistering a bridge that's managed by another driver.
> The other driver doesn't know that we have unregistered it's bridge
> and on subsequent .probe() we're not able to find those bridges anymore
> (since nobody re-creates them).
> 
> This fixes probe errors on Meson8b boards with the CVBS outputs enabled.
> 
> Fixes: 09847723c12f ("drm/meson: remove drm bridges at aggregate driver unbind time")
> Fixes: 42dcf15f901c ("drm/meson: add DSI encoder")
> Cc: stable@vger.kernel.org
> Reported-by: Steve Morvai <stevemorvai@hotmail.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> This issue was reported by Steve off-list to me (thanks again for your
> patience and sorry it took so long)!
> The Meson8b VPU driver is not upstream, but the problematic code is.
> Meaning: This issue can also appear on SoCs which are supported
> upstream if the meson DRM driver probe has to be re-tried (with
> -EPROBE_DEFER). That's why I chose to Cc the stable list.
> 
> 
>   drivers/gpu/drm/meson/meson_encoder_cvbs.c | 1 -
>   drivers/gpu/drm/meson/meson_encoder_dsi.c  | 1 -
>   drivers/gpu/drm/meson/meson_encoder_hdmi.c | 1 -
>   3 files changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_encoder_cvbs.c b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
> index 3f73b211fa8e..3407450435e2 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_cvbs.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
> @@ -294,6 +294,5 @@ void meson_encoder_cvbs_remove(struct meson_drm *priv)
>   	if (priv->encoders[MESON_ENC_CVBS]) {
>   		meson_encoder_cvbs = priv->encoders[MESON_ENC_CVBS];
>   		drm_bridge_remove(&meson_encoder_cvbs->bridge);
> -		drm_bridge_remove(meson_encoder_cvbs->next_bridge);
>   	}
>   }
> diff --git a/drivers/gpu/drm/meson/meson_encoder_dsi.c b/drivers/gpu/drm/meson/meson_encoder_dsi.c
> index 3f93c70488ca..311b91630fbe 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_dsi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_dsi.c
> @@ -168,6 +168,5 @@ void meson_encoder_dsi_remove(struct meson_drm *priv)
>   	if (priv->encoders[MESON_ENC_DSI]) {
>   		meson_encoder_dsi = priv->encoders[MESON_ENC_DSI];
>   		drm_bridge_remove(&meson_encoder_dsi->bridge);
> -		drm_bridge_remove(meson_encoder_dsi->next_bridge);
>   	}
>   }
> diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> index 25ea76558690..c4686568c9ca 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> @@ -474,6 +474,5 @@ void meson_encoder_hdmi_remove(struct meson_drm *priv)
>   	if (priv->encoders[MESON_ENC_HDMI]) {
>   		meson_encoder_hdmi = priv->encoders[MESON_ENC_HDMI];
>   		drm_bridge_remove(&meson_encoder_hdmi->bridge);
> -		drm_bridge_remove(meson_encoder_hdmi->next_bridge);
>   	}
>   }

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks a lot for the patch!

Neil

