Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387937FEC38
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbjK3Jw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbjK3Jw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:52:56 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E4810E5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:53:01 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b397793aaso4025475e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701337980; x=1701942780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VX9OtQcXfdg8VOb659Uu3GVae5kVEXsq6e2PqcBRuP8=;
        b=OSDbyNPuxEbjuamGdmsxp/Nd9pNRqVtKBmnbsVRQ7Gk7EC9lAIeCp3rGTXyqX+wYGK
         1bkM4ZBRg6bIvB8WNh0P2fccAnxaek6Tae6ICUOAG3cNwhSBtTSrS8vl4gyohEOF4umR
         7GO3J7FZjlmga4qAMPjgCen4pWHEv/fKiq2dU02G+F5tBsha+qa1sQBdBPUTjwnobAVB
         GEKT/0O1ogu0xowPI6YK4voU2HtqXdEaJYeketugQx7GFhEmKmWsC/1bxU0un+nZSQsZ
         uSdtAsDMoIbyn9XfrDCiIRJZSOGmK4owU6YjTgUnYJmEaBMJ3xNouZkAuX9dOt9NwTHd
         oJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701337980; x=1701942780;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VX9OtQcXfdg8VOb659Uu3GVae5kVEXsq6e2PqcBRuP8=;
        b=SXtA7xBBt6TjlnVgrCdKsjj/BcJAPOKGsqyExBwrsqiWZRVQeNBKPMUxOnESw7tnr6
         +1+8RRJHwRBRK2SJj55PRkL73AQkUmCWpfVglR4U47QWozhDVf31TW25CZorUKfgLCw8
         +oXQHNIo2oodETDCKJuMo6AkL/nLkgRxIhHcQFJ07OG1F774Y9Ueu4yqG6Oui6o4guY1
         XDDl1uayF6llBD2l0NIexpS0TamMwbyDNRn5woyDaBQdRI5ZorkQkWYwrKX35zvpUiQt
         PCqpn0PQCuAJ3aDWogitdQpNLVVwmmG65M+TqxsomPmx6Y4VBgs8V2XQ6+ar1Zn5geQM
         tU5Q==
X-Gm-Message-State: AOJu0YyhhZoV6Egdy3IZXklv3TapiCjEG43sIMc6Rn4NkANQ4eGDKe6a
        AVhE39O2QLG9dHfc5m8yyTTpcg==
X-Google-Smtp-Source: AGHT+IHHl2mg78BXo5WweteQ1vmiNkQtS/uB8Mw5r+/FfhpNISnN4kbE+gb6c/yEJdDyK5K6Rat8hg==
X-Received: by 2002:a05:600c:3550:b0:40b:4072:54de with SMTP id i16-20020a05600c355000b0040b407254demr12497610wmq.13.1701337980309;
        Thu, 30 Nov 2023 01:53:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:41c9:3acd:a6e2:5242? ([2a01:e0a:982:cbb0:41c9:3acd:a6e2:5242])
        by smtp.gmail.com with ESMTPSA id p36-20020a05600c1da400b0040b478da760sm1358964wms.48.2023.11.30.01.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 01:52:59 -0800 (PST)
Message-ID: <995fae78-0fe7-4fe3-a42b-2b9397f0d555@linaro.org>
Date:   Thu, 30 Nov 2023 10:52:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8550: correct TX Soundwire clock
Content-Language: en-US, fr
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231129140537.161720-1-krzysztof.kozlowski@linaro.org>
 <20231129140537.161720-2-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20231129140537.161720-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2023 15:05, Krzysztof Kozlowski wrote:
> The TX Soundwire controller should take clock from TX macro codec, not
> VA macro codec clock, otherwise the clock stays disabled.  This looks
> like a copy-paste issue, because the SC8280xp code uses here correctly
> clock from TX macro.  The VA macro clock is already consumed by TX macro
> codec, thus it won't be disabled by this change.
> 
> Fixes: 61b006389bb7 ("arm64: dts: qcom: sm8550: add Soundwire controllers")
> Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 52e8f4c52426..2fd3faacf554 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -2199,7 +2199,7 @@ swr2: soundwire@6d30000 {
>   			interrupts = <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
>   			interrupt-names = "core", "wakeup";
> -			clocks = <&lpass_vamacro>;
> +			clocks = <&lpass_txmacro>;
>   			clock-names = "iface";
>   			label = "TX";
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
