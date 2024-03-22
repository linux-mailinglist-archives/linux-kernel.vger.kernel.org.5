Return-Path: <linux-kernel+bounces-111147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85309886858
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47271C22B94
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DA517998;
	Fri, 22 Mar 2024 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m/GzVnyx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eyxWJYEG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE01BF3D;
	Fri, 22 Mar 2024 08:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096779; cv=none; b=F1EmiCmo0HDk00mpo//a/q6gpjIxrdeCPKAVNjlbVaORpS60hjJlvo12BD4XGxzG+2tWK2EiRkcmbWM9DvaBPV5VEjsRMi795FnogavUaG+pWDJ3UQJGHKHwywm/Zg0nQpc1thkjXd2eVQvTWJi2TNvuNUjV2cr2aRz7EeYfRv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096779; c=relaxed/simple;
	bh=wjX4iW6vPhAL5Q/HrAU+Ppr//9UgV0aTcsI4QPDBVrc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ubRIF3OYlpakxSLq6+ecp+TyjzItRsFKyniGlmU4mEHXOh4ixKwqqFlF7lh7RHm+0DlNt1Yrq8Jl9kf8dyGc8d1o6rMfuX3KXQdIpa9MokQOSgqygjaojmLhw/Teyp9Oj0JmRm7HUYmszWlTPZJIBV1wvsGwQBxEe0gJ85GKq68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m/GzVnyx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eyxWJYEG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Mar 2024 08:39:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711096775;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k9H0AkpxP+aZ/46y0uyxR1w0hSG+NvlkLnsM6ltSG7w=;
	b=m/GzVnyx3HmrMYykRUit7g28nUbrYczWnPUt/102QN9juAkIloxgBNWXfb3k3z/TmjFF3w
	FWuV2wPglwxwqwYjFJyJpC7GzkZ3dEufsgHpgZV44277BHG987TmWH4pqal9AzN63cS98M
	1IEQ7tSpVbjE6KTW+RU9ZpGFBRpO2Sfo0xPtbT5bTpmzJ5TitFHqkTwT5nHGczKoBfFN0A
	5CBoiCrUAa6lj/XIAkb1YKVcOxryr4pqVoLKS+0LZnmTtPhwtfnzw1A89NMFiuir27o1OE
	qX9ovyToJ92PntEDKsahrCMDYSQlOGKOPHv3GjqDwwTLZBjdX0AnZAweGBxslA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711096775;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k9H0AkpxP+aZ/46y0uyxR1w0hSG+NvlkLnsM6ltSG7w=;
	b=eyxWJYEGK+hSqcisv/5T1tX55Lt53wGh4mt9uKWxpNIx++VikZ8+fSXIXK+gAoc2pVrN3Y
	8Lxld5PthLxOzNBg==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86: Rename __{start,end}_init_task to
 __{start,end}_init_stack
Cc: "Xin Li (Intel)" <xin@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Juergen Gross <jgross@suse.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240322081616.3346181-1-xin@zytor.com>
References: <20240322081616.3346181-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171109677435.10875.4562573360831498341.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     8f69cba096b5cfd09be2d06c15d08dbd4a58c9d7
Gitweb:        https://git.kernel.org/tip/8f69cba096b5cfd09be2d06c15d08dbd4a58c9d7
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Fri, 22 Mar 2024 01:16:16 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Mar 2024 09:32:41 +01:00

x86: Rename __{start,end}_init_task to __{start,end}_init_stack

The stack of a task has been separated from the memory of a task_struct
struture for a long time on x86, as a result __{start,end}_init_task no
longer mark the start and end of the init_task structure, but its stack
only.

Rename __{start,end}_init_task to __{start,end}_init_stack.

Note other architectures are not affected because __{start,end}_init_task
are used on x86 only.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20240322081616.3346181-1-xin@zytor.com
---
 arch/x86/kernel/vmlinux.lds.S     | 2 +-
 include/asm-generic/vmlinux.lds.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 91085c3..4c04a36 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -173,7 +173,7 @@ SECTIONS
 		INIT_TASK_DATA(THREAD_SIZE)
 
 		/* equivalent to task_pt_regs(&init_task) */
-		__top_init_kernel_stack = __end_init_task - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE;
+		__top_init_kernel_stack = __end_init_stack - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE;
 
 #ifdef CONFIG_X86_32
 		/* 32 bit has nosave before _edata */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f7749d0..8708243 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -399,13 +399,13 @@
 
 #define INIT_TASK_DATA(align)						\
 	. = ALIGN(align);						\
-	__start_init_task = .;						\
+	__start_init_stack = .;						\
 	init_thread_union = .;						\
 	init_stack = .;							\
 	KEEP(*(.data..init_task))					\
 	KEEP(*(.data..init_thread_info))				\
-	. = __start_init_task + THREAD_SIZE;				\
-	__end_init_task = .;
+	. = __start_init_stack + THREAD_SIZE;				\
+	__end_init_stack = .;
 
 #define JUMP_TABLE_DATA							\
 	. = ALIGN(8);							\

