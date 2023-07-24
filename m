Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC5575F827
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjGXNYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjGXNYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:24:05 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225B6E65
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:23:58 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-785ccf19489so230145739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690205038; x=1690809838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2Ld8btTAGjqSvaVVGzkgPa6ahGfsdmbyS3Z1wPXSjI=;
        b=SbNzEoZiYLMLLMoE0dqviYJgHZ7OLelPBkfVWB9IGoUpaILC3GR5XEioFGZeYy1ELY
         gdLcnYbLYgx98YhKfVo1mXQArAbe8kXIufL0D8oqIhccbNvW4uFiF/QU5mb8JdsC3hr/
         0oWDiIqEGMbHoKnH3Ei8Jg7g9TBiK+m9DmKzgkXOf/Ois5bt8E/9K9kAENEBMCzU4v3m
         GDnJ9eErY7MsVRo3AuaD/mpGjcOSMI+T5nFNnJ0BoNVqoV26XC9ky6XFr/3P/+6uz+pY
         6K8Abc4ZRokkhklBZpNaNZa6YxJIeuo17INfR/3zuvQgwIduwZsq1Td5uMc+7zYnwGhS
         A/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690205038; x=1690809838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2Ld8btTAGjqSvaVVGzkgPa6ahGfsdmbyS3Z1wPXSjI=;
        b=bfIruQMf0Hi3XP69IjWlC8sTObYjdCcUO5Umc1TrOQNuvTt1uMHf91FxfN4KxZfOjA
         briNJY5nIKXll3MraBUYz9NZkEwp231RpqW5VKhEUOFjJ2Mz2QIFRaevGS0O+lN+anKp
         PrNHS/I1IrDew+FKchgLJr0l6xVFPr59DdtKLU2FGuJSOUqHbcbaHEQoDfpYU71sZtVd
         xrfirbO4fC7m13zAaJ7iASPPV47OggJZowSJuWgiWqcPT5I59zcm9qzGeuPqITq3qdPz
         yL99469vpryJAdBhzqQZeNABpF25pDz85ayo+gPX1jz48fNt2QJckxH1eYRWD2TiyIo0
         yVCQ==
X-Gm-Message-State: ABy/qLY0JETpliZfLmZdej7v4sDHXwqKdWD5Lfc346bIdKqmmJeDiREG
        kXdgPPFQd5wrbgITauOdaHcDwv45M1+ilnSYV/+9DA==
X-Google-Smtp-Source: APBJJlFc90JVKoy2UXuCfrGFA6GS4ztX/MGOXy0f+1gx/XNEgPv1ZpB3jBa/qI3zIRyOXlh1dETNq88aLH8L7qa2QGM=
X-Received: by 2002:a5e:8e06:0:b0:780:c787:637d with SMTP id
 a6-20020a5e8e06000000b00780c787637dmr6824489ion.17.1690205037787; Mon, 24 Jul
 2023 06:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <d62ceb33620cab766d809e6bbf30eaf5b46bc955.1689792825.git.tjeznach@rivosinc.com>
 <CANXhq0r=2eqpy9wLjVt1U0J7=LpnJLcKV7N9d90jvCss=7+Fzg@mail.gmail.com>
 <CAK9=C2Vg9eR5LJPeqDDQ0pHZcrT5DOUzA8_wYEVEjfnhb6s8pw@mail.gmail.com>
 <CANXhq0oTrU_-OQroW7H+hvxcU7YROhkgdCF9g_WtPTzVFQL7gA@mail.gmail.com> <CAK9=C2XoQjPzZ5yB5jfTbee4-Pb8GgFAZRbfcMwMk9pyo39WxQ@mail.gmail.com>
In-Reply-To: <CAK9=C2XoQjPzZ5yB5jfTbee4-Pb8GgFAZRbfcMwMk9pyo39WxQ@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 24 Jul 2023 21:23:46 +0800
Message-ID: <CANXhq0q7R9Srx6U=fReq7LDLFgW6rMmjKH=o6MzDT5AWNRXP6w@mail.gmail.com>
Subject: Re: [PATCH 03/11] dt-bindings: Add RISC-V IOMMU bindings
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Tomasz Jeznach <tjeznach@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
        linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
        iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 8:10=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> On Mon, Jul 24, 2023 at 5:01=E2=80=AFPM Zong Li <zong.li@sifive.com> wrot=
e:
> >
> > On Mon, Jul 24, 2023 at 6:02=E2=80=AFPM Anup Patel <apatel@ventanamicro=
.com> wrote:
> > >
> > > On Mon, Jul 24, 2023 at 1:33=E2=80=AFPM Zong Li <zong.li@sifive.com> =
wrote:
> > > >
> > > > On Thu, Jul 20, 2023 at 3:35=E2=80=AFAM Tomasz Jeznach <tjeznach@ri=
vosinc.com> wrote:
> > > > >
> > > > > From: Anup Patel <apatel@ventanamicro.com>
> > > > >
> > > > > We add DT bindings document for RISC-V IOMMU platform and PCI dev=
ices
> > > > > defined by the RISC-V IOMMU specification.
> > > > >
> > > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > > > ---
> > > > >  .../bindings/iommu/riscv,iommu.yaml           | 146 ++++++++++++=
++++++
> > > > >  1 file changed, 146 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/iommu/riscv=
,iommu.yaml
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.=
yaml b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..8a9aedb61768
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > > > > @@ -0,0 +1,146 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/iommu/riscv,iommu.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: RISC-V IOMMU Implementation
> > > > > +
> > > > > +maintainers:
> > > > > +  - Tomasz Jeznach <tjeznach@rivosinc.com>
> > > > > +
> > > > > +description:
> > > > > +  The RISC-V IOMMU specificaiton defines an IOMMU for RISC-V pla=
tforms
> > > > > +  which can be a regular platform device or a PCI device connect=
ed to
> > > > > +  the host root port.
> > > > > +
> > > > > +  The RISC-V IOMMU provides two stage translation, device direct=
ory table,
> > > > > +  command queue and fault reporting as wired interrupt or MSIx e=
vent for
> > > > > +  both PCI and platform devices.
> > > > > +
> > > > > +  Visit https://github.com/riscv-non-isa/riscv-iommu for more de=
tails.
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    oneOf:
> > > > > +      - description: RISC-V IOMMU as a platform device
> > > > > +        items:
> > > > > +          - enum:
> > > > > +              - vendor,chip-iommu
> > > > > +          - const: riscv,iommu
> > > > > +
> > > > > +      - description: RISC-V IOMMU as a PCI device connected to r=
oot port
> > > > > +        items:
> > > > > +          - enum:
> > > > > +              - vendor,chip-pci-iommu
> > > > > +          - const: riscv,pci-iommu
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +    description:
> > > > > +      For RISC-V IOMMU as a platform device, this represents the=
 MMIO base
> > > > > +      address of registers.
> > > > > +
> > > > > +      For RISC-V IOMMU as a PCI device, this represents the PCI-=
PCI bridge
> > > > > +      details as described in Documentation/devicetree/bindings/=
pci/pci.txt
> > > > > +
> > > > > +  '#iommu-cells':
> > > > > +    const: 2
> > > > > +    description: |
> > > > > +      Each IOMMU specifier represents the base device ID and num=
ber of
> > > > > +      device IDs.
> > > > > +
> > > > > +  interrupts:
> > > > > +    minItems: 1
> > > > > +    maxItems: 16
> > > > > +    description:
> > > > > +      The presence of this property implies that given RISC-V IO=
MMU uses
> > > > > +      wired interrupts to notify the RISC-V HARTS (or CPUs).
> > > > > +
> > > > > +  msi-parent:
> > > > > +    description:
> > > > > +      The presence of this property implies that given RISC-V IO=
MMU uses
> > > > > +      MSIx to notify the RISC-V HARTs (or CPUs). This property s=
hould be
> > > > > +      considered only when the interrupts property is absent.
> > > > > +
> > > > > +  dma-coherent:
> > > > > +    description:
> > > > > +      Present if page table walks and DMA accessed made by the R=
ISC-V IOMMU
> > > > > +      are cache coherent with the CPU.
> > > > > +
> > > > > +  power-domains:
> > > > > +    maxItems: 1
> > > > > +
> > > >
> > > > In RISC-V IOMMU, certain devices can be set to bypass mode when the
> > > > IOMMU is in translation mode. To identify the devices that require
> > > > bypass mode by default, does it be sensible to add a property to
> > > > indicate this behavior?
> > >
> > > Bypass mode for a device is a property of that device (similar to dma=
-coherent)
> > > and not of the IOMMU. Other architectures (ARM and x86) never added s=
uch
> > > a device property for bypass mode so I guess it is NOT ADVISABLE to d=
o it.
> > >
> > > If this is REALLY required then we can do something similar to the QC=
OM
> > > SMMU driver where they have a whitelist of devices which are allowed =
to
> > > be in bypass mode (i.e. IOMMU_DOMAIN_IDENTITY) based their device
> > > compatible string and any device outside this whitelist is blocked by=
 default.
> > >
> >
> > I have considered that adding the property of bypass mode to that
> > device would be more appropriate. However, if we want to define this
> > property for the device, it might need to go through the generic IOMMU
> > dt-bindings, but I'm not sure if other IOMMU devices need this. I am
> > bringing up this topic here because I would like to explore if there
> > are any solutions on the IOMMU side, such as a property that indicates
> > the phandle of devices wishing to set bypass mode, somewhat similar to
> > the whitelist you mentioned earlier. Do you think we should address
> > this? After all, this is a case of RISC-V IOMMU supported.
>
> Bypass mode is a common feature across IOMMUs. Other IOMMUs don't
> have a special property for bypass mode at device-level or at IOMMU level=
,
> which clearly indicates that defining a RISC-V specific property is not t=
he
> right way to go.
>
> The real question is how do we set IOMMU_DOMAIN_IDENTITY (i.e.
> bypass/identity domain) as the default domain for certain devices ?
>
> One possible option is to implement def_domain_type() IOMMU operation
> for RISC-V IOMMU which will return IOMMU_DOMAIN_IDENTITY for
> certain devices based on compatible string matching (i.e. whitelist of
> devices). As an example, refer qcom_smmu_def_domain_type()
> of drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>

That is indeed one way to approach it, and we can modify the
compatible string when we want to change the mode. However, it would
be preferable to explore a more flexible approach to achieve this
goal. By doing so, we can avoid hard coding anything in the driver or
having to rebuild the kernel  whenever we want to change the mode for
certain devices. While I have considered extending a cell in the
'iommus' property to indicate a device's desire to set bypass mode, it
doesn't comply with the iommu documentation and could lead to
ambiguous definitions.

If, at present, we are unable to find a suitable solution, perhaps
let's keep this topic in mind until we discover a more appropriate
approach. In the meantime, we can continue to explore other
possibilities to implement it. Thanks.

> Regards,
> Anup
>
>
>
>
>
> >
> > > Regards,
> > > Anup
> > >
> > > >
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - reg
> > > > > +  - '#iommu-cells'
> > > > > +
> > > > > +additionalProperties: false
> > > > > +
> > > > > +examples:
> > > > > +  - |
> > > > > +    /* Example 1 (IOMMU platform device with wired interrupts) *=
/
> > > > > +    immu1: iommu@1bccd000 {
> > > > > +        compatible =3D "vendor,chip-iommu", "riscv,iommu";
> > > > > +        reg =3D <0x1bccd000 0x1000>;
> > > > > +        interrupt-parent =3D <&aplic_smode>;
> > > > > +        interrupts =3D <32 4>, <33 4>, <34 4>, <35 4>;
> > > > > +        #iommu-cells =3D <2>;
> > > > > +    };
> > > > > +
> > > > > +    /* Device with two IOMMU device IDs, 0 and 7 */
> > > > > +    master1 {
> > > > > +        iommus =3D <&immu1 0 1>, <&immu1 7 1>;
> > > > > +    };
> > > > > +
> > > > > +  - |
> > > > > +    /* Example 2 (IOMMU platform device with MSIs) */
> > > > > +    immu2: iommu@1bcdd000 {
> > > > > +        compatible =3D "vendor,chip-iommu", "riscv,iommu";
> > > > > +        reg =3D <0x1bccd000 0x1000>;
> > > > > +        msi-parent =3D <&imsics_smode>;
> > > > > +        #iommu-cells =3D <2>;
> > > > > +    };
> > > > > +
> > > > > +    bus {
> > > > > +        #address-cells =3D <2>;
> > > > > +        #size-cells =3D <2>;
> > > > > +
> > > > > +        /* Device with IOMMU device IDs ranging from 32 to 64 */
> > > > > +        master1 {
> > > > > +                iommus =3D <&immu2 32 32>;
> > > > > +        };
> > > > > +
> > > > > +        pcie@40000000 {
> > > > > +            compatible =3D "pci-host-cam-generic";
> > > > > +            device_type =3D "pci";
> > > > > +            #address-cells =3D <3>;
> > > > > +            #size-cells =3D <2>;
> > > > > +            bus-range =3D <0x0 0x1>;
> > > > > +
> > > > > +            /* CPU_PHYSICAL(2)  SIZE(2) */
> > > > > +            reg =3D <0x0 0x40000000 0x0 0x1000000>;
> > > > > +
> > > > > +            /* BUS_ADDRESS(3)  CPU_PHYSICAL(2)  SIZE(2) */
> > > > > +            ranges =3D <0x01000000 0x0 0x01000000  0x0 0x0100000=
0  0x0 0x00010000>,
> > > > > +                     <0x02000000 0x0 0x41000000  0x0 0x41000000 =
 0x0 0x3f000000>;
> > > > > +
> > > > > +            #interrupt-cells =3D <0x1>;
> > > > > +
> > > > > +            /* PCI_DEVICE(3)  INT#(1)  CONTROLLER(PHANDLE)  CONT=
ROLLER_DATA(2) */
> > > > > +            interrupt-map =3D <   0x0 0x0 0x0  0x1  &aplic_smode=
  0x4 0x1>,
> > > > > +                            < 0x800 0x0 0x0  0x1  &aplic_smode  =
0x5 0x1>,
> > > > > +                            <0x1000 0x0 0x0  0x1  &aplic_smode  =
0x6 0x1>,
> > > > > +                            <0x1800 0x0 0x0  0x1  &aplic_smode  =
0x7 0x1>;
> > > > > +
> > > > > +            /* PCI_DEVICE(3)  INT#(1) */
> > > > > +            interrupt-map-mask =3D <0xf800 0x0 0x0  0x7>;
> > > > > +
> > > > > +            msi-parent =3D <&imsics_smode>;
> > > > > +
> > > > > +            /* Devices with bus number 0-127 are mastered via im=
mu2 */
> > > > > +            iommu-map =3D <0x0000 &immu2 0x0000 0x8000>;
> > > > > +        };
> > > > > +    };
> > > > > +...
> > > > > --
> > > > > 2.34.1
> > > > >
> > > > >
> > > > > _______________________________________________
> > > > > linux-riscv mailing list
> > > > > linux-riscv@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
