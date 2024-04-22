Return-Path: <linux-kernel+bounces-153677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C8A8AD18C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20601F21313
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7D8153518;
	Mon, 22 Apr 2024 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AT/1j9Zr"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2639E153585
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802058; cv=none; b=C/velx6qlbah7QUxfwns3u1R1MYQYRBD91XOuUf97gtJ7Qf1B127zyNfJfUlS48qDqwismw/sa75EwqXRZU44VkWlgTL2Css5wraa1TTmOclLigx9tDfkOEBW/BCjLyU9YkXLFxOAH9zSZQWQl9oXnqIXoX6+iy2nmDFDxqxfrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802058; c=relaxed/simple;
	bh=0MpppCeAGRGqoLAeeDV5dqYgLXIhh9N0FJAVoQeSrB0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=U2DDvN1HjFyojH2CnJuaG51PqeWfNB0G5zn1JssURwWIsMO4jdnaim/r/5lxQjJvIxrE9ro93zkNZXID6Sk1/nej9nan30tF3a7x1KF6Ibz+RwdPpt6p+EIhFLa6phYJRFhrzq3ZY1P9hORWCYdBTUstfUKx5Agma0xY5yTg3aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AT/1j9Zr; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2dd6c160eaaso16447891fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713802053; x=1714406853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rV5YhSHRl9//iqDa2BiuSCB2EW4ixdSWZiS3tQXSouc=;
        b=AT/1j9Zr/v5V+AuRycg1xWFleNsiX7J28EygEjNgW0qVDm3+V/9OyawOuoMiM5/z4i
         57yOfWHa8zqiiwa5Fnz/mmfctcFhDNFIVgNgNjgTDUNXABLfrjRIQmG+JzxETUt6QKGw
         TMTr/erXv68sxpAaRwisArplqjPA29MxVur51A9gu1R79MZNSqL/bN8AHcAr1U+iGMlu
         3b1nZcxx9ODRuw30KJjnSOKRqT3LykU0Ko1JsvHDqQHILQi0sR2eCWPoCUK6NLIyAlBt
         FItjQ9Zog0CiUWMJrw63lS2WQfDDS395O1KB9FgFRP0rtMC6YrficBQxfS/bJN4FdsmX
         IoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713802053; x=1714406853;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rV5YhSHRl9//iqDa2BiuSCB2EW4ixdSWZiS3tQXSouc=;
        b=Gv8lGJn66RAH0aCSKPWz2iv89Zw9w4ib87fSET2clM299L62ZwtXsYDutgdAooLa8v
         8fD9OrigWM2oDnpT3OJrcGTuRD0UxcYZ13gpXdXodlcNJqXvxfL23wdfM6/NZw4nu5xt
         x0a5vrwjI5SJXTGEiF5V2hRtr8PP2YGlkok3q0GMBcPyyTvP7ukJDC5Y2Jz625kt3qVu
         k/oNanZY4x9JRSoz5U/RXv9Xt1LoNtjO3dnXKTK5n648BB0k5Jtp9ybicv7Mnm3GNaTj
         l6qbWdvJWktn1J6c2qDP/85nQDirNsc3l2wCyAA/LUNZ1yhVOtywd3t/soYQaQIqvK9H
         KjhA==
X-Forwarded-Encrypted: i=1; AJvYcCVLAA8Fc/EglJ3ZDM7D3m6aThgaQdo1p78kquzWqzXHF7f/HVh1db2N3R7kgGUsXfCYf8yzp1D5wil4Ou598r9ymQC1FUp7FhNIlMrG
X-Gm-Message-State: AOJu0YzVz7VA7Jz6lJFG+qauFnvjNHFOIp8Im15LmQY/9o52qttmwebr
	geuZHx6M/N6Qo2PENSJ9pnbP+CggM7xZX/HIfMoA3YAgtFjqyPMkYfLVksyvfdo=
X-Google-Smtp-Source: AGHT+IH8eWW2BXlr/BFcs+LhyLxysUqw8CXmw+UlSNai+Eyp44b0clJUmsx90/mDvUjyTf6hUWW7kA==
X-Received: by 2002:a05:651c:19ac:b0:2dd:2e6c:21c6 with SMTP id bx44-20020a05651c19ac00b002dd2e6c21c6mr5668327ljb.2.1713802053058;
        Mon, 22 Apr 2024 09:07:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e5e5:892f:e81f:7cad? ([2a01:e0a:982:cbb0:e5e5:892f:e81f:7cad])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b00416e2c8b290sm21158551wmo.1.2024.04.22.09.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 09:07:32 -0700 (PDT)
Message-ID: <855a97c3-f96a-4606-a25e-a063a96782d1@linaro.org>
Date: Mon, 22 Apr 2024 18:07:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 0/3] arm64: qcom-sm8[456]50: properly describe the PCIe
 Gen4x2 PHY AUX clock
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>
References: <20240422-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v3-0-799475a27cce@linaro.org>
 <171378646293.749182.6639047187760279527.robh@kernel.org>
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
In-Reply-To: <171378646293.749182.6639047187760279527.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/04/2024 13:50, Rob Herring wrote:
> 
> On Mon, 22 Apr 2024 10:33:10 +0200, Neil Armstrong wrote:
>> The PCIe Gen4x2 PHY found in the SM8[456]50 SoCs have a second clock named
>> "PHY_AUX_CLK" which is an input of the Global Clock Controller (GCC) which
>> is muxed & gated then returned to the PHY as an input.
>>
>> Document the clock IDs to select the PIPE clock or the AUX clock,
>> also enforce a second clock-output-names and a #clock-cells value of 1
>> for the PCIe Gen4x2 PHY found in the SM8[456]50 SoCs.
>>
>> The PHY driver needs a light refactoring to support a second clock,
>> and finally the DT is changed to connect the PHY second clock to the
>> corresponding GCC input then drop the dummy fixed rate clock.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> Changes in v3:
>> - Rebased on linux-next, applies now cleanly
>> - Link to v2: https://lore.kernel.org/r/20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-0-3ec0a966d52f@linaro.org
>>
>> Changes in v2:
>> - Collected review tags
>> - Switched back to of_clk_add_hw_provider/devm_add_action_or_reset to maintain compatibility
>> - Tried to use generic of_clk_hw_onecell_get() but it requires to much boilerplate code
>>    and would still need a local qmp_pcie_clk_hw_get() to support the current #clock-cells=0
>>    when exposing 2 clocks, so it's simpler to just return the clocks in qmp_pcie_clk_hw_get()
>> - Link to v1: https://lore.kernel.org/r/20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-0-926d7a4ccd80@linaro.org
>>
>> ---
>> Neil Armstrong (3):
>>        arm64: dts: qcom: sm8450: remove pcie-1-phy-aux-clk and add pcie1_phy pcie1_phy_aux_clk
>>        arm64: dts: qcom: sm8550: remove pcie-1-phy-aux-clk and add pcie1_phy pcie1_phy_aux_clk
>>        arm64: dts: qcom: sm8650: remove pcie-1-phy-aux-clk and add pcie1_phy pcie1_phy_aux_clk
>>
>>   arch/arm64/boot/dts/qcom/sm8450.dtsi    |  8 ++++----
>>   arch/arm64/boot/dts/qcom/sm8550-hdk.dts |  4 ----
>>   arch/arm64/boot/dts/qcom/sm8550-mtp.dts |  4 ----
>>   arch/arm64/boot/dts/qcom/sm8550-qrd.dts |  8 --------
>>   arch/arm64/boot/dts/qcom/sm8550.dtsi    | 13 ++++---------
>>   arch/arm64/boot/dts/qcom/sm8650-mtp.dts |  4 ----
>>   arch/arm64/boot/dts/qcom/sm8650-qrd.dts |  4 ----
>>   arch/arm64/boot/dts/qcom/sm8650.dtsi    | 13 ++++---------
>>   8 files changed, 12 insertions(+), 46 deletions(-)
>> ---
>> base-commit: f529a6d274b3b8c75899e949649d231298f30a32
>> change-id: 20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-4b35169707dd
>>
>> Best regards,
>> --
>> Neil Armstrong <neil.armstrong@linaro.org>
>>
>>
>>
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>    pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y qcom/sm8550-hdk.dtb qcom/sm8550-mtp.dtb qcom/sm8550-qrd.dtb qcom/sm8650-mtp.dtb qcom/sm8650-qrd.dtb' for 20240422-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v3-0-799475a27cce@linaro.org:
> 
> arch/arm64/boot/dts/qcom/sm8550-qrd.dtb: clock-controller@100000: clocks: [[41], [42], [43], [44, 0], [45, 0], [45, 1], [45, 2], [46, 0]] is too short
> 	from schema $id: http://devicetree.org/schemas/clock/qcom,sm8550-gcc.yaml#
> arch/arm64/boot/dts/qcom/sm8550-qrd.dtb: clock-controller@100000: Unevaluated properties are not allowed ('clocks' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/clock/qcom,sm8550-gcc.yaml#
> 

Ok thx, I found out why, sending a v4 fixing that

Neil



> 
> 
> 


