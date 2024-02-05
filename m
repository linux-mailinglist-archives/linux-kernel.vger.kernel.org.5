Return-Path: <linux-kernel+bounces-53156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1655C84A16B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F111C22278
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC11345953;
	Mon,  5 Feb 2024 17:53:43 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02FD45942;
	Mon,  5 Feb 2024 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155623; cv=none; b=ICPin+HrbkDTpPwSE86clLtWl+Dnch7ZDd0X3ZwXlxLRtWw1F6p1hU0CT/mvCcDdnX5b+ru4GmEd72mkAQui3N1e7TG5Rt14z9a3fH1t5dN1Le386Ye8AkpbldE0gnjR7CUSM99ixz5g4w84KarsxWXs51bywVEmG6YtMtIY/Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155623; c=relaxed/simple;
	bh=4EirGIPqrbp+q4TnaDXx6ywFBbJZx5YKMeXIK9fxia0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7JEXW73mna5Ot9E9XaI/jPJBUoNSpAh+iobbRI0JjSftKEacPodm6WZTqkr+Zs/kLpqHr9uVrOZS+fMkdO+7f/Eewl2w8OpIj/C1r8kkd5kC313B1zEVRodk2TtJnUZwfpTpgGBzkVjtrQLMtIZH6aCYvmz/Sd0WfJHaxob8sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rX39o-0005nx-UH; Mon, 05 Feb 2024 18:53:25 +0100
Message-ID: <dc9f8eab-ec5c-46f1-a168-c510650d1cac@leemhuis.info>
Date: Mon, 5 Feb 2024 18:53:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: huge_memory: don't force huge page alignment on 32
 bit
Content-Language: en-US, de-DE
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, surenb@google.com, riel@surriel.com,
 willy@infradead.org, cl@linux.com, akpm@linux-foundation.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 yang@os.amperecomputing.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
 Yang Shi <shy828301@gmail.com>
References: <20240118133504.2910955-1-shy828301@gmail.com>
 <ad920491-9d73-4512-8996-badace520699@leemhuis.info>
 <CAHbLzkp7s1CcSE0rc-CpfcCrNtMdepAA5-K+0P4wz11x4SK6=g@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAHbLzkp7s1CcSE0rc-CpfcCrNtMdepAA5-K+0P4wz11x4SK6=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707155619;7d2e2678;
X-HE-SMSGID: 1rX39o-0005nx-UH

[adding the stable team]

On 05.02.24 18:07, Yang Shi wrote:
> On Sat, Feb 3, 2024 at 1:24 AM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>> On 18.01.24 14:35, Yang Shi wrote:
>>>
>>> The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
>>> boundaries") caused two issues [1] [2] reported on 32 bit system or compat
>>> userspace.
>>>
>>> It doesn't make too much sense to force huge page alignment on 32 bit
>>> system due to the constrained virtual address space.
>>>
>>> [1] https://lore.kernel.org/linux-mm/CAHbLzkqa1SCBA10yjWTtA2mKCsoK5+M1BthSDL8ROvUq2XxZMw@mail.gmail.com/T/#mf211643a0427f8d6495b5b53f8132f453d60ab95
>>> [2] https://lore.kernel.org/linux-mm/CAHbLzkqa1SCBA10yjWTtA2mKCsoK5+M1BthSDL8ROvUq2XxZMw@mail.gmail.com/T/#me93dff2ccbd9902c3e395e1c022fb454e48ecb1d
>>
>> [FWIW, this is now 4ef9ad19e17676 ("mm: huge_memory: don't force huge
>> page alignment on 32 bit") in mainline]
>>
>> Quick question: it it okay to ask Greg to pick this up for linux-6.7.y
>> series?
> 
> Yes, definitely. Thanks for following up.

In that case: Greg, could you please consider picking up 4ef9ad19e17676
("mm: huge_memory: don't force huge page alignment on 32 bit") for the
next linux-6.7 rc round? tia!

Ohh, and btw: you might also want to pick up c4608d1bf7c653 ("mm: mmap:
map MAP_STACK to VM_NOHUGEPAGE") if you haven't already done so: its
stable tag contains a typo, hence I guess your scripts might have missed
it (I only noticed that by chance).

Ciao, Thorsten

>> I'm wondering because Jiri's report ([1] in above quote) sounded like
>> this is something that will affect and annoy quite a few people with the
>> linux-6.7.y.
>>
>> Ciao, Thorsten
>>
>>> Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP boundaries")
>>> Reported-by: Jiri Slaby <jirislaby@kernel.org>
>>> Reported-by: Suren Baghdasaryan <surenb@google.com>
>>> Tested-by: Jiri Slaby <jirislaby@kernel.org>
>>> Tested-by: Suren Baghdasaryan <surenb@google.com>
>>> Cc: Rik van Riel <riel@surriel.com>
>>> Cc: Matthew Wilcox <willy@infradead.org>
>>> Cc: Christopher Lameter <cl@linux.com>
>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>> ---
>>>  mm/huge_memory.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 94ef5c02b459..e9fbaccbe0c0 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -37,6 +37,7 @@
>>>  #include <linux/page_owner.h>
>>>  #include <linux/sched/sysctl.h>
>>>  #include <linux/memory-tiers.h>
>>> +#include <linux/compat.h>
>>>
>>>  #include <asm/tlb.h>
>>>  #include <asm/pgalloc.h>
>>> @@ -811,6 +812,14 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
>>>       loff_t off_align = round_up(off, size);
>>>       unsigned long len_pad, ret;
>>>
>>> +     /*
>>> +      * It doesn't make too much sense to froce huge page alignment on
>>> +      * 32 bit system or compat userspace due to the contrained virtual
>>> +      * address space and address entropy.
>>> +      */
>>> +     if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
>>> +             return 0;
>>> +
>>>       if (off_end <= off_align || (off_end - off_align) < size)
>>>               return 0;
>>>
> 
> 

