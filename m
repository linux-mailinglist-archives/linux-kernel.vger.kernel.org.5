Return-Path: <linux-kernel+bounces-163409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E227F8B6A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97EFF281EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5D418628;
	Tue, 30 Apr 2024 06:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qVyyusBt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZkZ2ZP0S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB26FB1;
	Tue, 30 Apr 2024 06:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714457790; cv=none; b=ghjypSCXfelcyFYjK5qIYz9xVLbXyPv/cNsxECy6mE6/37LjeL7bnF1/Tp5T2J5z14kYdx0huGq9RXzmTXZFfPkSnYe6OQ+VrlEyOfPXmByUu6yw5La3bY/f7k+t+i3uEalsgUUoO1Drul3w0Ma7HjUtOkM6v28d9qPHEQR6cy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714457790; c=relaxed/simple;
	bh=w1FtgFGbKATPky80HMgAKnT9l8yQIMkdWVHQFIOZAeU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y58EuFJ/dPGaBrcT74O1PN7C6BGUx+nZxnAC7Z8GY8Acd25gKMrZG75N+39KPlSmW2nAg6f+RSmiYL1m8wPnUA3gOkYHgBH54SYrL8I0Vl3wr3e8Kd+TKNEpnlxoWxO6RXxVtlcCXfLYdrOAS7SNbYvAO72jVNjQw9Fl7NSPyz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qVyyusBt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZkZ2ZP0S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Apr 2024 06:16:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714457786;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yfrut0KQA7/LT2MTh/hFrudkeTIS+9cJoSYnPXB8YII=;
	b=qVyyusBtE9afiQOzeWux2Im959q/Wh0eWz9BVUfSeyAEVI7D/EEXGVs5+vheCGYJElQsZc
	I1u9QwV3raojSF6skVeBKXNjoIDJgA9jYQ+J+GxdqF4mNRlO6hnfHYQc3sJNtZc3eKOV5e
	e74Q/PJEaCTtxSjPlD4tJhhptJXHZ9iC6UsvKs71hJNNyTY6fabtw6MWDytDo6xO3rV9lP
	Pbbt1scK06vbW9zGICTHusX6q9ORzDRiANWcMoxJ+hgbnfkytsbpDLr/9zdGarmGdmyvDP
	QYOKJd1wA4xpQQZO4ODrrmBKiVGrSgtIasgFunDjr4yx9LvZOPurzm2tftURxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714457786;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yfrut0KQA7/LT2MTh/hFrudkeTIS+9cJoSYnPXB8YII=;
	b=ZkZ2ZP0SgbGk3bEVZ958dFw29DAyP04IYiw7VO3YEBz1ha1+siZw0aKUsHnfWNwCwmXixx
	xplI+t4dEk0XTdDA==
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
Message-ID: <171445778590.10875.11181834195203165765.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c9e1dc9825319392b44d3c22493dc543075933b9
Gitweb:        https://git.kernel.org/tip/c9e1dc9825319392b44d3c22493dc543075933b9
Author:        Linus Torvalds <torvalds@linux-foundation.org>
AuthorDate:    Mon, 29 Apr 2024 10:00:51 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 30 Apr 2024 08:08:30 +02:00

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
 arch/x86/entry/vsyscall/vsyscall_64.c | 25 +-------------------
 arch/x86/include/asm/processor.h      |  1 +-
 arch/x86/mm/fault.c                   | 33 +--------------------------
 3 files changed, 3 insertions(+), 56 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index a3c0df1..3b0f61b 100644
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
 
@@ -123,7 +118,6 @@ bool emulate_vsyscall(unsigned long error_code,
 	struct task_struct *tsk;
 	unsigned long caller;
 	int vsyscall_nr, syscall_nr, tmp;
-	int prev_sig_on_uaccess_err;
 	long ret;
 	unsigned long orig_dx;
 
@@ -234,12 +228,8 @@ bool emulate_vsyscall(unsigned long error_code,
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
@@ -262,23 +252,12 @@ bool emulate_vsyscall(unsigned long error_code,
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

