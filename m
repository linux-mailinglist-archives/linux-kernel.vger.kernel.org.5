Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2C2806E51
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377766AbjLFLs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377634AbjLFLs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:48:26 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704B1D72
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:48:32 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1915034144so93220666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 03:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701863311; x=1702468111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2atOuZ4m5Gd0/h1m8gOvMaL9Rsri8ziYxXRDoMiJ3Z4=;
        b=TMI0sLZt4OmnHOdX/rHF7lP7iEiiu9tDICwH446miWRtN5dLMIe3IJohkVCogVU1Vy
         Ow88vkSgWRAbCVEF5FMImYQGlDfchIVKT4g9XcItpG8Sy+83m4M1Q16LUblA+dTzoyk8
         AnZfP5hivKxbm86yvrQvzUjrWsy7yS3N/ncZr1oZG5mJIFyM2uTKHIsC25TyGeWNC29K
         hRNtfDXiT+77zvbU46YoEb3o9fdEJkW/5QchtqkwKNoDBclO2jbFG0/UE8SIKlt7SAge
         6cMiEWft9lP+8x8se8mwSC2kcajRWNWaSiaV+o1ciQFE6YKFKACdd/F3r8NVa1waKunl
         YEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701863311; x=1702468111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2atOuZ4m5Gd0/h1m8gOvMaL9Rsri8ziYxXRDoMiJ3Z4=;
        b=EAWzY0uIubsr3Gd+MWkF2HkpKt29s/jY1jm9fAtsexlMY8oZVLOZBTGTP7XCNcuPhj
         GSEXBjVGDrWOSjnOnuQc3yu/o5u2n1XGB3gOoBtFY0wCao0a564z5nEzHN4yKmVFw0sS
         Hz8sqAB/a2nsvBFwx+341FPOBLobuBL+HpC66+WzuOVH4waU19+Ezx1EXejs2S8c7krc
         syErQO6DBua5qYtKD/jBo0PdmydZVX79s7gMZDSz+ZPw2onhCek6ItfNzvvjdMi8RHo0
         SRhbVbrMLSKyCOVdUNNFLl5mBEEyzeNPZncnTm9R4IJ/vahKPp6+nR72pc7NabWOv0b+
         fqMQ==
X-Gm-Message-State: AOJu0YxvSSN1QxsSddiyjfr/cyDaUgqg4DuCHEU1HaNuanD+AhBgFkH/
        8+Ro2lxm7v4sbUT3Hn1DlDSmpQ==
X-Google-Smtp-Source: AGHT+IEdO1d6acuKq7fI7Zu+YUD1aCrLTPztZ/SxxNtASmnGXOvg9HfwOsUOMZBpcuZN8TYrQYwLYw==
X-Received: by 2002:a17:906:3408:b0:a19:a19b:c741 with SMTP id c8-20020a170906340800b00a19a19bc741mr430304ejb.145.1701863310872;
        Wed, 06 Dec 2023 03:48:30 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.22])
        by smtp.gmail.com with ESMTPSA id fx20-20020a170906b75400b00a1d38589c67sm1370637ejb.98.2023.12.06.03.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 03:48:30 -0800 (PST)
Message-ID: <89b68781-b552-499d-a8f2-df4dccbb02e0@tuxon.dev>
Date:   Wed, 6 Dec 2023 13:48:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] arm64: dts: renesas: rzg3s-smarc-som: Enable
 Ethernet interfaces
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
 <20231120070024.4079344-14-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXs9tKo9W31f5OybNR51a_i99Lyx=wHe0GLrADN_8KZTg@mail.gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdXs9tKo9W31f5OybNR51a_i99Lyx=wHe0GLrADN_8KZTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Geert,

On 06.12.2023 13:22, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> Thanks for your patch!
> 
> On Mon, Nov 20, 2023 at 8:03 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> RZ/G3S Smarc Module has Ethernet PHYs (KSZ9131) connected to each Ethernet
>> IP. For this add proper DT bindings to enable the Ethernet communication
>> though these PHYs.
>>
>> The interface b/w PHYs and MACs is RGMII. The skew settings were set to
>> zero as based on phy-mode (rgmii-id) the KSZ9131 driver enables internal
>> DLL which adds 2ns delay b/w clocks (TX/RX) and data signals.
> 
> So shouldn't you just use phy-mode "rgmii" instead?

I chose it like this for simpler configuration of the skew settings. The
PHY supports fixed 2ns delays which is enough for RGMII. And this is
configured based on phy-mode="rgmii-id". As this delay depends also on
soldering length I consider it better this way.

The other variant would have been using phy-mode="rgmii" + skew settings.

Also, same phy-mode is used by rzg2ul-smarc-som.dtsi which is using the
same PHY.

>> Different pin settings were applied to TXC, TX_CTL compared with the rest
>> of the RGMII pins to comply with requirements for these pins imposed by
>> HW manual of RZ/G3S (see chapters "Ether Ch0 Voltage Mode Control
>> Register (ETH0_POC)", "Ether Ch1 Voltage Mode Control Register (ETH1_POC)",
>> for power source selection, "Ether MII/RGMII Mode Control Register
>> (ETH_MODE)" for output-enable and "Input Enable Control Register (IEN_m)"
>> for input-enable configurations).
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
>> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
>> @@ -25,7 +25,10 @@ / {
>>
>>         aliases {
>>                 mmc0 = &sdhi0;
>> -#if !SW_SD2_EN
>> +#if SW_SD2_EN
> 
> Cfr. my comment on [PATCH 11/14], this looks odd...
> 
>> +               eth0 = &eth0;
>> +               eth1 = &eth1;
>> +#else
>>                 mmc2 = &sdhi2;
>>  #endif
>>         };
>> @@ -81,6 +84,64 @@ vcc_sdhi2: regulator2 {
>>         };
>>  };
>>
>> +#if SW_SD2_EN
> 
> Likewise.
> 
>> +&eth0 {
>> +       pinctrl-0 = <&eth0_pins>;
>> +       pinctrl-names = "default";
>> +       phy-handle = <&phy0>;
>> +       phy-mode = "rgmii-id";
>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
> 
> #{address,size}-cells should be in the SoC-specific .dtsi.
> Same for eth1.
> 
>> +       status = "okay";
> 
> The rest LGTM.
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
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
