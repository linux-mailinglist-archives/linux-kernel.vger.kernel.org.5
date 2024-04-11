Return-Path: <linux-kernel+bounces-140174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D34308A0C63
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4E21F2595C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22B313F455;
	Thu, 11 Apr 2024 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OHHacQgD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228AB1448E4;
	Thu, 11 Apr 2024 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827689; cv=none; b=NWcZmzuvRjNHBsoy+mKe7tSHnPUTswIq77PlpCnQibtZ6fot9IY8AqhsnRNtjzz5uEceCBxPmNbe/1IY24WUwb0nC+Qgk7LeRhjDSNOn/vstrTuHIXnlHNOWRgn1Y6CGc9vTI78Xgj8V2xhezgW+DyI5KFUh76ZMb+5VT613T4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827689; c=relaxed/simple;
	bh=zITqgZVojLh4dUSaGKV239z9RvbFs2+NfPNhuOaA6RY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiKzvkUoW2M3UdHshXibZwI4Rp6HBTh4cululUDP5QG+4vUWIJpQDEeMXMoR3V6xzXVHYGfGfCB60VjG+rOi8VMzf7QF9kx8+d1MRRNqwYBMNGiu5d0U8anUxlpHYjUJGr0h7iJC99IKNV2VgV8G/yfLLWhfqHLWYgLrMS2uvqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OHHacQgD; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712827687; x=1744363687;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zITqgZVojLh4dUSaGKV239z9RvbFs2+NfPNhuOaA6RY=;
  b=OHHacQgDYRiNowmTSbhA9P6GvF9lTuwW6mgJXtjAN9CVGs3v5hpa9Vwl
   Zc59bfEg+q8kR7mwDw9FFe7D2NYeVZ4GkfW6a7u+q2mfhdFgXRRm0MW4C
   LukqIi47l/0LlE2x9FMWiyrxQjqSr97ogBGszsoIgRTEw95bVFMzo+0vl
   2l45m0l/QgvDIg2PrXvNbF+Daqj9cl/gHV8WdKQk9+2p70iDU8yWLoo34
   J8xzKtFVL8KCAgywbAvbM2z0I5G0ljaNaWuGSArXV+QKMFifZcRBIPk8m
   IySOuRBZO0O88lwLkw6JkyjvoaS1XxQbjvBWuhZGBI/+9gEfZVnTqNtOW
   w==;
X-CSE-ConnectionGUID: N9AKuPqDSkqw1ah5BaW1UA==
X-CSE-MsgGUID: 9iM7Pl4AR+apieVATzFJ0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8083353"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8083353"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 02:28:05 -0700
X-CSE-ConnectionGUID: off1ptQUS5SR8wQ5l3jZ/Q==
X-CSE-MsgGUID: WwenVoetQbuHdgS5T+1EqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="25622263"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.215.66])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 02:27:58 -0700
Message-ID: <4d429a10-eb45-4262-8e74-69af810ef1ac@intel.com>
Date: Thu, 11 Apr 2024 12:27:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bug: Fix no-return-statement warning with !CONFIG_BUG
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Arnd Bergmann <arnd@arndb.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Anna-Maria Gleixner <anna-maria@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20240410153212.127477-1-adrian.hunter@intel.com>
 <87be83da-6102-483d-b1dc-a77eecc9f780@app.fastmail.com>
 <c9f382b2-cd96-4ee3-ad68-95381d9e09c0@intel.com>
 <a434248a-1e9f-4f4f-8f90-d36d8e979f53@csgroup.eu>
 <ff9d7032-a3b6-4ecd-ac26-d7d4a06a5c7f@csgroup.eu>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ff9d7032-a3b6-4ecd-ac26-d7d4a06a5c7f@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/04/24 11:22, Christophe Leroy wrote:
> 
> 
> Le 11/04/2024 à 10:12, Christophe Leroy a écrit :
>>
>>
>> Le 11/04/2024 à 09:16, Adrian Hunter a écrit :
>>> On 11/04/24 10:04, Arnd Bergmann wrote:
>>>> On Wed, Apr 10, 2024, at 17:32, Adrian Hunter wrote:
>>>>> BUG() does not return, and arch implementations of BUG() use 
>>>>> unreachable()
>>>>> or other non-returning code. However with !CONFIG_BUG, the default
>>>>> implementation is often used instead, and that does not do that. x86 
>>>>> always
>>>>> uses its own implementation, but powerpc with !CONFIG_BUG gives a build
>>>>> error:
>>>>>
>>>>>    kernel/time/timekeeping.c: In function ‘timekeeping_debug_get_ns’:
>>>>>    kernel/time/timekeeping.c:286:1: error: no return statement in 
>>>>> function
>>>>>    returning non-void [-Werror=return-type]
>>>>>
>>>>> Add unreachable() to default !CONFIG_BUG BUG() implementation.
>>>>
>>>> I'm a bit worried about this patch, since we have had problems
>>>> with unreachable() inside of BUG() in the past, and as far as I
>>>> can remember, the current version was the only one that
>>>> actually did the right thing on all compilers.
>>>>
>>>> One problem with an unreachable() annotation here is that if
>>>> a compiler misanalyses the endless loop, it can decide to
>>>> throw out the entire code path leading up to it and just
>>>> run into undefined behavior instead of printing a BUG()
>>>> message.
>>>>
>>>> Do you know which compiler version show the warning above?
>>>
>>> Original report has a list
>>>
>>>     https://lore.kernel.org/all/CA+G9fYvjdZCW=7ZGxS6A_3bysjQ56YF7S-+PNLQ_8a4DKh1Bhg@mail.gmail.com/
>>>
>>
>> Looking at the report, I think the correct fix should be to use 
>> BUILD_BUG() instead of BUG()
> 
> I confirm the error goes away with the following change to next-20240411 
> on powerpc tinyconfig with gcc 13.2
> 
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 4e18db1819f8..3d5ac0cdd721 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -282,7 +282,7 @@ static inline void timekeeping_check_update(struct 
> timekeeper *tk, u64 offset)
>   }
>   static inline u64 timekeeping_debug_get_ns(const struct tk_read_base *tkr)
>   {
> -	BUG();
> +	BUILD_BUG();
>   }
>   #endif
> 

That is fragile because it depends on defined(__OPTIMIZE__),
so it should still be:

	BUILD_BUG();
	return 0;


