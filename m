Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185E67B11D7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 06:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjI1Ez5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 00:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjI1Ezx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 00:55:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5686812A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:55:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bdcade7fbso1540373366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695876948; x=1696481748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRoZ9U8WPN+Qr3fM7UT4CjFDZZqBDxWZDvc7yR6K5h0=;
        b=d0oyf8m3qm5rklWiT/R30kvt4WfzwTKMe6jjY5/Iwv/Y8XlJpH8MjUFNrn3+zwNpvY
         Bya/r3q8L0EvaBav+sxt0WaBF1HjhRuSbmrMO/gub6qLNV3WqAZyRbRaDb051QluCaji
         c8/4niu+xDJABda20M8xnCOeerIZuV5lECuP/zcXDkrc3XLdQVpCAZi2UPi5SrfVYHu6
         2+TPUCGktlSDTL1pZUPfFPu0oMB3ePVnGfS3koNuv5X2exSS5DNlItwO+8iaxjRtxqJV
         Lziyr3kNdaVx31nzizJfYdIhMiSd5mS0ywNlvFl2k2uBHim28zuFOBp/x7EoGQ2OZ7yr
         hEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695876948; x=1696481748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRoZ9U8WPN+Qr3fM7UT4CjFDZZqBDxWZDvc7yR6K5h0=;
        b=qjG/34JCIMTrOKA3iecpj3JlQvYdtggFL4M/EYKlU1eOlbNrKlt165bLK56vjC8Oyy
         rsslZV+NchF4H5x/hB63eMM20vDRJq4AhYwZ1RsuDWx9Fx+dK8lclFM3v9PC3z2v1m22
         BE7DUJ+5Jgc9EJ53MZ6zGGgqJs3ggWWceS7CHJfrcTNiM59Pl+bHL2CrdPcTlA/7x0e7
         BiVpyaNgxRJOuLD7VtJVGSTm+/nuz+Q0V0ybtENX56aMoVAo8t6Wh+zyb+ax31gp7IUo
         Ijm2pmO7QyIk62v7mZIm1em/C66rh8V9sxrvTuBLfFe8b7noo8jUFLwRFxyOA2XgL8wT
         oX3Q==
X-Gm-Message-State: AOJu0Yw0PJzLMhLmrDsKsjTxfWZoQuTQUv8KVUy5k7c0dZopUAP0CoEw
        U/DIxzRef36GzyxkgyRtrFQxsw==
X-Google-Smtp-Source: AGHT+IE3pAEjLgDO8zlyhmBRQp2g+CFl8YUn7EwT8APbyBoysQf9t3e6/pskUqprJEO69PoIDitB5w==
X-Received: by 2002:a17:907:78d5:b0:9ae:6ab9:af90 with SMTP id kv21-20020a17090778d500b009ae6ab9af90mr142567ejc.47.1695876947632;
        Wed, 27 Sep 2023 21:55:47 -0700 (PDT)
Received: from [192.168.32.2] ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id jt24-20020a170906ca1800b009929d998abcsm10195585ejb.209.2023.09.27.21.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 21:55:47 -0700 (PDT)
Message-ID: <25ba20db-6dca-7179-a892-9d9f87442313@tuxon.dev>
Date:   Thu, 28 Sep 2023 07:55:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 09/37] clk: renesas: rzg2l: fix computation formula
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-10-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdVNzgHqURohOgpFEaGn+6+rQTqsDomoS1u_-jn=GgmHXw@mail.gmail.com>
 <dfe64c7c-2f90-65a2-05fc-e96ec5113a60@tuxon.dev>
 <CAMuHMdXJ_gp5cdGpcK-kGk16YGDX8d9MEjQQkSobOGLphbJ5dQ@mail.gmail.com>
 <CAMuHMdV=r9704bNemDHWvjMJKbsBQJKqTxkKCeGUNp4iBNBoew@mail.gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdV=r9704bNemDHWvjMJKbsBQJKqTxkKCeGUNp4iBNBoew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Geert,

On 27.09.2023 11:00, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Tue, Sep 26, 2023 at 4:44 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Tue, Sep 26, 2023 at 1:47 PM claudiu beznea <claudiu.beznea@tuxon.dev> wrote:
>>> On 14.09.2023 15:55, Geert Uytterhoeven wrote:
>>>> On Tue, Sep 12, 2023 at 6:52 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>
>>>>> According to hardware manual of RZ/G2L (r01uh0914ej0130-rzg2l-rzg2lc.pdf)
>>>>> the computation formula for PLL rate is as follows:
>>>>>
>>>>> Fout = ((m + k/65536) * Fin) / (p * 2^s)
>>>>>
>>>>> and k has values in range [-32768, 32767]. Dividing k by 65536 with
>>>>> integer variables leads all the time to zero. Thus we may have slight
>>>>> differences b/w what has been set vs. what is displayed. Thus,
>>>>> get rid of this and decompose the formula before dividing k by 65536.
>>>>>
>>>>> Fixes: ef3c613ccd68a ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")
>>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> Thanks for your patch!
>>>>
>>>>> --- a/drivers/clk/renesas/rzg2l-cpg.c
>>>>> +++ b/drivers/clk/renesas/rzg2l-cpg.c
>>>>> @@ -696,18 +696,22 @@ static unsigned long rzg2l_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
>>>>>         struct pll_clk *pll_clk = to_pll(hw);
>>>>>         struct rzg2l_cpg_priv *priv = pll_clk->priv;
>>>>>         unsigned int val1, val2;
>>>>> -       unsigned int mult = 1;
>>>>> -       unsigned int div = 1;
>>>>> +       unsigned int div;
>>>>> +       u64 rate;
>>>>> +       s16 kdiv;
>>>>>
>>>>>         if (pll_clk->type != CLK_TYPE_SAM_PLL)
>>>>>                 return parent_rate;
>>>>>
>>>>>         val1 = readl(priv->base + GET_REG_SAMPLL_CLK1(pll_clk->conf));
>>>>>         val2 = readl(priv->base + GET_REG_SAMPLL_CLK2(pll_clk->conf));
>>>>> -       mult = MDIV(val1) + KDIV(val1) / 65536;
>>>>> +       kdiv = KDIV(val1);
>>>>>         div = PDIV(val1) << SDIV(val2);
>>>>>
>>>>> -       return DIV_ROUND_CLOSEST_ULL((u64)parent_rate * mult, div);
>>>>> +       rate = (u64)MDIV(val1) * parent_rate;
>>>>> +       rate += ((long long)parent_rate * kdiv) / 65536;
>>>>
>>>> As the division is a binary shift, you can use the mul_u64_u32_shr() helper,
>>>> and incorporate the sdiv shift at the same time:
>>>>
>>>>     rate += mul_u64_u32_shr(parent_rate, KDIV(val1), 16 + SDIV(val2));
>>
>>  [1]^
>>
>>>>
>>>> You can save a multiplication by premultiplying mdiv by 65536:
>>>>
>>>>     rate = mul_u64_u32_shr(parent_rate, (MDIV(val1) << 16)) + KDIV(val1),
>>>>                            16 + SDIV(val2));
>>
>> [2]^
>>
>>>
>>> Looking again at this: KDIV (aka DIV_K) could have negative values thus
>>> mul_u64_u32_shr() cannot be used here.
>>
>> That means you can indeed not use [1].

You're right. Thanks for the input!

>>
>> But you can still use [2], as MDIV() must be in the range 64..533[3],
>> so "(MDIV(val1) << 16)) + (s16)KDIV(val1)" is always positive.
>> Note that you do need the cast to s16 (which I had missed before), or
>> the intermediate variable kdiv of type s16 (like in your patch).
> 
> Or include the cast to a signed type in the definition of KDIV().
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
