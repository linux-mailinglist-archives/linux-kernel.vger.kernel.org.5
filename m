Return-Path: <linux-kernel+bounces-17260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D706824A84
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20FED1F23497
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9542C856;
	Thu,  4 Jan 2024 21:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b1Z+2Eqk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B6C2C84D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-680a9796b38so4345006d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 13:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704405288; x=1705010088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHu/9yYjuNs9M6rsUIsCrmi3APbGPXR8WfnnSC4pWIc=;
        b=b1Z+2EqkEhS6Kk6l1CNJ0lSexxghl4ZA2d8vUGqekuil205aUASveOUacFtY3x86EB
         pnRYWDvKEF3Eb03/aG0wYAD/FtPyFf+z7eND0CRjRBHjYOhySrbrJS/VmgUu317PraKU
         v6WqiOKgJwjQhrzqG1wAEVzVjWmnnKjYJwYtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704405288; x=1705010088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHu/9yYjuNs9M6rsUIsCrmi3APbGPXR8WfnnSC4pWIc=;
        b=HCSYhndhbH406vTmbmlHtJNPNpREI2a/HKRrKyq2a274o3p3Xh5O5a1TCxEHW5373e
         c4SG22Q8MWuUE31I0An9OIo8r+BVMS2izgbIN405kiwnhBbkBhYiukRDv7EQ86eDX8Oc
         rCbe+VaicNSPrvVzBoPa5SHdmjd/dsmYi3FlVykPfiRDmQ+MHDF27HoYgVmtuPfY9zIT
         Nz0+WFGHJv0qowkD4QCoLogURME82UhFLdG3sEByKrEOja9Chrf/f79AToe89Y5MOnBQ
         LFKgWzcR1GRw8iiyPIKrhLUwXgSxWt2jdzleAWAAG6C+lxRMeq2BQ9rOU5J3Xw9W42hp
         ZZGQ==
X-Gm-Message-State: AOJu0YyathkMzsB3d2ZpdF55Us8jcpSkJHb8cmQubBdG69hmkoI/CtGx
	HAsJJnB0vr1+y50TCG8wpq59djvB3HcJls0dPHMQ/qEWcdId
X-Google-Smtp-Source: AGHT+IFuqeDMdG4zBQldI5XyvT6/jarUq5+fL5rEaozsnTJloLarXEyiTxEWhTea3tqeSV9UrqYBu0DbQI4IMlO5FpU=
X-Received: by 2002:a05:6214:2305:b0:67f:7c5c:3434 with SMTP id
 gc5-20020a056214230500b0067f7c5c3434mr1242635qvb.73.1704405287791; Thu, 04
 Jan 2024 13:54:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116172859.393744-1-sjg@chromium.org> <20231208150042.GA1278773-robh@kernel.org>
 <CAPnjgZ2i4gvgiUeHPOfHuOdBooV4e=QQEq6iMo0JbDwOS6dCwA@mail.gmail.com>
 <CAL_Jsq+xMZ8yz4H9D59uCSyX4h5W+4ruGF++=wVA=msXz+Y01A@mail.gmail.com>
 <CAPnjgZ1uW8T6woXSqFUNm301=W3zBYOrADREkrz=DuwSW87qZg@mail.gmail.com>
 <20231214172702.GA617226-robh@kernel.org> <CAPnjgZ2oJSGPO91Y_aLbe+v250WFrND4n3T0mOvhERYidVu=eQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ2oJSGPO91Y_aLbe+v250WFrND4n3T0mOvhERYidVu=eQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 4 Jan 2024 14:54:36 -0700
Message-ID: <CAFLszTizRRVbRO6_ygE2X-Lp5dENWSc4uMGL5GPJAFGAbRdCyQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: partitions: Add binman compatible
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, 
	linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>, 
	Michael Walle <mwalle@kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Pratyush Yadav <ptyadav@amazon.de>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Thu, Dec 14, 2023 at 2:09=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Rob,
>
> On Thu, 14 Dec 2023 at 10:27, Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Dec 08, 2023 at 03:58:10PM -0700, Simon Glass wrote:
> > > Hi Rob,
> > >
> > > On Fri, 8 Dec 2023 at 14:56, Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Fri, Dec 8, 2023 at 11:47=E2=80=AFAM Simon Glass <sjg@chromium.o=
rg> wrote:
> > > > >
> > > > > Hi Rob,
> > > > >
> > > > > On Fri, 8 Dec 2023 at 08:00, Rob Herring <robh@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, Nov 16, 2023 at 10:28:50AM -0700, Simon Glass wrote:
> > > > > > > Add a compatible string for binman, so we can extend fixed-pa=
rtitions
> > > > > > > in various ways.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > (no changes since v5)
> > > > > > >
> > > > > > > Changes in v5:
> > > > > > > - Add #address/size-cells and parternProperties
> > > > > > > - Drop $ref to fixed-partitions.yaml
> > > > > > > - Drop 'select: false'
> > > > > > >
> > > > > > > Changes in v4:
> > > > > > > - Change subject line
> > > > > > >
> > > > > > > Changes in v3:
> > > > > > > - Drop fixed-partition additional compatible string
> > > > > > > - Drop fixed-partitions from the example
> > > > > > > - Mention use of compatible instead of label
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > > - Drop mention of 'enhanced features' in fixed-partitions.yam=
l
> > > > > > > - Mention Binman input and output properties
> > > > > > > - Use plain partition@xxx for the node name
> > > > > > >
> > > > > > >  .../bindings/mtd/partitions/binman.yaml       | 68 +++++++++=
++++++++++
> > > > > > >  .../bindings/mtd/partitions/partitions.yaml   |  1 +
> > > > > > >  MAINTAINERS                                   |  5 ++
> > > > > > >  3 files changed, 74 insertions(+)
> > > > > > >  create mode 100644 Documentation/devicetree/bindings/mtd/par=
titions/binman.yaml
> > > > > > >
> > > > > > > diff --git a/Documentation/devicetree/bindings/mtd/partitions=
/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..329217550a98
> > > > > > > --- /dev/null
> > > > > > > +++ b/Documentation/devicetree/bindings/mtd/partitions/binman=
.yaml
> > > > > > > @@ -0,0 +1,68 @@
> > > > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > > > +# Copyright 2023 Google LLC
> > > > > > > +
> > > > > > > +%YAML 1.2
> > > > > > > +---
> > > > > > > +$id: http://devicetree.org/schemas/mtd/partitions/binman.yam=
l#
> > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > +
> > > > > > > +title: Binman firmware layout
> > > > > > > +
> > > > > > > +maintainers:
> > > > > > > +  - Simon Glass <sjg@chromium.org>
> > > > > > > +
> > > > > > > +description: |
> > > > > > > +  The binman node provides a layout for firmware, used when =
packaging firmware
> > > > > > > +  from multiple projects. It is based on fixed-partitions, w=
ith some
> > > > > > > +  extensions, but uses 'compatible' to indicate the contents=
 of the node, to
> > > > > > > +  avoid perturbing or confusing existing installations which=
 use 'label' for a
> > > > > > > +  particular purpose.
> > > > > > > +
> > > > > > > +  Binman supports properties used as inputs to the firmware-=
packaging process,
> > > > > > > +  such as those which control alignment of partitions. This =
binding addresses
> > > > > > > +  these 'input' properties. For example, it is common for th=
e 'reg' property
> > > > > > > +  (an 'output' property) to be set by Binman, based on the a=
lignment requested
> > > > > > > +  in the input.
> > > > > > > +
> > > > > > > +  Once processing is complete, input properties have mostly =
served their
> > > > > > > +  purpose, at least until the firmware is repacked later, e.=
g. due to a
> > > > > > > +  firmware update. The 'fixed-partitions' binding should pro=
vide enough
> > > > > > > +  information to read the firmware at runtime, including dec=
ompression if
> > > > > > > +  needed.
> > > > > >
> > > > > > How is this going to work exactly? binman reads these nodes and=
 then
> > > > > > writes out 'fixed-partitions' nodes. But then you've lost the b=
inman
> > > > > > specifc parts needed for repacking.
> > > > >
> > > > > No, they are the same node. I do want the extra information to st=
ick
> > > > > around. So long as it is compatible with fixed-partition as well,=
 this
> > > > > should work OK.
> > > >
> > > > How can it be both? The partitions node compatible can be either
> > > > 'fixed-partitions' or 'binman'.
> > >
> > > Can we not allow it to be both? I have tried to adjust things in
> > > response to feedback but perhaps the feedback was leading me down the
> > > wrong path?
> >
> > Sure, but then the schema has to and that means extending
> > fixed-partitions.
>
> Can we cross that bridge later? There might be resistance to it. I'm
> not sure. For now, perhaps just a binman compatible works well enough
> to make progress.

Is there any way to make progress on this? I would like to have
software which doesn't understand the binman compatible to at least be
able to understand the fixed-partition compatible. Is that acceptable?
If not, what is?

In any case, please can you help with this?

Regards,
Simon

