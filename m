Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1319479793E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239437AbjIGRJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237161AbjIGRJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:09:02 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8C91703
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:08:32 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-501cba1ec0aso1981389e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 10:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694106445; x=1694711245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Knh9a76TzJatawFXuxlKAvAZyiT05+Kr5wsD+gCCT50=;
        b=OueUtxeXGSCYjp2WpcKNQIvN9TrzD4H/ia+T613JjNBotNqDN9NT96qLXkkkIn0Qr7
         W0FrZSHMBzkgLmcvYFxzep4/sMy0jMe/Zt++t1DXsVZTJ5TH+YPFgWREdGcwb+m/aRbw
         mDTBOeKFaj0HRSYVxQGAXfV1wed8Rg5GBAmAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694106445; x=1694711245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Knh9a76TzJatawFXuxlKAvAZyiT05+Kr5wsD+gCCT50=;
        b=inUhWGULTLHYczoS63IGG63p6AKT+FDeznRAPa3nwmLAPEje/XK7QAypynEgfP4Ily
         fUC3kBXlHIwlLHp7XHAovbZ6t8K3rkxOKxffSTWw3nvE+a00XdrUDq+72O+/ZQpyesTd
         6zSa7mrxZxcpCKk6JAAZDDUky7G82knzUhiM0PjCDhPvOU7LA/qcndkwluxWkz49ZJHP
         69w6PAMblR4z1e3tI6XYfYrAB0GmQ4ni+VBa4YEa9gSQt5UjSfndv4sh22UhSC5HoZDn
         eL7DNKORki/wTfKbnPKmFcbCkHmrSu5E8c4jwF25DXbdkeFPCvvgHnEczyPDLOP1aw7K
         qLoQ==
X-Gm-Message-State: AOJu0YzGAqz8azT5jHa9p10+0jg5uuy4CXdEMp+uXMD5HteOi7aTg2gf
        jhtsLA4rMZjbEkhVGq9sJN5gN9FGSlCIoJ9doKAEFZeawcoiwlvb4h0=
X-Google-Smtp-Source: AGHT+IETdVICQDqLbQlGN1y6SsCAxQthLAdWJHW+NoJoQ+1wg2YaYYe2M/S6cATjIDe4kv6ijxuWCTpyCj/K02u5IBo=
X-Received: by 2002:a17:906:5a59:b0:9a4:dd49:da3e with SMTP id
 my25-20020a1709065a5900b009a4dd49da3emr5402038ejc.68.1694094990646; Thu, 07
 Sep 2023 06:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230830231758.2561402-1-sjg@chromium.org> <20230830231758.2561402-3-sjg@chromium.org>
 <CAMj1kXG5-aqoOtKdPFEdm=_5SdvgUTOhcDOBP1zdARAvKphJtg@mail.gmail.com>
 <CAL_JsqLx0KnXxFc8mFyT_RmA2qeBEutMXj_3nKo_g==cuSeYuQ@mail.gmail.com>
 <CAPnjgZ1U+Gy0Q_Sc63p0ixkWF9iJEEBLhV8-N9-sh7OGNy-OmQ@mail.gmail.com>
 <CAMj1kXG9vM0haSOu19j7ujQCBEN6CBeXVAH96nm+gixt9FmMrA@mail.gmail.com>
 <CAPnjgZ1oGF0Ni3RhK4fv6mJk40YjqyFVJxt6FfS9AW2rkcs9iA@mail.gmail.com> <CAMj1kXEZ4fDvbtgXKjF+L7si-=C-5E0XcjutoEF8pU9a-BGN-g@mail.gmail.com>
In-Reply-To: <CAMj1kXEZ4fDvbtgXKjF+L7si-=C-5E0XcjutoEF8pU9a-BGN-g@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Thu, 7 Sep 2023 07:56:12 -0600
Message-ID: <CAPnjgZ0vv+s00xvY2FqP+Fxb12tHuVWg-nwyWTrvuG+Mo4PaWg@mail.gmail.com>
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Thu, 7 Sept 2023 at 07:31, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 6 Sept 2023 at 18:50, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ard,
> >
> > On Wed, Sep 6, 2023, 10:09 Ard Biesheuvel <ardb@kernel.org> wrote:
> >>
> >> On Wed, 6 Sept 2023 at 16:54, Simon Glass <sjg@chromium.org> wrote:
> >> >
> >> > Hi Rob, Ard,
> >> >
> >> > On Wed, 6 Sept 2023 at 08:34, Rob Herring <robh@kernel.org> wrote:
> >> > >
> >> > > On Tue, Sep 5, 2023 at 4:44=E2=80=AFPM Ard Biesheuvel <ardb@kernel=
.org> wrote:
> >> > > >
> >> > > > On Thu, 31 Aug 2023 at 01:18, Simon Glass <sjg@chromium.org> wro=
te:
> >> > > > >
> >> > > > > The Devicetree specification skips over handling of a logical =
view of
> >> > > > > the memory map, pointing users to the UEFI specification.
> >> > > > >
> >> > > > > It is common to split firmware into 'Platform Init', which doe=
s the
> >> > > > > initial hardware setup and a "Payload" which selects the OS to=
 be booted.
> >> > > > > Thus an handover interface is required between these two piece=
s.
> >> > > > >
> >> > > > > Where UEFI boot-time services are not available, but UEFI firm=
ware is
> >> > > > > present on either side of this interface, information about me=
mory usage
> >> > > > > and attributes must be presented to the "Payload" in some form=
.
> >> > > > >
> >> > > >
> >> > > > I don't think the UEFI references are needed or helpful here.
> >> > > >
> >> > > > > This aims to provide an small schema addition for this mapping=
.
> >> > > > >
> >> > > > > For now, no attempt is made to create an exhaustive binding, s=
o there are
> >> > > > > some example types listed. More can be added later.
> >> > > > >
> >> > > > > The compatible string is not included, since the node name is =
enough to
> >> > > > > indicate the purpose of a node, as per the existing reserved-m=
emory
> >> > > > > schema.
> >> > >
> >> > > Node names reflect the 'class', but not what's specifically in the
> >> > > node. So really, all reserved-memory nodes should have the same na=
me,
> >> > > but that ship already sailed for existing users. 'compatible' is t=
he
> >> > > right thing here. As to what the node name should be, well, we hav=
en't
> >> > > defined that. I think we just used 'memory' on some platforms.
> >> >
> >> > OK
> >> >
> >> > >
> >> > > > > This binding does not include a binding for the memory 'attrib=
ute'
> >> > > > > property, defined by EFI_BOOT_SERVICES.GetMemoryMap(). It may =
be useful
> >> > > > > to have that as well, but perhaps not as a bit mask.
> >> > > > >
> >> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >> > > > > ---
> >> > > > >
> >> > > > > Changes in v5:
> >> > > > > - Drop the memory-map node (should have done that in v4)
> >> > > > > - Tidy up schema a bit
> >> > > > >
> >> > > > > Changes in v4:
> >> > > > > - Make use of the reserved-memory node instead of creating a n=
ew one
> >> > > > >
> >> > > > > Changes in v3:
> >> > > > > - Reword commit message again
> >> > > > > - cc a lot more people, from the FFI patch
> >> > > > > - Split out the attributes into the /memory nodes
> >> > > > >
> >> > > > > Changes in v2:
> >> > > > > - Reword commit message
> >> > > > >
> >> > > > >  .../reserved-memory/common-reserved.yaml      | 53 ++++++++++=
+++++++++
> >> > > > >  1 file changed, 53 insertions(+)
> >> > > > >  create mode 100644 dtschema/schemas/reserved-memory/common-re=
served.yaml
> >> > > > >
> >> > > > > diff --git a/dtschema/schemas/reserved-memory/common-reserved.=
yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
> >> > > > > new file mode 100644
> >> > > > > index 0000000..d1b466b
> >> > > > > --- /dev/null
> >> > > > > +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> >> > > > > @@ -0,0 +1,53 @@
> >> > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >> > > > > +%YAML 1.2
> >> > > > > +---
> >> > > > > +$id: http://devicetree.org/schemas/reserved-memory/common-res=
erved.yaml#
> >> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> > > > > +
> >> > > > > +title: Common memory reservations
> >> > > > > +
> >> > > > > +description: |
> >> > > > > +  Specifies that the reserved memory region can be used for t=
he purpose
> >> > > > > +  indicated by its node name.
> >> > > > > +
> >> > > > > +  Clients may reuse this reserved memory if they understand w=
hat it is for.
> >> > > > > +
> >> > > > > +maintainers:
> >> > > > > +  - Simon Glass <sjg@chromium.org>
> >> > > > > +
> >> > > > > +allOf:
> >> > > > > +  - $ref: reserved-memory.yaml
> >> > > > > +
> >> > > > > +properties:
> >> > > > > +  $nodename:
> >> > > > > +    enum:
> >> > > > > +      - acpi-reclaim
> >> > > > > +      - acpi-nvs
> >> > > > > +      - boot-code
> >> > > > > +      - boot-data
> >> > > > > +      - runtime-code
> >> > > > > +      - runtime-data
> >> > > > > +
> >> > > >
> >> > > > These types are used by firmware to describe the nature of certa=
in
> >> > > > memory regions to the OS. Boot code and data can be discarded, a=
s well
> >> > > > as ACPI reclaim after its contents have been consumed. Runtime c=
ode
> >> > > > and data need to be mapped for runtime features to work.
> >> > > >
> >> > > > When one firmware phase communicates the purpose of a certain me=
mory
> >> > > > reservation to another, it is typically not limited to whether i=
ts
> >> > > > needs to be preserved and when it needs to be mapped (and with w=
hich
> >> > > > attributes). I'd expect a memory reservation appearing under thi=
s node
> >> > > > to have a clearly defined purpose, and the subsequent phases nee=
d to
> >> > > > be able to discover this information.
> >> > > >
> >> > > > For example, a communication buffer for secure<->non-secure
> >> > > > communication or a page with spin tables used by PSCI. None of t=
he
> >> > > > proposed labels are appropriate for this, and I'd much rather ha=
ve a
> >> > > > compatible string or some other property that clarifies the natu=
re in
> >> > > > a more suitable way. Note that 'no-map' already exists to indica=
te
> >> > > > that the CPU should not map this memory unless it does so for th=
e
> >> > > > specific purpose that the reservation was made for.
> >> > >
> >> > > I agree. I think compatible is the better approach. Some property =
like
> >> > > 'discard' may not be sufficient information if the OS needs to con=
sume
> >> > > the region first and then discard it. Better to state exactly what=
's
> >> > > there and then the OS can imply the rest.
> >> >
> >> > OK, so what sort of compatible strings?
> >> >
> >> > How about:
> >> > "acpi-reclaim" - holds ACPI tables; memory can be reclaimed once the
> >> > tables are read and no-longer needed
> >>
> >> ACPI reclaim is a policy, not a purpose. This memory could contain
> >> many different things.
> >>
> >> > "boot-code" - holds boot code; memory can be reclaimed once the boot
> >> > phase is complete
> >> > "runtime-code" - holds runtime code; memory can be reclaimed only if
> >> > this code will not be used from that point
> >> >
> >>
> >> These are also policies. They can be inferred from the purpose.
> >>
> >> > etc. We can then have more specific compatibles, like:
> >> >
> >> > "psci-spin-table" - holds PSCI spin tables
> >> >
> >> > so you could do:
> >> >
> >> > compatible =3D "runtime-code", "psci-spin-table";
> >> >
> >>
> >> I understand that this binding targets firmware<->firmware rather than
> >> firmware<->OS, which makes it much more difficult to keep it both
> >> generic and sufficiently descriptive.
> >>
> >> However, I still feel that all the overlap with UEFI memory types is
> >> not what we want here. UEFI knows how to manage its own memory map,
> >> what it needs to know is what memory is already in use and for which
> >> exact purpose. Whether or not that implies that the memory can be
> >> freed at some point or can be mapped or not should follow from that.
> >
> >
> > Can you please make a suggestion? I am unsure what you are looking for.
> >
>
> I'm happy to help flesh this out, but you still have not provided us
> with an actual use case, so I can only draw from my own experience
> putting together firmware for virtual and physical ARM machines.

I did explain that this is needed when Tianocore is on both sides of
the interface, since Platform Init places some things in memory and
the Payload needs to preserve them there, and/or know where they are.

I think the problem might be that you don't agree with that, but it
seems to be a fact, so I am not sure how I can alter it.

Please can you clearly explain which part of the use case you are missing.

>
> All the ACPI and UEFI lingo needs to be dropped. This is relevant only
> to the OS, and only if the prior stage exposes UEFI interfaces, in
> which case it does not need this binding.

OK I can drop those from the commit message.

>
> So on one side, there is the requirement for each memory reservation
> to be described with sufficient detail so that a subsequent boot stage
> (firmware or OS) can use it for its intended purpose, provided that
> this boot stage is aware of its purpose (i.e., it has a driver that
> matches on the compatible string in question, and actually maps/uses
> the memory)
>
> On the other side, we need to describe how a memory reservation should
> be treated if the boot stage doesn't know its purpose, has no interest
> in using it or has consumed the contents and has no longer a need for
> the region. We already have no-map to describe that the memory should
> never be mapped (and this may be disregarded by an actual driver for
> the region). I imagine we might add 'discardable' as a boolean DT
> property, meaning that stage N may use the memory whichever way it
> wants if it is not going to use it for its intended purpose, provided
> that it deletes the node from the DT before passing it on to stage
> N+1.

OK. For now I think that everything is discardable, so long as the
Payload knows the purpose and that it not needed. That is what Rob
seemed to be saying. If we add 'discardable', does that mean that
things default to non-discardable? Would that not be a change of
behaviour for existing users?

>
> One thing that needs to be clarified is how this binding interacts
> with /memory nodes. I assume that currently, /reserved-memory is
> independent, i.e., it could describe mappable memory that is not
> covered by /memory at all. If this is the case, we have to decide
> whether or not discardable regions can be treated in the same way, or
> whether we should require that discardable regions are covered by
> /memory.

I would expect all memory to be described in /memory nodes. What is
the use case for omitting it? Are you thinking of SRAM, etc?

Regards,
Simon
