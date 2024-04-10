Return-Path: <linux-kernel+bounces-138108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89B789ECB7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB871F21C76
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B9213D296;
	Wed, 10 Apr 2024 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sO/eDirm"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2129413A405
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735612; cv=none; b=P3PkCFstYBbNUISWt60BDHwVvWXb7EgPUIRP+hTzdTK1u/l5H5CBJIQ7F0shE0i0jxQcEwlSEdO3NM3eBGZz1Dl+aENXr7S/dYIcDb7CFkDhkLBqVCBBjmcZnsaEe5TASORrW/XmrrAck7ciyPY6Og0+Qt7P3RFmBptuOhqJ6Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735612; c=relaxed/simple;
	bh=QVG4evRg8W5VO8NJdh62Fh0biVN6yJlwvqrMftGCzVw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AWPy9IXX54I8mY1DKOhtDXSG8WJwScQGl0kqFWQDW5oaE3M6bi0EsIVVpcUD+CGmiHZD+8qmRgGEr/f5ez0Cl1NH/RNcUHMoMvSf6Zwm5BJZp1/KYFpxjr330QTS8Yd1PZ53eNP63Ys3NCY9PKwf1MWjdvu6e2gVaSKBaMhXNLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sO/eDirm; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-343f1957ffcso2742187f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712735609; x=1713340409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqeWpXq7iVkwpLCfNMJQ1hkeTu7GIqakLNWFUZcYNR8=;
        b=sO/eDirmSN3fGEb5iPJAk6clUQAd70548sqz9Eve+fW8a5c3ID80KIK85pUJyVYZk3
         F3smHfzcis+46tpUiF+nBMyOEip3VM79ElbrvL9ERl0BpkDhm8O9xPJUg7T5LZdNgrSv
         kN/6zNgkZ0tmk8J0XCABcPJ3pfSI+hgt3ATmocBb5rour4Mtb7hj6rf+oG5S/4ZeLyzE
         TbHdoxzR1B2Vgkhbx3/cn11MP6D52TKo1ORo6ujt+eBNioRHlfM8r52Z9WA1IabbHMIO
         M5H/tWkGfRiBOF3BL8ZUMDpr6ulrk/MBHjxSw1IZ4PwYpJmPsozmJa7gJf985ewe2e9d
         M8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712735609; x=1713340409;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mqeWpXq7iVkwpLCfNMJQ1hkeTu7GIqakLNWFUZcYNR8=;
        b=Q21mmfy7WW2krA+r8wH/y0QCJhHKE2rqfPoClTdLYL3Ns8R6wzxjcKbLFi4FyRIjSF
         UtwrtoFglfK37DUKgk9A0EtWsoTzvbQasF20GB1b5l1FjdvCGcrQt6Cjnthe/OEDK71t
         ajLs99FdjpVj8mAq8z5orZqRVORTzQKTZc/bGzZwQJx/9TaZJLigoV3/WbLWVlEfCvHy
         y8Lwtki9vArDOLLd+a8xQiNNj5wxiX12PIR09LVdSwWBn/DehplUxOhHLhivXdC1L1n3
         6C80t4rQtrZH5ZvsogJfBMBftUy8L0jHYUpLyotvwpZ/utWgdWl2cokNv7izvPqo+IGj
         WpHg==
X-Forwarded-Encrypted: i=1; AJvYcCX2fD8g3adwQy96qudFnaY164bUYf4UgVHHLEpjTLrtYjG+AbWjQgN+P/m/wFhB1l4/phM3CPmlE3ef5d+WgUguJqHwpRsoLaBXX1r7
X-Gm-Message-State: AOJu0Ywhjx/ATMWtvJ59jkDDZ1HGi/k3UH1E+sbKIGYXs08XYek3u1nH
	eOG2Jkov6fWs8KEfmr5ZXyDgOBQ2D+JpS7O9GfaeQxIerVARGXbM8flxXHkkIzU=
X-Google-Smtp-Source: AGHT+IH6iDnO+uP8H0cIbAAG8d0vXfntJz0LonCnjcAsVy4AbjB4lxfmj6mpbR9+Z686JLFAOkSYzw==
X-Received: by 2002:adf:f2c6:0:b0:33e:c91b:9083 with SMTP id d6-20020adff2c6000000b0033ec91b9083mr4069681wrp.16.1712735609399;
        Wed, 10 Apr 2024 00:53:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7b0c:6cd:4afa:674b? ([2a01:e0a:982:cbb0:7b0c:6cd:4afa:674b])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c314800b00416b8da335esm1441821wmo.48.2024.04.10.00.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 00:53:29 -0700 (PDT)
Message-ID: <6ac4e36b-91b8-4324-874d-9b90c79451a1@linaro.org>
Date: Wed, 10 Apr 2024 09:53:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/5] arm64: dts: qcom: add USB-C orientation GPIOs
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240409-hdk-orientation-gpios-v2-0-658efd993987@linaro.org>
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
In-Reply-To: <20240409-hdk-orientation-gpios-v2-0-658efd993987@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/04/2024 16:28, Dmitry Baryshkov wrote:
> Populate orientation GPIOs for some of the PMIC-GLINK-based devices.
> This leaves only FairPhone5, RB3Gen2, SC8180X Primus and SC8280XP CRD
> without the orientation GPIOs declared.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Changes in v2:
> - Relax schema restriction for orientation-gpios property (Luca Weiss)
> - Link to v1: https://lore.kernel.org/r/20240408-hdk-orientation-gpios-v1-0-8064ba43e52a@linaro.org
> 
> ---
> Dmitry Baryshkov (5):
>        dt-bindings: soc: qcom: pmic-glink: allow orientation-gpios
>        arm64: dts: qcom: sm8350-hdk: add USB-C orientation GPIO
>        arm64: dts: qcom: sm8450-hdk: add USB-C orientation GPIO
>        arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: add USB-C orientation GPIOs
>        arm64: dts: qcom: sc8180x-lenovo-flex-5g: add USB-C orientation GPIOs
> 
>   .../devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml      | 14 --------------
>   arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts        |  2 ++
>   arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts |  2 ++
>   arch/arm64/boot/dts/qcom/sm8350-hdk.dts                    |  1 +
>   arch/arm64/boot/dts/qcom/sm8450-hdk.dts                    |  1 +
>   5 files changed, 6 insertions(+), 14 deletions(-)
> ---
> base-commit: 8568bb2ccc278f344e6ac44af6ed010a90aa88dc
> change-id: 20240408-hdk-orientation-gpios-141bc7fd247d
> 
> Best regards,

You forgot to pick it on the v1:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

