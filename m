Return-Path: <linux-kernel+bounces-149760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EABE88A9582
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638E71F21B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B907A15B112;
	Thu, 18 Apr 2024 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tJwwBFsN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9qCIBcLw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF2615AAA8;
	Thu, 18 Apr 2024 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430751; cv=none; b=boAxutmh2R+CYuOfPkiNVxWBlEBm0W56mpUcuYRVfqfw6nCPhbxvIXrJ0piZjRosDH986idKjl0U0x3Q69zFr50NP7cD/tq5zloAoKamaGdb7iMJgQm5GRKmezl4XpnzVWA2G46kg/KetLWq18AQVsdqflVjV+JLZLKVlg5Zy3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430751; c=relaxed/simple;
	bh=ZEsPCpG7/bePMkAti19PTun4xE4R1F48IXuZVXgQlZU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Oqc6zWrJALiFS9lpmOVOL+YX5ZJX/jG5fHn7Yi8Cu2ZzFmSyl8zltbetNWKXZU/1VOD3UOiBeQ4HjktH8E5cgjE+fpGCo05UhUqVGfsKAbB8KFimaP4bANtVpKeh6L+NveuH40/YC5bLc8UlApTK2whtVG1QUQzsLV42xdLiw2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tJwwBFsN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9qCIBcLw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Apr 2024 08:59:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713430747;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3DzCTW/rvviKfEef1seIKYEq7DyCVwKK623GNOwOcOY=;
	b=tJwwBFsNXoRUv4mP1ju3vaeExsLeiwwuW6uNnk3N6uxyI+YBMD7EAHxljQSt6O25RmnP3i
	Bg/dDe6M2OVHxC9PwiXD5xXZsZFOhxJgbli56mYa0J6S+CA1o3jJtSEud8IvzMd6Vw8783
	80JuzTQN9tvOmXdprca6vfLrnOn+swHPYEDZOqNZoFTpoHAn76wg5+qwcKrmUf8PQ0jHik
	FJXHKy7PhzBwb0IsVil5d2TCT15Ov36hawmw3lhAaPgT9FfMHflFtwdAhbZfpMKle8Yg4G
	w2Uph8yWsg+qfo+IQ9CGNnDyMhpAK+IGrxnR7aRzjlBEZIAt6oaovmr983V1AQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713430747;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3DzCTW/rvviKfEef1seIKYEq7DyCVwKK623GNOwOcOY=;
	b=9qCIBcLwAwTdk3oRYLAg7LuXTbthwCq77C5td+QR16SKVW6n/7jc8w5UqD7+gW+hSQCog5
	QTyGm6MKbo4bxkCA==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fred: Fix INT80 emulation for FRED
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, "Xin Li (Intel)" <xin@zytor.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240417174731.4189592-1-xin@zytor.com>
References: <20240417174731.4189592-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171343074673.10875.6611903314262261610.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     32f5f73b79ffdef215e2e1bcb6ad74387c0f925c
Gitweb:        https://git.kernel.org/tip/32f5f73b79ffdef215e2e1bcb6ad74387c0f925c
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Wed, 17 Apr 2024 10:47:31 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 18 Apr 2024 10:37:11 +02:00

x86/fred: Fix INT80 emulation for FRED

Add a FRED-specific INT80 handler and document why it differs from the
current one. Eventually, the common bits will be unified once FRED hw is
available and it turns out that no further changes are needed but for
now, keep the handlers separate for everyone's sanity's sake.

  [ bp: Zap duplicated commit message, massage. ]

Fixes: 55617fb991df ("x86/entry: Do not allow external 0x80 interrupts")
Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240417174731.4189592-1-xin@zytor.com
---
 arch/x86/entry/common.c     | 65 ++++++++++++++++++++++++++++++++++++-
 arch/x86/entry/entry_fred.c |  2 +-
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6de50b8..51cc9c7 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -255,6 +255,71 @@ __visible noinstr void do_int80_emulation(struct pt_regs *regs)
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
 }
+
+#ifdef CONFIG_X86_FRED
+/*
+ * A FRED-specific INT80 handler is warranted for the follwing reasons:
+ *
+ * 1) As INT instructions and hardware interrupts are separate event
+ *    types, FRED does not preclude the use of vector 0x80 for external
+ *    interrupts. As a result, the FRED setup code does not reserve
+ *    vector 0x80 and calling int80_is_external() is not merely
+ *    suboptimal but actively incorrect: it could cause a system call
+ *    to be incorrectly ignored.
+ *
+ * 2) It is called only for handling vector 0x80 of event type
+ *    EVENT_TYPE_SWINT and will never be called to handle any external
+ *    interrupt (event type EVENT_TYPE_EXTINT).
+ *
+ * 3) FRED has separate entry flows depending on if the event came from
+ *    user space or kernel space, and because the kernel does not use
+ *    INT insns, the FRED kernel entry handler fred_entry_from_kernel()
+ *    falls through to fred_bad_type() if the event type is
+ *    EVENT_TYPE_SWINT, i.e., INT insns. So if the kernel is handling
+ *    an INT insn, it can only be from a user level.
+ *
+ * 4) int80_emulation() does a CLEAR_BRANCH_HISTORY. While FRED will
+ *    likely take a different approach if it is ever needed: it
+ *    probably belongs in either fred_intx()/ fred_other() or
+ *    asm_fred_entrypoint_user(), depending on if this ought to be done
+ *    for all entries from userspace or only system
+ *    calls.
+ *
+ * 5) INT $0x80 is the fast path for 32-bit system calls under FRED.
+ */
+DEFINE_FREDENTRY_RAW(int80_emulation)
+{
+	int nr;
+
+	enter_from_user_mode(regs);
+
+	instrumentation_begin();
+	add_random_kstack_offset();
+
+	/*
+	 * FRED pushed 0 into regs::orig_ax and regs::ax contains the
+	 * syscall number.
+	 *
+	 * User tracing code (ptrace or signal handlers) might assume
+	 * that the regs::orig_ax contains a 32-bit number on invoking
+	 * a 32-bit syscall.
+	 *
+	 * Establish the syscall convention by saving the 32bit truncated
+	 * syscall number in regs::orig_ax and by invalidating regs::ax.
+	 */
+	regs->orig_ax = regs->ax & GENMASK(31, 0);
+	regs->ax = -ENOSYS;
+
+	nr = syscall_32_enter(regs);
+
+	local_irq_enable();
+	nr = syscall_enter_from_user_mode_work(regs, nr);
+	do_syscall_32_irqs_on(regs, nr);
+
+	instrumentation_end();
+	syscall_exit_to_user_mode(regs);
+}
+#endif
 #else /* CONFIG_IA32_EMULATION */
 
 /* Handles int $0x80 on a 32bit kernel */
diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index ac120cb..9fa18b8 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -66,7 +66,7 @@ static noinstr void fred_intx(struct pt_regs *regs)
 	/* INT80 */
 	case IA32_SYSCALL_VECTOR:
 		if (ia32_enabled())
-			return int80_emulation(regs);
+			return fred_int80_emulation(regs);
 		fallthrough;
 #endif
 

