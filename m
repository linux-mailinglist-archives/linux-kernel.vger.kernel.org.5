Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8707AE9B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjIZJ4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbjIZJ4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:56:10 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704EFCCD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 02:55:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a64619d8fbso1056305366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 02:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695722156; x=1696326956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oCGAB9bjd2rRkobql917EBDyBbo8Xf1tmOkuieid9Qw=;
        b=HFmsZ4RrW76dmgghgjnLmy/if7RGsBsH4gCiOAm04mIl6nM43bU4nQtLpo9Mipeio4
         JUhdNIn4w3HgA3gLB+81owUI+uiPg/4oyDitaKB+k6BzOwxh8C6RoMsHT6RFdWJ/t5fa
         kZkn3eT+bQKDuIZbyX+KdFGTZlx/r1PFcgLzEr1Wa9Gxr4hkCtQiDoaruQAnT9TdaoLw
         Lk8iZytyVRi3Hc982kBcXwdfyLV5KKQ7qefdk6LDk/U0aXwxhIAfzfZc7PFdV29YdBRj
         k6fRmlWHQ+eJ/xaWFtECSUf0Xd7QCXN5TOpRM4YTq/E0wPiTnPiEcvndPYLYKtNKLhqs
         A6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695722156; x=1696326956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oCGAB9bjd2rRkobql917EBDyBbo8Xf1tmOkuieid9Qw=;
        b=azGj/7a/iNF2/JQe6GT1ZXBlFrfMnHBSoz5OqZuXs3QoyiZrx5ECpePB23sGU8vMqe
         paHs1bT7fktepJTOKYnLUrX5Ki89dblkQ9LERWQ/Q+4LymybzGPXPSwoxfbscB6O3LxQ
         PENpnU76Rvfk9wRfFuv5jOcltiOf+bFGanhVM3nDB03VDEHtjSVernLwMkMAXtzQdfz+
         gNG1ano/gGGNMWk6isQEqFP0qd8m6Z9/tNeICb89dkDtRYHNNSdijmyr/G01hs4URUDa
         ROIOf+jvhSAX0qFrg5F0E0nKA65iPrlCTtphYN4+X8AInkpxqMJXe63TR5U8GQiGOhkc
         de1g==
X-Gm-Message-State: AOJu0Yx7djBmT3tT30hKP+//ESv6mqt9T2V7UT/T9Xyp/4KUgK9dLQt0
        VrthOQE6Jh0HXuRJIfLHM4su9g==
X-Google-Smtp-Source: AGHT+IEiQ8iJO3tEsrKT6DurQH2FvKo0uS+xJFcGLGiCr6SvtCfNXfJUyT6nkOwQSaE5M72oHauuhA==
X-Received: by 2002:a17:906:3188:b0:9ae:5fdc:aee8 with SMTP id 8-20020a170906318800b009ae5fdcaee8mr8441103ejy.53.1695722156458;
        Tue, 26 Sep 2023 02:55:56 -0700 (PDT)
Received: from [192.168.32.2] ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id j26-20020a170906831a00b00997d7aa59fasm7698269ejx.14.2023.09.26.02.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 02:55:55 -0700 (PDT)
Message-ID: <1f1b5174-cfd4-4393-3a86-9adfc8c2cce1@tuxon.dev>
Date:   Tue, 26 Sep 2023 12:55:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 25/37] pinctrl: renesas: rzg2l: adapt function number for
 RZ/G3S
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
 <20230912045157.177966-26-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdVkttQpA-s0MrKbTVxJ6K+xXmhV3sNNLTAPSbDa0f8XYA@mail.gmail.com>
Content-Language: en-US
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdVkttQpA-s0MrKbTVxJ6K+xXmhV3sNNLTAPSbDa0f8XYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Geert,

On 21.09.2023 15:51, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> Thanks for your patch!
> 
> On Tue, Sep 12, 2023 at 6:53 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> On RZ/G3S PFC register allow setting 8 functions for individual ports
>> (function1 to function8). For function1 register need to be configured
>> with 0, for function8 register need to be configured with 7.
>> We cannot use zero based addressing when requesting functions from
>> different code places as documentation (RZG3S_pinfunction_List_r1.0.xlsx)
>> states explicitly that function0 has different meaning.
> 
> According to that table, function0 is GPIO.

Yes, I'll mention it like this in the next version.

> 
>> For this add a new member to struct rzg2l_hwcfg that will keep the
>> offset that need to be substracted before applying a value to PFC register.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> But one question below...
> 
>> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
>> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
>> @@ -136,9 +136,11 @@ struct rzg2l_register_offsets {
>>  /**
>>   * struct rzg2l_hwcfg - hardware configuration data structure
>>   * @regs: hardware specific register offsets
>> + * @func_base: base number for port function (see register PFC)
>>   */
>>  struct rzg2l_hwcfg {
>>         const struct rzg2l_register_offsets regs;
>> +       u8 func_base;
>>  };
>>
>>  struct rzg2l_dedicated_configs {
>> @@ -221,6 +223,7 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
>>                                  unsigned int group_selector)
>>  {
>>         struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
>> +       const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
>>         const struct pinctrl_pin_desc *pin_desc;
>>         unsigned int i, *psel_val, *pin_data;
>>         struct function_desc *func;
>> @@ -247,9 +250,9 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
>>                 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
>>
>>                 dev_dbg(pctrl->dev, "port:%u pin: %u off:%x PSEL:%u\n", port,
>> -                       pin, off, psel_val[i]);
>> +                       pin, off, psel_val[i] - hwcfg->func_base);
>>
>> -               rzg2l_pinctrl_set_pfc_mode(pctrl, pin, off, psel_val[i]);
>> +               rzg2l_pinctrl_set_pfc_mode(pctrl, pin, off, psel_val[i] - hwcfg->func_base);
>>         }
>>
>>         return 0;
> 
> Perhaps the adjustment should be done in rzg2l_dt_subnode_to_map()
> instead, when obtaining MUX_FUNC() from DT? That would allow you to do
> some basic validation on it too, which is currently completely missing
> (reject out-of-range values overflowing into adjacent PFC fields,
> reject zero on RZ/G3S).

I'll have a look on this. I see .set_mux() can also be called from sysfs
though pinmux-select exported file thus, I don't know at the moment if
validating it on rzg2l_dt_subnode_to_map() will be enough.

Would it be OK to have this outside of this series or you would prefer it now?

Thank you,
Claudiu Beznea

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
