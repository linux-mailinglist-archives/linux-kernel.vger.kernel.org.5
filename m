Return-Path: <linux-kernel+bounces-29751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CC58312F2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C61E1F22FBA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223359474;
	Thu, 18 Jan 2024 07:05:02 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C16A9444
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705561501; cv=none; b=dJ1jtNCWnao6W4/Qa19ySo9ZDtzkC+u+pKxrb1GnN7Yw/oqvkwPVrLpSFhcYkY23sqavjRdBdONNmU2XuCfmw9/jhd3JEnyY5ly0r0COejstQh7lC6rmCnN7QLYnjEkadg8+2WphOY8cV8Nq9p6RbeVe3YAYILqdLhv40r9mebo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705561501; c=relaxed/simple;
	bh=v0d+o+oyU2L+qDUyAPW9p8OAzcs2j9iv1LOXtPMvlvU=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=f+0urOR4LjdBo4o6ca/YhZzG49UZIB6Jp2u3D12eU74zlL56v6IEEvck8scQHAF2QKDjtOvjSAM0gvVjeJUZKCnDEAiF9Qw+wg0QQdN7F3aTgfNKhjB1U3MaG+xyCTDJWoX/ZX+oLPlOwMGj7DcoMGTNpqkfXbhMFhX2blWcRoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso69936685e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 23:04:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705561498; x=1706166298;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5S4lXTmw9h953xURv594T5Yo3rY/dm6ydiBKsQ3CdKQ=;
        b=K3BfpAgSFK9/drbAQtqSHbQgnaas9std7bomLsspHP4EAXBMefbXe5z6GfftSd1Ld3
         e37K0kGBRsCRh114PQw0H+n+fl4YgWrJ6nRs+IV4o+ngldA1kDeFMr+8DMSEQCXtHNtM
         gZxelVT7OJSvv5c7mZaWQfbhXbw5ILmldS+b9fccaPMgvJf3Hb4zL93QgmNNhJti3tM+
         j/pskFy90M1K65gWGyqpDKnRb/liF0tLVywGpvejvB0wyvGw7pNcMTJ0gzA51fNeyTly
         jxeRUlnxW/UlmhwXVQ2n89Jrnf6aE0sEl0brkczAbHFxd9ihOR2fhHOqWrVIYzcwhTNn
         e6qA==
X-Gm-Message-State: AOJu0YzYARzyqCNsWf+s+2DJi+UKyGNGecWonlpRjY04USlkRczG75HU
	vBbuWC/zA3rRYv4QBRArjKOrlib/bm3AgIX43CBtUV7BWI7hlSd7
X-Google-Smtp-Source: AGHT+IGAFGpP7XF2uouD5Uj3NbTbrJ+u+1W7IY0t7vFat81rQSB9yz2I3sh9Epp7wUzlN925jm/jsQ==
X-Received: by 2002:a05:600c:4513:b0:40e:4119:cb4a with SMTP id t19-20020a05600c451300b0040e4119cb4amr236147wmo.15.1705561498062;
        Wed, 17 Jan 2024 23:04:58 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b0040c6d559490sm24785527wmq.3.2024.01.17.23.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 23:04:57 -0800 (PST)
Message-ID: <7103dfea-0db3-44b7-9b2e-e89d4edd19d7@kernel.org>
Date: Thu, 18 Jan 2024 08:04:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
Content-Language: en-US
To: Yang Shi <shy828301@gmail.com>
Cc: Rik van Riel <riel@surriel.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@fb.com,
 Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@linux.com>
References: <20220809142457.4751229f@imladris.surriel.com>
 <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
 <3193bf5b-4e22-412f-8c5b-68574942d9bc@kernel.org>
 <CAHbLzkoL6sCDciHqVMJga288853CHdOTa5thOPQ9SHKSqjGGPQ@mail.gmail.com>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <CAHbLzkoL6sCDciHqVMJga288853CHdOTa5thOPQ9SHKSqjGGPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18. 01. 24, 1:07, Yang Shi wrote:
>> This works around the problem, of course (but is a band-aid, not a fix):
>>
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -1829,7 +1829,7 @@ get_unmapped_area(struct file *file, unsigned long
>> addr, unsigned long len,
>>                    */
>>                   pgoff = 0;
>>                   get_area = shmem_get_unmapped_area;
>> -       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
>> +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>> !in_32bit_syscall()) {
>>                   /* Ensures that larger anonymous mappings are THP
>> aligned. */
>>                   get_area = thp_get_unmapped_area;
>>           }
>>
>>
>> thp_get_unmapped_area() does not take care of the legacy stuff...
> 
> Could you please help test the below patch? It is compiled, but I
> don't have 32 bit userspace or machine to test it.

Yeah, for x86_64, it's semantically the same as the above, so this works 
too:

Tested-by: Jiri Slaby <jirislaby@kernel.org>

> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -811,6 +811,9 @@ static unsigned long
> __thp_get_unmapped_area(struct file *filp,
>          loff_t off_align = round_up(off, size);
>          unsigned long len_pad, ret;
> 
> +       if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
> +               return 0;
> +
>          if (off_end <= off_align || (off_end - off_align) < size)
>                  return 0;

thanks,
-- 
js
suse labs


