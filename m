Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7767A1B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbjIOJ6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjIOJ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:58:37 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A0B3AB0;
        Fri, 15 Sep 2023 02:56:56 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so30238641fa.3;
        Fri, 15 Sep 2023 02:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694771814; x=1695376614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aMiSvg4Yw3aEFjiZx3jQ2DPRS3tXitXjq3AL84CvKNk=;
        b=Fh9WkBeN3ND4cFbgw7GuyP5XAo3lJrg8ZRn8+lMw1QV9cbp2pY4d7jgP3LCDzuIREb
         f84EeouUGUlytvtgOKybUee3HQe4/FU3R03p04YcYUGdSuYEAaKcEZhhqdOLWIMisvGG
         EThlhErpTsnAUIBNeLaBLe9xvU6KlP42v2CvuiymYwuVxIEV41Cb6eUleMUUnf9hwOaF
         bF8Jx4sle4WNPiQIjs/U/EgHPd/T/kDLCfp22WcSVcRfSSQr/t9LbyO6WpFYtE6Tdvaa
         sBx6XXkCvWQUzEHDMpwdeYH1mYg+4pELEKsrkYeVQBKWAs4mCtAJR4lb7CCiV0o6q3E1
         cE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771814; x=1695376614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMiSvg4Yw3aEFjiZx3jQ2DPRS3tXitXjq3AL84CvKNk=;
        b=Gmn95mXLUyzMk09ZNGtST80wPdLzCJjREG52qm0xdxgBCQ/B7UXtJleMJ5dgXMOTkh
         SjVliwAFDrH4DouSMyFlRWBFWKQoK8F6D15VX8bXiwkBnv7ytdpwIMJlucH/Y50Os7Ja
         hHfX/pA4rALu4FSknDaNEhh7HhHKFbyS7fa2FuLf8fhdTMnIbOPzXp6qnKwFriNQgDYI
         nQ7ZnGJGTk0EGmpykzKd7OFfuSJp1HWEqbOZzVQydS7amsk9DEYdgMe1XSdNlbowcEe1
         pENcKskgDG4SNo7+Tgh0hGqVUkNF4dBgKwi97D3OLFLT+MfSFNYsJZiIvu8S4sokx9cP
         IBdQ==
X-Gm-Message-State: AOJu0YzSKvEEgbzHn+0T5jEZtJdtk4VmpaSACWgAEjrjcRT+8LDVg7m7
        GMCNWG3fRkomFiEkOCo4fWk=
X-Google-Smtp-Source: AGHT+IGiIrBzxdkDcZggY5VX3GV5v815lZiXPB+li9/p6okgCgXaH3NDcd7FeFWBOLK7jq/+AUtCFQ==
X-Received: by 2002:a2e:950c:0:b0:2bf:ab17:d48b with SMTP id f12-20020a2e950c000000b002bfab17d48bmr1085429ljh.34.1694771813921;
        Fri, 15 Sep 2023 02:56:53 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id l16-20020a2ea310000000b002bcbae4c21fsm651828lje.50.2023.09.15.02.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:56:53 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:56:51 +0300
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
Subject: Re: [PATCH v5 2/3] dt-bindings: net: Add Loongson-1 Ethernet
 Controller
Message-ID: <e5tsfcu7qg7bl4phybyg3dzxioa6ccrs3fsckrxmzukalhnumq@e76h5zzhjtjr>
References: <20230914114435.481900-1-keguang.zhang@gmail.com>
 <20230914114435.481900-3-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914114435.481900-3-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 07:44:34PM +0800, Keguang Zhang wrote:
> Add devicetree binding document for Loongson-1 Ethernet controller.
> And modify MAINTAINERS to add a new F: entry for
> Loongson1 dt-binding documents.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
> V4 -> V5: Add a new F: entry for Loongson1 dt-binding documents
> V3 -> V4: Add "|" to description part
>           Amend "phy-mode" property
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
>  .../bindings/net/loongson,ls1b-gmac.yaml      | 114 ++++++++++++++++++
>  .../bindings/net/loongson,ls1c-emac.yaml      | 113 +++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  3 files changed, 228 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
>  create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml b/Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
> new file mode 100644
> index 000000000000..c4f3224bad38
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
> @@ -0,0 +1,114 @@
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
> +description: |
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
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    items:
> +      - const: macirq
> +
> +  loongson,ls1-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon containing some extra configurations
> +      including PHY interface mode.
> +
> +  phy-mode:
> +    enum:
> +      - mii
> +      - rgmii-id
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
> index 000000000000..99001b940b83
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml
> @@ -0,0 +1,113 @@
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
> +description: |
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
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    items:
> +      - const: macirq
> +
> +  loongson,ls1-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon containing some extra configurations
> +      including PHY interface mode.
> +
> +  phy-mode:
> +    enum:
> +      - mii
> +      - rmii
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
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fa7487b7729b..e514b53fb225 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14379,6 +14379,7 @@ MIPS/LOONGSON1 ARCHITECTURE
>  M:	Keguang Zhang <keguang.zhang@gmail.com>
>  L:	linux-mips@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/*/loongson,ls1*.yaml
>  F:	arch/mips/include/asm/mach-loongson32/
>  F:	arch/mips/loongson32/
>  F:	drivers/*/*loongson1*
> -- 
> 2.39.2
> 
> 
