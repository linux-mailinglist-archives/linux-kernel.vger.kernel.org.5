Return-Path: <linux-kernel+bounces-23486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E1282AD66
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80AD4B23D6C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD4815493;
	Thu, 11 Jan 2024 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="axVFp5FU"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B10B14F9D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbbdf0b859so5550114b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704972596; x=1705577396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L1/9OBgUnbI4qV6pkGpalRcx7MgtwXi8Ekel0WOHXQs=;
        b=axVFp5FU03cyM3XxUlRW4A1+Af30SmYit08s6H2hKmmih4wOrjWxnvCQAZgbw3mWqE
         YR9trjFZ40lEehQQ3oSe9esID+j8cTq6MGpb5ZmpYIrA5JByUBFhKdwAs0kigL1lyMuW
         jy1h1DANW1eRGABdrMUg1Sj/51M2nkkrAG75ZtiSHcbFmS1/d5hypp9NDGnTkgM9rZKZ
         yaxRHkUlAONKPckPvlCEL6Sc+m67S+cGa19UlNH4t1iaKjlq1w7emyWqZTWnVS5Lrplj
         TNqEXj9Q5eO+KUM+2YC53wXpGDkwG05eLrt7Fx3SpAi4sFBvglhFVLJChJbrL+LIo0Kz
         ocdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704972596; x=1705577396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1/9OBgUnbI4qV6pkGpalRcx7MgtwXi8Ekel0WOHXQs=;
        b=YdM95pLap1hjk/3WiyxLaja0eZbOpxiOiqJtLJS+Z3aThGOD9EgskZ+syiO31mwzIJ
         5+hVnKSX6d6tFdtP/DkVwujRj3WXBTarribYszTnDb2EwMn8+6drjFYmrG4AjQHojFmQ
         RcGONznva3cdJ32lufeGrJMPF6lR1haZKNUSAcZDRI2qp5TrPPmRLGgDmDU2wOMvLYQz
         S8xvSKDpsMeG5NbFn9TdB96kK+NrAF6bz00+y9QfM0idod7GgeKwxbIKq1xTfN9K7Bo2
         uiXqAI+GEf1mMK5n48HJtVHncBlNYA7tMl/U0X5oKPMrxUtiay1kb7wRkQmopRUGSSHN
         KjYw==
X-Gm-Message-State: AOJu0Yw2oLRmqao+xGzuTHoj67kzVqdXY0EZKiMGYseoFryg4zVZgwny
	sWqtIF3skKXvbEcaR7PB8zxu4N7F2QefGQ==
X-Google-Smtp-Source: AGHT+IFCKZdtwrnCuFg7TdR7AtliYvHu3SQxC/Xbm2j8wl2ATuGO1M0kBIaUI9ISibSbZ6dp+SrhvA==
X-Received: by 2002:a05:6358:d39d:b0:175:9bfc:1b34 with SMTP id mp29-20020a056358d39d00b001759bfc1b34mr1332658rwb.22.1704972596331;
        Thu, 11 Jan 2024 03:29:56 -0800 (PST)
Received: from sunil-laptop ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id nb1-20020a17090b35c100b0028d804ef772sm3504720pjb.25.2024.01.11.03.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 03:29:55 -0800 (PST)
Date: Thu, 11 Jan 2024 16:59:47 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Anup Patel <anup@brainfault.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH -next 1/2] ACPI: Enable ACPI_PROCESSOR for RISC-V
Message-ID: <ZZ/RK49zoFtSt4Ed@sunil-laptop>
References: <20240111093058.121838-1-sunilvl@ventanamicro.com>
 <20240111093058.121838-2-sunilvl@ventanamicro.com>
 <20240111-bb411d2dd39eb859dd049fa0@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111-bb411d2dd39eb859dd049fa0@orel>

On Thu, Jan 11, 2024 at 11:00:12AM +0100, Andrew Jones wrote:
> On Thu, Jan 11, 2024 at 03:00:57PM +0530, Sunil V L wrote:
> > The ACPI processor driver is not currently enabled for RISC-V.
> > This is required to enable CPU related functionalities like
> > LPI and CPPC. Hence, enable ACPI_PROCESSOR for RISC-V.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  drivers/acpi/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > index f819e760ff19..9a920752171c 100644
> > --- a/drivers/acpi/Kconfig
> > +++ b/drivers/acpi/Kconfig
> > @@ -282,7 +282,7 @@ config ACPI_CPPC_LIB
> >  
> >  config ACPI_PROCESSOR
> >  	tristate "Processor"
> > -	depends on X86 || ARM64 || LOONGARCH
> > +	depends on X86 || ARM64 || LOONGARCH || RISCV
> >  	select ACPI_PROCESSOR_IDLE
> >  	select ACPI_CPU_FREQ_PSS if X86 || LOONGARCH
> >  	select THERMAL
> > -- 
> > 2.34.1
> >
> 
> Hi Sunil,
> 
> Typically we'll want the Kconfig changes to come at the end of a series,
> or squashed into the patch that adds support for it, otherwise there's
> risk of build breakage during bisection. In this case, we're safe because
> the two new functions (I looked ahead) have __weak versions when they're
> not present.
> 
Sure. Let me swap the order of the patches.

> Also, interestingly, it looks like this ancient line
> 
>  obj-$(CONFIG_ACPI_PROCESSOR)    += processor.o
> 
> in drivers/acpi/Makefile should be removed, since there's no
> drivers/acpi/processor.c file. I guess the make process silently
> filters object files which don't have corresponding source files?
> Maybe we should write a Makefile analyzer to see what other lines
> can be removed...
>
Interesting. 

Hi Rafael, any thoughts?
 
> Anyway, for this patch, which I'd prefer to be swapped in order with
> the other patch, or just squashed into the other patch,
>
I prefer to keep as 2 separate patches. I will swap the order.

> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
Thanks!
Sunil 

