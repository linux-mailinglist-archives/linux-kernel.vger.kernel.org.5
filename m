Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04FE75F522
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGXLck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjGXLc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:32:29 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4D61BC0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 04:32:00 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7836272f36eso156583239f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 04:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690198314; x=1690803114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSZt7mHez9tNJy/98/Qfr0OOVK6jV7kKAFtTUhVHj+4=;
        b=Zu3QSNlWTHcd8OApwq0U+bD1SZkTRkdgFVizZQ0Kx7en8kEJKrVeVocSG+Chv6CbDP
         8nJtj3qZsoyDChCMF0DmJt+9YtpDu01OVSusMX7q1fmFDHxXKGJHDUXT48KQnY/TCtTY
         Ca4tZz8IH40wQVfKABxCYjCdDP7vUQYkYJOd7Yf3WR6gZXyp2TUWTTa0LsG27VSBw3R2
         r7jG9Qg1XyuTpO0sUi1Wh1+fPVhFZ3yF82QJ+Ou5dSdQIMJA1iqQvaZXvmw88x3vkHvl
         UyLDohMJw2aqsCJU6kE0hyYX+REUCLzbiWUui1gaA2l+B1Cl80IYVjKJFyIGGaPsc+ep
         oupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690198314; x=1690803114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSZt7mHez9tNJy/98/Qfr0OOVK6jV7kKAFtTUhVHj+4=;
        b=IbfNnqt9Dr/+nYRzgnawnUi8ubiInR7fQ2+2wU2P94402Ohap7npq+77i535q7iNcM
         2bcwexsuJ2H6uEBQ8BLLQDgLogOhxPczl4J0Qlq4eLJfw8baHEp8XO++KurnbShT26tf
         h8a8zduaBb4pUehpyYmnKxuU0IcigX51wv7V6h69h0DOm6uE9B+fvD+f0ma6X35T0NLJ
         JDaCvNokERgzkG5ONlQin7B55O2IpSs56bKXg0GEh/OAM3lItze+SmG60x/Ul813/3O/
         mfxaikI5/auk3vwaz8IIcMlJ8yjbo4DEb4be7u1I3LoPSYN2nE29IzNhpeCXn7dlYpTn
         RaRg==
X-Gm-Message-State: ABy/qLaMqv6qzJkYs9hsu+qPjcmT37FITuM+9cMy6lybcbhRsSvpiOk2
        URFbD+KM/jITEqcV0FAr9gk0h4FeDmw+1M30fXfL9w==
X-Google-Smtp-Source: APBJJlGHxOZ/paRjIch74XqvwUxQz0xz3MZH+VtCE2KMsEa3zvL3fC42DqgKEx4uhzMK7nJeCic/WBnYFQ/RxL330dA=
X-Received: by 2002:a6b:7f0a:0:b0:76c:8877:861d with SMTP id
 l10-20020a6b7f0a000000b0076c8877861dmr7363380ioq.1.1690198313863; Mon, 24 Jul
 2023 04:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <d62ceb33620cab766d809e6bbf30eaf5b46bc955.1689792825.git.tjeznach@rivosinc.com>
 <CANXhq0r=2eqpy9wLjVt1U0J7=LpnJLcKV7N9d90jvCss=7+Fzg@mail.gmail.com> <CAK9=C2Vg9eR5LJPeqDDQ0pHZcrT5DOUzA8_wYEVEjfnhb6s8pw@mail.gmail.com>
In-Reply-To: <CAK9=C2Vg9eR5LJPeqDDQ0pHZcrT5DOUzA8_wYEVEjfnhb6s8pw@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 24 Jul 2023 19:31:42 +0800
Message-ID: <CANXhq0oTrU_-OQroW7H+hvxcU7YROhkgdCF9g_WtPTzVFQL7gA@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 6:02=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> On Mon, Jul 24, 2023 at 1:33=E2=80=AFPM Zong Li <zong.li@sifive.com> wrot=
e:
> >
> > On Thu, Jul 20, 2023 at 3:35=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosi=
nc.com> wrote:
> > >
> > > From: Anup Patel <apatel@ventanamicro.com>
> > >
> > > We add DT bindings document for RISC-V IOMMU platform and PCI devices
> > > defined by the RISC-V IOMMU specification.
> > >
> > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > ---
> > >  .../bindings/iommu/riscv,iommu.yaml           | 146 ++++++++++++++++=
++
> > >  1 file changed, 146 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iom=
mu.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml=
 b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > > new file mode 100644
> > > index 000000000000..8a9aedb61768
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > > @@ -0,0 +1,146 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iommu/riscv,iommu.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: RISC-V IOMMU Implementation
> > > +
> > > +maintainers:
> > > +  - Tomasz Jeznach <tjeznach@rivosinc.com>
> > > +
> > > +description:
> > > +  The RISC-V IOMMU specificaiton defines an IOMMU for RISC-V platfor=
ms
> > > +  which can be a regular platform device or a PCI device connected t=
o
> > > +  the host root port.
> > > +
> > > +  The RISC-V IOMMU provides two stage translation, device directory =
table,
> > > +  command queue and fault reporting as wired interrupt or MSIx event=
 for
> > > +  both PCI and platform devices.
> > > +
> > > +  Visit https://github.com/riscv-non-isa/riscv-iommu for more detail=
s.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - description: RISC-V IOMMU as a platform device
> > > +        items:
> > > +          - enum:
> > > +              - vendor,chip-iommu
> > > +          - const: riscv,iommu
> > > +
> > > +      - description: RISC-V IOMMU as a PCI device connected to root =
port
> > > +        items:
> > > +          - enum:
> > > +              - vendor,chip-pci-iommu
> > > +          - const: riscv,pci-iommu
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +    description:
> > > +      For RISC-V IOMMU as a platform device, this represents the MMI=
O base
> > > +      address of registers.
> > > +
> > > +      For RISC-V IOMMU as a PCI device, this represents the PCI-PCI =
bridge
> > > +      details as described in Documentation/devicetree/bindings/pci/=
pci.txt
> > > +
> > > +  '#iommu-cells':
> > > +    const: 2
> > > +    description: |
> > > +      Each IOMMU specifier represents the base device ID and number =
of
> > > +      device IDs.
> > > +
> > > +  interrupts:
> > > +    minItems: 1
> > > +    maxItems: 16
> > > +    description:
> > > +      The presence of this property implies that given RISC-V IOMMU =
uses
> > > +      wired interrupts to notify the RISC-V HARTS (or CPUs).
> > > +
> > > +  msi-parent:
> > > +    description:
> > > +      The presence of this property implies that given RISC-V IOMMU =
uses
> > > +      MSIx to notify the RISC-V HARTs (or CPUs). This property shoul=
d be
> > > +      considered only when the interrupts property is absent.
> > > +
> > > +  dma-coherent:
> > > +    description:
> > > +      Present if page table walks and DMA accessed made by the RISC-=
V IOMMU
> > > +      are cache coherent with the CPU.
> > > +
> > > +  power-domains:
> > > +    maxItems: 1
> > > +
> >
> > In RISC-V IOMMU, certain devices can be set to bypass mode when the
> > IOMMU is in translation mode. To identify the devices that require
> > bypass mode by default, does it be sensible to add a property to
> > indicate this behavior?
>
> Bypass mode for a device is a property of that device (similar to dma-coh=
erent)
> and not of the IOMMU. Other architectures (ARM and x86) never added such
> a device property for bypass mode so I guess it is NOT ADVISABLE to do it=
.
>
> If this is REALLY required then we can do something similar to the QCOM
> SMMU driver where they have a whitelist of devices which are allowed to
> be in bypass mode (i.e. IOMMU_DOMAIN_IDENTITY) based their device
> compatible string and any device outside this whitelist is blocked by def=
ault.
>

I have considered that adding the property of bypass mode to that
device would be more appropriate. However, if we want to define this
property for the device, it might need to go through the generic IOMMU
dt-bindings, but I'm not sure if other IOMMU devices need this. I am
bringing up this topic here because I would like to explore if there
are any solutions on the IOMMU side, such as a property that indicates
the phandle of devices wishing to set bypass mode, somewhat similar to
the whitelist you mentioned earlier. Do you think we should address
this? After all, this is a case of RISC-V IOMMU supported.

> Regards,
> Anup
>
> >
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - '#iommu-cells'
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    /* Example 1 (IOMMU platform device with wired interrupts) */
> > > +    immu1: iommu@1bccd000 {
> > > +        compatible =3D "vendor,chip-iommu", "riscv,iommu";
> > > +        reg =3D <0x1bccd000 0x1000>;
> > > +        interrupt-parent =3D <&aplic_smode>;
> > > +        interrupts =3D <32 4>, <33 4>, <34 4>, <35 4>;
> > > +        #iommu-cells =3D <2>;
> > > +    };
> > > +
> > > +    /* Device with two IOMMU device IDs, 0 and 7 */
> > > +    master1 {
> > > +        iommus =3D <&immu1 0 1>, <&immu1 7 1>;
> > > +    };
> > > +
> > > +  - |
> > > +    /* Example 2 (IOMMU platform device with MSIs) */
> > > +    immu2: iommu@1bcdd000 {
> > > +        compatible =3D "vendor,chip-iommu", "riscv,iommu";
> > > +        reg =3D <0x1bccd000 0x1000>;
> > > +        msi-parent =3D <&imsics_smode>;
> > > +        #iommu-cells =3D <2>;
> > > +    };
> > > +
> > > +    bus {
> > > +        #address-cells =3D <2>;
> > > +        #size-cells =3D <2>;
> > > +
> > > +        /* Device with IOMMU device IDs ranging from 32 to 64 */
> > > +        master1 {
> > > +                iommus =3D <&immu2 32 32>;
> > > +        };
> > > +
> > > +        pcie@40000000 {
> > > +            compatible =3D "pci-host-cam-generic";
> > > +            device_type =3D "pci";
> > > +            #address-cells =3D <3>;
> > > +            #size-cells =3D <2>;
> > > +            bus-range =3D <0x0 0x1>;
> > > +
> > > +            /* CPU_PHYSICAL(2)  SIZE(2) */
> > > +            reg =3D <0x0 0x40000000 0x0 0x1000000>;
> > > +
> > > +            /* BUS_ADDRESS(3)  CPU_PHYSICAL(2)  SIZE(2) */
> > > +            ranges =3D <0x01000000 0x0 0x01000000  0x0 0x01000000  0=
x0 0x00010000>,
> > > +                     <0x02000000 0x0 0x41000000  0x0 0x41000000  0x0=
 0x3f000000>;
> > > +
> > > +            #interrupt-cells =3D <0x1>;
> > > +
> > > +            /* PCI_DEVICE(3)  INT#(1)  CONTROLLER(PHANDLE)  CONTROLL=
ER_DATA(2) */
> > > +            interrupt-map =3D <   0x0 0x0 0x0  0x1  &aplic_smode  0x=
4 0x1>,
> > > +                            < 0x800 0x0 0x0  0x1  &aplic_smode  0x5 =
0x1>,
> > > +                            <0x1000 0x0 0x0  0x1  &aplic_smode  0x6 =
0x1>,
> > > +                            <0x1800 0x0 0x0  0x1  &aplic_smode  0x7 =
0x1>;
> > > +
> > > +            /* PCI_DEVICE(3)  INT#(1) */
> > > +            interrupt-map-mask =3D <0xf800 0x0 0x0  0x7>;
> > > +
> > > +            msi-parent =3D <&imsics_smode>;
> > > +
> > > +            /* Devices with bus number 0-127 are mastered via immu2 =
*/
> > > +            iommu-map =3D <0x0000 &immu2 0x0000 0x8000>;
> > > +        };
> > > +    };
> > > +...
> > > --
> > > 2.34.1
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
