Return-Path: <linux-kernel+bounces-140130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F03D8A0BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DFD4B26390
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F0B14264F;
	Thu, 11 Apr 2024 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="disR6yM2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CBA62144;
	Thu, 11 Apr 2024 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826245; cv=none; b=TAWo9e5f1CFyHjFKDyERPYkHA8dTO1EWbEQIwCR/2Jc5l0Zt4PqBDh9XWBYu/q9UVjm0fJABGCeti1GkeC5F7FHgDf8pPE+Quy1evAz5L+bMa2/9iLOTBzqeYNtt02CFMqpBUWIOcd0b9y6jFBsiCeZteNFB0Vtprn7Yc4ExDpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826245; c=relaxed/simple;
	bh=psBauhL+pjKeENmsetnmfnJUWvmR2xRdeP4w3fPxpxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KCxW09vmgxPyX8YPYMPPpo1tv9XD9Z05IfPSWaXkT/2YvXf1COfM5aqeXuv+/Vvae9158lgjAwv8RoP06lzXcc+vnDcMExd1K73Fha/cr4X8zY/cdmq7yPoxTY5iY3vZmE3VoGyFqgFOQoA+WY+4TDeW8aL1Jt1LU/4f0oiVsv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=disR6yM2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712826244; x=1744362244;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=psBauhL+pjKeENmsetnmfnJUWvmR2xRdeP4w3fPxpxw=;
  b=disR6yM2opfBgNKyUJbqJ8EpNYe32CPDu0cJn9ohBSfScrWFYCQTNgMT
   KeXQg6JkErTerG1PGlMIAm9pn2xdJfhgITmGj4esvHBTo4+4+kgMbRljs
   w2dsDi+dC0fdujkg0ombirx9F/jgUCGaN8ZUzruPFG+jQtl3gzxNavJuh
   HcwFSxSOGewS1xTodXaIvsuHMIqTRgotsWztlnkW2oVGUKZdgVpgr7rEg
   Q9v9W1bJNe1/W3wxEekzbn4SZBtHy77xutcUncXIlu1DQ1K2lhuacqeFl
   udhDgLKeK86f0uXV9UpJEkk1gvZsKjSKQYAYNv8z2FcOzz3P+pmSsQVV3
   g==;
X-CSE-ConnectionGUID: yxqXurRcSt24+Eew1QQSjg==
X-CSE-MsgGUID: ZYGkJ0kISaKuOjQtRnBxoQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11186361"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="11186361"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 02:04:02 -0700
X-CSE-ConnectionGUID: jxyzJahlR7mafm9v/t3HUQ==
X-CSE-MsgGUID: 7WEppJyAQbCpQrc3PO3miw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20799716"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.215.66])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 02:03:56 -0700
Message-ID: <0fd5e869-720f-41bb-9f0f-c0f3925ffc1b@intel.com>
Date: Thu, 11 Apr 2024 12:03:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bug: Fix no-return-statement warning with !CONFIG_BUG
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, John Stultz <jstultz@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 linux-s390@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>,
 x86@kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Anna-Maria Gleixner <anna-maria@linutronix.de>,
 Stephen Boyd <sboyd@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20240410153212.127477-1-adrian.hunter@intel.com>
 <87be83da-6102-483d-b1dc-a77eecc9f780@app.fastmail.com>
 <c9f382b2-cd96-4ee3-ad68-95381d9e09c0@intel.com>
 <cac3f357-0dc2-46ba-9ea0-7b1f4278e8ff@app.fastmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <cac3f357-0dc2-46ba-9ea0-7b1f4278e8ff@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/04/24 10:56, Arnd Bergmann wrote:
> On Thu, Apr 11, 2024, at 09:16, Adrian Hunter wrote:
>> On 11/04/24 10:04, Arnd Bergmann wrote:
>>> On Wed, Apr 10, 2024, at 17:32, Adrian Hunter wrote:
>>>> BUG() does not return, and arch implementations of BUG() use unreachable()
>>>> or other non-returning code. However with !CONFIG_BUG, the default
>>>> implementation is often used instead, and that does not do that. x86 always
>>>> uses its own implementation, but powerpc with !CONFIG_BUG gives a build
>>>> error:
>>>>
>>>>   kernel/time/timekeeping.c: In function ‘timekeeping_debug_get_ns’:
>>>>   kernel/time/timekeeping.c:286:1: error: no return statement in function
>>>>   returning non-void [-Werror=return-type]
>>>>
>>>> Add unreachable() to default !CONFIG_BUG BUG() implementation.
>>>
>>> I'm a bit worried about this patch, since we have had problems
>>> with unreachable() inside of BUG() in the past, and as far as I
>>> can remember, the current version was the only one that
>>> actually did the right thing on all compilers.
>>>
>>> One problem with an unreachable() annotation here is that if
>>> a compiler misanalyses the endless loop, it can decide to
>>> throw out the entire code path leading up to it and just
>>> run into undefined behavior instead of printing a BUG()
>>> message.
>>>
>>> Do you know which compiler version show the warning above?
>>
>> Original report has a list
>>
> 
> It looks like it's all versions of gcc, though no versions
> of clang show the warnings. I did a few more tests and could
> not find any differences on actual code generation, but
> I'd still feel more comfortable changing the caller than
> the BUG() macro. It's trivial to add a 'return 0' there.

AFAICT every implementation of BUG() except this one has
unreachable() or equivalent, so that inconsistency seems
wrong.

Could add 'return 0', but I do notice other cases
where a function does not have a return value, such as
cpus_have_final_boot_cap(), so there is already an expectation
that that is OK.

> Another interesting observation is that clang-11 and earlier
> versions end up skipping the endless loop, both with and
> without the __builtin_unreachable, see
> https://godbolt.org/z/aqa9zqz8x

Adding volatile asm("") to the loop would probably fix that,
but it seems like a separate issue.

> 
> clang-12 and above do work like gcc, so I guess that is good.
> 
>      Arnd


