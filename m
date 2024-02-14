Return-Path: <linux-kernel+bounces-64605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB3A8540CB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526DD1F2B05A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10767E2;
	Wed, 14 Feb 2024 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ViEHfV3o"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FED87F;
	Wed, 14 Feb 2024 00:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869959; cv=none; b=E05m+9gn5/BkUQFAjmlzVEmZsjkgUZ55i7GtogbCe3ieJWbdr9qsBYOT8LdNk+zK2BHdqziag8xJm+01IsDVvhamWF0t2CifRH7jJg2dBH5qAhSdVkCTMgkwFguc+0wGcscwVguF//BqFHAdEbXCAz5M6pw+XXTHTh9wxkuns0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869959; c=relaxed/simple;
	bh=QAN7hZYSM3BJP81M/eLzNlJdF60Jewpg46NuJgdpOG0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kt+yUnUgbs3GIQof+AU3VOWVyK1ZjL1sFvC9RFiCZhtwJA7BXoshpYNb5sj0f+XpTlxbUqzlBnIj1ttXFjmSiv8QemZnwQySxsUgK7xLMkHuQFFAjm5XiDlZzftTPonkbCjLT+vLENomaa5X4ARYPbiLQo+W6Ab7hdvgZ7jOpCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ViEHfV3o; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.232.238] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 16E3E20B2000;
	Tue, 13 Feb 2024 16:19:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 16E3E20B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707869951;
	bh=H/WOKYyDPl6rQRUKTgqiCkym15mdTfioSDzSyvm7rqA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=ViEHfV3oyxygjlUGYt/LLeSl96uQs8jUhmk++Wv0C8TJztCa2gsJu2BznCSuDKBMD
	 Y2/gocRsP3+tPKr+v1ioILaBAZgaNkFZ/7Csq8saVZ9Rnve6jLiSBiiFTH8NEc9DQP
	 WJK+8Ydb2sCZPAKXYfMdgk3C8JBWvZjSK4I6Ar0M=
Message-ID: <18b3ac3e-2bfc-4fce-9be4-3e75e487f9fc@linux.microsoft.com>
Date: Tue, 13 Feb 2024 16:19:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: Re: [PATCH] arm64: Subscribe Microsoft Azure Cobalt 100 to ARM
 Neoverse N2 errata
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>, Rob Herring <robh@kernel.org>,
 Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>,
 "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>, stable@vger.kernel.org
References: <20240212232909.2276378-1-eahariha@linux.microsoft.com>
 <ZcqtUxhqUbYoRH-G@linux.dev>
Content-Language: en-US
In-Reply-To: <ZcqtUxhqUbYoRH-G@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/2024 3:44 PM, Oliver Upton wrote:
> Hi Easwar,
> 
> On Mon, Feb 12, 2024 at 11:29:06PM +0000, Easwar Hariharan wrote:
>> Add the MIDR value of Microsoft Azure Cobalt 100, which is a Microsoft
>> implemented CPU based on r0p0 of the ARM Neoverse N2 CPU, and therefore
>> suffers from all the same errata.
> 
> Can you comment at all on where one might find this MIDR? That is, does
> your hypervisor report the native MIDR of the implementation or does it
> repaint it as an Arm Neoverse N2 (0x410FD490)?

We will check on the Microsoft hypervisor's plans, and get back to you.

Notwithstanding that, we do have baremetal use cases for Microsoft Azure Cobalt 100
as well where this MIDR value will show through.

> 
>> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
>> index 7c7493cb571f..a632a7514e55 100644
>> --- a/arch/arm64/include/asm/cputype.h
>> +++ b/arch/arm64/include/asm/cputype.h
>> @@ -61,6 +61,7 @@
>>  #define ARM_CPU_IMP_HISI		0x48
>>  #define ARM_CPU_IMP_APPLE		0x61
>>  #define ARM_CPU_IMP_AMPERE		0xC0
>> +#define ARM_CPU_IMP_MICROSOFT		0x6D
>>  
>>  #define ARM_CPU_PART_AEM_V8		0xD0F
>>  #define ARM_CPU_PART_FOUNDATION		0xD00
>> @@ -135,6 +136,8 @@
>>  
>>  #define AMPERE_CPU_PART_AMPERE1		0xAC3
>>  
>> +#define MSFT_CPU_PART_AZURE_COBALT_100	0xD49 /* Based on r0p0 of ARM Neoverse N2 */
>> +
>>  #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
>>  #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
>>  #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
>> @@ -193,6 +196,7 @@
>>  #define MIDR_APPLE_M2_BLIZZARD_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_BLIZZARD_MAX)
>>  #define MIDR_APPLE_M2_AVALANCHE_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_AVALANCHE_MAX)
>>  #define MIDR_AMPERE1 MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1)
>> +#define MIDR_MICROSOFT_AZURE_COBALT_100 MIDR_CPU_MODEL(ARM_CPU_IMP_MICROSOFT, MSFT_CPU_PART_AZURE_COBALT_100)
> 
> nitpick: consistently use the abbreviated 'MSFT' for all the definitions
> you're adding.
> 

I was rather hoping to use Microsoft throughout, but I chose MSFT for the CPU_PART* to align columns
with the other defines. :) If consistency is of a higher priority than column alignment, I can change it
to MICROSOFT rather than MSFT throughout.

Thanks,
Easwar


