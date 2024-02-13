Return-Path: <linux-kernel+bounces-63586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8D98531D1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7F028C3D5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AF45646A;
	Tue, 13 Feb 2024 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="a6eoaBIp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OEHAVu57"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E003655C1D;
	Tue, 13 Feb 2024 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830751; cv=none; b=XZenOsOTEpJRdIwvVClwT9HtmwSNwJUcDUm/Zvc7PKfVLdtNTNrgi6bPbZkuljbn9n7rA6BqUOdIAjoXVewH2Uh+5h76tR984hus1So+r2p92WuO5Z1AqFRPgNW1DpLLohP+TRunogXTXQdHk/76jD6M92oIJGigywb298jTGag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830751; c=relaxed/simple;
	bh=ibVHfFsPFcvSEZ7/yr/9ehuQbI8jeSYbWCxBJlh89tY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RsLXo1ObxOLtaIlGvtfyg7vhetpm8NTmeUNothPkKWCi7vUM9VvB6pXSEb90PMSB8/cztlz3oqdRqe89yt38Wq2NfPpCzWxlXxxTF7Vs/AhNJWRAYLU5s1iP2lzUOwmD2nk37Q/r9CZmpc1kA4jqrnw82JKS5VlagZGD/d6k8pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=a6eoaBIp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OEHAVu57; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE10721F9A;
	Tue, 13 Feb 2024 13:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707830748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UD49cq/Gzb+y6/AtUpmsq4G9cGtvq1kVLdo8fHtz7EE=;
	b=a6eoaBIpcKAjo+ieKqHcPph35KLF6tQEL8BzTVtiBtN++TrodQa5xpkFKaOKQGEpjkkm9s
	d+TKbZacIZbDYo+dcht7j2UYu99jHANsbHiXZ6I0S8BzlaRQAXu+hDrj6gDMeZxSJSTrHi
	bc7WJZseuG3Vb6ClIjPWQsfC5GusLao=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707830747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UD49cq/Gzb+y6/AtUpmsq4G9cGtvq1kVLdo8fHtz7EE=;
	b=OEHAVu57ZvMBEUh7xTEdmdYpQDqlNb8nP+saeshxetOx4KdA4bgUHUZfrO1jwymwkZPVyJ
	fx1fLG8h5+HfWQ6k7+/vPyMbkxgi2ByFIqGpuS8c6o+cBuR/I6OgYM7Gii3SxjLOujSajG
	UWPRkQc3OD6zdkyH011FLisX2krvGx0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFB031370C;
	Tue, 13 Feb 2024 13:25:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H51pNttty2VFGAAAD6G6ig
	(envelope-from <petr.pavlu@suse.com>); Tue, 13 Feb 2024 13:25:47 +0000
From: Petr Pavlu <petr.pavlu@suse.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	jolsa@kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH] tracing: Fix HAVE_DYNAMIC_FTRACE_WITH_REGS ifdef
Date: Tue, 13 Feb 2024 14:24:34 +0100
Message-Id: <20240213132434.22537-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OEHAVu57
X-Spamd-Result: default: False [4.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[41.15%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.69
X-Rspamd-Queue-Id: EE10721F9A
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

Commit a8b9cf62ade1 ("ftrace: Fix DIRECT_CALLS to use SAVE_REGS by
default") attempted to fix an issue with direct trampolines on x86, see
its description for details. However, it wrongly referenced the
HAVE_DYNAMIC_FTRACE_WITH_REGS config option and the problem is still
present.

Add the missing "CONFIG_" prefix for the logic to work as intended.

Fixes: a8b9cf62ade1 ("ftrace: Fix DIRECT_CALLS to use SAVE_REGS by default")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c060d5b47910..83ba342aef31 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5331,7 +5331,7 @@ static int register_ftrace_function_nolock(struct ftrace_ops *ops);
  * not support ftrace_regs_caller but direct_call, use SAVE_ARGS so that it
  * jumps from ftrace_caller for multiple ftrace_ops.
  */
-#ifndef HAVE_DYNAMIC_FTRACE_WITH_REGS
+#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS
 #define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_ARGS)
 #else
 #define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS)

base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
-- 
2.35.3


