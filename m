Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F3078FBE8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 12:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349017AbjIAKs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 06:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjIAKs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:48:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FC510FA;
        Fri,  1 Sep 2023 03:48:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8709CB82455;
        Fri,  1 Sep 2023 10:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325FAC43397;
        Fri,  1 Sep 2023 10:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693565321;
        bh=aNKuBqzCPGhEHPydVh3QzcydeR2Zaxu8zUclUITlkPA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WXAI5gc33pyZwMVObbe1+ua7YYxHxo4ybg1culG+0Cgq2r4jJdQzx9MembEAfhMEi
         4UhIKYYNnJs9pskmR/xU75DjsVa+NLSP9IMeJZ/bVWNB03JD/qvRPpzahMqi11sUvY
         8mKqKlj0jyyalGnQMwRGaA8/GGcSLsv+lcUr0CRe0yZNQMRE6ldOQHfDM7XClzlTmX
         5qOKJw+HUhoaz5Zo/kqgwVdfaq7pgqRxiB62YZhc0ZDHdA5BGvzg43wEgZMXTvw6Pp
         5m6QL4bDqeEdC6IZJGu4npe2vufHqEg9BZtw44kBdzz608LunUS1QoGnqBtq7Fe77y
         0rpNdVc5Q48jg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2bc63e0d8cdso30104591fa.2;
        Fri, 01 Sep 2023 03:48:41 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx+Si2pa0bJx1J1zRRIKrkChB5qIhhnSa2Oh2XfydU2zfQQ/sV5
        JwGECT9lRdV2msYHfc5rvW/wxfygcTDxYTi8pIw=
X-Google-Smtp-Source: AGHT+IErDs+4x3Xy0d+ehTAv3uXd2A7tWxqLdrSlgGsO/iVp4xmOcljKiiLmHIkraV0M1KgowvPV3eNmwBpqMdkhJ1w=
X-Received: by 2002:a2e:8093:0:b0:2ba:8127:a2c3 with SMTP id
 i19-20020a2e8093000000b002ba8127a2c3mr1418052ljg.34.1693565318998; Fri, 01
 Sep 2023 03:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230822203446.4111742-1-sjg@chromium.org> <ZOXKTrC_dzN_hUkY@FVFF77S0Q05N>
 <CAMj1kXEHpRjk_YKOm4czCnnpjqgahj2jV8MMfGLx7b1RdnBnVw@mail.gmail.com>
 <CAPnjgZ1S8G=7eCBF9PcDk4H5sk3AcxSSWXO575jK8SjA9dR8qw@mail.gmail.com>
 <CAMj1kXH83_TB4S0PL3jswxjCP+907YpgS7FRuVTO3G62s7nn5w@mail.gmail.com>
 <CAPnjgZ2kkUt1eOWX8K+EsbjcQZPefNvj5DSaFb9QrvRg0t2h7w@mail.gmail.com>
 <CAMj1kXGe84uaJ9j9ic0V4HC43p7QBoKQ5ssTYd5DMBGtZ3++Jw@mail.gmail.com>
 <CAPnjgZ3L-jGxoXNHnsXY0MXU=jTAN66KNAxSLHPVeHinHMjzkQ@mail.gmail.com>
 <CAMj1kXGw6DGK=gVF3bMH5dp=LL89V9n1V1LMGKDn0CZWGHh8qg@mail.gmail.com>
 <CAPnjgZ1fjee3rf91onPbuLpgqTHe3dZgz0WBSzoiKAabO+ETkQ@mail.gmail.com>
 <CAMj1kXFvLGeXXmyK1wSXLk5yq42f2G3GvBGoN40JF=y4bvCo=Q@mail.gmail.com>
 <CAPnjgZ25VqPCBSZ69fyb+G93=hzS-gX6zVa0J3vYyY49p0CZmw@mail.gmail.com>
 <CAMj1kXGzPHFpjr4-Q5Vwe3TSZWdAumWVL7iYJR76VGQbZUSsEA@mail.gmail.com> <CAPnjgZ29DP_fwwV2bJiSP3zgpL2Q=CYHG1qjOiHyL4FUi895BA@mail.gmail.com>
In-Reply-To: <CAPnjgZ29DP_fwwV2bJiSP3zgpL2Q=CYHG1qjOiHyL4FUi895BA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 1 Sep 2023 12:48:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGk6cH_PeZz_1WbA4ztxF2QHXRvxbLQi4Eh0jW0atO5Ug@mail.gmail.com>
Message-ID: <CAMj1kXGk6cH_PeZz_1WbA4ztxF2QHXRvxbLQi4Eh0jW0atO5Ug@mail.gmail.com>
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

On Fri, 1 Sept 2023 at 03:12, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ard,
>
> On Thu, 31 Aug 2023 at 16:39, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 1 Sept 2023 at 00:17, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ard,
> > >
> > > On Thu, 31 Aug 2023 at 15:48, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Thu, 31 Aug 2023 at 21:03, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Ard,
> > > > >
> > > > > On Thu, 31 Aug 2023 at 06:28, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, 30 Aug 2023 at 23:11, Simon Glass <sjg@chromium.org> wrote:
> > > > > > >
> > > > > > > Hi Ard,
> > > > > > >
> > > > > > > On Tue, 29 Aug 2023 at 15:32, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Tue, 29 Aug 2023 at 21:18, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi Ard,
> > > > > > > > >
> > > > > > > > > On Thu, 24 Aug 2023 at 03:10, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > ...
> > > > > > > > > > In summary, I don't see why a non-UEFI payload would care about UEFI
> > > > > > > > > > semantics for pre-existing memory reservations, or vice versa. Note
> > > > > > > > > > that EDK2 will manage its own memory map, and expose it via UEFI boot
> > > > > > > > > > services and not via DT.
> > > > > > > > >
> > > > > > > > > Bear in mind that one or both sides of this interface may be UEFI.
> > > > > > > > > There is no boot-services link between the two parts that I have
> > > > > > > > > outlined.
> > > > > > > > >
> > > > > > > >
> > > > > > > > I don't understand what this means.
> > > > > > > >
> > > > > > > > UEFI specifies how one component invokes another, and it is not based
> > > > > > > > on a DT binding. If the second component calls UEFI boot or runtime
> > > > > > > > services, it should be invoked in this manner. If it doesn't, then it
> > > > > > > > doesn't care about these memory reservations (and the OS will not be
> > > > > > > > booted via UEFI either)
> > > > > > > >
> > > > > > > > So I feel I am missing something here. Perhaps a practical example
> > > > > > > > would be helpful?
> > > > > > >
> > > > > > > Let's say we want to support these combinations:
> > > > > > >
> > > > > > > Platform Init -> Payload
> > > > > > > --------------------------------
> > > > > > > U-Boot -> Tianocore
> > > > > > > coreboot -> U-Boot
> > > > > > > Tianocore -> U-Boot
> > > > > > > Tianocore -> Tianocore
> > > > > > > U-Boot -> U-Boot
> > > > > > >
> > > > > > > Some of the above things have UEFI interfaces, some don't. But in the
> > > > > > > case of Tianocore -> Tianocore we want things to work as if it were
> > > > > > > Tianocore -> (its own handoff mechanism) Tiancore.
> > > > > > >
> > > > > >
> > > > > > If Tianocore is the payload, it is either implemented as a EFI app, in
> > > > > > which case it has access to EFI services, or it is not, in which case
> > > > > > it doesn't care about UEFI semantics of the existing reserved regions,
> > > > > > and it only needs to know which regions exist and which of those are
> > > > > > reserved.
> > > > > >
> > > > > > And I think the same applies to all other rows in your table: either
> > > > > > the existence of UEFI needs to be carried forward, which needs to be
> > > > > > done via EFI services, or it doesn't, in which case the UEFI specific
> > > > > > reservations can be dropped, and only reserved and available memory is
> > > > > > relevant.
> > > > > >
> > > > > > > Some Platform Init may create runtime code which needs to accessible later.
> > > > > > >
> > > > > >
> > > > > > But not UEFI runtime code, right? If the payload is not UEFI based,
> > > > > > the OS would never be able to call that runtime code unless it is
> > > > > > described in a different, non-UEFI way. This is fine, but it is not
> > > > > > UEFI so we shouldn't call it UEFI runtime memory.
> > > > > >
> > > > > > > The way I think of it is that we need to generalise the memory map a
> > > > > > > bit. Saying that you must use UEFI boot services to discover it is too
> > > > > > > UEFI-specific.
> > > > > > >
> > > > > >
> > > > > > What I am questioning is why a memory map with UEFI semantics is even
> > > > > > relevant when those boot services do not exist.
> > > > > >
> > > > > > Could you be more specific about why a payload would have to be aware
> > > > > > of the existence of UEFI boot/runtime service regions if it does not
> > > > > > consume the UEFI interfaces of the platform init? And if the payload
> > > > > > exposes UEFI services to the OS, why would it consume a memory map
> > > > > > with UEFI semantics rather than a simple list of memblocks and memory
> > > > > > reservations?
> > > > >
> > > > > It seems like you are thinking of the Payload as grub, or something
> > > > > like that? This is not about grub. If there are EFI boot services to
> > > > > be provided, they are provided by the Payload, not Platform Init. I am
> > > > > not that familiar with Tianocore, but if you are, perhaps think of it
> > > > > as splitting Tianocore into two pieces, one of which inits the silicon
> > > > > and the other which provides the EFI boot services.
> > > > >
> > > > > Again, if you are familiar with Tianocore, it can be built either as a
> > > > > monolithic whole, or as a coreboot Payload. The Payload part of the
> > > > > code is (roughly) the same in each case. But the Platform Init is
> > > > > different[1]
> > > > >
> > > >
> > > > I co-maintain OVMF [including the ARM port that I created from
> > > > scratch] as well as the ARM architecture support in Tianocore, along
> > > > with a couple of platform ports for ARM boards, some of which could by
> > > > now be characterized as 'historical' (AMD Seattle, Socionext SynQuacer
> > > > and Raspberry Pi 3/4). So I think I have a pretty good handle on how
> > > > Tianocore based firmware is put together.
> > > >
> > > > Tianocore as a payload will expose boot services to the OS, and will
> > > > provide the OS with a memory map using the UEFI APIs. But you still
> > > > haven't explained why the memory description this Tianocore inherits
> > > > from the Platform Init would include any UEFI boot or runtime service
> > > > regions, or any of the other memory regions with UEFI semantics.
> > > > TIanocore just needs to know a) where memory lives b) which parts of
> > > > it are already in use (as far as the memory map is concerned), and the
> > > > existing bindings suffice for this purpose.
> > > >
> > > > In short, the memory regions with UEFI semantics are created by the
> > > > boot phase that actually exposes UEFI to the OS, in which case the
> > > > boot services can be used to obtain the memory map. If the consumer is
> > > > not UEFI based, there is no reason to bother it with descriptions of
> > > > memory regions that have no significance to it.
> > >
> > > But aren't you assuming that the Payload knows how to handle the
> > > hardware and can implement the runtime services? What if (for example)
> > > powering off the device is hardware-specific and only Platform Init
> > > knows how?
> > >
> >
> > If the payload relies on the platform init for anything, it can use
> > whichever interface those components manage to agree on.
> >
> > If this interface is UEFI, the payload can use UEFI to obtain the memory map.
>
> I think you are still getting mixed up with grub. Platform Init does
> not necessarily provide EFI boot services, even for Tianocore. It is
> the Payload which provides those services. In other words, the second
> half of Tianocore does not use EFI boot services to talk to the first
> half.
>

I might be misunderstanding your examples, as they are somewhat vague
and hypothetical.

Drawing from my experience working on Tianocore, allow me to give a
few examples myself:
- ArmVirtQemu (ARM port of OVMF) receives information about system RAM
via memory nodes in the device tree, using device_type=memory, from
QEMU, which fulfills the role of platform init in this case.
ArmVirtQemu currently doesn't consume the /reserved-memory node as
QEMU does not populate it, but that would be the appropriate place to
document RAM regions that Tianocore must treat as reserved;
- DeveloperBox [0] (based on Socionext SynQuacer) receives a platform
specific struct with memory regions and reservations in a patch of
SRAM that the early Tianocore code uses for stack and heap. Note that
system RAM is not available yet at this point (as it is being
discovered via this mechanism) and SRAM is quite tight, so DT is not
an option here;
- The Tianocore port for Raspberry Pi 4 [1] receives RAM information
from the VideoCore firmware by calling the mailbox interface. This
covers both available memory and reserved memory (for the GPU). The
statically allocated TF-A code and data regions that reside in
non-secure DRAM on this platform are reserved implicitly due to the
fact that they are part of the same firmware image, which knows not to
step on itself.

In none of these cases, I see a need for the binding that you propose.
Platfom Init -> Payload handover is highly platform specific, so
adding another generic DT binding for an as yet unidentified use case
seems seems premature at the very least.

[0] https://github.com/tianocore/edk2-platforms/tree/master/Platform/Socionext/DeveloperBox
[1] https://github.com/tianocore/edk2-platforms/tree/master/Platform/RaspberryPi/RPi4

> >
> > If this interface is not UEFI, the UEFI memory map is irrelevant, and
> > existing DT bindings are available that can describe this information.
>
> Can you please point me to those?
>

The /memory node is documented in the DT specification. The
/reserved-memory node is documented here:

Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml

> >
> > > On another track, would it help if we just dropped all mention of
> > > UEFI? The binding does not mention it.
> > >
> >
> > Your binding has
> >
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
> >
> > Every type listed is derived from a definition in the UEFI spec, which
> > is specifically mentioned as the source.
>
> Yes, but please see the v4 or v5 patch version, where that has
> changed. I sent v4 two days ago. I am worried that you are still
> responding to something that I revised in response to your original
> comments?
>

No, I haven't looked at those yet. Maybe the uboot community is
different, but in the Linux community, we tend to finish discussing vN
of a series before sendindg out vN+1. This prevents the kind of
parallel track discussions that seem to be taking place here. Also, it
is highly appreciated when an author takes all feedback into account
(or at least acknowledges it) in a vN+1 submission, which is difficult
to do before the discussion around vN has concluded.

...
> >
> > But if the Platform Init wants to reserve some system RAM for runtime
> > code (e.g., for its PSCI implementation on ARM), it can add it to the
> > /reserved-memory node, where both the payload and the OS will be able
> > to find it if needed.
>
> OK good. So with my binding that would be 'runtime-code@...'. I am
> still not sure what the problem is here.
>

The problem is that you are not using /reserved-memory to describe a
memory reservation but something new that all DT consumers need to be
taught about, or they might step on memory that turns out to be
reserved. The DT ecosystem is large and heterogeneous, and any tool or
boot stage in existence is at the risk of stepping on this memory
inadvertently, whereas /reserved-memory already provides the means to
reserve it and document its nature.

> >
> > > I'm just not sure that Platform Init and Payload are as completely
> > > independent as you seem to be suggesting. Once we get into the
> > > Payload, the only things we know are what Platform Init told us.
> > >
> >
> > They are not independent, and that is not at all what I am claiming.
> >
> > What I am objecting to is framing the platform init<->payload memory
> > handover in terms of UEFI memory types, which may conflict with well
> > established DT bindings that already serve the same purpose. The only
> > difference between /reserved-memory and this binding seems to be the
> > collection of UEFI memory types, which don't belong there in the first
> > place.
>
> OK, so please help me get this resolved.
>

I have already indicated how this should be resolved in my opinion,
which is by using the /reserved-memory node to describe memory
reservations, and not this binding.
