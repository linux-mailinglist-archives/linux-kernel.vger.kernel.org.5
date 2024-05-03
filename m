Return-Path: <linux-kernel+bounces-167864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D048BB07C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C010281469
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE52155322;
	Fri,  3 May 2024 16:01:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDF026AF5
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752061; cv=none; b=O6d8d/8Zq4lPH0T0vzHF3XvU3fD40ay0FTxcU1uV3lEfubGlZvb9TkHVvBZ+P0K/bdlbrTc9CNNCWGezjWybMPVCH3e6czTMW1yGbCr5KaawJcppvgoTO08I52H647fdRHkCjdgvbtH8zBKf6P+N7bGqjeG76Sc9kkWZy4Ahstg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752061; c=relaxed/simple;
	bh=AzrwmgjmsQOHBRTm2KCP6QAVQci1+KUTVkY25ZOI5G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUF9C3UM72BYbeEXYFTUCHDRBsGXcD89KAf2ywy68YQNmYQFlP9ETH435kHNa204U8r6Ty4PRwi7lpjBXKq9f/0Y2cWcc0EtvVIzgvtqQNEUUFYvQDsR4sOJ8gj5NrjOAgRKDoumVVpWbSVnGc1c7R5GMMZSobmQ/rziENqgOsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C3BD13D5;
	Fri,  3 May 2024 09:01:23 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.34.156])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41A513F793;
	Fri,  3 May 2024 09:00:52 -0700 (PDT)
Date: Fri, 3 May 2024 17:00:49 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Liao Chang <liaochang1@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, tglx@linutronix.de, ardb@kernel.org,
	broonie@kernel.org, anshuman.khandual@arm.com,
	miguel.luis@oracle.com, joey.gouly@arm.com, ryan.roberts@arm.com,
	jeremy.linton@arm.com, ericchancf@google.com,
	kristina.martsenko@arm.com, robh@kernel.org,
	scott@os.amperecomputing.com, songshuaishuai@tinylab.org,
	shijie@os.amperecomputing.com, akpm@linux-foundation.org,
	bhe@redhat.com, horms@kernel.org, mhiramat@kernel.org,
	rmk+kernel@armlinux.org.uk, shahuang@redhat.com,
	takakura@valinux.co.jp, dianders@chromium.org, swboyd@chromium.org,
	sumit.garg@linaro.org, frederic@kernel.org, reijiw@google.com,
	akihiko.odaki@daynix.com, ruanjinjie@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v3 1/8] arm64/sysreg: Add definitions for immediate
 versions of MSR ALLINT
Message-ID: <ZjUKMWPknEhLYoK8@FVFF77S0Q05N>
References: <20240415064758.3250209-1-liaochang1@huawei.com>
 <20240415064758.3250209-2-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415064758.3250209-2-liaochang1@huawei.com>

On Mon, Apr 15, 2024 at 06:47:51AM +0000, Liao Chang wrote:
> From: Mark Brown <broonie@kernel.org>
> 
> Encodings are provided for ALLINT which allow setting of ALLINT.ALLINT
> using an immediate rather than requiring that a register be loaded with
> the value to write. Since these don't currently fit within the scheme we
> have for sysreg generation add manual encodings like we currently do for
> other similar registers such as SVCR.
> 
> Since it is required that these immediate versions be encoded with xzr
> as the source register provide asm wrapper which ensure this is the
> case.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  arch/arm64/include/asm/nmi.h    | 27 +++++++++++++++++++++++++++
>  arch/arm64/include/asm/sysreg.h |  2 ++
>  2 files changed, 29 insertions(+)
>  create mode 100644 arch/arm64/include/asm/nmi.h

We have helpers for manipulating PSTATE bits; AFAICT we only need the three
lines below:

----8<----
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 9e8999592f3af..5c209d07ae57e 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -94,18 +94,21 @@
 
 #define PSTATE_PAN                     pstate_field(0, 4)
 #define PSTATE_UAO                     pstate_field(0, 3)
+#define PSTATE_ALLINT                  pstate_field(1, 0)
 #define PSTATE_SSBS                    pstate_field(3, 1)
 #define PSTATE_DIT                     pstate_field(3, 2)
 #define PSTATE_TCO                     pstate_field(3, 4)
 
 #define SET_PSTATE_PAN(x)              SET_PSTATE((x), PAN)
 #define SET_PSTATE_UAO(x)              SET_PSTATE((x), UAO)
+#define SET_PSTATE_ALLINT(x)           SET_PSTATE((x), ALLINT)
 #define SET_PSTATE_SSBS(x)             SET_PSTATE((x), SSBS)
 #define SET_PSTATE_DIT(x)              SET_PSTATE((x), DIT)
 #define SET_PSTATE_TCO(x)              SET_PSTATE((x), TCO)
 
 #define set_pstate_pan(x)              asm volatile(SET_PSTATE_PAN(x))
 #define set_pstate_uao(x)              asm volatile(SET_PSTATE_UAO(x))
+#define set_pstate_allint(x)           asm volatile(SET_PSTATE_ALLINT(x))
 #define set_pstate_ssbs(x)             asm volatile(SET_PSTATE_SSBS(x))
 #define set_pstate_dit(x)              asm volatile(SET_PSTATE_DIT(x))
---->8---- 

The addition of <asm/nmi.h> and refrences to <linux/cpumask.h> and
arm64_supports_nmi() don't seem like they should be part of this patch.

Mark.

> 
> diff --git a/arch/arm64/include/asm/nmi.h b/arch/arm64/include/asm/nmi.h
> new file mode 100644
> index 000000000000..0c566c649485
> --- /dev/null
> +++ b/arch/arm64/include/asm/nmi.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2022 ARM Ltd.
> + */
> +#ifndef __ASM_NMI_H
> +#define __ASM_NMI_H
> +
> +#ifndef __ASSEMBLER__
> +
> +#include <linux/cpumask.h>
> +
> +extern bool arm64_supports_nmi(void);
> +
> +#endif /* !__ASSEMBLER__ */
> +
> +static __always_inline void _allint_clear(void)
> +{
> +	asm volatile(__msr_s(SYS_ALLINT_CLR, "xzr"));
> +}
> +
> +static __always_inline void _allint_set(void)
> +{
> +	asm volatile(__msr_s(SYS_ALLINT_SET, "xzr"));
> +}
> +
> +#endif
> +
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 9e8999592f3a..b105773c57ca 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -167,6 +167,8 @@
>   * System registers, organised loosely by encoding but grouped together
>   * where the architected name contains an index. e.g. ID_MMFR<n>_EL1.
>   */
> +#define SYS_ALLINT_CLR			sys_reg(0, 1, 4, 0, 0)
> +#define SYS_ALLINT_SET			sys_reg(0, 1, 4, 1, 0)
>  #define SYS_SVCR_SMSTOP_SM_EL0		sys_reg(0, 3, 4, 2, 3)
>  #define SYS_SVCR_SMSTART_SM_EL0		sys_reg(0, 3, 4, 3, 3)
>  #define SYS_SVCR_SMSTOP_SMZA_EL0	sys_reg(0, 3, 4, 6, 3)
> -- 
> 2.34.1
> 

