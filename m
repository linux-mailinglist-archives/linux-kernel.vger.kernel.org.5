Return-Path: <linux-kernel+bounces-71174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 666A985A1A3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9F98B2239D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638522C18E;
	Mon, 19 Feb 2024 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KfGmEqw8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DiU3lG6I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F5D200C8
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341104; cv=none; b=L/L2ipJtgP/vRTchRleZOCXxTBznU+YklzcN5j65oGPlcwWfwhEn6wofQpt10Yqh3EhfKkLQNrLhHD4k1uSGYE4JINpLk4POdwOSapki22HEB5/KTPk1Dwr526x1t5SoR5waykbHuxSw4VkrIF+vifwKYd+j/xMHDCGthbOLIz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341104; c=relaxed/simple;
	bh=aWgrvypctQzziYl6KvOgN6Chq4da39LD3mgvplvAuJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sB8VHn9BrTPMJz9fjyFpsWckijuhXEVOPj9rPq6zSxz+QIlli1UTbXdCnQ7gz3H49cPvqWlMxdflf4B7T3z8XpvVCGjE5f7pOz33INRqpRSXbFm7YHxLI3uOBeKRpRjwEcdQqMUO4FULfvN0tTehRdVDLVwRHGt2Lte2Sxt1048=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KfGmEqw8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DiU3lG6I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708341101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LRh05+5lvCTPWKWoq3hTFsY8DpEaK+SuUN5woeyhLaA=;
	b=KfGmEqw8EHv9R9t6G7gkc1EPSs4UZH0DG0nusBvDc1kEdPoUedO1eqC2/kILzI6DNLGUhz
	3jKtkRbiyMqdrJfpSvAiXR9Ff0opbotrKH6AVE3GCHRzFeq6eZa2Ezr9t7UOAyWXXCWojE
	6PDxshgW+l9fpjxCqBkgrmNQFU3CDS1eWON+dP6lK4Jb/vL/bSro+NLY2m4hlG3BjvcIQV
	Erq2hSlXWg5c8N6t8gnBHYFzNLwv1Jvsjx6w0bqiVBaxLNxZvkacrJMXd7oMQxuLVfvYkY
	Ben8EJadHz1uCNELChysv8ykef7kehgtrxNNh1TSAPel4oo/4KaORfRReFIGHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708341101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LRh05+5lvCTPWKWoq3hTFsY8DpEaK+SuUN5woeyhLaA=;
	b=DiU3lG6IgRqefdfaWZcqFh1wSpWsBv8222Uaw8LjFx7Noed2uIgx5vnE6HlIxF/TgF9Aem
	07SnmYJ+lfuoAxCQ==
To: Waiman Long <longman@redhat.com>, Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>
Subject: Re: [PATCH printk v2 26/26] lockdep: Mark emergency section in
 lockdep splats
In-Reply-To: <6d8f5126-3595-4abd-9b05-b19a659d1cea@redhat.com>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-27-john.ogness@linutronix.de>
 <6d8f5126-3595-4abd-9b05-b19a659d1cea@redhat.com>
Date: Mon, 19 Feb 2024 12:17:20 +0106
Message-ID: <878r3gbtev.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2024-02-18, Waiman Long <longman@redhat.com> wrote:
> On 2/18/24 13:57, John Ogness wrote:
> lockdep.c has multiple functions that print stuff to the console, like
>
>  =C2=A0- print_circular_bug_header()
>  =C2=A0- print_bad_irq_dependency()
>  =C2=A0- print_deadlock_bug()
>  =C2=A0- print_collision()
>  =C2=A0- print_usage_bug()
>  =C2=A0- print_irq_inversion_bug()
>  =C2=A0- print_lock_invalid_wait_context()
>  =C2=A0- print_lock_nested_lock_not_held()
>  =C2=A0- print_unlock_imbalance_bug()
>  =C2=A0- print_lock_contention_bug()
>  =C2=A0- print_freed_lock_bug()
>  =C2=A0- print_held_locks_bug()
>  =C2=A0- lockdep_rcu_suspicious()
>
> So what is special about print_usage_bug() that it needs this
> emergency treatment but not the other ones?

I do not expect to be able to identify all "emergency printing" paths in
the kernel from the beginning. This series initially marks some sections
that are IMHO interesting for the feature.

As you are implying, for lockdep probably all printing should be
considered emergency. Is it preferred to place the markers outside the
high-level print functions, for example:

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 00465373d358..7a4e4f4a9156 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2182,10 +2182,12 @@ check_noncircular(struct held_lock *src, struct hel=
d_lock *target,
 			*trace =3D save_trace();
 		}
=20
+		nbcon_cpu_emergency_enter();
 		if (src->class_idx =3D=3D target->class_idx)
 			print_deadlock_bug(current, src, target);
 		else
 			print_circular_bug(&src_entry, target_entry, src, target);
+		nbcon_cpu_emergency_exit();
 	}
=20
 	return ret;

Or is it preferred to put them directly around the various pr_warn()
blocks (as the patch in this series is doing)?

John Ogness

