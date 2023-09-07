Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C077976B8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbjIGQPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239846AbjIGQOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:14:42 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CB0420F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:11:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so144203466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694103005; x=1694707805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JN+Qao8IdvyNSWvDm5vhSmhNPjf4gx2dY5//ckJMUw=;
        b=R9i29q3oQvSMucvyxIxo10H9+bhYIMb/Odv3TkSHqu40r5E3fe8G/4dxnjdTdoEgBp
         7vvtOx35JLPs+VHGz9HVASSBeydPh5YZbPVJdNzXS7RQc7ZiPtrKUcCTN7GeufZmgfDS
         kKML0oPZOfoALvVkHeKwAYhdXzFhBWOj6ar+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103005; x=1694707805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JN+Qao8IdvyNSWvDm5vhSmhNPjf4gx2dY5//ckJMUw=;
        b=RXWAVfjCwM/LaF9w9y81MdA7oXR89BMgkvZdX2T5U2EBSiAAJsA9ME6UjwiH0oT750
         nQc6tCA18VLSgoefdrMGD/EtqMJNGQ6ICSj/c+jFpSgSk/uo9t8PQJiytEHYXV+kM3Ym
         Fm57NUk2XkiiNr/+/BMQacO9NEYgpErcEamPMs9rLDt2HOtOtYS6CdV7NWmvU0n131sh
         /+4R/H62VDjjcTjyktGquZAlw7EzjJ53jgySjL4DMX+EdcULkbc4P98hrHnaX7ErlTBo
         Delr5HZzWjor8okK+6tW8pwzWh8PN2I6uSP4d9sQ3uz+fgFE4AoFanw4QBDoUPye/wDK
         iAhg==
X-Gm-Message-State: AOJu0YytsuIXDvS+A5K/d0pETiNxUV/0LHCALfnG3+dLakT0BymZnTUp
        9U7HMp5YgAG0Y248ZH+y35a1hrOemzWdrGkbuhCoeGqaBdSMwnfmTX8=
X-Google-Smtp-Source: AGHT+IGKYHUOwu4XGYcybpijSZ0JznJv7+Gh4Hl56ZWHPkAdzWLM3X+6tE/P1NiSyW/cwzz+UlzCUK6gEy03EY7aOO0=
X-Received: by 2002:a17:906:518d:b0:9a1:f81f:d0d5 with SMTP id
 y13-20020a170906518d00b009a1f81fd0d5mr4617047ejk.54.1694102215719; Thu, 07
 Sep 2023 08:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230830231758.2561402-1-sjg@chromium.org> <20230830231758.2561402-3-sjg@chromium.org>
 <CAMj1kXG5-aqoOtKdPFEdm=_5SdvgUTOhcDOBP1zdARAvKphJtg@mail.gmail.com>
 <CAL_JsqLx0KnXxFc8mFyT_RmA2qeBEutMXj_3nKo_g==cuSeYuQ@mail.gmail.com>
 <CAPnjgZ1U+Gy0Q_Sc63p0ixkWF9iJEEBLhV8-N9-sh7OGNy-OmQ@mail.gmail.com>
 <CAMj1kXG9vM0haSOu19j7ujQCBEN6CBeXVAH96nm+gixt9FmMrA@mail.gmail.com>
 <CAPnjgZ1oGF0Ni3RhK4fv6mJk40YjqyFVJxt6FfS9AW2rkcs9iA@mail.gmail.com>
 <CAMj1kXEZ4fDvbtgXKjF+L7si-=C-5E0XcjutoEF8pU9a-BGN-g@mail.gmail.com>
 <CAPnjgZ0vv+s00xvY2FqP+Fxb12tHuVWg-nwyWTrvuG+Mo4PaWg@mail.gmail.com>
 <CAMj1kXHGpCt8qkd6XYQF8mMdivQkTnEWjv6NzsFK=+N72LAn=Q@mail.gmail.com>
 <CAPnjgZ1vBaXfBa+FWvASi15=Py0DLbEK5XsRHLrJc02K2Yr_RQ@mail.gmail.com> <CAMj1kXFjVPwnu226R8bHbo0i0LZ7jQE+vLPNQa6cvrCYqGD+YA@mail.gmail.com>
In-Reply-To: <CAMj1kXFjVPwnu226R8bHbo0i0LZ7jQE+vLPNQa6cvrCYqGD+YA@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Thu, 7 Sep 2023 09:56:37 -0600
Message-ID: <CAPnjgZ1fVJE=ar_rB_So+vjkOZ_pDjaO5wwPn3pMKe=n3MmBeg@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] schemas: Add some common reserved-memory usages
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Devicetree Discuss <devicetree@vger.kernel.org>,
        Maximilian Brune <maximilian.brune@9elements.com>,
        ron minnich <rminnich@gmail.com>,
        Tom Rini <trini@konsulko.com>,
        Dhaval Sharma <dhaval@rivosinc.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        linux-acpi@vger.kernel.org, Gua Guo <gua.guo@intel.com>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        Guo Dong <guo.dong@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Chiu Chasel <chasel.chiu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Thu, 7 Sept 2023 at 09:07, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 7 Sept 2023 at 16:50, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ard,
> >
> > On Thu, 7 Sept 2023 at 08:12, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Thu, 7 Sept 2023 at 15:56, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ard,
> > > >
> > > > On Thu, 7 Sept 2023 at 07:31, Ard Biesheuvel <ardb@kernel.org> wrot=
e:
> > > > >
> > > > > On Wed, 6 Sept 2023 at 18:50, Simon Glass <sjg@chromium.org> wrot=
e:
> > > > > >
> > > > > > Hi Ard,
> > > > > >
> > > > > > On Wed, Sep 6, 2023, 10:09 Ard Biesheuvel <ardb@kernel.org> wro=
te:
> > > > > >>
> > > > > >> On Wed, 6 Sept 2023 at 16:54, Simon Glass <sjg@chromium.org> w=
rote:
> > > > > >> >
> > > > > >> > Hi Rob, Ard,
> > > > > >> >
> > > > > >> > On Wed, 6 Sept 2023 at 08:34, Rob Herring <robh@kernel.org> =
wrote:
> > > > > >> > >
> > > > > >> > > On Tue, Sep 5, 2023 at 4:44=E2=80=AFPM Ard Biesheuvel <ard=
b@kernel.org> wrote:
> > > > > >> > > >
> > > > > >> > > > On Thu, 31 Aug 2023 at 01:18, Simon Glass <sjg@chromium.=
org> wrote:
> > > > > >> > > > >
> > > > > >> > > > > The Devicetree specification skips over handling of a =
logical view of
> > > > > >> > > > > the memory map, pointing users to the UEFI specificati=
on.
> > > > > >> > > > >
> > > > > >> > > > > It is common to split firmware into 'Platform Init', w=
hich does the
> > > > > >> > > > > initial hardware setup and a "Payload" which selects t=
he OS to be booted.
> > > > > >> > > > > Thus an handover interface is required between these t=
wo pieces.
> > > > > >> > > > >
> > > > > >> > > > > Where UEFI boot-time services are not available, but U=
EFI firmware is
> > > > > >> > > > > present on either side of this interface, information =
about memory usage
> > > > > >> > > > > and attributes must be presented to the "Payload" in s=
ome form.
> > > > > >> > > > >
> > > > > >> > > >
> > > > > >> > > > I don't think the UEFI references are needed or helpful =
here.
> > > > > >> > > >
> > > > > >> > > > > This aims to provide an small schema addition for this=
 mapping.
> > > > > >> > > > >
> > > > > >> > > > > For now, no attempt is made to create an exhaustive bi=
nding, so there are
> > > > > >> > > > > some example types listed. More can be added later.
> > > > > >> > > > >
> > > > > >> > > > > The compatible string is not included, since the node =
name is enough to
> > > > > >> > > > > indicate the purpose of a node, as per the existing re=
served-memory
> > > > > >> > > > > schema.
> > > > > >> > >
> > > > > >> > > Node names reflect the 'class', but not what's specificall=
y in the
> > > > > >> > > node. So really, all reserved-memory nodes should have the=
 same name,
> > > > > >> > > but that ship already sailed for existing users. 'compatib=
le' is the
> > > > > >> > > right thing here. As to what the node name should be, well=
, we haven't
> > > > > >> > > defined that. I think we just used 'memory' on some platfo=
rms.
> > > > > >> >
> > > > > >> > OK
> > > > > >> >
> > > > > >> > >
> > > > > >> > > > > This binding does not include a binding for the memory=
 'attribute'
> > > > > >> > > > > property, defined by EFI_BOOT_SERVICES.GetMemoryMap().=
 It may be useful
> > > > > >> > > > > to have that as well, but perhaps not as a bit mask.
> > > > > >> > > > >
> > > > > >> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > >> > > > > ---
> > > > > >> > > > >
> > > > > >> > > > > Changes in v5:
> > > > > >> > > > > - Drop the memory-map node (should have done that in v=
4)
> > > > > >> > > > > - Tidy up schema a bit
> > > > > >> > > > >
> > > > > >> > > > > Changes in v4:
> > > > > >> > > > > - Make use of the reserved-memory node instead of crea=
ting a new one
> > > > > >> > > > >
> > > > > >> > > > > Changes in v3:
> > > > > >> > > > > - Reword commit message again
> > > > > >> > > > > - cc a lot more people, from the FFI patch
> > > > > >> > > > > - Split out the attributes into the /memory nodes
> > > > > >> > > > >
> > > > > >> > > > > Changes in v2:
> > > > > >> > > > > - Reword commit message
> > > > > >> > > > >
> > > > > >> > > > >  .../reserved-memory/common-reserved.yaml      | 53 ++=
+++++++++++++++++
> > > > > >> > > > >  1 file changed, 53 insertions(+)
> > > > > >> > > > >  create mode 100644 dtschema/schemas/reserved-memory/c=
ommon-reserved.yaml
> > > > > >> > > > >
> > > > > >> > > > > diff --git a/dtschema/schemas/reserved-memory/common-r=
eserved.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > > >> > > > > new file mode 100644
> > > > > >> > > > > index 0000000..d1b466b
> > > > > >> > > > > --- /dev/null
> > > > > >> > > > > +++ b/dtschema/schemas/reserved-memory/common-reserved=
.yaml
> > > > > >> > > > > @@ -0,0 +1,53 @@
> > > > > >> > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clau=
se
> > > > > >> > > > > +%YAML 1.2
> > > > > >> > > > > +---
> > > > > >> > > > > +$id: http://devicetree.org/schemas/reserved-memory/co=
mmon-reserved.yaml#
> > > > > >> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml=
#
> > > > > >> > > > > +
> > > > > >> > > > > +title: Common memory reservations
> > > > > >> > > > > +
> > > > > >> > > > > +description: |
> > > > > >> > > > > +  Specifies that the reserved memory region can be us=
ed for the purpose
> > > > > >> > > > > +  indicated by its node name.
> > > > > >> > > > > +
> > > > > >> > > > > +  Clients may reuse this reserved memory if they unde=
rstand what it is for.
> > > > > >> > > > > +
> > > > > >> > > > > +maintainers:
> > > > > >> > > > > +  - Simon Glass <sjg@chromium.org>
> > > > > >> > > > > +
> > > > > >> > > > > +allOf:
> > > > > >> > > > > +  - $ref: reserved-memory.yaml
> > > > > >> > > > > +
> > > > > >> > > > > +properties:
> > > > > >> > > > > +  $nodename:
> > > > > >> > > > > +    enum:
> > > > > >> > > > > +      - acpi-reclaim
> > > > > >> > > > > +      - acpi-nvs
> > > > > >> > > > > +      - boot-code
> > > > > >> > > > > +      - boot-data
> > > > > >> > > > > +      - runtime-code
> > > > > >> > > > > +      - runtime-data
> > > > > >> > > > > +
> > > > > >> > > >
> > > > > >> > > > These types are used by firmware to describe the nature =
of certain
> > > > > >> > > > memory regions to the OS. Boot code and data can be disc=
arded, as well
> > > > > >> > > > as ACPI reclaim after its contents have been consumed. R=
untime code
> > > > > >> > > > and data need to be mapped for runtime features to work.
> > > > > >> > > >
> > > > > >> > > > When one firmware phase communicates the purpose of a ce=
rtain memory
> > > > > >> > > > reservation to another, it is typically not limited to w=
hether its
> > > > > >> > > > needs to be preserved and when it needs to be mapped (an=
d with which
> > > > > >> > > > attributes). I'd expect a memory reservation appearing u=
nder this node
> > > > > >> > > > to have a clearly defined purpose, and the subsequent ph=
ases need to
> > > > > >> > > > be able to discover this information.
> > > > > >> > > >
> > > > > >> > > > For example, a communication buffer for secure<->non-sec=
ure
> > > > > >> > > > communication or a page with spin tables used by PSCI. N=
one of the
> > > > > >> > > > proposed labels are appropriate for this, and I'd much r=
ather have a
> > > > > >> > > > compatible string or some other property that clarifies =
the nature in
> > > > > >> > > > a more suitable way. Note that 'no-map' already exists t=
o indicate
> > > > > >> > > > that the CPU should not map this memory unless it does s=
o for the
> > > > > >> > > > specific purpose that the reservation was made for.
> > > > > >> > >
> > > > > >> > > I agree. I think compatible is the better approach. Some p=
roperty like
> > > > > >> > > 'discard' may not be sufficient information if the OS need=
s to consume
> > > > > >> > > the region first and then discard it. Better to state exac=
tly what's
> > > > > >> > > there and then the OS can imply the rest.
> > > > > >> >
> > > > > >> > OK, so what sort of compatible strings?
> > > > > >> >
> > > > > >> > How about:
> > > > > >> > "acpi-reclaim" - holds ACPI tables; memory can be reclaimed =
once the
> > > > > >> > tables are read and no-longer needed
> > > > > >>
> > > > > >> ACPI reclaim is a policy, not a purpose. This memory could con=
tain
> > > > > >> many different things.
> > > > > >>
> > > > > >> > "boot-code" - holds boot code; memory can be reclaimed once =
the boot
> > > > > >> > phase is complete
> > > > > >> > "runtime-code" - holds runtime code; memory can be reclaimed=
 only if
> > > > > >> > this code will not be used from that point
> > > > > >> >
> > > > > >>
> > > > > >> These are also policies. They can be inferred from the purpose=
.
> > > > > >>
> > > > > >> > etc. We can then have more specific compatibles, like:
> > > > > >> >
> > > > > >> > "psci-spin-table" - holds PSCI spin tables
> > > > > >> >
> > > > > >> > so you could do:
> > > > > >> >
> > > > > >> > compatible =3D "runtime-code", "psci-spin-table";
> > > > > >> >
> > > > > >>
> > > > > >> I understand that this binding targets firmware<->firmware rat=
her than
> > > > > >> firmware<->OS, which makes it much more difficult to keep it b=
oth
> > > > > >> generic and sufficiently descriptive.
> > > > > >>
> > > > > >> However, I still feel that all the overlap with UEFI memory ty=
pes is
> > > > > >> not what we want here. UEFI knows how to manage its own memory=
 map,
> > > > > >> what it needs to know is what memory is already in use and for=
 which
> > > > > >> exact purpose. Whether or not that implies that the memory can=
 be
> > > > > >> freed at some point or can be mapped or not should follow from=
 that.
> > > > > >
> > > > > >
> > > > > > Can you please make a suggestion? I am unsure what you are look=
ing for.
> > > > > >
> > > > >
> > > > > I'm happy to help flesh this out, but you still have not provided=
 us
> > > > > with an actual use case, so I can only draw from my own experienc=
e
> > > > > putting together firmware for virtual and physical ARM machines.
> > > >
> > > > I did explain that this is needed when Tianocore is on both sides o=
f
> > > > the interface, since Platform Init places some things in memory and
> > > > the Payload needs to preserve them there, and/or know where they ar=
e.
> > > >
> > > > I think the problem might be that you don't agree with that, but it
> > > > seems to be a fact, so I am not sure how I can alter it.
> > > >
> > > > Please can you clearly explain which part of the use case you are m=
issing.
> > > >
> > >
> > > 'Tianocore on both sides of the interface' means that Tianocore runs
> > > as the platform init code, and uses a bespoke DT based protocol to
> > > launch another instance of Tianocore as the payload, right?
> >
> > Not another instance, no. Just the other half of Tianocore. The first
> > half does platform init and the second half does the loading of the
> > OS.
> >
>
> That doesn't make any sense to me.
>
> > >
> > > Tianocore/EDK2 already implements methods to reinvoke itself if neede=
d
> > > (e.g., during a firmware update), and does so by launching a new DXE
> > > core. So the boot sequence looks like
> > >
> > > SEC -> PEI -> DXE -> BDS -> app that invokes UpdateCapsule() -> DXE -=
>
> > > firmware update
> > >
> > > So please elaborate on how this Tianocore on both sides of the
> > > interface is put together when it uses this DT based handover. We
> > > really need a better understanding of this in order to design a DT
> > > binding that meets its needs.
> >
> > Are you familiar with building Tianocore as a coreboot payload, for
> > example? That shows Tianocore running as just the Payload, with
> > coreboot doing the platform init. So the use case I am talking about
> > is similar to that.
> >
>
> Yes I am familiar with that, and it is a completely different thing.

Right, but that is my use case.

>
> As i explained before, there is already prior art for this in
> Tianocore, i.e., launching a Tianocore build based on a DT description
> of the platform, including /memory and /reserved-memory nodes.

By prior art do you mean code, or an existing binding? In either case,
can you please point me to it? Is this a generic binding used on x86
as well, or just for ARM?

My goal here is to augment the binding.

>
> I argued that Tianocore never consumes memory reservations with UEFI
> semantics, given that it supplants whatever UEFI functionality the
> previous stage may have provided. But it shouldn't step on the code
> and data regions used by the previous stage if it is still running in
> the background (e.g., OS at EL1 and PSCI at EL2 on ARM)
>
> So this brings me back to the things I proposed in my previous reply:
> - memory reservations should be described in detail so the consumer
> knows what to do with it

Yes I can add more detail, if that is all that is needed. But we seem
to still not be aligned on the goal.


> - memory reservations should have attributes that describe how the
> memory may be used if not for the described purpose
>
> I still don't see a reason for things like runtime-code and
> runtime-data etc based on the above. If stage N describes the memory
> it occupies itself as system memory, it should reserve it as well if
> it needs to be preserved after stage N+1 has taken over, so perhaps it
> should be described as a discardable memory reservation but I don't
> think it necessarily needs a type in that case.

Well if you can find another way to do this in the DT, that is fine.

Regards,
Simon
