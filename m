Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301357FD4BA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjK2Kyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjK2Kyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:54:53 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD0C8E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:54:59 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a00a9c6f1e9so937641666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701255297; x=1701860097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WaNT7WYUOm/G392OKMIh9XdJ8gT35U7w8c6/M00Pcos=;
        b=sRcQ/pkTsaL+f+b8oRn1brF5RNpGOSxNPEDw9qUKByYEn4wZDVJPUg2cVM87RvMZ49
         ae7EZgUNicobf7E+AcZH4lDpNI+0/yg3YGCC0jJ06xouz1MTLc+R4UVOyzOxJ6Rfe+xz
         IJiS6QQWriBGjqXwe95uFzrcUZfH/rE1sV/GqgcsbjOCQRCgyPS72dqK2jApsEGR+Fj3
         LvvAyJuso+RXHtHvzI6qkwSp3/OdShOMf9pxVNRAc5J7cfFoYvOZsl3E+QIiFcTw2iI1
         OesivpsimuowSVH34qhrpbUYkbQnW3wVnXJMFpsbj3BWW1PTjM5TyIeAs9Ghyou3h/0b
         jjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701255297; x=1701860097;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WaNT7WYUOm/G392OKMIh9XdJ8gT35U7w8c6/M00Pcos=;
        b=DxYF0hy91L9coUni6J2C9ww+bg8/o0uTbKfy6dAA5vpaJzP8Gz/kVK7IA+UoRRBGkI
         MYLd2fNWRXBbGCL3zOlkuB7jCOCHJKuPiLWCNDestU3bKru/PHjE3Pa222ErQJBo8awc
         A+n2fdGQoV1grt9O48QbQUoK+dQRdfcfirDdoD+xuWxQ4xAzZXmMdVBqda5K0tmH6E2s
         p5LGM+E5uqW+Od+2xiSVNzDBwd6KySsp9bc4HCXpfhTocYCHxUz5f8bokg4A5jWagSFJ
         POWLgdnCoCmG+Hnu15i4UvE4zxURqAbtak/25pCfvXVA24lpxXcjklIAsxzTN86KzPcl
         NBpA==
X-Gm-Message-State: AOJu0YxJ6XijpPILuU6WvYv4pyUGBI90Dgl+BMdvsA0mpv53E+noKd0l
        HFYBSxMtfdlBIq/RsioyOen/0g==
X-Google-Smtp-Source: AGHT+IEiWyZ9udu+TEmnkAnknsXruKGeWNOjB4HCrQJ1VzfuSdWgVckZxNsxVMGWur3FPBGnvfDaiA==
X-Received: by 2002:a17:906:cec7:b0:a10:8db4:bcf3 with SMTP id si7-20020a170906cec700b00a108db4bcf3mr6616764ejb.9.1701255297573;
        Wed, 29 Nov 2023 02:54:57 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id k7-20020a17090627c700b009e50ea0a05asm7814793ejc.99.2023.11.29.02.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 02:54:57 -0800 (PST)
Message-ID: <e3bc24d6-d9ef-4705-8de7-05460f915b17@linaro.org>
Date:   Wed, 29 Nov 2023 11:54:56 +0100
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <6d511cc4-f22c-4c8f-a1ea-a8d99be95157@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2023 11:14, Jacky Huang wrote:
> 
> Dear Krzysztof,
> 
> 
> On 2023/11/29 下午 06:02, Krzysztof Kozlowski wrote:
>> On 29/11/2023 10:41, Jacky Huang wrote:
>>> Dear Krzysztof,
>>>
>>>
>>> On 2023/11/29 下午 04:11, Krzysztof Kozlowski wrote:
>>>> On 29/11/2023 04:35, Jacky Huang wrote:
>>>>>>>> Best regards,
>>>>>>>> Krzysztof
>>>>>>>>
>>>>>>> Yes, it did pass the 'dtbs_check'. I guess the tool does not detect such
>>>>>>> issues.
>>>>>>> Anyway, I will fix it in the next version.
>>>>>> Hm, I see your bindings indeed allow pin-.* and unit addresses, so it is
>>>>>> the binding issue.
>>>>>>
>>>>>> The examples you used as reference - xlnx,zynqmp-pinctrl.yaml and
>>>>>> realtek,rtd1315e-pinctrl.yaml - do not mix these as you do.
>>>>>>
>>>>>> I don't understand why do you need them yet. I don't see any populate of
>>>>>> children. There are no compatibles, either.
>>>>>>
>>>>>> Which part of your driver uses them exactly?
>>>>>>
>>>>>> Best regards,
>>>>>> Krzysztof
>>>>>>
>>>>> I will move the 'pcfg_default: pin-default' from dtsi to dts, like this:
>>>>>
>>>>> &pinctrl {
>>>>>        pcfg_default: pin-default {
>>>>>            slew-rate = <0>;
>>>>>            input-schmitt-disable;
>>>>>            bias-disable;
>>>>>            power-source = <1>;
>>>>>            drive-strength = <17100>;
>>>>>        };
>>>> This solves nothing. It's the same placement.
>>>>
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>> OK, it stil be the binding issues.
>>> For "^pin-[a-z0-9]+$", I reference to the "pcfg-[a-z0-9-]+$" of
>>> rockchip,pinctrl.yaml.
>>>
>>> My intention is to describe a generic pin configuration, aiming to make
>>> the pin
>>> description more concise. In actual testing, it proves to be effective.
>> Can you instead respond to my actual questions?
>>
>> Best regards,
>> Krzysztof
>>
> 
> The the last one item of nuvoton,pins is a phandle, which can refer to 
> '&pin-default'. The following code of driver pinctrl-ma35.c parse 
> "nuvoton,pins", including the node reference by phandle. list = 
> of_get_property(np, "nuvoton,pins", &size); size /= sizeof(*list); if 
> (!size || size % 4) { dev_err(npctl->dev, "wrong setting!\n"); return 
> -EINVAL; } grp->npins = size / 4; grp->pins = devm_kzalloc(npctl->dev, 
> grp->npins * sizeof(*grp->pins), GFP_KERNEL); if (!grp->pins) return 
> -ENOMEM; pin = grp->settings = devm_kzalloc(npctl->dev, grp->npins * 
> sizeof(*grp->settings), GFP_KERNEL); if (!grp->settings) return -ENOMEM; 
> for (i = 0, j = 0; i < size; i += 4, j++) { struct device_node 
> *np_config; const __be32 *phandle; pin->offset = be32_to_cpu(*list++) * 
> MA35_MFP_REG_SZ_PER_BANK + MA35_MFP_REG_BASE; pin->shift = 
> (be32_to_cpu(*list++) * MA35_MFP_BITS_PER_PORT) % 32; pin->muxval = 
> be32_to_cpu(*list++); phandle = list++; if (!phandle) return -EINVAL; 
> np_config = of_find_node_by_phandle(be32_to_cpup(phandle)); ret = 
> pinconf_generic_parse_dt_config(np_config, NULL, &pin->configs, 
> &pin->nconfigs); if (ret) return ret; grp->pins[j] = 
> npctl->info->get_pin_num(pin->offset, pin->shift); pin++; } Best 
> Regards, Jacky Huang

Sorry, I cannot parse it.

I was referring to the children with unit addresses. I don't see any
populate of the children, so why do you need them?

There are no compatibles, either.

Which part of your driver uses them exactly?

Best regards,
Krzysztof

