Return-Path: <linux-kernel+bounces-15999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CAF8236D3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DED1F25886
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151041D555;
	Wed,  3 Jan 2024 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lO6zX9yF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D35C1DA20
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-68009cb4669so59346536d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 12:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704315259; x=1704920059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MB49pNbP4Kgw+fHr6WahZGlyQQT8haoiQ66ETHsRNlc=;
        b=lO6zX9yFynal+1LesKEfZMbAmMt9uxBr0XYJAgb06U1UO5XDvDsWusCU975rdsHOPn
         KZEhiiMGB68csB1UrJzF3+JblGWmX/yfvEYzk8uWn0xnwHqu0NljFqrOV9BTXcAd7/Qt
         IRCKBobi1+La/soUha0U9UxWhgz8Gtj1GrgKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704315259; x=1704920059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MB49pNbP4Kgw+fHr6WahZGlyQQT8haoiQ66ETHsRNlc=;
        b=xQ21R8d+o/6DNPgakgMIleZmSm2h0ROO9M/vYnAYob18jyfuIZsQpSZusq30AOTsKg
         ciMjZu2T3XK4uB5DwdWHb40QNA+2UNubagZL/uXgTJeXe8gqw5VeBEh42aAem9MfbgMj
         hvwNMnyDlpkwQwPEK36Htqjpo9n3x2tqgOvOtoOO52zo2YM7l0iHrkiozT2GidC8HF3e
         IKpHNvNqXd+/rxpOsluYK8QsZo8JKRJQ9cIYMddGfmUtdqafeMoubqGm7IE/hbhNKJyF
         pfbUAGLUjbfXpjqhlpNzXOYoNOZRzvgqaCco6SHyyq6EFUR3uKdewiCiFRq2/NNXmXVu
         NgpA==
X-Gm-Message-State: AOJu0YztGoGiMVJ32jfUzof23VEoCsfuLyBCFO0KNz8c1WFwFHo7BZQk
	8QSZgygvS0qzbSzHpkqEII8M+w5adFmJX1Hp7voS6DySQWQ2
X-Google-Smtp-Source: AGHT+IEvjWOLR6oG3jUV29RwLNIW+gVNYrGyjx9B1GKZpUQXEsP4K3Ty8/ToVkLtzb7ThZZKjwd/HqBnFokY2myQZKM=
X-Received: by 2002:a0c:cc94:0:b0:67f:9859:3ce2 with SMTP id
 f20-20020a0ccc94000000b0067f98593ce2mr20448833qvl.128.1704315259575; Wed, 03
 Jan 2024 12:54:19 -0800 (PST)
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
 <CAMj1kXEQL9n1Adedow5KEyZ5gdFQY3Fn+Fz8vSK3mHib_vDFig@mail.gmail.com> <CAL_JsqKkC1H0Hi2KdF1CH3959Use9ZaruE7uh4ncAyG4C6AqYQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKkC1H0Hi2KdF1CH3959Use9ZaruE7uh4ncAyG4C6AqYQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jan 2024 13:54:08 -0700
Message-ID: <CAFLszTjcGErbzaafkYNmNWH8dAhkyDfRe4DnFcG3Qhxo+jZc8g@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To: Rob Herring <robh@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, "Chiu, Chasel" <chasel.chiu@intel.com>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	"Tan, Lean Sheng" <sheng.tan@9elements.com>, lkml <linux-kernel@vger.kernel.org>, 
	Dhaval Sharma <dhaval@rivosinc.com>, "Brune, Maximilian" <maximilian.brune@9elements.com>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, "Dong, Guo" <guo.dong@intel.com>, 
	Tom Rini <trini@konsulko.com>, ron minnich <rminnich@gmail.com>, "Guo, Gua" <gua.guo@intel.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob, Ard,

On Wed, Jan 3, 2024 at 9:01=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Dec 22, 2023 at 5:48=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > On Thu, 21 Dec 2023 at 17:50, Chiu, Chasel <chasel.chiu@intel.com> wrot=
e:
> > >
> > >
> > > Hi Ard,
> > >
> > > Please see my reply below inline and let me know your thoughts.
> > >
> > > Thanks,
> > > Chasel
> > >
> > >
> > > > -----Original Message-----
> > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > > Sent: Thursday, December 21, 2023 6:31 AM
> > > > To: Chiu, Chasel <chasel.chiu@intel.com>
> > > > Cc: Simon Glass <sjg@chromium.org>; devicetree@vger.kernel.org; Mar=
k Rutland
> > > > <mark.rutland@arm.com>; Rob Herring <robh@kernel.org>; Tan, Lean Sh=
eng
> > > > <sheng.tan@9elements.com>; lkml <linux-kernel@vger.kernel.org>; Dha=
val
> > > > Sharma <dhaval@rivosinc.com>; Brune, Maximilian
> > > > <maximilian.brune@9elements.com>; Yunhui Cui <cuiyunhui@bytedance.c=
om>;
> > > > Dong, Guo <guo.dong@intel.com>; Tom Rini <trini@konsulko.com>; ron =
minnich
> > > > <rminnich@gmail.com>; Guo, Gua <gua.guo@intel.com>; linux-
> > > > acpi@vger.kernel.org; U-Boot Mailing List <u-boot@lists.denx.de>
> > > > Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memor=
y
> > > > usages
> > > >
> > > > On Tue, 28 Nov 2023 at 21:31, Chiu, Chasel <chasel.chiu@intel.com> =
wrote:
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > > > > Sent: Tuesday, November 28, 2023 10:08 AM
> > > > > > To: Chiu, Chasel <chasel.chiu@intel.com>
> > > > > > Cc: Simon Glass <sjg@chromium.org>; devicetree@vger.kernel.org;=
 Mark
> > > > > > Rutland <mark.rutland@arm.com>; Rob Herring <robh@kernel.org>; =
Tan,
> > > > > > Lean Sheng <sheng.tan@9elements.com>; lkml
> > > > > > <linux-kernel@vger.kernel.org>; Dhaval Sharma <dhaval@rivosinc.=
com>;
> > > > > > Brune, Maximilian <maximilian.brune@9elements.com>; Yunhui Cui
> > > > > > <cuiyunhui@bytedance.com>; Dong, Guo <guo.dong@intel.com>; Tom =
Rini
> > > > > > <trini@konsulko.com>; ron minnich <rminnich@gmail.com>; Guo, Gu=
a
> > > > > > <gua.guo@intel.com>; linux- acpi@vger.kernel.org; U-Boot Mailin=
g
> > > > > > List <u-boot@lists.denx.de>
> > > > > > Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-m=
emory
> > > > > > usages
> > > > > >
> > > > > > You are referring to a 2000 line patch so it is not 100% clear =
where to look tbh.
> > > > > >
> > > > > >
> > > > > > On Tue, 21 Nov 2023 at 19:37, Chiu, Chasel <chasel.chiu@intel.c=
om> wrote:
> > > > > > >
> > > > > > >
> > > > > > > In PR, UefiPayloadPkg/Library/FdtParserLib/FdtParserLib.c, li=
ne
> > > > > > > 268 is for
> > > > > > related example code.
> > > > > > >
> > > > > >
> > > > > > That refers to a 'memory-allocation' node, right? How does that
> > > > > > relate to the 'reserved-memory' node?
> > > > > >
> > > > > > And crucially, how does this clarify in which way "runtime-code=
" and
> > > > > > "runtime- data" reservations are being used?
> > > > > >
> > > > > > Since the very beginning of this discussion, I have been asking
> > > > > > repeatedly for examples that describe the wider context in whic=
h these
> > > > reservations are used.
> > > > > > The "runtime" into runtime-code and runtime-data means that the=
se
> > > > > > regions have a special significance to the operating system, no=
t
> > > > > > just to the next bootloader stage. So I want to understand exac=
tly
> > > > > > why it is necessary to describe these regions in a way where th=
e
> > > > > > operating system might be expected to interpret this informatio=
n and act
> > > > upon it.
> > > > > >
> > > > >
> > > > >
> > > > > I think runtime code and data today are mainly for supporting UEF=
I runtime
> > > > services - some BIOS functions for OS to utilize, OS may follow bel=
ow ACPI spec to
> > > > treat them as reserved range:
> > > > > https://uefi.org/specs/ACPI/6.5/15_System_Address_Map_Interfaces.=
html#
> > > > > uefi-memory-types-and-mapping-to-acpi-address-range-types
> > > > >
> > > > > Like I mentioned earlier, that PR is still in early phase and has=
 not reflected all
> > > > the required changes yet, but the idea is to build
> > > > gEfiMemoryTypeInformationGuid HOB from FDT reserved-memory nodes.
> > > > > UEFI generic Payload has DxeMain integrated, however Memory Types=
 are
> > > > platform-specific, for example, some platforms may need bigger runt=
ime memory
> > > > for their implementation, that's why we want such FDT reserved-memo=
ry node to
> > > > tell DxeMain.
> > > > >
> > > >
> > > > > The Payload flow will be like this:
> > > > >   Payload creates built-in default MemoryTypes table ->
> > > > >     FDT reserved-memory node to override if required (this also e=
nsures the
> > > > same memory map cross boots so ACPI S4 works) ->
> > > > >       Build gEfiMemoryTypeInformationGuid HOB by "platfom specifi=
c"
> > > > MemoryTypes Table ->
> > > > >         DxeMain/GCD to consume this MemoryTypes table and setup m=
emory
> > > > service ->
> > > > >           Install memory types table to UEFI system table.Configu=
ration table...
> > > > >
> > > > > Note: if Payload built-in default MemoryTypes table works fine fo=
r the
> > > > > platform, then FDT reserved-memory node does not need to provide =
such
> > > > 'usage' compatible strings. (optional) This FDT node could allow
> > > > flexibility/compatibility without rebuilding Payload binary.
> > > > >
> > > > > Not sure if I answered all your questions, please highlight which=
 area you need
> > > > more information.
> > > > >
> > > >
> > > > The gEfiMemoryTypeInformationGuid HOB typically carries platform de=
faults, and
> > > > the actual memory type information is kept in a non-volatile EFI va=
riable, which
> > > > gets updated when the memory usage changes. Is this different for
> > > > UefiPayloadPkg?
> > > >
> > > > (For those among the cc'ees less versed in EFI/EDK2: when you get t=
he 'config
> > > > changed -rebooting' message from the boot firmware, it typically me=
ans that this
> > > > memory type table has changed, and a reboot is necessary.)
> > > >
> > > > So the platform init needs to read this variable, or get the inform=
ation in a
> > > > different way. I assume it is the payload, not the platform init th=
at updates the
> > > > variable when necessary. This means the information flows from payl=
oad(n) to
> > > > platform init(n+1), where n is a monotonic index tracking consecuti=
ve boots of the
> > > > system.
> > > >
> > > > Can you explain how the DT fits into this? How are the runtime-code=
 and
> > > > runtime-data memory reservation nodes under /reserved-memory used t=
o
> > > > implement this information exchange between platform init and paylo=
ad? And
> > > > how do the HOB and the EFI variable fit into this picture?
> > >
> > >
> > > 1. With some offline discussion, we would move gEfiMemoryTypeInformat=
ionGuid usage to FDT->upl-custom node. This is because it is edk2 implement=
ation choice and non-edk2 PlatformInit or Payload may not have such memory =
optimization implementation. (not a generic usage/requirement for PlatformI=
nit and Payload)
> > >
> > > The edk2 example flow will be like below:
> > >
> > > PlatformInit to GetVariable of gEfiMemoryTypeInformationGuid and crea=
te Hob->
> > >   PlatformInit to initialize FDT->upl-custom node to report gEfiMemor=
yTypeInformationGuid HOB information ->
> > >     UefiPayload entry to re-create gEfiMemoryTypeInformationGuid HOB =
basing on FDT input (instead of the default MemoryType inside UefiPayload) =
->
> > >       UefiPayload DxeMain/Gcd will consume gEfiMemoryTypeInformationG=
uid Hob for memory type information ->
> > >         UefiPayload to initialize UEFI environment (mainly DXE dispat=
cher) ->
> > >           (additional FV binary appended to common UefiPayload binary=
) PlatformPayload to provide VariableService which is platform specific ->
> > >             UefiPayload UefiBootManager will SetVariable if memory ty=
pe change needed and request a warm reset ->
> > >               Back to PlatformInit ...
> > >
> >
> > OK so the upl-custom node can do whatever it needs to. I imagine these
> > will include the memory descriptor attribute field, and other parts
> > that may be missing from the /reserved-memory DT node specification?

From my side, ideally this will be empty, but it may be needed to make
things work.

> >
> > >
> > > 2. Now the proposed reserved-memory node usages will be for PlatformI=
nit to provide data which may be used by Payload or OS. This is not edk2 sp=
ecific and any PlatformInit/Payload could have same support.
> > > Note: all of below are optional and PlatformInit may choose to implem=
ent some of them or not.
> > >
> > >       - acpi
> > > If PlatformInit created some ACPI tables, this will report a memory r=
egion which contains all the tables to Payload and Payload may base on this=
 to add some more tables if required.
> > >
> > >       - acpi-nvs
> > > If PlatformInit has created some ACPI tables which having ACPI NVS me=
mory dependency, this will be that nvs region.
> > >
> >
> > These make sense.
> >
> > >       - boot-code
> > > When PlatformInit having some FW boot phase code that could be freed =
for OS to use when payload transferring control to UEFI OS
> > >
> > >       - boot-data
> > > When PlatformInit having some FW boot phase data that could be freed =
for OS to use when payload transferring control to UEFI OS.
> > >
> > >       - runtime-code
> > > PlatformInit may provide some services code that can be used for Payl=
oad to initialize UEFI Runtime Services for supporting UEFI OS.
> > >
> > >       - runtime-data
> > > PlatformInit may provide some services data that can be used for Payl=
oad to Initialize UEFI Runtime Services for supporting UEFI OS.
> > >
>
> I'll say it again. "boot" and "runtime" on their own could mean about
> anything, but the usage here is clearly tied to UEFI (or the EDK2
> implementation) and its meaning of boot and runtime. So the naming
> needs to reflect that.
>

Chasel has made a suggestion.

>
> > A UEFI OS must consume this information from the UEFI memory map, not
> > from the /reserved-memory nodes. So these nodes must either not be
> > visible to the OS at all, or carry an annotation that the OS must
> > ignore them.
>
> The kernel will process /reserved-memory for UEFI boot, so the
> expectation is anything in the EFI memory map is not present there. An
> annotation to ignore some nodes would require going back in time or
> accepting 2 sources of truth on existing OS.

The DT spec says:

>>>>>
3.5.4 /reserved-memory and UEFI
When booting via [UEFI], static /reserved-memory regions must also be
listed in the system memory map obtained
via the GetMemoryMap() UEFI boot time service as defined in [UEFI] =C2=A7
7.2. The reserved memory regions need to be
included in the UEFI memory map to protect against allocations by UEFI
applications.
<<<<<

To my reading, that means that the requirement is that the
/reserved-memory regions must be returned from the GetMemoryMap() call
too. I don't see it saying that the reserved-memory regions must be
empty, though.

>
> > Would it be possible to include a restriction in the DT schema that
> > these are only valid in the firmware boot phase?
>
> The only way ATM is including a schema or not when running validation
> on a DT for a particular boot phase. Include the schema in the project
> that wants to use these nodes and don't include it in cases that don't
> use it. I don't see a reason why this needs to be in dtschema.

We would like to use a single schema, which is dtschema. UPL
validation will eventually check this, so it needs to be correct.

Regards,
Simon

