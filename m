Return-Path: <linux-kernel+bounces-6375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365038197E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6561C24645
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181E5DDC6;
	Wed, 20 Dec 2023 04:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XEObP6NA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA760C153
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-552d39ac3ccso666715a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703047576; x=1703652376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ObOjGHxxzANzBA20+fRUpz/qy8ssxRN2M1oEwSnchMg=;
        b=XEObP6NAyuPE33DE6Fp3QBXNAaZNZth6v2xSsGDHfV118mNirehzBug2ojRxg7Z3Kg
         UqzXHMrmgnJBzatxZfE/5S0O0DFLGABlk/vO+UQKjMLV0/3rT+6ULQtYgV3ppqSmy2MC
         erFWBrsajNh7TULP7URSJ/kkXeZixhXeNUCko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703047576; x=1703652376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObOjGHxxzANzBA20+fRUpz/qy8ssxRN2M1oEwSnchMg=;
        b=bhttpDjFKQ08aupLcsGTvnVb8HLmjgvdJKpAPc77fjFtADjIAMUhOCtcqeIZn6b+n1
         JPGHbjK63VMkWjNbMMiYTPsixVBTh0kYvltAmEIXYkoI5xo2gmMLTEU09Lyd/dBybp7k
         RAESulwOIB/idC1cHznnKL7F+yFyCQyoJCRfaghVIA4q+db62gOmPYNdX2ASdj90zSGq
         eMydEOFiL2Xhis1vb3AaacJwKk85sE2S+PuDyD8W/FkXSLJbhu52bEaqPkroovbP+gS/
         bC81iLbJK9m5uirroaXcqn1abAOvdhNUR0VuO46odt9Dwcuke8lQmqpITjupmk6bWaX9
         fISA==
X-Gm-Message-State: AOJu0YxW33WpXYEA0v71PpbV71pP0PCnhU5FzbQGPYn27ZXoJmjUU0jG
	50c9/IA4d0S6EJo1wf2vlfhnjtqnoL/v+IYvc+lcjfZ5f7j/
X-Google-Smtp-Source: AGHT+IFiAtnYS6LXvMS3hEaXi1ylgrBmLLhNN+uioKFv9mVb/Ycop0Bj8klqTrKKv5ovgt1osw7sDYHdsp6TNkdiWcg=
X-Received: by 2002:a17:906:c15:b0:a26:8f35:20e3 with SMTP id
 s21-20020a1709060c1500b00a268f3520e3mr484981ejf.4.1703047576066; Tue, 19 Dec
 2023 20:46:16 -0800 (PST)
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
 <CAPnjgZ0ngqCyC36QVAFWu07p+7SHNQhsuo0MYstTawnbDEEmLw@mail.gmail.com>
In-Reply-To: <CAPnjgZ0ngqCyC36QVAFWu07p+7SHNQhsuo0MYstTawnbDEEmLw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:46:04 -0700
Message-ID: <CAPnjgZ1EDx=NtC9aPSVYUwoLRzA3M0rXnDeWxxsEnSUVs8N4FQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To: "Chiu, Chasel" <chasel.chiu@intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Rob Herring <robh@kernel.org>, "Tan, Lean Sheng" <sheng.tan@9elements.com>, 
	lkml <linux-kernel@vger.kernel.org>, Dhaval Sharma <dhaval@rivosinc.com>, 
	"Brune, Maximilian" <maximilian.brune@9elements.com>, Yunhui Cui <cuiyunhui@bytedance.com>, 
	"Dong, Guo" <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>, 
	ron minnich <rminnich@gmail.com>, "Guo, Gua" <gua.guo@intel.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, 11 Dec 2023 at 10:52, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Tue, 28 Nov 2023 at 13:31, Chiu, Chasel <chasel.chiu@intel.com> wrote:
> >
> >
> >
> >
> > > -----Original Message-----
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > > Sent: Tuesday, November 28, 2023 10:08 AM
> > > To: Chiu, Chasel <chasel.chiu@intel.com>
> > > Cc: Simon Glass <sjg@chromium.org>; devicetree@vger.kernel.org; Mark Rutland
> > > <mark.rutland@arm.com>; Rob Herring <robh@kernel.org>; Tan, Lean Sheng
> > > <sheng.tan@9elements.com>; lkml <linux-kernel@vger.kernel.org>; Dhaval
> > > Sharma <dhaval@rivosinc.com>; Brune, Maximilian
> > > <maximilian.brune@9elements.com>; Yunhui Cui <cuiyunhui@bytedance.com>;
> > > Dong, Guo <guo.dong@intel.com>; Tom Rini <trini@konsulko.com>; ron minnich
> > > <rminnich@gmail.com>; Guo, Gua <gua.guo@intel.com>; linux-
> > > acpi@vger.kernel.org; U-Boot Mailing List <u-boot@lists.denx.de>
> > > Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory
> > > usages
> > >
> > > You are referring to a 2000 line patch so it is not 100% clear where to look tbh.
> > >
> > >
> > > On Tue, 21 Nov 2023 at 19:37, Chiu, Chasel <chasel.chiu@intel.com> wrote:
> > > >
> > > >
> > > > In PR, UefiPayloadPkg/Library/FdtParserLib/FdtParserLib.c, line 268 is for
> > > related example code.
> > > >
> > >
> > > That refers to a 'memory-allocation' node, right? How does that relate to the
> > > 'reserved-memory' node?
> > >
> > > And crucially, how does this clarify in which way "runtime-code" and "runtime-
> > > data" reservations are being used?
> > >
> > > Since the very beginning of this discussion, I have been asking repeatedly for
> > > examples that describe the wider context in which these reservations are used.
> > > The "runtime" into runtime-code and runtime-data means that these regions have
> > > a special significance to the operating system, not just to the next bootloader
> > > stage. So I want to understand exactly why it is necessary to describe these
> > > regions in a way where the operating system might be expected to interpret this
> > > information and act upon it.
> > >
> >
> >
> > I think runtime code and data today are mainly for supporting UEFI runtime services - some BIOS functions for OS to utilize, OS may follow below ACPI spec to treat them as reserved range:
> > https://uefi.org/specs/ACPI/6.5/15_System_Address_Map_Interfaces.html#uefi-memory-types-and-mapping-to-acpi-address-range-types
> >
> > Like I mentioned earlier, that PR is still in early phase and has not reflected all the required changes yet, but the idea is to build gEfiMemoryTypeInformationGuid HOB from FDT reserved-memory nodes.
> > UEFI generic Payload has DxeMain integrated, however Memory Types are platform-specific, for example, some platforms may need bigger runtime memory for their implementation, that's why we want such FDT reserved-memory node to tell DxeMain.
> >
> > The Payload flow will be like this:
> >   Payload creates built-in default MemoryTypes table ->
> >     FDT reserved-memory node to override if required (this also ensures the same memory map cross boots so ACPI S4 works) ->
> >       Build gEfiMemoryTypeInformationGuid HOB by "platfom specific" MemoryTypes Table ->
> >         DxeMain/GCD to consume this MemoryTypes table and setup memory service ->
> >           Install memory types table to UEFI system table.Configuration table...
> >
> > Note: if Payload built-in default MemoryTypes table works fine for the platform, then FDT reserved-memory node does not need to provide such 'usage' compatible strings. (optional)
> > This FDT node could allow flexibility/compatibility without rebuilding Payload binary.
> >
> > Not sure if I answered all your questions, please highlight which area you need more information.
>
> Any more thoughts on this? If not, I would like to see this patch
> applied, please.

I am really not sure who or what is holding this up, so far.

Can we perhaps get this applied in time for Christmas? It would be a
nice end to the year.

Regards,
Simon

