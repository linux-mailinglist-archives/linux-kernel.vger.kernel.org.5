Return-Path: <linux-kernel+bounces-62555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0488522B8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C71283DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FC450254;
	Mon, 12 Feb 2024 23:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rUiMa8Qs"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEC04F897
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781476; cv=none; b=bioS7LytyfxMtl/GCCyTFKS9rd5flWj26SjHrxIpvtfPw6I+uZuRYMx+KpE+m0flCFqBBfGmdAxt54RVvJlfSMVKGl9TSCTBr8xgkbNzjn1S9LMGqD0yp2NtiASuGyLawwqiVhdZV7NZXg/5e/hV9pNlUOOHoHlpezfMmrbFvJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781476; c=relaxed/simple;
	bh=cw39m76UFq9tS5p8ZskWMb2lcc6vwhiwppLpIPjMO3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mfmb2x4BHsJVkCHw+4uRxt9jUI+f2m/uCaUnGPaTGh5CGyhZUaeSJwVX5fWPMCE+7DxRNM2BvHKA3P6sDH10WgKvQ4RAujmhRl3VXWRStoBEqJIqmrNaR6Zy3lyzde1nZq4KjZidvKuMlkI47TdaasF9VSLGIsMzjCiChjsbGW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rUiMa8Qs; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 12 Feb 2024 15:44:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707781472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZavUZpfe4iXVeRQFF+1YAOemYZZVmPWyKDi8FAoNTa0=;
	b=rUiMa8QsnFQtpiR5C1+Uh/5PkvOSlnbxRtk2SQk/Z8VQaTr2nGOj+Kf6LQkivTtOFVviOx
	GtgnjamJJ3OTOqokx2EVRawtG0F5T88rRMMmwZRO8BLNIPMXRuYGO00y68upFxf8CSktjH
	smPhG3fjddzVZacfdEptan3ZSePE3uY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Rob Herring <robh@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: Subscribe Microsoft Azure Cobalt 100 to ARM
 Neoverse N2 errata
Message-ID: <ZcqtUxhqUbYoRH-G@linux.dev>
References: <20240212232909.2276378-1-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212232909.2276378-1-eahariha@linux.microsoft.com>
X-Migadu-Flow: FLOW_OUT

Hi Easwar,

On Mon, Feb 12, 2024 at 11:29:06PM +0000, Easwar Hariharan wrote:
> Add the MIDR value of Microsoft Azure Cobalt 100, which is a Microsoft
> implemented CPU based on r0p0 of the ARM Neoverse N2 CPU, and therefore
> suffers from all the same errata.

Can you comment at all on where one might find this MIDR? That is, does
your hypervisor report the native MIDR of the implementation or does it
repaint it as an Arm Neoverse N2 (0x410FD490)?

> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 7c7493cb571f..a632a7514e55 100644
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
> +#define MSFT_CPU_PART_AZURE_COBALT_100	0xD49 /* Based on r0p0 of ARM Neoverse N2 */
> +
>  #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
>  #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
>  #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
> @@ -193,6 +196,7 @@
>  #define MIDR_APPLE_M2_BLIZZARD_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_BLIZZARD_MAX)
>  #define MIDR_APPLE_M2_AVALANCHE_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_AVALANCHE_MAX)
>  #define MIDR_AMPERE1 MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1)
> +#define MIDR_MICROSOFT_AZURE_COBALT_100 MIDR_CPU_MODEL(ARM_CPU_IMP_MICROSOFT, MSFT_CPU_PART_AZURE_COBALT_100)

nitpick: consistently use the abbreviated 'MSFT' for all the definitions
you're adding.

-- 
Thanks,
Oliver

