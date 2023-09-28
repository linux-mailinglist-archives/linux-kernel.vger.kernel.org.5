Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE7E7B20FD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjI1PUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjI1PUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:20:21 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC95BC0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:20:18 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5334f9a56f6so15890313a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695914416; x=1696519216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhGCCrTPz3qD815DrUTz3QFvoilWcLj84jeEgBAbn4g=;
        b=RQ2FPrFYjacQNvGdOlD75otTCmHvrF1Ybu5BwIbkEwy/0WPLPBJ+0J62RXmfkdETIx
         gBZOUDhhBxWjalQacJipdaRmkDvXzbX3Ir/mBHVdRIvSh/6zZxe+dhu4O4jl23Dlri1z
         9sAC0gnWrxGiVRpATaZf4sy/SS4qIQdILJlJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695914416; x=1696519216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhGCCrTPz3qD815DrUTz3QFvoilWcLj84jeEgBAbn4g=;
        b=IRRq+bqPruAh+6fIYwKXNaw1Rth09X4BasnqPRkg/wxjsLIdQ497DdOz83fCMomGnC
         G7D+XvoXCXuQ2C+1Sf4Q7hOUqr26YgXqxBSPWhHmkt4aFf6AbitQwAqP8MOXAW4P0/nL
         XUGJV0hSCXKlhD0pUQcoSvNxIgse+T6CJHWKJLvbpbxPeoJ/HJhyaoCGJjp6pi6e4W7N
         KLIttPug1jRDhrDnoYO3oeccAC+Izin75N/pAeRZn/bw+eoDh7lfMlnrcNxaspkKvDxF
         ujWGlvhjxo7yNvVN8Xqi3gOgufESZPdfp7qLewG1Ythjv+gM3UTh7D5EPlEA91t/BaAT
         sv6Q==
X-Gm-Message-State: AOJu0YxBY4OQ4/wNv8aJUPLbOeyoN+p32UcKkdECfzDRQ9zCjoMUVfkb
        6ZQv8YYKr2l9TQTNdmzOtnB2hlfDdKGAm9hYpyWL5w==
X-Google-Smtp-Source: AGHT+IGCrTzWYKPGz8+625kDs0eQi51Ow82elgipH2Qu5W+6QmLi6g4eOr361Yni2q+KJAEShzSViau1oDvFTplMmIU=
X-Received: by 2002:aa7:c1ca:0:b0:533:926:da9d with SMTP id
 d10-20020aa7c1ca000000b005330926da9dmr1505968edp.18.1695914416372; Thu, 28
 Sep 2023 08:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
 <CAL_Jsq+WuYDU+yY98opTHr1PT-J9mFYJQBjVMnk+FSWLDUO33w@mail.gmail.com>
 <CAPnjgZ1pfxaMG1n5yOBhiOhsNrRjck1K92U7Ga=+VTY_jjjrVg@mail.gmail.com>
 <20230922174649.GA3320366-robh@kernel.org> <CAPnjgZ3ojfAv=BHqOhM=-NnYqCm81Ny=PsGKiNphKTmw++fk9w@mail.gmail.com>
 <CAL_JsqJqvyP=c93DHDO8A5RXv7Lz_Z7eEHSbJQ=JCo+qPVhSfg@mail.gmail.com>
 <CAPnjgZ3BnD9aX3cNNPiGRKTOj+YeurHCLv6K0TRFhAtY21Qufw@mail.gmail.com>
 <20230925092122.0b615f25@xps-13> <CAPnjgZ0Z5J_33HuQF-5XgDFmZim0nHHzvZJOOZobWw_cOJd=9g@mail.gmail.com>
 <20230925164736.5efbf4c0@xps-13> <CAPnjgZ3YCQHJ-eXuX8rYx2Qb6QEL+XviFmXYTON6M-sGPWSBBg@mail.gmail.com>
 <20230925172447.43dcef88@xps-13> <CAPnjgZ20c9FsYVjSrQ9qbFy9Y67BqDP2zxMyATx===PFhO69Ew@mail.gmail.com>
 <CAL_JsqJfjHqtTB2qfLmNxmQtn1rZewNyNe+Knu_Z4UCdPoPhSQ@mail.gmail.com>
 <CAPnjgZ1npHPpwPmw2f4=E3U5=RH0m4R+W_MZ7+oXdmDF=EeUjg@mail.gmail.com>
 <20230926094815.5802e184@xps-13> <CAL_JsqL_8bhHkHOFL8a8=g1dYL4OY8hGuNDyc0Jz22rEuJzXtQ@mail.gmail.com>
 <CAPnjgZ3TJLaRzv_cXyLdpRBtc2-FBYQ=gk-_MhEDH47HvO71FQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ3TJLaRzv_cXyLdpRBtc2-FBYQ=gk-_MhEDH47HvO71FQ@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Thu, 28 Sep 2023 09:20:05 -0600
Message-ID: <CAPnjgZ2eUcgevpS7Ak5p=7bhm0aHW3taLO8Fq_EcpDDQidJFVA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd: Add a schema for binman
To:     Rob Herring <robh@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Dhruva Gole <d-gole@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again Rob,

On Wed, 27 Sept 2023 at 10:43, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Rob,
>
> On Tue, 26 Sept 2023 at 11:29, Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Sep 26, 2023 at 2:48=E2=80=AFAM Miquel Raynal <miquel.raynal@bo=
otlin.com> wrote:
> > >
> > > Hello,
> > >
> > > > > > > > These are firmware bindings, as indicated, but I
> > > > > > > > took them out of the /firmware node since that is for a dif=
ferent
> > > > > > > > purpose. Rob suggested that partitions was a good place. We=
 have fwupd
> > > > > > > > using DT to hold the firmware-update information, so I expe=
ct it will
> > > > > > > > move to use these bindings too.
> > > > > > >
> > > > > > > I would definitely use fixed partitions as that's what you ne=
ed then:
> > > > > > > registering where everything starts and ends. If you have "in=
-band"
> > > > > > > meta data you might require a compatible, but I don't think y=
ou
> > > > > > > do, in this case you should probably carry the content throug=
h a label
> > > > > > > (which will become the partition name) and we can discuss add=
itional
> > > > > > > properties if needed.
> > > > > >
> > > > > > I believe I am going to need a compatible string at the 'partit=
ions'
> > > > > > level to indicate that this is the binman scheme. But we can le=
ave
> > > > > > that until later.
> > > > >
> > > > > Perhaps:
> > > > >
> > > > > compatible =3D "binman", "fixed-partitions";
> > > > >
> > > > > Though I don't understand why binman couldn't just understand wha=
t
> > > > > "fixed-partitions" means rather than "binman".
> > > >
> > > > Well so long as we don't add any binman things in here, you are rig=
ht.
> > > >
> > > > But the eventual goal is parity with current Binman functionality,
> > > > which writes the entire (augmented) description to the DT, allowing
> > > > tools to rebuild / repack / replace pieces later, maintaining the s=
ame
> > > > alignment constraints, etc. I am assuming that properties like 'ali=
gn
> > > > =3D <16>' would not fit with fixed-partitions.
> > >
> > > I am personally not bothered by this kind of properties. But if we pl=
an
> > > on adding too much properties, I will advise to indeed use another na=
me
> > > than fixed-partitions (or add the "binman" secondary compatible)
> > > otherwise it's gonna be hard to support in the code while still
> > > restraining as much as we can the other partition schema.
> >
> > Agreed. It's a trade off. I think we need enough to understand the
> > problem (not just presented with a solution), agree on the general
> > solution/direction, and then discuss specific additions.
> >
> > > > But if we don't preserve
> > > > these properties then Binman cannot do repacking reliably. Perhaps =
for
> > > > now I could put the augmented DT in its own section somewhere, but =
I
> > > > am just not sure if that will work in a real system. E.g. with VBE =
the
> > > > goal is to use the DT to figure out how to access the firmware, upd=
ate
> > > > it, etc.
> >
> > VBE?

Verified Boot for Embedded, an EFI alternative with no callbacks.

> >
> > > > Is it not possible to have my own node with whatever things Binman
> > > > needs in it (subject to review of course)? i.e. could we discuss ho=
w
> > > > to encode it, but argue less about whether things are needed? I
> > > > kind-of feel I know what is needed, since I wrote the tool.
> >
> > What we don't need is the same information in 2 places for the DTB
> > used at runtime. If the binman node is removed, do whatever you want.
> > If you want to keep it at runtime, then it's got to extend what we
> > already have.
> >
> > I don't think anyone is disagreeing about whether specific information
> > is needed or not.
> >
> > > > > > So you are suggesting 'label' for the contents. Rob suggested
> > > > > > 'compatible' [1], so what should I do?
> > > > >
> > > > > "label" is for consumption by humans, not tools/software. Compati=
ble
> > > > > values are documented, label values are not. Though the partition
> > > > > stuff started out using label long ago and it's evolved to prefer=
ring
> > > > > compatible.
> > > >
> > > > OK so we are agreed that we are going with 'compatible'.
> > >
> > > Still strongly disagree here.
> >
> > Miquel is right. I was confused here. "label" is still pretty much
> > used for what the image is. Though we do have "u-boot,env" for both it
> > seems.
> >
> > My position on "label" stands. To the extent we have images for common
> > components, I think we should standardize the names. Certainly if
> > tools rely on the names, then they should be documented.
>
> OK thanks for clearing that up.
>
> But at present 'label' is free-form text. If I change it to an enum,
> won't that break things? If not, how do I actually do it?
>
> There is a u-boot.yaml but it doesn't actually have a "u-boot" label
> in the schema. In fact it seems that the label is not validated at
> all?

It looks like I can just add it to a separate schema file, which is
what I did in the latest version.

>
> >
> >
> > > My understanding is that a compatible carries how the content is
> > > organized, and how this maybe specific (like you have in-band meta da=
ta
> > > data that needs to be parsed in a specific way or in your case
> > > additional specific properties in the DT which give more context abou=
t
> > > how the data is stored). But the real content of the partition, ie. i=
f
> > > it contains a firmware, the kernel or some user data does not belong =
to
> > > the compatible.
> > >
> > > I.e:
> > > - The first byte of my partition gives the compression algorithm:
> > >   -> compatible =3D "compressed-partition-foo";
> > >      or
> > >   -> compatible =3D "fixed-partitions" + compression-algorithm =3D "f=
oo";
> > > - The partition contains a picture of my dog:
> > >   -> label =3D "my dog is beautiful"
> > >   but certainly not
> > >   -> compatible =3D "my-dog";
> >
> > IMO, compatible in this case should convey "JPEG image" or similar.
> >
> > > I don't see why, for the binman schema, we could not constrain the
> > > labels?
> >
> > Yes, but those should follow what we already have. "u-boot" for
> > example rather than "data,u-boot" which I think Simon had in some
> > version of this.
>
> Yes, don't worry, I had some feedback from Alper but have given up on
> that approach.

Regards,
Simon
