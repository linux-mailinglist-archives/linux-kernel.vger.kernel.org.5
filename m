Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACD57AF1BD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjIZR3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjIZR32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:29:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58639124
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 10:29:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CF0C433C7;
        Tue, 26 Sep 2023 17:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695749359;
        bh=qrBeQ51Dvxv01D+MaeOf5SpdgRWicIvEOSKVURSSzjA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jLKAuoY9Tq+nBCfB3Rsekoz5TWyvDE4Cz2iyx889195Ydz/Bm/vK+0uAblBSwOgyT
         4HO5gJ2LGgExjKXjYF0WDHcIHP6HAV8q6MsvQH2Fa1ungePnpAHr10Ac/tnY6eflVJ
         wjq7Vx2X7c2MBRDvXAl3jvH6oNjT60/1eozlWbuwyWY/AoV1eIJTb8yOWAOzl/ioDN
         MrsGgHSHIjl/waRnu0LdfdrngFegEjL6CM/V1e5yav3vZ07wwDPy3N3UER3Udxb7Cp
         AzFdLBUnvAPAvadGS6HFaFsJ2/0UvPysGZzaf6YxRMh6z8Lbfna7ZlsIvtG+t06sZa
         NCCbbM6N4VJlQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5041335fb9cso14979399e87.0;
        Tue, 26 Sep 2023 10:29:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YwkSIYyPqCqIonIGl6/fKZIjNMmviVPvhJPb3yU7v53OgUfVk0z
        E5SvC6A7lNNsEZhuoN3w542LYqNiTxVNKlS34g==
X-Google-Smtp-Source: AGHT+IF4jsYIOlWRMaDBVtY1ZGg0bMgAPx9E8v3RDGUGPZuPx/gUDtti2upRNZGqjvQTlkNrF5gZRcr/muks4aGOsIc=
X-Received: by 2002:a05:6512:2520:b0:500:8022:3dc7 with SMTP id
 be32-20020a056512252000b0050080223dc7mr9331056lfb.10.1695749358093; Tue, 26
 Sep 2023 10:29:18 -0700 (PDT)
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
 <CAPnjgZ1npHPpwPmw2f4=E3U5=RH0m4R+W_MZ7+oXdmDF=EeUjg@mail.gmail.com> <20230926094815.5802e184@xps-13>
In-Reply-To: <20230926094815.5802e184@xps-13>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 26 Sep 2023 12:29:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL_8bhHkHOFL8a8=g1dYL4OY8hGuNDyc0Jz22rEuJzXtQ@mail.gmail.com>
Message-ID: <CAL_JsqL_8bhHkHOFL8a8=g1dYL4OY8hGuNDyc0Jz22rEuJzXtQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd: Add a schema for binman
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Simon Glass <sjg@chromium.org>
Cc:     devicetree@vger.kernel.org,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 2:48=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hello,
>
> > > > > > These are firmware bindings, as indicated, but I
> > > > > > took them out of the /firmware node since that is for a differe=
nt
> > > > > > purpose. Rob suggested that partitions was a good place. We hav=
e fwupd
> > > > > > using DT to hold the firmware-update information, so I expect i=
t will
> > > > > > move to use these bindings too.
> > > > >
> > > > > I would definitely use fixed partitions as that's what you need t=
hen:
> > > > > registering where everything starts and ends. If you have "in-ban=
d"
> > > > > meta data you might require a compatible, but I don't think you
> > > > > do, in this case you should probably carry the content through a =
label
> > > > > (which will become the partition name) and we can discuss additio=
nal
> > > > > properties if needed.
> > > >
> > > > I believe I am going to need a compatible string at the 'partitions=
'
> > > > level to indicate that this is the binman scheme. But we can leave
> > > > that until later.
> > >
> > > Perhaps:
> > >
> > > compatible =3D "binman", "fixed-partitions";
> > >
> > > Though I don't understand why binman couldn't just understand what
> > > "fixed-partitions" means rather than "binman".
> >
> > Well so long as we don't add any binman things in here, you are right.
> >
> > But the eventual goal is parity with current Binman functionality,
> > which writes the entire (augmented) description to the DT, allowing
> > tools to rebuild / repack / replace pieces later, maintaining the same
> > alignment constraints, etc. I am assuming that properties like 'align
> > =3D <16>' would not fit with fixed-partitions.
>
> I am personally not bothered by this kind of properties. But if we plan
> on adding too much properties, I will advise to indeed use another name
> than fixed-partitions (or add the "binman" secondary compatible)
> otherwise it's gonna be hard to support in the code while still
> restraining as much as we can the other partition schema.

Agreed. It's a trade off. I think we need enough to understand the
problem (not just presented with a solution), agree on the general
solution/direction, and then discuss specific additions.

> > But if we don't preserve
> > these properties then Binman cannot do repacking reliably. Perhaps for
> > now I could put the augmented DT in its own section somewhere, but I
> > am just not sure if that will work in a real system. E.g. with VBE the
> > goal is to use the DT to figure out how to access the firmware, update
> > it, etc.

VBE?

> > Is it not possible to have my own node with whatever things Binman
> > needs in it (subject to review of course)? i.e. could we discuss how
> > to encode it, but argue less about whether things are needed? I
> > kind-of feel I know what is needed, since I wrote the tool.

What we don't need is the same information in 2 places for the DTB
used at runtime. If the binman node is removed, do whatever you want.
If you want to keep it at runtime, then it's got to extend what we
already have.

I don't think anyone is disagreeing about whether specific information
is needed or not.

> > > > So you are suggesting 'label' for the contents. Rob suggested
> > > > 'compatible' [1], so what should I do?
> > >
> > > "label" is for consumption by humans, not tools/software. Compatible
> > > values are documented, label values are not. Though the partition
> > > stuff started out using label long ago and it's evolved to preferring
> > > compatible.
> >
> > OK so we are agreed that we are going with 'compatible'.
>
> Still strongly disagree here.

Miquel is right. I was confused here. "label" is still pretty much
used for what the image is. Though we do have "u-boot,env" for both it
seems.

My position on "label" stands. To the extent we have images for common
components, I think we should standardize the names. Certainly if
tools rely on the names, then they should be documented.


> My understanding is that a compatible carries how the content is
> organized, and how this maybe specific (like you have in-band meta data
> data that needs to be parsed in a specific way or in your case
> additional specific properties in the DT which give more context about
> how the data is stored). But the real content of the partition, ie. if
> it contains a firmware, the kernel or some user data does not belong to
> the compatible.
>
> I.e:
> - The first byte of my partition gives the compression algorithm:
>   -> compatible =3D "compressed-partition-foo";
>      or
>   -> compatible =3D "fixed-partitions" + compression-algorithm =3D "foo";
> - The partition contains a picture of my dog:
>   -> label =3D "my dog is beautiful"
>   but certainly not
>   -> compatible =3D "my-dog";

IMO, compatible in this case should convey "JPEG image" or similar.

> I don't see why, for the binman schema, we could not constrain the
> labels?

Yes, but those should follow what we already have. "u-boot" for
example rather than "data,u-boot" which I think Simon had in some
version of this.

Rob
