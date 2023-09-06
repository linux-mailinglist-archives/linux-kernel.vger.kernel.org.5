Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA5B793EFB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjIFOer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241649AbjIFOeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:34:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38F41736;
        Wed,  6 Sep 2023 07:34:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F308C433C8;
        Wed,  6 Sep 2023 14:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694010879;
        bh=5CgX0qwVwa7r31LHexER1pGw9ZB7C7bXkkhE9p8u1dM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G7E0sAbA9XzGssy6wa8hjot6QZDI1nr1S1Er5vJsDaKFsTqzgGz9byJNYpYMc1euI
         2jzTFadEvLVMiEZi+pNRel2r4cgHtZ9HC4ojL4mNLGQsENyLwnu96F93QQ9exMPSbM
         X/fuATA+0tbteX6ohecGHwRQ0TPf/TjOWDsgknbqFCnRnkkz4iB2juCysN7FYbdGV7
         OsOtXCk0OWHth8BnhEnT79qO5c/Sn/D0Frj4qhHyr434I9Tv5o2Z+QFbv4HvH2SeiP
         50IAQHeckeBsWNLLAVW2BhWMj4EZUGaSenYqLJRhSV1SatxbMowkjP3jk4Pcx/K/mF
         A/CO0MsR+RIWQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso63838181fa.1;
        Wed, 06 Sep 2023 07:34:39 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz8PMMb7VeBKh5uvHK/9WV2kqWIEPuFBfJSoE9g/vjuABnf3TrM
        YDjEDZXfuH6UxVpcEIoVpFqHE/QPH6FBJD5nfA==
X-Google-Smtp-Source: AGHT+IHmZe9ADeT4s6VgDMevloEJ4hor33qOF7jCIYcpLWo61GuYHIGx/ltJxqfIj+RnbcHpgsYGiiy7WZsnHrujp7c=
X-Received: by 2002:a2e:9811:0:b0:2bc:efa4:2c36 with SMTP id
 a17-20020a2e9811000000b002bcefa42c36mr2221334ljj.11.1694010877155; Wed, 06
 Sep 2023 07:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230830231758.2561402-1-sjg@chromium.org> <20230830231758.2561402-3-sjg@chromium.org>
 <CAMj1kXG5-aqoOtKdPFEdm=_5SdvgUTOhcDOBP1zdARAvKphJtg@mail.gmail.com>
In-Reply-To: <CAMj1kXG5-aqoOtKdPFEdm=_5SdvgUTOhcDOBP1zdARAvKphJtg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 6 Sep 2023 09:34:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLx0KnXxFc8mFyT_RmA2qeBEutMXj_3nKo_g==cuSeYuQ@mail.gmail.com>
Message-ID: <CAL_JsqLx0KnXxFc8mFyT_RmA2qeBEutMXj_3nKo_g==cuSeYuQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] schemas: Add some common reserved-memory usages
To:     Ard Biesheuvel <ardb@kernel.org>, Simon Glass <sjg@chromium.org>
Cc:     devicetree@vger.kernel.org,
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

On Tue, Sep 5, 2023 at 4:44=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Thu, 31 Aug 2023 at 01:18, Simon Glass <sjg@chromium.org> wrote:
> >
> > The Devicetree specification skips over handling of a logical view of
> > the memory map, pointing users to the UEFI specification.
> >
> > It is common to split firmware into 'Platform Init', which does the
> > initial hardware setup and a "Payload" which selects the OS to be boote=
d.
> > Thus an handover interface is required between these two pieces.
> >
> > Where UEFI boot-time services are not available, but UEFI firmware is
> > present on either side of this interface, information about memory usag=
e
> > and attributes must be presented to the "Payload" in some form.
> >
>
> I don't think the UEFI references are needed or helpful here.
>
> > This aims to provide an small schema addition for this mapping.
> >
> > For now, no attempt is made to create an exhaustive binding, so there a=
re
> > some example types listed. More can be added later.
> >
> > The compatible string is not included, since the node name is enough to
> > indicate the purpose of a node, as per the existing reserved-memory
> > schema.

Node names reflect the 'class', but not what's specifically in the
node. So really, all reserved-memory nodes should have the same name,
but that ship already sailed for existing users. 'compatible' is the
right thing here. As to what the node name should be, well, we haven't
defined that. I think we just used 'memory' on some platforms.

> > This binding does not include a binding for the memory 'attribute'
> > property, defined by EFI_BOOT_SERVICES.GetMemoryMap(). It may be useful
> > to have that as well, but perhaps not as a bit mask.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v5:
> > - Drop the memory-map node (should have done that in v4)
> > - Tidy up schema a bit
> >
> > Changes in v4:
> > - Make use of the reserved-memory node instead of creating a new one
> >
> > Changes in v3:
> > - Reword commit message again
> > - cc a lot more people, from the FFI patch
> > - Split out the attributes into the /memory nodes
> >
> > Changes in v2:
> > - Reword commit message
> >
> >  .../reserved-memory/common-reserved.yaml      | 53 +++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >  create mode 100644 dtschema/schemas/reserved-memory/common-reserved.ya=
ml
> >
> > diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml b/dt=
schema/schemas/reserved-memory/common-reserved.yaml
> > new file mode 100644
> > index 0000000..d1b466b
> > --- /dev/null
> > +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > @@ -0,0 +1,53 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/reserved-memory/common-reserved.yam=
l#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Common memory reservations
> > +
> > +description: |
> > +  Specifies that the reserved memory region can be used for the purpos=
e
> > +  indicated by its node name.
> > +
> > +  Clients may reuse this reserved memory if they understand what it is=
 for.
> > +
> > +maintainers:
> > +  - Simon Glass <sjg@chromium.org>
> > +
> > +allOf:
> > +  - $ref: reserved-memory.yaml
> > +
> > +properties:
> > +  $nodename:
> > +    enum:
> > +      - acpi-reclaim
> > +      - acpi-nvs
> > +      - boot-code
> > +      - boot-data
> > +      - runtime-code
> > +      - runtime-data
> > +
>
> These types are used by firmware to describe the nature of certain
> memory regions to the OS. Boot code and data can be discarded, as well
> as ACPI reclaim after its contents have been consumed. Runtime code
> and data need to be mapped for runtime features to work.
>
> When one firmware phase communicates the purpose of a certain memory
> reservation to another, it is typically not limited to whether its
> needs to be preserved and when it needs to be mapped (and with which
> attributes). I'd expect a memory reservation appearing under this node
> to have a clearly defined purpose, and the subsequent phases need to
> be able to discover this information.
>
> For example, a communication buffer for secure<->non-secure
> communication or a page with spin tables used by PSCI. None of the
> proposed labels are appropriate for this, and I'd much rather have a
> compatible string or some other property that clarifies the nature in
> a more suitable way. Note that 'no-map' already exists to indicate
> that the CPU should not map this memory unless it does so for the
> specific purpose that the reservation was made for.

I agree. I think compatible is the better approach. Some property like
'discard' may not be sufficient information if the OS needs to consume
the region first and then discard it. Better to state exactly what's
there and then the OS can imply the rest.

Rob
