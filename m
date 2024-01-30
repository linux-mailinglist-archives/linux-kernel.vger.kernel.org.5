Return-Path: <linux-kernel+bounces-44853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BAE842829
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1067D1F21165
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7F3823D5;
	Tue, 30 Jan 2024 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M+R2/Vo5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i+/eHCyE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F28C823D6;
	Tue, 30 Jan 2024 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628968; cv=none; b=THbTZZejWUs5DDyqc04IznX3WzvaEID+AyZC2MvRZ36mrgpOsr4tjsYOYnJXJEgjniVOOxNkp1ZDB1MheklSTj6bwfR5/a5zYDklgeagce0P+tetWz1rAwwSykmZH7HeFJRhvMbjX+SmJqdKsOLbLbR+uIZJnsq/q459fZFHMmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628968; c=relaxed/simple;
	bh=2EGzl7M/FHI7zqdg7ywE9XuWh5LgpwPnBVChHVQOHUw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ElI/snunWSpnqTZgZFvD9nEp5U7vpPiZ+1prN1HuqcUl5+WOUiW1pozAS3G4lbjcjOrc5ZwMIh6bgsWILL2gJtDLqqZUzi5ASnXkA62T4oNoma4Qg1yTSt181sxeUT/zrRQ+VLmNC/JbOLe/HyizhA+Oj6xA4xbQ7dY8fRiopF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M+R2/Vo5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i+/eHCyE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 15:36:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706628964;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=KNY97KZhyunhlbOQUhYIMP68InPWjUlWLM1nd+NbATY=;
	b=M+R2/Vo5i/tS5qB0nz+flCPn4WK66PWkRPzXADc6omcE+z2cINlRPsVNPzomTZvGUuyXkO
	O0i3bw7q+haUJqMU1BbDBpZcCcG+BrHOjt5fEXng8k1+QR7kUmxUxvOc+aUb5a1bAgaMBr
	XadZ9OOn458o30XFPKdoauCmK/OhSk3EPOWWfzjGRJswaHMPrZyA5mVfZ834mslfbTVJoo
	RhBzyg53ucpkhazcL9SdD59rY7vPzVONt1bSG2TTdDfXxpck0uTXvJ08A5frzH9o268fhD
	JpnPS79daVhtyjdI7UxdpsXGJAJfzbA7S83FauRmveHbT9I1kixyISCJ8cGg6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706628964;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=KNY97KZhyunhlbOQUhYIMP68InPWjUlWLM1nd+NbATY=;
	b=i+/eHCyE6RnR5wxNMXXw7Z0h6sU6/EO3gaA8r6J9AiZkiWX7d65EwFu6UiZHBbbm4nhvSN
	X+52vrEKLRzw/dDw==
From: "tip-bot2 for Andrei Vagin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu: Stop relying on userspace for info to
 fault in xsave buffer
Cc: Konstantin Bogomolov <bogomolov@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Andrei Vagin <avagin@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170662896219.398.13546791060751128593.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d877550eaf2dc9090d782864c96939397a3c6835
Gitweb:        https://git.kernel.org/tip/d877550eaf2dc9090d782864c96939397a3c6835
Author:        Andrei Vagin <avagin@google.com>
AuthorDate:    Mon, 29 Jan 2024 22:36:03 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 30 Jan 2024 07:25:48 -08:00

x86/fpu: Stop relying on userspace for info to fault in xsave buffer

Before this change, the expected size of the user space buffer was
taken from fx_sw->xstate_size. fx_sw->xstate_size can be changed
from user-space, so it is possible construct a sigreturn frame where:

 * fx_sw->xstate_size is smaller than the size required by valid bits in
   fx_sw->xfeatures.
 * user-space unmaps parts of the sigrame fpu buffer so that not all of
   the buffer required by xrstor is accessible.

In this case, xrstor tries to restore and accesses the unmapped area
which results in a fault. But fault_in_readable succeeds because buf +
fx_sw->xstate_size is within the still mapped area, so it goes back and
tries xrstor again. It will spin in this loop forever.

Instead, fault in the maximum size which can be touched by XRSTOR (taken
from fpstate->user_size).

[ dhansen: tweak subject / changelog ]

Fixes: fcb3635f5018 ("x86/fpu/signal: Handle #PF in the direct restore path")
Reported-by: Konstantin Bogomolov <bogomolov@google.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrei Vagin <avagin@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240130063603.3392627-1-avagin%40google.com
---
 arch/x86/kernel/fpu/signal.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 558076d..247f222 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -274,12 +274,13 @@ static int __restore_fpregs_from_user(void __user *buf, u64 ufeatures,
  * Attempt to restore the FPU registers directly from user memory.
  * Pagefaults are handled and any errors returned are fatal.
  */
-static bool restore_fpregs_from_user(void __user *buf, u64 xrestore,
-				     bool fx_only, unsigned int size)
+static bool restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only)
 {
 	struct fpu *fpu = &current->thread.fpu;
 	int ret;
 
+	/* Restore enabled features only. */
+	xrestore &= fpu->fpstate->user_xfeatures;
 retry:
 	fpregs_lock();
 	/* Ensure that XFD is up to date */
@@ -309,7 +310,7 @@ retry:
 		if (ret != X86_TRAP_PF)
 			return false;
 
-		if (!fault_in_readable(buf, size))
+		if (!fault_in_readable(buf, fpu->fpstate->user_size))
 			goto retry;
 		return false;
 	}
@@ -339,7 +340,6 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 	struct user_i387_ia32_struct env;
 	bool success, fx_only = false;
 	union fpregs_state *fpregs;
-	unsigned int state_size;
 	u64 user_xfeatures = 0;
 
 	if (use_xsave()) {
@@ -349,17 +349,14 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 			return false;
 
 		fx_only = !fx_sw_user.magic1;
-		state_size = fx_sw_user.xstate_size;
 		user_xfeatures = fx_sw_user.xfeatures;
 	} else {
 		user_xfeatures = XFEATURE_MASK_FPSSE;
-		state_size = fpu->fpstate->user_size;
 	}
 
 	if (likely(!ia32_fxstate)) {
 		/* Restore the FPU registers directly from user memory. */
-		return restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only,
-						state_size);
+		return restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only);
 	}
 
 	/*

