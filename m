Return-Path: <linux-kernel+bounces-78548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5298614D2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40AC61F246CD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBB96E600;
	Fri, 23 Feb 2024 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wnHipvnq"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EE920B02
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700051; cv=none; b=HpzrYggAxBhPYvmAm3/A4UNM9d+ivBi48gnF2ldUAxzDnp6t0H01is1jsdHJGCfK/80FNsE0cWAhUFkClyD1BptTEsYcB59Maa3exC5RdCjdm/KIsLJJn0K1P4kwOOb8vKR411cFLP2BtuHfWdc4gRijU0dxJUGc83b+9rPL0o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700051; c=relaxed/simple;
	bh=6Oz2SurcRGuC9x/F6hMkBx4N978V20giw8IYdnyT7Tk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ImG3K6mnciJ0EU6Yg1o3ORs4NzIR2XZS3A4MRDC7KygcKOPqfa/cSvdEmF7N39Cu2r9WRB1ZGuKpMQ0JLKe0IwdaQ/msTqQj/crhv4rVkOOAwFe/6s3bYrJ/HWbQ4BJ3AQ7EpdsVQ7q+2VnoT7Y3Jdlf1WqP7QsGPvvGzKRgVyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wnHipvnq; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso639291f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708700047; x=1709304847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cNUbkWdNlhpKbmxfuu6qZOk5j1wm/SN92RpylpPx2rA=;
        b=wnHipvnqhiGlpohhMTy3U8eErrjhrPXItelT6tk7gt4WhdTBF0qQJzDiKy99xQbeE3
         eCEfMG2UyZALpA1u0L63ozN8PlXnMYYQ0b2KPOjD3Rf4v+yIWvf2eWT/3lMP3+1eCRSJ
         7FtdXkhwlzlyFEGPbTOALnYxIlbTdn62QifwUeL2OzzBhw6TTCkxP4b8ChIxmdMpUGJ5
         ynRloFqMUpF9GlkUh7YgwKKpIisLLkTpszj67MHCn5hbk/2nFoHdEyH57uIq333n3Oew
         1yzlmhuuUEXQLHT+f6YBuQ0T6j0yYv6y8yEX7T+95zcLU9/LyIZKyznt+cUvAVVHNnpO
         894w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708700047; x=1709304847;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cNUbkWdNlhpKbmxfuu6qZOk5j1wm/SN92RpylpPx2rA=;
        b=cJGuyDynLAWzpFDZT/WSiJLLDKlXPLL37b+23Pyv+PItOyTODgBEbuey6rPJaRN6Bf
         xZRnJobft0WJavl3NeRu/53ZI1fa3nXVdkG+WhsqLj+rgOkSDeK96RmnJkgW5Gcbyfc+
         9zgmbwz4CxgTZk8PWBNHDLbYWPSqIMxPKyqDL+EsxcaBg4Lryn3A8tF36Ai4Az1tBXHH
         4FZXU7eE3EVpmC1/daQnU/V7IVhg8MDNp1b2CcTuexosyevizjAgkxkqiGd8lrfrB2xr
         rPTm2MabQshbohraaSNYaEqYd5Z79nHgXVhnCnNlMxozfHb9lpVuoORBVzV8b0qcisJG
         Irxg==
X-Forwarded-Encrypted: i=1; AJvYcCUC8wNOcz7PnRygXZJd+rvGIdx71g9eNd79hEPv9dNLtMexHEkUFpclLUFSfWDsREXApuM87y2KhUnBy1dQIa3UNvHtUI2lVvh2SSl/
X-Gm-Message-State: AOJu0Yyd9mKwaBEfXdfGbDKXfwqYKO9sWSUbk+RvnMdm0Ffcac0sXbuM
	OjjFmKafve+18U9CNLOcX/f4k8Olq8dAtJlfcgJOY8DuQxS5Rocgqpubalc2lGA=
X-Google-Smtp-Source: AGHT+IHHEFVM/kLFgskVImQRztBShP4RflP5MJmVzKMK1rt1otBVKUaSq91oY7qDe/w6ZbH8jRi3mA==
X-Received: by 2002:a5d:6a90:0:b0:33d:c45:15ec with SMTP id s16-20020a5d6a90000000b0033d0c4515ecmr5104778wru.32.1708700047381;
        Fri, 23 Feb 2024 06:54:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:58e3:6b80:c446:11f4? ([2a01:e0a:982:cbb0:58e3:6b80:c446:11f4])
        by smtp.gmail.com with ESMTPSA id fa15-20020a05600c518f00b0041294a1d7bcsm2314742wmb.36.2024.02.23.06.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 06:54:06 -0800 (PST)
Message-ID: <3b6dc98a-a13d-4958-b8b4-003d27c84f89@linaro.org>
Date: Fri, 23 Feb 2024 15:54:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/6] soc: qcom: pmic_glink_altmode: fix drm bridge
 use-after-free
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
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org
References: <20240217150228.5788-1-johan+linaro@kernel.org>
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
In-Reply-To: <20240217150228.5788-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/02/2024 16:02, Johan Hovold wrote:
> Starting with 6.8-rc1 the internal display sometimes fails to come up on
> machines like the Lenovo ThinkPad X13s and the logs indicate that this
> is due to a regression in the DRM subsystem [1].
> 
> This series fixes a race in the pmic_glink_altmode driver which was
> exposed / triggered by the transparent DRM bridges rework that went into
> 6.8-rc1 and that manifested itself as a bridge failing to attach and
> sometimes triggering a NULL-pointer dereference.
> 
> The intermittent hard resets that have also been reported since 6.8-rc1
> unfortunately still remains and suggests that we are dealing with two
> separate regressions. There is some indication that also the hard resets
> (e.g. due to register accesses to unclocked hardware) are also due to
> changes in the DRM subsystem as it happens around the time that the eDP
> panel and display controller would be initialised during boot (the
> runtime PM rework?). This remains to be verified, however.
> 
> Included is also a fix for a related OF node reference leak in the
> aux-hpd driver found through inspection when reworking the driver.
> 
> The use-after-free bug is triggered by a probe deferral and highlighted
> some further bugs in the involved drivers, which were registering child
> devices before deferring probe. This behaviour is not correct and can
> both trigger probe deferral loops and potentially also further issues
> with the DRM bridge implementation.
> 
> This series can either go through the Qualcomm SoC tree (pmic_glink) or
> the DRM tree. The PHY patches do not depend on the rest of the series
> and could possibly be merged separately through the PHY tree.
> 
> Whichever gets this to mainline the fastest.
> 
> Johan
> 
> 
> [1] https://lore.kernel.org/lkml/ZctVmLK4zTwcpW3A@hovoldconsulting.com/
> 
> 
> Johan Hovold (5):
>    drm/bridge: aux-hpd: fix OF node leaks
>    drm/bridge: aux-hpd: separate allocation and registration
>    soc: qcom: pmic_glink_altmode: fix drm bridge use-after-free
>    phy: qcom-qmp-combo: fix drm bridge registration
>    phy: qcom-qmp-combo: fix type-c switch registration
> 
> Rob Clark (1):
>    soc: qcom: pmic_glink: Fix boot when QRTR=m
> 
>   drivers/gpu/drm/bridge/aux-hpd-bridge.c   | 70 ++++++++++++++++++-----
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 16 +++---
>   drivers/soc/qcom/pmic_glink.c             | 21 +++----
>   drivers/soc/qcom/pmic_glink_altmode.c     | 16 +++++-
>   include/drm/bridge/aux-bridge.h           | 15 +++++
>   5 files changed, 102 insertions(+), 36 deletions(-)
> 

For the serie:
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

After an offline discussion, Dmitry, it's ok to push the remaining patches to drm-misc-fixes.

Thanks,
Neil

