Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2417EF0BF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345745AbjKQKlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345781AbjKQKlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:41:11 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62F61A1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:41:07 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso23906071fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700217666; x=1700822466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mw4HRiUCk/Doy4cjgHODSEEb9fobmzOoP3kKgYZym14=;
        b=CAjeTB/0cVq5thlYdwcM0cN2d0m+21XgekVP9d9r9qC+fgc5JtGDWWzVpRmtZpNVml
         cvIwI5lIasBgTkQw5Op3FkSGckI9cSB/jLGWj0djd8b0Cm1pgUBZuGB3RBoW3IBwPvR8
         JBJFnqQDpkfrai8zARbW9yQdQ9VuOGeyLcIA45puWTYVDuCHcO7dWGOlSc7pMtVI3X5s
         BBSsRpJLnUVAcyRnfMlAwuSb66ulMP+ZdceHLw7avdGgsjWkZagZhB+WHHgoZDi57Nig
         iWUj1iVT3oxgFhOosmyitdRqnqUW5EAHT0gc4Gal/jCLYi1sMsNJjFqx5iTToQC8WfQC
         yR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700217666; x=1700822466;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mw4HRiUCk/Doy4cjgHODSEEb9fobmzOoP3kKgYZym14=;
        b=GvhOHs0dajGxATv1w5ealgOBAB4U9baU1omq7XpkpynsS5rwnl65Xfe7NgWvzThQN2
         0KHKb11wIvjnIXrSGetJJe8QAFFUHGTQZoHHDrxvHwdJZUTNtUlOB2BxS4YT2jqVMmYP
         +DCbGR/PeJomYoMMZbDmlLthMffT+Pgfed1sCrgQxoA9Y9fEtS6S21qKzBJo0wxgrBw7
         kTKTQKYeUq1sV9VBEe6m7js7U7Dy8KAmipj1SaKt3VPNhT6kGJL7V/hXvuok1dGR5Sft
         EtaoBXtR2xT44+7XgTyIWTy0ycDgf/Uzqs55vxxJ7T7y+6IdrbtBlLNq65y8qo3wuXT0
         gOOQ==
X-Gm-Message-State: AOJu0YznYOZTElVfgFQzteDsHbLAdOj7nfDQbITEg/dSQUl1kOakRY+K
        jHozoQ3B1uwp84cJ3oJhhHvqXg==
X-Google-Smtp-Source: AGHT+IGIqp9+SOQlbf1VSxJyUVykN8s+rSSZd9z9CNa3yPMJGm2Wwo3Xl7+OnSLwDaVGp6wVzgC7VA==
X-Received: by 2002:a05:651c:20c:b0:2c6:f711:cea1 with SMTP id y12-20020a05651c020c00b002c6f711cea1mr10048056ljn.39.1700217665860;
        Fri, 17 Nov 2023 02:41:05 -0800 (PST)
Received: from [192.168.7.188] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b0040a45fffd27sm6751494wmq.10.2023.11.17.02.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 02:41:04 -0800 (PST)
Message-ID: <247f4654-ec65-4857-8b35-1a79088e8b87@linaro.org>
Date:   Fri, 17 Nov 2023 11:41:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 07/16] arm64: dts: qcom: sm8550-aim300: add PCIe0
Content-Language: en-US, fr
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, -cc=kernel@quicinc.com
References: <20231117101817.4401-1-quic_tengfan@quicinc.com>
 <20231117101817.4401-8-quic_tengfan@quicinc.com>
 <37a3a407-07e7-49d8-bbce-b1dac8cfcf5a@linaro.org>
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
In-Reply-To: <37a3a407-07e7-49d8-bbce-b1dac8cfcf5a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2023 11:29, Dmitry Baryshkov wrote:
> On 17/11/2023 12:18, Tengfei Fan wrote:
>> Add PCIe0 nodes used with WCN7851 device.  The PCIe1 is not connected,
>> thus skip pcie_1_phy_aux_clk input clock to GCC.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8550-aim300.dts | 32 ++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8550-aim300.dts b/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
>> index 202b979da8ca..3aca0a433a00 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
>> @@ -393,6 +393,38 @@
>>       };
>>   };
>> +&gcc {
>> +    clocks = <&bi_tcxo_div2>, <&sleep_clk>,
>> +         <&pcie0_phy>,
>> +         <&pcie1_phy>,
>> +         <0>,
>> +         <&ufs_mem_phy 0>,
>> +         <&ufs_mem_phy 1>,
>> +         <&ufs_mem_phy 2>,
>> +         <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
>> +};
> 
> NAK, this should go to sm8550.dtsi unless there is a good reason.

Actually this is how QRD8550 was designed, so it's fine to mimic.

Neil

> 
>> +
>> +&pcie_1_phy_aux_clk {
>> +    status = "disabled";
>> +};
>> +
>> +&pcie0 {
>> +    perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
>> +    wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
>> +
>> +    pinctrl-0 = <&pcie0_default_state>;
>> +    pinctrl-names = "default";
>> +
>> +    status = "okay";
>> +};
>> +
>> +&pcie0_phy {
>> +    vdda-phy-supply = <&vreg_l1e_0p88>;
>> +    vdda-pll-supply = <&vreg_l3e_1p2>;
>> +
>> +    status = "okay";
>> +};
>> +
>>   &pm8550b_eusb2_repeater {
>>       vdd18-supply = <&vreg_l15b_1p8>;
>>       vdd3-supply = <&vreg_l5b_3p1>;
> 

