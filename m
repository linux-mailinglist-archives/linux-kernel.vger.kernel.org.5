Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1F478E167
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbjH3V2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241267AbjH3V2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:28:42 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7333CD2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:28:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-991c786369cso10297266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693430822; x=1694035622; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qsmmyr5OFzyMVcMpEFVBPPKJRXoUjcjNdTuQLnrGF48=;
        b=KX1sF7MzPw+guJ+/Nfm+vSAyX1GrGihZolzOPVMRj6CAYRo4VaKkWQ9tHoHYI7BH+5
         HwQFEMP9ni95lW2d//2hZV1Z8lniPHMoYm2MS1LFS0FQWCXI25s59rw4x6L/uueY1k2O
         LqZIhYmDm2W+NTvUpHfRVs6C7f148chSPCuj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693430822; x=1694035622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsmmyr5OFzyMVcMpEFVBPPKJRXoUjcjNdTuQLnrGF48=;
        b=OIcmyvMPo7aAR6up5r0T5/0ahn8IhG16EZkbMPvn1+4xfx/bwjLxL7momlclPIaEHg
         fAM5+tv/n4l1IDHStUxbMeJaUYh3ofjFYgdr1kKyfAgIcXuoJGofgaEiGn9uUQILztNe
         2ENQCZWnLqfNnVLUPNlR/nss6WPVkSZqW7XYD6Gi8s8jMeBF6J7PTPXzaF3I/ytsNeHJ
         7uvfQABhDKH88gC6eVKWxWgL5mw6RoGX6LqqDzV6dZUulgs4AfV+BK3zEr6VWkj12UhE
         8Ge75JciFgnTW6p3FD77fxxtBZsOryXiQN0+jW8lLcRPkYRu/sCtHAyBYTZOj5ZXNirO
         G4eA==
X-Gm-Message-State: AOJu0YwH7G+s9dWkiqJsJMnDy+OnPx/U67hmg2YEx6MaT50fs1WMLCky
        jN5gjzoIt/gh7ZOqDNG9Vrs66SptV1PmKjf9BI45JOFFfxVLKQEttDymaw==
X-Google-Smtp-Source: AGHT+IFDRoXLXPrIZmwI2bs476erTEre4LDDRoGLiwdLjD+TCzsvOulU+GzGz8j1hshodfcQrQVfKGCcCkOqp5X7yDU=
X-Received: by 2002:ac2:5f02:0:b0:500:77c4:108 with SMTP id
 2-20020ac25f02000000b0050077c40108mr1924403lfq.9.1693429856927; Wed, 30 Aug
 2023 14:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230822203446.4111742-1-sjg@chromium.org> <ZOXKTrC_dzN_hUkY@FVFF77S0Q05N>
 <CAMj1kXEHpRjk_YKOm4czCnnpjqgahj2jV8MMfGLx7b1RdnBnVw@mail.gmail.com>
 <CAPnjgZ1S8G=7eCBF9PcDk4H5sk3AcxSSWXO575jK8SjA9dR8qw@mail.gmail.com>
 <CAMj1kXH83_TB4S0PL3jswxjCP+907YpgS7FRuVTO3G62s7nn5w@mail.gmail.com>
 <CAPnjgZ2kkUt1eOWX8K+EsbjcQZPefNvj5DSaFb9QrvRg0t2h7w@mail.gmail.com> <CAMj1kXGe84uaJ9j9ic0V4HC43p7QBoKQ5ssTYd5DMBGtZ3++Jw@mail.gmail.com>
In-Reply-To: <CAMj1kXGe84uaJ9j9ic0V4HC43p7QBoKQ5ssTYd5DMBGtZ3++Jw@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Wed, 30 Aug 2023 15:10:45 -0600
Message-ID: <CAPnjgZ3L-jGxoXNHnsXY0MXU=jTAN66KNAxSLHPVeHinHMjzkQ@mail.gmail.com>
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
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Tue, 29 Aug 2023 at 15:32, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 29 Aug 2023 at 21:18, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ard,
> >
> > On Thu, 24 Aug 2023 at 03:10, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Wed, 23 Aug 2023 at 22:04, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Wed, 23 Aug 2023 at 08:24, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > On Wed, 23 Aug 2023 at 10:59, Mark Rutland <mark.rutland@arm.com> wrote:
> > > > > >
> > > > > > On Tue, Aug 22, 2023 at 02:34:42PM -0600, Simon Glass wrote:
> > > > > > > The Devicetree specification skips over handling of a logical view of
> > > > > > > the memory map, pointing users to the UEFI specification.
> > > > > > >
> > > > > > > It is common to split firmware into 'Platform Init', which does the
> > > > > > > initial hardware setup and a "Payload" which selects the OS to be booted.
> > > > > > > Thus an handover interface is required between these two pieces.
> > > > > > >
> > > > > > > Where UEFI boot-time services are not available, but UEFI firmware is
> > > > > > > present on either side of this interface, information about memory usage
> > > > > > > and attributes must be presented to the "Payload" in some form.
> > > > >
> > > > > Not quite.
> > > > >
> > > > > This seems to be intended for consumption by Linux booting in ACPI
> > > > > mode, but not via UEFI, right?
> > > >
> > > > Actually, this is for consumption by firmware. The goal is to allow
> > > > edk2 to boot into U-Boot and vice versa, i.e. provide some
> > > > interoperability between firmware projects. I will use the "Platform
> > > > Init" and "Payload" terminology here too.
> > > >
> > >
> > > OK. It was the cc to linux-acpi@ and the authors of the
> > > ACPI/SMBIOS-without-UEFI patches that threw me off here.
> > >
> > > If we are talking about an internal interface for firmware components,
> > > I'd be inclined to treat this as an implementation detail, as long as
> > > the OS is not expected to consume these DT nodes.
> > >
> > > However, I struggle to see the point of framing this information as a
> > > 'UEFI memory map'. Neither EDK2 nor u-boot consume this information
> > > natively, and there is already prior art in both projects to consume
> > > nodes following the existing bindings for device_type=memory and the
> > > /reserved-memory node. UEFI runtime memory is generally useless
> > > without UEFI runtime services, and UEFI boot services memory is just
> > > free memory.
> > >
> > > There is also an overlap with the handover between secure and
> > > non-secure firmware on arm64, which is also DT based, and communicates
> > > available memory as well as RAM regions that are reserved for firmware
> > > use.
> > >
> > > In summary, I don't see why a non-UEFI payload would care about UEFI
> > > semantics for pre-existing memory reservations, or vice versa. Note
> > > that EDK2 will manage its own memory map, and expose it via UEFI boot
> > > services and not via DT.
> >
> > Bear in mind that one or both sides of this interface may be UEFI.
> > There is no boot-services link between the two parts that I have
> > outlined.
> >
>
> I don't understand what this means.
>
> UEFI specifies how one component invokes another, and it is not based
> on a DT binding. If the second component calls UEFI boot or runtime
> services, it should be invoked in this manner. If it doesn't, then it
> doesn't care about these memory reservations (and the OS will not be
> booted via UEFI either)
>
> So I feel I am missing something here. Perhaps a practical example
> would be helpful?

Let's say we want to support these combinations:

Platform Init -> Payload
--------------------------------
U-Boot -> Tianocore
coreboot -> U-Boot
Tianocore -> U-Boot
Tianocore -> Tianocore
U-Boot -> U-Boot

Some of the above things have UEFI interfaces, some don't. But in the
case of Tianocore -> Tianocore we want things to work as if it were
Tianocore -> (its own handoff mechanism) Tiancore.

Some Platform Init may create runtime code which needs to accessible later.

The way I think of it is that we need to generalise the memory map a
bit. Saying that you must use UEFI boot services to discover it is too
UEFI-specific.

>
>
> > >
> > > ...
> > > >
> > > > There is no intent to implement the UEFI spec, here. It is simply that
> > > > some payloads (EDK2) are used to having this information.
> > > >
> > > > Imagine splitting EDK2 into two parts, one of which does platform init
> > > > and the other which (the payload) boots the OS. The payload wants
> > > > information from Platform Init and it needs to be in a devicetree,
> > > > since that is what we have chosen for this interface. So to some
> > > > extent this is unrelated to whether you have EFI boot services. We
> > > > just need to be able to pass the information across the interface.
> > > > Note that the user can (without recompilation, etc.) replace the
> > > > second part with U-Boot (for example) and it must still work.
> > > >
> > >
> > > OK, so device tree makes sense for this. This is how I implemented the
> > > EDK2 port that targets QEMU/mach-virt - it consumes the DT to discover
> > > the UART, RTC,, memory, PCI host bridge, etc.
> > >
> > > But I don't see a use case for a UEFI memory map here.
> > >
> > >
> ...
> > > >
> > > > Here I believe you are talking about booting the kernel in EFI mode,
> > > > but that is not the intent of this patch. This is all about things
> > > > happening in firmware. Now, if the payload (second) part of the
> > > > firmware decides it wants to offer EFI boot services and boot the
> > > > kernel via the EFI stub, then it may very well pack this information
> > > > (with a few changes) into a system table and make it available to the
> > > > kernel stub. But by then this FDT binding is irrelevant, since it has
> > > > served its purpose (which, to reiterate, is to facilitate information
> > > > passage from platform init to 'payload').
> > > >
> > >
> > > Indeed. As long as this binding is never consumed by the OS, I don't
> > > have any objections to it - I just fail to see the point.
> >
> > OK thanks.
> >
> > The point is that Platform Init and the payload need to agree about
> > where certain things are in memory. It is true that this is coming
> > from an EFI context, but that is just an example. Platform Init
> > doesn't necessarily know whether its payload is EFI, but may set this
> > up for use by the payload, just in case.
> >
>
> Platform init can communicate memory reservations to a UEFI payload if
> needed, and there is prior art for this.
>
> Platform init *cannot* communicate UEFI specific boot or runtime
> reservations in this manner, as this doesn't make sense: either
> Platform Init is UEFI and invokes a UEFI payload, in which case the
> UEFI spec applies. In other cases, the UEFI memory regions either
> don't exist or are irrelevant. The only EFI-agnostic aspect here is
> RAM reservation for use by firmware in general, and this does not have
> these UEFI semantics and does not need to be framed as such.

How does one do the handoff if we don't know whether the payload
supports UEFI or not? I am coming from an interoperability POV here.

Regards,
Simon
