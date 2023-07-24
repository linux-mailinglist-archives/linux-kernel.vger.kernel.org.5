Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F59775F5B2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjGXMKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGXMK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:10:29 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809671A1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 05:10:27 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-77acb04309dso252378739f.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 05:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690200627; x=1690805427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fjh0h6en9trTPq3UL6xtT9eD9xJ+RZwfXGu7HnVOnQM=;
        b=fYpwhXgpj4aiqH/g8yiXHfVqiyT8cx/IiuHsRtC8KDhdP49xFR6I8sIPSLmkdbyjYW
         9Aga0bhsoBnNsDFcyMveR1f1GqvPZLfEVk8x8hn3k/c2eJJ4e5+G3QYLRRs51tPDO75w
         C38sUSOCVVvBdqUbk7lvQagQdXrXqKVt2rR2bHPU57UWAJFyWt9yY2TEQIgEltibT5Lt
         irKnxL2l6WdudyetcGF6vrnHZYW8fp1yBnx+DweHUsV1/CuKB2CoCxndOyM988esSk8+
         H/4wkbx0xbb/yMOKzeZQKLrOBd3lfZqNuW9W0pdWCXxfDNmn+4e0PDdmeUO59XSxt+Tp
         DbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690200627; x=1690805427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fjh0h6en9trTPq3UL6xtT9eD9xJ+RZwfXGu7HnVOnQM=;
        b=buvdBW2wpo3ly29cB+DYGQCK6I+8MWUF560CQj9SuZZplDP83ZJpK5U0q/Snk1H//R
         Hf5hKaZu+PJgy+k+C41lR+ZpMV23TBLayZoG6dDFQq1Euqw8YoX4OaVmNIjNrwnsdwKN
         Sbj+ot/qITc9Y64S8e8+l9wwrn6K3nus1hTeahMEO9VFEhValTs4VAXk7FS5McygJwTj
         vDAWvCoNvEuPWQRIprMGmlivjHcVPoDJmmCAyN+mIp4pUBEfb+7nqdUXsLUQAYHq1TXh
         /CqLBmJ0GA8ZMnp8yfYGDHGneFzCfJ6waVtaFNlm7eRUzUiOPN9EP+xFaj3Lo5FIpRtp
         h0Ig==
X-Gm-Message-State: ABy/qLb+BKw3bVd9FHgPXGv+PXm+8s0vBW/YbO9+35vM5vDIVv8IZpbd
        uHZpUztXzYk0hk8AxB4cPheBPJ2zLzDHDRMcI7ETUQ==
X-Google-Smtp-Source: APBJJlF8o/rjh4ZW0dGde/YzvOexkeJwSIOSwjwUwtG37ZHxfebzgyn5UwgFaoPaCG6u6O0ZqG5btw4EDIhAVhccHw8=
X-Received: by 2002:a05:6e02:1090:b0:348:8b32:7ca3 with SMTP id
 r16-20020a056e02109000b003488b327ca3mr8136105ilj.5.1690200626675; Mon, 24 Jul
 2023 05:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <d62ceb33620cab766d809e6bbf30eaf5b46bc955.1689792825.git.tjeznach@rivosinc.com>
 <CANXhq0r=2eqpy9wLjVt1U0J7=LpnJLcKV7N9d90jvCss=7+Fzg@mail.gmail.com>
 <CAK9=C2Vg9eR5LJPeqDDQ0pHZcrT5DOUzA8_wYEVEjfnhb6s8pw@mail.gmail.com> <CANXhq0oTrU_-OQroW7H+hvxcU7YROhkgdCF9g_WtPTzVFQL7gA@mail.gmail.com>
In-Reply-To: <CANXhq0oTrU_-OQroW7H+hvxcU7YROhkgdCF9g_WtPTzVFQL7gA@mail.gmail.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 24 Jul 2023 17:40:14 +0530
Message-ID: <CAK9=C2XoQjPzZ5yB5jfTbee4-Pb8GgFAZRbfcMwMk9pyo39WxQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] dt-bindings: Add RISC-V IOMMU bindings
To:     Zong Li <zong.li@sifive.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 5:01=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> On Mon, Jul 24, 2023 at 6:02=E2=80=AFPM Anup Patel <apatel@ventanamicro.c=
om> wrote:
> >
> > On Mon, Jul 24, 2023 at 1:33=E2=80=AFPM Zong Li <zong.li@sifive.com> wr=
ote:
> > >
> > > On Thu, Jul 20, 2023 at 3:35=E2=80=AFAM Tomasz Jeznach <tjeznach@rivo=
sinc.com> wrote:
> > > >
> > > > From: Anup Patel <apatel@ventanamicro.com>
> > > >
> > > > We add DT bindings document for RISC-V IOMMU platform and PCI devic=
es
> > > > defined by the RISC-V IOMMU specification.
> > > >
> > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > > ---
> > > >  .../bindings/iommu/riscv,iommu.yaml           | 146 ++++++++++++++=
++++
> > > >  1 file changed, 146 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/iommu/riscv,i=
ommu.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.ya=
ml b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > > > new file mode 100644
> > > > index 000000000000..8a9aedb61768
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > > > @@ -0,0 +1,146 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/iommu/riscv,iommu.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: RISC-V IOMMU Implementation
> > > > +
> > > > +maintainers:
> > > > +  - Tomasz Jeznach <tjeznach@rivosinc.com>
> > > > +
> > > > +description:
> > > > +  The RISC-V IOMMU specificaiton defines an IOMMU for RISC-V platf=
orms
> > > > +  which can be a regular platform device or a PCI device connected=
 to
> > > > +  the host root port.
> > > > +
> > > > +  The RISC-V IOMMU provides two stage translation, device director=
y table,
> > > > +  command queue and fault reporting as wired interrupt or MSIx eve=
nt for
> > > > +  both PCI and platform devices.
> > > > +
> > > > +  Visit https://github.com/riscv-non-isa/riscv-iommu for more deta=
ils.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    oneOf:
> > > > +      - description: RISC-V IOMMU as a platform device
> > > > +        items:
> > > > +          - enum:
> > > > +              - vendor,chip-iommu
> > > > +          - const: riscv,iommu
> > > > +
> > > > +      - description: RISC-V IOMMU as a PCI device connected to roo=
t port
> > > > +        items:
> > > > +          - enum:
> > > > +              - vendor,chip-pci-iommu
> > > > +          - const: riscv,pci-iommu
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +    description:
> > > > +      For RISC-V IOMMU as a platform device, this represents the M=
MIO base
> > > > +      address of registers.
> > > > +
> > > > +      For RISC-V IOMMU as a PCI device, this represents the PCI-PC=
I bridge
> > > > +      details as described in Documentation/devicetree/bindings/pc=
i/pci.txt
> > > > +
> > > > +  '#iommu-cells':
> > > > +    const: 2
> > > > +    description: |
> > > > +      Each IOMMU specifier represents the base device ID and numbe=
r of
> > > > +      device IDs.
> > > > +
> > > > +  interrupts:
> > > > +    minItems: 1
> > > > +    maxItems: 16
> > > > +    description:
> > > > +      The presence of this property implies that given RISC-V IOMM=
U uses
> > > > +      wired interrupts to notify the RISC-V HARTS (or CPUs).
> > > > +
> > > > +  msi-parent:
> > > > +    description:
> > > > +      The presence of this property implies that given RISC-V IOMM=
U uses
> > > > +      MSIx to notify the RISC-V HARTs (or CPUs). This property sho=
uld be
> > > > +      considered only when the interrupts property is absent.
> > > > +
> > > > +  dma-coherent:
> > > > +    description:
> > > > +      Present if page table walks and DMA accessed made by the RIS=
C-V IOMMU
> > > > +      are cache coherent with the CPU.
> > > > +
> > > > +  power-domains:
> > > > +    maxItems: 1
> > > > +
> > >
> > > In RISC-V IOMMU, certain devices can be set to bypass mode when the
> > > IOMMU is in translation mode. To identify the devices that require
> > > bypass mode by default, does it be sensible to add a property to
> > > indicate this behavior?
> >
> > Bypass mode for a device is a property of that device (similar to dma-c=
oherent)
> > and not of the IOMMU. Other architectures (ARM and x86) never added suc=
h
> > a device property for bypass mode so I guess it is NOT ADVISABLE to do =
it.
> >
> > If this is REALLY required then we can do something similar to the QCOM
> > SMMU driver where they have a whitelist of devices which are allowed to
> > be in bypass mode (i.e. IOMMU_DOMAIN_IDENTITY) based their device
> > compatible string and any device outside this whitelist is blocked by d=
efault.
> >
>
> I have considered that adding the property of bypass mode to that
> device would be more appropriate. However, if we want to define this
> property for the device, it might need to go through the generic IOMMU
> dt-bindings, but I'm not sure if other IOMMU devices need this. I am
> bringing up this topic here because I would like to explore if there
> are any solutions on the IOMMU side, such as a property that indicates
> the phandle of devices wishing to set bypass mode, somewhat similar to
> the whitelist you mentioned earlier. Do you think we should address
> this? After all, this is a case of RISC-V IOMMU supported.

Bypass mode is a common feature across IOMMUs. Other IOMMUs don't
have a special property for bypass mode at device-level or at IOMMU level,
which clearly indicates that defining a RISC-V specific property is not the
right way to go.

The real question is how do we set IOMMU_DOMAIN_IDENTITY (i.e.
bypass/identity domain) as the default domain for certain devices ?

One possible option is to implement def_domain_type() IOMMU operation
for RISC-V IOMMU which will return IOMMU_DOMAIN_IDENTITY for
certain devices based on compatible string matching (i.e. whitelist of
devices). As an example, refer qcom_smmu_def_domain_type()
of drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c

Regards,
Anup





>
> > Regards,
> > Anup
> >
> > >
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - '#iommu-cells'
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    /* Example 1 (IOMMU platform device with wired interrupts) */
> > > > +    immu1: iommu@1bccd000 {
> > > > +        compatible =3D "vendor,chip-iommu", "riscv,iommu";
> > > > +        reg =3D <0x1bccd000 0x1000>;
> > > > +        interrupt-parent =3D <&aplic_smode>;
> > > > +        interrupts =3D <32 4>, <33 4>, <34 4>, <35 4>;
> > > > +        #iommu-cells =3D <2>;
> > > > +    };
> > > > +
> > > > +    /* Device with two IOMMU device IDs, 0 and 7 */
> > > > +    master1 {
> > > > +        iommus =3D <&immu1 0 1>, <&immu1 7 1>;
> > > > +    };
> > > > +
> > > > +  - |
> > > > +    /* Example 2 (IOMMU platform device with MSIs) */
> > > > +    immu2: iommu@1bcdd000 {
> > > > +        compatible =3D "vendor,chip-iommu", "riscv,iommu";
> > > > +        reg =3D <0x1bccd000 0x1000>;
> > > > +        msi-parent =3D <&imsics_smode>;
> > > > +        #iommu-cells =3D <2>;
> > > > +    };
> > > > +
> > > > +    bus {
> > > > +        #address-cells =3D <2>;
> > > > +        #size-cells =3D <2>;
> > > > +
> > > > +        /* Device with IOMMU device IDs ranging from 32 to 64 */
> > > > +        master1 {
> > > > +                iommus =3D <&immu2 32 32>;
> > > > +        };
> > > > +
> > > > +        pcie@40000000 {
> > > > +            compatible =3D "pci-host-cam-generic";
> > > > +            device_type =3D "pci";
> > > > +            #address-cells =3D <3>;
> > > > +            #size-cells =3D <2>;
> > > > +            bus-range =3D <0x0 0x1>;
> > > > +
> > > > +            /* CPU_PHYSICAL(2)  SIZE(2) */
> > > > +            reg =3D <0x0 0x40000000 0x0 0x1000000>;
> > > > +
> > > > +            /* BUS_ADDRESS(3)  CPU_PHYSICAL(2)  SIZE(2) */
> > > > +            ranges =3D <0x01000000 0x0 0x01000000  0x0 0x01000000 =
 0x0 0x00010000>,
> > > > +                     <0x02000000 0x0 0x41000000  0x0 0x41000000  0=
x0 0x3f000000>;
> > > > +
> > > > +            #interrupt-cells =3D <0x1>;
> > > > +
> > > > +            /* PCI_DEVICE(3)  INT#(1)  CONTROLLER(PHANDLE)  CONTRO=
LLER_DATA(2) */
> > > > +            interrupt-map =3D <   0x0 0x0 0x0  0x1  &aplic_smode  =
0x4 0x1>,
> > > > +                            < 0x800 0x0 0x0  0x1  &aplic_smode  0x=
5 0x1>,
> > > > +                            <0x1000 0x0 0x0  0x1  &aplic_smode  0x=
6 0x1>,
> > > > +                            <0x1800 0x0 0x0  0x1  &aplic_smode  0x=
7 0x1>;
> > > > +
> > > > +            /* PCI_DEVICE(3)  INT#(1) */
> > > > +            interrupt-map-mask =3D <0xf800 0x0 0x0  0x7>;
> > > > +
> > > > +            msi-parent =3D <&imsics_smode>;
> > > > +
> > > > +            /* Devices with bus number 0-127 are mastered via immu=
2 */
> > > > +            iommu-map =3D <0x0000 &immu2 0x0000 0x8000>;
> > > > +        };
> > > > +    };
> > > > +...
> > > > --
> > > > 2.34.1
> > > >
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
