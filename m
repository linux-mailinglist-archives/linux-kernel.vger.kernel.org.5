Return-Path: <linux-kernel+bounces-161816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B788C8B5199
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D855281098
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E371171A;
	Mon, 29 Apr 2024 06:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="h1N4ehux"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CD333F6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372873; cv=none; b=KaYiIdtlreZDstkrUdHYYfX3Cu6i0T/TtymEbUW0Vg+UK8fdavdo41hfa+pJIzkx5JCfigW8bYL195xDLlVNPE4t0H9CSObdEoYwesrEdpoYvLJvL51jNnGGcBZiO2cE+0oQMR3oipj/8eZBHwMso5Ixq1vz4bVaqMAujODkuQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372873; c=relaxed/simple;
	bh=YeRC4XxrlBzoc6aB9nHXzHEeLpZealXCAg5sLvD6yWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ax//PO2b8c2HG4COxKDwh1TwkVpiR5ME1NDVrFJt4ojjqTYjDyoXXsadcuDkbaGPu++ZBjrGzDQ5fF19ccUdTRoR4WHHp6CVlb/5wBEZNQfRrPxt9aub/KCKhSuR1IgFdyNRii4zPCe3qxCF9Rq8txrDDZ1zHVZbwOVdPIbipNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=h1N4ehux; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1eab699fcddso30697875ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714372872; x=1714977672; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g3CHl/SFXqYAERGdLxtaMngC8S6DnU6XgXGwCxtAafo=;
        b=h1N4ehuxNf1WNo9AT27O1M9NrihbnhveVDvKhdRXUk6djD2BVg/jaAjQQNfohwmjQZ
         m8AQgehMo4iCgd23HXNFlEtW++ATzzGQ4r6fITUcpaaf0sKOL9qVZvSPko1At/+1pD34
         G3Cbm9jepoDNI3LkaGP9u9vOQtrNXSvO2Z0gGstE0ZCwDElHSjuF0I1yV8yRQX6WKQYM
         jRtOJqlPaSQ711yMHUW6OOCBYGZzuwCQC5Z4FOwnKDbbsFLnkr2JSdfFKzD0QZdhoOhn
         dNAJxtavnh8+CtDVpKJB9ssP/p+c8pjDq2nT9EXIzrKUo8UXuPiWlA0DPZ9dwF8zn3Et
         klWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714372872; x=1714977672;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3CHl/SFXqYAERGdLxtaMngC8S6DnU6XgXGwCxtAafo=;
        b=PsR05u/PdlCmD9Rsz0ac3UJyxPYUgZUDIQ0WNvpIyzX3JYBiVB8LtBAywYal6mdvi8
         fzagKpR1LDh28QXOl/kmVwN6vSf/1hqjipOTIkiRBCyapiQPVyrfoG17et/mIlJfi2Ab
         /zQGvd88Mb1VRqp3+N3siQsD+UHzFl85XvRsVDUWLrDb8Aqu01yN1R9w9VSHTdr3GdF6
         pCl2rr/wJlWYUv77O7AphYoSfSS9rl/C3YBdx5/g6Ff6oQEYQbcu5WMVSWkdH4dy36Md
         2jWF+XkzGnX8c6vwfGosibm4M9DRyW2D8FgEb3guw4FcLqiujF17wa8TqByV5VonAIWq
         EQ7A==
X-Forwarded-Encrypted: i=1; AJvYcCVrYfNbejstIDWtg2UsVBAI5+VWl+GxA4PIc4iAk70BXnZYlzJ6ZLuB4G8hWoeHQSL0wdeaU2TNwgKWP82b3Tz7Ssy26uP5K8N+eHMF
X-Gm-Message-State: AOJu0YzJe7byIUAfrFLO8R7kz98n2YSY+lUxUjkx90aNAtT3Wd2UdMh6
	LVGVm80S0oYVSiovXwj2lRnhqXz7T3U1l5vhoi5OORCz46V+adI4dnAX/7t9Nh8=
X-Google-Smtp-Source: AGHT+IHJIq5O7lAJlnVgT2TPMMefYPHPYX81CZ0/PXoTk2cDvl0s5hdpuoLRaOXaOY+XM//0LK1HGQ==
X-Received: by 2002:a17:902:bf01:b0:1e8:32ed:6f6d with SMTP id bi1-20020a170902bf0100b001e832ed6f6dmr9271613plb.39.1714372871641;
        Sun, 28 Apr 2024 23:41:11 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.62])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902bf4900b001e26b7ac950sm19421830pls.272.2024.04.28.23.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 23:41:11 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:11:00 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH v4 00/20] RISC-V: ACPI: Add external interrupt
 controller support
Message-ID: <Zi9A/KQv5fB/8nB3@sunil-laptop>
References: <20240415170113.662318-1-sunilvl@ventanamicro.com>
 <CAJZ5v0gTzn3TDoh0+0UQjMeJVdU+z16dDOT_fKMhr0XrOxyRtA@mail.gmail.com>
 <871q6uir15.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871q6uir15.fsf@all.your.base.are.belong.to.us>

On Wed, Apr 24, 2024 at 07:55:50PM +0200, Björn Töpel wrote:
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
> 
> > On Mon, Apr 15, 2024 at 7:01 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >>
> >> This series adds support for the below ECR approved by ASWG.
> >> 1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view?usp=sharing
> >>
> >> The series primarily enables irqchip drivers for RISC-V ACPI based
> >> platforms.
> >>
> >> The series can be broadly categorized like below.
> >>
> >> 1) PCI ACPI related functions are migrated from arm64 to common file so
> >> that we don't need to duplicate them for RISC-V.
> >>
> >> 2) Added support for re-ordering the probe of interrupt controllers when
> >> IRQCHIP_ACPI_DECLARE is used.
> >>
> >> 3) To ensure probe order between interrupt controllers and devices,
> >> implicit dependency is created similar to when _DEP is present.
> >>
> >> 4) When PNP devices like Generic 16550A UART, have the dependency on the
> >> interrupt controller, they will not be added to PNP data structures. So,
> >> added second phase of pnpacpi_init to handle this.
> >>
> >> 5) ACPI support added in RISC-V interrupt controller drivers.
> >>
> >> This series is still kept as RFC to seek feedback on above design
> >> changes. Looking forward for the feedback!
> >
> > I've looked at the patches and I don't see anything deeply concerning
> > in them from the ACPI core code perspective.
> >
> > The changes look reasonably straightforward to me.
> 
> Sunil, given Rafael's input, it sounds like it's time for a patch
> proper. This is really the missing piece to make ACPI usable on RISC-V!
> 
> Thanks for the nice work!
> Björn
> 
> FWIW,
> Tested-by: Björn Töpel <bjorn@rivosinc.com>
> 
Sorry for the delayed response. I was AFK last week.

Many thanks!!, Rafael. Let me send next version without RFC.

Thank you very much Björn for testing it.

Thanks,
Sunil

