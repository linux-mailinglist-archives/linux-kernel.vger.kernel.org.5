Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A087750FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjGLRt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjGLRt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:49:56 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C455B19BA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:49:54 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7FB753F722
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689184193;
        bh=lJHKooZsiD+SMQIcQZfdysILSiGmx9U3IirX3kWX3PY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=mqgPwiceQuOi6c90xJh2lXXsCwoukixa6cPbmBhlLRRexguMN88tnrGSSxxCBVTPf
         RVN+clDAftml4uM06S5BBiKxhjCXH57rUYl9ClXYACkbxnvBpICMzcRe5DNPqnqQCl
         8kw4Ik2Pq7Rd2cHtDnM/RMpTw7AwyLy6bw+IH+o4nbAMvJR+0VPl0XXwgo8H9SriXr
         X/Lg4hqB0PxXd/gEqP0CGHcG7opltjA76Iw+qmU9ckUsvfYy9MRGc87Crp8yudK/Nz
         y4AxSwf3QFa/cPZB4WKiR9/URUWoJxe4INVdnukpCm+02jYwJKozbMJgpNDjYfgJsK
         BD+s6PTHUrt2w==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-403be92a8eeso22378021cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689184192; x=1691776192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJHKooZsiD+SMQIcQZfdysILSiGmx9U3IirX3kWX3PY=;
        b=K85poHBzJjjPRvMqi5lEG4PxjKWHIsTQE295kFcuBM2wC4HQmHuXjdjKdiDLRsi7g3
         n+5XAuY7G2mQxnMbffF/qDVpr0mZUEWBzXIvZF+uPcMmmNUd4KoexeTIC/XuJwVoDEyi
         Dwz43HyhmUpys5EZ7KTU/K8NdWgD23SNpAaPprWZPff/x9NI9bubvC6CPVez2bFaZhMH
         mDLSt3AVJ6E8HnVxzEt4TJ3RKyZz1Er4nVUd0XZ1m9H0DHYVFTgWbym2JOeMScNU12as
         tsnmKgv76t3Gbp1CxHl0RGsb+9pR1WWLUcZk+sGhlN6yg3IP+R/pL+xGCEMkGoyM9vv9
         hTAw==
X-Gm-Message-State: ABy/qLZG1oOzcvctN51ZaOlasq/ENWBxFBugcWyFr1uPKlQsjGexF/dN
        Ywfb6ldckjy3vi3Ve5KBLF8pdt2r1JcJT+molGJOEH8+dKh6jiKDplbWsFjfkBUiW1fcmj9fF3I
        K32SAOePwL3ApVinkvM7tQmwYLAsbJHv/vZvmFgpbr1xOLCaGjHnF2wTFnw==
X-Received: by 2002:ac8:7f94:0:b0:3f6:b7a3:8450 with SMTP id z20-20020ac87f94000000b003f6b7a38450mr24352600qtj.64.1689184192575;
        Wed, 12 Jul 2023 10:49:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFAVCNYn5fqzJf9r5xxZE6bfMm8mE7TPex0S4/HDEov/pqP3bmVNdXmJY0vjJGRnJoVt7f1kM3NlU3hxBHvEzU=
X-Received: by 2002:ac8:7f94:0:b0:3f6:b7a3:8450 with SMTP id
 z20-20020ac87f94000000b003f6b7a38450mr24352582qtj.64.1689184192327; Wed, 12
 Jul 2023 10:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230712092007.31013-1-xingyu.wu@starfivetech.com> <20230712092007.31013-2-xingyu.wu@starfivetech.com>
In-Reply-To: <20230712092007.31013-2-xingyu.wu@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 12 Jul 2023 19:49:36 +0200
Message-ID: <CAJM55Z9LF8wzvVR71giLYwDqgbQfJzytmifyFo50GcQ8Gt3DNg@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] dt-bindings: clock: Add StarFive JH7110
 System-Top-Group clock and reset generator
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
> Add bindings for the System-Top-Group clock and reset generator (STGCRG)
> on the JH7110 RISC-V SoC by StarFive Ltd.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  .../clock/starfive,jh7110-stgcrg.yaml         | 82 +++++++++++++++++++
>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 34 ++++++++
>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 28 +++++++
>  3 files changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml
>
> diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml
> new file mode 100644
> index 000000000000..b64ccd84200a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/starfive,jh7110-stgcrg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 System-Top-Group Clock and Reset Generator
> +
> +maintainers:
> +  - Xingyu Wu <xingyu.wu@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-stgcrg
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Main Oscillator (24 MHz)
> +      - description: HIFI4 core
> +      - description: STG AXI/AHB
> +      - description: USB (125 MHz)
> +      - description: CPU Bus
> +      - description: HIFI4 Axi
> +      - description: NOC STG Bus
> +      - description: APB Bus
> +
> +  clock-names:
> +    items:
> +      - const: osc
> +      - const: hifi4_core
> +      - const: stg_axiahb
> +      - const: usb_125m
> +      - const: cpu_bus
> +      - const: hifi4_axi
> +      - const: nocstg_bus
> +      - const: apb_bus
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
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +  - '#reset-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/starfive,jh7110-crg.h>
> +
> +    stgcrg: clock-controller@10230000 {
> +        compatible = "starfive,jh7110-stgcrg";
> +        reg = <0x10230000 0x10000>;
> +        clocks = <&osc>,
> +                 <&syscrg JH7110_SYSCLK_HIFI4_CORE>,
> +                 <&syscrg JH7110_SYSCLK_STG_AXIAHB>,
> +                 <&syscrg JH7110_SYSCLK_USB_125M>,
> +                 <&syscrg JH7110_SYSCLK_CPU_BUS>,
> +                 <&syscrg JH7110_SYSCLK_HIFI4_AXI>,
> +                 <&syscrg JH7110_SYSCLK_NOCSTG_BUS>,
> +                 <&syscrg JH7110_SYSCLK_APB_BUS>;
> +        clock-names = "osc", "hifi4_core",
> +                      "stg_axiahb", "usb_125m",
> +                      "cpu_bus", "hifi4_axi",
> +                      "nocstg_bus", "apb_bus";
> +        #clock-cells = <1>;
> +        #reset-cells = <1>;
> +    };
> diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt-bindings/clock/starfive,jh7110-crg.h
> index 06257bfd9ac1..6c8e8b4cf1f6 100644
> --- a/include/dt-bindings/clock/starfive,jh7110-crg.h
> +++ b/include/dt-bindings/clock/starfive,jh7110-crg.h
> @@ -1,6 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 OR MIT */
>  /*
>   * Copyright 2022 Emil Renner Berthing <kernel@esmil.dk>
> + * Copyright 2022 StarFive Technology Co., Ltd.
>   */
>
>  #ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
> @@ -218,4 +219,37 @@
>
>  #define JH7110_AONCLK_END                      14
>
> +/* STGCRG clocks */
> +#define JH7110_STGCLK_HIFI4_CLK_CORE           0
> +#define JH7110_STGCLK_USB0_APB                 1
> +#define JH7110_STGCLK_USB0_UTMI_APB            2
> +#define JH7110_STGCLK_USB0_AXI                 3
> +#define JH7110_STGCLK_USB0_LPM                 4
> +#define JH7110_STGCLK_USB0_STB                 5
> +#define JH7110_STGCLK_USB0_APP_125             6
> +#define JH7110_STGCLK_USB0_REFCLK              7
> +#define JH7110_STGCLK_PCIE0_AXI_MST0           8
> +#define JH7110_STGCLK_PCIE0_APB                        9
> +#define JH7110_STGCLK_PCIE0_TL                 10
> +#define JH7110_STGCLK_PCIE1_AXI_MST0           11
> +#define JH7110_STGCLK_PCIE1_APB                        12
> +#define JH7110_STGCLK_PCIE1_TL                 13
> +#define JH7110_STGCLK_PCIE_SLV_MAIN            14
> +#define JH7110_STGCLK_SEC_AHB                  15
> +#define JH7110_STGCLK_SEC_MISC_AHB             16
> +#define JH7110_STGCLK_GRP0_MAIN                        17
> +#define JH7110_STGCLK_GRP0_BUS                 18
> +#define JH7110_STGCLK_GRP0_STG                 19
> +#define JH7110_STGCLK_GRP1_MAIN                        20
> +#define JH7110_STGCLK_GRP1_BUS                 21
> +#define JH7110_STGCLK_GRP1_STG                 22
> +#define JH7110_STGCLK_GRP1_HIFI                        23
> +#define JH7110_STGCLK_E2_RTC                   24
> +#define JH7110_STGCLK_E2_CORE                  25
> +#define JH7110_STGCLK_E2_DBG                   26
> +#define JH7110_STGCLK_DMA1P_AXI                        27
> +#define JH7110_STGCLK_DMA1P_AHB                        28
> +
> +#define JH7110_STGCLK_END                      29
> +
>  #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__ */
> diff --git a/include/dt-bindings/reset/starfive,jh7110-crg.h b/include/dt-bindings/reset/starfive,jh7110-crg.h
> index d78e38690ceb..4e96ab81dd8e 100644
> --- a/include/dt-bindings/reset/starfive,jh7110-crg.h
> +++ b/include/dt-bindings/reset/starfive,jh7110-crg.h
> @@ -1,6 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 OR MIT */
>  /*
>   * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>   */
>
>  #ifndef __DT_BINDINGS_RESET_STARFIVE_JH7110_CRG_H__
> @@ -151,4 +152,31 @@
>
>  #define JH7110_AONRST_END                      8
>
> +/* STGCRG resets */
> +#define JH7110_STGRST_SYSCON                   0
> +#define JH7110_STGRST_HIFI4_CORE               1
> +#define JH7110_STGRST_HIFI4_AXI                        2
> +#define JH7110_STGRST_SEC_AHB                  3
> +#define JH7110_STGRST_E24_CORE                 4
> +#define JH7110_STGRST_DMA1P_AXI                        5
> +#define JH7110_STGRST_DMA1P_AHB                        6
> +#define JH7110_STGRST_USB0_AXI                 7
> +#define JH7110_STGRST_USB0_APB                 8
> +#define JH7110_STGRST_USB0_UTMI_APB            9
> +#define JH7110_STGRST_USB0_PWRUP               10
> +#define JH7110_STGRST_PCIE0_AXI_MST0           11
> +#define JH7110_STGRST_PCIE0_AXI_SLV0           12
> +#define JH7110_STGRST_PCIE0_AXI_SLV            13
> +#define JH7110_STGRST_PCIE0_BRG                        14
> +#define JH7110_STGRST_PCIE0_CORE               15
> +#define JH7110_STGRST_PCIE0_APB                        16
> +#define JH7110_STGRST_PCIE1_AXI_MST0           17
> +#define JH7110_STGRST_PCIE1_AXI_SLV0           18
> +#define JH7110_STGRST_PCIE1_AXI_SLV            19
> +#define JH7110_STGRST_PCIE1_BRG                        20
> +#define JH7110_STGRST_PCIE1_CORE               21
> +#define JH7110_STGRST_PCIE1_APB                        22
> +
> +#define JH7110_STGRST_END                      23
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
