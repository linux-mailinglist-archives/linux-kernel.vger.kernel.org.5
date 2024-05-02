Return-Path: <linux-kernel+bounces-166229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E85308B97D1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01DF286432
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A7756459;
	Thu,  2 May 2024 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DwXyx+W+"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275E456440
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642369; cv=none; b=SgbgNxlaqwbI1Qs/EGpXeaMlB2GNJzeaQ1uWQcQOHvz7QpiHXmcKRUlBP5zbLRYeW/IQiFHAkBDIBJIeY1xG3Dd9tNqSVnW47rUSY7UK/09xlV2Y9zvzk8Mx2O8liZ8upOFhMCKtOYre514dMw/150o6gm8Z6zYIK/NvZxOSDlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642369; c=relaxed/simple;
	bh=+KdPWEN16wQ9Tm9ok2b58EnczYYvk8kPtRWjVxLHs/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1uStz136EMRsjEHwR6JV5GT63arkfBcFww0cc9ajm4kY0NgYPw/Wyvy+uRPwCbN4SnNSd2TvT9KSkBrQ81stAVaMeczYGdVMI80H3f0a+n+gMQfdqpGJ+e+qL1+N+d4kX4ygmcLRJZIDdFGi0FzXog2+eRU3Gc7jJSFmo1k08M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DwXyx+W+; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ee4dcc4567so2188327a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 02:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714642367; x=1715247167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FvW/lnO7fBno/xaBzZIt3Emz2T8DvtxIkgq7/bGwou8=;
        b=DwXyx+W+pWfnM9wYHa72GjpVprpdBGam9RpvSG9+9kkamynTrgG5bloqc3+pk9W2tq
         sskWEAHuVKxFm0TbNw1gMKZM91SNaivjTutAcvLnPpj/Ss9Bc+LVEpKrwvGv7ZKG0W1v
         eNFVjAonGFfNW4CsybtnpF7Bs4L2e6P0cQHH24bP6kcWwDjugSA6nAUkDh2AmFilv7JA
         nDaST58oFc5APPG4Ej5fWXalQCqYdfKjYvXb3SqgY7sNR0+Ho1OpfO2XdLsCAHGkXtAC
         UIo29DH2UbgWh17At3cNeflKxUomjy9j0peZjL5/x2l3ms4dd3gY7SzNLtwT1zOMVUhb
         Ii5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714642367; x=1715247167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvW/lnO7fBno/xaBzZIt3Emz2T8DvtxIkgq7/bGwou8=;
        b=X7RO/KZL7pm4YxmVVtQhyXlRRaEHGxhqccXDvCah6TIiGywn41+x3H3/+JqXWnRWh1
         2V/9+JOkMEfuNLIaXVJQeRVCdMuSOKuhvaZ95TAJAWrn8qmoOb8QOr/oe1MVcToJ2p14
         gB4ADSaGTOxtQiKjZn7OHvrJzA1X2d09I94uiLJJZfgKiJKkzL1lPRqkwp2NdKZpFkEp
         P2eKUaW0/u3/rKstmr6EU0IwA8WB6wuOxpMQEuobQn3IYVNwWPRaHiL/nENf4/IedH5P
         x1fjpGN5CVIjQ7Iv+i7DVSzQBl4Ss7urmFomMCqPfR5S1k7bVTqVyETdBulpJ6uINhJC
         64vQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0rw3KPqQ7MNj5aqIAu4ofPeOlrX0ctL70Ykar1+I9Ws/CyHqtnAP1by/Y+2h0DAkz1eOZwfqIRZj7+cn8k++SAOVCFQeJxNM7Zub6
X-Gm-Message-State: AOJu0Yw6c2TsN7u6RIl16l8ESFl0kw3OSknB7b8vaJFsGZ6Dv0+X72z7
	RtIN2mCEoyElrZvIPe8w4yd6qlm9BGt04+Ww24HZz4Rsg1HznXaib+UbiTxcrnk=
X-Google-Smtp-Source: AGHT+IF4b+lPGskb1gHK2IpUgfNkpEMYBXho2rUofukPTZVb0za3mVEu5Rsh7KTHfVzjAbIKdeiEtg==
X-Received: by 2002:a05:6359:4c9e:b0:18f:673e:fce2 with SMTP id kk30-20020a0563594c9e00b0018f673efce2mr6283164rwc.6.1714642367069;
        Thu, 02 May 2024 02:32:47 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.19])
        by smtp.gmail.com with ESMTPSA id l25-20020a63ba59000000b0060795a08227sm692025pgu.37.2024.05.02.02.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:32:46 -0700 (PDT)
Date: Thu, 2 May 2024 15:02:33 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH v5 08/17] ACPI: pci_link: Clear the dependencies after
 probe
Message-ID: <ZjNdsWP46su9drAK@sunil-laptop>
References: <20240501121742.1215792-9-sunilvl@ventanamicro.com>
 <20240501165615.GA758227@bhelgaas>
 <ZjNcDyLRm9c7BAi3@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjNcDyLRm9c7BAi3@smile.fi.intel.com>

On Thu, May 02, 2024 at 12:25:35PM +0300, Andy Shevchenko wrote:
> On Wed, May 01, 2024 at 11:56:15AM -0500, Bjorn Helgaas wrote:
> > On Wed, May 01, 2024 at 05:47:33PM +0530, Sunil V L wrote:
> > > RISC-V platforms need to use dependencies between PCI host bridge, Link
> > > devices and the interrupt controllers to ensure probe order. The
> > > dependency is like below.
> > > 
> > > Interrupt controller <-- Link Device <-- PCI Host bridge.
> > > 
> > > If there is no dependency added between Link device and PCI Host Bridge,
> > > then the PCI end points can get probed prior to link device, unable to
> > > get mapping for INTx.
> > > 
> > > So, add the link device's HID to dependency honor list and also clear it
> > > after its probe.
> > > 
> > > Since this is required only for architectures like RISC-V, enable this
> > > code under a new config option and set this only in RISC-V.
> 
> ...
> 
> > > +	if (IS_ENABLED(CONFIG_ARCH_ACPI_DEFERRED_GSI))
> > > +		acpi_dev_clear_dependencies(device);
> > 
> > This is really a question for Rafael, but it doesn't seem right that
> > this completely depends on a config option.
> 
> +1 here, fells like a hack and looks like a hack.
> 
I can remove the config option. I just thought this would probably never
required to be called on other architectures.

Unless there is an objection, I will remove it in next version.

Thanks!
Sunil
> > Is there a reason this wouldn't work for all architectures, i.e., what
> > would happen if you just called acpi_dev_clear_dependencies()
> > unconditionally?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

