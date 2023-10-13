Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3F07C8EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjJMVJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMVJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:09:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41659BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:09:34 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9be7e3fa1daso13930466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697231373; x=1697836173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXEzu9S4cTD1Jlef4EbosXRYiSQebTwp28XSIMu0qBA=;
        b=STB6I1UHqO2BHwZWjm2mIjwwpRh6A3jRq7d9xRm/cjYHs2dj+duOw0SwuwJzEZi4rN
         4l6qxJ9SuKzN1aI8/T/xF3+CYyaszk247RrYoxxVMJ5PMVosjv1VGPAKfisuZV0+JAGU
         b8vNlsHF5hyX/179q21rLsOdpZPpQCeNUHGhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697231373; x=1697836173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXEzu9S4cTD1Jlef4EbosXRYiSQebTwp28XSIMu0qBA=;
        b=BNxJNKteZwx7s5cF/tY8ZAPc3bSWeBzgBDDEUUBMCtGpmb/Lwwu9u0lPlrxGRxMAlY
         mscRzHSsSKWjz9VHECb6NtfdxaEc+99XDtpMZGYte7wxEP2DH4ToUC1WmlSoSjqgekIU
         8Z1hXnXOxzm3lQP+0Fy4NUGXyQxakRsO5st4HGOeoTjZ82MCcdFA+HtAqbkKgz1VH0v1
         2PtAYU57nLX6adGqma+TpscTe0UnOLU2YHotct3DxzlAsRqW9TcN/gP+UNs+J1CmHzBv
         HJvZhWn8UuhfAk6uFxOs1vAyAdXqAmdiMankCb6LeS5l+K/UVfcssjIcX3Vhg0mH+8JQ
         /D+g==
X-Gm-Message-State: AOJu0Yz52aNxv8yH4tY44f1yQB7n5wHdtOvvrnuQaEqZdq3qxlb+5Smb
        WgFqx4LVBgE6puDMGvV5hR//hO2w58mBB/HhYiU1Eg==
X-Google-Smtp-Source: AGHT+IHmxjxpI1dzCqOIpM4CdU2WHdn17ADIZsaY2gUSzuoMBzjvaHGwQccnyUNZpYlp75gD2PzN046fNA3cYMBv4C0=
X-Received: by 2002:a17:906:314f:b0:9b0:169b:eece with SMTP id
 e15-20020a170906314f00b009b0169beecemr24735226eje.40.1697231372221; Fri, 13
 Oct 2023 14:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org> <20230926194242.2732127-2-sjg@chromium.org>
 <CAPnjgZ0Xf3U1aj32LbU-xiU1AqwnM3JL1F8xX-wZ18oEmg+irw@mail.gmail.com>
 <CAMj1kXEXcX7BkDyfy-6_5Vnch=N+onza-yfWfsVaGLE93h2c+Q@mail.gmail.com>
 <CAPnjgZ2SEby-ndrs=W_afBJH56eqc=-mhp1F1nwkvWks+=B54Q@mail.gmail.com>
 <CAMj1kXED3S+0cq+VT7naBrmWrUwT=HZAaZOBRMv8Ui1Pey1QNQ@mail.gmail.com>
 <CAPnjgZ0LrsJ2_ENTYoBrnyFaH3UKdHs3D2XWY=TzBuBpBoTXZA@mail.gmail.com> <CAL_Jsq+DQugkEDESW5wySFbLLN8HNqGDJCio8Wpi6fe0LeHKUA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+DQugkEDESW5wySFbLLN8HNqGDJCio8Wpi6fe0LeHKUA@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Fri, 13 Oct 2023 14:09:15 -0700
Message-ID: <CAPnjgZ0cmKP5hoGCyQ_Rp8ZQXUVwaPYJMWyidXuOOjMVkDoMDw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To:     Rob Herring <robh@kernel.org>
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
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, 13 Oct 2023 at 13:42, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Oct 6, 2023 at 7:03=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Hi Ard,
> >
> > On Fri, 6 Oct 2023 at 17:00, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Fri, 6 Oct 2023 at 20:17, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ard,
> > > >
> > > > On Fri, 6 Oct 2023 at 11:33, Ard Biesheuvel <ardb@kernel.org> wrote=
:
> > > > >
> > > > > On Mon, 2 Oct 2023 at 19:54, Simon Glass <sjg@chromium.org> wrote=
:
> > > > > >
> > > > > > Hi Rob,
> > > > > >
> > > > > > On Tue, 26 Sept 2023 at 13:42, Simon Glass <sjg@chromium.org> w=
rote:
> > > > > > >
> > > > > > > It is common to split firmware into 'Platform Init', which do=
es the
> > > > > > > initial hardware setup and a "Payload" which selects the OS t=
o be booted.
> > > > > > > Thus an handover interface is required between these two piec=
es.
> > > > > > >
> > > > > > > Where UEFI boot-time services are not available, but UEFI fir=
mware is
> > > > > > > present on either side of this interface, information about m=
emory usage
> > > > > > > and attributes must be presented to the "Payload" in some for=
m.
> > > > > > >
> > > > > > > This aims to provide an small schema addition for the memory =
mapping
> > > > > > > needed to keep these two pieces working together well.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > Changes in v7:
> > > > > > > - Rename acpi-reclaim to acpi
> > > > > > > - Drop individual mention of when memory can be reclaimed
> > > > > > > - Rewrite the item descriptions
> > > > > > > - Add back the UEFI text (with trepidation)
> > > > > >
> > > > > > I am again checking on this series. Can it be applied, please?
> > > > > >
> > > > >
> > > > > Apologies for the delay in response. I have been away.
> > > >
> > > > OK, I hope you had a nice trip.
> > > >
> > >
> > > Thanks, it was wonderful!
> > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Changes in v6:
> > > > > > > - Drop mention of UEFI
> > > > > > > - Use compatible strings instead of node names
> > > > > > >
> > > > > > > Changes in v5:
> > > > > > > - Drop the memory-map node (should have done that in v4)
> > > > > > > - Tidy up schema a bit
> > > > > > >
> > > > > > > Changes in v4:
> > > > > > > - Make use of the reserved-memory node instead of creating a =
new one
> > > > > > >
> > > > > > > Changes in v3:
> > > > > > > - Reword commit message again
> > > > > > > - cc a lot more people, from the FFI patch
> > > > > > > - Split out the attributes into the /memory nodes
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > > - Reword commit message
> > > > > > >
> > > > > > >  .../reserved-memory/common-reserved.yaml      | 71 +++++++++=
++++++++++
> > > > > > >  1 file changed, 71 insertions(+)
> > > > > > >  create mode 100644 dtschema/schemas/reserved-memory/common-r=
eserved.yaml
> > > > > > >
> > > > > > > diff --git a/dtschema/schemas/reserved-memory/common-reserved=
.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > > > > new file mode 100644
> > > > > > > index 0000000..f7fbdfd
> > > > > > > --- /dev/null
> > > > > > > +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > > > > @@ -0,0 +1,71 @@
> > > > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > > > > +%YAML 1.2
> > > > > > > +---
> > > > > > > +$id: http://devicetree.org/schemas/reserved-memory/common-re=
served.yaml#
> > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > +
> > > > > > > +title: Common memory reservations
> > > > > > > +
> > > > > > > +description: |
> > > > > > > +  Specifies that the reserved memory region can be used for =
the purpose
> > > > > > > +  indicated by its compatible string.
> > > > > > > +
> > > > > > > +  Clients may reuse this reserved memory if they understand =
what it is for,
> > > > > > > +  subject to the notes below.
> > > > > > > +
> > > > > > > +maintainers:
> > > > > > > +  - Simon Glass <sjg@chromium.org>
> > > > > > > +
> > > > > > > +allOf:
> > > > > > > +  - $ref: reserved-memory.yaml
> > > > > > > +
> > > > > > > +properties:
> > > > > > > +  compatible:
> > > > > > > +    description: |
> > > > > > > +      This describes some common memory reservations, with t=
he compatible
> > > > > > > +      string indicating what it is used for:
> > > > > > > +
> > > > > > > +         acpi: Advanced Configuration and Power Interface (A=
CPI) tables
> > > > > > > +         acpi-nvs: ACPI Non-Volatile-Sleeping Memory (NVS). =
This is reserved by
> > > > > > > +           the firmware for its use and is required to be sa=
ved and restored
> > > > > > > +           across an NVS sleep
> > > > > > > +         boot-code: Contains code used for booting which is =
not needed by the OS
> > > > > > > +         boot-code: Contains data used for booting which is =
not needed by the OS
> > > > > > > +         runtime-code: Contains code used for interacting wi=
th the system when
> > > > > > > +           running the OS
> > > > > > > +         runtime-data: Contains data used for interacting wi=
th the system when
> > > > > > > +           running the OS
> > > > > > > +
> > > > > > > +    enum:
> > > > > > > +      - acpi
> > > > > > > +      - acpi-nvs
> > > > > > > +      - boot-code
> > > > > > > +      - boot-data
> > > > > > > +      - runtime-code
> > > > > > > +      - runtime-data
> > > > > > > +
> > > > >
> > > > > As I mentioned a few times already, I don't think these compatibl=
es
> > > > > should be introduced here.
> > > > >
> > > > > A reserved region has a specific purpose, and the compatible shou=
ld be
> > > > > more descriptive than the enum above. If the consumer does not
> > > > > understand this purpose, it should simply treat the memory as res=
erved
> > > > > and not touch it. Alternatively, these regions can be referenced =
from
> > > > > other DT nodes using phandles if needed.
> > > >
> > > > We still need some description of what these regions are used for, =
so
> > > > that the payload can use the correct regions. I do not have any oth=
er
> > > > solution to this problem. We are in v7 at present. At least explain
> > > > where you want the compatible strings to be introduced.
> > > >
> > >
> > > My point is really that by themselves, these regions are not usable b=
y
> > > either a payload or an OS that consumes this information. Unless ther=
e
> > > is some other information being provided (via DT I imagine) that
> > > describes how these things are supposed to be used, they are nothing
> > > more than memory reservations that should be honored, and providing
> > > this arbitrary set of labels is unnecessary.
> > >
> > > > What sort of extra detail are you looking for? Please be specific a=
nd
> > > > preferably add some suggestions so I can close this out ASAP.
> > > >
> > >
> > > A payload or OS can do nothing with a memory reservation called
> > > 'runtime-code' it it doesn't know what is inside.
>
> Agreed. The question is WHAT runtime-code? The compatible needs to answer=
 that.
>
> For example, we have 'ramoops' as a compatible in reserved memory.
> That tells us *exactly* what's there. We know how to parse it. If we
> know ramoops is not supported, then we know we can toss it out and
> reclaim the memory.

So if we said:

   compatible =3D "runtime-code-efi"

would that be OK? We seem to be in catch 22 here, because if I don't
mention EFI unhappy, but if I do, Ard is unhappy.

What about the boottime code....you want to know which project it is from?

+      - acpi
+      - acpi-nvs

Those two should be enough info, right?

+      - boot-code
+      - boot-data

For these, they don't pertain to the OS, so perhaps they are OK? In
any case, using a generic term like this makes some sense to me. We
can always add a new compatible like "efi-boottime-services" later. It
may be that the boottime services would be handled by the payload, so
not needed in all cases.

+      - runtime-code
+      - runtime-data

See above.

>
>
> > > So there is another
> > > DT node somewhere that describes this, and that can simply point to
> > > this region (via a phandle) if it needs to describe the
> > > correspondence. This is more idiomatic for DT afaik (but I am not the
> > > expert).
>
> I don't see why we need that indirection.
>
> > >   But more importantly, it avoids overloading some vague
> > > labels with behavior (e.g., executable permissions for code regions)
> > > that should only be displayed for regions with a particular use,
> > > rather than for a ill defined class of reservations the purpose of
> > > which is not clear.
> > >
> > > What I am trying to avoid is the OS ending up being forced to consume
> > > this information in parallel to the EFI memory map, and having to
> > > reconcile them. I'd be much happier if this gets contributed to a spe=
c
> > > that only covers firmware-to-firmware, and is prevented from leaking
> > > into the OS facing interface.
> >
> > I don't know about "another DT node". We don't have one at present.
> >
> > There is already a note in the DT spec about this:
> >
> > > 3.5.4 /reserved-memory and UEFI
> >
> > > When booting via [UEFI], static /reserved-memory regions must also be=
 listed in the system memory map obtained
> > > via the GetMemoryMap() UEFI boot time service as defined in [UEFI] =
=C2=A7 7.2. The reserved memory regions need to be
> > > included in the UEFI memory map to protect against allocations by UEF=
I applications.
> > >
> > > Reserved regions with the no-map property must be listed in the memor=
y map with type EfiReservedMemoryType. All
> > > other reserved regions must be listed with type EfiBootServicesData.
> > >
> > > Dynamic reserved memory regions must not be listed in the [UEFI] memo=
ry map because they are allocated by the OS
> > > after exiting firmware boot services.
> >
> > I don't fully understand what all that means, but does it cover your co=
ncern?
>
> This section is purely about using UEFI mechanisms to load and boot
> the OS. If we're not talking about this stage of booting, then none of
> this applies.

OK

Regards,
Simon
