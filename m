Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6227B0A86
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjI0QoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjI0QoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:44:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9735A92
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:44:05 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso1477090566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695833044; x=1696437844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcujhrU25HQKsgbtffe4PcFl3+JaEKqz22NSzbLOb4g=;
        b=Y7nYGMS9YDb5KaYjVXsNj7kZIyaAtfbJlNDk/0DWAhyYaS+YHcXvBF3cDqe+UFqnDk
         ZAB9m+LkxhpAmC52GUtacu6qifA3Jbt4zYzMi9pZo4y5fnMjuN1KEr+iWAec3YKc8jEy
         /4hWAq3ns0d8q925npGLp7CUe4xYpoY2ZKTYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695833044; x=1696437844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcujhrU25HQKsgbtffe4PcFl3+JaEKqz22NSzbLOb4g=;
        b=CL7MYXqkgvtLZTGRSDzfa8N16v7uvhurUKDqtFE1DXwJJxtwA20pPE+Z8j4otDzMkL
         UmzCJ1tBJD2XwURp+dKEv3a9eKhpPD28Ep2CDV+iVc7ol4Z2esnElk5Mo1yqzBgAvmMT
         NduTRCkNdiYJFWbO1hx1OpRD+LUHWXOM6XFyIBesySJj9ofzhsbu1y3I2ydSk76UecyE
         qgLbakjbPIyMJ4zt1LXEsxFB/+XYG8dLndVxEPJs3svoSm8fm5Yj1pHY3YnYeTtQxdcK
         qrXqjjXEIB4enQmLPvTh/EWD8EJhOqHow4M3WVBBmqlae6jaDRRCCHLDGCHYphXikDRX
         2OdQ==
X-Gm-Message-State: AOJu0YxqWKuHEdlcfLQMuCfev5FVfhwqukTJ/BT7tXS2R3hZeoq9E5yh
        DyrrZ8YrgqQ/x9d39Q3cl/bUTGwCOdSCUzfPGi9ahA==
X-Google-Smtp-Source: AGHT+IGjSTTn0TUpQ1DCRB1+f6e4rbY/7N18XVnUUcFUhIo/5Tr3gMG3e0hk0zOQ7YAOaa3AfsMHDj5Vbcx4NnL4Z3k=
X-Received: by 2002:a50:ee0b:0:b0:52e:86b3:a4a6 with SMTP id
 g11-20020a50ee0b000000b0052e86b3a4a6mr2384623eds.29.1695833043736; Wed, 27
 Sep 2023 09:44:03 -0700 (PDT)
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
In-Reply-To: <CAL_JsqL_8bhHkHOFL8a8=g1dYL4OY8hGuNDyc0Jz22rEuJzXtQ@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Wed, 27 Sep 2023 10:43:45 -0600
Message-ID: <CAPnjgZ3TJLaRzv_cXyLdpRBtc2-FBYQ=gk-_MhEDH47HvO71FQ@mail.gmail.com>
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

Hi Rob,

On Tue, 26 Sept 2023 at 11:29, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Sep 26, 2023 at 2:48=E2=80=AFAM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
> >
> > Hello,
> >
> > > > > > > These are firmware bindings, as indicated, but I
> > > > > > > took them out of the /firmware node since that is for a diffe=
rent
> > > > > > > purpose. Rob suggested that partitions was a good place. We h=
ave fwupd
> > > > > > > using DT to hold the firmware-update information, so I expect=
 it will
> > > > > > > move to use these bindings too.
> > > > > >
> > > > > > I would definitely use fixed partitions as that's what you need=
 then:
> > > > > > registering where everything starts and ends. If you have "in-b=
and"
> > > > > > meta data you might require a compatible, but I don't think you
> > > > > > do, in this case you should probably carry the content through =
a label
> > > > > > (which will become the partition name) and we can discuss addit=
ional
> > > > > > properties if needed.
> > > > >
> > > > > I believe I am going to need a compatible string at the 'partitio=
ns'
> > > > > level to indicate that this is the binman scheme. But we can leav=
e
> > > > > that until later.
> > > >
> > > > Perhaps:
> > > >
> > > > compatible =3D "binman", "fixed-partitions";
> > > >
> > > > Though I don't understand why binman couldn't just understand what
> > > > "fixed-partitions" means rather than "binman".
> > >
> > > Well so long as we don't add any binman things in here, you are right=
.
> > >
> > > But the eventual goal is parity with current Binman functionality,
> > > which writes the entire (augmented) description to the DT, allowing
> > > tools to rebuild / repack / replace pieces later, maintaining the sam=
e
> > > alignment constraints, etc. I am assuming that properties like 'align
> > > =3D <16>' would not fit with fixed-partitions.
> >
> > I am personally not bothered by this kind of properties. But if we plan
> > on adding too much properties, I will advise to indeed use another name
> > than fixed-partitions (or add the "binman" secondary compatible)
> > otherwise it's gonna be hard to support in the code while still
> > restraining as much as we can the other partition schema.
>
> Agreed. It's a trade off. I think we need enough to understand the
> problem (not just presented with a solution), agree on the general
> solution/direction, and then discuss specific additions.
>
> > > But if we don't preserve
> > > these properties then Binman cannot do repacking reliably. Perhaps fo=
r
> > > now I could put the augmented DT in its own section somewhere, but I
> > > am just not sure if that will work in a real system. E.g. with VBE th=
e
> > > goal is to use the DT to figure out how to access the firmware, updat=
e
> > > it, etc.
>
> VBE?
>
> > > Is it not possible to have my own node with whatever things Binman
> > > needs in it (subject to review of course)? i.e. could we discuss how
> > > to encode it, but argue less about whether things are needed? I
> > > kind-of feel I know what is needed, since I wrote the tool.
>
> What we don't need is the same information in 2 places for the DTB
> used at runtime. If the binman node is removed, do whatever you want.
> If you want to keep it at runtime, then it's got to extend what we
> already have.
>
> I don't think anyone is disagreeing about whether specific information
> is needed or not.
>
> > > > > So you are suggesting 'label' for the contents. Rob suggested
> > > > > 'compatible' [1], so what should I do?
> > > >
> > > > "label" is for consumption by humans, not tools/software. Compatibl=
e
> > > > values are documented, label values are not. Though the partition
> > > > stuff started out using label long ago and it's evolved to preferri=
ng
> > > > compatible.
> > >
> > > OK so we are agreed that we are going with 'compatible'.
> >
> > Still strongly disagree here.
>
> Miquel is right. I was confused here. "label" is still pretty much
> used for what the image is. Though we do have "u-boot,env" for both it
> seems.
>
> My position on "label" stands. To the extent we have images for common
> components, I think we should standardize the names. Certainly if
> tools rely on the names, then they should be documented.

OK thanks for clearing that up.

But at present 'label' is free-form text. If I change it to an enum,
won't that break things? If not, how do I actually do it?

There is a u-boot.yaml but it doesn't actually have a "u-boot" label
in the schema. In fact it seems that the label is not validated at
all?

>
>
> > My understanding is that a compatible carries how the content is
> > organized, and how this maybe specific (like you have in-band meta data
> > data that needs to be parsed in a specific way or in your case
> > additional specific properties in the DT which give more context about
> > how the data is stored). But the real content of the partition, ie. if
> > it contains a firmware, the kernel or some user data does not belong to
> > the compatible.
> >
> > I.e:
> > - The first byte of my partition gives the compression algorithm:
> >   -> compatible =3D "compressed-partition-foo";
> >      or
> >   -> compatible =3D "fixed-partitions" + compression-algorithm =3D "foo=
";
> > - The partition contains a picture of my dog:
> >   -> label =3D "my dog is beautiful"
> >   but certainly not
> >   -> compatible =3D "my-dog";
>
> IMO, compatible in this case should convey "JPEG image" or similar.
>
> > I don't see why, for the binman schema, we could not constrain the
> > labels?
>
> Yes, but those should follow what we already have. "u-boot" for
> example rather than "data,u-boot" which I think Simon had in some
> version of this.

Yes, don't worry, I had some feedback from Alper but have given up on
that approach.

Regards,
Simon
