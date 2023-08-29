Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE8778C31E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjH2LLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjH2LK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:10:57 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39F1FF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:10:53 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-500b6456c7eso3593445e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693307452; x=1693912252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0r2GjALbWtOQSWtEI0zRkNY6QzBe9xzJHAY3ewhrC4c=;
        b=pZ1LoshjGQVaUbh88Ob9zvAlxushJcciivYWBYhFcHdriEAgLklhIcARi0uHyRpDE0
         99OcSofOZgVnXFlBEv9CTauF+0V9br1FzAmIMSv/NKEpbxGhYjzuBhKB4qd7ZxvPDexm
         cdoHZSWULazsYv/LA2LqUfqQeTRZN9ORgyZMgVEMIOJrpbugBDQhiAe80r7l6sxFSudc
         aQXqr1vecodTCeSjBCkXUN9U4NbQOdl5ScuLjRjfjuCyBECwUwW+ZPjNcU7NlLmNzZtY
         HuWmmEjGt7kZZDDU+9iVkW8p7wSoqqMZK6NbOMVaY44JiJlnDk6rNNO0Grfz40ql3Zow
         l+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693307452; x=1693912252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0r2GjALbWtOQSWtEI0zRkNY6QzBe9xzJHAY3ewhrC4c=;
        b=Ov3MM6A81ID42RZrh64iHoI4rP+D77RViZF8FiDay1Jp+cDjWafulu+sAZYpiG8qcm
         9+WBCide5Sp1hgh1zs7zdDl/3ASWclMsuSdPh12Jxhx89sNSo2aEIjD7C25vKgpgue4A
         E09BtTOgT+ogceTSoO7GnEHet/29aaU403I61+XWlKRkwClGQUkkimQv1zVYx4ICUtyS
         2t8JtGKT5IIhQjpJGFR8eGHmruVO8U5iMG1imyaG0n7L/r+B1TYeqXX1dW51Vvbx6ESW
         S1rze+1SvNSt2NvqWSjk1GrLhNmP4nxkEnTwAW/HjIIYtXd6NZdSJFz1V9ImHYiflFoL
         epWQ==
X-Gm-Message-State: AOJu0YyhspBMT7w+4fIqG3N07W0liPLne6AXOjlf1PDw+aDy3MTr6W9p
        TLOYFtTX1gBNlimlyvUosindHg==
X-Google-Smtp-Source: AGHT+IER1IFZ7/ug9j7OI1vTIHvLWZqoJWfIPZIKhx7eIjEo3PLnmdqCA57+CNtMw5SZZ9zIk5GY1g==
X-Received: by 2002:a05:6512:2395:b0:4fb:73ce:8e7d with SMTP id c21-20020a056512239500b004fb73ce8e7dmr25341399lfv.15.1693307451972;
        Tue, 29 Aug 2023 04:10:51 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id t7-20020aa7d4c7000000b00529fa63ef6fsm5551036edr.57.2023.08.29.04.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 04:10:51 -0700 (PDT)
Message-ID: <0941e2f4-6b58-a4e7-3dda-c1723f5503ac@linaro.org>
Date:   Tue, 29 Aug 2023 13:10:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/3] arm64: dts: qcom: ipq5018: enable the CPUFreq support
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_varada@quicinc.com, quic_srichara@quicinc.com
References: <20230829095423.760641-1-quic_gokulsri@quicinc.com>
 <20230829095423.760641-4-quic_gokulsri@quicinc.com>
 <f457ee94-81d0-bd28-1432-ba2828dabb79@linaro.org>
 <efe09cb6-7b67-9307-28e7-99e238a3672b@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <efe09cb6-7b67-9307-28e7-99e238a3672b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 12:56, Robert Marko wrote:
> 
> On 29. 08. 2023. 12:12, Krzysztof Kozlowski wrote:
>> On 29/08/2023 11:54, Gokul Sriram Palanisamy wrote:
>>> Add the APCS, A53 PLL, cpu-opp-table nodes to set
>>> the CPU frequency at optimal range.
>>>
>>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>> Signed-off-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 34 +++++++++++++++++++++++++++
>>>   1 file changed, 34 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> index 9f13d2dcdfd5..05843517312c 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> @@ -8,6 +8,7 @@
>>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>   #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
>>>   #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
>>> +#include <dt-bindings/clock/qcom,apss-ipq.h>
>> c is before r.
>>
>>>   
>>>   / {
>>>   	interrupt-parent = <&intc>;
>>> @@ -36,6 +37,8 @@ CPU0: cpu@0 {
>>>   			reg = <0x0>;
>>>   			enable-method = "psci";
>>>   			next-level-cache = <&L2_0>;
>>> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>>> +			operating-points-v2 = <&cpu_opp_table>;
>>>   		};
>>>   
>>>   		CPU1: cpu@1 {
>>> @@ -44,6 +47,8 @@ CPU1: cpu@1 {
>>>   			reg = <0x1>;
>>>   			enable-method = "psci";
>>>   			next-level-cache = <&L2_0>;
>>> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>>> +			operating-points-v2 = <&cpu_opp_table>;
>>>   		};
>>>   
>>>   		L2_0: l2-cache {
>>> @@ -54,6 +59,17 @@ L2_0: l2-cache {
>>>   		};
>>>   	};
>>>   
>>> +	cpu_opp_table: opp-table-cpu {
>>> +		compatible = "operating-points-v2";
>>> +		opp-shared;
>>> +
>>> +		opp-1008000000 {
>>> +			opp-hz = /bits/ 64 <1008000000>;
>>> +			opp-microvolt = <1100000>;
>>> +			clock-latency-ns = <200000>;
>> And the rest of OPPs?
> Hi Krzysztof,
> IPQ5018 only supports running at 1.1GHz, but its running at 800MHz
> by default from the bootloader so there is only one OPP.

Isn't this contradictory? If it is running at 800 initially, then it
supports running at 800...


Best regards,
Krzysztof

