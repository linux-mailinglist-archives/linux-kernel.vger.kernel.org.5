Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8471F7523B0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbjGMN0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjGMN0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:26:21 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2E83586
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:25:50 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B530E3F18D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689254703;
        bh=njPCzRp+gLgGXnuaFscEFk6TNloreb9Z1F7nmpn2GCo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=QaB1EROEy6wQE8NcVM2RvfUwMiEaSZZsrMErmuGoOm284DQwWRxrg7mFRb2Ygiape
         1G/jD79RdGT0bDPh0gteZxHCdfA/UUG6Kefi+sgnZ23RsSb8aClI1GORH4edNSFXGi
         HyA47bLTO3ilw7RR0lcY4nAfjGbf3cWE/QEMOWa1IfHrzDZmpmr4s//cvC8KtSzwvW
         SNdYrlmwlE9BevyzqUjMDchoJJT5Ui4J6oZ+NXVYvFjsxUvY2tdvanhMPJ+9B/a0r+
         7hpcf8lLh2PVvi+gs2Jw9L0okfyoyoekpnnRQhm2LQsf1tca4/8EsP41jnCf7WpviE
         f18JhwCpgSHCg==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-40327302341so6682641cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689254702; x=1691846702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njPCzRp+gLgGXnuaFscEFk6TNloreb9Z1F7nmpn2GCo=;
        b=Szg/QqJp6UHXiCfQmakIh7xU4mO7lES9uRbbg+l6/oJlnc3rVtH/3KUqgujk80CtF0
         WzivQ6QzUzdil5cqlahATs6+H+xQ3NPi1zGd5XwLOwffvwXL+1CdR3Nz6Bh9fZyRdJAn
         2j16Rstvx9Wx8KFJywzoA1fJYUNalgMR5r3B9asIIcrvmKkKtLg3TuibDeZWju1FweBq
         LoAevSV4pQodiEsQamRdp9akUG+S6fVku/QUx5G9K0wDbQGjCxcqRMPzaFa6qeA2uxrb
         vND9k3REcahkaiGkMLYwF56AR7uyYgvRLpwo9aonc0yZ1w6SrmnpN7p++ZIp5gI/rhM9
         MCBQ==
X-Gm-Message-State: ABy/qLa1o+y7jTCS4fgAYIJdXSp6hRQrd+OGH1TDSQiU19hWEtjisSBT
        jRaIY7XkkYPKDEFxlQjlv7Bzc6Axt/NdZOEU3rTst2v4rhW0FI4MnwwX2Q54Ei5wRACzcaXOTYy
        gzQT5tsr75/0r/FFZYj/g/ih9ZTzEtkGgl/ROimWWyxZwYOyFnwUWlfNOwg==
X-Received: by 2002:a05:622a:14d4:b0:3f6:aff0:6dec with SMTP id u20-20020a05622a14d400b003f6aff06decmr1750871qtx.32.1689254702767;
        Thu, 13 Jul 2023 06:25:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEWYwWyI37hBY/T3E7FV4GEsBkoCOExBvaA0XLzyYLy56YtYThzvj/ApC8dphahHLu8bbys9suJD14jU2FGI2M=
X-Received: by 2002:a05:622a:14d4:b0:3f6:aff0:6dec with SMTP id
 u20-20020a05622a14d400b003f6aff06decmr1750857qtx.32.1689254702551; Thu, 13
 Jul 2023 06:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230704064610.292603-1-xingyu.wu@starfivetech.com> <20230704064610.292603-8-xingyu.wu@starfivetech.com>
In-Reply-To: <20230704064610.292603-8-xingyu.wu@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Thu, 13 Jul 2023 15:24:46 +0200
Message-ID: <CAJM55Z989XRDuzff14pFa+AFnL6xBsswONFfdFxKbwGy55TwoA@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 7/7] riscv: dts: starfive: jh7110: Add PLL
 clocks source in SYSCRG node
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 at 08:49, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>
> Add PLL clocks input from PLL clocks driver in SYSCRG node.
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 11dd4c9d64b0..cdfd036a0e6c 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -452,12 +452,16 @@ syscrg: clock-controller@13020000 {
>                                  <&gmac1_rgmii_rxin>,
>                                  <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
>                                  <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
> -                                <&tdm_ext>, <&mclk_ext>;
> +                                <&tdm_ext>, <&mclk_ext>,
> +                                <&pllclk JH7110_CLK_PLL0_OUT>,
> +                                <&pllclk JH7110_CLK_PLL1_OUT>,
> +                                <&pllclk JH7110_CLK_PLL2_OUT>;

Once these are updated to <&pll ?> or <&pllclk JH7110_PLLCLK_PLL?_OUT>
if you still want to keep the defines:
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

>                         clock-names = "osc", "gmac1_rmii_refin",
>                                       "gmac1_rgmii_rxin",
>                                       "i2stx_bclk_ext", "i2stx_lrck_ext",
>                                       "i2srx_bclk_ext", "i2srx_lrck_ext",
> -                                     "tdm_ext", "mclk_ext";
> +                                     "tdm_ext", "mclk_ext",
> +                                     "pll0_out", "pll1_out", "pll2_out";
>                         #clock-cells = <1>;
>                         #reset-cells = <1>;
>                 };
> --
> 2.25.1
>
