Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916D37AD814
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjIYMdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjIYMdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:33:41 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BFCCE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:33:34 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bfed7c4e6dso105481881fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695645212; x=1696250012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOrEG4tfl75vIbxlTDfOPlF5gglTowT9ubBWOy0wGIE=;
        b=XraXWh175C0O1zeaF6oDS5y4MnsE+aL81TMVqOA8Ep1RsgCgNkscjk4Xs8zutgCURc
         Uuz0Dbo8ZZYmSC8Fecdoy1rfUmD2P6ZlDcvNghuSxf79muMlQ7vKhKrioc9ZqvLj+8OW
         pHW1wxxW78wozyS8earWBGR5Ib7a+l1IzH07g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695645212; x=1696250012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOrEG4tfl75vIbxlTDfOPlF5gglTowT9ubBWOy0wGIE=;
        b=NEoBlpZmK5B6UFTtnr0gPDJpdf446xZBBkhCwo5Wy5Cf+ChseiVMtcnSy/lTl9+cLc
         GfJ9o4Y/smt1pyFfy2GBA1M0Qc2KvR3XUzXOYURDfMQw2W6da1d2QqAZzIBbW/A9AiVv
         6o0NdXb++RZHmarwPgrtKCvQagkgmnN0RI+T1X6lc4EvhsXLaxWWmRRFPnOXnp3HGGE9
         lj0dngiXmBCvtBEin9SaqLPJi4MoaiDWqbU/9pZG+BUFrL8ZMpYyw9yClUON4UKLG1q3
         hQbvzNMU/hkloEd7n/fkYivi3GScqpB2ZbQmtXwDI53gMTNsUroXmB32x9jfcH7t27jG
         tDfw==
X-Gm-Message-State: AOJu0Yxw0I9SS3LkMChprWoIH1Cghuwn3ZPKMzkn5Ra6CTogrmvXHPl9
        xqNxHM5KnNTV09+mi9ltLk5glygH/LXmi0qhSWIa3Q==
X-Google-Smtp-Source: AGHT+IHQ2mVoYf0gISCrXjW928D9kOOj+nnB4kchHzakcfJ5+nTvY6NHkpDiRDXDUhEg1TfER0INKlLUgGq8Jiet7Nw=
X-Received: by 2002:ac2:4c9c:0:b0:503:18c3:d87a with SMTP id
 d28-20020ac24c9c000000b0050318c3d87amr5120311lfl.21.1695645212082; Mon, 25
 Sep 2023 05:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
 <CAL_Jsq+WuYDU+yY98opTHr1PT-J9mFYJQBjVMnk+FSWLDUO33w@mail.gmail.com>
 <CAPnjgZ1pfxaMG1n5yOBhiOhsNrRjck1K92U7Ga=+VTY_jjjrVg@mail.gmail.com>
 <20230922174649.GA3320366-robh@kernel.org> <CAPnjgZ3ojfAv=BHqOhM=-NnYqCm81Ny=PsGKiNphKTmw++fk9w@mail.gmail.com>
 <CAL_JsqJqvyP=c93DHDO8A5RXv7Lz_Z7eEHSbJQ=JCo+qPVhSfg@mail.gmail.com>
 <CAPnjgZ3BnD9aX3cNNPiGRKTOj+YeurHCLv6K0TRFhAtY21Qufw@mail.gmail.com> <20230925092122.0b615f25@xps-13>
In-Reply-To: <20230925092122.0b615f25@xps-13>
From:   Simon Glass <sjg@chromium.org>
Date:   Mon, 25 Sep 2023 06:33:14 -0600
Message-ID: <CAPnjgZ0Z5J_33HuQF-5XgDFmZim0nHHzvZJOOZobWw_cOJd=9g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd: Add a schema for binman
To:     Miquel Raynal <miquel.raynal@bootlin.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On Mon, 25 Sept 2023 at 01:21, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:
>
> Hi Simon,
>
> sjg@chromium.org wrote on Fri, 22 Sep 2023 13:51:14 -0600:
>
> > Hi Rob,
> >
> > On Fri, 22 Sept 2023 at 13:43, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Sep 22, 2023 at 1:12=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Rob,
> > > >
> > > > On Fri, 22 Sept 2023 at 11:46, Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Fri, Sep 22, 2023 at 11:01:18AM -0600, Simon Glass wrote:
> > > > > > Hi Rob,
> > > > > >
> > > > > > On Fri, 22 Sept 2023 at 10:00, Rob Herring <robh@kernel.org> wr=
ote:
> > > > > > >
> > > > > > > On Thu, Sep 21, 2023 at 1:45=E2=80=AFPM Simon Glass <sjg@chro=
mium.org> wrote:
> > > > > > > >
> > > > > > > > Binman[1] is a tool for creating firmware images. It allows=
 you to
> > > > > > > > combine various binaries and place them in an output file.
> > > > > > > >
> > > > > > > > Binman uses a DT schema to describe an image, in enough det=
ail that
> > > > > > > > it can be automatically built from component parts, disasse=
mbled,
> > > > > > > > replaced, listed, etc.
> > > > > > > >
> > > > > > > > Images are typically stored in flash, which is why this bin=
ding is
> > > > > > > > targeted at mtd. Previous discussion is at [2] [3].
> > > > > > > >
> > > > > > > > [1] https://u-boot.readthedocs.io/en/stable/develop/package=
/binman.html
> > > > > > > > [2] https://lore.kernel.org/u-boot/20230821180220.2724080-3=
-sjg@chromium.org/
> > > > > > > > [3] https://www.spinics.net/lists/devicetree/msg626149.html
> > > > > > >
> > > > > > > You missed:
> > > > > > >
> > > > > > > https://github.com/devicetree-org/dt-schema/pull/110
> > > > > > >
> > > > > > > where I said: We certainly shouldn't duplicate the existing p=
artitions
> > > > > > > bindings. What's missing from them (I assume we're mostly tal=
king
> > > > > > > about "fixed-partitions" which has been around forever I thin=
k (before
> > > > > > > me))?
> > > > > > >
> > > > > > > To repeat, unless there is some reason binman partitions conf=
lict with
> > > > > > > fixed-partitions, you need to start there and extend it. From=
 what's
> > > > > > > posted here, it neither conflicts nor needs extending.
> > > > > >
> > > > > > I think at this point I am just hopelessly confused. Have you t=
aken a
> > > > > > look at the binman schema? [1]
> > > > >
> > > > > Why do I need to? That's used for some tool and has nothing to do=
 with a
> > > > > device's DTB. However, I thought somewhere in this discussion you=
 showed
> > > > > it under a flash device node.
> > > >
> > > > Yes, that is the intent (under a flash node).
> > > >
> > > > > Then I care because then it overlaps with
> > > > > what we already have for partitions. If I misunderstood that, the=
n just
> > > > > put your schema with your tool. Only users of the tool should car=
e about
> > > > > the tool's schema.
> > > >
> > > > OK. I believe that binman will fit into both camps, since its input=
 is
> > > > not necessarily fully formed. E.g. if you don't specify the offset =
of
> > > > an entry, then it will be packed automatically. But the output is
> > > > fully formed, in that Binman now knows the offset so can write it t=
o
> > > > the DT.
> > >
> > > I suppose it could take its own format as input and then write out
> > > something different for the "on the device" format (i.e.
> > > fixed-partitions). At least for the dynamic offsets, we may need
> > > something allowed for binman input, but not allowed on device. In
> > > general, there is support for partitions without addresses/offsets,
> > > but only for partitions that have some other way to figure that out
> > > (on disk partition info).
> > >
> > > There's also the image filename which doesn't really belong in the on
> > > device partitions. So maybe the input and output schemas should be
> > > separate.
> >
> > OK, I'll focus on the output schema for now. I suspect this will be a
> > grey area though.
> >
> > As an example, if you replace a binary in the firmware, Binman can
> > repack the firmware to make room, respecting the alignment and size
> > constraints. So these need to be in the output schema somehow.
> >
> > >
> > > > > > I saw this file, which seems to extend a partition.
> > > > > >
> > > > > > Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-p=
artitions.yaml
> > > > >
> > > > > IIRC, that's a different type where partition locations are store=
d in
> > > > > the flash, so we don't need location and size in DT.
> > > >
> > > > OK.
> > > >
> > > > >
> > > > > >
> > > > > > I was assuming that I should create a top-level compatible =3D =
"binman"
> > > > > > node, with subnodes like compatible =3D "binman,bl31-atf", for =
example.
> > > > > > I should use the compatible string to indicate the contents, ri=
ght?
> > > > >
> > > > > Yes for subnodes, and we already have some somewhat standard ones=
 for
> > > > > "u-boot" and "u-boot-env". Though historically, "label" was used.
> > > >
> > > > Binman has common properties for all entries, including "compress"
> > > > which sets the compression algorithm.
> > >
> > > I see no issue with adding that. It seems useful and something missin=
g
> > > in the existing partition schemas.
> >
> > OK I sent a patch with that.
> >
> > >
> > > > So perhaps I should start by defining a new binman,bl31-atf which h=
as
> > > > common properties from an "binman,entry" definition?
> > >
> > > I don't understand the binman prefix. The contents are ATF (or TF-A
> > > now). Who wrote it to the flash image is not relevant.
> >
> > Are you suggesting just "atf-bl31", or "arm,atf-bl31" ? Or should we
> > change it to "tfa-bl31"?
>
> I don't really understand the relationship with TF-A here. Can't we
> just have a kind of fixed-partitions with additional properties like
> the compression?

Binman needs to know what to put in there, which is the purpose of the
compatible string.

>
> > > We already have some compatibles in use. We should reuse them if
> > > possible. Not sure about TF-A though.
> >
> > OK.
> >
>
> Also, I still don't understand the purpose of this schema. So binman
> generates an image, you want to flash this image and you would like the
> tool to generate the corresponding (partition) DT snippet automatically.
> Do I get this right? I don't get why you would need new compatibles for
> that.

It is actually the other way around. The schema tells Binman how to
build the image (what goes in there and where). Then outputs an
updated DT which describes where everything ended up, for use by other
tools, e.g. firmware update. It is a closed loop in that sense. See
the references for more information.

Regards,
Simon

[1] https://u-boot.readthedocs.io/en/latest/develop/package/index.html
[2] https://pretalx.com/media/osfc2019/submissions/Y7EN9V/resources/Binman_=
-_A_data-controlled_firmware_packer_for_U-B_pFU3n2K.pdf
[3] https://www.youtube.com/watch?v=3DL84ujgUXBOQ
