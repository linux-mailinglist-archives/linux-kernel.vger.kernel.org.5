Return-Path: <linux-kernel+bounces-128760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6133B895F68
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9948B248E8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E593C15ECE4;
	Tue,  2 Apr 2024 22:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zfeJcwKX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RidmNc0j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D3615ECC8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095897; cv=none; b=VmwULyNOglSwapPbrQjtLeW+bzArM3+Si8cM3lv7UcsnAPSsViK/oC8aHVDfjsGWYSNiMFeJ1ibCdliciTo5jUGe0e4rCrpc3kp7+uWnma4QayGvASnhEnrlV8yzcQ2KVuGNPvANCGnqqxr+UW+T/ozx8NAPltYZihc3VmLa9eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095897; c=relaxed/simple;
	bh=+x0B0DKqCUuY5JhcpCChNmzn4DAXIu7FX0iwPh4yj00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=siHsjFuApnHeb37tMdebiVV+Z8qlPhUSvFtD99KOLi6YiK6Syrmxqsc97o4+vWeMB7R8UN+y+1dMxkNWlnd5+1ihlRgxCrfjA2ma5oqHDDUMvEEXPZNSX8STD7pFmWJDG/CCrgIQdzeIFgGk+QqI9aSi8Z44O2VsTrVrnOKff6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zfeJcwKX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RidmNc0j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CzegSW+30fFMD0MZbnfdPKJm1E+ZrdzFvhWkWJc/40c=;
	b=zfeJcwKXXHueMeEDEdn+JAzbBB+a+cmmZB6wnzsurIJSMy/SqfjAjh2V5MUm/NrWa2zXTk
	Z7dhpE53PB76B58ipZT3lxvj5xIn1tA9fuEvDyphswzxJ7g4r0BbQJge+dsfTjvqF6p06n
	N8E47VK8slzHXvtUq52cCiJJ0DmqAVBgsxhyWJsbpDI3WdOlWSh/wPHdRCkT7cvE7PCceT
	whKxtcbBiQ+ZkeH/uzOsruzxRZ6GTcGEd5w94FO51fxCLvO0Jd6DwxGCHptlXBbIY8lWm1
	JkjFPDf+9j9Ut9gTdhlQ5jRCe0brAW/Vr86yZlu0QfyAZ/Wai5HZnVROvPSaxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CzegSW+30fFMD0MZbnfdPKJm1E+ZrdzFvhWkWJc/40c=;
	b=RidmNc0jX4fyRo2z6VZIWtpwsDGh6TsQrdJrlUZsVI6g88Dp5ol2HgzFwVqh3pld12EfdD
	DXNwIFK9Bn4OhNBw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH printk v4 01/27] printk: Add notation to console_srcu locking
Date: Wed,  3 Apr 2024 00:17:03 +0206
Message-Id: <20240402221129.2613843-2-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel/printk/printk.c:284:5: sparse: sparse: context imbalance in
'console_srcu_read_lock' - wrong count at exit
include/linux/srcu.h:301:9: sparse: sparse: context imbalance in
'console_srcu_read_unlock' - unexpected unlock

Fixes: 6c4afa79147e ("printk: Prepare for SRCU console list protection")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 612c73333848..c7c0ee2b47eb 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -282,6 +282,7 @@ EXPORT_SYMBOL(console_list_unlock);
  * Return: A cookie to pass to console_srcu_read_unlock().
  */
 int console_srcu_read_lock(void)
+	__acquires(&console_srcu)
 {
 	return srcu_read_lock_nmisafe(&console_srcu);
 }
@@ -295,6 +296,7 @@ EXPORT_SYMBOL(console_srcu_read_lock);
  * Counterpart to console_srcu_read_lock()
  */
 void console_srcu_read_unlock(int cookie)
+	__releases(&console_srcu)
 {
 	srcu_read_unlock_nmisafe(&console_srcu, cookie);
 }
-- 
2.39.2


