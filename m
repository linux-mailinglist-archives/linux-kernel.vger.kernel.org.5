Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D8B780A63
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358994AbjHRKnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358427AbjHRKnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:43:02 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E024512C;
        Fri, 18 Aug 2023 03:43:00 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe8c3b5ca0so1095484e87.1;
        Fri, 18 Aug 2023 03:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692355379; x=1692960179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmojBrhkjd/n3ZABKjh8jVqFFmKl05oPxBkFw3tuw2M=;
        b=WTK3ZwoTm92r5RsUNXAZ8viP2iNvWv7u3Xv+LTIF2AH3+UXC1Ta29pTmFotVdRuYnJ
         FU4DQePVhzf8GrENu5/hZvBaoUOC/lqI3IWDm3azpqHvif63MNksPiFyFUwGKm7H5VCl
         7A3S+1EDyUFvBl2YGpft/pZgbah8cKAvPMkzvY3RspvNJJD+/eSaYYtfVuYVF1DxRGAf
         LALN2s/wy2YQcVAWMgALYYkL9HYiGWHJ+PGzCjOLf7NqVh5q4t3mlY5SHuYHG5x/QkBH
         BQCeWrR72tAcV3mVrFIFTC4wkWxEBpreyk4vSaqH7Zgtwg9XnInvaJEKRDAZXdyxociK
         JvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692355379; x=1692960179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmojBrhkjd/n3ZABKjh8jVqFFmKl05oPxBkFw3tuw2M=;
        b=fzVg6L021C1zpeJR5LWHmDpMkwlFm3aRBWXYf66m0MecDmQa5AK96Vetnyu1eVZJyD
         OJR10PzZi0xUb280SdX61j37rTW3Dx0aGkFH2Jj93GyxauPdJ7IFtkQiEeEPXwYy6eIK
         ywkP5UubWSLI+96iH5j3Ty8hLDgstTyoPAkwRKXi+quS9HYp4YCVII7n1oV7zrEMID0B
         DAiZPyc/SxGR+TtFBbcpURumijby13AXRzDfSy65zhXBTAQLRn40pzHoPGHKkhEPPbES
         wcZ17aYFgh3HFpxA/8bk7RiIncHK7utdi6FW591e7njEJ0ROGDAzJPQHetPgerPPQGUs
         XvBg==
X-Gm-Message-State: AOJu0YzqqZ6EpPXBGiBoNoyxJ9cLZ/LkeUmPXhN9F73ZmRoXxPPdZ96b
        CbCZJjK9jEzDEOebKFiyMGZg1tVS4ZczSEAmzmI=
X-Google-Smtp-Source: AGHT+IFOm57VwaBrIJpj7TS7y6COoMgXNYSDbhXNO3d7922dFGXs0GQGrNjXeJyKNcuAwodKuMTsMW4596TYfSe88rc=
X-Received: by 2002:a19:6714:0:b0:4fe:5051:f253 with SMTP id
 b20-20020a196714000000b004fe5051f253mr1240003lfc.9.1692355378825; Fri, 18 Aug
 2023 03:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230812151135.1028780-1-keguang.zhang@gmail.com>
 <20230812151135.1028780-4-keguang.zhang@gmail.com> <thdwhlbs5salnufag24tqk4txqs3skidhq5nmzdeyxt3ni5pos@duj55rpqskl3>
In-Reply-To: <thdwhlbs5salnufag24tqk4txqs3skidhq5nmzdeyxt3ni5pos@duj55rpqskl3>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Fri, 18 Aug 2023 18:42:42 +0800
Message-ID: <CAJhJPsV9g2hSu4Ga8bH573JsJsrA_3dwi8T0oQBtq0FydHKrPg@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 8:54=E2=80=AFPM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> Hi Keguang
>
> On Sat, Aug 12, 2023 at 11:11:33PM +0800, Keguang Zhang wrote:
> > Add devicetree binding document for Loongson-1 DWMAC glue layer.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> >  .../bindings/net/loongson,ls1x-dwmac.yaml     | 98 +++++++++++++++++++
> >  .../devicetree/bindings/net/snps,dwmac.yaml   |  2 +
> >  2 files changed, 100 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1x=
-dwmac.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/net/loongson,ls1x-dwmac.=
yaml b/Documentation/devicetree/bindings/net/loongson,ls1x-dwmac.yaml
> > new file mode 100644
> > index 000000000000..150799460599
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/loongson,ls1x-dwmac.yaml
> > @@ -0,0 +1,98 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/loongson,ls1x-dwmac.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
>
> > +title: Loongson-1 DWMAC glue layer
>
> DT-schemas describe a device. It has nothing to do with the glue
> driver/layer/whatever.
>
OK. But what about the MODULE_DESCRIPTION in dwmac-loongson1.c
MODULE_DESCRIPTION("Loongson1 DWMAC glue layer");
Should the two parts be aligned with each other?
If not, what's your suggestion then?

> Also I suggest to add a brief device description in the
> "description:" property and add there a brief info regarding the SoCs
> the controllers can be found on, the DW (G)MAC IP-core version the
> ethernet controllers are based on and if possible some data about the
> synthesize parameters: SMA (MDIO-bus), Tx/Rx COE, DMA FIFOs size,
> perfect and hash MAC-filters size, L3L4 frame filters availability,
> PHY interfaces (MII, RMII, RGMII, etc), EEE support, IEEE 1588(-2008)
> Timestamping support, PMT and Wake-up frame support, MAC Management
> counters (MMC).
>
> Note DMA FIFO sizes can be also constrained in the properties
> "rx-fifo-depth" and "tx-fifo-depth"; perfect and hash MAC-filter sizes -
> in "snps,perfect-filter-entries" and "snps,multicast-filter-bins".
>
OK. The description could be added in next version.

> > +
> > +maintainers:
> > +  - Keguang Zhang <keguang.zhang@gmail.com>
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - loongson,ls1b-dwmac
> > +          - loongson,ls1c-dwmac
> > +  required:
> > +    - compatible
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - loongson,ls1b-dwmac
> > +          - loongson,ls1c-dwmac
> > +      - const: snps,dwmac-3.50a
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    const: stmmaceth
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-names:
> > +    const: macirq
> > +
>
> > +  syscon:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle to the syscon containing some extra configurations
> > +      including PHY interface mode.
>
> I believe the property is supposed to have a vendor-specific name like
> "loongson,ls1-syscon" or similar.

This has been fixed in v2.
Could you please review v2?
Thanks!
>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +  - interrupt-names
> > +  - phy-handle
>
> > +  - phy-mode
>
> You may want to specify the enum-constraints with the value permitted
> for the particular Loongson (G)MAC controller. Seeing ls1b and ls1c
> imply different sets of the PHY-modes the constraints are better to be
> defined in the allOf sub-schemas. Alternatively you can split the
> DT-schema file into two: one for ls1b-dwmac, another one for
> ls1c-dwmac. IMO the later option seems better.
>
The "phy-mode", as pointed by Krzysztof, is defined in
ethernet-controller and already required by snps,dwmac.
So I have dropped it in v2.
For allOf sub-schemas, do you mean something below?
allOf:
 - $ref: snps,dwmac.yaml#

 - if:
     properties:
       compatible:
         contains:
           const: loongson,ls1b-dwmac
   then:
     properties:
       phy-mode:
         enum:
           - mii
           - rgmii

 - if:
     properties:
       compatible:
         contains:
           const: loongson,ls1c-dwmac
   then:
     properties:
       phy-mode:
         enum:
           - mii
           - rmii

> -Serge(y)
>
> > +  - syscon
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
> > +        compatible =3D "loongson,ls1b-dwmac", "snps,dwmac-3.50a";
> > +        reg =3D <0x1fe10000 0x10000>;
> > +
> > +        clocks =3D <&clkc LS1X_CLKID_AHB>;
> > +        clock-names =3D "stmmaceth";
> > +
> > +        interrupt-parent =3D <&intc1>;
> > +        interrupts =3D <2 IRQ_TYPE_LEVEL_HIGH>;
> > +        interrupt-names =3D "macirq";
> > +
> > +        phy-handle =3D <&phy0>;
> > +        phy-mode =3D "mii";
> > +
> > +        snps,pbl =3D <1>;
> > +        syscon =3D <&syscon>;
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
> > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Do=
cumentation/devicetree/bindings/net/snps,dwmac.yaml
> > index ddf9522a5dc2..e1a956cf171e 100644
> > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > @@ -66,6 +66,8 @@ properties:
> >          - ingenic,x2000-mac
> >          - loongson,ls2k-dwmac
> >          - loongson,ls7a-dwmac
> > +        - loongson,ls1b-dwmac
> > +        - loongson,ls1c-dwmac
> >          - qcom,qcs404-ethqos
> >          - qcom,sa8775p-ethqos
> >          - qcom,sc8280xp-ethqos
> > --
> > 2.39.2
> >



--
Best regards,

Keguang Zhang
