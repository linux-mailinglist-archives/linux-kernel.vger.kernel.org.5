Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269CD7ADB55
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjIYPZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjIYPZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:25:00 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392FE111;
        Mon, 25 Sep 2023 08:24:53 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 663B2E000D;
        Mon, 25 Sep 2023 15:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695655491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8FBXEqtw7DtSRFjTe9aE3nB/Na/ZFvYNCCbHQx6230o=;
        b=If4ToL4JciFWlhP8QB7i+HGNSQ5PjcAOqXalI0QhDdwFmD9BgkOWXyqN7Hy81uKwoPVKXs
        imuh8ohuDBbA0kcCFlNI0xLlVk5LycsG2WRP3R+2CNd2Gtw0eacRVNIvVDD2ApbaEV7ryo
        Hsl7TpFluI+3ww7z1C37hmr0AYtvWDXPuycrfnkhoIB4RQd1+WLC2egYWWhxTluCHzEgxR
        1lsJcbGFxGq8nWKbFRsHOCWpJMFYp8rU9u4IbPdmzrxWvUpXm1du4Qt5hB0QIp+SZMsAj5
        YzideTKlcCvf34tYWU/LfWdvvmGj1P7UfPY4H916H/cNJEp2t+HosA/1whxyWA==
Date:   Mon, 25 Sep 2023 17:24:47 +0200
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
Message-ID: <20230925172447.43dcef88@xps-13>
In-Reply-To: <CAPnjgZ3YCQHJ-eXuX8rYx2Qb6QEL+XviFmXYTON6M-sGPWSBBg@mail.gmail.com>
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

> > > > > > > > > I was assuming that I should create a top-level compatibl=
e =3D "binman"
> > > > > > > > > node, with subnodes like compatible =3D "binman,bl31-atf"=
, for example.
> > > > > > > > > I should use the compatible string to indicate the conten=
ts, right? =20
> > > > > > > >
> > > > > > > > Yes for subnodes, and we already have some somewhat standar=
d ones for
> > > > > > > > "u-boot" and "u-boot-env". Though historically, "label" was=
 used. =20
> > > > > > >
> > > > > > > Binman has common properties for all entries, including "comp=
ress"
> > > > > > > which sets the compression algorithm. =20
> > > > > >
> > > > > > I see no issue with adding that. It seems useful and something =
missing
> > > > > > in the existing partition schemas. =20
> > > > >
> > > > > OK I sent a patch with that.
> > > > > =20
> > > > > > =20
> > > > > > > So perhaps I should start by defining a new binman,bl31-atf w=
hich has
> > > > > > > common properties from an "binman,entry" definition? =20
> > > > > >
> > > > > > I don't understand the binman prefix. The contents are ATF (or =
TF-A
> > > > > > now). Who wrote it to the flash image is not relevant. =20
> > > > >
> > > > > Are you suggesting just "atf-bl31", or "arm,atf-bl31" ? Or should=
 we
> > > > > change it to "tfa-bl31"? =20
> > > >
> > > > I don't really understand the relationship with TF-A here. Can't we
> > > > just have a kind of fixed-partitions with additional properties like
> > > > the compression? =20
> > >
> > > Binman needs to know what to put in there, which is the purpose of the
> > > compatible string. =20
> >
> > But "what" should be put inside the partition is part of the input
> > argument, not the output. You said (maybe I got this wrong) that the
> > schema would apply to the output of binman. If you want to let user
> > know what's inside, maybe it is worth adding a label, but otherwise I
> > don't like the idea of a compatible for that, which for me would mean:
> > "here is how to handle that specific portion of the flash/here is how
> > the flash is organized". =20
>=20
> But I thought that the compatible string was for that purpose? See for
> example "brcm,bcm4908-firmware" and "brcm,bcm963xx-imagetag" and
> "linksys,ns-firmware".

These three examples apparently need specific handling, the partitions
contain meta-data that a parser needs to check or something like that.
And finally it looks like partition names are set depending on the
content that was discovered, so yes, the partition name is likely the
good location to tell users/OSes what's inside.

> > > > Also, I still don't understand the purpose of this schema. So binman
> > > > generates an image, you want to flash this image and you would like=
 the
> > > > tool to generate the corresponding (partition) DT snippet automatic=
ally.
> > > > Do I get this right? I don't get why you would need new compatibles=
 for
> > > > that. =20
> > >
> > > It is actually the other way around. The schema tells Binman how to
> > > build the image (what goes in there and where). Then outputs an
> > > updated DT which describes where everything ended up, for use by other
> > > tools, e.g. firmware update. It is a closed loop in that sense. See
> > > the references for more information. =20
> >
> > Maybe I fail to see why you would want these description to be
> > introduced here, if they are not useful to the OS. =20
>=20
> Well I was asked to send them to Linux since they apparently don't
> belong in dt-schema. These are firmware bindings, as indicated, but I
> took them out of the /firmware node since that is for a different
> purpose. Rob suggested that partitions was a good place. We have fwupd
> using DT to hold the firmware-update information, so I expect it will
> move to use these bindings too.

I would definitely use fixed partitions as that's what you need then:
registering where everything starts and ends. If you have "in-band"
meta data you might require a compatible, but I don't think you
do, in this case you should probably carry the content through a label
(which will become the partition name) and we can discuss additional
properties if needed.

> > > [1] https://u-boot.readthedocs.io/en/latest/develop/package/index.html
> > > [2] https://pretalx.com/media/osfc2019/submissions/Y7EN9V/resources/B=
inman_-_A_data-controlled_firmware_packer_for_U-B_pFU3n2K.pdf
> > > [3] https://www.youtube.com/watch?v=3DL84ujgUXBOQ =20
> > =20
>=20
> Regards,
> Simon


Thanks,
Miqu=C3=A8l
