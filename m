Return-Path: <linux-kernel+bounces-70978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C67859EEA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E83B1C2230C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B5D22309;
	Mon, 19 Feb 2024 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sYH/CvFo"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE2B210E1
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333041; cv=none; b=JWbaRZx6ZuiP7jBzM+HkF8ubKGVh185VLfxnikluYwCye04aHZ4QNrYtkyaFR07p3dI6T+uMinBuzPtMpjmhTAMa4Tne2Yp2dKXgAvt+nNf6GdZqi07asNG7Ww0aidFJlrC5MmODcVdFjV7vJ2rJWLcff4gE6AO6G3TwosbOAYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333041; c=relaxed/simple;
	bh=oK8Ag+BqpmG2+YX++BF5p+1USUfncFQSIRT7uOTT5iA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rhTuTBAMnzkmmb3Gdl6kbv4OHCjEvz70uQGtFsnZPKIJ7pK9oc3+WLQEBJbWu285HnZv2n3yXqkTtZe6QehIdCJfgi00b7dXHPXFsViYX26TGYhm3ZODWF7VySj76xJmvwj027iJOENp6knQXiAjJjbo+MtH82we7BXeqQcYpFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sYH/CvFo; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d60acfa73so66734f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 00:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708333038; x=1708937838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7lAmgkPoXnpcJ5zQ5qMfiH0XSmlzTeVMWt+gcyguuI=;
        b=sYH/CvFo4TJuR1UhNqCedVZkdeQroTvC0DHPb4CPP+5DRZArMZT0jVRBb6DRPxyA0t
         yEVzaCtRntFg44C9itCt80LLCvtWdNVoXajyMz4r522v4Sz0iYvZkNeLyEY3j7LQ8PQN
         WxNYWSducDM4TcKn7zGgjPO/uZtZ5Acs/biECQxfSwqmj41S9TvOxKJPbGbntBkUp8UK
         WB3o6T479B6gKSKxT822MKIfnu/sC6Lb7JAedQMsrGjiYMQj8UA3I4mX6bydrlDiAEfq
         50pH7p1pynBCP8ND0x1cEcBZOACPyauHFmKnDAhKt951KxBH463JyEu2uCWupp2vl3CZ
         mBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708333038; x=1708937838;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d7lAmgkPoXnpcJ5zQ5qMfiH0XSmlzTeVMWt+gcyguuI=;
        b=HdV+1MhUUmybYcB3lgq7egS16ZSXmWTocl++tnhXJnqph393dabilCYoD5c1h7b+/p
         ZDp3JYew/EMqUUOufUetYYNt3t285F2IeZesdWCvX8MwrNcMVFpty2BKRR21WrVCFkfn
         nuGBTCi4XGZTapzCin1INo/L8rbPs0Zv6lNGQO4mV0Itk5i4Ps2OdWIQN9N3I6rIA0IJ
         j3myQ53IST3PiUdXQtUd4b+ZGrn3MJbh5b0c8EdrX16R0DyKsBZ+Ciu/rrEHaFiiNi6t
         jUAANFy87vTZygMU6fmqGdlwn5qwUCseBh6QIJp0yCrxkFfI0x1+Nqi0C7l8m3NAx0hb
         wktQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5HbuWq9FGjrwVeOn9T027v16w7NKw8k6dGd3S82Yo85xRymgeDc2Rbq+wr/GpbilGtrLijM2JcDLRG5aA9fTnmCRArNj4Yj86PKwq
X-Gm-Message-State: AOJu0Yx2qeUrculiPj1yhbWcYGr+ET7Hke6c+Oy1eoF3TIgE8KyHyeP5
	WbQl8QzgPqYByxnY+6ld/XTLfmvHsRzZyaqwfnZxabtzLdY4GLsZYKTKQzW9PM0=
X-Google-Smtp-Source: AGHT+IFjwnAVE3i22jizH6cf+EZMkRN74eAM9n33X9mePHh0I+wiD4NlU4a/GVdZvBXYmPAR76vkEw==
X-Received: by 2002:a5d:64ab:0:b0:33d:5285:581e with SMTP id m11-20020a5d64ab000000b0033d5285581emr1446476wrp.28.1708333037813;
        Mon, 19 Feb 2024 00:57:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f? ([2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d51c1000000b0033b1c321070sm9662213wrv.31.2024.02.19.00.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 00:57:17 -0800 (PST)
Message-ID: <83e153f6-4e48-4126-99bf-e8daf4f69b9c@linaro.org>
Date: Mon, 19 Feb 2024 09:57:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: defconfig: build ath12k as a module
Content-Language: en-US, fr
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bjorn Andersson <quic_bjorande@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240219084610.11007-1-brgl@bgdev.pl>
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
In-Reply-To: <20240219084610.11007-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/02/2024 09:46, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Qualcomm sm8550-qrd and sm8650-qrd boards have ath12k modules as part of
> their on-board WCN7850 WLAN/BT packages. Enable the relevant driver in
> defconfig.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 056a6cc546a4..3f3d3350cf90 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -408,6 +408,7 @@ CONFIG_WCN36XX=m
>   CONFIG_ATH11K=m
>   CONFIG_ATH11K_AHB=m
>   CONFIG_ATH11K_PCI=m
> +CONFIG_ATH12K=m
>   CONFIG_BRCMFMAC=m
>   CONFIG_MWIFIEX=m
>   CONFIG_MWIFIEX_SDIO=m

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

