Return-Path: <linux-kernel+bounces-56566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7381B84CBCE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA262860A7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131BE7CF0D;
	Wed,  7 Feb 2024 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WRiRArBf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rQSEKUb6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0065A118
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313281; cv=none; b=nx1GgXbXrRAcGJ4HNYLK6q/kM6ue6BB2drtXgTzGAOq+O23xGXh2SrSEOKdUMlc33/GAPRGVN1+s7kvlXkM+0xFQNoxw1EgncKrZxJKv2jUM3TJOSDP/WLVL6/aLt4h9PCmqxrL1LaCLtrpZujF5Vw/NmAB1PKzR51CzbRxc7CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313281; c=relaxed/simple;
	bh=vJqxW1p5ntcV7Q8gHg+dKNeHrRgOFCslGbsANTaGJrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SN0pI/PIuaQZW7hD+h4+xjmhS8tzAW/fuA2UVi75SGmgF+bv01DIpYmfqVrSUq/Thu40RBh/j9Ii/e2grr69prwq3JNFR4zRZeDuRkge3Y/eUBNh3fyPxYDw0DYgMWQhRfJ7BUmc0MbvusFx/ktLbvu4IF4rfqNR/6Mmx4+br1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WRiRArBf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rQSEKUb6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707313275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=krH2QkxdJALvXRu9Bq+Fw3gs7PqsPIKkUheQqZKkVK0=;
	b=WRiRArBfTTPvencS3aNMh6U5Jll4BkBh3TxSXBL1CoGcfofnV9slVz9bHirftVZ+t5pBg4
	EzczG4kxp49nz9+pUSB4YoXGZTnDRuG6ME5AcfuTctIYW4mDScQitWszFD8lECQe2H7WoU
	nGfzxZUpCCqfHaDeBxsbe+QZq+adxDbr6xjQlnoZ6qFQuiKmigH3jZLfkFgD5ZvuefAKm1
	wzW2N8S4c/1K0gcv5fcVI7Puhg+2fsKyx/UnTuOoozrgOJ8eqKb8GeeC4GrkUEbuqBHWOQ
	V5ASb+cBWeAX8yEibld4K2JztthP83EiGMLCwkkbA1qdo9OtMD3Vu6TO3gDMog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707313275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=krH2QkxdJALvXRu9Bq+Fw3gs7PqsPIKkUheQqZKkVK0=;
	b=rQSEKUb6LAdrLfbf/3uTISwSZSFmtlWYYHbFqF+X6t3mynIvhmFajaM7vSkWMB6D6NzSZj
	yM0rb7CMTdLBeWDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 06/14] printk: For @suppress_panic_printk check for other CPU in panic
Date: Wed,  7 Feb 2024 14:46:55 +0106
Message-Id: <20240207134103.1357162-7-john.ogness@linutronix.de>
In-Reply-To: <20240207134103.1357162-1-john.ogness@linutronix.de>
References: <20240207134103.1357162-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently @suppress_panic_printk is checked along with
non-matching @panic_cpu and current CPU. This works
because @suppress_panic_printk is only set when
panic_in_progress() is true.

Rather than relying on the @suppress_panic_printk semantics,
use the concise helper function other_cpu_in_progress(). The
helper function exists to avoid open coding such tests.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index be95a6851164..22bb45d8f2f2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2270,8 +2270,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (unlikely(suppress_printk))
 		return 0;
 
-	if (unlikely(suppress_panic_printk) &&
-	    atomic_read(&panic_cpu) != raw_smp_processor_id())
+	if (unlikely(suppress_panic_printk) && other_cpu_in_panic())
 		return 0;
 
 	if (level == LOGLEVEL_SCHED) {
-- 
2.39.2


