Return-Path: <linux-kernel+bounces-15723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163468230E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209211C23A6A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888EE1BDCB;
	Wed,  3 Jan 2024 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/ZT7b+Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45D51BDC4;
	Wed,  3 Jan 2024 16:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E496C433D9;
	Wed,  3 Jan 2024 16:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704297657;
	bh=TDf6P5sfgxkcu150MVs02La3DCa0WzykH4r9oZbtqt4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k/ZT7b+Y5IuAmdA4TKdz0LCwZjixpX2Eu1Zw08qkqgaC0QJTTNTi8ur2gDhaR2sZf
	 pTJF90u9TjziydpmooJZAzKXtqYNMY/JcFmvMoVQ1tcksYK2rUI+KQ60b/FLWxPwa+
	 tNdB+hW9swfypDh1YcvKTQh7e/l6EYl4WpbJeRubZC3IuP3rFzhy8Sl9BQS6CEC0w4
	 wVWQSk+dp/4rAftebPJX5pMDCbNMKjfpJNfCU7ftcW3y0NP14KO6NmEfSSpO+b019k
	 HAUVpKzwoUmR76Uq6ISW1WBXUaSE83MelWCx0rbyCbL2r4813nxEcQhFTOFJcXimF+
	 rnBDTSl1gYEZw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ccba761783so88504681fa.1;
        Wed, 03 Jan 2024 08:00:57 -0800 (PST)
X-Gm-Message-State: AOJu0Yz6uC1USmGuaty9eOHSa6IdiVhzsxb1N12ESCzq4Zh/zDpTk5dw
	K1uwgd2MAxWTdIDQN1BfOc/vYr61B+MApFG2tA==
X-Google-Smtp-Source: AGHT+IHSP1aMAl6w6n1MbYfch4aBmhGWsYak3Mkm0XOdMRv6AkQ17MG8edJfDYhTbCOZG9k/l6xyKnV3NCHBtwkZsfI=
X-Received: by 2002:a2e:b050:0:b0:2cc:d5b0:3f0f with SMTP id
 d16-20020a2eb050000000b002ccd5b03f0fmr5042459ljl.79.1704297655515; Wed, 03
 Jan 2024 08:00:55 -0800 (PST)
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
In-Reply-To: <CAMj1kXEQL9n1Adedow5KEyZ5gdFQY3Fn+Fz8vSK3mHib_vDFig@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 3 Jan 2024 09:00:37 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKkC1H0Hi2KdF1CH3959Use9ZaruE7uh4ncAyG4C6AqYQ@mail.gmail.com>
Message-ID: <CAL_JsqKkC1H0Hi2KdF1CH3959Use9ZaruE7uh4ncAyG4C6AqYQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "Chiu, Chasel" <chasel.chiu@intel.com>, Simon Glass <sjg@chromium.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	"Tan, Lean Sheng" <sheng.tan@9elements.com>, lkml <linux-kernel@vger.kernel.org>, 
	Dhaval Sharma <dhaval@rivosinc.com>, "Brune, Maximilian" <maximilian.brune@9elements.com>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, "Dong, Guo" <guo.dong@intel.com>, 
	Tom Rini <trini@konsulko.com>, ron minnich <rminnich@gmail.com>, "Guo, Gua" <gua.guo@intel.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 5:48=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Thu, 21 Dec 2023 at 17:50, Chiu, Chasel <chasel.chiu@intel.com> wrote:
> >
> >
> > Hi Ard,
> >
> > Please see my reply below inline and let me know your thoughts.
> >
> > Thanks,
> > Chasel
> >
> >
> > > -----Original Message-----
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > > Sent: Thursday, December 21, 2023 6:31 AM
> > > To: Chiu, Chasel <chasel.chiu@intel.com>
> > > Cc: Simon Glass <sjg@chromium.org>; devicetree@vger.kernel.org; Mark =
Rutland
> > > <mark.rutland@arm.com>; Rob Herring <robh@kernel.org>; Tan, Lean Shen=
g
> > > <sheng.tan@9elements.com>; lkml <linux-kernel@vger.kernel.org>; Dhava=
l
> > > Sharma <dhaval@rivosinc.com>; Brune, Maximilian
> > > <maximilian.brune@9elements.com>; Yunhui Cui <cuiyunhui@bytedance.com=
>;
> > > Dong, Guo <guo.dong@intel.com>; Tom Rini <trini@konsulko.com>; ron mi=
nnich
> > > <rminnich@gmail.com>; Guo, Gua <gua.guo@intel.com>; linux-
> > > acpi@vger.kernel.org; U-Boot Mailing List <u-boot@lists.denx.de>
> > > Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory
> > > usages
> > >
> > > On Tue, 28 Nov 2023 at 21:31, Chiu, Chasel <chasel.chiu@intel.com> wr=
ote:
> > > >
> > > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > > > Sent: Tuesday, November 28, 2023 10:08 AM
> > > > > To: Chiu, Chasel <chasel.chiu@intel.com>
> > > > > Cc: Simon Glass <sjg@chromium.org>; devicetree@vger.kernel.org; M=
ark
> > > > > Rutland <mark.rutland@arm.com>; Rob Herring <robh@kernel.org>; Ta=
n,
> > > > > Lean Sheng <sheng.tan@9elements.com>; lkml
> > > > > <linux-kernel@vger.kernel.org>; Dhaval Sharma <dhaval@rivosinc.co=
m>;
> > > > > Brune, Maximilian <maximilian.brune@9elements.com>; Yunhui Cui
> > > > > <cuiyunhui@bytedance.com>; Dong, Guo <guo.dong@intel.com>; Tom Ri=
ni
> > > > > <trini@konsulko.com>; ron minnich <rminnich@gmail.com>; Guo, Gua
> > > > > <gua.guo@intel.com>; linux- acpi@vger.kernel.org; U-Boot Mailing
> > > > > List <u-boot@lists.denx.de>
> > > > > Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-mem=
ory
> > > > > usages
> > > > >
> > > > > You are referring to a 2000 line patch so it is not 100% clear wh=
ere to look tbh.
> > > > >
> > > > >
> > > > > On Tue, 21 Nov 2023 at 19:37, Chiu, Chasel <chasel.chiu@intel.com=
> wrote:
> > > > > >
> > > > > >
> > > > > > In PR, UefiPayloadPkg/Library/FdtParserLib/FdtParserLib.c, line
> > > > > > 268 is for
> > > > > related example code.
> > > > > >
> > > > >
> > > > > That refers to a 'memory-allocation' node, right? How does that
> > > > > relate to the 'reserved-memory' node?
> > > > >
> > > > > And crucially, how does this clarify in which way "runtime-code" =
and
> > > > > "runtime- data" reservations are being used?
> > > > >
> > > > > Since the very beginning of this discussion, I have been asking
> > > > > repeatedly for examples that describe the wider context in which =
these
> > > reservations are used.
> > > > > The "runtime" into runtime-code and runtime-data means that these
> > > > > regions have a special significance to the operating system, not
> > > > > just to the next bootloader stage. So I want to understand exactl=
y
> > > > > why it is necessary to describe these regions in a way where the
> > > > > operating system might be expected to interpret this information =
and act
> > > upon it.
> > > > >
> > > >
> > > >
> > > > I think runtime code and data today are mainly for supporting UEFI =
runtime
> > > services - some BIOS functions for OS to utilize, OS may follow below=
 ACPI spec to
> > > treat them as reserved range:
> > > > https://uefi.org/specs/ACPI/6.5/15_System_Address_Map_Interfaces.ht=
ml#
> > > > uefi-memory-types-and-mapping-to-acpi-address-range-types
> > > >
> > > > Like I mentioned earlier, that PR is still in early phase and has n=
ot reflected all
> > > the required changes yet, but the idea is to build
> > > gEfiMemoryTypeInformationGuid HOB from FDT reserved-memory nodes.
> > > > UEFI generic Payload has DxeMain integrated, however Memory Types a=
re
> > > platform-specific, for example, some platforms may need bigger runtim=
e memory
> > > for their implementation, that's why we want such FDT reserved-memory=
 node to
> > > tell DxeMain.
> > > >
> > >
> > > > The Payload flow will be like this:
> > > >   Payload creates built-in default MemoryTypes table ->
> > > >     FDT reserved-memory node to override if required (this also ens=
ures the
> > > same memory map cross boots so ACPI S4 works) ->
> > > >       Build gEfiMemoryTypeInformationGuid HOB by "platfom specific"
> > > MemoryTypes Table ->
> > > >         DxeMain/GCD to consume this MemoryTypes table and setup mem=
ory
> > > service ->
> > > >           Install memory types table to UEFI system table.Configura=
tion table...
> > > >
> > > > Note: if Payload built-in default MemoryTypes table works fine for =
the
> > > > platform, then FDT reserved-memory node does not need to provide su=
ch
> > > 'usage' compatible strings. (optional) This FDT node could allow
> > > flexibility/compatibility without rebuilding Payload binary.
> > > >
> > > > Not sure if I answered all your questions, please highlight which a=
rea you need
> > > more information.
> > > >
> > >
> > > The gEfiMemoryTypeInformationGuid HOB typically carries platform defa=
ults, and
> > > the actual memory type information is kept in a non-volatile EFI vari=
able, which
> > > gets updated when the memory usage changes. Is this different for
> > > UefiPayloadPkg?
> > >
> > > (For those among the cc'ees less versed in EFI/EDK2: when you get the=
 'config
> > > changed -rebooting' message from the boot firmware, it typically mean=
s that this
> > > memory type table has changed, and a reboot is necessary.)
> > >
> > > So the platform init needs to read this variable, or get the informat=
ion in a
> > > different way. I assume it is the payload, not the platform init that=
 updates the
> > > variable when necessary. This means the information flows from payloa=
d(n) to
> > > platform init(n+1), where n is a monotonic index tracking consecutive=
 boots of the
> > > system.
> > >
> > > Can you explain how the DT fits into this? How are the runtime-code a=
nd
> > > runtime-data memory reservation nodes under /reserved-memory used to
> > > implement this information exchange between platform init and payload=
? And
> > > how do the HOB and the EFI variable fit into this picture?
> >
> >
> > 1. With some offline discussion, we would move gEfiMemoryTypeInformatio=
nGuid usage to FDT->upl-custom node. This is because it is edk2 implementat=
ion choice and non-edk2 PlatformInit or Payload may not have such memory op=
timization implementation. (not a generic usage/requirement for PlatformIni=
t and Payload)
> >
> > The edk2 example flow will be like below:
> >
> > PlatformInit to GetVariable of gEfiMemoryTypeInformationGuid and create=
 Hob->
> >   PlatformInit to initialize FDT->upl-custom node to report gEfiMemoryT=
ypeInformationGuid HOB information ->
> >     UefiPayload entry to re-create gEfiMemoryTypeInformationGuid HOB ba=
sing on FDT input (instead of the default MemoryType inside UefiPayload) ->
> >       UefiPayload DxeMain/Gcd will consume gEfiMemoryTypeInformationGui=
d Hob for memory type information ->
> >         UefiPayload to initialize UEFI environment (mainly DXE dispatch=
er) ->
> >           (additional FV binary appended to common UefiPayload binary) =
PlatformPayload to provide VariableService which is platform specific ->
> >             UefiPayload UefiBootManager will SetVariable if memory type=
 change needed and request a warm reset ->
> >               Back to PlatformInit ...
> >
>
> OK so the upl-custom node can do whatever it needs to. I imagine these
> will include the memory descriptor attribute field, and other parts
> that may be missing from the /reserved-memory DT node specification?
>
> >
> > 2. Now the proposed reserved-memory node usages will be for PlatformIni=
t to provide data which may be used by Payload or OS. This is not edk2 spec=
ific and any PlatformInit/Payload could have same support.
> > Note: all of below are optional and PlatformInit may choose to implemen=
t some of them or not.
> >
> >       - acpi
> > If PlatformInit created some ACPI tables, this will report a memory reg=
ion which contains all the tables to Payload and Payload may base on this t=
o add some more tables if required.
> >
> >       - acpi-nvs
> > If PlatformInit has created some ACPI tables which having ACPI NVS memo=
ry dependency, this will be that nvs region.
> >
>
> These make sense.
>
> >       - boot-code
> > When PlatformInit having some FW boot phase code that could be freed fo=
r OS to use when payload transferring control to UEFI OS
> >
> >       - boot-data
> > When PlatformInit having some FW boot phase data that could be freed fo=
r OS to use when payload transferring control to UEFI OS.
> >
> >       - runtime-code
> > PlatformInit may provide some services code that can be used for Payloa=
d to initialize UEFI Runtime Services for supporting UEFI OS.
> >
> >       - runtime-data
> > PlatformInit may provide some services data that can be used for Payloa=
d to Initialize UEFI Runtime Services for supporting UEFI OS.
> >

I'll say it again. "boot" and "runtime" on their own could mean about
anything, but the usage here is clearly tied to UEFI (or the EDK2
implementation) and its meaning of boot and runtime. So the naming
needs to reflect that.


> A UEFI OS must consume this information from the UEFI memory map, not
> from the /reserved-memory nodes. So these nodes must either not be
> visible to the OS at all, or carry an annotation that the OS must
> ignore them.

The kernel will process /reserved-memory for UEFI boot, so the
expectation is anything in the EFI memory map is not present there. An
annotation to ignore some nodes would require going back in time or
accepting 2 sources of truth on existing OS.

> Would it be possible to include a restriction in the DT schema that
> these are only valid in the firmware boot phase?

The only way ATM is including a schema or not when running validation
on a DT for a particular boot phase. Include the schema in the project
that wants to use these nodes and don't include it in cases that don't
use it. I don't see a reason why this needs to be in dtschema.

Rob

