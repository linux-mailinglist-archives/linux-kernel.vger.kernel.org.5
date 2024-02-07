Return-Path: <linux-kernel+bounces-56956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0FC84D1C2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18C6282C72
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD7D82D97;
	Wed,  7 Feb 2024 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nWXkN37R"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634A185C63
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331564; cv=none; b=kzTlkC+k0HWLqKnQ2GX4yz3Jq8NJ6/V08jbfyntZrJbjAH9cTuOFwnuuGteLIXaD49m4Z/DhnJgtH6gp4rWJJeOrs81Tp6/WyWkmGSJG1e0iSFAjwBgc5f0/yCAWhaUPdzM4KqATpqYEp0pXL84BE/nlpkRaUW6NfCn7LqLMXmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331564; c=relaxed/simple;
	bh=mlfUdvF3nuFmNk1lDQ0dgsIzWOBiMVa8ptQk84jgnhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NeeujbsdHjs9wHQpArlOjSpRSIgckIh5AeZSw+Mfcr1OELZGysaaHRtV9RH0hvkwQDcH4LkY/LHV5LSY45f9fhR/pf9ssygqFdnz6GaK+Z5+L92NTZniSlMCVNezwOirpRLGh2aTKx1GSrcNI3JdoG/YHqx4YP5wox/kKcDjf/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=nWXkN37R; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.187] ([71.202.196.111])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 417Iix0H2706018
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 7 Feb 2024 10:44:59 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 417Iix0H2706018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1707331500;
	bh=+euICXmQceRDTVsASTkgUeNDpBza5bVSfxOZzTFcd4I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nWXkN37RV9vpIGiituFfLtXtutGmqWdL84/jxvEpeis7Yc0WOHpY856xKPmi/Id9k
	 LVBSP05VRbGtIJJL9qJf+Ob8wkg1hGJbSxZNpbfYoaekLbkA4MWrBD9l28hSC7tyO4
	 re9oNgitRU0tzMDjMIRiLUoqE1OfBCiyMzKGyYwq66JDa0n+Ypam6kyW6vYGk32i19
	 lSGKDWGGkWsICil0WA6oFSeiUeenDbhpuBGN5N1dArxD+ZP5iuXgN6b2UNa5bMF9pG
	 svtlCYpqxQpDJf+D5ZANrcM5M4//ycqEyOCZJaf9JfqAfQdV0L0/ng0Z52/FN6+Esv
	 eCoKiUhOKVQuA==
Message-ID: <0fabf792-3a9e-48c9-9f83-286905b5b2d3@zytor.com>
Date: Wed, 7 Feb 2024 10:44:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/nmi: Fix "in NMI handler" check
To: paulmck@kernel.org, Breno Leitao <leitao@debian.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, leit@meta.com,
        Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>
References: <20240207165237.1048837-1-leitao@debian.org>
 <c128c9b0-6bfa-4d62-9bc9-1215ee12ce2b@paulmck-laptop>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <c128c9b0-6bfa-4d62-9bc9-1215ee12ce2b@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/2024 10:30 AM, Paul E. McKenney wrote:
> On Wed, Feb 07, 2024 at 08:52:35AM -0800, Breno Leitao wrote:
>> Commit 344da544f177 ("x86/nmi: Print reasons why backtrace NMIs are
>> ignored") creates a super nice framework to diagnose NMIs.
>>
>> Every time nmi_exc() is called, it increments a per_cpu counter
>> (nsp->idt_nmi_seq). At its exit, it also increments the same counter.
>> Looking at this counter, you can see how many times that function was
>> called (dividing by 2), and, if the function is still being executed, by
>> checking the idt_nmi_seq's last bit.
>>
>> On the check side (nmi_backtrace_stall_check()), that variable is
>> queried to check if the NMI is still being executed, but, there is a
>> mistake in the bitwise operation. That code wants to check if the last
>> bit of the idt_nmi_seq is set or not, but, does the opposite, and check
>> for all the other bits, which will always be true after the first
>> exc_nmi() executed successfully.
>>
>> This appends the misleading string to the dump "(CPU currently in NMI
>> handler function)"
>>
>> Fix it by checking the last bit, and if it is set, append the string.
>>
>> Fixes: 344da544f177 ("x86/nmi: Print reasons why backtrace NMIs are ignored")
>> Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> If someone else is taking this:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
> (I am queueing it for testing in any case.)

Does this fix need to be backported?

Commit 344da544f177 has a date on Dec 16 2022.

> 
>> ---
>>   arch/x86/kernel/nmi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
>> index 17e955ab69fe..6e738ad474dc 100644
>> --- a/arch/x86/kernel/nmi.c
>> +++ b/arch/x86/kernel/nmi.c
>> @@ -639,7 +639,7 @@ void nmi_backtrace_stall_check(const struct cpumask *btp)
>>   			msgp = nmi_check_stall_msg[idx];
>>   			if (nsp->idt_ignored_snap != READ_ONCE(nsp->idt_ignored) && (idx & 0x1))
>>   				modp = ", but OK because ignore_nmis was set";
>> -			if (nmi_seq & ~0x1)
>> +			if (nmi_seq & 0x1)
>>   				msghp = " (CPU currently in NMI handler function)";
>>   			else if (nsp->idt_nmi_seq_snap + 1 == nmi_seq)
>>   				msghp = " (CPU exited one NMI handler function)";
>> -- 
>> 2.39.3
>>
> 

-- 
Thanks!
     Xin


