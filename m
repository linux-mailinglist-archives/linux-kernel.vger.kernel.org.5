Return-Path: <linux-kernel+bounces-66788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84688856185
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17946291101
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8527312AAC1;
	Thu, 15 Feb 2024 11:27:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CC260DC5;
	Thu, 15 Feb 2024 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996448; cv=none; b=AIEv1eSSoh7UCdEloPTIdIGAeFQAMY1Ex1L6XwOSShZFt1/jQw/0Ihdqb+F1nSHfCoc6kVinJNRa7z3JoXYrmANtg83aAxLZEcToNrAMO+8pNCCFaZNgsjoRwyaPrsPbjEDKAQsnN2vJ1k23ciwswlZVLNflcrhJJtIiCYKIXYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996448; c=relaxed/simple;
	bh=pneRKOG04Q5HEf5H9t1s/vwSw+7DjCJ4W7QwhEnz3pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B55X9Y5L+MRGeLPKsS/OKwWMmY2C8XMSC76H/oTMEY2t0wzgukisb/BJ14WTOo28CysTFYg620gDUMMfuJ2cDTNlkuOaL5jC5cBGrVyEuYU2sbdsdG8P6lpZs+KeiZJH3x6beecOattJHPPtnYVlfjh49cM4awjba+7JbK4uP9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 121CF1516;
	Thu, 15 Feb 2024 03:28:07 -0800 (PST)
Received: from bogus (unknown [10.163.74.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CDD43F7B4;
	Thu, 15 Feb 2024 03:27:20 -0800 (PST)
Date: Thu, 15 Feb 2024 11:27:19 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org,
	Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 -next 0/3] RISC-V: ACPI: Enable CPPC based cpufreq
 support
Message-ID: <20240215112719.ciq7nrh6tr2ksr5j@bogus>
References: <20240208034414.22579-1-sunilvl@ventanamicro.com>
 <72ef475f-513b-4e33-ae85-f7e693a0cd38@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72ef475f-513b-4e33-ae85-f7e693a0cd38@arm.com>

On Fri, Feb 09, 2024 at 12:11:11PM +0100, Pierre Gondois wrote:
> The code looks good to me, so FWIW:
> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
> 
> +Sudeep as this touches cppc/arm in case he didn't see the patches
>

Thanks!

> On 2/8/24 04:44, Sunil V L wrote:
> > This series enables the support for "Collaborative Processor Performance
> > Control (CPPC) on ACPI based RISC-V platforms. It depends on the
> > encoding of CPPC registers as defined in RISC-V FFH spec [2].
> > 
> > CPPC is described in the ACPI spec [1]. RISC-V FFH spec required to
> > enable this, is available at [2].
> > 
> > [1] - https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#collaborative-processor-performance-control
> > [2] - https://github.com/riscv-non-isa/riscv-acpi-ffh/releases/download/v1.0.0/riscv-ffh.pdf
> > 
> > The series is based on the LPI support series.
> > Based-on: 20240118062930.245937-1-sunilvl@ventanamicro.com
> > (https://lore.kernel.org/lkml/20240118062930.245937-1-sunilvl@ventanamicro.com/)
> > 
> > Sunil V L (3):
> >    ACPI: RISC-V: Add CPPC driver
> >    cpufreq: Move CPPC configs to common Kconfig and add RISC-V
> >    RISC-V: defconfig: Enable CONFIG_ACPI_CPPC_CPUFREQ
> >

Looks good to me.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

