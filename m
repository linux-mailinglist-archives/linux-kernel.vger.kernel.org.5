Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D931777001
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjHJGIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjHJGIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:08:36 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683861994
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 23:08:35 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe4ad22e36so4735455e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 23:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691647714; x=1692252514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p0e0j+mOVNXfmgbebLeeHV/YeTp0gFm+U8YnF+fvMcc=;
        b=RmNLmcP1GXD4c6VBEl85jNdQDQy8g543rQHclmVF3pauFoY5RKczoniWQV8LzImfl0
         b/OaZviYVCajRSZO44BklswKOLpq4veNGoD2XNz79qf8sTX6bSJr4wxany3Z/UGEWWfk
         EhPzvdsD2onMx1c7k1egxXJBtqtOdI46+BCnIukHA0ZYHzjb6r7Gj+yBPl9O/T4/IlAg
         7B+6UO8dTYG9dvPrBYo2cNRpPLnx9+RKCrvgv+luaH0D8ehJhvAOH2dIoyN+gRf8UXkv
         hCAJIBAw8vIu2AVSSoH+iDCmSndMi8P2O4raDUsiFQnA3HsIL48rmjT/KRSpgQCfUbPr
         gNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691647714; x=1692252514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p0e0j+mOVNXfmgbebLeeHV/YeTp0gFm+U8YnF+fvMcc=;
        b=J8XM3gny3RlTYd+4/Kis8AeUV3+o8x6MCzCk+6T9WB7OC6Z6MgA8RZK66Ey2k9q4Sn
         cpGqz/esXaZSqNVVBGnf0a+vdCWJA4Az9ZlRpkRvPpCIjbvnwxLVVdQjYhq0Xe+psvk1
         xOcLLF9A+EkiRWTGxGVxtLgreCaAA3T1VKLM2i0BHbo0vlybZfBQPIDhQFAStMxLEUmq
         i/3cU9Kwrl/IwFm7kDSrAYOPJSuua6/SnT20VvqrAASBsoCeQ/uLIQzfRbK+zkImL7Na
         hdDp6zOg9wFiT9GDeHjbsZ03MYT2bEZYpWXZYZCDRfbtEE7oepuc/CtBxhWRUsUNkORs
         KaFg==
X-Gm-Message-State: AOJu0Yyrli30HxFLBtEzfy+h52tRZJWmJMidBXakzwk1k+0ZqjPnB+19
        vDmQmcEDyVdQojkzx+NtrF6tHQ==
X-Google-Smtp-Source: AGHT+IGuRbxtkVF5rtRNwLubFWM/KXOrLd15vCyh0rHGtTQ7U5FWocQviGG/mZJFNC9IOMvuay0evQ==
X-Received: by 2002:a05:600c:25a:b0:3fb:e1d5:7f48 with SMTP id 26-20020a05600c025a00b003fbe1d57f48mr1018328wmj.5.1691647713872;
        Wed, 09 Aug 2023 23:08:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id e7-20020a05600c218700b003fe3674bb39sm1016170wme.2.2023.08.09.23.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 23:08:33 -0700 (PDT)
Message-ID: <2d5b0f37-ac1e-c22a-9389-959fcfa74668@linaro.org>
Date:   Thu, 10 Aug 2023 08:08:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/2] gpio: dt-bindings: add parsing of loongson gpio
 offset
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn
References: <20230807074043.31288-1-zhuyinbo@loongson.cn>
 <20230807074043.31288-2-zhuyinbo@loongson.cn>
 <91f57b0d-a6e9-c039-40b6-0a1a9af5f7a0@linaro.org>
 <78c5a043-3e2a-48d6-88bd-2f91cc6d1347@loongson.cn>
 <f9a8897e-301e-9d69-be59-a5aa9290f01b@linaro.org>
 <36dd6038-933d-1513-1426-9c1283f3cbf8@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <36dd6038-933d-1513-1426-9c1283f3cbf8@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 05:35, Yinbo Zhu wrote:
> 
> 
> 在 2023/8/9 下午9:00, Krzysztof Kozlowski 写道:
>> On 09/08/2023 09:28, Yinbo Zhu wrote:
>>>>
>>>>>      - gpio-ranges
>>>>>      - interrupts
>>>>>    
>>>>> @@ -49,11 +82,16 @@ examples:
>>>>>        #include <dt-bindings/interrupt-controller/irq.h>
>>>>>    
>>>>>        gpio0: gpio@1fe00500 {
>>>>> -      compatible = "loongson,ls2k-gpio";
>>>>> +      compatible = "loongson,ls2k1000-gpio";
>>>>>          reg = <0x1fe00500 0x38>;
>>>>>          ngpios = <64>;
>>>>>          #gpio-cells = <2>;
>>>>>          gpio-controller;
>>>>> +      loongson,gpio-conf-offset = <0>;
>>>>> +      loongson,gpio-in-offset = <0x20>;
>>>>> +      loongson,gpio-out-offset = <0x10>;
>>>>> +      loongson,gpio-ctrl-mode = <0>;
>>>>> +      loongson,gpio-inten-offset = <0x30>;
>>>>
>>>> I still think that you just embed the programming model into properties,
>>>> instead of using dedicated compatible for different blocks. It could be
>>>> fine, although I would prefer to check it with your DTS
>>>
>>> Okay, I got it,  and if I understand correctly, you seem to agree with
>>> me adding attributes like this.
>>>
>>> And, if using this method that programming model into dts properites,
>>> then when adding a new platform's GPIO,  there is no longer a need to
>>> modify the driver because gpio controller is compatible and different
>>> platform can use a same compatible.
>>
>> Uhu, so there we are. You use this method now to avoid new compatibles.
>> No, therefore I do not agree.
> 
> 
> I don't seem to got it, if the GPIO controllers of two platforms are
> compatible, shouldn't they use the same compatible?

They can use the same fallback compatible, but you should have specific
compatible anyway. However they are not compatible, because programming
model is different.-

> 
>>
>>>
>>>>
>>>> Where is your DTS?
>>>
>>>
>>> Sorry, the dts containing gpio nodes are only available in the product
>>> code and have not been sent to the community yet.
>>
>> Does not help to convince us, but it is your right. With this and above
>> explanation, my answer is no - NAK.
> 
> 
> The community work for DTS on the 2K platform is still ongoing. Do I
> need to add a GPIO DTS node based on the following DTS to request your
> review?  so that you can more conveniently review whether my patch is
> suitable.
> 
> 2k1000
> https://lore.kernel.org/all/99bdbfc66604b4700e3e22e28c3d27ef7c9c9af7.1686882123.git.zhoubinbin@loongson.cn/
> 
> 2k500
> https://lore.kernel.org/all/c7087046a725e7a2cfde788185112c150e216f1b.1686882123.git.zhoubinbin@loongson.cn/
> 
> 2k2000
> https://lore.kernel.org/all/977009099c38177c384fca5a0ee77ebbe50e3ea2.1686882123.git.zhoubinbin@loongson.cn/

If you want to convince us that your properties makes sense, adding GPIO
nodes there would be helpful.

Best regards,
Krzysztof

