Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D531E7FB682
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343904AbjK1KAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343981AbjK1KAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:00:34 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83727D53
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:00:38 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b2ddab817so36734045e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701165637; x=1701770437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=peRhsy1DaMn6+gTgUstpnReaK7YYQKqTJkP5420book=;
        b=vN76ixwTr4iE3VLcXbFKDYYy4WXJ2WuKoYHGgGOpPomtoWpZpjjFaG1mEwntQJgQNV
         1XxRPSXnHExoUITbCf/YfRCEBKjr6wWsmM5n8O2FSWkCGKIkPos3YkMrxYTItRTA9wlX
         ZA4DSgxRVG3HdQDMV35WmXipXMakNVrQAiPw+WYR5X/Tk+mGMm3m5qtkWh1GFnx3q4Sa
         KO6CFXAwGryDXbaIl1r2AoWgHaF5Q0NPj926v+sOWuatyu3r/qHXMKzA6HKUOOAy9Igd
         PgrPZs7R/kLfsUbxHtAf3hjC7PmVwK3BLsH/1uIFcKApm+pwJIWbQAbqMC+eJ9VrUvUK
         KekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701165637; x=1701770437;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=peRhsy1DaMn6+gTgUstpnReaK7YYQKqTJkP5420book=;
        b=f0EQaYc8StzT+eIUkc6MhUe2HA+u5uUj00blK+/rvcKWlgixJhhx/y+XBVcQcsn3k0
         RDhmFP0DtatgcZCqq20sa7fHJN6ZqkPZ9BtcCe3epP3LfT8HBPbgtstE4e3zmKczYMPJ
         Hx4WteZkP7wK7+ySJY7h/AdHPa/5Y34ppmXBEooI32Y6CRPp8CGFY123H5sBQVAdEmL3
         HTLI56878Kp1pkqjBGbB9NWD2TuLnwDsdDkhD6mKR7npCq1iNuUHwQVaSiNVTRT6VCUH
         m1kWJZrK1mVg65/qB493aT3gyxY90aOjwQL2qjb6Y3lLcDCwxOplWATno7GcZ9ctTxlx
         yGjg==
X-Gm-Message-State: AOJu0Yz8UOxkptRIGIJv9ROZ0v72WKsMGiPaS0/b4tA3uf3l7dXNmGT/
        SkuNcohnaEpHWdwGSHhHRsRx5A==
X-Google-Smtp-Source: AGHT+IHDGcLTwkeDwIj23rYa62iDcLBoGE0fowJPdUwmZ/8dpIcAMhAtzKy4TywgJ1iH9M2UWG+J1w==
X-Received: by 2002:a5d:4984:0:b0:332:e3f1:9656 with SMTP id r4-20020a5d4984000000b00332e3f19656mr9594958wrq.35.1701165636928;
        Tue, 28 Nov 2023 02:00:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe? ([2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe])
        by smtp.gmail.com with ESMTPSA id a2-20020adff7c2000000b003258934a4bcsm11544493wrq.42.2023.11.28.02.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 02:00:36 -0800 (PST)
Message-ID: <fbbed866-fc43-4f30-94a1-942d38103e51@linaro.org>
Date:   Tue, 28 Nov 2023 11:00:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 2/8] arm64: dts: qcom: add initial SM8650 dtsi
Content-Language: en-US, fr
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231124-topic-sm8650-upstream-dt-v4-0-e402e73cc5f0@linaro.org>
 <20231124-topic-sm8650-upstream-dt-v4-2-e402e73cc5f0@linaro.org>
 <ZWWse_i-wjSTH8O4@gerhold.net>
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
In-Reply-To: <ZWWse_i-wjSTH8O4@gerhold.net>
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

Hi,

On 28/11/2023 10:01, Stephan Gerhold wrote:
> On Fri, Nov 24, 2023 at 10:20:39AM +0100, Neil Armstrong wrote:
>> Add initial DTSI for the Qualcomm SM8650 platform,
>> only contains nodes which doesn't depend on interconnect.
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8650.dtsi | 2439 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 2439 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>> new file mode 100644
>> index 000000000000..b0a9ca53d58e
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>> @@ -0,0 +1,2439 @@
>> +[...]
>> +		timer@17420000 {
>> +			compatible = "arm,armv7-timer-mem";
>> +			reg = <0 0x17420000 0 0x1000>;
>> +
>> +			ranges = <0 0 0 0x20000000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +
>> +			frame@17421000 {
>> +				reg = <0x17421000 0x1000>,
>> +				      <0x17422000 0x1000>;
>> +
>> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>> +					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +				frame-number = <0>;
>> +			};
>> +
>> +			frame@17423000 {
>> +				reg = <0x17423000 0x1000>;
>> +
>> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +				frame-number = <1>;
>> +
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@17425000 {
>> +				reg = <0x17425000 0x1000>;
>> +
>> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +				frame-number = <2>;
>> +
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@17427000 {
>> +				reg = <0x17427000 0x1000>;
>> +
>> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +				frame-number = <3>;
>> +
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@17429000 {
>> +				reg = <0x17429000 0x1000>;
>> +
>> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +				frame-number = <4>;
>> +
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@1742b000 {
>> +				reg = <0x1742b000 0x1000>;
>> +
>> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +				frame-number = <5>;
>> +
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@1742d000 {
>> +				reg = <0x1742d000 0x1000>;
>> +
>> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +				frame-number = <6>;
>> +
>> +				status = "disabled";
>> +			};
>> +		};
> 
> Nitpick: Personally I feel the empty lines between each property here
> are a bit overly verbose. It would be better readable without them.
> Might be personal preference though :-)

I tried to maintain a coherent style across the document, so it would break it...

> 
>> +[...]
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +
>> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> 
> I'm pretty sure GIC_CPU_MASK_SIMPLE() is only valid & used on GICv2.
> Unlike arm,gic.yaml, arm,gic-v3.yaml doesn't mention "bits[15:8] PPI
> interrupt cpu mask". Also see e.g. commit 4a92b6d75bab ("arm64: dts:
> msm8996: Fix wrong use of GIC_CPU_MASK_SIMPLE()").
> 
> Would be also good to check if any existing DTs have introduced this
> incorrectly again since then.

All those platforms using GICv3 still use GIC_CPU_MASK_SIMPLE():

arch/arm64/boot/dts/qcom/qcm2290.dtsi
arch/arm64/boot/dts/qcom/qdu1000.dtsi
arch/arm64/boot/dts/qcom/sa8775p.dtsi
arch/arm64/boot/dts/qcom/sc8280xp.dtsi
arch/arm64/boot/dts/qcom/sdx75.dtsi
arch/arm64/boot/dts/qcom/sm4450.dtsi
arch/arm64/boot/dts/qcom/sm6115.dtsi
arch/arm64/boot/dts/qcom/sm6350.dtsi
arch/arm64/boot/dts/qcom/sm6375.dtsi
arch/arm64/boot/dts/qcom/sm8250.dtsi
arch/arm64/boot/dts/qcom/sm8350.dtsi
arch/arm64/boot/dts/qcom/sm8450.dtsi
arch/arm64/boot/dts/qcom/sm8550.dtsi

I'm sure you're right, and indeed the PPI affinity can be specified in an optional
4th cell, but I'll need another confirmation I can safely remove it here.

Since it's harmless, it could be cleaned up later on over all the qcom DT.

Thanks,
Neil

> 
> Thanks,
> Stephan
> 

