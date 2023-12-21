Return-Path: <linux-kernel+bounces-8571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060A881B98D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2314286389
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603111D6A9;
	Thu, 21 Dec 2023 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqxSU2SK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0522659;
	Thu, 21 Dec 2023 14:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2CAC433D9;
	Thu, 21 Dec 2023 14:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703169054;
	bh=OEBZ6p63sjTkW3Yk5dnKU9NG+4OMfKh+D8wi0t4gbvI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sqxSU2SKjq4jOLnNVZKMvhtezYvRUhITev29n1eiJrV6KHKvK32a8N98JqBX13gKL
	 +OkLSfVCc3pzXUKumWzd8RaPCjYAwA973k5lQ76XhEmd+S7RXbidLj6h6HPA+h/b2r
	 v3sRJtJ5dfX13Z7Z76mRY3LOMhO3pP0mLxgGXLPa7KTvnm8/lsQrEkpQ8qLZH9hlEZ
	 n7vQnD6jJNsAadbmFeX1RN5dtVKvJGl+H6tDI0fi9xh/y5LAKBq+1/rAFx7nxlp5Km
	 3yXJa3ji+YQKhFXvmhHmEtnohhBo7FoiVQ+FXOWM1JwUqZWRzFTA2Ul2lhc3QRZZrH
	 hdVi0NLA+r0jQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e587fb62fso1304383e87.2;
        Thu, 21 Dec 2023 06:30:53 -0800 (PST)
X-Gm-Message-State: AOJu0YwP/JWlLcoVW8/OERTr0SDf01aPew4QPzazR/wmwYbpxGXFkL0m
	BVpglwNlC3+hZBNM+bROnKnsL+J/OfDIM5Z5ZwU=
X-Google-Smtp-Source: AGHT+IHPdxcsw7CIc8Zz9R57s+h3yCpmC0MOks9IUm441YI5k7PHlncS4N04abFTrQMbhLyNWoHo0BpkrAZ7Up7QGeI=
X-Received: by 2002:ac2:419a:0:b0:50c:222b:2489 with SMTP id
 z26-20020ac2419a000000b0050c222b2489mr9235479lfh.135.1703169052253; Thu, 21
 Dec 2023 06:30:52 -0800 (PST)
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
 <CAMj1kXHbM+ArLgNZgnmiok4gOfv6QLYxzyB9OCwfhEkJ2xGK_g@mail.gmail.com> <BN9PR11MB5483C2FBCD07DE61DCCDB523E6BCA@BN9PR11MB5483.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5483C2FBCD07DE61DCCDB523E6BCA@BN9PR11MB5483.namprd11.prod.outlook.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 21 Dec 2023 15:30:40 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHmu=ykgBMRiFqG4_ra3FJtHa=GASoMUJswdMFa9v4Xgw@mail.gmail.com>
Message-ID: <CAMj1kXHmu=ykgBMRiFqG4_ra3FJtHa=GASoMUJswdMFa9v4Xgw@mail.gmail.com>
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

On Tue, 28 Nov 2023 at 21:31, Chiu, Chasel <chasel.chiu@intel.com> wrote:
>
>
>
>
> > -----Original Message-----
> > From: Ard Biesheuvel <ardb@kernel.org>
> > Sent: Tuesday, November 28, 2023 10:08 AM
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
> > You are referring to a 2000 line patch so it is not 100% clear where to look tbh.
> >
> >
> > On Tue, 21 Nov 2023 at 19:37, Chiu, Chasel <chasel.chiu@intel.com> wrote:
> > >
> > >
> > > In PR, UefiPayloadPkg/Library/FdtParserLib/FdtParserLib.c, line 268 is for
> > related example code.
> > >
> >
> > That refers to a 'memory-allocation' node, right? How does that relate to the
> > 'reserved-memory' node?
> >
> > And crucially, how does this clarify in which way "runtime-code" and "runtime-
> > data" reservations are being used?
> >
> > Since the very beginning of this discussion, I have been asking repeatedly for
> > examples that describe the wider context in which these reservations are used.
> > The "runtime" into runtime-code and runtime-data means that these regions have
> > a special significance to the operating system, not just to the next bootloader
> > stage. So I want to understand exactly why it is necessary to describe these
> > regions in a way where the operating system might be expected to interpret this
> > information and act upon it.
> >
>
>
> I think runtime code and data today are mainly for supporting UEFI runtime services - some BIOS functions for OS to utilize, OS may follow below ACPI spec to treat them as reserved range:
> https://uefi.org/specs/ACPI/6.5/15_System_Address_Map_Interfaces.html#uefi-memory-types-and-mapping-to-acpi-address-range-types
>
> Like I mentioned earlier, that PR is still in early phase and has not reflected all the required changes yet, but the idea is to build gEfiMemoryTypeInformationGuid HOB from FDT reserved-memory nodes.
> UEFI generic Payload has DxeMain integrated, however Memory Types are platform-specific, for example, some platforms may need bigger runtime memory for their implementation, that's why we want such FDT reserved-memory node to tell DxeMain.
>

> The Payload flow will be like this:
>   Payload creates built-in default MemoryTypes table ->
>     FDT reserved-memory node to override if required (this also ensures the same memory map cross boots so ACPI S4 works) ->
>       Build gEfiMemoryTypeInformationGuid HOB by "platfom specific" MemoryTypes Table ->
>         DxeMain/GCD to consume this MemoryTypes table and setup memory service ->
>           Install memory types table to UEFI system table.Configuration table...
>
> Note: if Payload built-in default MemoryTypes table works fine for the platform, then FDT reserved-memory node does not need to provide such 'usage' compatible strings. (optional)
> This FDT node could allow flexibility/compatibility without rebuilding Payload binary.
>
> Not sure if I answered all your questions, please highlight which area you need more information.
>

The gEfiMemoryTypeInformationGuid HOB typically carries platform
defaults, and the actual memory type information is kept in a
non-volatile EFI variable, which gets updated when the memory usage
changes. Is this different for UefiPayloadPkg?

(For those among the cc'ees less versed in EFI/EDK2: when you get the
'config changed -rebooting' message from the boot firmware, it
typically means that this memory type table has changed, and a reboot
is necessary.)

So the platform init needs to read this variable, or get the
information in a different way. I assume it is the payload, not the
platform init that updates the variable when necessary. This means the
information flows from payload(n) to platform init(n+1), where n is a
monotonic index tracking consecutive boots of the system.

Can you explain how the DT fits into this? How are the runtime-code
and runtime-data memory reservation nodes under /reserved-memory used
to implement this information exchange between platform init and
payload? And how do the HOB and the EFI variable fit into this
picture?

