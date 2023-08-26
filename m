Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A4C78992A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 23:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjHZVEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 17:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjHZVEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 17:04:12 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC5FE50;
        Sat, 26 Aug 2023 14:04:09 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bcb54226e7so24262071fa.1;
        Sat, 26 Aug 2023 14:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693083848; x=1693688648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HIW3TRdcZM8BB21Bzls1PHa43zWQN2HiFfuM5Vokr34=;
        b=dtKisuZ1E5Uv+MovZUHmskuQJQ8Tj197eCFIMX2wluJpoNMTiFduzx5tXViYapuNQV
         70b1Tnkv2s9muM3zfZSts/X1KR41WFWmCz2fCHnBQQz7R6h5rR0wG8YIGqZuXP/uGT5q
         2GdnX0k4zzgQbdbQvI7zxcE3xVBJdGw397dJy5BhEgccW+a0899PQJcvluDmO8d6roPF
         z0Q1YqfXn8HlT3re9NRfUu6lP48NHlTWjLA6XDKj+CLq8S+pNjmCE/nnc24WP6L++Yrh
         Olef/Tm2c6DB6hCWbdYS47rQi4ev/jX94Ovtd7qQQBDBK6WstYbBDsThhm1pye8Mrh0b
         lUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693083848; x=1693688648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIW3TRdcZM8BB21Bzls1PHa43zWQN2HiFfuM5Vokr34=;
        b=F59qWUVsrp+W4yFuck8W0bc3fhHG+6AZFUDmQOV+ztgx7Nas3th0AqRNkTiYzypb1K
         9yP+w2KhtGQPO7KcCg6DXiKq/lhI1kiyPOsnC7hxRaP53U4tmKFEmcu7P8C/2GVkBdWj
         AT7A5coPQd1KNNy/14dyd2XQzpOHQkXGAB1D27CEDrKeln14yxTv+Xti0A25xV7nKJ8i
         vPFZKx5LHCxnGYfreTTJkrLjenn0xHnnBRVqk8P3vH+PK3QjbHmIjcsfl6itGUaHFEgY
         66JseKkk5iHGPJ+xt6dPD7AhqFyT86IfTch2y2Tnkx0Bd/NvObBiVWol/BLWGxZ0EBtY
         AoTg==
X-Gm-Message-State: AOJu0YyYRqnhD/+8BQC0C413C4Amt0OeYjTBaqFO69Ca/Kswq5Zt2gFe
        5+Ie7YVMpNbZBnvE/BoFhAs=
X-Google-Smtp-Source: AGHT+IHFX3R3aJ//dDGKbAPbc0tu1Bp0PweEt0u3uFHVBQfJ6/o0ZZFsfV0+w+jDB2pZ+940KhLePA==
X-Received: by 2002:a2e:80c8:0:b0:2bc:f1d3:b54b with SMTP id r8-20020a2e80c8000000b002bcf1d3b54bmr1796869ljg.4.1693083847462;
        Sat, 26 Aug 2023 14:04:07 -0700 (PDT)
Received: from mobilestation ([95.79.200.178])
        by smtp.gmail.com with ESMTPSA id u11-20020a2ea16b000000b002b6dba16f28sm945259ljl.127.2023.08.26.14.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 14:04:07 -0700 (PDT)
Date:   Sun, 27 Aug 2023 00:04:04 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: net: Add Loongson-1 Ethernet
 Controller
Message-ID: <dwe4oyunc2uitullflhryg7kmgeklj5wlx6ztrg5hahl64tkuz@koe4tijgj3bp>
References: <20230824125012.1040288-1-keguang.zhang@gmail.com>
 <20230824125012.1040288-3-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824125012.1040288-3-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 08:50:10PM +0800, Keguang Zhang wrote:
> Add devicetree binding document for Loongson-1 Ethernet controller.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> V2 -> V3: Split the DT-schema file into loongson,ls1b-gmac.yaml
>           and loongson,ls1c-emac.yaml (suggested by Serge Semin)
>           Change the compatibles to loongson,ls1b-gmac and loongson,ls1c-emac
>           Rename loongson,dwmac-syscon to loongson,ls1-syscon
>           Amend the title
>           Add description
>           Add Reviewed-by tag from Krzysztof Kozlowski(Sorry! I'm not sure)
> V1 -> V2: Fix "clock-names" and "interrupt-names" property
>           Rename the syscon property to "loongson,dwmac-syscon"
>           Drop "phy-handle" and "phy-mode" requirement
>           Revert adding loongson,ls1b-dwmac/loongson,ls1c-dwmac
>           to snps,dwmac.yaml
> 
>  .../bindings/net/loongson,ls1b-gmac.yaml      | 115 ++++++++++++++++++
>  .../bindings/net/loongson,ls1c-emac.yaml      | 114 +++++++++++++++++
>  2 files changed, 229 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
>  create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml b/Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
> new file mode 100644
> index 000000000000..f661d5b86649
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/loongson,ls1b-gmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson-1B Gigabit Ethernet MAC Controller
> +
> +maintainers:
> +  - Keguang Zhang <keguang.zhang@gmail.com>
> +

> +description:

Use "|" to keep the text formatting.
  description: |

> +  Loongson-1B Gigabit Ethernet MAC Controller is based on
> +  Synopsys DesignWare MAC (version 3.50a).
> +

> +  Main features
> +  - Dual 10/100/1000Mbps GMAC controllers
> +  - Full-duplex operation (IEEE 802.3x flow control automatic transmission)
> +  - Half-duplex operation (CSMA/CD Protocol and back-pressure support)
> +  - RX Checksum Offload
> +  - TX Checksum insertion
> +  - MII interface
> +  - RGMII interface

If only all the DW *MAC-based devices have such info in the
bindings the life would have been much easier...

> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - loongson,ls1b-gmac
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - loongson,ls1b-gmac
> +      - const: snps,dwmac-3.50a
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +

> +  clock-names:
> +    items:
> +      - const: stmmaceth

since there is a single clock then just:
  clock-names:
    const: stmmaceth

> +
> +  interrupts:
> +    maxItems: 1
> +

> +  interrupt-names:
> +    items:
> +      - const: macirq

ditto. just
  interrupt-names:
    const: macirq

> +
> +  loongson,ls1-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon containing some extra configurations
> +      including PHY interface mode.
> +

> +  phy-mode:
> +    items:
> +      - enum:
> +          - mii
> +          - rgmii-id

it's a single string then just:
  phy-mode:
    enum: ...

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +  - loongson,ls1-syscon
> +
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/loongson,ls1x-clk.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    gmac0: ethernet@1fe10000 {
> +        compatible = "loongson,ls1b-gmac", "snps,dwmac-3.50a";
> +        reg = <0x1fe10000 0x10000>;
> +
> +        clocks = <&clkc LS1X_CLKID_AHB>;
> +        clock-names = "stmmaceth";
> +
> +        interrupt-parent = <&intc1>;
> +        interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "macirq";
> +
> +        loongson,ls1-syscon = <&syscon>;
> +
> +        phy-handle = <&phy0>;
> +        phy-mode = "mii";
> +        snps,pbl = <1>;
> +
> +        mdio {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            compatible = "snps,dwmac-mdio";
> +
> +            phy0: ethernet-phy@0 {
> +                reg = <0x0>;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml b/Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml
> new file mode 100644
> index 000000000000..1ffad41941bf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml
> @@ -0,0 +1,114 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/loongson,ls1c-emac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson-1C Ethernet MAC Controller
> +
> +maintainers:
> +  - Keguang Zhang <keguang.zhang@gmail.com>
> +

> +description:

the same comment about the "|" modifier.

> +  Loongson-1C Ethernet MAC Controller is based on
> +  Synopsys DesignWare MAC (version 3.50a).
> +

> +  Main features
> +  - 10/100Mbps
> +  - Full-duplex operation (IEEE 802.3x flow control automatic transmission)
> +  - Half-duplex operation (CSMA/CD Protocol and back-pressure support)
> +  - IEEE 802.1Q VLAN tag detection for reception frames
> +  - MII interface
> +  - RMII interface

Based on the plat_stmmacenet_data data defined for the LS1C MAC it
also support support Tx COE. Isn't it? What about Rx COE?

> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - loongson,ls1c-emac
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - loongson,ls1c-emac
> +      - const: snps,dwmac-3.50a
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +

> +  clock-names:
> +    items:
> +      - const: stmmaceth

  clock-names:
    const: stmmaceth
?

> +
> +  interrupts:
> +    maxItems: 1
> +

> +  interrupt-names:
> +    items:
> +      - const: macirq

  interrupt-names:
    const: macirq
?

> +
> +  loongson,ls1-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon containing some extra configurations
> +      including PHY interface mode.
> +

> +  phy-mode:
> +    items:
> +      - enum:
> +          - mii
> +          - rmii

  phy-mode:
    enum: ...
?

-Serge(y)

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +  - loongson,ls1-syscon
> +
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/loongson,ls1x-clk.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    emac: ethernet@1fe10000 {
> +        compatible = "loongson,ls1c-emac", "snps,dwmac-3.50a";
> +        reg = <0x1fe10000 0x10000>;
> +
> +        clocks = <&clkc LS1X_CLKID_AHB>;
> +        clock-names = "stmmaceth";
> +
> +        interrupt-parent = <&intc1>;
> +        interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "macirq";
> +
> +        loongson,ls1-syscon = <&syscon>;
> +
> +        phy-handle = <&phy0>;
> +        phy-mode = "mii";
> +        snps,pbl = <1>;
> +
> +        mdio {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            compatible = "snps,dwmac-mdio";
> +
> +            phy0: ethernet-phy@13 {
> +                reg = <0x13>;
> +            };
> +        };
> +    };
> -- 
> 2.39.2
> 
> 
