Return-Path: <linux-kernel+bounces-16858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17527824504
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEBA1C221A6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1A52420B;
	Thu,  4 Jan 2024 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OU6qajmb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F3C241FD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7ba9f24acf8so26201739f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 07:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704382383; x=1704987183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w0Upt/iz7+ki/+WrJa4hJcNtIggoZOENcRuMxGOqm14=;
        b=OU6qajmb4r6oLDiNCOihPgV1vMwv5n3v07vWUtAL5W7ZMMtazqx8yrZiEjjxtE+Mhn
         UadGbiE/bw2JbvMIssRqh6x+NM/sbTbFKcbZ/JMLQRUwmr5t9HWSmf4eECDrVcVYz2SE
         hdV4tulmhIIBR53jbsZ4pji+oLqNqPIMj8niAed5D8qDnD9wfefEtKzniPftE8sjUVs/
         sXoIpy5XfdSFygMFWYcYbmgskEp2ZZGjo5Oq6tQzswMbwbJuRwGNYyF07+ehHDoSIk+u
         9ULNy6nZ8O9zNc5pGHPi8Jr4CZTMkLNZUhQwS3HT3MOebuUljyp8axEk6DAYZXiyb77M
         yKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704382383; x=1704987183;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w0Upt/iz7+ki/+WrJa4hJcNtIggoZOENcRuMxGOqm14=;
        b=nNEI3a8r5KPbiMJshyzV5bdy26q+xVYIvyT8BIAhvIdmsFldB+r8/NmudiT2L1H0dq
         YxidNU/edClqEtujgi0FpWqSV7dCgdPFCd0Cwc3HP9Eesb2yidi+gpxPGNaSoZ1MFEPs
         7eYRjNo+xlU5Z05aFprAIKA77AvEt1mwdnHQBVaZtxzpC+cTs4Z/i2qRbxDasYxz82kT
         TC8vQdV9P3LuXPmwW6hVRWu/OBcRagteA2gR8GB2vQCBzqs8mNxB1kEVoelW2/q2ff7q
         Agax66n1QlBQrf0tv/5oi2w1SK21qEIGy5qFlO7XpOJ44EYzRJDPeoXwFS1cyI4Ih8Uu
         XvbA==
X-Gm-Message-State: AOJu0Yw4RTed6c4y2ml0X/oIzpDhDyeCOz9p4Lp+VlTIQGc/oAo1DMW0
	dJk7y/IJQImWtStH6CLhLufN8mYXxrY3cdV4TpRW788zYCw=
X-Google-Smtp-Source: AGHT+IGThkPps3feUu8OFnstPk+YphTbwG+KpAF9RDM/pLmpSVUYeGNXZ7d/hFN+Slfqm2z3ucRA2Q==
X-Received: by 2002:a5e:de4a:0:b0:7bb:df9d:c29b with SMTP id e10-20020a5ede4a000000b007bbdf9dc29bmr794314ioq.43.1704382382773;
        Thu, 04 Jan 2024 07:33:02 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:b86c:e734:b34:45c6? ([2605:a601:adae:4500:b86c:e734:b34:45c6])
        by smtp.gmail.com with ESMTPSA id cv8-20020a056638498800b0046b4f448cc5sm7933260jab.91.2024.01.04.07.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 07:33:02 -0800 (PST)
Message-ID: <236f584e-76bf-4d98-8db4-562b627558bb@sifive.com>
Date: Thu, 4 Jan 2024 09:33:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/12] riscv: Only send remote fences when some other
 CPU is online
Content-Language: en-US
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240102220134.3229156-1-samuel.holland@sifive.com>
 <20240102220134.3229156-5-samuel.holland@sifive.com>
 <CAHVXubh+qnJCF1e6u8G0h+5fnfoGDHz0jjBr+KW11WZbKt3F9A@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CAHVXubh+qnJCF1e6u8G0h+5fnfoGDHz0jjBr+KW11WZbKt3F9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alex,

On 2024-01-04 6:33 AM, Alexandre Ghiti wrote:
> On Tue, Jan 2, 2024 at 11:01 PM Samuel Holland
> <samuel.holland@sifive.com> wrote:
>>
>> If no other CPU is online, a local cache or TLB flush is sufficient.
>> These checks can be constant-folded when SMP is disabled.
>>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>> Changes in v4:
>>  - New patch for v4
>>
>>  arch/riscv/mm/cacheflush.c | 4 +++-
>>  arch/riscv/mm/tlbflush.c   | 4 +++-
>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
>> index 47c485bc7df0..f7933ae88a55 100644
>> --- a/arch/riscv/mm/cacheflush.c
>> +++ b/arch/riscv/mm/cacheflush.c
>> @@ -21,7 +21,9 @@ void flush_icache_all(void)
>>  {
>>         local_flush_icache_all();
>>
>> -       if (riscv_use_sbi_for_rfence())
>> +       if (num_online_cpus() < 2)
>> +               return;
>> +       else if (riscv_use_sbi_for_rfence())
>>                 sbi_remote_fence_i(NULL);
>>         else
>>                 on_each_cpu(ipi_remote_fence_i, NULL, 1);
>> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
>> index 2f18fe6fc4f3..37b3c93e3c30 100644
>> --- a/arch/riscv/mm/tlbflush.c
>> +++ b/arch/riscv/mm/tlbflush.c
>> @@ -73,7 +73,9 @@ static void __ipi_flush_tlb_all(void *info)
>>
>>  void flush_tlb_all(void)
>>  {
>> -       if (riscv_use_sbi_for_rfence())
>> +       if (num_online_cpus() < 2)
>> +               local_flush_tlb_all();
>> +       else if (riscv_use_sbi_for_rfence())
>>                 sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, FLUSH_TLB_NO_ASID);
>>         else
>>                 on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
>> --
>> 2.42.0
>>
> 
> on_each_cpu() already deals correctly with a single online cpu, the
> only thing to optimize here is the SBI rfence. So I'd move this new
> test in sbi_remote_sfence_vma_asid() and sbi_remote_fence_i() to avoid
> the superfluous M-mode entry when only one cpu is online by checking
> the cpumask. And since sbi_remote_fence_i() is used in another

What specific cpumask check are you suggesting? In sbi_remote_sfence_vma_asid()
I don't think we can assume the local cpu is always included in the cpumask
(which we _can_ assume here), so it would need to construct/compare the whole
bitmap. That's much more expensive than the atomic load here.

> function (flush_icache_mm()), we could also take advantage of this
> optimization when only the local cpu must be flushed.

flush_icache_mm() already has a "local" variable which it uses to skip the call
to sbi_remote_fence_i(). Same with the broadcast check in __flush_tlb_range().
So no additional check is needed there. Those two functions, plus the two
changed in this patch, are the only call sites of the sbi_*() functions. I think
it makes more sense to optimize the four call sites than adding an additional
check in the sbi_*() functions.

Regards,
Samuel


