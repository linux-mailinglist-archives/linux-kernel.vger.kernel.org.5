Return-Path: <linux-kernel+bounces-51127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F538486DC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997DA1F22F16
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FE85EE95;
	Sat,  3 Feb 2024 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tLVmp8Zx"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CDD5EE8E
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706972094; cv=none; b=n31syGdMStX2T/0i5dsVF0QgxWVutm/aqQY3IOJWJO7/BlPHovQTAr0Tl9vePa+GwYyRzgBRJXSJvpxlvd/gWweGv0uCkMy/T6CroI2D5NMSEXidFOxx2bsg1mubWrutE6XaZQXG5nq1KnGopB27mB4XSsS184Q1vMaxsx7YLxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706972094; c=relaxed/simple;
	bh=9Yrtb6dNl6HImYgM5t9N6vy88uzxettAlCzyHo53KP0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SwWrmeorpirGfkGiDmIxSv2JFxnNLe/nhxWXomC/hhJ3yjjscrUN1u8jA6tu84aNuPZ+lvXCyEUogGF5FtIMCrivP/UewulW7eWCvg+K6eZtVkwF99UKFLQN+njziLLCla6LGBMS9UlXH2cmJfKaJAxF8MLFXakYcy9Gq22hL88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tLVmp8Zx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40ef6bbb61fso25401945e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 06:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706972091; x=1707576891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9tkqvlJI491obbTK4oQ1wFNxZfPVsleOITChHyLKBE=;
        b=tLVmp8ZxSGjm157qdDIMkEjGF5T3j0KL7Hmc9sC25PB2y7R/+8mMBTuu0Iy02OcZxN
         0TENG3gnDj5H68koYcKL4IWFJOUAytBIY6G0+NS5t0be906W8JATjmNUuMqrLRMETbFT
         nR7mmAupATpjX4yNlFZsoAw2t6DUdFcnOQzW4nN3OH+GPA87p6QeXUBlcWyt/DKVw/nG
         Aeq9iICSWMxD34ifz9+nO67MtUZfwZ2Slk0iYNcUmPF2Z56wu60L0T7ybVRR6cxOntwd
         1j4rVlbtNDXmz/Tp9BenDhb/cYcYvDBXtli3+ToimCPtE19HnZeb2ZxG7YeTuGOkm89q
         NYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706972091; x=1707576891;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l9tkqvlJI491obbTK4oQ1wFNxZfPVsleOITChHyLKBE=;
        b=LgeL1APjgaz77DY3ZKdSzWX4GeQPCJdGSZC2paqQuuyQ0M6jF3uLCKxkdaXO/7fw60
         zkWXlNoKQnvU2UBMrFdYzsf2aBRf03ekwjpEf3Iz1LEBVaiA4nNlrFGYGx5wO/kHdiMB
         /pGe/CFEsjpAh0edHg9nCe5PVrJEDHht2eCMA3whgi/UwnefML6RMypJv+m7Jszyx2eT
         PkOHpwd0xrywkAtfKUKyp+A0bj9Wv1OVTsNReWjxMKif2QKp95M4lgThaE0HIGwwHmn/
         4BHu9N+LqEfXlZgqnjHSniGGXZO/RqKuplho6YojsOZgEKrOJ0wsvNe89gYxPY1I4uvf
         WPng==
X-Gm-Message-State: AOJu0YyhzZPOv8PA2Gmryz64wHTtZofWNNN8QzrJ2Q6nTiVz5wPp/Cf9
	U94YvaSLe2T1OZDwqPIuOBh9dCwzl4jLcSgEPJMigvrOZEFm/n+/DE3kZmLOx4w=
X-Google-Smtp-Source: AGHT+IHXAkBEU+4phuk0x9RIgoQbb/RVBPp7glE19zxapjl1x1NoB1M1sSuHmDXgk0zB4Aiuntw8jQ==
X-Received: by 2002:a5d:4d10:0:b0:33a:fdc3:a61c with SMTP id z16-20020a5d4d10000000b0033afdc3a61cmr3548775wrt.31.1706972090927;
        Sat, 03 Feb 2024 06:54:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVRCzHtAxcuO8mrR+BHEE9m2OUgtXZvH24s2X8wVEUHdg3dAJKrtQBscD0H9UBYB7EQTgfgy8gxbJjpr8clQA5C7Mm6+M7aL2StC2EeuzuRMH3KTyk3Nj1Fxjq5KHqIaIQTUqkbVXrIthqr/naK88+8SIZYQJw0LAhy10KuS88w9UTyIypyCOsLxwYBT9P8CDha26LwfKrhX+Qu/t1kfO2yIOcC2Qj+SYc7hPx1nmC8wB3ehPpE7dis7hP3LxrJmjFhf5zletxBIsljJ3rzSQSiMrstw9Fxn+C+ZrkShRhPhmENeGTq5g==
Received: from ?IPV6:2001:67c:1810:f055:5044:617a:60fb:ed01? ([2001:67c:1810:f055:5044:617a:60fb:ed01])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d6b87000000b0033b0d2ba3a1sm4210200wrx.63.2024.02.03.06.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 06:54:50 -0800 (PST)
Message-ID: <74968e8f-1a14-4044-933d-528af39e61b7@linaro.org>
Date: Sat, 3 Feb 2024 15:54:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8550: Switch UFS from opp-table-hz
 to opp-v2
Content-Language: en-US, fr
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240203-topic-8550_ufs_oppv2-v2-1-b0bef2a73e6c@linaro.org>
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
In-Reply-To: <20240203-topic-8550_ufs_oppv2-v2-1-b0bef2a73e6c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/02/2024 01:10, Konrad Dybcio wrote:
> Now that the non-legacy form of OPP is supported within the UFS driver,
> go ahead and switch to it, adding support for more intermediate freq/power
> states.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Extracted out of:
> https://lore.kernel.org/linux-arm-msm/15d2bd66-29f3-435b-8494-d82ec4036413@linaro.org/#t
> 
> Changes since v1:
> - Set the reference clock rate to 0 in opp entries, it doesn't support
>    ratesetting anyway. Confirmed UFS still works.
> ---
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 50 +++++++++++++++++++++++++++++-------
>   1 file changed, 41 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index c89d8f3dad21..144e20edf237 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -1966,6 +1966,7 @@ ufs_mem_hc: ufs@1d84000 {
>   			iommus = <&apps_smmu 0x60 0x0>;
>   			dma-coherent;
>   
> +			operating-points-v2 = <&ufs_opp_table>;
>   			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI1 0>,
>   					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
>   
> @@ -1986,18 +1987,49 @@ ufs_mem_hc: ufs@1d84000 {
>   				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
>   				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
>   				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
> -			freq-table-hz =
> -				<75000000 300000000>,
> -				<0 0>,
> -				<0 0>,
> -				<75000000 300000000>,
> -				<100000000 403000000>,
> -				<0 0>,
> -				<0 0>,
> -				<0 0>;
>   			qcom,ice = <&ice>;
>   
>   			status = "disabled";
> +
> +			ufs_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-75000000 {
> +					opp-hz = /bits/ 64 <75000000>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <75000000>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +				};
> +
> +				opp-150000000 {
> +					opp-hz = /bits/ 64 <150000000>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <150000000>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>;
> +					required-opps = <&rpmhpd_opp_svs>;
> +				};
> +
> +				opp-300000000 {
> +					opp-hz = /bits/ 64 <300000000>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <300000000>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +				};
> +			};
>   		};
>   
>   		ice: crypto@1d88000 {
> 
> ---
> base-commit: 076d56d74f17e625b3d63cf4743b3d7d02180379
> change-id: 20240203-topic-8550_ufs_oppv2-bb88d63a4c58
> 
> Best regards,

Looks fine:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Let me have a test run with it first before applying.

Neil

