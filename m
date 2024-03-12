Return-Path: <linux-kernel+bounces-100260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D59879432
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C281C2349F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9E927711;
	Tue, 12 Mar 2024 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XkdddlV5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d/TNS+wq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9647A725;
	Tue, 12 Mar 2024 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710246698; cv=none; b=F6tm0qNO7u1vkk80cQOPAtXC5HhwJRt//XJfnRFiv9AgUDUB/rUf/BvUZx/v54xVFhSBkbKEOdOgmLaie9kPy4dgsuCiFd0VA1uQilS6Bemo4OAxunYhPtwO9gKUM+r1nrQAhCMnilqhCHALzL9rxolXWPbv7mAMR7xeiemnbYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710246698; c=relaxed/simple;
	bh=YUDwPmmGmifLTp4K+qwrTBLYO/VCERhHUUN5j5QK+34=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kHDd7iExh0dl/k8lClPJtaAV3A389ZObqiyt8iXk7GMQwkde5oRIqqxHYip6dBiLU7PTw2zDhQLiOyXuknSNFYLSazgY+CiEWbGlElkktyHPJRny7xgZDMB68NWxdsPLBsJiIQZjeZVJYYbCvGaV6FmDlQ40wl+TKT4bTNkzekc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XkdddlV5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d/TNS+wq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:31:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710246694;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ovi0JJjQ7hxlr3V/9fUor1xDG+wtgSVwvDQfNMYBdpM=;
	b=XkdddlV5cxbLqJFDoAkaL0N9t/0TKnUvo1eH5XFG2PTaPDzFtPc1pmrbqVONn6xvgnkZjh
	DtDOt2pEh/lZO++LnwK3vWMVE6uPt6kprPqgadMM38IaHpMagNsl0gsi6tXY01kPPVGIrM
	M8oelyUvXZmXil+n2dhmgZGygl2fgwAzVtZL0UzJBTe41AcqsZLv4KT0SSwEzfJQTcUp3B
	xaUWozscDId4064o9nBbllsEfdtkzSfDWBXTHgfEeUMJlLfatOcK9murVDF/FT/q3mSQA6
	ujUx3CmdfIJCRxfXY+Zw8zuPDH5fbb7xiyrcNb9EFnxVN6kTbmPYd9HZThEL1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710246694;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ovi0JJjQ7hxlr3V/9fUor1xDG+wtgSVwvDQfNMYBdpM=;
	b=d/TNS+wqqz3hitWA/3PXF0NsyL8k47y13OpBrIlj9uVB7DtYR95FQe/6ZjADOcHX81ZJJz
	uCkT6uPtk0wIcFDw==
From:
 tip-bot2 for =?utf-8?q?Andr=C3=A9_R=C3=B6sti?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Respect changes to system call number by
 trace_sys_enter()
Cc: an.roesti@gmail.com, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240311211704.7262-1-an.roesti@gmail.com>
References: <20240311211704.7262-1-an.roesti@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024669388.398.6202671416393382328.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     fb13b11d53875e28e7fbf0c26b288e4ea676aa9f
Gitweb:        https://git.kernel.org/tip/fb13b11d53875e28e7fbf0c26b288e4ea67=
6aa9f
Author:        Andr=C3=A9 R=C3=B6sti <an.roesti@gmail.com>
AuthorDate:    Mon, 11 Mar 2024 21:17:04=20
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Mar 2024 13:23:32 +01:00

entry: Respect changes to system call number by trace_sys_enter()

When a probe is registered at the trace_sys_enter() tracepoint, and that
probe changes the system call number, the old system call still gets
executed.  This worked correctly until commit b6ec41346103 ("core/entry:
Report syscall correctly for trace and audit"), which removed the
re-evaluation of the syscall number after the trace point.

Restore the original semantics by re-evaluating the system call number
after trace_sys_enter().=20

The performance impact of this re-evaluation is minimal because it only
takes place when a trace point is active, and compared to the actual trace
point overhead the read from a cache hot variable is negligible.

Fixes: b6ec41346103 ("core/entry: Report syscall correctly for trace and audi=
t")
Signed-off-by: Andr=C3=A9 R=C3=B6sti <an.roesti@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240311211704.7262-1-an.roesti@gmail.com
---
 kernel/entry/common.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 88cb3c8..90843cc 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -57,8 +57,14 @@ long syscall_trace_enter(struct pt_regs *regs, long syscal=
l,
 	/* Either of the above might have changed the syscall number */
 	syscall =3D syscall_get_nr(current, regs);
=20
-	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
+	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT)) {
 		trace_sys_enter(regs, syscall);
+		/*
+		 * Probes or BPF hooks in the tracepoint may have changed the
+		 * system call number as well.
+		 */
+		syscall =3D syscall_get_nr(current, regs);
+	}
=20
 	syscall_enter_audit(regs, syscall);
=20

