Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F97078B161
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjH1NKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjH1NK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:10:29 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209EDCC;
        Mon, 28 Aug 2023 06:10:25 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50091b91a83so4832530e87.3;
        Mon, 28 Aug 2023 06:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693228223; x=1693833023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpqvqS+fYSjFHYGuyg+gEAZd0FugNzJBjVPZjXEWq4E=;
        b=r7UAA6kgupMZUSPR5e5uaaI8wzVG6TpQLS+7eu5AxXVYQgI5bAzu8g6QqWP3sUTZUj
         U0OorX63BEt+ozzEBLLJT71oaTVNEz8/ilQYad9qdpkXBVkX2guhiTITN/7roFDYrO1X
         58bF5x5oVfO0Y4FkCWxqwd2g8H95U59VeGmUYbWgN0cCzGori1haVrITTlL+uX8hGNKr
         ZuLb77b/0cSSniyn8nvl0fl93qFB3dirrBcuQBoK5zoOVeSjY1aU+vz4uYdDQA62fE/g
         96ks6ZMUADQq66oXGLXd98lvGL3hO03cjBBkQENaBh/ebF/jW46Xt/hkkGQfMOIYDXMX
         gigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693228223; x=1693833023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpqvqS+fYSjFHYGuyg+gEAZd0FugNzJBjVPZjXEWq4E=;
        b=duQXnRyqLYXTF3ZyhlJoIU7uesM8xJY2HTPoGR1kRF5UM7/4BDH6shJmE/mc0rac/I
         WSn9Gpl0HtnzJFUMkVJjOfPDFPZPxeSfczjNruUMMPTUyo6sPhA4l2U38a0qs5I3P+B8
         5hBErL3KmhNBwtA7P9oK51SDwGn9SyA8OwQWiKlZK4nuhu2MohvXvN/kP8gsKOltW1ws
         wVV7Qo/lMSmW6gQbNE4YfP5F863Ab5rveYBGl/eB+hgg28VkGBTGwRoT6MZ7yAVkbd3j
         29G7n30dqH3A52ZCQKFX36degW7oy7yjSaFXUE41ZneO2y5vWgEAUz1MlGnE769YAAI7
         CNtw==
X-Gm-Message-State: AOJu0YyAWrw0+XXy9OPPTEUW+7AA9IaMpSPsLDu9KyM7RBmqZrTZuYN6
        5AwfmF8ha5ZkfOT6lxbx3YTfof6IYUvwXiUlSs8=
X-Google-Smtp-Source: AGHT+IGTdT+RlfQq1iFceMWgVEykC3GfUKhMxWYC8+y/6ChxgTlYLs9wDHB7KESy6dP8u5oxa14gzSK/dSOOww78HWA=
X-Received: by 2002:a05:6512:1cd:b0:4ff:af45:1ef7 with SMTP id
 f13-20020a05651201cd00b004ffaf451ef7mr15536129lfp.6.1693228222939; Mon, 28
 Aug 2023 06:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230824125012.1040288-1-keguang.zhang@gmail.com>
 <20230824125012.1040288-3-keguang.zhang@gmail.com> <dwe4oyunc2uitullflhryg7kmgeklj5wlx6ztrg5hahl64tkuz@koe4tijgj3bp>
In-Reply-To: <dwe4oyunc2uitullflhryg7kmgeklj5wlx6ztrg5hahl64tkuz@koe4tijgj3bp>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Mon, 28 Aug 2023 21:09:46 +0800
Message-ID: <CAJhJPsXEzqbwxBzwHqSG2_PxWPONofNycdTADZ3j=86J5CnMfQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: net: Add Loongson-1 Ethernet Controller
To:     Serge Semin <fancer.lancer@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 5:04=E2=80=AFAM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> On Thu, Aug 24, 2023 at 08:50:10PM +0800, Keguang Zhang wrote:
> > Add devicetree binding document for Loongson-1 Ethernet controller.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > V2 -> V3: Split the DT-schema file into loongson,ls1b-gmac.yaml
> >           and loongson,ls1c-emac.yaml (suggested by Serge Semin)
> >           Change the compatibles to loongson,ls1b-gmac and loongson,ls1=
c-emac
> >           Rename loongson,dwmac-syscon to loongson,ls1-syscon
> >           Amend the title
> >           Add description
> >           Add Reviewed-by tag from Krzysztof Kozlowski(Sorry! I'm not s=
ure)
> > V1 -> V2: Fix "clock-names" and "interrupt-names" property
> >           Rename the syscon property to "loongson,dwmac-syscon"
> >           Drop "phy-handle" and "phy-mode" requirement
> >           Revert adding loongson,ls1b-dwmac/loongson,ls1c-dwmac
> >           to snps,dwmac.yaml
> >
> >  .../bindings/net/loongson,ls1b-gmac.yaml      | 115 ++++++++++++++++++
> >  .../bindings/net/loongson,ls1c-emac.yaml      | 114 +++++++++++++++++
> >  2 files changed, 229 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1b=
-gmac.yaml
> >  create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1c=
-emac.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/net/loongson,ls1b-gmac.y=
aml b/Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
> > new file mode 100644
> > index 000000000000..f661d5b86649
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
> > @@ -0,0 +1,115 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/loongson,ls1b-gmac.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Loongson-1B Gigabit Ethernet MAC Controller
> > +
> > +maintainers:
> > +  - Keguang Zhang <keguang.zhang@gmail.com>
> > +
>
> > +description:
>
> Use "|" to keep the text formatting.
>   description: |
>
Will do.

> > +  Loongson-1B Gigabit Ethernet MAC Controller is based on
> > +  Synopsys DesignWare MAC (version 3.50a).
> > +
>
> > +  Main features
> > +  - Dual 10/100/1000Mbps GMAC controllers
> > +  - Full-duplex operation (IEEE 802.3x flow control automatic transmis=
sion)
> > +  - Half-duplex operation (CSMA/CD Protocol and back-pressure support)
> > +  - RX Checksum Offload
> > +  - TX Checksum insertion
> > +  - MII interface
> > +  - RGMII interface
>
> If only all the DW *MAC-based devices have such info in the
> bindings the life would have been much easier...
>
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - loongson,ls1b-gmac
> > +  required:
> > +    - compatible
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - loongson,ls1b-gmac
> > +      - const: snps,dwmac-3.50a
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
>
> > +  clock-names:
> > +    items:
> > +      - const: stmmaceth
>
> since there is a single clock then just:
>   clock-names:
>     const: stmmaceth
>
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
>
> > +  interrupt-names:
> > +    items:
> > +      - const: macirq
>
> ditto. just
>   interrupt-names:
>     const: macirq
>
> > +
> > +  loongson,ls1-syscon:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle to the syscon containing some extra configurations
> > +      including PHY interface mode.
> > +
>
> > +  phy-mode:
> > +    items:
> > +      - enum:
> > +          - mii
> > +          - rgmii-id
>
> it's a single string then just:
>   phy-mode:
>     enum: ...
>
Will do.

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +  - interrupt-names
> > +  - loongson,ls1-syscon
> > +
> > +allOf:
> > +  - $ref: snps,dwmac.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/loongson,ls1x-clk.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    gmac0: ethernet@1fe10000 {
> > +        compatible =3D "loongson,ls1b-gmac", "snps,dwmac-3.50a";
> > +        reg =3D <0x1fe10000 0x10000>;
> > +
> > +        clocks =3D <&clkc LS1X_CLKID_AHB>;
> > +        clock-names =3D "stmmaceth";
> > +
> > +        interrupt-parent =3D <&intc1>;
> > +        interrupts =3D <2 IRQ_TYPE_LEVEL_HIGH>;
> > +        interrupt-names =3D "macirq";
> > +
> > +        loongson,ls1-syscon =3D <&syscon>;
> > +
> > +        phy-handle =3D <&phy0>;
> > +        phy-mode =3D "mii";
> > +        snps,pbl =3D <1>;
> > +
> > +        mdio {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +            compatible =3D "snps,dwmac-mdio";
> > +
> > +            phy0: ethernet-phy@0 {
> > +                reg =3D <0x0>;
> > +            };
> > +        };
> > +    };
> > diff --git a/Documentation/devicetree/bindings/net/loongson,ls1c-emac.y=
aml b/Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml
> > new file mode 100644
> > index 000000000000..1ffad41941bf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml
> > @@ -0,0 +1,114 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/loongson,ls1c-emac.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Loongson-1C Ethernet MAC Controller
> > +
> > +maintainers:
> > +  - Keguang Zhang <keguang.zhang@gmail.com>
> > +
>
> > +description:
>
> the same comment about the "|" modifier.
>
Will do.

> > +  Loongson-1C Ethernet MAC Controller is based on
> > +  Synopsys DesignWare MAC (version 3.50a).
> > +
>
> > +  Main features
> > +  - 10/100Mbps
> > +  - Full-duplex operation (IEEE 802.3x flow control automatic transmis=
sion)
> > +  - Half-duplex operation (CSMA/CD Protocol and back-pressure support)
> > +  - IEEE 802.1Q VLAN tag detection for reception frames
> > +  - MII interface
> > +  - RMII interface
>
> Based on the plat_stmmacenet_data data defined for the LS1C MAC it
> also support support Tx COE. Isn't it? What about Rx COE?
>
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - loongson,ls1c-emac
> > +  required:
> > +    - compatible
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - loongson,ls1c-emac
> > +      - const: snps,dwmac-3.50a
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
>
> > +  clock-names:
> > +    items:
> > +      - const: stmmaceth
>
>   clock-names:
>     const: stmmaceth
> ?
>
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
>
> > +  interrupt-names:
> > +    items:
> > +      - const: macirq
>
>   interrupt-names:
>     const: macirq
> ?
>
> > +
> > +  loongson,ls1-syscon:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle to the syscon containing some extra configurations
> > +      including PHY interface mode.
> > +
>
> > +  phy-mode:
> > +    items:
> > +      - enum:
> > +          - mii
> > +          - rmii
>
>   phy-mode:
>     enum: ...
> ?
Will do.
>
> -Serge(y)
>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +  - interrupt-names
> > +  - loongson,ls1-syscon
> > +
> > +allOf:
> > +  - $ref: snps,dwmac.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/loongson,ls1x-clk.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    emac: ethernet@1fe10000 {
> > +        compatible =3D "loongson,ls1c-emac", "snps,dwmac-3.50a";
> > +        reg =3D <0x1fe10000 0x10000>;
> > +
> > +        clocks =3D <&clkc LS1X_CLKID_AHB>;
> > +        clock-names =3D "stmmaceth";
> > +
> > +        interrupt-parent =3D <&intc1>;
> > +        interrupts =3D <2 IRQ_TYPE_LEVEL_HIGH>;
> > +        interrupt-names =3D "macirq";
> > +
> > +        loongson,ls1-syscon =3D <&syscon>;
> > +
> > +        phy-handle =3D <&phy0>;
> > +        phy-mode =3D "mii";
> > +        snps,pbl =3D <1>;
> > +
> > +        mdio {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +            compatible =3D "snps,dwmac-mdio";
> > +
> > +            phy0: ethernet-phy@13 {
> > +                reg =3D <0x13>;
> > +            };
> > +        };
> > +    };
> > --
> > 2.39.2
> >
> >



--=20
Best regards,

Keguang Zhang
