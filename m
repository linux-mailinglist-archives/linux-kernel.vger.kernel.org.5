Return-Path: <linux-kernel+bounces-166977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C018BA289
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A55528C91D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A3E20FA9C;
	Thu,  2 May 2024 21:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a26noFQ9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UB4dx3u/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1A01CB334
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685938; cv=none; b=S0m5lfC0qFKU/r4TCtMqFSziJvdb6Vk2AltgrBpOe+XG0K29kOfQyGRLzXt15ZISiPFc9KNDVj2iNItUSwSRLNU8SE0lMoM3BaJqUwjyZGD2rI9nZyhRR+X3dqFFDXSAAI/328oatDq6BzMkEbc5/I8qbYjyGFi1Ekmq5vSDLio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685938; c=relaxed/simple;
	bh=sIDwBVtEZ9II9z34FVW/arDvGAYqJE9qC2xSXnoiiY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cD8SKoqkbIA5PxtWnl1BU/kQHl2QvhfSVH1BRkDvnVxZbPP8bawyhoAsMfzmr5IhyXcxrP8PKYOEm4VgVDrR4v2eV0/ldMGrAW248ouaQ/9AfozWFhdbtvLgGPHEAO4blTS13qAors3Gl3La5EfPNthWP/OexCoP/57vD7WeaOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a26noFQ9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UB4dx3u/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02mlGKrKUI3gQEB07A6y9zFTpJYkffg7XWV4RkY45mg=;
	b=a26noFQ9VHSBNGAz/Zf3ay3EJNiHrzvKdrHmERLizb1irxGUdVyR/YY3YMueIhuoxFqKQ0
	IJHSjYGaYGOA4XUYSeOumtVWycJKnO7KWQx8LubIxcab8aqXO96D3pUMa0ImyDAf/pbWkN
	P8yNWOEXNM8GXK3UjEZR1y9ssUhH3SloV4UGq/415wm5ONyYmqpqRUByR96+U7ZNpK8mxv
	G+VVivHdhVgaqIN/0Uq8aKwx5euxEedx96o39X+12B7IHtD9xAl3p6Agmxkz15Q538JFsp
	/Q55TQ0HjwTDD7pnKaXbuFAeib1YEAyvPwYWPQu6cLz66ExorQWqNKrZv0D+lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02mlGKrKUI3gQEB07A6y9zFTpJYkffg7XWV4RkY45mg=;
	b=UB4dx3u/PO58OnwfwIPQI/9jr+UCmR8vKb2hurmxCwEkii5uFJJLOtxgRyVLRv7rLnXcaI
	JZotGhzCIm1HLOBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH printk v5 27/30] panic: Mark emergency section in warn
Date: Thu,  2 May 2024 23:44:36 +0206
Message-Id: <20240502213839.376636-28-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

Mark the full contents of __warn() as an emergency section. In
this section, the CPU will not perform console output for the
printk() calls. Instead, a flushing of the console output is
triggered when exiting the emergency section.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/panic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index de8115c829cf..ee03193f9495 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -667,6 +667,8 @@ struct warn_args {
 void __warn(const char *file, int line, void *caller, unsigned taint,
 	    struct pt_regs *regs, struct warn_args *args)
 {
+	nbcon_cpu_emergency_enter();
+
 	disable_trace_on_warning();
 
 	if (file)
@@ -697,6 +699,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 
 	/* Just a warning, don't kill lockdep. */
 	add_taint(taint, LOCKDEP_STILL_OK);
+
+	nbcon_cpu_emergency_exit();
 }
 
 #ifdef CONFIG_BUG
-- 
2.39.2


