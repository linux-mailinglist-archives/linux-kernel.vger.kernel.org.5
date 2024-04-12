Return-Path: <linux-kernel+bounces-141874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9FB8A2476
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEA91B217F5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A23718B1B;
	Fri, 12 Apr 2024 03:38:57 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD59518628
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712893136; cv=none; b=EbxTrbNrOj5pHtMgTOtDwELqRShRHjh0HNL6ryQU8jLIKgNTvBqUkncsNmmf1WFAzoDCyFXb+UOaHXHkEVSfZzbnXEzc9g7OC0o6naZnAkGnotb7UQLQafs7EXX41qIMxEw1hcP1fGuMRhl2HlZBnXwLuSPUEb4VmQ4WpFjsGbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712893136; c=relaxed/simple;
	bh=iPBmFjzF1YUOP+UGBVTdCbLoWAO/XY2uz3tmDYZGnhk=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=XqvXjuLBNAbP/2w7OPHCI08OGceLR+WcdZfja383cGa0NzCZx0qtTvFyY1nSXwYjEb4DrExPWrbXOhLN8aG0y6+AXqxmkh7iDbPmJVlJHdT3cbNC5rDdVIy45HNRNFLT8EA4So915Mrc++wG00ZsplCNHEXWbpmyAno5ScFT/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4VG2NX60qbz4xPYf;
	Fri, 12 Apr 2024 11:38:52 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
	by mse-fl2.zte.com.cn with SMTP id 43C3ckt4008420;
	Fri, 12 Apr 2024 11:38:46 +0800 (+08)
	(envelope-from li.hao40@zte.com.cn)
Received: from mapi (xaxapp03[null])
	by mapi (Zmail) with MAPI id mid31;
	Fri, 12 Apr 2024 11:38:48 +0800 (CST)
Date: Fri, 12 Apr 2024 11:38:48 +0800 (CST)
X-Zmail-TransId: 2afb6618acc8ffffffffc1b-2da86
X-Mailer: Zmail v1.0
Message-ID: <20240412113848167egmP7kBg1Qm5sxfwGALG-@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <li.hao40@zte.com.cn>
To: <jirislaby@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSB0dHk6IGh2Yzogd2FrZXVwIGh2YyBjb25zb2xlIGltbWVkaWF0ZWx5IHdoZW4gbmVlZGVk?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 43C3ckt4008420
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6618ACCC.001/4VG2NX60qbz4xPYf

From: Li Hao <li.hao40@zte.com.cn>

Cancel the do_wakeup flag in hvc_struct, and change it to immediately
wake up tty when hp->n_outbuf is 0 in hvc_push().

When we receive a key input character, the interrupt handling function
hvc_handle_interrupt() will be executed, and the echo thread
flush_to_ldisc() will be added to the queue.

If the user is currently using tcsetattr(), a hang may occur. tcsetattr()
enters kernel and waits for hp->n_outbuf to become 0 via
tty_wait_until_sent(). If the echo thread finishes executing before
reaching tty_wait_until_sent (for example, put_chars() takes too long),
it will cause while meeting the wakeup condition (hp->do_wakeup = 1),
tty_wait_until_sent() cannot be woken up (missed the tty_wakeup() of
this round's tty_poll). Unless the next key input character comes,
hvc_poll will be executed, and tty_wakeup() will be performed through
the do_wakeup flag.

Signed-off-by: Li Hao <li.hao40@zte.com.cn>
---
 drivers/tty/hvc/hvc_console.c | 12 +++++-------
 drivers/tty/hvc/hvc_console.h |  1 -
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index cd1f657f7..2fa90d938 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -476,11 +476,13 @@ static void hvc_hangup(struct tty_struct *tty)
 static int hvc_push(struct hvc_struct *hp)
 {
 	int n;
+	struct tty_struct *tty;

 	n = hp->ops->put_chars(hp->vtermno, hp->outbuf, hp->n_outbuf);
+	tty = tty_port_tty_get(&hp->port);
 	if (n <= 0) {
 		if (n == 0 || n == -EAGAIN) {
-			hp->do_wakeup = 1;
+			tty_wakeup(tty);
 			return 0;
 		}
 		/* throw away output on error; this happens when
@@ -491,7 +493,7 @@ static int hvc_push(struct hvc_struct *hp)
 	if (hp->n_outbuf > 0)
 		memmove(hp->outbuf, hp->outbuf + n, hp->n_outbuf);
 	else
-		hp->do_wakeup = 1;
+		tty_wakeup(tty);

 	return n;
 }
@@ -739,11 +741,7 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 	poll_mask |= HVC_POLL_READ;

  out:
-	/* Wakeup write queue if necessary */
-	if (hp->do_wakeup) {
-		hp->do_wakeup = 0;
-		tty_wakeup(tty);
-	}
+	/* Wakeup in hvc_push */
  bail:
 	spin_unlock_irqrestore(&hp->lock, flags);

diff --git a/drivers/tty/hvc/hvc_console.h b/drivers/tty/hvc/hvc_console.h
index cf4c1af08..6622f71ba 100644
--- a/drivers/tty/hvc/hvc_console.h
+++ b/drivers/tty/hvc/hvc_console.h
@@ -36,7 +36,6 @@ struct hvc_struct {
 	struct tty_port port;
 	spinlock_t lock;
 	int index;
-	int do_wakeup;
 	int outbuf_size;
 	int n_outbuf;
 	uint32_t vtermno;
-- 
2.25.1

