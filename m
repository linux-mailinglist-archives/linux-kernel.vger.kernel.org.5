Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D9978F306
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347110AbjHaTD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240348AbjHaTD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:03:28 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C672E67
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:03:24 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d743a5fe05aso902631276.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693508604; x=1694113404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0mQPB8XxUb5OP/KXE1oeSlmWSBTEOE9Ge4MhauaXzcU=;
        b=X8tpNHEyhugJur8VoEnXX15d6uACX4Fc6QPRIYjSFXAq9Cy/XbpWerbBC7YsgolaWx
         V7hk4soqAqKQAU5Q8etE+CNPV6OhBdFrDsc519KVmWhPXaCgpeDfwJlNZ9v2L4NiONsQ
         MQl8t33m52L6uT7G50UfanvYa7QgIzpqAqSXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693508604; x=1694113404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mQPB8XxUb5OP/KXE1oeSlmWSBTEOE9Ge4MhauaXzcU=;
        b=ZcVplYvoETw81yw87x1XWizy0C5bYTZHSADF5yRv/bviX/2yeaDxYOCpR7TRmFolIU
         zmXNJWABV+1cCrYi4Ix++pub8qRChJ2OTT/s+4INFk1d3fuupsYKnAX4OYD3keuknHJl
         8br0iNM0EzVep8thy9B9vldXOocxN+Q8vo5Y2tcX3ae2uPXaGvTHBdBiVyLbPLGDS3HH
         5blS2LAFI0KAY0S5ibjnXqNWR8feYO+txuTuxf0UdeXJCCD9w7jz28FElOh4lyNMvxR3
         CleGu762qypxN1gJON3bBzOAQDqZxzgW7YwO5zlDEwG2VMby/RthYa7LVwq8GGFL1J4G
         vZ1A==
X-Gm-Message-State: AOJu0YwUygBOR/AoxIZ1V2QYN9no9wB957xl6owT289Fymb4PVWAYGif
        rc9pzhVVWU/9HDk4yKTEG3euE0bnqSjkpmi4gmoCqA==
X-Google-Smtp-Source: AGHT+IFgK3CYg/SLq61wmdqsP6GkeNlwlUUqSxXvTpLJ9zbWqnbqaeeme9BcbxPZX+EdxGR7aKxWcikWGBuh/0Fvn1M=
X-Received: by 2002:a25:cf12:0:b0:d7e:3db3:da2c with SMTP id
 f18-20020a25cf12000000b00d7e3db3da2cmr611334ybg.43.1693508603480; Thu, 31 Aug
 2023 12:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230822203446.4111742-1-sjg@chromium.org> <ZOXKTrC_dzN_hUkY@FVFF77S0Q05N>
 <CAMj1kXEHpRjk_YKOm4czCnnpjqgahj2jV8MMfGLx7b1RdnBnVw@mail.gmail.com>
 <CAPnjgZ1S8G=7eCBF9PcDk4H5sk3AcxSSWXO575jK8SjA9dR8qw@mail.gmail.com>
 <CAMj1kXH83_TB4S0PL3jswxjCP+907YpgS7FRuVTO3G62s7nn5w@mail.gmail.com>
 <CAPnjgZ2kkUt1eOWX8K+EsbjcQZPefNvj5DSaFb9QrvRg0t2h7w@mail.gmail.com>
 <CAMj1kXGe84uaJ9j9ic0V4HC43p7QBoKQ5ssTYd5DMBGtZ3++Jw@mail.gmail.com>
 <CAPnjgZ3L-jGxoXNHnsXY0MXU=jTAN66KNAxSLHPVeHinHMjzkQ@mail.gmail.com> <CAMj1kXGw6DGK=gVF3bMH5dp=LL89V9n1V1LMGKDn0CZWGHh8qg@mail.gmail.com>
In-Reply-To: <CAMj1kXGw6DGK=gVF3bMH5dp=LL89V9n1V1LMGKDn0CZWGHh8qg@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Thu, 31 Aug 2023 13:02:05 -0600
Message-ID: <CAPnjgZ1fjee3rf91onPbuLpgqTHe3dZgz0WBSzoiKAabO+ETkQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Thu, 31 Aug 2023 at 06:28, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 30 Aug 2023 at 23:11, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ard,
> >
> > On Tue, 29 Aug 2023 at 15:32, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Tue, 29 Aug 2023 at 21:18, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ard,
> > > >
> > > > On Thu, 24 Aug 2023 at 03:10, Ard Biesheuvel <ardb@kernel.org> wrote:
> ...
> > > > > In summary, I don't see why a non-UEFI payload would care about UEFI
> > > > > semantics for pre-existing memory reservations, or vice versa. Note
> > > > > that EDK2 will manage its own memory map, and expose it via UEFI boot
> > > > > services and not via DT.
> > > >
> > > > Bear in mind that one or both sides of this interface may be UEFI.
> > > > There is no boot-services link between the two parts that I have
> > > > outlined.
> > > >
> > >
> > > I don't understand what this means.
> > >
> > > UEFI specifies how one component invokes another, and it is not based
> > > on a DT binding. If the second component calls UEFI boot or runtime
> > > services, it should be invoked in this manner. If it doesn't, then it
> > > doesn't care about these memory reservations (and the OS will not be
> > > booted via UEFI either)
> > >
> > > So I feel I am missing something here. Perhaps a practical example
> > > would be helpful?
> >
> > Let's say we want to support these combinations:
> >
> > Platform Init -> Payload
> > --------------------------------
> > U-Boot -> Tianocore
> > coreboot -> U-Boot
> > Tianocore -> U-Boot
> > Tianocore -> Tianocore
> > U-Boot -> U-Boot
> >
> > Some of the above things have UEFI interfaces, some don't. But in the
> > case of Tianocore -> Tianocore we want things to work as if it were
> > Tianocore -> (its own handoff mechanism) Tiancore.
> >
>
> If Tianocore is the payload, it is either implemented as a EFI app, in
> which case it has access to EFI services, or it is not, in which case
> it doesn't care about UEFI semantics of the existing reserved regions,
> and it only needs to know which regions exist and which of those are
> reserved.
>
> And I think the same applies to all other rows in your table: either
> the existence of UEFI needs to be carried forward, which needs to be
> done via EFI services, or it doesn't, in which case the UEFI specific
> reservations can be dropped, and only reserved and available memory is
> relevant.
>
> > Some Platform Init may create runtime code which needs to accessible later.
> >
>
> But not UEFI runtime code, right? If the payload is not UEFI based,
> the OS would never be able to call that runtime code unless it is
> described in a different, non-UEFI way. This is fine, but it is not
> UEFI so we shouldn't call it UEFI runtime memory.
>
> > The way I think of it is that we need to generalise the memory map a
> > bit. Saying that you must use UEFI boot services to discover it is too
> > UEFI-specific.
> >
>
> What I am questioning is why a memory map with UEFI semantics is even
> relevant when those boot services do not exist.
>
> Could you be more specific about why a payload would have to be aware
> of the existence of UEFI boot/runtime service regions if it does not
> consume the UEFI interfaces of the platform init? And if the payload
> exposes UEFI services to the OS, why would it consume a memory map
> with UEFI semantics rather than a simple list of memblocks and memory
> reservations?

It seems like you are thinking of the Payload as grub, or something
like that? This is not about grub. If there are EFI boot services to
be provided, they are provided by the Payload, not Platform Init. I am
not that familiar with Tianocore, but if you are, perhaps think of it
as splitting Tianocore into two pieces, one of which inits the silicon
and the other which provides the EFI boot services.

Again, if you are familiar with Tianocore, it can be built either as a
monolithic whole, or as a coreboot Payload. The Payload part of the
code is (roughly) the same in each case. But the Platform Init is
different[1]

>
> Again, I am inclined to treat this as a firmware implementation
> detail, and the OS must never consume this binding. But I am still
> puzzled about what exact purpose it is expected to serve.

It really is purely so we can mix and match Platform Init (perhaps
silicon init is a more familiar term?) and the Payload.

Regards,
Simon

[1] Of course, coreboot uses blobs which are chunks of UEFI, but that
is a separate issue
