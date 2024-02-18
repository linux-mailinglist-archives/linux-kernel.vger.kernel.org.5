Return-Path: <linux-kernel+bounces-70530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399238598E7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9950281239
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06C871B55;
	Sun, 18 Feb 2024 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V1z5I0ZK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JU0rh4zw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A866E71B36
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708283075; cv=none; b=ez9el1Zg1YONAVWSACvMwBGg0BR6uWH9bffocgEsOKNZsLPNAseXWHIhwguGSvYVazN0y0PhbZLlO1R0mPtzrr1myMtMncEuAqEBT0L/H4+Z+ti8UwkZ2VjI6ENbL0Bgw4CXZZs/8MhPNeRIrVis7iJIHGWR9vkwUd88vNDK+Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708283075; c=relaxed/simple;
	bh=UgNQzP2/u6tlCo+4rRFkvhUnGTuONwvzfEkavv5ocsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E2zdrv6mPAhcnDrTi8Ivm3sDgEER3FU0Tmep2FTPWpe6dC1wflNHyb+3Ufvl3L+FtL7H2LC+VNEzQ7gbKzISN9wtn45ifF+VVh295jovXXfpLPD4qJ0+Avm1kwpnIrNp2tx5pKAXILW5ybMvn7Q/vPEbZVIETavwZEQW8WlMJHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V1z5I0ZK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JU0rh4zw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xxlb5lhcjt/hac5FRx4FUo+WOPkTmWiB9/oYCJlGF7c=;
	b=V1z5I0ZKF4iHILJ11grW3yUcMsf6dzsgE9WmHuFW6u/mxsPMHOJ0NSsnRbXIC6b8V1T0Z9
	wqPspAxBrbJs7PJxTaKHgLbrdQPevNQ5dnXs6vXoyD+hrTN3n1gh+X8inITIaEMq3XNX8l
	dKXlX7bVC2Ea2M7PeM2Satzn9re/EfxAmImJYno6Owt6YqVpL7yIsWeXlWfziccFOTF7EL
	89bInQanbWKAzq0TvEvvLMh0Swdds4mpPwEcCIbCABldoG8S0gVmv9Lm/41vzLqA3jr5bT
	agzhWDfYaOcXGngoaxe8lTI2CS81GGXp1TVsB+vrx2AI7tD3/tARoptktJJG7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xxlb5lhcjt/hac5FRx4FUo+WOPkTmWiB9/oYCJlGF7c=;
	b=JU0rh4zwDuGsnP1WFQPCdy7oRZb7xMVV+ZfKxvMADbaw7dYlMWIc2fH5D4SMeMceDUvmUD
	nvvtMP+k9d9OBDDw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 04/26] printk: Consider nbcon boot consoles on seq init
Date: Sun, 18 Feb 2024 20:03:04 +0106
Message-Id: <20240218185726.1994771-5-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a non-boot console is registering and boot consoles exist, the
consoles are flushed before being unregistered. This allows the
non-boot console to continue where the boot console left off.

If for whatever reason flushing fails, the lowest seq found from
any of the enabled boot consoles is used. Until now con->seq was
checked. However, if it is an nbcon boot console, the function
nbcon_seq_read() must be used to read seq because con->seq is
always 0.

Check if it is an nbcon boot console and if so call
nbcon_seq_read() to read seq.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1685a71f3f71..696a9d76c09c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3391,11 +3391,20 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
 
 				newcon->seq = prb_next_seq(prb);
 				for_each_console(con) {
-					if ((con->flags & CON_BOOT) &&
-					    (con->flags & CON_ENABLED) &&
-					    con->seq < newcon->seq) {
-						newcon->seq = con->seq;
+					u64 seq;
+
+					if (!((con->flags & CON_BOOT) &&
+					      (con->flags & CON_ENABLED))) {
+						continue;
 					}
+
+					if (con->flags & CON_NBCON)
+						seq = nbcon_seq_read(con);
+					else
+						seq = con->seq;
+
+					if (seq < newcon->seq)
+						newcon->seq = seq;
 				}
 			}
 
-- 
2.39.2


