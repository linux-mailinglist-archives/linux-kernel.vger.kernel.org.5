Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDC77FC248
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345483AbjK1SH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345310AbjK1SH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:07:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3E0B7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:08:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADF9C433CD;
        Tue, 28 Nov 2023 18:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701194883;
        bh=4DwB38wbaKFqe7hUkjoK0KTOX2HU0BmeTqXJcyORlu4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XWiG9o0Dtq787TusZ2eK1KJKrxDR6ZWsvWOUs1UhQwi/EqTGjSVzPy1M+BcivIXz8
         nKM4NnDzVmlPy4d56Q2UCesllUtMPZGL/0QkX7IMNeaphkjFm2UDe7x33QM08aSyNg
         HT+7MRyZ5Ty1ggpvUZ0/+5D4vejZIgr5QVPyS7fPyIAE7W8mxdCvLJL9bT57/U9ZSM
         5KfMaTnpcjctst3YM+476nbFzErxYqznvVsXBJ+2Ovg6wsBotr7yBLXpwoWP9LvQci
         glX1WDuLypxtZc6NAtIkU+q16SZ7p4PwqSyOVYlSslQcaGx7xyqM26ZGNPB+3i2to5
         XGQqVb9QkNvWQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2c9b8363683so9606181fa.3;
        Tue, 28 Nov 2023 10:08:03 -0800 (PST)
X-Gm-Message-State: AOJu0YykdBSVQZeJ/uQbgEdgEgpTbvgOz+fxikU1OYw7/ewtiK8U7EUo
        0Rm4X68zssgfIvKV8SzzOjwwz8QJ5jE4w3mIjgY=
X-Google-Smtp-Source: AGHT+IEMmvfyq0v5/2oBeBE/oqLc1Eu+CJpsjOxQOhU1mp+t/ys+FzWHNt4xUEoc92KVGBiOkt8B0IacbD0oqbAchGI=
X-Received: by 2002:a2e:b0e1:0:b0:2c9:b9db:73 with SMTP id h1-20020a2eb0e1000000b002c9b9db0073mr988987ljl.20.1701194881929;
 Tue, 28 Nov 2023 10:08:01 -0800 (PST)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org> <20230926194242.2732127-2-sjg@chromium.org>
 <BN9PR11MB5483FF3039913334C7EA83E1E6AEA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXFG92NpL7T7YocOup0xLKyopt3MnSCp0RL8cLzozzJz7A@mail.gmail.com>
 <BN9PR11MB548303B09536EB1577472029E6B3A@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAPnjgZ36t8g7E=0MSJyaV8-QKv9RVYe47Jd5E=NU-mFM4LWBQA@mail.gmail.com>
 <CAMj1kXHAEeK7x2f13k_JV3Xcw61nNLasyvXQf+mKwKekQ48EpQ@mail.gmail.com>
 <BN9PR11MB548334E0DA6495C438FBFDE1E6BBA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <BN9PR11MB548314DDE8D4C9503103D51CE6BBA@BN9PR11MB5483.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB548314DDE8D4C9503103D51CE6BBA@BN9PR11MB5483.namprd11.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Nov 2023 19:07:50 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHbM+ArLgNZgnmiok4gOfv6QLYxzyB9OCwfhEkJ2xGK_g@mail.gmail.com>
Message-ID: <CAMj1kXHbM+ArLgNZgnmiok4gOfv6QLYxzyB9OCwfhEkJ2xGK_g@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To:     "Chiu, Chasel" <chasel.chiu@intel.com>
Cc:     Simon Glass <sjg@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        "Tan, Lean Sheng" <sheng.tan@9elements.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dhaval Sharma <dhaval@rivosinc.com>,
        "Brune, Maximilian" <maximilian.brune@9elements.com>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        "Dong, Guo" <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>,
        ron minnich <rminnich@gmail.com>,
        "Guo, Gua" <gua.guo@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You are referring to a 2000 line patch so it is not 100% clear where
to look tbh.


On Tue, 21 Nov 2023 at 19:37, Chiu, Chasel <chasel.chiu@intel.com> wrote:
>
>
> In PR, UefiPayloadPkg/Library/FdtParserLib/FdtParserLib.c, line 268 is for related example code.
>

That refers to a 'memory-allocation' node, right? How does that relate
to the 'reserved-memory' node?

And crucially, how does this clarify in which way "runtime-code" and
"runtime-data" reservations are being used?

Since the very beginning of this discussion, I have been asking
repeatedly for examples that describe the wider context in which these
reservations are used. The "runtime" into runtime-code and
runtime-data means that these regions have a special significance to
the operating system, not just to the next bootloader stage. So I want
to understand exactly why it is necessary to describe these regions in
a way where the operating system might be expected to interpret this
information and act upon it.


>
> > -----Original Message-----
> > From: Chiu, Chasel
> > Sent: Tuesday, November 21, 2023 10:34 AM
> > To: Ard Biesheuvel <ardb@kernel.org>; Simon Glass <sjg@chromium.org>
> > Cc: devicetree@vger.kernel.org; Mark Rutland <mark.rutland@arm.com>; Rob
> > Herring <robh@kernel.org>; Tan, Lean Sheng <sheng.tan@9elements.com>; lkml
> > <linux-kernel@vger.kernel.org>; Dhaval Sharma <dhaval@rivosinc.com>; Brune,
> > Maximilian <maximilian.brune@9elements.com>; Yunhui Cui
> > <cuiyunhui@bytedance.com>; Dong, Guo <guo.dong@intel.com>; Tom Rini
> > <trini@konsulko.com>; ron minnich <rminnich@gmail.com>; Guo, Gua
> > <gua.guo@intel.com>; linux-acpi@vger.kernel.org; U-Boot Mailing List <u-
> > boot@lists.denx.de>; Chiu, Chasel <chasel.chiu@intel.com>
> > Subject: RE: [PATCH v7 2/2] schemas: Add some common reserved-memory
> > usages
> >
> >
> > Hi Ard,
> >
> > Here is the POC PR for your reference:
> > https://github.com/tianocore/edk2/pull/4969/files#diff-
> > ccebabae5274b21634723a2111ee0de11bed6cfe8cb206ef9e263d9c5f926a9cR26
> > 8
> > Please note that this PR is still in early phase and expected to have significant
> > changes.
> >
> > The idea is that payload entry will create gEfiMemoryTypeInformationGuid HOB
> > with payload default memory types and allow FDT to override if correspond node
> > present.
> > Please let me know if you have questions or suggestions.
> >
> > Thanks,
> > Chasel
> >
> >
> > > -----Original Message-----
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > > Sent: Tuesday, November 21, 2023 8:42 AM
> > > To: Simon Glass <sjg@chromium.org>
> > > Cc: Chiu, Chasel <chasel.chiu@intel.com>; devicetree@vger.kernel.org;
> > > Mark Rutland <mark.rutland@arm.com>; Rob Herring <robh@kernel.org>;
> > > Tan, Lean Sheng <sheng.tan@9elements.com>; lkml
> > > <linux-kernel@vger.kernel.org>; Dhaval Sharma <dhaval@rivosinc.com>;
> > > Brune, Maximilian <maximilian.brune@9elements.com>; Yunhui Cui
> > > <cuiyunhui@bytedance.com>; Dong, Guo <guo.dong@intel.com>; Tom Rini
> > > <trini@konsulko.com>; ron minnich <rminnich@gmail.com>; Guo, Gua
> > > <gua.guo@intel.com>; linux- acpi@vger.kernel.org; U-Boot Mailing List
> > > <u-boot@lists.denx.de>
> > > Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory
> > > usages
> > >
> > > On Mon, 20 Nov 2023 at 21:12, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Mon, 13 Nov 2023 at 11:09, Chiu, Chasel <chasel.chiu@intel.com> wrote:
> > > > >
> > > > >
> > > > > Hi Ard,
> > > > >
> > > > > Please see my reply below inline.
> > > > >
> > > > > Thanks,
> > > > > Chasel
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > > > > Sent: Saturday, November 11, 2023 3:04 AM
> > > > > > To: Chiu, Chasel <chasel.chiu@intel.com>
> > > > > > Cc: Simon Glass <sjg@chromium.org>; devicetree@vger.kernel.org;
> > > > > > Mark Rutland <mark.rutland@arm.com>; Rob Herring
> > > > > > <robh@kernel.org>; Tan, Lean Sheng <sheng.tan@9elements.com>;
> > > > > > lkml <linux-kernel@vger.kernel.org>; Dhaval Sharma
> > > > > > <dhaval@rivosinc.com>; Brune, Maximilian
> > > > > > <maximilian.brune@9elements.com>; Yunhui Cui
> > > > > > <cuiyunhui@bytedance.com>; Dong, Guo <guo.dong@intel.com>; Tom
> > > > > > Rini <trini@konsulko.com>; ron minnich <rminnich@gmail.com>;
> > > > > > Guo, Gua <gua.guo@intel.com>; linux- acpi@vger.kernel.org;
> > > > > > U-Boot Mailing List <u-boot@lists.denx.de>
> > > > > > Subject: Re: [PATCH v7 2/2] schemas: Add some common
> > > > > > reserved-memory usages
> > > > > >
> > > > > > On Sat, 11 Nov 2023 at 04:20, Chiu, Chasel <chasel.chiu@intel.com>
> > wrote:
> > > > > > >
> > > > > > >
> > > > > > > Just sharing some usage examples from UEFI/EDK2 scenario.
> > > > > > > To support ACPI S4/Hibernation, memory map must be consistent
> > > > > > > before entering and after resuming from S4, in this case
> > > > > > > payload may need to know previous memory map from bootloader
> > > > > > > (currently generic payload cannot access platform/bootloader
> > > > > > > specific non-volatile data, thus could not save/restore memory
> > > > > > > map
> > > > > > > information)
> > > > > >
> > > > > > So how would EDK2 reconstruct the entire EFI memory map from
> > > > > > just these unannotated /reserved-memory nodes? The EFI memory
> > > > > > map contains much more information than that, and all of it has
> > > > > > to match the pre-hibernate situation, right? Can you given an example?
> > > > >
> > > > >
> > > > > Here we listed only typically memory types that may change cross
> > > > > different
> > > platforms.
> > > > > Reserved memory type already can be handled by reserved-memory
> > > > > node,
> > > and rest of the types usually no need to change cross platforms thus
> > > currently we could rely on default in generic payload.
> > > > > In the future if we see a need to add new memory types we will
> > > > > discuss and
> > > add it to FDT schema.
> > > > >
> > > > >
> > > > >
> > > > > >
> > > > > > > Another usage is to support binary model which generic payload
> > > > > > > is a prebuilt
> > > > > > binary compatible for all platforms/configurations, however the
> > > > > > payload default memory map might not always work for all the
> > > > > > configurations and we want to allow bootloader to override
> > > > > > payload default
> > > memory map without recompiling.
> > > > > > >
> > > > > >
> > > > > > Agreed. But can you explain how a EDK2 payload might make
> > > > > > meaningful use of 'runtime-code' regions provided via DT  by the
> > > > > > non-EDK2 platform init? Can you give an example?
> > > > >
> > > > >
> > > > > Runtime-code/data is used by UEFI payload for booting UEFI OS
> > > > > which
> > > required UEFI runtime services.
> > > > > Platform Init will select some regions from the usable memory and
> > > > > assign it to
> > > runtime-code/data for UPL to consume. Or assign same runtime-code/data
> > > from previous boot.
> > > > > If UEFI OS is not supported, PlatformInit may not need to provide
> > > > > runtime-code/data regions to payload. (always providing
> > > > > runtime-code/data should be supported too)
> > > > >
> > > > >
> > > > > >
> > > > > > > Under below assumption:
> > > > > > >         FDT OS impact has been evaluated and taken care by
> > > > > > > relevant
> > > > > > experts/stakeholders.
> > > > > > > Reviewed-by: Chasel Chiu <chasel.chiu@intel.com>
> > > > > > >
> > > > > >
> > > > > > I am sorry but I don't know what 'FDT OS impact' means. We are
> > > > > > talking about a firmware-to-firmware abstraction that has the
> > > > > > potential to leak into the OS visible interface.
> > > > > >
> > > > > > I am a maintainer in the Tianocore project myself, so it would
> > > > > > help if you could explain who these relevant experts and
> > > > > > stakeholders are. Was this discussed on the edk2-devel mailing
> > > > > > list? If so, apologies for missing it but I may not have been cc'ed perhaps?
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > I'm not familiar with FDT OS, also I do not know if who from
> > > > > edk2-devel were
> > > supporting FDT OS, I think Simon might be able to connect FDT OS
> > > experts/stakeholders.
> > > > > We are mostly focusing on payload firmware phase implementation in
> > > > > edk2 (and other payloads too), however, since we have aligned the
> > > > > payload FDT and OS FDT months ago, I'm assuming FDT OS impact must
> > > > > be there and we need (or already done?) FDT OS experts to support
> > > > > it. (again, maybe Simon could share more information about FDT OS)
> > > > >
> > > > > In edk2 such FDT schema is UefiPayloadPkg internal usage only and
> > > > > payload
> > > entry will convert FDT into HOB thus we expected the most of the edk2
> > > generic code are no-touch/no impact, that's why we only had small
> > > group
> > > (UefiPayloadPkg) discussion.
> > > > > Ard, if you are aware of any edk2 code that's for supporting FDT
> > > > > OS, please let
> > > us know and we can discuss if those code were impacted or not.
> > > >
> > > > We discussed this and just to clarify, 'FDT OS' is not a special OS,
> > > > it is just Linux.
> > > >
> > > > So, with the above, are we all on the same page? Can the patch be
> > > > applied, perhaps? If not, what other discussion is needed?
> > > >
> > >
> > > An example of how a platform-init/payload combination would make
> > > meaningful use of such runtime-code/data regions.
