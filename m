Return-Path: <linux-kernel+bounces-142460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 409E48A2BD6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05772876B9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB2F54F8D;
	Fri, 12 Apr 2024 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ox3vR40S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qvzhoytv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC93A53815;
	Fri, 12 Apr 2024 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916210; cv=none; b=uis+/Wx2EnZfwJig3A7K89n4cUt1RbqR9JMJM+goS1HQ1kUAgmS4q5G5SDy1XD6XLBcS9iQHU0vNKJEHthd9iyFQLVSzkLbRO/qaRJ0wbKGjoD6VvH9krtcSr5nLj3IUFjtL4hYrvn8CnPCKxHPycdHzZsZwAbP7TWKksur7Wo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916210; c=relaxed/simple;
	bh=lCNee1828QqqQR3hshc5fVcZzrHDapC+fJ9N5c+1IIs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HpvUbtYo2gc6Jcr+H94HVtJSRFd1HsLqcnWbr8meFFZDeygdWtLbipkBOYueV/XdBMeozi6ychuWjdwl3lekCEdxQQiVAVCnEx26653loQYhYZtWNk456XAf3RsIykFrQqk+91PMyR7MIbdNC/2TpbbLzKf1UOPMnqKfsNTIHuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ox3vR40S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qvzhoytv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 10:03:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712916206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4CrUIsikDc930c3uKYQLq7h6pHpykCaDJGjbMGxQ6OU=;
	b=ox3vR40SrhvJ6BRFN/O2LtQL6g3joQb7Jyf1fsbgFbnYSjsRcG6Dn4jpQhgEgAGE895/uk
	0tIGRL9lgAZgoqkvAmV/ldTDB5R5nKYTzcS89QqvNRkRNenBjWpHqhy5JDUG/CSnGDjvtJ
	5R0QO/gUAVTy7f+Lrkjg++bkmzth3lJ/SKyP7P5aRg3UvEXGXRxVdDhw837oH1AtIyPT1J
	2rItxMhBxiMrsDNbsOoyit2skUYGmoMFKNX0hnFMj9UoS/h/3Wd1r/A59RQkEtM2C2Qs3p
	rvZpjQSHncdtVqZzqgUVDErkIIRPQfKxR6CibFjNIZQHQxDD1oaN+YEPV+m4bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712916206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4CrUIsikDc930c3uKYQLq7h6pHpykCaDJGjbMGxQ6OU=;
	b=qvzhoytvg0bIKxWOvWyE5nMN4YLPr+9gnsyDPtjUFoXoCasCJBMHabz5pLh85m2N9yKXLU
	5IQ345QN/NfLv9Aw==
From: "tip-bot2 for Kyle Huey" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/bpf: Remove #ifdef CONFIG_BPF_SYSCALL from
 struct perf_event members
Cc: Ingo Molnar <mingo@kernel.org>, Kyle Huey <khuey@kylehuey.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240412015019.7060-4-khuey@kylehuey.com>
References: <20240412015019.7060-4-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171291620574.10875.5995937196604251484.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     14e40a9578b70cc5323e55f61292a7e021f6037c
Gitweb:        https://git.kernel.org/tip/14e40a9578b70cc5323e55f61292a7e021f6037c
Author:        Kyle Huey <me@kylehuey.com>
AuthorDate:    Thu, 11 Apr 2024 18:50:15 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Apr 2024 11:49:49 +02:00

perf/bpf: Remove #ifdef CONFIG_BPF_SYSCALL from struct perf_event members

This will allow __perf_event_overflow() (which is independent of
CONFIG_BPF_SYSCALL) to use struct perf_event's prog to decide whether to
call bpf_overflow_handler().

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240412015019.7060-4-khuey@kylehuey.com
---
 include/linux/perf_event.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3e33b36..50e01db 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -809,11 +809,9 @@ struct perf_event {
 	u64				(*clock)(void);
 	perf_overflow_handler_t		overflow_handler;
 	void				*overflow_handler_context;
-#ifdef CONFIG_BPF_SYSCALL
 	perf_overflow_handler_t		orig_overflow_handler;
 	struct bpf_prog			*prog;
 	u64				bpf_cookie;
-#endif
 
 #ifdef CONFIG_EVENT_TRACING
 	struct trace_event_call		*tp_event;

