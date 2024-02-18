Return-Path: <linux-kernel+bounces-70520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 388CD8598CC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E946C281E06
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C12C763EB;
	Sun, 18 Feb 2024 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="16iOEDIe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iHynVoQd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1473B745D7
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282680; cv=none; b=WFMpaxFt1JabkoBdfexDfTXiArKZQHl59pkHzwhBZJuB96EYGwDNFgcJRLXgxZjsWiNLHP9+goifnC71nJegZ36nMjSO0tEaKIwbmOOprF6poOx5iUWHRU2pg6fMJGPil3hXZLwPB0EKKh09aqFsqARmjIpj+nV/qL6BrViKzbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282680; c=relaxed/simple;
	bh=OagJvzD8CITXGM05wrJdLFbnK8R3FnQZlKkDZ7ArXY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tl+0ejlRmOjX/bpbMvekIMokL61zLSwCbpniIimvTW1ZpBQOai65e4a3Gu35+4SJZLoJjEVOOAiG7OHIHvoV08BhGtJGsr/2hLL7DuC+4+qLZZ6xCMh6Qmjo9PvWk0tES2fUVRTeNtv9IwIUrmSrrgCnyZbjYtwk9SVWJ0OIwwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=16iOEDIe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iHynVoQd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0lPBki68mVE7PCw7W4jrgk0lCFhQvBUvfvhYmuWjIeY=;
	b=16iOEDIef9bfi8hm5YKwdXMo0KA3BGTQYHPoFj515WihwX2bbE+vwFUVFaE5Du1RD7Y5W2
	RPwwTqoL6dA2GLDE1UyNa3DkBrV1y2AT9dUZM10gr2IQ6QTaEIKAOA9R1vYmwRH7v5i/LW
	hBXv3pVUwSCOxaDFMsCTnMSJrRE+ezEIBTczVi/gszaGneoixpcpGkWyW361N2KLds8b9E
	T1VuopLugS5WomPG7SWkvrlSVJ/kiI4l4ux3mRbLXZo7iqt/NUSd2lWWwWiVtaTjb6MluE
	tD99NTIR2S1ylI9Jywrwdx9LaxGtztzqu6YDkz54DL0f/6KRyFckh8LM/JeqyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0lPBki68mVE7PCw7W4jrgk0lCFhQvBUvfvhYmuWjIeY=;
	b=iHynVoQdMqQvQ5UY9zDTHbYAg0fKIK48nfTCXAbx3zmnVvmiXaZF3CIrbiq4IENzpgm/Yp
	wGM0dChF7tn7OlDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH printk v2 26/26] lockdep: Mark emergency section in lockdep splats
Date: Sun, 18 Feb 2024 20:03:26 +0106
Message-Id: <20240218185726.1994771-27-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark an emergency section within print_usage_bug(), where
lockdep bugs are printed. In this section, the CPU will not
perform console output for the printk() calls. Instead, a
flushing of the console output is triggered when exiting
the emergency section.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/locking/lockdep.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e85b5ad3e206..00465373d358 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -56,6 +56,7 @@
 #include <linux/kprobes.h>
 #include <linux/lockdep.h>
 #include <linux/context_tracking.h>
+#include <linux/console.h>
 
 #include <asm/sections.h>
 
@@ -3970,6 +3971,8 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
 	if (!debug_locks_off() || debug_locks_silent)
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	pr_warn("\n");
 	pr_warn("================================\n");
 	pr_warn("WARNING: inconsistent lock state\n");
@@ -3998,6 +4001,8 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+
+	nbcon_cpu_emergency_exit();
 }
 
 /*
-- 
2.39.2


