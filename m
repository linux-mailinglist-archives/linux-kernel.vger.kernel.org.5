Return-Path: <linux-kernel+bounces-76223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD7B85F46F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43BC4286424
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8A1381B4;
	Thu, 22 Feb 2024 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="htI2uwYS"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32B5374CF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594404; cv=none; b=Gb7WJwQXRH0iwTqhj5FuRw4h9CTwi8XbjSKIo3IRPczlB90Ubj0iepnB3gGYQzCLQ4OVk7Ty2pJDgvJ0vGM81zwxOCrsfTMNg6BFy/7UGjoUmAAdViIS7sPyF700QsWNHVzILGdNX7CZG8tShJLbzyixehzOSU4k6B0nAn2oLLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594404; c=relaxed/simple;
	bh=dP8RdzkphJeuDSol23NMhvj/UZpW44n5G6pBD5kxGeA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QmuUI1tbPEPEI3pMVmE2KRP9h3hlMDeCBz1rfCvAbyOyUiIEKZ/IqLWLdvBZrKxs8MxaJ2q0qzVhWRPmSefiGSy6c6CMCFyzzXZ09Ms/aRgrAEK3cYH1zQXdOHEaioMk9pHDFTE1fjG7ZdFRIEgCvrHf6bQ1N2vuhSurcy6B6JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=htI2uwYS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4127706e48cso11230025e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708594401; x=1709199201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDXr5JamV/3Ee7kU0PpVPCxgNjfs/qLOTnSmkmTZcYM=;
        b=htI2uwYSAwsEj3ldPnyxA99KPi1N0viJpf5hWq1xCg5t0oSDiXaJC3qZ0tx+LYgHOH
         kQRokLbaacpJBnaczaKi+IMj3yTmSZtntSQhCVQGdBy0mEY7xqXx1q2oXc0nej4HnA7d
         u7wvn899omG0RvaSYHbRBiQ2GCzLNKGqR/bJVVBerxF6plj38LUpWrekPRP8+/ZiBY4v
         7HiOoIwGKvKSBqrWXWdZR+pIBQ0mdieMWtwDnK/h7clttX4rEq5cfXO6smhxFDZPpTNr
         rwL/4uW9df7d/HqKfUEAenaHptMydq/pf14h9moKKHfPRcMK1tzmplY46NKWMcujZ5DE
         m4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594401; x=1709199201;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fDXr5JamV/3Ee7kU0PpVPCxgNjfs/qLOTnSmkmTZcYM=;
        b=sVZTCSLa7A5JZiK94mest1W2OHCoJ/AMTcRH3SUcPZ4+mnSoXAU5SgtDTbGdPHwokY
         gQ4mzgUCFBdYq40oSbBmDiRvwwBi0os8tUJPFctAODJeJXubztJkc2YH5ParR1TGSZCe
         WLFPdrQ3ZVjaUKOUeu/8tZSC44Yplxw7AZ3U/r9euXqK0woRPIVZTixCFPdFU5OZErZr
         LE5WYlpJwHEe7XYDK/cwmHHAxDuejB80KvzQJd2QpfRjn/e/6pnPXntrdF4RlBvI7BcT
         dIDOTdbiAKhWiuKg+GF5ik5/x8WCaSIRRbvaBE6FMz/7+aNc2DhI/gYEoOMO1cy0P2mc
         pCzA==
X-Forwarded-Encrypted: i=1; AJvYcCVeAXuLhZDvmsMVE1FaMItaRJBAGaNfCyKqKKeAdXI3ANsF33vh23hF/J44OOZ8pLtKpyIgnUjTazBKMg2T4hs5G0gs5kvf+gFbIWjB
X-Gm-Message-State: AOJu0YwmG9kpSjqV9YL4I+HAnb0RU4odr/qbFg/9LBP24J7SklAhu4R4
	6N3TSmtd2i82jmB4g9hc0Ea7M6M9Zkw0b/WdbVzY8S3S8ZsDjyoAP/pwBnPkC5A=
X-Google-Smtp-Source: AGHT+IGQu/yEpWedhYCkg4zb3W4HcuXrKU1CRJjLn7mYmNeF7dYQsYTZdr8SRbdKAYubrdbuo5Wz6w==
X-Received: by 2002:a05:600c:81e:b0:40f:b0d9:113 with SMTP id k30-20020a05600c081e00b0040fb0d90113mr15595647wmp.36.1708594401122;
        Thu, 22 Feb 2024 01:33:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:c3d:c732:acf9:f53b? ([2a01:e0a:982:cbb0:c3d:c732:acf9:f53b])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c459100b004124907f43fsm20589536wmo.12.2024.02.22.01.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 01:33:20 -0800 (PST)
Message-ID: <dd9fa912-203a-4089-ac15-a73658aa2a09@linaro.org>
Date: Thu, 22 Feb 2024 10:33:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 8/9] arm64: dts: qcom: qcs6490-rb3gen2: Enable USB Type-C
 display
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 cros-qcom-dts-watchers@chromium.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com>
 <20240221-rb3gen2-dp-connector-v1-8-dc0964ef7d96@quicinc.com>
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
Organization: Linaro Developer Services
In-Reply-To: <20240221-rb3gen2-dp-connector-v1-8-dc0964ef7d96@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/02/2024 00:19, Bjorn Andersson wrote:
> With MDSS, pmic_glink, and the redriver in place, wire up the various
> components to enable USB Type-C display on the RB3gen2.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 63 +++++++++++++++++++++++++++-
>   1 file changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 171ed979d55f..4bf1c6351467 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -149,7 +149,15 @@ port@1 {
>   					reg = <1>;
>   
>   					pmic_glink_ss_in: endpoint {
> -						remote-endpoint = <&usb_1_dwc3_ss>;
> +						remote-endpoint = <&redriver_usb_con_ss>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					pmic_glink_sbu_in: endpoint {
> +						remote-endpoint = <&redriver_usb_con_sbu>;
>   					};
>   				};
>   			};
> @@ -476,6 +484,36 @@ typec-mux@1c {
>   
>   		retimer-switch;
>   		orientation-switch;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				redriver_usb_con_ss: endpoint {
> +					remote-endpoint = <&pmic_glink_ss_in>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +
> +				redriver_phy_con_ss: endpoint {
> +					remote-endpoint = <&usb_dp_qmpphy_out>;
> +					data-lanes = <0 1 2 3>;
> +				};
> +			};
> +
> +			port@2 {
> +				reg = <2>;
> +
> +				redriver_usb_con_sbu: endpoint {
> +					remote-endpoint = <&pmic_glink_sbu_in>;
> +				};
> +			};

Nice to see the SBU switching works :-)


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


> +		};
>   	};
>   };
>   
> @@ -483,6 +521,15 @@ &mdss {
>   	status = "okay";
>   };
>   
> +&mdss_dp {
> +	status = "okay";
> +};
> +
> +&mdss_dp_out {
> +	data-lanes = <0 1>;
> +	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
> +};
> +
>   &mdss_edp {
>   	status = "okay";
>   };
> @@ -534,7 +581,7 @@ &usb_1_dwc3_hs {
>   };
>   
>   &usb_1_dwc3_ss {
> -	remote-endpoint = <&pmic_glink_ss_in>;
> +	remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
>   };
>   
>   &usb_1_hsphy {
> @@ -554,6 +601,18 @@ &usb_1_qmpphy {
>   	status = "okay";
>   };
>   
> +&usb_dp_qmpphy_out {
> +	remote-endpoint = <&redriver_phy_con_ss>;
> +};
> +
> +&usb_dp_qmpphy_usb_ss_in {
> +	remote-endpoint = <&usb_1_dwc3_ss>;
> +};
> +
> +&usb_dp_qmpphy_dp_in {
> +	remote-endpoint = <&mdss_dp_out>;
> +};
> +
>   &wifi {
>   	memory-region = <&wlan_fw_mem>;
>   };
> 

