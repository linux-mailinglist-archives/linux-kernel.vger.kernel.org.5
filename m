Return-Path: <linux-kernel+bounces-128784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7676895F82
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F5A28167A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1BA16A1EE;
	Tue,  2 Apr 2024 22:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NXYykXZ3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E8ZXF0KY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A42E161B53
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095911; cv=none; b=Hdmy0iQP1HfSzqbxtdvVkgfY50HEj9ZOwMnKrlhtuJWF/ldoAASdKy5gicwFqu7+Lgaf0lj0PPbUU8dQnJ5IL93tiUv9Kmv3tvZVj3rW+WuPHi47akjua+8Sh8VqiD7sCFR7jXoSkROskmgYjwVdJavBor+2YbZfnprtbc7w6Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095911; c=relaxed/simple;
	bh=AEn1kMCZQRezyf2WMmaayQEC4zAM6aF9ELGCLd+z7bI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nIfocT9qEQ0iJ++TsgGXrOjR5pgvnSe5twqwW9kdj06CmU0YiT/tfh1h3MPQ7sjC7ROyelE82pe2LSc7i8t+veQLQ/IOWk6wWwNqweF4zY6D0OMDAldal4/aoJ6s/gtfZWt+zHwZ1RcWHk9syM/ff1+hOxfkArN8TxYlwbn+in8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NXYykXZ3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E8ZXF0KY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWb2ejOVxlZ3v7+K9dsSM3w74v6x9Bx6kvybMFlfTXc=;
	b=NXYykXZ3wBR6jVDDnE7QmpKfTlFvQ68QfjHGjE6pMty5wKbhJe1ClSymgkx+CMPs8old1Q
	+He78mUJwd2g+gvwAjKgiLfIZpaMbcUBQVTJkK9ijQkx6fl4OVf5S8zDdhZcOkumJlrW1j
	sUKo5O4sewMFCZP3unD9knwNbgppiqBqdABKCUqVZ+NuZ7CzyRrEVzKNCK1ccRsrTOsnoc
	DlW0qw39tFfAV5Yw0W9uElxIdsZsM3g+8B+2QSJ/lj8tzbQPz3FfAUSLeGmQHAGpguibNT
	z1SJt/Ux4Z4qQ/t4i/ZsrDE6F36tm8RHkSm2Ial4bTgFU51TqowYy2DpJn61rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWb2ejOVxlZ3v7+K9dsSM3w74v6x9Bx6kvybMFlfTXc=;
	b=E8ZXF0KYj3Y3uxpQRkkUOfwub2nPQKvnrOk3dEgZKOEekOxHQQYCl7782XAoSRAHN8+P6/
	alre4vb83o68ARDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Lukas Wunner <lukas@wunner.de>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH printk v4 24/27] panic: Mark emergency section in warn
Date: Wed,  3 Apr 2024 00:17:26 +0206
Message-Id: <20240402221129.2613843-25-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
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


