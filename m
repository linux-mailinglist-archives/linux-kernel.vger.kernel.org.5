Return-Path: <linux-kernel+bounces-156407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DF48B0270
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602CF1C21B21
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0F115748D;
	Wed, 24 Apr 2024 06:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eW05LZYc"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22066142E67
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941482; cv=none; b=ifeoi247F3JgHXjzVgpbsLp0Hw7j3+qrakJ6lfoprhUDbMjs2lvzWQWjlpkdAuUsLTjS3zVTslMTYwqaQ0DrpztWwqmMPvwta6V0KfLDCwReYzJ29gx/6FGWwS1Qke9YM/BGp32gX2hEROwhzx0jaFZPwSwEpw3iBZBfzjfPkNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941482; c=relaxed/simple;
	bh=e0psFuTSMLyPViM4HdYZqYy5nRfKxWhGIfCp/5rtrcs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rEui5PDa34pgUSWr93VNOgcpeSO91XAJi80UV/bIgLKH5c0a01WXOdRo2jUy+JpZTpugdNdGog/t7UTYzsRRgUVa/xIdXZV+TTomMemb7gOZXHCFpyVcjryaEXtFEXoc/+c3FluUcrInivaFFkTwvy9URTQOg5ukjKxX3722YIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eW05LZYc; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34665dd7744so4965823f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713941479; x=1714546279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fhRPEnVPqfUJjDOhDV7MC9ZHHIfbOjexEAXqhIdO3Y=;
        b=eW05LZYcNtldcXAVRqLPSOCj/850J1s4xwxUt2idddY7m04LOtZ5yCm8/au09rICYU
         1x0oleFgNAg3145JQuSbAruFtqtUSYzWfBvtCHRVP3DWYf8F+BzK6Ldcqgt08nwY7TWV
         4L+D4QI0FTHve2z3YN1aTf4DbalzcW0NC1v8gZAcJneeaKvrPHDV9B60JERXdgSyM0Yr
         kgs+GAbpwjmv7gGbqZ3vJlUMImY7kjIJnQ0EKeFpmh4R7PC5CfJR8mcYwcZWxib7dAl0
         w8fanhMgYOOn7GYxyxBbOpJtTXWv0YMRhtZAeNlUWJA+g2E1rasVRK2+02FGl+67fGCR
         5Qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713941479; x=1714546279;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5fhRPEnVPqfUJjDOhDV7MC9ZHHIfbOjexEAXqhIdO3Y=;
        b=cLLY3vFLq8A0l6OTw1UFz8HOXceXnO1F473HKCvXHanXwRqDnu0uMpEG3DhlLvynwQ
         ktNpgPh/mfx5Ilb4j9qj4MC8Duv9GimqNNJyyXbkMaJZ8sR1Hx+Ft7GCQ9yPtNme/mjo
         fa8Fx4XTkFBqc0mAwrsbSIjyyrXg5bClnkiTI4f1I+LTW5uvkILZfmENwVRf9EgKooVl
         r1aK21xM0bfTNC6TWGcCoSAksWjjSLdJ6QovPZMtHndN84d2IrZAFzKclWxwOvPKp1R7
         8AQLhSY30eGj+IgrfSl/0VM1NI3sa7/+iyl5Qg6D5KEv4ldgp3IliM9a0CT4v0v1IyFu
         fu6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTSieTwYxYRksrxHdQf2/VfwuqBEO7V4a9tbeJcL5YuClmzJWjId2/HZjbMLv6IPnyeTf56jiF9s6APJL8JhFsHiZUlkRt2o/Vg5zX
X-Gm-Message-State: AOJu0YyGIk8Z+KN44iKfvH+QJY3IyR8dj5mLL80oVZBd4MH8YvXphqa7
	nYZZ8Ozu/xG0Mh/2M8s83vfjSVBhIuCAtw+ytKFRBc5baDls/BOrcNFMEOy5Bxg=
X-Google-Smtp-Source: AGHT+IER+PTkXrM2sYTgRDnw/H8j7tp/CT8JUDUe2TAwv1AXC+oqV7npD/LeU5lehsx1WtbbguW2Ag==
X-Received: by 2002:a5d:5243:0:b0:343:ba58:97c4 with SMTP id k3-20020a5d5243000000b00343ba5897c4mr800456wrc.10.1713941479305;
        Tue, 23 Apr 2024 23:51:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ed3e:c90b:dd74:51a7? ([2a01:e0a:982:cbb0:ed3e:c90b:dd74:51a7])
        by smtp.gmail.com with ESMTPSA id cs18-20020a056000089200b003437799a373sm16429555wrb.83.2024.04.23.23.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 23:51:18 -0700 (PDT)
Message-ID: <ec748d7c-b1cb-4ab3-88e6-b624b1f086de@linaro.org>
Date: Wed, 24 Apr 2024 08:51:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: jdi-fhd-r63452: make use of prepare_prev_first
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 y.oudjana@protonmail.com
References: <20240423-jdi-fix-v1-1-808970662b40@gmail.com>
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
In-Reply-To: <20240423-jdi-fix-v1-1-808970662b40@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/04/2024 22:54, Barnabás Czémán wrote:
> The DSI host must be enabled for the panel to be initialized in
> prepare(). Set the prepare_prev_first flag to guarantee this.
> 
> Signed-off-by: Barnabás Czémán <trabarni@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
> index 3e0a8e0d58a0..483dc88d16d8 100644
> --- a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
> +++ b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
> @@ -247,6 +247,7 @@ static int jdi_fhd_r63452_probe(struct mipi_dsi_device *dsi)
>   
>   	drm_panel_init(&ctx->panel, dev, &jdi_fhd_r63452_panel_funcs,
>   		       DRM_MODE_CONNECTOR_DSI);
> +	ctx->panel.prepare_prev_first = true;
>   
>   	ret = drm_panel_of_backlight(&ctx->panel);
>   	if (ret)
> 
> ---
> base-commit: a59668a9397e7245b26e9be85d23f242ff757ae8
> change-id: 20240423-jdi-fix-986a796a3101
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

