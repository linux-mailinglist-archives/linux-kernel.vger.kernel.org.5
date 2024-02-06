Return-Path: <linux-kernel+bounces-55017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA1F84B652
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B9C1F260CF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C46130AE8;
	Tue,  6 Feb 2024 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sLXkEdtj"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA17D12F5B4
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226082; cv=none; b=lXEY/wcYpCtw0WHTBZObPafn2TjAJKDyewu2faT8ntb/UaUKVUxOMi3LcN/aLtN3IbNEF5FtGNQvIEtvbm7pdBi4enGja8yeGhxE62PdXB+SfneW8szWNcUssPQwciAkn6wBYjgEE4Pi4j4jLlxDVuUNM1Rj98FyTbmFxmduAto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226082; c=relaxed/simple;
	bh=AsPXcytE5ztP+1VNrf4wWuEz8aj9mxCWsxLk1zjy2bw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cTGGs/rj77t/xOfwVR0LYUWZuUEJMn+aHxOEfvpgVKZPCzSMA46voAK+pMC3fiGEq99A4WMbW04l4UrI2uj90m2NsRxdcvcGtJSeqh4xX8fyvkYlRaNgznzb7fSK+kLd6f1beckpsV0SR6zMvBKETAIb0WZ6AWbVbSA5YaK4hqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sLXkEdtj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fe2d3d5cbso5003425e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 05:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707226079; x=1707830879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xI7/KH0NHB00ld6P5VJIhM1CMLUZGZ9rp5sgwbgNwbs=;
        b=sLXkEdtjn9Dl4EHV30UKLOlKMe544HozbFLg78OSqDzKyWnQIzHw42OWjZO8BqYD++
         7+xnZXlkmmcAeLsB23ccBOT4b7ZOPlC9Ih1iN1caYtRZTle8fPGYE7EtbzgoRBzkONYm
         4oAGTqNNHdfy9nx5T/2/+dS+pG7kFazQf7UoILI7JCwfxFsDIgL0J8V9M6Am49PA5LIg
         Y0mh0z4FS3oNYzO/d+XIF6zMksiID0asqgfG+u772XGgrpRHVqYIuAShGd78rF9/w1es
         sNzVajTTG4vD7ZSiG1gFgP2pp30W1gfXP7bfTzQIkmiuoMqYcKMbnhVQs50A6UK6JCmt
         XsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707226079; x=1707830879;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xI7/KH0NHB00ld6P5VJIhM1CMLUZGZ9rp5sgwbgNwbs=;
        b=AyBbeopNWA9XvLK0kEfiYC7k6S+1C4t++uY12DEajEqgP+r61rT0iqz1yrCHUws2xa
         xQ6DAF3XIht5xqyt9XQcjDR2N+fqgBdElctrgn32Afv0woKEOCNiULlW5+XLEgf+pSY+
         msD3fdGkD5GZvCLFA1WejpbL8bQQvAR//UU9QtPPfN//onXvQkxSyjBUT0y9A1jaAtOS
         d8I2VjRSZCOVrDbNtvbrorlW4eWD+K78wf//iX8GIMIwOhdCO5KRtweqyD25WMtYRDdG
         Ip+QAFlTOR10nCBsSvK64Vp0sqCUuSpbXpmZ0KKfGtscIggHnRLu/G/lJxXyAtxKBw7M
         NxUg==
X-Gm-Message-State: AOJu0YyUqOVVPcq/ACb6VmkZJT1QmsyInH01N9F1JmAgwRAb5B81WYh1
	Ci+ed54KkvX78/emFGQxjEB7JPsQBTkcSGhjKjuXGG5RkRpTt1jRAg6b6EnhEi8=
X-Google-Smtp-Source: AGHT+IGE66a+HXmhBpAAuwuHEsD7B9iHrwq5hGTevClL/2uiG3Bz7zk82woFIP4NuwfgaLKjHMg/hw==
X-Received: by 2002:a05:600c:a05:b0:40e:b17d:2f56 with SMTP id z5-20020a05600c0a0500b0040eb17d2f56mr1611695wmp.23.1707226079069;
        Tue, 06 Feb 2024 05:27:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+mL0B2jjGs9S1MeviX4+ywxyvYoX2ll8OjCImx/+qlpVb50gNIIKHA9s5lp7B1fFRykHcjvkAMDBIyQnyH5T0njwNOQxLQQLhGdO6UdIBlR8dIYEDn7Ydfzcx9TwIjDg78d3dJvTIhK0lskQHrNECmfhg2lMelw8kebrPGHR7Mn3XH1jXbxynZo/mH1twYZnbxJoYwqj63JBs4d1JfLRB2QbhzKLL/KNcieqsmrZGiReaIIYTTRNEZEEsnhQ5xRcF170ra/YQUFdpnoL4CENbvrVoMjgQm2lMa6seQf5xQ29FmuYUGH1dMLd+9Uc6XTCbG5UGmApWySTV715jhusdlj3rHYu+Dwnvm6NPXxS/HwCxUrT8EYodW3CeMHWZjS3eZT0T16zLTMGpIW8=
Received: from ?IPV6:2a01:e0a:982:cbb0:ba23:8574:fa8:28dd? ([2a01:e0a:982:cbb0:ba23:8574:fa8:28dd])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c350a00b0040ee0abd8f1sm2062538wmq.21.2024.02.06.05.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 05:27:58 -0800 (PST)
Message-ID: <23824242-1b37-4544-ae9a-0a5a0582580e@linaro.org>
Date: Tue, 6 Feb 2024 14:27:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sa8540-ride: Enable first port of
 tertiary usb controller
Content-Language: en-US, fr
To: Krishna Kurapati <quic_kriskura@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, quic_ppratap@quicinc.com,
 quic_jackp@quicinc.com, Andrew Halaney <ahalaney@redhat.com>
References: <20240206114745.1388491-1-quic_kriskura@quicinc.com>
 <20240206114745.1388491-4-quic_kriskura@quicinc.com>
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
In-Reply-To: <20240206114745.1388491-4-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/02/2024 12:47, Krishna Kurapati wrote:
> From: Andrew Halaney <ahalaney@redhat.com>
> 
> There is now support for the multiport USB controller this uses so
> enable it.
> 
> The board only has a single port hooked up (despite it being wired up to
> the multiport IP on the SoC). There's also a USB 2.0 mux hooked up,
> which by default on boot is selected to mux properly. Grab the gpio
> controlling that and ensure it stays in the right position so USB 2.0
> continues to be routed from the external port to the SoC.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> Co-developed-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> index b04f72ec097c..eed1ddc29bc1 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> @@ -503,6 +503,18 @@ &usb_2_qmpphy0 {
>   	status = "okay";
>   };
>   
> +&usb_2 {
> +	pinctrl-0 = <&usb2_en>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&usb_2_dwc3 {
> +	phy-names = "usb2-port0", "usb3-port0";
> +	phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>;
> +};
> +
>   &xo_board_clk {
>   	clock-frequency = <38400000>;
>   };
> @@ -655,4 +667,13 @@ wake-pins {
>   			bias-pull-up;
>   		};
>   	};
> +
> +	usb2_en: usb2-en-state {
> +		/* TS3USB221A USB2.0 mux select */
> +		pins = "gpio24";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-low;
> +	};
>   };

Isn't gpio-hog the preferred way to describe that ?

Neil

