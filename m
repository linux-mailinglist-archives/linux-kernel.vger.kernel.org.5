Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2406E751001
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGLRwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjGLRwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:52:19 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEB7199E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:52:17 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F11023F18D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689184336;
        bh=l5M3IqZkSZTNpK4Rgfb/490i8YL19SZAjTybhYdRe5U=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=aVYAbYEuV2irmhFAeWeYjMUqUbKudG2X+uLWMGUSYXIAyBpQbEixscRVY4bmLWqeX
         Vqwr6MMwRjhqtehikBe9qH7BEag578gVDIVCqOt95MRwl5Ceb2UJUabm9Bv6+NI5Jp
         YyaGyWXcOFXjUM8489sTiio3T568j41TLLWB9SNXVb697Lj4OG6lr68xM9kEgEFNls
         UcKqaLwgr8YtVfWo+ORw7P1Fr4j7VAK3Ci6fTXDVtNHF0v+1I5BZoarWmsVfWIwIUi
         cOCRuEPTQnJyDSfcMUBdIsa7//h4pH/RaLyR10aLlLkRsunF3YlurjQJ1ZG92vPrT6
         3+MalCvRRFXGA==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-403ad49c647so39865081cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689184335; x=1691776335;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l5M3IqZkSZTNpK4Rgfb/490i8YL19SZAjTybhYdRe5U=;
        b=PoSPS8WBQAGsQTffglTWVD7XuTiC4LM2d1Dox38OLs72VJNq/9M8iOLUlH7+ODSr6k
         XnA92OpGPzwRTbwTmxY0RCZjT31te7lrt6fSTs7gUUJLVerckUx7uB4k2I7njmqoSrZy
         KTvQ4cK2ySMLOjxf9YA4NxUbBGZJGhvN8GGD8c12WJBef8SzcEmA7Fx60fbsILPGpBqA
         1ywN1HmY6z1TfeKrPwry2KeORnskvy8q1wOg7PBrO7AgIwk7zKu0LK110hAhMY1OWf3l
         tHwVHRfu0bDfj2eBgm+8QWB3PpHDvyBN3mujx5LkK1GBlruy1LcmbtgXzQAIP7KWKwbL
         WCzQ==
X-Gm-Message-State: ABy/qLbf2SX5JZ6+5BHOcm9vnmToYwQgapebUNsTwL+Hk4hrDM9nEYd1
        0yYHB4/9S0wc573Wj7BVvpf6PWl8aYxbUqgRT0w6zZxgi3BKedjzcLYKA16+WB2UT6I2vjtfC1Q
        e0TKDixHaVNz6grMOB7MltywHHcPL0yxqi9PpsHISSS5XzMfhhIFS+nYJYA==
X-Received: by 2002:a05:622a:54e:b0:402:d15e:2982 with SMTP id m14-20020a05622a054e00b00402d15e2982mr23069244qtx.25.1689184335028;
        Wed, 12 Jul 2023 10:52:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG3uMj4FGxQKvZ4HRowGrH0Fv5CI+N5D+ut6hhpgRCwd5Z3AsHez8thKYRxHUQtDfruIfQQPmR8RGBKrnRhhxg=
X-Received: by 2002:a05:622a:54e:b0:402:d15e:2982 with SMTP id
 m14-20020a05622a054e00b00402d15e2982mr23069219qtx.25.1689184334781; Wed, 12
 Jul 2023 10:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230712092007.31013-1-xingyu.wu@starfivetech.com> <20230712092007.31013-4-xingyu.wu@starfivetech.com>
In-Reply-To: <20230712092007.31013-4-xingyu.wu@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 12 Jul 2023 19:51:58 +0200
Message-ID: <CAJM55Z8TwKUzPjg4LdjrgV98D_oLr3ZBervOKwXHx+K9-Ddjew@mail.gmail.com>
Subject: Re: [PATCH v7 3/9] dt-bindings: clock: Add StarFive JH7110
 Image-Signal-Process clock and reset generator
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
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 at 11:22, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>
> Add bindings for the Image-Signal-Process clock and reset
> generator (ISPCRG) on the JH7110 RISC-V SoC by StarFive Ltd.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  .../clock/starfive,jh7110-ispcrg.yaml         | 87 +++++++++++++++++++
>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 18 ++++
>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 16 ++++
>  3 files changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-ispcrg.yaml
>
> diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-ispcrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-ispcrg.yaml
> new file mode 100644
> index 000000000000..3b8b85be5cd0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-ispcrg.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/starfive,jh7110-ispcrg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 Image-Signal-Process Clock and Reset Generator
> +
> +maintainers:
> +  - Xingyu Wu <xingyu.wu@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-ispcrg
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: ISP Top core
> +      - description: ISP Top Axi
> +      - description: NOC ISP Bus
> +      - description: external DVP
> +
> +  clock-names:
> +    items:
> +      - const: isp_top_core
> +      - const: isp_top_axi
> +      - const: noc_bus_isp_axi
> +      - const: dvp_clk
> +
> +  resets:
> +    items:
> +      - description: ISP Top core
> +      - description: ISP Top Axi
> +      - description: NOC ISP Bus
> +
> +  '#clock-cells':
> +    const: 1
> +    description:
> +      See <dt-bindings/clock/starfive,jh7110-crg.h> for valid indices.
> +
> +  '#reset-cells':
> +    const: 1
> +    description:
> +      See <dt-bindings/reset/starfive,jh7110-crg.h> for valid indices.
> +
> +  power-domains:
> +    maxItems: 1
> +    description:
> +      ISP domain power
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - '#clock-cells'
> +  - '#reset-cells'
> +  - power-domains
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/starfive,jh7110-crg.h>
> +    #include <dt-bindings/power/starfive,jh7110-pmu.h>
> +    #include <dt-bindings/reset/starfive,jh7110-crg.h>
> +
> +    ispcrg: clock-controller@19810000 {
> +        compatible = "starfive,jh7110-ispcrg";
> +        reg = <0x19810000 0x10000>;
> +        clocks = <&syscrg JH7110_SYSCLK_ISP_TOP_CORE>,
> +                 <&syscrg JH7110_SYSCLK_ISP_TOP_AXI>,
> +                 <&syscrg JH7110_SYSCLK_NOC_BUS_ISP_AXI>,
> +                 <&dvp_clk>;
> +        clock-names = "isp_top_core", "isp_top_axi",
> +                      "noc_bus_isp_axi", "dvp_clk";
> +        resets = <&syscrg JH7110_SYSRST_ISP_TOP>,
> +                 <&syscrg JH7110_SYSRST_ISP_TOP_AXI>,
> +                 <&syscrg JH7110_SYSRST_NOC_BUS_ISP_AXI>;
> +        #clock-cells = <1>;
> +        #reset-cells = <1>;
> +        power-domains = <&pwrc JH7110_PD_ISP>;
> +    };
> diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt-bindings/clock/starfive,jh7110-crg.h
> index 6c8e8b4cf1f6..39acf30db491 100644
> --- a/include/dt-bindings/clock/starfive,jh7110-crg.h
> +++ b/include/dt-bindings/clock/starfive,jh7110-crg.h
> @@ -252,4 +252,22 @@
>
>  #define JH7110_STGCLK_END                      29
>
> +/* ISPCRG clocks */
> +#define JH7110_ISPCLK_DOM4_APB_FUNC            0
> +#define JH7110_ISPCLK_MIPI_RX0_PXL             1
> +#define JH7110_ISPCLK_DVP_INV                  2
> +#define JH7110_ISPCLK_M31DPHY_CFG_IN           3
> +#define JH7110_ISPCLK_M31DPHY_REF_IN           4
> +#define JH7110_ISPCLK_M31DPHY_TX_ESC_LAN0      5
> +#define JH7110_ISPCLK_VIN_APB                  6
> +#define JH7110_ISPCLK_VIN_SYS                  7
> +#define JH7110_ISPCLK_VIN_PIXEL_IF0            8
> +#define JH7110_ISPCLK_VIN_PIXEL_IF1            9
> +#define JH7110_ISPCLK_VIN_PIXEL_IF2            10
> +#define JH7110_ISPCLK_VIN_PIXEL_IF3            11
> +#define JH7110_ISPCLK_VIN_P_AXI_WR             12
> +#define JH7110_ISPCLK_ISPV2_TOP_WRAPPER_C      13
> +
> +#define JH7110_ISPCLK_END                      14
> +
>  #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__ */
> diff --git a/include/dt-bindings/reset/starfive,jh7110-crg.h b/include/dt-bindings/reset/starfive,jh7110-crg.h
> index 4e96ab81dd8e..2c5d9dcefffa 100644
> --- a/include/dt-bindings/reset/starfive,jh7110-crg.h
> +++ b/include/dt-bindings/reset/starfive,jh7110-crg.h
> @@ -179,4 +179,20 @@
>
>  #define JH7110_STGRST_END                      23
>
> +/* ISPCRG resets */
> +#define JH7110_ISPRST_ISPV2_TOP_WRAPPER_P      0
> +#define JH7110_ISPRST_ISPV2_TOP_WRAPPER_C      1
> +#define JH7110_ISPRST_M31DPHY_HW               2
> +#define JH7110_ISPRST_M31DPHY_B09_AON          3
> +#define JH7110_ISPRST_VIN_APB                  4
> +#define JH7110_ISPRST_VIN_PIXEL_IF0            5
> +#define JH7110_ISPRST_VIN_PIXEL_IF1            6
> +#define JH7110_ISPRST_VIN_PIXEL_IF2            7
> +#define JH7110_ISPRST_VIN_PIXEL_IF3            8
> +#define JH7110_ISPRST_VIN_SYS                  9
> +#define JH7110_ISPRST_VIN_P_AXI_RD             10
> +#define JH7110_ISPRST_VIN_P_AXI_WR             11
> +
> +#define JH7110_ISPRST_END                      12
> +
>  #endif /* __DT_BINDINGS_RESET_STARFIVE_JH7110_CRG_H__ */
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
