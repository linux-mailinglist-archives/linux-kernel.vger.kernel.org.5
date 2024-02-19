Return-Path: <linux-kernel+bounces-70989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DFA859F15
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A51C1C21B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C1B225CC;
	Mon, 19 Feb 2024 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dJvJw+MD"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4D42135C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333422; cv=none; b=Ww/a/NOwHnUN4G0svZT8T9EvHtCKa74JNq+AwPn4mJ/ZsYk4UBg9rEPF+nkAoQX7c6HH63wHldyLpDZZh/FFqD1ZyNJ+5lhSFYlRJYK82pa+8GInF5TLFDbPsDCdMVBoG7lu2eF7Q7wnBEZVFlGhRXh97QRuIEG0Rj5fG8juc30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333422; c=relaxed/simple;
	bh=zpTa+qfeGV2k5NtVzTVITl85Yym3NlMeyy53MZ3h8nI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=h7r3FU/RFAoeFWUVuH0gWqV3zvdD7IuKpYJAdR7qbyx2x9UPtq2mzYIay6cGSA+lF8WQJxQc+U/vQPtVVmuoJVBmXX85XKG1de9Po2L6Y4Un4ahqJmPsRdMkGjONUIK1RM6nrXbBHtY6g/mCLVm1LOXz8NCITg3gCCKBWyeRTBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dJvJw+MD; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d509ab80eso208954f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 01:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708333419; x=1708938219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gF7sGDk1x24G6RZbBVHNrWjV9qvXDZGdRDsrtRvQq9E=;
        b=dJvJw+MDFW//kuh8SimerpT4lecUfksPHfHT6jJhmDGnFYP7GG75Znf6PY0WtePuPO
         Ni/9Bh81gdIUFBZBM7qeWQsej+Sywka6qqbHC3Ttt1EB9cp+ePRtS8puZwKbb6vzdR/0
         v/qFDPqjggI8aFCHjIrfpQPyPWR1kk2WH3g3YiOycklOxlV/jmIN+Sl/kJ9F1Y086NcH
         z62hwKFLtGz6p/AUyMW3mEwphoPW/rQhaRBjcHyP+7Y54HoqqXOTxhKiVDbATV9DJa4d
         tjWN+gS8ZSxHxw6l+a+7Q5El5YLvl41STdcKVL0Qk7XQiomDQ5eVfCAk/5JcCszBNhh0
         nz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708333419; x=1708938219;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gF7sGDk1x24G6RZbBVHNrWjV9qvXDZGdRDsrtRvQq9E=;
        b=F9y8sVQs1ZkXZgSklsT76uIM6e1YBkV+wKwORn+iUFCjtiE/TOaFO3PE30gYSHj2Ef
         kaTEZ3uJVGdnmrxQSw+ZkgBveN6DelGRmGb3zsjEFLJ72NtYU8EL4mqgFa6fDzoOwgyh
         FFmqYdHXzQrRU0P5gU2m5MY2VNWvucx8rKJ5fffTjpxr6OFVgDBYFMRs9ye8aq8IqlaW
         Bo+mxnyPuYs01CvesVem9F7hdIn61mgxxvl9BZd3b7kylB08wB7XaUBODnHiCDeOMyMK
         dWqBGGE/P6Rh+bdTrtY/pdynvm56exjRZlz/89e5MMh+y0ntlQr+o5jmowqlXsL5WMoM
         lVhg==
X-Forwarded-Encrypted: i=1; AJvYcCVNZEU/kgPolLF9CCE5NBqKhOP4AME9f/pc8IGOMHpel9LL6YmwWjDqiPBespc5lzCFZb2jB9KDKFdxrOEsIZtbO6bH8Y/pF+PA05R8
X-Gm-Message-State: AOJu0YxKfXCQ3vBZlUet+n9ADROuKZPh7rws/QW1PelKIzi8JJcOU/zg
	qSs0q6v0AJYbDN1589/Cc4hk2bI6X2g4oommaQLv9Qp2cgW8sdOVkyHrDR9XYdo=
X-Google-Smtp-Source: AGHT+IHeW4FAyqvBoHaZHyX8ohtq5iNNLDp8u7VcW4ZWJqvxtsgUI3BYpUKh1ifXeE1GS2yUvTjqBg==
X-Received: by 2002:a5d:588f:0:b0:33d:2b3d:b598 with SMTP id n15-20020a5d588f000000b0033d2b3db598mr4141771wrf.70.1708333418779;
        Mon, 19 Feb 2024 01:03:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f? ([2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f])
        by smtp.gmail.com with ESMTPSA id s1-20020adff801000000b0033d01fe1f04sm9722957wrp.55.2024.02.19.01.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 01:03:38 -0800 (PST)
Message-ID: <c86594cd-f32d-4b66-8459-9045640aa928@linaro.org>
Date: Mon, 19 Feb 2024 10:03:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 5/6] phy: qcom-qmp-combo: fix drm bridge registration
Content-Language: en-US, fr
To: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 stable@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>
References: <20240217150228.5788-1-johan+linaro@kernel.org>
 <20240217150228.5788-6-johan+linaro@kernel.org>
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
In-Reply-To: <20240217150228.5788-6-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/02/2024 16:02, Johan Hovold wrote:
> Due to a long-standing issue in driver core, drivers may not probe defer
> after having registered child devices to avoid triggering a probe
> deferral loop (see fbc35b45f9f6 ("Add documentation on meaning of
> -EPROBE_DEFER")).
> 
> This could potentially also trigger a bug in the DRM bridge
> implementation which does not expect bridges to go away even if device
> links may avoid triggering this (when enabled).
> 
> Move registration of the DRM aux bridge to after looking up clocks and
> other resources.
> 
> Note that PHY creation can in theory also trigger a probe deferral when
> a 'phy' supply is used. This does not seem to affect the QMP PHY driver
> but the PHY subsystem should be reworked to address this (i.e. by
> separating initialisation and registration of the PHY).
> 
> Fixes: 35921910bbd0 ("phy: qcom: qmp-combo: switch to DRM_AUX_BRIDGE")
> Fixes: 1904c3f578dc ("phy: qcom-qmp-combo: Introduce drm_bridge")
> Cc: stable@vger.kernel.org      # 6.5
> Cc: Bjorn Andersson <quic_bjorande@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 1ad10110dd25..e19d6a084f10 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -3566,10 +3566,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> -	ret = drm_aux_bridge_register(dev);
> -	if (ret)
> -		return ret;
> -
>   	/* Check for legacy binding with child nodes. */
>   	usb_np = of_get_child_by_name(dev->of_node, "usb3-phy");
>   	if (usb_np) {
> @@ -3589,6 +3585,10 @@ static int qmp_combo_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto err_node_put;
>   
> +	ret = drm_aux_bridge_register(dev);
> +	if (ret)
> +		goto err_node_put;
> +
>   	pm_runtime_set_active(dev);
>   	ret = devm_pm_runtime_enable(dev);
>   	if (ret)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

