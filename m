Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6127F2B66
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbjKULEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjKULDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:03:50 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A93ED76
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 03:03:28 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a02c48a0420so32996366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 03:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700564607; x=1701169407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ocOW+wDtvl9wtSJcVQOjkvft6Ekjwogemq66Yy+7vig=;
        b=jay/4mi6tMVsAkorg/DuQihHUxQY/iyzISw/IlBsrCZcuKtabOwoDqTM7iPfHnxDZy
         VZNoKkERz3B0xUGJXU2q0+fend0F1w3DYLU4NIe5wAYbFmSmIfACH2MLHlpHiAFcWUlA
         eJSW+Ken3U4LyqSMPJU8T39Aut7avgEIp4/v3UV3b3BPpqWUjeF+qmv/xaiSH57eGiaY
         MlqzK7N8CAKblq7L39UIcUPheq0fUVr0CeUH6nkDhWLenoc18OW10HHxvyjA0f/bgHPj
         8AfcIETzP5LL/tPOFl2tgks7KM0gkBXQtqLKb2Zc+OewRICD6f0d+8H/8eD80YH1w5AI
         a0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700564607; x=1701169407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocOW+wDtvl9wtSJcVQOjkvft6Ekjwogemq66Yy+7vig=;
        b=vYCRRzzDYpJbXhkTL3PjBNX10ZosyCOaqEXMixKNk2iJI18vbKJ0QG2cjKjPJj2ru6
         CFAkvvDf/zxyrlBD01iwecrfmPs4wvg2TmIi8AoOq7oecPXAZNvnug4Jrk14KjG1cI2T
         3kKxT6BaQb/8PhJhl3dj/YEdokrP2EnJ1v5Wn7HhAoM3KdexJEU0P2nVcaX3buXdi+Nj
         7GFtybM9hp3AL3m5Jv9mrxt02FdrkWbn3iNhRk3zEn/OVJ3N1+a/f6T6gdmv4ulrggBC
         zRzsWiqfCPWdF8NccbMbu2nyVQ9mRutmTtmL9aQr6FGcE7+l6AieoZEU0/QpvzpaiuBW
         ljHQ==
X-Gm-Message-State: AOJu0Yy1HCM0xD0YkoMO/eRbSOG/ibAFRz0ctUlyuQg7+gii0jjJFhkK
        pEis8rFoMtExQNSVkzVXoFb2jw==
X-Google-Smtp-Source: AGHT+IFraOZ+of1Nnh5fF4NLdfU3+RxtQZdG0uykUyhOhO7o4mzH+IpOupjDqWstj06JiptHz0lPHQ==
X-Received: by 2002:a17:906:3f1b:b0:9fe:a92b:9844 with SMTP id c27-20020a1709063f1b00b009fea92b9844mr4130736ejj.37.1700564606722;
        Tue, 21 Nov 2023 03:03:26 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.3])
        by smtp.gmail.com with ESMTPSA id f16-20020a17090624d000b00a02b519232bsm311964ejb.208.2023.11.21.03.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 03:03:26 -0800 (PST)
Message-ID: <c36cf6d0-181b-4a2c-9ccc-a585db66d5b8@tuxon.dev>
Date:   Tue, 21 Nov 2023 13:03:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] clk: renesas: r9a08g045: Add IA55 pclk and its
 reset
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231120111820.87398-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120111820.87398-2-claudiu.beznea.uj@bp.renesas.com>
 <e8637d39-911d-d8a3-b8da-548914df6ac@linux-m68k.org>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <e8637d39-911d-d8a3-b8da-548914df6ac@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Geert,

On 21.11.2023 11:59, Geert Uytterhoeven wrote:
>     Hi Claudiu,
> 
> On Mon, 20 Nov 2023, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> IA55 interrupt controller is available on RZ/G3S SoC. Add IA55 pclk and
>> its reset.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/clk/renesas/r9a08g045-cpg.c
>> +++ b/drivers/clk/renesas/r9a08g045-cpg.c
>> @@ -188,6 +188,7 @@ static const struct cpg_core_clk
>> r9a08g045_core_clks[] __initconst = {
>>
>> static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
>>     DEF_MOD("gic_gicclk",        R9A08G045_GIC600_GICCLK,
>> R9A08G045_CLK_P1, 0x514, 0),
>> +    DEF_MOD("ia55_pclk",        R9A08G045_IA55_PCLK, R9A08G045_CLK_P2,
>> 0x518, 0),
> 
> This conflicts with [1], which you sent just before.

Sorry for that, I intended to adapt the one that will have ended up last in
your tree.

> 
> If that patch goes in first, I guess this new entry should gain
> ", MSTOP(PERI_CPU, BIT(13))", just like the entry for ia55_clk?

That's right.

Thank you,
Claudiu Beznea

> 
>>     DEF_MOD("ia55_clk",        R9A08G045_IA55_CLK, R9A08G045_CLK_P1,
>> 0x518, 1),
>>     DEF_MOD("dmac_aclk",        R9A08G045_DMAC_ACLK, R9A08G045_CLK_P3,
>> 0x52c, 0),
>>     DEF_MOD("sdhi0_imclk",        R9A08G045_SDHI0_IMCLK, CLK_SD0_DIV4,
>> 0x554, 0),
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> [1] "clk: renesas: rzg2l-cpg: Add support for MSTOP"
>    
> https://lore.kernel.org/r/20231120070024.4079344-4-claudiu.beznea.uj@bp.renesas.com
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like
> that.
>                                 -- Linus Torvalds
