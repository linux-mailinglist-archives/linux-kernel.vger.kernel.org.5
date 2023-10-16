Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BBD7CB0F0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbjJPREm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjJPREX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:04:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32E283E4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:50:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E05C433C7;
        Mon, 16 Oct 2023 16:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697475015;
        bh=dAiKiJ+A2fpb0mLWyNJE2TtPMgp+in9hGPhvRQTEtuQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kdctiWPs2y7Lz+TZmeMB0DOIBMP61yBLXLVmyF87TTZnSDkxujpPENKah2VqvinD6
         IHPb3wO3hGQJvFWaEz2zkkPXkCJYeXR0rP11GUHfbB6+qbBvFHbtI3Be+VxrXfeyBm
         vyVq0erm2KaG+DSX9IZqhTQoS1zrFJTjxEe6WeZRxFF24WRAnwKVHN5W+YdI6r5IGO
         26gDNo+khYpkLCLx9DYqTQlDSSHH2uSAMv+O/o/GXh4ndehLZOweaiS+Zln7gY368H
         UlvuHdK+68QG+JpeLRHu6y+nKMM8lf2SiprBMgChwCGOo1meI89KhTsC8wovuwvGuJ
         s1dtl6dJgsSbg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-507b9408c61so345454e87.0;
        Mon, 16 Oct 2023 09:50:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YwG8eTRc0yZh5Fncsvq1Fsm089CoVVifSz3ipUMoJeGKV1UmyjO
        gzg36AZw/M6zzs4xTifBXy2g8tC0e/eWhaLn8g==
X-Google-Smtp-Source: AGHT+IGM6ATskDC+wE0Jj52XLiSQ5V+QcPN2ssobzitpeqE5zVNrtXglWBLAi3+Qzk+UorHEFgyOGPTrV+s2OD8+mn8=
X-Received: by 2002:ac2:53a8:0:b0:507:a650:991d with SMTP id
 j8-20020ac253a8000000b00507a650991dmr5207518lfh.58.1697475013438; Mon, 16 Oct
 2023 09:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org> <20230926194242.2732127-2-sjg@chromium.org>
 <CAPnjgZ0Xf3U1aj32LbU-xiU1AqwnM3JL1F8xX-wZ18oEmg+irw@mail.gmail.com>
 <CAMj1kXEXcX7BkDyfy-6_5Vnch=N+onza-yfWfsVaGLE93h2c+Q@mail.gmail.com>
 <CAPnjgZ2SEby-ndrs=W_afBJH56eqc=-mhp1F1nwkvWks+=B54Q@mail.gmail.com>
 <CAMj1kXED3S+0cq+VT7naBrmWrUwT=HZAaZOBRMv8Ui1Pey1QNQ@mail.gmail.com>
 <CAPnjgZ0LrsJ2_ENTYoBrnyFaH3UKdHs3D2XWY=TzBuBpBoTXZA@mail.gmail.com>
 <CAL_Jsq+DQugkEDESW5wySFbLLN8HNqGDJCio8Wpi6fe0LeHKUA@mail.gmail.com> <CAPnjgZ0cmKP5hoGCyQ_Rp8ZQXUVwaPYJMWyidXuOOjMVkDoMDw@mail.gmail.com>
In-Reply-To: <CAPnjgZ0cmKP5hoGCyQ_Rp8ZQXUVwaPYJMWyidXuOOjMVkDoMDw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 16 Oct 2023 11:50:00 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJH=vJ40PNTg_i0LoKA-c0hhMJkL8zCC3_bB-tOkFWWsw@mail.gmail.com>
Message-ID: <CAL_JsqJH=vJ40PNTg_i0LoKA-c0hhMJkL8zCC3_bB-tOkFWWsw@mail.gmail.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 4:09=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Rob,
>
> On Fri, 13 Oct 2023 at 13:42, Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Oct 6, 2023 at 7:03=E2=80=AFPM Simon Glass <sjg@chromium.org> w=
rote:
> > >
> > > Hi Ard,
> > >
> > > On Fri, 6 Oct 2023 at 17:00, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Fri, 6 Oct 2023 at 20:17, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Ard,
> > > > >
> > > > > On Fri, 6 Oct 2023 at 11:33, Ard Biesheuvel <ardb@kernel.org> wro=
te:
> > > > > >
> > > > > > On Mon, 2 Oct 2023 at 19:54, Simon Glass <sjg@chromium.org> wro=
te:
> > > > > > >
> > > > > > > Hi Rob,
> > > > > > >
> > > > > > > On Tue, 26 Sept 2023 at 13:42, Simon Glass <sjg@chromium.org>=
 wrote:
> > > > > > > >
> > > > > > > > It is common to split firmware into 'Platform Init', which =
does the
> > > > > > > > initial hardware setup and a "Payload" which selects the OS=
 to be booted.
> > > > > > > > Thus an handover interface is required between these two pi=
eces.
> > > > > > > >
> > > > > > > > Where UEFI boot-time services are not available, but UEFI f=
irmware is
> > > > > > > > present on either side of this interface, information about=
 memory usage
> > > > > > > > and attributes must be presented to the "Payload" in some f=
orm.
> > > > > > > >
> > > > > > > > This aims to provide an small schema addition for the memor=
y mapping
> > > > > > > > needed to keep these two pieces working together well.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Changes in v7:
> > > > > > > > - Rename acpi-reclaim to acpi
> > > > > > > > - Drop individual mention of when memory can be reclaimed
> > > > > > > > - Rewrite the item descriptions
> > > > > > > > - Add back the UEFI text (with trepidation)
> > > > > > >
> > > > > > > I am again checking on this series. Can it be applied, please=
?
> > > > > > >
> > > > > >
> > > > > > Apologies for the delay in response. I have been away.
> > > > >
> > > > > OK, I hope you had a nice trip.
> > > > >
> > > >
> > > > Thanks, it was wonderful!
> > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Changes in v6:
> > > > > > > > - Drop mention of UEFI
> > > > > > > > - Use compatible strings instead of node names
> > > > > > > >
> > > > > > > > Changes in v5:
> > > > > > > > - Drop the memory-map node (should have done that in v4)
> > > > > > > > - Tidy up schema a bit
> > > > > > > >
> > > > > > > > Changes in v4:
> > > > > > > > - Make use of the reserved-memory node instead of creating =
a new one
> > > > > > > >
> > > > > > > > Changes in v3:
> > > > > > > > - Reword commit message again
> > > > > > > > - cc a lot more people, from the FFI patch
> > > > > > > > - Split out the attributes into the /memory nodes
> > > > > > > >
> > > > > > > > Changes in v2:
> > > > > > > > - Reword commit message
> > > > > > > >
> > > > > > > >  .../reserved-memory/common-reserved.yaml      | 71 +++++++=
++++++++++++
> > > > > > > >  1 file changed, 71 insertions(+)
> > > > > > > >  create mode 100644 dtschema/schemas/reserved-memory/common=
-reserved.yaml
> > > > > > > >
> > > > > > > > diff --git a/dtschema/schemas/reserved-memory/common-reserv=
ed.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > > > > > new file mode 100644
> > > > > > > > index 0000000..f7fbdfd
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > > > > > @@ -0,0 +1,71 @@
> > > > > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > > > > > +%YAML 1.2
> > > > > > > > +---
> > > > > > > > +$id: http://devicetree.org/schemas/reserved-memory/common-=
reserved.yaml#
> > > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > > +
> > > > > > > > +title: Common memory reservations
> > > > > > > > +
> > > > > > > > +description: |
> > > > > > > > +  Specifies that the reserved memory region can be used fo=
r the purpose
> > > > > > > > +  indicated by its compatible string.
> > > > > > > > +
> > > > > > > > +  Clients may reuse this reserved memory if they understan=
d what it is for,
> > > > > > > > +  subject to the notes below.
> > > > > > > > +
> > > > > > > > +maintainers:
> > > > > > > > +  - Simon Glass <sjg@chromium.org>
> > > > > > > > +
> > > > > > > > +allOf:
> > > > > > > > +  - $ref: reserved-memory.yaml
> > > > > > > > +
> > > > > > > > +properties:
> > > > > > > > +  compatible:
> > > > > > > > +    description: |
> > > > > > > > +      This describes some common memory reservations, with=
 the compatible
> > > > > > > > +      string indicating what it is used for:
> > > > > > > > +
> > > > > > > > +         acpi: Advanced Configuration and Power Interface =
(ACPI) tables
> > > > > > > > +         acpi-nvs: ACPI Non-Volatile-Sleeping Memory (NVS)=
. This is reserved by
> > > > > > > > +           the firmware for its use and is required to be =
saved and restored
> > > > > > > > +           across an NVS sleep
> > > > > > > > +         boot-code: Contains code used for booting which i=
s not needed by the OS
> > > > > > > > +         boot-code: Contains data used for booting which i=
s not needed by the OS
> > > > > > > > +         runtime-code: Contains code used for interacting =
with the system when
> > > > > > > > +           running the OS
> > > > > > > > +         runtime-data: Contains data used for interacting =
with the system when
> > > > > > > > +           running the OS
> > > > > > > > +
> > > > > > > > +    enum:
> > > > > > > > +      - acpi
> > > > > > > > +      - acpi-nvs
> > > > > > > > +      - boot-code
> > > > > > > > +      - boot-data
> > > > > > > > +      - runtime-code
> > > > > > > > +      - runtime-data
> > > > > > > > +
> > > > > >
> > > > > > As I mentioned a few times already, I don't think these compati=
bles
> > > > > > should be introduced here.
> > > > > >
> > > > > > A reserved region has a specific purpose, and the compatible sh=
ould be
> > > > > > more descriptive than the enum above. If the consumer does not
> > > > > > understand this purpose, it should simply treat the memory as r=
eserved
> > > > > > and not touch it. Alternatively, these regions can be reference=
d from
> > > > > > other DT nodes using phandles if needed.
> > > > >
> > > > > We still need some description of what these regions are used for=
, so
> > > > > that the payload can use the correct regions. I do not have any o=
ther
> > > > > solution to this problem. We are in v7 at present. At least expla=
in
> > > > > where you want the compatible strings to be introduced.
> > > > >
> > > >
> > > > My point is really that by themselves, these regions are not usable=
 by
> > > > either a payload or an OS that consumes this information. Unless th=
ere
> > > > is some other information being provided (via DT I imagine) that
> > > > describes how these things are supposed to be used, they are nothin=
g
> > > > more than memory reservations that should be honored, and providing
> > > > this arbitrary set of labels is unnecessary.
> > > >
> > > > > What sort of extra detail are you looking for? Please be specific=
 and
> > > > > preferably add some suggestions so I can close this out ASAP.
> > > > >
> > > >
> > > > A payload or OS can do nothing with a memory reservation called
> > > > 'runtime-code' it it doesn't know what is inside.
> >
> > Agreed. The question is WHAT runtime-code? The compatible needs to answ=
er that.
> >
> > For example, we have 'ramoops' as a compatible in reserved memory.
> > That tells us *exactly* what's there. We know how to parse it. If we
> > know ramoops is not supported, then we know we can toss it out and
> > reclaim the memory.
>
> So if we said:
>
>    compatible =3D "runtime-code-efi"
>
> would that be OK? We seem to be in catch 22 here, because if I don't
> mention EFI unhappy, but if I do, Ard is unhappy.

Better yes, because then it is for something specific. However, AIUI,
that's setup for the OS and defining that region is already defined by
the EFI memory map. That's Ard's issue. If there's a need outside of
the EFI to OS handoff, then you need to define what that usecase looks
like. Describe the problem rather than present your solution.

If this is all specific to EDK2 then it should say that rather than
'efi'. I imagine Ard would be happier with something tied to EDK2 than
*all* UEFI. Though maybe the problem could be any implementation? IDK.
Maybe it's TF-A that needs to define where the EFI runtime services
region is and that needs to be passed all the way thru to the EFI
implementation? So again, define the problem.

> What about the boottime code....you want to know which project it is from=
?

I think it is the same.

>
> +      - acpi
> +      - acpi-nvs
>
> Those two should be enough info, right?

I think so. NVS is not a term I've heard in relation to ACPI, but that
may just be my limited ACPI knowledge.

> +      - boot-code
> +      - boot-data
>
> For these, they don't pertain to the OS, so perhaps they are OK?

Hard to tell that just from the name... 'boot' could be any component
involved in booting including the OS.

> In
> any case, using a generic term like this makes some sense to me. We
> can always add a new compatible like "efi-boottime-services" later. It
> may be that the boottime services would be handled by the payload, so
> not needed in all cases.

Why later? You have a specific use in mind and I imagine Ard has
thoughts on that.

Rob
