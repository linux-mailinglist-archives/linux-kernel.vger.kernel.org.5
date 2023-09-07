Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91ADE797BA4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343887AbjIGSWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343877AbjIGSWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:22:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C319D;
        Thu,  7 Sep 2023 11:22:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D89C4AF5E;
        Thu,  7 Sep 2023 13:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694093512;
        bh=oQCFnQHlRCRNYg7LhYt6nE9Xyrh2IY/UDLfbmmAuJTc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NgvZ3Wnr6VZUTsPII4TR20OXB34ch3STYpBxiE0nNulJhP7HtmRBJHtPlpliTq9sH
         8cAkQAo/BMgNp3osaK+JWFQd2XsdJJSnhT5psOj6/5gMTlQz03aCZSJK5bNn8mbrUq
         dLyrOtJxVmzNn14AfuesBDeU3zKIosmvWkl/Vdw6aw5oGTzdzBtqbWA8pejWbwSmpK
         i6H6+kGCar4G0WgexbZ3IQtuuofoMlgJZJCLNwcGb0V9glqs4t4frzBhAtwbd0iF19
         Y6xc0r/Odn7hRKnUIMGuPtzUT2lhbbs3LJR5ujceUyaunRMt36bX2kZzN1QisoX6Pk
         MrH4wnzebwwHw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-500bbe3ef0eso1132593e87.1;
        Thu, 07 Sep 2023 06:31:52 -0700 (PDT)
X-Gm-Message-State: AOJu0YwpiGcFR0DhHB7FSfk7wJ46xGrSuyfxarm7MT5bVafLfl4J8XIw
        CvN8WD9+h4S9zYlDV0I0yqAUTCitM2vxA3dAcBQ=
X-Google-Smtp-Source: AGHT+IEjJwoW5qdlQBOAX/47bLSCc44eatYa2/UB4A2WGcY12fy1WiePxwgI+rXJZoXPpM0fXU2+ekD4V1VBmB6Dhxg=
X-Received: by 2002:a05:6512:3ca5:b0:501:be4d:6dc5 with SMTP id
 h37-20020a0565123ca500b00501be4d6dc5mr826360lfv.8.1694093510033; Thu, 07 Sep
 2023 06:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230830231758.2561402-1-sjg@chromium.org> <20230830231758.2561402-3-sjg@chromium.org>
 <CAMj1kXG5-aqoOtKdPFEdm=_5SdvgUTOhcDOBP1zdARAvKphJtg@mail.gmail.com>
 <CAL_JsqLx0KnXxFc8mFyT_RmA2qeBEutMXj_3nKo_g==cuSeYuQ@mail.gmail.com>
 <CAPnjgZ1U+Gy0Q_Sc63p0ixkWF9iJEEBLhV8-N9-sh7OGNy-OmQ@mail.gmail.com>
 <CAMj1kXG9vM0haSOu19j7ujQCBEN6CBeXVAH96nm+gixt9FmMrA@mail.gmail.com> <CAPnjgZ1oGF0Ni3RhK4fv6mJk40YjqyFVJxt6FfS9AW2rkcs9iA@mail.gmail.com>
In-Reply-To: <CAPnjgZ1oGF0Ni3RhK4fv6mJk40YjqyFVJxt6FfS9AW2rkcs9iA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 7 Sep 2023 15:31:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEZ4fDvbtgXKjF+L7si-=C-5E0XcjutoEF8pU9a-BGN-g@mail.gmail.com>
Message-ID: <CAMj1kXEZ4fDvbtgXKjF+L7si-=C-5E0XcjutoEF8pU9a-BGN-g@mail.gmail.com>
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

On Wed, 6 Sept 2023 at 18:50, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ard,
>
> On Wed, Sep 6, 2023, 10:09 Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Wed, 6 Sept 2023 at 16:54, Simon Glass <sjg@chromium.org> wrote:
>> >
>> > Hi Rob, Ard,
>> >
>> > On Wed, 6 Sept 2023 at 08:34, Rob Herring <robh@kernel.org> wrote:
>> > >
>> > > On Tue, Sep 5, 2023 at 4:44=E2=80=AFPM Ard Biesheuvel <ardb@kernel.o=
rg> wrote:
>> > > >
>> > > > On Thu, 31 Aug 2023 at 01:18, Simon Glass <sjg@chromium.org> wrote=
:
>> > > > >
>> > > > > The Devicetree specification skips over handling of a logical vi=
ew of
>> > > > > the memory map, pointing users to the UEFI specification.
>> > > > >
>> > > > > It is common to split firmware into 'Platform Init', which does =
the
>> > > > > initial hardware setup and a "Payload" which selects the OS to b=
e booted.
>> > > > > Thus an handover interface is required between these two pieces.
>> > > > >
>> > > > > Where UEFI boot-time services are not available, but UEFI firmwa=
re is
>> > > > > present on either side of this interface, information about memo=
ry usage
>> > > > > and attributes must be presented to the "Payload" in some form.
>> > > > >
>> > > >
>> > > > I don't think the UEFI references are needed or helpful here.
>> > > >
>> > > > > This aims to provide an small schema addition for this mapping.
>> > > > >
>> > > > > For now, no attempt is made to create an exhaustive binding, so =
there are
>> > > > > some example types listed. More can be added later.
>> > > > >
>> > > > > The compatible string is not included, since the node name is en=
ough to
>> > > > > indicate the purpose of a node, as per the existing reserved-mem=
ory
>> > > > > schema.
>> > >
>> > > Node names reflect the 'class', but not what's specifically in the
>> > > node. So really, all reserved-memory nodes should have the same name=
,
>> > > but that ship already sailed for existing users. 'compatible' is the
>> > > right thing here. As to what the node name should be, well, we haven=
't
>> > > defined that. I think we just used 'memory' on some platforms.
>> >
>> > OK
>> >
>> > >
>> > > > > This binding does not include a binding for the memory 'attribut=
e'
>> > > > > property, defined by EFI_BOOT_SERVICES.GetMemoryMap(). It may be=
 useful
>> > > > > to have that as well, but perhaps not as a bit mask.
>> > > > >
>> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
>> > > > > ---
>> > > > >
>> > > > > Changes in v5:
>> > > > > - Drop the memory-map node (should have done that in v4)
>> > > > > - Tidy up schema a bit
>> > > > >
>> > > > > Changes in v4:
>> > > > > - Make use of the reserved-memory node instead of creating a new=
 one
>> > > > >
>> > > > > Changes in v3:
>> > > > > - Reword commit message again
>> > > > > - cc a lot more people, from the FFI patch
>> > > > > - Split out the attributes into the /memory nodes
>> > > > >
>> > > > > Changes in v2:
>> > > > > - Reword commit message
>> > > > >
>> > > > >  .../reserved-memory/common-reserved.yaml      | 53 ++++++++++++=
+++++++
>> > > > >  1 file changed, 53 insertions(+)
>> > > > >  create mode 100644 dtschema/schemas/reserved-memory/common-rese=
rved.yaml
>> > > > >
>> > > > > diff --git a/dtschema/schemas/reserved-memory/common-reserved.ya=
ml b/dtschema/schemas/reserved-memory/common-reserved.yaml
>> > > > > new file mode 100644
>> > > > > index 0000000..d1b466b
>> > > > > --- /dev/null
>> > > > > +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
>> > > > > @@ -0,0 +1,53 @@
>> > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> > > > > +%YAML 1.2
>> > > > > +---
>> > > > > +$id: http://devicetree.org/schemas/reserved-memory/common-reser=
ved.yaml#
>> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> > > > > +
>> > > > > +title: Common memory reservations
>> > > > > +
>> > > > > +description: |
>> > > > > +  Specifies that the reserved memory region can be used for the=
 purpose
>> > > > > +  indicated by its node name.
>> > > > > +
>> > > > > +  Clients may reuse this reserved memory if they understand wha=
t it is for.
>> > > > > +
>> > > > > +maintainers:
>> > > > > +  - Simon Glass <sjg@chromium.org>
>> > > > > +
>> > > > > +allOf:
>> > > > > +  - $ref: reserved-memory.yaml
>> > > > > +
>> > > > > +properties:
>> > > > > +  $nodename:
>> > > > > +    enum:
>> > > > > +      - acpi-reclaim
>> > > > > +      - acpi-nvs
>> > > > > +      - boot-code
>> > > > > +      - boot-data
>> > > > > +      - runtime-code
>> > > > > +      - runtime-data
>> > > > > +
>> > > >
>> > > > These types are used by firmware to describe the nature of certain
>> > > > memory regions to the OS. Boot code and data can be discarded, as =
well
>> > > > as ACPI reclaim after its contents have been consumed. Runtime cod=
e
>> > > > and data need to be mapped for runtime features to work.
>> > > >
>> > > > When one firmware phase communicates the purpose of a certain memo=
ry
>> > > > reservation to another, it is typically not limited to whether its
>> > > > needs to be preserved and when it needs to be mapped (and with whi=
ch
>> > > > attributes). I'd expect a memory reservation appearing under this =
node
>> > > > to have a clearly defined purpose, and the subsequent phases need =
to
>> > > > be able to discover this information.
>> > > >
>> > > > For example, a communication buffer for secure<->non-secure
>> > > > communication or a page with spin tables used by PSCI. None of the
>> > > > proposed labels are appropriate for this, and I'd much rather have=
 a
>> > > > compatible string or some other property that clarifies the nature=
 in
>> > > > a more suitable way. Note that 'no-map' already exists to indicate
>> > > > that the CPU should not map this memory unless it does so for the
>> > > > specific purpose that the reservation was made for.
>> > >
>> > > I agree. I think compatible is the better approach. Some property li=
ke
>> > > 'discard' may not be sufficient information if the OS needs to consu=
me
>> > > the region first and then discard it. Better to state exactly what's
>> > > there and then the OS can imply the rest.
>> >
>> > OK, so what sort of compatible strings?
>> >
>> > How about:
>> > "acpi-reclaim" - holds ACPI tables; memory can be reclaimed once the
>> > tables are read and no-longer needed
>>
>> ACPI reclaim is a policy, not a purpose. This memory could contain
>> many different things.
>>
>> > "boot-code" - holds boot code; memory can be reclaimed once the boot
>> > phase is complete
>> > "runtime-code" - holds runtime code; memory can be reclaimed only if
>> > this code will not be used from that point
>> >
>>
>> These are also policies. They can be inferred from the purpose.
>>
>> > etc. We can then have more specific compatibles, like:
>> >
>> > "psci-spin-table" - holds PSCI spin tables
>> >
>> > so you could do:
>> >
>> > compatible =3D "runtime-code", "psci-spin-table";
>> >
>>
>> I understand that this binding targets firmware<->firmware rather than
>> firmware<->OS, which makes it much more difficult to keep it both
>> generic and sufficiently descriptive.
>>
>> However, I still feel that all the overlap with UEFI memory types is
>> not what we want here. UEFI knows how to manage its own memory map,
>> what it needs to know is what memory is already in use and for which
>> exact purpose. Whether or not that implies that the memory can be
>> freed at some point or can be mapped or not should follow from that.
>
>
> Can you please make a suggestion? I am unsure what you are looking for.
>

I'm happy to help flesh this out, but you still have not provided us
with an actual use case, so I can only draw from my own experience
putting together firmware for virtual and physical ARM machines.

All the ACPI and UEFI lingo needs to be dropped. This is relevant only
to the OS, and only if the prior stage exposes UEFI interfaces, in
which case it does not need this binding.

So on one side, there is the requirement for each memory reservation
to be described with sufficient detail so that a subsequent boot stage
(firmware or OS) can use it for its intended purpose, provided that
this boot stage is aware of its purpose (i.e., it has a driver that
matches on the compatible string in question, and actually maps/uses
the memory)

On the other side, we need to describe how a memory reservation should
be treated if the boot stage doesn't know its purpose, has no interest
in using it or has consumed the contents and has no longer a need for
the region. We already have no-map to describe that the memory should
never be mapped (and this may be disregarded by an actual driver for
the region). I imagine we might add 'discardable' as a boolean DT
property, meaning that stage N may use the memory whichever way it
wants if it is not going to use it for its intended purpose, provided
that it deletes the node from the DT before passing it on to stage
N+1.

One thing that needs to be clarified is how this binding interacts
with /memory nodes. I assume that currently, /reserved-memory is
independent, i.e., it could describe mappable memory that is not
covered by /memory at all. If this is the case, we have to decide
whether or not discardable regions can be treated in the same way, or
whether we should require that discardable regions are covered by
/memory.
