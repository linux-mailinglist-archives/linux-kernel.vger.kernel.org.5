Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4441575A045
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjGSU6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjGSU6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:58:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15871FD5;
        Wed, 19 Jul 2023 13:58:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 456FF61838;
        Wed, 19 Jul 2023 20:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6B7C433C8;
        Wed, 19 Jul 2023 20:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689800284;
        bh=B4S0a9k7f+50hsxYrnWMb30xJE8CzR/by+bafs38zfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=daGmg3u7/lDEpY/rRKsv4n7gSC9uqEyG8vtXPTfmvmoQiMTl+EWsQoJrrUeVkBxrE
         UXjZbWGe0yf+fBzgDqDVaZTV09rimTM4pFnAw/8mFh/7Nu7F5sVKXX9RxzyuiTWFxD
         9c3oR76JRTJXn2vpbP7ZvoknTnRl5ybqTl7taYEGIi+UKWEDNUW+TrqJUBdrbVS9yQ
         mZ6qj689Jp25dqDYcmmefP04hmcYksP15Or6eMtVHsbNroiZRd+NoK1F8W1mifXWps
         HOZo7zgrIwIzrpO52Camc9DUw5pgGHHGXEK+SFggPXA1Jqi2shrMcpknxGK+FqO4vx
         RuKqEmCoBEi6A==
Date:   Wed, 19 Jul 2023 21:57:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Tomasz Jeznach <tjeznach@rivosinc.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
        linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
        iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 03/11] dt-bindings: Add RISC-V IOMMU bindings
Message-ID: <20230719-efficient-anew-8a67ab21a3aa@spud>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <d62ceb33620cab766d809e6bbf30eaf5b46bc955.1689792825.git.tjeznach@rivosinc.com>
 <20230719-unnoticed-scion-744fdf509151@spud>
 <CAH2o1u6CZSb7pXcaXmh7dJQmNZYh3uORk4x7vJPrb+uCwFdU5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ukD8vF3BBA10OUiB"
Content-Disposition: inline
In-Reply-To: <CAH2o1u6CZSb7pXcaXmh7dJQmNZYh3uORk4x7vJPrb+uCwFdU5g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ukD8vF3BBA10OUiB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 01:52:28PM -0700, Tomasz Jeznach wrote:
> On Wed, Jul 19, 2023 at 1:19=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
>=20
> > Hey Tomasz,
> >
> > On Wed, Jul 19, 2023 at 12:33:47PM -0700, Tomasz Jeznach wrote:
> > > From: Anup Patel <apatel@ventanamicro.com>
> > >
> > > We add DT bindings document for RISC-V IOMMU platform and PCI devices
> > > defined by the RISC-V IOMMU specification.
> > >
> > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >
> > Your signoff is missing from here.
> >
> > Secondly, as get_maintainer.pl would have told you, dt-bindings patches
> > need to be sent to the dt-binding maintainers and list.
> > +CC maintainers & list.
> >
> > Thirdly, dt-binding patches should come before their users.
> >
>=20
>=20
> Thank you for pointing out and adding DT maintainers.
> The signoff is definitely missing, and I'll will amend with other fixes /
> reordering.

Yeah, please wait until you get actual feedback on the drivers etc
though before you do that.

Also, don't send html emails to the mailing lists. They will be rejected
and those outside of direct-cc will not see the emails.

> > > ---
> > >  .../bindings/iommu/riscv,iommu.yaml           | 146 ++++++++++++++++=
++
> > >  1 file changed, 146 insertions(+)
> > >  create mode 100644
> > Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
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
> >
> > What about Anup, who seems to have written this?
> > Or your co-authors of the drivers?
> >
> >
> Anup provided only device tree riscv,iommu bindings proposal, but handed
> over its maintenance.
>=20
> > +
> > > +description:
> > > +  The RISC-V IOMMU specificaiton defines an IOMMU for RISC-V platfor=
ms
> > > +  which can be a regular platform device or a PCI device connected to
> > > +  the host root port.
> > > +
> > > +  The RISC-V IOMMU provides two stage translation, device directory
> > table,
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
> >
> > These dummy compatibles are not valid, as was pointed out to Anup on
> > the AIA series. Please go look at what was done there instead:
> >
> > https://lore.kernel.org/all/20230719113542.2293295-7-apatel@ventanamicr=
o.com/
> >
> >
> Thank you, good pointer, seams like the same comments apply here. Will go
> through the discussion and update.
>=20
>=20
> > > +          - const: riscv,iommu
> > > +
> > > +      - description: RISC-V IOMMU as a PCI device connected to root =
port
> > > +        items:
> > > +          - enum:
> > > +              - vendor,chip-pci-iommu
> > > +          - const: riscv,pci-iommu
> >
> > I'm not really au fait with the arm smmu stuff, but do any of its
> > versions support being connected to a root port?
> >
> >
> RISC-V IOMMU allows them to be connected to the root port, or presented as
> a platform device.

That is not quite what I asked... What I want to know is why we are
doing something different to Arm's SMMU stuff & whether it is because
RISC-V has extra capabilities, or the binding itself is flawed.

(There's no more comments from me below, just making sure the mail's
contents reaches lore)

Cheers,
Conor.

> > > +  reg:
> > > +    maxItems: 1
> > > +    description:
> > > +      For RISC-V IOMMU as a platform device, this represents the MMIO
> > base
> > > +      address of registers.
> > > +
> > > +      For RISC-V IOMMU as a PCI device, this represents the PCI-PCI
> > bridge
> > > +      details as described in
> > Documentation/devicetree/bindings/pci/pci.txt
> > > +
> > > +  '#iommu-cells':
> > > +    const: 2
> > > +    description: |
> >
> > |s are only needed where formatting needs to be preserved.
> >
> > > +      Each IOMMU specifier represents the base device ID and number =
of
> > > +      device IDs.
> > > +
> > > +  interrupts:
> > > +    minItems: 1
> > > +    maxItems: 16
> >
> > What are any of these interrupts?
> >
> >
> I'll add a description to the file. In short queue interfaces signalling =
to
> the driver.
>=20
>=20
> > +    description:
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
> >
> > RISC-V is dma-coherent by default, should this not be dma-noncoherent
> > instead?
> >
> >
> Very valid comment. I'm ok to reverse the flag unless anyone objects.
>=20
>=20
> > > +    description:
> > > +      Present if page table walks and DMA accessed made by the RISC-V
> > IOMMU
> > > +      are cache coherent with the CPU.
> > > +
> > > +  power-domains:
> > > +    maxItems: 1
> > > +
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
> >
> > Why is this "immu"? typo or intentional?
> >
>=20
> I guess there was no particular naming schema here, but I might defer this
> question to the author.
>=20
>=20
> >
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
> >
> > These sort of comments seem to just repeat what address-cells &
> > size-cells has already said, no?
> >
> >
> Correct.
>=20
>=20
>=20
> > Thanks,
> > Conor.
> >
>=20
>=20
> Thank you Conor for prompt response and comments.
> I'll address them in the next version.
>=20
> - Tomasz

--ukD8vF3BBA10OUiB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLhOVgAKCRB4tDGHoIJi
0gLqAP41V6w/ZHqx8UdUIKZ7RAciLKALxGmjKUql4InYzufZawEAt5m3zY5ZN4Qc
FWrfrohwIBUpTtMQ7nppC/NVf2f6Zww=
=JvC9
-----END PGP SIGNATURE-----

--ukD8vF3BBA10OUiB--
