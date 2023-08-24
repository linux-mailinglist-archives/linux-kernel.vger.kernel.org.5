Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6106786B36
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbjHXJKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbjHXJKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:10:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAE710FA;
        Thu, 24 Aug 2023 02:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 707C566868;
        Thu, 24 Aug 2023 09:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD22FC433CC;
        Thu, 24 Aug 2023 09:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692868216;
        bh=7M2xqO1AKiy66zJXRZ//i4wSn+wQl5CkWQs5eGyEols=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UaCn6ZVe225sX5NaZDcDs9oSE1RypLFGbrd8IvEqX4ijSeAmZ3YzLv8gd6qDnummg
         /puBieqcwhAOmigju3arMX+WbVhSc4LDyRHBbP0gNmiyyC7PrBwbD00OKN9C0P7KS/
         9jqBwNUBLvwfKT6JWK5dQNDp7w4k9EiDq062stg9C2K/Acxy0uFEfq+geEWBkOtvUm
         uTZOGlyET1LWblPQDHjvi7HWVLKiBfZ/zk/lWUDUYdmIH8Rj6l9vgLHp9HpkpKREm1
         SuDKv2dc7jNF1S9WJEuw2SL/qIiyxQc3ZylVWFortxNwHyAwPjzjC/BODaAgtPr0CS
         BiB5qCY5rXIKg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4fe8c16c1b4so10007586e87.2;
        Thu, 24 Aug 2023 02:10:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YzBQjvfjskzy+ei6I7l3x8C9QHkqPpEZRcli6RBX1Hx+33Gd2qB
        gDX3wziFxF7gACVbLNlDo8J8FDHlHemfO/dsJgg=
X-Google-Smtp-Source: AGHT+IEPbWrWaIcRd6K499nFrbiiTHWR7hUuTXAc8g5hvMnTaZ9GhrUD90DQzmZfscTZhkyjTgykTwhlMpySKF6Ohhc=
X-Received: by 2002:a05:6512:2208:b0:4ff:74e2:4268 with SMTP id
 h8-20020a056512220800b004ff74e24268mr13170713lfu.56.1692868214708; Thu, 24
 Aug 2023 02:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230822203446.4111742-1-sjg@chromium.org> <ZOXKTrC_dzN_hUkY@FVFF77S0Q05N>
 <CAMj1kXEHpRjk_YKOm4czCnnpjqgahj2jV8MMfGLx7b1RdnBnVw@mail.gmail.com> <CAPnjgZ1S8G=7eCBF9PcDk4H5sk3AcxSSWXO575jK8SjA9dR8qw@mail.gmail.com>
In-Reply-To: <CAPnjgZ1S8G=7eCBF9PcDk4H5sk3AcxSSWXO575jK8SjA9dR8qw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 24 Aug 2023 11:10:03 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH83_TB4S0PL3jswxjCP+907YpgS7FRuVTO3G62s7nn5w@mail.gmail.com>
Message-ID: <CAMj1kXH83_TB4S0PL3jswxjCP+907YpgS7FRuVTO3G62s7nn5w@mail.gmail.com>
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

On Wed, 23 Aug 2023 at 22:04, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Wed, 23 Aug 2023 at 08:24, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 23 Aug 2023 at 10:59, Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Tue, Aug 22, 2023 at 02:34:42PM -0600, Simon Glass wrote:
> > > > The Devicetree specification skips over handling of a logical view of
> > > > the memory map, pointing users to the UEFI specification.
> > > >
> > > > It is common to split firmware into 'Platform Init', which does the
> > > > initial hardware setup and a "Payload" which selects the OS to be booted.
> > > > Thus an handover interface is required between these two pieces.
> > > >
> > > > Where UEFI boot-time services are not available, but UEFI firmware is
> > > > present on either side of this interface, information about memory usage
> > > > and attributes must be presented to the "Payload" in some form.
> >
> > Not quite.
> >
> > This seems to be intended for consumption by Linux booting in ACPI
> > mode, but not via UEFI, right?
>
> Actually, this is for consumption by firmware. The goal is to allow
> edk2 to boot into U-Boot and vice versa, i.e. provide some
> interoperability between firmware projects. I will use the "Platform
> Init" and "Payload" terminology here too.
>

OK. It was the cc to linux-acpi@ and the authors of the
ACPI/SMBIOS-without-UEFI patches that threw me off here.

If we are talking about an internal interface for firmware components,
I'd be inclined to treat this as an implementation detail, as long as
the OS is not expected to consume these DT nodes.

However, I struggle to see the point of framing this information as a
'UEFI memory map'. Neither EDK2 nor u-boot consume this information
natively, and there is already prior art in both projects to consume
nodes following the existing bindings for device_type=memory and the
/reserved-memory node. UEFI runtime memory is generally useless
without UEFI runtime services, and UEFI boot services memory is just
free memory.

There is also an overlap with the handover between secure and
non-secure firmware on arm64, which is also DT based, and communicates
available memory as well as RAM regions that are reserved for firmware
use.

In summary, I don't see why a non-UEFI payload would care about UEFI
semantics for pre-existing memory reservations, or vice versa. Note
that EDK2 will manage its own memory map, and expose it via UEFI boot
services and not via DT.

...
>
> There is no intent to implement the UEFI spec, here. It is simply that
> some payloads (EDK2) are used to having this information.
>
> Imagine splitting EDK2 into two parts, one of which does platform init
> and the other which (the payload) boots the OS. The payload wants
> information from Platform Init and it needs to be in a devicetree,
> since that is what we have chosen for this interface. So to some
> extent this is unrelated to whether you have EFI boot services. We
> just need to be able to pass the information across the interface.
> Note that the user can (without recompilation, etc.) replace the
> second part with U-Boot (for example) and it must still work.
>

OK, so device tree makes sense for this. This is how I implemented the
EDK2 port that targets QEMU/mach-virt - it consumes the DT to discover
the UART, RTC,, memory, PCI host bridge, etc.

But I don't see a use case for a UEFI memory map here.


> >
> > >
> > > Today Linux does that by passing:
> > >
> > >   /chosen/linux,uefi-mmap-start
> > >   /chosen/linux,uefi-mmap-size
> > >   /chosen/linux,uefi-mmap-desc-size
> > >   /chosen/linux,uefi-mmap-desc-ver
> > >
> > > ... or /chosen/xen,* variants of those.
> > >
> > > Can't we document / genericise that?
>
> That seems to me to be the fields from the EFI memory-map call, but
> where is the actual content? I looked in the kernel but it seems to be
> an internal interface (between the stub and the kernel)?
>
> > >
> >
> > Given the ACPI angle, promoting this to external ABI would introduce a
> > DT dependency to ACPI boot. So we'll at least have to be very clear
> > about which takes precedence, or maybe disregard everything except the
> > /chosen node when doing ACPI boot?
> >
> > This also argues for not creating an ordinary binding for this (i.e.,
> > describing it as part of the platform topology), but putting it under
> > /chosen as a Linux-only boot tweak.
> >
> > > Pointing to that rather than re-encoding it in DT means that it stays in-sync
> > > with the EFI spec and we won't back ourselves into a corner where we cannot
> > > encode something due to a structural difference. I don't think it's a good idea
> > > to try to re-encode it, or we're just setting ourselves up for futher pain.
> > >
> >
> > What I would prefer is to formalize pseudo-EFI boot and define the
> > bare required minimum (system table + memory map + config tables) in
> > an arch-agnostic manner. That way, the only thing that needs to be
> > passed via DT/boot_params/etc is the (pseudo-)EFI system table
> > address, and everything else (SMBIOS, ACPI as well as the EFI memory
> > map and even the initrd) can be passed via config tables as usual, all
> > of which is already supported in (mostly) generic kernel code.
> >

<snip some lines>

>
> Here I believe you are talking about booting the kernel in EFI mode,
> but that is not the intent of this patch. This is all about things
> happening in firmware. Now, if the payload (second) part of the
> firmware decides it wants to offer EFI boot services and boot the
> kernel via the EFI stub, then it may very well pack this information
> (with a few changes) into a system table and make it available to the
> kernel stub. But by then this FDT binding is irrelevant, since it has
> served its purpose (which, to reiterate, is to facilitate information
> passage from platform init to 'payload').
>

Indeed. As long as this binding is never consumed by the OS, I don't
have any objections to it - I just fail to see the point.
