Return-Path: <linux-kernel+bounces-108845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C338810D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F43285A7E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F783CF6A;
	Wed, 20 Mar 2024 11:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c+TwO0ay";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DbcbzFVC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CB13D3BB;
	Wed, 20 Mar 2024 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933738; cv=none; b=urZr/zqseJ4479jQkkTXjPtEmKrfXtd7M3xive95VwPL+cczfYXlPWtPMETjiWEDDKz1Za6WmH4cP60JYRvBlunJpLoCgr+R44qOUpKy+Ef5nqX+8N44Cur/VZSXcsi08AzjkTW32NEdWITgXmwuOj/gGfFyFcYXY6j5dHuAIAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933738; c=relaxed/simple;
	bh=UXgCArGKXHVqCfjtqA+zJPjn0dFKXtMy5QTeNDn8G70=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GFGNB9iOMHFQyTKoEHFlS0CiR9EoCVXyh5z9YK94PCh7cR8FBeWwVx6jEfelYT/52lJu8J434sgKdn2LiOo/j0dRvoaVg4QhbGa/XOgWG4nsCHMJuPeysVz23SHTK11fZOhOZ/fUpmCMCvRzFz2hVFKIkRPRXWWV7aYkC1STtbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c+TwO0ay; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DbcbzFVC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Mar 2024 11:22:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710933735;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28N+oRLmcfmsL9js08rqhBhA0pbBtGmoJ8kzoNGv+eE=;
	b=c+TwO0ayynCwqK187WzpjmhHFKYPQxPTc0zVYiCIpi96nUYOERk7oDaIcT/qcbH5+RubTY
	TAgQvKnQneEm5m4tl95cC0HC7CTySv5zM52yhCarecwFPcN/H8tpi894+89RLpo21muhmN
	2CjhlDgRd5JjGirF1R76lpOWcHe0sA7PnoJkPAR3ck7yITO4kjypHTiAAYy5YX7OJuDPtK
	tS2U1rB5QAS2RWJgPZx52+ua4wbMQG2RVN08ZveBsN25VgumRCB3ofQAMaF4OnIcD3MBS5
	EcQcvI3oGOCHzNjcu5GzLGgSqml/s6Ic+j4jhlEgLwyhC6+3rIqYQg7yvV08lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710933735;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28N+oRLmcfmsL9js08rqhBhA0pbBtGmoJ8kzoNGv+eE=;
	b=DbcbzFVCa6Bbw/LjrwUXZVmkEwlM0wV1WgTPx93cANKOF+3WJAoAiRCcR23vC7hICt/7z9
	U+5bZf/mWamUP7CQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/percpu] x86/percpu: Move raw_percpu_xchg_op() to a better place
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240320083127.493250-2-ubizjak@gmail.com>
References: <20240320083127.493250-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171093373429.10875.782495497583129324.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     733b3d4dfa6c6b55885e77f1982ef5edc2023d21
Gitweb:        https://git.kernel.org/tip/733b3d4dfa6c6b55885e77f1982ef5edc2023d21
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 20 Mar 2024 09:30:41 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 20 Mar 2024 12:08:11 +01:00

x86/percpu: Move raw_percpu_xchg_op() to a better place

Move raw_percpu_xchg_op() together with this_percpu_xchg_op()
and trivially rename some internal variables to harmonize them
between macro implementations.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

