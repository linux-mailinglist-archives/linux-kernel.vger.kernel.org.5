Return-Path: <linux-kernel+bounces-111336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E799886AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB0E1C22201
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0FD3F8F7;
	Fri, 22 Mar 2024 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g7xSHxCi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K32R0Kag"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3C63F9C7;
	Fri, 22 Mar 2024 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105164; cv=none; b=mL6h4ugnxZztsOCvb6NzgN0XzllUfEcG6kSF/9DHlrii5WBmU1jwqbEvKLseI8ckMbOPmV3tww4ZS5OPXJjb7oSDVslkCZsMF88/XtsCaK1m5xZhKU6owsvnHZivkUdoG8euZInW+YJ4DBgtAaxcJwlFe463iE4ELVK5K3E4vRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105164; c=relaxed/simple;
	bh=oP9af5cniF5p3gxbjXvqLtOL4dq5x8JKZhk0IbRuazE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qjWRe27G19lYMpLXQnXEQzlLy0ez7FZ51TsPZHXP0Aa/oQ5TAqs+4Fkyf1kMw/ceD1jg9kReiLGTm3gi0t+14vsXCu1MMIHKGBP8kE275HN+sPaOP/H6ht7VTE4TGrUQu8B4JshzVK9xeunKBeohLyBkKm3maUlLFIP4f+orJvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g7xSHxCi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K32R0Kag; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Mar 2024 10:59:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711105160;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRim6UUbWRNh7EONqTeNK/OtRjMbw8SQJ84ILN6n3Nk=;
	b=g7xSHxCiMBUnzzRuARnHtu/mNVS9vPVXtHTkpod1i+CVtICssNyzkDSVhOtnVwUJaSaPOE
	OvhoSc+uXGnUKbV67hHr60pV4xwzXVO2pDvAp0VRwa4vbppB5XBqx91wkXfUBv1ZUpC7Kc
	QcpLqG9gUXfMhfxwFrUsHShONJj1yMdRwcBcPogExeMbhoLAf9rVYu3smMiCAh9r13pbtL
	H10GbUF1T0RjTiP8Osj8O6PZtaek02kj9K0IQZMuJlJ0WYqSKzLTQRW3/CTT5922NA3iDH
	iomQE9lPX+16bDincCMaQBqqT1jRgmhlrbTPyFPYlO9XzTHiuRkt5PFYCRRNng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711105160;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRim6UUbWRNh7EONqTeNK/OtRjMbw8SQJ84ILN6n3Nk=;
	b=K32R0KagLm5QKck5xSuUyGqnLV0u166lw1fy8+kpqoDmYxGwrGKOlYf371PyvZlbn2Kdwv
	gJ5iezYoj2HdyVCQ==
From: "tip-bot2 for Anton Altaparmakov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/pm: Work around false positive kmemleak report
 in msr_build_context()
Cc: Anton Altaparmakov <anton@tuxera.com>, Ingo Molnar <mingo@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, stable@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240314142656.17699-1-anton@tuxera.com>
References: <20240314142656.17699-1-anton@tuxera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171110515988.10875.8051105643716026412.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e3f269ed0accbb22aa8f25d2daffa23c3fccd407
Gitweb:        https://git.kernel.org/tip/e3f269ed0accbb22aa8f25d2daffa23c3fccd407
Author:        Anton Altaparmakov <anton@tuxera.com>
AuthorDate:    Thu, 14 Mar 2024 14:26:56 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Mar 2024 11:01:31 +01:00

x86/pm: Work around false positive kmemleak report in msr_build_context()

Since:

  7ee18d677989 ("x86/power: Make restore_processor_context() sane")

kmemleak reports this issue:

  unreferenced object 0xf68241e0 (size 32):
    comm "swapper/0", pid 1, jiffies 4294668610 (age 68.432s)
    hex dump (first 32 bytes):
      00 cc cc cc 29 10 01 c0 00 00 00 00 00 00 00 00  ....)...........
      00 42 82 f6 cc cc cc cc cc cc cc cc cc cc cc cc  .B..............
    backtrace:
      [<461c1d50>] __kmem_cache_alloc_node+0x106/0x260
      [<ea65e13b>] __kmalloc+0x54/0x160
      [<c3858cd2>] msr_build_context.constprop.0+0x35/0x100
      [<46635aff>] pm_check_save_msr+0x63/0x80
      [<6b6bb938>] do_one_initcall+0x41/0x1f0
      [<3f3add60>] kernel_init_freeable+0x199/0x1e8
      [<3b538fde>] kernel_init+0x1a/0x110
      [<938ae2b2>] ret_from_fork+0x1c/0x28

Which is a false positive.

Reproducer:

  - Run rsync of whole kernel tree (multiple times if needed).
  - start a kmemleak scan
  - Note this is just an example: a lot of our internal tests hit these.

The root cause is similar to the fix in:

  b0b592cf0836 x86/pm: Fix false positive kmemleak report in msr_build_context()

ie. the alignment within the packed struct saved_context
which has everything unaligned as there is only "u16 gs;" at start of
struct where in the past there were four u16 there thus aligning
everything afterwards.  The issue is with the fact that Kmemleak only
searches for pointers that are aligned (see how pointers are scanned in
kmemleak.c) so when the struct members are not aligned it doesn't see
them.

Testing:

We run a lot of tests with our CI, and after applying this fix we do not
see any kmemleak issues any more whilst without it we see hundreds of
the above report. From a single, simple test run consisting of 416 individual test
cases on kernel 5.10 x86 with kmemleak enabled we got 20 failures due to this,
which is quite a lot. With this fix applied we get zero kmemleak related failures.

Fixes: 7ee18d677989 ("x86/power: Make restore_processor_context() sane")
Signed-off-by: Anton Altaparmakov <anton@tuxera.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240314142656.17699-1-anton@tuxera.com
---
 arch/x86/include/asm/suspend_32.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
index a800abb..d8416b3 100644
--- a/arch/x86/include/asm/suspend_32.h
+++ b/arch/x86/include/asm/suspend_32.h
@@ -12,11 +12,6 @@
 
 /* image of the saved processor state */
 struct saved_context {
-	/*
-	 * On x86_32, all segment registers except gs are saved at kernel
-	 * entry in pt_regs.
-	 */
-	u16 gs;
 	unsigned long cr0, cr2, cr3, cr4;
 	u64 misc_enable;
 	struct saved_msrs saved_msrs;
@@ -27,6 +22,11 @@ struct saved_context {
 	unsigned long tr;
 	unsigned long safety;
 	unsigned long return_address;
+	/*
+	 * On x86_32, all segment registers except gs are saved at kernel
+	 * entry in pt_regs.
+	 */
+	u16 gs;
 	bool misc_enable_saved;
 } __attribute__((packed));
 

