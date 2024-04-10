Return-Path: <linux-kernel+bounces-138648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E37A89F8B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A31FB2DD49
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BCF16131C;
	Wed, 10 Apr 2024 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rrwJUMSq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tXtZWY5N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EF415ECFD;
	Wed, 10 Apr 2024 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756448; cv=none; b=IYGZPgpZsSHrjuCSaDg+wVsbpWi04g7RVuPxVjeCM8BGyWnkX0VQ24By8a/E+Seat3Rt+gDA2tyfPgbIheUWQhegvZ9UAUjMcQxZDNnMfHDGHEW7P3WF1ffpT1cEDSFv7nshaYK/9luPi1Hez+7QDvc1gN4oYfyo11fsOxNHJCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756448; c=relaxed/simple;
	bh=Uka8o22NlM8PwJyIfHYqHnihMi8oLfrnhZ2gZYikHTM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=STr5UX7nA1SRqAk4ILgxW4YgfUsYzp3/3kx9b5iUvsdSzZc55g1H4ZEMdFKWA6k2R8JT7FCPV7foTrljV4mqiot+sgrQF1x21BSs7rlvCEbbCIAxrzv56QGf1ECLFWQi1BKd7iZBKo7PGsohjAL9CiG3OJ3iiBom4XtAnqkgsr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rrwJUMSq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tXtZWY5N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 13:40:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712756444;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMhJgy48U8xArHHRNmuKI/ZW03PB0fR9F3j3M9Dq+KA=;
	b=rrwJUMSqbnHL54uFzz01AcpqOoJaArgGFWf0a/M4vYqj72eXcHjzoVJzCpP1GOg+cg50Yt
	Oe5+ZYlCdLQv2UbH5Vgjjfh27C49vrD/kDsUWdu8XuoMFwJSn4RgRIDaMq9HrB3gKgGNkZ
	jf27GYh2lIkIkdp2fX4XN4Dh3QUgDYIJ/pnCh+UvImGt+0WbRtMZ/SjcTCOFzH6+bP02gQ
	XoCWskXgC0Sq6W2qScHfyfbzxohYkBp4/e35hNv3Sgu4Wlao/+2qOKZ5uYQIPKP7tOtPwP
	4yaS6+gC5NTpPAWbnhXMoGCpmsFUQuI4r+8V3l3JasgrEHWGd8mrfpBDRqkwCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712756444;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMhJgy48U8xArHHRNmuKI/ZW03PB0fR9F3j3M9Dq+KA=;
	b=tXtZWY5NzlYFawxwLZdw5ZoU/DKsaCq/A3x7DJUeVa089M08QmvuyFnfjSvUR57+9Ts4bo
	nWyCWn63Gh6Sr+DQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic/x86: Introduce
 arch_atomic64_read_nonatomic() to x86_32
Cc: Mark Rutland <mark.rutland@arm.com>, Uros Bizjak <ubizjak@gmail.com>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240410062957.322614-2-ubizjak@gmail.com>
References: <20240410062957.322614-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171275644380.10875.3875613605552134894.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e73c4e34a0e9e3dfcb4e5ee4ccd3039a7b603218
Gitweb:        https://git.kernel.org/tip/e73c4e34a0e9e3dfcb4e5ee4ccd3039a7b603218
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 10 Apr 2024 08:29:34 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Apr 2024 15:04:54 +02:00

locking/atomic/x86: Introduce arch_atomic64_read_nonatomic() to x86_32

Introduce arch_atomic64_read_nonatomic() for 32-bit targets to load
the value from atomic64_t location in a non-atomic way. This
function is intended to be used in cases where a subsequent atomic
operation will handle the torn value, and can be used to prime the
first iteration of unconditional try_cmpxchg() loops.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240410062957.322614-2-ubizjak@gmail.com
---
 arch/x86/include/asm/atomic64_32.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index ec217aa..bbdf174 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -14,6 +14,32 @@ typedef struct {
 
 #define ATOMIC64_INIT(val)	{ (val) }
 
+/*
+ * Read an atomic64_t non-atomically.
+ *
+ * This is intended to be used in cases where a subsequent atomic operation
+ * will handle the torn value, and can be used to prime the first iteration
+ * of unconditional try_cmpxchg() loops, e.g.:
+ *
+ * 	s64 val = arch_atomic64_read_nonatomic(v);
+ * 	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val OP i);
+ *
+ * This is NOT safe to use where the value is not always checked by a
+ * subsequent atomic operation, such as in conditional try_cmpxchg() loops
+ * that can break before the atomic operation, e.g.:
+ *
+ * 	s64 val = arch_atomic64_read_nonatomic(v);
+ * 	do {
+ * 		if (condition(val))
+ * 			break;
+ * 	} while (!arch_atomic64_try_cmpxchg(v, &val, val OP i);
+ */
+static __always_inline s64 arch_atomic64_read_nonatomic(const atomic64_t *v)
+{
+	/* See comment in arch_atomic_read(). */
+	return __READ_ONCE(v->counter);
+}
+
 #define __ATOMIC64_DECL(sym) void atomic64_##sym(atomic64_t *, ...)
 #ifndef ATOMIC64_EXPORT
 #define ATOMIC64_DECL_ONE __ATOMIC64_DECL

