Return-Path: <linux-kernel+bounces-135569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F350089C7A8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8CE285D4E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B7D13FD6F;
	Mon,  8 Apr 2024 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vWOLiIYf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vWOLiIYf"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA3D13F01A;
	Mon,  8 Apr 2024 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588307; cv=none; b=pG/GOZ6Kq4DJQkxI9NVhCaet/XrXejStyV+c42sJ3LToziG1YTUBfEIcsJDzL8LhdiGlhs+OMvnLkGVJjFgYZhmcin1ERbxyjRxdUTFnSwIJAuWODieuK2+HU6hIVsHGD2oNCg65JmF/1jaewnP/+YY+KpHS5OtLRkxiTDBuSYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588307; c=relaxed/simple;
	bh=H2v7MTrPicOoDLC8fqGHfCf75dQRyPiiI+mZ/zR7ZIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PB65kLFXBvYIFd8KJhBxMwjpLvb5bsdixtCR1nK1MSUbHEMRoK+bQlnT3DWmLVmNRmwo800t1RQhXPNWE61Fia2Vaiv5Me9meGM1k/dHU3IjORcT6E+geY1//DXy0ogkrBlOg2h8IU7IH6VfRIzfy6s+pVwzqveLL/U7H5MyTfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vWOLiIYf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vWOLiIYf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 08316203F0;
	Mon,  8 Apr 2024 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712588302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTjJZsX/P9tXqTfUJFkBVLEtRqDKu3yAXjWfeJPn/ds=;
	b=vWOLiIYfYbL3aGlyNL1lo+sJ1v8hiRj1ROFWPrNLXjvZyWk7j0Tn4URnBWbbWI/hPtloSi
	u/F+H/QULKRTeKge7WFIAz9XAjuGrY2tu31B91juR6NFYDgObLLfuCNpL6HzGXBWvcO6NJ
	wjiiOrCZBLKJZSXIdY63apPBD8J7XaY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712588302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTjJZsX/P9tXqTfUJFkBVLEtRqDKu3yAXjWfeJPn/ds=;
	b=vWOLiIYfYbL3aGlyNL1lo+sJ1v8hiRj1ROFWPrNLXjvZyWk7j0Tn4URnBWbbWI/hPtloSi
	u/F+H/QULKRTeKge7WFIAz9XAjuGrY2tu31B91juR6NFYDgObLLfuCNpL6HzGXBWvcO6NJ
	wjiiOrCZBLKJZSXIdY63apPBD8J7XaY=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DB92813AA4;
	Mon,  8 Apr 2024 14:58:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id yNxwNQ0GFGa8dgAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Mon, 08 Apr 2024 14:58:21 +0000
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Kees Cook <keescook@chromium.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tycho Andersen <tandersen@netflix.com>,
	Jens Axboe <axboe@kernel.dk>,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH 2/3] kernel/pid: Remove default pid_max value
Date: Mon,  8 Apr 2024 16:58:18 +0200
Message-ID: <20240408145819.8787-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408145819.8787-1-mkoutny@suse.com>
References: <20240408145819.8787-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.30
X-Spam-Flag: NO

pid_max is a per-pidns (thus global too) limit on a number of tasks the
kernel admits. The knob can be configured by admin in the range between
pid_max_min and pid_max_max (sic). The default value sits between
those and it typically equals max(32k, 1k*nr_cpus).

The nr_cpu scaling was introduced in commit 72680a191b93 ("pids:
increase pid_max based on num_possible_cpus") to accommodate kernel's own
helper tasks (before workqueues). Generally, 1024 tasks/cpu cap is too
much if they were all running and it is also too little when they are
idle (memory being bottleneck).

The kernel also provides other mechanisms to restrict number of tasks --
threads-max sysctl and RLIMIT_NPROC with memory-scaled defaults and
generic pids cgroup controller (the last one being the solution of
fork-bombs, with qualified limits set up by admin).

The kernel provides mechanisms, while it should not imply policies --
default pid_max seems to be an example of the policy that does not fit
all. At the same time pid_max must have some value assigned, so use the
end of the allowed range -- pid_max_max.

This change thus increases initial pid_max from 32k to 4M (x86_64
defconfig).

This has effect on size of structure that alloc_pid/idr_alloc_cyclic
eventually uses and structure that kernel tracing uses with
'record-tgid' (~16 MiB).

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/linux/pid.h     |  4 ++--
 include/linux/threads.h | 15 ++++-----------
 kernel/pid.c            |  8 +++-----
 3 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index a3aad9b4074c..0d191ac02958 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -106,8 +106,8 @@ extern void exchange_tids(struct task_struct *task, struct task_struct *old);
 extern void transfer_pid(struct task_struct *old, struct task_struct *new,
 			 enum pid_type);
 
-extern int pid_max;
-extern int pid_max_min, pid_max_max;
+extern int pid_max_min, pid_max;
+extern const int pid_max_max;
 
 /*
  * look up a PID in the hash table. Must be called with the tasklist_lock
diff --git a/include/linux/threads.h b/include/linux/threads.h
index c34173e6c5f1..43f8f38a0c13 100644
--- a/include/linux/threads.h
+++ b/include/linux/threads.h
@@ -22,25 +22,18 @@
 
 #define MIN_THREADS_LEFT_FOR_ROOT 4
 
-/*
- * This controls the default maximum pid allocated to a process
- */
-#define PID_MAX_DEFAULT (CONFIG_BASE_SMALL ? 0x1000 : 0x8000)
-
 /*
  * A maximum of 4 million PIDs should be enough for a while.
  * [NOTE: PID/TIDs are limited to 2^30 ~= 1 billion, see FUTEX_TID_MASK.]
  */
 #define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
-	(sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
+	(sizeof(long) > 4 ? 4 * 1024 * 1024 : 0x8000))
 
 /*
- * Define a minimum number of pids per cpu.  Heuristically based
- * on original pid max of 32k for 32 cpus.  Also, increase the
- * minimum settable value for pid_max on the running system based
- * on similar defaults.  See kernel/pid.c:pid_idr_init() for details.
+ * Define a minimum number of pids per cpu. Mainly to accommodate
+ * smpboot_register_percpu_thread() kernel threads.
+ * See kernel/pid.c:pid_idr_init() for details.
  */
-#define PIDS_PER_CPU_DEFAULT	1024
 #define PIDS_PER_CPU_MIN	8
 
 #endif
diff --git a/kernel/pid.c b/kernel/pid.c
index da76ed1873f7..24ae505ac3b0 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -60,10 +60,10 @@ struct pid init_struct_pid = {
 	}, }
 };
 
-int pid_max = PID_MAX_DEFAULT;
+int pid_max = PID_MAX_LIMIT;
 
 int pid_max_min = RESERVED_PIDS + 1;
-int pid_max_max = PID_MAX_LIMIT;
+const int pid_max_max = PID_MAX_LIMIT;
 /*
  * Pseudo filesystems start inode numbering after one. We use Reserved
  * PIDs as a natural offset.
@@ -652,9 +652,7 @@ void __init pid_idr_init(void)
 	/* Verify no one has done anything silly: */
 	BUILD_BUG_ON(PID_MAX_LIMIT >= PIDNS_ADDING);
 
-	/* bump default and minimum pid_max based on number of cpus */
-	pid_max = min(pid_max_max, max_t(int, pid_max,
-				PIDS_PER_CPU_DEFAULT * num_possible_cpus()));
+	/* bump minimum pid_max based on number of cpus */
 	pid_max_min = max_t(int, pid_max_min,
 				PIDS_PER_CPU_MIN * num_possible_cpus());
 	pr_info("pid_max: default: %u minimum: %u\n", pid_max, pid_max_min);
-- 
2.44.0


