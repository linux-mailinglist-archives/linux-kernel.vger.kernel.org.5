Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404357FEA26
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344817AbjK3IEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344782AbjK3IEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:04:06 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529BC10E4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:04:11 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54c11430624so264909a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701331450; x=1701936250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z89fwBKk9m9+yFv5AqVLFvL0LJt5mjyMZmAmBxfuD7Y=;
        b=RDMLMMsMavRPUotiwbuOEOFI0JiJmTXiG6Ubip6l+bTVeX1kbgoIUgzlBOiA/S2Sn8
         l3YDmdm5SzDyoRzd8eaqmm3xwIX6d45FOWmLeRl6M2oM5lsLI1GDSytB4nCUIc2X/dYr
         u7UcgdJXsWjfU1bLWuLNV1wnvRqCcnyfteWVkvCleGn2TPe/Yt8rfUpPF38hqW3MZU2r
         O4YfLK/rExp9sFJQZMbWvemD5XUSJ/3Uhuf5FK9szMgDpM3SOIZho7GpLzsMzNN54uqC
         zNUFWeWqGh4PCNld8zExON+Tbm6C5hqF9AXVLVymZ4tYP5+Xnqm75ky2rPxq34S4mgwH
         W6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701331450; x=1701936250;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z89fwBKk9m9+yFv5AqVLFvL0LJt5mjyMZmAmBxfuD7Y=;
        b=eLrYx7ZckTMVkAZ0NEdqsD7rA4q7KGNG9U9jllPzBsUQFoW8U7YkqegH+xgjdH2XYA
         UXp/Hjfp+vCPcmTV5jzofNbyPo4ahxRFwQqLI1RRZUCmHp5sT618M4I5kfLB1nDGhyQQ
         b8YrcAf3HnI8N+qtJY7p71hBhw+TpSJL4p6CJxy+izCTO4cNAGP75IO+fDgqqA6/wIM5
         5mqEhcQxj6BNExZJbDhHOYm9hlGA+84fQrU8cDa9wdcRKI+4HipHVGSDn5vFsQGFXgdw
         C9ASSo1cpy7txrGTFUiNfq+90t0LqIb2sfSFELbkkKEIUbE0OToBgIOIYQNiqqrzPB8b
         Y0ow==
X-Gm-Message-State: AOJu0Yx7RyEimCs+Lhc4mO8O1ztzudMqC1WmHHWT3sOUfLl1wXEWRrGD
        bU/DPEc+ne0uwQsRfnotFQWVGA==
X-Google-Smtp-Source: AGHT+IFm0tw2G+RxKE5+Kjg3DkA1Wmz63e2K7JXPSmxLpDcmyZulzZ1f53VtnysLnP51WymzKqdseg==
X-Received: by 2002:a50:ccc2:0:b0:548:a1cd:a92c with SMTP id b2-20020a50ccc2000000b00548a1cda92cmr17295023edj.5.1701331449804;
        Thu, 30 Nov 2023 00:04:09 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id b22-20020aa7df96000000b0054b3a6243b1sm291363edy.71.2023.11.30.00.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 00:04:09 -0800 (PST)
Message-ID: <4e4a67c8-6c95-497f-82b3-d4328a18f249@linaro.org>
Date:   Thu, 30 Nov 2023 09:04:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: dts: nuvoton: Add pinctrl support for
 ma35d1
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de, j.neuschaefer@gmx.net
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
 <ff83f0f2-541a-4677-a247-5f47fdcca3f1@gmail.com>
 <db3ede63-8708-469f-8e7b-aca798ed50e0@linaro.org>
 <4b00c41c-7751-40ca-bf2d-53f1179772d4@gmail.com>
 <9ec2dd42-5173-40df-8e6b-9c09f2d77f67@linaro.org>
 <6d511cc4-f22c-4c8f-a1ea-a8d99be95157@gmail.com>
 <e3bc24d6-d9ef-4705-8de7-05460f915b17@linaro.org>
 <9c41e6d4-fe47-4e87-b0a7-f5ecaec720b3@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <9c41e6d4-fe47-4e87-b0a7-f5ecaec720b3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2023 02:10, Jacky Huang wrote:
> Dear Krzysztof,
> 
> 
> On 2023/11/29 下午 06:54, Krzysztof Kozlowski wrote:
>> On 29/11/2023 11:14, Jacky Huang wrote:
>>> Dear Krzysztof,
>>>
>>>
>>> On 2023/11/29 下午 06:02, Krzysztof Kozlowski wrote:
>>>> On 29/11/2023 10:41, Jacky Huang wrote:
>>>>> Dear Krzysztof,
>>>>>
>>>>>
>>>>> On 2023/11/29 下午 04:11, Krzysztof Kozlowski wrote:
>>>>>> On 29/11/2023 04:35, Jacky Huang wrote:
>>>>>>>>>> Best regards,
>>>>>>>>>> Krzysztof
>>>>>>>>>>
>>>>>>>>> Yes, it did pass the 'dtbs_check'. I guess the tool does not detect such
>>>>>>>>> issues.
>>>>>>>>> Anyway, I will fix it in the next version.
>>>>>>>> Hm, I see your bindings indeed allow pin-.* and unit addresses, so it is
>>>>>>>> the binding issue.
>>>>>>>>
>>>>>>>> The examples you used as reference - xlnx,zynqmp-pinctrl.yaml and
>>>>>>>> realtek,rtd1315e-pinctrl.yaml - do not mix these as you do.
>>>>>>>>
>>>>>>>> I don't understand why do you need them yet. I don't see any populate of
>>>>>>>> children. There are no compatibles, either.
>>>>>>>>
>>>>>>>> Which part of your driver uses them exactly?
>>>>>>>>
>>>>>>>> Best regards,
>>>>>>>> Krzysztof
>>>>>>>>
>>>>>>> I will move the 'pcfg_default: pin-default' from dtsi to dts, like this:
>>>>>>>
>>>>>>> &pinctrl {
>>>>>>>         pcfg_default: pin-default {
>>>>>>>             slew-rate = <0>;
>>>>>>>             input-schmitt-disable;
>>>>>>>             bias-disable;
>>>>>>>             power-source = <1>;
>>>>>>>             drive-strength = <17100>;
>>>>>>>         };
>>>>>> This solves nothing. It's the same placement.
>>>>>>
>>>>>>
>>>>>> Best regards,
>>>>>> Krzysztof
>>>>>>
>>>>> OK, it stil be the binding issues.
>>>>> For "^pin-[a-z0-9]+$", I reference to the "pcfg-[a-z0-9-]+$" of
>>>>> rockchip,pinctrl.yaml.
>>>>>
>>>>> My intention is to describe a generic pin configuration, aiming to make
>>>>> the pin
>>>>> description more concise. In actual testing, it proves to be effective.
>>>> Can you instead respond to my actual questions?
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>> The the last one item of nuvoton,pins is a phandle, which can refer to
>>> '&pin-default'. The following code of driver pinctrl-ma35.c parse
>>> "nuvoton,pins", including the node reference by phandle. list =
>>> of_get_property(np, "nuvoton,pins", &size); size /= sizeof(*list); if
>>> (!size || size % 4) { dev_err(npctl->dev, "wrong setting!\n"); return
>>> -EINVAL; } grp->npins = size / 4; grp->pins = devm_kzalloc(npctl->dev,
>>> grp->npins * sizeof(*grp->pins), GFP_KERNEL); if (!grp->pins) return
>>> -ENOMEM; pin = grp->settings = devm_kzalloc(npctl->dev, grp->npins *
>>> sizeof(*grp->settings), GFP_KERNEL); if (!grp->settings) return -ENOMEM;
>>> for (i = 0, j = 0; i < size; i += 4, j++) { struct device_node
>>> *np_config; const __be32 *phandle; pin->offset = be32_to_cpu(*list++) *
>>> MA35_MFP_REG_SZ_PER_BANK + MA35_MFP_REG_BASE; pin->shift =
>>> (be32_to_cpu(*list++) * MA35_MFP_BITS_PER_PORT) % 32; pin->muxval =
>>> be32_to_cpu(*list++); phandle = list++; if (!phandle) return -EINVAL;
>>> np_config = of_find_node_by_phandle(be32_to_cpup(phandle)); ret =
>>> pinconf_generic_parse_dt_config(np_config, NULL, &pin->configs,
>>> &pin->nconfigs); if (ret) return ret; grp->pins[j] =
>>> npctl->info->get_pin_num(pin->offset, pin->shift); pin++; } Best
>>> Regards, Jacky Huang
>> Sorry, I cannot parse it.
>>
>> I was referring to the children with unit addresses. I don't see any
>> populate of the children, so why do you need them?
>>
>> There are no compatibles, either.
>>
>> Which part of your driver uses them exactly?
>>
>> Best regards,
>> Krzysztof
>>
> So, I should update the binding from "^pin-[a-z0-9]+$" to something like 
> "-pincfg$".
> Just remove the unit address part, and it will become:
> 
>      default-pincfg {
>          slew-rate = <0>;
>          input-schmitt-disable;
>          bias-disable;
>          power-source = <1>;
>          drive-strength = <17100>;
>      };
> 

No, it solves nothing. Instead of pasting more code, can you answer my
questions?

Best regards,
Krzysztof

