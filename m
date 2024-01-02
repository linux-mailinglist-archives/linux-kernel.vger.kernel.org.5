Return-Path: <linux-kernel+bounces-14568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FFC821EEF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64FC11F22F09
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC51814AAC;
	Tue,  2 Jan 2024 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="buhmTjny"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199A314A82
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d604b4b30so26578495e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 07:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704209948; x=1704814748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8PuIzcJWDs7Ycx+IDbB+TKZ/Gz1HLUaLNM0aewStBVA=;
        b=buhmTjnyG4vSsPEuQgIhtTsfaJN5/vTtImEsp/zkxC8cDuEDGEQBNKB7sXgtRhSsMF
         WWGrZjxyMqe7bjSqcrApgLbwZarz0emGjfvqTo3N4rvd4Cr7BJKazmtkygQiqF/BtFbT
         rMZM9xYQrfTN5/L/vtlhpHxOGr5Wxsqkrsspc4vtFNr6RQEBxwnUbYcC6qsKXzCWrbQS
         OJCeFFMnSlqaR28SIS99FwUzgDcUCh+wdpw4T3fnCBMZpaev3MnFL4Ethi7ee2o7BOW5
         P6EckcttglMMFf5G+CFEX86+tqvp1acWuNldJDnahbv3f5tey8TRCYd16ALhRlG8llOU
         zz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704209948; x=1704814748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PuIzcJWDs7Ycx+IDbB+TKZ/Gz1HLUaLNM0aewStBVA=;
        b=i1M+Z9KDqDO7kM0rGUHMfnnkIR39VYJlXlVAVlGoDnEME21MX+8xDowmdNnymUQjOh
         W1GNeAln28qrHc7HD7QqgmiV2ZZRrnKqP9MvEBU0ELIvMZ+m5PybaNsKD+K+gwXJ8bSP
         /Iofa5XOVNJmd6bPHvf603ZBLVm3J5QJ1LMl/9MbkwJCz4UMEsK1Dluboahq4GH5buO9
         REwXTJxek4LjpUsyNxy8YDeNdJJeXerj3GToIrolrwa0gVmiZk0+2ueP+A80w08kk5rT
         8HGHfNNThawo3XyFQVeTcCwD/mPhoogxcjs/WQHLdCplsfMIn11yZvDGku6ZrNnJs6Qf
         nufQ==
X-Gm-Message-State: AOJu0Yw7fGg1oB2blkQ0Gl04FZkSnYnAhzmX/oj2RnCRPCmWpYrv/P4s
	zTmI37Yj5QJ53kG2CXomhSj3uyVldBP2kw==
X-Google-Smtp-Source: AGHT+IG1N4DB7FVoiHTpO09/sHvmv28ZIzI+6/qYRY5XJbohkHs6MM1mD5mZprp39syqBQUmrgyESQ==
X-Received: by 2002:a05:600c:a084:b0:40d:8a52:c998 with SMTP id jh4-20020a05600ca08400b0040d8a52c998mr1072817wmb.17.1704209948254;
        Tue, 02 Jan 2024 07:39:08 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id iv13-20020a05600c548d00b0040d30af488asm49891379wmb.40.2024.01.02.07.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 07:39:07 -0800 (PST)
Date: Tue, 2 Jan 2024 16:39:06 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	rafael.j.wysocki@intel.com, conor.dooley@microchip.com, sunilvl@ventanamicro.com, 
	aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [RFC v1 1/1] RISC-V: ACPI: Enable SPCR table for console output
 on RISC-V
Message-ID: <20240102-1ddc9ec273fded1548ee586d@orel>
References: <20231229065405.235625-1-jeeheng.sia@starfivetech.com>
 <20231229065405.235625-2-jeeheng.sia@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229065405.235625-2-jeeheng.sia@starfivetech.com>

On Fri, Dec 29, 2023 at 02:54:05PM +0800, Sia Jee Heng wrote:
> The ACPI SPCR code has been used to enable console output for ARM64 and
> X86. The same code can be reused for RISC-V.
> 
> Vendor will enable/disable the SPCR table in the firmware based on the
> platform design. However, in cases where the SPCR table is not usable,
> a kernel parameter could be used to specify the preferred console.
> 
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> ---
>  arch/riscv/kernel/acpi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> index e619edc8b0cc..5ec2fdf9e09f 100644
> --- a/arch/riscv/kernel/acpi.c
> +++ b/arch/riscv/kernel/acpi.c
> @@ -18,6 +18,7 @@
>  #include <linux/io.h>
>  #include <linux/memblock.h>
>  #include <linux/pci.h>
> +#include <linux/serial_core.h>
>  
>  int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
>  int acpi_disabled = 1;
> @@ -151,6 +152,9 @@ void __init acpi_boot_table_init(void)
>  		if (!param_acpi_force)
>  			disable_acpi();
>  	}
> +
> +	if (!acpi_disabled)
> +		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);

Both arm64 and loongarch call early_init_dt_scan_chosen_stdout() when
acpi_disabled and earlycon_acpi_spcr_enable are both true. Is that
not necessary for RISC-V?

Thanks,
drew

>  }
>  
>  static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, const unsigned long end)
> -- 
> 2.34.1
> 

