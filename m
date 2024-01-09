Return-Path: <linux-kernel+bounces-20754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87278284A7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9724C1C23E81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D179136B16;
	Tue,  9 Jan 2024 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vxE9lA87"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD6E36AF2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3366e78d872so3039609f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 03:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704799146; x=1705403946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chfBbkQWFi3RkRvELDfeIygNC5jObvP1JNIy+u9NYiI=;
        b=vxE9lA87nQKNiNqR3UjrWv/aCPJaeTUiW3fnnXuhemcjfO0nKdZ5zEF3Obqiu7/pcq
         JGzlZcoodOUVG8H9svU9yug7lSizT5GEjwVRg5zxfZqeIHccYYJGi3Mf5dRANDnzXJUw
         XGJViCi6zCOAWXKwBwPRrYeo/xMMFfJ8aXxo/7XPaAPhfawXJaQAR4w3KJb4NdMAgiId
         GbbotlYCgqcJZPkH3W8wQUWO7Qs58Z3cTPrAeUmbH5ty73BuqxbJTzrSpRST0rluFEL0
         EA0YDLtDl01lfvZcPuPrE9XqjM7LNRa5IICywRWiPw7QnqTLXgZ7Krk9o02KpDbSP7ki
         oqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704799146; x=1705403946;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=chfBbkQWFi3RkRvELDfeIygNC5jObvP1JNIy+u9NYiI=;
        b=Im1rIuYbNbBcxeQQYejHKpdUwirzF0Jwa2pIGRzFkGTXjUqi2cTyP4Gy3CjyI5mHBb
         O7TqxyWWSkSqfj+TkxDPQ2EJdXQnsDiz8ooeHPbb/sGGrSq9ex+6ia6gBr9Ix/37fPgB
         KmHyETCDcE76H3Q7QMmzwfVku8YP+/KeIn7SrLlFRWLgZVKRqwaX0MrMDaiYMb2u/Pyz
         oRA3DxC3QR5ivMGkqUXMIYxAo7FEH5DFS3NggQTd7MzY2VVCGrK4+YEVWAqnxKCK6tSN
         fuYLO1tSCq6hu5M8RNHYQkUhwhnQS7Rg0ZDS0qsDXQ5JEVffxo2WZ1foBFO2l/SwII3S
         8P4Q==
X-Gm-Message-State: AOJu0YzLFwcVH316y3bnfQMpPA0sJ8aKk8lxlQyNwUlRUT/eEqUVNmwP
	fBAXRGRLxCYROtTCX7I6p3r+wscZzK1hMg==
X-Google-Smtp-Source: AGHT+IEsZWXDG5nov5WgGdwrygI/N92ktso1pYJ/WeS1FwkcDt5mdmmfoNvhDk3tFn0aznqgxTrTuw==
X-Received: by 2002:a05:6000:10c5:b0:336:c963:25ee with SMTP id b5-20020a05600010c500b00336c96325eemr207146wrx.166.1704799145849;
        Tue, 09 Jan 2024 03:19:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:6193:3eba:f3ab:835f? ([2a01:e0a:982:cbb0:6193:3eba:f3ab:835f])
        by smtp.gmail.com with ESMTPSA id l10-20020adfa38a000000b0033668ac65ddsm2152275wrb.25.2024.01.09.03.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 03:19:04 -0800 (PST)
Message-ID: <99d7bb85-17b0-4b5e-a6cf-f5957ad92298@linaro.org>
Date: Tue, 9 Jan 2024 12:19:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/2] Add waveshare 7inch touchscreen panel support
Content-Language: en-US, fr
To: Shengyang Chen <shengyang.chen@starfivetech.com>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: quic_jesszhan@quicinc.com, sam@ravnborg.org, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, wahrenst@gmx.net, dave.stevenson@raspberrypi.com,
 thierry.reding@gmail.com, changhuang.liang@starfivetech.com,
 keith.zhao@starfivetech.com, jack.zhu@starfivetech.com,
 linux-kernel@vger.kernel.org
References: <20240109070949.23957-1-shengyang.chen@starfivetech.com>
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
In-Reply-To: <20240109070949.23957-1-shengyang.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 09/01/2024 08:09, Shengyang Chen wrote:
> This patchset adds waveshare 7inch touchscreen panel support
> for the StarFive JH7110 SoC.

Could you precise which SKU you're referring to ? is it 19885 => https://www.waveshare.com/7inch-dsi-lcd.htm ?

Are you sure it requires different timings from the RPi one ? In the Waveshare
wiki it explicitly uses the rpi setup (vc4-kms-dsi-7inch) to drive it: https://www.waveshare.com/wiki/7inch_DSI_LCD

Neil

> 
> 
> changes since v1:
> - Rebased on tag v6.7.
> 
> patch 1:
> - Gave up original changing.
> - Changed the commit message.
> - Add compatible in panel-simple.yaml
> 
> patch 2:
> - Gave up original changing.
> - Changed the commit message.
> - Add new mode for the panel in panel-simple.c
> 
> v1: https://patchwork.kernel.org/project/dri-devel/cover/20231124104451.44271-1-shengyang.chen@starfivetech.com/
> 
> Shengyang Chen (2):
>    dt-bindings: display: panel: panel-simple: Add compatible property for
>      waveshare 7inch touchscreen panel
>    gpu: drm: panel: panel-simple: add new display mode for waveshare
>      7inch touchscreen panel
> 
>   .../bindings/display/panel/panel-simple.yaml  |  2 ++
>   drivers/gpu/drm/panel/panel-simple.c          | 28 +++++++++++++++++++
>   2 files changed, 30 insertions(+)
> 


