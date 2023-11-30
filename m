Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7297FE57A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjK3BKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3BKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:10:43 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E447D54;
        Wed, 29 Nov 2023 17:10:49 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cfabcbda7bso12781305ad.0;
        Wed, 29 Nov 2023 17:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701306649; x=1701911449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6kr++LNoxhde2bcZzOtmobI8frTG3Z3GI3sj4jeWRAI=;
        b=UndvKYlQUAGJwWgR7edKECRLAh1w3F5UF9zSMMGBJ7PdkCXMYKcAaje5X+YiMpV8ys
         Oiq/8ovy9G05zg9uEueFZsrOHOd/WfZ7kd0grHf5JlwpoHMQ6zCvxgTENjjOJWQpkgPZ
         m78/KRgZENp8BUo1kPDGkwYNhqOSg7J+i6rgMcC57D9r9+4w86HfMtGvo502nlpduVTP
         2xPLoUO9ocBB7e+x3+O+93Igl1dFEYN9PCimIEq3VAvZvHPnI5BbXsUQwZ44HrwH3eXo
         5Fc2d7IErQSffj7676hxq5zKR1h3cr8nF+g8uKcJmsZbJKGw/xujx95qyoenE/L4cz9T
         o9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701306649; x=1701911449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kr++LNoxhde2bcZzOtmobI8frTG3Z3GI3sj4jeWRAI=;
        b=QnY08srcGP4K74S/wpwwsN3bxEFXeK+iByoi/YkWW6JwBXc3UpCRSi7DAJfCve91aX
         VwQTlofg9hcJSfXUcwNEE4re+lCokbEY8M+bvhW3o9ALOqfKyCtrejiv3QL7uCikkBOD
         pzjgHpEuFMQxB0D0Ni9EOkkWp5uTNH2JO6rmFRT+f3zUJHTpQ6yc8VrrM5DrC9IyIcyi
         ZaM7dzSr/baW5Yp81T0FTE5aF9aBpv2iGvb7zj8Ied3xDU312/Z+vzYbYKhcCAl5toKy
         4+ic1aktWClmd8zus6C+ilsdYRl2G8qMNly7p4N01Wbk7hVNKtJuezRb398cs/YPh0rN
         w+Kw==
X-Gm-Message-State: AOJu0YzP2LZL86cK3EHFq47NlphhBTGn7X3wzFhRvJI97RK6UU83ryN8
        0kF4Qh+yGAvnWEFnBXonBXI=
X-Google-Smtp-Source: AGHT+IFWKugnGgB1Wx5UQ8Ed3SqjSAv0dxwnnx3lzDGxGYzLin7pZRhR0k2UbIAlXVeKgqTYI/B63A==
X-Received: by 2002:a17:902:d2cb:b0:1cf:de3e:e4c9 with SMTP id n11-20020a170902d2cb00b001cfde3ee4c9mr17280161plc.29.1701306648523;
        Wed, 29 Nov 2023 17:10:48 -0800 (PST)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id w1-20020a636201000000b005b32d6b4f2fsm53522pgb.81.2023.11.29.17.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 17:10:48 -0800 (PST)
Message-ID: <9c41e6d4-fe47-4e87-b0a7-f5ecaec720b3@gmail.com>
Date:   Thu, 30 Nov 2023 09:10:43 +0800
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
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <e3bc24d6-d9ef-4705-8de7-05460f915b17@linaro.org>
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

Dear Krzysztof,


On 2023/11/29 下午 06:54, Krzysztof Kozlowski wrote:
> On 29/11/2023 11:14, Jacky Huang wrote:
>> Dear Krzysztof,
>>
>>
>> On 2023/11/29 下午 06:02, Krzysztof Kozlowski wrote:
>>> On 29/11/2023 10:41, Jacky Huang wrote:
>>>> Dear Krzysztof,
>>>>
>>>>
>>>> On 2023/11/29 下午 04:11, Krzysztof Kozlowski wrote:
>>>>> On 29/11/2023 04:35, Jacky Huang wrote:
>>>>>>>>> Best regards,
>>>>>>>>> Krzysztof
>>>>>>>>>
>>>>>>>> Yes, it did pass the 'dtbs_check'. I guess the tool does not detect such
>>>>>>>> issues.
>>>>>>>> Anyway, I will fix it in the next version.
>>>>>>> Hm, I see your bindings indeed allow pin-.* and unit addresses, so it is
>>>>>>> the binding issue.
>>>>>>>
>>>>>>> The examples you used as reference - xlnx,zynqmp-pinctrl.yaml and
>>>>>>> realtek,rtd1315e-pinctrl.yaml - do not mix these as you do.
>>>>>>>
>>>>>>> I don't understand why do you need them yet. I don't see any populate of
>>>>>>> children. There are no compatibles, either.
>>>>>>>
>>>>>>> Which part of your driver uses them exactly?
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Krzysztof
>>>>>>>
>>>>>> I will move the 'pcfg_default: pin-default' from dtsi to dts, like this:
>>>>>>
>>>>>> &pinctrl {
>>>>>>         pcfg_default: pin-default {
>>>>>>             slew-rate = <0>;
>>>>>>             input-schmitt-disable;
>>>>>>             bias-disable;
>>>>>>             power-source = <1>;
>>>>>>             drive-strength = <17100>;
>>>>>>         };
>>>>> This solves nothing. It's the same placement.
>>>>>
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>>
>>>> OK, it stil be the binding issues.
>>>> For "^pin-[a-z0-9]+$", I reference to the "pcfg-[a-z0-9-]+$" of
>>>> rockchip,pinctrl.yaml.
>>>>
>>>> My intention is to describe a generic pin configuration, aiming to make
>>>> the pin
>>>> description more concise. In actual testing, it proves to be effective.
>>> Can you instead respond to my actual questions?
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> The the last one item of nuvoton,pins is a phandle, which can refer to
>> '&pin-default'. The following code of driver pinctrl-ma35.c parse
>> "nuvoton,pins", including the node reference by phandle. list =
>> of_get_property(np, "nuvoton,pins", &size); size /= sizeof(*list); if
>> (!size || size % 4) { dev_err(npctl->dev, "wrong setting!\n"); return
>> -EINVAL; } grp->npins = size / 4; grp->pins = devm_kzalloc(npctl->dev,
>> grp->npins * sizeof(*grp->pins), GFP_KERNEL); if (!grp->pins) return
>> -ENOMEM; pin = grp->settings = devm_kzalloc(npctl->dev, grp->npins *
>> sizeof(*grp->settings), GFP_KERNEL); if (!grp->settings) return -ENOMEM;
>> for (i = 0, j = 0; i < size; i += 4, j++) { struct device_node
>> *np_config; const __be32 *phandle; pin->offset = be32_to_cpu(*list++) *
>> MA35_MFP_REG_SZ_PER_BANK + MA35_MFP_REG_BASE; pin->shift =
>> (be32_to_cpu(*list++) * MA35_MFP_BITS_PER_PORT) % 32; pin->muxval =
>> be32_to_cpu(*list++); phandle = list++; if (!phandle) return -EINVAL;
>> np_config = of_find_node_by_phandle(be32_to_cpup(phandle)); ret =
>> pinconf_generic_parse_dt_config(np_config, NULL, &pin->configs,
>> &pin->nconfigs); if (ret) return ret; grp->pins[j] =
>> npctl->info->get_pin_num(pin->offset, pin->shift); pin++; } Best
>> Regards, Jacky Huang
> Sorry, I cannot parse it.
>
> I was referring to the children with unit addresses. I don't see any
> populate of the children, so why do you need them?
>
> There are no compatibles, either.
>
> Which part of your driver uses them exactly?
>
> Best regards,
> Krzysztof
>
So, I should update the binding from "^pin-[a-z0-9]+$" to something like 
"-pincfg$".
Just remove the unit address part, and it will become:

     default-pincfg {
         slew-rate = <0>;
         input-schmitt-disable;
         bias-disable;
         power-source = <1>;
         drive-strength = <17100>;
     };


Best Regards,
Jacky Huang




