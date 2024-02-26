Return-Path: <linux-kernel+bounces-82041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69223867E21
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F911C2D169
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B0412FF86;
	Mon, 26 Feb 2024 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eNhTIo/2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wJ7UNBSe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AEA12C7E1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967952; cv=none; b=TIoKBQnkqDMBqqCogFY3IJHm/yJAmDWQXC27xix4lhcdrPEZhoQsoWhfkonrRzZGfWEUZEMXx0qxlviA4o2e3oWRi8kTAiuY3sr3dDPTpnlxq9u5VXmGGXeIWNpOA4IV5Fg1IE8Vx60dUOk/T1Wy1J2bvumQkHKHrsBPwrMnch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967952; c=relaxed/simple;
	bh=HD230qnCazUJ0VkUYF/KpSDIa6u84SjbwrA7bGZsANE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iPTXh+YOXo/FfQl41aqu1NOapGS0mopnf2DNpdrHBS1RIKcwakC/11AG91mMiQNbs9w/yNjpIZ4KLkG+nru6Y+Qh4AZci9CA5EMapRYoNkgdiaL3fw0cXZxLdp/D8TmTr5bJIISV+Oj/Bk/sZaXnr6uxgyR8q5qcF7NdIQ1A7lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eNhTIo/2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wJ7UNBSe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708967945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V3vn3rLr5G2NqalvLJxxGRPMV5b+Ax+IZGLTu4ZEzgI=;
	b=eNhTIo/2o/RWZs1pVkfZG/4iSYj+Fq4lfpzGaiNGzKPenf5WsKnoNIN/N+ToalNrqOFzUi
	B3qG725EMvlSkwhNmA7oDgkiuf2oJnWc8uThdWvlz2UN9jfHouxmF4xFTMEKWlD66zciO6
	fM/g4/uWJ6JP/CWQTa5vzUjif07bN9BydW5Nv7rqH+3Lmosx4LrWxy+SUOhitZ76GJ9vYE
	6TxrbUNq8u6UXtIn0OIdNibFimGIe8tVYKJpwaRaodcctqspYDml2mqah3l1y1DY0w7mdm
	kq6OXdX4BcPMCl4JCm/nYpFW82AC5F/PvAHVeRiPQ9WaZm/wva08WTvuGPVt4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708967945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V3vn3rLr5G2NqalvLJxxGRPMV5b+Ax+IZGLTu4ZEzgI=;
	b=wJ7UNBSeICW3VDibCMDLFvkAv2zCuzVWNl9Gbg368H8OVoZJxmReNGCIcT+MDGt7WB4qRP
	1r9yQnfY3kOsDQAA==
To: Arnd Bergmann <arnd@arndb.de>, Naresh Kamboju
 <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, Linux ARM
 <linux-arm-kernel@lists.infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Kees Cook <keescook@chromium.org>
Subject: Re: arch/arm64/include/asm/atomic_ll_sc.h:298:9: error: unknown
 type name 'u128'
In-Reply-To: <23e6b40b-deb4-4e94-b454-cb2af0543af1@app.fastmail.com>
References: <CA+G9fYtrXXm_KO9fNPz3XaRxHV7UD_yQp-TEuPQrNRHU+_0W_Q@mail.gmail.com>
 <0fe0add2-6b17-441f-a0e1-7c1ee9b0ea71@app.fastmail.com>
 <871q8zkygb.fsf@somnus>
 <23e6b40b-deb4-4e94-b454-cb2af0543af1@app.fastmail.com>
Date: Mon, 26 Feb 2024 18:19:04 +0100
Message-ID: <87wmqrjg8n.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Mon, Feb 26, 2024, at 17:00, Anna-Maria Behnsen wrote:
>> "Arnd Bergmann" <arnd@arndb.de> writes:
>>> Commit a0d2fcd62ac2 ("vdso/ARM: Make union vdso_data_store
>>> available for all architectures") introduced a reference to
>>> the asm/page.h in include/vdso/datapage.h, but this is outside
>>> of the vdso/*.h namespace and doesn't work in the compat vdso.
>>
>> But the asm namespace works for the vdso namespace. Only linux headers
>> do not work, or am I wrong?
>
> The vdso namespace was added to have something that works for
> userspace code in both compat 32-bit mode and native (32 or
> 64) bit mode, while anything outside of include/vdso may not
> work here.
>
>> PAGE_SIZE is defined in asm/page-def.h for arm64. So this could be a
>> fast fix (tested with clang-14):
>>
>> ---8<----
>> --- a/include/vdso/datapage.h
>> +++ b/include/vdso/datapage.h
>> @@ -19,7 +19,11 @@
>>  #include <vdso/time32.h>
>>  #include <vdso/time64.h>
>> 
>> +#ifdef CONFIG_ARM64
>> +#include <asm/page-def.h>
>> +#else
>>  #include <asm/page.h>
>> +#endif
>> 
>>  #ifdef CONFIG_ARCH_HAS_VDSO_DATA
>>  #include <asm/vdso/data.h>
>> ---8<---
>
> I've sent my own patch now, which is something we probably want
> anyway, but is obviously much more invasive thank your four-line
> patch.

Yes I saw it already.

> Maybe we can put your quick fix in the tip tree for the moment
> and I put my patches into the asm-generic tree, then
> we can do the trivial cleanup from my final patch later.
>

I'll send a quick fix and reference there to your future cleanup queue.

Thanks,

	Anna-Maria


