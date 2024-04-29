Return-Path: <linux-kernel+bounces-162297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D3F8B5933
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1477DB2B060
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4809977F15;
	Mon, 29 Apr 2024 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ExgKD7j/"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5B475810
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395162; cv=none; b=FfzDwfHKUlWxRMwqgb00voZ8gqqa6jK8JIzogtrb8swA9eT3Ug5oUkRD1tE5DcYI5mnll87YDzbl2AjmhxpaPmecx0sCwqI4JU6AJ/m2B19tXD2rh0x7kpDCX1j9q2yq8tVyOF8qBh+rHMT2vaY6vPmuhXOY5cTPyeAfNr6eoj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395162; c=relaxed/simple;
	bh=yMytuPO5lxWxXc3yn3xfzLGhfVQXqpW6poI0dAsDQ8Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Qor0BrwaSGWFLklWnJtxXMh8Nz1K27h8WDLzMbn5K2ZitnjY+YJ2P5G6hyPeflCxBlOD0h8ZMAmAPv9kmuM0czliYlrKIA14FG2aRPFnSxnO2rPbcMruuaOID55BoFWnuTZGaSxdjV95g31JrQxQQHvJSQjR9CsuG+fsvnxU+Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ExgKD7j/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34c90082dd7so1861345f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 05:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714395159; x=1714999959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=faGPWRrGeahCSJiTf18r83A81SFNIZKNhVYrt2vpUHE=;
        b=ExgKD7j/0G1KRYF22nwNH0mUgQjRqhRszUYlMKHWpzPNhOq0m5H1RtMTgJz4cRZI5p
         XLdU6eTgph8UMaAFfExB4Oc7ui5q4KgRYJPhwr2Cwk4DLHBytQj20oPaNZnyAyH7tdFT
         7BUHPWhW3WNs/EvXNIUB93nh2xgiuBahm+1WZx/7rxzm8zqBl5IMPSwps3jvdAf9Wkxt
         acyKnVOJ7qBsnIQ7EYmidyxpqFvidFX+f2cA3Blu8yluNl0Snl4kRUsS1Mjo65aiDZba
         zp3buETPDMgsT4vRs55ml54ECu6P78bT6NoYhnkfnnmZn0QSwq6x2k4ejkNA/Am7t/lp
         r7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714395159; x=1714999959;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=faGPWRrGeahCSJiTf18r83A81SFNIZKNhVYrt2vpUHE=;
        b=H1fijhhmFhjCihSARyutV1VQrYqWA10A9F5OK5ZZQCUBrLK6uOzWlr3GBypM7WawwO
         Fy7ALDN7QKOfPlix2a7Up38ROt8xCHoPEdQfRuFx7BZ3BshX0MOLrPW4PTJswzpq/RzE
         knwodVOgQK3KkJErl+gUviKbHykHtDC2BImz34JLrXdSZXb0qKxLrGnMUoVKlyhkYopk
         UOrM3OEbzPI/J3byMhdJaI5wmQjuOR7SWWPckB6f1wY4b709Z5Em7ZAW57yON0h1P09V
         KTSUIRJjv6jj5Vvf86XzB6NRWfrRyzM2vxOyKnB2djvdLlS/esx5td/9zLshr98lApGC
         XGng==
X-Forwarded-Encrypted: i=1; AJvYcCVAWD/b/EWKHp277KrjbZgntUB5QR/iCVsZqFHTITb8xTvfoUFCbTn22hpVwikGwJ+TRmHXqR8aNzUhXjZNhng4FmqhpiJ8KHxjd0oC
X-Gm-Message-State: AOJu0YwtAUNQgKyAJ4JLqZtq40q7rvtDeD/dE8Cor99/AGbOZ+qMl4hZ
	X/kjvdPtT8Id9S4mrIAl6hgH7cI3r6bEwWaW6SdGjBnbjTkb6TRKBV+B59Bc6aU=
X-Google-Smtp-Source: AGHT+IFoFfYeoOCH5RyosC+fxy/kn88ubP8n1obWqOWr3e36lBCsqBeNAOdlfYF7OubEt6H6iZKKgQ==
X-Received: by 2002:a05:6000:196a:b0:34b:400:2fea with SMTP id da10-20020a056000196a00b0034b04002feamr6936604wrb.71.1714395159111;
        Mon, 29 Apr 2024 05:52:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:d72:4b40:65fa:89e6? ([2a01:e0a:cad:2140:d72:4b40:65fa:89e6])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d48c8000000b0034af40b2efdsm21289088wrs.108.2024.04.29.05.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 05:52:37 -0700 (PDT)
Message-ID: <80125ab0-cf11-4757-8a8b-7588026f5e12@linaro.org>
Date: Mon, 29 Apr 2024 14:52:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 05/12] arm64: dts: qcom: sm8650: move USB graph to the SoC
 dtsi
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240429-usb-link-dtsi-v1-0-87c341b55cdf@linaro.org>
 <20240429-usb-link-dtsi-v1-5-87c341b55cdf@linaro.org>
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
In-Reply-To: <20240429-usb-link-dtsi-v1-5-87c341b55cdf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/04/2024 14:43, Dmitry Baryshkov wrote:
> Move the graph connection between USB host, USB SS PHY and DP port to
> the SoC dtsi file. They are linked in hardware in this way.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 13 -------------
>   arch/arm64/boot/dts/qcom/sm8650.dtsi    |  4 ++++
>   2 files changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> index 4e94f7fe4d2d..65ee00db5622 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> @@ -832,7 +832,6 @@ &mdss_dp0 {
>   
>   &mdss_dp0_out {
>   	data-lanes = <0 1>;
> -	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
>   };
>   
>   &pcie_1_phy_aux_clk {
> @@ -1211,10 +1210,6 @@ &usb_1_dwc3_hs {
>   	remote-endpoint = <&pmic_glink_hs_in>;
>   };
>   
> -&usb_1_dwc3_ss {
> -	remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
> -};
> -
>   &usb_1_hsphy {
>   	vdd-supply = <&vreg_l1i_0p88>;
>   	vdda12-supply = <&vreg_l3i_1p2>;
> @@ -1233,18 +1228,10 @@ &usb_dp_qmpphy {
>   	status = "okay";
>   };
>   
> -&usb_dp_qmpphy_dp_in {
> -	remote-endpoint = <&mdss_dp0_out>;
> -};
> -
>   &usb_dp_qmpphy_out {
>   	remote-endpoint = <&redriver_ss_in>;
>   };
>   
> -&usb_dp_qmpphy_usb_ss_in {
> -	remote-endpoint = <&usb_1_dwc3_ss>;
> -};
> -
>   &xo_board {
>   	clock-frequency = <76800000>;
>   };
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 8e0c1841f748..4624ea4906d9 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -3675,6 +3675,7 @@ port@1 {
>   						reg = <1>;
>   
>   						mdss_dp0_out: endpoint {
> +							remote-endpoint = <&usb_dp_qmpphy_dp_in>;
>   						};
>   					};
>   				};
> @@ -3767,6 +3768,7 @@ port@1 {
>   					reg = <1>;
>   
>   					usb_dp_qmpphy_usb_ss_in: endpoint {
> +						remote-endpoint = <&usb_1_dwc3_ss>;
>   					};
>   				};
>   
> @@ -3774,6 +3776,7 @@ port@2 {
>   					reg = <2>;
>   
>   					usb_dp_qmpphy_dp_in: endpoint {
> +						remote-endpoint = <&mdss_dp0_out>;
>   					};
>   				};
>   			};
> @@ -3864,6 +3867,7 @@ port@1 {
>   						reg = <1>;
>   
>   						usb_1_dwc3_ss: endpoint {
> +							remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
>   						};
>   					};
>   				};
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

