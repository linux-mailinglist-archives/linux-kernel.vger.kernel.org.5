Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F006785A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbjHWOX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjHWOXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:23:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5852BE47;
        Wed, 23 Aug 2023 07:23:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCB8665E1C;
        Wed, 23 Aug 2023 14:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11649C43391;
        Wed, 23 Aug 2023 14:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692800632;
        bh=L6RLKjcjf0wClZapR3eDem9qqnd+Wm/UZw5H508dK38=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=keenKXhdWPmWW/UM6/jrm2f8lqu83XeL3axzHEty84wzUfz6iGm5yF92b4siEMhVs
         x8HPi9BfV6x6Wd1aPa7pAzzLryu8pXkMYpD9/Up/qFNIqQuYpvr/zlHw+XASC82WEU
         c5pL7lAIOfIIIfyL5s+A/KitTVzaJAfYu6FhVYR1T+WtWnQwcWVmevz60wL+ECUAoG
         21tKPiwWMQX9idR8sjPIq5gKfzDz21TiKyuCvYl3kpMHr3tBqJM6wjb9s3tJOtQX6C
         c4t8X13CnFHlr6QBpHjf69YZrPhztbdJhbAJ9TlOu22oqPw0Tjfn7+4bwFY682wkkr
         P9ohjVJcixSCA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5007616b756so5905330e87.3;
        Wed, 23 Aug 2023 07:23:51 -0700 (PDT)
X-Gm-Message-State: AOJu0YzVnaiqt5gFElmfQNxALPqO/v17CutCU5f3Q5J2RuGbUAVhODYJ
        T4TdyX7wGIeJ/Ueg+GOAMB8T2ZnAfezrbqV5GIw=
X-Google-Smtp-Source: AGHT+IG+v0ql3xKgaaIRw2aNIMl4q7zemhhsd+/yB6IX6qUsIPOxXeEVctDDZNhBJ7VyqtLoumpqJTdkynEQuahFz/w=
X-Received: by 2002:a19:651d:0:b0:4ff:8fdd:4be4 with SMTP id
 z29-20020a19651d000000b004ff8fdd4be4mr9463042lfb.29.1692800629839; Wed, 23
 Aug 2023 07:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230822203446.4111742-1-sjg@chromium.org> <ZOXKTrC_dzN_hUkY@FVFF77S0Q05N>
In-Reply-To: <ZOXKTrC_dzN_hUkY@FVFF77S0Q05N>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 23 Aug 2023 16:23:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEHpRjk_YKOm4czCnnpjqgahj2jV8MMfGLx7b1RdnBnVw@mail.gmail.com>
Message-ID: <CAMj1kXEHpRjk_YKOm4czCnnpjqgahj2jV8MMfGLx7b1RdnBnVw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] schemas: Add a schema for memory map
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Simon Glass <sjg@chromium.org>, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Chiu Chasel <chasel.chiu@intel.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Gua Guo <gua.guo@intel.com>, linux-acpi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        ron minnich <rminnich@gmail.com>,
        Tom Rini <trini@konsulko.com>,
        Lean Sheng Tan <sheng.tan@9elements.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2023 at 10:59, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Aug 22, 2023 at 02:34:42PM -0600, Simon Glass wrote:
> > The Devicetree specification skips over handling of a logical view of
> > the memory map, pointing users to the UEFI specification.
> >
> > It is common to split firmware into 'Platform Init', which does the
> > initial hardware setup and a "Payload" which selects the OS to be booted.
> > Thus an handover interface is required between these two pieces.
> >
> > Where UEFI boot-time services are not available, but UEFI firmware is
> > present on either side of this interface, information about memory usage
> > and attributes must be presented to the "Payload" in some form.

Not quite.

This seems to be intended for consumption by Linux booting in ACPI
mode, but not via UEFI, right? Some proposed changes to support that
were rejected on the basis that ACPI on non-x86 is strictly tied to
ACPI boot, not only because the ACPI root table (rsdp) can only be
discovered via UEFI, but also because the ACPI subsystem in Linux
cross-references any memory mappings created from AML code against the
UEFI memory map.

Unfortunately, having a vague, non-exhaustive approximation of the
UEFI memory map is unlikely to be sufficient here. The existing logic
assumes that addresses not covered by the UEFI memory map are MMIO,
which means that either a) the UEFI memory map needs to describe all
RAM exhaustively or b) the existing logic needs to be modified to take
memblock or other information sources into account as well in order to
reason about whether a certain address requires device or normal
memory attributes.

Note that the ACPI spec only lists EFI as a valid way to obtain the
root table pointer on architectures other than x86. If other ways are
needed, they should be contributed to the spec, rather than being
added to Linux as an ad hoc workaround for bootloaders that have
trouble implementing the spec as is.

>
> Today Linux does that by passing:
>
>   /chosen/linux,uefi-mmap-start
>   /chosen/linux,uefi-mmap-size
>   /chosen/linux,uefi-mmap-desc-size
>   /chosen/linux,uefi-mmap-desc-ver
>
> ... or /chosen/xen,* variants of those.
>
> Can't we document / genericise that?
>

Given the ACPI angle, promoting this to external ABI would introduce a
DT dependency to ACPI boot. So we'll at least have to be very clear
about which takes precedence, or maybe disregard everything except the
/chosen node when doing ACPI boot?

This also argues for not creating an ordinary binding for this (i.e.,
describing it as part of the platform topology), but putting it under
/chosen as a Linux-only boot tweak.

> Pointing to that rather than re-encoding it in DT means that it stays in-sync
> with the EFI spec and we won't back ourselves into a corner where we cannot
> encode something due to a structural difference. I don't think it's a good idea
> to try to re-encode it, or we're just setting ourselves up for futher pain.
>

What I would prefer is to formalize pseudo-EFI boot and define the
bare required minimum (system table + memory map + config tables) in
an arch-agnostic manner. That way, the only thing that needs to be
passed via DT/boot_params/etc is the (pseudo-)EFI system table
address, and everything else (SMBIOS, ACPI as well as the EFI memory
map and even the initrd) can be passed via config tables as usual, all
of which is already supported in (mostly) generic kernel code.

This means that booting via the EFI stub would not be required, nor is
implementing boot services or runtime services or any of the other
things that people appear to hate with such a passion.

I'd actually prefer not to use those /chosen DT nodes, but pass the
memory map via a config table. This, however, requires* that the
runtime services memory regions are mapped 1:1 so it is not something
we can do for all currently supported systems. But for pseudo-EFI
boot, stipulating 1:1 runtime mappings is fine (or no runtime mappings
at all if the firmware does not expose runtime services)

* SetVirtualAddressMap() relocates the config table array, and without
a memory map, it is not possible to convert those address back to
physical. SetVirtualAddressMap() is evil and needs to die, but this is
off-topic for the thread at hand.

> >
> > This aims to provide an initial schema for this mapping.
> >
> > Note that this is separate from the existing /memory and /reserved-memory
> > nodes, since it is mostly concerned with what the memory is used for. It
> > may cover only a small fraction of available memory.
> >
> > For now, no attempt is made to create an exhaustive binding, so there are
> > some example types listed. This can be completed once this has passed
> > initial review.
> >
> > This binding does not include a binding for the memory 'attribute'
> > property, defined by EFI_BOOT_SERVICES.GetMemoryMap(). It may be useful
> > to have that as well, but perhaps not as a bit mask.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Reword commit message again
> > - cc a lot more people, from the FFI patch
> > - Split out the attributes into the /memory nodes
> >
> > Changes in v2:
> > - Reword commit message
> >
> >  dtschema/schemas/memory-map.yaml | 61 ++++++++++++++++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >  create mode 100644 dtschema/schemas/memory-map.yaml
> >
> > diff --git a/dtschema/schemas/memory-map.yaml b/dtschema/schemas/memory-map.yaml
> > new file mode 100644
> > index 0000000..4b06583
> > --- /dev/null
> > +++ b/dtschema/schemas/memory-map.yaml
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: BSD-2-Clause
> > +# Copyright 2023 Google LLC
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/memory-map.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: /memory-map nodes
> > +description: |
> > +  Common properties always required in /memory-map nodes. These nodes are
> > +  intended to resolve the nonchalant clause 3.4.1 ("/memory node and UEFI")
> > +  in the Devicetree Specification.
> > +
> > +maintainers:
> > +  - Simon Glass <sjg@chromium.org>
> > +
> > +properties:
> > +  $nodename:
> > +    const: 'memory-map'
> > +
> > +patternProperties:
> > +  "^([a-z][a-z0-9\\-]+@[0-9a-f]+)?$":
> > +    type: object
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      reg:
> > +        minItems: 1
> > +        maxItems: 1024
> > +
> > +      usage:
> > +        $ref: /schemas/types.yaml#/definitions/string
> > +        description: |
> > +          Describes the usage of the memory region, e.g.:
> > +
> > +            "acpi-reclaim", "acpi-nvs", "bootcode", "bootdata", "bootdata",
> > +            "runtime-code", "runtime-data".
> > +
> > +            See enum EFI_MEMORY_TYPE in "Unified Extensible Firmware Interface
> > +            (UEFI) Specification" for all the types. For now there are not
> > +            listed here.
> > +
> > +    required:
> > +      - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    memory-map {
> > +        acpi@f0000 {
> > +            reg = <0xf0000 0x4000>;
> > +            usage = "acpi-reclaim";
> > +        };
> > +
> > +        runtime@12300000 {
> > +            reg = <0x12300000 0x28000>;
> > +            usage = "runtime-code";
> > +        };
> > +    };
> > +...
> > --
> > 2.42.0.rc1.204.g551eb34607-goog
> >
