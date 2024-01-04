Return-Path: <linux-kernel+bounces-16871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73995824535
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE112823FF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180A224A00;
	Thu,  4 Jan 2024 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XfE5/+0v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C911224A0F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bbf9437280so18048039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 07:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704382970; x=1704987770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bCy1i3Gb1NX5g0K1r9bUje/jgcenFppGeFwkwujTXi4=;
        b=XfE5/+0vw6sGQBnBy5aDx2DtQmqWISCuWeJtqzImdLvQL8iLTY0NOoJLrMZIczPiio
         N5RqWSzDnpV5TNvyTY6EZWNzv7C0+lqm4bgGEbUnEU+F1GswtVKVtJnkne6i7WpSCgkm
         53N9FL+ks0R9xVz0/u9QdXdcirLRYVzpHDPW3taC09SZI/rQSoQqIVlyw1SRm03l+EFY
         KnXC3io3s13k/5czmxACY1wbs9/Xs18kM2AwjRsswcdFDivpmioXCw/2JAgK165D9RKu
         FiASo77Xh2dWzpjOxtomzeWnIRbgj1e4jFgCHbowsOUV40hNEsVpcIZxo4lKDVHV74yA
         Dq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704382970; x=1704987770;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCy1i3Gb1NX5g0K1r9bUje/jgcenFppGeFwkwujTXi4=;
        b=jvS64PcIEtOj1COnMv/qGNjJ9C4IIuy5RGaKHiBArueOBcM4wnxnjKXRVebhLQULv3
         qxp8U5TWMtff2+TvfJ48YXggDkffd+DlxjJXi5PkTCKbdSuI5k7kgg65T7baRrKUF2sx
         gt+B46OpVuZ+GT76Yo0UCsXywpGbnTEKftFPoOVYXPL9hADTB8lkDnZE+oF2qJhh3zmv
         CYBiWJ6iIHBYFi/KWQKz/1oEzyofqY4fvZ8wNY4qrEgc6eop0Z4To2iQBAfUqoZsiCuJ
         bJ6Fl5oKyh9bJNAybXfmudanY46DtAkj6DsR+6S7GPHBL/ENNja4ZOk0xoqhHzbpYNMX
         /Urg==
X-Gm-Message-State: AOJu0YxMp7Zb0fbQK4mFU9hbAjjEktzmm4dubi9G4XQxY8ktrtDcCMfx
	wJu8QlPPgDTg9+GTGHJ/7dLixkLcK4hA1AGKVXNDPp4qMVk=
X-Google-Smtp-Source: AGHT+IGZEWXPVw7OSf05ViMeKZMnGrSiJ/PnLgklrDrsnQyuI8SeiKthsoOlG9HJPrpd9bUMwN9Ncw==
X-Received: by 2002:a05:6602:218f:b0:79f:a25b:51c with SMTP id b15-20020a056602218f00b0079fa25b051cmr795113iob.11.1704382969798;
        Thu, 04 Jan 2024 07:42:49 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:b86c:e734:b34:45c6? ([2605:a601:adae:4500:b86c:e734:b34:45c6])
        by smtp.gmail.com with ESMTPSA id n7-20020a05663831c700b0046ceccc798asm7764042jav.6.2024.01.04.07.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 07:42:49 -0800 (PST)
Message-ID: <057f7d38-08b7-4693-907c-b2efa6a75a22@sifive.com>
Date: Thu, 4 Jan 2024 09:42:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/12] riscv: mm: Introduce cntx2asid/cntx2version
 helper macros
Content-Language: en-US
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240102220134.3229156-1-samuel.holland@sifive.com>
 <20240102220134.3229156-9-samuel.holland@sifive.com>
 <CAHVXubhKrC_7DEBXR_wCP9g7-KfWg9nuyim7+X1Ja2gh8s9+HA@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CAHVXubhKrC_7DEBXR_wCP9g7-KfWg9nuyim7+X1Ja2gh8s9+HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alex,

On 2024-01-04 6:39 AM, Alexandre Ghiti wrote:
> On Tue, Jan 2, 2024 at 11:01 PM Samuel Holland
> <samuel.holland@sifive.com> wrote:
>>
>> When using the ASID allocator, the MM context ID contains two values:
>> the ASID in the lower bits, and the allocator version number in the
>> remaining bits. Use macros to make this separation more obvious.
>>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>> (no changes since v1)
>>
>>  arch/riscv/include/asm/mmu.h |  3 +++
>>  arch/riscv/mm/context.c      | 12 ++++++------
>>  arch/riscv/mm/tlbflush.c     |  2 +-
>>  3 files changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
>> index 355504b37f8e..a550fbf770be 100644
>> --- a/arch/riscv/include/asm/mmu.h
>> +++ b/arch/riscv/include/asm/mmu.h
>> @@ -26,6 +26,9 @@ typedef struct {
>>  #endif
>>  } mm_context_t;
>>
>> +#define cntx2asid(cntx)                ((cntx) & asid_mask)
>> +#define cntx2version(cntx)     ((cntx) & ~asid_mask)
> 
> Not a big fan of the naming, I would have something like
> get_asid_from_context() and get_version_from_context() or something
> like that, but up to you of course.

Thanks for the review. I'm not really a fan of it either, but I tried to match
precedent from other architectures. These loosely follow the naming of
ctxid2asid() from arm64 and idx2asid() from csky. arm uses ASID().

Regards,
Samuel

>> +
>>  void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa,
>>                                phys_addr_t sz, pgprot_t prot);
>>  #endif /* __ASSEMBLY__ */
>> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
>> index 217fd4de6134..43d005f63253 100644
>> --- a/arch/riscv/mm/context.c
>> +++ b/arch/riscv/mm/context.c
>> @@ -81,7 +81,7 @@ static void __flush_context(void)
>>                 if (cntx == 0)
>>                         cntx = per_cpu(reserved_context, i);
>>
>> -               __set_bit(cntx & asid_mask, context_asid_map);
>> +               __set_bit(cntx2asid(cntx), context_asid_map);
>>                 per_cpu(reserved_context, i) = cntx;
>>         }
>>
>> @@ -102,7 +102,7 @@ static unsigned long __new_context(struct mm_struct *mm)
>>         lockdep_assert_held(&context_lock);
>>
>>         if (cntx != 0) {
>> -               unsigned long newcntx = ver | (cntx & asid_mask);
>> +               unsigned long newcntx = ver | cntx2asid(cntx);
>>
>>                 /*
>>                  * If our current CONTEXT was active during a rollover, we
>> @@ -115,7 +115,7 @@ static unsigned long __new_context(struct mm_struct *mm)
>>                  * We had a valid CONTEXT in a previous life, so try to
>>                  * re-use it if possible.
>>                  */
>> -               if (!__test_and_set_bit(cntx & asid_mask, context_asid_map))
>> +               if (!__test_and_set_bit(cntx2asid(cntx), context_asid_map))
>>                         return newcntx;
>>         }
>>
>> @@ -168,7 +168,7 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
>>          */
>>         old_active_cntx = atomic_long_read(&per_cpu(active_context, cpu));
>>         if (old_active_cntx &&
>> -           ((cntx & ~asid_mask) == atomic_long_read(&current_version)) &&
>> +           (cntx2version(cntx) == atomic_long_read(&current_version)) &&
>>             atomic_long_cmpxchg_relaxed(&per_cpu(active_context, cpu),
>>                                         old_active_cntx, cntx))
>>                 goto switch_mm_fast;
>> @@ -177,7 +177,7 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
>>
>>         /* Check that our ASID belongs to the current_version. */
>>         cntx = atomic_long_read(&mm->context.id);
>> -       if ((cntx & ~asid_mask) != atomic_long_read(&current_version)) {
>> +       if (cntx2version(cntx) != atomic_long_read(&current_version)) {
>>                 cntx = __new_context(mm);
>>                 atomic_long_set(&mm->context.id, cntx);
>>         }
>> @@ -191,7 +191,7 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
>>
>>  switch_mm_fast:
>>         csr_write(CSR_SATP, virt_to_pfn(mm->pgd) |
>> -                 ((cntx & asid_mask) << SATP_ASID_SHIFT) |
>> +                 (cntx2asid(cntx) << SATP_ASID_SHIFT) |
>>                   satp_mode);
>>
>>         if (need_flush_tlb)
>> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
>> index 76b24d4ed4ab..5ec621545c69 100644
>> --- a/arch/riscv/mm/tlbflush.c
>> +++ b/arch/riscv/mm/tlbflush.c
>> @@ -85,7 +85,7 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
>>                         return;
>>
>>                 if (static_branch_unlikely(&use_asid_allocator))
>> -                       asid = atomic_long_read(&mm->context.id) & asid_mask;
>> +                       asid = cntx2asid(atomic_long_read(&mm->context.id));
>>         } else {
>>                 cmask = cpu_online_mask;
>>         }
>> --
>> 2.42.0
>>
> 
> You can add:
> 
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> Thanks,
> 
> Alex


