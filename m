Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC247AEAF1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbjIZK7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbjIZK66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:58:58 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519CD198
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:58:50 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so140091911fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695725928; x=1696330728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uw1cUsiT57O3RUVdq5mZiqTz08pOHH5WJzsYWq/LW4w=;
        b=LDs36G73REglQOX9D/Nya1bWJXhVrk7ORjYwC6a3KKQdd8ycOnerhIDZ8PA8098Tb5
         yj01CRMSd8x57BhfdqYEurmSNlDe85jiwc3wy1IBJre9ue4kUG1kvgDB+Phvi25kl6f7
         OKP/mimaxCloGoKbLoMm80RW4QEdcwDWyze26yyz9PUeNFSZ8KwDK4g5OgwUOOC6c5MW
         CilxLhNnKGoUWgtl2PKeGNSXYXXX/8zYxMj+MNNaNOWk9EpaHy5TNZKecKCbX46JBerS
         5T0OXAx9gMR8AxKLTYxOZyRPhw6GfS6ghLN3taeqSxVKzem4O4iSlkuxG4YRLYw90A1q
         XUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695725928; x=1696330728;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uw1cUsiT57O3RUVdq5mZiqTz08pOHH5WJzsYWq/LW4w=;
        b=mRxr8PpjrVz61cqbZcLnfUN250M0JikyOJIb49YKTKpRpDDo2MNDuMV6PBtnIMntYH
         FrpRCo8g+GWjih7vGYEM41TfTBEejuIydVuWrcZCMSZBNxs0eVLYkWTajC6lFJICgZyT
         oSFNB5n9OsO3iw0b0Gd3ofofU/IdTsv3eXJ8kzx+cDDZqMnbudrNz5L6tWk3OzqInqLN
         yAlrF/+Ed8tj0I4G6zqCUALVUT0Y/C538u6H6QoBKVL2ht335fDg43xP3Im1MOGpqMnY
         EKTM7RXHgTIPOHfe7FqGTSNHnyfG1Y+dxtIJwcpx/d4A3hO17vadEp3uEyE5/3gZrBeP
         2png==
X-Gm-Message-State: AOJu0YwwLSEtFZBueu6tPDDgC3obmx5Km8ujEH44UHhdsowWXNDx1IlB
        jwtVOB0x2MOJbkngmeRh5R/Gjg==
X-Google-Smtp-Source: AGHT+IG6q6rzMJI50tbGhCpzLWa59Dfr/8oOlsuBHFVc+7zzzxAnHqZNID2Eo94dRB44wFNMHKElWw==
X-Received: by 2002:a2e:2e0f:0:b0:2b6:a3a0:5f7 with SMTP id u15-20020a2e2e0f000000b002b6a3a005f7mr7763488lju.9.1695725928289;
        Tue, 26 Sep 2023 03:58:48 -0700 (PDT)
Received: from [192.168.32.2] ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id k22-20020a170906129600b009aa292a2df2sm7548486ejb.217.2023.09.26.03.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 03:58:47 -0700 (PDT)
Message-ID: <64e91f8d-a94e-c835-75ef-ce9ab557dc54@tuxon.dev>
Date:   Tue, 26 Sep 2023 13:58:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 30/37] pinctrl: renesas: rzg2l: add support for RZ/G3S SoC
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
 <20230912045157.177966-31-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdV2GEKF0QjKudz529_tmUksTNMJtZu9NwC18KX-AXwaeg@mail.gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdV2GEKF0QjKudz529_tmUksTNMJtZu9NwC18KX-AXwaeg@mail.gmail.com>
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

On 21.09.2023 17:58, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Tue, Sep 12, 2023 at 6:53 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Add basic support for RZ/G3S to be able to boot from SD card, have a
>> running console port and use GPIOs. RZ/G3S has 82 general-purpose IO
>> ports. Support for the remaining pin functions (e.g. Ethernet, XSPI)
>> will be added along with controller specific support.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
>> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
>> @@ -1330,6 +1336,36 @@ static const u32 r9a07g043_gpio_configs[] = {
>>         RZG2L_GPIO_PORT_PACK(6, 0x22, RZG2L_MPXED_PIN_FUNCS),
>>  };
>>
>> +static const u32 r9a08g045_gpio_configs[] = {
>> +       RZG2L_GPIO_PORT_PACK(4, 0x20, RZG3S_MPXED_PIN_FUNCS(A)),                        /* P0  */
>> +       RZG2L_GPIO_PORT_PACK(5, 0x30, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
>> +                                                               PIN_CFG_IO_VMC_ETH0)),  /* P1 */
> 
> P1_0 and P7_0 have IEN functionality.
> I don't know how to represent that...

I think Prabhakar's series at [1] may help (or make a step forward) in
supporting this. I have in mind to wait for it and adapt RZ/G3S afterwards.

[1]
https://lore.kernel.org/all/20230630120433.49529-2-prabhakar.mahadev-lad.rj@bp.renesas.com/

> 
>> +       RZG2L_GPIO_PORT_PACK(4, 0x31, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
>> +                                                               PIN_CFG_IO_VMC_ETH0)),  /* P2 */
>> +       RZG2L_GPIO_PORT_PACK(4, 0x32, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
>> +                                                               PIN_CFG_IO_VMC_ETH0)),  /* P3 */
>> +       RZG2L_GPIO_PORT_PACK(6, 0x33, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
>> +                                                               PIN_CFG_IO_VMC_ETH0)),  /* P4 */
>> +       RZG2L_GPIO_PORT_PACK(5, 0x21, RZG3S_MPXED_PIN_FUNCS(A)),                        /* P5  */
>> +       RZG2L_GPIO_PORT_PACK(5, 0x22, RZG3S_MPXED_PIN_FUNCS(A)),                        /* P6  */
>> +       RZG2L_GPIO_PORT_PACK(5, 0x34, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
>> +                                                               PIN_CFG_IO_VMC_ETH1)),  /* P7 */
>> +       RZG2L_GPIO_PORT_PACK(5, 0x35, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
>> +                                                               PIN_CFG_IO_VMC_ETH1)),  /* P8 */
>> +       RZG2L_GPIO_PORT_PACK(4, 0x36, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
>> +                                                               PIN_CFG_IO_VMC_ETH1)),  /* P9 */
>> +       RZG2L_GPIO_PORT_PACK(5, 0x37, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
>> +                                                               PIN_CFG_IO_VMC_ETH1)),  /* P10 */
>> +       RZG2L_GPIO_PORT_PACK(4, 0x23, RZG3S_MPXED_PIN_FUNCS(B) | PIN_CFG_IEN),          /* P11  */
> 
> P11_0 does not have IEN functionality.
> I don't know how to represent that...

Same here.

> 
>> +       RZG2L_GPIO_PORT_PACK(2, 0x24, RZG3S_MPXED_PIN_FUNCS(B) | PIN_CFG_IEN),          /* P12  */
>> +       RZG2L_GPIO_PORT_PACK(5, 0x25, RZG3S_MPXED_PIN_FUNCS(A)),                        /* P13  */
>> +       RZG2L_GPIO_PORT_PACK(3, 0x26, RZG3S_MPXED_PIN_FUNCS(A)),                        /* P14  */
>> +       RZG2L_GPIO_PORT_PACK(4, 0x27, RZG3S_MPXED_PIN_FUNCS(A)),                        /* P15  */
>> +       RZG2L_GPIO_PORT_PACK(2, 0x28, RZG3S_MPXED_PIN_FUNCS(A)),                        /* P16  */
>> +       RZG2L_GPIO_PORT_PACK(4, 0x29, RZG3S_MPXED_PIN_FUNCS(A)),                        /* P17  */
>> +       RZG2L_GPIO_PORT_PACK(6, 0x2a, RZG3S_MPXED_PIN_FUNCS(A)),                        /* P18 */
>> +};
>> +
>>  static const struct {
>>         struct rzg2l_dedicated_configs common[35];
>>         struct rzg2l_dedicated_configs rzg2l_pins[7];
>> @@ -1416,6 +1452,46 @@ static const struct {
>>         }
>>  };
>>
>> +static const struct rzg2l_dedicated_configs rzg3s_dedicated_pins[] = {
>> +       { "NMI", RZG2L_SINGLE_PIN_PACK(0x0, 0, (PIN_CFG_FILONOFF | PIN_CFG_FILNUM |
>> +                                               PIN_CFG_FILCLKSEL)) },
>> +       { "TMS/SWDIO", RZG2L_SINGLE_PIN_PACK(0x1, 0, (PIN_CFG_IOLH_A | PIN_CFG_IEN |
>> +                                                     PIN_CFG_SOFT_PS)) },
>> +       { "TDO", RZG2L_SINGLE_PIN_PACK(0x1, 1, (PIN_CFG_IOLH_A | PIN_CFG_SOFT_PS)) },
>> +       { "WDTOVF_PERROUT#", RZG2L_SINGLE_PIN_PACK(0x6, 0, PIN_CFG_IOLH_A | PIN_CFG_SOFT_PS) },
>> +       { "SD0_CLK", RZG2L_SINGLE_PIN_PACK(0x10, 0, (PIN_CFG_IOLH_B | PIN_CFG_IO_VMC_SD0)) },
>> +       { "SD0_CMD", RZG2L_SINGLE_PIN_PACK(0x10, 1, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
>> +                                                    PIN_CFG_IO_VMC_SD0)) },
>> +       { "SD0_RST#", RZG2L_SINGLE_PIN_PACK(0x10, 2, (PIN_CFG_IOLH_B | PIN_CFG_IO_VMC_SD0)) },
>> +       { "SD0_DATA0", RZG2L_SINGLE_PIN_PACK(0x11, 0, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
>> +                                                      PIN_CFG_IO_VMC_SD0)) },
>> +       { "SD0_DATA1", RZG2L_SINGLE_PIN_PACK(0x11, 1, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
>> +                                                      PIN_CFG_IO_VMC_SD0)) },
>> +       { "SD0_DATA2", RZG2L_SINGLE_PIN_PACK(0x11, 2, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
>> +                                                      PIN_CFG_IO_VMC_SD0)) },
>> +       { "SD0_DATA3", RZG2L_SINGLE_PIN_PACK(0x11, 3, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
>> +                                                      PIN_CFG_IO_VMC_SD0)) },
>> +       { "SD0_DATA4", RZG2L_SINGLE_PIN_PACK(0x11, 4, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
>> +                                                      PIN_CFG_IO_VMC_SD0)) },
>> +       { "SD0_DATA5", RZG2L_SINGLE_PIN_PACK(0x11, 5, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
>> +                                                      PIN_CFG_IO_VMC_SD0)) },
>> +       { "SD0_DATA6", RZG2L_SINGLE_PIN_PACK(0x11, 6, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
>> +                                                      PIN_CFG_IO_VMC_SD0)) },
>> +       { "SD0_DATA7", RZG2L_SINGLE_PIN_PACK(0x11, 7, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
>> +                                                      PIN_CFG_IO_VMC_SD0)) },
>> +       { "SD1_CLK", RZG2L_SINGLE_PIN_PACK(0x12, 0, (PIN_CFG_IOLH_B | PIN_CFG_IO_VMC_SD1)) },
>> +       { "SD1_CMD", RZG2L_SINGLE_PIN_PACK(0x12, 1, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
>> +                                                    PIN_CFG_IO_VMC_SD1)) },
>> +       { "SD1_DATA0", RZG2L_SINGLE_PIN_PACK(0x13, 0, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
>> +                                                      PIN_CFG_IO_VMC_SD1)) },
>> +       { "SD1_DATA1", RZG2L_SINGLE_PIN_PACK(0x13, 1, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
>> +                                                      PIN_CFG_IO_VMC_SD1)) },
>> +       { "SD1_DATA2", RZG2L_SINGLE_PIN_PACK(0x13, 2, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
>> +                                                      PIN_CFG_IO_VMC_SD1)) },
>> +       { "SD1_DATA3", RZG2L_SINGLE_PIN_PACK(0x13, 3, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
>> +                                                      PIN_CFG_IO_VMC_SD1)) },
> 
> Is there any specific reason you left out the XSPI, Audio clock, and I3C pins?

I kept only the necessary support for booting and having SDs, GPIO
functional as a way of proving that all that has been added has been tested
(similar to clock support). Thus, with e.g. XSPI support I will add at the
same time clocks and pinctrl.

> 
>> +};
>> +
>>  static int rzg2l_gpio_get_gpioint(unsigned int virq, const struct rzg2l_pinctrl_data *data)
>>  {
>>         unsigned int gpioint;
>> @@ -1823,6 +1899,40 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg = {
>>         .iolh_groupb_oi = { 100, 66, 50, 33, },
>>  };
>>
>> +static const struct rzg2l_hwcfg rzg3s_hwcfg = {
>> +       .regs = {
>> +               .pwpr = 0x3000,
>> +               .sd_ch = 0x3004,
>> +       },
>> +       .iolh_groupa_ua = {
>> +               /* 1v8 power source */
>> +               [RZG2L_IOLH_IDX_1V8] = 2200, 4400, 9000, 10000,
>> +               /* 2v5 power source */
>> +               [RZG2L_IOLH_IDX_2V5 ... RZG2L_IOLH_IDX_3V3 - 1] = RZG2L_INVALID_IOLH_VAL,
> 
> Can be dropped once zero means invalid.
> 
>> +               /* 3v3 power source */
>> +               [RZG2L_IOLH_IDX_3V3] = 1900, 4000, 8000, 9000,
>> +       },
>> +       .iolh_groupb_ua = {
>> +               /* 1v8 power source */
>> +               [RZG2L_IOLH_IDX_1V8] = 7000, 8000, 9000, 10000,
>> +               /* 2v5 power source */
>> +               [RZG2L_IOLH_IDX_2V5 ... RZG2L_IOLH_IDX_3V3 - 1] = RZG2L_INVALID_IOLH_VAL,
> 
> Can be dropped once zero means invalid.
> 
>> +               /* 3v3 power source */
>> +               [RZG2L_IOLH_IDX_3V3] = 4000, 6000, 8000, 9000,
>> +       },
>> +       .iolh_groupc_ua = {
>> +               /* 1v8 power source */
>> +               [RZG2L_IOLH_IDX_1V8] = 5200, 6000, 6550, 6800,
>> +               /* 2v5 source */
>> +               [RZG2L_IOLH_IDX_2V5] = 4700, 5300, 5800, 6100,
>> +               /* 3v3 power source */
>> +               [RZG2L_IOLH_IDX_3V3] = 4500, 5200, 5700, 6050,
>> +       },
>> +       .drive_strength_ua = true,
>> +       .iolh_groupb_oi = { [0 ... 3] = RZG2L_INVALID_IOLH_VAL, },
>> +       .func_base = 1,
>> +};
>> +
>>  static struct rzg2l_pinctrl_data r9a07g043_data = {
>>         .port_pins = rzg2l_gpio_names,
>>         .port_pin_configs = r9a07g043_gpio_configs,
>> @@ -1844,6 +1954,16 @@ static struct rzg2l_pinctrl_data r9a07g044_data = {
>>         .hwcfg = &rzg2l_hwcfg,
>>  };
>>
>> +static struct rzg2l_pinctrl_data r9a08g045_data = {
>> +       .port_pins = rzg2l_gpio_names,
>> +       .port_pin_configs = r9a08g045_gpio_configs,
>> +       .n_ports = ARRAY_SIZE(r9a08g045_gpio_configs),
>> +       .dedicated_pins = rzg3s_dedicated_pins,
>> +       .n_port_pins = ARRAY_SIZE(r9a08g045_gpio_configs) * RZG2L_PINS_PER_PORT,
>> +       .n_dedicated_pins = ARRAY_SIZE(rzg3s_dedicated_pins),
>> +       .hwcfg = &rzg3s_hwcfg,
>> +};
>> +
>>  static const struct of_device_id rzg2l_pinctrl_of_table[] = {
>>         {
>>                 .compatible = "renesas,r9a07g043-pinctrl",
> 
> Please add a BUILD_BUG_ON() check for RZ/G3S to the
> rzg2l_pinctrl_probe() function, as is done for the other SoCs in
> the family.

Ok.

> 
> The rest LGTM.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
