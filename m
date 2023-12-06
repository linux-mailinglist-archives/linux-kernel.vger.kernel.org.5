Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12038806E01
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377640AbjLFLbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377613AbjLFLbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:31:34 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7D418D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:31:38 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a1db6816177so61969766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 03:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701862297; x=1702467097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQRUqPOJl21pxtz+qvje3X0j5jgtYYR7vWEnGFon7J0=;
        b=OAc93qBcLB0JINXohmFJNv5Ts61bZbpqAHTl0zkR9MjIADcMXHb53F1aoWWBGyK7YY
         KtdTd3LNzyUJZTK1ZJBZmUrXMBPhNLAHwZnKk28SgAJz1DGTGQYqJqp4GPeeezp3CN3Q
         HrAMF70lAM/AHzMwFRPDIwXK1sAyB6UWzOOiAHIAZLwDt9cF74Ymjlami7W2ZDWCC80k
         xJXMMGlTHUqTcpnReSs5FUPlqgfMcBuxViPpU9Hig8wpzCuQiFOrQkPqfawboCG+K7fW
         wYgsfUrNOPd4deWhMDLQ1Fpvb+LKGohHxXY/cT6pXqtyQ49FIoEuFOKG6orXGeJSxDRR
         g1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701862297; x=1702467097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQRUqPOJl21pxtz+qvje3X0j5jgtYYR7vWEnGFon7J0=;
        b=i7xGzd0M7zMd7heacPTOBnWxR6lpgFbocerMvW+It+dVsyyS8nuxqADBa5dYV5nbc8
         hEJslHxGSotEpqpKYLeSN3Y/fryClJnRZDT17OwdaX26vNbM68JtKhqAw6J0CmoaYK/K
         Iv3T3ZEHm3BhiFjZyI3ar97ceMQAWysdsxJIKZyLUMdOQJFElNCGrtMLRdyZs0m3fQUs
         Xe4+C4xdYmbqj8HQ/U64hxAbiZOC7rNeyShmURIf8BxR5f9WKpa4pqIZLE5dL70Xdo97
         YUWmLXcMTiI6FooJsP9XS1c8xCDiyIjRxNfSZAwa3phh3dWxJ/Btlsy85LYDIv1W0ZdK
         nmpw==
X-Gm-Message-State: AOJu0Yz7+aCwJJ2jsbQkeJqeW4Etojs4tLRvW3fVHokB8VFn4KcfxYFz
        LwtBDq/HJvtiizOJ9mZqtO0whA==
X-Google-Smtp-Source: AGHT+IFJ5a4vYKI7Ln74gNmwZjaExprtFCgmvccSvvLloul8tJqzuxrCdC0bjxwuxKyuhboAbKrUYQ==
X-Received: by 2002:a17:906:358e:b0:a1a:5cbf:4b5a with SMTP id o14-20020a170906358e00b00a1a5cbf4b5amr370491ejb.104.1701862297106;
        Wed, 06 Dec 2023 03:31:37 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.22])
        by smtp.gmail.com with ESMTPSA id hd18-20020a170907969200b00a1cbb289a7csm2054875ejc.183.2023.12.06.03.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 03:31:36 -0800 (PST)
Message-ID: <6e14077c-ceb6-4921-8db2-1dc4a99856c6@tuxon.dev>
Date:   Wed, 6 Dec 2023 13:31:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] arm64: renesas: rzg3s-smarc-som: Invert the logic
 for SW_SD2_EN macro
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@armlinux.org.uk, geert+renesas@glider.be,
        magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, p.zabel@pengutronix.de, arnd@arndb.de,
        m.szyprowski@samsung.com, alexandre.torgue@foss.st.com, afd@ti.com,
        broonie@kernel.org, alexander.stein@ew.tq-group.com,
        eugen.hristev@collabora.com, sergei.shtylyov@gmail.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120070024.4079344-12-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUbKe=yiXWNmk5BJFLtF2psx9khiDRGasT9WsnHz4RWsg@mail.gmail.com>
 <CAMuHMdXwSo1L9UuFg9RL0TLL_xzVt2r6QEFc0gtPoydpr4FmSQ@mail.gmail.com>
 <248d24a9-589e-4b92-94b6-98504f78d7b9@tuxon.dev>
 <CAMuHMdXo9Pj1NJ+XK-XKj18ynZ3gOxrXQpjMsTjfziTAyjYMdA@mail.gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdXo9Pj1NJ+XK-XKj18ynZ3gOxrXQpjMsTjfziTAyjYMdA@mail.gmail.com>
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



On 06.12.2023 13:27, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Wed, Dec 6, 2023 at 12:12 PM claudiu beznea <claudiu.beznea@tuxon.dev> wrote:
>> On 06.12.2023 12:56, Geert Uytterhoeven wrote:
>>> On Wed, Dec 6, 2023 at 11:33 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>> On Mon, Nov 20, 2023 at 8:03 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>
>>>>> The intention of SW_SD2_EN macro was to reflect the state of SW_CONFIG3
>>>>> switch available on RZ/G3S Smarc Module. According to documentation SD2
>>>>> is enabled when switch is in OFF state. For this, changed the logic of
>>>>> marco to map value 0 to switch's OFF state and value 1 to switch's ON
>>>>> state. Along with this update the description for each state for better
>>>>> understanding.
>>>>>
>>>>> The value of SW_SD2_EN macro was not changed in file because, according to
>>>>> documentation, the default state for this switch is ON.
>>>>>
>>>>> Fixes: adb4f0c5699c ("arm64: dts: renesas: Add initial support for RZ/G3S SMARC SoM")
>>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> Thanks for your patch!
>>>>
>>>>> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
>>>>> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
>>>>> @@ -14,8 +14,8 @@
>>>>>   *     0 - SD0 is connected to eMMC
>>>>>   *     1 - SD0 is connected to uSD0 card
>>>>>   * @SW_SD2_EN:
>>>>> - *     0 - SCIF1, SSI0, IRQ0, IRQ1 connected to SoC
>>>>> - *     1 - SD2 is connected to SoC
>>>>> + *     0 - (switch OFF) SD2 is connected to SoC
>>>>> + *     1 - (switch ON)  SCIF1, SSI0, IRQ0, IRQ1 connected to SoC
>>>>
>>>> I think this is still confusing: SW_SD2_EN refers to an active-low signal
>>>> (SW_SD2_EN#) in the schematics.
>>>
>>> OMG, while the signal is called "SW_SD2_EN#" in the schematics, it is
>>> _not_ active-low!
>>> SW_D2_EN# drives a STG3692 quad SPDT switch, and SD2 is enabled
>>> if SW_D2_EN# is high...
>>>
>>> The RZ/G3S SMARC Module User Manual says:
>>>
>>> Signal SW_SD2_EN ON: SD2 is disabled.
>>> Signal SW_SD2_EN OFF: SD2 is enabled.
>>
>> I followed the description in this manual, chapter 2.1.1 SW_CONFIG. The
>> idea was that these macros to correspond to individual switches, to match
>> that table (describing switches position) with this code as the user in the
>> end sets those switches described in table at 2.1.1 w/o necessary going
>> deep into schematic (at least in the beginning when trying different
>> functionalities).
>>
>> Do you think it would be better if we will have these macros named
>> SWCONFIGX, X in {1, 2, 3, 4, 5, 6} ?
> 
> Perhaps. A disadvantage would be that SW_CONFIG%u doesn't
> give any indication about its purpose...

That's the reason I chose initially to have the signal names instead of
SWCONFIGX.

Now seeing that signal names could be confusing I tend to go with SWCONFIGx
instead.

> 
>>> So whatever we do, something will look odd :-(
>>>
>>>> Before, SW_SD2_EN used assertion-logic (1 is enabled), and didn't
>>>> match the physical signal level.
>>>> After your patch, SW_SD2_EN matches the active-low physical level, but
>>>> this is not reflected in the name...
>>>>
>>>>>   */
>>>>>  #define SW_SD0_DEV_SEL 1
>>>>>  #define SW_SD2_EN      1
>>>>> @@ -25,7 +25,7 @@ / {
>>>>>
>>>>>         aliases {
>>>>>                 mmc0 = &sdhi0;
>>>>> -#if SW_SD2_EN
>>>>> +#if !SW_SD2_EN
>>>>
>>>> ... so this condition looks really weird.
>>>
>>> Still, I think the original looks nicer here.
>>>
>>> So I suggest to keep the original logic, but clarify the position of
>>> the switch.
>>> Does that make sense?
>>
>> It will still be odd, AFAICT, as this way as we will map 0 to ON and 1 to
>> OFF... A bit counterintuitive.
> 
> Most switches on board pull signals LOW when the switch is ON...
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
