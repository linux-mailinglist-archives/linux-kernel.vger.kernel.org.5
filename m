Return-Path: <linux-kernel+bounces-39930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A372383D787
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B901F2CCC3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FF82136C;
	Fri, 26 Jan 2024 09:37:00 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392E410A0F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261820; cv=none; b=ECcYDVougReX2m6MmKNjhU7qeafw+y8ywGZWHJgnxnI8r/QTM0UyJH7aQ4KcudfQZ3Jk2LR3CjngVlTxkeL2YtcLdxTrngsc+NO9AxvQyeluYWncUWhcbEHDF4Ucdd+tHPRSl7LvJ+P+eyZAxlNKcDsKcjl8OBdVg0kPHyWzRFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261820; c=relaxed/simple;
	bh=fogrqpb4wPx3QsVi0ooKV6pF4KkSXiEsTUhE8ba15ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyGlZrrZtjI3vP1mSYXtlUg6iaMfjNg/rF76MU/MAk3OXk4Qo1usW4eMUoYSqBW213Rf8UsZx+/3DsEdHB9+o+fGPyyOZvejzo/Xb30hbUaR64shj8GwDShki9oG8CQYBh9FcaV21lwUl9DHDu4DG/AMPUsLau84tqOvDHYJfS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cf1b770833so6501561fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:36:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706261816; x=1706866616;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGLeS98hA2fBZzgTNbeCyAi11v+/7WOKbg0CpbQOuXc=;
        b=cX9LaqYS5mZUvLEW3nUfPnjRWvVu0SGPGtcYXAf0OivSplEDi3FQ791IeBUyfasY8c
         +ojpDhKxtsfjVIMrfIUjBklSpwudS/EwMIu6auTbh31VZFAWwUvAJPWwba+gerChYBt0
         2yIGB3pYRuiCqNaDratVBn46VaM0p1wj4Fd0+5fw5e4oIiigOWq0rmHuHw1v0YdZyDfR
         j/LCSKgNqH1NKdoOpc5PVr7y3CvnAzhMT1vRBbNAgetHtdR8vQzgGLTHc5bTFthsLjA1
         gXvSjgPYh61o3ZpPATVVC6y4q32C7OBETGwRrgm26GrBH7FyuLI8NJoMZLuIMNuwbMvf
         /tYg==
X-Gm-Message-State: AOJu0Yyg85QtOx79sO/9V07PwCFuFEU8vClnx0bILIsMQUT6k9Yp8C3o
	n+R/+/m3kALR1dh8eP57Biv+hoLWs51mIN1DldafED402IUeNWTk
X-Google-Smtp-Source: AGHT+IFeeZY5dYUyGRCCjaAx/k+3kGFWFkxW2HDq9HUe32iVA/kkbb4wjPwcGETQvCeY1HhWx471QQ==
X-Received: by 2002:a2e:a36b:0:b0:2cf:429f:7fbb with SMTP id i11-20020a2ea36b000000b002cf429f7fbbmr538120ljn.72.1706261815777;
        Fri, 26 Jan 2024 01:36:55 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id o23-20020aa7dd57000000b0055c8a30152bsm405245edw.83.2024.01.26.01.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 01:36:55 -0800 (PST)
Message-ID: <2afa54e6-90db-4ae0-a21c-78e5051aa83c@kernel.org>
Date: Fri, 26 Jan 2024 10:36:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: huge_memory: don't force huge page alignment on 32
 bit
Content-Language: en-US
To: akpm@linux-foundation.org
Cc: surenb@google.com, riel@surriel.com, willy@infradead.org, cl@linux.com,
 yang@os.amperecomputing.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, "Bernhard M. Wiedemann" <bwiedemann@suse.de>,
 Michal Hocko <mhocko@suse.com>, Yang Shi <shy828301@gmail.com>
References: <20240118133504.2910955-1-shy828301@gmail.com>
 <ZbIhoj2PzD5jIdSn@tiehlicka>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <ZbIhoj2PzD5jIdSn@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25. 01. 24, 9:53, Michal Hocko wrote:
> On Thu 18-01-24 05:35:04, Yang Shi wrote:
>> From: Yang Shi <yang@os.amperecomputing.com>
>>
>> The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
>> boundaries") caused two issues [1] [2] reported on 32 bit system or compat
>> userspace.
>>
>> It doesn't make too much sense to force huge page alignment on 32 bit
>> system due to the constrained virtual address space.
>>
>> [1] https://lore.kernel.org/linux-mm/CAHbLzkqa1SCBA10yjWTtA2mKCsoK5+M1BthSDL8ROvUq2XxZMw@mail.gmail.com/T/#mf211643a0427f8d6495b5b53f8132f453d60ab95
>> [2] https://lore.kernel.org/linux-mm/CAHbLzkqa1SCBA10yjWTtA2mKCsoK5+M1BthSDL8ROvUq2XxZMw@mail.gmail.com/T/#me93dff2ccbd9902c3e395e1c022fb454e48ecb1d
>>
>> Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP boundaries")
>> Reported-by: Jiri Slaby <jirislaby@kernel.org>
>> Reported-by: Suren Baghdasaryan <surenb@google.com>
>> Tested-by: Jiri Slaby <jirislaby@kernel.org>
>> Tested-by: Suren Baghdasaryan <surenb@google.com>
>> Cc: Rik van Riel <riel@surriel.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Christopher Lameter <cl@linux.com>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Thanks!
> 
>> ---
>>   mm/huge_memory.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 94ef5c02b459..e9fbaccbe0c0 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -37,6 +37,7 @@
>>   #include <linux/page_owner.h>
>>   #include <linux/sched/sysctl.h>
>>   #include <linux/memory-tiers.h>
>> +#include <linux/compat.h>
>>   
>>   #include <asm/tlb.h>
>>   #include <asm/pgalloc.h>
>> @@ -811,6 +812,14 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
>>   	loff_t off_align = round_up(off, size);
>>   	unsigned long len_pad, ret;
>>   
>> +	/*
>> +	 * It doesn't make too much sense to froce huge page alignment on
>> +	 * 32 bit system or compat userspace due to the contrained virtual
>> +	 * address space and address entropy.
>> +	 */

FWIW,
Bernhard noticed that "froce" and "contrained", could you fix that 
before applying the patch?

thanks,
-- 
js
suse labs


