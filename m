Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9D478C2D3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjH2K6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbjH2K6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:58:31 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0704C97;
        Tue, 29 Aug 2023 03:58:00 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bbad32bc79so63276161fa.0;
        Tue, 29 Aug 2023 03:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693306621; x=1693911421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rSw+zZsdBWxRZgvnUvs7NGanaiI4oF3VFFFPv7LKsq0=;
        b=J6jtjDUICt4s+V+ZK9k3PI9DedsL9Q0ta0mEjj9CVdBdKSfIAdf0EsWHbuGpUiu5pL
         CP1jTolhGrcsrrW2ndg/J2/iBFPYZUxjpPEKkTYu0texSXgsQmVER2/H4r7UY+dCpmIC
         /Sj7FtnMwdD19FYSI0yOc9f1nipUJn+DClEiTiTmxFGQgdl3gqBPTjpaifVd7UFZvJiU
         tiUcJolEL24f8GWkwn6bVudQg4j7ET/cFJ0Z93TnUb7UVq1++DLR06EaamyeQXgaV+eW
         cCYmjtdL2xqCbu1dPex27x4LK4gkL2BqPWK0UvM+j72dRK+yLaLNUo51yBxGIPYtHagN
         gd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693306621; x=1693911421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rSw+zZsdBWxRZgvnUvs7NGanaiI4oF3VFFFPv7LKsq0=;
        b=VBafujPMJCuwuMv44u8qvjhfJk2H0rsPUNxOqBaGgt5u/MfnKUuLmLsr9STVvRBvcw
         kAI7SnQbMPKDxsSIeqnBJVbX85zU8zVUnEDZ+ECR5zkdvD5U0FCNIB/8A2oJRmSuw5Q1
         XgBt2VNHKxqNaq33RzAxMmRYqwbpikS+OXYjfh8i5X/ijp373H+oPIPC1r2EQQTzyJIJ
         vI9cVgE8p6ZzymnBwxGIkTgrAdqJkWEtXWueqGp/SK/yIrWUfip95xAFBWISXZ1UOFwk
         Rwx+kAWVD2MxhIgHfQFWSw+a25Rebh8zCFRrfMm+ONUgtKDS8tOqAUuNlujYxXAM5WEO
         F2vg==
X-Gm-Message-State: AOJu0YyQU43yFKj21G7AKfiD+Fh8S1C3hQXXOvw2rebvbvwyVxK+Tyr/
        QBPamQM+xiPIqjp31d7aVB4=
X-Google-Smtp-Source: AGHT+IHItxrOmL5CvTTDcK41YmH3vLVobItclhdKUlZLJZtjV1IVUDjc3nx2St+jbD2CPOZi6Gwlvw==
X-Received: by 2002:a2e:a7d3:0:b0:2bd:1908:4433 with SMTP id x19-20020a2ea7d3000000b002bd19084433mr1863677ljp.50.1693306621259;
        Tue, 29 Aug 2023 03:57:01 -0700 (PDT)
Received: from [192.168.3.32] ([188.252.220.237])
        by smtp.gmail.com with ESMTPSA id d16-20020a1709061f5000b009931a3adf64sm5921486ejk.17.2023.08.29.03.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 03:57:00 -0700 (PDT)
Message-ID: <efe09cb6-7b67-9307-28e7-99e238a3672b@gmail.com>
Date:   Tue, 29 Aug 2023 12:56:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] arm64: dts: qcom: ipq5018: enable the CPUFreq support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   Robert Marko <robimarko@gmail.com>
In-Reply-To: <f457ee94-81d0-bd28-1432-ba2828dabb79@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29. 08. 2023. 12:12, Krzysztof Kozlowski wrote:
> On 29/08/2023 11:54, Gokul Sriram Palanisamy wrote:
>> Add the APCS, A53 PLL, cpu-opp-table nodes to set
>> the CPU frequency at optimal range.
>>
>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 34 +++++++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> index 9f13d2dcdfd5..05843517312c 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> @@ -8,6 +8,7 @@
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
>>   #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
>> +#include <dt-bindings/clock/qcom,apss-ipq.h>
> c is before r.
>
>>   
>>   / {
>>   	interrupt-parent = <&intc>;
>> @@ -36,6 +37,8 @@ CPU0: cpu@0 {
>>   			reg = <0x0>;
>>   			enable-method = "psci";
>>   			next-level-cache = <&L2_0>;
>> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>> +			operating-points-v2 = <&cpu_opp_table>;
>>   		};
>>   
>>   		CPU1: cpu@1 {
>> @@ -44,6 +47,8 @@ CPU1: cpu@1 {
>>   			reg = <0x1>;
>>   			enable-method = "psci";
>>   			next-level-cache = <&L2_0>;
>> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>> +			operating-points-v2 = <&cpu_opp_table>;
>>   		};
>>   
>>   		L2_0: l2-cache {
>> @@ -54,6 +59,17 @@ L2_0: l2-cache {
>>   		};
>>   	};
>>   
>> +	cpu_opp_table: opp-table-cpu {
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp-1008000000 {
>> +			opp-hz = /bits/ 64 <1008000000>;
>> +			opp-microvolt = <1100000>;
>> +			clock-latency-ns = <200000>;
> And the rest of OPPs?
Hi Krzysztof,
IPQ5018 only supports running at 1.1GHz, but its running at 800MHz
by default from the bootloader so there is only one OPP.

I am glad to see more SoC-s gaining CPUFreq support.

Regards,
Robert
>
>> +		};
>> +	};
>> +
>>   	firmware {
>>   		scm {
>>   			compatible = "qcom,scm-ipq5018", "qcom,scm";
>> @@ -181,6 +197,24 @@ v2m1: v2m@1000 {
>>   			};
>>   		};
>>   
>> +		a53pll: clock@b116000 {
>> +			compatible = "qcom,ipq5018-a53pll";
>> +			reg = <0x0b116000 0x40>;
>> +			#clock-cells = <0>;
>> +			clocks = <&xo_board_clk>;
>> +			clock-names = "xo";
>> +		};
>> +
>> +		apcs_glb: mailbox@b111000 {
> 0xb111000 looks lower than 0x116000.
>
>> +			compatible = "qcom,ipq5018-apcs-apps-global",
>> +				     "qcom,ipq6018-apcs-apps-global";
>> +			reg = <0x0b111000 0x1000>;
> Best regards,
> Krzysztof
>
>
>
