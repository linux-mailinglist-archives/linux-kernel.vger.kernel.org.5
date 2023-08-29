Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5305978CECA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbjH2Vcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238939AbjH2Vco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:32:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85D8A8;
        Tue, 29 Aug 2023 14:32:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 567E5616A0;
        Tue, 29 Aug 2023 21:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC005C433CA;
        Tue, 29 Aug 2023 21:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693344760;
        bh=5o6ki4h0Ml9jAcSugGPORbFfTrt12s7REMjvXI4xR4Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LftEq++9TdpzBCHZL3FrVb5yUmSkFZylY8fpzdVOFPgfdE5Xtn5AMoKk9xgdCv/9N
         z1w202zDQmICAiMxZroK+nGFu+m+IrZs6RnnKSuUMAv513pVzJIu3aZaMbjZf9UpWG
         2GKGHABaseufLESGYQhz3VLnJaNHqRB0cRm6SBXdxxuXnVxAECwKxbrH2xF9yguKQT
         XBtVXkih+i6NgsvXtDmIxTU3JtlyIXwR2+6yFgrCCKrGWGUXqWPHkquHoM3cS84J8u
         J4lfgn/kfQtV/tH8/qu88KUCx4PqRnEDRkrVcQ/AgiKI1uy8viaFXRugesCVFiffDt
         oJOv0/0dD2EeA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50043cf2e29so7593960e87.2;
        Tue, 29 Aug 2023 14:32:40 -0700 (PDT)
X-Gm-Message-State: AOJu0Yznnu5J0REr2OYQIVG9HkaXk6keWa9cy5Nx8zF4ML5VtXlC+Mnx
        01jseyr0Yv80lPl0ujd/Hu94T210NvUfPUz7FSQ=
X-Google-Smtp-Source: AGHT+IFG7drW7XtSYzjCVaUWymqykiMN8j8kcQp1tRPjGjuXbW1d4XcdEzil0B8OeqZsoEILEVQdFDqyTELIfS7Pr5w=
X-Received: by 2002:ac2:5446:0:b0:500:9d6c:913e with SMTP id
 d6-20020ac25446000000b005009d6c913emr98357lfn.52.1693344758741; Tue, 29 Aug
 2023 14:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230822203446.4111742-1-sjg@chromium.org> <ZOXKTrC_dzN_hUkY@FVFF77S0Q05N>
 <CAMj1kXEHpRjk_YKOm4czCnnpjqgahj2jV8MMfGLx7b1RdnBnVw@mail.gmail.com>
 <CAPnjgZ1S8G=7eCBF9PcDk4H5sk3AcxSSWXO575jK8SjA9dR8qw@mail.gmail.com>
 <CAMj1kXH83_TB4S0PL3jswxjCP+907YpgS7FRuVTO3G62s7nn5w@mail.gmail.com> <CAPnjgZ2kkUt1eOWX8K+EsbjcQZPefNvj5DSaFb9QrvRg0t2h7w@mail.gmail.com>
In-Reply-To: <CAPnjgZ2kkUt1eOWX8K+EsbjcQZPefNvj5DSaFb9QrvRg0t2h7w@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 29 Aug 2023 23:32:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGe84uaJ9j9ic0V4HC43p7QBoKQ5ssTYd5DMBGtZ3++Jw@mail.gmail.com>
Message-ID: <CAMj1kXGe84uaJ9j9ic0V4HC43p7QBoKQ5ssTYd5DMBGtZ3++Jw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] schemas: Add a schema for memory map
To:     Simon Glass <sjg@chromium.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 21:18, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ard,
>
> On Thu, 24 Aug 2023 at 03:10, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 23 Aug 2023 at 22:04, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, 23 Aug 2023 at 08:24, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Wed, 23 Aug 2023 at 10:59, Mark Rutland <mark.rutland@arm.com> wrote:
> > > > >
> > > > > On Tue, Aug 22, 2023 at 02:34:42PM -0600, Simon Glass wrote:
> > > > > > The Devicetree specification skips over handling of a logical view of
> > > > > > the memory map, pointing users to the UEFI specification.
> > > > > >
> > > > > > It is common to split firmware into 'Platform Init', which does the
> > > > > > initial hardware setup and a "Payload" which selects the OS to be booted.
> > > > > > Thus an handover interface is required between these two pieces.
> > > > > >
> > > > > > Where UEFI boot-time services are not available, but UEFI firmware is
> > > > > > present on either side of this interface, information about memory usage
> > > > > > and attributes must be presented to the "Payload" in some form.
> > > >
> > > > Not quite.
> > > >
> > > > This seems to be intended for consumption by Linux booting in ACPI
> > > > mode, but not via UEFI, right?
> > >
> > > Actually, this is for consumption by firmware. The goal is to allow
> > > edk2 to boot into U-Boot and vice versa, i.e. provide some
> > > interoperability between firmware projects. I will use the "Platform
> > > Init" and "Payload" terminology here too.
> > >
> >
> > OK. It was the cc to linux-acpi@ and the authors of the
> > ACPI/SMBIOS-without-UEFI patches that threw me off here.
> >
> > If we are talking about an internal interface for firmware components,
> > I'd be inclined to treat this as an implementation detail, as long as
> > the OS is not expected to consume these DT nodes.
> >
> > However, I struggle to see the point of framing this information as a
> > 'UEFI memory map'. Neither EDK2 nor u-boot consume this information
> > natively, and there is already prior art in both projects to consume
> > nodes following the existing bindings for device_type=memory and the
> > /reserved-memory node. UEFI runtime memory is generally useless
> > without UEFI runtime services, and UEFI boot services memory is just
> > free memory.
> >
> > There is also an overlap with the handover between secure and
> > non-secure firmware on arm64, which is also DT based, and communicates
> > available memory as well as RAM regions that are reserved for firmware
> > use.
> >
> > In summary, I don't see why a non-UEFI payload would care about UEFI
> > semantics for pre-existing memory reservations, or vice versa. Note
> > that EDK2 will manage its own memory map, and expose it via UEFI boot
> > services and not via DT.
>
> Bear in mind that one or both sides of this interface may be UEFI.
> There is no boot-services link between the two parts that I have
> outlined.
>

I don't understand what this means.

UEFI specifies how one component invokes another, and it is not based
on a DT binding. If the second component calls UEFI boot or runtime
services, it should be invoked in this manner. If it doesn't, then it
doesn't care about these memory reservations (and the OS will not be
booted via UEFI either)

So I feel I am missing something here. Perhaps a practical example
would be helpful?


> >
> > ...
> > >
> > > There is no intent to implement the UEFI spec, here. It is simply that
> > > some payloads (EDK2) are used to having this information.
> > >
> > > Imagine splitting EDK2 into two parts, one of which does platform init
> > > and the other which (the payload) boots the OS. The payload wants
> > > information from Platform Init and it needs to be in a devicetree,
> > > since that is what we have chosen for this interface. So to some
> > > extent this is unrelated to whether you have EFI boot services. We
> > > just need to be able to pass the information across the interface.
> > > Note that the user can (without recompilation, etc.) replace the
> > > second part with U-Boot (for example) and it must still work.
> > >
> >
> > OK, so device tree makes sense for this. This is how I implemented the
> > EDK2 port that targets QEMU/mach-virt - it consumes the DT to discover
> > the UART, RTC,, memory, PCI host bridge, etc.
> >
> > But I don't see a use case for a UEFI memory map here.
> >
> >
...
> > >
> > > Here I believe you are talking about booting the kernel in EFI mode,
> > > but that is not the intent of this patch. This is all about things
> > > happening in firmware. Now, if the payload (second) part of the
> > > firmware decides it wants to offer EFI boot services and boot the
> > > kernel via the EFI stub, then it may very well pack this information
> > > (with a few changes) into a system table and make it available to the
> > > kernel stub. But by then this FDT binding is irrelevant, since it has
> > > served its purpose (which, to reiterate, is to facilitate information
> > > passage from platform init to 'payload').
> > >
> >
> > Indeed. As long as this binding is never consumed by the OS, I don't
> > have any objections to it - I just fail to see the point.
>
> OK thanks.
>
> The point is that Platform Init and the payload need to agree about
> where certain things are in memory. It is true that this is coming
> from an EFI context, but that is just an example. Platform Init
> doesn't necessarily know whether its payload is EFI, but may set this
> up for use by the payload, just in case.
>

Platform init can communicate memory reservations to a UEFI payload if
needed, and there is prior art for this.

Platform init *cannot* communicate UEFI specific boot or runtime
reservations in this manner, as this doesn't make sense: either
Platform Init is UEFI and invokes a UEFI payload, in which case the
UEFI spec applies. In other cases, the UEFI memory regions either
don't exist or are irrelevant. The only EFI-agnostic aspect here is
RAM reservation for use by firmware in general, and this does not have
these UEFI semantics and does not need to be framed as such.
