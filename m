Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA98B797A60
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjIGRir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244831AbjIGRio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:38:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DC5E73;
        Thu,  7 Sep 2023 10:38:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8428FC4E683;
        Thu,  7 Sep 2023 15:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694099252;
        bh=cbtVUTODPSn+Y0OWPuZJbt78zkB0GSynU4+n0umgUb8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fIXIsAq4c9CLCuvW4tR34fUBBpEvdtl3V6RjxN2TT0N2joFpPF0IPm+rmwS8U3EHs
         InVyt9GM8x6ObMaDHvJD2xXAFr5eyV00te+y1iW0fxaW6pJFJ2n53Kn7VpPSWWPlLw
         /dBUu1cQX5parpS6MZ9sackGTt426uD8XmUPRkILW43DhI8gNRf6F3gz17bLL+f939
         wYH1ZllEn+nzAEPW+etc51Q9mfDJHco0hNPU8UyKPid0WxVl/lUUiuR6Hfe7JOH1zW
         URj6lCnlVZZ22wVhYyh1jIoUi01e6qUI5oTq76FXhygpvgQ3OdnAB5niq+hXYKfvJc
         nDJjbyYKVJdTw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50079d148aeso1764101e87.3;
        Thu, 07 Sep 2023 08:07:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YxmfOr7APdKWPlx7mt927Ajrly/9KJTh8XqlUwjSUsyVZe9eDay
        XOFwR+9pMAgetLbg2B/FrF3vww80CM6ASRm0NTg=
X-Google-Smtp-Source: AGHT+IF/RO/eEPxFUMmGBROEY1W+ooT3PXUTG5InSg6sF/gBeP0mgjamO7iqAa/R6qmLRpF4TW5ARun4WG4eb7uJ29s=
X-Received: by 2002:a19:e00e:0:b0:500:a41d:354c with SMTP id
 x14-20020a19e00e000000b00500a41d354cmr4289022lfg.28.1694099250361; Thu, 07
 Sep 2023 08:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230830231758.2561402-1-sjg@chromium.org> <20230830231758.2561402-3-sjg@chromium.org>
 <CAMj1kXG5-aqoOtKdPFEdm=_5SdvgUTOhcDOBP1zdARAvKphJtg@mail.gmail.com>
 <CAL_JsqLx0KnXxFc8mFyT_RmA2qeBEutMXj_3nKo_g==cuSeYuQ@mail.gmail.com>
 <CAPnjgZ1U+Gy0Q_Sc63p0ixkWF9iJEEBLhV8-N9-sh7OGNy-OmQ@mail.gmail.com>
 <CAMj1kXG9vM0haSOu19j7ujQCBEN6CBeXVAH96nm+gixt9FmMrA@mail.gmail.com>
 <CAPnjgZ1oGF0Ni3RhK4fv6mJk40YjqyFVJxt6FfS9AW2rkcs9iA@mail.gmail.com>
 <CAMj1kXEZ4fDvbtgXKjF+L7si-=C-5E0XcjutoEF8pU9a-BGN-g@mail.gmail.com>
 <CAPnjgZ0vv+s00xvY2FqP+Fxb12tHuVWg-nwyWTrvuG+Mo4PaWg@mail.gmail.com>
 <CAMj1kXHGpCt8qkd6XYQF8mMdivQkTnEWjv6NzsFK=+N72LAn=Q@mail.gmail.com> <CAPnjgZ1vBaXfBa+FWvASi15=Py0DLbEK5XsRHLrJc02K2Yr_RQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ1vBaXfBa+FWvASi15=Py0DLbEK5XsRHLrJc02K2Yr_RQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 7 Sep 2023 17:07:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFjVPwnu226R8bHbo0i0LZ7jQE+vLPNQa6cvrCYqGD+YA@mail.gmail.com>
Message-ID: <CAMj1kXFjVPwnu226R8bHbo0i0LZ7jQE+vLPNQa6cvrCYqGD+YA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] schemas: Add some common reserved-memory usages
To:     Simon Glass <sjg@chromium.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sept 2023 at 16:50, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ard,
>
> On Thu, 7 Sept 2023 at 08:12, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 7 Sept 2023 at 15:56, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ard,
> > >
> > > On Thu, 7 Sept 2023 at 07:31, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Wed, 6 Sept 2023 at 18:50, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Ard,
> > > > >
> > > > > On Wed, Sep 6, 2023, 10:09 Ard Biesheuvel <ardb@kernel.org> wrote=
:
> > > > >>
> > > > >> On Wed, 6 Sept 2023 at 16:54, Simon Glass <sjg@chromium.org> wro=
te:
> > > > >> >
> > > > >> > Hi Rob, Ard,
> > > > >> >
> > > > >> > On Wed, 6 Sept 2023 at 08:34, Rob Herring <robh@kernel.org> wr=
ote:
> > > > >> > >
> > > > >> > > On Tue, Sep 5, 2023 at 4:44=E2=80=AFPM Ard Biesheuvel <ardb@=
kernel.org> wrote:
> > > > >> > > >
> > > > >> > > > On Thu, 31 Aug 2023 at 01:18, Simon Glass <sjg@chromium.or=
g> wrote:
> > > > >> > > > >
> > > > >> > > > > The Devicetree specification skips over handling of a lo=
gical view of
> > > > >> > > > > the memory map, pointing users to the UEFI specification=
.
> > > > >> > > > >
> > > > >> > > > > It is common to split firmware into 'Platform Init', whi=
ch does the
> > > > >> > > > > initial hardware setup and a "Payload" which selects the=
 OS to be booted.
> > > > >> > > > > Thus an handover interface is required between these two=
 pieces.
> > > > >> > > > >
> > > > >> > > > > Where UEFI boot-time services are not available, but UEF=
I firmware is
> > > > >> > > > > present on either side of this interface, information ab=
out memory usage
> > > > >> > > > > and attributes must be presented to the "Payload" in som=
e form.
> > > > >> > > > >
> > > > >> > > >
> > > > >> > > > I don't think the UEFI references are needed or helpful he=
re.
> > > > >> > > >
> > > > >> > > > > This aims to provide an small schema addition for this m=
apping.
> > > > >> > > > >
> > > > >> > > > > For now, no attempt is made to create an exhaustive bind=
ing, so there are
> > > > >> > > > > some example types listed. More can be added later.
> > > > >> > > > >
> > > > >> > > > > The compatible string is not included, since the node na=
me is enough to
> > > > >> > > > > indicate the purpose of a node, as per the existing rese=
rved-memory
> > > > >> > > > > schema.
> > > > >> > >
> > > > >> > > Node names reflect the 'class', but not what's specifically =
in the
> > > > >> > > node. So really, all reserved-memory nodes should have the s=
ame name,
> > > > >> > > but that ship already sailed for existing users. 'compatible=
' is the
> > > > >> > > right thing here. As to what the node name should be, well, =
we haven't
> > > > >> > > defined that. I think we just used 'memory' on some platform=
s.
> > > > >> >
> > > > >> > OK
> > > > >> >
> > > > >> > >
> > > > >> > > > > This binding does not include a binding for the memory '=
attribute'
> > > > >> > > > > property, defined by EFI_BOOT_SERVICES.GetMemoryMap(). I=
t may be useful
> > > > >> > > > > to have that as well, but perhaps not as a bit mask.
> > > > >> > > > >
> > > > >> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >> > > > > ---
> > > > >> > > > >
> > > > >> > > > > Changes in v5:
> > > > >> > > > > - Drop the memory-map node (should have done that in v4)
> > > > >> > > > > - Tidy up schema a bit
> > > > >> > > > >
> > > > >> > > > > Changes in v4:
> > > > >> > > > > - Make use of the reserved-memory node instead of creati=
ng a new one
> > > > >> > > > >
> > > > >> > > > > Changes in v3:
> > > > >> > > > > - Reword commit message again
> > > > >> > > > > - cc a lot more people, from the FFI patch
> > > > >> > > > > - Split out the attributes into the /memory nodes
> > > > >> > > > >
> > > > >> > > > > Changes in v2:
> > > > >> > > > > - Reword commit message
> > > > >> > > > >
> > > > >> > > > >  .../reserved-memory/common-reserved.yaml      | 53 ++++=
+++++++++++++++
> > > > >> > > > >  1 file changed, 53 insertions(+)
> > > > >> > > > >  create mode 100644 dtschema/schemas/reserved-memory/com=
mon-reserved.yaml
> > > > >> > > > >
> > > > >> > > > > diff --git a/dtschema/schemas/reserved-memory/common-res=
erved.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > >> > > > > new file mode 100644
> > > > >> > > > > index 0000000..d1b466b
> > > > >> > > > > --- /dev/null
> > > > >> > > > > +++ b/dtschema/schemas/reserved-memory/common-reserved.y=
aml
> > > > >> > > > > @@ -0,0 +1,53 @@
> > > > >> > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > >> > > > > +%YAML 1.2
> > > > >> > > > > +---
> > > > >> > > > > +$id: http://devicetree.org/schemas/reserved-memory/comm=
on-reserved.yaml#
> > > > >> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > >> > > > > +
> > > > >> > > > > +title: Common memory reservations
> > > > >> > > > > +
> > > > >> > > > > +description: |
> > > > >> > > > > +  Specifies that the reserved memory region can be used=
 for the purpose
> > > > >> > > > > +  indicated by its node name.
> > > > >> > > > > +
> > > > >> > > > > +  Clients may reuse this reserved memory if they unders=
tand what it is for.
> > > > >> > > > > +
> > > > >> > > > > +maintainers:
> > > > >> > > > > +  - Simon Glass <sjg@chromium.org>
> > > > >> > > > > +
> > > > >> > > > > +allOf:
> > > > >> > > > > +  - $ref: reserved-memory.yaml
> > > > >> > > > > +
> > > > >> > > > > +properties:
> > > > >> > > > > +  $nodename:
> > > > >> > > > > +    enum:
> > > > >> > > > > +      - acpi-reclaim
> > > > >> > > > > +      - acpi-nvs
> > > > >> > > > > +      - boot-code
> > > > >> > > > > +      - boot-data
> > > > >> > > > > +      - runtime-code
> > > > >> > > > > +      - runtime-data
> > > > >> > > > > +
> > > > >> > > >
> > > > >> > > > These types are used by firmware to describe the nature of=
 certain
> > > > >> > > > memory regions to the OS. Boot code and data can be discar=
ded, as well
> > > > >> > > > as ACPI reclaim after its contents have been consumed. Run=
time code
> > > > >> > > > and data need to be mapped for runtime features to work.
> > > > >> > > >
> > > > >> > > > When one firmware phase communicates the purpose of a cert=
ain memory
> > > > >> > > > reservation to another, it is typically not limited to whe=
ther its
> > > > >> > > > needs to be preserved and when it needs to be mapped (and =
with which
> > > > >> > > > attributes). I'd expect a memory reservation appearing und=
er this node
> > > > >> > > > to have a clearly defined purpose, and the subsequent phas=
es need to
> > > > >> > > > be able to discover this information.
> > > > >> > > >
> > > > >> > > > For example, a communication buffer for secure<->non-secur=
e
> > > > >> > > > communication or a page with spin tables used by PSCI. Non=
e of the
> > > > >> > > > proposed labels are appropriate for this, and I'd much rat=
her have a
> > > > >> > > > compatible string or some other property that clarifies th=
e nature in
> > > > >> > > > a more suitable way. Note that 'no-map' already exists to =
indicate
> > > > >> > > > that the CPU should not map this memory unless it does so =
for the
> > > > >> > > > specific purpose that the reservation was made for.
> > > > >> > >
> > > > >> > > I agree. I think compatible is the better approach. Some pro=
perty like
> > > > >> > > 'discard' may not be sufficient information if the OS needs =
to consume
> > > > >> > > the region first and then discard it. Better to state exactl=
y what's
> > > > >> > > there and then the OS can imply the rest.
> > > > >> >
> > > > >> > OK, so what sort of compatible strings?
> > > > >> >
> > > > >> > How about:
> > > > >> > "acpi-reclaim" - holds ACPI tables; memory can be reclaimed on=
ce the
> > > > >> > tables are read and no-longer needed
> > > > >>
> > > > >> ACPI reclaim is a policy, not a purpose. This memory could conta=
in
> > > > >> many different things.
> > > > >>
> > > > >> > "boot-code" - holds boot code; memory can be reclaimed once th=
e boot
> > > > >> > phase is complete
> > > > >> > "runtime-code" - holds runtime code; memory can be reclaimed o=
nly if
> > > > >> > this code will not be used from that point
> > > > >> >
> > > > >>
> > > > >> These are also policies. They can be inferred from the purpose.
> > > > >>
> > > > >> > etc. We can then have more specific compatibles, like:
> > > > >> >
> > > > >> > "psci-spin-table" - holds PSCI spin tables
> > > > >> >
> > > > >> > so you could do:
> > > > >> >
> > > > >> > compatible =3D "runtime-code", "psci-spin-table";
> > > > >> >
> > > > >>
> > > > >> I understand that this binding targets firmware<->firmware rathe=
r than
> > > > >> firmware<->OS, which makes it much more difficult to keep it bot=
h
> > > > >> generic and sufficiently descriptive.
> > > > >>
> > > > >> However, I still feel that all the overlap with UEFI memory type=
s is
> > > > >> not what we want here. UEFI knows how to manage its own memory m=
ap,
> > > > >> what it needs to know is what memory is already in use and for w=
hich
> > > > >> exact purpose. Whether or not that implies that the memory can b=
e
> > > > >> freed at some point or can be mapped or not should follow from t=
hat.
> > > > >
> > > > >
> > > > > Can you please make a suggestion? I am unsure what you are lookin=
g for.
> > > > >
> > > >
> > > > I'm happy to help flesh this out, but you still have not provided u=
s
> > > > with an actual use case, so I can only draw from my own experience
> > > > putting together firmware for virtual and physical ARM machines.
> > >
> > > I did explain that this is needed when Tianocore is on both sides of
> > > the interface, since Platform Init places some things in memory and
> > > the Payload needs to preserve them there, and/or know where they are.
> > >
> > > I think the problem might be that you don't agree with that, but it
> > > seems to be a fact, so I am not sure how I can alter it.
> > >
> > > Please can you clearly explain which part of the use case you are mis=
sing.
> > >
> >
> > 'Tianocore on both sides of the interface' means that Tianocore runs
> > as the platform init code, and uses a bespoke DT based protocol to
> > launch another instance of Tianocore as the payload, right?
>
> Not another instance, no. Just the other half of Tianocore. The first
> half does platform init and the second half does the loading of the
> OS.
>

That doesn't make any sense to me.

> >
> > Tianocore/EDK2 already implements methods to reinvoke itself if needed
> > (e.g., during a firmware update), and does so by launching a new DXE
> > core. So the boot sequence looks like
> >
> > SEC -> PEI -> DXE -> BDS -> app that invokes UpdateCapsule() -> DXE ->
> > firmware update
> >
> > So please elaborate on how this Tianocore on both sides of the
> > interface is put together when it uses this DT based handover. We
> > really need a better understanding of this in order to design a DT
> > binding that meets its needs.
>
> Are you familiar with building Tianocore as a coreboot payload, for
> example? That shows Tianocore running as just the Payload, with
> coreboot doing the platform init. So the use case I am talking about
> is similar to that.
>

Yes I am familiar with that, and it is a completely different thing.

As i explained before, there is already prior art for this in
Tianocore, i.e., launching a Tianocore build based on a DT description
of the platform, including /memory and /reserved-memory nodes.

I argued that Tianocore never consumes memory reservations with UEFI
semantics, given that it supplants whatever UEFI functionality the
previous stage may have provided. But it shouldn't step on the code
and data regions used by the previous stage if it is still running in
the background (e.g., OS at EL1 and PSCI at EL2 on ARM)

So this brings me back to the things I proposed in my previous reply:
- memory reservations should be described in detail so the consumer
knows what to do with it
- memory reservations should have attributes that describe how the
memory may be used if not for the described purpose

I still don't see a reason for things like runtime-code and
runtime-data etc based on the above. If stage N describes the memory
it occupies itself as system memory, it should reserve it as well if
it needs to be preserved after stage N+1 has taken over, so perhaps it
should be described as a discardable memory reservation but I don't
think it necessarily needs a type in that case.
