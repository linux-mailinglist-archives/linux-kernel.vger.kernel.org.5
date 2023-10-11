Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C477C5E8B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjJKUkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjJKUkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:40:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC1CA9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 13:40:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D74C433CA;
        Wed, 11 Oct 2023 20:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697056815;
        bh=8L5mXgJHZV0x1PMI3MCpHodGYPRdonPcTU4tFSKPg/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QrOIIgodWJOdpY6O5VZgof/a//29t0nzABmW+7z82j47UpXNZ4GLczHKF08ca2yHV
         cmFjzuojFU3Apr7fbL4yexD8/yTXJH7qFzBw8t6940OTYB+Gexcdm1/BJDW7Is6Jhs
         1AZUuxJjmQBbEQb4Iid/0eI9mRjK7c79dpmx91ZJnW3X1aBh0twEptjaIhwdNTiU+6
         1WjMLrDEx/iVfgiujG+M06i/7Ehi/ggxsJCSviXawcYXyye4cf3UE/BE4zKH4dZmCT
         /tnCUGZQNjAVcBpnFOOZJHN63AuwMVphQB5z+eT4PlTIHKLjI0KtZRTQ6AbKlMk70i
         QquwesXiDCvfA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5042bfb4fe9so389803e87.1;
        Wed, 11 Oct 2023 13:40:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YxmI1W7GApw+lirZQYwEwZICGWlxl8uFcZDycQEGNUzEeURvAma
        wO9TI5WASVXq5BD51fZmhYG0KQOlmE8+0+u5EKw=
X-Google-Smtp-Source: AGHT+IHQ62Gr7p4zlUczVxkcGxszjmTDmRGC0aE+SwxQcshlalF+lD+86JdoH0aKJLHW5Rbj9z4dRv/jeaZgPWyT1PY=
X-Received: by 2002:a05:6512:3902:b0:502:fdca:2eab with SMTP id
 a2-20020a056512390200b00502fdca2eabmr15087253lfu.37.1697056813622; Wed, 11
 Oct 2023 13:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org> <20230926194242.2732127-2-sjg@chromium.org>
 <CAPnjgZ0Xf3U1aj32LbU-xiU1AqwnM3JL1F8xX-wZ18oEmg+irw@mail.gmail.com>
 <CAMj1kXEXcX7BkDyfy-6_5Vnch=N+onza-yfWfsVaGLE93h2c+Q@mail.gmail.com>
 <CAPnjgZ2SEby-ndrs=W_afBJH56eqc=-mhp1F1nwkvWks+=B54Q@mail.gmail.com>
 <CAMj1kXED3S+0cq+VT7naBrmWrUwT=HZAaZOBRMv8Ui1Pey1QNQ@mail.gmail.com> <CAPnjgZ0LrsJ2_ENTYoBrnyFaH3UKdHs3D2XWY=TzBuBpBoTXZA@mail.gmail.com>
In-Reply-To: <CAPnjgZ0LrsJ2_ENTYoBrnyFaH3UKdHs3D2XWY=TzBuBpBoTXZA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 11 Oct 2023 22:40:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHSJLHHikB=8q-sAdYV2OsoSod+LDeyLa=YNU1d8998ZA@mail.gmail.com>
Message-ID: <CAMj1kXHSJLHHikB=8q-sAdYV2OsoSod+LDeyLa=YNU1d8998ZA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To:     Simon Glass <sjg@chromium.org>
Cc:     devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Oct 2023 at 02:03, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ard,
>
> On Fri, 6 Oct 2023 at 17:00, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 6 Oct 2023 at 20:17, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ard,
> > >
> > > On Fri, 6 Oct 2023 at 11:33, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Mon, 2 Oct 2023 at 19:54, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Rob,
> > > > >
> > > > > On Tue, 26 Sept 2023 at 13:42, Simon Glass <sjg@chromium.org> wro=
te:
> > > > > >
> > > > > > It is common to split firmware into 'Platform Init', which does=
 the
> > > > > > initial hardware setup and a "Payload" which selects the OS to =
be booted.
> > > > > > Thus an handover interface is required between these two pieces=
.
> > > > > >
> > > > > > Where UEFI boot-time services are not available, but UEFI firmw=
are is
> > > > > > present on either side of this interface, information about mem=
ory usage
> > > > > > and attributes must be presented to the "Payload" in some form.
> > > > > >
> > > > > > This aims to provide an small schema addition for the memory ma=
pping
> > > > > > needed to keep these two pieces working together well.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > Changes in v7:
> > > > > > - Rename acpi-reclaim to acpi
> > > > > > - Drop individual mention of when memory can be reclaimed
> > > > > > - Rewrite the item descriptions
> > > > > > - Add back the UEFI text (with trepidation)
> > > > >
> > > > > I am again checking on this series. Can it be applied, please?
> > > > >
> > > >
> > > > Apologies for the delay in response. I have been away.
> > >
> > > OK, I hope you had a nice trip.
> > >
> >
> > Thanks, it was wonderful!
> >
> > > >
> > > > >
> > > > > >
> > > > > > Changes in v6:
> > > > > > - Drop mention of UEFI
> > > > > > - Use compatible strings instead of node names
> > > > > >
> > > > > > Changes in v5:
> > > > > > - Drop the memory-map node (should have done that in v4)
> > > > > > - Tidy up schema a bit
> > > > > >
> > > > > > Changes in v4:
> > > > > > - Make use of the reserved-memory node instead of creating a ne=
w one
> > > > > >
> > > > > > Changes in v3:
> > > > > > - Reword commit message again
> > > > > > - cc a lot more people, from the FFI patch
> > > > > > - Split out the attributes into the /memory nodes
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Reword commit message
> > > > > >
> > > > > >  .../reserved-memory/common-reserved.yaml      | 71 +++++++++++=
++++++++
> > > > > >  1 file changed, 71 insertions(+)
> > > > > >  create mode 100644 dtschema/schemas/reserved-memory/common-res=
erved.yaml
> > > > > >
> > > > > > diff --git a/dtschema/schemas/reserved-memory/common-reserved.y=
aml b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > > > new file mode 100644
> > > > > > index 0000000..f7fbdfd
> > > > > > --- /dev/null
> > > > > > +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > > > @@ -0,0 +1,71 @@
> > > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: http://devicetree.org/schemas/reserved-memory/common-rese=
rved.yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: Common memory reservations
> > > > > > +
> > > > > > +description: |
> > > > > > +  Specifies that the reserved memory region can be used for th=
e purpose
> > > > > > +  indicated by its compatible string.
> > > > > > +
> > > > > > +  Clients may reuse this reserved memory if they understand wh=
at it is for,
> > > > > > +  subject to the notes below.
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Simon Glass <sjg@chromium.org>
> > > > > > +
> > > > > > +allOf:
> > > > > > +  - $ref: reserved-memory.yaml
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    description: |
> > > > > > +      This describes some common memory reservations, with the=
 compatible
> > > > > > +      string indicating what it is used for:
> > > > > > +
> > > > > > +         acpi: Advanced Configuration and Power Interface (ACP=
I) tables
> > > > > > +         acpi-nvs: ACPI Non-Volatile-Sleeping Memory (NVS). Th=
is is reserved by
> > > > > > +           the firmware for its use and is required to be save=
d and restored
> > > > > > +           across an NVS sleep
> > > > > > +         boot-code: Contains code used for booting which is no=
t needed by the OS
> > > > > > +         boot-code: Contains data used for booting which is no=
t needed by the OS
> > > > > > +         runtime-code: Contains code used for interacting with=
 the system when
> > > > > > +           running the OS
> > > > > > +         runtime-data: Contains data used for interacting with=
 the system when
> > > > > > +           running the OS
> > > > > > +
> > > > > > +    enum:
> > > > > > +      - acpi
> > > > > > +      - acpi-nvs
> > > > > > +      - boot-code
> > > > > > +      - boot-data
> > > > > > +      - runtime-code
> > > > > > +      - runtime-data
> > > > > > +
> > > >
> > > > As I mentioned a few times already, I don't think these compatibles
> > > > should be introduced here.
> > > >
> > > > A reserved region has a specific purpose, and the compatible should=
 be
> > > > more descriptive than the enum above. If the consumer does not
> > > > understand this purpose, it should simply treat the memory as reser=
ved
> > > > and not touch it. Alternatively, these regions can be referenced fr=
om
> > > > other DT nodes using phandles if needed.
> > >
> > > We still need some description of what these regions are used for, so
> > > that the payload can use the correct regions. I do not have any other
> > > solution to this problem. We are in v7 at present. At least explain
> > > where you want the compatible strings to be introduced.
> > >
> >
> > My point is really that by themselves, these regions are not usable by
> > either a payload or an OS that consumes this information. Unless there
> > is some other information being provided (via DT I imagine) that
> > describes how these things are supposed to be used, they are nothing
> > more than memory reservations that should be honored, and providing
> > this arbitrary set of labels is unnecessary.
> >
> > > What sort of extra detail are you looking for? Please be specific and
> > > preferably add some suggestions so I can close this out ASAP.
> > >
> >
> > A payload or OS can do nothing with a memory reservation called
> > 'runtime-code' it it doesn't know what is inside. So there is another
> > DT node somewhere that describes this, and that can simply point to
> > this region (via a phandle) if it needs to describe the
> > correspondence. This is more idiomatic for DT afaik (but I am not the
> > expert).  But more importantly, it avoids overloading some vague
> > labels with behavior (e.g., executable permissions for code regions)
> > that should only be displayed for regions with a particular use,
> > rather than for a ill defined class of reservations the purpose of
> > which is not clear.
> >
> > What I am trying to avoid is the OS ending up being forced to consume
> > this information in parallel to the EFI memory map, and having to
> > reconcile them. I'd be much happier if this gets contributed to a spec
> > that only covers firmware-to-firmware, and is prevented from leaking
> > into the OS facing interface.
>
> I don't know about "another DT node". We don't have one at present.
>
> There is already a note in the DT spec about this:
>
> > 3.5.4 /reserved-memory and UEFI
>
> > When booting via [UEFI], static /reserved-memory regions must also be l=
isted in the system memory map obtained
> > via the GetMemoryMap() UEFI boot time service as defined in [UEFI] =C2=
=A7 7.2. The reserved memory regions need to be
> > included in the UEFI memory map to protect against allocations by UEFI =
applications.
> >
> > Reserved regions with the no-map property must be listed in the memory =
map with type EfiReservedMemoryType. All
> > other reserved regions must be listed with type EfiBootServicesData.
> >
> > Dynamic reserved memory regions must not be listed in the [UEFI] memory=
 map because they are allocated by the OS
> > after exiting firmware boot services.
>
> I don't fully understand what all that means, but does it cover your conc=
ern?
>

I don't fully agree with the wording here, but apparently there is
some awareness here of the concerns I raised.

Interestingly, 'when booting via UEFI' becomes a bit ambiguous now,
given that DT is passed from stage to stage, and not every handover is
booting via UEFI. In general, I think the introduction of bindings
that cover areas other than the handover from the final boot loader to
the OS may create some more confusion later on, but I'll leave it up
to the DT bindings maintainer to reason about that.

If you are dead set on introducing these items (and I note that you
still have not provided an actual example of how a PI -> payload
handover would make use of runtime-code or boot-code reservations), I
won't keep standing in your way.

Thanks for the discussion, and apologies for dragging this out.

--=20
Ard.
