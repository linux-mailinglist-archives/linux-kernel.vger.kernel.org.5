Return-Path: <linux-kernel+bounces-135568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD33F89C7A7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A98E285A30
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04AE13F446;
	Mon,  8 Apr 2024 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Owog8HkE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eJiJB7Pp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65A7127B54;
	Mon,  8 Apr 2024 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588305; cv=none; b=bO7iZ5juU1J7BfUTDI6RXfALU2EveDNwyiqpnbjPC3gUCbMKoseWrdlXF5gWS9H/8OBUZ4UmP+zIusC9M8re7XH0f7HSV13L4blI4TfiZTNlN6xg3S66B6Fui+dvmpDvmfzgL4gECnayOuyxi4+c1jFvRxcZ8jTaGqr/6PmzarE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588305; c=relaxed/simple;
	bh=Vq9UE4oFVEBC3u6xpAf7VoHaSvXGu0QbBtJsYwS5Rb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MHD8J/ZzyAokqrp6fHuwKpZrwJnV+Zq/4TYfWDuIoRGO8KP5TWRWlD/zPtyRZsln0UHEUt90TsZkWzfsaashOgFbxNqTZTHHZDtY/HnqYd0Lni6TPTQ0PNnFY1buvaFFwMoNwTavJclCNp0/6cgfippryVr74EASxCcapgJhiLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Owog8HkE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eJiJB7Pp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF5B0229F9;
	Mon,  8 Apr 2024 14:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712588302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJrVwWdxkkiTZc1yahR+7aeNYeIbFQr7fotMaQYTpR0=;
	b=Owog8HkEfsuIxJ8C0wwnkm7E5aijikkK4WV0OVwnHYZ5rlKf11wfho1iqM0D/eFVu/VNKk
	TFG2HboKjiaqBHuQ0BZXfrC7iiYTE4keFXFM5LaRG+HOwyNqTyGmkAbijZLy5mUUqB8Bui
	yf0Jh/eRF6uCdLdsmeWq0emWnZm4cis=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=eJiJB7Pp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712588301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJrVwWdxkkiTZc1yahR+7aeNYeIbFQr7fotMaQYTpR0=;
	b=eJiJB7Pp+/l2J66TVKbOj4zRj7KvHYLXEAF8LVydYpwEEMGmpamUQTbtX3BtpjRCykw54n
	gNwML15JTtIDd0HaT1WfnjP9XB/k50JwN99n9WyM9LzlXOnztaxyR88SZd+AGnNfwJI6AQ
	QMSVIuch1l2tXzgBEGSl/5FEs9WrsO8=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BE57D13AA2;
	Mon,  8 Apr 2024 14:58:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id YAlKLg0GFGa8dgAAn2gu4w
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
Subject: [PATCH 1/3] tracing: Remove dependency of saved_cmdlines_buffer on PID_MAX_DEFAULT
Date: Mon,  8 Apr 2024 16:58:17 +0200
Message-ID: <20240408145819.8787-2-mkoutny@suse.com>
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
X-Spamd-Result: default: False [-0.52 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.01)[50.28%];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	R_RATELIMIT(0.00)[to_ip_from(RLbzsy9nfkyasyfk9a5p8bmpf9)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -0.52
X-Spamd-Bar: /
X-Rspamd-Queue-Id: DF5B0229F9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

Calculations into map_pid_to_cmdline use PID_MAX_DEFAULT but they
actually depend on the size of map_pid_to_cmdline. The size of the map
may be arbitrary. First, refer to the map size where necessary, second,
pick a good value for the size of the map.
Since the buffer is allocated at boot (i.e. user cannot affect its size
later), accounting for full PID_MAX_LIMIT would inflate map's size
unnecessarily (4*4M) for all users. Stick to the original value of
4*32k, the commit 785e3c0a3a87 ("tracing: Map all PIDs to command
lines") explains why it still works for higher pids.

The point of this exercise is to remove dependency on PID_MAX_DEFAULT.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/trace/trace_sched_switch.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index 8a407adb0e1c..aca2dafdd97a 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -161,6 +161,7 @@ static size_t tgid_map_max;
 
 #define SAVED_CMDLINES_DEFAULT 128
 #define NO_CMDLINE_MAP UINT_MAX
+#define PID_MAP_SIZE (CONFIG_BASE_SMALL ? 0x1000 : 0x8000)
 /*
  * Preemption must be disabled before acquiring trace_cmdline_lock.
  * The various trace_arrays' max_lock must be acquired in a context
@@ -168,7 +169,7 @@ static size_t tgid_map_max;
  */
 static arch_spinlock_t trace_cmdline_lock = __ARCH_SPIN_LOCK_UNLOCKED;
 struct saved_cmdlines_buffer {
-	unsigned map_pid_to_cmdline[PID_MAX_DEFAULT+1];
+	unsigned map_pid_to_cmdline[PID_MAP_SIZE];
 	unsigned *map_cmdline_to_pid;
 	unsigned cmdline_num;
 	int cmdline_idx;
@@ -248,7 +249,7 @@ int trace_save_cmdline(struct task_struct *tsk)
 	if (!tsk->pid)
 		return 1;
 
-	tpid = tsk->pid & (PID_MAX_DEFAULT - 1);
+	tpid = tsk->pid % PID_MAP_SIZE;
 
 	/*
 	 * It's not the end of the world if we don't get
@@ -294,7 +295,7 @@ static void __trace_find_cmdline(int pid, char comm[])
 		return;
 	}
 
-	tpid = pid & (PID_MAX_DEFAULT - 1);
+	tpid = pid % PID_MAP_SIZE;
 	map = savedcmd->map_pid_to_cmdline[tpid];
 	if (map != NO_CMDLINE_MAP) {
 		tpid = savedcmd->map_cmdline_to_pid[map];
@@ -645,8 +646,8 @@ tracing_saved_cmdlines_size_write(struct file *filp, const char __user *ubuf,
 	if (ret)
 		return ret;
 
-	/* must have at least 1 entry or less than PID_MAX_DEFAULT */
-	if (!val || val > PID_MAX_DEFAULT)
+	/* must have at least 1 entry or fit into map_pid_to_cmdline */
+	if (!val || val >= PID_MAP_SIZE)
 		return -EINVAL;
 
 	ret = tracing_resize_saved_cmdlines((unsigned int)val);
-- 
2.44.0


