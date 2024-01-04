Return-Path: <linux-kernel+bounces-16883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C451824559
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B8A2864AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39465249FE;
	Thu,  4 Jan 2024 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HTDRe7lm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0919E24217
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7b7fdde8b26so24888239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 07:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704383358; x=1704988158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7TIDLSdpMStFIDjtZ3v/tdAZRRwjQGD+NRWYb5ITqWs=;
        b=HTDRe7lm2WqfBap/sJTGQv3MDFuyGuTHB2mwsFGbSG7+Y0+Y67/CVJ333bh+sgJnRa
         /XM+dvmD0e6cs5UCfuD5mH1s+fGAgTZMw7U6pvnEMCG0bdMsKR1vMbedddeonH8ZBZLz
         v890DERnoml2GjvvjmHpacYOPvxmpMlePU9OvOqD9YhNGTXdUbTLHtkJbSju6tRrC/UR
         QU3TyY97E7OpYBQnKfStVHQROC2CCa79WXwpySuUZKVQLkFn+RKrBDsOly85xn0Copb0
         tbXGy6pApGbAckcmJik0qJr8oXkekCKNjYDmSh7jq9he51tRIrG61pOfgUXQt3TLKbpR
         1W9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704383358; x=1704988158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7TIDLSdpMStFIDjtZ3v/tdAZRRwjQGD+NRWYb5ITqWs=;
        b=U9SprjDT6I0vgKvCt4+edPTy6G+aUJXdYqQx44XBZO0KfkB6gUsP9tuSBMxYeiCMOj
         eY4tOhWI9gcCi5sV3aPvK3e4H3fWe5U3Qb72hIOGTCVHqujbp+TmWLiIauGk4P0qvU85
         pqSxQ8CoPNDwgaOBKcwSddHHdh3l9WUktZDqtT0Ax+8Oz09/DrmyD+YQwHLw6280qg8W
         FXWXZhbo+QiodwjZMZz+2GFdyAszB5uzC/82jEfkbESMalL2JR3kEFKC5vKH8aqDfG/p
         5b6UQZaJrPxv1VYAFPmFKLh2OKCwihLgSa8QQqkadgdJSIFF/VDO5Fb4OhsD/q3OwYs+
         oLug==
X-Gm-Message-State: AOJu0Yx7NbSSa2TTZQmxAxQKQEbfB2ECw1RKD2VwLb1cS5Ntsp3vZqBV
	Ue+6hutkd4XNMxlYdBklRjLQqhhQ+kLW3RiixA57HiyKb1w=
X-Google-Smtp-Source: AGHT+IGl23oaNLXkpTgQvFzjqjcPmDls8qUwG0Ek6OVfKuEbJznQZTa3hgKoIBfrgeoXH1vqf0zj0A==
X-Received: by 2002:a6b:e915:0:b0:7ba:85e4:f8de with SMTP id u21-20020a6be915000000b007ba85e4f8demr732625iof.42.1704383358130;
        Thu, 04 Jan 2024 07:49:18 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:b86c:e734:b34:45c6? ([2605:a601:adae:4500:b86c:e734:b34:45c6])
        by smtp.gmail.com with ESMTPSA id ep24-20020a0566384e1800b0046696ea033dsm7981361jab.146.2024.01.04.07.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 07:49:17 -0800 (PST)
Message-ID: <8341e264-53be-4821-ad9a-145e154aeec3@sifive.com>
Date: Thu, 4 Jan 2024 09:49:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/12] riscv: mm: Make asid_bits a local variable
Content-Language: en-US
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20240102220134.3229156-1-samuel.holland@sifive.com>
 <20240102220134.3229156-11-samuel.holland@sifive.com>
 <ZZV2hKLKtqjhEdvY@xhacker>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <ZZV2hKLKtqjhEdvY@xhacker>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-01-03 9:00 AM, Jisheng Zhang wrote:
> On Tue, Jan 02, 2024 at 02:00:47PM -0800, Samuel Holland wrote:
>> This variable is only used inside asids_init().
> 
> This is due to patch9, so can be folded into patch9.

I'm not sure what you mean here. Patch 9 does not touch any references to the
asid_bits variable, though it does touch adjacent lines.

>>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>> (no changes since v1)
>>
>>  arch/riscv/mm/context.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
>> index b5170ac1b742..43a8bc2d5af4 100644
>> --- a/arch/riscv/mm/context.c
>> +++ b/arch/riscv/mm/context.c
>> @@ -20,7 +20,6 @@
>>  
>>  DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
>>  
>> -static unsigned long asid_bits;
>>  static unsigned long num_asids;
>>  
>>  static atomic_long_t current_version;
>> @@ -226,7 +225,7 @@ static inline void set_mm(struct mm_struct *prev,
>>  
>>  static int __init asids_init(void)
>>  {
>> -	unsigned long old;
>> +	unsigned long asid_bits, old;
>>  
>>  	/* Figure-out number of ASID bits in HW */
>>  	old = csr_read(CSR_SATP);
>> -- 
>> 2.42.0
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv


