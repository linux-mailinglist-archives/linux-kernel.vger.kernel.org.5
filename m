Return-Path: <linux-kernel+bounces-148678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0223B8A85FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95AFE1F21EAF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC4D1411EE;
	Wed, 17 Apr 2024 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xz+vAPcs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wIrsteCA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A1113C3CF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364355; cv=none; b=EPCowtE7HtEbPihDUgjsdBo4d086F8/vphPv+TDXEnwkRsnLTaZPY/c6kVX1wn/IfBBgkAtquIzVgMJO7Yow1jrETivwzGrS4F3pADg+xwWNOuPM8Tf/kRgIkwhPqGL1jbdPqEQrAupadf52ELTIGrH02pJbDu+/Jjo1rgRnzsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364355; c=relaxed/simple;
	bh=akRpoSE1aSsr1suMziutI2H/OvzunaBEH2OaRnIAoPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aboeWs57g6Ml1lLzhjGj7e3r279W3Vf6BCv3aMOgE4z/4ua5rx5zkoGSY5NxocXygC16QObX92brPR5dFYH7fv/VEyQGCJkPC+HqsPQ1+f6KHyNsoGsdDtwUcWm8BPUDMwf95kYR7kg+APHP3hWhq8+58vfnUrUz6cbXH8SK4Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xz+vAPcs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wIrsteCA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713364352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iv0F5n+wt2/isQQuczAB8LxbG9OobE569mefgXu1zak=;
	b=xz+vAPcsqGsKD84y2YdcuuS2AbFW8kpdy+hzXHOifd14UbY3s+PmTcOWxsZd9VZYzmlhUc
	gA6j/t/Q2G1ZzKCQ8iSEymS/xp00dmpzCnH2M7yJIsmkv6GIeRDmDe3zdxQjSUhH9dxdPH
	p58mwtz0Xtp4lPwwbhWmb7pb0fZ3ayyKcf28rL92fUdGwzcxzt6m3h6F8U54Cm9RcZuGD9
	f6MwgUyfGuqYn/e7KltS0eMkOfcCHusXK1YfOFKd53687ce4HAXHIrzOTdIaKwDf9sLBjB
	7t/sjQ7aoYLXp+uCMPi2rKNQpfEKrjb9QL3qWt2C3tcMozcGkXZrLgO+ejGT8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713364352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iv0F5n+wt2/isQQuczAB8LxbG9OobE569mefgXu1zak=;
	b=wIrsteCAzaxtTnnZPxNVYBoin+Wlw4BKtWvOZh/Yff6P0Hf41IcGHKx9xGQxzaTO8sieco
	+dxXkj/4A+2wCnAw==
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: frederic@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Abaci Robot
 <abaci@linux.alibaba.com>
Subject: Re: [PATCH] hrtimer: Remove unused function hrtimer_hres_active
In-Reply-To: <20240417072342.113756-1-jiapeng.chong@linux.alibaba.com>
References: <20240417072342.113756-1-jiapeng.chong@linux.alibaba.com>
Date: Wed, 17 Apr 2024 16:32:31 +0200
Message-ID: <87wmow3vr4.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> writes:

> The function are defined in the hrtimer.c file, but not called
> elsewhere, so delete the unused function.
>
> kernel/time/hrtimer.c:653:19: warning: unused function 'hrtimer_hres_active'.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8778
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  kernel/time/hrtimer.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index cae9d04b5584..bdaf23356d4b 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -650,11 +650,6 @@ static inline int __hrtimer_hres_active(struct hrtimer_cpu_base *cpu_base)
>  		cpu_base->hres_active : 0;
>  }
>  
> -static inline int hrtimer_hres_active(void)
> -{
> -	return __hrtimer_hres_active(this_cpu_ptr(&hrtimer_bases));
> -}
> -
>  static void __hrtimer_reprogram(struct hrtimer_cpu_base *cpu_base,
>  				struct hrtimer *next_timer,
>  				ktime_t expires_next)


Can you please rename __hrtimer_hres_active() to hrtimer_hres_active()
and remove the old hrtimer_hres_active() function?

Btw. you could add a

  Fixes: 82ccdf062a64 ("hrtimer: Remove unused function")

as the warning was introduced by removing the last (unused) callsite
__hrtimer_peek_ahead_timers().

Thanks,

	Anna-Maria

