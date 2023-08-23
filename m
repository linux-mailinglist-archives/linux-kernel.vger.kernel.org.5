Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2790F78612B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 22:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbjHWUFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 16:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbjHWUE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 16:04:28 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7A710CC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 13:04:24 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so393943a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 13:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692821062; x=1693425862;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mbNGjy7zX9g+WJW97/AU37/Lm90Tn7R9l3Tj2bMGc18=;
        b=F4wOBbseRiVjpbDrTHSFdiu7aS8clVWte3lx2jqucjj+QSjkjxiR4dxhwcoeqwLTvV
         cpV9GHLpSf80jOH8Gw4Dsuvs0zYy5dzc9foLe7c1lr6mKhjBuV8k1rotMjoFutNoLmaC
         BN8ONzMiFx/UUbieNBZlNr1K9qv6ndCynIGSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692821062; x=1693425862;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbNGjy7zX9g+WJW97/AU37/Lm90Tn7R9l3Tj2bMGc18=;
        b=EBp5+sBK4pleP2X59E2bR/wa/n/Q/YEFk0QpAbhEpdPmvArJLYB9dLrASlm9LcaMD9
         /aviVXZiwczUgQAfMqE51jS6StfKoohwJiUoUa+GN2+eSOoe//Fo/sRqeM53WbqXXd+8
         2gZOy0sSTFbGAiUHjhgjQBl8wy607+t3Nc+l69K5JNb/7/NMmcdEr1ocudTmuXeYd6Do
         jvJ+0LsOYcpoaCGXvk070iI92WLiOx7JAt40guZpiIqLT6qAucCbZt+YZ87OngDXkq8L
         yAtnibrWvpsv0w86JGY8QVvr5q9wUOX0Vjr5Ewgo8+pO3aZUoDBKdTz+OQbZYcmL2IXE
         o+2A==
X-Gm-Message-State: AOJu0Yx4ZiDgWgdHScJzPf+bZec1XLyF32937tPNchqavHi+LFbQcYbS
        QwoNFWHFCHfTVBevuBrovlHQU3m9/cJxoemkMZlVTA==
X-Google-Smtp-Source: AGHT+IFJY3KXPDLQhJJTyqi58QXqh+TZuzYefqKWmN30vLkuxUEYHA5cDTOIlkGSEYQRpwD4bXdmfPW9Siw5UNXU32U=
X-Received: by 2002:a05:6402:34cf:b0:51d:b184:efd with SMTP id
 w15-20020a05640234cf00b0051db1840efdmr14823948edc.20.1692821062414; Wed, 23
 Aug 2023 13:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230822203446.4111742-1-sjg@chromium.org> <ZOXKTrC_dzN_hUkY@FVFF77S0Q05N>
 <CAMj1kXEHpRjk_YKOm4czCnnpjqgahj2jV8MMfGLx7b1RdnBnVw@mail.gmail.com>
In-Reply-To: <CAMj1kXEHpRjk_YKOm4czCnnpjqgahj2jV8MMfGLx7b1RdnBnVw@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Wed, 23 Aug 2023 14:04:11 -0600
Message-ID: <CAPnjgZ1S8G=7eCBF9PcDk4H5sk3AcxSSWXO575jK8SjA9dR8qw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] schemas: Add a schema for memory map
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
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
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 23 Aug 2023 at 08:24, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 23 Aug 2023 at 10:59, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Aug 22, 2023 at 02:34:42PM -0600, Simon Glass wrote:
> > > The Devicetree specification skips over handling of a logical view of
> > > the memory map, pointing users to the UEFI specification.
> > >
> > > It is common to split firmware into 'Platform Init', which does the
> > > initial hardware setup and a "Payload" which selects the OS to be booted.
> > > Thus an handover interface is required between these two pieces.
> > >
> > > Where UEFI boot-time services are not available, but UEFI firmware is
> > > present on either side of this interface, information about memory usage
> > > and attributes must be presented to the "Payload" in some form.
>
> Not quite.
>
> This seems to be intended for consumption by Linux booting in ACPI
> mode, but not via UEFI, right?

Actually, this is for consumption by firmware. The goal is to allow
edk2 to boot into U-Boot and vice versa, i.e. provide some
interoperability between firmware projects. I will use the "Platform
Init" and "Payload" terminology here too.

> Some proposed changes to support that
> were rejected on the basis that ACPI on non-x86 is strictly tied to
> ACPI boot, not only because the ACPI root table (rsdp) can only be
> discovered via UEFI, but also because the ACPI subsystem in Linux
> cross-references any memory mappings created from AML code against the
> UEFI memory map.
>
> Unfortunately, having a vague, non-exhaustive approximation of the
> UEFI memory map is unlikely to be sufficient here. The existing logic
> assumes that addresses not covered by the UEFI memory map are MMIO,
> which means that either a) the UEFI memory map needs to describe all
> RAM exhaustively or b) the existing logic needs to be modified to take
> memblock or other information sources into account as well in order to
> reason about whether a certain address requires device or normal
> memory attributes.
>
> Note that the ACPI spec only lists EFI as a valid way to obtain the
> root table pointer on architectures other than x86. If other ways are
> needed, they should be contributed to the spec, rather than being
> added to Linux as an ad hoc workaround for bootloaders that have
> trouble implementing the spec as is.

There is no intent to implement the UEFI spec, here. It is simply that
some payloads (EDK2) are used to having this information.

Imagine splitting EDK2 into two parts, one of which does platform init
and the other which (the payload) boots the OS. The payload wants
information from Platform Init and it needs to be in a devicetree,
since that is what we have chosen for this interface. So to some
extent this is unrelated to whether you have EFI boot services. We
just need to be able to pass the information across the interface.
Note that the user can (without recompilation, etc.) replace the
second part with U-Boot (for example) and it must still work.

>
> >
> > Today Linux does that by passing:
> >
> >   /chosen/linux,uefi-mmap-start
> >   /chosen/linux,uefi-mmap-size
> >   /chosen/linux,uefi-mmap-desc-size
> >   /chosen/linux,uefi-mmap-desc-ver
> >
> > ... or /chosen/xen,* variants of those.
> >
> > Can't we document / genericise that?

That seems to me to be the fields from the EFI memory-map call, but
where is the actual content? I looked in the kernel but it seems to be
an internal interface (between the stub and the kernel)?

> >
>
> Given the ACPI angle, promoting this to external ABI would introduce a
> DT dependency to ACPI boot. So we'll at least have to be very clear
> about which takes precedence, or maybe disregard everything except the
> /chosen node when doing ACPI boot?
>
> This also argues for not creating an ordinary binding for this (i.e.,
> describing it as part of the platform topology), but putting it under
> /chosen as a Linux-only boot tweak.
>
> > Pointing to that rather than re-encoding it in DT means that it stays in-sync
> > with the EFI spec and we won't back ourselves into a corner where we cannot
> > encode something due to a structural difference. I don't think it's a good idea
> > to try to re-encode it, or we're just setting ourselves up for futher pain.
> >
>
> What I would prefer is to formalize pseudo-EFI boot and define the
> bare required minimum (system table + memory map + config tables) in
> an arch-agnostic manner. That way, the only thing that needs to be
> passed via DT/boot_params/etc is the (pseudo-)EFI system table
> address, and everything else (SMBIOS, ACPI as well as the EFI memory
> map and even the initrd) can be passed via config tables as usual, all
> of which is already supported in (mostly) generic kernel code.
>
> This means that booting via the EFI stub would not be required, nor is
> implementing boot services or runtime services or any of the other
> things that people appear to hate with such a passion.
>
> I'd actually prefer not to use those /chosen DT nodes, but pass the
> memory map via a config table. This, however, requires* that the
> runtime services memory regions are mapped 1:1 so it is not something
> we can do for all currently supported systems. But for pseudo-EFI
> boot, stipulating 1:1 runtime mappings is fine (or no runtime mappings
> at all if the firmware does not expose runtime services)
>
> * SetVirtualAddressMap() relocates the config table array, and without
> a memory map, it is not possible to convert those address back to
> physical. SetVirtualAddressMap() is evil and needs to die, but this is
> off-topic for the thread at hand.

Here I believe you are talking about booting the kernel in EFI mode,
but that is not the intent of this patch. This is all about things
happening in firmware. Now, if the payload (second) part of the
firmware decides it wants to offer EFI boot services and boot the
kernel via the EFI stub, then it may very well pack this information
(with a few changes) into a system table and make it available to the
kernel stub. But by then this FDT binding is irrelevant, since it has
served its purpose (which, to reiterate, is to facilitate information
passage from platform init to 'payload').

>
> > >
> > > This aims to provide an initial schema for this mapping.
> > >
> > > Note that this is separate from the existing /memory and /reserved-memory
> > > nodes, since it is mostly concerned with what the memory is used for. It
> > > may cover only a small fraction of available memory.
> > >
> > > For now, no attempt is made to create an exhaustive binding, so there are
> > > some example types listed. This can be completed once this has passed
> > > initial review.
> > >
> > > This binding does not include a binding for the memory 'attribute'
> > > property, defined by EFI_BOOT_SERVICES.GetMemoryMap(). It may be useful
> > > to have that as well, but perhaps not as a bit mask.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v3:
> > > - Reword commit message again
> > > - cc a lot more people, from the FFI patch
> > > - Split out the attributes into the /memory nodes
> > >
> > > Changes in v2:
> > > - Reword commit message
> > >
> > >  dtschema/schemas/memory-map.yaml | 61 ++++++++++++++++++++++++++++++++
> > >  1 file changed, 61 insertions(+)
> > >  create mode 100644 dtschema/schemas/memory-map.yaml
> > >
> > > diff --git a/dtschema/schemas/memory-map.yaml b/dtschema/schemas/memory-map.yaml
> > > new file mode 100644
> > > index 0000000..4b06583
> > > --- /dev/null
> > > +++ b/dtschema/schemas/memory-map.yaml
> > > @@ -0,0 +1,61 @@
> > > +# SPDX-License-Identifier: BSD-2-Clause
> > > +# Copyright 2023 Google LLC
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/memory-map.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: /memory-map nodes
> > > +description: |
> > > +  Common properties always required in /memory-map nodes. These nodes are
> > > +  intended to resolve the nonchalant clause 3.4.1 ("/memory node and UEFI")
> > > +  in the Devicetree Specification.
> > > +
> > > +maintainers:
> > > +  - Simon Glass <sjg@chromium.org>
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    const: 'memory-map'
> > > +
> > > +patternProperties:
> > > +  "^([a-z][a-z0-9\\-]+@[0-9a-f]+)?$":
> > > +    type: object
> > > +    additionalProperties: false
> > > +
> > > +    properties:
> > > +      reg:
> > > +        minItems: 1
> > > +        maxItems: 1024
> > > +
> > > +      usage:
> > > +        $ref: /schemas/types.yaml#/definitions/string
> > > +        description: |
> > > +          Describes the usage of the memory region, e.g.:
> > > +
> > > +            "acpi-reclaim", "acpi-nvs", "bootcode", "bootdata", "bootdata",
> > > +            "runtime-code", "runtime-data".
> > > +
> > > +            See enum EFI_MEMORY_TYPE in "Unified Extensible Firmware Interface
> > > +            (UEFI) Specification" for all the types. For now there are not
> > > +            listed here.
> > > +
> > > +    required:
> > > +      - reg
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    memory-map {
> > > +        acpi@f0000 {
> > > +            reg = <0xf0000 0x4000>;
> > > +            usage = "acpi-reclaim";
> > > +        };
> > > +
> > > +        runtime@12300000 {
> > > +            reg = <0x12300000 0x28000>;
> > > +            usage = "runtime-code";
> > > +        };
> > > +    };
> > > +...
> > > --
> > > 2.42.0.rc1.204.g551eb34607-goog
> > >

Regards,
Simon
