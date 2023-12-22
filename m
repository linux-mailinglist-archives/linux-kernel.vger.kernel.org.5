Return-Path: <linux-kernel+bounces-9726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C4D81CA43
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9BF1F2251E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC8D2230B;
	Fri, 22 Dec 2023 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ly4DFqcI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969C3224DA;
	Fri, 22 Dec 2023 12:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7EFC433C7;
	Fri, 22 Dec 2023 12:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703249290;
	bh=V72pV+EXR1DLsor55xWUV6GPn2LtZ4+S8rLYXyUkQPM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ly4DFqcIqG575M4GSPA1U0o94smm+XMk0G4zD/WWsU9CsHBfwE9cRLC/eJ+yIDpKa
	 kRUn51b0erGl0TQVk4OADdDjdz1wiRGyy3W2IhDtCOMsmdij34xTGBGkwVxQi2w2B4
	 qAFfo8IT/8+ENPD84LreX/2MV0BHMb9iaRTDT+L45LITW0LceaLp9tIWGpioXz6iCj
	 XEaKPK2X9CaG7ltMs+ZYZ5Va9tVhFITOASK/kwV0aDpg04xk4HeroBR22dHesvuGiT
	 AwhBlVD2SiQZCUrKJ9zIER8UFCQzliuEqTWWtnqQxwW4lLH3BFLHLa/f9w+ARPDHuL
	 5Xwn5L/AxeXyw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e6a5b5e36so530356e87.3;
        Fri, 22 Dec 2023 04:48:10 -0800 (PST)
X-Gm-Message-State: AOJu0Yw+CsDuQulIcuD5+3Iu6C1hv+4vGgBqTjOqa+pJDbswYvzL/sjA
	5n6BXNpEM5mlxaB4jVj81HQgQRDjfxqG9Q0xIBA=
X-Google-Smtp-Source: AGHT+IFeUV+nepXa2pRRmsunsTOc5QtiHCIzjxaYBxClPNYPYWoKSQCLb8x0ZJ/yZ0cBRxzjL76fjrwtzEai63KHemk=
X-Received: by 2002:ac2:454e:0:b0:50e:384c:289a with SMTP id
 j14-20020ac2454e000000b0050e384c289amr643501lfm.78.1703249288530; Fri, 22 Dec
 2023 04:48:08 -0800 (PST)
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
 <CAMj1kXHmu=ykgBMRiFqG4_ra3FJtHa=GASoMUJswdMFa9v4Xgw@mail.gmail.com> <BN9PR11MB54837EEB391CC2A8FA6C0BF5E695A@BN9PR11MB5483.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB54837EEB391CC2A8FA6C0BF5E695A@BN9PR11MB5483.namprd11.prod.outlook.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 22 Dec 2023 13:47:57 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEQL9n1Adedow5KEyZ5gdFQY3Fn+Fz8vSK3mHib_vDFig@mail.gmail.com>
Message-ID: <CAMj1kXEQL9n1Adedow5KEyZ5gdFQY3Fn+Fz8vSK3mHib_vDFig@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Dec 2023 at 17:50, Chiu, Chasel <chasel.chiu@intel.com> wrote:
>
>
> Hi Ard,
>
> Please see my reply below inline and let me know your thoughts.
>
> Thanks,
> Chasel
>
>
> > -----Original Message-----
> > From: Ard Biesheuvel <ardb@kernel.org>
> > Sent: Thursday, December 21, 2023 6:31 AM
> > To: Chiu, Chasel <chasel.chiu@intel.com>
> > Cc: Simon Glass <sjg@chromium.org>; devicetree@vger.kernel.org; Mark Ru=
tland
> > <mark.rutland@arm.com>; Rob Herring <robh@kernel.org>; Tan, Lean Sheng
> > <sheng.tan@9elements.com>; lkml <linux-kernel@vger.kernel.org>; Dhaval
> > Sharma <dhaval@rivosinc.com>; Brune, Maximilian
> > <maximilian.brune@9elements.com>; Yunhui Cui <cuiyunhui@bytedance.com>;
> > Dong, Guo <guo.dong@intel.com>; Tom Rini <trini@konsulko.com>; ron minn=
ich
> > <rminnich@gmail.com>; Guo, Gua <gua.guo@intel.com>; linux-
> > acpi@vger.kernel.org; U-Boot Mailing List <u-boot@lists.denx.de>
> > Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory
> > usages
> >
> > On Tue, 28 Nov 2023 at 21:31, Chiu, Chasel <chasel.chiu@intel.com> wrot=
e:
> > >
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > > Sent: Tuesday, November 28, 2023 10:08 AM
> > > > To: Chiu, Chasel <chasel.chiu@intel.com>
> > > > Cc: Simon Glass <sjg@chromium.org>; devicetree@vger.kernel.org; Mar=
k
> > > > Rutland <mark.rutland@arm.com>; Rob Herring <robh@kernel.org>; Tan,
> > > > Lean Sheng <sheng.tan@9elements.com>; lkml
> > > > <linux-kernel@vger.kernel.org>; Dhaval Sharma <dhaval@rivosinc.com>=
;
> > > > Brune, Maximilian <maximilian.brune@9elements.com>; Yunhui Cui
> > > > <cuiyunhui@bytedance.com>; Dong, Guo <guo.dong@intel.com>; Tom Rini
> > > > <trini@konsulko.com>; ron minnich <rminnich@gmail.com>; Guo, Gua
> > > > <gua.guo@intel.com>; linux- acpi@vger.kernel.org; U-Boot Mailing
> > > > List <u-boot@lists.denx.de>
> > > > Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memor=
y
> > > > usages
> > > >
> > > > You are referring to a 2000 line patch so it is not 100% clear wher=
e to look tbh.
> > > >
> > > >
> > > > On Tue, 21 Nov 2023 at 19:37, Chiu, Chasel <chasel.chiu@intel.com> =
wrote:
> > > > >
> > > > >
> > > > > In PR, UefiPayloadPkg/Library/FdtParserLib/FdtParserLib.c, line
> > > > > 268 is for
> > > > related example code.
> > > > >
> > > >
> > > > That refers to a 'memory-allocation' node, right? How does that
> > > > relate to the 'reserved-memory' node?
> > > >
> > > > And crucially, how does this clarify in which way "runtime-code" an=
d
> > > > "runtime- data" reservations are being used?
> > > >
> > > > Since the very beginning of this discussion, I have been asking
> > > > repeatedly for examples that describe the wider context in which th=
ese
> > reservations are used.
> > > > The "runtime" into runtime-code and runtime-data means that these
> > > > regions have a special significance to the operating system, not
> > > > just to the next bootloader stage. So I want to understand exactly
> > > > why it is necessary to describe these regions in a way where the
> > > > operating system might be expected to interpret this information an=
d act
> > upon it.
> > > >
> > >
> > >
> > > I think runtime code and data today are mainly for supporting UEFI ru=
ntime
> > services - some BIOS functions for OS to utilize, OS may follow below A=
CPI spec to
> > treat them as reserved range:
> > > https://uefi.org/specs/ACPI/6.5/15_System_Address_Map_Interfaces.html=
#
> > > uefi-memory-types-and-mapping-to-acpi-address-range-types
> > >
> > > Like I mentioned earlier, that PR is still in early phase and has not=
 reflected all
> > the required changes yet, but the idea is to build
> > gEfiMemoryTypeInformationGuid HOB from FDT reserved-memory nodes.
> > > UEFI generic Payload has DxeMain integrated, however Memory Types are
> > platform-specific, for example, some platforms may need bigger runtime =
memory
> > for their implementation, that's why we want such FDT reserved-memory n=
ode to
> > tell DxeMain.
> > >
> >
> > > The Payload flow will be like this:
> > >   Payload creates built-in default MemoryTypes table ->
> > >     FDT reserved-memory node to override if required (this also ensur=
es the
> > same memory map cross boots so ACPI S4 works) ->
> > >       Build gEfiMemoryTypeInformationGuid HOB by "platfom specific"
> > MemoryTypes Table ->
> > >         DxeMain/GCD to consume this MemoryTypes table and setup memor=
y
> > service ->
> > >           Install memory types table to UEFI system table.Configurati=
on table...
> > >
> > > Note: if Payload built-in default MemoryTypes table works fine for th=
e
> > > platform, then FDT reserved-memory node does not need to provide such
> > 'usage' compatible strings. (optional) This FDT node could allow
> > flexibility/compatibility without rebuilding Payload binary.
> > >
> > > Not sure if I answered all your questions, please highlight which are=
a you need
> > more information.
> > >
> >
> > The gEfiMemoryTypeInformationGuid HOB typically carries platform defaul=
ts, and
> > the actual memory type information is kept in a non-volatile EFI variab=
le, which
> > gets updated when the memory usage changes. Is this different for
> > UefiPayloadPkg?
> >
> > (For those among the cc'ees less versed in EFI/EDK2: when you get the '=
config
> > changed -rebooting' message from the boot firmware, it typically means =
that this
> > memory type table has changed, and a reboot is necessary.)
> >
> > So the platform init needs to read this variable, or get the informatio=
n in a
> > different way. I assume it is the payload, not the platform init that u=
pdates the
> > variable when necessary. This means the information flows from payload(=
n) to
> > platform init(n+1), where n is a monotonic index tracking consecutive b=
oots of the
> > system.
> >
> > Can you explain how the DT fits into this? How are the runtime-code and
> > runtime-data memory reservation nodes under /reserved-memory used to
> > implement this information exchange between platform init and payload? =
And
> > how do the HOB and the EFI variable fit into this picture?
>
>
> 1. With some offline discussion, we would move gEfiMemoryTypeInformationG=
uid usage to FDT->upl-custom node. This is because it is edk2 implementatio=
n choice and non-edk2 PlatformInit or Payload may not have such memory opti=
mization implementation. (not a generic usage/requirement for PlatformInit =
and Payload)
>
> The edk2 example flow will be like below:
>
> PlatformInit to GetVariable of gEfiMemoryTypeInformationGuid and create H=
ob->
>   PlatformInit to initialize FDT->upl-custom node to report gEfiMemoryTyp=
eInformationGuid HOB information ->
>     UefiPayload entry to re-create gEfiMemoryTypeInformationGuid HOB basi=
ng on FDT input (instead of the default MemoryType inside UefiPayload) ->
>       UefiPayload DxeMain/Gcd will consume gEfiMemoryTypeInformationGuid =
Hob for memory type information ->
>         UefiPayload to initialize UEFI environment (mainly DXE dispatcher=
) ->
>           (additional FV binary appended to common UefiPayload binary) Pl=
atformPayload to provide VariableService which is platform specific ->
>             UefiPayload UefiBootManager will SetVariable if memory type c=
hange needed and request a warm reset ->
>               Back to PlatformInit ...
>

OK so the upl-custom node can do whatever it needs to. I imagine these
will include the memory descriptor attribute field, and other parts
that may be missing from the /reserved-memory DT node specification?

>
> 2. Now the proposed reserved-memory node usages will be for PlatformInit =
to provide data which may be used by Payload or OS. This is not edk2 specif=
ic and any PlatformInit/Payload could have same support.
> Note: all of below are optional and PlatformInit may choose to implement =
some of them or not.
>
>       - acpi
> If PlatformInit created some ACPI tables, this will report a memory regio=
n which contains all the tables to Payload and Payload may base on this to =
add some more tables if required.
>
>       - acpi-nvs
> If PlatformInit has created some ACPI tables which having ACPI NVS memory=
 dependency, this will be that nvs region.
>

These make sense.

>       - boot-code
> When PlatformInit having some FW boot phase code that could be freed for =
OS to use when payload transferring control to UEFI OS
>
>       - boot-data
> When PlatformInit having some FW boot phase data that could be freed for =
OS to use when payload transferring control to UEFI OS.
>
>       - runtime-code
> PlatformInit may provide some services code that can be used for Payload =
to initialize UEFI Runtime Services for supporting UEFI OS.
>
>       - runtime-data
> PlatformInit may provide some services data that can be used for Payload =
to Initialize UEFI Runtime Services for supporting UEFI OS.
>

A UEFI OS must consume this information from the UEFI memory map, not
from the /reserved-memory nodes. So these nodes must either not be
visible to the OS at all, or carry an annotation that the OS must
ignore them.

Would it be possible to include a restriction in the DT schema that
these are only valid in the firmware boot phase?

