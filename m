Return-Path: <linux-kernel+bounces-135567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9228D89C7A6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B821C21993
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B5F13F443;
	Mon,  8 Apr 2024 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kyKRGI0F";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kyKRGI0F"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0080013EFE3;
	Mon,  8 Apr 2024 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588305; cv=none; b=H8SKeGatTZxB7BodTcc7mjp2UXIqtbVifqHK5QfMQn5d7f2xiysXObd/rF54JwkqTygv3wGv+L6jO4qaeQvk6x+67tfKHyycDSuOKZNWDyYNg0b3vxXx+m5Jl9WXaPsxTBEppYBiO8mkkoam7dYiV6IYh3+wRP/OLCNJd2KqeAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588305; c=relaxed/simple;
	bh=LwifpkONrUkWLyBk8gbNdvhiMcqi281CAICCZSh3f7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKgg9fLy1coGSTSogPwbDWJlv8ltrZZrYXaeMLcyOx3XoX9Oec2xc57rPipo0j+/mQuZZMM7dFJCvt3nXL0ENm72v0EJgeykpMYLyDjxPbsXYBngndJ9Nz/gYBGpzJ00DO8AcL6/hmi7qDXga/Le6xsm2CkOSkKI9ZagfM9v/D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kyKRGI0F; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kyKRGI0F; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1F791229FB;
	Mon,  8 Apr 2024 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712588302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rbXAunVKbUV1XwN367Y+XydNp2/9W1e0lOfKLCJipg=;
	b=kyKRGI0FcxpevV6x3NfZMC5Decj/TV0PerpAe/1hTi6et5v4cQEV4Srt+H9/UQMQ/VhQ5W
	7plLn2bhAQzqcS19/Y9PjEtD+VYz7dgpn8DslW/vKsSwast3bQd3+qAo6oVkaSs0C6b96R
	iXytpSk2/gXNIRvfUTEbsVkZ7oNDNLw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712588302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rbXAunVKbUV1XwN367Y+XydNp2/9W1e0lOfKLCJipg=;
	b=kyKRGI0FcxpevV6x3NfZMC5Decj/TV0PerpAe/1hTi6et5v4cQEV4Srt+H9/UQMQ/VhQ5W
	7plLn2bhAQzqcS19/Y9PjEtD+VYz7dgpn8DslW/vKsSwast3bQd3+qAo6oVkaSs0C6b96R
	iXytpSk2/gXNIRvfUTEbsVkZ7oNDNLw=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 04B1F13AB3;
	Mon,  8 Apr 2024 14:58:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 8Df/AA4GFGa8dgAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Mon, 08 Apr 2024 14:58:22 +0000
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
Subject: [PATCH 3/3] tracing: Compare pid_max against pid_list capacity
Date: Mon,  8 Apr 2024 16:58:19 +0200
Message-ID: <20240408145819.8787-4-mkoutny@suse.com>
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
X-Spam-Flag: NO
X-Spam-Score: -0.30
X-Spam-Level: 
X-Spamd-Result: default: False [-0.30 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[43.99%];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:email]

trace_pid_list_alloc() checks pid_max against a magic number referencing
an (obsolete) source file when it actually should check against the
capacity of pid_list tree. Turn definition of MAX_PID around -- derive
it from tree parameters and replace references to magic value and
header files with so defined MAX_PID.
Should PID_MAX_LIMIT change in future or pid_max escapes PID_MAX_LIMIT,
appropriate checks remain in place. No functional change intended.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/trace/pid_list.c | 6 +++---
 kernel/trace/pid_list.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
index 95106d02b32d..b968f0b65dc1 100644
--- a/kernel/trace/pid_list.c
+++ b/kernel/trace/pid_list.c
@@ -93,7 +93,7 @@ static inline bool upper_empty(union upper_chunk *chunk)
 static inline int pid_split(unsigned int pid, unsigned int *upper1,
 			     unsigned int *upper2, unsigned int *lower)
 {
-	/* MAX_PID should cover all pids */
+	/* MAX_PID must cover all possible pids */
 	BUILD_BUG_ON(MAX_PID < PID_MAX_LIMIT);
 
 	/* In case a bad pid is passed in, then fail */
@@ -413,8 +413,8 @@ struct trace_pid_list *trace_pid_list_alloc(void)
 	struct trace_pid_list *pid_list;
 	int i;
 
-	/* According to linux/thread.h, pids can be no bigger that 30 bits */
-	WARN_ON_ONCE(pid_max > (1 << 30));
+	/* See pid_split(), equal to pid_max > PID_MAX_LIMIT */
+	WARN_ON_ONCE(pid_max > MAX_PID);
 
 	pid_list = kzalloc(sizeof(*pid_list), GFP_KERNEL);
 	if (!pid_list)
diff --git a/kernel/trace/pid_list.h b/kernel/trace/pid_list.h
index 62e73f1ac85f..28562a9a3d01 100644
--- a/kernel/trace/pid_list.h
+++ b/kernel/trace/pid_list.h
@@ -56,8 +56,8 @@
 
 #define UPPER_MASK	(UPPER_MAX - 1)
 
-/* According to linux/thread.h pids can not be bigger than or equal to 1 << 30 */
-#define MAX_PID		(1 << 30)
+/* Structure can hold only pids strictly below this limit */
+#define MAX_PID		(1 << (UPPER_BITS + UPPER_BITS + LOWER_BITS))
 
 /* Just keep 6 chunks of both upper and lower in the cache on alloc */
 #define CHUNK_ALLOC 6
-- 
2.44.0


