Return-Path: <linux-kernel+bounces-150226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353038A9BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA292824D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894C21649D5;
	Thu, 18 Apr 2024 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="EFqRllpU"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF410168AE7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448748; cv=none; b=GbtkadKMXufFSegVXmLS46j2+kgd25xBWwEFQZJZBOL8Xwj+IWi59uS5lsblAQI4TJxY9yCuZlhb53oRLUU2k6NtIybvZhsCbMYcIHYj/cJmdU4DDFyvuWYVZhAZKhqKsZh2qattQ8D8KnYe6MAqAKINupoB+CBeKvUzegMJYhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448748; c=relaxed/simple;
	bh=JT3JZZTJ2Qm1KqHFfbHbqKzfMjaDTTZGcTW42XX/i6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwJgvNiH5h8hFhJd0rDSZQkwZBq6zHG3mygV8DpQ9uwJ26zrhewTngAg8Ihi2b1heHjjsZsCirImzwmL48s9NGJkVLUC4ajxzfh0AuIm5QrbHanhzOfo5W19ExVAYJn8HXzMHzSQhG4F3p/mP8ZBtcYlJAVpcxfk8QofJEmAJ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=EFqRllpU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed627829e6so1051435b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713448745; x=1714053545; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WZO5tEmqpe+L1U/C8UD1PE69dEQv50EfBPcTW8iw+NY=;
        b=EFqRllpUznQCo9ebi00bs037YgXrZGTZjAcg3vZCFxw3n06tCB0+o7suTEzq38YYm6
         yxzw20WLK+XijfWp9D7eaWDoH9woI7UjOQDKziPhgoRPp8yLx1eLshOfdnJcb8NTVuXm
         teTu/VlH3/uj/lix7cIR5+J4+s4sTyqmfLZXK2Aj3i9h9n4Uaos/wOrBmjRrIKC8+PWG
         UqsSBrywjrD/Erowl65CiqC5VWaISUwBe9k/wAe3NNfhsUgkVdpfXz/ac93mhI8IPavN
         b4mgkjt++q9V0hmKlKv50Gdy+32wzph4I8FU0Q2gzRPHG08dEZaYjq33xkXHQR5KkBBw
         LnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713448745; x=1714053545;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZO5tEmqpe+L1U/C8UD1PE69dEQv50EfBPcTW8iw+NY=;
        b=o9WYj/LQk/vkHyCh53qNxx29qAGU0HjSqWMaV7qO56SNNc+T2wCdbYlF7olAgbPK4+
         PEazJixHVzVrX7YPLOvkufS4Zk8fisWokzRSKlXRHmfJ3QmW/uzW43KaKQrMH6wcDlyJ
         Jjw62emkkuNZ3o9htoRu9NLT6aLrVkwSS4u0VCaYrdHgx1QXmIKcL2zL2zwuY9uO6h+1
         6yJt8uIUs3YCRkYgxT+1XU2wlizgnsg7RZ557mEZlu5bPIZydDTwQdTDnUzc2XHnSYx5
         a3rFIFpkilbrUn9YnN/uqTHdUJCo7WiB/KIZxICgxiwtazZp1Qfwws8s79RpJisz1k33
         1iXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlzFnKVgd8xk0+I5TXZutWlp/8COX1oMhS8tve3XCP4uccJFkOBpLwAzYw4fmmD6bn/9leIDLRBn7tut3uTw7cj7+M44SAxz5qBGt4
X-Gm-Message-State: AOJu0YwORMzvpgCBpfBIm3dhK5m3RLHA1SnrlNUqo96B/fULYUcYI2xv
	Y1pTzU45mKuBqRxtVWe64WMtS56PvvwFCivRy5TLUDFuDsSJ5s0RGnN9o79IU9Q55IJZcIeK9Kc
	A8s4=
X-Google-Smtp-Source: AGHT+IGUjEe5kgj82Lo/86KEUqPTE4pNtd6avdOYxdh0NqwVwVbNQ8pG380MXUqn5yro6JHyVQnxWQ==
X-Received: by 2002:a05:6a00:8a0f:b0:6ec:da6c:fd69 with SMTP id ic15-20020a056a008a0f00b006ecda6cfd69mr2885160pfb.7.1713448744818;
        Thu, 18 Apr 2024 06:59:04 -0700 (PDT)
Received: from sunil-laptop ([106.51.189.72])
        by smtp.gmail.com with ESMTPSA id km3-20020a056a003c4300b006eaa21301a7sm1488660pfb.162.2024.04.18.06.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:59:04 -0700 (PDT)
Date: Thu, 18 Apr 2024 19:28:54 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [RFC PATCH v4 00/20] RISC-V: ACPI: Add external interrupt
 controller support
Message-ID: <ZiEnHtWbT04bXYmP@sunil-laptop>
References: <20240415170113.662318-1-sunilvl@ventanamicro.com>
 <87a5lqsrvh.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a5lqsrvh.fsf@all.your.base.are.belong.to.us>

On Thu, Apr 18, 2024 at 03:49:22PM +0200, Björn Töpel wrote:
> Sunil V L <sunilvl@ventanamicro.com> writes:
> 
> > This series adds support for the below ECR approved by ASWG.
> > 1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view?usp=sharing
> >
> > The series primarily enables irqchip drivers for RISC-V ACPI based
> > platforms.
> >
> > The series can be broadly categorized like below. 
> >
> > 1) PCI ACPI related functions are migrated from arm64 to common file so
> > that we don't need to duplicate them for RISC-V.
> >
> > 2) Added support for re-ordering the probe of interrupt controllers when
> > IRQCHIP_ACPI_DECLARE is used.
> >
> > 3) To ensure probe order between interrupt controllers and devices,
> > implicit dependency is created similar to when _DEP is present.
> >
> > 4) When PNP devices like Generic 16550A UART, have the dependency on the
> > interrupt controller, they will not be added to PNP data structures. So,
> > added second phase of pnpacpi_init to handle this.
> >
> > 5) ACPI support added in RISC-V interrupt controller drivers.
> >
> > This series is still kept as RFC to seek feedback on above design
> > changes. Looking forward for the feedback!
> >
> > Changes since RFC v3:
> > 	1) Moved to _DEP method instead of fw_devlink.
> > 	2) PLIC/APLIC driver probe using namespace devices.
> > 	3) Handling PNP devices as part of clearing dependency.
> > 	4) Rebased to latest linux-next to get AIA DT drivers.
> >
> > Changes since RFC v2:
> > 	1) Introduced fw_devlink for ACPI nodes for IRQ dependency.
> > 	2) Dropped patches in drivers which are not required due to
> > 	   fw_devlink support.
> > 	3) Dropped pci_set_msi() patch and added a patch in
> > 	   pci_create_root_bus().
> > 	4) Updated pnp_irq() patch so that none of the actual PNP
> > 	   drivers need to change.
> >
> > Changes since RFC v1:
> > 	1) Abandoned swnode approach as per Marc's feedback.
> > 	2) To cope up with AIA series changes which changed irqchip driver
> > 	   probe from core_initcall() to platform_driver, added patches
> > 	   to support deferred probing.
> > 	3) Rebased on top of Anup's AIA v11 and added tags.
> >
> > To test the series,
> >
> > 1) Qemu should be built using the riscv_acpi_namespace_v1 branch at
> > https://github.com/vlsunil/qemu.git
> >
> > 2) EDK2 should be built using the instructions at:
> > https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README.md
> 
> Hi Sunil,
> 
> I started playing with your work, and FYI: Using U-boot instead of EDK2
> works out of the box (with acpi.config added to U-boot).
> 
> I changed my rootfs/boot tooling like [1], and it boots.
> 
> (For those who prefer working with U-boot UEFI instead of EDK2.)
> 
> 
Hi Björn,

This is cool!. I was not aware that u-boot also supports ACPI on
RISC-V. Many thanks!

Thanks,
Sunil

