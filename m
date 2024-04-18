Return-Path: <linux-kernel+bounces-149995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EA28A98E2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3791F23577
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7278015E7F1;
	Thu, 18 Apr 2024 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="iQo+TlDy"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CF115E5DA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440767; cv=none; b=LFsvMzDURImMSn7NSXmhtRHHvjwwXBJG8g8PyNU7qbG26bP4OrMPWHxrMO0PAhROrxDNWuO5IXaxEQTL6se4N3oA8ZLB21RDMnIoHNaR2vsTbA3B2UaSb0J1vufPfVDzU7HaIOPn0beZA3zagjPLfI0ErPkb/Omp1wUSAvCfAxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440767; c=relaxed/simple;
	bh=RRGuCpmn9QpJJtwiZl5qPKqvfeSljByY3/4eHt18EWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ui7Bs2xoHUG/qQtHLXhPVC0YFsVE85PgWedtxdhKPeBFoGneaFkooBDlbnhV0VTaJGFM/4MHKssykYxbZVhinKZe2IQ7aTmGS0GKzObGHLoy+HcY51/jHP3elKl8jDkGUv/xLmqALelPIvZI3XGYpQM4lEk01KVjCpQTC5D5cpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=iQo+TlDy; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e65a1370b7so8119835ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713440765; x=1714045565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tse31PpId242mWCWoF9F68b2IO88pQ6rFBjaTyilK9M=;
        b=iQo+TlDywmHMl4Buq7NOY0BwGRvebw27unc4YP03pPwcPemPAms43l7rGhj3hw7jC5
         jK8rdRo1RS+LPM22dC9Rd2iXbuuZDOhkt+ibIxG7+e38898IxQVqp0qTXuB6ne3KHE5W
         nm46xElg/pj4z2XH2mJqUqxx0MxqXfl+p9je3kn77NEJN5kwtOKYTuy69AY1Qu4SEcMB
         LQ21dEiiyOqwmLhk8kGmgCotVCX8f7DImiPAHFqnd4T9bhu06NIrS4IhSXbTb8AQkylu
         gYdlNXd7atb4do6kkJ81V2elkTQrn1p5QmlcyfBP2bXSGT+PkjtFVZUo+UzG05w9/Dks
         yPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713440765; x=1714045565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tse31PpId242mWCWoF9F68b2IO88pQ6rFBjaTyilK9M=;
        b=dHYJTA2HZVQBO8XB4kWC1wafNcS5ZvV6vCFcJkkSqICYfuzEMgfI1K/Fg/ymllvgyu
         3DGau2X7yhRyLyFpY+mcHSMUbU51LimZMBXPuf+87vCotCPjVrFeKfy+MGVZ3K5t6lKp
         wWFrLQ7BG0F8g/+wXn3jpFz9qRVKLuPysmGWDpeMXBBqr+vNK4eTMIA6PQO3tfmIcds0
         GPRwStANs5ZVcnlK8X7dLZwwNOECSWLDiMDHnoP1w/86A06a+bOW2CiCZvP0GHa4zhCo
         CPuJB3Ja7rEqR/pNvbYKi1UNieCbEClSmfO6O0qVUyEh5YvoMe40api6E0FHL2wPx2Jm
         1FCA==
X-Forwarded-Encrypted: i=1; AJvYcCUPpLr2tgLua0uRfhEAx/dNfCnb7w8urZyG9TZzge/qmD9qwEC7DkanFakY/lM9P9k0byV2ErGfJWQ/8IbVOOhMtatno5nv1KJOn5+y
X-Gm-Message-State: AOJu0YzowBWxbNx3w70MDCA5ZBZgZ0NFxsA1O8zN5hH4mplHYTrFYMaL
	annYjY6DD1M6ca5e90+7ZaQc68vfH8B+ErcCy/Yqz4/9C7u+apSa2XVevY/hv54=
X-Google-Smtp-Source: AGHT+IHRN0PX0++JRfnr2/T3yLJtW4R020dQU6g3OEB6EOIeUseXqxzCCZJlgMQ9PVF1Si/Jw1nqbQ==
X-Received: by 2002:a17:902:ec90:b0:1e4:911b:7a6b with SMTP id x16-20020a170902ec9000b001e4911b7a6bmr3458551plg.61.1713440764817;
        Thu, 18 Apr 2024 04:46:04 -0700 (PDT)
Received: from sunil-laptop ([106.51.189.72])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902ec8100b001e5cadbdf8csm1327734plg.37.2024.04.18.04.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:46:04 -0700 (PDT)
Date: Thu, 18 Apr 2024 17:15:53 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [RFC PATCH v4 03/20] PCI: Make pci_create_root_bus() declare its
 reliance on MSI domains
Message-ID: <ZiEH8VF6VhCMnXz1@sunil-laptop>
References: <Zh41pOmtAJ0EcbiN@sunil-laptop>
 <20240416204653.GA164172@bhelgaas>
 <Zh/rroBTGTq/Q/FN@sunil-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh/rroBTGTq/Q/FN@sunil-laptop>

Hi Bjorn,

On Wed, Apr 17, 2024 at 09:03:13PM +0530, Sunil V L wrote:
<snip>
> 
> I think fundamentally there are two issues here.
> 
> 1) MSI domain should have been setup properly when
> pci_register_host_bridge() is called. I see that pci_arch_init() which
> is supposed to get called early calls x86_create_pci_msi_domain().
> pci_register_host_bridge() also calls pci_set_bus_msi_domain() to setup
> the MSI domain which can walk up to host bridge to find. So, not sure
> why PCI_BUS_FLAGS_NO_MSI is getting set. Is there an issue in walking up
> the tree?
> 
I think I understand now why this is happening on X86. In X86, even
though x86_create_pci_msi_domain() sets up the MSI domain, it never
informs IRQ framework. Only later in pcibios_device_add(), the device's
MSI domain will be set which is too late for this bridge logic. So, when
pci_set_bus_msi_domain() is called from pci_register_host_bridge(), it
will not get it.

It works in RISC-V (I guess ARM64 as well) because, the irqchip driver
for MSI controller registers using pci_msi_register_fwnode_provider().
But, if we set bridge->msi_domain = true in X86, it will disable MSI
even though it supports MSI which is really bad.

Please correct me if I am wrong with the analysis. If correct, what do
you think the way forward if using CONFIG option is not good? I tried to
register the domain in below commit but I don't feel it is a cleaner way.
https://github.com/vlsunil/linux/commit/d6cf76f10c225c94fffb286b7a3e803a4e37df54

Thanks,
Sunil

