Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081627976E5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbjIGQSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238924AbjIGQRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:17:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428FA659C;
        Thu,  7 Sep 2023 08:53:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE3FC32790;
        Thu,  7 Sep 2023 14:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694095972;
        bh=QUc1tsLO7zUJeHD0MZENRlZb3TfRCagrYzJmPBEK058=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f8iIOjw5iXtrWXpBFX07K9kRtKrmN5HdItESH206AVhEZ20Z7OnaEhdUwF4IyYpjN
         ZfmmnD2kxyqh/HMDf3gdK+dbY54/am2aZEEE/hOyr8RsN6stWR21ckyvMWRdPkztP4
         blGHhUwgj4TpnaHZTGx7S0ge1TUlLn8BcbnWPaSj5XeHWQnHA9IL/m9A5UO5a9bwFT
         F98C/rz82pJWREpj97y/hBBSFm/H5WVHacQkYeqQ1dnFWwVNNOLy0BCswpedkP7H+4
         iJZA8r8OSP9KCtOhx5F4CRj3ugCDeb39eY7cdXxW47ewZj8dUrbDsP0YY43/wzIg6/
         n//qJIjQJuVGQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b962c226ceso17443821fa.3;
        Thu, 07 Sep 2023 07:12:52 -0700 (PDT)
X-Gm-Message-State: AOJu0YzUPUVr6my5xHQ7wLX3+vAKFTid/zuW77uErMwRhLqKUbQpMcjR
        8SpSZg9trQRrUuT0mIoWBEZlcIxTeJZC4Y587aw=
X-Google-Smtp-Source: AGHT+IGR3EPKgQgP4eoW6QqN8tqzLasHJNbaTYYRQ14asiM8DuRVZc0sGAn0HbeQjWcX4owwhl7616t3ciBvj67ZLhM=
X-Received: by 2002:a2e:9089:0:b0:2b9:4b2b:89d8 with SMTP id
 l9-20020a2e9089000000b002b94b2b89d8mr4717024ljg.35.1694095970585; Thu, 07 Sep
 2023 07:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230830231758.2561402-1-sjg@chromium.org> <20230830231758.2561402-3-sjg@chromium.org>
 <CAMj1kXG5-aqoOtKdPFEdm=_5SdvgUTOhcDOBP1zdARAvKphJtg@mail.gmail.com>
 <CAL_JsqLx0KnXxFc8mFyT_RmA2qeBEutMXj_3nKo_g==cuSeYuQ@mail.gmail.com>
 <CAPnjgZ1U+Gy0Q_Sc63p0ixkWF9iJEEBLhV8-N9-sh7OGNy-OmQ@mail.gmail.com>
 <CAMj1kXG9vM0haSOu19j7ujQCBEN6CBeXVAH96nm+gixt9FmMrA@mail.gmail.com>
 <CAPnjgZ1oGF0Ni3RhK4fv6mJk40YjqyFVJxt6FfS9AW2rkcs9iA@mail.gmail.com>
 <CAMj1kXEZ4fDvbtgXKjF+L7si-=C-5E0XcjutoEF8pU9a-BGN-g@mail.gmail.com> <CAPnjgZ0vv+s00xvY2FqP+Fxb12tHuVWg-nwyWTrvuG+Mo4PaWg@mail.gmail.com>
In-Reply-To: <CAPnjgZ0vv+s00xvY2FqP+Fxb12tHuVWg-nwyWTrvuG+Mo4PaWg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 7 Sep 2023 16:12:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHGpCt8qkd6XYQF8mMdivQkTnEWjv6NzsFK=+N72LAn=Q@mail.gmail.com>
Message-ID: <CAMj1kXHGpCt8qkd6XYQF8mMdivQkTnEWjv6NzsFK=+N72LAn=Q@mail.gmail.com>
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

On Thu, 7 Sept 2023 at 15:56, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ard,
>
> On Thu, 7 Sept 2023 at 07:31, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 6 Sept 2023 at 18:50, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ard,
> > >
> > > On Wed, Sep 6, 2023, 10:09 Ard Biesheuvel <ardb@kernel.org> wrote:
> > >>
> > >> On Wed, 6 Sept 2023 at 16:54, Simon Glass <sjg@chromium.org> wrote:
> > >> >
> > >> > Hi Rob, Ard,
> > >> >
> > >> > On Wed, 6 Sept 2023 at 08:34, Rob Herring <robh@kernel.org> wrote:
> > >> > >
> > >> > > On Tue, Sep 5, 2023 at 4:44=E2=80=AFPM Ard Biesheuvel <ardb@kern=
el.org> wrote:
> > >> > > >
> > >> > > > On Thu, 31 Aug 2023 at 01:18, Simon Glass <sjg@chromium.org> w=
rote:
> > >> > > > >
> > >> > > > > The Devicetree specification skips over handling of a logica=
l view of
> > >> > > > > the memory map, pointing users to the UEFI specification.
> > >> > > > >
> > >> > > > > It is common to split firmware into 'Platform Init', which d=
oes the
> > >> > > > > initial hardware setup and a "Payload" which selects the OS =
to be booted.
> > >> > > > > Thus an handover interface is required between these two pie=
ces.
> > >> > > > >
> > >> > > > > Where UEFI boot-time services are not available, but UEFI fi=
rmware is
> > >> > > > > present on either side of this interface, information about =
memory usage
> > >> > > > > and attributes must be presented to the "Payload" in some fo=
rm.
> > >> > > > >
> > >> > > >
> > >> > > > I don't think the UEFI references are needed or helpful here.
> > >> > > >
> > >> > > > > This aims to provide an small schema addition for this mappi=
ng.
> > >> > > > >
> > >> > > > > For now, no attempt is made to create an exhaustive binding,=
 so there are
> > >> > > > > some example types listed. More can be added later.
> > >> > > > >
> > >> > > > > The compatible string is not included, since the node name i=
s enough to
> > >> > > > > indicate the purpose of a node, as per the existing reserved=
-memory
> > >> > > > > schema.
> > >> > >
> > >> > > Node names reflect the 'class', but not what's specifically in t=
he
> > >> > > node. So really, all reserved-memory nodes should have the same =
name,
> > >> > > but that ship already sailed for existing users. 'compatible' is=
 the
> > >> > > right thing here. As to what the node name should be, well, we h=
aven't
> > >> > > defined that. I think we just used 'memory' on some platforms.
> > >> >
> > >> > OK
> > >> >
> > >> > >
> > >> > > > > This binding does not include a binding for the memory 'attr=
ibute'
> > >> > > > > property, defined by EFI_BOOT_SERVICES.GetMemoryMap(). It ma=
y be useful
> > >> > > > > to have that as well, but perhaps not as a bit mask.
> > >> > > > >
> > >> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >> > > > > ---
> > >> > > > >
> > >> > > > > Changes in v5:
> > >> > > > > - Drop the memory-map node (should have done that in v4)
> > >> > > > > - Tidy up schema a bit
> > >> > > > >
> > >> > > > > Changes in v4:
> > >> > > > > - Make use of the reserved-memory node instead of creating a=
 new one
> > >> > > > >
> > >> > > > > Changes in v3:
> > >> > > > > - Reword commit message again
> > >> > > > > - cc a lot more people, from the FFI patch
> > >> > > > > - Split out the attributes into the /memory nodes
> > >> > > > >
> > >> > > > > Changes in v2:
> > >> > > > > - Reword commit message
> > >> > > > >
> > >> > > > >  .../reserved-memory/common-reserved.yaml      | 53 ++++++++=
+++++++++++
> > >> > > > >  1 file changed, 53 insertions(+)
> > >> > > > >  create mode 100644 dtschema/schemas/reserved-memory/common-=
reserved.yaml
> > >> > > > >
> > >> > > > > diff --git a/dtschema/schemas/reserved-memory/common-reserve=
d.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > >> > > > > new file mode 100644
> > >> > > > > index 0000000..d1b466b
> > >> > > > > --- /dev/null
> > >> > > > > +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > >> > > > > @@ -0,0 +1,53 @@
> > >> > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > >> > > > > +%YAML 1.2
> > >> > > > > +---
> > >> > > > > +$id: http://devicetree.org/schemas/reserved-memory/common-r=
eserved.yaml#
> > >> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >> > > > > +
> > >> > > > > +title: Common memory reservations
> > >> > > > > +
> > >> > > > > +description: |
> > >> > > > > +  Specifies that the reserved memory region can be used for=
 the purpose
> > >> > > > > +  indicated by its node name.
> > >> > > > > +
> > >> > > > > +  Clients may reuse this reserved memory if they understand=
 what it is for.
> > >> > > > > +
> > >> > > > > +maintainers:
> > >> > > > > +  - Simon Glass <sjg@chromium.org>
> > >> > > > > +
> > >> > > > > +allOf:
> > >> > > > > +  - $ref: reserved-memory.yaml
> > >> > > > > +
> > >> > > > > +properties:
> > >> > > > > +  $nodename:
> > >> > > > > +    enum:
> > >> > > > > +      - acpi-reclaim
> > >> > > > > +      - acpi-nvs
> > >> > > > > +      - boot-code
> > >> > > > > +      - boot-data
> > >> > > > > +      - runtime-code
> > >> > > > > +      - runtime-data
> > >> > > > > +
> > >> > > >
> > >> > > > These types are used by firmware to describe the nature of cer=
tain
> > >> > > > memory regions to the OS. Boot code and data can be discarded,=
 as well
> > >> > > > as ACPI reclaim after its contents have been consumed. Runtime=
 code
> > >> > > > and data need to be mapped for runtime features to work.
> > >> > > >
> > >> > > > When one firmware phase communicates the purpose of a certain =
memory
> > >> > > > reservation to another, it is typically not limited to whether=
 its
> > >> > > > needs to be preserved and when it needs to be mapped (and with=
 which
> > >> > > > attributes). I'd expect a memory reservation appearing under t=
his node
> > >> > > > to have a clearly defined purpose, and the subsequent phases n=
eed to
> > >> > > > be able to discover this information.
> > >> > > >
> > >> > > > For example, a communication buffer for secure<->non-secure
> > >> > > > communication or a page with spin tables used by PSCI. None of=
 the
> > >> > > > proposed labels are appropriate for this, and I'd much rather =
have a
> > >> > > > compatible string or some other property that clarifies the na=
ture in
> > >> > > > a more suitable way. Note that 'no-map' already exists to indi=
cate
> > >> > > > that the CPU should not map this memory unless it does so for =
the
> > >> > > > specific purpose that the reservation was made for.
> > >> > >
> > >> > > I agree. I think compatible is the better approach. Some propert=
y like
> > >> > > 'discard' may not be sufficient information if the OS needs to c=
onsume
> > >> > > the region first and then discard it. Better to state exactly wh=
at's
> > >> > > there and then the OS can imply the rest.
> > >> >
> > >> > OK, so what sort of compatible strings?
> > >> >
> > >> > How about:
> > >> > "acpi-reclaim" - holds ACPI tables; memory can be reclaimed once t=
he
> > >> > tables are read and no-longer needed
> > >>
> > >> ACPI reclaim is a policy, not a purpose. This memory could contain
> > >> many different things.
> > >>
> > >> > "boot-code" - holds boot code; memory can be reclaimed once the bo=
ot
> > >> > phase is complete
> > >> > "runtime-code" - holds runtime code; memory can be reclaimed only =
if
> > >> > this code will not be used from that point
> > >> >
> > >>
> > >> These are also policies. They can be inferred from the purpose.
> > >>
> > >> > etc. We can then have more specific compatibles, like:
> > >> >
> > >> > "psci-spin-table" - holds PSCI spin tables
> > >> >
> > >> > so you could do:
> > >> >
> > >> > compatible =3D "runtime-code", "psci-spin-table";
> > >> >
> > >>
> > >> I understand that this binding targets firmware<->firmware rather th=
an
> > >> firmware<->OS, which makes it much more difficult to keep it both
> > >> generic and sufficiently descriptive.
> > >>
> > >> However, I still feel that all the overlap with UEFI memory types is
> > >> not what we want here. UEFI knows how to manage its own memory map,
> > >> what it needs to know is what memory is already in use and for which
> > >> exact purpose. Whether or not that implies that the memory can be
> > >> freed at some point or can be mapped or not should follow from that.
> > >
> > >
> > > Can you please make a suggestion? I am unsure what you are looking fo=
r.
> > >
> >
> > I'm happy to help flesh this out, but you still have not provided us
> > with an actual use case, so I can only draw from my own experience
> > putting together firmware for virtual and physical ARM machines.
>
> I did explain that this is needed when Tianocore is on both sides of
> the interface, since Platform Init places some things in memory and
> the Payload needs to preserve them there, and/or know where they are.
>
> I think the problem might be that you don't agree with that, but it
> seems to be a fact, so I am not sure how I can alter it.
>
> Please can you clearly explain which part of the use case you are missing=
.
>

'Tianocore on both sides of the interface' means that Tianocore runs
as the platform init code, and uses a bespoke DT based protocol to
launch another instance of Tianocore as the payload, right?

Tianocore/EDK2 already implements methods to reinvoke itself if needed
(e.g., during a firmware update), and does so by launching a new DXE
core. So the boot sequence looks like

SEC -> PEI -> DXE -> BDS -> app that invokes UpdateCapsule() -> DXE ->
firmware update

So please elaborate on how this Tianocore on both sides of the
interface is put together when it uses this DT based handover. We
really need a better understanding of this in order to design a DT
binding that meets its needs.

...
> >
> > So on one side, there is the requirement for each memory reservation
> > to be described with sufficient detail so that a subsequent boot stage
> > (firmware or OS) can use it for its intended purpose, provided that
> > this boot stage is aware of its purpose (i.e., it has a driver that
> > matches on the compatible string in question, and actually maps/uses
> > the memory)
> >
> > On the other side, we need to describe how a memory reservation should
> > be treated if the boot stage doesn't know its purpose, has no interest
> > in using it or has consumed the contents and has no longer a need for
> > the region. We already have no-map to describe that the memory should
> > never be mapped (and this may be disregarded by an actual driver for
> > the region). I imagine we might add 'discardable' as a boolean DT
> > property, meaning that stage N may use the memory whichever way it
> > wants if it is not going to use it for its intended purpose, provided
> > that it deletes the node from the DT before passing it on to stage
> > N+1.
>
> OK. For now I think that everything is discardable, so long as the
> Payload knows the purpose and that it not needed. That is what Rob
> seemed to be saying. If we add 'discardable', does that mean that
> things default to non-discardable? Would that not be a change of
> behaviour for existing users?
>

Excellent question. I always assumed that /reserved-memory nodes with
a defined base address would be honored regardless.

> >
> > One thing that needs to be clarified is how this binding interacts
> > with /memory nodes. I assume that currently, /reserved-memory is
> > independent, i.e., it could describe mappable memory that is not
> > covered by /memory at all. If this is the case, we have to decide
> > whether or not discardable regions can be treated in the same way, or
> > whether we should require that discardable regions are covered by
> > /memory.
>
> I would expect all memory to be described in /memory nodes. What is
> the use case for omitting it? Are you thinking of SRAM, etc?
>

Indeed.

For example, the SynQuacer platform has SRAM that it uses for
platform-specific purposes (early stack and heap, passing information
between secure and non-secure at boot), but it is not wired into the
hardware cache coherency protocol, so it only tolerates non-shareable
mappings. Describing this as discardable would be accurate (given that
it is only used early in the boot), but that doesn't mean it can be
used as general purpose memory by the OS.
