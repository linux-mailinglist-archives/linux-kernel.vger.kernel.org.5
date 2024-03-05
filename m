Return-Path: <linux-kernel+bounces-91910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF32871843
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9771C2138C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334D44D9FF;
	Tue,  5 Mar 2024 08:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uw/MJvFY"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4064D9F9;
	Tue,  5 Mar 2024 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709627548; cv=none; b=AI7Nw3wn2oey3tR+Onu/IANZPqVf745KmyBB9ATQXdC1Gvo1PcJhyRY8UQdyeLxbkQIqkeHlL2+3Zi3e1GEHgZierJtNbm+9NzBGCWCYxb3N8lvk5njjFlsJsKagtWqk9PoKe7Ry8qigU/yNsRwoSs88qQo9wASr43F5j0m2gSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709627548; c=relaxed/simple;
	bh=tqTaYVx4Sf4z2nZaPA9gTuNW0DhU57NkHahdzD5dQJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VoQxmdZ9w4W8SY8VuSOOPmm8qdlBo0+7+sMs84R1uDDbQV+Cz5j1iCoBo8viw6bc6R/vGYQ/03XVEEb2Ydepy5mwcAYRQ/KGU3aD+peNR8QnKoFKuRNkPvZ3VUr18iQOyzsS9YnEx/3NK2EYyR10rHwUpj0FDR+UuBmHe7nBv6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uw/MJvFY; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so68156201fa.1;
        Tue, 05 Mar 2024 00:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709627545; x=1710232345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ethXSKdD3YM8zYFiv0Mh/2ibhnJt7eqBZOvLVeN7M8o=;
        b=Uw/MJvFYZtOLCSbgZP1qlnf76YVQQDORmx9QoCRz4VbgtTkBPXXjAB+U7hoIRFT8pc
         FKssfeP47fRVC18Gvizob1ygF5Cf28oSSEm/tl1PuFQuzef0Dd8KzuKChmHfvW6x9D/f
         /nu5iz/E8OpPjMqt4LWNHldEk96zkCcE2i9P1Lo8zMLUj39QUeGnPHtz1vI34rbOqB5X
         56ylgx7rYnhs0ndxc+cRC0kbAnqZyznZNnb1eyx64LiOiBYwTxamQnpQcs8os5sv4+SO
         0Qplw/rsWewcd9q7if8gHEoyY/iqieLYIy/RKX+sSoZheW/An5rOvZtT3VCPcthrc0rd
         PqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709627545; x=1710232345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ethXSKdD3YM8zYFiv0Mh/2ibhnJt7eqBZOvLVeN7M8o=;
        b=Eefihs7sW1Wrfm4MZmRnrTSeTNJUtQV2l3VcHWvEv/1k/KufLFOtBFJHTZkPYnWP6G
         0C5wyO2S/xyz4XlklBVJeTX5TdhEDiLFyhSlbcOc5pODtPsOJ7K0SofyJP7NQbgGy3y7
         /0io8xQYGLEcXGPf4YcvC2h5oNMnBxPekB7pyGo4eQKkYwle7wcaQuNFyR9FDNT1HBze
         1dSm9qo/B+2yI1VPmm1iALa32QeRw/bO8Bn81KOc6frlpORoXz3WfgNLWn2yHkHBcnJO
         9PXP+mnXYD9zPfiPbSeppsFIMSJynYUy5Z8yf0GWUBMDFprckRwAB+kZAHVhyH/3xcUO
         3o4A==
X-Forwarded-Encrypted: i=1; AJvYcCU9+xHeX8a1QP/+DpCzhyLz3EWJPP1lrKbP7BzLL/wJF75gDOVUQuhGVmp9GFQGRC7M99NWqf8v30EpkHsAJB9vbiP8JpbkJiXK52TIQ2XANYYR+P7isRtCV4lMVBpYpRiKghBcSYOrNA==
X-Gm-Message-State: AOJu0YzI4QMiYGuCzMKgWGtSYzzGBMJZ2yauwsw9lPumvOPcuwLutlrR
	pMNz3TMuDrInxZtIuQdxOYaPoLZFCKZkuVcm4I2/HgG7YsNhbG7yyRUaiojt30jy89lvdhxHJJF
	4J8QdH99f7H68N6YgsxhSCpC+Tl8=
X-Google-Smtp-Source: AGHT+IHOYeWGaFKAzUJPrDZmmHE+LVTyfiv0q3uVMfUxGU07PXgnFSmnCFMHXZtTfZpJfuf1uxbMfPp+8OPCiwRzXhU=
X-Received: by 2002:a2e:a23b:0:b0:2d2:b915:e073 with SMTP id
 i27-20020a2ea23b000000b002d2b915e073mr631884ljm.27.1709627544665; Tue, 05 Mar
 2024 00:32:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706603678.git.haibo1.xu@intel.com> <0be49d4d7d7e43933534aad6f72b35d3380519fd.1706603678.git.haibo1.xu@intel.com>
 <ZeatCIUZ/eJa1WHs@sunil-laptop>
In-Reply-To: <ZeatCIUZ/eJa1WHs@sunil-laptop>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Tue, 5 Mar 2024 16:32:13 +0800
Message-ID: <CAJve8onPknQLfZNwUMUm3SSy8rPOJoLvcbzNAFB64EuznEn2jA@mail.gmail.com>
Subject: Re: [PATCH 4/4] ACPI: RISCV: Enable ACPI based NUMA
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Anup Patel <apatel@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Jisheng Zhang <jszhang@kernel.org>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Baoquan He <bhe@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Chen Jiahao <chenjiahao16@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
	James Morse <james.morse@arm.com>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Evan Green <evan@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Tony Luck <tony.luck@intel.com>, Yuntao Wang <ytcoode@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 1:26=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com>=
 wrote:
>
> On Wed, Jan 31, 2024 at 10:32:01AM +0800, Haibo Xu wrote:
> > Enable ACPI based NUMA for RISCV in Kconfig.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  arch/riscv/Kconfig        | 1 +
> >  drivers/acpi/numa/Kconfig | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index bffbd869a068..e586ab959f34 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -438,6 +438,7 @@ config NUMA
> >       select HAVE_SETUP_PER_CPU_AREA
> >       select NEED_PER_CPU_EMBED_FIRST_CHUNK
> >       select NEED_PER_CPU_PAGE_FIRST_CHUNK
> > +     select ACPI_NUMA if ACPI
> >       select OF_NUMA
> >       select USE_PERCPU_NUMA_NODE_ID
> >       help
> > diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
> > index 849c2bd820b9..525297c44250 100644
> > --- a/drivers/acpi/numa/Kconfig
> > +++ b/drivers/acpi/numa/Kconfig
> > @@ -2,7 +2,7 @@
> >  config ACPI_NUMA
> >       bool "NUMA support"
> >       depends on NUMA
> > -     depends on (X86 || ARM64 || LOONGARCH)
> > +     depends on (X86 || ARM64 || LOONGARCH || RISCV)
> Is it possible to remove this if IA64 is removed now?
>

Yes. Arnd also suggest removing this totally.
Will update it in v2.

> Thanks,
> Sunil
> >       default y if ARM64
> >
> >  config ACPI_HMAT
> > --
> > 2.34.1
> >

