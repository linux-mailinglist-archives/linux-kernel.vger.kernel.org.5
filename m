Return-Path: <linux-kernel+bounces-102746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E02E187B6D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C061F216EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095BE10A39;
	Thu, 14 Mar 2024 03:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMfACicE"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8565110A0C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 03:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710386605; cv=none; b=BdbtTrpipqDwQZKZxwKpj2lJWPYAeyQxwcQxJBadYBRF+/8C+c6xN3OoYXofeY3Z4417lrD0QOmnRweUmPOJD4wTzlcz3BUcct4oABArkYokfW/vgpA0e/YIrGam1mn41cmK4OJVNL1p1dMDYAtbZ1NMR8Xot99yykrYQzajVvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710386605; c=relaxed/simple;
	bh=s6H3z4vOEkPpYUtMELOATLUilw50LUpYqjPaTBzLdlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhMXJ9457lAYTm5gMdxviqiZqQrNfX2CP+p5d4TjgkMXNF42yYKpsTvtrnHuAcHVFATr3E6t4peR+33IeSK1akTgyt3qVz7fxY6ccwkrRb8ZlcMJmlZEKdpEjrrrDz7r3YKRGpAZACMXrlv1CxCClwOemTG0j3ZFpAjfDNBHkP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMfACicE; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512f892500cso547972e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710386602; x=1710991402; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vi78B0nzIeBRacJX5kaa6m0PzotVzHiwM1adWtYD49I=;
        b=KMfACicEEKw40S83glewPD5hc39SO0ADHMcl7AT905Rm9Q6b+2wSPBEU5wF5hZR+3v
         ZeUZFhkoBJtmCkx7QS+KVIAfGI2E1kyTv475DYemJMt+3hk+pe3xwmmXpqW06mZiAAMc
         3GeTSBudhxXA+cF7lFbrgtRGKUljG+ls5uojBArB4rkA5kQRRkfU51tnuzCZkmxE4g+5
         Ib49lce7LvzfRUdq5MgdtwxSPPWhIPqN3b409isgQAqW3o8FtMC+EmnKjlls48Ok/T9e
         8hMJ9+8Ou+TAFKv7UTUN60kPLU3S4Rk0wPlrqpj1KOLEIW2moMtPkbIJ9ZISU9yFpOa/
         eExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710386602; x=1710991402;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vi78B0nzIeBRacJX5kaa6m0PzotVzHiwM1adWtYD49I=;
        b=E/M+vj6kdBzTJL7EDL49v42bje3RtZoP6Dd20YjOK230r0gF7pmgWFV0DPWskrlCsP
         AqMTPKwIop2/kq4qs72wUuvbn8uCioP7cNPYpvs1C4sNKlU849nqlCEylPUJc1uudOIW
         bdHpVq/mJj7Hizm0dcJbxxjxdk2+iJyavrzI3PJbf/iOFOOSa84iTOwmLPS2lGQ/e0Km
         PKs3GS0nbBjl8vTKvrfIaPLWoSI5KpmVVh4j5+jXZncQRyf+pRDKscMM0T4ThvhnWBr8
         vMLJs1JaNMtkTUQcPUJHkR5SDA9Wwo0HhP6N9hPKqjRJ/YNAduoXyRbxK9U6kj5qGfe1
         DYHQ==
X-Forwarded-Encrypted: i=1; AJvYcCURhQkX8/c9z4xCMAb10auBpUkJLYI4adYVnbrdEdwHr09wp3qYT77hoOZdIoyYYcB5vi5dGMJLfmGDMbNnUkq4pL5Ag8IsWM6acgqQ
X-Gm-Message-State: AOJu0Ywb7mziQoItt52Oddk+H0gdfigckHOFy4q9A3SEG+GX3kGIa71f
	aBsk8J8dOKO+zFaqlkyMR9htUUjINrfWsq5SVJPA+aEAa3trh8aK9UYK7FqzywQ=
X-Google-Smtp-Source: AGHT+IFuH38DFBT9iEjTReyUR/v0emSuwvfVcPBntpl/XWWipb6T1F7+2y6jU2tFUngH8ZMJR3ocJg==
X-Received: by 2002:ac2:4d91:0:b0:513:a738:20f1 with SMTP id g17-20020ac24d91000000b00513a73820f1mr250673lfe.25.1710386601348;
        Wed, 13 Mar 2024 20:23:21 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id n20-20020a05640205d400b005683bc91f5csm268520edx.0.2024.03.13.20.23.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2024 20:23:20 -0700 (PDT)
Date: Thu, 14 Mar 2024 03:23:20 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] x86/boot: replace __PHYSICAL_START with
 LOAD_PHYSICAL_ADDR
Message-ID: <20240314032320.iug2hvzyblychanu@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240313075839.8321-1-richard.weiyang@gmail.com>
 <20240313075839.8321-3-richard.weiyang@gmail.com>
 <ZfF/ekjP9R91dw2j@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfF/ekjP9R91dw2j@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Mar 13, 2024 at 11:29:33AM +0100, Ingo Molnar wrote:
>
>* Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> Both __PHYSICAL_START and LOAD_PHYSICAL_ADDR are defined to get aligned
>> CONFIG_PHYSICAL_START, so we can replace __PHYSICAL_START with
>> LOAD_PHYSICAL_ADDR. And then remove the definition of __PHYSICAL_START,
>> which is only used to define __START_KERNEL.
>> 
>> Since <asm/boot.h> includes <asm/pgtable_types.h>, which includes
>> <asm/page_types.h>, it is fine to move definition from <asm/boot.h> to
>> <asm/page_types.h>.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>>  arch/x86/include/asm/boot.h       | 5 -----
>>  arch/x86/include/asm/page_types.h | 8 +++++---
>>  2 files changed, 5 insertions(+), 8 deletions(-)
>> 
>> diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
>> index a38cc0afc90a..12cbc57d0128 100644
>> --- a/arch/x86/include/asm/boot.h
>> +++ b/arch/x86/include/asm/boot.h
>> @@ -6,11 +6,6 @@
>>  #include <asm/pgtable_types.h>
>>  #include <uapi/asm/boot.h>
>>  
>> -/* Physical address where kernel should be loaded. */
>> -#define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
>> -				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
>> -				& ~(CONFIG_PHYSICAL_ALIGN - 1))
>> -
>>  /* Minimum kernel alignment, as a power of two */
>>  #ifdef CONFIG_X86_64
>>  # define MIN_KERNEL_ALIGN_LG2	PMD_SHIFT
>> diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
>> index 86bd4311daf8..acc1620fd121 100644
>> --- a/arch/x86/include/asm/page_types.h
>> +++ b/arch/x86/include/asm/page_types.h
>> @@ -31,10 +31,12 @@
>>  
>>  #define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
>>  
>> -#define __PHYSICAL_START	ALIGN(CONFIG_PHYSICAL_START, \
>> -				      CONFIG_PHYSICAL_ALIGN)
>> +/* Physical address where kernel should be loaded. */
>> +#define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
>> +				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
>> +				& ~(CONFIG_PHYSICAL_ALIGN - 1))
>
>I agree with this simplification, but the ALIGN() expression is far easier 
>to read, so please keep that one instead of the open-coded version.
>

I just tried to define LOAD_PHYSICAL_ADDR by ALIGN, but face a compile error
on compressed/head_[32|64].o.

$ make arch/x86/boot/compressed/head_64.o
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  AS      arch/x86/boot/compressed/head_64.o
arch/x86/boot/compressed/head_64.S: Assembler messages:
arch/x86/boot/compressed/head_64.S:154: Error: junk (0x1000000,0x200000)' after expression
arch/x86/boot/compressed/head_64.S:154: Error: number of operands mismatch for 16' after expression
arch/x86/boot/compressed/head_64.S:157: Error: junk mov'
arch/x86/boot/compressed/head_64.S:330: Error: junk (0x1000000,0x200000)' after expression
arch/x86/boot/compressed/head_64.S:330: Error: number of operands mismatch for 16' after expression
arch/x86/boot/compressed/head_64.S:333: Error: junk movq'

If my understanding is correct, the reason is linkage.h defines ALIGN, which
is ".balign xxx". Maybe this is why original LOAD_PHYSICAL_ADDR doesn't use
ALIGN.

So is this ok to keep the open-coded definition?

>Thanks,
>
>	Ingo

-- 
Wei Yang
Help you, Help me

