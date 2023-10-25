Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD157D64A1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjJYILl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbjJYILf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:11:35 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC5910A;
        Wed, 25 Oct 2023 01:11:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B0E7FE000C;
        Wed, 25 Oct 2023 08:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698221488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kMsuCLZa5HO4/dTq8bW3lK1ng6FHaXYOgfnq2P4eOQg=;
        b=WpaHPssdmaUYYCP6ILGX0jXGmmE/YE/hq7pPHyHUfKycPqwyvpeThDlzSTmxf5Ou/U8LPK
        6xbQM3cFgvQAUxwbh2R7OUMPXF0KMmrFbJgjg/8LuhWiKG5TTjx4S8caNs0H2LU64Easwg
        fJ2/fvW0VucZ+04ktbrfh7kF0CrEni45GoGImZyTX/RsZrcAshVZntfXs08QoYAil3WXyv
        uSjUYnShdesomb97EqP4C2SacSYMGjg2BpmOPGqwlcIgY8pZUaOJ71hemiQihaRoWPscmr
        SK1xm9WNW35kipLA05wVJSf+d6y3gMGJudeEhF6oLcu9FPgRwn0NXJuDG9o9VQ==
Date:   Wed, 25 Oct 2023 10:11:26 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Simon Glass <sjg@chromium.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, Michael Walle <mwalle@kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: mtd: binman-partition: Add binman
 compatibles
Message-ID: <20231025101126.2234a74c@xps-13>
In-Reply-To: <CAPnjgZ0G3W0a1T5TMuS_8L+4OwqFU3xXBKPnTs+MDDFBWYP_VA@mail.gmail.com>
References: <20231009220436.2164245-1-sjg@chromium.org>
        <20231009220436.2164245-2-sjg@chromium.org>
        <20231024161644.GB3707756-robh@kernel.org>
        <CAPnjgZ0G3W0a1T5TMuS_8L+4OwqFU3xXBKPnTs+MDDFBWYP_VA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

sjg@chromium.org wrote on Tue, 24 Oct 2023 14:40:54 -0700:

> Hi Rob,
>=20
> On Tue, 24 Oct 2023 at 09:16, Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Oct 09, 2023 at 04:04:14PM -0600, Simon Glass wrote: =20
> > > Add two compatible for binman entries, as a starting point for the
> > > schema.
> > >
> > > Note that, after discussion on v2, we decided to keep the existing
> > > meaning of label so as not to require changes to existing userspace
> > > software when moving to use binman nodes to specify the firmware
> > > layout.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v4:
> > > - Correct selection of multiple compatible strings
> > >
> > > Changes in v3:
> > > - Drop fixed-partitions from the example
> > > - Use compatible instead of label
> > >
> > > Changes in v2:
> > > - Use plain partition@xxx for the node name
> > >
> > >  .../mtd/partitions/binman-partition.yaml      | 49 +++++++++++++++++=
++
> > >  1 file changed, 49 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/=
binman-partition.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman-=
partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman-pa=
rtition.yaml
> > > new file mode 100644
> > > index 000000000000..35a320359ec1
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mtd/partitions/binman-partiti=
on.yaml
> > > @@ -0,0 +1,49 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +# Copyright 2023 Google LLC
> > > +
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mtd/partitions/binman-partition.y=
aml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Binman partition
> > > +
> > > +maintainers:
> > > +  - Simon Glass <sjg@chromium.org>
> > > +
> > > +select: false =20
> >
> > So this schema is never used. 'select: false' is only useful if
> > something else if referencing the schema. =20
>=20
> OK. Is there a user guide to this somewhere? I really don't understand
> it very well.

The example-schema.yaml at the root of the dt-bindings directory is
well commented.

> > > +description: |
> > > +  This corresponds to a binman 'entry'. It is a single partition whi=
ch holds
> > > +  data of a defined type.
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/mtd/partitions/partition.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - const: binman,entry     # generic binman entry =20
> >
> > 'binman' is not a vendor. You could add it if you think that's useful.
> > Probably not with only 1 case... =20
>=20
> I think it is best to use this for generic things implemented by
> binman, rather than some other project. For example, binman supports a
> 'fill' region. It also supports sections which are groups of
> sub-entries. So we will likely start with half a dozen of these and it
> will likely grow: binman,fill, binman,section, binman,files
>=20
> If we don't use 'binman', what do you suggest?
>=20
> > =20
> > > +      - items:
> > > +          - const: u-boot       # u-boot.bin from U-Boot project
> > > +          - const: atf-bl31     # bl31.bin or bl31.elf from TF-A pro=
ject =20
> >
> > Probably should use the new 'tfa' rather than old 'atf'. Is this the
> > only binary for TFA? The naming seems inconsistent in that every image
> > goes in (or can go in) a bl?? section. Why does TFA have it but u-boot
> > doesn't? Perhaps BL?? is orthogonal to defining what is in each
> > partition. Perhaps someone more familar with all this than I am can
> > comment. =20
>=20
> From what I can tell TF-A can produce all sorts of binaries, of which
> bl31 is one. U-Boot can also produce lots of binaries, but its naming
> is different (u-boot, u-boot-spl, etc.). Bear in mind that U-Boot is
> used on ARM, where this terminology is defined, and on x86 (for
> example), where it is not.
>=20
> >
> > Once you actually test this, you'll find you are specifying:
> >
> > compatible =3D "u-boot", "atf-bl31"; =20
>=20
> I don't understand that, sorry. I'll send a v5 and see if the problem goe=
s away.

For me this means the partition contains U-Boot and TF-A, which is
probably not what you want. I believe Rob is saying that how you define
the compatible property above does not match the examples below. Did
you run make dt_binding_check?

Also, do you really need to say which software project provides a
component? Would using "bl31", "bl33", etc be enough? Or maybe you
could have eg. "bl31-tf-a" and "bl31-u-boot-spl" (in this order) for
clarity? This way one knows which stage a partition contains and also
the software project which provided it.

To be honest I still don't fully get where you want to go and I believe
a more complete schema would probably help, with different examples, to
catch what you need and why.

> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    partitions {
> > > +        compatible =3D "binman";
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <1>;
> > > +
> > > +        partition@100000 {
> > > +            compatible =3D "u-boot";
> > > +            reg =3D <0x100000 0xf00000>;
> > > +        };
> > > +
> > > +        partition@200000 {
> > > +            compatible =3D "atf-bl31";
> > > +            reg =3D <0x200000 0x100000>;
> > > +        };
> > > +    };
> > > --
> > > 2.42.0.609.gbb76f46606-goog
> > > =20
>=20
> Regards,
> Simon


Thanks,
Miqu=C3=A8l
