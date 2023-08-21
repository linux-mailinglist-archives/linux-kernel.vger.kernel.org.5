Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59184782A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbjHUNPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjHUNPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:15:01 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205D8F4;
        Mon, 21 Aug 2023 06:14:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5236b2b4cdbso4214809a12.3;
        Mon, 21 Aug 2023 06:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692623598; x=1693228398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oX0xWKQkXrYavLJXfvsEkt1aDI7IkJr5D/pUmxA4EgU=;
        b=msRWNKPV74iHu+isJb6p0zwb80yPBowEDPJNAdfbwhHJ4EmktivtMHNk0Iack0Svjq
         VWcyjzjrhlzJf++3epO6bkJ/P2qx10S/kRYQfJBpwBSwk7RIHss5jl4pjdLQWN3vCUFl
         YyjFlalgtqD5fNQyk0YO6eIvoICnRWK7Ign50JpCFCUGx/5XrHhwr9EohTe3iwKi5OzU
         3KA2gPe8aiikuzs8qeXwvuWkLO+Z3qis7KD1QGXW3CuS716gJSJAOjzP3DFmcl2Oy1VS
         +T4acbUfJ2D1ifGBcteb2ZswHziUdfLqM5zN2xFx61V5P7RcseQ6dh5q6rtMdN4OXqBz
         RYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692623598; x=1693228398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oX0xWKQkXrYavLJXfvsEkt1aDI7IkJr5D/pUmxA4EgU=;
        b=PjQ+G30Tr9Eslq3Jn6V2kSgb1V503W6XmzrjhqXcK3AdGjgeoWo7+1r1XpDgNookpg
         pHpd4+kf0aT1vci5M3dgYSntb3KE+kU0lrzQWDGMryx7Msn0OF8RXbnjuay2GVLJ9SS5
         gk+d0yZpDCVskjE44ABltDiSAmaaqNxIwDJeyxogI76eJJjhdz64ZuiKARvKcsFa/ULa
         SFwcsVX7/7dIY/KY872GQ/L45f50s/dR91A+m+13x47c1gpkg/zRvnSCW5CQGzrS2T/Y
         a6F6zvdQDfnfrPDHMW4j9mDXdQdjuCo/5FJMvloEgw3eLlwXe0CDosktO2O0jFAwVsyP
         pCUg==
X-Gm-Message-State: AOJu0YxxZjtvpk22KaaglM1j0bg3mSlvd80mXTEUvlSHswtagKzRt1NS
        nah/Iw5cZynkFOO6psgTNWkIFH0eTc+uWahbJ9A=
X-Google-Smtp-Source: AGHT+IGgODVe3sxeZIdVpzBoAXIab50YLpc7teJAxlyvaIySQPuigyCmcQ+XsuzZd5DvLV7LMUSrT+Brha9biAsqTBY=
X-Received: by 2002:a50:fa93:0:b0:523:102f:3cdd with SMTP id
 w19-20020a50fa93000000b00523102f3cddmr5285515edr.19.1692623598394; Mon, 21
 Aug 2023 06:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230812151135.1028780-1-keguang.zhang@gmail.com>
 <20230812151135.1028780-4-keguang.zhang@gmail.com> <thdwhlbs5salnufag24tqk4txqs3skidhq5nmzdeyxt3ni5pos@duj55rpqskl3>
 <CAJhJPsV9g2hSu4Ga8bH573JsJsrA_3dwi8T0oQBtq0FydHKrPg@mail.gmail.com> <jjpwnfc3bjpw44fdzqmekbxqaqeus34aeuezas3fqrfbsvp4gp@yhv4ig5ypj3g>
In-Reply-To: <jjpwnfc3bjpw44fdzqmekbxqaqeus34aeuezas3fqrfbsvp4gp@yhv4ig5ypj3g>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Mon, 21 Aug 2023 21:13:01 +0800
Message-ID: <CAJhJPsUAssk7wHzM8ptEAB_TWchdvuZyWw92+YGZL+YuTD+sgw@mail.gmail.com>
Subject: Re: [PATCH 3/5] dt-bindings: net: Add Loongson-1 DWMAC glue layer
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
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
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

On Fri, Aug 18, 2023 at 9:48=E2=80=AFPM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> On Fri, Aug 18, 2023 at 06:42:42PM +0800, Keguang Zhang wrote:
> > On Wed, Aug 16, 2023 at 8:54=E2=80=AFPM Serge Semin <fancer.lancer@gmai=
l.com> wrote:
> > >
> > > Hi Keguang
> > >
> > > On Sat, Aug 12, 2023 at 11:11:33PM +0800, Keguang Zhang wrote:
> > > > Add devicetree binding document for Loongson-1 DWMAC glue layer.
> > > >
> > > > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > > > ---
> > > >  .../bindings/net/loongson,ls1x-dwmac.yaml     | 98 +++++++++++++++=
++++
> > > >  .../devicetree/bindings/net/snps,dwmac.yaml   |  2 +
> > > >  2 files changed, 100 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/net/loongson,=
ls1x-dwmac.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/net/loongson,ls1x-dw=
mac.yaml b/Documentation/devicetree/bindings/net/loongson,ls1x-dwmac.yaml
> > > > new file mode 100644
> > > > index 000000000000..150799460599
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/net/loongson,ls1x-dwmac.yam=
l
> > > > @@ -0,0 +1,98 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/net/loongson,ls1x-dwmac.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > >
> > > > +title: Loongson-1 DWMAC glue layer
> > >
> > > DT-schemas describe a device. It has nothing to do with the glue
> > > driver/layer/whatever.
> > >
>
> > OK. But what about the MODULE_DESCRIPTION in dwmac-loongson1.c
> > MODULE_DESCRIPTION("Loongson1 DWMAC glue layer");
> > Should the two parts be aligned with each other?
>
> No they shouldn't. MODULE_DESCRIPTION() describes the driver module.
> "Loongson1 (G)MAC glue layer" is a correct description of the kernel
> driver module.
>
> > If not, what's your suggestion then?
>
> Something like "Loongson-1 Ethernet controller" or "Loongson-1 (G)MAC
> controller". A name which would refer to the device itself
> irrespective to the driver name, driver design, etc.
>
> * Note the already available DW (XG)MAC vendor-specific DT-bindings
> * referring to the glue layer/driver in the title property are wrong
> * in doing that.
>
> >
> > > Also I suggest to add a brief device description in the
> > > "description:" property and add there a brief info regarding the SoCs
> > > the controllers can be found on, the DW (G)MAC IP-core version the
> > > ethernet controllers are based on and if possible some data about the
> > > synthesize parameters: SMA (MDIO-bus), Tx/Rx COE, DMA FIFOs size,
> > > perfect and hash MAC-filters size, L3L4 frame filters availability,
> > > PHY interfaces (MII, RMII, RGMII, etc), EEE support, IEEE 1588(-2008)
> > > Timestamping support, PMT and Wake-up frame support, MAC Management
> > > counters (MMC).
> > >
> > > Note DMA FIFO sizes can be also constrained in the properties
> > > "rx-fifo-depth" and "tx-fifo-depth"; perfect and hash MAC-filter size=
s -
> > > in "snps,perfect-filter-entries" and "snps,multicast-filter-bins".
> > >
> > OK. The description could be added in next version.
> >
> > > > +
> > > > +maintainers:
> > > > +  - Keguang Zhang <keguang.zhang@gmail.com>
> > > > +
> > > > +select:
> > > > +  properties:
> > > > +    compatible:
> > > > +      contains:
> > > > +        enum:
> > > > +          - loongson,ls1b-dwmac
> > > > +          - loongson,ls1c-dwmac
> > > > +  required:
> > > > +    - compatible
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - enum:
>
> > > > +          - loongson,ls1b-dwmac
> > > > +          - loongson,ls1c-dwmac
>
> BTW referring to the DW IP-core in the compatible string isn't very
> much useful especially seeing you have a generic fallback compatible.
>
> The next names would be more descriptive:
> loongson,ls1b-gmac - seeing MAC supports 10/100/1000 speed modes
> loongson,ls1c-mac - seeing MAC support 10/100 speed modes only
>
>
> > > > +      - const: snps,dwmac-3.50a
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  clocks:
> > > > +    maxItems: 1
> > > > +
> > > > +  clock-names:
> > > > +    const: stmmaceth
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupt-names:
> > > > +    const: macirq
> > > > +
> > >
> > > > +  syscon:
> > > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > > +    description:
> > > > +      Phandle to the syscon containing some extra configurations
> > > > +      including PHY interface mode.
> > >
> > > I believe the property is supposed to have a vendor-specific name lik=
e
> > > "loongson,ls1-syscon" or similar.
> >
>
> > This has been fixed in v2.
>
> The name "loongson,dwmac-syscon" doesn't look correct because "dwmac-"
> prefix refer to some DWMAC system controller meanwhile the phandle
> passed to the device is a generic Loongson1 SoC system controller. So
> "loongson,ls1-syscon" looks more suitable.
>
Will do.

> > Could you please review v2?
> > Thanks!
>
> I'll have a look at v3 since v2 doesn't have my comments taken into
> account. BTW don't rush with resubmitting your series. Give it at
> least one week or so to hang out in the reviewers mail boxes as the
> Linux kernel patches review process suggests.
>
> > >
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - clocks
> > > > +  - clock-names
> > > > +  - interrupts
> > > > +  - interrupt-names
> > > > +  - phy-handle
> > >
> > > > +  - phy-mode
> > >
> > > You may want to specify the enum-constraints with the value permitted
> > > for the particular Loongson (G)MAC controller. Seeing ls1b and ls1c
> > > imply different sets of the PHY-modes the constraints are better to b=
e
> > > defined in the allOf sub-schemas. Alternatively you can split the
> > > DT-schema file into two: one for ls1b-dwmac, another one for
> > > ls1c-dwmac. IMO the later option seems better.
> > >
>
> > The "phy-mode", as pointed by Krzysztof, is defined in
> > ethernet-controller and already required by snps,dwmac.
> > So I have dropped it in v2.
>
> My point was in specifying a particular constraints on the "phy-mode"
> property. Krzysztof correctly suggested to drop the property from the
> "required" list since it's already required by the snps,dwmac.yaml
> schema. One doesn't contradict to another.
>
> > For allOf sub-schemas, do you mean something below?
> > allOf:
> >  - $ref: snps,dwmac.yaml#
> >
> >  - if:
> >      properties:
> >        compatible:
> >          contains:
> >            const: loongson,ls1b-dwmac
> >    then:
> >      properties:
> >        phy-mode:
> >          enum:
> >            - mii
> >            - rgmii
> >
> >  - if:
> >      properties:
> >        compatible:
> >          contains:
> >            const: loongson,ls1c-dwmac
> >    then:
> >      properties:
> >        phy-mode:
> >          enum:
> >            - mii
> >            - rmii
>
> Yes. But IMO in order to prevent having such complicated multi-level
> schemas you can just split up your bindings into two:
> loongson,ls1b-dwmac.yaml
> and
> loongson,ls1c-dwmac.yaml
>
> Thus you'll be able to have a device-specific generic "title" and
> "description" in each of them (especially seeing LS1-C MAC lacks of
> 1000Mbps mode support which you said you would add to the bindings
> description), simpler "compatible" and "phy-mode" property
> constraints.
>
OK. I will split this file into loongson,ls1b-gmac.yaml and
loongson,ls1c-mac.yaml.
Thanks for your review!



> -Serge(y)
>
> >
> > > -Serge(y)
> > >
> > > > +  - syscon
> > > > +
> > > > +allOf:
> > > > +  - $ref: snps,dwmac.yaml#
> > > > +
> > > > +unevaluatedProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/clock/loongson,ls1x-clk.h>
> > > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > > +
> > > > +    gmac0: ethernet@1fe10000 {
> > > > +        compatible =3D "loongson,ls1b-dwmac", "snps,dwmac-3.50a";
> > > > +        reg =3D <0x1fe10000 0x10000>;
> > > > +
> > > > +        clocks =3D <&clkc LS1X_CLKID_AHB>;
> > > > +        clock-names =3D "stmmaceth";
> > > > +
> > > > +        interrupt-parent =3D <&intc1>;
> > > > +        interrupts =3D <2 IRQ_TYPE_LEVEL_HIGH>;
> > > > +        interrupt-names =3D "macirq";
> > > > +
> > > > +        phy-handle =3D <&phy0>;
> > > > +        phy-mode =3D "mii";
> > > > +
> > > > +        snps,pbl =3D <1>;
> > > > +        syscon =3D <&syscon>;
> > > > +
> > > > +        mdio {
> > > > +            #address-cells =3D <1>;
> > > > +            #size-cells =3D <0>;
> > > > +            compatible =3D "snps,dwmac-mdio";
> > > > +
> > > > +            phy0: ethernet-phy@0 {
> > > > +                reg =3D <0x0>;
> > > > +            };
> > > > +        };
> > > > +    };
> > > > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml =
b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > > index ddf9522a5dc2..e1a956cf171e 100644
> > > > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > > @@ -66,6 +66,8 @@ properties:
> > > >          - ingenic,x2000-mac
> > > >          - loongson,ls2k-dwmac
> > > >          - loongson,ls7a-dwmac
> > > > +        - loongson,ls1b-dwmac
> > > > +        - loongson,ls1c-dwmac
> > > >          - qcom,qcs404-ethqos
> > > >          - qcom,sa8775p-ethqos
> > > >          - qcom,sc8280xp-ethqos
> > > > --
> > > > 2.39.2
> > > >
> >
> >
> >
> > --
> > Best regards,
> >
> > Keguang Zhang



--
Best regards,

Keguang Zhang
