Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730D475FF79
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjGXTEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXTEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:04:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3EB10E3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 12:04:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98e39784a85so1222001266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 12:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690225478; x=1690830278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pD2vBl11A3JvjZHMqQSC2wjAkgZG0vtIPFxmn1Ef91k=;
        b=EFXzdKlFp0p8frFe9WzpbOeuiavKsFiJxEUrOuGjVQgt5w+iM6gPQHY7cYmuT1d3Ee
         JUuEvTC0fYgt4pM9sse53nnelAUWit6ketlMm6HRceN64VXqlNxeBkE6XBgaTDoU0Vqh
         vp0sP9S88wt9ipFYSjbDLNk+DogKf2Y6WY/FusynFXA8fpnA7faExVEOfIY6GBk9ryn0
         ydq5YPSLPPK+ZRNUswld6dftuYlM9mHqKfUUVDrm2f3fMJOHUD07tSrUAyCmb0cLhvJn
         HkI5UBzSUfFe0qoRhGTak0JR3RXwl21Va0jsCt1piyUI0GdMjHp1bMYODW5dbZM9rENf
         zMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690225478; x=1690830278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pD2vBl11A3JvjZHMqQSC2wjAkgZG0vtIPFxmn1Ef91k=;
        b=KXNa6LQabrWMAL9FGAtLJfxFd+hptIMQUN8CHinfxH3y0+O7fOosQUvYBmgoBW57hP
         psOXqKIVNS01RzjO3F2V5Bm8mXiQd9BstlAmakkLYhR/7ez2H3x+J5aY0pnQ3jtY2fAi
         Jb4R5dHIeYLBa8uFnWDNleCdCYR7Mwf7LNToJbWEr27J5A0vtpubePb1KOiX107Mq/oq
         kxeO24qCXMC+R46TtRCywrzr8fhqdxzoqYfisyRcu+P4XG39WrcoYMeDnqKb8OGeGMHH
         HJh9XHluv9oEMooeK8gPOXB/YqpWYEBMOl0wYBX3VCelmUautX5Y81SPLhjE+jjKEkqf
         oQqg==
X-Gm-Message-State: ABy/qLbHmIPJrjNqEsyIVPT0sNGs3fZcyhXiBdPYplATAxvw60FMPwG7
        rTp8sb+ajh9fbJ+pYS1rmXSIMob11S8b6Uwb6jrfgg==
X-Google-Smtp-Source: APBJJlH8PcP6Ar2Yndr8PYDlOJafITRjY5SmRLH4Qin3oRRrz59+sQFYRpb2OYyIEjQxLiUEenK9Vw==
X-Received: by 2002:a17:907:75cb:b0:98d:4ae:8db9 with SMTP id jl11-20020a17090775cb00b0098d04ae8db9mr83481ejc.19.1690225478540;
        Mon, 24 Jul 2023 12:04:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w10-20020a1709062f8a00b00992c92af6f4sm7260070eji.144.2023.07.24.12.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 12:04:32 -0700 (PDT)
Message-ID: <22f7895b-244b-2140-0fff-33777e8bd8de@linaro.org>
Date:   Mon, 24 Jul 2023 21:04:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 07/42] soc: Add SoC driver for Cirrus ep93xx
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Andy Shevchenko <andy@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>
Cc:     linux-kernel@vger.kernel.org
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-7-3d63a5f1103e@maquefel.me>
 <0ec81b89-4d4c-4e13-5ea0-697f5c0af835@linaro.org>
 <4073daf401a820c0f64e6fa813b5253bd0427bcd.camel@maquefel.me>
 <886e29ec-a290-993a-d99a-d5fd90662e99@linaro.org>
 <9b51bd0a-271a-4830-9422-89ad853a67b6@app.fastmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9b51bd0a-271a-4830-9422-89ad853a67b6@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 20:04, Arnd Bergmann wrote:
> 
>>>>> +
>>>>> +       pr_info("EP93xx SoC revision %s\n", attrs->revision);
>>>>> +
>>>>> +       return 0;
>>>>> +}
>>>>> +core_initcall(ep93xx_soc_init);
>>>>
>>>> That's not the way to add soc driver. You need a proper driver for it
>>>
>>> What is a proper driver for these ? 
>>
>> Usually platform_driver, e.g. exynos-chipid.
> 
> Using a platform driver sounds like the right thing to do here,
> it's cleaner and should not be hard to do if the driver just matches
> the cirrus,ep9301-syscon node. I would have just merged
> the v3 version, but this is something that makes sense changing
> in v4.
> 
>>> Even the latest additions in drivers/soc/* go with *_initcall.
>>
>> Which one? Ones which call platform_driver_register()? That's quite
>> different story, isn't it? I don't see other recent cases, except
>> regulator couplers. They might be, some people send and accept poor
>> code, so what do you expect from us? Crappy code got in once, so more of
>> it can go?
> 
> That's not what is happening here, this is all part of an incremental
> improvement of the existing code. If the DT bindings make sense, I'm
> happy to take some shortcuts with the implementation that keep it
> closer to the existing implementation and either clean them up over
> time or just throw out the platform in five or ten years when the last
> machines are dead.

I am not saying that this is happening here, but the argument that once
we took some patch is not the reason to keep going. For sure we could
cut here some slack, unlike for big SoC vendors...

Best regards,
Krzysztof

