Return-Path: <linux-kernel+bounces-91693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C9387153A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5682B282195
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1BE46444;
	Tue,  5 Mar 2024 05:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="AXlMY1FA"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB3DAD5E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 05:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709616408; cv=none; b=VS69dH2NqcOBF5WUI3Ey3o7bzLfojihXmfa2VejxAiD72ULIMkFe9sF0OjBrWu3QrHBD1XFme3r4o1l+aqPF11V1SXfjGYtm2Cm5XBb9M06/juw7mOVviSbRZrEMLzoO7OZUJFWPuM9Tjtq2Z3w837PGSTvWlT1QuCxocvP+aqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709616408; c=relaxed/simple;
	bh=IUUnXu41nv70y8HvfDJJUOOnZ7pf++QXfILZ3C80xAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWd8r0iZDWPsINU9GLL0beiw+xy+uRMEBq+7laoaxX3xXV1IyERbjvTawIWZYOrGHkT+CqaWI/2bIA+KedIAda3Z/M2wGcVlZcF6VR2AWvimyozSXK/QntoVAeM6mXN155gbXBJgoF73byONrFVJ3WWEYRqSLgZJoVhi+pHFV9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=AXlMY1FA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dcc7f4717fso52930905ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 21:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709616406; x=1710221206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KMCvUOJfUJZd1FjH5xJXeLVB97fRCdKEGxvILGRlgeg=;
        b=AXlMY1FAYQAm3hVYveyMFVhrABj1ov4QYWhAsOIoGRLVGu6QsX4Nlm2OLueYxhsY0K
         flkxH65VaDAdvqqAXtW3BJ8y+eSXI/c0ygnTDLyb8BJQiRJzN4Zr8nAtycfgo81tQn6Y
         ZRnu/oHUBQPvfDTqVWjzRUCjBSBRi0D8r4+pHIZFWZn7MQJRkme5cGxHy5cqnM1y5KIP
         MPRng+QQnUra5UkTYOLT244LFlmi3AiVw6D4J6l4i4Avcy2tIP+7DLN30TDEQyvlw5ik
         c5nr4RDhcWngv9+73UqKosl4lfMeX8BYZgHzxuslS3YP6iTJwNAVuE+wK++Obt/Gt6AQ
         DC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709616406; x=1710221206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMCvUOJfUJZd1FjH5xJXeLVB97fRCdKEGxvILGRlgeg=;
        b=AvO+BXg4vJCzbse2oaHoC+smOJD6Q0ettS5Znz+TtPHLflDPxWLFv0v/hxEP0p1T1r
         aJys0XFcG8LE/O7gxvpZp+xLYCLBALsrc/oaok8mk2+crwFTp2z1Us6bOlf3OMmDhIhf
         EOVcf/c5DyhmP0nQgEOA4kxcoxnzPrSoerI3clcBJahNpvKbP8s/ctXpmtiM2NGXM2dU
         p8YQYboAGbRQ/50fQznFMHDd/hDhFZLuo5f7MRTwUlYUfW+ffV3l5B19RUvLWUD/gGsT
         Ab4P5opIIwPgTwMq5LTgvhlOI2ubEuMgsevAdCsFi460DOYbyzDIWbIoyeBgdUOrxwsn
         JLuw==
X-Forwarded-Encrypted: i=1; AJvYcCUwqmsJgB4N7bJ0bqbtB5fSIFTqsgIsNhBtinzsQ/YCmGIN3L8M9LGcBTMfNDHQRBlU4VIXPSKmFPMnR/33DTi1Pj6bPQ1pbJaHBBuA
X-Gm-Message-State: AOJu0YxFVarx0Vw4XiCB492Cv+0ZfUsVzGmx4vkE90yjF+QLb7zLN5w0
	MJQgP4eCCs8pg5H4+P4I0sNRkDYOJ5MJUMFptNBTpCvE7BInZqgV2UL24DvGO2A=
X-Google-Smtp-Source: AGHT+IGs95PUoXAEeVYkFgLUnlTCMmRM9UBfrxIhvh57F9nTPhSjmTGyccBIiPgnhfiEPKqxoObiIA==
X-Received: by 2002:a17:902:f552:b0:1dc:ce28:a47d with SMTP id h18-20020a170902f55200b001dcce28a47dmr929601plf.17.1709616406218;
        Mon, 04 Mar 2024 21:26:46 -0800 (PST)
Received: from sunil-laptop ([106.51.184.12])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902b78800b001dcc1597377sm9455663pls.230.2024.03.04.21.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 21:26:45 -0800 (PST)
Date: Tue, 5 Mar 2024 10:56:32 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: xiaobo55x@gmail.com, ajones@ventanamicro.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>, Anup Patel <apatel@ventanamicro.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Baoquan He <bhe@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Ard Biesheuvel <ardb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH 4/4] ACPI: RISCV: Enable ACPI based NUMA
Message-ID: <ZeatCIUZ/eJa1WHs@sunil-laptop>
References: <cover.1706603678.git.haibo1.xu@intel.com>
 <0be49d4d7d7e43933534aad6f72b35d3380519fd.1706603678.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be49d4d7d7e43933534aad6f72b35d3380519fd.1706603678.git.haibo1.xu@intel.com>

On Wed, Jan 31, 2024 at 10:32:01AM +0800, Haibo Xu wrote:
> Enable ACPI based NUMA for RISCV in Kconfig.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  arch/riscv/Kconfig        | 1 +
>  drivers/acpi/numa/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index bffbd869a068..e586ab959f34 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -438,6 +438,7 @@ config NUMA
>  	select HAVE_SETUP_PER_CPU_AREA
>  	select NEED_PER_CPU_EMBED_FIRST_CHUNK
>  	select NEED_PER_CPU_PAGE_FIRST_CHUNK
> +	select ACPI_NUMA if ACPI
>  	select OF_NUMA
>  	select USE_PERCPU_NUMA_NODE_ID
>  	help
> diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
> index 849c2bd820b9..525297c44250 100644
> --- a/drivers/acpi/numa/Kconfig
> +++ b/drivers/acpi/numa/Kconfig
> @@ -2,7 +2,7 @@
>  config ACPI_NUMA
>  	bool "NUMA support"
>  	depends on NUMA
> -	depends on (X86 || ARM64 || LOONGARCH)
> +	depends on (X86 || ARM64 || LOONGARCH || RISCV)
Is it possible to remove this if IA64 is removed now? 

Thanks,
Sunil
>  	default y if ARM64
>  
>  config ACPI_HMAT
> -- 
> 2.34.1
> 

