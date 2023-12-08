Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3045280AF36
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574853AbjLHV5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574893AbjLHV4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:56:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C03B2696
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:56:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECF2C433A9;
        Fri,  8 Dec 2023 21:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702072577;
        bh=lLQ2WDCFYnh09MKNvKahHNehAE3mXonCy/B5T05x9JM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QVM696iIcTYOFN+ev+FZUSa0/ixShjERZF+VIKawdd9uLQrXYEX411unpB8wvAZut
         kmruEk2LsZ0WrxbnQNh1cKguyfbgpz4yL6P0mVvsSdZx5zs/KagDL3fxtV2oRsRIJQ
         UlsYw9d262QTPWJi25GWjm4+bFwH/nrlQLmLRT3IIRyWggljT7BpbMxU2Yt9w25K9F
         zaxGru+oEKJN01GxqEMMuhiA1PsKZ86RazkibkaWzpwmX/vd85LqdWk21rDI0l6vtC
         Dt2ZGycSZDwEvaHQJjlfn7x7JsAOPJgAjdUAXI43z7EcEOfZja5RCHIoZN0/BaRRub
         BiK3mxuFgvy7Q==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50bf32c0140so2910507e87.1;
        Fri, 08 Dec 2023 13:56:17 -0800 (PST)
X-Gm-Message-State: AOJu0YysPC5ECq/6CB8TyzgOYpusC7QOUeV1Bz6GxuzjrVO2xachGpJV
        LksDgy+3AhpIL417GPwvRgMyJtoZ75xKjvjKRg==
X-Google-Smtp-Source: AGHT+IEI2ip3XV4V7TTB5nRPLVsv6tOfk4vWYEqLclmJPsP0iDuLLixjRpN97skNUaRQnS3dh1vfZAeeAx25aEDiGfc=
X-Received: by 2002:a05:6512:a90:b0:50b:f23d:d804 with SMTP id
 m16-20020a0565120a9000b0050bf23dd804mr338588lfu.77.1702072575996; Fri, 08 Dec
 2023 13:56:15 -0800 (PST)
MIME-Version: 1.0
References: <20231116172859.393744-1-sjg@chromium.org> <20231208150042.GA1278773-robh@kernel.org>
 <CAPnjgZ2i4gvgiUeHPOfHuOdBooV4e=QQEq6iMo0JbDwOS6dCwA@mail.gmail.com>
In-Reply-To: <CAPnjgZ2i4gvgiUeHPOfHuOdBooV4e=QQEq6iMo0JbDwOS6dCwA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 8 Dec 2023 15:56:02 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+xMZ8yz4H9D59uCSyX4h5W+4ruGF++=wVA=msXz+Y01A@mail.gmail.com>
Message-ID: <CAL_Jsq+xMZ8yz4H9D59uCSyX4h5W+4ruGF++=wVA=msXz+Y01A@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: partitions: Add binman compatible
To:     Simon Glass <sjg@chromium.org>
Cc:     devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>,
        Michael Walle <mwalle@kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pratyush Yadav <ptyadav@amazon.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 11:47=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Rob,
>
> On Fri, 8 Dec 2023 at 08:00, Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Nov 16, 2023 at 10:28:50AM -0700, Simon Glass wrote:
> > > Add a compatible string for binman, so we can extend fixed-partitions
> > > in various ways.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v5)
> > >
> > > Changes in v5:
> > > - Add #address/size-cells and parternProperties
> > > - Drop $ref to fixed-partitions.yaml
> > > - Drop 'select: false'
> > >
> > > Changes in v4:
> > > - Change subject line
> > >
> > > Changes in v3:
> > > - Drop fixed-partition additional compatible string
> > > - Drop fixed-partitions from the example
> > > - Mention use of compatible instead of label
> > >
> > > Changes in v2:
> > > - Drop mention of 'enhanced features' in fixed-partitions.yaml
> > > - Mention Binman input and output properties
> > > - Use plain partition@xxx for the node name
> > >
> > >  .../bindings/mtd/partitions/binman.yaml       | 68 +++++++++++++++++=
++
> > >  .../bindings/mtd/partitions/partitions.yaml   |  1 +
> > >  MAINTAINERS                                   |  5 ++
> > >  3 files changed, 74 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/=
binman.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.=
yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> > > new file mode 100644
> > > index 000000000000..329217550a98
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> > > @@ -0,0 +1,68 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +# Copyright 2023 Google LLC
> > > +
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mtd/partitions/binman.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Binman firmware layout
> > > +
> > > +maintainers:
> > > +  - Simon Glass <sjg@chromium.org>
> > > +
> > > +description: |
> > > +  The binman node provides a layout for firmware, used when packagin=
g firmware
> > > +  from multiple projects. It is based on fixed-partitions, with some
> > > +  extensions, but uses 'compatible' to indicate the contents of the =
node, to
> > > +  avoid perturbing or confusing existing installations which use 'la=
bel' for a
> > > +  particular purpose.
> > > +
> > > +  Binman supports properties used as inputs to the firmware-packagin=
g process,
> > > +  such as those which control alignment of partitions. This binding =
addresses
> > > +  these 'input' properties. For example, it is common for the 'reg' =
property
> > > +  (an 'output' property) to be set by Binman, based on the alignment=
 requested
> > > +  in the input.
> > > +
> > > +  Once processing is complete, input properties have mostly served t=
heir
> > > +  purpose, at least until the firmware is repacked later, e.g. due t=
o a
> > > +  firmware update. The 'fixed-partitions' binding should provide eno=
ugh
> > > +  information to read the firmware at runtime, including decompressi=
on if
> > > +  needed.
> >
> > How is this going to work exactly? binman reads these nodes and then
> > writes out 'fixed-partitions' nodes. But then you've lost the binman
> > specifc parts needed for repacking.
>
> No, they are the same node. I do want the extra information to stick
> around. So long as it is compatible with fixed-partition as well, this
> should work OK.

How can it be both? The partitions node compatible can be either
'fixed-partitions' or 'binman'.

In the partition nodes, 'align' for example is allowed for a binman
partition but not a fixed-partition.

Note that the schema may not actually warn on extra properties ATM
because there are some issues with the schema structure. Since there
can be nested partittions, that complicates matters. It's been on my
todo list to fix.


Rob
