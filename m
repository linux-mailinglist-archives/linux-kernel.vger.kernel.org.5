Return-Path: <linux-kernel+bounces-92923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F342F872836
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AABA22837D7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A79486AC3;
	Tue,  5 Mar 2024 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="OBRVYu/T"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1C724B59;
	Tue,  5 Mar 2024 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668914; cv=none; b=JEytL/nHLJxh0QUXGWKJvWWOx3KbYLqHpj1UGOixx5K44kYpg6HlAl5KUI6XuwhqwAvFvQgGgGQOPaicP/MvyGowC1Tf9X+FDbFQv6R5k2AWsqnwSACdzpdty8ROkiU9/P8jZctdE+1KZhnvP9YDnrQE0tWRnKnk/jmVSLwlY40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668914; c=relaxed/simple;
	bh=GTZEmYrJZ99CRAEJeUE7NQw/5vhF7dJqJaRROiMrRzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kaMRFkKKLRt/VgzuKXA2qKrVwKQL0G0TRp5C7eCqIwkcdLRejWkBr/Y/5ZIuoGl8wXRUv7CGCQJBtmJSe6HsppJbPrqRmWn1bYxec4Zl8/VsXZkiukVS3E4iG4usad0mfEBpCwTa+dulAsljWv47oI6zQJhr4EMXtTHfNtfCQU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=OBRVYu/T; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1709668909;
	bh=GTZEmYrJZ99CRAEJeUE7NQw/5vhF7dJqJaRROiMrRzU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OBRVYu/Tyb/oOls1AzS687Uc4GZdicEAZ1LDF75aZgvLCzWN9FWoNvT+11Cr9TadD
	 467iS5CaWbRKqM9MHpVIo8QECsO+mOlMktIOkz8L40zrt9J3KbJxmyr+pU0Kl5Fu8o
	 mQey8lhQVLarLcFahnPRrcdQYZnTrj2P6MYSntUKRf6LfVS7nmMcGEVYWJJjlTQnnf
	 WTv8ksnba53LkC52kXoP4OYs4J9eSN5HL+zIDuI6IAOm2itjdBtBTsvYHcafUcpAv4
	 Mi2FxM6yki8BMrYXpiFjcAij8CRYSF3nTUzDAISPywCLFsRAeu9tjlcjhV6PtZbRee
	 6CHmLBAajqhKQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Tq60F27Yszfx5;
	Tue,  5 Mar 2024 15:01:49 -0500 (EST)
Message-ID: <b0a3e152-22bb-4502-a0a0-4b2513bfbec8@efficios.com>
Date: Tue, 5 Mar 2024 15:01:55 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Add memory barrier for mm_cid
Content-Language: en-US
To: "levi.yun" <yeoreum.yun@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, mark.rutland@arm.com, peterz@infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 nd@arm.com, stable@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
References: <20240305145335.2696125-1-yeoreum.yun@arm.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240305145335.2696125-1-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-05 09:53, levi.yun wrote:
> Currently arm64's switch_mm() doesn't always have an smp_mb()
> which the core scheduler code has depended upon since commit:
> 
>      commit 223baf9d17f25 ("sched: Fix performance regression introduced by mm_cid")
> 
> If switch_mm() doesn't call smp_mb(), sched_mm_cid_remote_clear()
> can unset the activly used cid when it fails to observe active task after it
> sets lazy_put.
> 
> By adding an smp_mb() in arm64's check_and_switch_context(),
> Guarantee to observe active task after sched_mm_cid_remote_clear()
> success to set lazy_put.

This comment from the original implementation of membarrier
MEMBARRIER_CMD_PRIVATE_EXPEDITED states that the original need from
membarrier was to have a full barrier between storing to rq->curr and
return to userspace:

commit 22e4ebb9758 ("membarrier: Provide expedited private command")

commit message:

     * Our TSO archs can do RELEASE without being a full barrier. Look at
       x86 spin_unlock() being a regular STORE for example.  But for those
       archs, all atomics imply smp_mb and all of them have atomic ops in
       switch_mm() for mm_cpumask(), and on x86 the CR3 load acts as a full
       barrier.
     
     * From all weakly ordered machines, only ARM64 and PPC can do RELEASE,
       the rest does indeed do smp_mb(), so there the spin_unlock() is a full
       barrier and we're good.
     
     * ARM64 has a very heavy barrier in switch_to(), which suffices.
     
     * PPC just removed its barrier from switch_to(), but appears to be
       talking about adding something to switch_mm(). So add a
       smp_mb__after_unlock_lock() for now, until this is settled on the PPC
       side.

associated code:

+               /*
+                * The membarrier system call requires each architecture
+                * to have a full memory barrier after updating
+                * rq->curr, before returning to user-space. For TSO
+                * (e.g. x86), the architecture must provide its own
+                * barrier in switch_mm(). For weakly ordered machines
+                * for which spin_unlock() acts as a full memory
+                * barrier, finish_lock_switch() in common code takes
+                * care of this barrier. For weakly ordered machines for
+                * which spin_unlock() acts as a RELEASE barrier (only
+                * arm64 and PowerPC), arm64 has a full barrier in
+                * switch_to(), and PowerPC has
+                * smp_mb__after_unlock_lock() before
+                * finish_lock_switch().
+                */

Which got updated to this by

commit 306e060435d ("membarrier: Document scheduler barrier requirements")

                 /*
                  * The membarrier system call requires each architecture
                  * to have a full memory barrier after updating
+                * rq->curr, before returning to user-space.
+                *
+                * Here are the schemes providing that barrier on the
+                * various architectures:
+                * - mm ? switch_mm() : mmdrop() for x86, s390, sparc, PowerPC.
+                *   switch_mm() rely on membarrier_arch_switch_mm() on PowerPC.
+                * - finish_lock_switch() for weakly-ordered
+                *   architectures where spin_unlock is a full barrier,
+                * - switch_to() for arm64 (weakly-ordered, spin_unlock
+                *   is a RELEASE barrier),
                  */

However, rseq mm_cid has stricter requirements: the barrier needs to be
issued between store to rq->curr and switch_mm_cid(), which happens
earlier than:

- spin_unlock(),
- switch_to().

So it's fine when the architecture switch_mm happens to have that barrier
already, but less so when the architecture only provides the full barrier
in switch_to() or spin_unlock().

The issue is therefore not specific to arm64, it's actually a bug in the
rseq switch_mm_cid() implementation. All architectures that don't have
memory barriers in switch_mm(), but rather have the full barrier either in
finish_lock_switch() or switch_to() have them too late for the needs of
switch_mm_cid().

I would recommend one of three approaches here:

A) Add smp_mb() in switch_mm_cid() for all architectures that lack that
    barrier in switch_mm().

B) Figure out if we can move switch_mm_cid() further down in the scheduler
    without breaking anything (within switch_to(), at the very end of
    finish_lock_switch() for instance). I'm not sure we can do that though
    because switch_mm_cid() touches the "prev" which is tricky after
    switch_to().

C) Add barriers in switch_mm() within all architectures that are missing it.

Thoughts ?

Thanks,

Mathieu


> 
> Signed-off-by: levi.yun <yeoreum.yun@arm.com>
> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
> Cc: <stable@vger.kernel.org> # 6.4.x
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Aaron Lu <aaron.lu@intel.com>
> ---
>   I'm really sorry if you got this multiple times.
>   I had some problems with the SMTP server...
> 
>   arch/arm64/mm/context.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
> index 188197590fc9..7a9e8e6647a0 100644
> --- a/arch/arm64/mm/context.c
> +++ b/arch/arm64/mm/context.c
> @@ -268,6 +268,11 @@ void check_and_switch_context(struct mm_struct *mm)
>   	 */
>   	if (!system_uses_ttbr0_pan())
>   		cpu_switch_mm(mm->pgd, mm);
> +
> +	/*
> +	 * See the comments on switch_mm_cid describing user -> user transition.
> +	 */
> +	smp_mb();
>   }
> 
>   unsigned long arm64_mm_context_get(struct mm_struct *mm)
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


