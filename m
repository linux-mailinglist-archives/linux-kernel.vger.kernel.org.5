Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0627A0597
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbjINNaA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 09:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjINN36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:29:58 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7001FD8;
        Thu, 14 Sep 2023 06:29:54 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5925e580f12so11411447b3.3;
        Thu, 14 Sep 2023 06:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694698193; x=1695302993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMgnSEID+xkECrUs/n98woQl+ojuPd0/IiG5nfXIn2c=;
        b=XzOelWPkiVoyl5RggkTcRd3uA415Z162tBB3CDrInXacj6nPzpABWMzAnB4PpROIua
         nR2OvbrozuiwByoF79OQHRDCan6qXryQHUomw5kleQQzv29QBpZtP3sYxbss6G4i3LxE
         97Xg53EqVldYoAxzJM//+QVFXFWZevXujZSnY9zxdP3K/1DfM/4A9plmlOmrCB0+GBm3
         XA5jHgzZxV0WAX1y8GFy/NYTrvbiYOfLTy50/dM7PZ31+aHSyVJvDMF/gkRAk9DKGQX9
         6qxmEiymL97L0V71FfS1AZwdmxa+3sYzzO1KCXZXT4U4ChqHnnShTZnSMbjZMvIGn/Dp
         +OWg==
X-Gm-Message-State: AOJu0YxRn2nJ1IhFRaj4ClhPlBwSXh4h7ibZXqSkuyZMCKL2ThaE198N
        QZMCbJOix1H0a/ZZQ7wH85OUT6gcwbaAjw==
X-Google-Smtp-Source: AGHT+IEqkaYIojyrujrVO1BiGM9aV1qiSgkX3ciD/0/s2n379RnWi+PZW1+3eZyfAzTGGaaNUj5fuw==
X-Received: by 2002:a81:7287:0:b0:59b:8da4:dc1 with SMTP id n129-20020a817287000000b0059b8da40dc1mr5820380ywc.38.1694698193125;
        Thu, 14 Sep 2023 06:29:53 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id h125-20020a816c83000000b00582fae92aa7sm318186ywc.93.2023.09.14.06.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 06:29:52 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59bd2e19c95so11653557b3.0;
        Thu, 14 Sep 2023 06:29:52 -0700 (PDT)
X-Received: by 2002:a0d:fe43:0:b0:589:c065:b419 with SMTP id
 o64-20020a0dfe43000000b00589c065b419mr5624958ywf.34.1694698192345; Thu, 14
 Sep 2023 06:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-15-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-15-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 15:29:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWRxaBsPAn0OR15WFua_5HZVPTmWabFnnex5gDLKjE9Cw@mail.gmail.com>
Message-ID: <CAMuHMdWRxaBsPAn0OR15WFua_5HZVPTmWabFnnex5gDLKjE9Cw@mail.gmail.com>
Subject: Re: [PATCH 14/37] clk: renesas: rzg2l: use u32 for flag and mux_flags
To:     Claudiu <claudiu.beznea@tuxon.dev>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Tue, Sep 12, 2023 at 6:52 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> flag and mux_flags are intended to keep bit masks. Use u32 type for it.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/rzg2l-cpg.h
> +++ b/drivers/clk/renesas/rzg2l-cpg.h
> @@ -92,8 +92,8 @@ struct cpg_core_clk {
>         unsigned int conf;
>         const struct clk_div_table *dtable;
>         const char * const *parent_names;
> -       int flag;
> -       int mux_flags;
> +       u32 flag;

"flag" is used for several purposes, which expected different types:
    - clk_init_data.flags is unsigned long,
    - The clk_divider_flags parameter of clk_hw_register_divider_table() is u8,
    - The clk_divider_flags parameter of __clk_hw_register_divider() is u8,
    - The flags parameter of __devm_clk_hw_register_mux() is unsigned long.

> +       u32 mux_flags;

Actually the clk_mux_flags parameter of __devm_clk_hw_register_mux() is u8.

>         int num_parents;
>  };

I guess u32 is fine for all.
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
