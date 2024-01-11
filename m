Return-Path: <linux-kernel+bounces-23586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209E082AEB2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99154B20F02
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EAF15AD1;
	Thu, 11 Jan 2024 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="G33nWuG3"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195BF15AC0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a28f66dc7ffso1138244966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 04:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704976091; x=1705580891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=met0TS3f1iN0VupGC8yYYJUiPelRlG/OMDMfE7CCcUo=;
        b=G33nWuG3pLKr7rTBDaurck8orl0FgWfYCi43NSlluN/SbUxFOjJ5Veq7LDpckGqJhG
         LrF/lMkBDjpGF8v+shcQPxDatrd/SV25rwN7o0QJjT5p3Ij88MWmgnYb4NVojCviLoyZ
         wC8CDkRoed3U4J9BxavOH9t/av9msxnHf57/KhpR0fsPU1n0BmC75JtNFmufP8d73nvB
         ZNnO8jaUUMcNsOSKRM9BKNEqNO08L3zwhYNuwh0VL5TEUofClHF/OEvcXWp7MfgCZsz+
         Cc4Z7PjFQVkkzPBfyHsRwnpT0aDTtVSh0+nKtXfvei5+xElPl0Fjacmipv0y79Bj1zKF
         8AJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704976091; x=1705580891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=met0TS3f1iN0VupGC8yYYJUiPelRlG/OMDMfE7CCcUo=;
        b=L/GkxLwxdxtAElHiEUaCqlVHiwkx8qSNs5X2t75fwGAlQ7JNfmZrsQvE49s7svx2uW
         MnuMdZw7vL54T+dZbi9PRpIJQ4w4O+yk3ZDnNodxdUpKcNwt/+1j+DF1YB5j+eyZtSDe
         1OWAzOB9sirJjFZjpMD2iLU1l2WZeXOFhd+VsOtcNDvI0yGWbnQl7DYBhjA9YJlLUXaG
         41ThVk5aTf4tuZpRxmFclrZT2Dn/qeJr3L6UvjX/kSb8XGxSZpfJR2+wyaCdMkdRI5d0
         8wPGaDcepLuGaE7WrgTVTAS+WJo6SYCrcrCAFpDYYYVJGVB534AQEe52coU/4rc+Nzjk
         3Oug==
X-Gm-Message-State: AOJu0Yz2TYq4YltzXthLNmCKa6BK54JQsl8flBz0F52rcrTrbdu+ErRX
	MsGaw48CMRuMB7NqmFBlY1XG1ecQ9LCU6A==
X-Google-Smtp-Source: AGHT+IEkg2z959ndk+FzzQaRGZjtyR4oRWJbgbi4WbvdpfH73VMDgLf0V+BD0aiz0hAD1dgeK/Pwbw==
X-Received: by 2002:a17:907:7f29:b0:a29:eefc:ef80 with SMTP id qf41-20020a1709077f2900b00a29eefcef80mr809934ejc.33.1704976091271;
        Thu, 11 Jan 2024 04:28:11 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id ox9-20020a170907100900b00a2825a9e1d0sm526002ejb.174.2024.01.11.04.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 04:28:10 -0800 (PST)
Date: Thu, 11 Jan 2024 13:28:09 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: Re: [PATCH -next 1/2] ACPI: Enable ACPI_PROCESSOR for RISC-V
Message-ID: <20240111-e3a13157f1869342e2c8e942@orel>
References: <20240111093058.121838-1-sunilvl@ventanamicro.com>
 <20240111093058.121838-2-sunilvl@ventanamicro.com>
 <20240111-bb411d2dd39eb859dd049fa0@orel>
 <ZZ_cBlOSW9VCjkOv@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ_cBlOSW9VCjkOv@bogus>

On Thu, Jan 11, 2024 at 12:16:06PM +0000, Sudeep Holla wrote:
> On Thu, Jan 11, 2024 at 11:00:12AM +0100, Andrew Jones wrote:
> 
> [...]
> 
> > Also, interestingly, it looks like this ancient line
> >
> >  obj-$(CONFIG_ACPI_PROCESSOR)    += processor.o
> >
> > in drivers/acpi/Makefile should be removed,
> 
> No
> 
> > since there's no drivers/acpi/processor.c file.
> 
> Correct, but ..
> 
> > I guess the make process silently filters object files which don't have
> > corresponding source files?
> 
> May be, but I doubt if that is the case here.
> 
> processor.o is just aggregation of all processor_*.o and this will be
> the processor.ko when built as a module.

Oh, I see. I had tried looking for a processor.o after building, to see if
it was something like that, but it still didn't appear. It didn't occur to
me to also try ACPI_PROCESSOR as a module.

I'll go put my head in some sand now.

Thanks,
drew

