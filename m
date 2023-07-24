Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480E875ED0B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGXIDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjGXIDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:03:38 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7D5B3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:03:35 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-785cbc5bfd2so217107939f.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690185814; x=1690790614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDV1hO4yFDLFQD8uasv873PhbxS0N3VZ/OX9F2C97xE=;
        b=kcZ/Xod4BzTW0MG7FTCv4BsGhRO0EY13L1SGLkXlNt++FjfUgnptMOK98Nt+bdE072
         sYB1DkMHLgW8rzlfvXirbjMZY5yluG85dUBipqsVPGhrjuKoKxgcdN8m0D8ElL12PDb+
         ofH9ZRqXBW0P7iN1Fpn9iGLCF+k7aOgByeSsaYU2z8Di3UiHHnvt3DZNJMBe0a8DRf0U
         wtGNC1We+iy9SasKNNbu9e6dgIK4jp/kU8wzFO2C7fkFxwdsygggcEOZ3FQFZD5LF/ra
         kWy7jx5y1OlndlBhWYEp7cg50Xys9sBSd99XtLDTY9h1j5s+NZfHWCH/frJo7TxL6mW1
         9lrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690185814; x=1690790614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDV1hO4yFDLFQD8uasv873PhbxS0N3VZ/OX9F2C97xE=;
        b=ToeT43F6biX/1G7Ln/r/tLyOX2Y6YxnTHdvLIa3/INXHq7tY2X4Mq2pgIioxEPA0fv
         iHdUDdByve+wq9jQE2668plZ8RsrU82mBsC91iGiZTpnop8HjdsLbelrXyIZDqxcfyQx
         pGWCQxR7Ej9jHbDC3XwmcPlbqxPOAd/scEZkxCcPbYmCA7fZcotq+9mbf92IJfpkl5dA
         DfzWeEinreSt9SipaHJ06eJDmYq9FMR9BsWzmW15sFf96PO7dvKuoZmHowZ1Lh00GBfx
         RblqzwR574je7mO/W+IGxhGM0ObPLqhhBFtnddGgmIzJay0g4/MUve2yFtbGfu2+y1/T
         HC9g==
X-Gm-Message-State: ABy/qLazH1EwKzW5FFt/0jA8WSqwORhM3+trjJDXogV2DKEgELAgdWtm
        924a2t7bVTbj/95HXebx4mLFAjPL7LnP+b7dDy7gqA==
X-Google-Smtp-Source: APBJJlGStZ0elL9HH6PKyspeFwsjUt4L8Rdan0uM9spSXhs7URXUU9N/7aON4Qpj5WW46YVinyaPfPJS/Cejo/4LOyM=
X-Received: by 2002:a6b:da19:0:b0:783:4bc6:636e with SMTP id
 x25-20020a6bda19000000b007834bc6636emr5469762iob.21.1690185814397; Mon, 24
 Jul 2023 01:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <d62ceb33620cab766d809e6bbf30eaf5b46bc955.1689792825.git.tjeznach@rivosinc.com>
In-Reply-To: <d62ceb33620cab766d809e6bbf30eaf5b46bc955.1689792825.git.tjeznach@rivosinc.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 24 Jul 2023 16:03:23 +0800
Message-ID: <CANXhq0r=2eqpy9wLjVt1U0J7=LpnJLcKV7N9d90jvCss=7+Fzg@mail.gmail.com>
Subject: Re: [PATCH 03/11] dt-bindings: Add RISC-V IOMMU bindings
To:     Tomasz Jeznach <tjeznach@rivosinc.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
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

On Thu, Jul 20, 2023 at 3:35=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc.c=
om> wrote:
>
> From: Anup Patel <apatel@ventanamicro.com>
>
> We add DT bindings document for RISC-V IOMMU platform and PCI devices
> defined by the RISC-V IOMMU specification.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../bindings/iommu/riscv,iommu.yaml           | 146 ++++++++++++++++++
>  1 file changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.y=
aml
>
> diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b/D=
ocumentation/devicetree/bindings/iommu/riscv,iommu.yaml
> new file mode 100644
> index 000000000000..8a9aedb61768
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> @@ -0,0 +1,146 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/riscv,iommu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V IOMMU Implementation
> +
> +maintainers:
> +  - Tomasz Jeznach <tjeznach@rivosinc.com>
> +
> +description:
> +  The RISC-V IOMMU specificaiton defines an IOMMU for RISC-V platforms
> +  which can be a regular platform device or a PCI device connected to
> +  the host root port.
> +
> +  The RISC-V IOMMU provides two stage translation, device directory tabl=
e,
> +  command queue and fault reporting as wired interrupt or MSIx event for
> +  both PCI and platform devices.
> +
> +  Visit https://github.com/riscv-non-isa/riscv-iommu for more details.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: RISC-V IOMMU as a platform device
> +        items:
> +          - enum:
> +              - vendor,chip-iommu
> +          - const: riscv,iommu
> +
> +      - description: RISC-V IOMMU as a PCI device connected to root port
> +        items:
> +          - enum:
> +              - vendor,chip-pci-iommu
> +          - const: riscv,pci-iommu
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      For RISC-V IOMMU as a platform device, this represents the MMIO ba=
se
> +      address of registers.
> +
> +      For RISC-V IOMMU as a PCI device, this represents the PCI-PCI brid=
ge
> +      details as described in Documentation/devicetree/bindings/pci/pci.=
txt
> +
> +  '#iommu-cells':
> +    const: 2
> +    description: |
> +      Each IOMMU specifier represents the base device ID and number of
> +      device IDs.
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 16
> +    description:
> +      The presence of this property implies that given RISC-V IOMMU uses
> +      wired interrupts to notify the RISC-V HARTS (or CPUs).
> +
> +  msi-parent:
> +    description:
> +      The presence of this property implies that given RISC-V IOMMU uses
> +      MSIx to notify the RISC-V HARTs (or CPUs). This property should be
> +      considered only when the interrupts property is absent.
> +
> +  dma-coherent:
> +    description:
> +      Present if page table walks and DMA accessed made by the RISC-V IO=
MMU
> +      are cache coherent with the CPU.
> +
> +  power-domains:
> +    maxItems: 1
> +

In RISC-V IOMMU, certain devices can be set to bypass mode when the
IOMMU is in translation mode. To identify the devices that require
bypass mode by default, does it be sensible to add a property to
indicate this behavior?

> +required:
> +  - compatible
> +  - reg
> +  - '#iommu-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    /* Example 1 (IOMMU platform device with wired interrupts) */
> +    immu1: iommu@1bccd000 {
> +        compatible =3D "vendor,chip-iommu", "riscv,iommu";
> +        reg =3D <0x1bccd000 0x1000>;
> +        interrupt-parent =3D <&aplic_smode>;
> +        interrupts =3D <32 4>, <33 4>, <34 4>, <35 4>;
> +        #iommu-cells =3D <2>;
> +    };
> +
> +    /* Device with two IOMMU device IDs, 0 and 7 */
> +    master1 {
> +        iommus =3D <&immu1 0 1>, <&immu1 7 1>;
> +    };
> +
> +  - |
> +    /* Example 2 (IOMMU platform device with MSIs) */
> +    immu2: iommu@1bcdd000 {
> +        compatible =3D "vendor,chip-iommu", "riscv,iommu";
> +        reg =3D <0x1bccd000 0x1000>;
> +        msi-parent =3D <&imsics_smode>;
> +        #iommu-cells =3D <2>;
> +    };
> +
> +    bus {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        /* Device with IOMMU device IDs ranging from 32 to 64 */
> +        master1 {
> +                iommus =3D <&immu2 32 32>;
> +        };
> +
> +        pcie@40000000 {
> +            compatible =3D "pci-host-cam-generic";
> +            device_type =3D "pci";
> +            #address-cells =3D <3>;
> +            #size-cells =3D <2>;
> +            bus-range =3D <0x0 0x1>;
> +
> +            /* CPU_PHYSICAL(2)  SIZE(2) */
> +            reg =3D <0x0 0x40000000 0x0 0x1000000>;
> +
> +            /* BUS_ADDRESS(3)  CPU_PHYSICAL(2)  SIZE(2) */
> +            ranges =3D <0x01000000 0x0 0x01000000  0x0 0x01000000  0x0 0=
x00010000>,
> +                     <0x02000000 0x0 0x41000000  0x0 0x41000000  0x0 0x3=
f000000>;
> +
> +            #interrupt-cells =3D <0x1>;
> +
> +            /* PCI_DEVICE(3)  INT#(1)  CONTROLLER(PHANDLE)  CONTROLLER_D=
ATA(2) */
> +            interrupt-map =3D <   0x0 0x0 0x0  0x1  &aplic_smode  0x4 0x=
1>,
> +                            < 0x800 0x0 0x0  0x1  &aplic_smode  0x5 0x1>=
,
> +                            <0x1000 0x0 0x0  0x1  &aplic_smode  0x6 0x1>=
,
> +                            <0x1800 0x0 0x0  0x1  &aplic_smode  0x7 0x1>=
;
> +
> +            /* PCI_DEVICE(3)  INT#(1) */
> +            interrupt-map-mask =3D <0xf800 0x0 0x0  0x7>;
> +
> +            msi-parent =3D <&imsics_smode>;
> +
> +            /* Devices with bus number 0-127 are mastered via immu2 */
> +            iommu-map =3D <0x0000 &immu2 0x0000 0x8000>;
> +        };
> +    };
> +...
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
