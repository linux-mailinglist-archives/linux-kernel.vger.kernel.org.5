Return-Path: <linux-kernel+bounces-162291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8BE8B5920
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8463F1F2275C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A3D7D3E8;
	Mon, 29 Apr 2024 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lmdzsbLr"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77AD6FE2D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395081; cv=none; b=cICbixucNr9NX7uP68FTeJ2zi5c442Uwu30AWaNSpEvLgMYEili8/NUIIuaMBxD4N4wWiPvZUBPYMJBODqThw9psyVpMp4F97cT95WUVBZsmKD5TOYoEeFk3FMvJlMYZkrZza+YVP8wVniBdERWo+Wge8Jg9YzlK6LcpEbEsBpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395081; c=relaxed/simple;
	bh=gSPTlr0VBBzkRCIURVwBTn5xzbfhPg5dw3Ha9B1pM04=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JWmgf+uMQlWWMcmYTiGV4zYmZJCq7mURkSl2KoCVxILVPSvwPnhTQbvajkJK4esrGCVRTkcXyTy6gBLeAcgOU34xQKeqrSOYBTZ4B9Zcf2kOeJbHmiO81nvgkZfnXSCzEERYfQPvQO6u7mFnolhpISYm6BqOa5sdSgqbE8V+R8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lmdzsbLr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ffso15270685e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 05:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714395078; x=1714999878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PDIY9s2RJ2xRPkiukpn1HLtVc24S+QYrw8xF4eyHUBs=;
        b=lmdzsbLrKyDGQm7N/Ny0NadxgxBWo2QoJx6wxSuOcJ1uNOUgHx4sDF6JtRC2nPlk33
         o08cNMfyAqWnTC+aRTRFJZQrlPZy+whDXIuVLnAZNpbUEJ+OHQiFUPQemKBbJbsib1Xd
         4SVSVHGKBkJ0NTBLjwqbcMg8aaCDbfJqlPzyWzt2xpF1fsxm5UwMDBwyjpk+lz18EzZW
         Wu924MBAf/9BZZoey9EiG19o3/+i6c2Ov/iAO/kB4CakEaWmiiHYP+CufBp462Dhgbkv
         1JZQmnPFpIsi6tJyGFEcFz5XSIeVqr3WvBUH0QEsyPGkRCwgE3CF1dA9VrAXTBnVTkSa
         nZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714395078; x=1714999878;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PDIY9s2RJ2xRPkiukpn1HLtVc24S+QYrw8xF4eyHUBs=;
        b=tTJhtqZcQyW2f/U9UecdqhHDrN0wUagzp4QEMRijX46CxGa0JFTFD5ohggPyVasw9T
         5IMa57m86nHAkFtBPJMI9A921KZNH6u0l3/6XxjBBmWQxqV+C5y9MF/0MzwpwCATGf6E
         qSn37vP+b0Lb/rbHjZ0d4jJj7GyTT6qXpxxIOentgOkqw4y/nrnGEQ8f4DI2hL06iXa2
         kWSD3wpBZslBOswNPKYeCjRqcEIaLy2PuwuacCc1TBaYrq7mBY0AeSN2/GvyyHKam6/+
         RQmChwdSkSbAhgqvzRQVfAU7seeV9C96uXlowzjCYARqlSPojJV20mZ6k5Cr43WiqbOS
         b+Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVegqK1XbZ4y8SuY/hKHKnVX7TROUlg4J/mvXHNoD2iXgu9JxBESaGATsz7+9mrWdxO4DMb+xKThbkGEjs8QztHAwQXI4RIAQAl6Myk
X-Gm-Message-State: AOJu0YxfiuaySZVcoNsRxTN7zbDacGyDLJkx7kOF4WDqh6XuIWfnASZv
	qqH3RDLwo6vZNln72GPw8A4suNsei4AXQzenlI32JfL6YlXM9EexGETPoPYvD7Q=
X-Google-Smtp-Source: AGHT+IF4yCm1L2PfyAvsiV07AozWKhA+NKumsFsD/aq4tlT0uK1ojhkCX2pfI5aw8vupgPzCyxrZbA==
X-Received: by 2002:a05:600c:1d2a:b0:41a:4623:7ee9 with SMTP id l42-20020a05600c1d2a00b0041a46237ee9mr5908828wms.10.1714395078233;
        Mon, 29 Apr 2024 05:51:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:d72:4b40:65fa:89e6? ([2a01:e0a:cad:2140:d72:4b40:65fa:89e6])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d4b87000000b0034cf3001104sm3458454wrt.33.2024.04.29.05.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 05:51:17 -0700 (PDT)
Message-ID: <4f5f19b5-7385-4d85-b63f-fdafe62dc987@linaro.org>
Date: Mon, 29 Apr 2024 14:51:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 07/12] arm64: dts: qcom: sm8450: move PHY's
 orientation-switch to SoC dtsi
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240429-usb-link-dtsi-v1-0-87c341b55cdf@linaro.org>
 <20240429-usb-link-dtsi-v1-7-87c341b55cdf@linaro.org>
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
In-Reply-To: <20240429-usb-link-dtsi-v1-7-87c341b55cdf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/04/2024 14:43, Dmitry Baryshkov wrote:
> The orientation-switch of the USB+DP QMP PHY is not a property of the
> board, it is a design property of the QMP PHY itself. Move the property
> from board DTS to SoC DTSI.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 2 --
>   arch/arm64/boot/dts/qcom/sm8450.dtsi    | 2 ++
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> index 9926294e4f84..71dc06db7736 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> @@ -1120,8 +1120,6 @@ &usb_1_qmpphy {
>   
>   	vdda-phy-supply = <&vreg_l6b_1p2>;
>   	vdda-pll-supply = <&vreg_l1b_0p91>;
> -
> -	orientation-switch;
>   };
>   
>   &usb_1_qmpphy_out {
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index d138b90bb280..3494d5076368 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -2304,6 +2304,8 @@ usb_1_qmpphy: phy@88e8000 {
>   			#clock-cells = <1>;
>   			#phy-cells = <1>;
>   
> +			orientation-switch;
> +
>   			status = "disabled";
>   
>   			ports {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

