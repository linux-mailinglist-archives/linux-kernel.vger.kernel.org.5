Return-Path: <linux-kernel+bounces-162278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C047A8B58FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F641C20DFF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202CC537EC;
	Mon, 29 Apr 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uOj7JL4U"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0262E40C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394891; cv=none; b=hv9g5RRjzVzWLHKzNdHPshUDqaHQcWoWisIrMLrjPasdxpMIYaKkf07gYkG6nxRO7K0eNFX4cPTWq2VKYUibcXXZE9/729Ts6cJuVL8gmkXArYWoAkSyvLu0lIYwMXD2pnAzJ1uZg2iWMnqSUOgwzdpkXCHKAvN3NkEIjPdaVFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394891; c=relaxed/simple;
	bh=cXbG2RfKg14KIKweqgdf/9Jnv+n7O54jLRu0uSow+TQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TBYMDoUhZOyRrflhbyaTwbfmfe+57RMWwJti5szDIinVGJL7qLtCGJ2UuZcYMuPRXe2nSDjL9CYkWTWVaDlxFhRmP7zXinlTdPCbHW/e/J84XanTFcLA4RUML2wSIUWBi2i+MobEHfT4NUOy6NoHpbR/UZyGvBq77S8m1z4y2sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uOj7JL4U; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34d1ede7e51so533322f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 05:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714394888; x=1714999688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWGHKar9gPpf8FREfKdSsvhcLM1EOEGgWjHyzOE7yU8=;
        b=uOj7JL4UHoBAwcRsSAUxSqV0J/gHbiEETaVMY08d9+DwvfRuEC6bfgrPZ/MN75vn2P
         O4vCfJSgMWEvAd443lcD2/ZC45uwWdAg+6PZ0cWuROMNEfDTKq2IfnEWU8kJpNm2XiTL
         YiZq1e8ZqAGO5sQTAWfHXwkp9VDMtcUwDXhNfzJoP7A0oHHLaZ6hjrO4tJkuLOZO0IAz
         b0Yuxqtof8YslKDiMcZ9To6Z5SRSlXokHQv7Y4Hagy7l5ECyFZNinAG5O3M1YuH9vTxt
         Ae9fDhTAHZJpk+J07jfzg/M4wi1j9r33aBZYiT1F+cDgnnS/yM5lrYtpOxviKUzr9XhH
         Gwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714394888; x=1714999688;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KWGHKar9gPpf8FREfKdSsvhcLM1EOEGgWjHyzOE7yU8=;
        b=EkL+vKTey+IwDbBlblLM44DD3Sf3KcA8ShMUZFkWuqG6C60Z9N82HHqz587oCu1vuC
         l4ADDLMdwSa2sEG0OY6oJ98v9gi2k+5E4EwzfFCbsFFuXpWeOGD2gUI8IEpQAzNtOjrP
         zZy/hUDEpYWRbiyEe5YeXXT34uY/1CblglgFcz13j7T3t1ebcv/lH6Xq0UkWMpW7RkTm
         1m3FyCs+KmZXcX1XB+KsmPsXzkqPHlX/W60tfJm1E6zZU2hmWm/W9Cgamc0VoFfp69Xo
         7FMCO3lLjE3VRBITdNDc3UJd36Lv3c7uRlL71vk353EPHaBWXEMXE4XPH/eHX85gLB3v
         hBBg==
X-Forwarded-Encrypted: i=1; AJvYcCWLAsl6WW7/9iI6VQNjvI/w7Wded1tf8MI658OhFcxyJq8hdp4xCS4IogcXweIKkXtgFpIt9/01hAHj3t+IED5c1VuwQvU+ZkoxPe1e
X-Gm-Message-State: AOJu0YzbPqfOyilbl4xQQFU99AaaAiDHwLCs1vEWK6oKXvErgMRwU7/d
	zse/X9qQV6oQwvUavOWSR95w+b2lWmSWdPNgXSuKoNWgb2QdBpzV5/5KzQGVKR0=
X-Google-Smtp-Source: AGHT+IFi4OevBqEUAYmOe/4iGMLHv21RcMaNvECqTzvjs6yQyDCTPhFbnyagMO5og9GXgDXuL36w+g==
X-Received: by 2002:a5d:4444:0:b0:342:61ee:bee1 with SMTP id x4-20020a5d4444000000b0034261eebee1mr6372838wrr.23.1714394887993;
        Mon, 29 Apr 2024 05:48:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:d72:4b40:65fa:89e6? ([2a01:e0a:cad:2140:d72:4b40:65fa:89e6])
        by smtp.gmail.com with ESMTPSA id a16-20020a5d4d50000000b0034a9b75e272sm24154091wru.45.2024.04.29.05.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 05:48:07 -0700 (PDT)
Message-ID: <4ba02a4e-705c-469d-96db-0077749fc25d@linaro.org>
Date: Mon, 29 Apr 2024 14:48:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 10/12] arm64: dts: qcom: sm8650-mtp: connect USB-C SS port
 to QMP PHY
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240429-usb-link-dtsi-v1-0-87c341b55cdf@linaro.org>
 <20240429-usb-link-dtsi-v1-10-87c341b55cdf@linaro.org>
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
In-Reply-To: <20240429-usb-link-dtsi-v1-10-87c341b55cdf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/04/2024 14:43, Dmitry Baryshkov wrote:
> The lanes from the USB-C SS port are connected to the combo USB+DP QMP
> PHY rather than the SS port of the USB controller. Move the connection
> endpoint to the QMP PHY out port.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8650-mtp.dts | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
> index d04ceaa73c2b..819f6eadba07 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
> @@ -59,7 +59,7 @@ port@1 {
>   					reg = <1>;
>   
>   					pmic_glink_ss_in: endpoint {
> -						remote-endpoint = <&usb_1_dwc3_ss>;
> +						remote-endpoint = <&usb_dp_qmpphy_out>;
>   					};
>   				};
>   			};
> @@ -853,10 +853,6 @@ &usb_1_dwc3_hs {
>   	remote-endpoint = <&pmic_glink_hs_in>;
>   };
>   
> -&usb_1_dwc3_ss {
> -	remote-endpoint = <&pmic_glink_ss_in>;
> -};
> -
>   &usb_1_hsphy {
>   	vdd-supply = <&vreg_l1i_0p88>;
>   	vdda12-supply = <&vreg_l3i_1p2>;
> @@ -873,6 +869,10 @@ &usb_dp_qmpphy {
>   	status = "okay";
>   };
>   
> +&usb_dp_qmpphy_out {
> +	remote-endpoint = <&pmic_glink_ss_in>;
> +};
> +
>   &xo_board {
>   	clock-frequency = <76800000>;
>   };
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

