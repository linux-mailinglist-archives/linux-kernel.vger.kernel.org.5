Return-Path: <linux-kernel+bounces-121110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE8788E3DD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82EA0B2C8DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CDE17108D;
	Wed, 27 Mar 2024 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsT7D7V3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217A1171640;
	Wed, 27 Mar 2024 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542107; cv=none; b=mU9y6xIkJunoFSlFY5B+9wHuwAdMq3EOv8al20A0rzGokxGKfK7kSb3wu61levVk/alg70P4ebhmdvS9rygbxoC3KJdTo4j1Ut49YcbB84YVfPejhmMDNCxG6pLQCidfNm5yXg/e868fKX/RcQv2Si6FM+nJilrFzGR5lbMPmnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542107; c=relaxed/simple;
	bh=IsRoMauX6XuP6xXjrNy5AIgQyoyyA53paEbXLm6oM+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hUIDXt/pa24Hyhx6c6p3ZlS4Dth9RAgcKTCnO9SZIArRX/vrjy0WBYOwIPbSwomiiP3pJJOP5xXRuhGKcJTvMVOUCuC0VpBAwe9AK8vzkAQtKxm1aYNIqvpgv4LSnSItRXLw5BVHaR9cpa10p0FcMFugXa1g6X8ixGVaOrHXSFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsT7D7V3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2D8C433C7;
	Wed, 27 Mar 2024 12:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542106;
	bh=IsRoMauX6XuP6xXjrNy5AIgQyoyyA53paEbXLm6oM+M=;
	h=From:To:Cc:Subject:Date:From;
	b=FsT7D7V3BQFSqXzKrnSOq3s9jqASdDSF68yJ6gBEPdsTOu1iE9HujDo08fvx3PghE
	 W4SgY4bICMURXAbUBu9fUGolh68iH2wxJGsqnab53B0ojl7OyxYksFcr4cEQX5cSJy
	 SQDVUEpDyUczJodQi5SxPbNd1bt5wgQKl0D4ugLUDRlbiLcI5Zsa7O6/ebjgiX7vRh
	 7jQrAPsl5h8ATIh/qQaztc0ii/+pUYwfiTDFbty4wLmA14K2+VfhwSUeLsL473s5CG
	 JeaYk9nU8wE0waq0ECsidflFdekWF9opJHlZq4DjAt6BOwV/1PRnOLGftbDTilMwRY
	 Lo1UYGafmLrvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anton@tuxera.com
Cc: Ingo Molnar <mingo@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "x86/pm: Work around false positive kmemleak report in msr_build_context()" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:21:44 -0400
Message-ID: <20240327122144.2837099-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e3f269ed0accbb22aa8f25d2daffa23c3fccd407 Mon Sep 17 00:00:00 2001
From: Anton Altaparmakov <anton@tuxera.com>
Date: Thu, 14 Mar 2024 14:26:56 +0000
Subject: [PATCH] x86/pm: Work around false positive kmemleak report in
 msr_build_context()

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
index a800abb1a9925..d8416b3bf832e 100644
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
 
-- 
2.43.0





