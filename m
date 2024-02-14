Return-Path: <linux-kernel+bounces-65269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D71854A63
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273F328E9F3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6D654F9C;
	Wed, 14 Feb 2024 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqQ1kvx/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB3054FA1;
	Wed, 14 Feb 2024 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707916957; cv=none; b=lpD3AOGaBIp6QoOS78WOfeMKCr/CnnpB2wWxTX6jjeyN55DB84DtFF0g5CMK3v6cfvetNEcmyO1CtpD2UIn73sQOFLDJs7JKovZiLcSHuPgbfzFdKllJ2lZBJ5MtA/mMgI0pLR33sYJLUdi/SKd37ZkMSy9ZuE5SqhmoBdW71i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707916957; c=relaxed/simple;
	bh=uBscQYEWaOjRVRSlzctG/Sn/fNhszLxXKt2J3iXHHPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUhE5l1DmibUKjz4BIGQUtXdyJd8fWBeXdBc88hyJJHNpLBhFD0fvzmmjnHa/5l7QNccjcnW3nU5Q2Fc1UJxMyVK/TQP0xk0RKi7Si2p4OQaOdQLkrsT2zhrD3GFxbZKpITJnnxAndCKbj8BtGJkAjVOi7q8uzXs5/2dy4NCZXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqQ1kvx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C48CC433C7;
	Wed, 14 Feb 2024 13:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707916956;
	bh=uBscQYEWaOjRVRSlzctG/Sn/fNhszLxXKt2J3iXHHPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hqQ1kvx/k+fQ6qWjv3Nf1zCZzr/SqN2GZsI6sY2JDEXC68hJPb6hGeOb5+xE0Wg7F
	 Ea18k+9Aq+5YJgivrWW6GReJOEAsm1QDCKphGtY2qMutXq6kZnaQbkb9hqR6IAU/Z2
	 85L13JIyyfvR80RbAGA+6/uK+KVDyVAJMYLO+6ed5+ionJc6rCS9xo+dews2syWr87
	 KPLZQGgImJvSBBs+tgqp9GLv/iM3AuOU+N1+iQ0yRrDJKM7dKAzsH3vQocSwBAw50X
	 UbTDo0U1lx5lGPkkuR/1WPqod4Jgqagg2hR8lx4Go9ey3Vyl4PqqpEZQVau3Us0MMk
	 azxa12oOvLkBQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org
Subject: [PATCH RFC 2/5] tracing/fprobe-event: cleanup: Fix a wrong comment in fprobe event
Date: Wed, 14 Feb 2024 22:22:32 +0900
Message-Id: <170791695283.389532.14517656803358182473.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170791693437.389532.6816883363982512874.stgit@devnote2>
References: <170791693437.389532.6816883363982512874.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Despite the fprobe event,  "Kretprobe" was commented. So fix it.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_fprobe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 7d2ddbcfa377..3ccef4d82235 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -210,7 +210,7 @@ fentry_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
 }
 NOKPROBE_SYMBOL(fentry_trace_func);
 
-/* Kretprobe handler */
+/* function exit handler */
 static nokprobe_inline void
 __fexit_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
 		   unsigned long ret_ip, struct pt_regs *regs,


