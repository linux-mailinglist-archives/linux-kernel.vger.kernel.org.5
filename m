Return-Path: <linux-kernel+bounces-65322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82468854B28
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299F41F2760E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE5454FB5;
	Wed, 14 Feb 2024 14:12:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C7B54BD9
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919949; cv=none; b=eFY27tFdTFDrlv3A+I7Gn3jZdmtiFGrdNVn4pEFCdVAqScvsVbqePE9jzYcmJJOgsCZGHdkC21kToZDKWm9kmnWfMiKkBe0wuZCxlDxP1EpJ2wUnq/o1jh8/4pK5cFtU2eKgrh+TVchjdaugAilydVTcuMawN1OoVdM8ZiLtNTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919949; c=relaxed/simple;
	bh=DjL3TuX2F7s/3sIGHVw41gv2i6azOAQmF5jfG+IBnf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oytuxvtLZ0Ke9vIMR8x+ZlvxXrTjDtVguvn6dVt+p3pX6y7YQenptTawA+aEwEEaWDrl19/JYdKOUCbkO+eYSTrcAKhqckS8XGUgeWIHIobCLa+Kf48o99xKoiuSfTTkUO9yvUUQKmh8tFiwqAfb7mbFdITwdj0RhLvkZ/aHX3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74CA41FB;
	Wed, 14 Feb 2024 06:13:06 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.64.145])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47C953F5A1;
	Wed, 14 Feb 2024 06:12:20 -0800 (PST)
Date: Wed, 14 Feb 2024 14:12:17 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
	jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
	mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
	glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
	mattst88@gmail.com, krypton@ulrich-teichert.org,
	rostedt@goodmis.org, David.Laight@aculab.com, richard@nod.at,
	mjguzik@gmail.com, jon.grimm@amd.com, bharata@amd.com,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH 04/30] sched: make test_*_tsk_thread_flag() return bool
Message-ID: <ZczKQceazAevmNtL@FVFF77S0Q05N>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-5-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213055554.1802415-5-ankur.a.arora@oracle.com>

On Mon, Feb 12, 2024 at 09:55:28PM -0800, Ankur Arora wrote:
> All users of test_*_tsk_thread_flag() treat the result as boolean.
> This is also true for the underlying test_and_*_bit() operations.
> 
> Change the return type to bool.
> 
> Cc: Peter Ziljstra <peterz@infradead.org>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

I think this makes sense on its own regardless of the rest of the series; it
might make sense to move it to the start of the series so that it can easily be
picked up even if the rest needs work.

Mark.

> ---
>  include/linux/sched.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 7a22a56350bb..e790860d89c3 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1933,17 +1933,17 @@ static inline void update_tsk_thread_flag(struct task_struct *tsk, int flag,
>  	update_ti_thread_flag(task_thread_info(tsk), flag, value);
>  }
>  
> -static inline int test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
> +static inline bool test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
>  {
>  	return test_and_set_ti_thread_flag(task_thread_info(tsk), flag);
>  }
>  
> -static inline int test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
> +static inline bool test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
>  {
>  	return test_and_clear_ti_thread_flag(task_thread_info(tsk), flag);
>  }
>  
> -static inline int test_tsk_thread_flag(struct task_struct *tsk, int flag)
> +static inline bool test_tsk_thread_flag(struct task_struct *tsk, int flag)
>  {
>  	return test_ti_thread_flag(task_thread_info(tsk), flag);
>  }
> @@ -1958,7 +1958,7 @@ static inline void clear_tsk_need_resched(struct task_struct *tsk)
>  	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
>  }
>  
> -static inline int test_tsk_need_resched(struct task_struct *tsk)
> +static inline bool test_tsk_need_resched(struct task_struct *tsk)
>  {
>  	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
>  }
> -- 
> 2.31.1
> 

