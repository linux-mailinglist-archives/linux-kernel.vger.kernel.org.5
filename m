Return-Path: <linux-kernel+bounces-27466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF1D82F096
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56EBF1C23505
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644A51BF38;
	Tue, 16 Jan 2024 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuR9v4gA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347E5EADF;
	Tue, 16 Jan 2024 14:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C982C433B2;
	Tue, 16 Jan 2024 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705415710;
	bh=zaijGVATmy6GzChHiiK8uSOo+YHOgSEKUtwLiX427Fg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TuR9v4gAJ3BdvTrCIO1Gwm1YdvK2IK2MYf5qjlOdra7K3hhCZuY4L0nO9aOXaD0Ev
	 jSB7ThFlG9PenmRKCX1uArnaAHc/30P6YOHq3A/DtLWj99Ki4GygKfJInlAa8FM9ie
	 zgSkSnRlgakLrBegiyneYGlPETKDpc4+1hT9ITicxyticqd2HuMLOFkXqMspRor/Oc
	 N+AUAu3AvMPb68BeU+6d9JZcS85gFF16aLsczmyvnR7Xx3EejwuuQgHeY8+wrnlRtu
	 0sLrjTmk1/gqk/MCSrq9JXbOP0GuZk5Gs6ZoztFAFg5/r1S4Hct3Rk0rEW/Rqz8K9S
	 cRpXwhX7/ZpWA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cd46e7ae8fso109517401fa.1;
        Tue, 16 Jan 2024 06:35:10 -0800 (PST)
X-Gm-Message-State: AOJu0YysURows66dWDTnvQK0XbJzorC59OhyyNrNdFU6dsfIQlyTzM55
	rP93JWAbNyPRgRWRorbedwKSMnPUnag5eYp78g8=
X-Google-Smtp-Source: AGHT+IHFIyuoq5L7mzPqeE6kVupTlFwQ1uP+ufGn0cV0oNciVMUk2jSy25h1vh0L4Uq0cPUXFourXmrMR+lNwNj9VRI=
X-Received: by 2002:a05:651c:150f:b0:2cd:e256:5db2 with SMTP id
 e15-20020a05651c150f00b002cde2565db2mr340814ljf.110.1705415708662; Tue, 16
 Jan 2024 06:35:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org> <20230926194242.2732127-2-sjg@chromium.org>
 <BN9PR11MB5483FF3039913334C7EA83E1E6AEA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXFG92NpL7T7YocOup0xLKyopt3MnSCp0RL8cLzozzJz7A@mail.gmail.com>
 <BN9PR11MB548303B09536EB1577472029E6B3A@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAPnjgZ36t8g7E=0MSJyaV8-QKv9RVYe47Jd5E=NU-mFM4LWBQA@mail.gmail.com>
 <CAMj1kXHAEeK7x2f13k_JV3Xcw61nNLasyvXQf+mKwKekQ48EpQ@mail.gmail.com>
 <BN9PR11MB548334E0DA6495C438FBFDE1E6BBA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <BN9PR11MB548314DDE8D4C9503103D51CE6BBA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXHbM+ArLgNZgnmiok4gOfv6QLYxzyB9OCwfhEkJ2xGK_g@mail.gmail.com>
 <BN9PR11MB5483C2FBCD07DE61DCCDB523E6BCA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXHmu=ykgBMRiFqG4_ra3FJtHa=GASoMUJswdMFa9v4Xgw@mail.gmail.com>
 <BN9PR11MB54837EEB391CC2A8FA6C0BF5E695A@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXEQL9n1Adedow5KEyZ5gdFQY3Fn+Fz8vSK3mHib_vDFig@mail.gmail.com>
 <BN9PR11MB5483E191F1906641565A1337E694A@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXGcZP99hyURXFAZfwKmYqj-xBN9BcW7R3h9Mm2k937Buw@mail.gmail.com>
 <BN9PR11MB548370E8181B1BB3C6FB9A20E667A@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXH9z0fvWc5UgzDQ=HfYKkh=YudjL-yoZwKX93baiMgZ8w@mail.gmail.com> <BN9PR11MB5483D8D09B86CF3F92A20D3AE6672@BN9PR11MB5483.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5483D8D09B86CF3F92A20D3AE6672@BN9PR11MB5483.namprd11.prod.outlook.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 16 Jan 2024 15:34:57 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGNdheZ97JNhBc53VNoajPA=4iPn=KkWf6DZ36td2d8aA@mail.gmail.com>
Message-ID: <CAMj1kXGNdheZ97JNhBc53VNoajPA=4iPn=KkWf6DZ36td2d8aA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To: "Chiu, Chasel" <chasel.chiu@intel.com>
Cc: Simon Glass <sjg@chromium.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Rob Herring <robh@kernel.org>, "Tan, Lean Sheng" <sheng.tan@9elements.com>, 
	lkml <linux-kernel@vger.kernel.org>, Dhaval Sharma <dhaval@rivosinc.com>, 
	"Brune, Maximilian" <maximilian.brune@9elements.com>, Yunhui Cui <cuiyunhui@bytedance.com>, 
	"Dong, Guo" <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>, 
	ron minnich <rminnich@gmail.com>, "Guo, Gua" <gua.guo@intel.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 18:53, Chiu, Chasel <chasel.chiu@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Ard Biesheuvel <ardb@kernel.org>
> > Sent: Thursday, January 4, 2024 12:43 AM
> > To: Chiu, Chasel <chasel.chiu@intel.com>
> > Cc: Simon Glass <sjg@chromium.org>; devicetree@vger.kernel.org; Mark Rutland
> > <mark.rutland@arm.com>; Rob Herring <robh@kernel.org>; Tan, Lean Sheng
> > <sheng.tan@9elements.com>; lkml <linux-kernel@vger.kernel.org>; Dhaval
> > Sharma <dhaval@rivosinc.com>; Brune, Maximilian
> > <maximilian.brune@9elements.com>; Yunhui Cui <cuiyunhui@bytedance.com>;
> > Dong, Guo <guo.dong@intel.com>; Tom Rini <trini@konsulko.com>; ron minnich
> > <rminnich@gmail.com>; Guo, Gua <gua.guo@intel.com>; linux-
> > acpi@vger.kernel.org; U-Boot Mailing List <u-boot@lists.denx.de>
> > Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory
> > usages
> >
> > On Thu, 4 Jan 2024 at 01:25, Chiu, Chasel <chasel.chiu@intel.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > > Sent: Wednesday, January 3, 2024 7:22 AM
> > > > To: Chiu, Chasel <chasel.chiu@intel.com>
> > > > Cc: Simon Glass <sjg@chromium.org>; devicetree@vger.kernel.org; Mark
> > > > Rutland <mark.rutland@arm.com>; Rob Herring <robh@kernel.org>; Tan,
> > > > Lean Sheng <sheng.tan@9elements.com>; lkml
> > > > <linux-kernel@vger.kernel.org>; Dhaval Sharma <dhaval@rivosinc.com>;
> > > > Brune, Maximilian <maximilian.brune@9elements.com>; Yunhui Cui
> > > > <cuiyunhui@bytedance.com>; Dong, Guo <guo.dong@intel.com>; Tom Rini
> > > > <trini@konsulko.com>; ron minnich <rminnich@gmail.com>; Guo, Gua
> > > > <gua.guo@intel.com>; linux- acpi@vger.kernel.org; U-Boot Mailing
> > > > List <u-boot@lists.denx.de>
> > > > Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory
> > > > usages
> > > >
> > > > On Fri, 22 Dec 2023 at 20:52, Chiu, Chasel <chasel.chiu@intel.com> wrote:
> > > > >
> > > > >
> > > > > Please see my reply below inline.
> > > > >
> > > > > Thanks,
> > > > > Chasel
> > > > >
> > > > ...
> > > > > > > > The gEfiMemoryTypeInformationGuid HOB typically carries
> > > > > > > > platform defaults, and the actual memory type information is
> > > > > > > > kept in a non-volatile EFI variable, which gets updated when
> > > > > > > > the memory usage changes. Is this different for UefiPayloadPkg?
> > > > > > > >
> > > > > > > > (For those among the cc'ees less versed in EFI/EDK2: when
> > > > > > > > you get the 'config changed -rebooting' message from the
> > > > > > > > boot firmware, it typically means that this memory type
> > > > > > > > table has changed, and a reboot is necessary.)
> > > > > > > >
> > > > > > > > So the platform init needs to read this variable, or get the
> > > > > > > > information in a different way. I assume it is the payload,
> > > > > > > > not the platform init that updates the variable when
> > > > > > > > necessary. This means the information flows from payload(n)
> > > > > > > > to platform init(n+1), where n is a monotonic index tracking
> > > > > > > > consecutive boots of the
> > > > system.
> > > > > > > >
> > > > > > > > Can you explain how the DT fits into this? How are the
> > > > > > > > runtime-code and runtime-data memory reservation nodes under
> > > > > > > > /reserved-memory used to implement this information exchange
> > > > > > > > between platform init and payload? And how do the HOB and
> > > > > > > > the EFI
> > > > variable fit into this picture?
> > > > > > >
> > > > > > >
> > > > > > > 1. With some offline discussion, we would move
> > > > > > > gEfiMemoryTypeInformationGuid usage to FDT->upl-custom node.
> > > > > > > This is because it is edk2 implementation choice and non-edk2
> > > > > > > PlatformInit or Payload may not have such memory optimization
> > > > > > > implementation. (not a generic usage/requirement for
> > > > > > > PlatformInit and Payload)
> > > > > > >
> > > > > > > The edk2 example flow will be like below:
> > > > > > >
> > > > > > > PlatformInit to GetVariable of gEfiMemoryTypeInformationGuid
> > > > > > > and create Hob-
> > > > > > >
> > > > > > >   PlatformInit to initialize FDT->upl-custom node to report
> > > > > > gEfiMemoryTypeInformationGuid HOB information ->
> > > > > > >     UefiPayload entry to re-create
> > > > > > > gEfiMemoryTypeInformationGuid HOB basing
> > > > > > on FDT input (instead of the default MemoryType inside
> > > > > > UefiPayload)
> > > > > > ->
> > > > > > >       UefiPayload DxeMain/Gcd will consume
> > > > > > > gEfiMemoryTypeInformationGuid
> > > > > > Hob for memory type information ->
> > > > > > >         UefiPayload to initialize UEFI environment (mainly DXE dispatcher) -
> > >
> > > > > > >           (additional FV binary appended to common UefiPayload
> > > > > > > binary)
> > > > > > PlatformPayload to provide VariableService which is platform
> > > > > > specific ->
> > > > > > >             UefiPayload UefiBootManager will SetVariable if
> > > > > > > memory type change
> > > > > > needed and request a warm reset ->
> > > > > > >               Back to PlatformInit ...
> > > > > > >
> > > > > >
> > > > > > OK so the upl-custom node can do whatever it needs to. I imagine
> > > > > > these will include the memory descriptor attribute field, and
> > > > > > other parts that may be missing from the /reserved-memory DT node
> > specification?
> > > > >
> > > > >
> > > > > Yes, if needed by edk2 specific implementation, not generic
> > > > > enough, we may
> > > > consider to use upl-custom node to pass those data.
> > > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > 2. Now the proposed reserved-memory node usages will be for
> > > > > > > PlatformInit to
> > > > > > provide data which may be used by Payload or OS. This is not
> > > > > > edk2 specific and any PlatformInit/Payload could have same support.
> > > > > > > Note: all of below are optional and PlatformInit may choose to
> > > > > > > implement some
> > > > > > of them or not.
> > > > > > >
> > > > > > >       - acpi
> > > > > > > If PlatformInit created some ACPI tables, this will report a
> > > > > > > memory region which
> > > > > > contains all the tables to Payload and Payload may base on this
> > > > > > to add some more tables if required.
> > > > > > >
> > > > > > >       - acpi-nvs
> > > > > > > If PlatformInit has created some ACPI tables which having ACPI
> > > > > > > NVS memory
> > > > > > dependency, this will be that nvs region.
> > > > > > >
> > > > > >
> > > > > > These make sense.
> > > > > >
> > > > > > >       - boot-code
> > > > > > > When PlatformInit having some FW boot phase code that could be
> > > > > > > freed for OS to use when payload transferring control to UEFI
> > > > > > > OS
> > > > > > >
> > > > > > >       - boot-data
> > > > > > > When PlatformInit having some FW boot phase data that could be
> > > > > > > freed for OS
> > > > > > to use when payload transferring control to UEFI OS.
> > > > > > >
> > > > > > >       - runtime-code
> > > > > > > PlatformInit may provide some services code that can be used
> > > > > > > for Payload to
> > > > > > initialize UEFI Runtime Services for supporting UEFI OS.
> > > > > > >
> > > > > > >       - runtime-data
> > > > > > > PlatformInit may provide some services data that can be used
> > > > > > > for Payload to
> > > > > > Initialize UEFI Runtime Services for supporting UEFI OS.
> > > > > > >
> > > > > >
> > > > > > A UEFI OS must consume this information from the UEFI memory
> > > > > > map, not from the /reserved-memory nodes. So these nodes must
> > > > > > either not be visible to the OS at all, or carry an annotation
> > > > > > that the OS must ignore
> > > > them.
> > > > > >
> > > > > > Would it be possible to include a restriction in the DT schema
> > > > > > that these are only valid in the firmware boot phase?
> > > > >
> > > > >
> > > > > https://uefi.org/specs/UEFI/2.10/07_Services_Boot_Services.html#ef
> > > > > i-bo ot-services-exitbootservices Per UEFI specification, UEFI OS
> > > > > will always call UEFI GetMemoryMap function to retrieve memory
> > > > > map, so FDT
> > > > node present or not does not matter to UEFI OS. We probably could
> > > > have annotation in UPL specification to emphasize this.
> > > > > I'm not familiar with Linux FDT boot, but if non-UEFI OS does not
> > > > > call UEFI
> > > > GetMemoryMap() and does not know what is runtime-code/data, boot-
> > > > code/data, it might just treat such reserved-memory nodes as
> > > > 'regular' reserved memory nodes, and that's still ok because
> > > > non-UEFI OS will not call to any runtime service or re-purpose boot-code/data
> > memory regions.
> > > > >
> > > >
> > > > You are saying the same thing but in a different way. A UEFI OS must
> > > > only rely on GetMemoryMap(), and not on the /reserved-memory node to
> > > > obtain this information. But this requirement needs to be stated
> > > > somewhere: the UEFI spec does not reason about other sources of EFI
> > > > memory information at all, and this DT schema does not mention any of this
> > either.
> > > >
> > > > > Would you provide a real OS case which will be impacted by this
> > > > > reserved-
> > > > memory schema so we can discuss basing on real case?
> > > > >
> > > >
> > > > Funny, that is what I have been trying to get from you :-)
> > > >
> > > > The problem I am anticipating here is that the information in
> > > > /reserved-memory may be out of sync with the EFI memory map. It
> > > > needs to be made clear that the EFI memory map is the only source of
> > > > truth when the OS is involved, and this /reserved-memory mechanism
> > > > should only be used by other firmware stages. But the schema does
> > > > not mention this at all. The schema also does not mention that the
> > > > information in /reserved-memory is not actually sufficient to
> > > > reconstruct the EFI memory map that the firmware payload expects
> > > > (which is why the upl- custom-node exists too)
> > >
> > >
> > >
> > > Does below solve your concerns if we mention those in schema
> > > description? (please feel free to add more if you have) . boot-code/boot-data
> > and runtime-code/runtime-data usages are following UEFI specification
> > >   . before ExitBootServices:
> > https://uefi.org/specs/UEFI/2.10/07_Services_Boot_Services.html#memory-
> > type-usage-before-exitbootservices
> > >   . after ExitBootServices:
> > > https://uefi.org/specs/UEFI/2.10/07_Services_Boot_Services.html#memory
> > > -type-usage-after-exitbootservices
> > > . These usages do not intend to construct full UEFI memory map, it is only for
> > PlatformInit to pass pre-installed tables or services to Payload for supporting UEFI
> > OS boot.
> > > . These usages are optional
> > > . Typically UEFI OS boot will always call GetMemoryMap() to retrieve
> > > memory map following UEFI spec, no matter DT nodes present or not
> > > (https://uefi.org/specs/UEFI/2.10/07_Services_Boot_Services.html#efi-b
> > > oot-services-exitbootservices) . Typically Non-UEFI OS boot will treat
> > > those  boot* or runtime* reserved-memory as 'regular' reserved memory if
> > present.
> > >
> >
> > This already helps quite a lot, thanks.
> >
> > But why should a non-UEFI OS be required to keep boot* or runtime* regions
> > reserved? The firmware stage that boots the OS knows whether it is performing
> > an UEFI boot or a non-UEFI boot, and it should only present the information that
> > goes along with that. The OS should never have to worry about reconciling two
> > sources of truth.
> >
> > And to Rob's point about boot / runtime being ill-defined: I would argue that
> > 'runtime' quite clearly implies 'under the OS', and so UEFI
> > runtime* reservations are assumed to always be relevant to UEFI OSes.
> >
> > I think there is a fundamental difference of opinion here, where the position of
> > the firmware developers is that the DT should be the same across all boot stages,
> > while my position reasoning from the OS side is that the OS should be able to
> > observe only the abstractions that are part of the contract between firmware and
> > OS.
>
> I agree that boot* and runtime* can be utilized by non-UEFI OS too, we are just reusing existing definitions from UEFI spec.
>   . boot-code/boot-data: firmware stage code/data that can be freed after firmware stage ending so OS will have more usable memory.
>   . runtime-code/runtime-data: firmware stage code/data that are intended to be utilized by OS stage.
> Non-UEFI OS still can implement/support boot* or runtime* memory if they want, and the runtime service can be 'non-UEFI' runtime service too as long as OS/FW aligning each other.

No, I disagree here, and this is the core of the issue IMO. Boot data
and runtime data are tied to UEFI boot. A non-UEFI OS must either keep
these regions reserved and not use them at all, or disregard the
reservation and use them as ordinary memory.

What I don't want is a frankenstein construction where UEFI boot is
avoided for religious reasons, but the regions in question are still
parsed/accessed/etc to reimplement things like SMBIOS etc in a way
that violates the specification.

> Or non-UEFI OS can simply treat them as "usable memory" if they do not call to any runtime services from those memory regions. (in this case runtime* memory can be repurposed just like boot* memory)
> That will be OS choices and we may add some example OS handling to schema description too.
>

The OS should not have to care about this at all. The reservations are
intended for firmware stages, not the OS. The OS will either find
these reservations in the UEFI memory map, or it should not care about
them at all.

> While we are working on UPL specific DT, we got agreement that 2 separate DT are unnecessary, we better align/merge with existing OS DT and OS could utilize those additional UPL DT information too if they want.
> This also simplifies/unifies PlatformInit as same DT could support different OS loader Payloads.
>

I was not part of any agreement that 2 separate DTs are unnecessary,
and I think this discussion proves that exposing firmware
implementation details to the OS via a unified DT can be problematic.

