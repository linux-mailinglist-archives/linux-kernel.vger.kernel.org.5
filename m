Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070E3790F6B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 02:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350095AbjIDA5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 20:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbjIDA5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 20:57:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D01299
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 17:57:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31c479ede21so820277f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 17:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693789048; x=1694393848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F4NiAX8nddOFb+q5MdSSZTo4J0GfTd0YP95tRAyVWeE=;
        b=xw3hl6gLjolM1XU5AfcMXPIFNSvIf8DiOHTgSVwT7DubcasI0YbHjxehXd2O98955d
         vgPHNVK7P0odIcxB+3JLJmTXRUbb6BQ0JPlEIAv4AANp0+0CRcxMZdpImYovjn3zi/mu
         x70F790qKxoE4O2n9bLqb8+kqHbCB2fsBkja6yQ9KUjV78T0cXeW2v5CwXzgrJOsW3B+
         EUte9yneVBIXA7Yu0sa4IkQ56KUbhvqxO0O51FL2iSFyRZHG9tt6B6x7R2Nnqrppo+w7
         aXWxnPF3AJ9v5byxAyIUNMZQAE1jnc9fKjpODYpjkToyWRcVxlTvTPw9VGRUJxr35Zny
         ER/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693789048; x=1694393848;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4NiAX8nddOFb+q5MdSSZTo4J0GfTd0YP95tRAyVWeE=;
        b=BOoY1Ljn+YCMU4e5aEf6878ABEQMGRwBY2w6g2b++W7jDQz8Iw3A/HC2KpIDWD/vli
         EoAJ6aps2rsW2GtShi4HOl0nZf7YDKrjLCeXm2cK2iy+sBA+qslcAsjUxX9DjaII2l/R
         4q1N1Mg8I4z5YSCVZIV957f3sD1sU6BGvpPO+uBweUsC7K0WmbhdawhFa2e/hQQYIKK1
         NuMGRSqipLnyJ9MGvn8NgRX+F2RwR1XLp203XcHgPbNkdbb9EHw3T9ZbJq+26sxKH4pA
         nrXt4/lXpItb6iZ5jH6jVvlQMDG4TkJ2fn6Hu7N8290rjB12umL19+OFHXGAu1r1fa1l
         MHdQ==
X-Gm-Message-State: AOJu0Yz8mgB60Pgrr4fpYN21gOUIadkt2pKXIfrAblge/Zr3t1oZGrEZ
        Kx3RuPCS4RGs6aHWzDHNG4+sMoW0lsfX9GzTbgs=
X-Google-Smtp-Source: AGHT+IFU+VFezB3qmW7ae+FJNxTsbAodLWMouwX29XWEuFb3b0PM47kSPr0KPSt6Bfebz16hQOqWEg==
X-Received: by 2002:adf:ef91:0:b0:317:69d2:35be with SMTP id d17-20020adfef91000000b0031769d235bemr6522208wro.30.1693789047727;
        Sun, 03 Sep 2023 17:57:27 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k33-20020a05600c1ca100b0040210a27e29sm12824297wms.32.2023.09.03.17.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 17:57:27 -0700 (PDT)
Message-ID: <c6f4b93c-aa80-e250-d06b-6b3bdfbfc64b@linaro.org>
Date:   Mon, 4 Sep 2023 01:57:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] arm64: dts: ipq5018: Correct uart1_pins pinconf
Content-Language: en-US
To:     Ziyang Huang <hzyitc@outlook.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, quic_gokulsri@quicinc.com,
        quic_srichara@quicinc.com, quic_varada@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <TYZPR01MB5556D24A77DAFA013F93B551C9E4A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <b6fa8337-a5c0-172a-a41b-ab18de3f4f72@linaro.org>
 <TYZPR01MB555673C1E12A27DA8109DBEAC9EAA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <TYZPR01MB555673C1E12A27DA8109DBEAC9EAA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2023 14:02, Ziyang Huang wrote:
> 在 2023/9/1 23:04, Bryan O'Donoghue 写道:
>> <...>
>>
>> The assignment of pins 20 and 21 to blsp1_uart1 is not correct.
>>
>> The blspX_uartY in pinctrl should match what is in the dtsi so 
>> assigning pins_a above to blsp1_uart1 is not right. The dts name and 
>> pinctrl name should be the same.
>>
>> Your console is on blsp0_uart0.
>>
>> https://git.codelinaro.org/clo/qsdk/oss/boot/u-boot-2016/-/blob/5343739b4070bcec2fecd72f758c16adc31a3083/arch/arm/dts/ipq5018-mp03.3.dts#L33
>>
>> So roughly speaking
>>
>> arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
>>
>> aliases {
>>      serial0 = &blsp0_uart0;
>> };
>>
>> chosen {
>>      stdout-path = "serial0:115200n8";
>> };
>>
>> &blsp0_uart0 {
>>          pinctrl-0 = <&uart0_pins>;
>>          pinctrl-names = "default";
>>          status = "okay";
>> };
>>
>>
>> arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>
>> blsp0_uart0: serial@78af000
>>
>> either that or  blsp0_uart1 for pins28 and pins29 - you seem to 
>> indicate pins_1 => blsp0_uart0.
>>
>> The two roots of the problem are
>>
>> 1. Mislabeling of the uart block in the dtsi
>> 2. Invalid miscongiruation of pins for that misnamed block
>>
>> The fix should be
>>
>> 1. Fix the labeling of uart in the dtsi
>> 2. Decide on which pins gpio20, gpio21 ? are the right ones to configure
>>
>> I thought you said in a previous email if you changed pins gpio28 and 
>> gpio29 that the UART would fail if so that implies blsp0_uart1.
>>
>> Either way the pinctrl and dts should agree.
>>
>> ---
>> bod
>>
> 
> No, please read my commit message carefully.
> 
> The Y of pinctrl is the index of pinmux config. So it can't be used in 
> the serial node definition.
> 
> Please note that the physical port of first serial is configurable. It 
> can use gpio20, gpio21 or/and gpio28,29. All of these pins are for the 
> first serial.
> 
> Let's take the second serial as an example. It has 3 configurable 
> physical port groups - "blsp1_uart0" (pinconfig name, use GPIO 
> 10,11,12,13), "blsp1_uart1" (gpio 31,32,33,34), "blsp1_uart2" (gpio 
> 23,24,25,26).
> 
> But the dts name of the second serial definition is "blsp1_uart2". 
> Because it the second serial of the first BLSP block.
> 
> Same logic. The dts name of the first serial definition is 
> "blsp1_uart1". Because it the first serial of the first BLSP block.
> 
> I think I need to introduce the architecture of these SoC. It has two 
> BLSP block. Each BLSP block has several uart port.
> 
> So the dts name of serial contains the BLSP index and the serial index 
> inside BLSP. But pinconf name doesn't care about it. So it use global 
> index. And due to the physical ports are configurable, it need pinmux 
> index.
> 
> The equation will be like this:
> 
> dts name of serial definition: "blspX_uartY"
> pinconf name: "blspU_uartV"
> U = (uart_number_inside_each_blsp * (X - 1)) + (Y - 1)

I've checked the documentation for this chip.

gpio20, gpio21 = blsp0_uart0
gpio28, gpio29 = blsp0_uart0

These pins are muxed to UART0, I agree, the u-boot dts also indicates 
this also.

If we open the documentation further we see

0x78AF000 = BLSP1_BLSP_UART0
0x79b0000 = BLSP1_BLSP_UART1

So for starters the dtsi has the _wrong_ label.

Here/anseo

grep uart0: arch/arm64/boot/dts/qcom/*
arch/arm64/boot/dts/qcom/ipq5332.dtsi:		blsp1_uart0: serial@78af000 {
arch/arm64/boot/dts/qcom/ipq9574.dtsi:		blsp1_uart0: serial@78af000 {

That's how that label ought to be the main hint something is askance is 
assigning a pin named "blsp0_uart0" to a dts entry named "blsp1_uart1".

Please update the label in your next revision.

---
bod
