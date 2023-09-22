Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711307AB8E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjIVSMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjIVSMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:12:49 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394E2C2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:12:33 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-530a6cbbb47so3097072a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695406351; x=1696011151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKwr2XjhB87XY1eJcNFIWSnRqkfq4gGTTTV7rcfgoQg=;
        b=LpsF6LYmtOp2WOyI/N+C7UpruCLsKErGUCoYr/byu2GVQFTvkWa12O87SzGWUdrriv
         E1dDBCZZmi53zQ8onyp3z8F64JeIyM4ZuFxr5twJ533R7qfT0NjOytWq9xBxsdkrrSzH
         rdK+6w9AKDCyEojuX6muvRmArZB/wZJSRKTGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695406351; x=1696011151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKwr2XjhB87XY1eJcNFIWSnRqkfq4gGTTTV7rcfgoQg=;
        b=eUHjQ9aBtDAXSkemBlDeuqayruzGUTQmiWpztEinigvf/jSPzgtmlqxq9iv8SIEDtE
         +BfSibzvnyfOuyYsJ4F4U3NmoRMjUx3GFKZ0+MtPDh4qG/D8uH345rTHu5W7zDUH5e2k
         P0DibOx4+sR6wv0r5LY9VBlLqsG8B/8Te5Ub7FZ+lXQP0NAjCOmqw2QEnXtPC3z/7ncm
         Gk0fvdnmlxbV0ConaYvd1YfHXCwUqXbdljq4JwGhxfGlcE4EDQL8niE5SoBcVFy+Gdi6
         rfeivdxs5SHyI72nun2kkPD+cddoCKg4l+gd9/lDl1ISTU/bJ4IgjtoyQ+3p4bXbMhTq
         mCXA==
X-Gm-Message-State: AOJu0YzHh2MeR9TXlZxIJQR6ggn4gF1HiWQEGSFwCYtsftLIqH5/YG3w
        /z1oNIxoCCbHQvG+qZ1gyPJQ0fO516X/9Dyk4daDFQ==
X-Google-Smtp-Source: AGHT+IEhGuF05gZ1ykRj7c0nOIVSMf034rK4oo9lAlBZB3RlBbcD+8isF0isGviqL5G0fBM/1IdwSOKb/LE2mWFyyHQ=
X-Received: by 2002:aa7:dc17:0:b0:533:926:da9d with SMTP id
 b23-20020aa7dc17000000b005330926da9dmr220253edu.18.1695406351489; Fri, 22 Sep
 2023 11:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
 <CAL_Jsq+WuYDU+yY98opTHr1PT-J9mFYJQBjVMnk+FSWLDUO33w@mail.gmail.com>
 <CAPnjgZ1pfxaMG1n5yOBhiOhsNrRjck1K92U7Ga=+VTY_jjjrVg@mail.gmail.com> <20230922174649.GA3320366-robh@kernel.org>
In-Reply-To: <20230922174649.GA3320366-robh@kernel.org>
From:   Simon Glass <sjg@chromium.org>
Date:   Fri, 22 Sep 2023 12:12:20 -0600
Message-ID: <CAPnjgZ3ojfAv=BHqOhM=-NnYqCm81Ny=PsGKiNphKTmw++fk9w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd: Add a schema for binman
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Dhruva Gole <d-gole@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, 22 Sept 2023 at 11:46, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Sep 22, 2023 at 11:01:18AM -0600, Simon Glass wrote:
> > Hi Rob,
> >
> > On Fri, 22 Sept 2023 at 10:00, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Thu, Sep 21, 2023 at 1:45=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Binman[1] is a tool for creating firmware images. It allows you to
> > > > combine various binaries and place them in an output file.
> > > >
> > > > Binman uses a DT schema to describe an image, in enough detail that
> > > > it can be automatically built from component parts, disassembled,
> > > > replaced, listed, etc.
> > > >
> > > > Images are typically stored in flash, which is why this binding is
> > > > targeted at mtd. Previous discussion is at [2] [3].
> > > >
> > > > [1] https://u-boot.readthedocs.io/en/stable/develop/package/binman.=
html
> > > > [2] https://lore.kernel.org/u-boot/20230821180220.2724080-3-sjg@chr=
omium.org/
> > > > [3] https://www.spinics.net/lists/devicetree/msg626149.html
> > >
> > > You missed:
> > >
> > > https://github.com/devicetree-org/dt-schema/pull/110
> > >
> > > where I said: We certainly shouldn't duplicate the existing partition=
s
> > > bindings. What's missing from them (I assume we're mostly talking
> > > about "fixed-partitions" which has been around forever I think (befor=
e
> > > me))?
> > >
> > > To repeat, unless there is some reason binman partitions conflict wit=
h
> > > fixed-partitions, you need to start there and extend it. From what's
> > > posted here, it neither conflicts nor needs extending.
> >
> > I think at this point I am just hopelessly confused. Have you taken a
> > look at the binman schema? [1]
>
> Why do I need to? That's used for some tool and has nothing to do with a
> device's DTB. However, I thought somewhere in this discussion you showed
> it under a flash device node.

Yes, that is the intent (under a flash node).

> Then I care because then it overlaps with
> what we already have for partitions. If I misunderstood that, then just
> put your schema with your tool. Only users of the tool should care about
> the tool's schema.

OK. I believe that binman will fit into both camps, since its input is
not necessarily fully formed. E.g. if you don't specify the offset of
an entry, then it will be packed automatically. But the output is
fully formed, in that Binman now knows the offset so can write it to
the DT.

>
> >
> > I saw this file, which seems to extend a partition.
> >
> > Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partition=
s.yaml
>
> IIRC, that's a different type where partition locations are stored in
> the flash, so we don't need location and size in DT.

OK.

>
> >
> > I was assuming that I should create a top-level compatible =3D "binman"
> > node, with subnodes like compatible =3D "binman,bl31-atf", for example.
> > I should use the compatible string to indicate the contents, right?
>
> Yes for subnodes, and we already have some somewhat standard ones for
> "u-boot" and "u-boot-env". Though historically, "label" was used.

Binman has common properties for all entries, including "compress"
which sets the compression algorithm.

So perhaps I should start by defining a new binman,bl31-atf which has
common properties from an "binman,entry" definition?

>
> Top-level, meaning the root of the DT? That sound like just something
> for the tool, so I don't care, but it doesn't belong in the DTB.

Sorry, I mean 'top-level' with respect to the partitions.

>
> >
> > Re extending, what is the minimum I can do? Are you looking for
> > something like a "compress" property that indicates that the entry is
> > compressed?
> >
> > I'm really just a bit lost.
>
> Me too.

Regards,
Simon
