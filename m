Return-Path: <linux-kernel+bounces-43997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 419E6841BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC4B8B22516
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4974E383A8;
	Tue, 30 Jan 2024 06:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2r8m4z+s"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131924C61
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706596569; cv=none; b=gU0rChmFx0xLAjMubJ0EQCc2rsJhBpLXAceK61rMcJVDZv5qIT+zkPKwiYvgpnrS1zxMIyJPbOVjRSPMPgx5sXdqzbPJSF6G4j09/WrWI/USZb65guJ6VmPLXq6PZItNf1eCK1UkilQBchdg7IE3qPObOBayyLCubppz7YrdvNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706596569; c=relaxed/simple;
	bh=LGFgozpDpNff0v5K6NHEQYxTIsH7ytp7gB/Q2V+8pwE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kdBfuBehwWIUcC5kDXFEKoYrZuleUIKEMk66ucXUDtZu3I/dXUeGpkwVTnCqQqkImI54hzkTHErOmNJIxPjeWCLPfPQ0pW2NmJwlulg5O6uLMlyEx0kfKlkAWX8EQTnaAn6X9E1BHovvLbLFLl+UToz7LxF3ciUNXNZ86xWKHtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2r8m4z+s; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-294cb63fda2so1384178a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 22:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706596567; x=1707201367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MVXjYaU74UNiN/jcBg4R2XESl1frZVjMD5rXT/kNyBk=;
        b=2r8m4z+skAST6nLMEa3E3j7igjK5/Q83MopXuF+KxO5a26+yU8a4hfODeYTP4NeSEV
         C0MdHbOhkT+o1kH7bTeujhSES6x2t99Qb4m5tuTcc/v7ezCxFZ1rTB7dzCGz2wlniGI0
         HyWAIl/MhMnUieLpEv2RABIiKAajMX6IMzL4hny9QbtFWGJYL7R/AQ9v6SIN2v4JaH+f
         BWIpP+08uuJEBvCJoC9p1zB3805vJdYhRTjH9Ohq5cddG1mbOUzkY5OJJnRXUlcZhCvz
         MFB1wEebGrr8meQzPo2V2hHV4NO5/QZ8fECG+0maR1ZbAHbYwG7F9PyUmrCwwq1cOtl6
         v4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706596567; x=1707201367;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVXjYaU74UNiN/jcBg4R2XESl1frZVjMD5rXT/kNyBk=;
        b=oYtWlRqR6GDWGkCjW8UhWce24vu/iatHHG2IoDlsBwdHAKq1w5tWw30kMpWujHpqwX
         mPypIenEJGxX1D4imF8JZ6QZ9eIQ/RUczOvesyG4FKXRqk5FJQyNfMol0jxdCxexyzaX
         2zQnMgbTCkB76dbGGN+UITPhOCTX2JFPAEnfPfTCkz9da/juV0EjNWYyWc5c0UX7sKa9
         sfSEu9MF0dLAoyr6FOEvgZRSzRqApm8OlD7F/FnOqAdauIaY9NggBQ3hh3lrItZmbgfU
         Ts1MCSLeyF7B9+E/dvp5bsMmUFxinCwak/RLxEZRXreEETJfp2Rt68Fc3zHI282rKwDa
         qM4Q==
X-Gm-Message-State: AOJu0YyD+z8hWbjDP+QXk975zmEce/egtX/iOsii0/kdWB8FETuJl1Wz
	WllKOgVZto4xyJ2xCBk7V7LyByYS7sItqXDo/8M8v3BMRolI3wwWcC3RQj/UrLey7LpJEqtkabm
	4OA==
X-Google-Smtp-Source: AGHT+IH9QsHcLju9rhS/Xko7JDx+IZhdnG6BOk+xYLW5y+ECXV/nzPwAk88jdBnoKJzXf4+k6aXBpVi7ouM=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:10:512c:bd37:9d9b:405e])
 (user=avagin job=sendgmr) by 2002:a17:903:34c6:b0:1d8:fb04:ac78 with SMTP id
 ml6-20020a17090334c600b001d8fb04ac78mr7357plb.10.1706596567301; Mon, 29 Jan
 2024 22:36:07 -0800 (PST)
Date: Mon, 29 Jan 2024 22:36:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240130063603.3392627-1-avagin@google.com>
Subject: [PATCH v2 RESEND] x86/fpu: call fault_in_readable() for the entire
 xsave buffer
From: Andrei Vagin <avagin@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrei Vagin <avagin@google.com>, Dave Hansen <dave.hansen@intel.com>, 
	stable@vger.kernel.org, Konstantin Bogomolov <bogomolov@google.com>
Content-Type: text/plain; charset="UTF-8"

Before this change, the expected size of the user space buffer was
taken from fx_sw->xstate_size. fx_sw->xstate_size can be changed
from user-space, so it is possible construct a sigreturn frame where:

 * fx_sw->xstate_size is smaller than the size required by valid bits in
   fx_sw->xfeatures.
 * user-space unmaps parts of the sigrame fpu buffer so that not all of
   the buffer required by xrstor is accessible.

In this case, xrstor tries to restore and accesses the unmaped area
which results in a fault. But fault_in_readable succeeds because buf +
fx_sw->xstate_size is within the still mapped area, so it goes back and
tries xrstor again. It will spin in this loop forever.

Thomas suggested to pass fpstate->user_size into fault_in_readable,
because it is the maximum size which can be touched by XRSTOR.

Cc: Dave Hansen <dave.hansen@intel.com>
Cc: stable@vger.kernel.org
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Konstantin Bogomolov <bogomolov@google.com>
Fixes: fcb3635f5018 ("x86/fpu/signal: Handle #PF in the direct restore path")
Signed-off-by: Andrei Vagin <avagin@google.com>
---
v2: use fpstate->user_size instead of calculating a size of xstate
buffer.
resend: add stable@ and lkml@ to CC

 arch/x86/kernel/fpu/signal.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 558076dbde5b..247f2225aa9f 100644
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
@@ -309,7 +310,7 @@ static bool restore_fpregs_from_user(void __user *buf, u64 xrestore,
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
-- 
2.43.0.429.g432eaa2c6b-goog


