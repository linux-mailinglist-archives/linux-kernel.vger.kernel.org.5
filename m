Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634F27ADF45
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjIYStl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjIYStj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:49:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEBEB8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:49:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B09C433D9;
        Mon, 25 Sep 2023 18:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695667772;
        bh=+rcy4oYAhba9wCyLwGbxX2HdccPNPodqOPJo6IEv+Zs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h8HpK/K+JNku8lmwmMNxoufWJOItCjPCi/g42NpWdooJcaidgyNGKIyEraqlT0b3B
         KkemmWKJLU+NVACs0fBZL2AxSWBntKOybYk+3ljPvdwkaj2KH9fFwSeFsE+gcI4Fgx
         TPvIfgMPJCh3AL2cqLbcEaKK0NXtoWjawqQAdacQE84+Trqyo1DLdTBiCMWoWiden0
         pS3BZAbkXTFe2kL4ShpESGqZrGvS7XX/T2mDFiKl2Ntf1BkDuuEtdKfPtrXCdUUC+R
         4s5+peO5db482uGrgAUQbwcwqzSjAbefuvnVvCJ0Ja4B0xR8c2uvBI0eAw+KIJd4C9
         Q/kOQXKuQovTg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5042f391153so8339805e87.1;
        Mon, 25 Sep 2023 11:49:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YwMBvEsBTPJCUPPCx2Mq2aXLJXRgVXyt198zK4bJ/NIzXr4Ut/k
        WsTsG6ok9kVi+iMRC9JR+HRc40Qzo20pfLiA0g==
X-Google-Smtp-Source: AGHT+IGcHkOdCdPfbzp5VC5myRrLOdVgIvfsU2VlMZvLU+MhLgLmRzzSK/ci9n3/LNSjtTK1Mz2yOzkxqKrQowyQlHw=
X-Received: by 2002:a05:6512:1598:b0:503:a1b:d0c5 with SMTP id
 bp24-20020a056512159800b005030a1bd0c5mr215163lfb.14.1695667770401; Mon, 25
 Sep 2023 11:49:30 -0700 (PDT)
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
In-Reply-To: <CAPnjgZ20c9FsYVjSrQ9qbFy9Y67BqDP2zxMyATx===PFhO69Ew@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 25 Sep 2023 13:49:17 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJfjHqtTB2qfLmNxmQtn1rZewNyNe+Knu_Z4UCdPoPhSQ@mail.gmail.com>
Message-ID: <CAL_JsqJfjHqtTB2qfLmNxmQtn1rZewNyNe+Knu_Z4UCdPoPhSQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd: Add a schema for binman
To:     Simon Glass <sjg@chromium.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 11:25=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Miquel,
>
> On Mon, 25 Sept 2023 at 09:24, Miquel Raynal <miquel.raynal@bootlin.com> =
wrote:
> >
> > Hi Simon,
> >
> > > > > > > > > > > I was assuming that I should create a top-level compa=
tible =3D "binman"
> > > > > > > > > > > node, with subnodes like compatible =3D "binman,bl31-=
atf", for example.
> > > > > > > > > > > I should use the compatible string to indicate the co=
ntents, right?
> > > > > > > > > >
> > > > > > > > > > Yes for subnodes, and we already have some somewhat sta=
ndard ones for
> > > > > > > > > > "u-boot" and "u-boot-env". Though historically, "label"=
 was used.
> > > > > > > > >
> > > > > > > > > Binman has common properties for all entries, including "=
compress"
> > > > > > > > > which sets the compression algorithm.
> > > > > > > >
> > > > > > > > I see no issue with adding that. It seems useful and someth=
ing missing
> > > > > > > > in the existing partition schemas.
> > > > > > >
> > > > > > > OK I sent a patch with that.
> > > > > > >
> > > > > > > >
> > > > > > > > > So perhaps I should start by defining a new binman,bl31-a=
tf which has
> > > > > > > > > common properties from an "binman,entry" definition?
> > > > > > > >
> > > > > > > > I don't understand the binman prefix. The contents are ATF =
(or TF-A
> > > > > > > > now). Who wrote it to the flash image is not relevant.
> > > > > > >
> > > > > > > Are you suggesting just "atf-bl31", or "arm,atf-bl31" ? Or sh=
ould we
> > > > > > > change it to "tfa-bl31"?
> > > > > >
> > > > > > I don't really understand the relationship with TF-A here. Can'=
t we
> > > > > > just have a kind of fixed-partitions with additional properties=
 like
> > > > > > the compression?
> > > > >
> > > > > Binman needs to know what to put in there, which is the purpose o=
f the
> > > > > compatible string.
> > > >
> > > > But "what" should be put inside the partition is part of the input
> > > > argument, not the output. You said (maybe I got this wrong) that th=
e
> > > > schema would apply to the output of binman. If you want to let user
> > > > know what's inside, maybe it is worth adding a label, but otherwise=
 I
> > > > don't like the idea of a compatible for that, which for me would me=
an:
> > > > "here is how to handle that specific portion of the flash/here is h=
ow
> > > > the flash is organized".
> > >
> > > But I thought that the compatible string was for that purpose? See fo=
r
> > > example "brcm,bcm4908-firmware" and "brcm,bcm963xx-imagetag" and
> > > "linksys,ns-firmware".
> >
> > These three examples apparently need specific handling, the partitions
> > contain meta-data that a parser needs to check or something like that.
> > And finally it looks like partition names are set depending on the
> > content that was discovered, so yes, the partition name is likely the
> > good location to tell users/OSes what's inside.
> >
> > > > > > Also, I still don't understand the purpose of this schema. So b=
inman
> > > > > > generates an image, you want to flash this image and you would =
like the
> > > > > > tool to generate the corresponding (partition) DT snippet autom=
atically.
> > > > > > Do I get this right? I don't get why you would need new compati=
bles for
> > > > > > that.
> > > > >
> > > > > It is actually the other way around. The schema tells Binman how =
to
> > > > > build the image (what goes in there and where). Then outputs an
> > > > > updated DT which describes where everything ended up, for use by =
other
> > > > > tools, e.g. firmware update. It is a closed loop in that sense. S=
ee
> > > > > the references for more information.
> > > >
> > > > Maybe I fail to see why you would want these description to be
> > > > introduced here, if they are not useful to the OS.
> > >
> > > Well I was asked to send them to Linux since they apparently don't
> > > belong in dt-schema.

That is not what I said. I said fixed-partitions should be extended. I
prefer they are extended in-place before moving them rather than the
other way around.

> > > These are firmware bindings, as indicated, but I
> > > took them out of the /firmware node since that is for a different
> > > purpose. Rob suggested that partitions was a good place. We have fwup=
d
> > > using DT to hold the firmware-update information, so I expect it will
> > > move to use these bindings too.
> >
> > I would definitely use fixed partitions as that's what you need then:
> > registering where everything starts and ends. If you have "in-band"
> > meta data you might require a compatible, but I don't think you
> > do, in this case you should probably carry the content through a label
> > (which will become the partition name) and we can discuss additional
> > properties if needed.
>
> I believe I am going to need a compatible string at the 'partitions'
> level to indicate that this is the binman scheme. But we can leave
> that until later.

Perhaps:

compatible =3D "binman", "fixed-partitions";

Though I don't understand why binman couldn't just understand what
"fixed-partitions" means rather than "binman".


> So you are suggesting 'label' for the contents. Rob suggested
> 'compatible' [1], so what should I do?

"label" is for consumption by humans, not tools/software. Compatible
values are documented, label values are not. Though the partition
stuff started out using label long ago and it's evolved to preferring
compatible.

> With this schema, would every node be called 'partition@...' or is
> there flexibility to use other names?

The preference is to use generic names. Do you mean without a
unit-address or different from "partition"? The need for the input
side of binman to have dynamic addresses seems like the biggest issue.
That's allowed in other cases with "partition-N" or "partition-foo"
IIRC. I don't think we want to allow that for "fixed-partitions" at
least in the DTB (i.e. the output side of binman).

Rob
