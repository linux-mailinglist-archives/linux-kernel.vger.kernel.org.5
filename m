Return-Path: <linux-kernel+bounces-111342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3223D886AE5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E132A28993A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E02A3F8F4;
	Fri, 22 Mar 2024 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3fbqRSWW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vK8io8cX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ED63AC2B;
	Fri, 22 Mar 2024 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105203; cv=none; b=NGGLw/3D0AQTfejYeJh5SscrWcuh9Mg2cbL/6h5WuLXhcSHta22Z3hkCizSXMl0xWsLIysrKWBs5FGEdcW+kl6TLNurtq/uQmefC8MWij+5n/XsM7oe5xRLgWkdXqKNGltmyHMWDulbfpxWEIxEtYrEAdHddVQvPzK7NK6WMgfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105203; c=relaxed/simple;
	bh=tJHE6WQbKfpVHDW5fVetKWlZW1/K4yJf4ZiivuZPg8o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qOPzNpXgeeBZu+JqpfMpXL2O15VVhw9v/a7elYysSOycjRcsVhfO8GSxG43OnTL3jQR5pce1k9mo3GAt88A4OnlOALO3KR6y2ErxU3H8uINE5XxSWH2rqHaCzhiWBMKAlaTqi2Xaj/xT/yezImEeLIm++dcATlAU0bKbEoXvGjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3fbqRSWW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vK8io8cX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Mar 2024 10:59:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711105199;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h5ZtWgNkBRMIWmFp5Y46fMbsEbaY+4L88vZSo4bSAYk=;
	b=3fbqRSWWm7VdSohU6QuSBy0+Ow0oLKfAsYETKjbOUBsX6B59zz4BetrD3Dx+s4Re7+S+aT
	pundB6tZuqQvaAFlSCRAuljOYsFPPSDFg+diHz+R9hP6eCu8bnnlgeFJkomh85iGhAIKJJ
	ybpZ2EA8gocFnqV9UsKCY3o5TMaxYErW1uDWvhy8EmBxfSj4yUw2X+S28KgA7UlnLo+mxT
	7mcojqpiJr/TS27Yf4vFtppudGLp1E7P+nce/HwFRBnYfzfnoUUHBm/wGpguF5jcUDU318
	AxHkPw/FHurYhfxmAEySs+5hzpc24/FvJ0Ng5XMzat/2S4TDUBD+tt5iT76ujg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711105199;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h5ZtWgNkBRMIWmFp5Y46fMbsEbaY+4L88vZSo4bSAYk=;
	b=vK8io8cXiG5x2vUrVfeZjYF1uqcRgbQ91f7ZEH/+0LOdPqvL5UxouiDKi7p6SsGs921bF2
	2l48tkXpFqoRsZCA==
From: "tip-bot2 for H.J. Lu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/shstk: Enable shadow stacks for x32
Cc: "H.J. Lu" <hjl.tools@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240315140433.1966543-1-hjl.tools@gmail.com>
References: <20240315140433.1966543-1-hjl.tools@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171110519880.10875.7663158781394877164.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     2883f01ec37dd8668e7222dfdb5980c86fdfe277
Gitweb:        https://git.kernel.org/tip/2883f01ec37dd8668e7222dfdb5980c86fdfe277
Author:        H.J. Lu <hjl.tools@gmail.com>
AuthorDate:    Fri, 15 Mar 2024 07:04:33 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Mar 2024 10:17:11 +01:00

x86/shstk: Enable shadow stacks for x32

1. Add shadow stack support to x32 signal.
2. Use the 64-bit map_shadow_stack syscall for x32.
3. Set up shadow stack for x32.

Tested with shadow stack enabled x32 glibc on Intel Tiger Lake:

I configured x32 glibc with --enable-cet, build glibc and
run all glibc tests with shadow stack enabled.  There are
no regressions.  I verified that shadow stack is enabled
via /proc/pid/status.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: H.J. Lu <hjl.tools@gmail.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20240315140433.1966543-1-hjl.tools@gmail.com
---
 arch/x86/entry/syscalls/syscall_64.tbl | 2 +-
 arch/x86/kernel/shstk.c                | 4 ++--
 arch/x86/kernel/signal_64.c            | 6 ++++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 7e8d46f..cc78226 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -374,7 +374,7 @@
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
 451	common	cachestat		sys_cachestat
 452	common	fchmodat2		sys_fchmodat2
-453	64	map_shadow_stack	sys_map_shadow_stack
+453	common	map_shadow_stack	sys_map_shadow_stack
 454	common	futex_wake		sys_futex_wake
 455	common	futex_wait		sys_futex_wait
 456	common	futex_requeue		sys_futex_requeue
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 59e15dd..6f1e988 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -163,8 +163,8 @@ static int shstk_setup(void)
 	if (features_enabled(ARCH_SHSTK_SHSTK))
 		return 0;
 
-	/* Also not supported for 32 bit and x32 */
-	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) || in_32bit_syscall())
+	/* Also not supported for 32 bit */
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) || in_ia32_syscall())
 		return -EOPNOTSUPP;
 
 	size = adjust_shstk_size(0);
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 23d8aaf..8a94053 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -315,6 +315,9 @@ int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 
 	uc_flags = frame_uc_flags(regs);
 
+	if (setup_signal_shadow_stack(ksig))
+		return -EFAULT;
+
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
@@ -377,6 +380,9 @@ COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
 	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
 
+	if (restore_signal_shadow_stack())
+		goto badframe;
+
 	if (compat_restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 

