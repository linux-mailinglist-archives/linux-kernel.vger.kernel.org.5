Return-Path: <linux-kernel+bounces-65584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 767C5854F13
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BABE1C2206A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338BE604D9;
	Wed, 14 Feb 2024 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UJwLC3Nl"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FC560273;
	Wed, 14 Feb 2024 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929336; cv=none; b=Kt+ld7GXWAeENkM0nv3jX31er3vI7cIxjdKdzBeakl6cqInvpL/rmv230BToh2gLKmCuaIXGldvY1YVIMYIkLv44uRPrMHejHCn8yNjno4dslxW+siW3AA44I3MoTUQWan4TRBuAX1mxIrHu91vV5ka70mgaqNV8UxCWd+bcCJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929336; c=relaxed/simple;
	bh=NmM56gqPvUymNtGZLWDbLYuIQw40e9xCEmB6pNwzYbE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PxlbPnpqBRetKYd01DcRpcxgnoY2rbYxXEAfSTuzS6eC+9E4+xbeZZo/UYo97/geeueSenqxObhEI1GltTWUPjvUpDCTLKKq1ggn5eezGNBsNCm5nqOFU8OrhhJ5XmGbkEFoeqfIN/To1v5c+QxhSDD8c2GrbfdShANq96h1HXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UJwLC3Nl; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F952C0005;
	Wed, 14 Feb 2024 16:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707929331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D1Xkso4/luCnCKmls1XObu6mUiNp8i4jcJTznrQv8Nw=;
	b=UJwLC3Nlmt0bX5sP8DqteDyKkHocT208N6iY6iwCQjGZvM/w/raRC6Z6u0GZvDlLlB7WiT
	e6Iq6q5lkA3NDDxu3e6VTZ3SuYafkYnaYvhT69fos5yQ/kpsFQSsH99X4Gxkpk9PwXspnE
	Eosba5GhY3zH8D8L4Y0dUSedb4ST5pvWvOF/L5nLG264pvtCXoInMXh3ES8NuMvVWL2iSZ
	BarDtR7VJzn2T/88ytOWk0o/O2zF0BA4FiCnU0dybZLGUqLtm3j2pwsbTFwHlX3ep4+d9e
	ceGEeiTNv0Zo3SJth1fPqh9WWDB1KUzAwMMoBgDv2gRpcPuh10MWWs6iEq0MOw==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>, linux-mips@vger.kernel.org, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir
 Kondratiev <vladimir.kondratiev@mobileye.com>, Tawfik Bayouk
 <tawfik.bayouk@mobileye.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, =?utf-8?Q?Th=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 03/14] MIPS: Allows relocation exception vectors
 everywhere
In-Reply-To: <ZcTE8nKCaKuaUvAe@alpha.franken.de>
References: <20240205153503.574468-1-gregory.clement@bootlin.com>
 <20240205153503.574468-4-gregory.clement@bootlin.com>
 <ZcTE8nKCaKuaUvAe@alpha.franken.de>
Date: Wed, 14 Feb 2024 17:48:51 +0100
Message-ID: <87plwzj8jw.fsf@BL-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com

Thomas Bogendoerfer <tsbogend@alpha.franken.de> writes:

> On Mon, Feb 05, 2024 at 04:34:49PM +0100, Gregory CLEMENT wrote:
>> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> 
>> Now the exception vector for CPS systems are allocated on-fly
>> with memblock as well.
>> 
>> It will try to allocate from KSEG1 first, and then try to allocate
>> in low 4G if possible.
>> 
>> The main reset vector is now generated by uasm, to avoid tons
>> of patches to the code. Other vectors are copied to the location
>> later.
>> 
>> gc: use the new macro CKSEG[0A1]DDR_OR_64BIT()
>>     move 64bits fix in an other patch
>>     fix cache issue with mips_cps_core_entry
>>     rewrite the patch to reduce the diff stat
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>  arch/mips/include/asm/mips-cm.h |   1 +
>>  arch/mips/include/asm/smp-cps.h |   4 +-
>>  arch/mips/kernel/cps-vec.S      |  48 ++-------
>>  arch/mips/kernel/smp-cps.c      | 171 +++++++++++++++++++++++++++-----
>>  4 files changed, 157 insertions(+), 67 deletions(-)
>> [..]
>> diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
>> index dd55d59b88db3..f4cdd50177e0b 100644
>> --- a/arch/mips/kernel/smp-cps.c
>> +++ b/arch/mips/kernel/smp-cps.c
>> @@ -7,6 +7,7 @@
>>  #include <linux/cpu.h>
>>  #include <linux/delay.h>
>>  #include <linux/io.h>
>> +#include <linux/memblock.h>
>>  #include <linux/sched/task_stack.h>
>>  #include <linux/sched/hotplug.h>
>>  #include <linux/slab.h>
>> @@ -25,7 +26,34 @@
>>  #include <asm/time.h>
>>  #include <asm/uasm.h>
>>  
>> +#define BEV_VEC_SIZE	0x500
>> +#define BEV_VEC_ALIGN	0x1000
>> +
>> +#define A0		4
>> +#define A1		5
>> +#define T9		25
>> +#define K0		26
>> +#define K1		27
>> +
>> +#define C0_STATUS	12, 0
>> +#define C0_CAUSE	13, 0
>> +
>> +#define ST0_NMI_BIT	19
>> +#ifdef CONFIG_64BIT
>> +#define ST0_KX_IF_64	ST0_KX
>> +#else
>> +#define ST0_KX_IF_64	0
>> +#endif
>
> please move this together with the other defines in arch/mips/kvm/entry.c
> to a header file (arch/mips/include/asm/uasm.h sounds like a good fit).


Jiaxun Yang sent a series to address it [1]. I managed to rebase my
series on top of this one.

Do you agree with these 8 patches?

Can I send my next series with the assumption that it will be merged?

Gregory

1: https://lore.kernel.org/linux-mips/20240209-regname-v1-0-2125efa016ef@flygoat.com/


-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

