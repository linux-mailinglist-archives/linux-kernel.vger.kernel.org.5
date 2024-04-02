Return-Path: <linux-kernel+bounces-127663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED71894F26
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5A7281797
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C63C58AD6;
	Tue,  2 Apr 2024 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AHkTsqkj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2VkLTX1t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE8A5731E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051546; cv=none; b=b1S2cZ0jkDXZKWm50yV/sl4W8I34en6LLSTausHB+kRc5QxwEGPo+GsqOBRxrB10x/R3F6m7jYH1nBn8qyz496MXunnH37HmrRLweQYf+VX6D5K5qPLO6iFTK4w8wSfJgWWQTKCX5OwIvm2SKgJOnHQD+HyxfxpyHaC62hl+Auo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051546; c=relaxed/simple;
	bh=AvNwNwPRatiYJ8KSWOBnIOETxBQESg1ookNNE0WUh5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pHvEI7GiGKQ6NsfdDIGZnQjRdC+pKqy57u4K2pAP/uy4EG4i0hcqLjdolh8RbnRzZnzRF7zV42+WeyUMONmQD0Y7m/NbL62uyo/WFPgB0WcEn7Y1cCWwVHoOradjOU6gZNmgABOUtTWXFUWW+lYDE4QISPAGaoWCTvf8gavf+rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AHkTsqkj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2VkLTX1t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712051543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MfofgMPYhY/CqWyYNBhoezw1zH/eEREYv39qPQ0r7r4=;
	b=AHkTsqkjQbHXXaFvQ5UP2Gi8kNOdjZjU203GN+COJzt1HFQ4x7JUpwRuZZnLoMepVZCVqM
	FHI+kivziADmv/gyOxAVJSnj9Z6GiWWO23uPtRL/wmb+rtAx4luGlrxP/eqA14bZWJfg91
	PFQ/1ZF1de7dNSkjEHRuiDSqctQ+4eO4kwRDVFehyEurKX/ZEY7k9DU1oEONSQsPzOMD2+
	gdhwVDmjnF2myapYukatzEUIvql7EHVqsE1BdWGg9YE/zuBIN1Hfneu52OjK8NErvpPwv1
	eP4wblcEmJfSL5lhg0kHwuQfcEAxKMvRlPvePFvLesbcYUC/iouMQ0CZe1Pifw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712051543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MfofgMPYhY/CqWyYNBhoezw1zH/eEREYv39qPQ0r7r4=;
	b=2VkLTX1t5a2XWVXNN/izKQSB9OB8uZt0ALZgP3O9/xbc48FDbcAHos1B+zl2EnD65HECRO
	KQhxGEJ0320vDbBA==
To: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>
Subject: Re: [PATCH] timers/migration: Fix ignored event due to missing CPU
 update
In-Reply-To: <20240401214859.11533-1-frederic@kernel.org>
References: <20240401214859.11533-1-frederic@kernel.org>
Date: Tue, 02 Apr 2024 11:52:23 +0200
Message-ID: <87r0fo9jmw.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Frederic Weisbecker <frederic@kernel.org> writes:

> When a group event is updated with its expiry unchanged but a different
> CPU, that target change may go unnoticed and the event may be propagated
> up with a stale CPU value. The following depicts a scenario that has
> been actually observed:

urgh...

>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/time/timer_migration.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> index c63a0afdcebe..90786bb9a607 100644
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -762,8 +762,11 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
>  	 * queue when the expiry time changed only or when it could be ignored.
>  	 */
>  	if (timerqueue_node_queued(&evt->nextevt)) {
> -		if ((evt->nextevt.expires == nextexp) && !evt->ignore)
> +		if ((evt->nextevt.expires == nextexp) && !evt->ignore) {
> +			if (evt->cpu != first_childevt->cpu)
> +				evt->cpu = first_childevt->cpu;

Why not just unconditionally overwriting the evt->cpu value here?

>  			goto check_toplvl;
> +		}
>  
>  		if (!timerqueue_del(&group->events, &evt->nextevt))
>  			WRITE_ONCE(group->next_expiry, KTIME_MAX);

Thanks,

        Anna-Maria


