Return-Path: <linux-kernel+bounces-72163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A52D85B036
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA994B20B01
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF1F23779;
	Tue, 20 Feb 2024 01:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ITYpa6SB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dP4uBO1n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAE210953;
	Tue, 20 Feb 2024 01:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708390931; cv=none; b=t6i+3FLXNUPwYJQfXSi19Ks5teYXYpD6a/bz7mgvKENq2axj4SYi8b76isI9NLGIuO7qX7OP3cvIjbK1htCAcSGDbLDuZZrfwAgL9skfMl8/vsgi+9Suv4/sWev5X2biR0URGFiPVtMMzT/uALaMWzxshPncyu7wv03ksRCCBC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708390931; c=relaxed/simple;
	bh=G1+M6v3juigyiR3fQI9txWJp1oX7nPu+QZSTbto5ZrY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=oj2vQ8KtzZXHulGYX9+TGRDeZoHuhv1KmBNf0ZcU9F5hbwBnJ6GaH05X5ToY22HkoFEiRH57ziEpaqVdsydu5QTi41F7dwSC+EdkIXj34cmnj8WJy2IspyZ/QD+PjjbhFGUX8AXlZoOv4eBowBA50xo7xIvJX2nkku0RVSRzEvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ITYpa6SB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dP4uBO1n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Feb 2024 01:02:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708390928;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=zBzOHUDK7yKQpAW9Mx+8ZCSEadFabIiFxnpqbFGgvno=;
	b=ITYpa6SBpFPRiyI02/ec6Wi4ThfE3yY5tnveLH1+cvnCoq0L4GewKu85DPT5CzQQkb2qHv
	S/156pxyY9cM/ckmBbMLaCJa1aR2DSTXgp/g4t0Lg5m9xMkozyOwywNPABVLrQOsy9SSt2
	r1p8o3OYbEFlpDuxGZREM+njaRwYxPRlfeToKO3o2YkDiUpQFgE6xglEXrWMBuj1c1/Sd8
	oeGR1cYgnzyTqCe5dbU9gYfCwgN4iTZmKC5lnh4Fp3t0S4eQOykFHzlCuSIHNUDkJrLJqw
	qZxMC/6PA194fLsgcYmAS25JbvEV9Oc2uZSbd+hAUFPHBcrCgakoQ1/PHo4GHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708390928;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=zBzOHUDK7yKQpAW9Mx+8ZCSEadFabIiFxnpqbFGgvno=;
	b=dP4uBO1nt6RdI/SMEoHEEUVRCv+i3v9io5Fo3me0m4JaJmTVWeYLNux9e/dyiTNHFqIAL7
	fgH94XGtsUl+bcDA==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/entry_64: Add VERW just before userspace transition
Cc: Dave Hansen <dave.hansen@intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170839092728.398.17208840006241390266.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3c7501722e6b31a6e56edd23cea5e77dbb9ffd1a
Gitweb:        https://git.kernel.org/tip/3c7501722e6b31a6e56edd23cea5e77dbb9ffd1a
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Tue, 13 Feb 2024 18:21:52 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 19 Feb 2024 16:31:42 -08:00

x86/entry_64: Add VERW just before userspace transition

Mitigation for MDS is to use VERW instruction to clear any secrets in
CPU Buffers. Any memory accesses after VERW execution can still remain
in CPU buffers. It is safer to execute VERW late in return to user path
to minimize the window in which kernel data can end up in CPU buffers.
There are not many kernel secrets to be had after SWITCH_TO_USER_CR3.

Add support for deploying VERW mitigation after user register state is
restored. This helps minimize the chances of kernel data ending up into
CPU buffers after executing VERW.

Note that the mitigation at the new location is not yet enabled.

  Corner case not handled
  =======================
  Interrupts returning to kernel don't clear CPUs buffers since the
  exit-to-user path is expected to do that anyways. But, there could be
  a case when an NMI is generated in kernel after the exit-to-user path
  has cleared the buffers. This case is not handled and NMI returning to
  kernel don't clear CPU buffers because:

  1. It is rare to get an NMI after VERW, but before returning to userspace.
  2. For an unprivileged user, there is no known way to make that NMI
     less rare or target it.
  3. It would take a large number of these precisely-timed NMIs to mount
     an actual attack.  There's presumably not enough bandwidth.
  4. The NMI in question occurs after a VERW, i.e. when user state is
     restored and most interesting data is already scrubbed. Whats left
     is only the data that NMI touches, and that may or may not be of
     any interest.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240213-delay-verw-v8-2-a6216d83edb7%40linux.intel.com
---
 arch/x86/entry/entry_64.S        | 11 +++++++++++
 arch/x86/entry/entry_64_compat.S |  1 +
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c40f89a..9bb4859 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -161,6 +161,7 @@ syscall_return_via_sysret:
 SYM_INNER_LABEL(entry_SYSRETQ_unsafe_stack, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	swapgs
+	CLEAR_CPU_BUFFERS
 	sysretq
 SYM_INNER_LABEL(entry_SYSRETQ_end, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
@@ -573,6 +574,7 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 
 .Lswapgs_and_iret:
 	swapgs
+	CLEAR_CPU_BUFFERS
 	/* Assert that the IRET frame indicates user mode. */
 	testb	$3, 8(%rsp)
 	jnz	.Lnative_iret
@@ -723,6 +725,8 @@ native_irq_return_ldt:
 	 */
 	popq	%rax				/* Restore user RAX */
 
+	CLEAR_CPU_BUFFERS
+
 	/*
 	 * RSP now points to an ordinary IRET frame, except that the page
 	 * is read-only and RSP[31:16] are preloaded with the userspace
@@ -1450,6 +1454,12 @@ nmi_restore:
 	movq	$0, 5*8(%rsp)		/* clear "NMI executing" */
 
 	/*
+	 * Skip CLEAR_CPU_BUFFERS here, since it only helps in rare cases like
+	 * NMI in kernel after user state is restored. For an unprivileged user
+	 * these conditions are hard to meet.
+	 */
+
+	/*
 	 * iretq reads the "iret" frame and exits the NMI stack in a
 	 * single instruction.  We are returning to kernel mode, so this
 	 * cannot result in a fault.  Similarly, we don't need to worry
@@ -1466,6 +1476,7 @@ SYM_CODE_START(entry_SYSCALL32_ignore)
 	UNWIND_HINT_END_OF_STACK
 	ENDBR
 	mov	$-ENOSYS, %eax
+	CLEAR_CPU_BUFFERS
 	sysretl
 SYM_CODE_END(entry_SYSCALL32_ignore)
 
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index de94e2e..eabf48c 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -270,6 +270,7 @@ SYM_INNER_LABEL(entry_SYSRETL_compat_unsafe_stack, SYM_L_GLOBAL)
 	xorl	%r9d, %r9d
 	xorl	%r10d, %r10d
 	swapgs
+	CLEAR_CPU_BUFFERS
 	sysretl
 SYM_INNER_LABEL(entry_SYSRETL_compat_end, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR

