Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF0F794134
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbjIFQJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbjIFQJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:09:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04F21997;
        Wed,  6 Sep 2023 09:09:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B970C433C7;
        Wed,  6 Sep 2023 16:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694016539;
        bh=JdR56YlXcpyvtRpoamjz0Pk7Vfmcc9MGNe0qBgrNBMY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=for6qEhUxv1FtRLPOwopQHgZtefqRxJAhdHXf4s5bIw4M4KXBYUxkBgRPEX7POOtg
         rzXfRyS3IXhUqLVmPPArwULcNDVpzPvhzgiQoHKMtqApychXnb7R7twqpMLiGIn4lB
         wcVcxsnSHmqMugIOgLSDPVHCfFCmcPPJ+NzGa3Zsx42Zq1mlFnSdwZyRsk7+PoLfqB
         DyS6a0HzTGg6PewNIEesO0N/A46ADc0qgrWmGn1H5W1Lo6FOdp7AeFZIiLXzc8RT+w
         SnJWXOVipaIoEBXH8STAp9mC3eVMgYzUZv9WVcQ8bxvuz3u3VcSKJNXvyHTpnmNIXU
         70/R5+Q4xTlGQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4ff09632194so6606369e87.2;
        Wed, 06 Sep 2023 09:08:59 -0700 (PDT)
X-Gm-Message-State: AOJu0YyPUZ6uG+7gaLXzMQ35SRcV61c1BC8wtvWynAwMn11odUYu1ZEi
        uH0yypHxf8BFuNArT0hpmZBLTrw6EOLm8I5qehg=
X-Google-Smtp-Source: AGHT+IHJ7l1KOz/r1QQF049O4yuAb8C5zJaW2+brtp2HPScOtjbv+MaizDWk8MjokSuO1ZSIUWqAchFVMKiS0l6xEB4=
X-Received: by 2002:a19:6555:0:b0:4fd:d470:203b with SMTP id
 c21-20020a196555000000b004fdd470203bmr2328593lfj.69.1694016537219; Wed, 06
 Sep 2023 09:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230830231758.2561402-1-sjg@chromium.org> <20230830231758.2561402-3-sjg@chromium.org>
 <CAMj1kXG5-aqoOtKdPFEdm=_5SdvgUTOhcDOBP1zdARAvKphJtg@mail.gmail.com>
 <CAL_JsqLx0KnXxFc8mFyT_RmA2qeBEutMXj_3nKo_g==cuSeYuQ@mail.gmail.com> <CAPnjgZ1U+Gy0Q_Sc63p0ixkWF9iJEEBLhV8-N9-sh7OGNy-OmQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ1U+Gy0Q_Sc63p0ixkWF9iJEEBLhV8-N9-sh7OGNy-OmQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 6 Sep 2023 18:08:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG9vM0haSOu19j7ujQCBEN6CBeXVAH96nm+gixt9FmMrA@mail.gmail.com>
Message-ID: <CAMj1kXG9vM0haSOu19j7ujQCBEN6CBeXVAH96nm+gixt9FmMrA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] schemas: Add some common reserved-memory usages
To:     Simon Glass <sjg@chromium.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
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

On Wed, 6 Sept 2023 at 16:54, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Rob, Ard,
>
> On Wed, 6 Sept 2023 at 08:34, Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Sep 5, 2023 at 4:44=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org>=
 wrote:
> > >
> > > On Thu, 31 Aug 2023 at 01:18, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > The Devicetree specification skips over handling of a logical view =
of
> > > > the memory map, pointing users to the UEFI specification.
> > > >
> > > > It is common to split firmware into 'Platform Init', which does the
> > > > initial hardware setup and a "Payload" which selects the OS to be b=
ooted.
> > > > Thus an handover interface is required between these two pieces.
> > > >
> > > > Where UEFI boot-time services are not available, but UEFI firmware =
is
> > > > present on either side of this interface, information about memory =
usage
> > > > and attributes must be presented to the "Payload" in some form.
> > > >
> > >
> > > I don't think the UEFI references are needed or helpful here.
> > >
> > > > This aims to provide an small schema addition for this mapping.
> > > >
> > > > For now, no attempt is made to create an exhaustive binding, so the=
re are
> > > > some example types listed. More can be added later.
> > > >
> > > > The compatible string is not included, since the node name is enoug=
h to
> > > > indicate the purpose of a node, as per the existing reserved-memory
> > > > schema.
> >
> > Node names reflect the 'class', but not what's specifically in the
> > node. So really, all reserved-memory nodes should have the same name,
> > but that ship already sailed for existing users. 'compatible' is the
> > right thing here. As to what the node name should be, well, we haven't
> > defined that. I think we just used 'memory' on some platforms.
>
> OK
>
> >
> > > > This binding does not include a binding for the memory 'attribute'
> > > > property, defined by EFI_BOOT_SERVICES.GetMemoryMap(). It may be us=
eful
> > > > to have that as well, but perhaps not as a bit mask.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v5:
> > > > - Drop the memory-map node (should have done that in v4)
> > > > - Tidy up schema a bit
> > > >
> > > > Changes in v4:
> > > > - Make use of the reserved-memory node instead of creating a new on=
e
> > > >
> > > > Changes in v3:
> > > > - Reword commit message again
> > > > - cc a lot more people, from the FFI patch
> > > > - Split out the attributes into the /memory nodes
> > > >
> > > > Changes in v2:
> > > > - Reword commit message
> > > >
> > > >  .../reserved-memory/common-reserved.yaml      | 53 +++++++++++++++=
++++
> > > >  1 file changed, 53 insertions(+)
> > > >  create mode 100644 dtschema/schemas/reserved-memory/common-reserve=
d.yaml
> > > >
> > > > diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml =
b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > new file mode 100644
> > > > index 0000000..d1b466b
> > > > --- /dev/null
> > > > +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > @@ -0,0 +1,53 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/reserved-memory/common-reserved=
.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Common memory reservations
> > > > +
> > > > +description: |
> > > > +  Specifies that the reserved memory region can be used for the pu=
rpose
> > > > +  indicated by its node name.
> > > > +
> > > > +  Clients may reuse this reserved memory if they understand what i=
t is for.
> > > > +
> > > > +maintainers:
> > > > +  - Simon Glass <sjg@chromium.org>
> > > > +
> > > > +allOf:
> > > > +  - $ref: reserved-memory.yaml
> > > > +
> > > > +properties:
> > > > +  $nodename:
> > > > +    enum:
> > > > +      - acpi-reclaim
> > > > +      - acpi-nvs
> > > > +      - boot-code
> > > > +      - boot-data
> > > > +      - runtime-code
> > > > +      - runtime-data
> > > > +
> > >
> > > These types are used by firmware to describe the nature of certain
> > > memory regions to the OS. Boot code and data can be discarded, as wel=
l
> > > as ACPI reclaim after its contents have been consumed. Runtime code
> > > and data need to be mapped for runtime features to work.
> > >
> > > When one firmware phase communicates the purpose of a certain memory
> > > reservation to another, it is typically not limited to whether its
> > > needs to be preserved and when it needs to be mapped (and with which
> > > attributes). I'd expect a memory reservation appearing under this nod=
e
> > > to have a clearly defined purpose, and the subsequent phases need to
> > > be able to discover this information.
> > >
> > > For example, a communication buffer for secure<->non-secure
> > > communication or a page with spin tables used by PSCI. None of the
> > > proposed labels are appropriate for this, and I'd much rather have a
> > > compatible string or some other property that clarifies the nature in
> > > a more suitable way. Note that 'no-map' already exists to indicate
> > > that the CPU should not map this memory unless it does so for the
> > > specific purpose that the reservation was made for.
> >
> > I agree. I think compatible is the better approach. Some property like
> > 'discard' may not be sufficient information if the OS needs to consume
> > the region first and then discard it. Better to state exactly what's
> > there and then the OS can imply the rest.
>
> OK, so what sort of compatible strings?
>
> How about:
> "acpi-reclaim" - holds ACPI tables; memory can be reclaimed once the
> tables are read and no-longer needed

ACPI reclaim is a policy, not a purpose. This memory could contain
many different things.

> "boot-code" - holds boot code; memory can be reclaimed once the boot
> phase is complete
> "runtime-code" - holds runtime code; memory can be reclaimed only if
> this code will not be used from that point
>

These are also policies. They can be inferred from the purpose.

> etc. We can then have more specific compatibles, like:
>
> "psci-spin-table" - holds PSCI spin tables
>
> so you could do:
>
> compatible =3D "runtime-code", "psci-spin-table";
>

I understand that this binding targets firmware<->firmware rather than
firmware<->OS, which makes it much more difficult to keep it both
generic and sufficiently descriptive.

However, I still feel that all the overlap with UEFI memory types is
not what we want here. UEFI knows how to manage its own memory map,
what it needs to know is what memory is already in use and for which
exact purpose. Whether or not that implies that the memory can be
freed at some point or can be mapped or not should follow from that.
