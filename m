Return-Path: <linux-kernel+bounces-16885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4FC824562
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F013B21BD9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CB0249F8;
	Thu,  4 Jan 2024 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="W+zTMMgq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC50249E7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7ba9f1cfe94so43936839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 07:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704383449; x=1704988249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KmpM6mBQQhHv/gSZR2zG7ER6CNMKk8ullD4Z85B1/5k=;
        b=W+zTMMgqAA8fj3eqHcMB/tTfn7ws7Wn+JQLoCYmDmAvjS15nnYnPp7g+bbHQ/rX6in
         ChobwW1kbZoYs3nWCdF1AWXPGHGdCObFIPzhsEXSIQYQRbopDNrYGWAdxN3o93lzT3D4
         n5+UvCX21GmyIJ89ezrqec08pEaL94rLRL4XEVCASAwVXKAihVnVFZ1s92otruFi6i4d
         S9MkRDyJybpuWBzHVi6S7xbv5VZzrslx0Z646aDPVzA4AsV6xq8LRzTHITm6b4kykxgt
         NxEAlkV/siv5kPOSOSSDvKhVL3jlJi+TVmyFyUSjwFpK82C0vgB3pVyr1Kge4+b34mbZ
         tjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704383449; x=1704988249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmpM6mBQQhHv/gSZR2zG7ER6CNMKk8ullD4Z85B1/5k=;
        b=LMSlQQ2pij6yLYIMspgtq3WlpsuDxuIMXGbIaZ8A++AWhDGdo68JPtT0CBORRSjosj
         CJA1zSUC4wxgY5U/7711qQeGcWgA8GA7rh8mQU2zbgqJdbWbbJ6kH+xdlnljF1pHjjbR
         aFPptrxRH83unZDQZXBf+f6rsMWONiZQUGJd2N5yb2GwBOWr3WU5pUw0hQmkfrhv3SXk
         21qJY02swPCc2lb/Hg3n8foc1TZeM6CU8vAhXUs7vkex/ZT+4geT5N2ECE1A43S0hLCp
         GYwHFoESVDkpdKm4l9ilJ5ThWBc7Nlc1Pg7LxI4059GPauGSk6RUQ5qXc+O5axj/PoT1
         PKIg==
X-Gm-Message-State: AOJu0YyrqLBD/VTsLKha1i/ZiRkp6eeRPn8rJWZcOQPTuRSFenwFtH6P
	gUL368lNMLOdjsrbLToAJr7rxrFBobCDUg==
X-Google-Smtp-Source: AGHT+IGblrtLVD/taGoGDW+hOtY7FGSidp60/B4QZjgm2pnNBR6S054TRz0oEA5w0xMcz2qB5XLKCQ==
X-Received: by 2002:a05:6e02:1aa5:b0:35f:a27c:e76a with SMTP id l5-20020a056e021aa500b0035fa27ce76amr474841ilv.9.1704383448854;
        Thu, 04 Jan 2024 07:50:48 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:b86c:e734:b34:45c6? ([2605:a601:adae:4500:b86c:e734:b34:45c6])
        by smtp.gmail.com with ESMTPSA id ep24-20020a0566384e1800b0046696ea033dsm7981361jab.146.2024.01.04.07.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 07:50:48 -0800 (PST)
Message-ID: <e0ceb2e3-ae27-47aa-94de-f0d0060b2a77@sifive.com>
Date: Thu, 4 Jan 2024 09:50:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/12] riscv: mm: Always use an ASID to flush mm
 contexts
Content-Language: en-US
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20240102220134.3229156-1-samuel.holland@sifive.com>
 <20240102220134.3229156-13-samuel.holland@sifive.com>
 <ZZV3AAY3WIAq+sl9@xhacker>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <ZZV3AAY3WIAq+sl9@xhacker>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-01-03 9:02 AM, Jisheng Zhang wrote:
> On Tue, Jan 02, 2024 at 02:00:49PM -0800, Samuel Holland wrote:
>> Even if multiple ASIDs are not supported, using the single-ASID variant
>> of the sfence.vma instruction preserves TLB entries for global (kernel)
>> pages. So it is always more efficient to use the single-ASID code path.
>>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>> Changes in v4:
>>  - There is now only one copy of __flush_tlb_range()
>>
>> Changes in v2:
>>  - Update both copies of __flush_tlb_range()
>>
>>  arch/riscv/include/asm/mmu_context.h | 2 --
>>  arch/riscv/mm/context.c              | 3 +--
>>  arch/riscv/mm/tlbflush.c             | 3 +--
>>  3 files changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
>> index 7030837adc1a..b0659413a080 100644
>> --- a/arch/riscv/include/asm/mmu_context.h
>> +++ b/arch/riscv/include/asm/mmu_context.h
>> @@ -33,8 +33,6 @@ static inline int init_new_context(struct task_struct *tsk,
>>  	return 0;
>>  }
>>  
>> -DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
>> -
>>  #include <asm-generic/mmu_context.h>
>>  
>>  #endif /* _ASM_RISCV_MMU_CONTEXT_H */
>> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
>> index 3ca9b653df7d..20057085ab8a 100644
>> --- a/arch/riscv/mm/context.c
>> +++ b/arch/riscv/mm/context.c
>> @@ -18,8 +18,7 @@
>>  
>>  #ifdef CONFIG_MMU
>>  
>> -DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
>> -
>> +static DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
> 
> One of my optimization "riscv: tlb: avoid tlb flushing if fullmm == 1"
> will make use of use_asid_allocator, so could we remove this modification?

Yes, I can leave the global declaration alone for now.

>>  static unsigned long num_asids;
>>  
>>  static atomic_long_t current_version;
>> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
>> index 5ec621545c69..39d80f56d292 100644
>> --- a/arch/riscv/mm/tlbflush.c
>> +++ b/arch/riscv/mm/tlbflush.c
>> @@ -84,8 +84,7 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
>>  		if (cpumask_empty(cmask))
>>  			return;
>>  
>> -		if (static_branch_unlikely(&use_asid_allocator))
>> -			asid = cntx2asid(atomic_long_read(&mm->context.id));
>> +		asid = cntx2asid(atomic_long_read(&mm->context.id));
>>  	} else {
>>  		cmask = cpu_online_mask;
>>  	}
>> -- 
>> 2.42.0
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv


