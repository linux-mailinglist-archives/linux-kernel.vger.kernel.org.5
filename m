Return-Path: <linux-kernel+bounces-79955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AC28628F0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 04:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41761F21532
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776FA8C07;
	Sun, 25 Feb 2024 03:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="nvh++8F9"
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAE78BF6
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 03:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708830778; cv=none; b=fWsy2PcI8+NMm9ov3fZ7/QsFMUm2+jfbr6xUoQKSctFypmtqFjfK9+n/OWsi9oURJHWk2ysg9T3GtxiK4tT0JR4IRhQmOkUCBTd7eBfiUJylIejJCY8rVT+hk0Evmi5PRwia3xPaeEqWWpG6vJJOVGi1sXQCZNlSm+14wUduVlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708830778; c=relaxed/simple;
	bh=U4i+i9PdBw8hS+mhrV5wIJhHZ+uVQK46IFdaQMNvLmA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=tQdviae4w6ugQ5et1tPTp5em+IA1JgBVf9TMNmDlkC9j1sqV4TfFOPqqpIR8ArIHRXdy7ikq0nCRZoFdZ4fYLEFiI6JhPr7BbArtnS0Spypqm0KDN9h1+iafJDoy2a0WXzgunznm3VJL1o9GvGG3RpYJFjoCx+GA09bfWVkfhvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=nvh++8F9; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708830774; bh=A/IxJBZi27mtkrsoxOZws5nHnODjFxtLyQdPu2a35uU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nvh++8F9zKycX2w3RdPceEsb0wHDDofJIs3hAodH8Elub/SuncE5O1OFA1/zmuXtL
	 qi5TPcno55Up0+KxhFzDhrg7xgiiOgGPZSKueIJr2LfWnLD35AuxSmRykd564FIBAm
	 7Zm39RatLbVNRma8OwO0fwSJzOut4m7hbLFiHYv8=
Received: from localhost.localdomain ([153.3.164.50])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 33487E60; Sun, 25 Feb 2024 11:12:52 +0800
X-QQ-mid: xmsmtpt1708830772td52svu9a
Message-ID: <tencent_8B422629CF388976D1303D2C5B0720089305@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur91Jl8O5fz+Bb1i2ZaLpyIhNB7YV8SfRiLgwNQd1ahEc/2me8sSw
	 2Ltka2+r+ZOX6aMyZ9BXnUERzXeW/YeO/OtEs59JoTDgIpSchtqWKX6px3YDCLo3cQuw/zNdtsvT
	 3HRPEoBCgxGd2j46tEnUEn9NxGsAeao2qAUSAzBxxBiq4Gdt6ReDDLOxAhZWKnAxZ0eFr7I+Fy+y
	 ibOc0oL6CB8OGoD8csgVq2NiWIBXKlW2iZIpIUwuBOH48G1k0OjQx4lVNQ+7YjsTs3/uTuBcUdNw
	 I1CbM+l2Ir+WJ21+PppLWW+tBkUeU5Nrkd2oTKeSNBIxZw6b46nb3DsuYNKzeRUDzXmufomrOt0B
	 LtNXbYLfSeyWPmXaWtN90Oe8DQelPjWifknj9LaL6QTG/9tjGbCF4FUBqZrg/EYG6c4rmwAhcDNA
	 IGitLOXHWOObh7XyFA7uTvdCPY6sRnziFs6Ck0OD9ZVcXmQCNS0D+DYPWQFIGjw084L86yAeYrLv
	 1hKVM3UotzqDPYVZlZ/ZlFshFTx1+QWmwm4fMt5RGlWupYinKjaO6pZz8coykeSAjx9GTDCsfcdZ
	 VI57tcf9K1ccfUBe/uJu0OYxRNZ86mhyulDghdEfvrltBJ0JgiU1BHEenViEv7Ln63ZE/2UyH5UK
	 O3ZGVP1WVPwZuutrGsHeSixVqDR6eHG44hH5MS0EIHkjvn8/7ttLUirq0VoGq79yhLAE5jTmZUD5
	 aL4L/MelBa4gyCT/37Xi0yz9q181SWonCHDsdmHnocIR2dfdUYkOBipUqYnnbmYgUMyPVTlh/Z9V
	 +PYo/18oOFZiSyR6nUoKhcb0j0ZwUJh5EFoxQDW6i40vQQv/Fxv7BcmMY102P+Q3vCMMpGBBxk7n
	 1DQUbd3HqSX368nn20jl0fijlX7fjehYQzoix/W8W+HZL4utjDkiAlAiBpv5syPO/0VMYgoo6Kl2
	 wBQvshHckPUs2m27W6hyQ+y+SsaOITW/i1fAhwtQHIE0VVqH3gn3+8sZmNSOmLIDw1bN6Un7+4XN
	 3GEO+xGnS9qqHzF17s
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: linke li <lilinke99@qq.com>
To: 
Cc: lilinke99@qq.com,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tick: use READ_ONCE() to read jiffies in concurrent environment
Date: Sun, 25 Feb 2024 11:12:50 +0800
X-OQ-MSGID: <20240225031250.99386-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <lilinke99@qq.com>
References: <lilinke99@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In function tick_sched_do_timer(), jiffies is read using READ_ONCE()
in line 224, while read directly in line 217

217	if (ts->last_tick_jiffies != jiffies) {
218		ts->stalled_jiffies = 0;
219		ts->last_tick_jiffies = READ_ONCE(jiffies);
220	} else {
221		if (++ts->stalled_jiffies == MAX_STALLED_JIFFIES) {
222			tick_do_update_jiffies64(now);
223			ts->stalled_jiffies = 0;
224			ts->last_tick_jiffies = READ_ONCE(jiffies);
225		}
226	}

There is patch similar to this. commit c1c0ce31b242 ("r8169: fix the KCSAN reported data-race in rtl_tx() while reading tp->cur_tx")
This patch find two read of same variable while one is protected, another
is not. And READ_ONCE() is added to protect.

Signed-off-by: linke li <lilinke99@qq.com>
---
 kernel/time/tick-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 01fb50c1b17e..aa684511c25a 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -214,7 +214,7 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	 * If the jiffies update stalled for too long (timekeeper in stop_machine()
 	 * or VMEXIT'ed for several msecs), force an update.
 	 */
-	if (ts->last_tick_jiffies != jiffies) {
+	if (ts->last_tick_jiffies != READ_ONCE(jiffies)) {
 		ts->stalled_jiffies = 0;
 		ts->last_tick_jiffies = READ_ONCE(jiffies);
 	} else {
-- 
2.39.3 (Apple Git-145)


