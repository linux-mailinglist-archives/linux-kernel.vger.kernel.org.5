Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD03793FA5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242056AbjIFOyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjIFOyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:54:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273C31739
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 07:53:58 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9a6190af24aso579332366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 07:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694012036; x=1694616836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heM2WIdgYwpyKdVMhVOdDsIpHChYmeGvTy53ja7Lcs8=;
        b=NVu3aiVSNwsiuMGcWf46Q0G524zWPLodMAuIBESuvi6HAUEA8FzyGoExHYXRA9MGsM
         oj2DkfMAgRT7eC2dGW2l/NVw4DTyWkABQytrQJ1UQ295T7cmtKoxOPHgnlJGTAEFXcyw
         pTjNmeafQykd0FlYVQMXDzIpCQelyKrJWlOr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694012036; x=1694616836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heM2WIdgYwpyKdVMhVOdDsIpHChYmeGvTy53ja7Lcs8=;
        b=iV72EmcXUOHozV+AUgyIMp3l8tnydFH5IGgO0ZsNW2rXFiLVMBVSK9TDTTllw5kFV9
         TT5fJAiE97qtdNZ03LRWqQQJT303ALbvCbjGEmp3LT388X41EydbbacuiFjrcdz2oAaq
         jthN55IBkQJeE1HB+PU5wiSYRQSDCO93IzTPU1E9nQQduB6/QcdgYI6ObJYoiNl4PWtL
         JL+mOO8i9K0A6sRaEzLtKG98Q3ea+HaFKYzNl2jUfeqaFhgxT9342eA+f3y4nuO+KHFz
         rf2v5Qlnda4/c7CBO5IPZ3W8kjARE7Mdxgtn0rb/OBBaDDcUUEoOR9d3p3kV7014z3Gc
         ryRQ==
X-Gm-Message-State: AOJu0Yyh2pjT0Xbv9454LoLq0LlpFv2UUyhClB681MfBM6DwmUwR+TOw
        eUjwRc1/bGm57AsfX2MV/IrIBUAW9Yy09NRaIAOSzw==
X-Google-Smtp-Source: AGHT+IEU5UffRYUvDwA0NQm7JOuEQu6yerz5z3/Mhzsxu8B4Hq3armkLEjFFu6wwdpmajrU9Sup7CUTnJTt9lIFlQHI=
X-Received: by 2002:a17:906:10c:b0:9a5:bce9:ffb7 with SMTP id
 12-20020a170906010c00b009a5bce9ffb7mr2596750eje.19.1694012036398; Wed, 06 Sep
 2023 07:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230830231758.2561402-1-sjg@chromium.org> <20230830231758.2561402-3-sjg@chromium.org>
 <CAMj1kXG5-aqoOtKdPFEdm=_5SdvgUTOhcDOBP1zdARAvKphJtg@mail.gmail.com> <CAL_JsqLx0KnXxFc8mFyT_RmA2qeBEutMXj_3nKo_g==cuSeYuQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLx0KnXxFc8mFyT_RmA2qeBEutMXj_3nKo_g==cuSeYuQ@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Wed, 6 Sep 2023 08:53:44 -0600
Message-ID: <CAPnjgZ1U+Gy0Q_Sc63p0ixkWF9iJEEBLhV8-N9-sh7OGNy-OmQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] schemas: Add some common reserved-memory usages
To:     Rob Herring <robh@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, devicetree@vger.kernel.org,
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

Hi Rob, Ard,

On Wed, 6 Sept 2023 at 08:34, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Sep 5, 2023 at 4:44=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
> >
> > On Thu, 31 Aug 2023 at 01:18, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > The Devicetree specification skips over handling of a logical view of
> > > the memory map, pointing users to the UEFI specification.
> > >
> > > It is common to split firmware into 'Platform Init', which does the
> > > initial hardware setup and a "Payload" which selects the OS to be boo=
ted.
> > > Thus an handover interface is required between these two pieces.
> > >
> > > Where UEFI boot-time services are not available, but UEFI firmware is
> > > present on either side of this interface, information about memory us=
age
> > > and attributes must be presented to the "Payload" in some form.
> > >
> >
> > I don't think the UEFI references are needed or helpful here.
> >
> > > This aims to provide an small schema addition for this mapping.
> > >
> > > For now, no attempt is made to create an exhaustive binding, so there=
 are
> > > some example types listed. More can be added later.
> > >
> > > The compatible string is not included, since the node name is enough =
to
> > > indicate the purpose of a node, as per the existing reserved-memory
> > > schema.
>
> Node names reflect the 'class', but not what's specifically in the
> node. So really, all reserved-memory nodes should have the same name,
> but that ship already sailed for existing users. 'compatible' is the
> right thing here. As to what the node name should be, well, we haven't
> defined that. I think we just used 'memory' on some platforms.

OK

>
> > > This binding does not include a binding for the memory 'attribute'
> > > property, defined by EFI_BOOT_SERVICES.GetMemoryMap(). It may be usef=
ul
> > > to have that as well, but perhaps not as a bit mask.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v5:
> > > - Drop the memory-map node (should have done that in v4)
> > > - Tidy up schema a bit
> > >
> > > Changes in v4:
> > > - Make use of the reserved-memory node instead of creating a new one
> > >
> > > Changes in v3:
> > > - Reword commit message again
> > > - cc a lot more people, from the FFI patch
> > > - Split out the attributes into the /memory nodes
> > >
> > > Changes in v2:
> > > - Reword commit message
> > >
> > >  .../reserved-memory/common-reserved.yaml      | 53 +++++++++++++++++=
++
> > >  1 file changed, 53 insertions(+)
> > >  create mode 100644 dtschema/schemas/reserved-memory/common-reserved.=
yaml
> > >
> > > diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml b/=
dtschema/schemas/reserved-memory/common-reserved.yaml
> > > new file mode 100644
> > > index 0000000..d1b466b
> > > --- /dev/null
> > > +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > @@ -0,0 +1,53 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/reserved-memory/common-reserved.y=
aml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Common memory reservations
> > > +
> > > +description: |
> > > +  Specifies that the reserved memory region can be used for the purp=
ose
> > > +  indicated by its node name.
> > > +
> > > +  Clients may reuse this reserved memory if they understand what it =
is for.
> > > +
> > > +maintainers:
> > > +  - Simon Glass <sjg@chromium.org>
> > > +
> > > +allOf:
> > > +  - $ref: reserved-memory.yaml
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    enum:
> > > +      - acpi-reclaim
> > > +      - acpi-nvs
> > > +      - boot-code
> > > +      - boot-data
> > > +      - runtime-code
> > > +      - runtime-data
> > > +
> >
> > These types are used by firmware to describe the nature of certain
> > memory regions to the OS. Boot code and data can be discarded, as well
> > as ACPI reclaim after its contents have been consumed. Runtime code
> > and data need to be mapped for runtime features to work.
> >
> > When one firmware phase communicates the purpose of a certain memory
> > reservation to another, it is typically not limited to whether its
> > needs to be preserved and when it needs to be mapped (and with which
> > attributes). I'd expect a memory reservation appearing under this node
> > to have a clearly defined purpose, and the subsequent phases need to
> > be able to discover this information.
> >
> > For example, a communication buffer for secure<->non-secure
> > communication or a page with spin tables used by PSCI. None of the
> > proposed labels are appropriate for this, and I'd much rather have a
> > compatible string or some other property that clarifies the nature in
> > a more suitable way. Note that 'no-map' already exists to indicate
> > that the CPU should not map this memory unless it does so for the
> > specific purpose that the reservation was made for.
>
> I agree. I think compatible is the better approach. Some property like
> 'discard' may not be sufficient information if the OS needs to consume
> the region first and then discard it. Better to state exactly what's
> there and then the OS can imply the rest.

OK, so what sort of compatible strings?

How about:
"acpi-reclaim" - holds ACPI tables; memory can be reclaimed once the
tables are read and no-longer needed
"boot-code" - holds boot code; memory can be reclaimed once the boot
phase is complete
"runtime-code" - holds runtime code; memory can be reclaimed only if
this code will not be used from that point

etc. We can then have more specific compatibles, like:

"psci-spin-table" - holds PSCI spin tables

so you could do:

compatible =3D "runtime-code", "psci-spin-table";

Regards,
Simon
