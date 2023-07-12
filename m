Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10742751057
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjGLSMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGLSME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:12:04 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4327A121
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:12:03 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5E5BA3F71D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 18:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689185520;
        bh=IiTbBlj0ewF8G4BUt91YuXI1v1SQzafoivmnBlClh7o=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=TYvSAOUO0+9BvIh1z++Yvxwg1/EiJ2/MsySwB82fZTrYsKc+9loodKQEQX9eT06Cf
         lVGPK6a25QBqXO0q8dbd0V1EPgJLotch43koN0d8k8+WAKEmb+YVpHhO5/NAH5Vko7
         l5M/EZKgR+PlbGNAD0eL855iuMSG08FM01/ocRqnFqU0TBz7CtIlo3zZg3LQPGJWY/
         t4l+qVcIRUZz1iuWFV9deqQjqka+j0EL8om0plV74j4a7Lz0q8kEX7vkESV3rM16Ks
         qL+wvr365wwp+IWhuWSZn/EU3s/YHiKUS/rgeWQBsf6uAWG3O3hwy9qyKTrxec6W6F
         XnYEzjUKRU8cg==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-403b84bc821so26916611cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689185519; x=1691777519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IiTbBlj0ewF8G4BUt91YuXI1v1SQzafoivmnBlClh7o=;
        b=LZQueswd4y2YR5iNmqe9ep5z+incw7GowWDVG/Uz2fIrkxcX/A52rBRxC05d5uGexU
         a810DVell9fBifO+8bmlbiFIWOUM1EN3DxGf33I0OIKbVL4t7n2RBp6ASWCUqCl2COeT
         GGVlTHGjAwoXIs8sByeHdjzX6vWZCXdGRKTlQeiyczRPLMZfIRDi/Aa9JH7nRByAiZV8
         iha/3hzZAh4Ag6zOkhENYSTZZpf+c41jsJGLFQ/s//sMvofsd7h7J/MVAlEI5L5lw1VM
         +7ojdw5hnrxKNjapT7k4pNSxEFexmaja+TS7ZOsGmkGJdRHkilT5L76H+ZhnorblG9sK
         fNWA==
X-Gm-Message-State: ABy/qLZqJ48/VotmvQ6hJ6Zi10t3nkf/L1RtRgQ4nmscacKUcpe2k9iS
        8Qjrng1mSa0iEwM9GED6cVyE50yn0UQOuI5At4Yw0r9S+eSuK3f7nUN9x9PrW1zc2h/TNcA11xd
        L/GatE0OnbMpaN28fdsOXX0juTJY/QU7QI4/GsPg5I0CQf5uVU38qQF3y8g==
X-Received: by 2002:a05:622a:607:b0:400:9896:b0fa with SMTP id z7-20020a05622a060700b004009896b0famr23054534qta.64.1689185519442;
        Wed, 12 Jul 2023 11:11:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF+yH6SEzFMjdi9+xn1WCS08DTxJsK51NR6l1TztLgLNuwI2JQDigR3T+OItHZ2i/n2iFxsrYmTXZ+OTvDP/m4=
X-Received: by 2002:a05:622a:607:b0:400:9896:b0fa with SMTP id
 z7-20020a05622a060700b004009896b0famr23054520qta.64.1689185519221; Wed, 12
 Jul 2023 11:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230712092007.31013-1-xingyu.wu@starfivetech.com> <20230712092007.31013-10-xingyu.wu@starfivetech.com>
In-Reply-To: <20230712092007.31013-10-xingyu.wu@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 12 Jul 2023 20:11:42 +0200
Message-ID: <CAJM55Z_1btuZ3ewLTMgxya8bwZ-HZRVRTHEwscmhv6DcAJFKfg@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] riscv: dts: starfive: jh7110: Add
 STGCRG/ISPCRG/VOUTCRG nodes
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 at 11:22, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>
> Add STGCRG/ISPCRG/VOUTCRG new node to support JH7110
> System-Top-Group, Image-Signal-Process and Video-Output
> clock and reset drivers for the JH7110 RISC-V SoC.
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 55 ++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index e9c1e4ad71a2..0005fa163a78 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -6,6 +6,7 @@
>
>  /dts-v1/;
>  #include <dt-bindings/clock/starfive,jh7110-crg.h>
> +#include <dt-bindings/power/starfive,jh7110-pmu.h>
>  #include <dt-bindings/reset/starfive,jh7110-crg.h>
>
>  / {
> @@ -398,6 +399,25 @@ i2c2: i2c@10050000 {
>                         status = "disabled";
>                 };
>
> +               stgcrg: clock-controller@10230000 {
> +                       compatible = "starfive,jh7110-stgcrg";
> +                       reg = <0x0 0x10230000 0x0 0x10000>;
> +                       clocks = <&osc>,
> +                                <&syscrg JH7110_SYSCLK_HIFI4_CORE>,
> +                                <&syscrg JH7110_SYSCLK_STG_AXIAHB>,
> +                                <&syscrg JH7110_SYSCLK_USB_125M>,
> +                                <&syscrg JH7110_SYSCLK_CPU_BUS>,
> +                                <&syscrg JH7110_SYSCLK_HIFI4_AXI>,
> +                                <&syscrg JH7110_SYSCLK_NOCSTG_BUS>,
> +                                <&syscrg JH7110_SYSCLK_APB_BUS>;
> +                       clock-names = "osc", "hifi4_core",
> +                                     "stg_axiahb", "usb_125m",
> +                                     "cpu_bus", "hifi4_axi",
> +                                     "nocstg_bus", "apb_bus";
> +                       #clock-cells = <1>;
> +                       #reset-cells = <1>;
> +               };
> +
>                 uart3: serial@12000000 {
>                         compatible = "snps,dw-apb-uart";
>                         reg = <0x0 0x12000000 0x0 0x10000>;
> @@ -558,5 +578,40 @@ pwrc: power-controller@17030000 {
>                         interrupts = <111>;
>                         #power-domain-cells = <1>;
>                 };
> +
> +               ispcrg: clock-controller@19810000 {
> +                       compatible = "starfive,jh7110-ispcrg";
> +                       reg = <0x0 0x19810000 0x0 0x10000>;
> +                       clocks = <&syscrg JH7110_SYSCLK_ISP_TOP_CORE>,
> +                                <&syscrg JH7110_SYSCLK_ISP_TOP_AXI>,
> +                                <&syscrg JH7110_SYSCLK_NOC_BUS_ISP_AXI>,
> +                                <&dvp_clk>;
> +                       clock-names = "isp_top_core", "isp_top_axi",
> +                                     "noc_bus_isp_axi", "dvp_clk";
> +                       resets = <&syscrg JH7110_SYSRST_ISP_TOP>,
> +                                <&syscrg JH7110_SYSRST_ISP_TOP_AXI>,
> +                                <&syscrg JH7110_SYSRST_NOC_BUS_ISP_AXI>;
> +                       #clock-cells = <1>;
> +                       #reset-cells = <1>;
> +                       power-domains = <&pwrc JH7110_PD_ISP>;
> +               };
> +
> +               voutcrg: clock-controller@295c0000 {
> +                       compatible = "starfive,jh7110-voutcrg";
> +                       reg = <0x0 0x295c0000 0x0 0x10000>;
> +                       clocks = <&syscrg JH7110_SYSCLK_VOUT_SRC>,
> +                                <&syscrg JH7110_SYSCLK_VOUT_TOP_AHB>,
> +                                <&syscrg JH7110_SYSCLK_VOUT_TOP_AXI>,
> +                                <&syscrg JH7110_SYSCLK_VOUT_TOP_HDMITX0_MCLK>,
> +                                <&syscrg JH7110_SYSCLK_I2STX0_BCLK>,
> +                                <&hdmitx0_pixelclk>;
> +                       clock-names = "vout_src", "vout_top_ahb",
> +                                     "vout_top_axi", "vout_top_hdmitx0_mclk",
> +                                     "i2stx0_bclk", "hdmitx0_pixelclk";
> +                       resets = <&syscrg JH7110_SYSRST_VOUT_TOP_SRC>;
> +                       #clock-cells = <1>;
> +                       #reset-cells = <1>;
> +                       power-domains = <&pwrc JH7110_PD_VOUT>;
> +               };
>         };
>  };
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
