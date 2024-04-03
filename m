Return-Path: <linux-kernel+bounces-129136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B76896586
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F141F23B40
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB47B58AA9;
	Wed,  3 Apr 2024 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jX1LOOo1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Ln3dULy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA3455E74;
	Wed,  3 Apr 2024 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128107; cv=none; b=SNQHH2cYxmIdk+/3SjnjrrmxdaWmrpeE5kpZp0oCMfPrixgIQ6OhR+D+C8aSEMe+LTB9+5Xp++JzLMh9S5b2kk89QxtpzCwqqA6UFxKUQdamgwJqB24tlzIPnpUarT4oLPqCJHhJkuutcw81UeF5JCPEDYRsucnCpvIfneLh4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128107; c=relaxed/simple;
	bh=T4yhKl7TrANqUAds2tjpE8Je/TuDt+FVyVtJ/SbQRMU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KBQ6J9Vlsk2E/8x+HiznAT8lb3PW962beDuFkSG4y4eA/BzLBwL8qr/l+pzBqqX96bmIdMspCiLnf5R7Y52HxJmeYzesRw5ib/HY8wJtmlEkW6sv1DHC40QqnM4NXwsLZoD+Nng42NBKeS96hjxPQU3MSbLFAcT0hiyLcQnNuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jX1LOOo1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Ln3dULy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Apr 2024 07:08:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712128104;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kX//15BztzPoscCO6BK+vfCh48Eu32fB7AasZnjTLjs=;
	b=jX1LOOo1Q+mTqDTBntU7Avrzz7IVWJRGi3StBywuCtd9I31h2qRTDd/GWcqth+9DELhhrg
	izUsupEn3OiS4qv2kLO1eWE2x8aWPDb2SharHkoeX5bIl/b3EQJoVCGQ0VzqudXB//ioZx
	n6Vr57JcUFWb58jf+9+tc0nwzVSKDXCMXl3q1MGmydvsFIXpWHNHXSvRU5cV/vnhII3eAo
	hZUvA6YE8SL+aw06tIDbCfpbOVR5SpidhsIu3sO1iWelttAQ5GzMp9oq1Nv0WpBtPJV4ya
	td/mbxMvF64TSGkVXIPSKuTGts6RrrdbLdnm9kd13vuG+GfWtr8skWyOJ0+45g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712128104;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kX//15BztzPoscCO6BK+vfCh48Eu32fB7AasZnjTLjs=;
	b=2Ln3dULyffs/S+XOO6oBpNQc1LYdK1QxajOnA+wZtXWSDF6Bgm/n6SHZPDOcu+TwoDARh0
	LqFvaedSaS2sfyBA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/percpu] x86/percpu: Use __force to cast from __percpu address space
Cc: Charlemagne Lasse <charlemagnelasse@gmail.com>,
 Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240402175058.52649-1-ubizjak@gmail.com>
References: <20240402175058.52649-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171212810325.10875.17377924831396823871.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     a55c1fdad5f61b4bfe42319694b23671a758cb28
Gitweb:        https://git.kernel.org/tip/a55c1fdad5f61b4bfe42319694b23671a758cb28
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 02 Apr 2024 19:50:38 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Apr 2024 08:59:15 +02:00

x86/percpu: Use __force to cast from __percpu address space

Fix Sparse warning when casting from __percpu address space by using
__force in the cast. x86 named address spaces are not considered to
be subspaces of the generic (flat) address space, so explicit casts
are required to convert pointers between these address spaces and the
generic address space (the application should cast to uintptr_t and
apply the segment base offset). The cast to uintptr_t removes
__percpu address space tag and Sparse reports:

  warning: cast removes address space '__percpu' of expression

Use __force to inform Sparse that the cast is intentional.

Fixes: 9a462b9eafa6 ("x86/percpu: Use compiler segment prefix qualifier")
Reported-by: Charlemagne Lasse <charlemagnelasse@gmail.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240402175058.52649-1-ubizjak@gmail.com

Closes: https://lore.kernel.org/lkml/CAFGhKbzev7W4aHwhFPWwMZQEHenVgZUj7=aunFieVqZg3mt14A@mail.gmail.com/
---
 arch/x86/include/asm/percpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 1f6404e..20696df 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -77,7 +77,7 @@
 #define arch_raw_cpu_ptr(_ptr)					\
 ({								\
 	unsigned long tcp_ptr__ = __raw_my_cpu_offset;		\
-	tcp_ptr__ += (unsigned long)(_ptr);			\
+	tcp_ptr__ += (__force unsigned long)(_ptr);		\
 	(typeof(*(_ptr)) __kernel __force *)tcp_ptr__;		\
 })
 #else
@@ -96,8 +96,8 @@
 #endif /* CONFIG_SMP */
 
 #define __my_cpu_type(var)	typeof(var) __percpu_seg_override
-#define __my_cpu_ptr(ptr)	(__my_cpu_type(*ptr) *)(uintptr_t)(ptr)
-#define __my_cpu_var(var)	(*__my_cpu_ptr(&var))
+#define __my_cpu_ptr(ptr)	(__my_cpu_type(*ptr)*)(__force uintptr_t)(ptr)
+#define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
 #define __percpu_arg(x)		__percpu_prefix "%" #x
 #define __force_percpu_arg(x)	__force_percpu_prefix "%" #x
 

