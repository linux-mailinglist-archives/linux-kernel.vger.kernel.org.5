Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC26B7C7DD7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjJMGrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJMGrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:47:00 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24DFBC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:46:57 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3af5b5d7f16so1023542b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697179617; x=1697784417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAv9PsVdxpQ39eb66YGKg9NOnjKSeQxVJzuKdUvt8g0=;
        b=HdMQLLbSIMoicCfTeg4pAxxWkHko2eTKn+dqdCYi8fSEIw6JdDrO5HT3IDURrohzAs
         3hLNG11WPGRucjpWVSIO1SjWCqgDrCKvxGG42LYoFDr3Ux+O9YzbB23L/X1ji0w4PGiI
         RzwXiVuVSp3TBE2RACs4j9QJXGwro0S5nTMfZkHPHhTPExs2hClL976s+Cpohgn5uRAd
         qadC/iCn8392iZvreyLCUfbUGmF7PAeeoR7TDddAVmxu1Jlt+Kqum9XmO/zh9BtG0IXk
         23rCBH4gOGQs/0YN+Srs4cnDW2pR7CtdEfTPu57JcgwJGcCFoa5dzgPPjOqOUdp4QXp5
         3dwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697179617; x=1697784417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAv9PsVdxpQ39eb66YGKg9NOnjKSeQxVJzuKdUvt8g0=;
        b=leRKZskOBUCfGrXYcKAY9v9U0yydlBNet0NQhnNtpplkN7yhyBas2QhSOuGlKk1NOm
         pma4ZaC2yc5HtpsagjnnP52tOeqpUFxT9jkkKviZC11Tj2quARQSJ9a6DmlS+J/EbYi/
         GepBtCebX4SIdVeWbI6i8eGgUrTqQNXZKIFIponEdk7HkBIOAia5K8hJY+Z8j1K1o10I
         kGGhWxN1GNTxircz46kHiDmG5RlA76EXpvq1EuuDirpvzitTnHoAf81mKvQreLOGAvsS
         4r8a3U9Y8noJZXwzbA79vkSQ7GXB9KkvjI4DpRS16hGJ9Qm9HFI/+KxFThAbtzQR9u4G
         9R1A==
X-Gm-Message-State: AOJu0YzhElBg4rxvShoVbDXhjfK03YB4yRH/zTt9ORgFMwrGbTtWw7i7
        GWRU3SPFbTZHuNcggiQoICi7Q4VA0u1DDC1Ji8mOzQ==
X-Google-Smtp-Source: AGHT+IHvlhFetP1dLXJSaeAASQ1+0TblhiMmTGYHfkXU7fwztEdzGyQj8XdRw0QEmGOCm8yj/Vq8HKuwasAapN28CNA=
X-Received: by 2002:aca:240f:0:b0:3a7:330d:93da with SMTP id
 n15-20020aca240f000000b003a7330d93damr26242512oic.19.1697179616944; Thu, 12
 Oct 2023 23:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231003044403.1974628-1-apatel@ventanamicro.com>
 <20231003044403.1974628-8-apatel@ventanamicro.com> <20231012-countable-darkish-7e449edc763d@spud>
In-Reply-To: <20231012-countable-darkish-7e449edc763d@spud>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Fri, 13 Oct 2023 12:16:45 +0530
Message-ID: <CAK9=C2ViQj5iNBvQcMpYii2p+CrOiQ3hY8t5_U8mrJTcMVZCYw@mail.gmail.com>
Subject: Re: [PATCH v10 07/15] dt-bindings: interrupt-controller: Add RISC-V
 incoming MSI controller
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 10:05=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> Hey,
>
> On Tue, Oct 03, 2023 at 10:13:55AM +0530, Anup Patel wrote:
> > We add DT bindings document for the RISC-V incoming MSI controller
> > (IMSIC) defined by the RISC-V advanced interrupt architecture (AIA)
> > specification.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Just FYI, since they'll reply to this themselves, but some of the
> Microchip folks have run into problems with sparse hart indexes while
> trying to use the imsic binding to describe some configurations they
> have. I think there were also so problems with how to describe to a
> linux guest which file to use, when the first hart available to the
> guest does not use the first file. They'll do a better job of describing
> their problems than I will, so I shall leave it to them!

Quoting AIA spec:
"For the purpose of locating the memory pages of interrupt files in the
address space, assume each hart (or each hart within a group) has a
unique hart number that may or may not be related to the unique hart
identifiers (=E2=80=9Chart IDs=E2=80=9D) that the RISC-V Privileged Archite=
cture assigns
to harts."

It is very easy to get confused between the AIA "hart index" and
"hart IDs" defined by the RISC-V Privileged specification but these
are two very different things. The AIA "hart index" over here is the
bits in the address of an IMSIC file.

This DT binding follows the IMSIC file arrangement in the address
space as defined by the section "3.6 Arrangement of the memory
regions of multiple interrupt files" of the AIA specification. This
arrangement is MANDATORY for platforms having both APLIC
and IMSIC because in MSI-mode the APLIC generates target
MSI address based the IMSIC file arrangement described in the
section "3.6 Arrangement of the memory regions of multiple
interrupt files". In fact, this also applies to virtual platforms
created by hypervisors (KVM, Xen, ...)

Regards,
Anup


>
> Cheers,
> Conor.
>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  .../interrupt-controller/riscv,imsics.yaml    | 172 ++++++++++++++++++
> >  1 file changed, 172 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-control=
ler/riscv,imsics.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/ris=
cv,imsics.yaml b/Documentation/devicetree/bindings/interrupt-controller/ris=
cv,imsics.yaml
> > new file mode 100644
> > index 000000000000..84976f17a4a1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsi=
cs.yaml
> > @@ -0,0 +1,172 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/interrupt-controller/riscv,imsics.y=
aml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RISC-V Incoming MSI Controller (IMSIC)
> > +
> > +maintainers:
> > +  - Anup Patel <anup@brainfault.org>
> > +
> > +description: |
> > +  The RISC-V advanced interrupt architecture (AIA) defines a per-CPU i=
ncoming
> > +  MSI controller (IMSIC) for handling MSIs in a RISC-V platform. The R=
ISC-V
> > +  AIA specification can be found at https://github.com/riscv/riscv-aia=
.
> > +
> > +  The IMSIC is a per-CPU (or per-HART) device with separate interrupt =
file
> > +  for each privilege level (machine or supervisor). The configuration =
of
> > +  a IMSIC interrupt file is done using AIA CSRs and it also has a 4KB =
MMIO
> > +  space to receive MSIs from devices. Each IMSIC interrupt file suppor=
ts a
> > +  fixed number of interrupt identities (to distinguish MSIs from devic=
es)
> > +  which is same for given privilege level across CPUs (or HARTs).
> > +
> > +  The device tree of a RISC-V platform will have one IMSIC device tree=
 node
> > +  for each privilege level (machine or supervisor) which collectively =
describe
> > +  IMSIC interrupt files at that privilege level across CPUs (or HARTs)=
.
> > +
> > +  The arrangement of IMSIC interrupt files in MMIO space of a RISC-V p=
latform
> > +  follows a particular scheme defined by the RISC-V AIA specification.=
 A IMSIC
> > +  group is a set of IMSIC interrupt files co-located in MMIO space and=
 we can
> > +  have multiple IMSIC groups (i.e. clusters, sockets, chiplets, etc) i=
n a
> > +  RISC-V platform. The MSI target address of a IMSIC interrupt file at=
 given
> > +  privilege level (machine or supervisor) encodes group index, HART in=
dex,
> > +  and guest index (shown below).
> > +
> > +  XLEN-1            > (HART Index MSB)                  12    0
> > +  |                  |                                  |     |
> > +  -------------------------------------------------------------
> > +  |xxxxxx|Group Index|xxxxxxxxxxx|HART Index|Guest Index|  0  |
> > +  -------------------------------------------------------------
> > +
> > +allOf:
> > +  - $ref: /schemas/interrupt-controller.yaml#
> > +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - qemu,imsics
> > +      - const: riscv,imsics
> > +
> > +  reg:
> > +    minItems: 1
> > +    maxItems: 16384
> > +    description:
> > +      Base address of each IMSIC group.
> > +
> > +  interrupt-controller: true
> > +
> > +  "#interrupt-cells":
> > +    const: 0
> > +
> > +  msi-controller: true
> > +
> > +  "#msi-cells":
> > +    const: 0
> > +
> > +  interrupts-extended:
> > +    minItems: 1
> > +    maxItems: 16384
> > +    description:
> > +      This property represents the set of CPUs (or HARTs) for which gi=
ven
> > +      device tree node describes the IMSIC interrupt files. Each node =
pointed
> > +      to should be a riscv,cpu-intc node, which has a CPU node (i.e. R=
ISC-V
> > +      HART) as parent.
> > +
> > +  riscv,num-ids:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 63
> > +    maximum: 2047
> > +    description:
> > +      Number of interrupt identities supported by IMSIC interrupt file=
.
> > +
> > +  riscv,num-guest-ids:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 63
> > +    maximum: 2047
> > +    description:
> > +      Number of interrupt identities are supported by IMSIC guest inte=
rrupt
> > +      file. When not specified it is assumed to be same as specified b=
y the
> > +      riscv,num-ids property.
> > +
> > +  riscv,guest-index-bits:
> > +    minimum: 0
> > +    maximum: 7
> > +    default: 0
> > +    description:
> > +      Number of guest index bits in the MSI target address.
> > +
> > +  riscv,hart-index-bits:
> > +    minimum: 0
> > +    maximum: 15
> > +    description:
> > +      Number of HART index bits in the MSI target address. When not
> > +      specified it is calculated based on the interrupts-extended prop=
erty.
> > +
> > +  riscv,group-index-bits:
> > +    minimum: 0
> > +    maximum: 7
> > +    default: 0
> > +    description:
> > +      Number of group index bits in the MSI target address.
> > +
> > +  riscv,group-index-shift:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 55
> > +    default: 24
> > +    description:
> > +      The least significant bit position of the group index bits in th=
e
> > +      MSI target address.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupt-controller
> > +  - msi-controller
> > +  - "#msi-cells"
> > +  - interrupts-extended
> > +  - riscv,num-ids
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    // Example 1 (Machine-level IMSIC files with just one group):
> > +
> > +    interrupt-controller@24000000 {
> > +      compatible =3D "qemu,imsics", "riscv,imsics";
> > +      interrupts-extended =3D <&cpu1_intc 11>,
> > +                            <&cpu2_intc 11>,
> > +                            <&cpu3_intc 11>,
> > +                            <&cpu4_intc 11>;
> > +      reg =3D <0x28000000 0x4000>;
> > +      interrupt-controller;
> > +      #interrupt-cells =3D <0>;
> > +      msi-controller;
> > +      #msi-cells =3D <0>;
> > +      riscv,num-ids =3D <127>;
> > +    };
> > +
> > +  - |
> > +    // Example 2 (Supervisor-level IMSIC files with two groups):
> > +
> > +    interrupt-controller@28000000 {
> > +      compatible =3D "qemu,imsics", "riscv,imsics";
> > +      interrupts-extended =3D <&cpu1_intc 9>,
> > +                            <&cpu2_intc 9>,
> > +                            <&cpu3_intc 9>,
> > +                            <&cpu4_intc 9>;
> > +      reg =3D <0x28000000 0x2000>, /* Group0 IMSICs */
> > +            <0x29000000 0x2000>; /* Group1 IMSICs */
> > +      interrupt-controller;
> > +      #interrupt-cells =3D <0>;
> > +      msi-controller;
> > +      #msi-cells =3D <0>;
> > +      riscv,num-ids =3D <127>;
> > +      riscv,group-index-bits =3D <1>;
> > +      riscv,group-index-shift =3D <24>;
> > +    };
> > +...
> > --
> > 2.34.1
> >
