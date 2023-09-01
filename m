Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70C678FF9E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350102AbjIAPEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347216AbjIAPEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:04:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9069F10CF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:04:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe32016bc8so21366345e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 08:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693580649; x=1694185449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IWnLKgy4psQAOPCmq/KJu4X6vCCHFBpqjxEL4HJlAgs=;
        b=n+wE5ieHXurAgi1byUSaX4KsGtfy3zHADC/OQfi33+CpznUU88VFfpnwzeadHwAB9X
         p7E6XSZl8+Abe807eKpCY7RWgOJI5o+tUU/A7Xu976iTwL1jq2IJCCWyFp21lq4Ts7i7
         zWDJsHJSts+DpNLsrvpIROaS4vKL8qSU3Pxv2wr1CvrjE8gXAYv4oAFzYrPCjsD2N0ts
         BxiucjC8NLNTf48cAn4tzId3mPxfiprB93zTnetJR29kx2PzhipHbxyTMg4TN0Z459qB
         b4aTJeCL6Mp8DLa9ivC8f3UO8atxx/SKLgoksCMUDZCeVuIsA8YgpZ7xHGSRgSjBjC+4
         8Kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693580649; x=1694185449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IWnLKgy4psQAOPCmq/KJu4X6vCCHFBpqjxEL4HJlAgs=;
        b=lMukNpXvSSW0oX3zrbxsK/xp4LR4JMNR5EnWYteCIpaRmuqsmTdFJNPwFkuoz5Zq5d
         /5RaJ+e2509L+azMwehlXU7sg+fh97Ra7RaDQAhbiuA4jfFJdamRCTETvYdtyeRCWoD3
         yl7dF1GHwAnEbE1XIAOZg94Kq/GMhJDdcmSKXxE+NkXw844Ag6wyIbDTp0icWV6w5D9Y
         avtmjai5bkyTpQo4Xc7D4TUkl7eXfblF2DQuznfNAUwUdhLSyEbyv/Zn+2qlYfunwQHc
         qgd1G9MmASmJKbN7MY/mobMR4i48T5sZh7Ndb5xMzFD+D1uoMGAMh84oIFEGtRU/0iY5
         AT7g==
X-Gm-Message-State: AOJu0YxGVUE76wEsxUNnQ9ylPigG0+2+YpdfbuDXds3f8o7zc2wPXc5M
        udBrXq3IHMKfD88/8uHMut5hpA==
X-Google-Smtp-Source: AGHT+IGhXUcSeTC1y/HbwZL6d49yRvC6KlJjPuI32snrfXHFombXdShnxsysYVpAb4HQE5xETHL9yw==
X-Received: by 2002:a05:600c:205a:b0:401:264b:5df7 with SMTP id p26-20020a05600c205a00b00401264b5df7mr1938908wmg.35.1693580648493;
        Fri, 01 Sep 2023 08:04:08 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c379200b003fee65091fdsm8347949wmr.40.2023.09.01.08.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 08:04:07 -0700 (PDT)
Message-ID: <b6fa8337-a5c0-172a-a41b-ab18de3f4f72@linaro.org>
Date:   Fri, 1 Sep 2023 16:04:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] arm64: dts: ipq5018: Correct uart1_pins pinconf
Content-Language: en-US
To:     Ziyang Huang <hzyitc@outlook.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_gokulsri@quicinc.com, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <TYZPR01MB5556D24A77DAFA013F93B551C9E4A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <TYZPR01MB5556D24A77DAFA013F93B551C9E4A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2023 15:10, Ziyang Huang wrote:
> In pinctrl, the pinconfigs for uart are named "blspX_uartY".
>    X is the UART ID. Starts from 1.
>      1-6 are in BLSP Block 1.
>      7-12 are in BLSP Block 2.
>    Y is the index of mux config. Starts from 0.
> 
> In dts, the serials are also named "blspX_uartY", but with different logic.
>    X is the BLSP Block ID. Starts from 1.
>    Y is the uart id inside block.
>      In "ipq6018.dtsi" and "ipq8074.dtsi", it starts from 1.
>      But in "ipq5332.dtsi" and "ipq9574.dtsi", it starts from 0.
> 
> +-----------------+-----------------+-------------+-----------------+
> |     Block ID    | ID inside Block |  dts name   | pinconfig name  |
> | (Starts from 1) | (Starts from 1) |             |                 |
> +-----------------+-----------------+-------------+-----------------+
> |        1        |        1        | blsp1_uart1 |   blsp0_uartY   |
> |        1        |        2        | blsp1_uart2 |   blsp1_uartY   |
> |        1        |        6        | blsp1_uart6 |   blsp5_uartY   |
> |        2        |        1        | blsp2_uart1 |   blsp6_uartY   |
> |        2        |        6        | blsp2_uart6 |   blsp12_uartY  |
> +-----------------+-----------------+-------------+-----------------+
> 
> In "ipq5018.dts", "blsp1_uart1" (dts name) is the first serial (confimed
> by the address), So its pinconfig should be "blsp0_uart0" (pinconfig name,
> use GPIO 20 and 21) or "blsp0_uart1" (pinconfig name, use GPIO 28 and 29).
> 
> Fixes: 570006756a16 ("arm64: dts: Add ipq5018 SoC and rdp432-c2 board support")
> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
> ---
> Changes since v1:
> - Use corrent name in From
> 
> Changes since v2:
> - Define 2 pinconfs for uart1 in ipq5018.dtsi
> - rdp432-c2 use uart1_pins_a
> 
>   arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts |  2 +-
>   arch/arm64/boot/dts/qcom/ipq5018.dtsi          | 15 +++++++++++----
>   2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
> index e636a1cb9b77..e83d1863e89c 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
> @@ -23,7 +23,7 @@ chosen {
>   };
>   
>   &blsp1_uart1 {
> -	pinctrl-0 = <&uart1_pins>;
> +	pinctrl-0 = <&uart1_pins_a>;
>   	pinctrl-names = "default";
>   	status = "okay";
>   };
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index 9f13d2dcdfd5..50b4a2bd6fd3 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -103,11 +103,18 @@ tlmm: pinctrl@1000000 {
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
>   
> -			uart1_pins: uart1-state {
> -				pins = "gpio31", "gpio32", "gpio33", "gpio34";
> -				function = "blsp1_uart1";
> +			uart1_pins_a: uart1@0 {
> +				pins = "gpio20", "gpio21";
> +				function = "blsp0_uart0";
>   				drive-strength = <8>;
> -				bias-pull-down;
> +				bias-disabled;
> +			};
> +
> +			uart1_pins_b: uart1@1 {
> +				pins = "gpio28", "gpio29";
> +				function = "blsp0_uart1";
> +				drive-strength = <8>;
> +				bias-disabled;
>   			};
>   		};
>   

The assignment of pins 20 and 21 to blsp1_uart1 is not correct.

The blspX_uartY in pinctrl should match what is in the dtsi so assigning 
pins_a above to blsp1_uart1 is not right. The dts name and pinctrl name 
should be the same.

Your console is on blsp0_uart0.

https://git.codelinaro.org/clo/qsdk/oss/boot/u-boot-2016/-/blob/5343739b4070bcec2fecd72f758c16adc31a3083/arch/arm/dts/ipq5018-mp03.3.dts#L33

So roughly speaking

arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts

aliases {
	serial0 = &blsp0_uart0;
};

chosen {
	stdout-path = "serial0:115200n8";
};

&blsp0_uart0 {
         pinctrl-0 = <&uart0_pins>;
         pinctrl-names = "default";
         status = "okay";
};


arch/arm64/boot/dts/qcom/ipq5018.dtsi

blsp0_uart0: serial@78af000

either that or  blsp0_uart1 for pins28 and pins29 - you seem to indicate 
pins_1 => blsp0_uart0.

The two roots of the problem are

1. Mislabeling of the uart block in the dtsi
2. Invalid miscongiruation of pins for that misnamed block

The fix should be

1. Fix the labeling of uart in the dtsi
2. Decide on which pins gpio20, gpio21 ? are the right ones to configure

I thought you said in a previous email if you changed pins gpio28 and 
gpio29 that the UART would fail if so that implies blsp0_uart1.

Either way the pinctrl and dts should agree.

---
bod

