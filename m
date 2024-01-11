Return-Path: <linux-kernel+bounces-23350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8156582AB74
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB465284995
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081B512B86;
	Thu, 11 Jan 2024 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="AsEZXAkq"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5292D125BE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-555bd21f9fdso5818277a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704967214; x=1705572014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SK6l91q7AEIn5ipGCEJlFPJF27Zw8+0MoPYYgQPY0a4=;
        b=AsEZXAkq7rgCb3FMKtxC+H3Axt8OhMzF2gp6HL3KglEpPC7pY7kHgjFG81lXzvZ/UN
         wLwIG5YIr1ReEYlGnn+d90k0CfdMpuxobTPyawzLSiaDcBaKeP2HJ4KQWiJS1XmMyJ39
         k/Ox2Pc/agvuZh/X6kGyNAFogbRgembnxmEN5DN1il19f96KXjO0q4yMO2ZKT8wB+uhW
         Z3uuo40KyPsRHX0BL8uZd/DaWA7ZBygNYC0OOd8vcHNYPg/HzJKv+59yuLsDWAmdoXxO
         9kD7Obb+S73Nur8WGtFBbObUn8GOEjpRCq5IgfVPGJJtdo1oBRyj4Jx1HvVklaXvws9N
         G1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704967214; x=1705572014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SK6l91q7AEIn5ipGCEJlFPJF27Zw8+0MoPYYgQPY0a4=;
        b=dfslvgQdy05fJi9fZriqUV+sf0QpAOjiGXZZyPb9BZduoSQsHTI89Vb7V5r56hJ+Ln
         4VzMA8Spyme7WifXCu/P5zJqeKwux5Ji+bkmwQ4GRv+ieeXNhrSoEBuw095tNuOhhccN
         UZ7AUgq2qZSTRel+Vnq5M1Yx+YTrtsNxUUZhLV3qvNP1ILJwCh3qh3+1a9LFaNpMnWXj
         28hCUvEhth8l+JvcEMbvpYL37o282ICQ0t6MDYbLpUXz0mMif40xA4cTYqGqVsn2V4vy
         rrWkWkeU0a0asD60RcVi6QJltxBx30UE85HSOCXEfeEnsjLhEu0P4z/VfRdI+IhITpKQ
         Qw5g==
X-Gm-Message-State: AOJu0Yw8t9pZgC4c1qxJw72ZMcFC1P/DQZ5nVLeEWMiVDEOxmgspF2D5
	uVEIVM59WziHUkHrggbdivqYqqezrnlDpQ==
X-Google-Smtp-Source: AGHT+IG9OykZ6CNPvrkHEc3LhlxSvCDJTd22uv+2HGjZ6t7gDVg53BD9mWU36h/4tpDnSh7smSjEVg==
X-Received: by 2002:a17:907:9281:b0:a27:f6aa:c7b0 with SMTP id bw1-20020a170907928100b00a27f6aac7b0mr576724ejc.11.1704967214471;
        Thu, 11 Jan 2024 02:00:14 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id o8-20020a170906358800b00a2ace215a78sm368912ejb.114.2024.01.11.02.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 02:00:13 -0800 (PST)
Date: Thu, 11 Jan 2024 11:00:12 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH -next 1/2] ACPI: Enable ACPI_PROCESSOR for RISC-V
Message-ID: <20240111-bb411d2dd39eb859dd049fa0@orel>
References: <20240111093058.121838-1-sunilvl@ventanamicro.com>
 <20240111093058.121838-2-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111093058.121838-2-sunilvl@ventanamicro.com>

On Thu, Jan 11, 2024 at 03:00:57PM +0530, Sunil V L wrote:
> The ACPI processor driver is not currently enabled for RISC-V.
> This is required to enable CPU related functionalities like
> LPI and CPPC. Hence, enable ACPI_PROCESSOR for RISC-V.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/acpi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index f819e760ff19..9a920752171c 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -282,7 +282,7 @@ config ACPI_CPPC_LIB
>  
>  config ACPI_PROCESSOR
>  	tristate "Processor"
> -	depends on X86 || ARM64 || LOONGARCH
> +	depends on X86 || ARM64 || LOONGARCH || RISCV
>  	select ACPI_PROCESSOR_IDLE
>  	select ACPI_CPU_FREQ_PSS if X86 || LOONGARCH
>  	select THERMAL
> -- 
> 2.34.1
>

Hi Sunil,

Typically we'll want the Kconfig changes to come at the end of a series,
or squashed into the patch that adds support for it, otherwise there's
risk of build breakage during bisection. In this case, we're safe because
the two new functions (I looked ahead) have __weak versions when they're
not present.

Also, interestingly, it looks like this ancient line

 obj-$(CONFIG_ACPI_PROCESSOR)    += processor.o

in drivers/acpi/Makefile should be removed, since there's no
drivers/acpi/processor.c file. I guess the make process silently
filters object files which don't have corresponding source files?
Maybe we should write a Makefile analyzer to see what other lines
can be removed...

Anyway, for this patch, which I'd prefer to be swapped in order with
the other patch, or just squashed into the other patch,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

