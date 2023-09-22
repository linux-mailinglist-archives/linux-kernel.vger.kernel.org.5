Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E723C7ABA49
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjIVTvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjIVTvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:51:37 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A43BCCC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:51:27 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50435ad51bbso2551936e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695412286; x=1696017086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcpcIFJ61Cgs0SnYetl6zxlaNczsC0YBO5OwWuuMpjg=;
        b=QkjTHSKkkSJK2ZwSPpurcAmT8xgayLrFoPIWEiUTwrLDgeIYREqu9SkOOFEmzLWtyR
         aNALWpPlZW4wZmyezyRKD6UV6PkjWMcwEz0JoZVfgsxecYt20n+k7g9234F8N/3gYAlW
         /VJYgZ9hJXJYfzi0FJ8KVQ7vQTKaZT1UglfEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695412286; x=1696017086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcpcIFJ61Cgs0SnYetl6zxlaNczsC0YBO5OwWuuMpjg=;
        b=GVVWdYem+ppHY4X0/HhtoMGLXz86mQx6xfoZpxhr0/DdHmdCSLW0V0xXQFF6ncU4LF
         DUTY/u0qCbIKq1ie9dn5SZUw1F9mavJfmj/KN6k/6IY9MFoHKlFlLSK9BHQN1AjDWqQd
         X8lLWVAvoJJTWwB3rIKKYxqkhhnZ4S3mxqleryMPuABdjKJuVbRRiTA17WIC315mf7YU
         mNyLYSV+t3VXqxkC0RQ2pc4if2WBh4diFoFoVGWr7xkqL/FPnPxHsUssRh3NX8nhbOkQ
         TzwgPrU8q9PZUjC1B7V3Immu3vmNhIU/o9jv+mjOWNdLDeN/DHgAflprYc34zA7zpF8y
         B1Ag==
X-Gm-Message-State: AOJu0YzRJDGC+0betAhzNH83VPyuGiRAL9QqYvWtBZ9iS2Go51cvQ5GA
        G+UJNObE418kjAjAMkMDMDWBg90BqKoC1BG37ehzRQ==
X-Google-Smtp-Source: AGHT+IGL6fQHrX1AqP0gkgxhmMGrRSypGWx3ZtAcsfH7zlp8ROCDaeJq0vczx5UZ4LzUj+CQKnM3WMIgnpzbaTlIv70=
X-Received: by 2002:a05:6512:32a2:b0:503:2a53:7480 with SMTP id
 q2-20020a05651232a200b005032a537480mr431345lfe.49.1695412285461; Fri, 22 Sep
 2023 12:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
 <CAL_Jsq+WuYDU+yY98opTHr1PT-J9mFYJQBjVMnk+FSWLDUO33w@mail.gmail.com>
 <CAPnjgZ1pfxaMG1n5yOBhiOhsNrRjck1K92U7Ga=+VTY_jjjrVg@mail.gmail.com>
 <20230922174649.GA3320366-robh@kernel.org> <CAPnjgZ3ojfAv=BHqOhM=-NnYqCm81Ny=PsGKiNphKTmw++fk9w@mail.gmail.com>
 <CAL_JsqJqvyP=c93DHDO8A5RXv7Lz_Z7eEHSbJQ=JCo+qPVhSfg@mail.gmail.com>
In-Reply-To: <CAL_JsqJqvyP=c93DHDO8A5RXv7Lz_Z7eEHSbJQ=JCo+qPVhSfg@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Fri, 22 Sep 2023 13:51:14 -0600
Message-ID: <CAPnjgZ3BnD9aX3cNNPiGRKTOj+YeurHCLv6K0TRFhAtY21Qufw@mail.gmail.com>
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
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, 22 Sept 2023 at 13:43, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Sep 22, 2023 at 1:12=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Rob,
> >
> > On Fri, 22 Sept 2023 at 11:46, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Sep 22, 2023 at 11:01:18AM -0600, Simon Glass wrote:
> > > > Hi Rob,
> > > >
> > > > On Fri, 22 Sept 2023 at 10:00, Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Thu, Sep 21, 2023 at 1:45=E2=80=AFPM Simon Glass <sjg@chromium=
.org> wrote:
> > > > > >
> > > > > > Binman[1] is a tool for creating firmware images. It allows you=
 to
> > > > > > combine various binaries and place them in an output file.
> > > > > >
> > > > > > Binman uses a DT schema to describe an image, in enough detail =
that
> > > > > > it can be automatically built from component parts, disassemble=
d,
> > > > > > replaced, listed, etc.
> > > > > >
> > > > > > Images are typically stored in flash, which is why this binding=
 is
> > > > > > targeted at mtd. Previous discussion is at [2] [3].
> > > > > >
> > > > > > [1] https://u-boot.readthedocs.io/en/stable/develop/package/bin=
man.html
> > > > > > [2] https://lore.kernel.org/u-boot/20230821180220.2724080-3-sjg=
@chromium.org/
> > > > > > [3] https://www.spinics.net/lists/devicetree/msg626149.html
> > > > >
> > > > > You missed:
> > > > >
> > > > > https://github.com/devicetree-org/dt-schema/pull/110
> > > > >
> > > > > where I said: We certainly shouldn't duplicate the existing parti=
tions
> > > > > bindings. What's missing from them (I assume we're mostly talking
> > > > > about "fixed-partitions" which has been around forever I think (b=
efore
> > > > > me))?
> > > > >
> > > > > To repeat, unless there is some reason binman partitions conflict=
 with
> > > > > fixed-partitions, you need to start there and extend it. From wha=
t's
> > > > > posted here, it neither conflicts nor needs extending.
> > > >
> > > > I think at this point I am just hopelessly confused. Have you taken=
 a
> > > > look at the binman schema? [1]
> > >
> > > Why do I need to? That's used for some tool and has nothing to do wit=
h a
> > > device's DTB. However, I thought somewhere in this discussion you sho=
wed
> > > it under a flash device node.
> >
> > Yes, that is the intent (under a flash node).
> >
> > > Then I care because then it overlaps with
> > > what we already have for partitions. If I misunderstood that, then ju=
st
> > > put your schema with your tool. Only users of the tool should care ab=
out
> > > the tool's schema.
> >
> > OK. I believe that binman will fit into both camps, since its input is
> > not necessarily fully formed. E.g. if you don't specify the offset of
> > an entry, then it will be packed automatically. But the output is
> > fully formed, in that Binman now knows the offset so can write it to
> > the DT.
>
> I suppose it could take its own format as input and then write out
> something different for the "on the device" format (i.e.
> fixed-partitions). At least for the dynamic offsets, we may need
> something allowed for binman input, but not allowed on device. In
> general, there is support for partitions without addresses/offsets,
> but only for partitions that have some other way to figure that out
> (on disk partition info).
>
> There's also the image filename which doesn't really belong in the on
> device partitions. So maybe the input and output schemas should be
> separate.

OK, I'll focus on the output schema for now. I suspect this will be a
grey area though.

As an example, if you replace a binary in the firmware, Binman can
repack the firmware to make room, respecting the alignment and size
constraints. So these need to be in the output schema somehow.

>
> > > > I saw this file, which seems to extend a partition.
> > > >
> > > > Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-parti=
tions.yaml
> > >
> > > IIRC, that's a different type where partition locations are stored in
> > > the flash, so we don't need location and size in DT.
> >
> > OK.
> >
> > >
> > > >
> > > > I was assuming that I should create a top-level compatible =3D "bin=
man"
> > > > node, with subnodes like compatible =3D "binman,bl31-atf", for exam=
ple.
> > > > I should use the compatible string to indicate the contents, right?
> > >
> > > Yes for subnodes, and we already have some somewhat standard ones for
> > > "u-boot" and "u-boot-env". Though historically, "label" was used.
> >
> > Binman has common properties for all entries, including "compress"
> > which sets the compression algorithm.
>
> I see no issue with adding that. It seems useful and something missing
> in the existing partition schemas.

OK I sent a patch with that.

>
> > So perhaps I should start by defining a new binman,bl31-atf which has
> > common properties from an "binman,entry" definition?
>
> I don't understand the binman prefix. The contents are ATF (or TF-A
> now). Who wrote it to the flash image is not relevant.

Are you suggesting just "atf-bl31", or "arm,atf-bl31" ? Or should we
change it to "tfa-bl31"?

>
> We already have some compatibles in use. We should reuse them if
> possible. Not sure about TF-A though.

OK.

Regards,
Simon
