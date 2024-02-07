Return-Path: <linux-kernel+bounces-56562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A14C84CBC8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3D8286171
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B46C78B6B;
	Wed,  7 Feb 2024 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1XG67EOg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="03YKrbAF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F577F14
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313278; cv=none; b=GQ4C4MttD73zn1PWTRCmwM/yEQPNZX6W9C7wkDKJqJ/t3o8eJpWkbXGJcJKnmEymWqEIkqxRA6BzwfRwRWfqXedfw36RNiuVvUyEDdTSquKlpogMcYDuk18Gp0lWpAt0OmN8zWJ/SVXThDtJLsFd8zULZNIvd1U2qp6whw6Mihs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313278; c=relaxed/simple;
	bh=GQCehcL6yhboRMDP0y/MXe78eGzvs0hF3ziXNMfK9rw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d2XKPkcdjlgA3BfBJW8OmWkkI+ftVHD1bmjZmEZeyYOVb4Se3FI/MT2qVz6WCkxri3gVKb6pP+KaEJSf6kwnBP+/4HwOyCOOW/LczGyAxG5TXCxH9/A5AhkoBklnk4Ebm2ii/51VsTbKTH8GAmK8jSerUWgei/ZvIhcHkg/cZ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1XG67EOg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=03YKrbAF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707313274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hMI7qkQLotY/selAHG10OOY1svS/SpGuuqTiSxMDtnw=;
	b=1XG67EOg5kbZJ+oMrdcK6eXfeRTnhvIhtEryVT/AU1249nJWNYTwhpMRTAxYuWfl08drRl
	2a62Zw0ykAeBX4qNl4cE09KfPDvRQ32LJw3py83pFE3+kZwveE9cIudS1sEva/TYRmJqAL
	GUaNc7RQN3Wgz2RU+W02OiD6c1eIzZaPaVsiC3GAFpXvoXVfs0TjaS0kLkgJ0bjZCOJi0S
	9epYTlrM60GYG4pgc7r4jL0+5yBzJ0L4rijnPxJheNF0IbYnlOrKCY1ckYIdjsTnb/hrQM
	2sUgEmcS0Fyo0QPQWH7jPOGq17K8eP+BO1gcvE1Ps8x7dGbfBkRVqhnSqw7JRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707313274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hMI7qkQLotY/selAHG10OOY1svS/SpGuuqTiSxMDtnw=;
	b=03YKrbAFKwGaONJprswAKsS54u/aCmhX38LAqldWggW2SvwTYy17/nHb/AR7Ft6Zio8bdZ
	0yMr+GEQusrMtPBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Francesco Dolcini <francesco@dolcini.it>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH printk v4 02/14] printk: Adjust mapping for 32bit seq macros
Date: Wed,  7 Feb 2024 14:46:51 +0106
Message-Id: <20240207134103.1357162-3-john.ogness@linutronix.de>
In-Reply-To: <20240207134103.1357162-1-john.ogness@linutronix.de>
References: <20240207134103.1357162-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Note: This change only applies to 32bit architectures. On 64bit
      architectures the macros are NOPs.

__ulseq_to_u64seq() computes the upper 32 bits of the passed
argument value (@ulseq). The upper bits are derived from a base
value (@rb_next_seq) in a way that assumes @ulseq represents a
64bit number that is less than or equal to @rb_next_seq.

Until now this mapping has been correct for all call sites. However,
in a follow-up commit, values of @ulseq will be passed in that are
higher than the base value. This requires a change to how the 32bit
value is mapped to a 64bit sequence number.

Rather than mapping @ulseq such that the base value is the end of a
32bit block, map @ulseq such that the base value is in the middle of
a 32bit block. This allows supporting 31 bits before and after the
base value, which is deemed acceptable for the console sequence
number during runtime.

Here is an example to illustrate the previous and new mappings.

For a base value (@rb_next_seq) of 2 2000 0000...

Before this change the range of possible return values was:

1 2000 0001 to 2 2000 0000

__ulseq_to_u64seq(1fff ffff) => 2 1fff ffff
__ulseq_to_u64seq(2000 0000) => 2 2000 0000
__ulseq_to_u64seq(2000 0001) => 1 2000 0001
__ulseq_to_u64seq(9fff ffff) => 1 9fff ffff
__ulseq_to_u64seq(a000 0000) => 1 a000 0000
__ulseq_to_u64seq(a000 0001) => 1 a000 0001

After this change the range of possible return values are:

1 a000 0001 to 2 a000 0000

__ulseq_to_u64seq(1fff ffff) => 2 1fff ffff
__ulseq_to_u64seq(2000 0000) => 2 2000 0000
__ulseq_to_u64seq(2000 0001) => 2 2000 0001
__ulseq_to_u64seq(9fff ffff) => 2 9fff ffff
__ulseq_to_u64seq(a000 0000) => 2 a000 0000
__ulseq_to_u64seq(a000 0001) => 1 a000 0001

[ john.ogness: Rewrite commit message. ]

Reported-by: Francesco Dolcini <francesco@dolcini.it>
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk_ringbuffer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index b82a96dc2ea2..12f60c782e46 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -407,7 +407,7 @@ static inline u64 __ulseq_to_u64seq(struct printk_ringbuffer *rb, u32 ulseq)
 	 * Also the access to the ring buffer is always safe.
 	 */
 	rb_next_seq = prb_next_seq(rb);
-	seq = rb_next_seq - ((u32)rb_next_seq - ulseq);
+	seq = rb_next_seq - (s32)((u32)rb_next_seq - ulseq);
 
 	return seq;
 }
-- 
2.39.2


