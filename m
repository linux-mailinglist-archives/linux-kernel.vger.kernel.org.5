Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E682B78B0EB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjH1Mrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjH1MrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:47:03 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC80B11A;
        Mon, 28 Aug 2023 05:46:59 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5007c8308c3so4966388e87.0;
        Mon, 28 Aug 2023 05:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693226818; x=1693831618;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RKbygzd8nBa97vp+FOLUHU4VMJn4AUJJs7Ji4/H8MIo=;
        b=j9Fcv7/ATbvge3u73//9A7bUOFLTUCpq+Mo8mv2pVE746flc37hDqa00q+AwZnsLQf
         WjVIigWKc2rTGUCFof4NWky/tTpH8kCfajMCaAkcN0HEfUwxSHwgvWLl+IjgUu2RQEqp
         DiNeNB7iVyDpX4nmbPHE/ZLfW/Dp5KMrILSx2aBk/g8mIy9x5fTe5iXPp3ujxBR/pkiB
         R67M3sNNzqnX53GGye18q75YstmT4DHGL8ERe5PTqh0iirZ3hM+VWaow3SjJrC3a/+9R
         86hsRkHK2EK4c2ybQkys+wqYJFiaKrWLOOn8n3aCWYmCm5uquCsXORdFuoCs8HMsR/lr
         Jy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693226818; x=1693831618;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKbygzd8nBa97vp+FOLUHU4VMJn4AUJJs7Ji4/H8MIo=;
        b=YI6atPzPBqz9+GTf3J4OiUnDSiCBmhdYRccSNDQc0/kER5reY8ErUEYtTORgFs9QBB
         I7a9oVBFgFbN4YCE71PP3kj0enqino07k30cBH5E+7u6HvD1VtWa8c3/rJgNvZ3MThLs
         b/VD2vbIbdCO/N9zqIqRbmO2NGdryhtBuHZ5274fJ9sfepSrOU6Asc9sv6NRhVZvH0Ih
         fge+B8OnLsBVc5pcwP3b3RF1/BeBSWefF5MP8ifc1icr4XjJ+uSjSyrz7FZs72pjjGHv
         VxJ/ZmsJKY0BSN5Sqd1N3Te6GS/vFCSlCjfkidBYRWqUtKDHuYX36n1/5hLaRuHE/FSJ
         quew==
X-Gm-Message-State: AOJu0YwjnzrYfLrxRAcgtDVCmQKPCMT/P/p68oskP0QdlSxpfhrmIRw+
        BpVWLW+63FLK5O2ka/u0aA8=
X-Google-Smtp-Source: AGHT+IH8FOgmgz8Tec69XkCKDfGkNM/vLrWCchFCekesBi1O3Vzp9vTnsFX8SVlxBZvpGQjH6ojkXA==
X-Received: by 2002:a05:6512:12cb:b0:500:8443:744a with SMTP id p11-20020a05651212cb00b005008443744amr19189182lfg.7.1693226817678;
        Mon, 28 Aug 2023 05:46:57 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id v13-20020ac2592d000000b005009cbbdff7sm1570479lfi.11.2023.08.28.05.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 05:46:56 -0700 (PDT)
Date:   Mon, 28 Aug 2023 15:46:54 +0300
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
Message-ID: <vlbb25vj4qcbxpijvdiypnebbw7m2cuoepxr6sn74kgjhg4f3h@3z2x3l2kolxx>
References: <20230824125012.1040288-1-keguang.zhang@gmail.com>
 <20230824125012.1040288-3-keguang.zhang@gmail.com>
 <dwe4oyunc2uitullflhryg7kmgeklj5wlx6ztrg5hahl64tkuz@koe4tijgj3bp>
 <CAJhJPsWOOiPnkr-Mk0BXOgCBSMyFx+x7STbO910cxc1RoC8_dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhJPsWOOiPnkr-Mk0BXOgCBSMyFx+x7STbO910cxc1RoC8_dw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:38:37PM +0800, Keguang Zhang wrote:
> On Sun, Aug 27, 2023 at 5:04 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > On Thu, Aug 24, 2023 at 08:50:10PM +0800, Keguang Zhang wrote:
> > > Add devicetree binding document for Loongson-1 Ethernet controller.
> > >
> > > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > ---
> > > V2 -> V3: Split the DT-schema file into loongson,ls1b-gmac.yaml
> > >           and loongson,ls1c-emac.yaml (suggested by Serge Semin)
> > >           Change the compatibles to loongson,ls1b-gmac and loongson,ls1c-emac
> > >           Rename loongson,dwmac-syscon to loongson,ls1-syscon
> > >           Amend the title
> > >           Add description
> > >           Add Reviewed-by tag from Krzysztof Kozlowski(Sorry! I'm not sure)
> > > V1 -> V2: Fix "clock-names" and "interrupt-names" property
> > >           Rename the syscon property to "loongson,dwmac-syscon"
> > >           Drop "phy-handle" and "phy-mode" requirement
> > >           Revert adding loongson,ls1b-dwmac/loongson,ls1c-dwmac
> > >           to snps,dwmac.yaml
> > >
> > >  .../bindings/net/loongson,ls1b-gmac.yaml      | 115 ++++++++++++++++++
> > >  .../bindings/net/loongson,ls1c-emac.yaml      | 114 +++++++++++++++++
> > >  2 files changed, 229 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml b/Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
> > > new file mode 100644
> > > index 000000000000..f661d5b86649
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
> > > @@ -0,0 +1,115 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/net/loongson,ls1b-gmac.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Loongson-1B Gigabit Ethernet MAC Controller
> > > +
> > > +maintainers:
> > > +  - Keguang Zhang <keguang.zhang@gmail.com>
> > > +
> >
> > > +description:
> >
> > Use "|" to keep the text formatting.
> >   description: |
> >
> > > +  Loongson-1B Gigabit Ethernet MAC Controller is based on
> > > +  Synopsys DesignWare MAC (version 3.50a).
> > > +
> >
> > > +  Main features
> > > +  - Dual 10/100/1000Mbps GMAC controllers
> > > +  - Full-duplex operation (IEEE 802.3x flow control automatic transmission)
> > > +  - Half-duplex operation (CSMA/CD Protocol and back-pressure support)
> > > +  - RX Checksum Offload
> > > +  - TX Checksum insertion
> > > +  - MII interface
> > > +  - RGMII interface
> >
> > If only all the DW *MAC-based devices have such info in the
> > bindings the life would have been much easier...
> >
> > > +
> > > +select:
> > > +  properties:
> > > +    compatible:
> > > +      contains:
> > > +        enum:
> > > +          - loongson,ls1b-gmac
> > > +  required:
> > > +    - compatible
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - loongson,ls1b-gmac
> > > +      - const: snps,dwmac-3.50a
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> >

> > > +  clock-names:
> > > +    items:
> > > +      - const: stmmaceth
> >
> > since there is a single clock then just:
> >   clock-names:
> >     const: stmmaceth

As Krzysztof noted please ignore this comment.

> >
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> >
> > > +  interrupt-names:
> > > +    items:
> > > +      - const: macirq
> >

> > ditto. just
> >   interrupt-names:
> >     const: macirq

ditto.

> >
> > > +
> > > +  loongson,ls1-syscon:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description:
> > > +      Phandle to the syscon containing some extra configurations
> > > +      including PHY interface mode.
> > > +
> >
> > > +  phy-mode:
> > > +    items:
> > > +      - enum:
> > > +          - mii
> > > +          - rgmii-id
> >
> > it's a single string then just:
> >   phy-mode:
> >     enum: ...
> >
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - clocks
> > > +  - clock-names
> > > +  - interrupts
> > > +  - interrupt-names
> > > +  - loongson,ls1-syscon
> > > +
> > > +allOf:
> > > +  - $ref: snps,dwmac.yaml#
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/loongson,ls1x-clk.h>
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +
> > > +    gmac0: ethernet@1fe10000 {
> > > +        compatible = "loongson,ls1b-gmac", "snps,dwmac-3.50a";
> > > +        reg = <0x1fe10000 0x10000>;
> > > +
> > > +        clocks = <&clkc LS1X_CLKID_AHB>;
> > > +        clock-names = "stmmaceth";
> > > +
> > > +        interrupt-parent = <&intc1>;
> > > +        interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
> > > +        interrupt-names = "macirq";
> > > +
> > > +        loongson,ls1-syscon = <&syscon>;
> > > +
> > > +        phy-handle = <&phy0>;
> > > +        phy-mode = "mii";
> > > +        snps,pbl = <1>;
> > > +
> > > +        mdio {
> > > +            #address-cells = <1>;
> > > +            #size-cells = <0>;
> > > +            compatible = "snps,dwmac-mdio";
> > > +
> > > +            phy0: ethernet-phy@0 {
> > > +                reg = <0x0>;
> > > +            };
> > > +        };
> > > +    };
> > > diff --git a/Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml b/Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml
> > > new file mode 100644
> > > index 000000000000..1ffad41941bf
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml
> > > @@ -0,0 +1,114 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/net/loongson,ls1c-emac.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Loongson-1C Ethernet MAC Controller
> > > +
> > > +maintainers:
> > > +  - Keguang Zhang <keguang.zhang@gmail.com>
> > > +
> >
> > > +description:
> >
> > the same comment about the "|" modifier.
> >
> > > +  Loongson-1C Ethernet MAC Controller is based on
> > > +  Synopsys DesignWare MAC (version 3.50a).
> > > +
> >
> > > +  Main features
> > > +  - 10/100Mbps
> > > +  - Full-duplex operation (IEEE 802.3x flow control automatic transmission)
> > > +  - Half-duplex operation (CSMA/CD Protocol and back-pressure support)
> > > +  - IEEE 802.1Q VLAN tag detection for reception frames
> > > +  - MII interface
> > > +  - RMII interface
> >
> > Based on the plat_stmmacenet_data data defined for the LS1C MAC it
> > also support support Tx COE. Isn't it? What about Rx COE?
> >

> According to the value read from HW Feature Register(offset 0x1058),
> both TXCOESEL an
> RXTYP1COE/RXTYP2COE are zero.
> Therefore, neither TX COE nor RX COE is supported by LS1C MAC.
> Current plat_stmmacenet_data is Inaccurate.

And since STMMAC probe() procedure overrides the
plat_stmmacenet_data.tx_coe field then no problems the mistaken value
caused. I see. Thanks for clarification.

-Serge(y)

> 
> > > +
> > > +select:
> > > +  properties:
> > > +    compatible:
> > > +      contains:
> > > +        enum:
> > > +          - loongson,ls1c-emac
> > > +  required:
> > > +    - compatible
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - loongson,ls1c-emac
> > > +      - const: snps,dwmac-3.50a
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> >
> > > +  clock-names:
> > > +    items:
> > > +      - const: stmmaceth
> >

> >   clock-names:
> >     const: stmmaceth
> > ?

Please ignore this comment.

> >
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> >
> > > +  interrupt-names:
> > > +    items:
> > > +      - const: macirq
> >

> >   interrupt-names:
> >     const: macirq
> > ?

ditto.

-Serge(y)

> >
> > > +
> > > +  loongson,ls1-syscon:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description:
> > > +      Phandle to the syscon containing some extra configurations
> > > +      including PHY interface mode.
> > > +
> >
> > > +  phy-mode:
> > > +    items:
> > > +      - enum:
> > > +          - mii
> > > +          - rmii
> >
> >   phy-mode:
> >     enum: ...
> > ?
> >
> > -Serge(y)
> >
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - clocks
> > > +  - clock-names
> > > +  - interrupts
> > > +  - interrupt-names
> > > +  - loongson,ls1-syscon
> > > +
> > > +allOf:
> > > +  - $ref: snps,dwmac.yaml#
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/loongson,ls1x-clk.h>
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +
> > > +    emac: ethernet@1fe10000 {
> > > +        compatible = "loongson,ls1c-emac", "snps,dwmac-3.50a";
> > > +        reg = <0x1fe10000 0x10000>;
> > > +
> > > +        clocks = <&clkc LS1X_CLKID_AHB>;
> > > +        clock-names = "stmmaceth";
> > > +
> > > +        interrupt-parent = <&intc1>;
> > > +        interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
> > > +        interrupt-names = "macirq";
> > > +
> > > +        loongson,ls1-syscon = <&syscon>;
> > > +
> > > +        phy-handle = <&phy0>;
> > > +        phy-mode = "mii";
> > > +        snps,pbl = <1>;
> > > +
> > > +        mdio {
> > > +            #address-cells = <1>;
> > > +            #size-cells = <0>;
> > > +            compatible = "snps,dwmac-mdio";
> > > +
> > > +            phy0: ethernet-phy@13 {
> > > +                reg = <0x13>;
> > > +            };
> > > +        };
> > > +    };
> > > --
> > > 2.39.2
> > >
> > >
> 
> 
> 
> --
> Best regards,
> 
> Keguang Zhang
