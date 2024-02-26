Return-Path: <linux-kernel+bounces-81854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7379867AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877881F28CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E11812CD8D;
	Mon, 26 Feb 2024 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dXqqfxIv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e36mqOQp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC5A12C7F4
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963224; cv=none; b=kXhJ8EGF+EIUd1p0sTICLbQU2nqaOCDX71jsSWcs1Xnt2R/hoMwR0bs+3ByDeUtnHmDDkpUz1gpI5YCD4MNzpSd/wthZ/adKbKkzcOvbPOcd4AAgdbuAOXSs9oD7Ylov0j2zyyDkDlS6cjNc+mLREj7dmL9HbUNIznbNSWAnY/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963224; c=relaxed/simple;
	bh=zx5/mIFUTU3yjrLv62x/L8m8qfx6G0kMg3WAxLQv1gI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cUgnBRyOS/fIPyrvITuo+e6Piizib36asVplcFp2VayrNsdDc00ZDbC3vItV3v0Oima+NwQ9PXibZhcXS4bFjhXVr3+8KL+cxmfJSc2VUmb79pN2laVhfQwQGsgIGIIL+IvMvycTg10MoIwgRiPl3F9CHMifxgXWF11kdLQzFcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dXqqfxIv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e36mqOQp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708963220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WEmhdiiQQbTfuRjiNB7+533BTNvYbMz78iuKIE4w618=;
	b=dXqqfxIv9snhj53TLlWIoYnlfb2uv2KCZYP0gst5jHNgf+TacKXsogPHCK0T73IAZ2or8m
	mDl9B1Z2CIO6m3VBkrVk9rsBXShjB3YAx81XMe9dtHjB9BQ2sLlc2jecIjYL997IxLq87w
	axZ8ExqOBivLnwBmYIWlSqIN3D0WNBZQWQMGjx7iQFKMFWIq7xuhOSyytNkDBgdxqnqwgl
	nh+RcVDQj5yWCi0WWHXHl+CgH1h7pNfArIZTNpobXhZB9+8dwbqvhssq0J6auC7qEq+JgA
	94qTo83w2ufuYAjAoexK1mQOX/9jFwFJ0gYZmBNDFttXxX7pSRFziG6AMNIX2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708963220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WEmhdiiQQbTfuRjiNB7+533BTNvYbMz78iuKIE4w618=;
	b=e36mqOQpOvMbmMukekA46dOhO4E6SSBBK1zQDxRVK/a9JFTFZjjmQuS0YAMjSr3HFeQd6B
	3xS/EnFxXx+GZSDA==
To: Arnd Bergmann <arnd@arndb.de>, Naresh Kamboju
 <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, Linux ARM
 <linux-arm-kernel@lists.infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Kees Cook <keescook@chromium.org>
Subject: Re: arch/arm64/include/asm/atomic_ll_sc.h:298:9: error: unknown
 type name 'u128'
In-Reply-To: <0fe0add2-6b17-441f-a0e1-7c1ee9b0ea71@app.fastmail.com>
References: <CA+G9fYtrXXm_KO9fNPz3XaRxHV7UD_yQp-TEuPQrNRHU+_0W_Q@mail.gmail.com>
 <0fe0add2-6b17-441f-a0e1-7c1ee9b0ea71@app.fastmail.com>
Date: Mon, 26 Feb 2024 17:00:20 +0100
Message-ID: <871q8zkygb.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Fri, Feb 23, 2024, at 10:10, Naresh Kamboju wrote:
>> In file included from arch/arm64/include/asm/lse.h:5,
>>                  from arch/arm64/include/asm/cmpxchg.h:14,
>>                  from arch/arm64/include/asm/atomic.h:16,
>>                  from include/linux/atomic.h:7,
>>                  from include/asm-generic/bitops/atomic.h:5,
>>                  from arch/arm64/include/asm/bitops.h:25,
>>                  from include/linux/bitops.h:68,
>>                  from arch/arm64/include/asm/memory.h:209,
>>                  from arch/arm64/include/asm/page.h:46,
>>                  from include/vdso/datapage.h:22,
>>                  from lib/vdso/gettimeofday.c:5,
>>
>>                  from <command-line>:
>> arch/arm64/include/asm/atomic_ll_sc.h:298:9: error: unknown type name 'u128'
>>   298 |         u128 full;
>>       |         ^~~~
>> arch/arm64/include/asm/atomic_ll_sc.h:305:24: error: unknown type name 'u128'
>>   305 | static __always_inline u128
>
> The problem here is the separation of vdso/*.h headers and
> linux/*.h headers.
>
> Commit a0d2fcd62ac2 ("vdso/ARM: Make union vdso_data_store
> available for all architectures") introduced a reference to
> the asm/page.h in include/vdso/datapage.h, but this is outside
> of the vdso/*.h namespace and doesn't work in the compat vdso.

But the asm namespace works for the vdso namespace. Only linux headers
do not work, or am I wrong?

> I think it is only needed because of the PAGE_SIZE macro,
> so that constant needs to come from somewhere else.

Yes.

> I have an older patch that I never merged to unify the
> page size configuration in Kconfig, and could try to
> dig that out if nobody has a better idea. If we do that,
> we could introduce a CONFIG_PAGE_SIZE.

PAGE_SIZE is defined in asm/page-def.h for arm64. So this could be a
fast fix (tested with clang-14):

---8<----
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -19,7 +19,11 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>
 
+#ifdef CONFIG_ARM64
+#include <asm/page-def.h>
+#else
 #include <asm/page.h>
+#endif
 
 #ifdef CONFIG_ARCH_HAS_VDSO_DATA
 #include <asm/vdso/data.h>
---8<---

Thanks,

	Anna-Maria


