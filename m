Return-Path: <linux-kernel+bounces-116921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2273688A522
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB581F379C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F164619DF7D;
	Mon, 25 Mar 2024 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ufjKNn5a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zXRMY86j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D4F13F450;
	Mon, 25 Mar 2024 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365163; cv=none; b=mVYUx60RKaO7UITmNt9mPeXLmYy6OXinyOYotDsQIPXRQvoAmDTEDkYp96Agy5LMS++kJJ/xG3Zv6/Oad7VZxTKpuNmrrbV4C9sEISAq3nclWkBttfT13ilnw76Z45tUnleBypaaGu0vlenGW0t8TXKmcVHpwZiPXc62Pao1Wws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365163; c=relaxed/simple;
	bh=/nLbfNN0ipKFWk82Fr2MEYp8hRp7jP/GzVTL6jLAI2c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MTc6PKFldv6jOgK8iUDpfimEQwNkJsCmTzyKjYM5W2OemrYbuVr0LSEppozG7tK+R9tItHILYc5OUN0ICHFIoj2Cn3YNZZJSRuIzbNPa6lFIivUMiJvUV44aY7HkP24wPXdZ1oOgFDp88FcrY2ynU9/cJEsQnMpqV4CRRq1BNKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ufjKNn5a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zXRMY86j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 11:12:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711365158;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRmVAtwJTzTwGTVTKkZMZKpyrGK3ZS86YzTVXgqpH5w=;
	b=ufjKNn5aUQ/mTt/Che6qPAWzE9Y4We9NjtZeQl5ZHYr8fup/EVEGR33So/E/AAc0dZOght
	+NsTBoi7KODfBLb4aDDk7r9Ol60pfaJJtuG5sZoYzOyhNZzJjsrWnOChcIYpdlTlSt5WX5
	eCWMt5yNG+XsoLPexfH2wQDmk+ZvK2HwlEJ6UleosDsL3NoAyZJDzWMoFuzot8g/0GF+EY
	JYVSbx3EmDWOwr5AXNrhZFqjtCAQrSCTMfNwHuaEMX86TmnwXgZLI/Z2SNPs4/lkN3UA/B
	hYtZonH9KzYfI4ETdQ4+vqY7VF4MT6MyPz2DdlQkYlJ1VdJMsFziP21UiFo+4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711365158;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRmVAtwJTzTwGTVTKkZMZKpyrGK3ZS86YzTVXgqpH5w=;
	b=zXRMY86jspY49RJ+YT0zrEm68OWdowijsutkVjOszvPFfzuY1RDWz3sABfZgt/EuQTXl1i
	dY70fZBqg0iIE1CQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Do not use this_cpu_read_stable_8() for
 32-bit targets
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240324212014.310189-1-ubizjak@gmail.com>
References: <20240324212014.310189-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171136515796.10875.14770508158283664685.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     b90169b42a6f49ff2fe2e4d4ed0bbcf17fb8f1bf
Gitweb:        https://git.kernel.org/tip/b90169b42a6f49ff2fe2e4d4ed0bbcf17fb8f1bf
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Sun, 24 Mar 2024 22:19:45 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 Mar 2024 12:03:45 +01:00

x86/percpu: Do not use this_cpu_read_stable_8() for 32-bit targets

this_cpu_read_stable() macro uses __pcpu_size_call_return()
that unconditionally calls this_cpu_read_stable_8() also for
32-bit targets. This usage is ivalid as it will result in the
generation of 64-bit MOVQ instruction on 32-bit targets via
percpu_stable_op() macro.

Since there is no generic support for this_cpu_read_stable_8() for
32-bit targets, the patch defines this_cpu_read_stable_8() to
BUILD_BUG() when CONFIG_X86_64 is not defined. This way, we are
sure that this_cpu_read_stable_8() won't actually be used for
32-bit targets, but it is still defined to prevent build failure.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20240324212014.310189-1-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index f6ddbaa..1f6404e 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -423,10 +423,6 @@ do {									\
  * actually per-thread variables implemented as per-CPU variables and
  * thus stable for the duration of the respective task.
  */
-#define this_cpu_read_stable_1(pcp)	percpu_stable_op(1, "mov", pcp)
-#define this_cpu_read_stable_2(pcp)	percpu_stable_op(2, "mov", pcp)
-#define this_cpu_read_stable_4(pcp)	percpu_stable_op(4, "mov", pcp)
-#define this_cpu_read_stable_8(pcp)	percpu_stable_op(8, "mov", pcp)
 #define this_cpu_read_stable(pcp)	__pcpu_size_call_return(this_cpu_read_stable_, pcp)
 
 #ifdef CONFIG_USE_X86_SEG_SUPPORT
@@ -495,6 +491,10 @@ do {									\
 #define this_cpu_read_const(pcp)	({ BUILD_BUG(); (typeof(pcp))0; })
 #endif /* CONFIG_USE_X86_SEG_SUPPORT */
 
+#define this_cpu_read_stable_1(pcp)	percpu_stable_op(1, "mov", pcp)
+#define this_cpu_read_stable_2(pcp)	percpu_stable_op(2, "mov", pcp)
+#define this_cpu_read_stable_4(pcp)	percpu_stable_op(4, "mov", pcp)
+
 #define raw_cpu_add_1(pcp, val)		percpu_add_op(1, , (pcp), val)
 #define raw_cpu_add_2(pcp, val)		percpu_add_op(2, , (pcp), val)
 #define raw_cpu_add_4(pcp, val)		percpu_add_op(4, , (pcp), val)
@@ -546,6 +546,8 @@ do {									\
  * 32 bit must fall back to generic operations.
  */
 #ifdef CONFIG_X86_64
+#define this_cpu_read_stable_8(pcp)	percpu_stable_op(8, "mov", pcp)
+
 #define raw_cpu_add_8(pcp, val)			percpu_add_op(8, , (pcp), val)
 #define raw_cpu_and_8(pcp, val)			percpu_to_op(8, , "and", (pcp), val)
 #define raw_cpu_or_8(pcp, val)			percpu_to_op(8, , "or", (pcp), val)
@@ -561,6 +563,9 @@ do {									\
 #define this_cpu_xchg_8(pcp, nval)		this_percpu_xchg_op(pcp, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval)
 #define this_cpu_try_cmpxchg_8(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, volatile, pcp, ovalp, nval)
+#else
+/* There is no generic 64 bit read stable operation for 32 bit targets. */
+#define this_cpu_read_stable_8(pcp)    ({ BUILD_BUG(); (typeof(pcp))0; })
 #endif
 
 static __always_inline bool x86_this_cpu_constant_test_bit(unsigned int nr,

