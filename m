Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE527E5890
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjKHOU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjKHOUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:20:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A88B1FC4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:20:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9BCC43397;
        Wed,  8 Nov 2023 14:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699453252;
        bh=E82DmwfH2dcxbs9xwMmLiAaOTn5D4Ow/0Cpeotwv8Tc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rWV9Xw8NQwgrRa5bh7nxobt3EqPIBdZysZTWWrerABqOhIeuc1Jnby1BN2RDe6jSo
         wMC3krMIgAV9h8cHBuiFMh3OnoC3PvFNYfXcFr8asqoC8PUIh9NLWF0HfK/5X9PJna
         FtNp1qyXtzlxe51KM8v9HXKo949wd8TvzBYHFjWrIpr/fJT718UUvyZZYNHdr9Gz87
         lpBiEXfyw04EV1dbr6WISFxIDQcdQfSpYgg7s8OXdUzU7Wl5EHf9NVIujRA8jtvOAS
         4hYRkewHrL2b9sIIiuVIjloxGRyoSp0Rqw3Z1EVhordXWA9/lMH6d3wK30okromWFX
         DblWljL7w3jaw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2c594196344so92025811fa.3;
        Wed, 08 Nov 2023 06:20:51 -0800 (PST)
X-Gm-Message-State: AOJu0YxNzAwn+kyozMipu4tA12kmdCNAdHxh7r8QxGe5Sh4I3n4PM3Zb
        qugjZEhxUfrsFar4RObmLehup1eEX7JbHoVBkGQ=
X-Google-Smtp-Source: AGHT+IF3AlqJpBLUhu1DTarhTz6FDwvlN0RLFjtbhZO/9hXihKmHvPiQC4/ncAP2kR3ROp5UFGC31vCUAe8Gj7r8AZQ=
X-Received: by 2002:a2e:8e3c:0:b0:2c6:eaf8:49ff with SMTP id
 r28-20020a2e8e3c000000b002c6eaf849ffmr1584451ljk.37.1699453250122; Wed, 08
 Nov 2023 06:20:50 -0800 (PST)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org> <20230926194242.2732127-2-sjg@chromium.org>
 <CAPnjgZ0Xf3U1aj32LbU-xiU1AqwnM3JL1F8xX-wZ18oEmg+irw@mail.gmail.com>
 <CAMj1kXEXcX7BkDyfy-6_5Vnch=N+onza-yfWfsVaGLE93h2c+Q@mail.gmail.com>
 <CAPnjgZ2SEby-ndrs=W_afBJH56eqc=-mhp1F1nwkvWks+=B54Q@mail.gmail.com>
 <CAMj1kXED3S+0cq+VT7naBrmWrUwT=HZAaZOBRMv8Ui1Pey1QNQ@mail.gmail.com>
 <CAPnjgZ0LrsJ2_ENTYoBrnyFaH3UKdHs3D2XWY=TzBuBpBoTXZA@mail.gmail.com>
 <CAL_Jsq+DQugkEDESW5wySFbLLN8HNqGDJCio8Wpi6fe0LeHKUA@mail.gmail.com>
 <CAPnjgZ0cmKP5hoGCyQ_Rp8ZQXUVwaPYJMWyidXuOOjMVkDoMDw@mail.gmail.com>
 <CAL_JsqJH=vJ40PNTg_i0LoKA-c0hhMJkL8zCC3_bB-tOkFWWsw@mail.gmail.com>
 <CAPnjgZ1FrdGKjGAxUbkQoL2vHwhC_2Oa2KT+0cm25dQAuAjxAQ@mail.gmail.com>
 <CAPnjgZ19-xR6QxS=fR53skz0VuAty2Z2w2vQTjP7g=tbTFpaqw@mail.gmail.com>
 <CAL_JsqL+X1DatsGk_Cn1HsbG2GV9AngFWXVysWTiNRu_d9tDqw@mail.gmail.com>
 <CAMj1kXHfh40wxerZGjOn2JJ5Skm5C--Rz2jy8p3XZ2UXKGjw+g@mail.gmail.com> <CAL_JsqLpea+FU4gXpaSUSeBP70szJ+mRjJtFei=QW2VoHCFOuA@mail.gmail.com>
In-Reply-To: <CAL_JsqLpea+FU4gXpaSUSeBP70szJ+mRjJtFei=QW2VoHCFOuA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 8 Nov 2023 15:20:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHPVXB2ojzhKbAO47+EDMDzODqjLZ+iOKw=u=Bc7=HPCQ@mail.gmail.com>
Message-ID: <CAMj1kXHPVXB2ojzhKbAO47+EDMDzODqjLZ+iOKw=u=Bc7=HPCQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To:     Rob Herring <robh@kernel.org>
Cc:     Simon Glass <sjg@chromium.org>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dhaval Sharma <dhaval@rivosinc.com>,
        Maximilian Brune <maximilian.brune@9elements.com>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        Guo Dong <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>,
        ron minnich <rminnich@gmail.com>, Gua Guo <gua.guo@intel.com>,
        Chiu Chasel <chasel.chiu@intel.com>,
        linux-acpi@vger.kernel.org,
        U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2023 at 14:57, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Nov 8, 2023 at 5:38=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> w=
rote:
> >
> > On Tue, 7 Nov 2023 at 19:07, Rob Herring <robh@kernel.org> wrote:
> > >
> > >
> > > All of this:
> > >
> >
> > > > On Mon, 16 Oct 2023 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > It is not specific to EDK2. Imagine this boot sequence:
> > > > >
> > > > > - Platform Init (U-Boot) starts up
> > > > > - U-Boot uses its platform knowledge to sets some ACPI tables and=
 put
> > > > > various things in memory
> > > > > - U-Boot sets up some runtime code and data for the OS
> > > > > - U-Boot jumps to the Tianocore payload **
> > > > > - Payload (Tianocore) wants to know where the ACPI tables are, fo=
r example
> > > > > - Tianocore needs to provide boot services to the OS, so needs to=
 know
> > > > > the memory map, etc.
> > > > >
> > > > > ** At this point we want to use DT to pass the required informati=
on.
> > > > >
> > > > > Of course, Platform Init could be coreboot or Tianocore or some
> > > > > strange private binary. Payload could be U-Boot or something else=
.
> > > > > That is the point of this effort, to build interoperability.
> > >
> > > [...]
> > >
> > > > > Perhaps the problem here is that Linux has tied itself up in knot=
s
> > > > > with its EFI stuff and DT fixups and what-not. But this is not th=
at.
> > > > > It is a simple handoff between two pieces of firmware, Platform I=
nit
> > > > > and Payload. It has nothing to do with the OS. With Tianocore the=
y are
> > > > > typically combined, but with this usage they are split, and we ca=
n
> > > > > swap out one project for another on either side of the DT interfa=
ce.
> > >
> > > Is perhaps the clearest description of the problem you want to solve.
> > > It's clearly related to EFI though not the interface to the OS. IIRC,
> > > "platform init" and "payload" are terms in the UEFI spec, right?
> >
> > No they are not. This is from the universal payload specification that
> > is being drafted here
> >
> > https://universalpayload.github.io/spec/index.html
> >
> > but the UEFI specification does not use this terminology.
>
> Then I'm confused as to what this is:
>
> https://uefi.org/specs/PI/1.8/index.html
>

The PI and UEFI specifications are both maintained by the UEFI forum.

The UEFI specification covers external APIs for firmware
implementations, i.e., the OS visible interface and the public API for
UEFI device drivers that are not tightly integrated with system
firmware (for example, the GPU boot time driver in the ROM of an
add-in card)

The UEFI forum's PI spec describes system firmware internals, and
defines the SEC, PEI DXE and BDS boot phases, among other things.

It is possible to implement UEFI without PI (which is what uboot does,
for instance), but Tianocore/EDK2 is the reference implementation for
both PI and UEFI, and sadly, there is no discernible distinction
between the two (e.g., both PI and UEFI use identifiers with EFI_ type
and enum identifier prefixes)

'platform init' in the context of this discussion is something
completely separate, and has zero bearing on the PI<->UEFI handover in
Tianocore (which is not really a handover to begin with).

There is code in Tianocore which allows it to run as a 'payload',
which means [presumably] that only the DXE and subsequent phases are
launched from a 'platform init' component that describes the platform
using some of the DT bindings that are under discussion here. In this
case, I can see how some of the ACPI descriptions provided by the
'platform init' might be inherited by the 'payload'. However, I don't
see how such a Tianocore payload would make meaningful use of
boot/runtime code/data described in general terms using this proposed
binding, which is why I keep asking for an example scenario.
