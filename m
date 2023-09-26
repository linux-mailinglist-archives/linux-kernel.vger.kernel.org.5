Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4667AE71B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjIZHsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIZHsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:48:30 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D1BDC;
        Tue, 26 Sep 2023 00:48:22 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 62FF41BF208;
        Tue, 26 Sep 2023 07:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695714501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WByilfXcf9fwVRPpSMAIkhXNNnHM8fT1soPbMgZimUo=;
        b=UByeNvtFKGUJFu1r0cCVg4+6yFQMDRx3wfWvVNZdgBJ5aAZyYTFHXVNk8YXzQ+gqfyu7Vj
        LwFeBNk0hjpd+S5kuzcJpVl07s4zPh+5PF9MXJAj2J7Cwa6C5nYzJzLTuzC2dwd3i2QCPm
        uVHFHh9cTFsd1d1qCeS5kRLHIQgpfDahPO/iUmIvFY9drBLH156TnaLMrfj4GgaTWhwSR9
        WKswhTyRPBo685G0NmpdIpmxjid0SysKvF7C/Q3nj76ii+vo7WnUVse1GiqN4XO3Uomjp/
        x/3dlWrMw2mvxxabewSs/TLI1FpSmlooHgTCL1cYJWL49xPmAS7MJGXg3zof7A==
Date:   Tue, 26 Sep 2023 09:48:15 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Simon Glass <sjg@chromium.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Dhruva Gole <d-gole@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: Add a schema for binman
Message-ID: <20230926094815.5802e184@xps-13>
In-Reply-To: <CAPnjgZ1npHPpwPmw2f4=E3U5=RH0m4R+W_MZ7+oXdmDF=EeUjg@mail.gmail.com>
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
        <CAL_Jsq+WuYDU+yY98opTHr1PT-J9mFYJQBjVMnk+FSWLDUO33w@mail.gmail.com>
        <CAPnjgZ1pfxaMG1n5yOBhiOhsNrRjck1K92U7Ga=+VTY_jjjrVg@mail.gmail.com>
        <20230922174649.GA3320366-robh@kernel.org>
        <CAPnjgZ3ojfAv=BHqOhM=-NnYqCm81Ny=PsGKiNphKTmw++fk9w@mail.gmail.com>
        <CAL_JsqJqvyP=c93DHDO8A5RXv7Lz_Z7eEHSbJQ=JCo+qPVhSfg@mail.gmail.com>
        <CAPnjgZ3BnD9aX3cNNPiGRKTOj+YeurHCLv6K0TRFhAtY21Qufw@mail.gmail.com>
        <20230925092122.0b615f25@xps-13>
        <CAPnjgZ0Z5J_33HuQF-5XgDFmZim0nHHzvZJOOZobWw_cOJd=9g@mail.gmail.com>
        <20230925164736.5efbf4c0@xps-13>
        <CAPnjgZ3YCQHJ-eXuX8rYx2Qb6QEL+XviFmXYTON6M-sGPWSBBg@mail.gmail.com>
        <20230925172447.43dcef88@xps-13>
        <CAPnjgZ20c9FsYVjSrQ9qbFy9Y67BqDP2zxMyATx===PFhO69Ew@mail.gmail.com>
        <CAL_JsqJfjHqtTB2qfLmNxmQtn1rZewNyNe+Knu_Z4UCdPoPhSQ@mail.gmail.com>
        <CAPnjgZ1npHPpwPmw2f4=E3U5=RH0m4R+W_MZ7+oXdmDF=EeUjg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > > > > These are firmware bindings, as indicated, but I
> > > > > took them out of the /firmware node since that is for a different
> > > > > purpose. Rob suggested that partitions was a good place. We have =
fwupd
> > > > > using DT to hold the firmware-update information, so I expect it =
will
> > > > > move to use these bindings too. =20
> > > >
> > > > I would definitely use fixed partitions as that's what you need the=
n:
> > > > registering where everything starts and ends. If you have "in-band"
> > > > meta data you might require a compatible, but I don't think you
> > > > do, in this case you should probably carry the content through a la=
bel
> > > > (which will become the partition name) and we can discuss additional
> > > > properties if needed. =20
> > >
> > > I believe I am going to need a compatible string at the 'partitions'
> > > level to indicate that this is the binman scheme. But we can leave
> > > that until later. =20
> >
> > Perhaps:
> >
> > compatible =3D "binman", "fixed-partitions";
> >
> > Though I don't understand why binman couldn't just understand what
> > "fixed-partitions" means rather than "binman". =20
>=20
> Well so long as we don't add any binman things in here, you are right.
>=20
> But the eventual goal is parity with current Binman functionality,
> which writes the entire (augmented) description to the DT, allowing
> tools to rebuild / repack / replace pieces later, maintaining the same
> alignment constraints, etc. I am assuming that properties like 'align
> =3D <16>' would not fit with fixed-partitions.=20

I am personally not bothered by this kind of properties. But if we plan
on adding too much properties, I will advise to indeed use another name
than fixed-partitions (or add the "binman" secondary compatible)
otherwise it's gonna be hard to support in the code while still
restraining as much as we can the other partition schema.

> But if we don't preserve
> these properties then Binman cannot do repacking reliably. Perhaps for
> now I could put the augmented DT in its own section somewhere, but I
> am just not sure if that will work in a real system. E.g. with VBE the
> goal is to use the DT to figure out how to access the firmware, update
> it, etc.
>=20
> Is it not possible to have my own node with whatever things Binman
> needs in it (subject to review of course)? i.e. could we discuss how
> to encode it, but argue less about whether things are needed? I
> kind-of feel I know what is needed, since I wrote the tool.
>=20
> >
> > =20
> > > So you are suggesting 'label' for the contents. Rob suggested
> > > 'compatible' [1], so what should I do? =20
> >
> > "label" is for consumption by humans, not tools/software. Compatible
> > values are documented, label values are not. Though the partition
> > stuff started out using label long ago and it's evolved to preferring
> > compatible. =20
>=20
> OK so we are agreed that we are going with 'compatible'.

Still strongly disagree here.

My understanding is that a compatible carries how the content is
organized, and how this maybe specific (like you have in-band meta data
data that needs to be parsed in a specific way or in your case
additional specific properties in the DT which give more context about
how the data is stored). But the real content of the partition, ie. if
it contains a firmware, the kernel or some user data does not belong to
the compatible.

I.e:
- The first byte of my partition gives the compression algorithm:
  -> compatible =3D "compressed-partition-foo";
     or
  -> compatible =3D "fixed-partitions" + compression-algorithm =3D "foo";
- The partition contains a picture of my dog:
  -> label =3D "my dog is beautiful"
  but certainly not
  -> compatible =3D "my-dog";

I don't see why, for the binman schema, we could not constrain the
labels?

> > > With this schema, would every node be called 'partition@...' or is
> > > there flexibility to use other names? =20
> >
> > The preference is to use generic names. Do you mean without a
> > unit-address or different from "partition"? The need for the input
> > side of binman to have dynamic addresses seems like the biggest issue.
> > That's allowed in other cases with "partition-N" or "partition-foo"
> > IIRC. I don't think we want to allow that for "fixed-partitions" at
> > least in the DTB (i.e. the output side of binman). =20
>=20
> OK I suppose this is the problem with starting small. I was hoping to
> build up the schema piece by piece but now I am wondering whether
> every little detail will get redirected and I'll end up with something
> that Binman cannot use.
>=20
> So far all I have is that I can add a 'compress' property and a
> 'compatible' which describes the contents. I suppose it is a start.

I guess defining all you need in one go would be better. At least
showing a full and typical example might help. But some items like
encoding if you have TF-A or U-Boot in the compatible, I'm far from
convinced...

Thanks,
Miqu=C3=A8l
