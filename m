Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B399C7645E7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjG0Fk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjG0FkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:40:22 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6422F3C24
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:38:52 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a1ebb85f99so526544b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436261; x=1691041061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WywdthfPTh+XfmRqlsarbdS3w8tnqax2JJ3u+Tr5fo=;
        b=UQbBxhMfOst5NWQV6gVQ0JJTWp5Vb6FIoSgT8tqKClUgcqvsdppOr7nsx1YKLKiXTM
         Pyca07NsQbrTjFLWardjLPcxkVKLtuT4aRWl8oDnKMyQkYJQBJY/Uh6e4qjHBj2PNnPe
         48c3KJBaBKRm4+PFUxF3tHz1WGI1p/oMqPfrtCxT6Y/pBuAnJYW9dAB6dfR3z1bDWi20
         uaCIEl3spqdFESgrHsOyMhfo2PjM3l6bQXfF1dIjP0pXfU2PqdYn9Wm/t5gwqjeJesYk
         bGvhtRpImS2dDbSwRyD1Nz4w7L8dVwydFOZRx8rTJkBoh+qPhKv1MvFl3s3v/ta5gH5c
         zQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436261; x=1691041061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WywdthfPTh+XfmRqlsarbdS3w8tnqax2JJ3u+Tr5fo=;
        b=ladyVQYTa2yQr4xaQzv4g94F08RUfTA/ewo+b1Qv8IenyEO7ATjJ8JdLTG+MBNwo0R
         gIJaNH0HvH+K7nZIeYAmCXbN9DcYcaMgp/V0+EhY1ChoW7NRLpVRl+8edWfUkPbdS7Cx
         JJ5GyYnWwFnw4K2TASV/4MEHjF04mRjhoTZjFDwvb6JFZ1EHMjJuZrbFMu+OpEQJJOvB
         s8aFu9BtSQo+Hq6sNlslnjKn3aqWQKB8t+5Gk9yMpjU4sBOf1Uy4OzXhGHA0fvbdYbxX
         zKnaW7zw3t25yrVqKNhhB28Zs433KUG0YD4LLViahhomrey+E3WkYp42HBTI/Mq/1/km
         XGcw==
X-Gm-Message-State: ABy/qLZzizUgmd2sS/y4oqvyD5J+z1PgFqIFedQwAC9z/Xmn4o2br5GN
        ejASASLfv6CEPQWp3ZzsEUmFvg==
X-Google-Smtp-Source: APBJJlH2LjwCUDsuM4N9A21r1wgRMpGLVv1sCSS0LVgt/Ju+ZtxNXj38rWLzRXbXE/flB/mRf27sfw==
X-Received: by 2002:a05:6808:1494:b0:3a2:a96d:19c3 with SMTP id e20-20020a056808149400b003a2a96d19c3mr2377106oiw.41.1690436261045;
        Wed, 26 Jul 2023 22:37:41 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id n29-20020a638f1d000000b0055b61cd99a1sm478848pgd.81.2023.07.26.22.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 22:37:40 -0700 (PDT)
Message-ID: <95420387-3cde-dd6e-3cb1-169ca56268d2@tuxon.dev>
Date:   Thu, 27 Jul 2023 08:37:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARM: dts: at91: ksz9477_evb: Add missing timer nodes
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>, Lukasz Majewski <lukma@denx.de>
Cc:     devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
References: <20230712152111.3756211-1-lukma@denx.de>
 <20230726101902.769f6541@wsk> <20230726-igloo-science-96e926f086f6@spud>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230726-igloo-science-96e926f086f6@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.07.2023 21:33, Conor Dooley wrote:
> On Wed, Jul 26, 2023 at 10:19:02AM +0200, Lukasz Majewski wrote:
>> Dear Community,
>>
>>> Without this change the KSZ9477-EVB board hangs just after passing
>>> execution flow from u-boot to Linux kernel.
>>>
>>> This code has been copied from at91-sama5d3_xplained.dts.
>>>
>>> Test setup: Linux 6.5-rc1
>>> Config:     arch/arm/configs/sama5_defconfig
>>> Toolchain:  gcc-linaro-7.3.1-2018.05-x86_64_arm-linux-gnueabi
>>>
>>> Signed-off-by: Lukasz Majewski <lukma@denx.de>
>>> ---
>>>   .../boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts  | 12
>>> ++++++++++++ 1 file changed, 12 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts
>>> b/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts index
>>> 14af1fd6d247..99cd6d15998b 100644 ---
>>> a/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts +++
>>> b/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts @@ -162,6
>>> +162,18 @@ };
>>>   };
>>>   
>>> +&tcb0 {
>>> +	timer0: timer@0 {
>>> +		compatible = "atmel,tcb-timer";
>>> +		reg = <0>;
>>> +	};
>>> +
>>> +	timer1: timer@1 {
>>> +		compatible = "atmel,tcb-timer";
>>> +		reg = <1>;
>>> +	};
>>> +};
>>> +
>>>   &usb0 {
>>>   	pinctrl-names = "default";
>>>   	pinctrl-0 = <&pinctrl_usba_vbus>;
>>
>> Gentle ping on this fix ...
> 
> Claudiu has left Microchip, so things might've got a bit lost on the
> way. I've added his new address, Claudiu, will you take a look/pick this
> up please? I can also do it if that is easier for you.

It's on my list.

Thanks,
Claudiu

> 
> Thanks,
> Conor.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
