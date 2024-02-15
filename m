Return-Path: <linux-kernel+bounces-66295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C86C98559DE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7431C230D6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23CB625;
	Thu, 15 Feb 2024 04:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="aKNQTR2l"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9251415B7
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 04:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707971835; cv=none; b=P2FxDqREywXa+BUgDaW29HJopRKQMq+Vkf2/pqZ/o0ql8ai+OLT5JH/9tdOcGG0Xjme+DS/hioXRerD7IxzG287GYI+6hxvEKQS34TwPBAuwGk+VBK/cAifrsKLYJbeIyGGPYzJ7aX1BGcauw6Ox3eZ6Knli+T71vYUsS8lZJyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707971835; c=relaxed/simple;
	bh=hWjmYkC4Y2k+DXmyyldp64dBFjzl/FP6Z68rFyr4mCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFMca7Tiu6eN480LZhgwkb+LYRgdZ+2oXvvnQ38bZGjudRq3TLah+DSawKbrx/4Fanuf26G9MRID2ukiI2ZRep5bJ8op7F0UwjMBD+RiCjsZJOA4pgR3PKp8b6GZy5+FFu6/DbzMwpYUv5VxaPwRh1semOV2pZkExNBOJkEEbUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=aKNQTR2l; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ddf26eba3cso285624a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 20:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707971832; x=1708576632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eNxJDjUCrN6LyBUSVQQs/vfYX3KHuLasmPCTnAxXhZ0=;
        b=aKNQTR2l31qk4unC6v3bbtL+ygY4o8K9Ce2Gc5gt+5P9e+lTTKdsNVCr4k7USfA4HD
         +iqCvRsNOGcbqDeE40HKpDqBPsggEbPTeBDg9bNgtHm4EifcGiw9kO17F0v+9eZB0Tns
         hNWq/8BO4FibtOWUohHGG2S5J4RNf24E7//hvzb8YFUupElNDIbv2wA3sAjPRXs50z6w
         O2hZdzLRbgBgY97JNuu9anS9EbGygOgJxGvkjxazmt/GgAdcLhDP9o16XI9Y20hl8sN3
         UjnsVukozZ0zVQ9q6Igio9UMMVw2iuFvhGCGEXGuSQ8aT5TSIsZe/c27mk+/CTnn0z9+
         DxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707971832; x=1708576632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNxJDjUCrN6LyBUSVQQs/vfYX3KHuLasmPCTnAxXhZ0=;
        b=Mfs8YyeTETxD6slMoDOmdLF+WxvDtSuKXU+Uct+0P5gYob+ReA40uSRe6ZEY75Mysr
         cG27knrtm4+fhBVOedT62f+vGa3VtmBU260nOdSKNzZDsJNA6E1K4Wf11oakb9e/TdIr
         M7YvGTVl8GqnDRGJ+3qt7YRsRWDcCXJaFJ4FDQCDdtHWnOiApqw3wwemgRjof6iHYj21
         2f/wRsOmgvxC30scGmVifR/N38sbjRgQyONy8sRNIBQXbEdWK/HM2+PakRl5rvXpL9Co
         CVUwg13wpPMMAKncgpVI6wRB7c01KApeXubX8ryconXSBvpbXsqDuA+77zGjzBNuEmBd
         vrlg==
X-Forwarded-Encrypted: i=1; AJvYcCVM0srCLdfTJJgSbd3ijc+zVdeXHNa2ObyG/5riicZO4QImJNi3XtaxTmfXzIQFv8EW+V81yBIgFgfpeRD3mKK59G+sfAmSzQ+4Gd7c
X-Gm-Message-State: AOJu0YwSzbAIad4c88G2yn56nWJOTiNSAzw/KceKwdKHtGjxCZM3KQ4y
	c7HtCnwjRSHmJfXlla7/6QJX7ivZS0VkoEQzTpC6MhYGjyLt9y0hJ32EsnJonyE=
X-Google-Smtp-Source: AGHT+IF6VXW2Q1PC6MlD1H84uMFhuVJdYWGUe07iOM0/TV77GrZ+nJHBLkmineD4719XAI9et/fv0Q==
X-Received: by 2002:a9d:7985:0:b0:6e4:22b4:72ef with SMTP id h5-20020a9d7985000000b006e422b472efmr757348otm.5.1707971832463;
        Wed, 14 Feb 2024 20:37:12 -0800 (PST)
Received: from sunil-laptop ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id h25-20020a9d61d9000000b006dbfafc2049sm103050otk.30.2024.02.14.20.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 20:37:12 -0800 (PST)
Date: Thu, 15 Feb 2024 10:07:03 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v3 -next 0/3] RISC-V: ACPI: Add LPI support
Message-ID: <Zc2U70o7teYnJyp9@sunil-laptop>
References: <20240118062930.245937-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118062930.245937-1-sunilvl@ventanamicro.com>

Hi Rafel,

On Thu, Jan 18, 2024 at 11:59:27AM +0530, Sunil V L wrote:
> This series adds support for Low Power Idle (LPI) on ACPI based
> platforms. 
> 
> LPI is described in the ACPI spec [1]. RISC-V FFH spec required to
> enable this is available at [2].
> 
> [1] - https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#lpi-low-power-idle-states 
> [2] - https://github.com/riscv-non-isa/riscv-acpi-ffh/releases/download/v/riscv-ffh.pdf
> 
Could you please take a look at this series also and provide ACK if
looks fine?

Thanks,
Sunil
> Changes since v2:
> 	1) Added "riscv_" prefix for functions made non static (Feedback from Drew)
> 	2) Added RB tags from Drew.
> 	
> Changes since v1:
> 	1) Reordered the commits such that the patch which enables
> 	   ACPI_PROCESSOR is the last one in the series.
> 	2) Used GENMASK and other changes to address Drew's comments.
> 	3) Moved common functions required by both DT and ACPI based cpuidle
> 	   drivers from the DT driver to common arch/riscv/suspend.c.
> 	4) ACPI cpuidle driver is added under drivers/acpi/riscv
> 	5) Rebased to latest for-next branch of linux-riscv.
> 
> 
> Sunil V L (3):
>   cpuidle: RISC-V: Move few functions to arch/riscv
>   ACPI: RISC-V: Add LPI driver
>   ACPI: Enable ACPI_PROCESSOR for RISC-V
> 
>  arch/riscv/include/asm/suspend.h    |  3 ++
>  arch/riscv/kernel/suspend.c         | 49 +++++++++++++++++
>  drivers/acpi/Kconfig                |  2 +-
>  drivers/acpi/riscv/Makefile         |  3 +-
>  drivers/acpi/riscv/cpuidle.c        | 81 +++++++++++++++++++++++++++++
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 49 ++---------------
>  6 files changed, 141 insertions(+), 46 deletions(-)
>  create mode 100644 drivers/acpi/riscv/cpuidle.c
> 
> -- 
> 2.34.1
> 

