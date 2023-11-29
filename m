Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D407FCD85
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjK2Dfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjK2Df2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:35:28 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F027A170B;
        Tue, 28 Nov 2023 19:35:33 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cfb4d28c43so32310125ad.1;
        Tue, 28 Nov 2023 19:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701228933; x=1701833733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tDEyZbCiD6Dl1gjsWghaLMq/5eUSRSd2QR51WySv6Oo=;
        b=NtuvMRAGxmRPIFdbskElmPxes7oNTk2zumygoV/JBvO4f0hrCFwd3wrYYW5XWG7Ag+
         /cnz/SIRwsXrAPrezaYwQSO51FUiu/s3GozpX0lFlostgutnR6hh9A0GIPmZRCb+mARO
         Rw2WlkX2xsukiJYFxYqYCAbdnJHugqHeQMU6Nw7psGM3TKcsyze3gMRfnpqK1J4/iFh6
         638LvNIGffWufsLCJR2VzP4XdxYENqRiIOEWSzDpwICfF8XJkaXTvkassa9wC1zVMLCg
         eXvl+C3xAauK0R+xEwQmTPHS0CKLIV401+McmQD1vlQxs8bfXRBzW3K906px/YWCC8vu
         XHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701228933; x=1701833733;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tDEyZbCiD6Dl1gjsWghaLMq/5eUSRSd2QR51WySv6Oo=;
        b=MrnEDofWRJQSZOzjng5XczRr+jFAvSPX93Ro7mZkDV3H3GpSvkG4aYL0d6+H4syBiX
         PMuwCQdXcBVcKC4TqYTuHIplqBxl7C0kiA3ENqKqzwZL3kx9jjEaYE+BoHJ6bKlN9QTC
         2sfi3WSmHmqQc0VkXPxw3aBaMF1avnyBNgFKaIsEfY68gPE2GljlY5D6qXrKGRSjHz2C
         pCjg6GnkPOAJyOk1qegHHTIUG0YdCBLHvk0N/isjelBD6euR5x1Px63tgVv3koHyVcBR
         /MdFsa7zKG1C9/4eXa4d4Vwu1glrWFn74bNmY349ksJ9oP765eS1jZ3VdgB5hA0e0nLZ
         heFg==
X-Gm-Message-State: AOJu0YwM3m5OoU6a3+aoU+ZdRjHlTJ3fEFkNh6Eye67hrcK9AN/srMTm
        rhKXLdBFjQrVBuXyN6Hfbbk=
X-Google-Smtp-Source: AGHT+IFrfXS/GRV0hJhefAcOaI2mYEMBX6t7lhvcc2/ZzrcGxhO/5K/nehfaOCh/ZV3gQsUn55bpDQ==
X-Received: by 2002:a17:902:d590:b0:1cf:b43d:6b39 with SMTP id k16-20020a170902d59000b001cfb43d6b39mr16079665plh.52.1701228933203;
        Tue, 28 Nov 2023 19:35:33 -0800 (PST)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id ju12-20020a170903428c00b001cf5654fc29sm11145403plb.72.2023.11.28.19.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 19:35:32 -0800 (PST)
Message-ID: <ff83f0f2-541a-4677-a247-5f47fdcca3f1@gmail.com>
Date:   Wed, 29 Nov 2023 11:35:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: dts: nuvoton: Add pinctrl support for
 ma35d1
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ychuang3@nuvoton.com, schung@nuvoton.com
References: <20231128061118.575847-1-ychuang570808@gmail.com>
 <20231128061118.575847-4-ychuang570808@gmail.com>
 <7edda3ca-b98a-4125-979f-3ee7ac718a9a@linaro.org>
 <a0be9aaa-290d-450e-b0b8-d87453bcaaa0@gmail.com>
 <7fed5d90-da04-40fb-8677-b807b6f51cc9@linaro.org>
 <8663d26e-32b8-4f2b-b497-9efa7440f070@gmail.com>
 <2fab32e6-23a4-41bb-b47b-4f993fc590dc@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <2fab32e6-23a4-41bb-b47b-4f993fc590dc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof,

Thanks for your review.

On 2023/11/28 下午 07:06, Krzysztof Kozlowski wrote:
> On 28/11/2023 11:45, Jacky Huang wrote:
>> Dear Krzysztof,
>>
>> Thanks for your review.
>>
>> On 2023/11/28 下午 05:34, Krzysztof Kozlowski wrote:
>>> On 28/11/2023 09:37, Jacky Huang wrote:
>>>>>> +			gpion: gpio@40040340 {
>>>>>> +				reg = <0x340 0x40>;
>>>>>> +				interrupts = <GIC_SPI  105 IRQ_TYPE_LEVEL_HIGH>;
>>>>>> +				clocks = <&clk GPN_GATE>;
>>>>>> +				gpio-controller;
>>>>>> +				#gpio-cells = <2>;
>>>>>> +				interrupt-controller;
>>>>>> +				#interrupt-cells = <2>;
>>>>>> +			};
>>>>>> +
>>>>>> +			pcfg_default: pin-default {
>>>>>> +				slew-rate = <0>;
>>>>>> +				input-schmitt-disable;
>>>>>> +				bias-disable;
>>>>>> +				power-source = <1>;
>>>>>> +				drive-strength = <17100>;
>>>>>> +			};
>>>>> It does not look like you tested the DTS against bindings. Please run
>>>>> `make dtbs_check W=1` (see
>>>>> Documentation/devicetree/bindings/writing-schema.rst or
>>>>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>>>>> for instructions).
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>>
>>>> I forgot to remove 'ma35d1-pinfunc.h' from my local copy.
>>>> After remove the '#include <dt-bindings/pinctrl/ma35d1-pinfunc.h>', it
>>>> can pass
>>>> the `make dtbs_check W=1` check.
>>>> I will fix it in the next version.
>>> Really? Then your bindings look wrong. Why do you mix MMIO nodes and
>>> non-MMIO in one device node?
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> Yes, it did pass the 'dtbs_check'. I guess the tool does not detect such
>> issues.
>> Anyway, I will fix it in the next version.
> Hm, I see your bindings indeed allow pin-.* and unit addresses, so it is
> the binding issue.
>
> The examples you used as reference - xlnx,zynqmp-pinctrl.yaml and
> realtek,rtd1315e-pinctrl.yaml - do not mix these as you do.
>
> I don't understand why do you need them yet. I don't see any populate of
> children. There are no compatibles, either.
>
> Which part of your driver uses them exactly?
>
> Best regards,
> Krzysztof
>

I will move the 'pcfg_default: pin-default' from dtsi to dts, like this:

&pinctrl {
     pcfg_default: pin-default {
         slew-rate = <0>;
         input-schmitt-disable;
         bias-disable;
         power-source = <1>;
         drive-strength = <17100>;
     };

     uart-grp {
         pinctrl_uart0: uart0-pins {
             nuvoton,pins = <4 14 1 &pcfg_default>,
                        <4 15 1 &pcfg_default>;
         };

         pinctrl_uart11: uart11-pins {
             nuvoton,pins = <11 0 2 &pcfg_default>,
                        <11 1 2 &pcfg_default>,
                        <11 2 2 &pcfg_default>,
                        <11 3 2 &pcfg_default>;
         };
...

I use the 'pin-' and just intent to define a generic pin configuration, 
such as the above 'pin-default'.


Best Regards,
Jacky Huang




