Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92B878A4F9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 06:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjH1Ejx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 00:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjH1EjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 00:39:19 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC80124;
        Sun, 27 Aug 2023 21:39:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52a3ff5f0abso3731875a12.1;
        Sun, 27 Aug 2023 21:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693197554; x=1693802354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wE6m2GXwFFPq4NJBQ0sRXfE2Cg2dR5BXR+AZ5aIwj60=;
        b=ivdDT9fJBsNV1HczxghuQp2MnsA5ghjkHEXqdwZeO8s4hyZ6he51QHNTZ4jqzm5GXi
         W0ymhp0caMHShka9rf+WgflQDShDHwbo9R96Be68Gb7rjehpqepaA9GekOEN5+gMSjsL
         YpbRu3co6nUGGiYcZDFZNCtbUrXtyigf6JzeRboQR7LTtZhoekWLVK8e+gvWJcGsqjpv
         OAbCBelLDR+y73DheOdV1iU5d1Db1eotWDFpKfIpd/oxiL3kmke5w8pc1qRkuumiPJUF
         x/+Kau8wPROTHPuc6jvwURj5UpRwr4m/Udjtl4fHvkQ983unzol13wlfpkJTAdtjdHKf
         UOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693197554; x=1693802354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wE6m2GXwFFPq4NJBQ0sRXfE2Cg2dR5BXR+AZ5aIwj60=;
        b=Kj+2QGzr3hpl5o79cj2kJVRixHc5kIYWH8OijlVOiXZpSfZfMxpRDjEO75sDlg/5vb
         tf1BEIVKdhKBznl0ZfutAs7L1BvIAkIbtpn/7rSDstaQ4jvGqsBNOqOUsve1qm+4YR5q
         +dg3vTIBiE9Izu2L88zAwPM/dIn+FNO1qUszzCeM+HwhF3ZdyY9iL3oB7qGp2DKX3jNT
         IEAEmdV/0QSvJHK/0yxw+LNc9t/pEdpM4Tza93/NgRrP/nfM2J2pv5BaqFuAqe+j4Z8W
         3xbRCzn6dSIKej/s5H4l23HkHyWeOvv1FJPkbnGDhVQ+z5PKjgEjIFwcsF9aZkNM5zrt
         s/xQ==
X-Gm-Message-State: AOJu0YyKb9+PfnsiG94GByYDXPiFf17DiTuB0fUumvYb/OEUYAdzOb9C
        ytDmr5zuWwqlXW985BwhxCk80oZEh2uSndgxkWg=
X-Google-Smtp-Source: AGHT+IH/joOSu2b6OBOw236aHBSrAmkDgpyHagqggNExbdBZSoySDRp9Ig9Qq6ElZUFHQbWAhhDC6mXkyTflxXfoOiQ=
X-Received: by 2002:a05:6402:74f:b0:514:9ab4:3524 with SMTP id
 p15-20020a056402074f00b005149ab43524mr18419532edy.7.1693197553857; Sun, 27
 Aug 2023 21:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230824125012.1040288-1-keguang.zhang@gmail.com>
 <20230824125012.1040288-3-keguang.zhang@gmail.com> <dwe4oyunc2uitullflhryg7kmgeklj5wlx6ztrg5hahl64tkuz@koe4tijgj3bp>
In-Reply-To: <dwe4oyunc2uitullflhryg7kmgeklj5wlx6ztrg5hahl64tkuz@koe4tijgj3bp>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Mon, 28 Aug 2023 12:38:37 +0800
Message-ID: <CAJhJPsWOOiPnkr-Mk0BXOgCBSMyFx+x7STbO910cxc1RoC8_dw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
According to the value read from HW Feature Register(offset 0x1058),
both TXCOESEL an
RXTYP1COE/RXTYP2COE are zero.
Therefore, neither TX COE nor RX COE is supported by LS1C MAC.
Current plat_stmmacenet_data is Inaccurate.

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



--
Best regards,

Keguang Zhang
