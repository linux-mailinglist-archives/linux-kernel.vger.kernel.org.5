Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB5A78A069
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 19:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjH0REz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 13:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjH0RE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 13:04:27 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0590712D;
        Sun, 27 Aug 2023 10:04:25 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so37282541fa.3;
        Sun, 27 Aug 2023 10:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693155863; x=1693760663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ERbGcMk6gfakm9DN1/j10oG7dRsa1/HJVwOkOQiUYg=;
        b=QB82P1/Zoei8Wskv8ZM5fkHfMCha7VG0U/0BQuxdE2f4ZU2B9iX5BaWjqV2hRhjaM1
         VclHZdpG/2ZEkFaM2dgBudZ0Q+U82Aw6FOzq5HJnOxQXtukJ/gxGiGUzAcDX6ip40XrQ
         XckT14k0RWChipnAa0JW55RHk50fzqco30TuRFsN8+FEazdk/0kN/qDcBHnUMl3O+ke8
         GVIYwwWSmeaefQRYixLYsd4hzTY4BV6OACA3xwRyJJPTdsAktiJYnDWMOiWCq798WXG2
         RJ33CKslbhnggSYVNsYXxsj3BpaCtmZRyNcXfddXeiVAHJXQ7NPJgRW7BxHOa7+YgvKz
         Xu6Q==
X-Gm-Message-State: AOJu0Yy5bPw5dm2YIHq5P44geJtehAkLAX5c9lBm3O/vKyfD20hoaaQw
        Vq69AP/F35DC7D6Qt/9s56N6wMENeV5TlRfu
X-Google-Smtp-Source: AGHT+IEF7d/5kTVF5MtR4cRbcAp149+5664NC2TYLcGNDPGf3jUEZ1dBbrgI5e/SqbeFgnAyHK3sug==
X-Received: by 2002:a2e:9bd8:0:b0:2b1:c1ae:73e3 with SMTP id w24-20020a2e9bd8000000b002b1c1ae73e3mr17253046ljj.15.1693155862987;
        Sun, 27 Aug 2023 10:04:22 -0700 (PDT)
Received: from [192.168.86.246] (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id a1-20020a17090640c100b0099bcf9c2ec6sm3589439ejk.75.2023.08.27.10.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 10:04:22 -0700 (PDT)
Message-ID: <70b3ba82-0920-4613-9480-919a3df6833c@linux.com>
Date:   Sun, 27 Aug 2023 18:04:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 0/4] Add S4 SoC PLLs and Peripheral clock
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com, qi.duan@amlogic.com
References: <20230822082750.27633-1-yu.tu@amlogic.com>
Content-Language: en-US
From:   Lucas Tanure <tanure@linux.com>
In-Reply-To: <20230822082750.27633-1-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-2023 09:27, Yu Tu wrote:
> 1. Add S4 SoC PLLs and Peripheral clock controller dt-bindings.
> 2. Add PLLs and Peripheral clock controller driver for S4 SOC.
> 
> 
> Yu Tu (4):
>    dt-bindings: clock: document Amlogic S4 SoC PLL clock controller
>    dt-bindings: clock: document Amlogic S4 SoC peripherals clock
>      controller
>    clk: meson: S4: add support for Amlogic S4 SoC PLL clock driver
>    clk: meson: S4: add support for Amlogic S4 SoC peripheral clock
>      controller
> 
> V9 -> V10:
> 1. Change the relevant S4 CLK patch based on Neil's recently modified
> patch.
> 2. Change patch 0003/0004 clocks comment, format and clock flags suggested
> by Jerome.
> 
> V8 -> V9: Add patch 0001/0002 dt-bindings tag. Suggested by Krzysztof.
> V7 -> V8:
> 1. Change patch 0001/0002 dt-bindings title description, remove "meson".
> Suggested by Dmitry, Neil.
> 2. Change patch 0003/0004 clocks comment, format and clock flags suggested by
> Dmitry, Neil, Jerome.
> 
> V6 -> V7: Change send patch series as well change format and clock flags
> suggested by Jerome. Change dt-bindings suggested by Krzysztof.
> V5 -> V6: Change send patch series, as well change format and clock flags.
> V4 -> V5: change format and clock flags and adjust the patch series
> as suggested by Jerome.
> V3 -> V4: change format and clock flags.
> V2 -> V3: Use two clock controller.
> V1 -> V2: Change format as discussed in the email.
> 
> Link:https://lore.kernel.org/linux-amlogic/20230517070215.28463-1-yu.tu@amlogic.com/
> 
>   .../clock/amlogic,s4-peripherals-clkc.yaml    |   96 +
>   .../bindings/clock/amlogic,s4-pll-clkc.yaml   |   49 +
>   drivers/clk/meson/Kconfig                     |   23 +
>   drivers/clk/meson/Makefile                    |    2 +
>   drivers/clk/meson/s4-peripherals.c            | 3787 +++++++++++++++++
>   drivers/clk/meson/s4-peripherals.h            |   57 +
>   drivers/clk/meson/s4-pll.c                    |  867 ++++
>   drivers/clk/meson/s4-pll.h                    |   38 +
>   .../clock/amlogic,s4-peripherals-clkc.h       |  236 +
>   .../dt-bindings/clock/amlogic,s4-pll-clkc.h   |   43 +
>   10 files changed, 5198 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
>   create mode 100644 drivers/clk/meson/s4-peripherals.c
>   create mode 100644 drivers/clk/meson/s4-peripherals.h
>   create mode 100644 drivers/clk/meson/s4-pll.c
>   create mode 100644 drivers/clk/meson/s4-pll.h
>   create mode 100644 include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>   create mode 100644 include/dt-bindings/clock/amlogic,s4-pll-clkc.h
> 
> 
> base-commit: bd0f6c57c2b324b6f92ccfe13a8005ff829287b8
How similar is T7 and S4 regarding the clocks?
Can S4 clock driver be used by T7 without modifications?

Thanks
Lucas
