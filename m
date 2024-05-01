Return-Path: <linux-kernel+bounces-165007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7548B8666
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C6C5B2250B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852274D9FC;
	Wed,  1 May 2024 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zELHSjKr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WhZs9A1Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECAF4CE0F;
	Wed,  1 May 2024 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714549852; cv=none; b=TWBdpl0aguzeWFxcEVaZpPBL2XpLNLsMVRv1ho8uBgzPqULm031RWKTCVNipBp9DKwQC3QdDq2rgPsZRfw/383j0sZnwKuNqTVSvEqF4sql90Pk6fcU4owHJtXXFBiSIIY/hW0VuKn5/8NHZTnVXgGvMVpjME0lURUvMZetiwWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714549852; c=relaxed/simple;
	bh=qc9Q3fJInyIPLUyfsn2QU1DB5+yr0LAeBaxOlPKq20I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aoISJHfPasNdqDbX32dv9ccuf321ZeoBUV2hkdUjWZBxsLq8//MCa0oV0QExaO0rKWFJ+Ycoul7tgypMRjMCSVTthpZoRKbcNBpl48cHJfqRWtz2svTT/39+DBh1kVOmvH8BoIdQfWG5Z3GaTjKC+jSOYod452EEaXarTKx07YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zELHSjKr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WhZs9A1Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 01 May 2024 07:50:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714549848;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vgs7Ofr2/HH/fNinRqbnfHY1oZ2hMdJThwsIZ2I8j2E=;
	b=zELHSjKrL0gfwmtL0dHBrVuKUucQ8l7pjgwaafFHpjhynFTb9yYMhob8Zuwfqly9t/gNzK
	5elGq1ODLCnmYqjX/tO/Ch1Bo4GKT3N9Rm6mJlQsD1n6IZMbEe0HvciEQ80kK1gCSMJ6vn
	aKgpa/gy+FxnovWQnh7myQvC8iBdz7ASPtabyiwjzinCQ+t58SIMtMmtBYlDkpGguBQhEu
	p06K6CCDZy2+Lr0ZSV3BkXAEJyWUPpTfl6VK8VozgGjpDoNmLVj11Xgo8++tcye9ckq/HE
	d3sdFHznhYBRApoMZWuyqqXhGg8fwTIqMZHJkTgjraRvNPCisbdRRCOyJoKc6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714549848;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vgs7Ofr2/HH/fNinRqbnfHY1oZ2hMdJThwsIZ2I8j2E=;
	b=WhZs9A1Y+k04QKzabClmo1nunMkBodZ2iJraWIsmgXh0k0pzDnfMsPeYdVB3Uo+coJMxjE
	vUjP6pC7U4a8rgBg==
From: "tip-bot2 for Linus Torvalds" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: Remove broken vsyscall emulation code from
 the page fault code
Cc: syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com>
References:
 <CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171454984807.10875.8290271548321530670.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     02b670c1f88e78f42a6c5aee155c7b26960ca054
Gitweb:        https://git.kernel.org/tip/02b670c1f88e78f42a6c5aee155c7b26960ca054
Author:        Linus Torvalds <torvalds@linux-foundation.org>
AuthorDate:    Mon, 29 Apr 2024 10:00:51 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 01 May 2024 09:41:43 +02:00

x86/mm: Remove broken vsyscall emulation code from the page fault code

The syzbot-reported stack trace from hell in this discussion thread
actually has three nested page faults:

  https://lore.kernel.org/r/000000000000d5f4fc0616e816d4@google.com

.. and I think that's actually the important thing here:

 - the first page fault is from user space, and triggers the vsyscall
   emulation.

 - the second page fault is from __do_sys_gettimeofday(), and that should
   just have caused the exception that then sets the return value to
   -EFAULT

 - the third nested page fault is due to _raw_spin_unlock_irqrestore() ->
   preempt_schedule() -> trace_sched_switch(), which then causes a BPF
   trace program to run, which does that bpf_probe_read_compat(), which
   causes that page fault under pagefault_disable().

It's quite the nasty backtrace, and there's a lot going on.

The problem is literally the vsyscall emulation, which sets

        current->thread.sig_on_uaccess_err = 1;

and that causes the fixup_exception() code to send the signal *despite* the
exception being caught.

And I think that is in fact completely bogus.  It's completely bogus
exactly because it sends that signal even when it *shouldn't* be sent -
like for the BPF user mode trace gathering.

In other words, I think the whole "sig_on_uaccess_err" thing is entirely
broken, because it makes any nested page-faults do all the wrong things.

Now, arguably, I don't think anybody should enable vsyscall emulation any
more, but this test case clearly does.

I think we should just make the "send SIGSEGV" be something that the
vsyscall emulation does on its own, not this broken per-thread state for
something that isn't actually per thread.

The x86 page fault code actually tried to deal with the "incorrect nesting"
by having that:

                if (in_interrupt())
                        return;

which ignores the sig_on_uaccess_err case when it happens in interrupts,
but as shown by this example, these nested page faults do not need to be
about interrupts at all.

IOW, I think the only right thing is to remove that horrendously broken
code.

The attached patch looks like the ObviouslyCorrect(tm) thing to do.

NOTE! This broken code goes back to this commit in 2011:

  4fc3490114bb ("x86-64: Set siginfo and context on vsyscall emulation faults")

.. and back then the reason was to get all the siginfo details right.
Honestly, I do not for a moment believe that it's worth getting the siginfo
details right here, but part of the commit says:

    This fixes issues with UML when vsyscall=emulate.

.. and so my patch to remove this garbage will probably break UML in this
situation.

I do not believe that anybody should be running with vsyscall=emulate in
2024 in the first place, much less if you are doing things like UML. But
let's see if somebody screams.

Reported-and-tested-by: syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 28 +---------------------
 arch/x86/include/asm/processor.h      |  1 +-
 arch/x86/mm/fault.c                   | 33 +--------------------------
 3 files changed, 3 insertions(+), 59 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index a3c0df1..2fb7d53 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -98,11 +98,6 @@ static int addr_to_vsyscall_nr(unsigned long addr)
 
 static bool write_ok_or_segv(unsigned long ptr, size_t size)
 {
-	/*
-	 * XXX: if access_ok, get_user, and put_user handled
-	 * sig_on_uaccess_err, this could go away.
-	 */
-
 	if (!access_ok((void __user *)ptr, size)) {
 		struct thread_struct *thread = &current->thread;
 
@@ -120,10 +115,8 @@ static bool write_ok_or_segv(unsigned long ptr, size_t size)
 bool emulate_vsyscall(unsigned long error_code,
 		      struct pt_regs *regs, unsigned long address)
 {
-	struct task_struct *tsk;
 	unsigned long caller;
 	int vsyscall_nr, syscall_nr, tmp;
-	int prev_sig_on_uaccess_err;
 	long ret;
 	unsigned long orig_dx;
 
@@ -172,8 +165,6 @@ bool emulate_vsyscall(unsigned long error_code,
 		goto sigsegv;
 	}
 
-	tsk = current;
-
 	/*
 	 * Check for access_ok violations and find the syscall nr.
 	 *
@@ -234,12 +225,8 @@ bool emulate_vsyscall(unsigned long error_code,
 		goto do_ret;  /* skip requested */
 
 	/*
-	 * With a real vsyscall, page faults cause SIGSEGV.  We want to
-	 * preserve that behavior to make writing exploits harder.
+	 * With a real vsyscall, page faults cause SIGSEGV.
 	 */
-	prev_sig_on_uaccess_err = current->thread.sig_on_uaccess_err;
-	current->thread.sig_on_uaccess_err = 1;
-
 	ret = -EFAULT;
 	switch (vsyscall_nr) {
 	case 0:
@@ -262,23 +249,12 @@ bool emulate_vsyscall(unsigned long error_code,
 		break;
 	}
 
-	current->thread.sig_on_uaccess_err = prev_sig_on_uaccess_err;
-
 check_fault:
 	if (ret == -EFAULT) {
 		/* Bad news -- userspace fed a bad pointer to a vsyscall. */
 		warn_bad_vsyscall(KERN_INFO, regs,
 				  "vsyscall fault (exploit attempt?)");
-
-		/*
-		 * If we failed to generate a signal for any reason,
-		 * generate one here.  (This should be impossible.)
-		 */
-		if (WARN_ON_ONCE(!sigismember(&tsk->pending.signal, SIGBUS) &&
-				 !sigismember(&tsk->pending.signal, SIGSEGV)))
-			goto sigsegv;
-
-		return true;  /* Don't emulate the ret. */
+		goto sigsegv;
 	}
 
 	regs->ax = ret;
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 811548f..78e51b0 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -472,7 +472,6 @@ struct thread_struct {
 	unsigned long		iopl_emul;
 
 	unsigned int		iopl_warn:1;
-	unsigned int		sig_on_uaccess_err:1;
 
 	/*
 	 * Protection Keys Register for Userspace.  Loaded immediately on
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 622d12e..bba4e02 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -723,39 +723,8 @@ kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
 	WARN_ON_ONCE(user_mode(regs));
 
 	/* Are we prepared to handle this kernel fault? */
-	if (fixup_exception(regs, X86_TRAP_PF, error_code, address)) {
-		/*
-		 * Any interrupt that takes a fault gets the fixup. This makes
-		 * the below recursive fault logic only apply to a faults from
-		 * task context.
-		 */
-		if (in_interrupt())
-			return;
-
-		/*
-		 * Per the above we're !in_interrupt(), aka. task context.
-		 *
-		 * In this case we need to make sure we're not recursively
-		 * faulting through the emulate_vsyscall() logic.
-		 */
-		if (current->thread.sig_on_uaccess_err && signal) {
-			sanitize_error_code(address, &error_code);
-
-			set_signal_archinfo(address, error_code);
-
-			if (si_code == SEGV_PKUERR) {
-				force_sig_pkuerr((void __user *)address, pkey);
-			} else {
-				/* XXX: hwpoison faults will set the wrong code. */
-				force_sig_fault(signal, si_code, (void __user *)address);
-			}
-		}
-
-		/*
-		 * Barring that, we can do the fixup and be happy.
-		 */
+	if (fixup_exception(regs, X86_TRAP_PF, error_code, address))
 		return;
-	}
 
 	/*
 	 * AMD erratum #91 manifests as a spurious page fault on a PREFETCH

