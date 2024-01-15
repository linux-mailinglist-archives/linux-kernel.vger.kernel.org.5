Return-Path: <linux-kernel+bounces-25743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F39F582D536
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A287281A65
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1418B23A7;
	Mon, 15 Jan 2024 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D1mUXrTz"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBA8748F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e80046275so270515e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 00:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705308214; x=1705913014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7trEMMexp/L0cRP5nniRYAU6VEcRUVKr6Xlvoj7OOQ=;
        b=D1mUXrTznnAT3I+8WnSLMfUyx1LE06Z95H/i1gzzQYNZ34fcEjVHbu0Muig0NOlbl3
         MNLC6Ons+17FepZpsCBl+qFhBXQ9rOvtsw0Y7qR39jXAKwvsNLfJr6ycT5axJmA/tWvU
         vCSahCw6p87lRwsCCh+tFOGEAeC43NDaWS2eNDJSLVs50mTX7v/teKgxyUhX0yAV50B4
         WHzyawQCfxKWRmk5CcEGDR7YmWPJQfQ2xJo655v0olO8ELVglEN0fwxYHo+t6ZOxLVBj
         zqo3BJ6sAsu9NdDu12D5nEs8zkxzdCbYTYqisP1YqzBfoYwOyLFWZywppWLe5E/vmTPV
         yJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705308214; x=1705913014;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v7trEMMexp/L0cRP5nniRYAU6VEcRUVKr6Xlvoj7OOQ=;
        b=Jh+oyX6M1dmSYB4VRwHOYhk+uh/PHuF6VDx55TrIj+olGQBVQJ2F7+BHL81ppbAHsZ
         2EpiqiTwmch1i+NrF3VyjpHRz64sMkv9IsR+cVHRzGZp5eWb+RWfWXNPR9GAEqEMQEVM
         vSfEsf19FTU3EXivuIHtpPCB9DY/KvqAVT5j+kzgKdp+bYU5XKyxBooZRJtUzdn2CAEA
         q4PJFn4jhbaF1qMuKiPR7cN9AA4IB5hLweRQo11xbDxDS9+QKN0rGPEsmKMoEgKa2uiS
         OGRcUOhH6g1ZoalTALVqw55M9G+LQH+LT6GFG+6bTaD58R2MRZltbPjnJS7XktXVopSf
         NBnw==
X-Gm-Message-State: AOJu0Yw6Ujq3kUYKhy32V8OtiWbv2KayvmC3gj41vu7ek1CWerq29Oex
	twbUuU3zeKnxkKYhXsJ3DIgpWJSw2N0NBg==
X-Google-Smtp-Source: AGHT+IH3YQraSdCl5E7fmni/nnmbQn6D7xvQbHJ4xwymZ9rctQpsSlaYCsbqYXIp3W6UjPUKaCNQtg==
X-Received: by 2002:a05:600c:314b:b0:40e:6ee6:6fb with SMTP id h11-20020a05600c314b00b0040e6ee606fbmr1864869wmo.120.1705308213780;
        Mon, 15 Jan 2024 00:43:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:af6f:bcbb:3c88:33c2? ([2a01:e0a:982:cbb0:af6f:bcbb:3c88:33c2])
        by smtp.gmail.com with ESMTPSA id m26-20020a7bca5a000000b0040e54381a85sm14669897wml.26.2024.01.15.00.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 00:43:33 -0800 (PST)
Message-ID: <b1da07f9-7e15-4d83-bef3-d0ce157654bc@linaro.org>
Date: Mon, 15 Jan 2024 09:43:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: Select DRM_KMS_HELPER for DRM_PANEL_BRIDGE
Content-Language: en-US, fr
To: Luca Weiss <luca.weiss@fairphone.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240111-drm-panel-bridge-fixup-v1-1-e06292f6f500@fairphone.com>
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
In-Reply-To: <20240111-drm-panel-bridge-fixup-v1-1-e06292f6f500@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Luca,

On 11/01/2024 13:38, Luca Weiss wrote:
> Since the kconfig symbol of DRM_PANEL_BRIDGE is only adding
> bridge/panel.o to drm_kms_helper object, we need to select
> DRM_KMS_HELPER to make sure the file is actually getting built.
> 
> Otherwise with certain defconfigs e.g. devm_drm_of_get_bridge will not
> be properly available:
> 
>    aarch64-linux-gnu-ld: drivers/phy/qualcomm/phy-qcom-qmp-combo.o: in function `qmp_combo_bridge_attach':
>    drivers/phy/qualcomm/phy-qcom-qmp-combo.c:3204:(.text+0x8f4): undefined reference to `devm_drm_of_get_bridge'
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> I can see "depends on DRM_KMS_HELPER" was removed with commit
> 3c3384050d68 ("drm: Don't make DRM_PANEL_BRIDGE dependent on DRM_KMS_HELPERS")
> 
> I'm not too familiar with Kconfig but it feels more correct if
> PHY_QCOM_QMP_COMBO selects DRM_PANEL_BRIDGE that that's enough; and it
> doesn't also has to explicitly select DRM_KMS_HELPER because of how the
> objects are built in the Makefile.
> 
> Alternatively solution to this patch could be adjusting this line in
> include/drm/drm_bridge.h:
> 
>    -#if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL_BRIDGE)
>    +#if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL_BRIDGE) && defined(CONFIG_DRM_KMS_HELPER)
>     struct drm_bridge *devm_drm_of_get_bridge(struct device *dev, struct device_node *node,
>                                              u32 port, u32 endpoint);
> 
> .. and then selecting DRM_KMS_HELPER for PHY_QCOM_QMP_COMBO.
> 
> But I think the solution in this patch is better. Let me know what you
> think.

I think this is no more the case after on linux-next:
35921910bbd0 phy: qcom: qmp-combo: switch to DRM_AUX_BRIDGE

But could you still check ?

Neil

> ---
>   drivers/gpu/drm/bridge/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index ac9ec5073619..ae782b427829 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -8,6 +8,7 @@ config DRM_BRIDGE
>   config DRM_PANEL_BRIDGE
>   	def_bool y
>   	depends on DRM_BRIDGE
> +	select DRM_KMS_HELPER
>   	select DRM_PANEL
>   	help
>   	  DRM bridge wrapper of DRM panels
> 
> ---
> base-commit: b9c3a1fa6fb324e691a03cf124b79f4842e65d76
> change-id: 20240111-drm-panel-bridge-fixup-5c2977fb969f
> 
> Best regards,


