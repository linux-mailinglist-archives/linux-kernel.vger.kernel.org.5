Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45A97E47D2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343544AbjKGSHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjKGSHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:07:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E37B0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:07:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71BFC433A9;
        Tue,  7 Nov 2023 18:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699380453;
        bh=N4rlLB7z0cOpmpZ/BL47aepJIVFWZKyXA+rtWoCv60w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZM27deGCx+o8H6YUVL55r5q8aUEBMsTc7nhR4mdmHHNy6/eF27PP9TboKKe+d+edk
         UjgX9W/Vv3oUM0mEFsURZ79HnO+q+KHBaMhW1Y1EDydagf+HNR4vCaWCXJ12pqjx79
         70ty0soXF5YwV+dXnusUVL+RExSyP0zsqTXqaXAZVons9GBrOoHnX9UrkaMrrJizzn
         AVQZpHpIEPEFsNNdKiuQ0clYlJvXv1CZMM05pxjmLvpJibtrnRloMDZvWiU+J0ewAP
         LV/2+9tcR/G4+/PkZ3WAmIrHB+45Mw5bfBFTTHa5zAFTENfg6+XmU+5egd0pKf0ZWV
         PrZ3Tc7qvcgwA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50797cf5b69so7882545e87.2;
        Tue, 07 Nov 2023 10:07:32 -0800 (PST)
X-Gm-Message-State: AOJu0Yzw6IvCI0r8GXCarCVkTbpFvNKJOEYxHZH9mcky90qLkiOfOVX7
        tugrXeEOTYaaw92NdT5Jq820fAk16tsnpkye4w==
X-Google-Smtp-Source: AGHT+IEkUVYvX0YzvXzJFUleQKdN0GE9vRVxqaXq3qMhrMlB77Pbme7h7KcKJjsSIgU5e9Jsi4+ATC2DZumGeHvPbdQ=
X-Received: by 2002:a05:6512:557:b0:503:24c7:df34 with SMTP id
 h23-20020a056512055700b0050324c7df34mr24961177lfl.11.1699380450811; Tue, 07
 Nov 2023 10:07:30 -0800 (PST)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org> <20230926194242.2732127-2-sjg@chromium.org>
 <CAPnjgZ0Xf3U1aj32LbU-xiU1AqwnM3JL1F8xX-wZ18oEmg+irw@mail.gmail.com>
 <CAMj1kXEXcX7BkDyfy-6_5Vnch=N+onza-yfWfsVaGLE93h2c+Q@mail.gmail.com>
 <CAPnjgZ2SEby-ndrs=W_afBJH56eqc=-mhp1F1nwkvWks+=B54Q@mail.gmail.com>
 <CAMj1kXED3S+0cq+VT7naBrmWrUwT=HZAaZOBRMv8Ui1Pey1QNQ@mail.gmail.com>
 <CAPnjgZ0LrsJ2_ENTYoBrnyFaH3UKdHs3D2XWY=TzBuBpBoTXZA@mail.gmail.com>
 <CAL_Jsq+DQugkEDESW5wySFbLLN8HNqGDJCio8Wpi6fe0LeHKUA@mail.gmail.com>
 <CAPnjgZ0cmKP5hoGCyQ_Rp8ZQXUVwaPYJMWyidXuOOjMVkDoMDw@mail.gmail.com>
 <CAL_JsqJH=vJ40PNTg_i0LoKA-c0hhMJkL8zCC3_bB-tOkFWWsw@mail.gmail.com>
 <CAPnjgZ1FrdGKjGAxUbkQoL2vHwhC_2Oa2KT+0cm25dQAuAjxAQ@mail.gmail.com> <CAPnjgZ19-xR6QxS=fR53skz0VuAty2Z2w2vQTjP7g=tbTFpaqw@mail.gmail.com>
In-Reply-To: <CAPnjgZ19-xR6QxS=fR53skz0VuAty2Z2w2vQTjP7g=tbTFpaqw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 7 Nov 2023 12:07:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL+X1DatsGk_Cn1HsbG2GV9AngFWXVysWTiNRu_d9tDqw@mail.gmail.com>
Message-ID: <CAL_JsqL+X1DatsGk_Cn1HsbG2GV9AngFWXVysWTiNRu_d9tDqw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To:     Simon Glass <sjg@chromium.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dhaval Sharma <dhaval@rivosinc.com>,
        Maximilian Brune <maximilian.brune@9elements.com>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        Guo Dong <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>,
        ron minnich <rminnich@gmail.com>, Gua Guo <gua.guo@intel.com>,
        Chiu Chasel <chasel.chiu@intel.com>,
        linux-acpi@vger.kernel.org,
        U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 10:56=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Rob,
>
> On Mon, 16 Oct 2023 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Rob,
> >
> > On Mon, 16 Oct 2023 at 10:50, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Oct 13, 2023 at 4:09=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Rob,
> > > >
> > > > On Fri, 13 Oct 2023 at 13:42, Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Fri, Oct 6, 2023 at 7:03=E2=80=AFPM Simon Glass <sjg@chromium.=
org> wrote:
> > > > > >
> > > > > > Hi Ard,
> > > > > >
> > > > > > On Fri, 6 Oct 2023 at 17:00, Ard Biesheuvel <ardb@kernel.org> w=
rote:
> > > > > > >
> > > > > > > On Fri, 6 Oct 2023 at 20:17, Simon Glass <sjg@chromium.org> w=
rote:
> > > > > > > >
> > > > > > > > Hi Ard,
> > > > > > > >
> > > > > > > > On Fri, 6 Oct 2023 at 11:33, Ard Biesheuvel <ardb@kernel.or=
g> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, 2 Oct 2023 at 19:54, Simon Glass <sjg@chromium.or=
g> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Rob,
> > > > > > > > > >
> > > > > > > > > > On Tue, 26 Sept 2023 at 13:42, Simon Glass <sjg@chromiu=
m.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > It is common to split firmware into 'Platform Init', =
which does the
> > > > > > > > > > > initial hardware setup and a "Payload" which selects =
the OS to be booted.
> > > > > > > > > > > Thus an handover interface is required between these =
two pieces.
> > > > > > > > > > >
> > > > > > > > > > > Where UEFI boot-time services are not available, but =
UEFI firmware is
> > > > > > > > > > > present on either side of this interface, information=
 about memory usage
> > > > > > > > > > > and attributes must be presented to the "Payload" in =
some form.
> > > > > > > > > > >
> > > > > > > > > > > This aims to provide an small schema addition for the=
 memory mapping
> > > > > > > > > > > needed to keep these two pieces working together well=
.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > ---
> > > > > > > > > > >
> > > > > > > > > > > Changes in v7:
> > > > > > > > > > > - Rename acpi-reclaim to acpi
> > > > > > > > > > > - Drop individual mention of when memory can be recla=
imed
> > > > > > > > > > > - Rewrite the item descriptions
> > > > > > > > > > > - Add back the UEFI text (with trepidation)
> > > > > > > > > >
> > > > > > > > > > I am again checking on this series. Can it be applied, =
please?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Apologies for the delay in response. I have been away.
> > > > > > > >
> > > > > > > > OK, I hope you had a nice trip.
> > > > > > > >
> > > > > > >
> > > > > > > Thanks, it was wonderful!
> > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Changes in v6:
> > > > > > > > > > > - Drop mention of UEFI
> > > > > > > > > > > - Use compatible strings instead of node names
> > > > > > > > > > >
> > > > > > > > > > > Changes in v5:
> > > > > > > > > > > - Drop the memory-map node (should have done that in =
v4)
> > > > > > > > > > > - Tidy up schema a bit
> > > > > > > > > > >
> > > > > > > > > > > Changes in v4:
> > > > > > > > > > > - Make use of the reserved-memory node instead of cre=
ating a new one
> > > > > > > > > > >
> > > > > > > > > > > Changes in v3:
> > > > > > > > > > > - Reword commit message again
> > > > > > > > > > > - cc a lot more people, from the FFI patch
> > > > > > > > > > > - Split out the attributes into the /memory nodes
> > > > > > > > > > >
> > > > > > > > > > > Changes in v2:
> > > > > > > > > > > - Reword commit message
> > > > > > > > > > >
> > > > > > > > > > >  .../reserved-memory/common-reserved.yaml      | 71 +=
++++++++++++++++++
> > > > > > > > > > >  1 file changed, 71 insertions(+)
> > > > > > > > > > >  create mode 100644 dtschema/schemas/reserved-memory/=
common-reserved.yaml
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/dtschema/schemas/reserved-memory/common-=
reserved.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > > > > > > > > new file mode 100644
> > > > > > > > > > > index 0000000..f7fbdfd
> > > > > > > > > > > --- /dev/null
> > > > > > > > > > > +++ b/dtschema/schemas/reserved-memory/common-reserve=
d.yaml
> > > > > > > > > > > @@ -0,0 +1,71 @@
> > > > > > > > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Cla=
use
> > > > > > > > > > > +%YAML 1.2
> > > > > > > > > > > +---
> > > > > > > > > > > +$id: http://devicetree.org/schemas/reserved-memory/c=
ommon-reserved.yaml#
> > > > > > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yam=
l#
> > > > > > > > > > > +
> > > > > > > > > > > +title: Common memory reservations
> > > > > > > > > > > +
> > > > > > > > > > > +description: |
> > > > > > > > > > > +  Specifies that the reserved memory region can be u=
sed for the purpose
> > > > > > > > > > > +  indicated by its compatible string.
> > > > > > > > > > > +
> > > > > > > > > > > +  Clients may reuse this reserved memory if they und=
erstand what it is for,
> > > > > > > > > > > +  subject to the notes below.
> > > > > > > > > > > +
> > > > > > > > > > > +maintainers:
> > > > > > > > > > > +  - Simon Glass <sjg@chromium.org>
> > > > > > > > > > > +
> > > > > > > > > > > +allOf:
> > > > > > > > > > > +  - $ref: reserved-memory.yaml
> > > > > > > > > > > +
> > > > > > > > > > > +properties:
> > > > > > > > > > > +  compatible:
> > > > > > > > > > > +    description: |
> > > > > > > > > > > +      This describes some common memory reservations=
, with the compatible
> > > > > > > > > > > +      string indicating what it is used for:
> > > > > > > > > > > +
> > > > > > > > > > > +         acpi: Advanced Configuration and Power Inte=
rface (ACPI) tables
> > > > > > > > > > > +         acpi-nvs: ACPI Non-Volatile-Sleeping Memory=
 (NVS). This is reserved by
> > > > > > > > > > > +           the firmware for its use and is required =
to be saved and restored
> > > > > > > > > > > +           across an NVS sleep
> > > > > > > > > > > +         boot-code: Contains code used for booting w=
hich is not needed by the OS
> > > > > > > > > > > +         boot-code: Contains data used for booting w=
hich is not needed by the OS
> > > > > > > > > > > +         runtime-code: Contains code used for intera=
cting with the system when
> > > > > > > > > > > +           running the OS
> > > > > > > > > > > +         runtime-data: Contains data used for intera=
cting with the system when
> > > > > > > > > > > +           running the OS
> > > > > > > > > > > +
> > > > > > > > > > > +    enum:
> > > > > > > > > > > +      - acpi
> > > > > > > > > > > +      - acpi-nvs
> > > > > > > > > > > +      - boot-code
> > > > > > > > > > > +      - boot-data
> > > > > > > > > > > +      - runtime-code
> > > > > > > > > > > +      - runtime-data
> > > > > > > > > > > +
> > > > > > > > >
> > > > > > > > > As I mentioned a few times already, I don't think these c=
ompatibles
> > > > > > > > > should be introduced here.
> > > > > > > > >
> > > > > > > > > A reserved region has a specific purpose, and the compati=
ble should be
> > > > > > > > > more descriptive than the enum above. If the consumer doe=
s not
> > > > > > > > > understand this purpose, it should simply treat the memor=
y as reserved
> > > > > > > > > and not touch it. Alternatively, these regions can be ref=
erenced from
> > > > > > > > > other DT nodes using phandles if needed.
> > > > > > > >
> > > > > > > > We still need some description of what these regions are us=
ed for, so
> > > > > > > > that the payload can use the correct regions. I do not have=
 any other
> > > > > > > > solution to this problem. We are in v7 at present. At least=
 explain
> > > > > > > > where you want the compatible strings to be introduced.
> > > > > > > >
> > > > > > >
> > > > > > > My point is really that by themselves, these regions are not =
usable by
> > > > > > > either a payload or an OS that consumes this information. Unl=
ess there
> > > > > > > is some other information being provided (via DT I imagine) t=
hat
> > > > > > > describes how these things are supposed to be used, they are =
nothing
> > > > > > > more than memory reservations that should be honored, and pro=
viding
> > > > > > > this arbitrary set of labels is unnecessary.
> > > > > > >
> > > > > > > > What sort of extra detail are you looking for? Please be sp=
ecific and
> > > > > > > > preferably add some suggestions so I can close this out ASA=
P.
> > > > > > > >
> > > > > > >
> > > > > > > A payload or OS can do nothing with a memory reservation call=
ed
> > > > > > > 'runtime-code' it it doesn't know what is inside.
> > > > >
> > > > > Agreed. The question is WHAT runtime-code? The compatible needs t=
o answer that.
> > > > >
> > > > > For example, we have 'ramoops' as a compatible in reserved memory=
.
> > > > > That tells us *exactly* what's there. We know how to parse it. If=
 we
> > > > > know ramoops is not supported, then we know we can toss it out an=
d
> > > > > reclaim the memory.
> > > >
> > > > So if we said:
> > > >
> > > >    compatible =3D "runtime-code-efi"
> > > >
> > > > would that be OK? We seem to be in catch 22 here, because if I don'=
t
> > > > mention EFI unhappy, but if I do, Ard is unhappy.
> > >
> > > Better yes, because then it is for something specific. However, AIUI,
> > > that's setup for the OS and defining that region is already defined b=
y
> > > the EFI memory map. That's Ard's issue. If there's a need outside of
> > > the EFI to OS handoff,
> >
> > There is a need. Here is part of the commit message again. If there is
> > something else you need to know, please ask.
> >
> > >>>>
> > It is common to split firmware into 'Platform Init', which does the
> > initial hardware setup and a "Payload" which selects the OS to be boote=
d.
> > Thus an handover interface is required between these two pieces.
> >
> > Where UEFI boot-time services are not available, but UEFI firmware is
> > present on either side of this interface, information about memory usag=
e
> > and attributes must be presented to the "Payload" in some form.
> > <<<
> >
> > > then you need to define what that usecase looks
> > > like. Describe the problem rather than present your solution.
> > >
> > > If this is all specific to EDK2 then it should say that rather than
> > > 'efi'. I imagine Ard would be happier with something tied to EDK2 tha=
n
> > > *all* UEFI. Though maybe the problem could be any implementation? IDK=
.
> > > Maybe it's TF-A that needs to define where the EFI runtime services
> > > region is and that needs to be passed all the way thru to the EFI
> > > implementation? So again, define the problem.
> >

All of this:

> > It is not specific to EDK2. Imagine this boot sequence:
> >
> > - Platform Init (U-Boot) starts up
> > - U-Boot uses its platform knowledge to sets some ACPI tables and put
> > various things in memory
> > - U-Boot sets up some runtime code and data for the OS
> > - U-Boot jumps to the Tianocore payload **
> > - Payload (Tianocore) wants to know where the ACPI tables are, for exam=
ple
> > - Tianocore needs to provide boot services to the OS, so needs to know
> > the memory map, etc.
> >
> > ** At this point we want to use DT to pass the required information.
> >
> > Of course, Platform Init could be coreboot or Tianocore or some
> > strange private binary. Payload could be U-Boot or something else.
> > That is the point of this effort, to build interoperability.

[...]

> > Perhaps the problem here is that Linux has tied itself up in knots
> > with its EFI stuff and DT fixups and what-not. But this is not that.
> > It is a simple handoff between two pieces of firmware, Platform Init
> > and Payload. It has nothing to do with the OS. With Tianocore they are
> > typically combined, but with this usage they are split, and we can
> > swap out one project for another on either side of the DT interface.

Is perhaps the clearest description of the problem you want to solve.
It's clearly related to EFI though not the interface to the OS. IIRC,
"platform init" and "payload" are terms in the UEFI spec, right? I
don't recall how well defined those are vs. just abstract concepts.

Is it only for this interface or any firmware to firmware handoff. If
the former, then I'm looking for folks involved with EFI/Tianocore to
have some buy-in. If the latter, then this should be part of the
firmware handoff efforts and have buy-in there.

> > I do have views on the 'EFI' opt-out with reserved-memory, if you are
> > interested, but that relates to the OS. If you are wanting to place
> > some constraints on /reserved-memory and /memory we could do that
> > e.g. that the DT and the map returned by EFI boot services must be
> > consistent. But as it is, the nodes are ignored by the OS when booting
> > with EFI, aren't they?
>
> Can this be applied, please? If there are further comments, please let me=
 know.

I really have limited knowledge and interest in this. I don't mind
hosting something like this in dtschema, but I'm not taking it without
buy-in from multiple parties which I haven't seen.

Rob
