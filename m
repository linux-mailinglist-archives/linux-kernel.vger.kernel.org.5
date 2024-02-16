Return-Path: <linux-kernel+bounces-68787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C77D85806B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1AF1F22ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AEE12F597;
	Fri, 16 Feb 2024 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN/gFtiX"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A30768F2;
	Fri, 16 Feb 2024 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096553; cv=none; b=WuAyRAMwx71i7zHYPK4pFBiNomkfcUOqdooE+5zB7D2SdJ3hvTmz8vOMw4WQHYNGIqhS6CRAJXW7j8nev6hmq1R4enpYbVTABFDiOysk0SyqO7SAv7+AX/NAfQheOBECj0g5WDomLtQbAQR0NB8aCeQg2jd8FKEng7uflmu2H/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096553; c=relaxed/simple;
	bh=lQHgNf4lZFaXKyQkFvpZd1nX0tMYYIakTZ3wulKXKFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmycuzPYPkwSpJaffE1i7T0yEewtSRTn2KKdaeOJz5UztTmDsUzg/0q3qiDxLgOKsHh7rwHktcPTQGVbrxpvO6P2h7t0mBlUm264omTtISZY7CoDt0ZmpZfiyp0CWZJiwexwOEc135yYNkoLA3osVztpZPhApTLCq2r85ICPbDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lN/gFtiX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e09493eb8eso2566513b3a.1;
        Fri, 16 Feb 2024 07:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708096551; x=1708701351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1fBU0BnRrjjNunok1eRCJ3FzNq+wuPw/Wc45OrLINiQ=;
        b=lN/gFtiXY9BEMJFkzfBIPVjWI6sCBBu12MQIRt7aF9N2Rd1VRCSxgDDWppqwrFofLn
         KyCd+2dT7uEIRZfM466A0rPhWbSrVyWKzvzinQM9MTTL26gI+Mtya8oGSwqzgg4rvjMx
         m06WqxYVhnJyh+Jz+sYLjHpSlj/gJ1bMmZE/FwYg27HrWT+krjFOblT91MR28lb26AS5
         OTXXyB9sAU4lNCULdGYnc29G44jqh3qsN4e8yxvSgG71Akf6pNdv/cuUqZM46u4kBdHk
         M9sGOvAK7fMfk8sUhn7/+xcVTdOvdSSatL7MZ3hQmkJ7kMK8tObYDdXGxQ1hvyHmVZQ6
         cgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708096551; x=1708701351;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1fBU0BnRrjjNunok1eRCJ3FzNq+wuPw/Wc45OrLINiQ=;
        b=UY2T3oW/d3YhKOASgbk/YUkaBuqPmQnX6WImUcckU7t+JvYd7Z2FSAq+5QRJnlmRqd
         756a8DDkD+z+fBfBPkqoWGgsa1FMmmDJ2tNOyvLTFGyVKs1mnCzn6hqaV1X/OkZJnpcG
         sa4rZ6Livmr9JxtuQVig4T15U/uTPpksaR4rGY6l/I/Y5BiU3Z38yQ5JHYdn2Jnc4qlA
         X+DJkQDn/dSeAiVU+M1nMysM+yODTbbK/3u1GoSZYedVFiPeCkB20vP3/sgf39rLX9mq
         +cbK7lm6jQFu9Hd7pR++dEhdbDCjqNEY+dPjvm2X2UJjjpqL/Fn8XjnEWg6X68sVWQYk
         AW3A==
X-Forwarded-Encrypted: i=1; AJvYcCWeovT/SpoaH96zSQGYVVwuZKHReitOEpDl8ouSlzT8l4yC7Dod/s2lPq3PjeAbxphORsV7aN3hRNhXEW3iGGJojhdSYJ4BP+nVjhT8
X-Gm-Message-State: AOJu0Ywp3PCxjwUp0RGTp3frAEZp7RWcslGZQn9Shad/+o2OngEP76Yr
	lGo+aQfF6DQJi4/dZh05R9x5Hz9gF0rhCAHc+fLtX4t33bJuQElvPHb0WWoL
X-Google-Smtp-Source: AGHT+IHSOKwPfjsHo155LHe/Nwr9Aw+9Sgs2fzFG+iK7odLLBBFofGw/97uFyN2fYy+tOygfIjWmow==
X-Received: by 2002:a05:6a21:150a:b0:19e:b477:33a4 with SMTP id nq10-20020a056a21150a00b0019eb47733a4mr7410349pzb.27.1708096550723;
        Fri, 16 Feb 2024 07:15:50 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i123-20020a62c181000000b006e0e4b9b7e6sm49131pfg.212.2024.02.16.07.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 07:15:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <06b53f95-2910-46d5-b968-14718d7e0ac6@roeck-us.net>
Date: Fri, 16 Feb 2024 07:15:49 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc/unaligned: Rewrite 64-bit inline assembly of
 emulate_ldd()
Content-Language: en-US
To: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240216073315.3801833-1-linux@roeck-us.net>
 <1e889ddc-e5ea-41c8-a316-61bae12dfa9c@gmx.de>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <1e889ddc-e5ea-41c8-a316-61bae12dfa9c@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/16/24 05:48, Helge Deller wrote:
> On 2/16/24 08:33, Guenter Roeck wrote:
>> Convert to use real temp variables instead of clobbering processor
>> registers.
> 
> Thanks for doing this.
> It was on my todo list since quite some time :-)
> 
>> This aligns the 64-bit inline assembly code with the 32-bit
>> assembly code which was rewritten with commit 427c1073a2a1
>> ("parisc/unaligned: Rewrite 32-bit inline assembly of emulate_ldd()").
>>
>> While at it, fix comment in 32-bit rewrite code. Temporary variables are
>> now used for both 32-bit and 64-bit code, so move their declarations
>> to the function header.
>>
>> No functional change intended.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> Implemented while analyzing a bug. I am not really sure of it is worth
>> the effort, but I figured that I might as well submit it.
>>
>>   arch/parisc/kernel/unaligned.c | 29 +++++++++++++----------------
>>   1 file changed, 13 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/parisc/kernel/unaligned.c b/arch/parisc/kernel/unaligned.c
>> index c520e551a165..622c7b549fb8 100644
>> --- a/arch/parisc/kernel/unaligned.c
>> +++ b/arch/parisc/kernel/unaligned.c
>> @@ -169,7 +169,8 @@ static int emulate_ldw(struct pt_regs *regs, int toreg, int flop)
>>   static int emulate_ldd(struct pt_regs *regs, int toreg, int flop)
>>   {
>>       unsigned long saddr = regs->ior;
>> -    __u64 val = 0;
>> +    unsigned long shift;
>> +    __u64 val = 0, temp1;
> 
> temp1 is ok to be "long".
> 
>>       ASM_EXCEPTIONTABLE_VAR(ret);
>>
>>       DPRINTF("load " RFMT ":" RFMT " to r%d for 8 bytes\n",
>> @@ -180,25 +181,22 @@ static int emulate_ldd(struct pt_regs *regs, int toreg, int flop)
>>
>>   #ifdef CONFIG_64BIT
>>       __asm__ __volatile__  (
>> -"    depd,z    %3,60,3,%%r19\n"        /* r19=(ofs&7)*8 */
>> -"    mtsp    %4, %%sr1\n"
>> -"    depd    %%r0,63,3,%3\n"
>> -"1:    ldd    0(%%sr1,%3),%0\n"
>> -"2:    ldd    8(%%sr1,%3),%%r20\n"
>> -"    subi    64,%%r19,%%r19\n"
>> -"    mtsar    %%r19\n"
>> -"    shrpd    %0,%%r20,%%sar,%0\n"
>> +"    depd,z    %4,60,3,%2\n"        /* shift=(ofs&7)*8 */
>> +"    mtsp    %5, %%sr1\n"
>> +"    depd    %%r0,63,3,%4\n"
>> +"1:    ldd    0(%%sr1,%4),%0\n"
>> +"2:    ldd    8(%%sr1,%4),%3\n"
>> +"    subi    64,%2,%2\n"
>> +"    mtsar    %2\n"
>> +"    shrpd    %0,%3,%%sar,%0\n"
>>   "3:    \n"
>>       ASM_EXCEPTIONTABLE_ENTRY_EFAULT(1b, 3b, "%1")
>>       ASM_EXCEPTIONTABLE_ENTRY_EFAULT(2b, 3b, "%1")
>> -    : "=r" (val), "+r" (ret)
>> -    : "0" (val), "r" (saddr), "r" (regs->isr)
>> -    : "r19", "r20" );
>> +    : "+r" (val), "+r" (ret), "=&r" (shift), "=&r" (temp1)
>> +    : "r" (saddr), "r" (regs->isr) );
> 
> addr is actually being modified.
> That's why I moved it into the output registers and
> shuffled shift and temp1 one backwards, so that the registers
> are now in the same ordering as on the 32-bit path.
> 
> I've pushed the modified patch here:
> https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?h=for-next&id=a6ea53ce77e9dd6e388d673bdd4d80741f97b914
> 
> Please double-check!
> 
Confirmed working.

Thanks,
Guenter

> Thanks!
> Helge
> 
> 
>>   #else
>> -    {
>> -    unsigned long shift, temp1;
>>       __asm__ __volatile__  (
>> -"    zdep    %2,29,2,%3\n"        /* r19=(ofs&3)*8 */
>> +"    zdep    %2,29,2,%3\n"        /* shift=(ofs&3)*8 */
>>   "    mtsp    %5, %%sr1\n"
>>   "    dep    %%r0,31,2,%2\n"
>>   "1:    ldw    0(%%sr1,%2),%0\n"
>> @@ -214,7 +212,6 @@ static int emulate_ldd(struct pt_regs *regs, int toreg, int flop)
>>       ASM_EXCEPTIONTABLE_ENTRY_EFAULT(3b, 4b, "%1")
>>       : "+r" (val), "+r" (ret), "+r" (saddr), "=&r" (shift), "=&r" (temp1)
>>       : "r" (regs->isr) );
>> -    }
>>   #endif
>>
>>       DPRINTF("val = 0x%llx\n", val);
> 


