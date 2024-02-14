Return-Path: <linux-kernel+bounces-65793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD878551E8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2871F29D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E341292F9;
	Wed, 14 Feb 2024 18:15:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4295B126F38;
	Wed, 14 Feb 2024 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934505; cv=none; b=UGdZEhSYUuv1R/xFLQIoFrvhi7ab+xC77pHhY9/4+uhsvCug373JBZTp4KrT2evWucg8dB/ngyWE8MR5V2rJxN5h0eUim9lkN9eX1jOWgeW33fdt7RGlE/NEBGW+0Q+oR4u91nPyCNn1kffTrPVbBFQ8E+UXvyk1vLDFjK2AsGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934505; c=relaxed/simple;
	bh=RjqtADI9MyVFi2kOV6/vS40eHkYIpFO3ZcnSOROaE1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0w+HL9RogYz0OazKVt7MJoqPrw/6Q3EsO0CRqdZG5sXL7uINOoGezMKtBcszAsqDEBgYrNE2NSHbKHzMuxgZcFmYayjtSmI0wLXFYgrMrJOcS9xLBWkYCjHFytyu0k95VzTiu3pHvFk3LO+c0xXJ4LDH3+ayIrmoAUmZwfnckk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28EE21FB;
	Wed, 14 Feb 2024 10:15:43 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.64.145])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED1813F7B4;
	Wed, 14 Feb 2024 10:14:59 -0800 (PST)
Date: Wed, 14 Feb 2024 18:14:51 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Subscribe Microsoft Azure Cobalt 100 to ARM
 Neoverse N2 errata
Message-ID: <Zc0DEmbhgPMessV0@FVFF77S0Q05N>
References: <20240214175522.2457857-1-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214175522.2457857-1-eahariha@linux.microsoft.com>

On Wed, Feb 14, 2024 at 05:55:18PM +0000, Easwar Hariharan wrote:
> Add the MIDR value of Microsoft Azure Cobalt 100, which is a Microsoft
> implemented CPU based on r0p0 of the ARM Neoverse N2 CPU, and therefore
> suffers from all the same errata.
> 
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

I assume that Catalin/Will will take this through the arm64 tree.

Mark.

> ---
> changelog:
> v1->v2:
> * v1: https://lore.kernel.org/linux-arm-kernel/20240212232909.2276378-1-eahariha@linux.microsoft.com/T/#u
> * Consistently use MICROSOFT throughout
> ---
>  Documentation/arch/arm64/silicon-errata.rst | 7 +++++++
>  arch/arm64/include/asm/cputype.h            | 4 ++++
>  arch/arm64/kernel/cpu_errata.c              | 3 +++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
> index e8c2ce1f9df6..45a7f4932fe0 100644
> --- a/Documentation/arch/arm64/silicon-errata.rst
> +++ b/Documentation/arch/arm64/silicon-errata.rst
> @@ -243,3 +243,10 @@ stable kernels.
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ASR            | ASR8601         | #8601001        | N/A                         |
>  +----------------+-----------------+-----------------+-----------------------------+
> ++----------------+-----------------+-----------------+-----------------------------+
> +| Microsoft      | Azure Cobalt 100| #2139208        | ARM64_ERRATUM_2139208       |
> ++----------------+-----------------+-----------------+-----------------------------+
> +| Microsoft      | Azure Cobalt 100| #2067961        | ARM64_ERRATUM_2067961       |
> ++----------------+-----------------+-----------------+-----------------------------+
> +| Microsoft      | Azure Cobalt 100| #2253138        | ARM64_ERRATUM_2253138       |
> ++----------------+-----------------+-----------------+-----------------------------+
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 7c7493cb571f..52f076afeb96 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -61,6 +61,7 @@
>  #define ARM_CPU_IMP_HISI		0x48
>  #define ARM_CPU_IMP_APPLE		0x61
>  #define ARM_CPU_IMP_AMPERE		0xC0
> +#define ARM_CPU_IMP_MICROSOFT		0x6D
>  
>  #define ARM_CPU_PART_AEM_V8		0xD0F
>  #define ARM_CPU_PART_FOUNDATION		0xD00
> @@ -135,6 +136,8 @@
>  
>  #define AMPERE_CPU_PART_AMPERE1		0xAC3
>  
> +#define MICROSOFT_CPU_PART_AZURE_COBALT_100	0xD49 /* Based on r0p0 of ARM Neoverse N2 */
> +
>  #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
>  #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
>  #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
> @@ -193,6 +196,7 @@
>  #define MIDR_APPLE_M2_BLIZZARD_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_BLIZZARD_MAX)
>  #define MIDR_APPLE_M2_AVALANCHE_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_AVALANCHE_MAX)
>  #define MIDR_AMPERE1 MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1)
> +#define MIDR_MICROSOFT_AZURE_COBALT_100 MIDR_CPU_MODEL(ARM_CPU_IMP_MICROSOFT, MICROSOFT_CPU_PART_AZURE_COBALT_100)
>  
>  /* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
>  #define MIDR_FUJITSU_ERRATUM_010001		MIDR_FUJITSU_A64FX
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 967c7c7a4e7d..76b8dd37092a 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -374,6 +374,7 @@ static const struct midr_range erratum_1463225[] = {
>  static const struct midr_range trbe_overwrite_fill_mode_cpus[] = {
>  #ifdef CONFIG_ARM64_ERRATUM_2139208
>  	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
> +	MIDR_ALL_VERSIONS(MIDR_MICROSOFT_AZURE_COBALT_100),
>  #endif
>  #ifdef CONFIG_ARM64_ERRATUM_2119858
>  	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
> @@ -387,6 +388,7 @@ static const struct midr_range trbe_overwrite_fill_mode_cpus[] = {
>  static const struct midr_range tsb_flush_fail_cpus[] = {
>  #ifdef CONFIG_ARM64_ERRATUM_2067961
>  	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
> +	MIDR_ALL_VERSIONS(MIDR_MICROSOFT_AZURE_COBALT_100),
>  #endif
>  #ifdef CONFIG_ARM64_ERRATUM_2054223
>  	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
> @@ -399,6 +401,7 @@ static const struct midr_range tsb_flush_fail_cpus[] = {
>  static struct midr_range trbe_write_out_of_range_cpus[] = {
>  #ifdef CONFIG_ARM64_ERRATUM_2253138
>  	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
> +	MIDR_ALL_VERSIONS(MIDR_MICROSOFT_AZURE_COBALT_100),
>  #endif
>  #ifdef CONFIG_ARM64_ERRATUM_2224489
>  	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
> -- 
> 2.34.1
> 

