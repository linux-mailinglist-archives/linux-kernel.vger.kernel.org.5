Return-Path: <linux-kernel+bounces-91678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBDC8714EC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84101F232B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB8D405FD;
	Tue,  5 Mar 2024 04:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JcmZ6zKI"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F0E10A1B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 04:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709613869; cv=none; b=BTfMqz451rEa8PJC7ylLqnRJ1XQIk6rBhoE2gMOfGdV2Uu0JX491ALp1aBNrLg9fnMvkf5RNlhL98o7jloHdl2pe69plMHRJiGV+piEmTkm/9e/tXzSOvivPPKNmt2PSAR//yDLRbPYmtBNDFRKNhy6S+A1cEhovffT1H73vmho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709613869; c=relaxed/simple;
	bh=9FduPOM1E0DLi1J/5wrgWMsdvAlzYCOwin/4aXtDbPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCarYdqDJejDWN81PjFDwAW5tE+a3gbid5LAeqrpXJkSqrX1k8ahEBRASNdo7MY/VviIPaKTBOJmOP/OFSbcCSsvqW/rWNmOzhe1i1+B8eYdmTi6cdfuOBHoqLr/gAMrd6A5SU7N1jHhF4dzPd73F5N37ySwcFYdISxdtHj5lRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JcmZ6zKI; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6da9c834646so4750426b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 20:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709613868; x=1710218668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SEmCILRrIWZpalXXrpWDX7rbP4qw8KKDAl0Yn0w+NeM=;
        b=JcmZ6zKIFsPibwIxqhIEhH4mnOo/+yJGvSF3Do6zD3CWlGzi7fFJYM5xlWe4vErl6F
         X8C7aDLmdxxIBr1pqFK78DiaABaR6pAUSTDo0vpeymK9GbzNUgG+rUm6rQG2+BJIRfQH
         NKMuUIukX7iyAe31iggW1HwuT3TQ+Mk7INM5w6l7NL0fHfxOOAiz98Y8R8LrMSYZnqPQ
         YFzQlJ9XXq53NqOixi6D1JLqEKcuXNue5Z4cO+kRniHe8C1Q3PAfNJBrKxYWajqmQF4F
         hHDxdXpE9DnYXOYKmsIpWT4LRRDx4qajI/DUMZQQOBWqUjnwlf4PNhWOf5/AvV2ktLnp
         wWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709613868; x=1710218668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEmCILRrIWZpalXXrpWDX7rbP4qw8KKDAl0Yn0w+NeM=;
        b=MX+PblwI4ESFZ3kPT/URl6fADDowrVtu3LKQch4X4uPdbvOhhaHWs/7RbsulzvWsY4
         fXwjJLo+1JzgF1+WqjnMYeICamgkYDb9gmH0qYsmrhm3hFN09jSTex1HS40K7zfaUWE+
         eW1sOta7vq8dJw80GOsb6Y+e8xkrycWWtyMV4qYohjyHFMIINkU+fp4+ISNWR0SHcRfo
         BfOWe+dh48eQ0hJ2cWb0vb1R/d5cP/SK0iZ6X1eI9uNisK0hR7LmkRWWEJKpJfVo72XO
         WocT0ofGIiWVUHkNpNJDyIAjRMCXVKbed18ovr9LVChue3TDC96CjBpxyrO1EwdeQpYG
         x9Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUxWe7dqJaILtJipsDdvH37qZABbcQBSNqi2gxp/lCRmg5GfSwO5zL4D95fC25i8ZTaLf4B0d6OCbedexA8/RcLF3nbHSMRb2vJW0t7
X-Gm-Message-State: AOJu0YyCbEcnO5VDkE6NzKPLUrBN3jeZ/FvFOjbfQqOd5mNmmjW7xoAP
	Tgj83vLFO0l3tMiGRtZt27li5P0o7U0al6uohdRhoFbAyNmPqAQn+N8fgtICGgk=
X-Google-Smtp-Source: AGHT+IGzdE2wBh5JMNN2REb28BcAMWbrN4VvpnatTms7qSnw73XZkAoXt6ydG0CS93YADlTRvZf9Ag==
X-Received: by 2002:a05:6a20:4304:b0:19e:4aa7:e6ab with SMTP id h4-20020a056a20430400b0019e4aa7e6abmr909690pzk.47.1709613867818;
        Mon, 04 Mar 2024 20:44:27 -0800 (PST)
Received: from sunil-laptop ([106.51.184.12])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b001dcfaf4db22sm5467653plr.2.2024.03.04.20.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 20:44:26 -0800 (PST)
Date: Tue, 5 Mar 2024 10:14:14 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: xiaobo55x@gmail.com, ajones@ventanamicro.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Baoquan He <bhe@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH 0/4] Add ACPI NUMA support for RISC-V
Message-ID: <ZeajHkn6dTQ3krsL@sunil-laptop>
References: <cover.1706603678.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1706603678.git.haibo1.xu@intel.com>

Hi Haibo,
On Wed, Jan 31, 2024 at 10:31:57AM +0800, Haibo Xu wrote:
> This patch series enable RISC-V ACPI NUMA support which was based on
> the recently approved ACPI ECR[1].
> 
> Patch 1/4 is generated from the acpica PR[2] and should be merged through
> the acpica project. Due to this dependency, other 3 patches can only be
> merged after the corresponding ACPICA patch was pulled into linux.
> 
> Patch 2/4 add the common SRAT RINTC affinity structure handler.
> Patch 3/4 add RISC-V specific acpi_numa.c file to parse NUMA information
> from SRAT and SLIT ACPI tables.
> Patch 4/4 add corresponding ACPI_NUMA config for RISC-V Kconfig. 
> 
> Based-on: https://github.com/linux-riscv/linux-riscv/tree/for-next
> 
> [1] https://mantis.uefi.org/mantis/view.php?id=2433

Please avoid providing mantis link. It is not useful for people who are
not UEFI members. Better to provide the link to the PDF version of the
ECR approved.

Thanks,
Sunil

