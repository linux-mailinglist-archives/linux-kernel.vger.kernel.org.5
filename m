Return-Path: <linux-kernel+bounces-135566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D584089C7D2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC94B2A17E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F37D13F43C;
	Mon,  8 Apr 2024 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MWmDryg5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MWmDryg5"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C655F1CD21;
	Mon,  8 Apr 2024 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588305; cv=none; b=Y5R+mSZD+Xy4GgilSScguShonn7ECavOBGEaICzBWiGi7gHUZDZZ5uCp/ekNn2/EYzx477ZnaefYbDmhHBdlIgOOn629AJ7b+EMAovNw3LHGJYhTJJOgJcCuMnow9cItudSQ9gIKDiwnyo/b7qj14f0hMurCNhVofrbm1U8y/Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588305; c=relaxed/simple;
	bh=eh0+8+0QYHNx18ZniBqXk+NH559KDLZlNIQrWVs8B48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n13ZFOKgITtLnevkFSc/8B8IeJ7/vQBY6SfcduFIZ7VkNa9nzXjfvzEhG8LU8EABn0NQaCEBCk1SySp0IuGG589f2RgGXjiHFQXrP3OYQ88ZsZQXfFq2oa6X+35gPHpZk3M+gLKrd3ZZBNhjk9qUqJzRQA6fWm5czUPx4Pyi1o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MWmDryg5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MWmDryg5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C22AA229F8;
	Mon,  8 Apr 2024 14:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712588301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l8Ews1UDHTZngMlqVjeOqPsy8QIWHPyWNH+7PJ6WHqA=;
	b=MWmDryg5V7v76GUBs3URy9bLz2NYPD2ri37XRKac4PcbW0dHKcPpy3ChjmOFBLhqIvmtuD
	V5O7z1jPZ7skjGNQ1w66r1kZrYzTCmDB1cU3kpDXfth855s3+YDVG23Ut+mZjmb6P96I3O
	LSSTYkkzZTiMtCHR9nAhw/yfhB4HwI0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=MWmDryg5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712588301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l8Ews1UDHTZngMlqVjeOqPsy8QIWHPyWNH+7PJ6WHqA=;
	b=MWmDryg5V7v76GUBs3URy9bLz2NYPD2ri37XRKac4PcbW0dHKcPpy3ChjmOFBLhqIvmtuD
	V5O7z1jPZ7skjGNQ1w66r1kZrYzTCmDB1cU3kpDXfth855s3+YDVG23Ut+mZjmb6P96I3O
	LSSTYkkzZTiMtCHR9nAhw/yfhB4HwI0=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A1C371332F;
	Mon,  8 Apr 2024 14:58:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 5bL/Jg0GFGa8dgAAn2gu4w
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
Subject: [PATCH 0/3] kernel/pid: Remove default pid_max value
Date: Mon,  8 Apr 2024 16:58:16 +0200
Message-ID: <20240408145819.8787-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-0.69 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	BAYES_HAM(-0.18)[70.45%];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: C22AA229F8
X-Spam-Flag: NO
X-Spam-Score: -0.69
X-Spamd-Bar: /

TL;DR excerpt from commit 02/03:

	The kernel provides mechanisms, while it should not imply policies --
	default pid_max seems to be an example of the policy that does not fit
	all. At the same time pid_max must have some value assigned, so use the
	end of the allowed range -- pid_max_max.

More details are in that commit's message. The other two commits are
related preparation and less related refresh in code that somewhat
references pid_max.

Michal Koutný (3):
  tracing: Remove dependency of saved_cmdlines_buffer on PID_MAX_DEFAULT
  kernel/pid: Remove default pid_max value
  tracing: Compare pid_max against pid_list capacity

 include/linux/pid.h               |  4 ++--
 include/linux/threads.h           | 15 ++++-----------
 kernel/pid.c                      |  8 +++-----
 kernel/trace/pid_list.c           |  6 +++---
 kernel/trace/pid_list.h           |  4 ++--
 kernel/trace/trace_sched_switch.c | 11 ++++++-----
 6 files changed, 20 insertions(+), 28 deletions(-)


base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
-- 
2.44.0


