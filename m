Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BEA802C17
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbjLDHeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDHeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:34:15 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C93FE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 23:34:21 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b595bf5d2so42799255e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 23:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701675259; x=1702280059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xkT4drhpDzb1KxFICd/WEWnn5ymnnV9MLDEkeHmOOCg=;
        b=GenIlH1XvR/zKD5YWhSwyIkO2MBACS6//FJ7NdorbfkVGhJQPzPFvMwY2Rdv4DtlGe
         xXkUWqYAFWlI1VkUnoybT/g0ZquZsO1FKmoIb5+pejaplNVHc/M/ZX9KCwDVkQf1jArY
         YmEB4ZfHdSzhKNU0wMH4svMvKTqfY5lFzLu68ZEZ1vAElx9GjleOy+Zs9c4iybZF2Wnr
         QFBLyx90Fsj+cqBh4YHhylVQxnu8hEEC///EnNB7ViEXW0ZgH6jhA7S4V8NLEJpHrSuk
         q6G/GAEcxWiiKt0AJfy3zvy+yenG2r4U1pD2Iu+xF/RczI6JqbQFDxfixkj5w8w0UBJm
         cQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701675259; x=1702280059;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkT4drhpDzb1KxFICd/WEWnn5ymnnV9MLDEkeHmOOCg=;
        b=Rja4wObZkVfuSznRQ/JIkUleDab2qB2cM4hH5s0XhVWiclB4bAXMAZQSzMqLW6GFvl
         lv53ZmIO0gxLvjeqkBWC50ccWJ97KlJTHnOYX/9jNp2ZKZSxxiXgBuJPkEu28cm0TLXv
         aaDbugSKYXEm3E8RkrNEoXzBu/PAcoh8rdt7aruNZd73tFEzFhjhQUXg3RcMNx52M+dl
         gGYpPeb/ZQqG58oDVbcPfAFmOQSB+bNEJ0mhDyX7MAOimFt3c/9fmElKdODsDnogP+Rz
         kYDYRKBCaL0ZCJm13zFIl+BoxzmavMWneCw9fmyQPER9kvgbArhPPQ2m8GsJStUpQiXl
         3V6w==
X-Gm-Message-State: AOJu0YywASnbMtYxYh8e+JPMFs7C7JEB24EFjHPrB3L7p2l9k7ZV/zYE
        PQaDQol0kykidS7XJJxAg0HPxA==
X-Google-Smtp-Source: AGHT+IFLd6uc1esRdus+n5JgwFdcILDLg2A8pTlH3V20qyXL/Hq+B/C3Ab2ic/OSyJAfnTqf0Cf6YA==
X-Received: by 2002:a05:600c:4d96:b0:40b:4268:f375 with SMTP id v22-20020a05600c4d9600b0040b4268f375mr1338522wmp.36.1701675259379;
        Sun, 03 Dec 2023 23:34:19 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.22])
        by smtp.gmail.com with ESMTPSA id q13-20020a05600c46cd00b004063c9f68f2sm13978721wmo.26.2023.12.03.23.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Dec 2023 23:34:19 -0800 (PST)
Message-ID: <abbf8d0b-b766-4734-b4e9-a963e1dc8810@tuxon.dev>
Date:   Mon, 4 Dec 2023 09:34:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] clk: renesas: r9a08g045-cpg: Add clock and reset
 support for ETH0 and ETH1
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@armlinux.org.uk, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
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
 <20231120070024.4079344-5-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWwn8xcKX3vgawtGqksuMM3CKZx=3k6EKP3kDFZxbocdA@mail.gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdWwn8xcKX3vgawtGqksuMM3CKZx=3k6EKP3kDFZxbocdA@mail.gmail.com>
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

Hi, Geert,

On 01.12.2023 17:59, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Mon, Nov 20, 2023 at 8:01 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> RZ/G3S has 2 Gigabit Ethernet interfaces available. Add clock and reset
>> support for both of them.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/clk/renesas/r9a08g045-cpg.c
>> +++ b/drivers/clk/renesas/r9a08g045-cpg.c
>> @@ -217,6 +219,16 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
>>                                         MSTOP(PERI_COM, BIT(11))),
>>         DEF_MOD("sdhi2_aclk",           R9A08G045_SDHI2_ACLK, R9A08G045_CLK_P1, 0x554, 11,
>>                                         MSTOP(PERI_COM, BIT(11))),
>> +       DEF_COUPLED("eth0_axi",         R9A08G045_ETH0_CLK_AXI, R9A08G045_CLK_M0, 0x57c, 0,
>> +                                       MSTOP(PERI_COM, BIT(2))),
>> +       DEF_COUPLED("eth0_chi",         R9A08G045_ETH0_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 0,
>> +                                       MSTOP(PERI_COM, BIT(2))),
>> +       DEF_MOD("eth0_refclk",          R9A08G045_ETH0_REFCLK, R9A08G045_CLK_HP, 0x57c, 8, 0),
>> +       DEF_COUPLED("eth1_axi",         R9A08G045_ETH1_CLK_AXI, R9A08G045_CLK_M0, 0x57c, 1,
>> +                                       MSTOP(PERI_COM, BIT(3))),
>> +       DEF_COUPLED("eth1_chi",         R9A08G045_ETH1_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 1,
>> +                                       MSTOP(PERI_COM, BIT(3))),
>> +       DEF_MOD("eth1_refclk",          R9A08G045_ETH1_REFCLK, R9A08G045_CLK_HP, 0x57c, 9, 0),
>>         DEF_MOD("scif0_clk_pck",        R9A08G045_SCIF0_CLK_PCK, R9A08G045_CLK_P0, 0x584, 0,
>>                                         MSTOP(MCPU2, BIT(1))),
>>         DEF_MOD("gpio_hclk",            R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0, 0),
> 
> LGTM, pending the MSTOP() part.
> 
> Is the MSTOP() handling needed to function? IIUIC, all modules are
> enabled
> out of reset.

MSTOP is not needed for Ethernet to work. Indeed, all modules are enabled
out of reset.

> If it is not needed, I can take this patch and remove the MSTOP() part.

It's OK for me. Thank you for handling this.

Anyway, let me know if you encounter issues with it so I can resend it.

Thank you,
Claudiu Beznea

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
