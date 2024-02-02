Return-Path: <linux-kernel+bounces-50610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C460847B8F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73CDD1F2A899
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D767983A10;
	Fri,  2 Feb 2024 21:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JiL6gOVa"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C8E839E5
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706909535; cv=none; b=UFertq7LmsNfRTy5E4wHEGw6Aa1Nx/ShTUURvklbiAGGWeCBnU/pP3mCpTOLNCP40zeI5PFoiD14tfYYfzwc7JIi3NjleNhk68miBszoM3IfU22AMsqKBoSGZHYlHZBnxMQjem2/U1zMOR6IgTGEl1L1HJSR5/PmeXcISbG2HbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706909535; c=relaxed/simple;
	bh=mGhUNxZMsWaoiJyj9PRjL1hNx8uB6yny+9h5RYXXVNc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QvpchIj4aBVtQ5YA7OQ1xuMoffPVAqiwYarZ5SkfvrtviGYzryqz9+aaYc2GwQcD5RNd4Pqy2C843QQxNtJprZayxs4+lSZbRSXj6+MjxuQP+spLHpK4/m+efvgAFr1EstiJ2GGA+vz/rVyrYdbJFvCd2TgqYp6FBePHuzpnI7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JiL6gOVa; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fb63c40c0so21797445e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 13:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706909531; x=1707514331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5Hc9mSNGHRmqMuX3vLv6BjyMkdxw/6pVnK77OZ+Opw=;
        b=JiL6gOVaALg26POSKiYizB0tEBx7NGFDpowE20wur2ACWY9QJRNsKpG+ntef5FOfuH
         tOOMJg3NFu+m4O28fAz/HrskzBnOKnoivtDFeBChram+o2n2SJdY69eFE8Cm1WWGB1E2
         1FAzoSv45h1g7+/hOp733KMnRxh6e4EEJZlPfE/r6L3Yq+NyR7W423CcwoY3IuUu7IQE
         8IQlkAIcMSquwy/+qxxAhxj+ZkPtSsKmXoUx3hDxfYMSchuU4REt/bM5X0/RBvvLRnhH
         lr7VMWinCpTBcU30n7F1P18paXTQtDwZl/4NPZj9+7kvEoXRhm6tG1/bBgmxdvHiaZyE
         ETPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706909531; x=1707514331;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W5Hc9mSNGHRmqMuX3vLv6BjyMkdxw/6pVnK77OZ+Opw=;
        b=Yc+FnWxNZf2eYoiPRBAlGeXRR3xlg7Gpn/WTVzXWcH8gTJW/fq/CrNJLZ4Nmsq6NnS
         Bl4P0BBCZDlmPclKNiCDrTFiv5iP8nq8ndWZEzGzEccvOfkY7L4z/Sy54E8EZO+rWIcO
         q+pTccpZTC9qu8XPQd0iLWfzwWxvQu16Q5BoYUzzMXqxcflLx4M7AGgMCTRbdqxiP5LD
         57SlxmTCuUeLWPNAr0bJvKKg4hoBqz4DPIfBH9cfrdkrv/bbx6H90oFKEmSJ16rcdlWX
         h8QkLu0dVrYgmY2jaqGWrHwmq9pbjB4wk63SFaulLcieNa3GfY+nnN6s9lB7ug9GFf0h
         IIuA==
X-Gm-Message-State: AOJu0YwIt6ClXUVltt6naJFC4yQWCxsl2jB6nI004TqbHeuS6q5K4JEL
	QKvU2uUw+3fr5qaHI3ci/mjCYC0BgGoJzSuiXc99e2IUScir36I1CV7bpytSaH+vBCfJ4r498qj
	ZJ7y4UBaE
X-Google-Smtp-Source: AGHT+IGyPixWYoi+L4/ukaGBHlcrE3M3qeKjP8naEQzcqadDPDsfbwSTPYGe0HluOek3vr3B35Am3w==
X-Received: by 2002:a05:600c:1550:b0:40e:fb8f:76b2 with SMTP id f16-20020a05600c155000b0040efb8f76b2mr7592084wmg.12.1706909531281;
        Fri, 02 Feb 2024 13:32:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVcz30ZwoH/5xCYeuEkyULtPjnugcNsrZooblZ7+o777yvjaEWQrcqbShcYM4dWmclsHEVB/1TNGAGbLTGQCCQX6Oz67KeLrqoMYb+dE37zKDXBA99J6ReiSRhz/Zhx27tbSpG5cCbraq3CbZ1ixBa7OrNl+p4VLRcJrmGHiD+qRbnOOU5ugn6RY/9JVf4M2TD3KZhWDNUIByvv7JwneXD2fYnSC4t1RxEGFgx2lEfu1Jg6xKiz6FGtZjYTLpMMzwFxzTrg9EN6kRNJ+JLUft1+Cd7E5w+OEXMl0x1J5xdofOSF3y5JTfj4Af6TMGe1JDafwvpEx1Ye+0OGQwZxmaxeAqzYxoiVI0AZD9MxAMtPvMaIUk6BJmrliqUv6Afqc5v0hBRGXxHtB7UqAQzmG2OmJnmMkK2UWRxBakzsOx1lqMOu01kDQSNGYd5IfbEH4s9obOyc7VP/6hz+HwqLNiMqjqdueeeG1XnKHEGhaSJzeh8xWY9WNRM0CyjBJQnSAtqIlONjlBbX4w7yVOGAbXV8FRLFH5pUBXUK5Us6xZv0nXCMFTpyzKkpryKTVIX8/i9ucNWekWlsh1oeczrLOcRf3dJqktVGTJtV4KXAGrXiyk+kUe2COFPTQ00Y6qn1N8rpCDEvS8qJewZqPNp7bVkRS9TmVApJrOwh
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c314600b0040fb7695620sm1020943wmo.0.2024.02.02.13.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 13:32:10 -0800 (PST)
Message-ID: <b8a5e5dd-e018-4305-9fb8-88f4ddc49a2f@linaro.org>
Date: Fri, 2 Feb 2024 22:32:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: drm/bridge: ti-sn65dsi86: Fix bouncing
 @codeaurora address
Content-Language: en-US, fr
To: Jeffrey Hugo <quic_jhugo@quicinc.com>, dianders@chromium.org,
 andrzej.hajda@intel.com, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 quic_bjorande@quicinc.com
Cc: airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240202202329.4172917-1-quic_jhugo@quicinc.com>
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
In-Reply-To: <20240202202329.4172917-1-quic_jhugo@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/02/2024 21:23, Jeffrey Hugo wrote:
> The servers for the @codeaurora domain are long retired and any messages
> sent there bounce.  Sandeep Panda's email address is no longer valid and
> should be repleaced.  However Sandeep has left the company and has not
> been active sice, therefore it looks like this binding is orphaned.
> 
> Doug is listed as the reviewer for this file in MAINTAINERS and has
> volunteered to be listed within the file as the binding maintainer.
> Therefore replace Sandeep with Doug to make the documentation current.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>   .../devicetree/bindings/display/bridge/ti,sn65dsi86.yaml        | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> index 6ec6d287bff4..c93878b6d718 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: SN65DSI86 DSI to eDP bridge chip
>   
>   maintainers:
> -  - Sandeep Panda <spanda@codeaurora.org>
> +  - Douglas Anderson <dianders@chromium.org>
>   
>   description: |
>     The Texas Instruments SN65DSI86 bridge takes MIPI DSI in and outputs eDP.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

