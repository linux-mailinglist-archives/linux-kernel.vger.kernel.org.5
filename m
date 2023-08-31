Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11EF78ED10
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346241AbjHaM2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjHaM2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:28:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42297CDB;
        Thu, 31 Aug 2023 05:28:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFC8BB82288;
        Thu, 31 Aug 2023 12:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F28C433CC;
        Thu, 31 Aug 2023 12:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693484926;
        bh=Vyak1dTXZ6H1ELH2V6tR0Berxj+Mh0hnmpnrgiYOi4A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q1vNqyifUgY4lrK/jaUT18rHZBA7ZouBEtmNsHQrf/SAjjjQuQjLXKbwAsxSI9u/p
         666GulrypEJKTm7gSCZINhrAB2IQXEZTDf4ln8oQ367RsqpBnuzXgU0TQT1r2zYCed
         uUnPgTwPOra/Q6faCjIwmLori4K0rresH6Q6CbQIbrP1UfINp01kdKl0++ck5MQbRk
         BDfe1zXfiNC35th+hz6rypABL3mUyf8Bhvg+R/z4G0YUS17PYvP0iml8ae0pnNw9bD
         pdlkfQbsqCdmwFmN5iYRskkat7qDnWnIQo8Xu4rHa47FUghBSOEh4EA29OUE/pUeki
         bDclJWwmEk8jA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-500bbe3ef0eso842035e87.1;
        Thu, 31 Aug 2023 05:28:46 -0700 (PDT)
X-Gm-Message-State: AOJu0YwyZ1xpZkXl4wbHwvJfkvSBsC4ch/T04sSvCWY9Y60u9uko22JP
        5kK0XyuhvBSxEvDI5eHL/cwDtmQ5VwsnaWpUxD4=
X-Google-Smtp-Source: AGHT+IEt6ssTLnEZQPql8uv0e9cCMN2qYBu4GX0LcJsKO+irQC/odNOUf2HHFRys9I3941ggRp0B4CR23/MLwZcdE20=
X-Received: by 2002:a05:6512:ba9:b0:500:8676:aa7f with SMTP id
 b41-20020a0565120ba900b005008676aa7fmr819687lfv.23.1693484924436; Thu, 31 Aug
 2023 05:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230822203446.4111742-1-sjg@chromium.org> <ZOXKTrC_dzN_hUkY@FVFF77S0Q05N>
 <CAMj1kXEHpRjk_YKOm4czCnnpjqgahj2jV8MMfGLx7b1RdnBnVw@mail.gmail.com>
 <CAPnjgZ1S8G=7eCBF9PcDk4H5sk3AcxSSWXO575jK8SjA9dR8qw@mail.gmail.com>
 <CAMj1kXH83_TB4S0PL3jswxjCP+907YpgS7FRuVTO3G62s7nn5w@mail.gmail.com>
 <CAPnjgZ2kkUt1eOWX8K+EsbjcQZPefNvj5DSaFb9QrvRg0t2h7w@mail.gmail.com>
 <CAMj1kXGe84uaJ9j9ic0V4HC43p7QBoKQ5ssTYd5DMBGtZ3++Jw@mail.gmail.com> <CAPnjgZ3L-jGxoXNHnsXY0MXU=jTAN66KNAxSLHPVeHinHMjzkQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ3L-jGxoXNHnsXY0MXU=jTAN66KNAxSLHPVeHinHMjzkQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 31 Aug 2023 14:28:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGw6DGK=gVF3bMH5dp=LL89V9n1V1LMGKDn0CZWGHh8qg@mail.gmail.com>
Message-ID: <CAMj1kXGw6DGK=gVF3bMH5dp=LL89V9n1V1LMGKDn0CZWGHh8qg@mail.gmail.com>
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

On Wed, 30 Aug 2023 at 23:11, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ard,
>
> On Tue, 29 Aug 2023 at 15:32, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Tue, 29 Aug 2023 at 21:18, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ard,
> > >
> > > On Thu, 24 Aug 2023 at 03:10, Ard Biesheuvel <ardb@kernel.org> wrote:
...
> > > > In summary, I don't see why a non-UEFI payload would care about UEFI
> > > > semantics for pre-existing memory reservations, or vice versa. Note
> > > > that EDK2 will manage its own memory map, and expose it via UEFI boot
> > > > services and not via DT.
> > >
> > > Bear in mind that one or both sides of this interface may be UEFI.
> > > There is no boot-services link between the two parts that I have
> > > outlined.
> > >
> >
> > I don't understand what this means.
> >
> > UEFI specifies how one component invokes another, and it is not based
> > on a DT binding. If the second component calls UEFI boot or runtime
> > services, it should be invoked in this manner. If it doesn't, then it
> > doesn't care about these memory reservations (and the OS will not be
> > booted via UEFI either)
> >
> > So I feel I am missing something here. Perhaps a practical example
> > would be helpful?
>
> Let's say we want to support these combinations:
>
> Platform Init -> Payload
> --------------------------------
> U-Boot -> Tianocore
> coreboot -> U-Boot
> Tianocore -> U-Boot
> Tianocore -> Tianocore
> U-Boot -> U-Boot
>
> Some of the above things have UEFI interfaces, some don't. But in the
> case of Tianocore -> Tianocore we want things to work as if it were
> Tianocore -> (its own handoff mechanism) Tiancore.
>

If Tianocore is the payload, it is either implemented as a EFI app, in
which case it has access to EFI services, or it is not, in which case
it doesn't care about UEFI semantics of the existing reserved regions,
and it only needs to know which regions exist and which of those are
reserved.

And I think the same applies to all other rows in your table: either
the existence of UEFI needs to be carried forward, which needs to be
done via EFI services, or it doesn't, in which case the UEFI specific
reservations can be dropped, and only reserved and available memory is
relevant.

> Some Platform Init may create runtime code which needs to accessible later.
>

But not UEFI runtime code, right? If the payload is not UEFI based,
the OS would never be able to call that runtime code unless it is
described in a different, non-UEFI way. This is fine, but it is not
UEFI so we shouldn't call it UEFI runtime memory.

> The way I think of it is that we need to generalise the memory map a
> bit. Saying that you must use UEFI boot services to discover it is too
> UEFI-specific.
>

What I am questioning is why a memory map with UEFI semantics is even
relevant when those boot services do not exist.

Could you be more specific about why a payload would have to be aware
of the existence of UEFI boot/runtime service regions if it does not
consume the UEFI interfaces of the platform init? And if the payload
exposes UEFI services to the OS, why would it consume a memory map
with UEFI semantics rather than a simple list of memblocks and memory
reservations?

Again, I am inclined to treat this as a firmware implementation
detail, and the OS must never consume this binding. But I am still
puzzled about what exact purpose it is expected to serve.
