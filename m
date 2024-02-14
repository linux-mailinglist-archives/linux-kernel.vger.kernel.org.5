Return-Path: <linux-kernel+bounces-65103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6E38547D0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB57529086C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE06E1946B;
	Wed, 14 Feb 2024 11:11:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF1F18E28;
	Wed, 14 Feb 2024 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909085; cv=none; b=OPfil/lJ7dRJ94XHc5fbqCT11vhnaIT8+ty9yCty6MVv1DY4EUQZ685AbVC9v2k7mEam6/lY4MQRD3OK3GO4SMINVsURjlhkLqbxxZDZHOn8hHttDsKG9tZBj1x5zDevNxDz0hZIbz7FBZ0W064lBZvCRDBhzVUAR5FC6TtN7WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909085; c=relaxed/simple;
	bh=HsZd4cCR70HE0iyjlUKYCOohLKrz8PN3AKztuMP3OWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=la3AL3Czfumqllwr7wFA3ndGh8aHuM7sbAlnyVsZ73KiZxHx3y5/4NFSn3gMPJ9xUNmOqMU4TCHyP1dqIEJHZ6BauqPJPv+L4VpbPMSyPctXnqRP8Sz1Q4SBMCmU96zfshqH3iv+fC4eVzYjBfBkEw+nCmJ3iAHaz31HCsVmnPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC7D61FB;
	Wed, 14 Feb 2024 03:12:03 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.64.145])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 957893F766;
	Wed, 14 Feb 2024 03:11:20 -0800 (PST)
Date: Wed, 14 Feb 2024 11:11:14 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Rob Herring <robh@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: Subscribe Microsoft Azure Cobalt 100 to ARM
 Neoverse N2 errata
Message-ID: <Zcyf0oIJe7ukH0si@FVFF77S0Q05N>
References: <20240212232909.2276378-1-eahariha@linux.microsoft.com>
 <ZcqtUxhqUbYoRH-G@linux.dev>
 <18b3ac3e-2bfc-4fce-9be4-3e75e487f9fc@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18b3ac3e-2bfc-4fce-9be4-3e75e487f9fc@linux.microsoft.com>

On Tue, Feb 13, 2024 at 04:19:08PM -0800, Easwar Hariharan wrote:
> >> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> >> index 7c7493cb571f..a632a7514e55 100644
> >> --- a/arch/arm64/include/asm/cputype.h
> >> +++ b/arch/arm64/include/asm/cputype.h
> >> @@ -61,6 +61,7 @@
> >>  #define ARM_CPU_IMP_HISI		0x48
> >>  #define ARM_CPU_IMP_APPLE		0x61
> >>  #define ARM_CPU_IMP_AMPERE		0xC0
> >> +#define ARM_CPU_IMP_MICROSOFT		0x6D
> >>  
> >>  #define ARM_CPU_PART_AEM_V8		0xD0F
> >>  #define ARM_CPU_PART_FOUNDATION		0xD00
> >> @@ -135,6 +136,8 @@
> >>  
> >>  #define AMPERE_CPU_PART_AMPERE1		0xAC3
> >>  
> >> +#define MSFT_CPU_PART_AZURE_COBALT_100	0xD49 /* Based on r0p0 of ARM Neoverse N2 */
> >> +
> >>  #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
> >>  #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
> >>  #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
> >> @@ -193,6 +196,7 @@
> >>  #define MIDR_APPLE_M2_BLIZZARD_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_BLIZZARD_MAX)
> >>  #define MIDR_APPLE_M2_AVALANCHE_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_AVALANCHE_MAX)
> >>  #define MIDR_AMPERE1 MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1)
> >> +#define MIDR_MICROSOFT_AZURE_COBALT_100 MIDR_CPU_MODEL(ARM_CPU_IMP_MICROSOFT, MSFT_CPU_PART_AZURE_COBALT_100)
> > 
> > nitpick: consistently use the abbreviated 'MSFT' for all the definitions
> > you're adding.
> 
> I was rather hoping to use Microsoft throughout, but I chose MSFT for the CPU_PART* to align columns
> with the other defines. :) If consistency is of a higher priority than column alignment, I can change it
> to MICROSOFT rather than MSFT throughout.

Consistency across the definitions is more important than alignmen; please
choose either "MSFT" or "MICROSOFT" and use that consistently.

Mark.

