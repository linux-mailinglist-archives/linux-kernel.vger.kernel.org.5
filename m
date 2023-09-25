Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C0D7ADAA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjIYOy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjIYOyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:54:25 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B93103
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:54:17 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d776e1f181bso7740276276.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695653657; x=1696258457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAs/h3x9h+77khWIK3iPvQFPgGZ4y9rDhC59IFJZTGw=;
        b=fnQcBfjLLh1mKBUQWy7wvpr1QOrrcCchV0wcyAN7AUSm8NlJQcsaEireWheIiExX5Z
         z3tlSyziRTJ4IXVYkWUuRMVoDIdgrk/fVfI81HH6WAXCfrIAlBd7i3rh5VNob5SI11xF
         6pQBnAN3Jg23SSQ2MXBLEIZ+q52pZIU5ysQ3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695653657; x=1696258457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAs/h3x9h+77khWIK3iPvQFPgGZ4y9rDhC59IFJZTGw=;
        b=ojd6nCPsVJl61K6jlTsI+FHwwd2TZTpKedXy00CP/PMOrbhhKxtJzgpDYWB+e17cxK
         AxKOq38oVCsUDtOsxGWXN+ag2d1PAhYxw9z1sr436BENrqIys4Sn9gGesHOq5uUOFUOL
         W+0X7nBjIl4vu/bBQdka4SF4mwLuhFodrT18duEpDUyMw0pvdxtqjJ48rJ4cRQyoIu2r
         FNAw1lA2/xCBXYRWn39auw42FUaYgAaGXB69pxZ7tojxVfwOSej6rQ1qNh7oIAsp+aAX
         tRzDQUt+aJt+M7hFChoSR7MdzcXlLixb3mY6Y3zA5hHEtIgtzp/FoEYB5fskCiSTUy6N
         ytpw==
X-Gm-Message-State: AOJu0Yyl/YT2cJNL2gy20RvLt3tRwux+UbOtU0YRGihl3Wtkr8MjBCFg
        RufM8H2p1ie247mYj0d93VVDQWCiiBOBc5/IMCvbwA==
X-Google-Smtp-Source: AGHT+IHzjHIDz/yn/ztOldBZssnouHhhnprKKe22wtVgmt4CE9tlbt9a7WbVTOT55WwDR4WjkXVN84l//rbWRTHR4cI=
X-Received: by 2002:a25:77c7:0:b0:d7b:9bd7:f280 with SMTP id
 s190-20020a2577c7000000b00d7b9bd7f280mr7664332ybc.0.1695653656597; Mon, 25
 Sep 2023 07:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
 <CAL_Jsq+WuYDU+yY98opTHr1PT-J9mFYJQBjVMnk+FSWLDUO33w@mail.gmail.com>
 <CAPnjgZ1pfxaMG1n5yOBhiOhsNrRjck1K92U7Ga=+VTY_jjjrVg@mail.gmail.com>
 <20230922174649.GA3320366-robh@kernel.org> <CAPnjgZ3ojfAv=BHqOhM=-NnYqCm81Ny=PsGKiNphKTmw++fk9w@mail.gmail.com>
 <CAL_JsqJqvyP=c93DHDO8A5RXv7Lz_Z7eEHSbJQ=JCo+qPVhSfg@mail.gmail.com>
 <CAPnjgZ3BnD9aX3cNNPiGRKTOj+YeurHCLv6K0TRFhAtY21Qufw@mail.gmail.com>
 <20230925092122.0b615f25@xps-13> <CAPnjgZ0Z5J_33HuQF-5XgDFmZim0nHHzvZJOOZobWw_cOJd=9g@mail.gmail.com>
 <20230925164736.5efbf4c0@xps-13>
In-Reply-To: <20230925164736.5efbf4c0@xps-13>
From:   Simon Glass <sjg@chromium.org>
Date:   Mon, 25 Sep 2023 08:53:59 -0600
Message-ID: <CAPnjgZ3YCQHJ-eXuX8rYx2Qb6QEL+XviFmXYTON6M-sGPWSBBg@mail.gmail.com>
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

On Mon, 25 Sept 2023 at 08:47, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:
>
> Hi Simon,
>
> sjg@chromium.org wrote on Mon, 25 Sep 2023 06:33:14 -0600:
>
> > Hi Miquel,
> >
> > On Mon, 25 Sept 2023 at 01:21, Miquel Raynal <miquel.raynal@bootlin.com=
> wrote:
> > >
> > > Hi Simon,
> > >
> > > sjg@chromium.org wrote on Fri, 22 Sep 2023 13:51:14 -0600:
> > >
> > > > Hi Rob,
> > > >
> > > > On Fri, 22 Sept 2023 at 13:43, Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Fri, Sep 22, 2023 at 1:12=E2=80=AFPM Simon Glass <sjg@chromium=
.org> wrote:
> > > > > >
> > > > > > Hi Rob,
> > > > > >
> > > > > > On Fri, 22 Sept 2023 at 11:46, Rob Herring <robh@kernel.org> wr=
ote:
> > > > > > >
> > > > > > > On Fri, Sep 22, 2023 at 11:01:18AM -0600, Simon Glass wrote:
> > > > > > > > Hi Rob,
> > > > > > > >
> > > > > > > > On Fri, 22 Sept 2023 at 10:00, Rob Herring <robh@kernel.org=
> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Sep 21, 2023 at 1:45=E2=80=AFPM Simon Glass <sjg@=
chromium.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Binman[1] is a tool for creating firmware images. It al=
lows you to
> > > > > > > > > > combine various binaries and place them in an output fi=
le.
> > > > > > > > > >
> > > > > > > > > > Binman uses a DT schema to describe an image, in enough=
 detail that
> > > > > > > > > > it can be automatically built from component parts, dis=
assembled,
> > > > > > > > > > replaced, listed, etc.
> > > > > > > > > >
> > > > > > > > > > Images are typically stored in flash, which is why this=
 binding is
> > > > > > > > > > targeted at mtd. Previous discussion is at [2] [3].
> > > > > > > > > >
> > > > > > > > > > [1] https://u-boot.readthedocs.io/en/stable/develop/pac=
kage/binman.html
> > > > > > > > > > [2] https://lore.kernel.org/u-boot/20230821180220.27240=
80-3-sjg@chromium.org/
> > > > > > > > > > [3] https://www.spinics.net/lists/devicetree/msg626149.=
html
> > > > > > > > >
> > > > > > > > > You missed:
> > > > > > > > >
> > > > > > > > > https://github.com/devicetree-org/dt-schema/pull/110
> > > > > > > > >
> > > > > > > > > where I said: We certainly shouldn't duplicate the existi=
ng partitions
> > > > > > > > > bindings. What's missing from them (I assume we're mostly=
 talking
> > > > > > > > > about "fixed-partitions" which has been around forever I =
think (before
> > > > > > > > > me))?
> > > > > > > > >
> > > > > > > > > To repeat, unless there is some reason binman partitions =
conflict with
> > > > > > > > > fixed-partitions, you need to start there and extend it. =
From what's
> > > > > > > > > posted here, it neither conflicts nor needs extending.
> > > > > > > >
> > > > > > > > I think at this point I am just hopelessly confused. Have y=
ou taken a
> > > > > > > > look at the binman schema? [1]
> > > > > > >
> > > > > > > Why do I need to? That's used for some tool and has nothing t=
o do with a
> > > > > > > device's DTB. However, I thought somewhere in this discussion=
 you showed
> > > > > > > it under a flash device node.
> > > > > >
> > > > > > Yes, that is the intent (under a flash node).
> > > > > >
> > > > > > > Then I care because then it overlaps with
> > > > > > > what we already have for partitions. If I misunderstood that,=
 then just
> > > > > > > put your schema with your tool. Only users of the tool should=
 care about
> > > > > > > the tool's schema.
> > > > > >
> > > > > > OK. I believe that binman will fit into both camps, since its i=
nput is
> > > > > > not necessarily fully formed. E.g. if you don't specify the off=
set of
> > > > > > an entry, then it will be packed automatically. But the output =
is
> > > > > > fully formed, in that Binman now knows the offset so can write =
it to
> > > > > > the DT.
> > > > >
> > > > > I suppose it could take its own format as input and then write ou=
t
> > > > > something different for the "on the device" format (i.e.
> > > > > fixed-partitions). At least for the dynamic offsets, we may need
> > > > > something allowed for binman input, but not allowed on device. In
> > > > > general, there is support for partitions without addresses/offset=
s,
> > > > > but only for partitions that have some other way to figure that o=
ut
> > > > > (on disk partition info).
> > > > >
> > > > > There's also the image filename which doesn't really belong in th=
e on
> > > > > device partitions. So maybe the input and output schemas should b=
e
> > > > > separate.
> > > >
> > > > OK, I'll focus on the output schema for now. I suspect this will be=
 a
> > > > grey area though.
> > > >
> > > > As an example, if you replace a binary in the firmware, Binman can
> > > > repack the firmware to make room, respecting the alignment and size
> > > > constraints. So these need to be in the output schema somehow.
> > > >
> > > > >
> > > > > > > > I saw this file, which seems to extend a partition.
> > > > > > > >
> > > > > > > > Documentation/devicetree/bindings/mtd/partitions/brcm,bcm49=
08-partitions.yaml
> > > > > > >
> > > > > > > IIRC, that's a different type where partition locations are s=
tored in
> > > > > > > the flash, so we don't need location and size in DT.
> > > > > >
> > > > > > OK.
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > I was assuming that I should create a top-level compatible =
=3D "binman"
> > > > > > > > node, with subnodes like compatible =3D "binman,bl31-atf", =
for example.
> > > > > > > > I should use the compatible string to indicate the contents=
, right?
> > > > > > >
> > > > > > > Yes for subnodes, and we already have some somewhat standard =
ones for
> > > > > > > "u-boot" and "u-boot-env". Though historically, "label" was u=
sed.
> > > > > >
> > > > > > Binman has common properties for all entries, including "compre=
ss"
> > > > > > which sets the compression algorithm.
> > > > >
> > > > > I see no issue with adding that. It seems useful and something mi=
ssing
> > > > > in the existing partition schemas.
> > > >
> > > > OK I sent a patch with that.
> > > >
> > > > >
> > > > > > So perhaps I should start by defining a new binman,bl31-atf whi=
ch has
> > > > > > common properties from an "binman,entry" definition?
> > > > >
> > > > > I don't understand the binman prefix. The contents are ATF (or TF=
-A
> > > > > now). Who wrote it to the flash image is not relevant.
> > > >
> > > > Are you suggesting just "atf-bl31", or "arm,atf-bl31" ? Or should w=
e
> > > > change it to "tfa-bl31"?
> > >
> > > I don't really understand the relationship with TF-A here. Can't we
> > > just have a kind of fixed-partitions with additional properties like
> > > the compression?
> >
> > Binman needs to know what to put in there, which is the purpose of the
> > compatible string.
>
> But "what" should be put inside the partition is part of the input
> argument, not the output. You said (maybe I got this wrong) that the
> schema would apply to the output of binman. If you want to let user
> know what's inside, maybe it is worth adding a label, but otherwise I
> don't like the idea of a compatible for that, which for me would mean:
> "here is how to handle that specific portion of the flash/here is how
> the flash is organized".

But I thought that the compatible string was for that purpose? See for
example "brcm,bcm4908-firmware" and "brcm,bcm963xx-imagetag" and
"linksys,ns-firmware".

What mechanism do you suggest be used here?

>
> > > > > We already have some compatibles in use. We should reuse them if
> > > > > possible. Not sure about TF-A though.
> > > >
> > > > OK.
> > > >
> > >
> > > Also, I still don't understand the purpose of this schema. So binman
> > > generates an image, you want to flash this image and you would like t=
he
> > > tool to generate the corresponding (partition) DT snippet automatical=
ly.
> > > Do I get this right? I don't get why you would need new compatibles f=
or
> > > that.
> >
> > It is actually the other way around. The schema tells Binman how to
> > build the image (what goes in there and where). Then outputs an
> > updated DT which describes where everything ended up, for use by other
> > tools, e.g. firmware update. It is a closed loop in that sense. See
> > the references for more information.
>
> Maybe I fail to see why you would want these description to be
> introduced here, if they are not useful to the OS.

Well I was asked to send them to Linux since they apparently don't
belong in dt-schema. These are firmware bindings, as indicated, but I
took them out of the /firmware node since that is for a different
purpose. Rob suggested that partitions was a good place. We have fwupd
using DT to hold the firmware-update information, so I expect it will
move to use these bindings too.

>
> > [1] https://u-boot.readthedocs.io/en/latest/develop/package/index.html
> > [2] https://pretalx.com/media/osfc2019/submissions/Y7EN9V/resources/Bin=
man_-_A_data-controlled_firmware_packer_for_U-B_pFU3n2K.pdf
> > [3] https://www.youtube.com/watch?v=3DL84ujgUXBOQ
>

Regards,
Simon
