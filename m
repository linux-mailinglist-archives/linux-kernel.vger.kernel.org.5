Return-Path: <linux-kernel+bounces-59270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D0B84F454
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5291F23B82
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12B12DF7D;
	Fri,  9 Feb 2024 11:11:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFD528DCB;
	Fri,  9 Feb 2024 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477084; cv=none; b=djH7SPmC4czRoQuvdoszSovA7k8G/d4l6CzjDzTz1dssAdaBGnhFWdT6RW01IFMWgn/E2CmZvpwGNXXHZLFn2QIbn59UWDi/cUWa9x5OUKdDC+8NyMW9Vo0CTTbzd8X2UNLY/dg1SAjDEnsxvavtfPoYGpy7NzX4SQFqzfhKQwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477084; c=relaxed/simple;
	bh=2sHleEjAfsXlECwT5CNpMpQsUNDdU15gyNB4pJ6ldRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnitWk1Ywr6zpmKY/se8GSVr89hNwRvy6FsBgUry9xwyppGDIIEVuwkV2KHJO+kPWzdFTvz97LO1kO5fCpZhZwIJvDgEY0kOHQuL5WQgpCABQgIm2sjVGxRiXfuO7y5yeoCy/2T2mQSj5gQ79q6sSVRul9f2iXw9hKSwVp15yTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F22DFEC;
	Fri,  9 Feb 2024 03:12:04 -0800 (PST)
Received: from [10.57.47.170] (unknown [10.57.47.170])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCA853F8A4;
	Fri,  9 Feb 2024 03:11:18 -0800 (PST)
Message-ID: <72ef475f-513b-4e33-ae85-f7e693a0cd38@arm.com>
Date: Fri, 9 Feb 2024 12:11:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 -next 0/3] RISC-V: ACPI: Enable CPPC based cpufreq
 support
Content-Language: en-US
To: Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Anup Patel <apatel@ventanamicro.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Atish Kumar Patra <atishp@rivosinc.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Andrew Jones <ajones@ventanamicro.com>,
 Len Brown <lenb@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
References: <20240208034414.22579-1-sunilvl@ventanamicro.com>
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20240208034414.22579-1-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The code looks good to me, so FWIW:
Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>

+Sudeep as this touches cppc/arm in case he didn't see the patches

On 2/8/24 04:44, Sunil V L wrote:
> This series enables the support for "Collaborative Processor Performance
> Control (CPPC) on ACPI based RISC-V platforms. It depends on the
> encoding of CPPC registers as defined in RISC-V FFH spec [2].
> 
> CPPC is described in the ACPI spec [1]. RISC-V FFH spec required to
> enable this, is available at [2].
> 
> [1] - https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#collaborative-processor-performance-control
> [2] - https://github.com/riscv-non-isa/riscv-acpi-ffh/releases/download/v1.0.0/riscv-ffh.pdf
> 
> The series is based on the LPI support series.
> Based-on: 20240118062930.245937-1-sunilvl@ventanamicro.com
> (https://lore.kernel.org/lkml/20240118062930.245937-1-sunilvl@ventanamicro.com/)
> 
> Sunil V L (3):
>    ACPI: RISC-V: Add CPPC driver
>    cpufreq: Move CPPC configs to common Kconfig and add RISC-V
>    RISC-V: defconfig: Enable CONFIG_ACPI_CPPC_CPUFREQ
> 
>   arch/riscv/configs/defconfig |   1 +
>   drivers/acpi/riscv/Makefile  |   1 +
>   drivers/acpi/riscv/cppc.c    | 157 +++++++++++++++++++++++++++++++++++
>   drivers/cpufreq/Kconfig      |  29 +++++++
>   drivers/cpufreq/Kconfig.arm  |  26 ------
>   5 files changed, 188 insertions(+), 26 deletions(-)
>   create mode 100644 drivers/acpi/riscv/cppc.c
> 

