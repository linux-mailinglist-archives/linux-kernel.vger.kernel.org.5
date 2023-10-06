Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7907BC2B4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbjJFXAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjJFXAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:00:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECAF93
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 16:00:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC67DC43395;
        Fri,  6 Oct 2023 23:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696633210;
        bh=k8j0XLQXjQQJNDui+0jlFZl+AAfuXhuCpn9vIwWl/cE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k5/VSAnWHKDBM+aIaW9QONktl0tgBQMkfEMqxBot4G6+wPYt1Z4J99Em95YUTDseY
         jGYDjY/mNJfz3h6IDzruMe+TCkQuBvsV+78ssBXvhZDthyjlPQaQJC4AanULx4jJsm
         udEBGn5mwgluyt40Cb0H4b9Rt4EoHlwr/4tKhZJkwAG5M6AooiUM+qPWQNcq/S02L0
         uXRCHgIoYf95seef8oUkwVjkIy8c3hxlqxiu5kjtgdkWQ1JPziVj7jT/CkmoWqv7dB
         MpKq3AWdGdLHCySq4EF227rhl/LTJuItrLWjF986UZOQrfH6sQpospQwPwBkhWTC0/
         ohcKg3tNSgdvg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50567477b29so3403234e87.3;
        Fri, 06 Oct 2023 16:00:10 -0700 (PDT)
X-Gm-Message-State: AOJu0YwLlFCsgFLgCJ0fV+PBHkvECAuehejBgdT5oHVklyGQScRjd3+F
        6mLcB3EVHZhoXbEzvgqos0W2APpysc9qvqRPCTU=
X-Google-Smtp-Source: AGHT+IGUwIsnV63UDRYG6J0ZqF0iXQaqHVFbYxtJQSuymsUOMmUxtPl2e5FaMeYVFq286z0ldqJng0iURsW6bIABAWg=
X-Received: by 2002:a05:6512:68a:b0:502:d743:9fc4 with SMTP id
 t10-20020a056512068a00b00502d7439fc4mr9541254lfe.37.1696633208839; Fri, 06
 Oct 2023 16:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org> <20230926194242.2732127-2-sjg@chromium.org>
 <CAPnjgZ0Xf3U1aj32LbU-xiU1AqwnM3JL1F8xX-wZ18oEmg+irw@mail.gmail.com>
 <CAMj1kXEXcX7BkDyfy-6_5Vnch=N+onza-yfWfsVaGLE93h2c+Q@mail.gmail.com> <CAPnjgZ2SEby-ndrs=W_afBJH56eqc=-mhp1F1nwkvWks+=B54Q@mail.gmail.com>
In-Reply-To: <CAPnjgZ2SEby-ndrs=W_afBJH56eqc=-mhp1F1nwkvWks+=B54Q@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 7 Oct 2023 00:59:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXED3S+0cq+VT7naBrmWrUwT=HZAaZOBRMv8Ui1Pey1QNQ@mail.gmail.com>
Message-ID: <CAMj1kXED3S+0cq+VT7naBrmWrUwT=HZAaZOBRMv8Ui1Pey1QNQ@mail.gmail.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2023 at 20:17, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ard,
>
> On Fri, 6 Oct 2023 at 11:33, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Mon, 2 Oct 2023 at 19:54, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Rob,
> > >
> > > On Tue, 26 Sept 2023 at 13:42, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > It is common to split firmware into 'Platform Init', which does the
> > > > initial hardware setup and a "Payload" which selects the OS to be booted.
> > > > Thus an handover interface is required between these two pieces.
> > > >
> > > > Where UEFI boot-time services are not available, but UEFI firmware is
> > > > present on either side of this interface, information about memory usage
> > > > and attributes must be presented to the "Payload" in some form.
> > > >
> > > > This aims to provide an small schema addition for the memory mapping
> > > > needed to keep these two pieces working together well.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v7:
> > > > - Rename acpi-reclaim to acpi
> > > > - Drop individual mention of when memory can be reclaimed
> > > > - Rewrite the item descriptions
> > > > - Add back the UEFI text (with trepidation)
> > >
> > > I am again checking on this series. Can it be applied, please?
> > >
> >
> > Apologies for the delay in response. I have been away.
>
> OK, I hope you had a nice trip.
>

Thanks, it was wonderful!

> >
> > >
> > > >
> > > > Changes in v6:
> > > > - Drop mention of UEFI
> > > > - Use compatible strings instead of node names
> > > >
> > > > Changes in v5:
> > > > - Drop the memory-map node (should have done that in v4)
> > > > - Tidy up schema a bit
> > > >
> > > > Changes in v4:
> > > > - Make use of the reserved-memory node instead of creating a new one
> > > >
> > > > Changes in v3:
> > > > - Reword commit message again
> > > > - cc a lot more people, from the FFI patch
> > > > - Split out the attributes into the /memory nodes
> > > >
> > > > Changes in v2:
> > > > - Reword commit message
> > > >
> > > >  .../reserved-memory/common-reserved.yaml      | 71 +++++++++++++++++++
> > > >  1 file changed, 71 insertions(+)
> > > >  create mode 100644 dtschema/schemas/reserved-memory/common-reserved.yaml
> > > >
> > > > diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > new file mode 100644
> > > > index 0000000..f7fbdfd
> > > > --- /dev/null
> > > > +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > > > @@ -0,0 +1,71 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/reserved-memory/common-reserved.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Common memory reservations
> > > > +
> > > > +description: |
> > > > +  Specifies that the reserved memory region can be used for the purpose
> > > > +  indicated by its compatible string.
> > > > +
> > > > +  Clients may reuse this reserved memory if they understand what it is for,
> > > > +  subject to the notes below.
> > > > +
> > > > +maintainers:
> > > > +  - Simon Glass <sjg@chromium.org>
> > > > +
> > > > +allOf:
> > > > +  - $ref: reserved-memory.yaml
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    description: |
> > > > +      This describes some common memory reservations, with the compatible
> > > > +      string indicating what it is used for:
> > > > +
> > > > +         acpi: Advanced Configuration and Power Interface (ACPI) tables
> > > > +         acpi-nvs: ACPI Non-Volatile-Sleeping Memory (NVS). This is reserved by
> > > > +           the firmware for its use and is required to be saved and restored
> > > > +           across an NVS sleep
> > > > +         boot-code: Contains code used for booting which is not needed by the OS
> > > > +         boot-code: Contains data used for booting which is not needed by the OS
> > > > +         runtime-code: Contains code used for interacting with the system when
> > > > +           running the OS
> > > > +         runtime-data: Contains data used for interacting with the system when
> > > > +           running the OS
> > > > +
> > > > +    enum:
> > > > +      - acpi
> > > > +      - acpi-nvs
> > > > +      - boot-code
> > > > +      - boot-data
> > > > +      - runtime-code
> > > > +      - runtime-data
> > > > +
> >
> > As I mentioned a few times already, I don't think these compatibles
> > should be introduced here.
> >
> > A reserved region has a specific purpose, and the compatible should be
> > more descriptive than the enum above. If the consumer does not
> > understand this purpose, it should simply treat the memory as reserved
> > and not touch it. Alternatively, these regions can be referenced from
> > other DT nodes using phandles if needed.
>
> We still need some description of what these regions are used for, so
> that the payload can use the correct regions. I do not have any other
> solution to this problem. We are in v7 at present. At least explain
> where you want the compatible strings to be introduced.
>

My point is really that by themselves, these regions are not usable by
either a payload or an OS that consumes this information. Unless there
is some other information being provided (via DT I imagine) that
describes how these things are supposed to be used, they are nothing
more than memory reservations that should be honored, and providing
this arbitrary set of labels is unnecessary.

> What sort of extra detail are you looking for? Please be specific and
> preferably add some suggestions so I can close this out ASAP.
>

A payload or OS can do nothing with a memory reservation called
'runtime-code' it it doesn't know what is inside. So there is another
DT node somewhere that describes this, and that can simply point to
this region (via a phandle) if it needs to describe the
correspondence. This is more idiomatic for DT afaik (but I am not the
expert).  But more importantly, it avoids overloading some vague
labels with behavior (e.g., executable permissions for code regions)
that should only be displayed for regions with a particular use,
rather than for a ill defined class of reservations the purpose of
which is not clear.

What I am trying to avoid is the OS ending up being forced to consume
this information in parallel to the EFI memory map, and having to
reconcile them. I'd be much happier if this gets contributed to a spec
that only covers firmware-to-firmware, and is prevented from leaking
into the OS facing interface.



> >
> >
> > > > +  reg:
> > > > +    description: region of memory that is reserved for the purpose indicated
> > > > +      by the compatible string.
> > > > +
> > > > +required:
> > > > +  - reg
> > > > +
> > > > +unevaluatedProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    reserved-memory {
> > > > +        #address-cells = <1>;
> > > > +        #size-cells = <1>;
> > > > +
> > > > +        reserved@12340000 {
> > > > +            compatible = "boot-code";
> > > > +            reg = <0x12340000 0x00800000>;
> > > > +        };
> > > > +
> > > > +        reserved@43210000 {
> > > > +            compatible = "boot-data";
> > > > +            reg = <0x43210000 0x00800000>;
> > > > +        };
> > > > +    };
> > > > --
> > > > 2.42.0.515.g380fc7ccd1-goog
>
> Regards,
> Simon
