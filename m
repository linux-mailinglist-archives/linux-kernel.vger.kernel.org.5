Return-Path: <linux-kernel+bounces-51118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF6C8486BD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28424B248F7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870665F47F;
	Sat,  3 Feb 2024 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YcbxswS4"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF75D5EE9C
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706971214; cv=none; b=m/payOZm1inGUhAEWzD0II37XdVvfCh0j8SJ7etalgM9WMbGVD8Yzv9IgRMMEi9QlHYMaIZoEs8k5GuyA+Qpp1pHKga8yO9tauuxVoucSx1+z5PdgosA0Hd/0QkCHyNL3XFBhY1ry29MkoDsrQbC+ZYOBzGfUhGUS6fOb3MC4b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706971214; c=relaxed/simple;
	bh=q1QZORWoeF3hG4BvBSs3h+Zls/mAAlnOwYoixsds5Og=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=m/Qn4kHtAFcrzQHiJGrKLJGi85aKhewD/06Rvg2UD7Eo+QkhZYaLo5z3CHBPo3Nz8kYpAXkJqN8OrvHR+3vuL/A9ZOaq+9WT9a2FumWt56d5ITcPLrKj0ScP5vjyWdtKcukjtrNHoETZ6agkrMS9h/nnUewFcytof6Ly3OhxL4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YcbxswS4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fc654a56dso13746725e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 06:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706971211; x=1707576011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1khyXsl2uQ49TZZlX5GEuEsN6onRhf1Nq/aqOzPdR8=;
        b=YcbxswS4H4UCIVTyvCkAXAn3wIU4zPIx5LtiWiAnCXYxACkDRlW14YvkmUAqIQR55g
         CjuF/cimnpxE1A7L0cLcPMz1fOIEkPFwJadVjldOoU41BRBiEO4zeYznbJYqRT0dc/fl
         ziMnknFHLnbzXY0WxoXUG9AO4W86sq/2H8dKTdSJXJ/A8HfcB2F8cemkD0jUiNY48b5X
         TFcN9ipc3zPYGwLN6usqAjerxirfaDi90+TFykMRt83fWoPaDFQLfbzZ4+HFSf0S0BzO
         gzqdtTaz1D0Oe16IkhKSvIe6rLMsiiJrp0gfKtQqZPPgT1oDIroFk1H0stxK1o1ECksD
         SgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706971211; x=1707576011;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h1khyXsl2uQ49TZZlX5GEuEsN6onRhf1Nq/aqOzPdR8=;
        b=gr4odgSCtW6wWGCSrHdB11esI31NFlnGshM4L6gKYceQaKBnW7hxxpSwVke+Jp68n2
         fwgbkFXhw5aIjiblnUpITpXBR7wAy4qyRcKItCilqSixpidvEBDTSNXCvN+ES2ZzvRq2
         WT5oSac90wVdB0PsAFyPXplbdLMMYPqGMwdr90aSPKBrizQq4l9pubVQS0ctuHeBE7nB
         snqv0hVGIOSNBpJ+T2Fep6UvzJeY8d+tAHnXD4q1TZhuj7FyIIvF4v2cuVm8KuJnt1XQ
         YgsnpEewRHSmod4cieOx3KoQhTAs8RMnVLfwLpmqVTaqF+k/gbVuw2fYOtJWXR5bZTCT
         E9hg==
X-Gm-Message-State: AOJu0YzIbdRTg88X8kuiYEkaEyoL7fUJ21TVm8WUYohkjhfQonafJDAO
	88GG4oD6Yt4saMnE7yfgyWdKsNKl5GTuH+1WLHM/NPhVYkhE4YTx+p1rqGdz7tMc9Dd4uyuawhU
	zU2+6HA==
X-Google-Smtp-Source: AGHT+IHucqBcbd7A6063P89orNXrIPGag7RoLfpbjPD9TY5rWT1EfDXZtJKNfg0qA2jLSUSQGTk1hQ==
X-Received: by 2002:adf:a356:0:b0:33b:17e0:6715 with SMTP id d22-20020adfa356000000b0033b17e06715mr2588485wrb.3.1706971210955;
        Sat, 03 Feb 2024 06:40:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUMNVG1WycuTAj8wRGLZn7wbOvvXpe4wN+VM2kUHIUnDnE3/4gqkOECkS+gYOILh2kb/WDBQCGP/rI9ABnf4wcdLylJfQfml3+PTBKUmttLiMC7IzQOSfJaqYvCzXNdET56BVpnFz+NHyANa5NhwLL3IfEdeWqeknyf1lQNYTIcAr1a5IiCN9DBftduFXUJSYKXgrYVRHGYMb/Q6nvSbTIbSwsq+e45Ied6lQy/7FcFTabp++6J6V6Q57SO1rQf0+EdvlI5JAKsVmOIKxWR9VE2g5bi/Js8UKzXfz6476TBjP/vPduBLkzH4T+2ErtvQA==
Received: from ?IPV6:2001:67c:1810:f055:5044:617a:60fb:ed01? ([2001:67c:1810:f055:5044:617a:60fb:ed01])
        by smtp.gmail.com with ESMTPSA id x16-20020adff0d0000000b0033b1ab837e1sm4181260wro.71.2024.02.03.06.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 06:40:10 -0800 (PST)
Message-ID: <a3169686-31a4-4029-bc74-6c38b77680a3@linaro.org>
Date: Sat, 3 Feb 2024 15:40:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: visionox-r66451: Set prepare_prev_first flag
To: Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg
 <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: quic_abhinavk@quicinc.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240202-visionox-r66451-prev-first-v1-1-c267dc889284@quicinc.com>
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
Organization: Linaro Developer Services
In-Reply-To: <20240202-visionox-r66451-prev-first-v1-1-c267dc889284@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/02/2024 22:50, Jessica Zhang wrote:
> The DSI host needs to be enabled for the panel to be initialized in
> prepare(). Ensure this happens by setting prepare_prev_first.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>   drivers/gpu/drm/panel/panel-visionox-r66451.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-visionox-r66451.c b/drivers/gpu/drm/panel/panel-visionox-r66451.c
> index fbb73464de332..493f2a6076f8d 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-r66451.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-r66451.c
> @@ -322,6 +322,7 @@ static int visionox_r66451_probe(struct mipi_dsi_device *dsi)
>   	dsi->lanes = 4;
>   	dsi->format = MIPI_DSI_FMT_RGB888;
>   	dsi->mode_flags = MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS;
> +	ctx->panel.prepare_prev_first = true;
>   
>   	drm_panel_init(&ctx->panel, dev, &visionox_r66451_funcs, DRM_MODE_CONNECTOR_DSI);
>   	ctx->panel.backlight = visionox_r66451_create_backlight(dsi);
> 
> ---
> base-commit: 51b70ff55ed88edd19b080a524063446bcc34b62
> change-id: 20230717-visionox-r66451-prev-first-67b036160e32
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

