Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BBD7E55AC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjKHLiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHLis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:38:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67AA198A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 03:38:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A72DC43391;
        Wed,  8 Nov 2023 11:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699443526;
        bh=vGXPlqnsevPIGZEWSM3CikPCEVA3knUIxql8hMIFa+8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UT3W5d5euKmiYSHd8WWdlrXj+43eOfV4an0TzJho8R4LZp7CY1/nNRTrmHCmg2gky
         mMKRJFvTDxdo5U9r3+rydjzYYW572TAs1XERGXtUmO+Ay0rETC3Q1ShYtGZvUKQcJ/
         pjOwWr+JXzcM/0ps6QshVA+MMMb6OdA7fjOSI+og7nsFMIimiLxO/UFqLICbdAgh2s
         0RoXPc06wblhuGeblQJtdFRKKJGksjGxakbkWCqiAA2DEC4kFMF62e/pbD0rhzBoe4
         pmlP4DqiBg/1XWnDVPYvOTX/NC6sXHVsVD5uRgckM/O1mx0CMqkRl7lWITUg5xWkFk
         HnMKT8aAiVHtg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2c50906f941so96932811fa.2;
        Wed, 08 Nov 2023 03:38:46 -0800 (PST)
X-Gm-Message-State: AOJu0Yys9WSg0n5egnz0lKo+rMgazk9YymKU5Zh1MU4WyrLTL/mkfug9
        g1NK5ktVaSqKWZqEkSYmTkwMAzDT4KwjNb+JN9E=
X-Google-Smtp-Source: AGHT+IEQ9bty1WIItGB/rSDnD5+xGDKEJz18MvCqVthKxr2g3hVt1rDXhjwsogoBOkJGa9uGw8Cqpa0oILGNn3aOwmY=
X-Received: by 2002:a2e:ba9e:0:b0:2c5:1e70:7d30 with SMTP id
 a30-20020a2eba9e000000b002c51e707d30mr1324249ljf.30.1699443524688; Wed, 08
 Nov 2023 03:38:44 -0800 (PST)
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
 <CAPnjgZ19-xR6QxS=fR53skz0VuAty2Z2w2vQTjP7g=tbTFpaqw@mail.gmail.com> <CAL_JsqL+X1DatsGk_Cn1HsbG2GV9AngFWXVysWTiNRu_d9tDqw@mail.gmail.com>
In-Reply-To: <CAL_JsqL+X1DatsGk_Cn1HsbG2GV9AngFWXVysWTiNRu_d9tDqw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 8 Nov 2023 12:38:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHfh40wxerZGjOn2JJ5Skm5C--Rz2jy8p3XZ2UXKGjw+g@mail.gmail.com>
Message-ID: <CAMj1kXHfh40wxerZGjOn2JJ5Skm5C--Rz2jy8p3XZ2UXKGjw+g@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 at 19:07, Rob Herring <robh@kernel.org> wrote:
>
>
> All of this:
>

> > On Mon, 16 Oct 2023 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > It is not specific to EDK2. Imagine this boot sequence:
> > >
> > > - Platform Init (U-Boot) starts up
> > > - U-Boot uses its platform knowledge to sets some ACPI tables and put
> > > various things in memory
> > > - U-Boot sets up some runtime code and data for the OS
> > > - U-Boot jumps to the Tianocore payload **
> > > - Payload (Tianocore) wants to know where the ACPI tables are, for example
> > > - Tianocore needs to provide boot services to the OS, so needs to know
> > > the memory map, etc.
> > >
> > > ** At this point we want to use DT to pass the required information.
> > >
> > > Of course, Platform Init could be coreboot or Tianocore or some
> > > strange private binary. Payload could be U-Boot or something else.
> > > That is the point of this effort, to build interoperability.
>
> [...]
>
> > > Perhaps the problem here is that Linux has tied itself up in knots
> > > with its EFI stuff and DT fixups and what-not. But this is not that.
> > > It is a simple handoff between two pieces of firmware, Platform Init
> > > and Payload. It has nothing to do with the OS. With Tianocore they are
> > > typically combined, but with this usage they are split, and we can
> > > swap out one project for another on either side of the DT interface.
>
> Is perhaps the clearest description of the problem you want to solve.
> It's clearly related to EFI though not the interface to the OS. IIRC,
> "platform init" and "payload" are terms in the UEFI spec, right?

No they are not. This is from the universal payload specification that
is being drafted here

https://universalpayload.github.io/spec/index.html

but the UEFI specification does not use this terminology.

> I don't recall how well defined those are vs. just abstract concepts.
>
> Is it only for this interface or any firmware to firmware handoff. If
> the former, then I'm looking for folks involved with EFI/Tianocore to
> have some buy-in. If the latter, then this should be part of the
> firmware handoff efforts and have buy-in there.
>

I still haven't seen any example of how platform init would make
meaningful use of 'boot-code' and 'runtime-code' regions to inform a
payload about executable regions in memory. Especially 'runtime code'
is interesting here, as it presumably means that the OS must map such
regions as executable in some way. This is why I mentioned phandles in
a previous reply: there /must/ be some additional context provided
elsewhere, or the distinction between boot code/data and runtime
code/data is meaningless.

So again, can we *please* have an example of how these regions will be
used in practice?

> > > I do have views on the 'EFI' opt-out with reserved-memory, if you are
> > > interested, but that relates to the OS. If you are wanting to place
> > > some constraints on /reserved-memory and /memory we could do that
> > > e.g. that the DT and the map returned by EFI boot services must be
> > > consistent. But as it is, the nodes are ignored by the OS when booting
> > > with EFI, aren't they?
> >
> > Can this be applied, please? If there are further comments, please let me know.
>
> I really have limited knowledge and interest in this. I don't mind
> hosting something like this in dtschema, but I'm not taking it without
> buy-in from multiple parties which I haven't seen.
>

I will state again that I do not object to these bindings as long as
they are restricted to use in the context of firmware. However, there
is no scoping in DT schema as far as I am aware, which means that the
OS may be forced/expected to interpret these regions beyond simply
disregarding them and treating them as reserved memory, and *that* is
something I strongly object to.
