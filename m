Return-Path: <linux-kernel+bounces-134583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C7989B33B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32BC21C219BC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847703B799;
	Sun,  7 Apr 2024 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDqovKhZ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32787208B4
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712509929; cv=none; b=cdc/pg4EIkdtfv+h6RPg0lvG512nWMLeb6US8dt6zGI4p5xN+EtmCNWhfPANxG7gH1eZDke2Km3Fe+w7EZtZwQ1bzJPJTd/c+NpDTfTwgC8N2RVdC0lzHKS7xs5tN+Inj9qzJxc1mpHXP3+6CV6ANdT7zVF5/a0Mkxs+MgA1DHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712509929; c=relaxed/simple;
	bh=B3y8mZ+vq9/ue0AgaJBCC43ZM6QQg/dP8O79dopuaqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alUaL2Rvt4sxV4nTap6VaVpgNZhzAOKerWdNdt9c38AP155XPQz25cta5o+xd4C6SJfmmMeWokgVfC85+7KnpTvCQ/g5ptKnQy13wXE1R6M3WIxYv67o0ilYmlucyTMm7LIpvYN0Soet6nKaZy0J0CctGXNiygdzX73dnacZNII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDqovKhZ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-516ef30b16eso744261e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 10:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712509926; x=1713114726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qCUriK+M0jiIXILb+tuB1UUD9u2BDme31WEMqfwtns=;
        b=lDqovKhZ3exZZY2BfUqx5GbmyWRDmAm/HboowBYx2f1bW2OIKjf1Qrzepqy8duJu6V
         5pSOkypp6A+HeO3w0PNOcGTT/sL/YzU+wydGiGNMcp5H+tFTqpU2qcy7CjFkbMHmTxGN
         ii3XTPmISTBpR+SjzM+B3SG77QBH5hGWen6EEorGl7NFXwESGSH6hD2NcCGl6jo/2OnT
         P0ADpCYOk5xm1+NwegQL+23H/epLSbMA6uyB9Nrt5upevT3PKpDso4L8DhqGUAiY2enA
         wBv/PIdsRXK+4ySOPAgxnx4TqEN/r8JcREyHz7kmSLDllO5VSJKDl7XgJjb/VDj/ae77
         181A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712509926; x=1713114726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qCUriK+M0jiIXILb+tuB1UUD9u2BDme31WEMqfwtns=;
        b=qWkhvUKK44d2wHJvEDFl0Jrb7Pi74nVoe0qCvlQvR1GKsRFKTFZ1z2+UQvBpk/pGtl
         7HVfkK+IFFORjCcj3h+r3OwGntCoXq7WOCe0SjMtXxXKUFss44YGCqIOLzSYm4DjSClj
         Ok8lrsZMb2DfhCcmM+lNbOrNhDQF5xx56iNow/mtJ6ikkLUKV7W5F/bq43jjxTv56ZIR
         9prxL0pR9GX9zVoaSIRQ7Ii6AgC5YRsTBaFfybHwCVzA8sqZjRqiUGwJikPDyBNx5eae
         ihxZbFQAOPMCn2+pZRtMyjOg8rUmgEru6eP1tY2SsahqHRIe29C0sY64smo+NnULW6YV
         gwDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVffwk1JZF2qhXl+3WFfACFPSVeE93HJTH4KT+kOqabifhMnz7NIFy7Vm5R9v1DYtKALFMe1ry7t07x9zMPJobS1ADhtvrhIYG4nSLE
X-Gm-Message-State: AOJu0YxNMaFwCQSDrmgK29HbnsdZgIMzdFR/FYidf2+KGNxHy1nSaqIs
	ySm+3Hynj41tAAOrq3dpUIah7DqDKKdFd6lIK1GJN87NC+FNzpri
X-Google-Smtp-Source: AGHT+IHtaIccuyFUdaKKa2Zpdn1UYBrvGIcS+CFd9LibEYo3spBXmcNmUNHFqmPVcKYM58FADUip+Q==
X-Received: by 2002:a05:6512:224d:b0:513:cf73:d8d2 with SMTP id i13-20020a056512224d00b00513cf73d8d2mr4282714lfu.54.1712509926074;
        Sun, 07 Apr 2024 10:12:06 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1202:2659:d6e4:5d55:b864? (soda.int.kasm.eu. [2001:678:a5c:1202:2659:d6e4:5d55:b864])
        by smtp.gmail.com with ESMTPSA id x24-20020ac24898000000b00515c1b1fb85sm870313lfc.233.2024.04.07.10.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 10:12:05 -0700 (PDT)
Message-ID: <55c71868-e2ae-4095-a5ca-5cdb195d508b@gmail.com>
Date: Sun, 7 Apr 2024 19:12:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memprofiling: explicitly include irqflags.h in
 alloc_tag.h
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: akpm@linux-foundation.org, surenb@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240407133252.173636-1-klarasmodin@gmail.com>
 <w2leytfo6pdsslutpp6p3ziq2fxdu7azammphh24cp6bka2xta@ijosdg33pozv>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <w2leytfo6pdsslutpp6p3ziq2fxdu7azammphh24cp6bka2xta@ijosdg33pozv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024-04-07 19:01, Kent Overstreet wrote:
> On Sun, Apr 07, 2024 at 03:32:52PM +0200, Klara Modin wrote:
>> linux/alloc_tag.h uses the macro this_cpu_inc which eventually expands to:
>>
>>   #define this_cpu_generic_to_op(pcp, val, op)				\
>>   do {									\
>>   	unsigned long __flags;						\
>>   	raw_local_irq_save(__flags);					\
>>   	raw_cpu_generic_to_op(pcp, val, op);				\
>>   	raw_local_irq_restore(__flags);					\
>>   } while (0)
>>
>> The macros raw_local_irq_save and raw_local_irq_restore are defined in
>> linux/irqflags.h which is not included implicitly on all configs.
>> Therefore, include it explicitly.
>>
>> Fixes: ac906a377c67 ("lib: add allocation tagging support for memory allocation profiling")
>> Link: https://lore.kernel.org/lkml/6b8149f3-80e6-413c-abcb-1925ecda9d8c@gmail.com/
>> Signed-off-by: Klara Modin <klarasmodin@gmail.com>
>> ---
>>   include/linux/alloc_tag.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
>> index e867461585ff..afc9e259a2d3 100644
>> --- a/include/linux/alloc_tag.h
>> +++ b/include/linux/alloc_tag.h
>> @@ -12,6 +12,7 @@
>>   #include <asm/percpu.h>
>>   #include <linux/cpumask.h>
>>   #include <linux/static_key.h>
>> +#include <linux/irqflags.h>
> 
> Actually, shouldn't this end up in a percpu header? Or was there a
> problem with that?

If I understand it correctly, linux/alloc_tag.h does not include 
linux/percpu.h (which has that include) to avoid a circular dependency 
as linux/percpu.h includes linux/alloc_tag.h. It instead includes 
arch-specific asm/percpu.h, and as a consequence it doesn't always get 
linux/irqflags.h.

It's also entirely possible that I've mixed something up, I really don't 
have much experience developing for the kernel.

