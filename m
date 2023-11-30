Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE8F7FEA68
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344867AbjK3IXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjK3IXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:23:48 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9835510E0;
        Thu, 30 Nov 2023 00:23:54 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b8929269a0so400391b6e.1;
        Thu, 30 Nov 2023 00:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701332634; x=1701937434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2vM+eit77vlScyxJx/3cRdVqQ5mmJi0Bh/bu3AvMHdc=;
        b=KHXshndM4NrG/a+KU7x3PPgzH6WpUP2e82lDOA1K7dd5/y3F1Y5QSURyMxLu8s3OE0
         n0yiMWw6YKT/QUpL470uhG09P15br2ptVSW9mRKl4oKhGeSy/uuS/V8CmAbANjP+JtKc
         lYgHwVcVXUflXcekfnayZ0c4l1p+N7TeUqtseVtiPOxWr9MUkLu9h/msOq9TXVcoowNh
         cbXpfI8wVCe08/ul44qzitpxryKu4IviT6UgnWBz89ES4WO+tC7E2q7OQuq4H1+eUt3n
         SxEy3CoVRqn808nZdxpDxqxDezKi4y5zT1FS3EOegMGUsAL3lzaaZNrIorH5P08NJp+N
         ESfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701332634; x=1701937434;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vM+eit77vlScyxJx/3cRdVqQ5mmJi0Bh/bu3AvMHdc=;
        b=LhjMKjXFw4Wgyfqv5U1txo5LoNBRZJRyyFf0wjRka8eiYF6pHRC9CQIu4dytuQx+mN
         22lRbujdUKxdIJ62c5qZHQjpCZtvZEhyFLx0CNJSrRSkCQPHobb9aP5RezJgJAmsoy7+
         E8N3fjz/uv4urRZFtQNtNR64t3LUhyzX50ZBPE+fn84m0ktkPHq7LfS1S6QYB8RM330o
         Us73vpTN4iogspuI9yhV6WqdQo+ZSHnNK/zv3hwdfmTljPunRSMfFJGB8Ld6O3FtJ5Wl
         bD0ovqOBGAXlHQgSOc0xUzGc90UNZyeUHFerX0XpfOHhOqx7wvXTwlAsbzeLcSZl49j6
         ebRA==
X-Gm-Message-State: AOJu0YzwB38cOhqGSKOYjtW4ASyBOSceElIfCrMRp6fOY/IuTj1Wy7+k
        TgDzv9TPuCrd9nuHiT81qOoLaP7NMfA=
X-Google-Smtp-Source: AGHT+IF/in67KbW0Hvd+vT6Xhp1+0hHaC3625zxmJskQmqvU3pUDh+DJ+adKvF4ihSICitAOiCN9mA==
X-Received: by 2002:a05:6870:a2d4:b0:1e9:ab99:6b7 with SMTP id w20-20020a056870a2d400b001e9ab9906b7mr25673160oak.3.1701332633826;
        Thu, 30 Nov 2023 00:23:53 -0800 (PST)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id s22-20020a63ff56000000b005bcea1bf43bsm696222pgk.12.2023.11.30.00.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 00:23:53 -0800 (PST)
Message-ID: <0140acce-1d24-4a61-a97b-def0d7c072d3@gmail.com>
Date:   Thu, 30 Nov 2023 16:23:49 +0800
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
 <ff83f0f2-541a-4677-a247-5f47fdcca3f1@gmail.com>
 <db3ede63-8708-469f-8e7b-aca798ed50e0@linaro.org>
 <4b00c41c-7751-40ca-bf2d-53f1179772d4@gmail.com>
 <9ec2dd42-5173-40df-8e6b-9c09f2d77f67@linaro.org>
 <6d511cc4-f22c-4c8f-a1ea-a8d99be95157@gmail.com>
 <e3bc24d6-d9ef-4705-8de7-05460f915b17@linaro.org>
 <9c41e6d4-fe47-4e87-b0a7-f5ecaec720b3@gmail.com>
 <4e4a67c8-6c95-497f-82b3-d4328a18f249@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <4e4a67c8-6c95-497f-82b3-d4328a18f249@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/30 下午 04:04, Krzysztof Kozlowski wrote:
> On 30/11/2023 02:10, Jacky Huang wrote:
>> Dear Krzysztof,
>>
>>
>> On 2023/11/29 下午 06:54, Krzysztof Kozlowski wrote:
>>> On 29/11/2023 11:14, Jacky Huang wrote:
>>>> Dear Krzysztof,
>>>>
>>>>
>>>> On 2023/11/29 下午 06:02, Krzysztof Kozlowski wrote:
>>>>> On 29/11/2023 10:41, Jacky Huang wrote:
>>>>>> Dear Krzysztof,
>>>>>>
>>>>>>
>>>>>> On 2023/11/29 下午 04:11, Krzysztof Kozlowski wrote:
>>>>>>> On 29/11/2023 04:35, Jacky Huang wrote:
>>>>>>>>>>> Best regards,
>>>>>>>>>>> Krzysztof
>>>>>>>>>>>
>>>>>>>>>> Yes, it did pass the 'dtbs_check'. I guess the tool does not detect such
>>>>>>>>>> issues.
>>>>>>>>>> Anyway, I will fix it in the next version.
>>>>>>>>> Hm, I see your bindings indeed allow pin-.* and unit addresses, so it is
>>>>>>>>> the binding issue.
>>>>>>>>>
>>>>>>>>> The examples you used as reference - xlnx,zynqmp-pinctrl.yaml and
>>>>>>>>> realtek,rtd1315e-pinctrl.yaml - do not mix these as you do.
>>>>>>>>>
>>>>>>>>> I don't understand why do you need them yet. I don't see any populate of
>>>>>>>>> children. There are no compatibles, either.
>>>>>>>>>
>>>>>>>>> Which part of your driver uses them exactly?
>>>>>>>>>
>>>>>>>>> Best regards,
>>>>>>>>> Krzysztof
>>>>>>>>>
>>>>>>>> I will move the 'pcfg_default: pin-default' from dtsi to dts, like this:
>>>>>>>>
>>>>>>>> &pinctrl {
>>>>>>>>          pcfg_default: pin-default {
>>>>>>>>              slew-rate = <0>;
>>>>>>>>              input-schmitt-disable;
>>>>>>>>              bias-disable;
>>>>>>>>              power-source = <1>;
>>>>>>>>              drive-strength = <17100>;
>>>>>>>>          };
>>>>>>> This solves nothing. It's the same placement.
>>>>>>>
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Krzysztof
>>>>>>>
>>>>>> OK, it stil be the binding issues.
>>>>>> For "^pin-[a-z0-9]+$", I reference to the "pcfg-[a-z0-9-]+$" of
>>>>>> rockchip,pinctrl.yaml.
>>>>>>
>>>>>> My intention is to describe a generic pin configuration, aiming to make
>>>>>> the pin
>>>>>> description more concise. In actual testing, it proves to be effective.
>>>>> Can you instead respond to my actual questions?
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>>
>>>> The the last one item of nuvoton,pins is a phandle, which can refer to
>>>> '&pin-default'. The following code of driver pinctrl-ma35.c parse
>>>> "nuvoton,pins", including the node reference by phandle. list =
>>>> of_get_property(np, "nuvoton,pins", &size); size /= sizeof(*list); if
>>>> (!size || size % 4) { dev_err(npctl->dev, "wrong setting!\n"); return
>>>> -EINVAL; } grp->npins = size / 4; grp->pins = devm_kzalloc(npctl->dev,
>>>> grp->npins * sizeof(*grp->pins), GFP_KERNEL); if (!grp->pins) return
>>>> -ENOMEM; pin = grp->settings = devm_kzalloc(npctl->dev, grp->npins *
>>>> sizeof(*grp->settings), GFP_KERNEL); if (!grp->settings) return -ENOMEM;
>>>> for (i = 0, j = 0; i < size; i += 4, j++) { struct device_node
>>>> *np_config; const __be32 *phandle; pin->offset = be32_to_cpu(*list++) *
>>>> MA35_MFP_REG_SZ_PER_BANK + MA35_MFP_REG_BASE; pin->shift =
>>>> (be32_to_cpu(*list++) * MA35_MFP_BITS_PER_PORT) % 32; pin->muxval =
>>>> be32_to_cpu(*list++); phandle = list++; if (!phandle) return -EINVAL;
>>>> np_config = of_find_node_by_phandle(be32_to_cpup(phandle)); ret =
>>>> pinconf_generic_parse_dt_config(np_config, NULL, &pin->configs,
>>>> &pin->nconfigs); if (ret) return ret; grp->pins[j] =
>>>> npctl->info->get_pin_num(pin->offset, pin->shift); pin++; } Best
>>>> Regards, Jacky Huang
>>> Sorry, I cannot parse it.
>>>
>>> I was referring to the children with unit addresses. I don't see any
>>> populate of the children, so why do you need them?
>>>
>>> There are no compatibles, either.
>>>
>>> Which part of your driver uses them exactly?
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> So, I should update the binding from "^pin-[a-z0-9]+$" to something like
>> "-pincfg$".
>> Just remove the unit address part, and it will become:
>>
>>       default-pincfg {
>>           slew-rate = <0>;
>>           input-schmitt-disable;
>>           bias-disable;
>>           power-source = <1>;
>>           drive-strength = <17100>;
>>       };
>>
> No, it solves nothing. Instead of pasting more code, can you answer my
> questions?
>
> Best regards,
> Krzysztof
>

Yes, this node is invalid.
I will drop this node and update the yaml.


Best Regards,
Jacky Huang

