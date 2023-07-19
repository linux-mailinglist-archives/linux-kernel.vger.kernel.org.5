Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3E375A0A7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 23:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjGSVhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 17:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjGSVhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:37:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2951FCD;
        Wed, 19 Jul 2023 14:37:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A80A96184D;
        Wed, 19 Jul 2023 21:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0A7C433CA;
        Wed, 19 Jul 2023 21:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689802663;
        bh=l31xmKKZKXpdELnjITMbNJIiJOmw33va5T4SCwmraDs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ehK5AhVFNt8CzbXFYdFHh5jzB81wh7yj1WYC+1x/CKL4LzcFjsShmKSk/jl9zejkw
         b6lfgY+/XxgPHGqavUtZ5PhvvN3AnagCd7A/AfZRs7trWOpFLVUa2oKSr6WbDrhUUf
         +FM5z3756FcjGhuMyU/sStaPvraEi3ZScmmx7aVyw//h9SiTW2w6EairnoLPkDn40T
         yv83I6obL4m0YOmV65Rhbf4SfA87hqGVcdg1grwCsrL04JN5qjckLKnmPqCWOP4OhO
         GNldWU2xI3qgihrhsaA933Dob/b9j5RzidJDRj71V/2+l80YRZjUaurjXwFxnzzGsd
         gdR7L2gtF4qkw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b743161832so1228221fa.1;
        Wed, 19 Jul 2023 14:37:42 -0700 (PDT)
X-Gm-Message-State: ABy/qLborZJI9hLeuGpByZcNMvpCTk5J+urv6+J4sD4hP9/8lC0ZZgWb
        +fh8hMGaM+cwUl5zASKfo0n3Yve+SL4YkucbNA==
X-Google-Smtp-Source: APBJJlEFlih0GsgJb5Kb1nv8BRzBOuXoE5Uxgako0V+TCO6aW6WabNUjR9BZ/pRBaaA+TCXjVBCw3zJAiM2xffQZrLs=
X-Received: by 2002:a2e:9c5a:0:b0:2b6:d0fc:ee18 with SMTP id
 t26-20020a2e9c5a000000b002b6d0fcee18mr790661ljj.19.1689802660935; Wed, 19 Jul
 2023 14:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <d62ceb33620cab766d809e6bbf30eaf5b46bc955.1689792825.git.tjeznach@rivosinc.com>
 <20230719-unnoticed-scion-744fdf509151@spud>
In-Reply-To: <20230719-unnoticed-scion-744fdf509151@spud>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 19 Jul 2023 15:37:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLsb801Z4H7+ViboBSGwd+XidcpYcJMHgw+6fofsXB=9Q@mail.gmail.com>
Message-ID: <CAL_JsqLsb801Z4H7+ViboBSGwd+XidcpYcJMHgw+6fofsXB=9Q@mail.gmail.com>
Subject: Re: [PATCH 03/11] dt-bindings: Add RISC-V IOMMU bindings
To:     Conor Dooley <conor@kernel.org>,
        Tomasz Jeznach <tjeznach@rivosinc.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
        linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
        iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 2:19=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> Hey Tomasz,
>
> On Wed, Jul 19, 2023 at 12:33:47PM -0700, Tomasz Jeznach wrote:
> > From: Anup Patel <apatel@ventanamicro.com>
> >
> > We add DT bindings document for RISC-V IOMMU platform and PCI devices
> > defined by the RISC-V IOMMU specification.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>
> Your signoff is missing from here.
>
> Secondly, as get_maintainer.pl would have told you, dt-bindings patches
> need to be sent to the dt-binding maintainers and list.
> +CC maintainers & list.
>
> Thirdly, dt-binding patches should come before their users.
>
> > ---
> >  .../bindings/iommu/riscv,iommu.yaml           | 146 ++++++++++++++++++
> >  1 file changed, 146 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu=
.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b=
/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > new file mode 100644
> > index 000000000000..8a9aedb61768
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > @@ -0,0 +1,146 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iommu/riscv,iommu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RISC-V IOMMU Implementation
> > +
> > +maintainers:
> > +  - Tomasz Jeznach <tjeznach@rivosinc.com>
>
> What about Anup, who seems to have written this?
> Or your co-authors of the drivers?
>
> > +
> > +description:
> > +  The RISC-V IOMMU specificaiton defines an IOMMU for RISC-V platforms

typo

> > +  which can be a regular platform device or a PCI device connected to
> > +  the host root port.
> > +
> > +  The RISC-V IOMMU provides two stage translation, device directory ta=
ble,
> > +  command queue and fault reporting as wired interrupt or MSIx event f=
or
> > +  both PCI and platform devices.

TBC, you want a PCI device that's an IOMMU and the IOMMU serves
(provides translation for) PCI devices?

> > +
> > +  Visit https://github.com/riscv-non-isa/riscv-iommu for more details.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - description: RISC-V IOMMU as a platform device

"platform device" is a Linux term. Don't use Linux terms in bindings.

> > +        items:
> > +          - enum:
> > +              - vendor,chip-iommu
>
> These dummy compatibles are not valid, as was pointed out to Anup on
> the AIA series. Please go look at what was done there instead:
> https://lore.kernel.org/all/20230719113542.2293295-7-apatel@ventanamicro.=
com/
>
> > +          - const: riscv,iommu
> > +
> > +      - description: RISC-V IOMMU as a PCI device connected to root po=
rt
> > +        items:
> > +          - enum:
> > +              - vendor,chip-pci-iommu
> > +          - const: riscv,pci-iommu
>
> I'm not really au fait with the arm smmu stuff, but do any of its
> versions support being connected to a root port?

PCI devices have a defined format for the compatible string based on
VID/PID. For PCI, also usually don't need to be described in DT
because they are discoverable. The exception is when there's parts
which aren't. Which parts aren't?

> > +  reg:
> > +    maxItems: 1
> > +    description:
> > +      For RISC-V IOMMU as a platform device, this represents the MMIO =
base
> > +      address of registers.
> > +
> > +      For RISC-V IOMMU as a PCI device, this represents the PCI-PCI br=
idge

Your IOMMU is also a PCI-PCI bridge? Is that a normal PCI thing?


> > +      details as described in Documentation/devicetree/bindings/pci/pc=
i.txt

Don't refer to pci.txt. It is going to be removed.

> > +
> > +  '#iommu-cells':
> > +    const: 2
> > +    description: |
>
> |s are only needed where formatting needs to be preserved.
>
> > +      Each IOMMU specifier represents the base device ID and number of
> > +      device IDs.

Doesn't that assume device IDs are contiguous? Generally not a safe assumpt=
ion.

> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 16
>
> What are any of these interrupts?
>
> > +    description:
> > +      The presence of this property implies that given RISC-V IOMMU us=
es
> > +      wired interrupts to notify the RISC-V HARTS (or CPUs).
> > +
> > +  msi-parent:
> > +    description:
> > +      The presence of this property implies that given RISC-V IOMMU us=
es
> > +      MSIx to notify the RISC-V HARTs (or CPUs). This property should =
be
> > +      considered only when the interrupts property is absent.

This doesn't make sense for a PCI device. PCI defines its own way to
describe MSI support.

> > +
> > +  dma-coherent:
>
> RISC-V is dma-coherent by default, should this not be dma-noncoherent
> instead?
>
> > +    description:
> > +      Present if page table walks and DMA accessed made by the RISC-V =
IOMMU
> > +      are cache coherent with the CPU.
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#iommu-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    /* Example 1 (IOMMU platform device with wired interrupts) */
> > +    immu1: iommu@1bccd000 {
>
> Why is this "immu"? typo or intentional?
>
> > +        compatible =3D "vendor,chip-iommu", "riscv,iommu";
> > +        reg =3D <0x1bccd000 0x1000>;
> > +        interrupt-parent =3D <&aplic_smode>;
> > +        interrupts =3D <32 4>, <33 4>, <34 4>, <35 4>;
> > +        #iommu-cells =3D <2>;
> > +    };
> > +
> > +    /* Device with two IOMMU device IDs, 0 and 7 */
> > +    master1 {
> > +        iommus =3D <&immu1 0 1>, <&immu1 7 1>;
> > +    };
> > +
> > +  - |
> > +    /* Example 2 (IOMMU platform device with MSIs) */
> > +    immu2: iommu@1bcdd000 {
> > +        compatible =3D "vendor,chip-iommu", "riscv,iommu";
> > +        reg =3D <0x1bccd000 0x1000>;
> > +        msi-parent =3D <&imsics_smode>;
> > +        #iommu-cells =3D <2>;
> > +    };
> > +
> > +    bus {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +
> > +        /* Device with IOMMU device IDs ranging from 32 to 64 */
> > +        master1 {
> > +                iommus =3D <&immu2 32 32>;
> > +        };
> > +
> > +        pcie@40000000 {
> > +            compatible =3D "pci-host-cam-generic";
> > +            device_type =3D "pci";
> > +            #address-cells =3D <3>;
> > +            #size-cells =3D <2>;
> > +            bus-range =3D <0x0 0x1>;
> > +
> > +            /* CPU_PHYSICAL(2)  SIZE(2) */

I'm guessing there was more after this, but I don't have it...

Guessing, immu2 is a PCI device, but it translates for master1 which
is not a PCI device? Weird. Why would anyone build such a thing?


Rob
