Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C3F78CCDB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbjH2TS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239981AbjH2TSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:18:38 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7CBFD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:18:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52683b68c2fso6296675a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693336712; x=1693941512; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XY6m0jrM1EIVxXZKsdM96lBHZBbK4+oaifCRdomyQwM=;
        b=ggeAGzDtrtR1fsr0tJrYLFSyK078f2U9HNB0qWWgeRcAKJl3JNzDbNFLA2h0J9LRJ7
         uRstepuCugK11GShKZBnbQ7clCyATthZ/kuUmWiaWBeSAxeuG/yo2aSgLAryBhoKnsA+
         zUWP8bomW03iCb9JppmgDgPWUPKaf7sSBfa1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693336712; x=1693941512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XY6m0jrM1EIVxXZKsdM96lBHZBbK4+oaifCRdomyQwM=;
        b=JOB0+qejB9UrdU/SVQZwUuWYPtrei+tOXfDWyvYr8BhLKP0g/AqMN2pcImt4KgsCae
         6Zh78LwetqGdSv3T0/B9nZ9qGey5gIIwI2J1bLcZ8CiBIVCpZQNxhjG/8LWVMSobur0n
         ymuM+OxZzTIO+uqasOJtMUOsmcFSeZJ3B90VBZGo5GEwFqYTb/vVQ5AhK7wT1S0NrLh4
         FpzFlGrYF6xH3oG17SIR/ZtA/KqvcJIho+lEz1FgBSW6lgWOr4B1uwzMN69+zW26Uxb+
         05BRV+b56HBkIsNi65s96pIDa1IgTVR95T2HoFqH5RWqNrEGfCPgeSEeYlLK6x7vbJWs
         jOPA==
X-Gm-Message-State: AOJu0Yxiwps5AB11qjvP+FoZ9/Twb3aoRvu48QJksq/lGbqUoSzmE/gM
        qOOvEfdB+ipND2558e8Mx5PLWghxEi2uVxmnsIA31g==
X-Google-Smtp-Source: AGHT+IFI+6hIzTjgJuzAa1zO1wGKWDxOAL24PqezgVa4g1DgJpvIb/BqU2ngDxgfIuxCB7U7LzNQnl5VC1qyua0ZTCk=
X-Received: by 2002:aa7:d898:0:b0:522:b929:9f01 with SMTP id
 u24-20020aa7d898000000b00522b9299f01mr195406edq.9.1693336712271; Tue, 29 Aug
 2023 12:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230822203446.4111742-1-sjg@chromium.org> <ZOXKTrC_dzN_hUkY@FVFF77S0Q05N>
 <CAMj1kXEHpRjk_YKOm4czCnnpjqgahj2jV8MMfGLx7b1RdnBnVw@mail.gmail.com>
 <CAPnjgZ1S8G=7eCBF9PcDk4H5sk3AcxSSWXO575jK8SjA9dR8qw@mail.gmail.com> <CAMj1kXH83_TB4S0PL3jswxjCP+907YpgS7FRuVTO3G62s7nn5w@mail.gmail.com>
In-Reply-To: <CAMj1kXH83_TB4S0PL3jswxjCP+907YpgS7FRuVTO3G62s7nn5w@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Tue, 29 Aug 2023 13:17:48 -0600
Message-ID: <CAPnjgZ2kkUt1eOWX8K+EsbjcQZPefNvj5DSaFb9QrvRg0t2h7w@mail.gmail.com>
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

On Thu, 24 Aug 2023 at 03:10, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 23 Aug 2023 at 22:04, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi,
> >
> > On Wed, 23 Aug 2023 at 08:24, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Wed, 23 Aug 2023 at 10:59, Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > On Tue, Aug 22, 2023 at 02:34:42PM -0600, Simon Glass wrote:
> > > > > The Devicetree specification skips over handling of a logical view of
> > > > > the memory map, pointing users to the UEFI specification.
> > > > >
> > > > > It is common to split firmware into 'Platform Init', which does the
> > > > > initial hardware setup and a "Payload" which selects the OS to be booted.
> > > > > Thus an handover interface is required between these two pieces.
> > > > >
> > > > > Where UEFI boot-time services are not available, but UEFI firmware is
> > > > > present on either side of this interface, information about memory usage
> > > > > and attributes must be presented to the "Payload" in some form.
> > >
> > > Not quite.
> > >
> > > This seems to be intended for consumption by Linux booting in ACPI
> > > mode, but not via UEFI, right?
> >
> > Actually, this is for consumption by firmware. The goal is to allow
> > edk2 to boot into U-Boot and vice versa, i.e. provide some
> > interoperability between firmware projects. I will use the "Platform
> > Init" and "Payload" terminology here too.
> >
>
> OK. It was the cc to linux-acpi@ and the authors of the
> ACPI/SMBIOS-without-UEFI patches that threw me off here.
>
> If we are talking about an internal interface for firmware components,
> I'd be inclined to treat this as an implementation detail, as long as
> the OS is not expected to consume these DT nodes.
>
> However, I struggle to see the point of framing this information as a
> 'UEFI memory map'. Neither EDK2 nor u-boot consume this information
> natively, and there is already prior art in both projects to consume
> nodes following the existing bindings for device_type=memory and the
> /reserved-memory node. UEFI runtime memory is generally useless
> without UEFI runtime services, and UEFI boot services memory is just
> free memory.
>
> There is also an overlap with the handover between secure and
> non-secure firmware on arm64, which is also DT based, and communicates
> available memory as well as RAM regions that are reserved for firmware
> use.
>
> In summary, I don't see why a non-UEFI payload would care about UEFI
> semantics for pre-existing memory reservations, or vice versa. Note
> that EDK2 will manage its own memory map, and expose it via UEFI boot
> services and not via DT.

Bear in mind that one or both sides of this interface may be UEFI.
There is no boot-services link between the two parts that I have
outlined.

>
> ...
> >
> > There is no intent to implement the UEFI spec, here. It is simply that
> > some payloads (EDK2) are used to having this information.
> >
> > Imagine splitting EDK2 into two parts, one of which does platform init
> > and the other which (the payload) boots the OS. The payload wants
> > information from Platform Init and it needs to be in a devicetree,
> > since that is what we have chosen for this interface. So to some
> > extent this is unrelated to whether you have EFI boot services. We
> > just need to be able to pass the information across the interface.
> > Note that the user can (without recompilation, etc.) replace the
> > second part with U-Boot (for example) and it must still work.
> >
>
> OK, so device tree makes sense for this. This is how I implemented the
> EDK2 port that targets QEMU/mach-virt - it consumes the DT to discover
> the UART, RTC,, memory, PCI host bridge, etc.
>
> But I don't see a use case for a UEFI memory map here.
>
>
> > >
> > > >
> > > > Today Linux does that by passing:
> > > >
> > > >   /chosen/linux,uefi-mmap-start
> > > >   /chosen/linux,uefi-mmap-size
> > > >   /chosen/linux,uefi-mmap-desc-size
> > > >   /chosen/linux,uefi-mmap-desc-ver
> > > >
> > > > ... or /chosen/xen,* variants of those.
> > > >
> > > > Can't we document / genericise that?
> >
> > That seems to me to be the fields from the EFI memory-map call, but
> > where is the actual content? I looked in the kernel but it seems to be
> > an internal interface (between the stub and the kernel)?
> >
> > > >
> > >
> > > Given the ACPI angle, promoting this to external ABI would introduce a
> > > DT dependency to ACPI boot. So we'll at least have to be very clear
> > > about which takes precedence, or maybe disregard everything except the
> > > /chosen node when doing ACPI boot?
> > >
> > > This also argues for not creating an ordinary binding for this (i.e.,
> > > describing it as part of the platform topology), but putting it under
> > > /chosen as a Linux-only boot tweak.
> > >
> > > > Pointing to that rather than re-encoding it in DT means that it stays in-sync
> > > > with the EFI spec and we won't back ourselves into a corner where we cannot
> > > > encode something due to a structural difference. I don't think it's a good idea
> > > > to try to re-encode it, or we're just setting ourselves up for futher pain.
> > > >
> > >
> > > What I would prefer is to formalize pseudo-EFI boot and define the
> > > bare required minimum (system table + memory map + config tables) in
> > > an arch-agnostic manner. That way, the only thing that needs to be
> > > passed via DT/boot_params/etc is the (pseudo-)EFI system table
> > > address, and everything else (SMBIOS, ACPI as well as the EFI memory
> > > map and even the initrd) can be passed via config tables as usual, all
> > > of which is already supported in (mostly) generic kernel code.
> > >
>
> <snip some lines>
>
> >
> > Here I believe you are talking about booting the kernel in EFI mode,
> > but that is not the intent of this patch. This is all about things
> > happening in firmware. Now, if the payload (second) part of the
> > firmware decides it wants to offer EFI boot services and boot the
> > kernel via the EFI stub, then it may very well pack this information
> > (with a few changes) into a system table and make it available to the
> > kernel stub. But by then this FDT binding is irrelevant, since it has
> > served its purpose (which, to reiterate, is to facilitate information
> > passage from platform init to 'payload').
> >
>
> Indeed. As long as this binding is never consumed by the OS, I don't
> have any objections to it - I just fail to see the point.

OK thanks.

The point is that Platform Init and the payload need to agree about
where certain things are in memory. It is true that this is coming
from an EFI context, but that is just an example. Platform Init
doesn't necessarily know whether its payload is EFI, but may set this
up for use by the payload, just in case.

Regards,
SImon
