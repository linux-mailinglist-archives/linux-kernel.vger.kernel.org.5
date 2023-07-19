Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1103F759A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjGSPps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjGSPpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:45:46 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42888210B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:45:34 -0700 (PDT)
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5CD643F0F8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689781532;
        bh=bJD7aE/rIe6c3FFU/UVaWfG6cXGm2QJmqrPvjRg5gaY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Z2JJId5Ku9Bc5CRpk8AGAjyCA68XgukimWXd8dS9ZLaXui/jn0NBQC+JNIxvmlDqB
         rLa8W6GT+JvG03K/oj1I3DdXUK8ioPIMOY7YUSQbqLnnaTJXLtSAeUhSKWp/UqDVMO
         i+cjHeiwhovbXZ5c6lEapJHUBPriMmsnYRhJhuCWachAsISf3/woYFbCbNdBN0PjKg
         RTTN+YzUDHL9kzVn3fdmivpJY+gaD4myWRkQ4UvXSAWFCYGJFVoIjtkmyjtzQT1mfg
         eJqGY48oza+9exRjmcvjI3KcdbPu4zqikhcZY4u/JNfqRlOXK49mXes6cEnSm9v48N
         spmMpuk1Bzxhg==
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7675fc3333eso80069685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689781531; x=1690386331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJD7aE/rIe6c3FFU/UVaWfG6cXGm2QJmqrPvjRg5gaY=;
        b=Zzwc29+m3QRFz0vX3Q7eZe3owCpsG4u/iBjLDar4hUBEwAsACmy+8SdaGXB0p0m2Nc
         tkElPlnZ4qMGAKpap5eW5gSwYeoV1BiuwtX1tr/7YUzwEgCIBL/yOHeI/A6GULLFTOU7
         tF7Kk72j93eP9LI77hjnW2QoXLlDd/J7swJuP04qYpiv7ximYnv0Ur8jzJTAjgHcOdty
         FXIvD1cbNG8sr9fMhgV1uxB6BdgyMqHZO66gKmr5cY6V9SvTOXyZVnPA0hSoKlvsOrLs
         qX88w5/lhO76O6u7tg7g4atn5HT243jzwqooBwtAVKysm0LOWoJnW8XsCGWbBraPKRgy
         YrLA==
X-Gm-Message-State: ABy/qLbX6EIcXK7u/U7IK7HLc/MGRysS38yDcJdsRO3uXPFDuWHvu/R7
        DAnh7DgwTIkSfOGt6hmaRpyf4DjZy6rQIPOa5TG3OujL9Q5fErznFWJE2+QcetcLwNJib3eaK0h
        p/qxTQATsMHYb14VUs2JLR46/Q7Tc51bT2toBGeL2DNL3FLnOlScgaukRVA==
X-Received: by 2002:a05:620a:4155:b0:766:f972:73e1 with SMTP id k21-20020a05620a415500b00766f97273e1mr2968761qko.26.1689781531337;
        Wed, 19 Jul 2023 08:45:31 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEgOZHqVyytZCi4Dmyj+T4kdUCY46MCEOc5/aq2hMRc989Ipy34EdmzvPv2BTt9oGjxyPIrXj6QLDKGJmpUDGw=
X-Received: by 2002:a05:620a:4155:b0:766:f972:73e1 with SMTP id
 k21-20020a05620a415500b00766f97273e1mr2968746qko.26.1689781531078; Wed, 19
 Jul 2023 08:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230717023040.78860-1-xingyu.wu@starfivetech.com> <20230717023040.78860-2-xingyu.wu@starfivetech.com>
In-Reply-To: <20230717023040.78860-2-xingyu.wu@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 19 Jul 2023 17:45:14 +0200
Message-ID: <CAJM55Z_daAVJim+aS3DsWTv3RoG40p24qh-MZ92NgJHCVKN+3A@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] dt-bindings: clock: Add StarFive JH7110 PLL clock generator
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 at 04:30, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>
> Add bindings for the PLL clock generator on the JH7110 RISC-V SoC.
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  .../bindings/clock/starfive,jh7110-pll.yaml   | 46 +++++++++++++++++++
>  .../dt-bindings/clock/starfive,jh7110-crg.h   |  6 +++
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml
>
> diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml
> new file mode 100644
> index 000000000000..be8300ce86d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/starfive,jh7110-pll.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 PLL Clock Generator
> +
> +description:
> +  These PLLs are high speed, low jitter frequency synthesizers in the JH7110.
> +  Each PLL works in integer mode or fraction mode, with configuration
> +  registers in the sys syscon. So the PLLs node should be a child of
> +  SYS-SYSCON node.
> +  The formula for calculating frequency is
> +  Fvco = Fref * (NI + NF) / M / Q1
> +
> +maintainers:
> +  - Xingyu Wu <xingyu.wu@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-pll
> +
> +  clocks:
> +    maxItems: 1
> +    description: Main Oscillator (24 MHz)
> +
> +  '#clock-cells':
> +    const: 1
> +    description:
> +      See <dt-bindings/clock/starfive,jh7110-crg.h> for valid indices.
> +
> +required:
> +  - compatible
> +  - clocks
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller {
> +      compatible = "starfive,jh7110-pll";
> +      clocks = <&osc>;
> +      #clock-cells = <1>;
> +    };
> diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt-bindings/clock/starfive,jh7110-crg.h
> index 06257bfd9ac1..3fb5e31c3be4 100644
> --- a/include/dt-bindings/clock/starfive,jh7110-crg.h
> +++ b/include/dt-bindings/clock/starfive,jh7110-crg.h
> @@ -6,6 +6,12 @@
>  #ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
>  #define __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
>
> +/* PLL clocks */
> +#define JH7110_PLLCLK_PLL0_OUT                 0
> +#define JH7110_PLLCLK_PLL1_OUT                 1
> +#define JH7110_PLLCLK_PLL2_OUT                 2
> +#define JH7110_PLLCLK_END                      3
> +
>  /* SYSCRG clocks */
>  #define JH7110_SYSCLK_CPU_ROOT                 0
>  #define JH7110_SYSCLK_CPU_CORE                 1
> --
> 2.25.1
>
