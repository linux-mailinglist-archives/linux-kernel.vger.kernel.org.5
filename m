Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5678678F4CD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347606AbjHaVsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345373AbjHaVsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:48:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A214B8;
        Thu, 31 Aug 2023 14:48:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE793B8231D;
        Thu, 31 Aug 2023 21:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C43C433C8;
        Thu, 31 Aug 2023 21:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693518488;
        bh=KeVVWWTD17B/6hwPR+f3bpOs1cN39GfXUiKSj9N9f2s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gmoZePOqZQarBaPe2JGo/Num1p7EFrZ+ZGt4ZlR+8hKWNTsnjHtMNN2mOpmuXgvTp
         C0yr0MU2gGCxi0kTwZMlncQH3STiRjXrN0FbHUSQ+WICgcTEyz9kghGFlWkbFJ1SZS
         LXhh4zrQRJ5rYt3BaloFLMu1gkmJr1xXfnUGg2+qxJQ7feKykMpObxoubeTHuKU/+a
         S7Y9PEIv1A3X0KLKJaacW//FfT1dq4LUfpiwbAo9rmMnqItWsdqQhyil+LsnMb2G3B
         edhVAnPalUih/adMWIGWNJdOe+B8v7U1yRg6YlEAKq3+ArzGj0ze02OpUnmMN1bg+k
         wxWyrslBQVcng==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-500bdef7167so3049721e87.0;
        Thu, 31 Aug 2023 14:48:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YylTlZctAirWPrG4P0Rnz19ZiHwYdKYOYmYApmoSrypuSPElRIq
        pTiwhC3LHXRdHaLghBV1aiOsbrxk2A7lL3osWH8=
X-Google-Smtp-Source: AGHT+IHR5q2pesvi36NMoSEfYqkRp/yXUcWlo+ZqPpYi3Vv2mu8r0vmM7L+9kZSDNHjoNC8BFybZ4l8k23PxI8qLHyY=
X-Received: by 2002:a05:6512:3d08:b0:4fe:27a0:68bc with SMTP id
 d8-20020a0565123d0800b004fe27a068bcmr1423708lfv.27.1693518486520; Thu, 31 Aug
 2023 14:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230822203446.4111742-1-sjg@chromium.org> <ZOXKTrC_dzN_hUkY@FVFF77S0Q05N>
 <CAMj1kXEHpRjk_YKOm4czCnnpjqgahj2jV8MMfGLx7b1RdnBnVw@mail.gmail.com>
 <CAPnjgZ1S8G=7eCBF9PcDk4H5sk3AcxSSWXO575jK8SjA9dR8qw@mail.gmail.com>
 <CAMj1kXH83_TB4S0PL3jswxjCP+907YpgS7FRuVTO3G62s7nn5w@mail.gmail.com>
 <CAPnjgZ2kkUt1eOWX8K+EsbjcQZPefNvj5DSaFb9QrvRg0t2h7w@mail.gmail.com>
 <CAMj1kXGe84uaJ9j9ic0V4HC43p7QBoKQ5ssTYd5DMBGtZ3++Jw@mail.gmail.com>
 <CAPnjgZ3L-jGxoXNHnsXY0MXU=jTAN66KNAxSLHPVeHinHMjzkQ@mail.gmail.com>
 <CAMj1kXGw6DGK=gVF3bMH5dp=LL89V9n1V1LMGKDn0CZWGHh8qg@mail.gmail.com> <CAPnjgZ1fjee3rf91onPbuLpgqTHe3dZgz0WBSzoiKAabO+ETkQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ1fjee3rf91onPbuLpgqTHe3dZgz0WBSzoiKAabO+ETkQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 31 Aug 2023 23:47:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFvLGeXXmyK1wSXLk5yq42f2G3GvBGoN40JF=y4bvCo=Q@mail.gmail.com>
Message-ID: <CAMj1kXFvLGeXXmyK1wSXLk5yq42f2G3GvBGoN40JF=y4bvCo=Q@mail.gmail.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 21:03, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ard,
>
> On Thu, 31 Aug 2023 at 06:28, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 30 Aug 2023 at 23:11, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ard,
> > >
> > > On Tue, 29 Aug 2023 at 15:32, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Tue, 29 Aug 2023 at 21:18, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Ard,
> > > > >
> > > > > On Thu, 24 Aug 2023 at 03:10, Ard Biesheuvel <ardb@kernel.org> wrote:
> > ...
> > > > > > In summary, I don't see why a non-UEFI payload would care about UEFI
> > > > > > semantics for pre-existing memory reservations, or vice versa. Note
> > > > > > that EDK2 will manage its own memory map, and expose it via UEFI boot
> > > > > > services and not via DT.
> > > > >
> > > > > Bear in mind that one or both sides of this interface may be UEFI.
> > > > > There is no boot-services link between the two parts that I have
> > > > > outlined.
> > > > >
> > > >
> > > > I don't understand what this means.
> > > >
> > > > UEFI specifies how one component invokes another, and it is not based
> > > > on a DT binding. If the second component calls UEFI boot or runtime
> > > > services, it should be invoked in this manner. If it doesn't, then it
> > > > doesn't care about these memory reservations (and the OS will not be
> > > > booted via UEFI either)
> > > >
> > > > So I feel I am missing something here. Perhaps a practical example
> > > > would be helpful?
> > >
> > > Let's say we want to support these combinations:
> > >
> > > Platform Init -> Payload
> > > --------------------------------
> > > U-Boot -> Tianocore
> > > coreboot -> U-Boot
> > > Tianocore -> U-Boot
> > > Tianocore -> Tianocore
> > > U-Boot -> U-Boot
> > >
> > > Some of the above things have UEFI interfaces, some don't. But in the
> > > case of Tianocore -> Tianocore we want things to work as if it were
> > > Tianocore -> (its own handoff mechanism) Tiancore.
> > >
> >
> > If Tianocore is the payload, it is either implemented as a EFI app, in
> > which case it has access to EFI services, or it is not, in which case
> > it doesn't care about UEFI semantics of the existing reserved regions,
> > and it only needs to know which regions exist and which of those are
> > reserved.
> >
> > And I think the same applies to all other rows in your table: either
> > the existence of UEFI needs to be carried forward, which needs to be
> > done via EFI services, or it doesn't, in which case the UEFI specific
> > reservations can be dropped, and only reserved and available memory is
> > relevant.
> >
> > > Some Platform Init may create runtime code which needs to accessible later.
> > >
> >
> > But not UEFI runtime code, right? If the payload is not UEFI based,
> > the OS would never be able to call that runtime code unless it is
> > described in a different, non-UEFI way. This is fine, but it is not
> > UEFI so we shouldn't call it UEFI runtime memory.
> >
> > > The way I think of it is that we need to generalise the memory map a
> > > bit. Saying that you must use UEFI boot services to discover it is too
> > > UEFI-specific.
> > >
> >
> > What I am questioning is why a memory map with UEFI semantics is even
> > relevant when those boot services do not exist.
> >
> > Could you be more specific about why a payload would have to be aware
> > of the existence of UEFI boot/runtime service regions if it does not
> > consume the UEFI interfaces of the platform init? And if the payload
> > exposes UEFI services to the OS, why would it consume a memory map
> > with UEFI semantics rather than a simple list of memblocks and memory
> > reservations?
>
> It seems like you are thinking of the Payload as grub, or something
> like that? This is not about grub. If there are EFI boot services to
> be provided, they are provided by the Payload, not Platform Init. I am
> not that familiar with Tianocore, but if you are, perhaps think of it
> as splitting Tianocore into two pieces, one of which inits the silicon
> and the other which provides the EFI boot services.
>
> Again, if you are familiar with Tianocore, it can be built either as a
> monolithic whole, or as a coreboot Payload. The Payload part of the
> code is (roughly) the same in each case. But the Platform Init is
> different[1]
>

I co-maintain OVMF [including the ARM port that I created from
scratch] as well as the ARM architecture support in Tianocore, along
with a couple of platform ports for ARM boards, some of which could by
now be characterized as 'historical' (AMD Seattle, Socionext SynQuacer
and Raspberry Pi 3/4). So I think I have a pretty good handle on how
Tianocore based firmware is put together.

Tianocore as a payload will expose boot services to the OS, and will
provide the OS with a memory map using the UEFI APIs. But you still
haven't explained why the memory description this Tianocore inherits
from the Platform Init would include any UEFI boot or runtime service
regions, or any of the other memory regions with UEFI semantics.
TIanocore just needs to know a) where memory lives b) which parts of
it are already in use (as far as the memory map is concerned), and the
existing bindings suffice for this purpose.

In short, the memory regions with UEFI semantics are created by the
boot phase that actually exposes UEFI to the OS, in which case the
boot services can be used to obtain the memory map. If the consumer is
not UEFI based, there is no reason to bother it with descriptions of
memory regions that have no significance to it.

> >
> > Again, I am inclined to treat this as a firmware implementation
> > detail, and the OS must never consume this binding. But I am still
> > puzzled about what exact purpose it is expected to serve.
>
> It really is purely so we can mix and match Platform Init (perhaps
> silicon init is a more familiar term?) and the Payload.
>

That part is clear to me.

> [1] Of course, coreboot uses blobs which are chunks of UEFI, but that
> is a separate issue

I suppose you are referring to the proprietary FSP components? Those
are mostly made up of PEIMs (in Tianocore/EDK2 speak) for DDR training
and chipset initialization, and don't really take part in the
implementation of the UEFI APIs. Strictly, they are not 'chunks of
UEFI' but 'chunks of PI' (but even Tianocore itself, being the
reference implementation of both UEFI and PI, does a terrible job at
distinguishing between the two)
