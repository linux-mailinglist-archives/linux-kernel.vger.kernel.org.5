Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E257ADA3F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjIYOrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIYOru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:47:50 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFBB107;
        Mon, 25 Sep 2023 07:47:42 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B8C0FF803;
        Mon, 25 Sep 2023 14:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695653261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RJ8wgD+sYfH60sjIVfTMxjGu1xymUUwJJ2ErY48nGYc=;
        b=F7eU7qiRDF62AVpgPJ49OU04LdCXgKlpYzPbhNN54who82KLTFKdm47pGgO4xFwJdDltHS
        0nKfkxU+vPiZG26sgJZbDa4TxAD8FiFV/UUYlCbOmlGxzBDEKHTOI8IvYE2lQu1tSIhYyV
        /BzEFNcs2hALNf6Va7MaOZssraIt2zWCwDJbqUZseBljhgdUvok74dJOUFbxyxH99DFMft
        BeIhCv503gtR9Bmuzf9nZutyHN8c4ayK18Azz83kxt9ZVlZbVUOci/dg/GVLw13jvdKFZ1
        UtQU44zICcz/jvDDv7+fy1NsgRufPvhTaowh/fEe/MaT4fEBxmYrQR61tzD0HA==
Date:   Mon, 25 Sep 2023 16:47:36 +0200
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
Message-ID: <20230925164736.5efbf4c0@xps-13>
In-Reply-To: <CAPnjgZ0Z5J_33HuQF-5XgDFmZim0nHHzvZJOOZobWw_cOJd=9g@mail.gmail.com>
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
        <CAL_Jsq+WuYDU+yY98opTHr1PT-J9mFYJQBjVMnk+FSWLDUO33w@mail.gmail.com>
        <CAPnjgZ1pfxaMG1n5yOBhiOhsNrRjck1K92U7Ga=+VTY_jjjrVg@mail.gmail.com>
        <20230922174649.GA3320366-robh@kernel.org>
        <CAPnjgZ3ojfAv=BHqOhM=-NnYqCm81Ny=PsGKiNphKTmw++fk9w@mail.gmail.com>
        <CAL_JsqJqvyP=c93DHDO8A5RXv7Lz_Z7eEHSbJQ=JCo+qPVhSfg@mail.gmail.com>
        <CAPnjgZ3BnD9aX3cNNPiGRKTOj+YeurHCLv6K0TRFhAtY21Qufw@mail.gmail.com>
        <20230925092122.0b615f25@xps-13>
        <CAPnjgZ0Z5J_33HuQF-5XgDFmZim0nHHzvZJOOZobWw_cOJd=9g@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

sjg@chromium.org wrote on Mon, 25 Sep 2023 06:33:14 -0600:

> Hi Miquel,
>=20
> On Mon, 25 Sept 2023 at 01:21, Miquel Raynal <miquel.raynal@bootlin.com> =
wrote:
> >
> > Hi Simon,
> >
> > sjg@chromium.org wrote on Fri, 22 Sep 2023 13:51:14 -0600:
> > =20
> > > Hi Rob,
> > >
> > > On Fri, 22 Sept 2023 at 13:43, Rob Herring <robh@kernel.org> wrote: =
=20
> > > >
> > > > On Fri, Sep 22, 2023 at 1:12=E2=80=AFPM Simon Glass <sjg@chromium.o=
rg> wrote: =20
> > > > >
> > > > > Hi Rob,
> > > > >
> > > > > On Fri, 22 Sept 2023 at 11:46, Rob Herring <robh@kernel.org> wrot=
e: =20
> > > > > >
> > > > > > On Fri, Sep 22, 2023 at 11:01:18AM -0600, Simon Glass wrote: =20
> > > > > > > Hi Rob,
> > > > > > >
> > > > > > > On Fri, 22 Sept 2023 at 10:00, Rob Herring <robh@kernel.org> =
wrote: =20
> > > > > > > >
> > > > > > > > On Thu, Sep 21, 2023 at 1:45=E2=80=AFPM Simon Glass <sjg@ch=
romium.org> wrote: =20
> > > > > > > > >
> > > > > > > > > Binman[1] is a tool for creating firmware images. It allo=
ws you to
> > > > > > > > > combine various binaries and place them in an output file.
> > > > > > > > >
> > > > > > > > > Binman uses a DT schema to describe an image, in enough d=
etail that
> > > > > > > > > it can be automatically built from component parts, disas=
sembled,
> > > > > > > > > replaced, listed, etc.
> > > > > > > > >
> > > > > > > > > Images are typically stored in flash, which is why this b=
inding is
> > > > > > > > > targeted at mtd. Previous discussion is at [2] [3].
> > > > > > > > >
> > > > > > > > > [1] https://u-boot.readthedocs.io/en/stable/develop/packa=
ge/binman.html
> > > > > > > > > [2] https://lore.kernel.org/u-boot/20230821180220.2724080=
-3-sjg@chromium.org/
> > > > > > > > > [3] https://www.spinics.net/lists/devicetree/msg626149.ht=
ml =20
> > > > > > > >
> > > > > > > > You missed:
> > > > > > > >
> > > > > > > > https://github.com/devicetree-org/dt-schema/pull/110
> > > > > > > >
> > > > > > > > where I said: We certainly shouldn't duplicate the existing=
 partitions
> > > > > > > > bindings. What's missing from them (I assume we're mostly t=
alking
> > > > > > > > about "fixed-partitions" which has been around forever I th=
ink (before
> > > > > > > > me))?
> > > > > > > >
> > > > > > > > To repeat, unless there is some reason binman partitions co=
nflict with
> > > > > > > > fixed-partitions, you need to start there and extend it. Fr=
om what's
> > > > > > > > posted here, it neither conflicts nor needs extending. =20
> > > > > > >
> > > > > > > I think at this point I am just hopelessly confused. Have you=
 taken a
> > > > > > > look at the binman schema? [1] =20
> > > > > >
> > > > > > Why do I need to? That's used for some tool and has nothing to =
do with a
> > > > > > device's DTB. However, I thought somewhere in this discussion y=
ou showed
> > > > > > it under a flash device node. =20
> > > > >
> > > > > Yes, that is the intent (under a flash node).
> > > > > =20
> > > > > > Then I care because then it overlaps with
> > > > > > what we already have for partitions. If I misunderstood that, t=
hen just
> > > > > > put your schema with your tool. Only users of the tool should c=
are about
> > > > > > the tool's schema. =20
> > > > >
> > > > > OK. I believe that binman will fit into both camps, since its inp=
ut is
> > > > > not necessarily fully formed. E.g. if you don't specify the offse=
t of
> > > > > an entry, then it will be packed automatically. But the output is
> > > > > fully formed, in that Binman now knows the offset so can write it=
 to
> > > > > the DT. =20
> > > >
> > > > I suppose it could take its own format as input and then write out
> > > > something different for the "on the device" format (i.e.
> > > > fixed-partitions). At least for the dynamic offsets, we may need
> > > > something allowed for binman input, but not allowed on device. In
> > > > general, there is support for partitions without addresses/offsets,
> > > > but only for partitions that have some other way to figure that out
> > > > (on disk partition info).
> > > >
> > > > There's also the image filename which doesn't really belong in the =
on
> > > > device partitions. So maybe the input and output schemas should be
> > > > separate. =20
> > >
> > > OK, I'll focus on the output schema for now. I suspect this will be a
> > > grey area though.
> > >
> > > As an example, if you replace a binary in the firmware, Binman can
> > > repack the firmware to make room, respecting the alignment and size
> > > constraints. So these need to be in the output schema somehow.
> > > =20
> > > > =20
> > > > > > > I saw this file, which seems to extend a partition.
> > > > > > >
> > > > > > > Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908=
-partitions.yaml =20
> > > > > >
> > > > > > IIRC, that's a different type where partition locations are sto=
red in
> > > > > > the flash, so we don't need location and size in DT. =20
> > > > >
> > > > > OK.
> > > > > =20
> > > > > > =20
> > > > > > >
> > > > > > > I was assuming that I should create a top-level compatible =
=3D "binman"
> > > > > > > node, with subnodes like compatible =3D "binman,bl31-atf", fo=
r example.
> > > > > > > I should use the compatible string to indicate the contents, =
right? =20
> > > > > >
> > > > > > Yes for subnodes, and we already have some somewhat standard on=
es for
> > > > > > "u-boot" and "u-boot-env". Though historically, "label" was use=
d. =20
> > > > >
> > > > > Binman has common properties for all entries, including "compress"
> > > > > which sets the compression algorithm. =20
> > > >
> > > > I see no issue with adding that. It seems useful and something miss=
ing
> > > > in the existing partition schemas. =20
> > >
> > > OK I sent a patch with that.
> > > =20
> > > > =20
> > > > > So perhaps I should start by defining a new binman,bl31-atf which=
 has
> > > > > common properties from an "binman,entry" definition? =20
> > > >
> > > > I don't understand the binman prefix. The contents are ATF (or TF-A
> > > > now). Who wrote it to the flash image is not relevant. =20
> > >
> > > Are you suggesting just "atf-bl31", or "arm,atf-bl31" ? Or should we
> > > change it to "tfa-bl31"? =20
> >
> > I don't really understand the relationship with TF-A here. Can't we
> > just have a kind of fixed-partitions with additional properties like
> > the compression? =20
>=20
> Binman needs to know what to put in there, which is the purpose of the
> compatible string.

But "what" should be put inside the partition is part of the input
argument, not the output. You said (maybe I got this wrong) that the
schema would apply to the output of binman. If you want to let user
know what's inside, maybe it is worth adding a label, but otherwise I
don't like the idea of a compatible for that, which for me would mean:
"here is how to handle that specific portion of the flash/here is how
the flash is organized".

> > > > We already have some compatibles in use. We should reuse them if
> > > > possible. Not sure about TF-A though. =20
> > >
> > > OK.
> > > =20
> >
> > Also, I still don't understand the purpose of this schema. So binman
> > generates an image, you want to flash this image and you would like the
> > tool to generate the corresponding (partition) DT snippet automatically.
> > Do I get this right? I don't get why you would need new compatibles for
> > that. =20
>=20
> It is actually the other way around. The schema tells Binman how to
> build the image (what goes in there and where). Then outputs an
> updated DT which describes where everything ended up, for use by other
> tools, e.g. firmware update. It is a closed loop in that sense. See
> the references for more information.

Maybe I fail to see why you would want these description to be
introduced here, if they are not useful to the OS.

> [1] https://u-boot.readthedocs.io/en/latest/develop/package/index.html
> [2] https://pretalx.com/media/osfc2019/submissions/Y7EN9V/resources/Binma=
n_-_A_data-controlled_firmware_packer_for_U-B_pFU3n2K.pdf
> [3] https://www.youtube.com/watch?v=3DL84ujgUXBOQ


Thanks,
Miqu=C3=A8l
