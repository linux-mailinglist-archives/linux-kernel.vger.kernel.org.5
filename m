Return-Path: <linux-kernel+bounces-161602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8A08B4E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B291C2098C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C512D51A;
	Sun, 28 Apr 2024 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Dj9oIMlD"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABEC10953
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 22:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714343366; cv=none; b=LoIU0MMeLlMTW4/IikiqmqmgbdCuJMpnlA6hwykRA8oUmWWRwceaTMR/E+bLO0BKOty/rLOzIYM+W8utO1kLC88yPjA9YoHobxRkd8R/OlGNZbTYvAMquWvqoUf7PAY0siBooAR0hrih8qALBc3U/nzz3IObe6di2rX6KHl2ihE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714343366; c=relaxed/simple;
	bh=pPwkkXZ3zq39Ql6e/IBNNK8JDEj0tSnD9VPw3PvRVq0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GpLoq+tBrA+aaAAJ1Tl7MMkEYSEeqqNmYcyUdsha+ItedtLSCPVIFkCvZ5HbRKQpIxB+HD40MJOOR091cMcvzvWSURB17MmL0AgqxBjAZ8n8ONj1RF/5ogxj6WR4aMVNdq5fXdjf3BPbgzuDInfhfTRPSnibH9K7FnEjmltpnZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Dj9oIMlD; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4641:eb14:ad94:2806:1c1a] ([IPv6:2601:646:8002:4641:eb14:ad94:2806:1c1a])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43SMSngt4061982
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 28 Apr 2024 15:28:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43SMSngt4061982
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1714343331;
	bh=YnKL15VUt17/SbAWYY7A8FHqIahTjoK+FZSOEBiiAi4=;
	h=Date:To:Cc:From:Subject:From;
	b=Dj9oIMlDitdI4nFdG5Mrs21wYdU1wclIjuKgAsYd7bM/MT4CmCmal47KV+z3RCvrS
	 b335khZwyiye7rziis6X8JvzKwwoNM9rqgbsAFSBE0yh0X32K5REtBjCtFcuhkKL5c
	 U+Uysgc9o7Ia6QphoDaXR5OWbdkbvQSfm0g3KTJPZjI8+sunyFLPG5dxuwbo4zfZjR
	 HSCnLd/lT2jYWKE6EGG+SVL87LY9OhF+az0rlfh5kJzr6kogeypYm5uJ/iN/uH8Y6l
	 VF3q12Be/13tjCD/A+S78/MWgEN4QrUfeeV9J2Lw5t10+Sqb/sMRYmVcDdQfQrqKfc
	 kDFIuqduNG6BQ==
Message-ID: <a793c733-267d-4930-8ee2-0fc0f24c3538@zytor.com>
Date: Sun, 28 Apr 2024 15:28:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Xin Li <xin@zytor.com>, Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: x86: dynamic pt_regs pointer and kernel stack randomization
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

So the issue of having an explicit pointer to the user space pt_regs 
structure has come up in the context of future FRED extensions, which 
may increase the size of the exception stack frame under some 
circumstances, which may not be constant in the first place.

It struck me that this can be combined with kernel stack randomization 
in such a way that it mostly amortizes the cost of both.

Downside: for best performance, it should be pushed into assembly 
entry/exit code, although that is technically not *required* (and it is 
of course possible to do it in C on IDT but in the one single assembly 
entry stub for FRED.)

In the FRED code it would look like [simplified]:

asm_fred_entrypoint_user:
	/* Current code */
	/* ... */
	movq %rsp,%rdi		/* part of FRED_ENTER */

	/* New code */
	movq %rdi,PER_CPU_VAR(user_pt_regs_ptr)	/* [1] */
#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
	subq PER_CPU_VAR(kstack_offset),%rsp	/* [2] */
#endif
	/* CFI annotation */

	/* Current code */
	call fred_entry_from_user

asm_fred_exit_uTser:
	/* New code */
	movq PER_CPU_VAR(user_pt_regs_ptr),%rsp
	/* CFI annotation */

	/* Current code */
	/* ... */
	ERETU

[1] - This instruction can be pushed into the C code in 
fred_entry_from_user() without changing the functionality in any way.

[2] - This is the ONLY instruction in this sequence that would be 
specific to CONFIG_RANDOMIZE_KSTACK_OFFSET, and it probably isn't even 
worth patching out.

This requires a 64-bit premasked value to be generated byc 
choose_random_kstack_offset() which would seem to be a better option for 
performance, especially since there is already arithmetic done at that 
time. Otherwise it requires three instructions. This means the 
randomness accumulator ends up being in a separate variable from the 
premasked value. This could be further very slightly optimized by adding 
the actual stack location and making this a movq, but then that value 
has to be context-switched; this is probably not all that useful.

The masking needs to consider alignment, which the current code doesn't; 
that by itself adds additional code to the current code sequences.



That is literally *all* the code that is needed to replace 
add_random_kstack_offset(). It doesn't block tailcall optimization 
anywhere. If user_pt_regs_ptr and kstack_offset share a cache line it 
becomes even cheaper.

Note that at least in the FRED case this code would be invoked even on 
events other than system calls, some of which may be controllable by the 
user, like page faults. I am guessing that this is actually a plus.

	-hpa


