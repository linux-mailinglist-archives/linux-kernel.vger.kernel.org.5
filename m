Return-Path: <linux-kernel+bounces-51281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D498488A8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 21:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1DFAB23B37
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201C85FDC8;
	Sat,  3 Feb 2024 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="owdTVPnF"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DAE5FDB9
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 20:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706991171; cv=none; b=nsuTljYM/8HbHRcNttv3uoIzlxoAUiDHQ7/NB6WBymKeZiPFsFO/X6RxB6mcrTDFtyAElHcM1QPQdMnszTuFi4VOvdZEG0+8NEiDZXvOmvYk9gWft1Y8z6aljJy9IL5JgdQSQJT28T58nJH11ca5+xP/GXI9S3IwjmtjRixRFLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706991171; c=relaxed/simple;
	bh=XMiuwDIpVjrwT8pZFL8FTDbig4Uonmz+QY2PmFoT1mE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cr6bpTlxrVgPCV5CUIeNzYDNcXiu3hCeIFt1GLm24qG0KhJyKT+cFVi4GslLmpasT+/aZXYpXgysh9+7cAspYiHS+gMFyDKTmvBeBp37dlQLk+XCauxjuJkkizfq44yqvB9nhqyXYYIMxOC6j4mXhf89SYT9JWLxv23dTB0ka6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=owdTVPnF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33b1d7f7366so1260057f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 12:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706991168; x=1707595968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ahih9RgEoYwMlpRdersewynKDFZTyq1Vc8lHuD3WPU=;
        b=owdTVPnFkM8bUZpBPMHYSxtCL+c1fqBIfzb6HhzQ29vPbe7sIjFrythraCV0ZddV9E
         t5VDNAUQhTBpkMYIq4FYwlxWW9JZVC+NB/YBqTaAgyDHjBg/IiMNgX3hl0r+7q4cO8wH
         5laT8hhGG9o3TaPD932Igq3Yjal4mL+BGriPVIQcJQJK1QYZNogYzKpsLiQGd8AYU/2F
         P6Fe2pUn4OOrmF31D/OfTRDr+rmHZP6XoRnLiRvzNWWHXC+22PS3//vTweuWvTPPjSA9
         tkvB2w48nMTMt6ItXh3QAjBIGqD2y3okPSyildYrOc3U5tDGfJj6EKiVh2AM3Q10NG50
         yDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706991168; x=1707595968;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8ahih9RgEoYwMlpRdersewynKDFZTyq1Vc8lHuD3WPU=;
        b=ZvNJ7Tuh/qVgofze1eqJ4L0ZXg7UUjSZ7bcBUXzSS7a4SoufiqyMdYP94kRe62ReL7
         3KONOsItgGS3zRJ138Bgx61pS0LfiZ2jITTSALqdrkghT8roZ40WtyB2wlxJVfbITpIm
         Egh8Z+QYUpo2wGEK+e84Eeq9b1lUatLm/91bNmfYRunoCezlEebcnC9+LQsney4XGmJu
         SwwyNSX8jy0TAoTT3va66d65Vl5OqwDLOx6Hx/6nvKaCAWGv/0ewycDJWI0D49ipALru
         tU14Ppnmo0ieknerhcFHmGISfeUsamRFVKbkTZynI3nQiDh8ueduiMYButQ4Eka8O0W4
         culA==
X-Gm-Message-State: AOJu0YwDB8Umc5thWy4qK64ROrlVP+QIlXXjXfMh26aCFlsoBZAXVf8r
	ISObgscQN9GpIPbaFl3kMNb5hb1IyhZuw8hkiKSn56Vx2QO8lgAqAZLul04LAP4=
X-Google-Smtp-Source: AGHT+IEBMgd3qvNtSGTG9qXtLL492Vflm5wg+fXnH0hHmn45E1sCU1TVe1l1l+2xL2zvDe6NgjaCpA==
X-Received: by 2002:a5d:644a:0:b0:33b:182f:eb9d with SMTP id d10-20020a5d644a000000b0033b182feb9dmr4393583wrw.43.1706991167596;
        Sat, 03 Feb 2024 12:12:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXddspYHgSOlgLatjC0n0l4mR2eo0YQjWGgViZn2aPK1M3eDvdCRySgBLTL2bu+czyfKf8zqPUey8UMnHYyZMujdV6LB7kPkzsb2usDwkj5cfBwFnM7xKXFKwQdbgcjxsimp1sDbiQ0aifIwTnRu/nluSRQUL4sBIM5J+Lgxvt90RL7Z2Ve/WdXJ6yMot53XmKaAhVD/fsADY0h5784L+GAAtzxfVbU1NaOQ/caOfWcUpYb/LbOehPQ+FImUmpqoYswjD49xbQPTM6QPtOWvd4L8vYRCFVuuFnSR/4iFY6sQyvi/oza7w==
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4f08000000b0033b15fdad42sm4662053wru.34.2024.02.03.12.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 12:12:46 -0800 (PST)
Message-ID: <a594ca1e-bef6-4ce9-b5c7-02999969a756@linaro.org>
Date: Sat, 3 Feb 2024 21:12:37 +0100
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

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD

