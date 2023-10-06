Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3144E7BBDD8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjJFRdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjJFRdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:33:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22794C2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 10:33:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC23C433C9;
        Fri,  6 Oct 2023 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696613613;
        bh=4IY5wvH6Tu8PjK8sB+KMGi/o7CRamiSkVLdDByB8yd8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JLgw/UkCyfmsvFHkORbsNApmlFxfQIWwAspg7Fgtj7uPVIWdvAhtw04GGiTbDYQgU
         1NcRUUKEdX98ooHi0UShUy8PN3FdMPPaykMmKqJK+nG7EdgTbceY7vSGy9qCM1QQvi
         RkkVLS9B7Kv445176PYUUham34401aZOlX6CwIKbjTM1DmC8nNUKjLfabxIW1VcsMF
         id2cn/dFAO1AG1GG+6/5eS2voYp3c+sXJEDLrfjeWZvg42g2KtTaAdrhU8+EOIOswF
         uvVTpmOpUNHgJrjWPfo/NvPCdZb55r9VdDBIIOpd8W4TUMwcV4GxQxdf92GByJiWNL
         CsSL1voPt3ONQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5044dd5b561so2928579e87.1;
        Fri, 06 Oct 2023 10:33:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YyWyIlen5VyOrw6TrBzNXgv4ZDiAm3PF1iwGmb1vJSFasUWWHU8
        GBNm6QwZFY/pfEgS1FuTTAr5ZOY6CmTXMFyy/u0=
X-Google-Smtp-Source: AGHT+IG2WFsPGJcnl4fQlvIDX23yxE4FYGH11uyJoLwu4bJYLZExy/cAZV6tzSxf3TqK4KzjOHM+0kg+tpgnDaQV7yU=
X-Received: by 2002:a19:c217:0:b0:504:7e12:4846 with SMTP id
 l23-20020a19c217000000b005047e124846mr7273243lfc.30.1696613611592; Fri, 06
 Oct 2023 10:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org> <20230926194242.2732127-2-sjg@chromium.org>
 <CAPnjgZ0Xf3U1aj32LbU-xiU1AqwnM3JL1F8xX-wZ18oEmg+irw@mail.gmail.com>
In-Reply-To: <CAPnjgZ0Xf3U1aj32LbU-xiU1AqwnM3JL1F8xX-wZ18oEmg+irw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 6 Oct 2023 19:33:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEXcX7BkDyfy-6_5Vnch=N+onza-yfWfsVaGLE93h2c+Q@mail.gmail.com>
Message-ID: <CAMj1kXEXcX7BkDyfy-6_5Vnch=N+onza-yfWfsVaGLE93h2c+Q@mail.gmail.com>
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

On Mon, 2 Oct 2023 at 19:54, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Rob,
>
> On Tue, 26 Sept 2023 at 13:42, Simon Glass <sjg@chromium.org> wrote:
> >
> > It is common to split firmware into 'Platform Init', which does the
> > initial hardware setup and a "Payload" which selects the OS to be booted.
> > Thus an handover interface is required between these two pieces.
> >
> > Where UEFI boot-time services are not available, but UEFI firmware is
> > present on either side of this interface, information about memory usage
> > and attributes must be presented to the "Payload" in some form.
> >
> > This aims to provide an small schema addition for the memory mapping
> > needed to keep these two pieces working together well.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v7:
> > - Rename acpi-reclaim to acpi
> > - Drop individual mention of when memory can be reclaimed
> > - Rewrite the item descriptions
> > - Add back the UEFI text (with trepidation)
>
> I am again checking on this series. Can it be applied, please?
>

Apologies for the delay in response. I have been away.

>
> >
> > Changes in v6:
> > - Drop mention of UEFI
> > - Use compatible strings instead of node names
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
> >  .../reserved-memory/common-reserved.yaml      | 71 +++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >  create mode 100644 dtschema/schemas/reserved-memory/common-reserved.yaml
> >
> > diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > new file mode 100644
> > index 0000000..f7fbdfd
> > --- /dev/null
> > +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> > @@ -0,0 +1,71 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/reserved-memory/common-reserved.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Common memory reservations
> > +
> > +description: |
> > +  Specifies that the reserved memory region can be used for the purpose
> > +  indicated by its compatible string.
> > +
> > +  Clients may reuse this reserved memory if they understand what it is for,
> > +  subject to the notes below.
> > +
> > +maintainers:
> > +  - Simon Glass <sjg@chromium.org>
> > +
> > +allOf:
> > +  - $ref: reserved-memory.yaml
> > +
> > +properties:
> > +  compatible:
> > +    description: |
> > +      This describes some common memory reservations, with the compatible
> > +      string indicating what it is used for:
> > +
> > +         acpi: Advanced Configuration and Power Interface (ACPI) tables
> > +         acpi-nvs: ACPI Non-Volatile-Sleeping Memory (NVS). This is reserved by
> > +           the firmware for its use and is required to be saved and restored
> > +           across an NVS sleep
> > +         boot-code: Contains code used for booting which is not needed by the OS
> > +         boot-code: Contains data used for booting which is not needed by the OS
> > +         runtime-code: Contains code used for interacting with the system when
> > +           running the OS
> > +         runtime-data: Contains data used for interacting with the system when
> > +           running the OS
> > +
> > +    enum:
> > +      - acpi
> > +      - acpi-nvs
> > +      - boot-code
> > +      - boot-data
> > +      - runtime-code
> > +      - runtime-data
> > +

As I mentioned a few times already, I don't think these compatibles
should be introduced here.

A reserved region has a specific purpose, and the compatible should be
more descriptive than the enum above. If the consumer does not
understand this purpose, it should simply treat the memory as reserved
and not touch it. Alternatively, these regions can be referenced from
other DT nodes using phandles if needed.


> > +  reg:
> > +    description: region of memory that is reserved for the purpose indicated
> > +      by the compatible string.
> > +
> > +required:
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    reserved-memory {
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +
> > +        reserved@12340000 {
> > +            compatible = "boot-code";
> > +            reg = <0x12340000 0x00800000>;
> > +        };
> > +
> > +        reserved@43210000 {
> > +            compatible = "boot-data";
> > +            reg = <0x43210000 0x00800000>;
> > +        };
> > +    };
> > --
> > 2.42.0.515.g380fc7ccd1-goog
> >
>
> Regards,
> Simon
