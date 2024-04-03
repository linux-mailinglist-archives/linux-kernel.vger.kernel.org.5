Return-Path: <linux-kernel+bounces-129228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A538896759
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC5A1F27214
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D986CDC2;
	Wed,  3 Apr 2024 07:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WyH6tedh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rHtsWKSy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A887286A6;
	Wed,  3 Apr 2024 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131068; cv=none; b=TObUu6Di80Ynbu/YcqQ8GUrap8+rfJ5dREJ8OL2jdb0lp/I/5r5PpaJCu0NOBqVMW9g7TOnuReLjusa/9aPtt4MwA3XSRISLPEpE60nGexuQ3EoBrs9sfDYsBYXdhc2JpY9TxepARJEovwaOrSEYbHPdom4ktwR6MBXqw1wW3z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131068; c=relaxed/simple;
	bh=1BKrRh4jCLaZG7GlkJVWPSFj8qS+m+uzp2aHQHIajHw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ilLk9dDMoElCXcle2JAarAABZW4Qy5ROebe/y0PKeqe6ExyDDBc99xIpITSzbYqeBh1nr95urwK/vV5Bqh5uosFMeNaEHo+KRbeJhyrsqrTjLyFKeKu2eWjkuRC3k1zIX55cxPKjN31ufmf7+jIaISRxoXgDiJKcaxBhw6+zG/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WyH6tedh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rHtsWKSy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Apr 2024 07:57:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712131065;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8hnsAJF50xd6gSWbPnRJLLUi1CEbJd9wSyZtF23iRQ=;
	b=WyH6tedh8nek4rybejf/xkWMpC+LkfnmSThGHklOZVSQgTJq2v0WPKTjWEQpLRA0+mnWYD
	oGvE2bYzL/OMq96SCjU6nxN7oVDoYhiZ/d0vZLANuRp6bkDkRR6nIHrBvhPAtzBD0gGPNj
	ZSsd/nvqhCQ+SqbVt7SJkos4Ehwc2Q1rw3pnEfR4KpXd/sGM4JmSGi9oZH5w+NsfrfNdkN
	OfycmT96PbBO9at0hButrwDWsggs7Qp+W1gaPAgFyQlqBsz9tjk/E5XTE3QRSiITYWxQaF
	S34YvS6fHzl0Whm/cPd/z8dJJGTL6S2Y6wqKLVjHRT1lRa3d3l6QoZUlVyYc7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712131065;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8hnsAJF50xd6gSWbPnRJLLUi1CEbJd9wSyZtF23iRQ=;
	b=rHtsWKSyUu+raHf+LTzw7A7JnNh/Xyh8gHd1Lay9BSmQijzlm6kYb+RC/+i941TibL6cpm
	3GRgNZ58YQaim0DA==
From: "tip-bot2 for Avadhut Naik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] tracing: Add the ::ppin field to the mce_record tracepoint
Cc: Avadhut Naik <avadhut.naik@amd.com>, Ingo Molnar <mingo@kernel.org>,
 Sohil Mehta <sohil.mehta@intel.com>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240401171455.1737976-2-avadhut.naik@amd.com>
References: <20240401171455.1737976-2-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171213106485.10875.12804346187076671037.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     98430645e383404e5f6f784cabbb08ebb4ac5499
Gitweb:        https://git.kernel.org/tip/98430645e383404e5f6f784cabbb08ebb4ac5499
Author:        Avadhut Naik <avadhut.naik@amd.com>
AuthorDate:    Mon, 01 Apr 2024 12:14:54 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Apr 2024 09:39:29 +02:00

tracing: Add the ::ppin field to the mce_record tracepoint

Machine Check Error information from 'struct mce' is exposed to userspace
through the mce_record tracepoint.

Currently, however, the PPIN (Protected Processor Inventory Number) field
of 'struct mce' is not exposed.

Add a PPIN field to the tracepoint as it provides a unique identifier for
the system (or socket in case of multi-socket systems) on which the MCE
has been received.

Also, add a comment explaining the kind of information that can be and
should be added to the tracepoint.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20240401171455.1737976-2-avadhut.naik@amd.com
---
 include/trace/events/mce.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 9c4e121..294fccc 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -9,6 +9,14 @@
 #include <linux/tracepoint.h>
 #include <asm/mce.h>
 
+/*
+ * MCE Event Record.
+ *
+ * Only very relevant and transient information which cannot be
+ * gathered from a system by any other means or which can only be
+ * acquired arduously should be added to this record.
+ */
+
 TRACE_EVENT(mce_record,
 
 	TP_PROTO(struct mce *m),
@@ -25,6 +33,7 @@ TRACE_EVENT(mce_record,
 		__field(	u64,		ipid		)
 		__field(	u64,		ip		)
 		__field(	u64,		tsc		)
+		__field(	u64,		ppin		)
 		__field(	u64,		walltime	)
 		__field(	u32,		cpu		)
 		__field(	u32,		cpuid		)
@@ -45,6 +54,7 @@ TRACE_EVENT(mce_record,
 		__entry->ipid		= m->ipid;
 		__entry->ip		= m->ip;
 		__entry->tsc		= m->tsc;
+		__entry->ppin		= m->ppin;
 		__entry->walltime	= m->time;
 		__entry->cpu		= m->extcpu;
 		__entry->cpuid		= m->cpuid;
@@ -55,7 +65,7 @@ TRACE_EVENT(mce_record,
 		__entry->cpuvendor	= m->cpuvendor;
 	),
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR: %016Lx, MISC: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR: %016Lx, MISC: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x",
 		__entry->cpu,
 		__entry->mcgcap, __entry->mcgstatus,
 		__entry->bank, __entry->status,
@@ -65,6 +75,7 @@ TRACE_EVENT(mce_record,
 		__entry->synd,
 		__entry->cs, __entry->ip,
 		__entry->tsc,
+		__entry->ppin,
 		__entry->cpuvendor,
 		__entry->cpuid,
 		__entry->walltime,

