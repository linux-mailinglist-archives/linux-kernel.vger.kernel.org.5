Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D970F78F3DC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344485AbjHaUUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244103AbjHaUUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:20:06 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0760CE6B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 13:19:58 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401d80f4ef8so12835845e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 13:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20230601.gappssmtp.com; s=20230601; t=1693513196; x=1694117996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TbAGwjrbP3wJw/XyfuKcVfBZuXKE+qWablDMlIo3xlA=;
        b=TsgjcYbLYR8FFqMJA7901+qQ46KWqhJeLb5QfIaSVvvVC2S4olJqRKerJwaSs5ycnv
         lleNrn6OJ0DdwF8WAGXusHzKUxx0KXmZq+AUUgkfXeZariMaf0kJL5mTgJJokPNNY05r
         uAIG/vt0+6MrUAgWCpMGt48j6+zLb5QFrLcBHg9Ln4k5LbyJNSXEels0PoPGP0SpueGx
         i5yiKZ5XJcjrEvCgK6O/JRLqMdze2PpPof75lM9GZTg1PtHAnTUchtm64+PUH8CFFENS
         wYxgeoKfWPOBKzv36XSbfMJj+VfDSoIp3JzUcitpiME069lgdaZ22tVYmhaVyn1YxLXx
         kMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693513196; x=1694117996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TbAGwjrbP3wJw/XyfuKcVfBZuXKE+qWablDMlIo3xlA=;
        b=JVn4Jtl29Nb1PraZDM6fSOrbljKNCnAiNFPSqAiWiBDOeEzlEatjhNmt0X3bO/rg8L
         xQ7+41VGztOC1uRqxNAsxjuWe0cCJE65V7zeBV9/RuxWEaXTWiI710fLy3QVJaIYZBrJ
         WptH0CERRzfyDKno6pqSv5R7Z71nl8c5i5WIDBD0rcRJGlCrzQ48Cs0e3gGaK6qLCr98
         Hfkw0YwB02n/84K+43f0X05L4foo3c3nEhiwqZxnuGd/V49vVwKGjQXW9gBtXaSnJUKo
         fMShN5ujEI14EBz59bdSJzIOM6zkjBz8mb+pfJTJaxpwkwmnDAeIHIZaOrVQVVz6VRMh
         9GmA==
X-Gm-Message-State: AOJu0YzH1yUIPP/JgPdivDtauNRMkFuzxgv+/D1efw/I1VBV0Yno7eI3
        +KT1Zw6Z7peBW5roQT1o8+wGsA==
X-Google-Smtp-Source: AGHT+IGRWtQXXQ/4Fa+JT3KC4UtOZDnaGKakyrrx7kEF0AAlUNk//9L8FLqoiWeVYYAlLLZqTMtkoQ==
X-Received: by 2002:a7b:cc85:0:b0:3ff:28b8:c53d with SMTP id p5-20020a7bcc85000000b003ff28b8c53dmr299774wma.33.1693513196321;
        Thu, 31 Aug 2023 13:19:56 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s5-20020a7bc385000000b003fe61c33df5sm6102993wmj.3.2023.08.31.13.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 13:19:55 -0700 (PDT)
Message-ID: <49fbae87-ce09-23af-6bcd-459b5646e680@nexus-software.ie>
Date:   Thu, 31 Aug 2023 21:19:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] arm64: dts: ipq5018: Correct uart1_pins pinconf
Content-Language: en-US
To:     Ziyang Huang <hzyitc@outlook.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_gokulsri@quicinc.com, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <TYZPR01MB5556F902BF64AF857C3ABD44C9E5A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <TYZPR01MB5556F902BF64AF857C3ABD44C9E5A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2023 17:34, Ziyang Huang wrote:
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
> Changes since v1
> - Use corrent name in From
> 
>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index 9f13d2dcdfd5..91b98020e1c6 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -104,10 +104,10 @@ tlmm: pinctrl@1000000 {
>   			#interrupt-cells = <2>;
>   
>   			uart1_pins: uart1-state {
> -				pins = "gpio31", "gpio32", "gpio33", "gpio34";
> -				function = "blsp1_uart1";
> +				pins = "gpio28", "gpio29";
> +				function = "blsp0_uart1";
>   				drive-strength = <8>;
> -				bias-pull-down;
> +				bias-disabled;
>   			};
>   		};
>   

So this change will have the effect of changing the console on 
ipq5018-rdp432 from gpio31-gpio34 to gpio28, gpio29.

Have you verified that change on hardware or the schematic ?

https://forum.openwrt.org/t/add-support-for-xiaomi-redmi-ax5400-white-version/140879/22?page=2

This has the wrong UART pinout ?

Is this change something that should be expressed for a particular board ?

---
bod
