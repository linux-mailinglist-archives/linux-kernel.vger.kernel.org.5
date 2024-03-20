Return-Path: <linux-kernel+bounces-108868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC33C88111A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A19D1F246E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343FF3EA76;
	Wed, 20 Mar 2024 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4cS2aF01";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lrhykz4Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C7EF9F8;
	Wed, 20 Mar 2024 11:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934763; cv=none; b=f91MvqPlEXKWkIeiabJr0YvPD3LRJvll5y1aqb/jt649nJCv581Z+5DKGM9BSpEOp54B4Zf4J0OtPTHHxsU8F56nLDKHSoCTNY6ISn6/f71zP1r6Vl6qmlgn5Y7xBKYtQAgvqdeiAkNAfyIATxEsQ1aQOfuu10ocfTjwSf4Ix0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934763; c=relaxed/simple;
	bh=jqkItR4wT9GcZzRc3hNh6hJd4rYluNqBTu2a2/JnBSU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=apziW5Iywyx4stg/vJ/Ah8KRSljVr9WebLKP489jcUkYIJxQmTfCift7WQpeKIG3Arpk8Ya8ZsigsQUnuYhPDXpSg0lIgKldyFHHbKUskqGC6OZRKzly3yDM2xd4Wjvn+lol1CDxUDGO35EBA7U2w5jFSp+9/+z7cNnn0a/yRTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4cS2aF01; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lrhykz4Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Mar 2024 11:39:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710934760;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0RIGXNyY9BGocUDDfqdCyOD3A3U0G464OrHQC8qam6M=;
	b=4cS2aF01WVDdWPE7JOka0LvxHBwf6FD3YU82eFcttzcalhLpn/nM2PkKC2DFcLmQs8SvDT
	NB+4gV/9oS0rWBn7dUrqNvGMBJtAcS/kU/Q7fR7PfT6tC2nWPeg0sr74B2fNOXPSB1IdrB
	8fHwMOXjsAwzw+ezSwoH2zVTT6O51QW1VXLVTSo9aiarWsFciPNhHVTCD9BgMKEGzTVe1i
	V7cGMD4xqgelFxPe/bAOytkq2RjmqSjSqV7ik3iw5W7BW0WMDYlVzBDWoZ8PevDEv0u8yz
	QD6fXO47r7Nv08j5H3hHEYDoYev2F+leNY841FTp1SscanPh921urh59I+JSyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710934760;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0RIGXNyY9BGocUDDfqdCyOD3A3U0G464OrHQC8qam6M=;
	b=lrhykz4ZOmGGJmp3nw+qyhs1WT9rQqxc17/r0KPh4agFFqfWFELDGhQ2AXOo/KQYRjxhsP
	oLXQXsnYtLHu7WAw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/percpu] x86/percpu: Move raw_percpu_xchg_op() to a better place
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240320083127.493250-2-ubizjak@gmail.com>
References: <20240320083127.493250-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171093475924.10875.15112548554818833406.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     ce99b9c8daff3352a2ae0c72acf44e0663095fea
Gitweb:        https://git.kernel.org/tip/ce99b9c8daff3352a2ae0c72acf44e0663095fea
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 20 Mar 2024 09:30:41 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 20 Mar 2024 12:29:17 +01:00

x86/percpu: Move raw_percpu_xchg_op() to a better place

Move raw_percpu_xchg_op() together with this_percpu_xchg_op()
and trivially rename some internal variables to harmonize them
between macro implementations.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240320083127.493250-2-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index de991e6..7563e69 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -230,6 +230,17 @@ do {									\
 })
 
 /*
+ * raw_cpu_xchg() can use a load-store since
+ * it is not required to be IRQ-safe.
+ */
+#define raw_percpu_xchg_op(_var, _nval)					\
+({									\
+	typeof(_var) pxo_old__ = raw_cpu_read(_var);			\
+	raw_cpu_write(_var, _nval);					\
+	pxo_old__;							\
+})
+
+/*
  * this_cpu_xchg() is implemented using cmpxchg without a lock prefix.
  * xchg is expensive due to the implied lock prefix. The processor
  * cannot prefetch cachelines if xchg is used.
@@ -499,18 +510,6 @@ do {									\
 #define raw_cpu_or_1(pcp, val)		percpu_to_op(1, , "or", (pcp), val)
 #define raw_cpu_or_2(pcp, val)		percpu_to_op(2, , "or", (pcp), val)
 #define raw_cpu_or_4(pcp, val)		percpu_to_op(4, , "or", (pcp), val)
-
-/*
- * raw_cpu_xchg() can use a load-store since it is not required to be
- * IRQ-safe.
- */
-#define raw_percpu_xchg_op(var, nval)					\
-({									\
-	typeof(var) pxo_ret__ = raw_cpu_read(var);			\
-	raw_cpu_write(var, (nval));					\
-	pxo_ret__;							\
-})
-
 #define raw_cpu_xchg_1(pcp, val)	raw_percpu_xchg_op(pcp, val)
 #define raw_cpu_xchg_2(pcp, val)	raw_percpu_xchg_op(pcp, val)
 #define raw_cpu_xchg_4(pcp, val)	raw_percpu_xchg_op(pcp, val)

