Return-Path: <linux-kernel+bounces-156428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 976F98B02AF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486D21F22520
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894AB157A5A;
	Wed, 24 Apr 2024 06:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yfefzyy+"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFBE157A58
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941687; cv=none; b=VANpqtdUqkekBs0urVDCP3CQrWIO6TUBhhBED6gpHbBYmEG/ORpx2CyvKsd8tIfWLS6Xef7ObVtDRFD9tTYTH73z2juoez0FM+ozcMgnuxJL1T7FCxo/GZ9lD89L1HqmfEJ83Q+iWp45dA3LWPOUvXSTGRTNTbGoxWa9V0vwbGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941687; c=relaxed/simple;
	bh=Htpj673Hpy57DaifV2ero4o9X8d4/6knlPlOrZjhPyU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=m5mRAZ7LrJMvU1RWqzVqHFFdoSCncZpsRgdhzSfqXeIzVKTSFW8ESoNM6m6aAqaCUna++yymBv2caWW/n/vDAdXPxYVxON/cRUrX4pVMsRAdCoWtFT7lXMgwRhUeoNJU2ibhqak5gW26dCQWCujot8v+v7isWdd+1KcjgQ8hBcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yfefzyy+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41af6701768so3992215e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713941684; x=1714546484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8bRCgW5T5C1zJ8E17b4jWTOUyWD7CH0mT1aVxTkcyF0=;
        b=Yfefzyy+TG+J2CvFCzU6U6HxV3+zqDpF38SDUlUqjypdv6kSlR00DHYKQrB06KN3Cs
         7BjUNNi4LTis071+iQT4uSiXkh7p+8Esq0GNmvFlaxM7EVP3swKLC+UXBduUMqBVA/Wm
         bhPsENxB2GLihhahHULoHNo0YyBE5k4Bkh3ujjP/usSBikzlKpgK5xd7SNFMFrjWHp7O
         08jq0OaNtknFPDQTy3N+ien2w/eQ6JTf6uKOWumUoFAiUS9eBC3/0k0evnZvJLpNTP5+
         8wfBCmWYYgCvQ/gsJk2QRr1PZ+rQhjCTCeHajBcxcGVenxnV67LI9/+z/PoQjWOTl1xF
         5uRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713941684; x=1714546484;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8bRCgW5T5C1zJ8E17b4jWTOUyWD7CH0mT1aVxTkcyF0=;
        b=Nfifaji8zx450o4KDnDOvGDp0MXa/FU6/NcUGeFTBmqcU6RPnQQxU8nNofktP2m9da
         19/yo5cWVlx413uvZyLSy5yJ9BtjjYA7kDk6oBu3t7Ek28iS3Kyyp2nrEqcW3cNs4U+a
         xEiXp9bIi2aSvSjBFT3+rheSghX68Y7dKqmsDTPMKO5cI5+w97GTDjdneqN5+aDvcpuc
         sqlRW9G3oaNuWNG9RlcZfETJAYmDEQH99+u/W2MlLucUUHN3od0E3toa0Du7Lxg/KnRx
         WZ71FG4BPDHkz9QZe1xIrNP8pBfF8xiw5rcepvRMz2iyjsSkkmPI1Y1+8FjkMh5fQHzS
         Y6cw==
X-Forwarded-Encrypted: i=1; AJvYcCVIAcl6ldF+M9zoz/B0CwIG7GBdqjh2e62/ptt+t4nbABOjcjsv4xEnevYJULdUbFwTDZLwY+6F49myY3KhHo024Z7m4Q+6jgAeKcwJ
X-Gm-Message-State: AOJu0YwJoM/swIxoJTQNj0d/lBoIEjJ1RbKD6VT5SnRoHEpkySL0URoW
	cgoVXcMjC3rtCUhtlwkJeyK/weilFFe8cEnJcdiWdUL62M4KtkVfBP+Pem72yW8=
X-Google-Smtp-Source: AGHT+IEbswXmJDcA7EFPdf80BhUcAOFM/NRn/7lUivF6qZFsJoWShPkwWrvg7v9MpetcI3NV+PKGlQ==
X-Received: by 2002:adf:ee06:0:b0:347:9e5a:3070 with SMTP id y6-20020adfee06000000b003479e5a3070mr790943wrn.17.1713941684224;
        Tue, 23 Apr 2024 23:54:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ed3e:c90b:dd74:51a7? ([2a01:e0a:982:cbb0:ed3e:c90b:dd74:51a7])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4844000000b00349f098f4a6sm16235018wrs.53.2024.04.23.23.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 23:54:43 -0700 (PDT)
Message-ID: <d377e5c4-7716-4f4e-8fe4-472e3230eebe@linaro.org>
Date: Wed, 24 Apr 2024 08:54:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] drm/panel/lg-sw43408: depends on
 CONFIG_DRM_DISPLAY_DP_HELPER
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20240420-panel-sw43408-fix-v1-0-b282ff725242@linaro.org>
 <20240420-panel-sw43408-fix-v1-1-b282ff725242@linaro.org>
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
In-Reply-To: <20240420-panel-sw43408-fix-v1-1-b282ff725242@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/04/2024 04:41, Dmitry Baryshkov wrote:
> This panel driver uses DSC PPS functions and as such depends on the
> DRM_DISPLAY_DP_HELPER. Add missing dependency
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404200800.kYsRYyli-lkp@intel.com/

No Fixes ?

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/panel/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index ab67789e59a2..5e6692207beb 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -340,6 +340,7 @@ config DRM_PANEL_LG_SW43408
>   	depends on OF
>   	depends on DRM_MIPI_DSI
>   	depends on BACKLIGHT_CLASS_DEVICE
> +	depends on DRM_DISPLAY_DP_HELPER
>   	help
>   	  Say Y here if you want to enable support for LG sw43408 panel.
>   	  The panel has a 1080x2160@60Hz resolution and uses 24 bit RGB per
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

