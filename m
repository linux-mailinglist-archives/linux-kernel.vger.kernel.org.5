Return-Path: <linux-kernel+bounces-133897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD71789AA7E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A108B21ACD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5802C194;
	Sat,  6 Apr 2024 11:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aGsZ2T+q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/0ewbai/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C949210A1A;
	Sat,  6 Apr 2024 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712401680; cv=none; b=T6kamQ0WKKCBbMi5yjAnYei4/EnSr7FoII6WkkhYfZzR3Qqp7JolAKJgX9jG1zrssdOPxOxafoV1JLm45y/MC1S696mZ8Ly3QVKTCJMmEI0BJSoeJRUWBlhFNc1T/GgdCKX2Ur5XrP6jZL+Gj/6m6hchr1KJ8WcJyGoZqFOz49U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712401680; c=relaxed/simple;
	bh=0ZsSVu7FwwDeT1dTRsyrltoc6bjWUMxL35uO76l5+RQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IoECcvT1XjqsDnBqFcQSlmN+fXses/xwzU2y5pYaHypO9d5T10vNUINJVQDo9odO8zod40Zvz/np2q+tTbodAE8ISkt7AY0o1rtD4DEtMm6lHFX58k63iY1lc2BUYflGJUKRwEVt71V4LmGBzf4H2h8e6wnKfMOv81E8AVoTczI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aGsZ2T+q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/0ewbai/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 06 Apr 2024 11:07:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712401677;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIZGlFZMVJf16JyvzNlrZhZAIcJu92pRLG0r9frCNmU=;
	b=aGsZ2T+qTuOqbUaTrHBBrGPtpWTT/zrSwFMo0uwauK+7cwuxvwjeJmDGamfduNMVmRQvTj
	mdboHK7mt7SbHUz0fCV4O2JkxHegjhkkKnOD6nnJsqfUzD28QVbbOlHzHAypRVRHWmYlW/
	mcF5HQ8nfznnfX+RgrXzOLOUfz73jI/7zVGBLpsAAkvXGP+loHVW24cf+BV3UQ4ciVRkvy
	Ce38zvps1HOdTyFO0grezy1cXGGbBHiwmvr7KGFfOseXFG1G0YyVLup3ocDstbL45/0I8r
	PeKQWpncRpUtmXdQlYfJYaWknPzj3Vro7spikaCoqNMdhj2oBJPFE6KrQkBrRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712401677;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIZGlFZMVJf16JyvzNlrZhZAIcJu92pRLG0r9frCNmU=;
	b=/0ewbai/UXT6qGINX+Xv4Ur/9D7SxRP+6VhU+FTnvpBjqtMLd/oEfbUkXzOHs8MJ3dLDs5
	qawdN2pgyIPFXHDQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Introduce raw_cpu_read_long() to reduce
 ifdeffery
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240404094218.448963-3-ubizjak@gmail.com>
References: <20240404094218.448963-3-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171240167636.10875.3775749856704912792.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     93cfa544cf9e4771def159002304a2e366cd97af
Gitweb:        https://git.kernel.org/tip/93cfa544cf9e4771def159002304a2e366cd97af
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 04 Apr 2024 11:42:03 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Apr 2024 12:42:17 +02:00

x86/percpu: Introduce raw_cpu_read_long() to reduce ifdeffery

Introduce raw_cpu_read_long() macro to slightly reduce ifdeffery
in <asm/percpu.h>.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240404094218.448963-3-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index d6ff0db..3bedee1 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -59,12 +59,6 @@
 #define __force_percpu_prefix	"%%"__stringify(__percpu_seg)":"
 #define __my_cpu_offset		this_cpu_read(this_cpu_off)
 
-#ifdef CONFIG_X86_64
-#define __raw_my_cpu_offset	raw_cpu_read_8(this_cpu_off);
-#else
-#define __raw_my_cpu_offset	raw_cpu_read_4(this_cpu_off);
-#endif
-
 /*
  * Compared to the generic __my_cpu_offset version, the following
  * saves one instruction and avoids clobbering a temp register.
@@ -76,7 +70,7 @@
 #ifndef BUILD_VDSO32_64
 #define arch_raw_cpu_ptr(_ptr)					\
 ({								\
-	unsigned long tcp_ptr__ = __raw_my_cpu_offset;		\
+	unsigned long tcp_ptr__ = raw_cpu_read_long(this_cpu_off); \
 	tcp_ptr__ += (__force unsigned long)(_ptr);		\
 	(typeof(*(_ptr)) __kernel __force *)tcp_ptr__;		\
 })
@@ -563,9 +557,13 @@ do {									\
 #define this_cpu_xchg_8(pcp, nval)		this_percpu_xchg_op(pcp, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval)
 #define this_cpu_try_cmpxchg_8(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, volatile, pcp, ovalp, nval)
+
+#define raw_cpu_read_long(pcp)		raw_cpu_read_8(pcp)
 #else
 /* There is no generic 64 bit read stable operation for 32 bit targets. */
-#define this_cpu_read_stable_8(pcp)    ({ BUILD_BUG(); (typeof(pcp))0; })
+#define this_cpu_read_stable_8(pcp)	({ BUILD_BUG(); (typeof(pcp))0; })
+
+#define raw_cpu_read_long(pcp)		raw_cpu_read_4(pcp)
 #endif
 
 #define x86_this_cpu_constant_test_bit(_nr, _var)			\

